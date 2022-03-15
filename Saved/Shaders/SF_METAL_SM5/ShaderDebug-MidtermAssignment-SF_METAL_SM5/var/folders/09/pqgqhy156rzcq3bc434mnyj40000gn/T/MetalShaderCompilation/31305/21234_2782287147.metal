

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

fragment MainPS_out Main_000052f2_a5d6552b(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(11)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(12)]], texture2d<float> Material_Texture2D_0 [[texture(13)]], texture2d<float> Material_Texture2D_1 [[texture(14)]], texture2d<float> Material_Texture2D_2 [[texture(15)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
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
    float2 _273 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125;
    float4 _277 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _273, bias(View.View_MaterialTextureMipBias));
    float _304;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _304 = _245.w;
                break;
            }
            else
            {
                float _288 = _245.z;
                _304 = ((_288 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_288 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _310 = float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _277.x) + _304) - 150.0) * 0.0005000000237487256526947021484375, 0.0), 1.0));
    float3 _319 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(float3(0.5, 0.5, 1.0) * float4(_263, sqrt(fast::clamp(1.0 - dot(_263, _263), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), _310) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _331 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _334 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _343 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.449999988079071044921875), bias(View.View_MaterialTextureMipBias));
    float _344 = _343.x;
    float _348 = _343.y;
    float _352 = _343.z;
    float4 _358 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _273, bias(View.View_MaterialTextureMipBias));
    float _359 = _358.x;
    float _363 = _358.y;
    float _367 = _358.z;
    float3 _375 = fast::min(fast::max(mix(float3((_344 <= 0.0) ? 0.0 : pow(_344, 2.0), (_348 <= 0.0) ? 0.0 : pow(_348, 2.0), (_352 <= 0.0) ? 0.0 : pow(_352, 2.0)), float3((_359 <= 0.0) ? 0.0 : pow(_359, 2.0), (_363 <= 0.0) ? 0.0 : pow(_363, 2.0), (_367 <= 0.0) ? 0.0 : pow(_367, 2.0)), _310) * fast::min(fast::max(1.0 - (_331.x * _334.x), 0.0), 1.0), float3(0.0)), float3(1.0));
    float3 _380 = fast::clamp(mix(_375, float3(dot(_375, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375))), float3(0.4000000059604644775390625)) * 0.699999988079071044921875, float3(0.0), float3(1.0));
    uint _382 = in.in_var_PRIMITIVE_ID * 36u;
    uint _383 = _382 + 20u;
    float _431;
    float _432;
    float _433;
    float3 _434;
    float3 _435;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _383)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _401 = ((_245.xy / float2(_245.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _405 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _401, level(0.0));
        float4 _408 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _401, level(0.0));
        float4 _411 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _401, level(0.0));
        float _421 = _411.w;
        _431 = (View.View_RoughnessOverrideParameter.x * _421) + _411.z;
        _432 = (0.5 * _421) + _411.y;
        _433 = _411.x;
        _434 = (_380 * _405.w) + _405.xyz;
        _435 = normalize((_319 * _408.w) + ((_408.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _431 = View.View_RoughnessOverrideParameter.x;
        _432 = 0.5;
        _433 = 0.0;
        _434 = _380;
        _435 = _319;
    }
    float3 _445 = fast::clamp((_254 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _456 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_445.x), int(_445.y), int(_445.z), 0).xyz), 0));
    float3 _471 = (((_456.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_445 / float3(_456.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _484;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _383)].z > 0.0)
    {
        _484 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _471, level(0.0)).x;
    }
    else
    {
        _484 = 1.0;
    }
    float3 _498 = ((_434 - (_434 * _433)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _505 = (mix(float3(0.07999999821186065673828125 * _432), _434, float3(_433)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _508 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _513;
    if (_508)
    {
        _513 = _498 + (_505 * 0.449999988079071044921875);
    }
    else
    {
        _513 = _498;
    }
    float3 _515 = select(_505, float3(0.0), bool3(_508));
    float3 _517 = float3(dot(_515, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _534 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _471, level(0.0));
    float _550 = _534.x;
    float4 _552 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _471, level(0.0)) * 2.0) - float4(1.0)) * _550) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _553 = _534.y;
    float4 _555 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _471, level(0.0)) * 2.0) - float4(1.0)) * _553) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _556 = _534.z;
    float4 _558 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _471, level(0.0)) * 2.0) - float4(1.0)) * _556) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _575 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _471, level(0.0)) * 2.0) - float4(1.0)) * _550) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _577 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _471, level(0.0)) * 2.0) - float4(1.0)) * _553) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _579 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _471, level(0.0)) * 2.0) - float4(1.0)) * _556) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _612 = _185;
    _612.y = (-0.48860299587249755859375) * _435.y;
    float4 _615 = _612;
    _615.z = 0.48860299587249755859375 * _435.z;
    float4 _618 = _615;
    _618.w = (-0.48860299587249755859375) * _435.x;
    float3 _619 = _435 * _435;
    float4 _622 = _182;
    _622.x = (1.09254801273345947265625 * _435.x) * _435.y;
    float4 _625 = _622;
    _625.y = ((-1.09254801273345947265625) * _435.y) * _435.z;
    float4 _630 = _625;
    _630.z = 0.3153919875621795654296875 * ((3.0 * _619.z) - 1.0);
    float4 _633 = _630;
    _633.w = ((-1.09254801273345947265625) * _435.x) * _435.z;
    float4 _637 = _618;
    _637.x = 0.886227548122406005859375;
    float3 _639 = _637.yzw * 2.094395160675048828125;
    float4 _640 = float4(_637.x, _639.x, _639.y, _639.z);
    float4 _641 = _633 * 0.785398185253143310546875;
    float _642 = (_619.x - _619.y) * 0.4290426075458526611328125;
    float3 _648 = float3(0.0);
    _648.x = (dot(float4(_550, _552.xyz), _640) + dot(float4(_552.w, _575.xyz), _641)) + (_575.w * _642);
    float3 _654 = _648;
    _654.y = (dot(float4(_553, _555.xyz), _640) + dot(float4(_555.w, _577.xyz), _641)) + (_577.w * _642);
    float3 _660 = _654;
    _660.z = (dot(float4(_556, _558.xyz), _640) + dot(float4(_558.w, _579.xyz), _641)) + (_579.w * _642);
    float _689;
    float _690;
    float3 _691;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _676 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _471, level(0.0)).xyz * 2.0) - float3(1.0);
        float _677 = length(_676);
        float3 _680 = _676 / float3(fast::max(_677, 9.9999997473787516355514526367188e-05));
        float _681 = 1.0 - _677;
        float _683 = 1.0 - (_681 * _681);
        _689 = mix(fast::clamp(dot(_680, _435), 0.0, 1.0), 1.0, _683);
        _690 = _677;
        _691 = mix(_680, _435, float3(_683));
    }
    else
    {
        _689 = 1.0;
        _690 = 1.0;
        _691 = _435;
    }
    float4 _695 = float4(_691, 1.0);
    float3 _699 = _183;
    _699.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _695);
    float3 _703 = _699;
    _703.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _695);
    float3 _707 = _703;
    _707.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _695);
    float4 _710 = _695.xyzz * _695.yzzx;
    float3 _714 = _183;
    _714.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _710);
    float3 _718 = _714;
    _718.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _710);
    float3 _722 = _718;
    _722.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _710);
    float3 _737 = ((fast::max(float3(0.0), _660) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_707 + _722) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_691.x * _691.x) - (_691.y * _691.y)))) * View.View_SkyLightColor.xyz) * (_690 * _689));
    float3 _759 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _788;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _787;
        if (any(abs(_254 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _382 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _382 + 19u)].xyz + float3(1.0))))
        {
            _787 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_254, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _787 = _759;
        }
        _788 = _787;
    }
    else
    {
        _788 = _759;
    }
    float4 _795 = float4(((mix(float3(0.0), _513 + (_515 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_737 * _513) * fast::max(float3(1.0), ((((((_434 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_434 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_434 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _788) * 1.0, 0.0);
    float4 _802;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _801 = _795;
        _801.w = 0.0;
        _802 = _801;
    }
    else
    {
        _802 = _795;
    }
    float2 _806 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _814 = (_435 * 0.5) + float3(0.5);
    float4 _816 = float4(_814.x, _814.y, _814.z, float4(0.0).w);
    _816.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _383)].y;
    float4 _817 = float4(0.0);
    _817.x = _433;
    float4 _818 = _817;
    _818.y = _432;
    float4 _819 = _818;
    _819.z = _431;
    float4 _820 = _819;
    _820.w = 0.50588238239288330078125;
    float4 _832 = float4(_434.x, _434.y, _434.z, float4(0.0).w);
    _832.w = ((log2(((dot(_737, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_517 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_517 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_517 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_806.xyx * _806.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _802 * View.View_PreExposure;
    out.out_var_SV_Target1 = _816;
    out.out_var_SV_Target2 = _820;
    out.out_var_SV_Target3 = _832;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_484, 1.0, 1.0, 1.0);
    return out;
}

