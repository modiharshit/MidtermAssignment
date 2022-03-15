

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
    char _m19_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m21_pad[320];
    float3 View_VolumetricFogInvGridSize;
    float3 View_VolumetricFogGridZParams;
    char _m23_pad[16];
    float3 View_VolumetricLightmapWorldToUVScale;
    float3 View_VolumetricLightmapWorldToUVAdd;
    packed_float3 View_VolumetricLightmapIndirectionTextureSize;
    float View_VolumetricLightmapBrickSize;
    float3 View_VolumetricLightmapBrickTexelSize;
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
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

constant float _147 = {};
constant float4 _149 = {};
constant float3 _150 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPS_in
{
    float4 in_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 in_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 in_var_TEXCOORD0_0 [[user(locn2)]];
    uint in_var_PRIMITIVE_ID [[user(locn3)]];
    float4 in_var_TEXCOORD7 [[user(locn4)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_000046a2_e2b26479(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(4)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(5)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(6)]], texture2d<float> TranslucentBasePass_SceneTextures_SceneDepthTexture [[texture(7)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(8)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(9)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(10)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(11)]], texture2d<float> Material_Texture2D_0 [[texture(12)]], texture2d<float> Material_Texture2D_1 [[texture(13)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_SceneTextures_PointClampSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _214 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _218 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _223 = (_218.xyz / float3(_218.w)) - View.View_PreViewTranslation;
    float3 _231 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _245 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 8.0), bias(View.View_MaterialTextureMipBias));
    float4 _249 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y));
    float _257 = _214.w;
    float4 _267 = TranslucentBasePass_SceneTextures_SceneDepthTexture.sample(TranslucentBasePass_SceneTextures_PointClampSampler, (((_214.xy / float2(_257)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz), level(0.0));
    float _268 = _267.x;
    float _298;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _298 = _257;
                break;
            }
            else
            {
                float _291 = _214.z;
                _298 = ((_291 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_291 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _304 = fast::clamp(_245.xyz + _249.xyz, float3(0.0), float3(1.0));
    float _305 = fast::clamp(fast::min(fast::max(_249.w, 0.0), 1.0) * fast::min(fast::max(((((_268 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_268 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w))) - _298) * 0.006666666828095912933349609375, 0.0), 1.0), 0.0, 1.0);
    float3 _315 = fast::clamp((_223 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _326 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_315.x), int(_315.y), int(_315.z), 0).xyz), 0));
    float3 _341 = (((_326.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_315 / float3(_326.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float3 _348 = (_304 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _355 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _358 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _363;
    if (_358)
    {
        _363 = _348 + (_355 * 0.449999988079071044921875);
    }
    else
    {
        _363 = _348;
    }
    float4 _369 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _341, level(0.0));
    float _385 = _369.x;
    float _388 = _369.y;
    float _391 = _369.z;
    float4 _408 = _149;
    _408.y = (-0.48860299587249755859375) * _231.y;
    float4 _411 = _408;
    _411.z = 0.48860299587249755859375 * _231.z;
    float4 _414 = _411;
    _414.w = (-0.48860299587249755859375) * _231.x;
    float4 _415 = _414;
    _415.x = 0.886227548122406005859375;
    float3 _417 = _415.yzw * 2.094395160675048828125;
    float4 _418 = float4(_415.x, _417.x, _417.y, _417.z);
    float3 _420 = _150;
    _420.x = dot(float4(_385, ((((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _341, level(0.0)) * 2.0) - float4(1.0)) * _385) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625)).xyz), _418);
    float3 _422 = _420;
    _422.y = dot(float4(_388, ((((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _341, level(0.0)) * 2.0) - float4(1.0)) * _388) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625)).xyz), _418);
    float3 _424 = _422;
    _424.z = dot(float4(_391, ((((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _341, level(0.0)) * 2.0) - float4(1.0)) * _391) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625)).xyz), _418);
    float _453;
    float _454;
    float3 _455;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _440 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _341, level(0.0)).xyz * 2.0) - float3(1.0);
        float _441 = length(_440);
        float3 _444 = _440 / float3(fast::max(_441, 9.9999997473787516355514526367188e-05));
        float _445 = 1.0 - _441;
        float _447 = 1.0 - (_445 * _445);
        _453 = mix(fast::clamp(dot(_444, _231), 0.0, 1.0), 1.0, _447);
        _454 = _441;
        _455 = mix(_444, _231, float3(_447));
    }
    else
    {
        _453 = 1.0;
        _454 = 1.0;
        _455 = _231;
    }
    float4 _459 = float4(_455, 1.0);
    float3 _463 = _150;
    _463.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _459);
    float3 _467 = _463;
    _467.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _459);
    float3 _471 = _467;
    _471.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _459);
    float4 _474 = _459.xyzz * _459.yzzx;
    float3 _478 = _150;
    _478.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _474);
    float3 _482 = _478;
    _482.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _474);
    float3 _486 = _482;
    _486.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _474);
    bool _518 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _566;
    if (_518)
    {
        float4 _525 = View.View_WorldToClip * float4(_223, 1.0);
        float _526 = _525.w;
        float4 _554;
        if (_518)
        {
            _554 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_525.xy / float2(_526)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_526 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _554 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _566 = float4(_554.xyz + (in.in_var_TEXCOORD7.xyz * _554.w), _554.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _566 = in.in_var_TEXCOORD7;
    }
    float3 _574 = (_223 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _582 = (_223 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _587 = fast::clamp((float3(0.5) - abs(_574 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _592 = (_587.x * _587.y) * _587.z;
    float4 _600 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _582, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _574, level(0.0)), float4(_592));
    float3 _611 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _582, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _574, level(0.0)).xyz, float3(_592)) * 1.0;
    float4 _613 = _149;
    _613.x = _600.x;
    float4 _615 = _149;
    _615.x = _600.y;
    float4 _617 = _149;
    _617.x = _600.z;
    float3 _618 = _600.xyz;
    float3 _622 = _618 / float3(dot(_618, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _624 = _611 * _622.x;
    float3 _627 = _611 * _622.y;
    float3 _630 = _611 * _622.z;
    float3 _633 = _150;
    _633.x = dot(float4(_613.x, _624.x, _624.y, _624.z), _418);
    float3 _635 = _633;
    _635.y = dot(float4(_615.x, _627.x, _627.y, _627.z), _418);
    float3 _637 = _635;
    _637.z = dot(float4(_617.x, _630.x, _630.y, _630.z), _418);
    float3 _651 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _682;
    float3 _683;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _657 = in.in_var_PRIMITIVE_ID * 36u;
        bool _670 = any(abs(_223 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _657 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _657 + 19u)].xyz + float3(1.0)));
        float3 _680;
        if (_670)
        {
            _680 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_223, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _680 = _651;
        }
        _682 = _670 ? 1.0 : _305;
        _683 = _680;
    }
    else
    {
        _682 = _305;
        _683 = _651;
    }
    float4 _693 = float4((((mix(_363 * float4(fast::max(float3(0.0), _637), _147).xyz, _363 + (select(_355, float3(0.0), bool3(_358)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + (((((fast::max(float3(0.0), _424) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_471 + _486) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_455.x * _455.x) - (_455.y * _455.y)))) * View.View_SkyLightColor.xyz) * (_454 * _453))) * _363) * fast::max(float3(1.0), ((((((_304 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_304 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_304 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _683) * _566.w) + _566.xyz, _682);
    float3 _697 = _693.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_697.x, _697.y, _697.z, _693.w);
    return out;
}

