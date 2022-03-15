

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
    char _m4_pad[336];
    float4 View_SkyPlanetCenterAndViewHeight;
    char _m5_pad[88];
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
    char _m0_pad[400];
    float4x4 WorldToShadowMatrix;
    float4 ShadowmapMinMax;
    float4 ShadowInjectParams;
    float4 DepthBiasParameters;
    uint bStaticallyShadowed;
    float4x4 WorldToStaticShadowMatrix;
    float4 StaticShadowBufferSize;
    uint VolumeCascadeIndex;
    float4x4 VolumetricCloudWorldToLightClipShadowMatrix;
    float VolumetricCloudShadowmapFarDepthKm;
    uint VolumetricCloudShadowEnabled;
    float VolumetricCloudShadowmapStrength;
    uint AtmospherePerPixelTransmittanceEnabled;
    char _m13_pad[80];
    spvUnsafeArray<float4, 2> ClippingPlanes;
};

constant float4 _107 = {};

struct InjectMainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
    float4 out_var_SV_Target1 [[color(1)]];
};

struct InjectMainPS_in
{
    float2 in_var_TEXCOORD0 [[user(locn0), center_no_perspective]];
};

fragment InjectMainPS_out Main_00003313_449ab47d(InjectMainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_DeferredLightUniforms& DeferredLightUniforms [[buffer(1)]], constant type_Material& Material [[buffer(2)]], constant type_Globals& _Globals [[buffer(3)]], texture2d<float> View_TransmittanceLutTexture [[texture(0)]], texture2d<float> ShadowDepthTexture [[texture(1)]], texture2d<float> StaticShadowDepthTexture [[texture(2)]], texture2d<float> VolumetricCloudShadowmapTexture [[texture(3)]], sampler View_TransmittanceLutTextureSampler [[sampler(0)]], sampler ShadowDepthTextureSampler [[sampler(1)]], sampler StaticShadowDepthTextureSampler [[sampler(2)]], sampler VolumetricCloudShadowmapTextureSampler [[sampler(3)]], uint gl_Layer [[render_target_array_index]])
{
    InjectMainPS_out out = {};
    float _125 = float(gl_Layer) + 0.5;
    float _130 = View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].z + (_125 * View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].w);
    float _137 = 0.5 * View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].w;
    float2 _139 = (View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].xy + (in.in_var_TEXCOORD0 / View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].xy)) - float2(_137);
    float _140 = _139.x;
    float4 _151 = float4(_140, _139.y, _130, 1.0);
    float _153 = -dot(_Globals.ClippingPlanes[0], _151);
    float _157 = -dot(_Globals.ClippingPlanes[1], _151);
    if (_153 < 0.0)
    {
        discard_fragment();
    }
    if (_157 < 0.0)
    {
        discard_fragment();
    }
    float _172 = fast::clamp(_153 * _Globals.ShadowInjectParams.x, 0.0, 1.0) * fast::clamp(_157 * _Globals.ShadowInjectParams.y, 0.0, 1.0);
    float3 _180 = float3(_140, _139.y, _130) + float3(dot(abs(DeferredLightUniforms.DeferredLightUniforms_Direction * float3(_137)), float3(1.0)));
    float _257;
    if (_Globals.bStaticallyShadowed != 0u)
    {
        float4 _192 = _Globals.WorldToStaticShadowMatrix * float4(_180, 1.0);
        float2 _196 = _192.xy / float2(_192.w);
        bool2 _197 = _196 >= float2(0.0);
        bool2 _198 = _196 <= float2(1.0);
        float _256;
        if (all(bool2(_197.x && _198.x, _197.y && _198.y)))
        {
            float2 _210 = (_196 * _Globals.StaticShadowBufferSize.xy) - float2(0.5);
            float2 _211 = fract(_210);
            float2 _212 = floor(_210);
            float4 _220 = _107;
            _220.x = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_212 + float2(0.5, 1.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
            float4 _226 = _220;
            _226.y = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_212 + float2(1.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
            float4 _232 = _226;
            _232.z = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_212 + float2(1.5, 0.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
            float4 _237 = _232;
            _237.w = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_212 + float2(0.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
            float4 _247 = fast::clamp(fast::clamp((_237 * 40.0) - float4((_192.z * 40.0) - 1.0), float4(0.0), float4(1.0)) + select(float4(0.0), float4(1.0), _237 > float4(0.9900000095367431640625)), float4(0.0), float4(1.0));
            float2 _251 = mix(_247.wx, _247.zy, _211.xx);
            _256 = mix(_251.x, _251.y, _211.y);
        }
        else
        {
            _256 = 1.0;
        }
        _257 = _256;
    }
    else
    {
        _257 = 1.0;
    }
    float4 _261 = float4(_180, 1.0);
    float4 _264 = _Globals.WorldToShadowMatrix * _261;
    float2 _268 = _264.xy / float2(_264.w);
    bool2 _272 = _268 >= _Globals.ShadowmapMinMax.xy;
    bool2 _274 = _268 <= _Globals.ShadowmapMinMax.zw;
    float _290;
    if (all(bool2(_272.x && _274.x, _272.y && _274.y)))
    {
        _290 = float(_264.z < (ShadowDepthTexture.sample(ShadowDepthTextureSampler, _268, level(0.0)).x - _Globals.DepthBiasParameters.x));
    }
    else
    {
        _290 = 1.0;
    }
    float _303 = fast::clamp((dot(_180 - View.View_WorldCameraOrigin, View.View_ViewForward) * _Globals.ShadowInjectParams.z) + _Globals.ShadowInjectParams.w, 0.0, 1.0);
    float _319 = fast::min(_257, mix(_290, 1.0, _303 * _303)) * dot(fast::max(mix(Material.Material_VectorExpressions[2].xyz, Material.Material_VectorExpressions[3].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0)), float3(0.33329999446868896484375));
    float _358;
    if (_Globals.VolumetricCloudShadowEnabled > 0u)
    {
        float4 _331 = _Globals.VolumetricCloudWorldToLightClipShadowMatrix * _261;
        float4 _333 = _331 / _331.wwww;
        float4 _339 = VolumetricCloudShadowmapTexture.sample(VolumetricCloudShadowmapTextureSampler, (float2(0.5) + (float2(0.5, -0.5) * _333.xy)), level(0.0));
        _358 = _319 * mix(1.0, fast::clamp(exp(-fast::min(_339.z, _339.y * (fast::max(0.0, (fast::clamp(1.0 - _333.z, 0.0, 1.0) * _Globals.VolumetricCloudShadowmapFarDepthKm) - _339.x) * 1000.0))), 0.0, 1.0), _Globals.VolumetricCloudShadowmapStrength);
    }
    else
    {
        _358 = _319;
    }
    float _379;
    if (_Globals.VolumeCascadeIndex == 1u)
    {
        float3 _372 = fast::clamp((float3(0.5) - abs(((float3(in.in_var_TEXCOORD0, _125 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w) * (1.0 + (4.0 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w))) - float3(2.0 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w)) - float3(0.5))) * 10.0, float3(0.0), float3(1.0));
        _379 = mix(1.0, _358, (_372.x * _372.y) * _372.z);
    }
    else
    {
        _379 = _358;
    }
    float3 _384 = ((DeferredLightUniforms.DeferredLightUniforms_Color * float3(0.3183098733425140380859375)) * 1.0) * _379;
    float3 _468;
    if (_Globals.AtmospherePerPixelTransmittanceEnabled > 0u)
    {
        float3 _394 = (_180 - View.View_SkyPlanetCenterAndViewHeight.xyz) * 9.9999997473787516355514526367188e-06;
        float3 _466;
        switch (0u)
        {
            default:
            {
                float3 _405 = _394 - float4(0.0, 0.0, 0.0, View.View_SkyAtmosphereBottomRadiusKm).xyz;
                float _407 = dot(DeferredLightUniforms.DeferredLightUniforms_Direction, DeferredLightUniforms.DeferredLightUniforms_Direction);
                float _408 = dot(DeferredLightUniforms.DeferredLightUniforms_Direction, _405);
                float _409 = 2.0 * _408;
                float _410 = View.View_SkyAtmosphereBottomRadiusKm * View.View_SkyAtmosphereBottomRadiusKm;
                float _415 = (_409 * _409) - ((4.0 * _407) * (dot(_405, _405) - _410));
                float2 _427;
                if (_415 >= 0.0)
                {
                    _427 = (float2(_408 * (-2.0)) + (float2(-1.0, 1.0) * sqrt(_415))) / float2(2.0 * _407);
                }
                else
                {
                    _427 = float2(-1.0);
                }
                if ((_427.x > 0.0) || (_427.y > 0.0))
                {
                    _466 = float3(0.0);
                    break;
                }
                float _435 = length(_394);
                float _438 = dot(DeferredLightUniforms.DeferredLightUniforms_Direction, _394 / float3(_435));
                float _439 = View.View_SkyAtmosphereTopRadiusKm * View.View_SkyAtmosphereTopRadiusKm;
                float _442 = sqrt(fast::max(0.0, _439 - _410));
                float _443 = _435 * _435;
                float _446 = sqrt(fast::max(0.0, _443 - _410));
                float _456 = View.View_SkyAtmosphereTopRadiusKm - _435;
                _466 = View_TransmittanceLutTexture.sample(View_TransmittanceLutTextureSampler, float2((fast::max(0.0, ((-_435) * _438) + sqrt((_443 * ((_438 * _438) - 1.0)) + _439)) - _456) / ((_446 + _442) - _456), _446 / _442), level(0.0)).xyz;
                break;
            }
        }
        _468 = _384 * _466;
    }
    else
    {
        _468 = _384;
    }
    float4 _469 = _107;
    _469.x = 0.2820949852466583251953125;
    float4 _472 = _469;
    _472.y = (-0.48860299587249755859375) * DeferredLightUniforms.DeferredLightUniforms_Direction.y;
    float4 _475 = _472;
    _475.z = 0.48860299587249755859375 * DeferredLightUniforms.DeferredLightUniforms_Direction.z;
    float4 _478 = _475;
    _478.w = (-0.48860299587249755859375) * DeferredLightUniforms.DeferredLightUniforms_Direction.x;
    float4 _480 = _478 * _468.x;
    float4 _482 = _478 * _468.y;
    float4 _484 = _478 * _468.z;
    out.out_var_SV_Target0 = float4(_480.x, _482.x, _484.x, _379) * _172;
    out.out_var_SV_Target1 = float4(dot(float3(_480.y, _482.y, _484.y), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), dot(float3(_480.z, _482.z, _484.z), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), dot(float3(_480.w, _482.w, _484.w), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), 0.0) * _172;
    return out;
}

