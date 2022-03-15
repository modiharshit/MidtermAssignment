

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
    spvUnsafeArray<float4, 2> ClippingPlanes;
};

constant float4 _100 = {};

struct InjectMainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
    float4 out_var_SV_Target1 [[color(1)]];
};

struct InjectMainPS_in
{
    float2 in_var_TEXCOORD0 [[user(locn0), center_no_perspective]];
};

fragment InjectMainPS_out Main_00003154_2071afa3(InjectMainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_DeferredLightUniforms& DeferredLightUniforms [[buffer(1)]], constant type_Globals& _Globals [[buffer(2)]], texture2d<float> View_TransmittanceLutTexture [[texture(0)]], texture2d<float> ShadowDepthTexture [[texture(1)]], texture2d<float> StaticShadowDepthTexture [[texture(2)]], texture2d<float> VolumetricCloudShadowmapTexture [[texture(3)]], sampler View_TransmittanceLutTextureSampler [[sampler(0)]], sampler ShadowDepthTextureSampler [[sampler(1)]], sampler StaticShadowDepthTextureSampler [[sampler(2)]], sampler VolumetricCloudShadowmapTextureSampler [[sampler(3)]], uint gl_Layer [[render_target_array_index]])
{
    InjectMainPS_out out = {};
    float _118 = float(gl_Layer) + 0.5;
    float _123 = View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].z + (_118 * View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].w);
    float _130 = 0.5 * View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].w;
    float2 _132 = (View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].xy + (in.in_var_TEXCOORD0 / View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].xy)) - float2(_130);
    float _133 = _132.x;
    float4 _144 = float4(_133, _132.y, _123, 1.0);
    float _146 = -dot(_Globals.ClippingPlanes[0], _144);
    float _150 = -dot(_Globals.ClippingPlanes[1], _144);
    if (_146 < 0.0)
    {
        discard_fragment();
    }
    if (_150 < 0.0)
    {
        discard_fragment();
    }
    float _165 = fast::clamp(_146 * _Globals.ShadowInjectParams.x, 0.0, 1.0) * fast::clamp(_150 * _Globals.ShadowInjectParams.y, 0.0, 1.0);
    float3 _173 = float3(_133, _132.y, _123) + float3(dot(abs(DeferredLightUniforms.DeferredLightUniforms_Direction * float3(_130)), float3(1.0)));
    float _250;
    if (_Globals.bStaticallyShadowed != 0u)
    {
        float4 _185 = _Globals.WorldToStaticShadowMatrix * float4(_173, 1.0);
        float2 _189 = _185.xy / float2(_185.w);
        bool2 _190 = _189 >= float2(0.0);
        bool2 _191 = _189 <= float2(1.0);
        float _249;
        if (all(bool2(_190.x && _191.x, _190.y && _191.y)))
        {
            float2 _203 = (_189 * _Globals.StaticShadowBufferSize.xy) - float2(0.5);
            float2 _204 = fract(_203);
            float2 _205 = floor(_203);
            float4 _213 = _100;
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
        _250 = _249;
    }
    else
    {
        _250 = 1.0;
    }
    float4 _254 = float4(_173, 1.0);
    float4 _257 = _Globals.WorldToShadowMatrix * _254;
    float2 _261 = _257.xy / float2(_257.w);
    bool2 _265 = _261 >= _Globals.ShadowmapMinMax.xy;
    bool2 _267 = _261 <= _Globals.ShadowmapMinMax.zw;
    float _283;
    if (all(bool2(_265.x && _267.x, _265.y && _267.y)))
    {
        _283 = float(_257.z < (ShadowDepthTexture.sample(ShadowDepthTextureSampler, _261, level(0.0)).x - _Globals.DepthBiasParameters.x));
    }
    else
    {
        _283 = 1.0;
    }
    float _296 = fast::clamp((dot(_173 - View.View_WorldCameraOrigin, View.View_ViewForward) * _Globals.ShadowInjectParams.z) + _Globals.ShadowInjectParams.w, 0.0, 1.0);
    float _299 = fast::min(_250, mix(_283, 1.0, _296 * _296));
    float _338;
    if (_Globals.VolumetricCloudShadowEnabled > 0u)
    {
        float4 _311 = _Globals.VolumetricCloudWorldToLightClipShadowMatrix * _254;
        float4 _313 = _311 / _311.wwww;
        float4 _319 = VolumetricCloudShadowmapTexture.sample(VolumetricCloudShadowmapTextureSampler, (float2(0.5) + (float2(0.5, -0.5) * _313.xy)), level(0.0));
        _338 = _299 * mix(1.0, fast::clamp(exp(-fast::min(_319.z, _319.y * (fast::max(0.0, (fast::clamp(1.0 - _313.z, 0.0, 1.0) * _Globals.VolumetricCloudShadowmapFarDepthKm) - _319.x) * 1000.0))), 0.0, 1.0), _Globals.VolumetricCloudShadowmapStrength);
    }
    else
    {
        _338 = _299;
    }
    float _359;
    if (_Globals.VolumeCascadeIndex == 1u)
    {
        float3 _352 = fast::clamp((float3(0.5) - abs(((float3(in.in_var_TEXCOORD0, _118 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w) * (1.0 + (4.0 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w))) - float3(2.0 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w)) - float3(0.5))) * 10.0, float3(0.0), float3(1.0));
        _359 = mix(1.0, _338, (_352.x * _352.y) * _352.z);
    }
    else
    {
        _359 = _338;
    }
    float3 _364 = ((DeferredLightUniforms.DeferredLightUniforms_Color * float3(0.3183098733425140380859375)) * 1.0) * _359;
    float3 _448;
    if (_Globals.AtmospherePerPixelTransmittanceEnabled > 0u)
    {
        float3 _374 = (_173 - View.View_SkyPlanetCenterAndViewHeight.xyz) * 9.9999997473787516355514526367188e-06;
        float3 _446;
        switch (0u)
        {
            default:
            {
                float3 _385 = _374 - float4(0.0, 0.0, 0.0, View.View_SkyAtmosphereBottomRadiusKm).xyz;
                float _387 = dot(DeferredLightUniforms.DeferredLightUniforms_Direction, DeferredLightUniforms.DeferredLightUniforms_Direction);
                float _388 = dot(DeferredLightUniforms.DeferredLightUniforms_Direction, _385);
                float _389 = 2.0 * _388;
                float _390 = View.View_SkyAtmosphereBottomRadiusKm * View.View_SkyAtmosphereBottomRadiusKm;
                float _395 = (_389 * _389) - ((4.0 * _387) * (dot(_385, _385) - _390));
                float2 _407;
                if (_395 >= 0.0)
                {
                    _407 = (float2(_388 * (-2.0)) + (float2(-1.0, 1.0) * sqrt(_395))) / float2(2.0 * _387);
                }
                else
                {
                    _407 = float2(-1.0);
                }
                if ((_407.x > 0.0) || (_407.y > 0.0))
                {
                    _446 = float3(0.0);
                    break;
                }
                float _415 = length(_374);
                float _418 = dot(DeferredLightUniforms.DeferredLightUniforms_Direction, _374 / float3(_415));
                float _419 = View.View_SkyAtmosphereTopRadiusKm * View.View_SkyAtmosphereTopRadiusKm;
                float _422 = sqrt(fast::max(0.0, _419 - _390));
                float _423 = _415 * _415;
                float _426 = sqrt(fast::max(0.0, _423 - _390));
                float _436 = View.View_SkyAtmosphereTopRadiusKm - _415;
                _446 = View_TransmittanceLutTexture.sample(View_TransmittanceLutTextureSampler, float2((fast::max(0.0, ((-_415) * _418) + sqrt((_423 * ((_418 * _418) - 1.0)) + _419)) - _436) / ((_426 + _422) - _436), _426 / _422), level(0.0)).xyz;
                break;
            }
        }
        _448 = _364 * _446;
    }
    else
    {
        _448 = _364;
    }
    float4 _449 = _100;
    _449.x = 0.2820949852466583251953125;
    float4 _452 = _449;
    _452.y = (-0.48860299587249755859375) * DeferredLightUniforms.DeferredLightUniforms_Direction.y;
    float4 _455 = _452;
    _455.z = 0.48860299587249755859375 * DeferredLightUniforms.DeferredLightUniforms_Direction.z;
    float4 _458 = _455;
    _458.w = (-0.48860299587249755859375) * DeferredLightUniforms.DeferredLightUniforms_Direction.x;
    float4 _460 = _458 * _448.x;
    float4 _462 = _458 * _448.y;
    float4 _464 = _458 * _448.z;
    out.out_var_SV_Target0 = float4(_460.x, _462.x, _464.x, _359) * _165;
    out.out_var_SV_Target1 = float4(dot(float3(_460.y, _462.y, _464.y), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), dot(float3(_460.z, _462.z, _464.z), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), dot(float3(_460.w, _462.w, _464.w), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), 0.0) * _165;
    return out;
}

