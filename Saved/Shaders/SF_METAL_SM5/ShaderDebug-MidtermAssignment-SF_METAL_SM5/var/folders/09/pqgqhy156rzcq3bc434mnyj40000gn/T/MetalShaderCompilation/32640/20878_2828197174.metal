

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
    char _m0_pad[448];
    float4x4 View_ViewToClip;
    char _m1_pad[192];
    float4x4 View_SVPositionToTranslatedWorld;
    char _m2_pad[272];
    float4 View_InvDeviceZToWorldZTransform;
    float4 View_ScreenPositionScaleBias;
    char _m4_pad[48];
    float3 View_PreViewTranslation;
    char _m5_pad[928];
    float4 View_ViewRectMin;
    float4 View_ViewSizeAndInvSize;
    char _m7_pad[68];
    float View_PreExposure;
    float4 View_DiffuseOverrideParameter;
    float4 View_SpecularOverrideParameter;
    float4 View_NormalOverrideParameter;
    float2 View_RoughnessOverrideParameter;
    char _m12_pad[8];
    float View_OutOfBoundsMask;
    char _m13_pad[48];
    float View_MaterialTextureMipBias;
    char _m14_pad[28];
    float View_UnlitViewmodeMask;
    char _m15_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m16_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m17_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m19_pad[124];
    float View_ShowDecalsMask;
    char _m20_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m21_pad[48];
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

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _182 = {};
constant float3 _183 = {};
constant float4 _185 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
    float4 out_var_SV_Target1 [[color(1)]];
    float4 out_var_SV_Target2 [[color(2)]];
    float4 out_var_SV_Target3 [[color(3)]];
    float4 out_var_SV_Target4 [[color(4)]];
    float4 out_var_SV_Target5 [[color(5)]];
};

