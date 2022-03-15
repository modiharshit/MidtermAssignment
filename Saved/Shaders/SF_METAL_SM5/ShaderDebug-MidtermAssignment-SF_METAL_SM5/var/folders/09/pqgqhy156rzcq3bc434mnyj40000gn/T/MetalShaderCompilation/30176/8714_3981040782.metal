

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
    char _m0_pad[2368];
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

struct type_Globals
{
    uint bStaticallyShadowed;
    float4x4 WorldToStaticShadowMatrix;
    float4 StaticShadowBufferSize;
    uint VolumeCascadeIndex;
    float SpotlightMask;
};

constant float4 _87 = {};

struct InjectMainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
    float4 out_var_SV_Target1 [[color(1)]];
};

struct InjectMainPS_in
{
    float2 in_var_TEXCOORD0 [[user(locn0), center_no_perspective]];
};

fragment InjectMainPS_out Main_0000220a_ed49dc8e(InjectMainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_DeferredLightUniforms& DeferredLightUniforms [[buffer(1)]], constant type_Globals& _Globals [[buffer(2)]], texture2d<float> StaticShadowDepthTexture [[texture(0)]], sampler StaticShadowDepthTextureSampler [[sampler(0)]], uint gl_Layer [[render_target_array_index]])
{
    InjectMainPS_out out = {};
    float _99 = float(gl_Layer) + 0.5;
    float _111 = 0.5 * View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].w;
    float3 _116 = float3((View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].xy + (in.in_var_TEXCOORD0 / View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].xy)) - float2(_111), View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].z + (_99 * View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].w));
    float3 _125 = float3(DeferredLightUniforms.DeferredLightUniforms_Position) - _116;
    if (((1.0 / (DeferredLightUniforms.DeferredLightUniforms_InvRadius * DeferredLightUniforms.DeferredLightUniforms_InvRadius)) - dot(_125, _125)) < 0.0)
    {
        discard_fragment();
    }
    float3 _135 = normalize(_125);
    float3 _141 = _116 + float3(dot(abs(_135 * float3(_111)), float3(1.0)));
    float3 _142 = float3(DeferredLightUniforms.DeferredLightUniforms_Position) - _141;
    float3 _143 = _142 * DeferredLightUniforms.DeferredLightUniforms_InvRadius;
    float _160 = fast::clamp((dot(normalize(_142), DeferredLightUniforms.DeferredLightUniforms_Direction) - DeferredLightUniforms.DeferredLightUniforms_SpotAngles.x) * DeferredLightUniforms.DeferredLightUniforms_SpotAngles.y, 0.0, 1.0);
    float _162 = (_160 * _160) * pow(1.0 - fast::clamp(dot(_143, _143), 0.0, 1.0), DeferredLightUniforms.DeferredLightUniforms_FalloffExponent);
    float _269;
    if (_Globals.bStaticallyShadowed != 0u)
    {
        float _268;
        if (_Globals.SpotlightMask < 1.0)
        {
            float3 _245 = _141 - float3(DeferredLightUniforms.DeferredLightUniforms_Position);
            float _246 = length(_245);
            float3 _248 = _245 / float3(_246);
            float _252 = atan2(_248.y, _248.x) * 0.15915493667125701904296875;
            _268 = float((_246 * DeferredLightUniforms.DeferredLightUniforms_InvRadius) < StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, float2((_252 > 0.0) ? _252 : (1.0 + _252), acos(_248.z) * 0.3183098733425140380859375), level(0.0)).x);
        }
        else
        {
            float4 _180 = _Globals.WorldToStaticShadowMatrix * float4(_141, 1.0);
            float2 _184 = _180.xy / float2(_180.w);
            bool2 _185 = _184 >= float2(0.0);
            bool2 _186 = _184 <= float2(1.0);
            float _244;
            if (all(bool2(_185.x && _186.x, _185.y && _186.y)))
            {
                float2 _198 = (_184 * _Globals.StaticShadowBufferSize.xy) - float2(0.5);
                float2 _199 = fract(_198);
                float2 _200 = floor(_198);
                float4 _208 = _87;
                _208.x = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_200 + float2(0.5, 1.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _214 = _208;
                _214.y = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_200 + float2(1.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _220 = _214;
                _220.z = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_200 + float2(1.5, 0.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _225 = _220;
                _225.w = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_200 + float2(0.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _235 = fast::clamp(fast::clamp((_225 * 40.0) - float4((_180.z * 40.0) - 1.0), float4(0.0), float4(1.0)) + select(float4(0.0), float4(1.0), _225 > float4(0.9900000095367431640625)), float4(0.0), float4(1.0));
                float2 _239 = mix(_235.wx, _235.zy, _199.xx);
                _244 = mix(_239.x, _239.y, _199.y);
            }
            else
            {
                _244 = 1.0;
            }
            _268 = _244;
        }
        _269 = _268;
    }
    else
    {
        _269 = 1.0;
    }
    float _291;
    float _292;
    if (_Globals.VolumeCascadeIndex == 1u)
    {
        float3 _283 = fast::clamp((float3(0.5) - abs(((float3(in.in_var_TEXCOORD0, _99 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w) * (1.0 + (4.0 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w))) - float3(2.0 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w)) - float3(0.5))) * 10.0, float3(0.0), float3(1.0));
        float _288 = (_283.x * _283.y) * _283.z;
        _291 = mix(0.0, _269, _288);
        _292 = mix(0.0, _162, _288);
    }
    else
    {
        _291 = _269;
        _292 = _162;
    }
    float3 _297 = ((float3(DeferredLightUniforms.DeferredLightUniforms_Color) * float3(0.3183098733425140380859375)) * _292) * _291;
    float4 _298 = _87;
    _298.x = 0.2820949852466583251953125;
    float4 _301 = _298;
    _301.y = (-0.48860299587249755859375) * _135.y;
    float4 _304 = _301;
    _304.z = 0.48860299587249755859375 * _135.z;
    float4 _307 = _304;
    _307.w = (-0.48860299587249755859375) * _135.x;
    float4 _309 = _307 * _297.x;
    float4 _311 = _307 * _297.y;
    float4 _313 = _307 * _297.z;
    out.out_var_SV_Target0 = float4(_309.x, _311.x, _313.x, 0.0) * 1.0;
    out.out_var_SV_Target1 = float4(dot(float3(_309.y, _311.y, _313.y), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), dot(float3(_309.z, _311.z, _313.z), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), dot(float3(_309.w, _311.w, _313.w), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), 0.0) * 1.0;
    return out;
}

