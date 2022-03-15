

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

fragment InjectMainPS_out Main_00002932_0e9537b3(InjectMainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_DeferredLightUniforms& DeferredLightUniforms [[buffer(1)]], constant type_Material& Material [[buffer(2)]], constant type_Globals& _Globals [[buffer(3)]], texture2d<float> Material_Texture2D_0 [[texture(0)]], texture2d<float> StaticShadowDepthTexture [[texture(1)]], sampler Material_Texture2D_0Sampler [[sampler(0)]], sampler StaticShadowDepthTextureSampler [[sampler(1)]], uint gl_Layer [[render_target_array_index]])
{
    InjectMainPS_out out = {};
    float _116 = float(gl_Layer) + 0.5;
    float _128 = 0.5 * View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].w;
    float3 _133 = float3((View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].xy + (in.in_var_TEXCOORD0 / View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].xy)) - float2(_128), View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].z + (_116 * View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].w));
    float3 _142 = float3(DeferredLightUniforms.DeferredLightUniforms_Position) - _133;
    if (((1.0 / (DeferredLightUniforms.DeferredLightUniforms_InvRadius * DeferredLightUniforms.DeferredLightUniforms_InvRadius)) - dot(_142, _142)) < 0.0)
    {
        discard_fragment();
    }
    float3 _152 = normalize(_142);
    float3 _158 = _133 + float3(dot(abs(_152 * float3(_128)), float3(1.0)));
    float3 _159 = float3(DeferredLightUniforms.DeferredLightUniforms_Position) - _158;
    float _160 = dot(_159, _159);
    float _164 = (_160 * DeferredLightUniforms.DeferredLightUniforms_InvRadius) * DeferredLightUniforms.DeferredLightUniforms_InvRadius;
    float _167 = fast::clamp(1.0 - (_164 * _164), 0.0, 1.0);
    float _180 = fast::clamp((dot(normalize(_159), DeferredLightUniforms.DeferredLightUniforms_Direction) - DeferredLightUniforms.DeferredLightUniforms_SpotAngles.x) * DeferredLightUniforms.DeferredLightUniforms_SpotAngles.y, 0.0, 1.0);
    float _182 = (_180 * _180) * ((1.0 / (_160 + 1.0)) * (_167 * _167));
    float _289;
    if (_Globals.bStaticallyShadowed != 0u)
    {
        float _288;
        if (_Globals.SpotlightMask < 1.0)
        {
            float3 _265 = _158 - float3(DeferredLightUniforms.DeferredLightUniforms_Position);
            float _266 = length(_265);
            float3 _268 = _265 / float3(_266);
            float _272 = atan2(_268.y, _268.x) * 0.15915493667125701904296875;
            _288 = float((_266 * DeferredLightUniforms.DeferredLightUniforms_InvRadius) < StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, float2((_272 > 0.0) ? _272 : (1.0 + _272), acos(_268.z) * 0.3183098733425140380859375), level(0.0)).x);
        }
        else
        {
            float4 _200 = _Globals.WorldToStaticShadowMatrix * float4(_158, 1.0);
            float2 _204 = _200.xy / float2(_200.w);
            bool2 _205 = _204 >= float2(0.0);
            bool2 _206 = _204 <= float2(1.0);
            float _264;
            if (all(bool2(_205.x && _206.x, _205.y && _206.y)))
            {
                float2 _218 = (_204 * _Globals.StaticShadowBufferSize.xy) - float2(0.5);
                float2 _219 = fract(_218);
                float2 _220 = floor(_218);
                float4 _228 = _104;
                _228.x = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_220 + float2(0.5, 1.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _234 = _228;
                _234.y = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_220 + float2(1.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _240 = _234;
                _240.z = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_220 + float2(1.5, 0.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _245 = _240;
                _245.w = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_220 + float2(0.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _255 = fast::clamp(fast::clamp((_245 * 40.0) - float4((_200.z * 40.0) - 1.0), float4(0.0), float4(1.0)) + select(float4(0.0), float4(1.0), _245 > float4(0.9900000095367431640625)), float4(0.0), float4(1.0));
                float2 _259 = mix(_255.wx, _255.zy, _219.xx);
                _264 = mix(_259.x, _259.y, _219.y);
            }
            else
            {
                _264 = 1.0;
            }
            _288 = _264;
        }
        _289 = _288;
    }
    else
    {
        _289 = 1.0;
    }
    float4 _296 = _Globals.LightFunctionWorldToLight * float4(_158, 1.0);
    float3 _300 = _296.xyz / float3(_296.w);
    float2 _302 = _300.zy;
    float2 _333;
    if (_Globals.LightFunctionParameters.z > 0.0)
    {
        _333 = ((_302 / float2(_300.x * _Globals.LightFunctionParameters.x)) * 0.5) + float2(0.5);
    }
    else
    {
        float2 _324;
        if (_Globals.LightFunctionParameters.w > 0.0)
        {
            float3 _314 = normalize(_300.zyx);
            _324 = float2((atan2(_314.y, _314.x) + 3.1415927410125732421875) * 0.15915493667125701904296875, acos(_314.z) * 0.3183098733425140380859375);
        }
        else
        {
            _324 = _302;
        }
        _333 = _324;
    }
    spvUnsafeArray<float2, 1> _107 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _335 = 0; _335 < 1; )
    {
        _107[_335] = _333;
        _335++;
        continue;
    }
    float4 _347 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (_107[0] * 4.0));
    float _360 = _289 * dot(fast::max(mix(float4(_347.x).xyz, Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0)), float3(0.33329999446868896484375));
    float _382;
    float _383;
    if (_Globals.VolumeCascadeIndex == 1u)
    {
        float3 _374 = fast::clamp((float3(0.5) - abs(((float3(in.in_var_TEXCOORD0, _116 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w) * (1.0 + (4.0 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w))) - float3(2.0 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w)) - float3(0.5))) * 10.0, float3(0.0), float3(1.0));
        float _379 = (_374.x * _374.y) * _374.z;
        _382 = mix(0.0, _360, _379);
        _383 = mix(0.0, _182, _379);
    }
    else
    {
        _382 = _360;
        _383 = _182;
    }
    float3 _388 = ((DeferredLightUniforms.DeferredLightUniforms_Color * float3(0.3183098733425140380859375)) * _383) * _382;
    float4 _389 = _104;
    _389.x = 0.2820949852466583251953125;
    float4 _392 = _389;
    _392.y = (-0.48860299587249755859375) * _152.y;
    float4 _395 = _392;
    _395.z = 0.48860299587249755859375 * _152.z;
    float4 _398 = _395;
    _398.w = (-0.48860299587249755859375) * _152.x;
    float4 _400 = _398 * _388.x;
    float4 _402 = _398 * _388.y;
    float4 _404 = _398 * _388.z;
    out.out_var_SV_Target0 = float4(_400.x, _402.x, _404.x, 0.0) * 1.0;
    out.out_var_SV_Target1 = float4(dot(float3(_400.y, _402.y, _404.y), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), dot(float3(_400.z, _402.z, _404.z), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), dot(float3(_400.w, _402.w, _404.w), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), 0.0) * 1.0;
    return out;
}

