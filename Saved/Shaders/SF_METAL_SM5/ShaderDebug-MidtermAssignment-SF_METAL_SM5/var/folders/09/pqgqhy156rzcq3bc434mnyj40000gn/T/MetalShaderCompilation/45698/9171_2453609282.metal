

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

fragment InjectMainPS_out Main_000023d3_923f1b42(InjectMainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_DeferredLightUniforms& DeferredLightUniforms [[buffer(1)]], constant type_Material& Material [[buffer(2)]], constant type_Globals& _Globals [[buffer(3)]], texture2d<float> StaticShadowDepthTexture [[texture(0)]], sampler StaticShadowDepthTextureSampler [[sampler(0)]], uint gl_Layer [[render_target_array_index]])
{
    InjectMainPS_out out = {};
    float _105 = float(gl_Layer) + 0.5;
    float _117 = 0.5 * View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].w;
    float3 _122 = float3((View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].xy + (in.in_var_TEXCOORD0 / View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].xy)) - float2(_117), View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].z + (_105 * View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].w));
    float3 _131 = float3(DeferredLightUniforms.DeferredLightUniforms_Position) - _122;
    if (((1.0 / (DeferredLightUniforms.DeferredLightUniforms_InvRadius * DeferredLightUniforms.DeferredLightUniforms_InvRadius)) - dot(_131, _131)) < 0.0)
    {
        discard_fragment();
    }
    float3 _141 = normalize(_131);
    float3 _147 = _122 + float3(dot(abs(_141 * float3(_117)), float3(1.0)));
    float3 _148 = float3(DeferredLightUniforms.DeferredLightUniforms_Position) - _147;
    float3 _149 = _148 * DeferredLightUniforms.DeferredLightUniforms_InvRadius;
    float _166 = fast::clamp((dot(normalize(_148), DeferredLightUniforms.DeferredLightUniforms_Direction) - DeferredLightUniforms.DeferredLightUniforms_SpotAngles.x) * DeferredLightUniforms.DeferredLightUniforms_SpotAngles.y, 0.0, 1.0);
    float _168 = (_166 * _166) * pow(1.0 - fast::clamp(dot(_149, _149), 0.0, 1.0), DeferredLightUniforms.DeferredLightUniforms_FalloffExponent);
    float _275;
    if (_Globals.bStaticallyShadowed != 0u)
    {
        float _274;
        if (_Globals.SpotlightMask < 1.0)
        {
            float3 _251 = _147 - float3(DeferredLightUniforms.DeferredLightUniforms_Position);
            float _252 = length(_251);
            float3 _254 = _251 / float3(_252);
            float _258 = atan2(_254.y, _254.x) * 0.15915493667125701904296875;
            _274 = float((_252 * DeferredLightUniforms.DeferredLightUniforms_InvRadius) < StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, float2((_258 > 0.0) ? _258 : (1.0 + _258), acos(_254.z) * 0.3183098733425140380859375), level(0.0)).x);
        }
        else
        {
            float4 _186 = _Globals.WorldToStaticShadowMatrix * float4(_147, 1.0);
            float2 _190 = _186.xy / float2(_186.w);
            bool2 _191 = _190 >= float2(0.0);
            bool2 _192 = _190 <= float2(1.0);
            float _250;
            if (all(bool2(_191.x && _192.x, _191.y && _192.y)))
            {
                float2 _204 = (_190 * _Globals.StaticShadowBufferSize.xy) - float2(0.5);
                float2 _205 = fract(_204);
                float2 _206 = floor(_204);
                float4 _214 = _93;
                _214.x = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_206 + float2(0.5, 1.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _220 = _214;
                _220.y = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_206 + float2(1.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _226 = _220;
                _226.z = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_206 + float2(1.5, 0.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _231 = _226;
                _231.w = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_206 + float2(0.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _241 = fast::clamp(fast::clamp((_231 * 40.0) - float4((_186.z * 40.0) - 1.0), float4(0.0), float4(1.0)) + select(float4(0.0), float4(1.0), _231 > float4(0.9900000095367431640625)), float4(0.0), float4(1.0));
                float2 _245 = mix(_241.wx, _241.zy, _205.xx);
                _250 = mix(_245.x, _245.y, _205.y);
            }
            else
            {
                _250 = 1.0;
            }
            _274 = _250;
        }
        _275 = _274;
    }
    else
    {
        _275 = 1.0;
    }
    float _288 = _275 * dot(fast::max(mix(Material.Material_VectorExpressions[2].xyz, Material.Material_VectorExpressions[3].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0)), float3(0.33329999446868896484375));
    float _310;
    float _311;
    if (_Globals.VolumeCascadeIndex == 1u)
    {
        float3 _302 = fast::clamp((float3(0.5) - abs(((float3(in.in_var_TEXCOORD0, _105 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w) * (1.0 + (4.0 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w))) - float3(2.0 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w)) - float3(0.5))) * 10.0, float3(0.0), float3(1.0));
        float _307 = (_302.x * _302.y) * _302.z;
        _310 = mix(0.0, _288, _307);
        _311 = mix(0.0, _168, _307);
    }
    else
    {
        _310 = _288;
        _311 = _168;
    }
    float3 _316 = ((float3(DeferredLightUniforms.DeferredLightUniforms_Color) * float3(0.3183098733425140380859375)) * _311) * _310;
    float4 _317 = _93;
    _317.x = 0.2820949852466583251953125;
    float4 _320 = _317;
    _320.y = (-0.48860299587249755859375) * _141.y;
    float4 _323 = _320;
    _323.z = 0.48860299587249755859375 * _141.z;
    float4 _326 = _323;
    _326.w = (-0.48860299587249755859375) * _141.x;
    float4 _328 = _326 * _316.x;
    float4 _330 = _326 * _316.y;
    float4 _332 = _326 * _316.z;
    out.out_var_SV_Target0 = float4(_328.x, _330.x, _332.x, 0.0) * 1.0;
    out.out_var_SV_Target1 = float4(dot(float3(_328.y, _330.y, _332.y), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), dot(float3(_328.z, _330.z, _332.z), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), dot(float3(_328.w, _330.w, _332.w), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), 0.0) * 1.0;
    return out;
}

