

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
    char _m0_pad[704];
    float4x4 View_SVPositionToTranslatedWorld;
    char _m1_pad[288];
    float4 View_ScreenPositionScaleBias;
    char _m2_pad[48];
    float3 View_PreViewTranslation;
    char _m3_pad[928];
    float4 View_ViewRectMin;
    float4 View_ViewSizeAndInvSize;
    char _m5_pad[68];
    float View_PreExposure;
    float4 View_DiffuseOverrideParameter;
    float4 View_SpecularOverrideParameter;
    float4 View_NormalOverrideParameter;
    float2 View_RoughnessOverrideParameter;
    char _m10_pad[8];
    float View_OutOfBoundsMask;
    char _m11_pad[24];
    float View_CullingSign;
    char _m12_pad[52];
    float View_UnlitViewmodeMask;
    char _m13_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m14_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m15_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m17_pad[124];
    float View_ShowDecalsMask;
    char _m18_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m19_pad[48];
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
    char _m0_pad[64];
    float4 Primitive_InvNonUniformScaleAndDeterminantSign;
    float4 Primitive_ObjectWorldPositionAndRadius;
    char _m2_pad[208];
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

constant float4 _160 = {};
constant float3 _161 = {};
constant float _163 = {};
constant float4 _164 = {};

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
    float4 in_var_COLOR0 [[user(locn2)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_000045ed_9c4196d6(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(11)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(12)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]], bool gl_FrontFacing [[front_facing]])
{
    MainPS_out out = {};
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _222 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _163, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _227 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _232 = (_227.xyz / float3(_227.w)) - View.View_PreViewTranslation;
    float3 _246 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * ((View.View_CullingSign * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w) * float(gl_FrontFacing ? 1 : (-1)));
    float3 _255 = fast::clamp(in.in_var_COLOR0.xyz, float3(0.0), float3(1.0));
    float _259 = (0.5 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _304;
    float _305;
    float _306;
    float3 _307;
    float3 _308;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _276 = ((_222.xy / float2(_222.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _280 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _276, level(0.0));
        float4 _283 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _276, level(0.0));
        float4 _286 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _276, level(0.0));
        _304 = (_259 * _286.w) + _286.z;
        _305 = _286.y;
        _306 = _286.x;
        _307 = (_255 * _280.w) + _280.xyz;
        _308 = normalize((_246 * _283.w) + ((_283.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _304 = _259;
        _305 = 0.0;
        _306 = 0.0;
        _307 = _255;
        _308 = _246;
    }
    float3 _318 = fast::clamp((_232 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _329 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_318.x), int(_318.y), int(_318.z), 0).xyz), 0));
    float3 _344 = (((_329.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_318 / float3(_329.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _357;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        _357 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _344, level(0.0)).x;
    }
    else
    {
        _357 = 1.0;
    }
    float3 _371 = ((_307 - (_307 * _306)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _378 = (mix(float3(0.07999999821186065673828125 * _305), _307, float3(_306)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _381 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _386;
    if (_381)
    {
        _386 = _371 + (_378 * 0.449999988079071044921875);
    }
    else
    {
        _386 = _371;
    }
    float3 _388 = select(_378, float3(0.0), bool3(_381));
    float3 _390 = float3(dot(_388, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _407 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _344, level(0.0));
    float _423 = _407.x;
    float4 _425 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _344, level(0.0)) * 2.0) - float4(1.0)) * _423) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _426 = _407.y;
    float4 _428 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _344, level(0.0)) * 2.0) - float4(1.0)) * _426) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _429 = _407.z;
    float4 _431 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _344, level(0.0)) * 2.0) - float4(1.0)) * _429) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _448 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _344, level(0.0)) * 2.0) - float4(1.0)) * _423) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _450 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _344, level(0.0)) * 2.0) - float4(1.0)) * _426) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _452 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _344, level(0.0)) * 2.0) - float4(1.0)) * _429) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _485 = _164;
    _485.y = (-0.48860299587249755859375) * _308.y;
    float4 _488 = _485;
    _488.z = 0.48860299587249755859375 * _308.z;
    float4 _491 = _488;
    _491.w = (-0.48860299587249755859375) * _308.x;
    float3 _492 = _308 * _308;
    float4 _495 = _160;
    _495.x = (1.09254801273345947265625 * _308.x) * _308.y;
    float4 _498 = _495;
    _498.y = ((-1.09254801273345947265625) * _308.y) * _308.z;
    float4 _503 = _498;
    _503.z = 0.3153919875621795654296875 * ((3.0 * _492.z) - 1.0);
    float4 _506 = _503;
    _506.w = ((-1.09254801273345947265625) * _308.x) * _308.z;
    float4 _510 = _491;
    _510.x = 0.886227548122406005859375;
    float3 _512 = _510.yzw * 2.094395160675048828125;
    float4 _513 = float4(_510.x, _512.x, _512.y, _512.z);
    float4 _514 = _506 * 0.785398185253143310546875;
    float _515 = (_492.x - _492.y) * 0.4290426075458526611328125;
    float3 _521 = float3(0.0);
    _521.x = (dot(float4(_423, _425.xyz), _513) + dot(float4(_425.w, _448.xyz), _514)) + (_448.w * _515);
    float3 _527 = _521;
    _527.y = (dot(float4(_426, _428.xyz), _513) + dot(float4(_428.w, _450.xyz), _514)) + (_450.w * _515);
    float3 _533 = _527;
    _533.z = (dot(float4(_429, _431.xyz), _513) + dot(float4(_431.w, _452.xyz), _514)) + (_452.w * _515);
    float _562;
    float _563;
    float3 _564;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _549 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _344, level(0.0)).xyz * 2.0) - float3(1.0);
        float _550 = length(_549);
        float3 _553 = _549 / float3(fast::max(_550, 9.9999997473787516355514526367188e-05));
        float _554 = 1.0 - _550;
        float _556 = 1.0 - (_554 * _554);
        _562 = mix(fast::clamp(dot(_553, _308), 0.0, 1.0), 1.0, _556);
        _563 = _550;
        _564 = mix(_553, _308, float3(_556));
    }
    else
    {
        _562 = 1.0;
        _563 = 1.0;
        _564 = _308;
    }
    float4 _568 = float4(_564, 1.0);
    float3 _572 = _161;
    _572.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _568);
    float3 _576 = _572;
    _576.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _568);
    float3 _580 = _576;
    _580.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _568);
    float4 _583 = _568.xyzz * _568.yzzx;
    float3 _587 = _161;
    _587.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _583);
    float3 _591 = _587;
    _591.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _583);
    float3 _595 = _591;
    _595.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _583);
    float3 _610 = ((fast::max(float3(0.0), _533) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_580 + _595) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_564.x * _564.x) - (_564.y * _564.y)))) * View.View_SkyLightColor.xyz) * (_563 * _562));
    float3 _632 = fast::max(mix(in.in_var_COLOR0.xyz, Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _658;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _657;
        if (any(abs(_232 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _657 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_232, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _657 = _632;
        }
        _658 = _657;
    }
    else
    {
        _658 = _632;
    }
    float4 _665 = float4(((mix(float3(0.0), _386 + (_388 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_610 * _386) * fast::max(float3(1.0), ((((((_307 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_307 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_307 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _658) * 1.0, 0.0);
    float4 _672;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _671 = _665;
        _671.w = 0.0;
        _672 = _671;
    }
    else
    {
        _672 = _665;
    }
    float2 _676 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _684 = (_308 * 0.5) + float3(0.5);
    float4 _686 = float4(_684.x, _684.y, _684.z, float4(0.0).w);
    _686.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _687 = float4(0.0);
    _687.x = _306;
    float4 _688 = _687;
    _688.y = _305;
    float4 _689 = _688;
    _689.z = _304;
    float4 _690 = _689;
    _690.w = 0.50588238239288330078125;
    float4 _702 = float4(_307.x, _307.y, _307.z, float4(0.0).w);
    _702.w = ((log2(((dot(_610, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_390 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_390 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_390 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_676.xyx * _676.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _672 * View.View_PreExposure;
    out.out_var_SV_Target1 = _686;
    out.out_var_SV_Target2 = _690;
    out.out_var_SV_Target3 = _702;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_357, 1.0, 1.0, 1.0);
    return out;
}

