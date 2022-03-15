

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
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
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

constant float4 _108 = {};

struct InjectMainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
    float4 out_var_SV_Target1 [[color(1)]];
};

struct InjectMainPS_in
{
    float2 in_var_TEXCOORD0 [[user(locn0), center_no_perspective]];
};

fragment InjectMainPS_out Main_00002e4e_741deb3a(InjectMainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_DeferredLightUniforms& DeferredLightUniforms [[buffer(1)]], constant type_Material& Material [[buffer(2)]], constant type_Globals& _Globals [[buffer(3)]], texture2d<float> View_TransmittanceLutTexture [[texture(0)]], texture2d<float> StaticShadowDepthTexture [[texture(1)]], texture2d<float> VolumetricCloudShadowmapTexture [[texture(2)]], sampler View_TransmittanceLutTextureSampler [[sampler(0)]], sampler StaticShadowDepthTextureSampler [[sampler(1)]], sampler VolumetricCloudShadowmapTextureSampler [[sampler(2)]], uint gl_Layer [[render_target_array_index]])
{
    InjectMainPS_out out = {};
    float _120 = float(gl_Layer) + 0.5;
    float _125 = View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].z + (_120 * View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].w);
    float _132 = 0.5 * View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].w;
    float2 _134 = (View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].xy + (in.in_var_TEXCOORD0 / View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].xy)) - float2(_132);
    float _135 = _134.x;
    float4 _146 = float4(_135, _134.y, _125, 1.0);
    float _148 = -dot(_Globals.ClippingPlanes[0], _146);
    float _152 = -dot(_Globals.ClippingPlanes[1], _146);
    if (_148 < 0.0)
    {
        discard_fragment();
    }
    if (_152 < 0.0)
    {
        discard_fragment();
    }
    float _167 = fast::clamp(_148 * _Globals.ShadowInjectParams.x, 0.0, 1.0) * fast::clamp(_152 * _Globals.ShadowInjectParams.y, 0.0, 1.0);
    float3 _175 = float3(_135, _134.y, _125) + float3(dot(abs(DeferredLightUniforms.DeferredLightUniforms_Direction * float3(_132)), float3(1.0)));
    float _252;
    if (_Globals.bStaticallyShadowed != 0u)
    {
        float4 _187 = _Globals.WorldToStaticShadowMatrix * float4(_175, 1.0);
        float2 _191 = _187.xy / float2(_187.w);
        bool2 _192 = _191 >= float2(0.0);
        bool2 _193 = _191 <= float2(1.0);
        float _251;
        if (all(bool2(_192.x && _193.x, _192.y && _193.y)))
        {
            float2 _205 = (_191 * _Globals.StaticShadowBufferSize.xy) - float2(0.5);
            float2 _206 = fract(_205);
            float2 _207 = floor(_205);
            float4 _215 = _108;
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
        _252 = _251;
    }
    else
    {
        _252 = 1.0;
    }
    float _262 = _252 * dot(fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0)), float3(0.33329999446868896484375));
    float _305;
    if (_Globals.VolumetricCloudShadowEnabled > 0u)
    {
        float4 _278 = _Globals.VolumetricCloudWorldToLightClipShadowMatrix * float4(_175, 1.0);
        float4 _280 = _278 / _278.wwww;
        float4 _286 = VolumetricCloudShadowmapTexture.sample(VolumetricCloudShadowmapTextureSampler, (float2(0.5) + (float2(0.5, -0.5) * _280.xy)), level(0.0));
        _305 = _262 * mix(1.0, fast::clamp(exp(-fast::min(_286.z, _286.y * (fast::max(0.0, (fast::clamp(1.0 - _280.z, 0.0, 1.0) * _Globals.VolumetricCloudShadowmapFarDepthKm) - _286.x) * 1000.0))), 0.0, 1.0), _Globals.VolumetricCloudShadowmapStrength);
    }
    else
    {
        _305 = _262;
    }
    float _326;
    if (_Globals.VolumeCascadeIndex == 1u)
    {
        float3 _319 = fast::clamp((float3(0.5) - abs(((float3(in.in_var_TEXCOORD0, _120 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w) * (1.0 + (4.0 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w))) - float3(2.0 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w)) - float3(0.5))) * 10.0, float3(0.0), float3(1.0));
        _326 = mix(1.0, _305, (_319.x * _319.y) * _319.z);
    }
    else
    {
        _326 = _305;
    }
    float3 _331 = ((DeferredLightUniforms.DeferredLightUniforms_Color * float3(0.3183098733425140380859375)) * 1.0) * _326;
    float3 _415;
    if (_Globals.AtmospherePerPixelTransmittanceEnabled > 0u)
    {
        float3 _341 = (_175 - View.View_SkyPlanetCenterAndViewHeight.xyz) * 9.9999997473787516355514526367188e-06;
        float3 _413;
        switch (0u)
        {
            default:
            {
                float3 _352 = _341 - float4(0.0, 0.0, 0.0, View.View_SkyAtmosphereBottomRadiusKm).xyz;
                float _354 = dot(DeferredLightUniforms.DeferredLightUniforms_Direction, DeferredLightUniforms.DeferredLightUniforms_Direction);
                float _355 = dot(DeferredLightUniforms.DeferredLightUniforms_Direction, _352);
                float _356 = 2.0 * _355;
                float _357 = View.View_SkyAtmosphereBottomRadiusKm * View.View_SkyAtmosphereBottomRadiusKm;
                float _362 = (_356 * _356) - ((4.0 * _354) * (dot(_352, _352) - _357));
                float2 _374;
                if (_362 >= 0.0)
                {
                    _374 = (float2(_355 * (-2.0)) + (float2(-1.0, 1.0) * sqrt(_362))) / float2(2.0 * _354);
                }
                else
                {
                    _374 = float2(-1.0);
                }
                if ((_374.x > 0.0) || (_374.y > 0.0))
                {
                    _413 = float3(0.0);
                    break;
                }
                float _382 = length(_341);
                float _385 = dot(DeferredLightUniforms.DeferredLightUniforms_Direction, _341 / float3(_382));
                float _386 = View.View_SkyAtmosphereTopRadiusKm * View.View_SkyAtmosphereTopRadiusKm;
                float _389 = sqrt(fast::max(0.0, _386 - _357));
                float _390 = _382 * _382;
                float _393 = sqrt(fast::max(0.0, _390 - _357));
                float _403 = View.View_SkyAtmosphereTopRadiusKm - _382;
                _413 = View_TransmittanceLutTexture.sample(View_TransmittanceLutTextureSampler, float2((fast::max(0.0, ((-_382) * _385) + sqrt((_390 * ((_385 * _385) - 1.0)) + _386)) - _403) / ((_393 + _389) - _403), _393 / _389), level(0.0)).xyz;
                break;
            }
        }
        _415 = _331 * _413;
    }
    else
    {
        _415 = _331;
    }
    float4 _416 = _108;
    _416.x = 0.2820949852466583251953125;
    float4 _419 = _416;
    _419.y = (-0.48860299587249755859375) * DeferredLightUniforms.DeferredLightUniforms_Direction.y;
    float4 _422 = _419;
    _422.z = 0.48860299587249755859375 * DeferredLightUniforms.DeferredLightUniforms_Direction.z;
    float4 _425 = _422;
    _425.w = (-0.48860299587249755859375) * DeferredLightUniforms.DeferredLightUniforms_Direction.x;
    float4 _427 = _425 * _415.x;
    float4 _429 = _425 * _415.y;
    float4 _431 = _425 * _415.z;
    out.out_var_SV_Target0 = float4(_427.x, _429.x, _431.x, _326) * _167;
    out.out_var_SV_Target1 = float4(dot(float3(_427.y, _429.y, _431.y), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), dot(float3(_427.z, _429.z, _431.z), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), dot(float3(_427.w, _429.w, _431.w), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), 0.0) * _167;
    return out;
}

