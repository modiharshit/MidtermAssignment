

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

constant float4 _179 = {};
constant float3 _180 = {};
constant float4 _182 = {};

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
    float4 in_var_TEXCOORD0_0 [[user(locn3)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00004ee4_cd355fcc(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(11)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(12)]], texture2d<float> Material_Texture2D_0 [[texture(13)]], texture2d<float> Material_Texture2D_1 [[texture(14)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _242 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _246 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _251 = (_246.xyz / float3(_246.w)) - View.View_PreViewTranslation;
    float4 _259 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _262 = (_259.xy * float2(2.0)) - float2(1.0);
    float3 _279 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize(((float4(_262, sqrt(fast::clamp(1.0 - dot(_262, _262), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _291 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 20.0), bias(View.View_MaterialTextureMipBias));
    float _293 = mix(0.4000000059604644775390625, 1.0, _291.x);
    float4 _297 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _322;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _322 = _242.w;
                break;
            }
            else
            {
                float _306 = _242.z;
                _322 = ((_306 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_306 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _326 = fast::min(fast::max((_322 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _327 = _297.y;
    float4 _331 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _333 = _331.y;
    float3 _346 = fast::clamp(float3(mix(_293, 1.0 - _293, mix(_327, 1.0, _326)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_333 + mix(_327, 0.0, _326), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _351 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _333) + mix(mix(0.699999988079071044921875, 1.0, _327), 1.0, _326), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _398;
    float _399;
    float _400;
    float3 _401;
    float3 _402;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _368 = ((_242.xy / float2(_242.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _372 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _368, level(0.0));
        float4 _375 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _368, level(0.0));
        float4 _378 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _368, level(0.0));
        float _388 = _378.w;
        _398 = (_351 * _388) + _378.z;
        _399 = (0.5 * _388) + _378.y;
        _400 = _378.x;
        _401 = (_346 * _372.w) + _372.xyz;
        _402 = normalize((_279 * _375.w) + ((_375.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _398 = _351;
        _399 = 0.5;
        _400 = 0.0;
        _401 = _346;
        _402 = _279;
    }
    float3 _412 = fast::clamp((_251 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _423 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_412.x), int(_412.y), int(_412.z), 0).xyz), 0));
    float3 _438 = (((_423.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_412 / float3(_423.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _451;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        _451 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _438, level(0.0)).x;
    }
    else
    {
        _451 = 1.0;
    }
    float3 _465 = ((_401 - (_401 * _400)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _472 = (mix(float3(0.07999999821186065673828125 * _399), _401, float3(_400)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _475 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _480;
    if (_475)
    {
        _480 = _465 + (_472 * 0.449999988079071044921875);
    }
    else
    {
        _480 = _465;
    }
    float3 _482 = select(_472, float3(0.0), bool3(_475));
    float3 _484 = float3(dot(_482, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _501 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _438, level(0.0));
    float _517 = _501.x;
    float4 _519 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _438, level(0.0)) * 2.0) - float4(1.0)) * _517) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _520 = _501.y;
    float4 _522 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _438, level(0.0)) * 2.0) - float4(1.0)) * _520) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _523 = _501.z;
    float4 _525 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _438, level(0.0)) * 2.0) - float4(1.0)) * _523) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _542 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _438, level(0.0)) * 2.0) - float4(1.0)) * _517) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _544 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _438, level(0.0)) * 2.0) - float4(1.0)) * _520) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _546 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _438, level(0.0)) * 2.0) - float4(1.0)) * _523) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _579 = _182;
    _579.y = (-0.48860299587249755859375) * _402.y;
    float4 _582 = _579;
    _582.z = 0.48860299587249755859375 * _402.z;
    float4 _585 = _582;
    _585.w = (-0.48860299587249755859375) * _402.x;
    float3 _586 = _402 * _402;
    float4 _589 = _179;
    _589.x = (1.09254801273345947265625 * _402.x) * _402.y;
    float4 _592 = _589;
    _592.y = ((-1.09254801273345947265625) * _402.y) * _402.z;
    float4 _597 = _592;
    _597.z = 0.3153919875621795654296875 * ((3.0 * _586.z) - 1.0);
    float4 _600 = _597;
    _600.w = ((-1.09254801273345947265625) * _402.x) * _402.z;
    float4 _604 = _585;
    _604.x = 0.886227548122406005859375;
    float3 _606 = _604.yzw * 2.094395160675048828125;
    float4 _607 = float4(_604.x, _606.x, _606.y, _606.z);
    float4 _608 = _600 * 0.785398185253143310546875;
    float _609 = (_586.x - _586.y) * 0.4290426075458526611328125;
    float3 _615 = float3(0.0);
    _615.x = (dot(float4(_517, _519.xyz), _607) + dot(float4(_519.w, _542.xyz), _608)) + (_542.w * _609);
    float3 _621 = _615;
    _621.y = (dot(float4(_520, _522.xyz), _607) + dot(float4(_522.w, _544.xyz), _608)) + (_544.w * _609);
    float3 _627 = _621;
    _627.z = (dot(float4(_523, _525.xyz), _607) + dot(float4(_525.w, _546.xyz), _608)) + (_546.w * _609);
    float _656;
    float _657;
    float3 _658;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _643 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _438, level(0.0)).xyz * 2.0) - float3(1.0);
        float _644 = length(_643);
        float3 _647 = _643 / float3(fast::max(_644, 9.9999997473787516355514526367188e-05));
        float _648 = 1.0 - _644;
        float _650 = 1.0 - (_648 * _648);
        _656 = mix(fast::clamp(dot(_647, _402), 0.0, 1.0), 1.0, _650);
        _657 = _644;
        _658 = mix(_647, _402, float3(_650));
    }
    else
    {
        _656 = 1.0;
        _657 = 1.0;
        _658 = _402;
    }
    float4 _662 = float4(_658, 1.0);
    float3 _666 = _180;
    _666.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _662);
    float3 _670 = _666;
    _670.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _662);
    float3 _674 = _670;
    _674.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _662);
    float4 _677 = _662.xyzz * _662.yzzx;
    float3 _681 = _180;
    _681.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _677);
    float3 _685 = _681;
    _685.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _677);
    float3 _689 = _685;
    _689.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _677);
    float3 _704 = ((fast::max(float3(0.0), _627) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_674 + _689) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_658.x * _658.x) - (_658.y * _658.y)))) * View.View_SkyLightColor.xyz) * (_657 * _656));
    float3 _726 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _752;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _751;
        if (any(abs(_251 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _751 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_251, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _751 = _726;
        }
        _752 = _751;
    }
    else
    {
        _752 = _726;
    }
    float4 _759 = float4(((mix(float3(0.0), _480 + (_482 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_704 * _480) * fast::max(float3(1.0), ((((((_401 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_401 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_401 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _752) * 1.0, 0.0);
    float4 _766;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _765 = _759;
        _765.w = 0.0;
        _766 = _765;
    }
    else
    {
        _766 = _759;
    }
    float2 _770 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _778 = (_402 * 0.5) + float3(0.5);
    float4 _780 = float4(_778.x, _778.y, _778.z, float4(0.0).w);
    _780.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _781 = float4(0.0);
    _781.x = _400;
    float4 _782 = _781;
    _782.y = _399;
    float4 _783 = _782;
    _783.z = _398;
    float4 _784 = _783;
    _784.w = 0.50588238239288330078125;
    float4 _796 = float4(_401.x, _401.y, _401.z, float4(0.0).w);
    _796.w = ((log2(((dot(_704, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_484 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_484 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_484 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_770.xyx * _770.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _766 * View.View_PreExposure;
    out.out_var_SV_Target1 = _780;
    out.out_var_SV_Target2 = _784;
    out.out_var_SV_Target3 = _796;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_451, 1.0, 1.0, 1.0);
    return out;
}

