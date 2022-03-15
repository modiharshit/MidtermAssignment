

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

constant float4 _165 = {};
constant float3 _166 = {};
constant float _168 = {};
constant float4 _169 = {};

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

fragment MainPS_out Main_000047ac_c2510693(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(11)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(12)]], texture2d<float> Material_Texture2D_0 [[texture(13)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _226 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _168, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _231 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _236 = (_231.xyz / float3(_231.w)) - View.View_PreViewTranslation;
    float3 _244 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _257 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _259 = fast::clamp(_257.xyz, float3(0.0), float3(1.0));
    float _263 = (0.5 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _264 = in.in_var_PRIMITIVE_ID * 36u;
    uint _265 = _264 + 20u;
    float _313;
    float _314;
    float _315;
    float3 _316;
    float3 _317;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _265)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _283 = ((_226.xy / float2(_226.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _287 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _283, level(0.0));
        float4 _290 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _283, level(0.0));
        float4 _293 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _283, level(0.0));
        float _303 = _293.w;
        _313 = (_263 * _303) + _293.z;
        _314 = (0.5 * _303) + _293.y;
        _315 = _293.x;
        _316 = (_259 * _287.w) + _287.xyz;
        _317 = normalize((_244 * _290.w) + ((_290.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _313 = _263;
        _314 = 0.5;
        _315 = 0.0;
        _316 = _259;
        _317 = _244;
    }
    float3 _327 = fast::clamp((_236 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _338 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_327.x), int(_327.y), int(_327.z), 0).xyz), 0));
    float3 _353 = (((_338.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_327 / float3(_338.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _366;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _265)].z > 0.0)
    {
        _366 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _353, level(0.0)).x;
    }
    else
    {
        _366 = 1.0;
    }
    float3 _380 = ((_316 - (_316 * _315)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _387 = (mix(float3(0.07999999821186065673828125 * _314), _316, float3(_315)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _390 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _395;
    if (_390)
    {
        _395 = _380 + (_387 * 0.449999988079071044921875);
    }
    else
    {
        _395 = _380;
    }
    float3 _397 = select(_387, float3(0.0), bool3(_390));
    float3 _399 = float3(dot(_397, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _416 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _353, level(0.0));
    float _432 = _416.x;
    float4 _434 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _353, level(0.0)) * 2.0) - float4(1.0)) * _432) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _435 = _416.y;
    float4 _437 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _353, level(0.0)) * 2.0) - float4(1.0)) * _435) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _438 = _416.z;
    float4 _440 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _353, level(0.0)) * 2.0) - float4(1.0)) * _438) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _457 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _353, level(0.0)) * 2.0) - float4(1.0)) * _432) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _459 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _353, level(0.0)) * 2.0) - float4(1.0)) * _435) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _461 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _353, level(0.0)) * 2.0) - float4(1.0)) * _438) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _494 = _169;
    _494.y = (-0.48860299587249755859375) * _317.y;
    float4 _497 = _494;
    _497.z = 0.48860299587249755859375 * _317.z;
    float4 _500 = _497;
    _500.w = (-0.48860299587249755859375) * _317.x;
    float3 _501 = _317 * _317;
    float4 _504 = _165;
    _504.x = (1.09254801273345947265625 * _317.x) * _317.y;
    float4 _507 = _504;
    _507.y = ((-1.09254801273345947265625) * _317.y) * _317.z;
    float4 _512 = _507;
    _512.z = 0.3153919875621795654296875 * ((3.0 * _501.z) - 1.0);
    float4 _515 = _512;
    _515.w = ((-1.09254801273345947265625) * _317.x) * _317.z;
    float4 _519 = _500;
    _519.x = 0.886227548122406005859375;
    float3 _521 = _519.yzw * 2.094395160675048828125;
    float4 _522 = float4(_519.x, _521.x, _521.y, _521.z);
    float4 _523 = _515 * 0.785398185253143310546875;
    float _524 = (_501.x - _501.y) * 0.4290426075458526611328125;
    float3 _530 = float3(0.0);
    _530.x = (dot(float4(_432, _434.xyz), _522) + dot(float4(_434.w, _457.xyz), _523)) + (_457.w * _524);
    float3 _536 = _530;
    _536.y = (dot(float4(_435, _437.xyz), _522) + dot(float4(_437.w, _459.xyz), _523)) + (_459.w * _524);
    float3 _542 = _536;
    _542.z = (dot(float4(_438, _440.xyz), _522) + dot(float4(_440.w, _461.xyz), _523)) + (_461.w * _524);
    float _571;
    float _572;
    float3 _573;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _558 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _353, level(0.0)).xyz * 2.0) - float3(1.0);
        float _559 = length(_558);
        float3 _562 = _558 / float3(fast::max(_559, 9.9999997473787516355514526367188e-05));
        float _563 = 1.0 - _559;
        float _565 = 1.0 - (_563 * _563);
        _571 = mix(fast::clamp(dot(_562, _317), 0.0, 1.0), 1.0, _565);
        _572 = _559;
        _573 = mix(_562, _317, float3(_565));
    }
    else
    {
        _571 = 1.0;
        _572 = 1.0;
        _573 = _317;
    }
    float4 _577 = float4(_573, 1.0);
    float3 _581 = _166;
    _581.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _577);
    float3 _585 = _581;
    _585.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _577);
    float3 _589 = _585;
    _589.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _577);
    float4 _592 = _577.xyzz * _577.yzzx;
    float3 _596 = _166;
    _596.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _592);
    float3 _600 = _596;
    _600.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _592);
    float3 _604 = _600;
    _604.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _592);
    float3 _619 = ((fast::max(float3(0.0), _542) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_589 + _604) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_573.x * _573.x) - (_573.y * _573.y)))) * View.View_SkyLightColor.xyz) * (_572 * _571));
    float3 _641 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _670;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _669;
        if (any(abs(_236 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _264 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _264 + 19u)].xyz + float3(1.0))))
        {
            _669 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_236, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _669 = _641;
        }
        _670 = _669;
    }
    else
    {
        _670 = _641;
    }
    float4 _677 = float4(((mix(float3(0.0), _395 + (_397 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_619 * _395) * fast::max(float3(1.0), ((((((_316 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_316 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_316 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _670) * 1.0, 0.0);
    float4 _684;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _683 = _677;
        _683.w = 0.0;
        _684 = _683;
    }
    else
    {
        _684 = _677;
    }
    float2 _688 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _696 = (_317 * 0.5) + float3(0.5);
    float4 _698 = float4(_696.x, _696.y, _696.z, float4(0.0).w);
    _698.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _265)].y;
    float4 _699 = float4(0.0);
    _699.x = _315;
    float4 _700 = _699;
    _700.y = _314;
    float4 _701 = _700;
    _701.z = _313;
    float4 _702 = _701;
    _702.w = 0.50588238239288330078125;
    float4 _714 = float4(_316.x, _316.y, _316.z, float4(0.0).w);
    _714.w = ((log2(((dot(_619, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_399 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_399 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_399 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_688.xyx * _688.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _684 * View.View_PreExposure;
    out.out_var_SV_Target1 = _698;
    out.out_var_SV_Target2 = _702;
    out.out_var_SV_Target3 = _714;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_366, 1.0, 1.0, 1.0);
    return out;
}

