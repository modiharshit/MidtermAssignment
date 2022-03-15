

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

constant float4 _178 = {};
constant float3 _179 = {};
constant float4 _181 = {};

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

fragment MainPS_out Main_00004eef_03186dd9(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(11)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(12)]], texture2d<float> Material_Texture2D_0 [[texture(13)]], texture2d<float> Material_Texture2D_1 [[texture(14)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _241 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _245 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _250 = (_245.xyz / float3(_245.w)) - View.View_PreViewTranslation;
    float4 _258 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _261 = (_258.xy * float2(2.0)) - float2(1.0);
    float3 _278 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize(((float4(_261, sqrt(fast::clamp(1.0 - dot(_261, _261), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _290 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 20.0), bias(View.View_MaterialTextureMipBias));
    float _292 = mix(0.4000000059604644775390625, 1.0, _290.x);
    float4 _296 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _321;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _321 = _241.w;
                break;
            }
            else
            {
                float _305 = _241.z;
                _321 = ((_305 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_305 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _325 = fast::min(fast::max((_321 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _326 = _296.y;
    float4 _330 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _332 = _330.y;
    float3 _345 = fast::clamp(float3(mix(_292, 1.0 - _292, mix(_326, 1.0, _325)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_332 + mix(_326, 0.0, _325), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _350 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _332) + mix(mix(0.699999988079071044921875, 1.0, _326), 1.0, _325), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _397;
    float _398;
    float _399;
    float3 _400;
    float3 _401;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _367 = ((_241.xy / float2(_241.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _371 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _367, level(0.0));
        float4 _374 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _367, level(0.0));
        float4 _377 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _367, level(0.0));
        float _387 = _377.w;
        _397 = (_350 * _387) + _377.z;
        _398 = (0.5 * _387) + _377.y;
        _399 = _377.x;
        _400 = (_345 * _371.w) + _371.xyz;
        _401 = normalize((_278 * _374.w) + ((_374.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _397 = _350;
        _398 = 0.5;
        _399 = 0.0;
        _400 = _345;
        _401 = _278;
    }
    float3 _411 = fast::clamp((_250 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _422 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_411.x), int(_411.y), int(_411.z), 0).xyz), 0));
    float3 _437 = (((_422.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_411 / float3(_422.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _450;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        _450 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _437, level(0.0)).x;
    }
    else
    {
        _450 = 1.0;
    }
    float3 _464 = ((_400 - (_400 * _399)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _471 = (mix(float3(0.07999999821186065673828125 * _398), _400, float3(_399)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _474 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _479;
    if (_474)
    {
        _479 = _464 + (_471 * 0.449999988079071044921875);
    }
    else
    {
        _479 = _464;
    }
    float3 _481 = select(_471, float3(0.0), bool3(_474));
    float3 _483 = float3(dot(_481, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _500 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _437, level(0.0));
    float _516 = _500.x;
    float4 _518 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _437, level(0.0)) * 2.0) - float4(1.0)) * _516) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _519 = _500.y;
    float4 _521 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _437, level(0.0)) * 2.0) - float4(1.0)) * _519) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _522 = _500.z;
    float4 _524 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _437, level(0.0)) * 2.0) - float4(1.0)) * _522) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _541 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _437, level(0.0)) * 2.0) - float4(1.0)) * _516) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _543 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _437, level(0.0)) * 2.0) - float4(1.0)) * _519) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _545 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _437, level(0.0)) * 2.0) - float4(1.0)) * _522) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _578 = _181;
    _578.y = (-0.48860299587249755859375) * _401.y;
    float4 _581 = _578;
    _581.z = 0.48860299587249755859375 * _401.z;
    float4 _584 = _581;
    _584.w = (-0.48860299587249755859375) * _401.x;
    float3 _585 = _401 * _401;
    float4 _588 = _178;
    _588.x = (1.09254801273345947265625 * _401.x) * _401.y;
    float4 _591 = _588;
    _591.y = ((-1.09254801273345947265625) * _401.y) * _401.z;
    float4 _596 = _591;
    _596.z = 0.3153919875621795654296875 * ((3.0 * _585.z) - 1.0);
    float4 _599 = _596;
    _599.w = ((-1.09254801273345947265625) * _401.x) * _401.z;
    float4 _603 = _584;
    _603.x = 0.886227548122406005859375;
    float3 _605 = _603.yzw * 2.094395160675048828125;
    float4 _606 = float4(_603.x, _605.x, _605.y, _605.z);
    float4 _607 = _599 * 0.785398185253143310546875;
    float _608 = (_585.x - _585.y) * 0.4290426075458526611328125;
    float3 _614 = float3(0.0);
    _614.x = (dot(float4(_516, _518.xyz), _606) + dot(float4(_518.w, _541.xyz), _607)) + (_541.w * _608);
    float3 _620 = _614;
    _620.y = (dot(float4(_519, _521.xyz), _606) + dot(float4(_521.w, _543.xyz), _607)) + (_543.w * _608);
    float3 _626 = _620;
    _626.z = (dot(float4(_522, _524.xyz), _606) + dot(float4(_524.w, _545.xyz), _607)) + (_545.w * _608);
    float _655;
    float _656;
    float3 _657;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _642 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _437, level(0.0)).xyz * 2.0) - float3(1.0);
        float _643 = length(_642);
        float3 _646 = _642 / float3(fast::max(_643, 9.9999997473787516355514526367188e-05));
        float _647 = 1.0 - _643;
        float _649 = 1.0 - (_647 * _647);
        _655 = mix(fast::clamp(dot(_646, _401), 0.0, 1.0), 1.0, _649);
        _656 = _643;
        _657 = mix(_646, _401, float3(_649));
    }
    else
    {
        _655 = 1.0;
        _656 = 1.0;
        _657 = _401;
    }
    float4 _661 = float4(_657, 1.0);
    float3 _665 = _179;
    _665.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _661);
    float3 _669 = _665;
    _669.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _661);
    float3 _673 = _669;
    _673.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _661);
    float4 _676 = _661.xyzz * _661.yzzx;
    float3 _680 = _179;
    _680.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _676);
    float3 _684 = _680;
    _684.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _676);
    float3 _688 = _684;
    _688.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _676);
    float3 _703 = ((fast::max(float3(0.0), _626) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_673 + _688) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_657.x * _657.x) - (_657.y * _657.y)))) * View.View_SkyLightColor.xyz) * (_656 * _655));
    float3 _725 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _751;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _750;
        if (any(abs(_250 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _750 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_250, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _750 = _725;
        }
        _751 = _750;
    }
    else
    {
        _751 = _725;
    }
    float4 _758 = float4(((mix(float3(0.0), _479 + (_481 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_703 * _479) * fast::max(float3(1.0), ((((((_400 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_400 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_400 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _751) * 1.0, 0.0);
    float4 _765;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _764 = _758;
        _764.w = 0.0;
        _765 = _764;
    }
    else
    {
        _765 = _758;
    }
    float2 _769 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _777 = (_401 * 0.5) + float3(0.5);
    float4 _779 = float4(_777.x, _777.y, _777.z, float4(0.0).w);
    _779.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _780 = float4(0.0);
    _780.x = _399;
    float4 _781 = _780;
    _781.y = _398;
    float4 _782 = _781;
    _782.z = _397;
    float4 _783 = _782;
    _783.w = 0.50588238239288330078125;
    float4 _795 = float4(_400.x, _400.y, _400.z, float4(0.0).w);
    _795.w = ((log2(((dot(_703, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_483 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_483 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_483 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_769.xyx * _769.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _765 * View.View_PreExposure;
    out.out_var_SV_Target1 = _779;
    out.out_var_SV_Target2 = _783;
    out.out_var_SV_Target3 = _795;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_450, 1.0, 1.0, 1.0);
    return out;
}

