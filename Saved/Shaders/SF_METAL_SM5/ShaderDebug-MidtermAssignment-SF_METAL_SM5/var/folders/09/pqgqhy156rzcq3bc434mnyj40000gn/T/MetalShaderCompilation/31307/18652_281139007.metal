

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
    float View_IndirectLightingCacheShowFlag;
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_IndirectLightingCache
{
    char _m0_pad[64];
    float4 IndirectLightingCache_PointSkyBentNormal;
    float IndirectLightingCache_DirectionalLightShadowing;
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients0;
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients1;
    float4 IndirectLightingCache_IndirectLightingSHCoefficients2;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _161 = {};
constant float3 _162 = {};
constant float _164 = {};
constant float4 _165 = {};

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

fragment MainPS_out Main_000048dc_10c1d73f(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _222 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _164, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _227 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _232 = (_227.xyz / float3(_227.w)) - View.View_PreViewTranslation;
    float4 _238 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _241 = (_238.xy * float2(2.0)) - float2(1.0);
    float3 _257 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_241, sqrt(fast::clamp(1.0 - dot(_241, _241), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _269 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _274 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _279 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _283 = (_269.x + 0.5) * ((_274.x + 0.5) * (_279.x + 0.5));
    float4 _289 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _295 = fast::clamp(mix(float3(0.5), float3(1.0), float3(_283)) * _289.xyz, float3(0.0), float3(1.0));
    float _300 = (fast::clamp(mix(0.5, 0.300000011920928955078125, _283 * _289.w), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _301 = in.in_var_PRIMITIVE_ID * 36u;
    uint _302 = _301 + 20u;
    float _351;
    float _352;
    float _353;
    float3 _354;
    float3 _355;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _302)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _320 = ((_222.xy / float2(_222.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _324 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _320, level(0.0));
        float4 _327 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _320, level(0.0));
        float4 _330 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _320, level(0.0));
        float _340 = _330.w;
        _351 = (_300 * _340) + _330.z;
        _352 = (0.5 * _340) + _330.y;
        _353 = _340 + _330.x;
        _354 = (_295 * _324.w) + _324.xyz;
        _355 = normalize((_257 * _327.w) + ((_327.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _351 = _300;
        _352 = 0.5;
        _353 = 1.0;
        _354 = _295;
        _355 = _257;
    }
    bool _365 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _371;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _301 + 18u)].w > 0.0) && _365)
    {
        _371 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _371 = 1.0;
    }
    float _418;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _302)].z > 0.0)
    {
        float3 _386 = fast::clamp((_232 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _397 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_386.x), int(_386.y), int(_386.z), 0).xyz), 0));
        _418 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_397.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_386 / float3(_397.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _418 = _371;
    }
    float3 _432 = ((_354 - (_354 * _353)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _439 = (mix(float3(0.07999999821186065673828125 * _352), _354, float3(_353)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _442 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _447;
    if (_442)
    {
        _447 = _432 + (_439 * 0.449999988079071044921875);
    }
    else
    {
        _447 = _432;
    }
    float3 _449 = select(_439, float3(0.0), bool3(_442));
    float3 _451 = float3(dot(_449, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _537;
    if (_365)
    {
        float4 _487 = _165;
        _487.y = (-0.48860299587249755859375) * _355.y;
        float4 _490 = _487;
        _490.z = 0.48860299587249755859375 * _355.z;
        float4 _493 = _490;
        _493.w = (-0.48860299587249755859375) * _355.x;
        float3 _494 = _355 * _355;
        float4 _497 = _161;
        _497.x = (1.09254801273345947265625 * _355.x) * _355.y;
        float4 _500 = _497;
        _500.y = ((-1.09254801273345947265625) * _355.y) * _355.z;
        float4 _505 = _500;
        _505.z = 0.3153919875621795654296875 * ((3.0 * _494.z) - 1.0);
        float4 _508 = _505;
        _508.w = ((-1.09254801273345947265625) * _355.x) * _355.z;
        float4 _512 = _493;
        _512.x = 0.886227548122406005859375;
        float3 _514 = _512.yzw * 2.094395160675048828125;
        float4 _515 = float4(_512.x, _514.x, _514.y, _514.z);
        float4 _516 = _508 * 0.785398185253143310546875;
        float _517 = (_494.x - _494.y) * 0.4290426075458526611328125;
        float3 _523 = float3(0.0);
        _523.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _515) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _516)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _517);
        float3 _529 = _523;
        _529.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _515) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _516)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _517);
        float3 _535 = _529;
        _535.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _515) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _516)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _517);
        _537 = fast::max(float3(0.0), _535);
    }
    else
    {
        _537 = float3(0.0);
    }
    float _563;
    float _564;
    float3 _565;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _553;
        float _554;
        if (_365)
        {
            _553 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _554 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _553 = _355;
            _554 = 1.0;
        }
        float _555 = 1.0 - _554;
        float _557 = 1.0 - (_555 * _555);
        _563 = mix(fast::clamp(dot(_553, _355), 0.0, 1.0), 1.0, _557);
        _564 = _554;
        _565 = mix(_553, _355, float3(_557));
    }
    else
    {
        _563 = 1.0;
        _564 = 1.0;
        _565 = _355;
    }
    float4 _569 = float4(_565, 1.0);
    float3 _573 = _162;
    _573.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _569);
    float3 _577 = _573;
    _577.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _569);
    float3 _581 = _577;
    _581.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _569);
    float4 _584 = _569.xyzz * _569.yzzx;
    float3 _588 = _162;
    _588.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _584);
    float3 _592 = _588;
    _592.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _584);
    float3 _596 = _592;
    _596.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _584);
    float3 _611 = (_537 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_581 + _596) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_565.x * _565.x) - (_565.y * _565.y)))) * View.View_SkyLightColor.xyz) * (_564 * _563));
    float3 _633 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _662;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _661;
        if (any(abs(_232 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _301 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _301 + 19u)].xyz + float3(1.0))))
        {
            _661 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_232, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _661 = _633;
        }
        _662 = _661;
    }
    else
    {
        _662 = _633;
    }
    float4 _669 = float4(((mix(float3(0.0), _447 + (_449 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_611 * _447) * fast::max(float3(1.0), ((((((_354 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_354 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_354 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _662) * 1.0, 0.0);
    float4 _676;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _675 = _669;
        _675.w = 0.0;
        _676 = _675;
    }
    else
    {
        _676 = _669;
    }
    float2 _680 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _688 = (_355 * 0.5) + float3(0.5);
    float4 _690 = float4(_688.x, _688.y, _688.z, float4(0.0).w);
    _690.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _302)].y;
    float4 _691 = float4(0.0);
    _691.x = _353;
    float4 _692 = _691;
    _692.y = _352;
    float4 _693 = _692;
    _693.z = _351;
    float4 _694 = _693;
    _694.w = 0.50588238239288330078125;
    float4 _706 = float4(_354.x, _354.y, _354.z, float4(0.0).w);
    _706.w = ((log2(((dot(_611, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_451 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_451 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_451 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_680.xyx * _680.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _676 * View.View_PreExposure;
    out.out_var_SV_Target1 = _690;
    out.out_var_SV_Target2 = _694;
    out.out_var_SV_Target3 = _706;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_418, 1.0, 1.0, 1.0);
    return out;
}

