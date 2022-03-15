

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
    char _m17_pad[80];
    float3 View_IndirectLightingColorScale;
    char _m18_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m19_pad[384];
    float3 View_VolumetricFogInvGridSize;
    float3 View_VolumetricFogGridZParams;
    char _m21_pad[16];
    float3 View_VolumetricLightmapWorldToUVScale;
    float3 View_VolumetricLightmapWorldToUVAdd;
    packed_float3 View_VolumetricLightmapIndirectionTextureSize;
    float View_VolumetricLightmapBrickSize;
    float3 View_VolumetricLightmapBrickTexelSize;
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

constant float _142 = {};
constant float4 _144 = {};
constant float3 _145 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPS_in
{
    float4 in_var_TEXCOORD10 [[user(locn0)]];
    float4 in_var_TEXCOORD11 [[user(locn1)]];
    float4 in_var_TEXCOORD2 [[user(locn2)]];
    float4 in_var_TEXCOORD3_0 [[user(locn3)]];
    float4 in_var_PARTICLE_SUBUVS [[user(locn4)]];
    float3 in_var_PARTICLE_LIGHTING_OFFSET [[user(locn5)]];
    float4 in_var_TEXCOORD7 [[user(locn6)]];
};

fragment MainPS_out Main_00003cc4_d565888c(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(4)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(5)]], texture2d<float> TranslucentBasePass_SceneTextures_SceneDepthTexture [[texture(6)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(7)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(8)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(9)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(10)]], texture2d<float> Material_Texture2D_0 [[texture(11)]], texture2d<float> Material_Texture2D_1 [[texture(12)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_SceneTextures_PointClampSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD3 = {};
    in_var_TEXCOORD3[0] = in.in_var_TEXCOORD3_0;
    float4 _212 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _216 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _221 = (_216.xyz / float3(_216.w)) - View.View_PreViewTranslation;
    float3 _229 = normalize(float3x3(in.in_var_TEXCOORD10.xyz, cross(in.in_var_TEXCOORD11.xyz, in.in_var_TEXCOORD10.xyz) * in.in_var_TEXCOORD11.w, in.in_var_TEXCOORD11.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _243 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD3[0].x, in_var_TEXCOORD3[0].y) * 8.0), bias(View.View_MaterialTextureMipBias));
    float4 _247 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, in.in_var_PARTICLE_SUBUVS.xy);
    float4 _249 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, in.in_var_PARTICLE_SUBUVS.zw);
    float4 _251 = mix(_247, _249, float4(in.in_var_TEXCOORD10.w));
    float _263 = _212.w;
    float4 _273 = TranslucentBasePass_SceneTextures_SceneDepthTexture.sample(TranslucentBasePass_SceneTextures_PointClampSampler, (((_212.xy / float2(_263)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz), level(0.0));
    float _274 = _273.x;
    float _304;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _304 = _263;
                break;
            }
            else
            {
                float _297 = _212.z;
                _304 = ((_297 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_297 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _310 = fast::clamp((_243.xyz + _251.xyz) * in.in_var_TEXCOORD2.xyz, float3(0.0), float3(1.0));
    float _311 = fast::clamp(fast::min(fast::max(in.in_var_TEXCOORD2.w * _251.w, 0.0), 1.0) * fast::min(fast::max(((((_274 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_274 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w))) - _304) * 0.006666666828095912933349609375, 0.0), 1.0), 0.0, 1.0);
    float3 _321 = fast::clamp((_221 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _332 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_321.x), int(_321.y), int(_321.z), 0).xyz), 0));
    float3 _347 = (((_332.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_321 / float3(_332.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float3 _354 = (_310 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _361 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _364 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _369;
    if (_364)
    {
        _369 = _354 + (_361 * 0.449999988079071044921875);
    }
    else
    {
        _369 = _354;
    }
    float4 _375 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _347, level(0.0));
    float _391 = _375.x;
    float _394 = _375.y;
    float _397 = _375.z;
    float4 _414 = _144;
    _414.y = (-0.48860299587249755859375) * _229.y;
    float4 _417 = _414;
    _417.z = 0.48860299587249755859375 * _229.z;
    float4 _420 = _417;
    _420.w = (-0.48860299587249755859375) * _229.x;
    float4 _421 = _420;
    _421.x = 0.886227548122406005859375;
    float3 _423 = _421.yzw * 2.094395160675048828125;
    float4 _424 = float4(_421.x, _423.x, _423.y, _423.z);
    float3 _426 = _145;
    _426.x = dot(float4(_391, ((((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _347, level(0.0)) * 2.0) - float4(1.0)) * _391) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625)).xyz), _424);
    float3 _428 = _426;
    _428.y = dot(float4(_394, ((((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _347, level(0.0)) * 2.0) - float4(1.0)) * _394) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625)).xyz), _424);
    float3 _430 = _428;
    _430.z = dot(float4(_397, ((((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _347, level(0.0)) * 2.0) - float4(1.0)) * _397) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625)).xyz), _424);
    bool _452 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _500;
    if (_452)
    {
        float4 _459 = View.View_WorldToClip * float4(_221, 1.0);
        float _460 = _459.w;
        float4 _488;
        if (_452)
        {
            _488 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_459.xy / float2(_460)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_460 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _488 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _500 = float4(_488.xyz + (in.in_var_TEXCOORD7.xyz * _488.w), _488.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _500 = in.in_var_TEXCOORD7;
    }
    float3 _501 = _221 + in.in_var_PARTICLE_LIGHTING_OFFSET;
    float3 _509 = (_501 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _517 = (_501 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _522 = fast::clamp((float3(0.5) - abs(_509 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _527 = (_522.x * _522.y) * _522.z;
    float4 _535 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _517, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _509, level(0.0)), float4(_527));
    float3 _546 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _517, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _509, level(0.0)).xyz, float3(_527)) * 1.0;
    float4 _548 = _144;
    _548.x = _535.x;
    float4 _550 = _144;
    _550.x = _535.y;
    float4 _552 = _144;
    _552.x = _535.z;
    float3 _553 = _535.xyz;
    float3 _557 = _553 / float3(dot(_553, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _559 = _546 * _557.x;
    float3 _562 = _546 * _557.y;
    float3 _565 = _546 * _557.z;
    float3 _568 = _145;
    _568.x = dot(float4(_548.x, _559.x, _559.y, _559.z), _424);
    float3 _570 = _568;
    _570.y = dot(float4(_550.x, _562.x, _562.y, _562.z), _424);
    float3 _572 = _570;
    _572.z = dot(float4(_552.x, _565.x, _565.y, _565.z), _424);
    float3 _586 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _613;
    float3 _614;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        bool _601 = any(abs(_221 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0)));
        float3 _611;
        if (_601)
        {
            _611 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_221, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _611 = _586;
        }
        _613 = _601 ? 1.0 : _311;
        _614 = _611;
    }
    else
    {
        _613 = _311;
        _614 = _586;
    }
    float4 _624 = float4((((mix(_369 * float4(fast::max(float3(0.0), _572), _142).xyz, _369 + (select(_361, float3(0.0), bool3(_364)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((((fast::max(float3(0.0), _430) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) * _369) * fast::max(float3(1.0), ((((((_310 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_310 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_310 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _614) * _500.w) + _500.xyz, _613);
    float3 _628 = _624.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_628.x, _628.y, _628.z, _624.w);
    return out;
}

