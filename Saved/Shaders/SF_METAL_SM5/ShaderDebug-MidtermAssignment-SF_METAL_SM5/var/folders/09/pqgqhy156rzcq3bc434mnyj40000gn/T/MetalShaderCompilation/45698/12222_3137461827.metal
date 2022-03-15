

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
    packed_float3 DeferredLightUniforms_Color;
    float DeferredLightUniforms_FalloffExponent;
    float3 DeferredLightUniforms_Direction;
    char _m5_pad[16];
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

fragment InjectMainPS_out Main_00002fbe_bb01de43(InjectMainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_DeferredLightUniforms& DeferredLightUniforms [[buffer(1)]], constant type_Material& Material [[buffer(2)]], constant type_Globals& _Globals [[buffer(3)]], texture2d<float> ShadowDepthTexture [[texture(0)]], depthcube<float> ShadowDepthCubeTexture [[texture(1)]], texture2d<float> StaticShadowDepthTexture [[texture(2)]], sampler ShadowDepthTextureSampler [[sampler(0)]], sampler ShadowDepthCubeTextureSampler [[sampler(1)]], sampler StaticShadowDepthTextureSampler [[sampler(2)]], uint gl_Layer [[render_target_array_index]])
{
    InjectMainPS_out out = {};
    float _122 = float(gl_Layer) + 0.5;
    float _134 = 0.5 * View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].w;
    float3 _139 = float3((View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].xy + (in.in_var_TEXCOORD0 / View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].xy)) - float2(_134), View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].z + (_122 * View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].w));
    float3 _148 = float3(DeferredLightUniforms.DeferredLightUniforms_Position) - _139;
    if (((1.0 / (DeferredLightUniforms.DeferredLightUniforms_InvRadius * DeferredLightUniforms.DeferredLightUniforms_InvRadius)) - dot(_148, _148)) < 0.0)
    {
        discard_fragment();
    }
    float3 _158 = normalize(_148);
    float3 _164 = _139 + float3(dot(abs(_158 * float3(_134)), float3(1.0)));
    float3 _165 = float3(DeferredLightUniforms.DeferredLightUniforms_Position) - _164;
    float3 _166 = _165 * DeferredLightUniforms.DeferredLightUniforms_InvRadius;
    float _183 = fast::clamp((dot(normalize(_165), DeferredLightUniforms.DeferredLightUniforms_Direction) - DeferredLightUniforms.DeferredLightUniforms_SpotAngles.x) * DeferredLightUniforms.DeferredLightUniforms_SpotAngles.y, 0.0, 1.0);
    float _185 = (_183 * _183) * pow(1.0 - fast::clamp(dot(_166, _166), 0.0, 1.0), DeferredLightUniforms.DeferredLightUniforms_FalloffExponent);
    bool _188 = _Globals.SpotlightMask < 1.0;
    float _293;
    if (_Globals.bStaticallyShadowed != 0u)
    {
        float _292;
        if (_188)
        {
            float3 _269 = _164 - float3(DeferredLightUniforms.DeferredLightUniforms_Position);
            float _270 = length(_269);
            float3 _272 = _269 / float3(_270);
            float _276 = atan2(_272.y, _272.x) * 0.15915493667125701904296875;
            _292 = float((_270 * DeferredLightUniforms.DeferredLightUniforms_InvRadius) < StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, float2((_276 > 0.0) ? _276 : (1.0 + _276), acos(_272.z) * 0.3183098733425140380859375), level(0.0)).x);
        }
        else
        {
            float4 _204 = _Globals.WorldToStaticShadowMatrix * float4(_164, 1.0);
            float2 _208 = _204.xy / float2(_204.w);
            bool2 _209 = _208 >= float2(0.0);
            bool2 _210 = _208 <= float2(1.0);
            float _268;
            if (all(bool2(_209.x && _210.x, _209.y && _210.y)))
            {
                float2 _222 = (_208 * _Globals.StaticShadowBufferSize.xy) - float2(0.5);
                float2 _223 = fract(_222);
                float2 _224 = floor(_222);
                float4 _232 = _109;
                _232.x = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_224 + float2(0.5, 1.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _238 = _232;
                _238.y = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_224 + float2(1.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _244 = _238;
                _244.z = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_224 + float2(1.5, 0.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _249 = _244;
                _249.w = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_224 + float2(0.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _259 = fast::clamp(fast::clamp((_249 * 40.0) - float4((_204.z * 40.0) - 1.0), float4(0.0), float4(1.0)) + select(float4(0.0), float4(1.0), _249 > float4(0.9900000095367431640625)), float4(0.0), float4(1.0));
                float2 _263 = mix(_259.wx, _259.zy, _223.xx);
                _268 = mix(_263.x, _263.y, _223.y);
            }
            else
            {
                _268 = 1.0;
            }
            _292 = _268;
        }
        _293 = _292;
    }
    else
    {
        _293 = 1.0;
    }
    float _381;
    if (_188)
    {
        float _380;
        if ((length(_165) * DeferredLightUniforms.DeferredLightUniforms_InvRadius) < 1.0)
        {
            float3 _339 = abs(_165);
            float _340 = _339.x;
            float _341 = _339.y;
            float _342 = _339.z;
            float _344 = fast::max(_340, fast::max(_341, _342));
            int _363;
            if (_344 == _340)
            {
                _363 = (_340 == _165.x) ? 0 : 1;
            }
            else
            {
                int _359;
                if (_344 == _341)
                {
                    _359 = (_341 == _165.y) ? 2 : 3;
                }
                else
                {
                    _359 = (_342 == _165.z) ? 4 : 5;
                }
                _363 = _359;
            }
            float4 _371 = _Globals.ShadowViewProjectionMatrices[_363] * float4(-_165, 1.0);
            float _373 = _371.w;
            _380 = ShadowDepthCubeTexture.sample_compare(ShadowDepthCubeTextureSampler, _165, (_371.z / _373) + ((_Globals.InvShadowmapResolution * (-15.35999965667724609375)) / _373), level(0.0));
        }
        else
        {
            _380 = 1.0;
        }
        _381 = _380;
    }
    else
    {
        float4 _303 = _Globals.WorldToShadowMatrix * float4(_164, 1.0);
        float2 _307 = _303.xy / float2(_303.w);
        bool2 _311 = _307 >= _Globals.ShadowmapMinMax.xy;
        bool2 _313 = _307 <= _Globals.ShadowmapMinMax.zw;
        float _329;
        if (all(bool2(_311.x && _313.x, _311.y && _313.y)))
        {
            _329 = float(_303.z < (ShadowDepthTexture.sample(ShadowDepthTextureSampler, _307, level(0.0)).x - _Globals.DepthBiasParameters.x));
        }
        else
        {
            _329 = 1.0;
        }
        _381 = _329;
    }
    float _402;
    if ((!_188) && (!(_Globals.SpotlightMask >= 1.0)))
    {
        float _399 = fast::clamp((dot(_164 - View.View_WorldCameraOrigin, View.View_ViewForward) * _Globals.ShadowInjectParams.z) + _Globals.ShadowInjectParams.w, 0.0, 1.0);
        _402 = mix(_381, 1.0, _399 * _399);
    }
    else
    {
        _402 = _381;
    }
    float _416 = fast::min(_293, _402) * dot(fast::max(mix(Material.Material_VectorExpressions[2].xyz, Material.Material_VectorExpressions[3].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0)), float3(0.33329999446868896484375));
    float _438;
    float _439;
    if (_Globals.VolumeCascadeIndex == 1u)
    {
        float3 _430 = fast::clamp((float3(0.5) - abs(((float3(in.in_var_TEXCOORD0, _122 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w) * (1.0 + (4.0 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w))) - float3(2.0 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w)) - float3(0.5))) * 10.0, float3(0.0), float3(1.0));
        float _435 = (_430.x * _430.y) * _430.z;
        _438 = mix(0.0, _416, _435);
        _439 = mix(0.0, _185, _435);
    }
    else
    {
        _438 = _416;
        _439 = _185;
    }
    float3 _444 = ((float3(DeferredLightUniforms.DeferredLightUniforms_Color) * float3(0.3183098733425140380859375)) * _439) * _438;
    float4 _445 = _109;
    _445.x = 0.2820949852466583251953125;
    float4 _448 = _445;
    _448.y = (-0.48860299587249755859375) * _158.y;
    float4 _451 = _448;
    _451.z = 0.48860299587249755859375 * _158.z;
    float4 _454 = _451;
    _454.w = (-0.48860299587249755859375) * _158.x;
    float4 _456 = _454 * _444.x;
    float4 _458 = _454 * _444.y;
    float4 _460 = _454 * _444.z;
    out.out_var_SV_Target0 = float4(_456.x, _458.x, _460.x, 0.0) * 1.0;
    out.out_var_SV_Target1 = float4(dot(float3(_456.y, _458.y, _460.y), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), dot(float3(_456.z, _458.z, _460.z), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), dot(float3(_456.w, _458.w, _460.w), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), 0.0) * 1.0;
    return out;
}

