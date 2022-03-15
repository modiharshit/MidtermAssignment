

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
    float3 DeferredLightUniforms_Color;
    float3 DeferredLightUniforms_Direction;
    char _m4_pad[16];
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

fragment InjectMainPS_out Main_00002217_74969c6b(InjectMainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_DeferredLightUniforms& DeferredLightUniforms [[buffer(1)]], constant type_Globals& _Globals [[buffer(2)]], texture2d<float> StaticShadowDepthTexture [[texture(0)]], sampler StaticShadowDepthTextureSampler [[sampler(0)]], uint gl_Layer [[render_target_array_index]])
{
    InjectMainPS_out out = {};
    float _98 = float(gl_Layer) + 0.5;
    float _110 = 0.5 * View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].w;
    float3 _115 = float3((View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].xy + (in.in_var_TEXCOORD0 / View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].xy)) - float2(_110), View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].z + (_98 * View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].w));
    float3 _124 = float3(DeferredLightUniforms.DeferredLightUniforms_Position) - _115;
    if (((1.0 / (DeferredLightUniforms.DeferredLightUniforms_InvRadius * DeferredLightUniforms.DeferredLightUniforms_InvRadius)) - dot(_124, _124)) < 0.0)
    {
        discard_fragment();
    }
    float3 _134 = normalize(_124);
    float3 _140 = _115 + float3(dot(abs(_134 * float3(_110)), float3(1.0)));
    float3 _141 = float3(DeferredLightUniforms.DeferredLightUniforms_Position) - _140;
    float _142 = dot(_141, _141);
    float _146 = (_142 * DeferredLightUniforms.DeferredLightUniforms_InvRadius) * DeferredLightUniforms.DeferredLightUniforms_InvRadius;
    float _149 = fast::clamp(1.0 - (_146 * _146), 0.0, 1.0);
    float _162 = fast::clamp((dot(normalize(_141), DeferredLightUniforms.DeferredLightUniforms_Direction) - DeferredLightUniforms.DeferredLightUniforms_SpotAngles.x) * DeferredLightUniforms.DeferredLightUniforms_SpotAngles.y, 0.0, 1.0);
    float _164 = (_162 * _162) * ((1.0 / (_142 + 1.0)) * (_149 * _149));
    float _271;
    if (_Globals.bStaticallyShadowed != 0u)
    {
        float _270;
        if (_Globals.SpotlightMask < 1.0)
        {
            float3 _247 = _140 - float3(DeferredLightUniforms.DeferredLightUniforms_Position);
            float _248 = length(_247);
            float3 _250 = _247 / float3(_248);
            float _254 = atan2(_250.y, _250.x) * 0.15915493667125701904296875;
            _270 = float((_248 * DeferredLightUniforms.DeferredLightUniforms_InvRadius) < StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, float2((_254 > 0.0) ? _254 : (1.0 + _254), acos(_250.z) * 0.3183098733425140380859375), level(0.0)).x);
        }
        else
        {
            float4 _182 = _Globals.WorldToStaticShadowMatrix * float4(_140, 1.0);
            float2 _186 = _182.xy / float2(_182.w);
            bool2 _187 = _186 >= float2(0.0);
            bool2 _188 = _186 <= float2(1.0);
            float _246;
            if (all(bool2(_187.x && _188.x, _187.y && _188.y)))
            {
                float2 _200 = (_186 * _Globals.StaticShadowBufferSize.xy) - float2(0.5);
                float2 _201 = fract(_200);
                float2 _202 = floor(_200);
                float4 _210 = _87;
                _210.x = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_202 + float2(0.5, 1.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _216 = _210;
                _216.y = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_202 + float2(1.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _222 = _216;
                _222.z = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_202 + float2(1.5, 0.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _227 = _222;
                _227.w = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_202 + float2(0.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _237 = fast::clamp(fast::clamp((_227 * 40.0) - float4((_182.z * 40.0) - 1.0), float4(0.0), float4(1.0)) + select(float4(0.0), float4(1.0), _227 > float4(0.9900000095367431640625)), float4(0.0), float4(1.0));
                float2 _241 = mix(_237.wx, _237.zy, _201.xx);
                _246 = mix(_241.x, _241.y, _201.y);
            }
            else
            {
                _246 = 1.0;
            }
            _270 = _246;
        }
        _271 = _270;
    }
    else
    {
        _271 = 1.0;
    }
    float _293;
    float _294;
    if (_Globals.VolumeCascadeIndex == 1u)
    {
        float3 _285 = fast::clamp((float3(0.5) - abs(((float3(in.in_var_TEXCOORD0, _98 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w) * (1.0 + (4.0 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w))) - float3(2.0 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w)) - float3(0.5))) * 10.0, float3(0.0), float3(1.0));
        float _290 = (_285.x * _285.y) * _285.z;
        _293 = mix(0.0, _271, _290);
        _294 = mix(0.0, _164, _290);
    }
    else
    {
        _293 = _271;
        _294 = _164;
    }
    float3 _299 = ((DeferredLightUniforms.DeferredLightUniforms_Color * float3(0.3183098733425140380859375)) * _294) * _293;
    float4 _300 = _87;
    _300.x = 0.2820949852466583251953125;
    float4 _303 = _300;
    _303.y = (-0.48860299587249755859375) * _134.y;
    float4 _306 = _303;
    _306.z = 0.48860299587249755859375 * _134.z;
    float4 _309 = _306;
    _309.w = (-0.48860299587249755859375) * _134.x;
    float4 _311 = _309 * _299.x;
    float4 _313 = _309 * _299.y;
    float4 _315 = _309 * _299.z;
    out.out_var_SV_Target0 = float4(_311.x, _313.x, _315.x, 0.0) * 1.0;
    out.out_var_SV_Target1 = float4(dot(float3(_311.y, _313.y, _315.y), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), dot(float3(_311.z, _313.z, _315.z), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), dot(float3(_311.w, _313.w, _315.w), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), 0.0) * 1.0;
    return out;
}

