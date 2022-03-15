

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

struct type_Primitive
{
    char _m0_pad[80];
    float4 Primitive_ObjectWorldPositionAndRadius;
    char _m1_pad[208];
    float3 Primitive_ObjectBounds;
    float Primitive_DecalReceiverMask;
    float Primitive_PerObjectGBufferData;
    float Primitive_UseVolumetricLightmapShadowFromStationaryLights;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _177 = {};
constant float3 _178 = {};
constant float4 _180 = {};

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
    float2 in_var_TEXCOORD0_0 [[user(locn0)]];
    float4 in_var_TEXCOORD10_centroid [[user(locn1)]];
    float4 in_var_TEXCOORD11_centroid [[user(locn2)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00004e61_aa9f343c(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(11)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(12)]], texture2d<float> Material_Texture2D_0 [[texture(13)]], texture2d<float> Material_Texture2D_1 [[texture(14)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float2, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _239 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _243 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _248 = (_243.xyz / float3(_243.w)) - View.View_PreViewTranslation;
    float4 _256 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (in_var_TEXCOORD0[0] * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _259 = (_256.xy * float2(2.0)) - float2(1.0);
    float3 _276 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize(((float4(_259, sqrt(fast::clamp(1.0 - dot(_259, _259), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _288 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in_var_TEXCOORD0[0] * 20.0), bias(View.View_MaterialTextureMipBias));
    float _290 = mix(0.4000000059604644775390625, 1.0, _288.x);
    float4 _294 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in_var_TEXCOORD0[0] * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _319;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _319 = _239.w;
                break;
            }
            else
            {
                float _303 = _239.z;
                _319 = ((_303 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_303 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _323 = fast::min(fast::max((_319 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _324 = _294.y;
    float4 _328 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in_var_TEXCOORD0[0] * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _330 = _328.y;
    float3 _343 = fast::clamp(float3(mix(_290, 1.0 - _290, mix(_324, 1.0, _323)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_330 + mix(_324, 0.0, _323), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _348 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _330) + mix(mix(0.699999988079071044921875, 1.0, _324), 1.0, _323), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _395;
    float _396;
    float _397;
    float3 _398;
    float3 _399;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _365 = ((_239.xy / float2(_239.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _369 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _365, level(0.0));
        float4 _372 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _365, level(0.0));
        float4 _375 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _365, level(0.0));
        float _385 = _375.w;
        _395 = (_348 * _385) + _375.z;
        _396 = (0.5 * _385) + _375.y;
        _397 = _375.x;
        _398 = (_343 * _369.w) + _369.xyz;
        _399 = normalize((_276 * _372.w) + ((_372.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _395 = _348;
        _396 = 0.5;
        _397 = 0.0;
        _398 = _343;
        _399 = _276;
    }
    float3 _409 = fast::clamp((_248 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _420 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_409.x), int(_409.y), int(_409.z), 0).xyz), 0));
    float3 _435 = (((_420.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_409 / float3(_420.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _448;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        _448 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _435, level(0.0)).x;
    }
    else
    {
        _448 = 1.0;
    }
    float3 _462 = ((_398 - (_398 * _397)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _469 = (mix(float3(0.07999999821186065673828125 * _396), _398, float3(_397)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _472 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _477;
    if (_472)
    {
        _477 = _462 + (_469 * 0.449999988079071044921875);
    }
    else
    {
        _477 = _462;
    }
    float3 _479 = select(_469, float3(0.0), bool3(_472));
    float3 _481 = float3(dot(_479, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _498 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _435, level(0.0));
    float _514 = _498.x;
    float4 _516 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _435, level(0.0)) * 2.0) - float4(1.0)) * _514) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _517 = _498.y;
    float4 _519 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _435, level(0.0)) * 2.0) - float4(1.0)) * _517) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _520 = _498.z;
    float4 _522 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _435, level(0.0)) * 2.0) - float4(1.0)) * _520) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _539 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _435, level(0.0)) * 2.0) - float4(1.0)) * _514) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _541 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _435, level(0.0)) * 2.0) - float4(1.0)) * _517) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _543 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _435, level(0.0)) * 2.0) - float4(1.0)) * _520) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _576 = _180;
    _576.y = (-0.48860299587249755859375) * _399.y;
    float4 _579 = _576;
    _579.z = 0.48860299587249755859375 * _399.z;
    float4 _582 = _579;
    _582.w = (-0.48860299587249755859375) * _399.x;
    float3 _583 = _399 * _399;
    float4 _586 = _177;
    _586.x = (1.09254801273345947265625 * _399.x) * _399.y;
    float4 _589 = _586;
    _589.y = ((-1.09254801273345947265625) * _399.y) * _399.z;
    float4 _594 = _589;
    _594.z = 0.3153919875621795654296875 * ((3.0 * _583.z) - 1.0);
    float4 _597 = _594;
    _597.w = ((-1.09254801273345947265625) * _399.x) * _399.z;
    float4 _601 = _582;
    _601.x = 0.886227548122406005859375;
    float3 _603 = _601.yzw * 2.094395160675048828125;
    float4 _604 = float4(_601.x, _603.x, _603.y, _603.z);
    float4 _605 = _597 * 0.785398185253143310546875;
    float _606 = (_583.x - _583.y) * 0.4290426075458526611328125;
    float3 _612 = float3(0.0);
    _612.x = (dot(float4(_514, _516.xyz), _604) + dot(float4(_516.w, _539.xyz), _605)) + (_539.w * _606);
    float3 _618 = _612;
    _618.y = (dot(float4(_517, _519.xyz), _604) + dot(float4(_519.w, _541.xyz), _605)) + (_541.w * _606);
    float3 _624 = _618;
    _624.z = (dot(float4(_520, _522.xyz), _604) + dot(float4(_522.w, _543.xyz), _605)) + (_543.w * _606);
    float _653;
    float _654;
    float3 _655;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _640 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _435, level(0.0)).xyz * 2.0) - float3(1.0);
        float _641 = length(_640);
        float3 _644 = _640 / float3(fast::max(_641, 9.9999997473787516355514526367188e-05));
        float _645 = 1.0 - _641;
        float _647 = 1.0 - (_645 * _645);
        _653 = mix(fast::clamp(dot(_644, _399), 0.0, 1.0), 1.0, _647);
        _654 = _641;
        _655 = mix(_644, _399, float3(_647));
    }
    else
    {
        _653 = 1.0;
        _654 = 1.0;
        _655 = _399;
    }
    float4 _659 = float4(_655, 1.0);
    float3 _663 = _178;
    _663.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _659);
    float3 _667 = _663;
    _667.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _659);
    float3 _671 = _667;
    _671.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _659);
    float4 _674 = _659.xyzz * _659.yzzx;
    float3 _678 = _178;
    _678.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _674);
    float3 _682 = _678;
    _682.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _674);
    float3 _686 = _682;
    _686.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _674);
    float3 _701 = ((fast::max(float3(0.0), _624) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_671 + _686) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_655.x * _655.x) - (_655.y * _655.y)))) * View.View_SkyLightColor.xyz) * (_654 * _653));
    float3 _723 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _749;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _748;
        if (any(abs(_248 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _748 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_248, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _748 = _723;
        }
        _749 = _748;
    }
    else
    {
        _749 = _723;
    }
    float4 _756 = float4(((mix(float3(0.0), _477 + (_479 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_701 * _477) * fast::max(float3(1.0), ((((((_398 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_398 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_398 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _749) * 1.0, 0.0);
    float4 _763;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _762 = _756;
        _762.w = 0.0;
        _763 = _762;
    }
    else
    {
        _763 = _756;
    }
    float2 _767 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _775 = (_399 * 0.5) + float3(0.5);
    float4 _777 = float4(_775.x, _775.y, _775.z, float4(0.0).w);
    _777.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _778 = float4(0.0);
    _778.x = _397;
    float4 _779 = _778;
    _779.y = _396;
    float4 _780 = _779;
    _780.z = _395;
    float4 _781 = _780;
    _781.w = 0.50588238239288330078125;
    float4 _793 = float4(_398.x, _398.y, _398.z, float4(0.0).w);
    _793.w = ((log2(((dot(_701, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_481 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_481 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_481 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_767.xyx * _767.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _763 * View.View_PreExposure;
    out.out_var_SV_Target1 = _777;
    out.out_var_SV_Target2 = _781;
    out.out_var_SV_Target3 = _793;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_448, 1.0, 1.0, 1.0);
    return out;
}

