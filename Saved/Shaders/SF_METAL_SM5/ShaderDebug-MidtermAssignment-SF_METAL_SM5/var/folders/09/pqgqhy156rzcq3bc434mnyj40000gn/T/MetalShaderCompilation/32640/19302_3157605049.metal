

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

constant float4 _166 = {};
constant float3 _167 = {};
constant float _169 = {};
constant float4 _170 = {};

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

fragment MainPS_out Main_00004b66_bc353ab9(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float3x3 _216 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _227 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _169, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _232 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _236 = _232.xyz / float3(_232.w);
    float3 _237 = _236 - View.View_PreViewTranslation;
    float2 _241 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5;
    float4 _247 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _241, bias(View.View_MaterialTextureMipBias));
    float2 _253 = ((normalize(-_236) * _216).xy * ((0.00999999977648258209228515625 * _247.w) + (-0.008000000379979610443115234375))) + _241;
    float4 _257 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _253, bias(View.View_MaterialTextureMipBias));
    float2 _260 = (_257.xy * float2(2.0)) - float2(1.0);
    float3 _276 = normalize(_216 * normalize((float4(_260, sqrt(fast::clamp(1.0 - dot(_260, _260), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _288 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _293 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _298 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _302 = (_288.x + 0.5) * ((_293.x + 0.5) * (_298.x + 0.5));
    float4 _305 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _253, bias(View.View_MaterialTextureMipBias));
    float4 _311 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _253, bias(View.View_MaterialTextureMipBias));
    float3 _316 = fast::clamp(_305.xyz * mix(0.5, 1.0, _302), float3(0.0), float3(1.0));
    float _317 = fast::clamp(_311.y, 0.0, 1.0);
    float _322 = (fast::clamp(mix(0.300000011920928955078125, 0.800000011920928955078125, _302 * _311.x), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _323 = in.in_var_PRIMITIVE_ID * 36u;
    uint _324 = _323 + 20u;
    float _372;
    float _373;
    float _374;
    float3 _375;
    float3 _376;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _324)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _342 = ((_227.xy / float2(_227.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _346 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _342, level(0.0));
        float4 _349 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _342, level(0.0));
        float4 _352 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _342, level(0.0));
        float _362 = _352.w;
        _372 = (_322 * _362) + _352.z;
        _373 = (0.5 * _362) + _352.y;
        _374 = _352.x;
        _375 = (_316 * _346.w) + _346.xyz;
        _376 = normalize((_276 * _349.w) + ((_349.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _372 = _322;
        _373 = 0.5;
        _374 = 0.0;
        _375 = _316;
        _376 = _276;
    }
    bool _386 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _392;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _323 + 18u)].w > 0.0) && _386)
    {
        _392 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _392 = 1.0;
    }
    float _439;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _324)].z > 0.0)
    {
        float3 _407 = fast::clamp((_237 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _418 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_407.x), int(_407.y), int(_407.z), 0).xyz), 0));
        _439 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_418.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_407 / float3(_418.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _439 = _392;
    }
    float3 _453 = ((_375 - (_375 * _374)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _460 = (mix(float3(0.07999999821186065673828125 * _373), _375, float3(_374)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _463 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _468;
    if (_463)
    {
        _468 = _453 + (_460 * 0.449999988079071044921875);
    }
    else
    {
        _468 = _453;
    }
    float3 _470 = select(_460, float3(0.0), bool3(_463));
    float3 _472 = float3(dot(_470, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _479 = float3(_317);
    float3 _559;
    if (_386)
    {
        float4 _509 = _170;
        _509.y = (-0.48860299587249755859375) * _376.y;
        float4 _512 = _509;
        _512.z = 0.48860299587249755859375 * _376.z;
        float4 _515 = _512;
        _515.w = (-0.48860299587249755859375) * _376.x;
        float3 _516 = _376 * _376;
        float4 _519 = _166;
        _519.x = (1.09254801273345947265625 * _376.x) * _376.y;
        float4 _522 = _519;
        _522.y = ((-1.09254801273345947265625) * _376.y) * _376.z;
        float4 _527 = _522;
        _527.z = 0.3153919875621795654296875 * ((3.0 * _516.z) - 1.0);
        float4 _530 = _527;
        _530.w = ((-1.09254801273345947265625) * _376.x) * _376.z;
        float4 _534 = _515;
        _534.x = 0.886227548122406005859375;
        float3 _536 = _534.yzw * 2.094395160675048828125;
        float4 _537 = float4(_534.x, _536.x, _536.y, _536.z);
        float4 _538 = _530 * 0.785398185253143310546875;
        float _539 = (_516.x - _516.y) * 0.4290426075458526611328125;
        float3 _545 = float3(0.0);
        _545.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _537) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _538)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _539);
        float3 _551 = _545;
        _551.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _537) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _538)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _539);
        float3 _557 = _551;
        _557.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _537) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _538)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _539);
        _559 = fast::max(float3(0.0), _557);
    }
    else
    {
        _559 = float3(0.0);
    }
    float _585;
    float _586;
    float3 _587;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _575;
        float _576;
        if (_386)
        {
            _575 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _576 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _575 = _376;
            _576 = 1.0;
        }
        float _577 = 1.0 - _576;
        float _579 = 1.0 - (_577 * _577);
        _585 = mix(fast::clamp(dot(_575, _376), 0.0, 1.0), 1.0, _579);
        _586 = _576;
        _587 = mix(_575, _376, float3(_579));
    }
    else
    {
        _585 = 1.0;
        _586 = 1.0;
        _587 = _376;
    }
    float4 _591 = float4(_587, 1.0);
    float3 _595 = _167;
    _595.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _591);
    float3 _599 = _595;
    _599.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _591);
    float3 _603 = _599;
    _603.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _591);
    float4 _606 = _591.xyzz * _591.yzzx;
    float3 _610 = _167;
    _610.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _606);
    float3 _614 = _610;
    _614.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _606);
    float3 _618 = _614;
    _618.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _606);
    float3 _633 = (_559 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_603 + _618) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_587.x * _587.x) - (_587.y * _587.y)))) * View.View_SkyLightColor.xyz) * (_586 * _585));
    float3 _655 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _684;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _683;
        if (any(abs(_237 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _323 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _323 + 19u)].xyz + float3(1.0))))
        {
            _683 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_237, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _683 = _655;
        }
        _684 = _683;
    }
    else
    {
        _684 = _655;
    }
    float4 _691 = float4(((mix(float3(0.0), _468 + (_470 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_633 * _468) * fast::max(_479, ((((((_375 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _317) + ((_375 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _317) + ((_375 * 2.755199909210205078125) + float3(0.69029998779296875))) * _317))) + _684) * 1.0, 0.0);
    float4 _698;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _697 = _691;
        _697.w = 0.0;
        _698 = _697;
    }
    else
    {
        _698 = _691;
    }
    float2 _702 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _710 = (_376 * 0.5) + float3(0.5);
    float4 _712 = float4(_710.x, _710.y, _710.z, float4(0.0).w);
    _712.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _324)].y;
    float4 _713 = float4(0.0);
    _713.x = _374;
    float4 _714 = _713;
    _714.y = _373;
    float4 _715 = _714;
    _715.z = _372;
    float4 _716 = _715;
    _716.w = 0.50588238239288330078125;
    float4 _728 = float4(_375.x, _375.y, _375.z, float4(0.0).w);
    _728.w = ((log2(((dot(_633, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_479, ((((((_472 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _317) + ((_472 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _317) + ((_472 * 2.755199909210205078125) + float3(0.69029998779296875))) * _317).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_702.xyx * _702.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _698 * View.View_PreExposure;
    out.out_var_SV_Target1 = _712;
    out.out_var_SV_Target2 = _716;
    out.out_var_SV_Target3 = _728;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_439, 1.0, 1.0, 1.0);
    return out;
}

