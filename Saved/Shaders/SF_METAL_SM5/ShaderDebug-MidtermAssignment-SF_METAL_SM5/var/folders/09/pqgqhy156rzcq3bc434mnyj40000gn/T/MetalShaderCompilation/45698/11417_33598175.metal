

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
    spvUnsafeArray<float4, 2> ClippingPlanes;
};

constant float4 _103 = {};

struct InjectMainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
    float4 out_var_SV_Target1 [[color(1)]];
};

struct InjectMainPS_in
{
    float2 in_var_TEXCOORD0 [[user(locn0), center_no_perspective]];
};

fragment InjectMainPS_out Main_00002c99_0200aadf(InjectMainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_DeferredLightUniforms& DeferredLightUniforms [[buffer(1)]], constant type_Globals& _Globals [[buffer(2)]], texture2d<float> View_TransmittanceLutTexture [[texture(0)]], texture2d<float> StaticShadowDepthTexture [[texture(1)]], texture2d<float> VolumetricCloudShadowmapTexture [[texture(2)]], sampler View_TransmittanceLutTextureSampler [[sampler(0)]], sampler StaticShadowDepthTextureSampler [[sampler(1)]], sampler VolumetricCloudShadowmapTextureSampler [[sampler(2)]], uint gl_Layer [[render_target_array_index]])
{
    InjectMainPS_out out = {};
    float _114 = float(gl_Layer) + 0.5;
    float _119 = View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].z + (_114 * View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].w);
    float _126 = 0.5 * View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].w;
    float2 _128 = (View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].xy + (in.in_var_TEXCOORD0 / View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].xy)) - float2(_126);
    float _129 = _128.x;
    float4 _140 = float4(_129, _128.y, _119, 1.0);
    float _142 = -dot(_Globals.ClippingPlanes[0], _140);
    float _146 = -dot(_Globals.ClippingPlanes[1], _140);
    if (_142 < 0.0)
    {
        discard_fragment();
    }
    if (_146 < 0.0)
    {
        discard_fragment();
    }
    float _161 = fast::clamp(_142 * _Globals.ShadowInjectParams.x, 0.0, 1.0) * fast::clamp(_146 * _Globals.ShadowInjectParams.y, 0.0, 1.0);
    float3 _169 = float3(_129, _128.y, _119) + float3(dot(abs(DeferredLightUniforms.DeferredLightUniforms_Direction * float3(_126)), float3(1.0)));
    float _246;
    if (_Globals.bStaticallyShadowed != 0u)
    {
        float4 _181 = _Globals.WorldToStaticShadowMatrix * float4(_169, 1.0);
        float2 _185 = _181.xy / float2(_181.w);
        bool2 _186 = _185 >= float2(0.0);
        bool2 _187 = _185 <= float2(1.0);
        float _245;
        if (all(bool2(_186.x && _187.x, _186.y && _187.y)))
        {
            float2 _199 = (_185 * _Globals.StaticShadowBufferSize.xy) - float2(0.5);
            float2 _200 = fract(_199);
            float2 _201 = floor(_199);
            float4 _209 = _103;
            _209.x = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_201 + float2(0.5, 1.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
            float4 _215 = _209;
            _215.y = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_201 + float2(1.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
            float4 _221 = _215;
            _221.z = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_201 + float2(1.5, 0.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
            float4 _226 = _221;
            _226.w = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_201 + float2(0.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
            float4 _236 = fast::clamp(fast::clamp((_226 * 40.0) - float4((_181.z * 40.0) - 1.0), float4(0.0), float4(1.0)) + select(float4(0.0), float4(1.0), _226 > float4(0.9900000095367431640625)), float4(0.0), float4(1.0));
            float2 _240 = mix(_236.wx, _236.zy, _200.xx);
            _245 = mix(_240.x, _240.y, _200.y);
        }
        else
        {
            _245 = 1.0;
        }
        _246 = _245;
    }
    else
    {
        _246 = 1.0;
    }
    float _289;
    if (_Globals.VolumetricCloudShadowEnabled > 0u)
    {
        float4 _262 = _Globals.VolumetricCloudWorldToLightClipShadowMatrix * float4(_169, 1.0);
        float4 _264 = _262 / _262.wwww;
        float4 _270 = VolumetricCloudShadowmapTexture.sample(VolumetricCloudShadowmapTextureSampler, (float2(0.5) + (float2(0.5, -0.5) * _264.xy)), level(0.0));
        _289 = _246 * mix(1.0, fast::clamp(exp(-fast::min(_270.z, _270.y * (fast::max(0.0, (fast::clamp(1.0 - _264.z, 0.0, 1.0) * _Globals.VolumetricCloudShadowmapFarDepthKm) - _270.x) * 1000.0))), 0.0, 1.0), _Globals.VolumetricCloudShadowmapStrength);
    }
    else
    {
        _289 = _246;
    }
    float _310;
    if (_Globals.VolumeCascadeIndex == 1u)
    {
        float3 _303 = fast::clamp((float3(0.5) - abs(((float3(in.in_var_TEXCOORD0, _114 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w) * (1.0 + (4.0 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w))) - float3(2.0 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w)) - float3(0.5))) * 10.0, float3(0.0), float3(1.0));
        _310 = mix(1.0, _289, (_303.x * _303.y) * _303.z);
    }
    else
    {
        _310 = _289;
    }
    float3 _315 = ((DeferredLightUniforms.DeferredLightUniforms_Color * float3(0.3183098733425140380859375)) * 1.0) * _310;
    float3 _399;
    if (_Globals.AtmospherePerPixelTransmittanceEnabled > 0u)
    {
        float3 _325 = (_169 - View.View_SkyPlanetCenterAndViewHeight.xyz) * 9.9999997473787516355514526367188e-06;
        float3 _397;
        switch (0u)
        {
            default:
            {
                float3 _336 = _325 - float4(0.0, 0.0, 0.0, View.View_SkyAtmosphereBottomRadiusKm).xyz;
                float _338 = dot(DeferredLightUniforms.DeferredLightUniforms_Direction, DeferredLightUniforms.DeferredLightUniforms_Direction);
                float _339 = dot(DeferredLightUniforms.DeferredLightUniforms_Direction, _336);
                float _340 = 2.0 * _339;
                float _341 = View.View_SkyAtmosphereBottomRadiusKm * View.View_SkyAtmosphereBottomRadiusKm;
                float _346 = (_340 * _340) - ((4.0 * _338) * (dot(_336, _336) - _341));
                float2 _358;
                if (_346 >= 0.0)
                {
                    _358 = (float2(_339 * (-2.0)) + (float2(-1.0, 1.0) * sqrt(_346))) / float2(2.0 * _338);
                }
                else
                {
                    _358 = float2(-1.0);
                }
                if ((_358.x > 0.0) || (_358.y > 0.0))
                {
                    _397 = float3(0.0);
                    break;
                }
                float _366 = length(_325);
                float _369 = dot(DeferredLightUniforms.DeferredLightUniforms_Direction, _325 / float3(_366));
                float _370 = View.View_SkyAtmosphereTopRadiusKm * View.View_SkyAtmosphereTopRadiusKm;
                float _373 = sqrt(fast::max(0.0, _370 - _341));
                float _374 = _366 * _366;
                float _377 = sqrt(fast::max(0.0, _374 - _341));
                float _387 = View.View_SkyAtmosphereTopRadiusKm - _366;
                _397 = View_TransmittanceLutTexture.sample(View_TransmittanceLutTextureSampler, float2((fast::max(0.0, ((-_366) * _369) + sqrt((_374 * ((_369 * _369) - 1.0)) + _370)) - _387) / ((_377 + _373) - _387), _377 / _373), level(0.0)).xyz;
                break;
            }
        }
        _399 = _315 * _397;
    }
    else
    {
        _399 = _315;
    }
    float4 _400 = _103;
    _400.x = 0.2820949852466583251953125;
    float4 _403 = _400;
    _403.y = (-0.48860299587249755859375) * DeferredLightUniforms.DeferredLightUniforms_Direction.y;
    float4 _406 = _403;
    _406.z = 0.48860299587249755859375 * DeferredLightUniforms.DeferredLightUniforms_Direction.z;
    float4 _409 = _406;
    _409.w = (-0.48860299587249755859375) * DeferredLightUniforms.DeferredLightUniforms_Direction.x;
    float4 _411 = _409 * _399.x;
    float4 _413 = _409 * _399.y;
    float4 _415 = _409 * _399.z;
    out.out_var_SV_Target0 = float4(_411.x, _413.x, _415.x, _310) * _161;
    out.out_var_SV_Target1 = float4(dot(float3(_411.y, _413.y, _415.y), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), dot(float3(_411.z, _413.z, _415.z), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), dot(float3(_411.w, _413.w, _415.w), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), 0.0) * _161;
    return out;
}

