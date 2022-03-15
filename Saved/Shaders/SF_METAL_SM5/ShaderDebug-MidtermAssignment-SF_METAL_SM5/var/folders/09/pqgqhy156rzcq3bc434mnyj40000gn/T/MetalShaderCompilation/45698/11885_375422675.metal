

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
    char _m2_pad[336];
    float4 View_SkyPlanetCenterAndViewHeight;
    char _m3_pad[88];
    float View_SkyAtmosphereBottomRadiusKm;
    float View_SkyAtmosphereTopRadiusKm;
};

struct type_DeferredLightUniforms
{
    char _m0_pad[64];
    float3 DeferredLightUniforms_Color;
    float3 DeferredLightUniforms_Direction;
};

struct type_Material
{
    spvUnsafeArray<float4, 4> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

struct type_Globals
{
    float4 ShadowInjectParams;
    uint bStaticallyShadowed;
    float4x4 WorldToStaticShadowMatrix;
    float4 StaticShadowBufferSize;
    uint VolumeCascadeIndex;
    float4x4 VolumetricCloudWorldToLightClipShadowMatrix;
    float VolumetricCloudShadowmapFarDepthKm;
    uint VolumetricCloudShadowEnabled;
    float VolumetricCloudShadowmapStrength;
    uint AtmospherePerPixelTransmittanceEnabled;
    char _m10_pad[80];
    spvUnsafeArray<float4, 2> ClippingPlanes;
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

fragment InjectMainPS_out Main_00002e6d_16607ed3(InjectMainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_DeferredLightUniforms& DeferredLightUniforms [[buffer(1)]], constant type_Material& Material [[buffer(2)]], constant type_Globals& _Globals [[buffer(3)]], texture2d<float> View_TransmittanceLutTexture [[texture(0)]], texture2d<float> StaticShadowDepthTexture [[texture(1)]], texture2d<float> VolumetricCloudShadowmapTexture [[texture(2)]], sampler View_TransmittanceLutTextureSampler [[sampler(0)]], sampler StaticShadowDepthTextureSampler [[sampler(1)]], sampler VolumetricCloudShadowmapTextureSampler [[sampler(2)]], uint gl_Layer [[render_target_array_index]])
{
    InjectMainPS_out out = {};
    float _121 = float(gl_Layer) + 0.5;
    float _126 = View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].z + (_121 * View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].w);
    float _133 = 0.5 * View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].w;
    float2 _135 = (View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].xy + (in.in_var_TEXCOORD0 / View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].xy)) - float2(_133);
    float _136 = _135.x;
    float4 _147 = float4(_136, _135.y, _126, 1.0);
    float _149 = -dot(_Globals.ClippingPlanes[0], _147);
    float _153 = -dot(_Globals.ClippingPlanes[1], _147);
    if (_149 < 0.0)
    {
        discard_fragment();
    }
    if (_153 < 0.0)
    {
        discard_fragment();
    }
    float _168 = fast::clamp(_149 * _Globals.ShadowInjectParams.x, 0.0, 1.0) * fast::clamp(_153 * _Globals.ShadowInjectParams.y, 0.0, 1.0);
    float3 _176 = float3(_136, _135.y, _126) + float3(dot(abs(DeferredLightUniforms.DeferredLightUniforms_Direction * float3(_133)), float3(1.0)));
    float _253;
    if (_Globals.bStaticallyShadowed != 0u)
    {
        float4 _188 = _Globals.WorldToStaticShadowMatrix * float4(_176, 1.0);
        float2 _192 = _188.xy / float2(_188.w);
        bool2 _193 = _192 >= float2(0.0);
        bool2 _194 = _192 <= float2(1.0);
        float _252;
        if (all(bool2(_193.x && _194.x, _193.y && _194.y)))
        {
            float2 _206 = (_192 * _Globals.StaticShadowBufferSize.xy) - float2(0.5);
            float2 _207 = fract(_206);
            float2 _208 = floor(_206);
            float4 _216 = _109;
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
        _253 = _252;
    }
    else
    {
        _253 = 1.0;
    }
    float _266 = _253 * dot(fast::max(mix(Material.Material_VectorExpressions[2].xyz, Material.Material_VectorExpressions[3].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0)), float3(0.33329999446868896484375));
    float _309;
    if (_Globals.VolumetricCloudShadowEnabled > 0u)
    {
        float4 _282 = _Globals.VolumetricCloudWorldToLightClipShadowMatrix * float4(_176, 1.0);
        float4 _284 = _282 / _282.wwww;
        float4 _290 = VolumetricCloudShadowmapTexture.sample(VolumetricCloudShadowmapTextureSampler, (float2(0.5) + (float2(0.5, -0.5) * _284.xy)), level(0.0));
        _309 = _266 * mix(1.0, fast::clamp(exp(-fast::min(_290.z, _290.y * (fast::max(0.0, (fast::clamp(1.0 - _284.z, 0.0, 1.0) * _Globals.VolumetricCloudShadowmapFarDepthKm) - _290.x) * 1000.0))), 0.0, 1.0), _Globals.VolumetricCloudShadowmapStrength);
    }
    else
    {
        _309 = _266;
    }
    float _330;
    if (_Globals.VolumeCascadeIndex == 1u)
    {
        float3 _323 = fast::clamp((float3(0.5) - abs(((float3(in.in_var_TEXCOORD0, _121 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w) * (1.0 + (4.0 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w))) - float3(2.0 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w)) - float3(0.5))) * 10.0, float3(0.0), float3(1.0));
        _330 = mix(1.0, _309, (_323.x * _323.y) * _323.z);
    }
    else
    {
        _330 = _309;
    }
    float3 _335 = ((DeferredLightUniforms.DeferredLightUniforms_Color * float3(0.3183098733425140380859375)) * 1.0) * _330;
    float3 _419;
    if (_Globals.AtmospherePerPixelTransmittanceEnabled > 0u)
    {
        float3 _345 = (_176 - View.View_SkyPlanetCenterAndViewHeight.xyz) * 9.9999997473787516355514526367188e-06;
        float3 _417;
        switch (0u)
        {
            default:
            {
                float3 _356 = _345 - float4(0.0, 0.0, 0.0, View.View_SkyAtmosphereBottomRadiusKm).xyz;
                float _358 = dot(DeferredLightUniforms.DeferredLightUniforms_Direction, DeferredLightUniforms.DeferredLightUniforms_Direction);
                float _359 = dot(DeferredLightUniforms.DeferredLightUniforms_Direction, _356);
                float _360 = 2.0 * _359;
                float _361 = View.View_SkyAtmosphereBottomRadiusKm * View.View_SkyAtmosphereBottomRadiusKm;
                float _366 = (_360 * _360) - ((4.0 * _358) * (dot(_356, _356) - _361));
                float2 _378;
                if (_366 >= 0.0)
                {
                    _378 = (float2(_359 * (-2.0)) + (float2(-1.0, 1.0) * sqrt(_366))) / float2(2.0 * _358);
                }
                else
                {
                    _378 = float2(-1.0);
                }
                if ((_378.x > 0.0) || (_378.y > 0.0))
                {
                    _417 = float3(0.0);
                    break;
                }
                float _386 = length(_345);
                float _389 = dot(DeferredLightUniforms.DeferredLightUniforms_Direction, _345 / float3(_386));
                float _390 = View.View_SkyAtmosphereTopRadiusKm * View.View_SkyAtmosphereTopRadiusKm;
                float _393 = sqrt(fast::max(0.0, _390 - _361));
                float _394 = _386 * _386;
                float _397 = sqrt(fast::max(0.0, _394 - _361));
                float _407 = View.View_SkyAtmosphereTopRadiusKm - _386;
                _417 = View_TransmittanceLutTexture.sample(View_TransmittanceLutTextureSampler, float2((fast::max(0.0, ((-_386) * _389) + sqrt((_394 * ((_389 * _389) - 1.0)) + _390)) - _407) / ((_397 + _393) - _407), _397 / _393), level(0.0)).xyz;
                break;
            }
        }
        _419 = _335 * _417;
    }
    else
    {
        _419 = _335;
    }
    float4 _420 = _109;
    _420.x = 0.2820949852466583251953125;
    float4 _423 = _420;
    _423.y = (-0.48860299587249755859375) * DeferredLightUniforms.DeferredLightUniforms_Direction.y;
    float4 _426 = _423;
    _426.z = 0.48860299587249755859375 * DeferredLightUniforms.DeferredLightUniforms_Direction.z;
    float4 _429 = _426;
    _429.w = (-0.48860299587249755859375) * DeferredLightUniforms.DeferredLightUniforms_Direction.x;
    float4 _431 = _429 * _419.x;
    float4 _433 = _429 * _419.y;
    float4 _435 = _429 * _419.z;
    out.out_var_SV_Target0 = float4(_431.x, _433.x, _435.x, _330) * _168;
    out.out_var_SV_Target1 = float4(dot(float3(_431.y, _433.y, _435.y), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), dot(float3(_431.z, _433.z, _435.z), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), dot(float3(_431.w, _433.w, _435.w), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), 0.0) * _168;
    return out;
}

