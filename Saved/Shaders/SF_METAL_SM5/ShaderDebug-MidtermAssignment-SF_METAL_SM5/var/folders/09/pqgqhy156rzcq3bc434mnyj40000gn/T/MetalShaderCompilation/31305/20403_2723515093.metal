

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
    char _m11_pad[48];
    float View_MaterialTextureMipBias;
    char _m12_pad[28];
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

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _177 = {};
constant float3 _178 = {};
constant float _180 = {};
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
    uint in_var_PRIMITIVE_ID [[user(locn3)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00004fb3_a2558ad5(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(11)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(12)]], texture2d<float> Material_Texture2D_0 [[texture(13)]], texture2d<float> Material_Texture2D_1 [[texture(14)]], texture2d<float> Material_Texture2D_2 [[texture(15)]], texture2d<float> Material_Texture2D_3 [[texture(16)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float3x3 _227 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _238 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _180, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _243 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _247 = _243.xyz / float3(_243.w);
    float3 _248 = _247 - View.View_PreViewTranslation;
    float2 _252 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5;
    float4 _258 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _252, bias(View.View_MaterialTextureMipBias));
    float2 _264 = ((normalize(-_247) * _227).xy * ((0.00999999977648258209228515625 * _258.w) + (-0.008000000379979610443115234375))) + _252;
    float4 _268 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _264, bias(View.View_MaterialTextureMipBias));
    float2 _271 = (_268.xy * float2(2.0)) - float2(1.0);
    float3 _287 = normalize(_227 * normalize((float4(_271, sqrt(fast::clamp(1.0 - dot(_271, _271), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _299 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _304 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _309 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _313 = (_299.x + 0.5) * ((_304.x + 0.5) * (_309.x + 0.5));
    float4 _316 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _264, bias(View.View_MaterialTextureMipBias));
    float4 _322 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _264, bias(View.View_MaterialTextureMipBias));
    float3 _327 = fast::clamp(_316.xyz * mix(0.5, 1.0, _313), float3(0.0), float3(1.0));
    float _328 = fast::clamp(_322.y, 0.0, 1.0);
    float _333 = (fast::clamp(mix(0.300000011920928955078125, 0.800000011920928955078125, _313 * _322.x), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _334 = in.in_var_PRIMITIVE_ID * 36u;
    uint _335 = _334 + 20u;
    float _383;
    float _384;
    float _385;
    float3 _386;
    float3 _387;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _335)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _353 = ((_238.xy / float2(_238.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _357 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _353, level(0.0));
        float4 _360 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _353, level(0.0));
        float4 _363 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _353, level(0.0));
        float _373 = _363.w;
        _383 = (_333 * _373) + _363.z;
        _384 = (0.5 * _373) + _363.y;
        _385 = _363.x;
        _386 = (_327 * _357.w) + _357.xyz;
        _387 = normalize((_287 * _360.w) + ((_360.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _383 = _333;
        _384 = 0.5;
        _385 = 0.0;
        _386 = _327;
        _387 = _287;
    }
    float3 _397 = fast::clamp((_248 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _408 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_397.x), int(_397.y), int(_397.z), 0).xyz), 0));
    float3 _423 = (((_408.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_397 / float3(_408.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _436;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _335)].z > 0.0)
    {
        _436 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _423, level(0.0)).x;
    }
    else
    {
        _436 = 1.0;
    }
    float3 _450 = ((_386 - (_386 * _385)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _457 = (mix(float3(0.07999999821186065673828125 * _384), _386, float3(_385)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _460 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _465;
    if (_460)
    {
        _465 = _450 + (_457 * 0.449999988079071044921875);
    }
    else
    {
        _465 = _450;
    }
    float3 _467 = select(_457, float3(0.0), bool3(_460));
    float3 _469 = float3(dot(_467, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _476 = float3(_328);
    float4 _487 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _423, level(0.0));
    float _503 = _487.x;
    float4 _505 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _423, level(0.0)) * 2.0) - float4(1.0)) * _503) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _506 = _487.y;
    float4 _508 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _423, level(0.0)) * 2.0) - float4(1.0)) * _506) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _509 = _487.z;
    float4 _511 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _423, level(0.0)) * 2.0) - float4(1.0)) * _509) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _528 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _423, level(0.0)) * 2.0) - float4(1.0)) * _503) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _530 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _423, level(0.0)) * 2.0) - float4(1.0)) * _506) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _532 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _423, level(0.0)) * 2.0) - float4(1.0)) * _509) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _565 = _181;
    _565.y = (-0.48860299587249755859375) * _387.y;
    float4 _568 = _565;
    _568.z = 0.48860299587249755859375 * _387.z;
    float4 _571 = _568;
    _571.w = (-0.48860299587249755859375) * _387.x;
    float3 _572 = _387 * _387;
    float4 _575 = _177;
    _575.x = (1.09254801273345947265625 * _387.x) * _387.y;
    float4 _578 = _575;
    _578.y = ((-1.09254801273345947265625) * _387.y) * _387.z;
    float4 _583 = _578;
    _583.z = 0.3153919875621795654296875 * ((3.0 * _572.z) - 1.0);
    float4 _586 = _583;
    _586.w = ((-1.09254801273345947265625) * _387.x) * _387.z;
    float4 _590 = _571;
    _590.x = 0.886227548122406005859375;
    float3 _592 = _590.yzw * 2.094395160675048828125;
    float4 _593 = float4(_590.x, _592.x, _592.y, _592.z);
    float4 _594 = _586 * 0.785398185253143310546875;
    float _595 = (_572.x - _572.y) * 0.4290426075458526611328125;
    float3 _601 = float3(0.0);
    _601.x = (dot(float4(_503, _505.xyz), _593) + dot(float4(_505.w, _528.xyz), _594)) + (_528.w * _595);
    float3 _607 = _601;
    _607.y = (dot(float4(_506, _508.xyz), _593) + dot(float4(_508.w, _530.xyz), _594)) + (_530.w * _595);
    float3 _613 = _607;
    _613.z = (dot(float4(_509, _511.xyz), _593) + dot(float4(_511.w, _532.xyz), _594)) + (_532.w * _595);
    float _642;
    float _643;
    float3 _644;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _629 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _423, level(0.0)).xyz * 2.0) - float3(1.0);
        float _630 = length(_629);
        float3 _633 = _629 / float3(fast::max(_630, 9.9999997473787516355514526367188e-05));
        float _634 = 1.0 - _630;
        float _636 = 1.0 - (_634 * _634);
        _642 = mix(fast::clamp(dot(_633, _387), 0.0, 1.0), 1.0, _636);
        _643 = _630;
        _644 = mix(_633, _387, float3(_636));
    }
    else
    {
        _642 = 1.0;
        _643 = 1.0;
        _644 = _387;
    }
    float4 _648 = float4(_644, 1.0);
    float3 _652 = _178;
    _652.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _648);
    float3 _656 = _652;
    _656.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _648);
    float3 _660 = _656;
    _660.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _648);
    float4 _663 = _648.xyzz * _648.yzzx;
    float3 _667 = _178;
    _667.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _663);
    float3 _671 = _667;
    _671.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _663);
    float3 _675 = _671;
    _675.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _663);
    float3 _690 = ((fast::max(float3(0.0), _613) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_660 + _675) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_644.x * _644.x) - (_644.y * _644.y)))) * View.View_SkyLightColor.xyz) * (_643 * _642));
    float3 _712 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _741;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _740;
        if (any(abs(_248 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _334 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _334 + 19u)].xyz + float3(1.0))))
        {
            _740 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_248, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _740 = _712;
        }
        _741 = _740;
    }
    else
    {
        _741 = _712;
    }
    float4 _748 = float4(((mix(float3(0.0), _465 + (_467 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_690 * _465) * fast::max(_476, ((((((_386 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _328) + ((_386 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _328) + ((_386 * 2.755199909210205078125) + float3(0.69029998779296875))) * _328))) + _741) * 1.0, 0.0);
    float4 _755;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _754 = _748;
        _754.w = 0.0;
        _755 = _754;
    }
    else
    {
        _755 = _748;
    }
    float2 _759 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _767 = (_387 * 0.5) + float3(0.5);
    float4 _769 = float4(_767.x, _767.y, _767.z, float4(0.0).w);
    _769.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _335)].y;
    float4 _770 = float4(0.0);
    _770.x = _385;
    float4 _771 = _770;
    _771.y = _384;
    float4 _772 = _771;
    _772.z = _383;
    float4 _773 = _772;
    _773.w = 0.50588238239288330078125;
    float4 _785 = float4(_386.x, _386.y, _386.z, float4(0.0).w);
    _785.w = ((log2(((dot(_690, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_476, ((((((_469 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _328) + ((_469 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _328) + ((_469 * 2.755199909210205078125) + float3(0.69029998779296875))) * _328).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_759.xyx * _759.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _755 * View.View_PreExposure;
    out.out_var_SV_Target1 = _769;
    out.out_var_SV_Target2 = _773;
    out.out_var_SV_Target3 = _785;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_436, 1.0, 1.0, 1.0);
    return out;
}

