

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
    spvUnsafeArray<float4, 4> Material_VectorExpressions;
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

constant float4 _109 = {};

struct InjectMainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
    float4 out_var_SV_Target1 [[color(1)]];
};

struct InjectMainPS_in
{
    float2 in_var_TEXCOORD0 [[user(locn0), center_no_perspective]];
};

fragment InjectMainPS_out Main_00002fcd_ede1f0de(InjectMainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_DeferredLightUniforms& DeferredLightUniforms [[buffer(1)]], constant type_Material& Material [[buffer(2)]], constant type_Globals& _Globals [[buffer(3)]], texture2d<float> ShadowDepthTexture [[texture(0)]], depthcube<float> ShadowDepthCubeTexture [[texture(1)]], texture2d<float> StaticShadowDepthTexture [[texture(2)]], sampler ShadowDepthTextureSampler [[sampler(0)]], sampler ShadowDepthCubeTextureSampler [[sampler(1)]], sampler StaticShadowDepthTextureSampler [[sampler(2)]], uint gl_Layer [[render_target_array_index]])
{
    InjectMainPS_out out = {};
    float _121 = float(gl_Layer) + 0.5;
    float _133 = 0.5 * View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].w;
    float3 _138 = float3((View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].xy + (in.in_var_TEXCOORD0 / View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].xy)) - float2(_133), View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].z + (_121 * View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].w));
    float3 _147 = float3(DeferredLightUniforms.DeferredLightUniforms_Position) - _138;
    if (((1.0 / (DeferredLightUniforms.DeferredLightUniforms_InvRadius * DeferredLightUniforms.DeferredLightUniforms_InvRadius)) - dot(_147, _147)) < 0.0)
    {
        discard_fragment();
    }
    float3 _157 = normalize(_147);
    float3 _163 = _138 + float3(dot(abs(_157 * float3(_133)), float3(1.0)));
    float3 _164 = float3(DeferredLightUniforms.DeferredLightUniforms_Position) - _163;
    float _165 = dot(_164, _164);
    float _169 = (_165 * DeferredLightUniforms.DeferredLightUniforms_InvRadius) * DeferredLightUniforms.DeferredLightUniforms_InvRadius;
    float _172 = fast::clamp(1.0 - (_169 * _169), 0.0, 1.0);
    float _185 = fast::clamp((dot(normalize(_164), DeferredLightUniforms.DeferredLightUniforms_Direction) - DeferredLightUniforms.DeferredLightUniforms_SpotAngles.x) * DeferredLightUniforms.DeferredLightUniforms_SpotAngles.y, 0.0, 1.0);
    float _187 = (_185 * _185) * ((1.0 / (_165 + 1.0)) * (_172 * _172));
    bool _190 = _Globals.SpotlightMask < 1.0;
    float _295;
    if (_Globals.bStaticallyShadowed != 0u)
    {
        float _294;
        if (_190)
        {
            float3 _271 = _163 - float3(DeferredLightUniforms.DeferredLightUniforms_Position);
            float _272 = length(_271);
            float3 _274 = _271 / float3(_272);
            float _278 = atan2(_274.y, _274.x) * 0.15915493667125701904296875;
            _294 = float((_272 * DeferredLightUniforms.DeferredLightUniforms_InvRadius) < StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, float2((_278 > 0.0) ? _278 : (1.0 + _278), acos(_274.z) * 0.3183098733425140380859375), level(0.0)).x);
        }
        else
        {
            float4 _206 = _Globals.WorldToStaticShadowMatrix * float4(_163, 1.0);
            float2 _210 = _206.xy / float2(_206.w);
            bool2 _211 = _210 >= float2(0.0);
            bool2 _212 = _210 <= float2(1.0);
            float _270;
            if (all(bool2(_211.x && _212.x, _211.y && _212.y)))
            {
                float2 _224 = (_210 * _Globals.StaticShadowBufferSize.xy) - float2(0.5);
                float2 _225 = fract(_224);
                float2 _226 = floor(_224);
                float4 _234 = _109;
                _234.x = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_226 + float2(0.5, 1.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _240 = _234;
                _240.y = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_226 + float2(1.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _246 = _240;
                _246.z = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_226 + float2(1.5, 0.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _251 = _246;
                _251.w = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_226 + float2(0.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _261 = fast::clamp(fast::clamp((_251 * 40.0) - float4((_206.z * 40.0) - 1.0), float4(0.0), float4(1.0)) + select(float4(0.0), float4(1.0), _251 > float4(0.9900000095367431640625)), float4(0.0), float4(1.0));
                float2 _265 = mix(_261.wx, _261.zy, _225.xx);
                _270 = mix(_265.x, _265.y, _225.y);
            }
            else
            {
                _270 = 1.0;
            }
            _294 = _270;
        }
        _295 = _294;
    }
    else
    {
        _295 = 1.0;
    }
    float _383;
    if (_190)
    {
        float _382;
        if ((length(_164) * DeferredLightUniforms.DeferredLightUniforms_InvRadius) < 1.0)
        {
            float3 _341 = abs(_164);
            float _342 = _341.x;
            float _343 = _341.y;
            float _344 = _341.z;
            float _346 = fast::max(_342, fast::max(_343, _344));
            int _365;
            if (_346 == _342)
            {
                _365 = (_342 == _164.x) ? 0 : 1;
            }
            else
            {
                int _361;
                if (_346 == _343)
                {
                    _361 = (_343 == _164.y) ? 2 : 3;
                }
                else
                {
                    _361 = (_344 == _164.z) ? 4 : 5;
                }
                _365 = _361;
            }
            float4 _373 = _Globals.ShadowViewProjectionMatrices[_365] * float4(-_164, 1.0);
            float _375 = _373.w;
            _382 = ShadowDepthCubeTexture.sample_compare(ShadowDepthCubeTextureSampler, _164, (_373.z / _375) + ((_Globals.InvShadowmapResolution * (-15.35999965667724609375)) / _375), level(0.0));
        }
        else
        {
            _382 = 1.0;
        }
        _383 = _382;
    }
    else
    {
        float4 _305 = _Globals.WorldToShadowMatrix * float4(_163, 1.0);
        float2 _309 = _305.xy / float2(_305.w);
        bool2 _313 = _309 >= _Globals.ShadowmapMinMax.xy;
        bool2 _315 = _309 <= _Globals.ShadowmapMinMax.zw;
        float _331;
        if (all(bool2(_313.x && _315.x, _313.y && _315.y)))
        {
            _331 = float(_305.z < (ShadowDepthTexture.sample(ShadowDepthTextureSampler, _309, level(0.0)).x - _Globals.DepthBiasParameters.x));
        }
        else
        {
            _331 = 1.0;
        }
        _383 = _331;
    }
    float _404;
    if ((!_190) && (!(_Globals.SpotlightMask >= 1.0)))
    {
        float _401 = fast::clamp((dot(_163 - View.View_WorldCameraOrigin, View.View_ViewForward) * _Globals.ShadowInjectParams.z) + _Globals.ShadowInjectParams.w, 0.0, 1.0);
        _404 = mix(_383, 1.0, _401 * _401);
    }
    else
    {
        _404 = _383;
    }
    float _418 = fast::min(_295, _404) * dot(fast::max(mix(Material.Material_VectorExpressions[2].xyz, Material.Material_VectorExpressions[3].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0)), float3(0.33329999446868896484375));
    float _440;
    float _441;
    if (_Globals.VolumeCascadeIndex == 1u)
    {
        float3 _432 = fast::clamp((float3(0.5) - abs(((float3(in.in_var_TEXCOORD0, _121 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w) * (1.0 + (4.0 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w))) - float3(2.0 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w)) - float3(0.5))) * 10.0, float3(0.0), float3(1.0));
        float _437 = (_432.x * _432.y) * _432.z;
        _440 = mix(0.0, _418, _437);
        _441 = mix(0.0, _187, _437);
    }
    else
    {
        _440 = _418;
        _441 = _187;
    }
    float3 _446 = ((DeferredLightUniforms.DeferredLightUniforms_Color * float3(0.3183098733425140380859375)) * _441) * _440;
    float4 _447 = _109;
    _447.x = 0.2820949852466583251953125;
    float4 _450 = _447;
    _450.y = (-0.48860299587249755859375) * _157.y;
    float4 _453 = _450;
    _453.z = 0.48860299587249755859375 * _157.z;
    float4 _456 = _453;
    _456.w = (-0.48860299587249755859375) * _157.x;
    float4 _458 = _456 * _446.x;
    float4 _460 = _456 * _446.y;
    float4 _462 = _456 * _446.z;
    out.out_var_SV_Target0 = float4(_458.x, _460.x, _462.x, 0.0) * 1.0;
    out.out_var_SV_Target1 = float4(dot(float3(_458.y, _460.y, _462.y), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), dot(float3(_458.z, _460.z, _462.z), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), dot(float3(_458.w, _460.w, _462.w), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), 0.0) * 1.0;
    return out;
}

