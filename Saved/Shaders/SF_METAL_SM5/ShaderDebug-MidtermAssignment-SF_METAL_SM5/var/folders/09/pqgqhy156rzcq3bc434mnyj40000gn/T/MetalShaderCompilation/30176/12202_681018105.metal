

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

fragment InjectMainPS_out Main_00002faa_289782f9(InjectMainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_DeferredLightUniforms& DeferredLightUniforms [[buffer(1)]], constant type_Material& Material [[buffer(2)]], constant type_Globals& _Globals [[buffer(3)]], texture2d<float> ShadowDepthTexture [[texture(0)]], depthcube<float> ShadowDepthCubeTexture [[texture(1)]], texture2d<float> StaticShadowDepthTexture [[texture(2)]], sampler ShadowDepthTextureSampler [[sampler(0)]], sampler ShadowDepthCubeTextureSampler [[sampler(1)]], sampler StaticShadowDepthTextureSampler [[sampler(2)]], uint gl_Layer [[render_target_array_index]])
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
    float3 _165 = _164 * DeferredLightUniforms.DeferredLightUniforms_InvRadius;
    float _182 = fast::clamp((dot(normalize(_164), DeferredLightUniforms.DeferredLightUniforms_Direction) - DeferredLightUniforms.DeferredLightUniforms_SpotAngles.x) * DeferredLightUniforms.DeferredLightUniforms_SpotAngles.y, 0.0, 1.0);
    float _184 = (_182 * _182) * pow(1.0 - fast::clamp(dot(_165, _165), 0.0, 1.0), DeferredLightUniforms.DeferredLightUniforms_FalloffExponent);
    bool _187 = _Globals.SpotlightMask < 1.0;
    float _292;
    if (_Globals.bStaticallyShadowed != 0u)
    {
        float _291;
        if (_187)
        {
            float3 _268 = _163 - float3(DeferredLightUniforms.DeferredLightUniforms_Position);
            float _269 = length(_268);
            float3 _271 = _268 / float3(_269);
            float _275 = atan2(_271.y, _271.x) * 0.15915493667125701904296875;
            _291 = float((_269 * DeferredLightUniforms.DeferredLightUniforms_InvRadius) < StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, float2((_275 > 0.0) ? _275 : (1.0 + _275), acos(_271.z) * 0.3183098733425140380859375), level(0.0)).x);
        }
        else
        {
            float4 _203 = _Globals.WorldToStaticShadowMatrix * float4(_163, 1.0);
            float2 _207 = _203.xy / float2(_203.w);
            bool2 _208 = _207 >= float2(0.0);
            bool2 _209 = _207 <= float2(1.0);
            float _267;
            if (all(bool2(_208.x && _209.x, _208.y && _209.y)))
            {
                float2 _221 = (_207 * _Globals.StaticShadowBufferSize.xy) - float2(0.5);
                float2 _222 = fract(_221);
                float2 _223 = floor(_221);
                float4 _231 = _108;
                _231.x = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_223 + float2(0.5, 1.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _237 = _231;
                _237.y = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_223 + float2(1.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _243 = _237;
                _243.z = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_223 + float2(1.5, 0.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _248 = _243;
                _248.w = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_223 + float2(0.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _258 = fast::clamp(fast::clamp((_248 * 40.0) - float4((_203.z * 40.0) - 1.0), float4(0.0), float4(1.0)) + select(float4(0.0), float4(1.0), _248 > float4(0.9900000095367431640625)), float4(0.0), float4(1.0));
                float2 _262 = mix(_258.wx, _258.zy, _222.xx);
                _267 = mix(_262.x, _262.y, _222.y);
            }
            else
            {
                _267 = 1.0;
            }
            _291 = _267;
        }
        _292 = _291;
    }
    else
    {
        _292 = 1.0;
    }
    float _380;
    if (_187)
    {
        float _379;
        if ((length(_164) * DeferredLightUniforms.DeferredLightUniforms_InvRadius) < 1.0)
        {
            float3 _338 = abs(_164);
            float _339 = _338.x;
            float _340 = _338.y;
            float _341 = _338.z;
            float _343 = fast::max(_339, fast::max(_340, _341));
            int _362;
            if (_343 == _339)
            {
                _362 = (_339 == _164.x) ? 0 : 1;
            }
            else
            {
                int _358;
                if (_343 == _340)
                {
                    _358 = (_340 == _164.y) ? 2 : 3;
                }
                else
                {
                    _358 = (_341 == _164.z) ? 4 : 5;
                }
                _362 = _358;
            }
            float4 _370 = _Globals.ShadowViewProjectionMatrices[_362] * float4(-_164, 1.0);
            float _372 = _370.w;
            _379 = ShadowDepthCubeTexture.sample_compare(ShadowDepthCubeTextureSampler, _164, (_370.z / _372) + ((_Globals.InvShadowmapResolution * (-15.35999965667724609375)) / _372), level(0.0));
        }
        else
        {
            _379 = 1.0;
        }
        _380 = _379;
    }
    else
    {
        float4 _302 = _Globals.WorldToShadowMatrix * float4(_163, 1.0);
        float2 _306 = _302.xy / float2(_302.w);
        bool2 _310 = _306 >= _Globals.ShadowmapMinMax.xy;
        bool2 _312 = _306 <= _Globals.ShadowmapMinMax.zw;
        float _328;
        if (all(bool2(_310.x && _312.x, _310.y && _312.y)))
        {
            _328 = float(_302.z < (ShadowDepthTexture.sample(ShadowDepthTextureSampler, _306, level(0.0)).x - _Globals.DepthBiasParameters.x));
        }
        else
        {
            _328 = 1.0;
        }
        _380 = _328;
    }
    float _401;
    if ((!_187) && (!(_Globals.SpotlightMask >= 1.0)))
    {
        float _398 = fast::clamp((dot(_163 - View.View_WorldCameraOrigin, View.View_ViewForward) * _Globals.ShadowInjectParams.z) + _Globals.ShadowInjectParams.w, 0.0, 1.0);
        _401 = mix(_380, 1.0, _398 * _398);
    }
    else
    {
        _401 = _380;
    }
    float _412 = fast::min(_292, _401) * dot(fast::max(mix(float3(1.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0)), float3(0.33329999446868896484375));
    float _434;
    float _435;
    if (_Globals.VolumeCascadeIndex == 1u)
    {
        float3 _426 = fast::clamp((float3(0.5) - abs(((float3(in.in_var_TEXCOORD0, _121 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w) * (1.0 + (4.0 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w))) - float3(2.0 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w)) - float3(0.5))) * 10.0, float3(0.0), float3(1.0));
        float _431 = (_426.x * _426.y) * _426.z;
        _434 = mix(0.0, _412, _431);
        _435 = mix(0.0, _184, _431);
    }
    else
    {
        _434 = _412;
        _435 = _184;
    }
    float3 _440 = ((float3(DeferredLightUniforms.DeferredLightUniforms_Color) * float3(0.3183098733425140380859375)) * _435) * _434;
    float4 _441 = _108;
    _441.x = 0.2820949852466583251953125;
    float4 _444 = _441;
    _444.y = (-0.48860299587249755859375) * _157.y;
    float4 _447 = _444;
    _447.z = 0.48860299587249755859375 * _157.z;
    float4 _450 = _447;
    _450.w = (-0.48860299587249755859375) * _157.x;
    float4 _452 = _450 * _440.x;
    float4 _454 = _450 * _440.y;
    float4 _456 = _450 * _440.z;
    out.out_var_SV_Target0 = float4(_452.x, _454.x, _456.x, 0.0) * 1.0;
    out.out_var_SV_Target1 = float4(dot(float3(_452.y, _454.y, _456.y), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), dot(float3(_452.z, _454.z, _456.z), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), dot(float3(_452.w, _454.w, _456.w), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), 0.0) * 1.0;
    return out;
}

