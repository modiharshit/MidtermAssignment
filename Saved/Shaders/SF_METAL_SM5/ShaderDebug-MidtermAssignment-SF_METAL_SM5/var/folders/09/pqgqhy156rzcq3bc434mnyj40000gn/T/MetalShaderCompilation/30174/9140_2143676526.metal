

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

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

struct type_Globals
{
    uint bStaticallyShadowed;
    float4x4 WorldToStaticShadowMatrix;
    float4 StaticShadowBufferSize;
    uint VolumeCascadeIndex;
    char _m4_pad[92];
    float SpotlightMask;
};

constant float4 _92 = {};

struct InjectMainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
    float4 out_var_SV_Target1 [[color(1)]];
};

struct InjectMainPS_in
{
    float2 in_var_TEXCOORD0 [[user(locn0), center_no_perspective]];
};

fragment InjectMainPS_out Main_000023b4_7fc5e86e(InjectMainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_DeferredLightUniforms& DeferredLightUniforms [[buffer(1)]], constant type_Material& Material [[buffer(2)]], constant type_Globals& _Globals [[buffer(3)]], texture2d<float> StaticShadowDepthTexture [[texture(0)]], sampler StaticShadowDepthTextureSampler [[sampler(0)]], uint gl_Layer [[render_target_array_index]])
{
    InjectMainPS_out out = {};
    float _104 = float(gl_Layer) + 0.5;
    float _116 = 0.5 * View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].w;
    float3 _121 = float3((View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].xy + (in.in_var_TEXCOORD0 / View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].xy)) - float2(_116), View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].z + (_104 * View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].w));
    float3 _130 = float3(DeferredLightUniforms.DeferredLightUniforms_Position) - _121;
    if (((1.0 / (DeferredLightUniforms.DeferredLightUniforms_InvRadius * DeferredLightUniforms.DeferredLightUniforms_InvRadius)) - dot(_130, _130)) < 0.0)
    {
        discard_fragment();
    }
    float3 _140 = normalize(_130);
    float3 _146 = _121 + float3(dot(abs(_140 * float3(_116)), float3(1.0)));
    float3 _147 = float3(DeferredLightUniforms.DeferredLightUniforms_Position) - _146;
    float3 _148 = _147 * DeferredLightUniforms.DeferredLightUniforms_InvRadius;
    float _165 = fast::clamp((dot(normalize(_147), DeferredLightUniforms.DeferredLightUniforms_Direction) - DeferredLightUniforms.DeferredLightUniforms_SpotAngles.x) * DeferredLightUniforms.DeferredLightUniforms_SpotAngles.y, 0.0, 1.0);
    float _167 = (_165 * _165) * pow(1.0 - fast::clamp(dot(_148, _148), 0.0, 1.0), DeferredLightUniforms.DeferredLightUniforms_FalloffExponent);
    float _274;
    if (_Globals.bStaticallyShadowed != 0u)
    {
        float _273;
        if (_Globals.SpotlightMask < 1.0)
        {
            float3 _250 = _146 - float3(DeferredLightUniforms.DeferredLightUniforms_Position);
            float _251 = length(_250);
            float3 _253 = _250 / float3(_251);
            float _257 = atan2(_253.y, _253.x) * 0.15915493667125701904296875;
            _273 = float((_251 * DeferredLightUniforms.DeferredLightUniforms_InvRadius) < StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, float2((_257 > 0.0) ? _257 : (1.0 + _257), acos(_253.z) * 0.3183098733425140380859375), level(0.0)).x);
        }
        else
        {
            float4 _185 = _Globals.WorldToStaticShadowMatrix * float4(_146, 1.0);
            float2 _189 = _185.xy / float2(_185.w);
            bool2 _190 = _189 >= float2(0.0);
            bool2 _191 = _189 <= float2(1.0);
            float _249;
            if (all(bool2(_190.x && _191.x, _190.y && _191.y)))
            {
                float2 _203 = (_189 * _Globals.StaticShadowBufferSize.xy) - float2(0.5);
                float2 _204 = fract(_203);
                float2 _205 = floor(_203);
                float4 _213 = _92;
                _213.x = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_205 + float2(0.5, 1.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _219 = _213;
                _219.y = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_205 + float2(1.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _225 = _219;
                _225.z = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_205 + float2(1.5, 0.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _230 = _225;
                _230.w = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_205 + float2(0.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _240 = fast::clamp(fast::clamp((_230 * 40.0) - float4((_185.z * 40.0) - 1.0), float4(0.0), float4(1.0)) + select(float4(0.0), float4(1.0), _230 > float4(0.9900000095367431640625)), float4(0.0), float4(1.0));
                float2 _244 = mix(_240.wx, _240.zy, _204.xx);
                _249 = mix(_244.x, _244.y, _204.y);
            }
            else
            {
                _249 = 1.0;
            }
            _273 = _249;
        }
        _274 = _273;
    }
    else
    {
        _274 = 1.0;
    }
    float _284 = _274 * dot(fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0)), float3(0.33329999446868896484375));
    float _306;
    float _307;
    if (_Globals.VolumeCascadeIndex == 1u)
    {
        float3 _298 = fast::clamp((float3(0.5) - abs(((float3(in.in_var_TEXCOORD0, _104 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w) * (1.0 + (4.0 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w))) - float3(2.0 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w)) - float3(0.5))) * 10.0, float3(0.0), float3(1.0));
        float _303 = (_298.x * _298.y) * _298.z;
        _306 = mix(0.0, _284, _303);
        _307 = mix(0.0, _167, _303);
    }
    else
    {
        _306 = _284;
        _307 = _167;
    }
    float3 _312 = ((float3(DeferredLightUniforms.DeferredLightUniforms_Color) * float3(0.3183098733425140380859375)) * _307) * _306;
    float4 _313 = _92;
    _313.x = 0.2820949852466583251953125;
    float4 _316 = _313;
    _316.y = (-0.48860299587249755859375) * _140.y;
    float4 _319 = _316;
    _319.z = 0.48860299587249755859375 * _140.z;
    float4 _322 = _319;
    _322.w = (-0.48860299587249755859375) * _140.x;
    float4 _324 = _322 * _312.x;
    float4 _326 = _322 * _312.y;
    float4 _328 = _322 * _312.z;
    out.out_var_SV_Target0 = float4(_324.x, _326.x, _328.x, 0.0) * 1.0;
    out.out_var_SV_Target1 = float4(dot(float3(_324.y, _326.y, _328.y), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), dot(float3(_324.z, _326.z, _328.z), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), dot(float3(_324.w, _326.w, _328.w), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), 0.0) * 1.0;
    return out;
}