struct MainPS_in
{
    float4 in_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 in_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 in_var_TEXCOORD0_0 [[user(locn2)]];
    uint in_var_PRIMITIVE_ID [[user(locn3)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_0000518e_a892dd36(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(11)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(12)]], texture2d<float> Material_Texture2D_0 [[texture(13)]], texture2d<float> Material_Texture2D_1 [[texture(14)]], texture2d<float> Material_Texture2D_2 [[texture(15)]], texture2d<float> Material_Texture2D_3 [[texture(16)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _245 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _249 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _254 = (_249.xyz / float3(_249.w)) - View.View_PreViewTranslation;
    float4 _260 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _263 = (_260.xy * float2(2.0)) - float2(1.0);
    float4 _275 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _302;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _302 = _245.w;
                break;
            }
            else
            {
                float _286 = _245.z;
                _302 = ((_286 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_286 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _318 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(float4(_263, sqrt(fast::clamp(1.0 - dot(_263, _263), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _275.x) + _302) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _330 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _335 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _340 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _344 = (_330.x + 0.5) * ((_335.x + 0.5) * (_340.x + 0.5));
    float4 _348 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _354 = fast::clamp(_348.xyz * _344, float3(0.0), float3(1.0));
    float _359 = (fast::clamp(mix(0.800000011920928955078125, 0.4000000059604644775390625, _344 * _348.w), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _360 = in.in_var_PRIMITIVE_ID * 36u;
    uint _361 = _360 + 20u;
    float _409;
    float _410;
    float _411;
    float3 _412;
    float3 _413;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _361)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _379 = ((_245.xy / float2(_245.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _383 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _379, level(0.0));
        float4 _386 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _379, level(0.0));
        float4 _389 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _379, level(0.0));
        float _399 = _389.w;
        _409 = (_359 * _399) + _389.z;
        _410 = (0.5 * _399) + _389.y;
        _411 = _389.x;
        _412 = (_354 * _383.w) + _383.xyz;
        _413 = normalize((_318 * _386.w) + ((_386.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _409 = _359;
        _410 = 0.5;
        _411 = 0.0;
        _412 = _354;
        _413 = _318;
    }
    float3 _423 = fast::clamp((_254 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _434 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_423.x), int(_423.y), int(_423.z), 0).xyz), 0));
    float3 _449 = (((_434.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_423 / float3(_434.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _462;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _361)].z > 0.0)
    {
        _462 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _449, level(0.0)).x;
    }
    else
    {
        _462 = 1.0;
    }
    float3 _476 = ((_412 - (_412 * _411)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _483 = (mix(float3(0.07999999821186065673828125 * _410), _412, float3(_411)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _486 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _491;
    if (_486)
    {
        _491 = _476 + (_483 * 0.449999988079071044921875);
    }
    else
    {
        _491 = _476;
    }
    float3 _493 = select(_483, float3(0.0), bool3(_486));
    float3 _495 = float3(dot(_493, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _512 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _449, level(0.0));
    float _528 = _512.x;
    float4 _530 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _449, level(0.0)) * 2.0) - float4(1.0)) * _528) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _531 = _512.y;
    float4 _533 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _449, level(0.0)) * 2.0) - float4(1.0)) * _531) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _534 = _512.z;
    float4 _536 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _449, level(0.0)) * 2.0) - float4(1.0)) * _534) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _553 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _449, level(0.0)) * 2.0) - float4(1.0)) * _528) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _555 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _449, level(0.0)) * 2.0) - float4(1.0)) * _531) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _557 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _449, level(0.0)) * 2.0) - float4(1.0)) * _534) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _590 = _185;
    _590.y = (-0.48860299587249755859375) * _413.y;
    float4 _593 = _590;
    _593.z = 0.48860299587249755859375 * _413.z;
    float4 _596 = _593;
    _596.w = (-0.48860299587249755859375) * _413.x;
    float3 _597 = _413 * _413;
    float4 _600 = _182;
    _600.x = (1.09254801273345947265625 * _413.x) * _413.y;
    float4 _603 = _600;
    _603.y = ((-1.09254801273345947265625) * _413.y) * _413.z;
    float4 _608 = _603;
    _608.z = 0.3153919875621795654296875 * ((3.0 * _597.z) - 1.0);
    float4 _611 = _608;
    _611.w = ((-1.09254801273345947265625) * _413.x) * _413.z;
    float4 _615 = _596;
    _615.x = 0.886227548122406005859375;
    float3 _617 = _615.yzw * 2.094395160675048828125;
    float4 _618 = float4(_615.x, _617.x, _617.y, _617.z);
    float4 _619 = _611 * 0.785398185253143310546875;
    float _620 = (_597.x - _597.y) * 0.4290426075458526611328125;
    float3 _626 = float3(0.0);
    _626.x = (dot(float4(_528, _530.xyz), _618) + dot(float4(_530.w, _553.xyz), _619)) + (_553.w * _620);
    float3 _632 = _626;
    _632.y = (dot(float4(_531, _533.xyz), _618) + dot(float4(_533.w, _555.xyz), _619)) + (_555.w * _620);
    float3 _638 = _632;
    _638.z = (dot(float4(_534, _536.xyz), _618) + dot(float4(_536.w, _557.xyz), _619)) + (_557.w * _620);
    float _667;
    float _668;
    float3 _669;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _654 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _449, level(0.0)).xyz * 2.0) - float3(1.0);
        float _655 = length(_654);
        float3 _658 = _654 / float3(fast::max(_655, 9.9999997473787516355514526367188e-05));
        float _659 = 1.0 - _655;
        float _661 = 1.0 - (_659 * _659);
        _667 = mix(fast::clamp(dot(_658, _413), 0.0, 1.0), 1.0, _661);
        _668 = _655;
        _669 = mix(_658, _413, float3(_661));
    }
    else
    {
        _667 = 1.0;
        _668 = 1.0;
        _669 = _413;
    }
    float4 _673 = float4(_669, 1.0);
    float3 _677 = _183;
    _677.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _673);
    float3 _681 = _677;
    _681.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _673);
    float3 _685 = _681;
    _685.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _673);
    float4 _688 = _673.xyzz * _673.yzzx;
    float3 _692 = _183;
    _692.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _688);
    float3 _696 = _692;
    _696.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _688);
    float3 _700 = _696;
    _700.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _688);
    float3 _715 = ((fast::max(float3(0.0), _638) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_685 + _700) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_669.x * _669.x) - (_669.y * _669.y)))) * View.View_SkyLightColor.xyz) * (_668 * _667));
    float3 _737 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _766;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _765;
        if (any(abs(_254 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _360 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _360 + 19u)].xyz + float3(1.0))))
        {
            _765 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_254, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _765 = _737;
        }
        _766 = _765;
    }
    else
    {
        _766 = _737;
    }
    float4 _773 = float4(((mix(float3(0.0), _491 + (_493 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_715 * _491) * fast::max(float3(1.0), ((((((_412 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_412 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_412 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _766) * 1.0, 0.0);
    float4 _780;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _779 = _773;
        _779.w = 0.0;
        _780 = _779;
    }
    else
    {
        _780 = _773;
    }
    float2 _784 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _792 = (_413 * 0.5) + float3(0.5);
    float4 _794 = float4(_792.x, _792.y, _792.z, float4(0.0).w);
    _794.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _361)].y;
    float4 _795 = float4(0.0);
    _795.x = _411;
    float4 _796 = _795;
    _796.y = _410;
    float4 _797 = _796;
    _797.z = _409;
    float4 _798 = _797;
    _798.w = 0.50588238239288330078125;
    float4 _810 = float4(_412.x, _412.y, _412.z, float4(0.0).w);
    _810.w = ((log2(((dot(_715, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_495 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_495 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_495 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_784.xyx * _784.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _780 * View.View_PreExposure;
    out.out_var_SV_Target1 = _794;
    out.out_var_SV_Target2 = _798;
    out.out_var_SV_Target3 = _810;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_462, 1.0, 1.0, 1.0);
    return out;
}

