

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

struct type_Material
{
    spvUnsafeArray<float4, 4> Material_VectorExpressions;
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

constant float4 _93 = {};

struct InjectMainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
    float4 out_var_SV_Target1 [[color(1)]];
};

struct InjectMainPS_in
{
    float2 in_var_TEXCOORD0 [[user(locn0), center_no_perspective]];
};

fragment InjectMainPS_out Main_000023e2_8e1f9e1b(InjectMainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_DeferredLightUniforms& DeferredLightUniforms [[buffer(1)]], constant type_Material& Material [[buffer(2)]], constant type_Globals& _Globals [[buffer(3)]], texture2d<float> StaticShadowDepthTexture [[texture(0)]], sampler StaticShadowDepthTextureSampler [[sampler(0)]], uint gl_Layer [[render_target_array_index]])
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
    float _148 = dot(_147, _147);
    float _152 = (_148 * DeferredLightUniforms.DeferredLightUniforms_InvRadius) * DeferredLightUniforms.DeferredLightUniforms_InvRadius;
    float _155 = fast::clamp(1.0 - (_152 * _152), 0.0, 1.0);
    float _168 = fast::clamp((dot(normalize(_147), DeferredLightUniforms.DeferredLightUniforms_Direction) - DeferredLightUniforms.DeferredLightUniforms_SpotAngles.x) * DeferredLightUniforms.DeferredLightUniforms_SpotAngles.y, 0.0, 1.0);
    float _170 = (_168 * _168) * ((1.0 / (_148 + 1.0)) * (_155 * _155));
    float _277;
    if (_Globals.bStaticallyShadowed != 0u)
    {
        float _276;
        if (_Globals.SpotlightMask < 1.0)
        {
            float3 _253 = _146 - float3(DeferredLightUniforms.DeferredLightUniforms_Position);
            float _254 = length(_253);
            float3 _256 = _253 / float3(_254);
            float _260 = atan2(_256.y, _256.x) * 0.15915493667125701904296875;
            _276 = float((_254 * DeferredLightUniforms.DeferredLightUniforms_InvRadius) < StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, float2((_260 > 0.0) ? _260 : (1.0 + _260), acos(_256.z) * 0.3183098733425140380859375), level(0.0)).x);
        }
        else
        {
            float4 _188 = _Globals.WorldToStaticShadowMatrix * float4(_146, 1.0);
            float2 _192 = _188.xy / float2(_188.w);
            bool2 _193 = _192 >= float2(0.0);
            bool2 _194 = _192 <= float2(1.0);
            float _252;
            if (all(bool2(_193.x && _194.x, _193.y && _194.y)))
            {
                float2 _206 = (_192 * _Globals.StaticShadowBufferSize.xy) - float2(0.5);
                float2 _207 = fract(_206);
                float2 _208 = floor(_206);
                float4 _216 = _93;
                _216.x = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_208 + float2(0.5, 1.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _222 = _216;
                _222.y = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_208 + float2(1.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _228 = _222;
                _228.z = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_208 + float2(1.5, 0.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _233 = _228;
                _233.w = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_208 + float2(0.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _243 = fast::clamp(fast::clamp((_233 * 40.0) - float4((_188.z * 40.0) - 1.0), float4(0.0), float4(1.0)) + select(float4(0.0), float4(1.0), _233 > float4(0.9900000095367431640625)), float4(0.0), float4(1.0));
                float2 _247 = mix(_243.wx, _243.zy, _207.xx);
                _252 = mix(_247.x, _247.y, _207.y);
            }
            else
            {
                _252 = 1.0;
            }
            _276 = _252;
        }
        _277 = _276;
    }
    else
    {
        _277 = 1.0;
    }
    float _290 = _277 * dot(fast::max(mix(Material.Material_VectorExpressions[2].xyz, Material.Material_VectorExpressions[3].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0)), float3(0.33329999446868896484375));
    float _312;
    float _313;
    if (_Globals.VolumeCascadeIndex == 1u)
    {
        float3 _304 = fast::clamp((float3(0.5) - abs(((float3(in.in_var_TEXCOORD0, _104 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w) * (1.0 + (4.0 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w))) - float3(2.0 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w)) - float3(0.5))) * 10.0, float3(0.0), float3(1.0));
        float _309 = (_304.x * _304.y) * _304.z;
        _312 = mix(0.0, _290, _309);
        _313 = mix(0.0, _170, _309);
    }
    else
    {
        _312 = _290;
        _313 = _170;
    }
    float3 _318 = ((DeferredLightUniforms.DeferredLightUniforms_Color * float3(0.3183098733425140380859375)) * _313) * _312;
    float4 _319 = _93;
    _319.x = 0.2820949852466583251953125;
    float4 _322 = _319;
    _322.y = (-0.48860299587249755859375) * _140.y;
    float4 _325 = _322;
    _325.z = 0.48860299587249755859375 * _140.z;
    float4 _328 = _325;
    _328.w = (-0.48860299587249755859375) * _140.x;
    float4 _330 = _328 * _318.x;
    float4 _332 = _328 * _318.y;
    float4 _334 = _328 * _318.z;
    out.out_var_SV_Target0 = float4(_330.x, _332.x, _334.x, 0.0) * 1.0;
    out.out_var_SV_Target1 = float4(dot(float3(_330.y, _332.y, _334.y), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), dot(float3(_330.z, _332.z, _334.z), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), dot(float3(_330.w, _332.w, _334.w), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), 0.0) * 1.0;
    return out;
}

