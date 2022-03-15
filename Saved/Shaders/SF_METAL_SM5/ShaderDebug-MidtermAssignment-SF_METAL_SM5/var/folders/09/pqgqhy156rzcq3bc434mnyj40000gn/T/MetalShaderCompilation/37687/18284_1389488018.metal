

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

constant float _151 = {};
constant float4 _153 = {};
constant float3 _154 = {};

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

fragment MainPS_out Main_0000476c_52d1e792(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(4)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(5)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(6)]], texture2d<float> TranslucentBasePass_SceneTextures_SceneDepthTexture [[texture(7)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(8)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(9)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(10)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(11)]], texture2d<float> Material_Texture2D_0 [[texture(12)]], texture2d<float> Material_Texture2D_1 [[texture(13)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_SceneTextures_PointClampSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _224 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _228 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _233 = (_228.xyz / float3(_228.w)) - View.View_PreViewTranslation;
    float3 _241 = normalize(float3x3(in.in_var_TANGENTX.xyz, cross(in.in_var_TANGENTZ.xyz, in.in_var_TANGENTX.xyz) * in.in_var_TANGENTZ.w, in.in_var_TANGENTZ.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _255 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 8.0), bias(View.View_MaterialTextureMipBias));
    float4 _259 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, in.in_var_PARTICLE_SUBUVS.xy);
    float4 _261 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, in.in_var_PARTICLE_SUBUVS.zw);
    float4 _263 = mix(_259, _261, float4(in.in_var_TEXCOORD4.x));
    float _275 = _224.w;
    float4 _285 = TranslucentBasePass_SceneTextures_SceneDepthTexture.sample(TranslucentBasePass_SceneTextures_PointClampSampler, (((_224.xy / float2(_275)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz), level(0.0));
    float _286 = _285.x;
    float _316;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _316 = _275;
                break;
            }
            else
            {
                float _309 = _224.z;
                _316 = ((_309 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_309 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _322 = fast::clamp((_255.xyz + _263.xyz) * in.in_var_TEXCOORD5.xyz, float3(0.0), float3(1.0));
    float _323 = fast::clamp(fast::min(fast::max(in.in_var_TEXCOORD5.w * _263.w, 0.0), 1.0) * fast::min(fast::max(((((_286 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_286 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w))) - _316) * 0.006666666828095912933349609375, 0.0), 1.0), 0.0, 1.0);
    float3 _333 = fast::clamp((_233 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _344 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_333.x), int(_333.y), int(_333.z), 0).xyz), 0));
    float3 _359 = (((_344.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_333 / float3(_344.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float3 _366 = (_322 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _373 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _376 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _381;
    if (_376)
    {
        _381 = _366 + (_373 * 0.449999988079071044921875);
    }
    else
    {
        _381 = _366;
    }
    float4 _387 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _359, level(0.0));
    float _403 = _387.x;
    float _406 = _387.y;
    float _409 = _387.z;
    float4 _426 = _153;
    _426.y = (-0.48860299587249755859375) * _241.y;
    float4 _429 = _426;
    _429.z = 0.48860299587249755859375 * _241.z;
    float4 _432 = _429;
    _432.w = (-0.48860299587249755859375) * _241.x;
    float4 _433 = _432;
    _433.x = 0.886227548122406005859375;
    float3 _435 = _433.yzw * 2.094395160675048828125;
    float4 _436 = float4(_433.x, _435.x, _435.y, _435.z);
    float3 _438 = _154;
    _438.x = dot(float4(_403, ((((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _359, level(0.0)) * 2.0) - float4(1.0)) * _403) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625)).xyz), _436);
    float3 _440 = _438;
    _440.y = dot(float4(_406, ((((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _359, level(0.0)) * 2.0) - float4(1.0)) * _406) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625)).xyz), _436);
    float3 _442 = _440;
    _442.z = dot(float4(_409, ((((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _359, level(0.0)) * 2.0) - float4(1.0)) * _409) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625)).xyz), _436);
    float _471;
    float _472;
    float3 _473;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _458 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _359, level(0.0)).xyz * 2.0) - float3(1.0);
        float _459 = length(_458);
        float3 _462 = _458 / float3(fast::max(_459, 9.9999997473787516355514526367188e-05));
        float _463 = 1.0 - _459;
        float _465 = 1.0 - (_463 * _463);
        _471 = mix(fast::clamp(dot(_462, _241), 0.0, 1.0), 1.0, _465);
        _472 = _459;
        _473 = mix(_462, _241, float3(_465));
    }
    else
    {
        _471 = 1.0;
        _472 = 1.0;
        _473 = _241;
    }
    float4 _477 = float4(_473, 1.0);
    float3 _481 = _154;
    _481.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _477);
    float3 _485 = _481;
    _485.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _477);
    float3 _489 = _485;
    _489.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _477);
    float4 _492 = _477.xyzz * _477.yzzx;
    float3 _496 = _154;
    _496.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _492);
    float3 _500 = _496;
    _500.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _492);
    float3 _504 = _500;
    _504.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _492);
    bool _536 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _584;
    if (_536)
    {
        float4 _543 = View.View_WorldToClip * float4(_233, 1.0);
        float _544 = _543.w;
        float4 _572;
        if (_536)
        {
            _572 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_543.xy / float2(_544)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_544 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _572 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _584 = float4(_572.xyz + (in.in_var_TEXCOORD7.xyz * _572.w), _572.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _584 = in.in_var_TEXCOORD7;
    }
    float3 _585 = _233 + in.in_var_PARTICLE_LIGHTING_OFFSET;
    float3 _593 = (_585 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _601 = (_585 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _606 = fast::clamp((float3(0.5) - abs(_593 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _611 = (_606.x * _606.y) * _606.z;
    float4 _619 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _601, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _593, level(0.0)), float4(_611));
    float3 _630 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _601, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _593, level(0.0)).xyz, float3(_611)) * 1.0;
    float4 _632 = _153;
    _632.x = _619.x;
    float4 _634 = _153;
    _634.x = _619.y;
    float4 _636 = _153;
    _636.x = _619.z;
    float3 _637 = _619.xyz;
    float3 _641 = _637 / float3(dot(_637, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _643 = _630 * _641.x;
    float3 _646 = _630 * _641.y;
    float3 _649 = _630 * _641.z;
    float3 _652 = _154;
    _652.x = dot(float4(_632.x, _643.x, _643.y, _643.z), _436);
    float3 _654 = _652;
    _654.y = dot(float4(_634.x, _646.x, _646.y, _646.z), _436);
    float3 _656 = _654;
    _656.z = dot(float4(_636.x, _649.x, _649.y, _649.z), _436);
    float3 _670 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _697;
    float3 _698;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        bool _685 = any(abs(_233 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0)));
        float3 _695;
        if (_685)
        {
            _695 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_233, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _695 = _670;
        }
        _697 = _685 ? 1.0 : _323;
        _698 = _695;
    }
    else
    {
        _697 = _323;
        _698 = _670;
    }
    float4 _708 = float4((((mix(_381 * float4(fast::max(float3(0.0), _656), _151).xyz, _381 + (select(_373, float3(0.0), bool3(_376)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + (((((fast::max(float3(0.0), _442) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_489 + _504) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_473.x * _473.x) - (_473.y * _473.y)))) * View.View_SkyLightColor.xyz) * (_472 * _471))) * _381) * fast::max(float3(1.0), ((((((_322 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_322 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_322 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _698) * _584.w) + _584.xyz, _697);
    float3 _712 = _708.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_712.x, _712.y, _712.z, _708.w);
    return out;
}

