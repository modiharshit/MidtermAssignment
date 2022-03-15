

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
    char _m0_pad[64];
    float4x4 View_WorldToClip;
    char _m1_pad[320];
    float4x4 View_ViewToClip;
    char _m2_pad[192];
    float4x4 View_SVPositionToTranslatedWorld;
    char _m3_pad[272];
    float4 View_InvDeviceZToWorldZTransform;
    float4 View_ScreenPositionScaleBias;
    char _m5_pad[48];
    float3 View_PreViewTranslation;
    char _m6_pad[928];
    float4 View_ViewRectMin;
    float4 View_ViewSizeAndInvSize;
    char _m8_pad[68];
    float View_PreExposure;
    float4 View_DiffuseOverrideParameter;
    float4 View_SpecularOverrideParameter;
    float4 View_NormalOverrideParameter;
    char _m12_pad[16];
    float View_OutOfBoundsMask;
    char _m13_pad[48];
    float View_MaterialTextureMipBias;
    char _m14_pad[28];
    float View_UnlitViewmodeMask;
    char _m15_pad[32];
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeMin;
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeInvSize;
    char _m17_pad[508];
    float View_RenderingReflectionCaptureMask;
    char _m18_pad[48];
    float4 View_SkyLightColor;
    char _m19_pad[320];
    float3 View_VolumetricFogInvGridSize;
    float3 View_VolumetricFogGridZParams;
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_Primitive
{
    char _m0_pad[80];
    float4 Primitive_ObjectWorldPositionAndRadius;
    char _m1_pad[208];
    float3 Primitive_ObjectBounds;
};

