

#pragma clang diagnostic ignored "-Wmissing-prototypes"
#pragma clang diagnostic ignored "-Wmissing-braces"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

template<typename T, size_t Num>
struct spvUnsafeArray
{
    T elements[Num ? Num : 1];
    
    thread T& operator [] (size_t pos) thread
    {
        return elements[pos];
    }
    constexpr const thread T& operator [] (size_t pos) const thread
    {
        return elements[pos];
    }
    
    device T& operator [] (size_t pos) device
    {
        return elements[pos];
    }
    constexpr const device T& operator [] (size_t pos) const device
    {
        return elements[pos];
    }
    
    constexpr const constant T& operator [] (size_t pos) const constant
    {
        return elements[pos];
    }
    
    threadgroup T& operator [] (size_t pos) threadgroup
    {
        return elements[pos];
    }
    constexpr const threadgroup T& operator [] (size_t pos) const threadgroup
    {
        return elements[pos];
    }
};

struct type_View
{
    char _m0_pad[960];
    float3 View_ViewForward;
    char _m1_pad[96];
    float3 View_WorldCameraOrigin;
    char _m2_pad[1280];
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeMin;
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeInvSize;
};

struct type_DeferredLightUniforms
{
    char _m0_pad[48];
    packed_float3 DeferredLightUniforms_Position;
    float DeferredLightUniforms_InvRadius;
    float3 DeferredLightUniforms_Color;
    float3 DeferredLightUniforms_Direction;
    char _m4_pad[16];
    float2 DeferredLightUniforms_SpotAngles;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

struct type_Globals
{
    spvUnsafeArray<float4x4, 6> ShadowViewProjectionMatrices;
    float InvShadowmapResolution;
    float4x4 WorldToShadowMatrix;
    float4 ShadowmapMinMax;
    float4 ShadowInjectParams;
    float4 DepthBiasParameters;
    uint bStaticallyShadowed;
    float4x4 WorldToStaticShadowMatrix;
    float4 StaticShadowBufferSize;
    uint VolumeCascadeIndex;
    char _m10_pad[92];
    float SpotlightMask;
};

constant float4 _108 = {};

struct InjectMainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
    float4 out_var_SV_Target1 [[color(1)]];
};

struct InjectMainPS_in
{
    float2 in_var_TEXCOORD0 [[user(locn0), center_no_perspective]];
};

