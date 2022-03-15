

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
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
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

constant float4 _106 = {};

struct InjectMainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
    float4 out_var_SV_Target1 [[color(1)]];
};

struct InjectMainPS_in
{
    float2 in_var_TEXCOORD0 [[user(locn0), center_no_perspective]];
};

fragment InjectMainPS_out Main_000032f4_fc3d22f5(InjectMainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_DeferredLightUniforms& DeferredLightUniforms [[buffer(1)]], constant type_Material& Material [[buffer(2)]], constant type_Globals& _Globals [[buffer(3)]], texture2d<float> View_TransmittanceLutTexture [[texture(0)]], texture2d<float> ShadowDepthTexture [[texture(1)]], texture2d<float> StaticShadowDepthTexture [[texture(2)]], texture2d<float> VolumetricCloudShadowmapTexture [[texture(3)]], sampler View_TransmittanceLutTextureSampler [[sampler(0)]], sampler ShadowDepthTextureSampler [[sampler(1)]], sampler StaticShadowDepthTextureSampler [[sampler(2)]], sampler VolumetricCloudShadowmapTextureSampler [[sampler(3)]], uint gl_Layer [[render_target_array_index]])
{
    InjectMainPS_out out = {};
    float _124 = float(gl_Layer) + 0.5;
    float _129 = View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].z + (_124 * View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].w);
    float _136 = 0.5 * View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].w;
    float2 _138 = (View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].xy + (in.in_var_TEXCOORD0 / View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].xy)) - float2(_136);
    float _139 = _138.x;
    float4 _150 = float4(_139, _138.y, _129, 1.0);
    float _152 = -dot(_Globals.ClippingPlanes[0], _150);
    float _156 = -dot(_Globals.ClippingPlanes[1], _150);
    if (_152 < 0.0)
    {
        discard_fragment();
    }
    if (_156 < 0.0)
    {
        discard_fragment();
    }
    float _171 = fast::clamp(_152 * _Globals.ShadowInjectParams.x, 0.0, 1.0) * fast::clamp(_156 * _Globals.ShadowInjectParams.y, 0.0, 1.0);
    float3 _179 = float3(_139, _138.y, _129) + float3(dot(abs(DeferredLightUniforms.DeferredLightUniforms_Direction * float3(_136)), float3(1.0)));
    float _256;
    if (_Globals.bStaticallyShadowed != 0u)
    {
        float4 _191 = _Globals.WorldToStaticShadowMatrix * float4(_179, 1.0);
        float2 _195 = _191.xy / float2(_191.w);
        bool2 _196 = _195 >= float2(0.0);
        bool2 _197 = _195 <= float2(1.0);
        float _255;
        if (all(bool2(_196.x && _197.x, _196.y && _197.y)))
        {
            float2 _209 = (_195 * _Globals.StaticShadowBufferSize.xy) - float2(0.5);
            float2 _210 = fract(_209);
            float2 _211 = floor(_209);
            float4 _219 = _106;
            _219.x = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_211 + float2(0.5, 1.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
            float4 _225 = _219;
            _225.y = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_211 + float2(1.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
            float4 _231 = _225;
            _231.z = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_211 + float2(1.5, 0.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
            float4 _236 = _231;
            _236.w = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_211 + float2(0.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
            float4 _246 = fast::clamp(fast::clamp((_236 * 40.0) - float4((_191.z * 40.0) - 1.0), float4(0.0), float4(1.0)) + select(float4(0.0), float4(1.0), _236 > float4(0.9900000095367431640625)), float4(0.0), float4(1.0));
            float2 _250 = mix(_246.wx, _246.zy, _210.xx);
            _255 = mix(_250.x, _250.y, _210.y);
        }
        else
        {
            _255 = 1.0;
        }
        _256 = _255;
    }
    else
    {
        _256 = 1.0;
    }
    float4 _260 = float4(_179, 1.0);
    float4 _263 = _Globals.WorldToShadowMatrix * _260;
    float2 _267 = _263.xy / float2(_263.w);
    bool2 _271 = _267 >= _Globals.ShadowmapMinMax.xy;
    bool2 _273 = _267 <= _Globals.ShadowmapMinMax.zw;
    float _289;
    if (all(bool2(_271.x && _273.x, _271.y && _273.y)))
    {
        _289 = float(_263.z < (ShadowDepthTexture.sample(ShadowDepthTextureSampler, _267, level(0.0)).x - _Globals.DepthBiasParameters.x));
    }
    else
    {
        _289 = 1.0;
    }
    float _302 = fast::clamp((dot(_179 - View.View_WorldCameraOrigin, View.View_ViewForward) * _Globals.ShadowInjectParams.z) + _Globals.ShadowInjectParams.w, 0.0, 1.0);
    float _315 = fast::min(_256, mix(_289, 1.0, _302 * _302)) * dot(fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0)), float3(0.33329999446868896484375));
    float _354;
    if (_Globals.VolumetricCloudShadowEnabled > 0u)
    {
        float4 _327 = _Globals.VolumetricCloudWorldToLightClipShadowMatrix * _260;
        float4 _329 = _327 / _327.wwww;
        float4 _335 = VolumetricCloudShadowmapTexture.sample(VolumetricCloudShadowmapTextureSampler, (float2(0.5) + (float2(0.5, -0.5) * _329.xy)), level(0.0));
        _354 = _315 * mix(1.0, fast::clamp(exp(-fast::min(_335.z, _335.y * (fast::max(0.0, (fast::clamp(1.0 - _329.z, 0.0, 1.0) * _Globals.VolumetricCloudShadowmapFarDepthKm) - _335.x) * 1000.0))), 0.0, 1.0), _Globals.VolumetricCloudShadowmapStrength);
    }
    else
    {
        _354 = _315;
    }
    float _375;
    if (_Globals.VolumeCascadeIndex == 1u)
    {
        float3 _368 = fast::clamp((float3(0.5) - abs(((float3(in.in_var_TEXCOORD0, _124 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w) * (1.0 + (4.0 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w))) - float3(2.0 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w)) - float3(0.5))) * 10.0, float3(0.0), float3(1.0));
        _375 = mix(1.0, _354, (_368.x * _368.y) * _368.z);
    }
    else
    {
        _375 = _354;
    }
    float3 _380 = ((DeferredLightUniforms.DeferredLightUniforms_Color * float3(0.3183098733425140380859375)) * 1.0) * _375;
    float3 _464;
    if (_Globals.AtmospherePerPixelTransmittanceEnabled > 0u)
    {
        float3 _390 = (_179 - View.View_SkyPlanetCenterAndViewHeight.xyz) * 9.9999997473787516355514526367188e-06;
        float3 _462;
        switch (0u)
        {
            default:
            {
                float3 _401 = _390 - float4(0.0, 0.0, 0.0, View.View_SkyAtmosphereBottomRadiusKm).xyz;
                float _403 = dot(DeferredLightUniforms.DeferredLightUniforms_Direction, DeferredLightUniforms.DeferredLightUniforms_Direction);
                float _404 = dot(DeferredLightUniforms.DeferredLightUniforms_Direction, _401);
                float _405 = 2.0 * _404;
                float _406 = View.View_SkyAtmosphereBottomRadiusKm * View.View_SkyAtmosphereBottomRadiusKm;
                float _411 = (_405 * _405) - ((4.0 * _403) * (dot(_401, _401) - _406));
                float2 _423;
                if (_411 >= 0.0)
                {
                    _423 = (float2(_404 * (-2.0)) + (float2(-1.0, 1.0) * sqrt(_411))) / float2(2.0 * _403);
                }
                else
                {
                    _423 = float2(-1.0);
                }
                if ((_423.x > 0.0) || (_423.y > 0.0))
                {
                    _462 = float3(0.0);
                    break;
                }
                float _431 = length(_390);
                float _434 = dot(DeferredLightUniforms.DeferredLightUniforms_Direction, _390 / float3(_431));
                float _435 = View.View_SkyAtmosphereTopRadiusKm * View.View_SkyAtmosphereTopRadiusKm;
                float _438 = sqrt(fast::max(0.0, _435 - _406));
                float _439 = _431 * _431;
                float _442 = sqrt(fast::max(0.0, _439 - _406));
                float _452 = View.View_SkyAtmosphereTopRadiusKm - _431;
                _462 = View_TransmittanceLutTexture.sample(View_TransmittanceLutTextureSampler, float2((fast::max(0.0, ((-_431) * _434) + sqrt((_439 * ((_434 * _434) - 1.0)) + _435)) - _452) / ((_442 + _438) - _452), _442 / _438), level(0.0)).xyz;
                break;
            }
        }
        _464 = _380 * _462;
    }
    else
    {
        _464 = _380;
    }
    float4 _465 = _106;
    _465.x = 0.2820949852466583251953125;
    float4 _468 = _465;
    _468.y = (-0.48860299587249755859375) * DeferredLightUniforms.DeferredLightUniforms_Direction.y;
    float4 _471 = _468;
    _471.z = 0.48860299587249755859375 * DeferredLightUniforms.DeferredLightUniforms_Direction.z;
    float4 _474 = _471;
    _474.w = (-0.48860299587249755859375) * DeferredLightUniforms.DeferredLightUniforms_Direction.x;
    float4 _476 = _474 * _464.x;
    float4 _478 = _474 * _464.y;
    float4 _480 = _474 * _464.z;
    out.out_var_SV_Target0 = float4(_476.x, _478.x, _480.x, _375) * _171;
    out.out_var_SV_Target1 = float4(dot(float3(_476.y, _478.y, _480.y), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), dot(float3(_476.z, _478.z, _480.z), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), dot(float3(_476.w, _478.w, _480.w), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), 0.0) * _171;
    return out;
}

