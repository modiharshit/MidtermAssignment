

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
    float4 LightFunctionParameters;
    float4x4 LightFunctionWorldToLight;
    spvUnsafeArray<float4, 2> ClippingPlanes;
};

constant spvUnsafeArray<float2, 1> _111 = spvUnsafeArray<float2, 1>({ float2(0.0) });

constant float4 _121 = {};

struct InjectMainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
    float4 out_var_SV_Target1 [[color(1)]];
};

struct InjectMainPS_in
{
    float2 in_var_TEXCOORD0 [[user(locn0), center_no_perspective]];
};

fragment InjectMainPS_out Main_000033b8_497d6e92(InjectMainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_DeferredLightUniforms& DeferredLightUniforms [[buffer(1)]], constant type_Material& Material [[buffer(2)]], constant type_Globals& _Globals [[buffer(3)]], texture2d<float> View_TransmittanceLutTexture [[texture(0)]], texture2d<float> Material_Texture2D_0 [[texture(1)]], texture2d<float> StaticShadowDepthTexture [[texture(2)]], texture2d<float> VolumetricCloudShadowmapTexture [[texture(3)]], sampler View_TransmittanceLutTextureSampler [[sampler(0)]], sampler Material_Texture2D_0Sampler [[sampler(1)]], sampler StaticShadowDepthTextureSampler [[sampler(2)]], sampler VolumetricCloudShadowmapTextureSampler [[sampler(3)]], uint gl_Layer [[render_target_array_index]])
{
    InjectMainPS_out out = {};
    float _133 = float(gl_Layer) + 0.5;
    float _138 = View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].z + (_133 * View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].w);
    float _145 = 0.5 * View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].w;
    float2 _147 = (View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].xy + (in.in_var_TEXCOORD0 / View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].xy)) - float2(_145);
    float _148 = _147.x;
    float4 _159 = float4(_148, _147.y, _138, 1.0);
    float _161 = -dot(_Globals.ClippingPlanes[0], _159);
    float _165 = -dot(_Globals.ClippingPlanes[1], _159);
    if (_161 < 0.0)
    {
        discard_fragment();
    }
    if (_165 < 0.0)
    {
        discard_fragment();
    }
    float _180 = fast::clamp(_161 * _Globals.ShadowInjectParams.x, 0.0, 1.0) * fast::clamp(_165 * _Globals.ShadowInjectParams.y, 0.0, 1.0);
    float3 _188 = float3(_148, _147.y, _138) + float3(dot(abs(DeferredLightUniforms.DeferredLightUniforms_Direction * float3(_145)), float3(1.0)));
    float _265;
    if (_Globals.bStaticallyShadowed != 0u)
    {
        float4 _200 = _Globals.WorldToStaticShadowMatrix * float4(_188, 1.0);
        float2 _204 = _200.xy / float2(_200.w);
        bool2 _205 = _204 >= float2(0.0);
        bool2 _206 = _204 <= float2(1.0);
        float _264;
        if (all(bool2(_205.x && _206.x, _205.y && _206.y)))
        {
            float2 _218 = (_204 * _Globals.StaticShadowBufferSize.xy) - float2(0.5);
            float2 _219 = fract(_218);
            float2 _220 = floor(_218);
            float4 _228 = _121;
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
        _265 = _264;
    }
    else
    {
        _265 = 1.0;
    }
    float4 _269 = float4(_188, 1.0);
    float4 _272 = _Globals.LightFunctionWorldToLight * _269;
    float3 _276 = _272.xyz / float3(_272.w);
    float2 _278 = _276.zy;
    float2 _309;
    if (_Globals.LightFunctionParameters.z > 0.0)
    {
        _309 = ((_278 / float2(_276.x * _Globals.LightFunctionParameters.x)) * 0.5) + float2(0.5);
    }
    else
    {
        float2 _300;
        if (_Globals.LightFunctionParameters.w > 0.0)
        {
            float3 _290 = normalize(_276.zyx);
            _300 = float2((atan2(_290.y, _290.x) + 3.1415927410125732421875) * 0.15915493667125701904296875, acos(_290.z) * 0.3183098733425140380859375);
        }
        else
        {
            _300 = _278;
        }
        _309 = _300;
    }
    spvUnsafeArray<float2, 1> _124 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _311 = 0; _311 < 1; )
    {
        _124[_311] = _309;
        _311++;
        continue;
    }
    float4 _323 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (_124[0] * 4.0));
    float _336 = _265 * dot(fast::max(mix(float4(_323.x).xyz, Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0)), float3(0.33329999446868896484375));
    float _375;
    if (_Globals.VolumetricCloudShadowEnabled > 0u)
    {
        float4 _348 = _Globals.VolumetricCloudWorldToLightClipShadowMatrix * _269;
        float4 _350 = _348 / _348.wwww;
        float4 _356 = VolumetricCloudShadowmapTexture.sample(VolumetricCloudShadowmapTextureSampler, (float2(0.5) + (float2(0.5, -0.5) * _350.xy)), level(0.0));
        _375 = _336 * mix(1.0, fast::clamp(exp(-fast::min(_356.z, _356.y * (fast::max(0.0, (fast::clamp(1.0 - _350.z, 0.0, 1.0) * _Globals.VolumetricCloudShadowmapFarDepthKm) - _356.x) * 1000.0))), 0.0, 1.0), _Globals.VolumetricCloudShadowmapStrength);
    }
    else
    {
        _375 = _336;
    }
    float _396;
    if (_Globals.VolumeCascadeIndex == 1u)
    {
        float3 _389 = fast::clamp((float3(0.5) - abs(((float3(in.in_var_TEXCOORD0, _133 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w) * (1.0 + (4.0 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w))) - float3(2.0 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w)) - float3(0.5))) * 10.0, float3(0.0), float3(1.0));
        _396 = mix(1.0, _375, (_389.x * _389.y) * _389.z);
    }
    else
    {
        _396 = _375;
    }
    float3 _401 = ((DeferredLightUniforms.DeferredLightUniforms_Color * float3(0.3183098733425140380859375)) * 1.0) * _396;
    float3 _485;
    if (_Globals.AtmospherePerPixelTransmittanceEnabled > 0u)
    {
        float3 _411 = (_188 - View.View_SkyPlanetCenterAndViewHeight.xyz) * 9.9999997473787516355514526367188e-06;
        float3 _483;
        switch (0u)
        {
            default:
            {
                float3 _422 = _411 - float4(0.0, 0.0, 0.0, View.View_SkyAtmosphereBottomRadiusKm).xyz;
                float _424 = dot(DeferredLightUniforms.DeferredLightUniforms_Direction, DeferredLightUniforms.DeferredLightUniforms_Direction);
                float _425 = dot(DeferredLightUniforms.DeferredLightUniforms_Direction, _422);
                float _426 = 2.0 * _425;
                float _427 = View.View_SkyAtmosphereBottomRadiusKm * View.View_SkyAtmosphereBottomRadiusKm;
                float _432 = (_426 * _426) - ((4.0 * _424) * (dot(_422, _422) - _427));
                float2 _444;
                if (_432 >= 0.0)
                {
                    _444 = (float2(_425 * (-2.0)) + (float2(-1.0, 1.0) * sqrt(_432))) / float2(2.0 * _424);
                }
                else
                {
                    _444 = float2(-1.0);
                }
                if ((_444.x > 0.0) || (_444.y > 0.0))
                {
                    _483 = float3(0.0);
                    break;
                }
                float _452 = length(_411);
                float _455 = dot(DeferredLightUniforms.DeferredLightUniforms_Direction, _411 / float3(_452));
                float _456 = View.View_SkyAtmosphereTopRadiusKm * View.View_SkyAtmosphereTopRadiusKm;
                float _459 = sqrt(fast::max(0.0, _456 - _427));
                float _460 = _452 * _452;
                float _463 = sqrt(fast::max(0.0, _460 - _427));
                float _473 = View.View_SkyAtmosphereTopRadiusKm - _452;
                _483 = View_TransmittanceLutTexture.sample(View_TransmittanceLutTextureSampler, float2((fast::max(0.0, ((-_452) * _455) + sqrt((_460 * ((_455 * _455) - 1.0)) + _456)) - _473) / ((_463 + _459) - _473), _463 / _459), level(0.0)).xyz;
                break;
            }
        }
        _485 = _401 * _483;
    }
    else
    {
        _485 = _401;
    }
    float4 _486 = _121;
    _486.x = 0.2820949852466583251953125;
    float4 _489 = _486;
    _489.y = (-0.48860299587249755859375) * DeferredLightUniforms.DeferredLightUniforms_Direction.y;
    float4 _492 = _489;
    _492.z = 0.48860299587249755859375 * DeferredLightUniforms.DeferredLightUniforms_Direction.z;
    float4 _495 = _492;
    _495.w = (-0.48860299587249755859375) * DeferredLightUniforms.DeferredLightUniforms_Direction.x;
    float4 _497 = _495 * _485.x;
    float4 _499 = _495 * _485.y;
    float4 _501 = _495 * _485.z;
    out.out_var_SV_Target0 = float4(_497.x, _499.x, _501.x, _396) * _180;
    out.out_var_SV_Target1 = float4(dot(float3(_497.y, _499.y, _501.y), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), dot(float3(_497.z, _499.z, _501.z), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), dot(float3(_497.w, _499.w, _501.w), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), 0.0) * _180;
    return out;
}