struct type_TranslucentBasePass
{
    char _m0_pad[1836];
    float TranslucentBasePass_Shared_Fog_ApplyVolumetricFog;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float _131 = {};
constant float3 _133 = {};
constant float4 _134 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPS_in
{
    float4 in_var_TEXCOORD0_0 [[user(locn0)]];
    float4 in_var_PARTICLE_SUBUVS [[user(locn1)]];
    float3 in_var_TEXCOORD4 [[user(locn2)]];
    float4 in_var_TEXCOORD5 [[user(locn3)]];
    float3 in_var_PARTICLE_LIGHTING_OFFSET [[user(locn4)]];
    float4 in_var_TANGENTX [[user(locn5)]];
    float4 in_var_TANGENTZ [[user(locn6)]];
    float4 in_var_TEXCOORD7 [[user(locn7)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00003920_fa744343(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], texture2d<float> TranslucentBasePass_SceneTextures_SceneDepthTexture [[texture(1)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(2)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(3)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(4)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(5)]], texture2d<float> Material_Texture2D_0 [[texture(6)]], texture2d<float> Material_Texture2D_1 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_SceneTextures_PointClampSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _197 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _201 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _206 = (_201.xyz / float3(_201.w)) - View.View_PreViewTranslation;
    float3 _214 = normalize(float3x3(in.in_var_TANGENTX.xyz, cross(in.in_var_TANGENTZ.xyz, in.in_var_TANGENTX.xyz) * in.in_var_TANGENTZ.w, in.in_var_TANGENTZ.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _228 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 8.0), bias(View.View_MaterialTextureMipBias));
    float4 _232 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, in.in_var_PARTICLE_SUBUVS.xy);
    float4 _234 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, in.in_var_PARTICLE_SUBUVS.zw);
    float4 _236 = mix(_232, _234, float4(in.in_var_TEXCOORD4.x));
    float _248 = _197.w;
    float4 _258 = TranslucentBasePass_SceneTextures_SceneDepthTexture.sample(TranslucentBasePass_SceneTextures_PointClampSampler, (((_197.xy / float2(_248)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz), level(0.0));
    float _259 = _258.x;
    float _289;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _289 = _248;
                break;
            }
            else
            {
                float _282 = _197.z;
                _289 = ((_282 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_282 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _295 = fast::clamp((_228.xyz + _236.xyz) * in.in_var_TEXCOORD5.xyz, float3(0.0), float3(1.0));
    float _296 = fast::clamp(fast::min(fast::max(in.in_var_TEXCOORD5.w * _236.w, 0.0), 1.0) * fast::min(fast::max(((((_259 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_259 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w))) - _289) * 0.006666666828095912933349609375, 0.0), 1.0), 0.0, 1.0);
    float3 _303 = (_295 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _310 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _313 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _318;
    if (_313)
    {
        _318 = _303 + (_310 * 0.449999988079071044921875);
    }
    else
    {
        _318 = _303;
    }
    float _321 = _214.x;
    float _322 = _214.y;
    float4 _324 = float4(_321, _322, _214.z, 1.0);
    float3 _328 = _133;
    _328.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _324);
    float3 _332 = _328;
    _332.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _324);
    float3 _336 = _332;
    _336.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _324);
    float4 _339 = _324.xyzz * _324.yzzx;
    float3 _343 = _133;
    _343.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _339);
    float3 _347 = _343;
    _347.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _339);
    float3 _351 = _347;
    _351.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _339);
    bool _381 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _430;
    if (_381)
    {
        float4 _388 = View.View_WorldToClip * float4(_206, 1.0);
        float _389 = _388.w;
        float4 _418;
        if (_381)
        {
            _418 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_388.xy / float2(_389)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_389 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _418 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _430 = float4(_418.xyz + (in.in_var_TEXCOORD7.xyz * _418.w), _418.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _430 = in.in_var_TEXCOORD7;
    }
    float3 _431 = _206 + in.in_var_PARTICLE_LIGHTING_OFFSET;
    float3 _439 = (_431 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _447 = (_431 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _452 = fast::clamp((float3(0.5) - abs(_439 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _457 = (_452.x * _452.y) * _452.z;
    float4 _466 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _447, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _439, level(0.0)), float4(_457));
    float3 _477 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _447, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _439, level(0.0)).xyz, float3(_457)) * 1.0;
    float4 _479 = _134;
    _479.x = _466.x;
    float4 _481 = _134;
    _481.x = _466.y;
    float4 _483 = _134;
    _483.x = _466.z;
    float3 _484 = _466.xyz;
    float3 _488 = _484 / float3(dot(_484, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _490 = _477 * _488.x;
    float3 _493 = _477 * _488.y;
    float3 _496 = _477 * _488.z;
    float4 _499 = _134;
    _499.y = (-0.48860299587249755859375) * _322;
    float4 _501 = _499;
    _501.z = 0.48860299587249755859375 * _214.z;
    float4 _503 = _501;
    _503.w = (-0.48860299587249755859375) * _321;
    float4 _504 = _503;
    _504.x = 0.886227548122406005859375;
    float3 _506 = _504.yzw * 2.094395160675048828125;
    float4 _507 = float4(_504.x, _506.x, _506.y, _506.z);
    float3 _509 = _133;
    _509.x = dot(float4(_479.x, _490.x, _490.y, _490.z), _507);
    float3 _511 = _509;
    _511.y = dot(float4(_481.x, _493.x, _493.y, _493.z), _507);
    float3 _513 = _511;
    _513.z = dot(float4(_483.x, _496.x, _496.y, _496.z), _507);
    float3 _527 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _554;
    float3 _555;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        bool _542 = any(abs(_206 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0)));
        float3 _552;
        if (_542)
        {
            _552 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_206, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _552 = _527;
        }
        _554 = _542 ? 1.0 : _296;
        _555 = _552;
    }
    else
    {
        _554 = _296;
        _555 = _527;
    }
    float4 _565 = float4((((mix(_318 * float4(fast::max(float3(0.0), _513), _131).xyz, _318 + (select(_310, float3(0.0), bool3(_313)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((((fast::max(float3(0.0), (_336 + _351) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_321 * _321) - (_322 * _322)))) * View.View_SkyLightColor.xyz) * 1.0) * _318) * fast::max(float3(1.0), ((((((_295 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_295 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_295 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _555) * _430.w) + _430.xyz, _554);
    float3 _569 = _565.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_569.x, _569.y, _569.z, _565.w);
    return out;
}

