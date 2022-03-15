

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

struct type_TranslucentSelfShadow
{
    float4x4 TranslucentSelfShadow_WorldToShadowMatrix;
    float4 TranslucentSelfShadow_ShadowUVMinMax;
    char _m2_pad[16];
    float4 TranslucentSelfShadow_DirectionalLightColor;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _169 = {};
constant float3 _170 = {};

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

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00004f75_b3ff468e(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(6)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(3)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(4)]], constant type_Material& Material [[buffer(5)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(4)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(5)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(6)]], texture2d<float> TranslucentBasePass_SceneTextures_SceneDepthTexture [[texture(7)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(8)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(9)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(10)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(11)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(12)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(13)]], texture2d<float> Material_Texture2D_0 [[texture(14)]], texture2d<float> Material_Texture2D_1 [[texture(15)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_SceneTextures_PointClampSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD3 = {};
    in_var_TEXCOORD3[0] = in.in_var_TEXCOORD3_0;
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _239 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _243 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _248 = (_243.xyz / float3(_243.w)) - View.View_PreViewTranslation;
    float3 _256 = normalize(float3x3(in.in_var_TEXCOORD10.xyz, cross(in.in_var_TEXCOORD11.xyz, in.in_var_TEXCOORD10.xyz) * in.in_var_TEXCOORD11.w, in.in_var_TEXCOORD11.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _270 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD3[0].x, in_var_TEXCOORD3[0].y) * 8.0), bias(View.View_MaterialTextureMipBias));
    float4 _274 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, in.in_var_PARTICLE_SUBUVS.xy);
    float4 _276 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, in.in_var_PARTICLE_SUBUVS.zw);
    float4 _278 = mix(_274, _276, float4(in.in_var_TEXCOORD10.w));
    float _290 = _239.w;
    float4 _300 = TranslucentBasePass_SceneTextures_SceneDepthTexture.sample(TranslucentBasePass_SceneTextures_PointClampSampler, (((_239.xy / float2(_290)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz), level(0.0));
    float _301 = _300.x;
    float _331;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _331 = _290;
                break;
            }
            else
            {
                float _324 = _239.z;
                _331 = ((_324 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_324 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _337 = fast::clamp((_270.xyz + _278.xyz) * in.in_var_TEXCOORD2.xyz, float3(0.0), float3(1.0));
    float _338 = fast::clamp(fast::min(fast::max(in.in_var_TEXCOORD2.w * _278.w, 0.0), 1.0) * fast::min(fast::max(((((_301 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_301 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w))) - _331) * 0.006666666828095912933349609375, 0.0), 1.0), 0.0, 1.0);
    float3 _348 = fast::clamp((_248 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _359 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_348.x), int(_348.y), int(_348.z), 0).xyz), 0));
    float3 _374 = (((_359.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_348 / float3(_359.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float3 _381 = (_337 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _388 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _391 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _396;
    if (_391)
    {
        _396 = _381 + (_388 * 0.449999988079071044921875);
    }
    else
    {
        _396 = _381;
    }
    float4 _402 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _374, level(0.0));
    float _418 = _402.x;
    float _421 = _402.y;
    float _424 = _402.z;
    float4 _441 = _169;
    _441.y = (-0.48860299587249755859375) * _256.y;
    float4 _444 = _441;
    _444.z = 0.48860299587249755859375 * _256.z;
    float4 _447 = _444;
    _447.w = (-0.48860299587249755859375) * _256.x;
    float4 _448 = _447;
    _448.x = 0.886227548122406005859375;
    float3 _450 = _448.yzw * 2.094395160675048828125;
    float4 _451 = float4(_448.x, _450.x, _450.y, _450.z);
    float3 _453 = _170;
    _453.x = dot(float4(_418, ((((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _374, level(0.0)) * 2.0) - float4(1.0)) * _418) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625)).xyz), _451);
    float3 _455 = _453;
    _455.y = dot(float4(_421, ((((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _374, level(0.0)) * 2.0) - float4(1.0)) * _421) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625)).xyz), _451);
    float3 _457 = _455;
    _457.z = dot(float4(_424, ((((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _374, level(0.0)) * 2.0) - float4(1.0)) * _424) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625)).xyz), _451);
    float _486;
    float _487;
    float3 _488;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _473 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _374, level(0.0)).xyz * 2.0) - float3(1.0);
        float _474 = length(_473);
        float3 _477 = _473 / float3(fast::max(_474, 9.9999997473787516355514526367188e-05));
        float _478 = 1.0 - _474;
        float _480 = 1.0 - (_478 * _478);
        _486 = mix(fast::clamp(dot(_477, _256), 0.0, 1.0), 1.0, _480);
        _487 = _474;
        _488 = mix(_477, _256, float3(_480));
    }
    else
    {
        _486 = 1.0;
        _487 = 1.0;
        _488 = _256;
    }
    float4 _492 = float4(_488, 1.0);
    float3 _496 = _170;
    _496.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _492);
    float3 _500 = _496;
    _500.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _492);
    float3 _504 = _500;
    _504.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _492);
    float4 _507 = _492.xyzz * _492.yzzx;
    float3 _511 = _170;
    _511.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _507);
    float3 _515 = _511;
    _515.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _507);
    float3 _519 = _515;
    _519.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _507);
    bool _551 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _599;
    if (_551)
    {
        float4 _558 = View.View_WorldToClip * float4(_248, 1.0);
        float _559 = _558.w;
        float4 _587;
        if (_551)
        {
            _587 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_558.xy / float2(_559)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_559 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _587 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _599 = float4(_587.xyz + (in.in_var_TEXCOORD7.xyz * _587.w), _587.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _599 = in.in_var_TEXCOORD7;
    }
    float3 _600 = _248 + in.in_var_PARTICLE_LIGHTING_OFFSET;
    float3 _608 = (_600 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _616 = (_600 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _621 = fast::clamp((float3(0.5) - abs(_608 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _626 = (_621.x * _621.y) * _621.z;
    float4 _634 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _616, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _608, level(0.0)), float4(_626));
    float3 _645 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _616, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _608, level(0.0)).xyz, float3(_626)) * 1.0;
    float4 _647 = _169;
    _647.x = _634.x;
    float4 _649 = _169;
    _649.x = _634.y;
    float4 _651 = _169;
    _651.x = _634.z;
    float3 _652 = _634.xyz;
    float3 _656 = _652 / float3(dot(_652, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _658 = _645 * _656.x;
    float3 _661 = _645 * _656.y;
    float3 _664 = _645 * _656.z;
    float3 _667 = _170;
    _667.x = dot(float4(_647.x, _658.x, _658.y, _658.z), _451);
    float3 _669 = _667;
    _669.y = dot(float4(_649.x, _661.x, _661.y, _661.z), _451);
    float3 _671 = _669;
    _671.z = dot(float4(_651.x, _664.x, _664.y, _664.z), _451);
    float _673 = _634.w;
    float3 _678 = float4(fast::max(float3(0.0), _671), _673).xyz;
    float3 _744;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _692 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_600, 1.0);
        float2 _696 = _692.xy / float2(_692.w);
        float _697 = _692.z;
        float4 _700 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _696, level(0.0));
        float3 _704 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _697;
        bool2 _729 = _696 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _731 = _696 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _744 = _396 * fast::max(_678 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _673) * (float3(1.0) - select(fast::clamp(exp((float3((((_700.x * _697) * 0.5) + dot((sin(_704) * _700.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_704)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _696, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_729.x || _731.x, _729.y || _731.y)))))), float3(0.0));
    }
    else
    {
        _744 = _396 * _678;
    }
    float3 _751 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _778;
    float3 _779;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        bool _766 = any(abs(_248 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0)));
        float3 _776;
        if (_766)
        {
            _776 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_248, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _776 = _751;
        }
        _778 = _766 ? 1.0 : _338;
        _779 = _776;
    }
    else
    {
        _778 = _338;
        _779 = _751;
    }
    float4 _789 = float4((((mix(_744, _396 + (select(_388, float3(0.0), bool3(_391)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + (((((fast::max(float3(0.0), _457) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_504 + _519) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_488.x * _488.x) - (_488.y * _488.y)))) * View.View_SkyLightColor.xyz) * (_487 * _486))) * _396) * fast::max(float3(1.0), ((((((_337 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_337 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_337 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _779) * _599.w) + _599.xyz, _778);
    float3 _793 = _789.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_793.x, _793.y, _793.z, _789.w);
    return out;
}

