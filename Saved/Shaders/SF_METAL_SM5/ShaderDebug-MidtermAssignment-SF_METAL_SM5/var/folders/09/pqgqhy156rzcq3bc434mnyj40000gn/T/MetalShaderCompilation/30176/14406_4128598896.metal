

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
    float4 LightFunctionParameters;
    float4x4 LightFunctionWorldToLight;
    spvUnsafeArray<float4, 2> ClippingPlanes;
};

constant spvUnsafeArray<float2, 1> _106 = spvUnsafeArray<float2, 1>({ float2(0.0) });

constant float4 _116 = {};

struct InjectMainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
    float4 out_var_SV_Target1 [[color(1)]];
};

struct InjectMainPS_in
{
    float2 in_var_TEXCOORD0 [[user(locn0), center_no_perspective]];
};

fragment InjectMainPS_out Main_00003846_f6156b70(InjectMainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_DeferredLightUniforms& DeferredLightUniforms [[buffer(1)]], constant type_Material& Material [[buffer(2)]], constant type_Globals& _Globals [[buffer(3)]], texture2d<float> View_TransmittanceLutTexture [[texture(0)]], texture2d<float> Material_Texture2D_0 [[texture(1)]], texture2d<float> ShadowDepthTexture [[texture(2)]], texture2d<float> StaticShadowDepthTexture [[texture(3)]], texture2d<float> VolumetricCloudShadowmapTexture [[texture(4)]], sampler View_TransmittanceLutTextureSampler [[sampler(0)]], sampler Material_Texture2D_0Sampler [[sampler(1)]], sampler ShadowDepthTextureSampler [[sampler(2)]], sampler StaticShadowDepthTextureSampler [[sampler(3)]], sampler VolumetricCloudShadowmapTextureSampler [[sampler(4)]], uint gl_Layer [[render_target_array_index]])
{
    InjectMainPS_out out = {};
    float _137 = float(gl_Layer) + 0.5;
    float _142 = View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].z + (_137 * View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].w);
    float _149 = 0.5 * View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].w;
    float2 _151 = (View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].xy + (in.in_var_TEXCOORD0 / View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].xy)) - float2(_149);
    float _152 = _151.x;
    float4 _163 = float4(_152, _151.y, _142, 1.0);
    float _165 = -dot(_Globals.ClippingPlanes[0], _163);
    float _169 = -dot(_Globals.ClippingPlanes[1], _163);
    if (_165 < 0.0)
    {
        discard_fragment();
    }
    if (_169 < 0.0)
    {
        discard_fragment();
    }
    float _184 = fast::clamp(_165 * _Globals.ShadowInjectParams.x, 0.0, 1.0) * fast::clamp(_169 * _Globals.ShadowInjectParams.y, 0.0, 1.0);
    float3 _192 = float3(_152, _151.y, _142) + float3(dot(abs(DeferredLightUniforms.DeferredLightUniforms_Direction * float3(_149)), float3(1.0)));
    float _269;
    if (_Globals.bStaticallyShadowed != 0u)
    {
        float4 _204 = _Globals.WorldToStaticShadowMatrix * float4(_192, 1.0);
        float2 _208 = _204.xy / float2(_204.w);
        bool2 _209 = _208 >= float2(0.0);
        bool2 _210 = _208 <= float2(1.0);
        float _268;
        if (all(bool2(_209.x && _210.x, _209.y && _210.y)))
        {
            float2 _222 = (_208 * _Globals.StaticShadowBufferSize.xy) - float2(0.5);
            float2 _223 = fract(_222);
            float2 _224 = floor(_222);
            float4 _232 = _116;
            _232.x = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_224 + float2(0.5, 1.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
            float4 _238 = _232;
            _238.y = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_224 + float2(1.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
            float4 _244 = _238;
            _244.z = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_224 + float2(1.5, 0.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
            float4 _249 = _244;
            _249.w = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_224 + float2(0.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
            float4 _259 = fast::clamp(fast::clamp((_249 * 40.0) - float4((_204.z * 40.0) - 1.0), float4(0.0), float4(1.0)) + select(float4(0.0), float4(1.0), _249 > float4(0.9900000095367431640625)), float4(0.0), float4(1.0));
            float2 _263 = mix(_259.wx, _259.zy, _223.xx);
            _268 = mix(_263.x, _263.y, _223.y);
        }
        else
        {
            _268 = 1.0;
        }
        _269 = _268;
    }
    else
    {
        _269 = 1.0;
    }
    float4 _273 = float4(_192, 1.0);
    float4 _276 = _Globals.WorldToShadowMatrix * _273;
    float2 _280 = _276.xy / float2(_276.w);
    bool2 _284 = _280 >= _Globals.ShadowmapMinMax.xy;
    bool2 _286 = _280 <= _Globals.ShadowmapMinMax.zw;
    float _302;
    if (all(bool2(_284.x && _286.x, _284.y && _286.y)))
    {
        _302 = float(_276.z < (ShadowDepthTexture.sample(ShadowDepthTextureSampler, _280, level(0.0)).x - _Globals.DepthBiasParameters.x));
    }
    else
    {
        _302 = 1.0;
    }
    float _315 = fast::clamp((dot(_192 - View.View_WorldCameraOrigin, View.View_ViewForward) * _Globals.ShadowInjectParams.z) + _Globals.ShadowInjectParams.w, 0.0, 1.0);
    float4 _321 = _Globals.LightFunctionWorldToLight * _273;
    float3 _325 = _321.xyz / float3(_321.w);
    float2 _327 = _325.zy;
    float2 _358;
    if (_Globals.LightFunctionParameters.z > 0.0)
    {
        _358 = ((_327 / float2(_325.x * _Globals.LightFunctionParameters.x)) * 0.5) + float2(0.5);
    }
    else
    {
        float2 _349;
        if (_Globals.LightFunctionParameters.w > 0.0)
        {
            float3 _339 = normalize(_325.zyx);
            _349 = float2((atan2(_339.y, _339.x) + 3.1415927410125732421875) * 0.15915493667125701904296875, acos(_339.z) * 0.3183098733425140380859375);
        }
        else
        {
            _349 = _327;
        }
        _358 = _349;
    }
    spvUnsafeArray<float2, 1> _128 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _360 = 0; _360 < 1; )
    {
        _128[_360] = _358;
        _360++;
        continue;
    }
    float4 _372 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (_128[0] * 4.0));
    float _385 = fast::min(_269, mix(_302, 1.0, _315 * _315)) * dot(fast::max(mix(float4(_372.x).xyz, Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0)), float3(0.33329999446868896484375));
    float _424;
    if (_Globals.VolumetricCloudShadowEnabled > 0u)
    {
        float4 _397 = _Globals.VolumetricCloudWorldToLightClipShadowMatrix * _273;
        float4 _399 = _397 / _397.wwww;
        float4 _405 = VolumetricCloudShadowmapTexture.sample(VolumetricCloudShadowmapTextureSampler, (float2(0.5) + (float2(0.5, -0.5) * _399.xy)), level(0.0));
        _424 = _385 * mix(1.0, fast::clamp(exp(-fast::min(_405.z, _405.y * (fast::max(0.0, (fast::clamp(1.0 - _399.z, 0.0, 1.0) * _Globals.VolumetricCloudShadowmapFarDepthKm) - _405.x) * 1000.0))), 0.0, 1.0), _Globals.VolumetricCloudShadowmapStrength);
    }
    else
    {
        _424 = _385;
    }
    float _445;
    if (_Globals.VolumeCascadeIndex == 1u)
    {
        float3 _438 = fast::clamp((float3(0.5) - abs(((float3(in.in_var_TEXCOORD0, _137 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w) * (1.0 + (4.0 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w))) - float3(2.0 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w)) - float3(0.5))) * 10.0, float3(0.0), float3(1.0));
        _445 = mix(1.0, _424, (_438.x * _438.y) * _438.z);
    }
    else
    {
        _445 = _424;
    }
    float3 _450 = ((DeferredLightUniforms.DeferredLightUniforms_Color * float3(0.3183098733425140380859375)) * 1.0) * _445;
    float3 _534;
    if (_Globals.AtmospherePerPixelTransmittanceEnabled > 0u)
    {
        float3 _460 = (_192 - View.View_SkyPlanetCenterAndViewHeight.xyz) * 9.9999997473787516355514526367188e-06;
        float3 _532;
        switch (0u)
        {
            default:
            {
                float3 _471 = _460 - float4(0.0, 0.0, 0.0, View.View_SkyAtmosphereBottomRadiusKm).xyz;
                float _473 = dot(DeferredLightUniforms.DeferredLightUniforms_Direction, DeferredLightUniforms.DeferredLightUniforms_Direction);
                float _474 = dot(DeferredLightUniforms.DeferredLightUniforms_Direction, _471);
                float _475 = 2.0 * _474;
                float _476 = View.View_SkyAtmosphereBottomRadiusKm * View.View_SkyAtmosphereBottomRadiusKm;
                float _481 = (_475 * _475) - ((4.0 * _473) * (dot(_471, _471) - _476));
                float2 _493;
                if (_481 >= 0.0)
                {
                    _493 = (float2(_474 * (-2.0)) + (float2(-1.0, 1.0) * sqrt(_481))) / float2(2.0 * _473);
                }
                else
                {
                    _493 = float2(-1.0);
                }
                if ((_493.x > 0.0) || (_493.y > 0.0))
                {
                    _532 = float3(0.0);
                    break;
                }
                float _501 = length(_460);
                float _504 = dot(DeferredLightUniforms.DeferredLightUniforms_Direction, _460 / float3(_501));
                float _505 = View.View_SkyAtmosphereTopRadiusKm * View.View_SkyAtmosphereTopRadiusKm;
                float _508 = sqrt(fast::max(0.0, _505 - _476));
                float _509 = _501 * _501;
                float _512 = sqrt(fast::max(0.0, _509 - _476));
                float _522 = View.View_SkyAtmosphereTopRadiusKm - _501;
                _532 = View_TransmittanceLutTexture.sample(View_TransmittanceLutTextureSampler, float2((fast::max(0.0, ((-_501) * _504) + sqrt((_509 * ((_504 * _504) - 1.0)) + _505)) - _522) / ((_512 + _508) - _522), _512 / _508), level(0.0)).xyz;
                break;
            }
        }
        _534 = _450 * _532;
    }
    else
    {
        _534 = _450;
    }
    float4 _535 = _116;
    _535.x = 0.2820949852466583251953125;
    float4 _538 = _535;
    _538.y = (-0.48860299587249755859375) * DeferredLightUniforms.DeferredLightUniforms_Direction.y;
    float4 _541 = _538;
    _541.z = 0.48860299587249755859375 * DeferredLightUniforms.DeferredLightUniforms_Direction.z;
    float4 _544 = _541;
    _544.w = (-0.48860299587249755859375) * DeferredLightUniforms.DeferredLightUniforms_Direction.x;
    float4 _546 = _544 * _534.x;
    float4 _548 = _544 * _534.y;
    float4 _550 = _544 * _534.z;
    out.out_var_SV_Target0 = float4(_546.x, _548.x, _550.x, _445) * _184;
    out.out_var_SV_Target1 = float4(dot(float3(_546.y, _548.y, _550.y), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), dot(float3(_546.z, _548.z, _550.z), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), dot(float3(_546.w, _548.w, _550.w), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), 0.0) * _184;
    return out;
}

