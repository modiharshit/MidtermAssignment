

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
    float4 in_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 in_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 in_var_TEXCOORD0_0 [[user(locn2)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00004e66_ae580c1b(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(11)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(12)]], texture2d<float> Material_Texture2D_0 [[texture(13)]], texture2d<float> Material_Texture2D_1 [[texture(14)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _240 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _244 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _249 = (_244.xyz / float3(_244.w)) - View.View_PreViewTranslation;
    float4 _257 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (in_var_TEXCOORD0[0].xy * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _260 = (_257.xy * float2(2.0)) - float2(1.0);
    float3 _277 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize(((float4(_260, sqrt(fast::clamp(1.0 - dot(_260, _260), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _289 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in_var_TEXCOORD0[0].xy * 20.0), bias(View.View_MaterialTextureMipBias));
    float _291 = mix(0.4000000059604644775390625, 1.0, _289.x);
    float4 _295 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in_var_TEXCOORD0[0].xy * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _320;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _320 = _240.w;
                break;
            }
            else
            {
                float _304 = _240.z;
                _320 = ((_304 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_304 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _324 = fast::min(fast::max((_320 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _325 = _295.y;
    float4 _329 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in_var_TEXCOORD0[0].xy * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _331 = _329.y;
    float3 _344 = fast::clamp(float3(mix(_291, 1.0 - _291, mix(_325, 1.0, _324)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_331 + mix(_325, 0.0, _324), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _349 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _331) + mix(mix(0.699999988079071044921875, 1.0, _325), 1.0, _324), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _396;
    float _397;
    float _398;
    float3 _399;
    float3 _400;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _366 = ((_240.xy / float2(_240.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _370 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _366, level(0.0));
        float4 _373 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _366, level(0.0));
        float4 _376 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _366, level(0.0));
        float _386 = _376.w;
        _396 = (_349 * _386) + _376.z;
        _397 = (0.5 * _386) + _376.y;
        _398 = _376.x;
        _399 = (_344 * _370.w) + _370.xyz;
        _400 = normalize((_277 * _373.w) + ((_373.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _396 = _349;
        _397 = 0.5;
        _398 = 0.0;
        _399 = _344;
        _400 = _277;
    }
    float3 _410 = fast::clamp((_249 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _421 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_410.x), int(_410.y), int(_410.z), 0).xyz), 0));
    float3 _436 = (((_421.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_410 / float3(_421.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _449;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        _449 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _436, level(0.0)).x;
    }
    else
    {
        _449 = 1.0;
    }
    float3 _463 = ((_399 - (_399 * _398)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _470 = (mix(float3(0.07999999821186065673828125 * _397), _399, float3(_398)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _473 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _478;
    if (_473)
    {
        _478 = _463 + (_470 * 0.449999988079071044921875);
    }
    else
    {
        _478 = _463;
    }
    float3 _480 = select(_470, float3(0.0), bool3(_473));
    float3 _482 = float3(dot(_480, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _499 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _436, level(0.0));
    float _515 = _499.x;
    float4 _517 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _436, level(0.0)) * 2.0) - float4(1.0)) * _515) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _518 = _499.y;
    float4 _520 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _436, level(0.0)) * 2.0) - float4(1.0)) * _518) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _521 = _499.z;
    float4 _523 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _436, level(0.0)) * 2.0) - float4(1.0)) * _521) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _540 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _436, level(0.0)) * 2.0) - float4(1.0)) * _515) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _542 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _436, level(0.0)) * 2.0) - float4(1.0)) * _518) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _544 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _436, level(0.0)) * 2.0) - float4(1.0)) * _521) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _577 = _180;
    _577.y = (-0.48860299587249755859375) * _400.y;
    float4 _580 = _577;
    _580.z = 0.48860299587249755859375 * _400.z;
    float4 _583 = _580;
    _583.w = (-0.48860299587249755859375) * _400.x;
    float3 _584 = _400 * _400;
    float4 _587 = _177;
    _587.x = (1.09254801273345947265625 * _400.x) * _400.y;
    float4 _590 = _587;
    _590.y = ((-1.09254801273345947265625) * _400.y) * _400.z;
    float4 _595 = _590;
    _595.z = 0.3153919875621795654296875 * ((3.0 * _584.z) - 1.0);
    float4 _598 = _595;
    _598.w = ((-1.09254801273345947265625) * _400.x) * _400.z;
    float4 _602 = _583;
    _602.x = 0.886227548122406005859375;
    float3 _604 = _602.yzw * 2.094395160675048828125;
    float4 _605 = float4(_602.x, _604.x, _604.y, _604.z);
    float4 _606 = _598 * 0.785398185253143310546875;
    float _607 = (_584.x - _584.y) * 0.4290426075458526611328125;
    float3 _613 = float3(0.0);
    _613.x = (dot(float4(_515, _517.xyz), _605) + dot(float4(_517.w, _540.xyz), _606)) + (_540.w * _607);
    float3 _619 = _613;
    _619.y = (dot(float4(_518, _520.xyz), _605) + dot(float4(_520.w, _542.xyz), _606)) + (_542.w * _607);
    float3 _625 = _619;
    _625.z = (dot(float4(_521, _523.xyz), _605) + dot(float4(_523.w, _544.xyz), _606)) + (_544.w * _607);
    float _654;
    float _655;
    float3 _656;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _641 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _436, level(0.0)).xyz * 2.0) - float3(1.0);
        float _642 = length(_641);
        float3 _645 = _641 / float3(fast::max(_642, 9.9999997473787516355514526367188e-05));
        float _646 = 1.0 - _642;
        float _648 = 1.0 - (_646 * _646);
        _654 = mix(fast::clamp(dot(_645, _400), 0.0, 1.0), 1.0, _648);
        _655 = _642;
        _656 = mix(_645, _400, float3(_648));
    }
    else
    {
        _654 = 1.0;
        _655 = 1.0;
        _656 = _400;
    }
    float4 _660 = float4(_656, 1.0);
    float3 _664 = _178;
    _664.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _660);
    float3 _668 = _664;
    _668.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _660);
    float3 _672 = _668;
    _672.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _660);
    float4 _675 = _660.xyzz * _660.yzzx;
    float3 _679 = _178;
    _679.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _675);
    float3 _683 = _679;
    _683.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _675);
    float3 _687 = _683;
    _687.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _675);
    float3 _702 = ((fast::max(float3(0.0), _625) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_672 + _687) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_656.x * _656.x) - (_656.y * _656.y)))) * View.View_SkyLightColor.xyz) * (_655 * _654));
    float3 _724 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _750;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _749;
        if (any(abs(_249 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _749 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_249, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _749 = _724;
        }
        _750 = _749;
    }
    else
    {
        _750 = _724;
    }
    float4 _757 = float4(((mix(float3(0.0), _478 + (_480 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_702 * _478) * fast::max(float3(1.0), ((((((_399 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_399 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_399 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _750) * 1.0, 0.0);
    float4 _764;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _763 = _757;
        _763.w = 0.0;
        _764 = _763;
    }
    else
    {
        _764 = _757;
    }
    float2 _768 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _776 = (_400 * 0.5) + float3(0.5);
    float4 _778 = float4(_776.x, _776.y, _776.z, float4(0.0).w);
    _778.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _779 = float4(0.0);
    _779.x = _398;
    float4 _780 = _779;
    _780.y = _397;
    float4 _781 = _780;
    _781.z = _396;
    float4 _782 = _781;
    _782.w = 0.50588238239288330078125;
    float4 _794 = float4(_399.x, _399.y, _399.z, float4(0.0).w);
    _794.w = ((log2(((dot(_702, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_482 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_482 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_482 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_768.xyx * _768.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _764 * View.View_PreExposure;
    out.out_var_SV_Target1 = _778;
    out.out_var_SV_Target2 = _782;
    out.out_var_SV_Target3 = _794;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_449, 1.0, 1.0, 1.0);
    return out;
}

