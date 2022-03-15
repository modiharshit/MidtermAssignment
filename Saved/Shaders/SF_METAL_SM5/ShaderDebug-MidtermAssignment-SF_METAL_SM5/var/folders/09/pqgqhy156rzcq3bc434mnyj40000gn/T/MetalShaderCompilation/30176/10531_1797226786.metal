

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
    float4 LightFunctionParameters;
    float4x4 LightFunctionWorldToLight;
    float SpotlightMask;
};

constant spvUnsafeArray<float2, 1> _95 = spvUnsafeArray<float2, 1>({ float2(0.0) });

constant float4 _104 = {};

struct InjectMainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
    float4 out_var_SV_Target1 [[color(1)]];
};

struct InjectMainPS_in
{
    float2 in_var_TEXCOORD0 [[user(locn0), center_no_perspective]];
};

fragment InjectMainPS_out Main_00002923_6b1f8122(InjectMainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_DeferredLightUniforms& DeferredLightUniforms [[buffer(1)]], constant type_Material& Material [[buffer(2)]], constant type_Globals& _Globals [[buffer(3)]], texture2d<float> Material_Texture2D_0 [[texture(0)]], texture2d<float> StaticShadowDepthTexture [[texture(1)]], sampler Material_Texture2D_0Sampler [[sampler(0)]], sampler StaticShadowDepthTextureSampler [[sampler(1)]], uint gl_Layer [[render_target_array_index]])
{
    InjectMainPS_out out = {};
    float _117 = float(gl_Layer) + 0.5;
    float _129 = 0.5 * View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].w;
    float3 _134 = float3((View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].xy + (in.in_var_TEXCOORD0 / View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].xy)) - float2(_129), View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].z + (_117 * View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].w));
    float3 _143 = float3(DeferredLightUniforms.DeferredLightUniforms_Position) - _134;
    if (((1.0 / (DeferredLightUniforms.DeferredLightUniforms_InvRadius * DeferredLightUniforms.DeferredLightUniforms_InvRadius)) - dot(_143, _143)) < 0.0)
    {
        discard_fragment();
    }
    float3 _153 = normalize(_143);
    float3 _159 = _134 + float3(dot(abs(_153 * float3(_129)), float3(1.0)));
    float3 _160 = float3(DeferredLightUniforms.DeferredLightUniforms_Position) - _159;
    float3 _161 = _160 * DeferredLightUniforms.DeferredLightUniforms_InvRadius;
    float _178 = fast::clamp((dot(normalize(_160), DeferredLightUniforms.DeferredLightUniforms_Direction) - DeferredLightUniforms.DeferredLightUniforms_SpotAngles.x) * DeferredLightUniforms.DeferredLightUniforms_SpotAngles.y, 0.0, 1.0);
    float _180 = (_178 * _178) * pow(1.0 - fast::clamp(dot(_161, _161), 0.0, 1.0), DeferredLightUniforms.DeferredLightUniforms_FalloffExponent);
    float _287;
    if (_Globals.bStaticallyShadowed != 0u)
    {
        float _286;
        if (_Globals.SpotlightMask < 1.0)
        {
            float3 _263 = _159 - float3(DeferredLightUniforms.DeferredLightUniforms_Position);
            float _264 = length(_263);
            float3 _266 = _263 / float3(_264);
            float _270 = atan2(_266.y, _266.x) * 0.15915493667125701904296875;
            _286 = float((_264 * DeferredLightUniforms.DeferredLightUniforms_InvRadius) < StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, float2((_270 > 0.0) ? _270 : (1.0 + _270), acos(_266.z) * 0.3183098733425140380859375), level(0.0)).x);
        }
        else
        {
            float4 _198 = _Globals.WorldToStaticShadowMatrix * float4(_159, 1.0);
            float2 _202 = _198.xy / float2(_198.w);
            bool2 _203 = _202 >= float2(0.0);
            bool2 _204 = _202 <= float2(1.0);
            float _262;
            if (all(bool2(_203.x && _204.x, _203.y && _204.y)))
            {
                float2 _216 = (_202 * _Globals.StaticShadowBufferSize.xy) - float2(0.5);
                float2 _217 = fract(_216);
                float2 _218 = floor(_216);
                float4 _226 = _104;
                _226.x = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_218 + float2(0.5, 1.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _232 = _226;
                _232.y = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_218 + float2(1.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _238 = _232;
                _238.z = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_218 + float2(1.5, 0.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _243 = _238;
                _243.w = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_218 + float2(0.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _253 = fast::clamp(fast::clamp((_243 * 40.0) - float4((_198.z * 40.0) - 1.0), float4(0.0), float4(1.0)) + select(float4(0.0), float4(1.0), _243 > float4(0.9900000095367431640625)), float4(0.0), float4(1.0));
                float2 _257 = mix(_253.wx, _253.zy, _217.xx);
                _262 = mix(_257.x, _257.y, _217.y);
            }
            else
            {
                _262 = 1.0;
            }
            _286 = _262;
        }
        _287 = _286;
    }
    else
    {
        _287 = 1.0;
    }
    float4 _294 = _Globals.LightFunctionWorldToLight * float4(_159, 1.0);
    float3 _298 = _294.xyz / float3(_294.w);
    float2 _300 = _298.zy;
    float2 _331;
    if (_Globals.LightFunctionParameters.z > 0.0)
    {
        _331 = ((_300 / float2(_298.x * _Globals.LightFunctionParameters.x)) * 0.5) + float2(0.5);
    }
    else
    {
        float2 _322;
        if (_Globals.LightFunctionParameters.w > 0.0)
        {
            float3 _312 = normalize(_298.zyx);
            _322 = float2((atan2(_312.y, _312.x) + 3.1415927410125732421875) * 0.15915493667125701904296875, acos(_312.z) * 0.3183098733425140380859375);
        }
        else
        {
            _322 = _300;
        }
        _331 = _322;
    }
    spvUnsafeArray<float2, 1> _108 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _333 = 0; _333 < 1; )
    {
        _108[_333] = _331;
        _333++;
        continue;
    }
    float4 _345 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (_108[0] * 4.0));
    float _358 = _287 * dot(fast::max(mix(float4(_345.x).xyz, Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0)), float3(0.33329999446868896484375));
    float _380;
    float _381;
    if (_Globals.VolumeCascadeIndex == 1u)
    {
        float3 _372 = fast::clamp((float3(0.5) - abs(((float3(in.in_var_TEXCOORD0, _117 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w) * (1.0 + (4.0 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w))) - float3(2.0 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w)) - float3(0.5))) * 10.0, float3(0.0), float3(1.0));
        float _377 = (_372.x * _372.y) * _372.z;
        _380 = mix(0.0, _358, _377);
        _381 = mix(0.0, _180, _377);
    }
    else
    {
        _380 = _358;
        _381 = _180;
    }
    float3 _386 = ((float3(DeferredLightUniforms.DeferredLightUniforms_Color) * float3(0.3183098733425140380859375)) * _381) * _380;
    float4 _387 = _104;
    _387.x = 0.2820949852466583251953125;
    float4 _390 = _387;
    _390.y = (-0.48860299587249755859375) * _153.y;
    float4 _393 = _390;
    _393.z = 0.48860299587249755859375 * _153.z;
    float4 _396 = _393;
    _396.w = (-0.48860299587249755859375) * _153.x;
    float4 _398 = _396 * _386.x;
    float4 _400 = _396 * _386.y;
    float4 _402 = _396 * _386.z;
    out.out_var_SV_Target0 = float4(_398.x, _400.x, _402.x, 0.0) * 1.0;
    out.out_var_SV_Target1 = float4(dot(float3(_398.y, _400.y, _402.y), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), dot(float3(_398.z, _400.z, _402.z), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), dot(float3(_398.w, _400.w, _402.w), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), 0.0) * 1.0;
    return out;
}