fragment InjectMainPS_out Main_00002fae_3fdbc1ff(InjectMainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_DeferredLightUniforms& DeferredLightUniforms [[buffer(1)]], constant type_Material& Material [[buffer(2)]], constant type_Globals& _Globals [[buffer(3)]], texture2d<float> ShadowDepthTexture [[texture(0)]], depthcube<float> ShadowDepthCubeTexture [[texture(1)]], texture2d<float> StaticShadowDepthTexture [[texture(2)]], sampler ShadowDepthTextureSampler [[sampler(0)]], sampler ShadowDepthCubeTextureSampler [[sampler(1)]], sampler StaticShadowDepthTextureSampler [[sampler(2)]], uint gl_Layer [[render_target_array_index]])
{
    InjectMainPS_out out = {};
    float _120 = float(gl_Layer) + 0.5;
    float _132 = 0.5 * View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].w;
    float3 _137 = float3((View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].xy + (in.in_var_TEXCOORD0 / View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].xy)) - float2(_132), View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].z + (_120 * View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].w));
    float3 _146 = float3(DeferredLightUniforms.DeferredLightUniforms_Position) - _137;
    if (((1.0 / (DeferredLightUniforms.DeferredLightUniforms_InvRadius * DeferredLightUniforms.DeferredLightUniforms_InvRadius)) - dot(_146, _146)) < 0.0)
    {
        discard_fragment();
    }
    float3 _156 = normalize(_146);
    float3 _162 = _137 + float3(dot(abs(_156 * float3(_132)), float3(1.0)));
    float3 _163 = float3(DeferredLightUniforms.DeferredLightUniforms_Position) - _162;
    float _164 = dot(_163, _163);
    float _168 = (_164 * DeferredLightUniforms.DeferredLightUniforms_InvRadius) * DeferredLightUniforms.DeferredLightUniforms_InvRadius;
    float _171 = fast::clamp(1.0 - (_168 * _168), 0.0, 1.0);
    float _184 = fast::clamp((dot(normalize(_163), DeferredLightUniforms.DeferredLightUniforms_Direction) - DeferredLightUniforms.DeferredLightUniforms_SpotAngles.x) * DeferredLightUniforms.DeferredLightUniforms_SpotAngles.y, 0.0, 1.0);
    float _186 = (_184 * _184) * ((1.0 / (_164 + 1.0)) * (_171 * _171));
    bool _189 = _Globals.SpotlightMask < 1.0;
    float _294;
    if (_Globals.bStaticallyShadowed != 0u)
    {
        float _293;
        if (_189)
        {
            float3 _270 = _162 - float3(DeferredLightUniforms.DeferredLightUniforms_Position);
            float _271 = length(_270);
            float3 _273 = _270 / float3(_271);
            float _277 = atan2(_273.y, _273.x) * 0.15915493667125701904296875;
            _293 = float((_271 * DeferredLightUniforms.DeferredLightUniforms_InvRadius) < StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, float2((_277 > 0.0) ? _277 : (1.0 + _277), acos(_273.z) * 0.3183098733425140380859375), level(0.0)).x);
        }
        else
        {
            float4 _205 = _Globals.WorldToStaticShadowMatrix * float4(_162, 1.0);
            float2 _209 = _205.xy / float2(_205.w);
            bool2 _210 = _209 >= float2(0.0);
            bool2 _211 = _209 <= float2(1.0);
            float _269;
            if (all(bool2(_210.x && _211.x, _210.y && _211.y)))
            {
                float2 _223 = (_209 * _Globals.StaticShadowBufferSize.xy) - float2(0.5);
                float2 _224 = fract(_223);
                float2 _225 = floor(_223);
                float4 _233 = _108;
                _233.x = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_225 + float2(0.5, 1.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _239 = _233;
                _239.y = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_225 + float2(1.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _245 = _239;
                _245.z = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_225 + float2(1.5, 0.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _250 = _245;
                _250.w = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_225 + float2(0.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _260 = fast::clamp(fast::clamp((_250 * 40.0) - float4((_205.z * 40.0) - 1.0), float4(0.0), float4(1.0)) + select(float4(0.0), float4(1.0), _250 > float4(0.9900000095367431640625)), float4(0.0), float4(1.0));
                float2 _264 = mix(_260.wx, _260.zy, _224.xx);
                _269 = mix(_264.x, _264.y, _224.y);
            }
            else
            {
                _269 = 1.0;
            }
            _293 = _269;
        }
        _294 = _293;
    }
    else
    {
        _294 = 1.0;
    }
    float _382;
    if (_189)
    {
        float _381;
        if ((length(_163) * DeferredLightUniforms.DeferredLightUniforms_InvRadius) < 1.0)
        {
            float3 _340 = abs(_163);
            float _341 = _340.x;
            float _342 = _340.y;
            float _343 = _340.z;
            float _345 = fast::max(_341, fast::max(_342, _343));
            int _364;
            if (_345 == _341)
            {
                _364 = (_341 == _163.x) ? 0 : 1;
            }
            else
            {
                int _360;
                if (_345 == _342)
                {
                    _360 = (_342 == _163.y) ? 2 : 3;
                }
                else
                {
                    _360 = (_343 == _163.z) ? 4 : 5;
                }
                _364 = _360;
            }
            float4 _372 = _Globals.ShadowViewProjectionMatrices[_364] * float4(-_163, 1.0);
            float _374 = _372.w;
            _381 = ShadowDepthCubeTexture.sample_compare(ShadowDepthCubeTextureSampler, _163, (_372.z / _374) + ((_Globals.InvShadowmapResolution * (-15.35999965667724609375)) / _374), level(0.0));
        }
        else
        {
            _381 = 1.0;
        }
        _382 = _381;
    }
    else
    {
        float4 _304 = _Globals.WorldToShadowMatrix * float4(_162, 1.0);
        float2 _308 = _304.xy / float2(_304.w);
        bool2 _312 = _308 >= _Globals.ShadowmapMinMax.xy;
        bool2 _314 = _308 <= _Globals.ShadowmapMinMax.zw;
        float _330;
        if (all(bool2(_312.x && _314.x, _312.y && _314.y)))
        {
            _330 = float(_304.z < (ShadowDepthTexture.sample(ShadowDepthTextureSampler, _308, level(0.0)).x - _Globals.DepthBiasParameters.x));
        }
        else
        {
            _330 = 1.0;
        }
        _382 = _330;
    }
    float _403;
    if ((!_189) && (!(_Globals.SpotlightMask >= 1.0)))
    {
        float _400 = fast::clamp((dot(_162 - View.View_WorldCameraOrigin, View.View_ViewForward) * _Globals.ShadowInjectParams.z) + _Globals.ShadowInjectParams.w, 0.0, 1.0);
        _403 = mix(_382, 1.0, _400 * _400);
    }
    else
    {
        _403 = _382;
    }
    float _414 = fast::min(_294, _403) * dot(fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0)), float3(0.33329999446868896484375));
    float _436;
    float _437;
    if (_Globals.VolumeCascadeIndex == 1u)
    {
        float3 _428 = fast::clamp((float3(0.5) - abs(((float3(in.in_var_TEXCOORD0, _120 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w) * (1.0 + (4.0 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w))) - float3(2.0 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w)) - float3(0.5))) * 10.0, float3(0.0), float3(1.0));
        float _433 = (_428.x * _428.y) * _428.z;
        _436 = mix(0.0, _414, _433);
        _437 = mix(0.0, _186, _433);
    }
    else
    {
        _436 = _414;
        _437 = _186;
    }
    float3 _442 = ((DeferredLightUniforms.DeferredLightUniforms_Color * float3(0.3183098733425140380859375)) * _437) * _436;
    float4 _443 = _108;
    _443.x = 0.2820949852466583251953125;
    float4 _446 = _443;
    _446.y = (-0.48860299587249755859375) * _156.y;
    float4 _449 = _446;
    _449.z = 0.48860299587249755859375 * _156.z;
    float4 _452 = _449;
    _452.w = (-0.48860299587249755859375) * _156.x;
    float4 _454 = _452 * _442.x;
    float4 _456 = _452 * _442.y;
    float4 _458 = _452 * _442.z;
    out.out_var_SV_Target0 = float4(_454.x, _456.x, _458.x, 0.0) * 1.0;
    out.out_var_SV_Target1 = float4(dot(float3(_454.y, _456.y, _458.y), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), dot(float3(_454.z, _456.z, _458.z), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), dot(float3(_454.w, _456.w, _458.w), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), 0.0) * 1.0;
    return out;
}

