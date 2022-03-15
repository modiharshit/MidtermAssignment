

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

fragment InjectMainPS_out Main_000023c3_e2cfaf9d(InjectMainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_DeferredLightUniforms& DeferredLightUniforms [[buffer(1)]], constant type_Material& Material [[buffer(2)]], constant type_Globals& _Globals [[buffer(3)]], texture2d<float> StaticShadowDepthTexture [[texture(0)]], sampler StaticShadowDepthTextureSampler [[sampler(0)]], uint gl_Layer [[render_target_array_index]])
{
    InjectMainPS_out out = {};
    float _103 = float(gl_Layer) + 0.5;
    float _115 = 0.5 * View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].w;
    float3 _120 = float3((View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].xy + (in.in_var_TEXCOORD0 / View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].xy)) - float2(_115), View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].z + (_103 * View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].w));
    float3 _129 = float3(DeferredLightUniforms.DeferredLightUniforms_Position) - _120;
    if (((1.0 / (DeferredLightUniforms.DeferredLightUniforms_InvRadius * DeferredLightUniforms.DeferredLightUniforms_InvRadius)) - dot(_129, _129)) < 0.0)
    {
        discard_fragment();
    }
    float3 _139 = normalize(_129);
    float3 _145 = _120 + float3(dot(abs(_139 * float3(_115)), float3(1.0)));
    float3 _146 = float3(DeferredLightUniforms.DeferredLightUniforms_Position) - _145;
    float _147 = dot(_146, _146);
    float _151 = (_147 * DeferredLightUniforms.DeferredLightUniforms_InvRadius) * DeferredLightUniforms.DeferredLightUniforms_InvRadius;
    float _154 = fast::clamp(1.0 - (_151 * _151), 0.0, 1.0);
    float _167 = fast::clamp((dot(normalize(_146), DeferredLightUniforms.DeferredLightUniforms_Direction) - DeferredLightUniforms.DeferredLightUniforms_SpotAngles.x) * DeferredLightUniforms.DeferredLightUniforms_SpotAngles.y, 0.0, 1.0);
    float _169 = (_167 * _167) * ((1.0 / (_147 + 1.0)) * (_154 * _154));
    float _276;
    if (_Globals.bStaticallyShadowed != 0u)
    {
        float _275;
        if (_Globals.SpotlightMask < 1.0)
        {
            float3 _252 = _145 - float3(DeferredLightUniforms.DeferredLightUniforms_Position);
            float _253 = length(_252);
            float3 _255 = _252 / float3(_253);
            float _259 = atan2(_255.y, _255.x) * 0.15915493667125701904296875;
            _275 = float((_253 * DeferredLightUniforms.DeferredLightUniforms_InvRadius) < StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, float2((_259 > 0.0) ? _259 : (1.0 + _259), acos(_255.z) * 0.3183098733425140380859375), level(0.0)).x);
        }
        else
        {
            float4 _187 = _Globals.WorldToStaticShadowMatrix * float4(_145, 1.0);
            float2 _191 = _187.xy / float2(_187.w);
            bool2 _192 = _191 >= float2(0.0);
            bool2 _193 = _191 <= float2(1.0);
            float _251;
            if (all(bool2(_192.x && _193.x, _192.y && _193.y)))
            {
                float2 _205 = (_191 * _Globals.StaticShadowBufferSize.xy) - float2(0.5);
                float2 _206 = fract(_205);
                float2 _207 = floor(_205);
                float4 _215 = _92;
                _215.x = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_207 + float2(0.5, 1.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _221 = _215;
                _221.y = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_207 + float2(1.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _227 = _221;
                _227.z = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_207 + float2(1.5, 0.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _232 = _227;
                _232.w = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_207 + float2(0.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _242 = fast::clamp(fast::clamp((_232 * 40.0) - float4((_187.z * 40.0) - 1.0), float4(0.0), float4(1.0)) + select(float4(0.0), float4(1.0), _232 > float4(0.9900000095367431640625)), float4(0.0), float4(1.0));
                float2 _246 = mix(_242.wx, _242.zy, _206.xx);
                _251 = mix(_246.x, _246.y, _206.y);
            }
            else
            {
                _251 = 1.0;
            }
            _275 = _251;
        }
        _276 = _275;
    }
    else
    {
        _276 = 1.0;
    }
    float _286 = _276 * dot(fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0)), float3(0.33329999446868896484375));
    float _308;
    float _309;
    if (_Globals.VolumeCascadeIndex == 1u)
    {
        float3 _300 = fast::clamp((float3(0.5) - abs(((float3(in.in_var_TEXCOORD0, _103 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w) * (1.0 + (4.0 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w))) - float3(2.0 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w)) - float3(0.5))) * 10.0, float3(0.0), float3(1.0));
        float _305 = (_300.x * _300.y) * _300.z;
        _308 = mix(0.0, _286, _305);
        _309 = mix(0.0, _169, _305);
    }
    else
    {
        _308 = _286;
        _309 = _169;
    }
    float3 _314 = ((DeferredLightUniforms.DeferredLightUniforms_Color * float3(0.3183098733425140380859375)) * _309) * _308;
    float4 _315 = _92;
    _315.x = 0.2820949852466583251953125;
    float4 _318 = _315;
    _318.y = (-0.48860299587249755859375) * _139.y;
    float4 _321 = _318;
    _321.z = 0.48860299587249755859375 * _139.z;
    float4 _324 = _321;
    _324.w = (-0.48860299587249755859375) * _139.x;
    float4 _326 = _324 * _314.x;
    float4 _328 = _324 * _314.y;
    float4 _330 = _324 * _314.z;
    out.out_var_SV_Target0 = float4(_326.x, _328.x, _330.x, 0.0) * 1.0;
    out.out_var_SV_Target1 = float4(dot(float3(_326.y, _328.y, _330.y), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), dot(float3(_326.z, _328.z, _330.z), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), dot(float3(_326.w, _328.w, _330.w), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), 0.0) * 1.0;
    return out;
}

