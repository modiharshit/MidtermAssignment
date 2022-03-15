

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
    char _m15_pad[188];
    float View_ShowDecalsMask;
    char _m16_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m17_pad[48];
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
    char _m0_pad[80];
    float IndirectLightingCache_DirectionalLightShadowing;
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients0;
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients1;
    float4 IndirectLightingCache_IndirectLightingSHCoefficients2;
};

struct type_Material
{
    spvUnsafeArray<float4, 4> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _155 = {};
constant float _157 = {};
constant float4 _158 = {};

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

fragment MainPS_out Main_00003cc1_d950a38a(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _212 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _157, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _217 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _222 = (_217.xyz / float3(_217.w)) - View.View_PreViewTranslation;
    float4 _228 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _231 = (_228.xy * float2(2.0)) - float2(1.0);
    float3 _247 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_231, sqrt(fast::clamp(1.0 - dot(_231, _231), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _258 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _262 = _258.x;
    float3 _271 = fast::clamp(Material.Material_VectorExpressions[3].xyz * _262, float3(0.0), float3(1.0));
    float _272 = fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0);
    float _277 = (fast::clamp(mix(Material.Material_ScalarExpressions[0].z, Material.Material_ScalarExpressions[0].w, _262), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _278 = in.in_var_PRIMITIVE_ID * 36u;
    uint _279 = _278 + 20u;
    float _329;
    float _330;
    float _331;
    float3 _332;
    float3 _333;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _279)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _297 = ((_212.xy / float2(_212.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _301 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _297, level(0.0));
        float4 _304 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _297, level(0.0));
        float4 _307 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _297, level(0.0));
        float _317 = _307.w;
        _329 = (_277 * _317) + _307.z;
        _330 = (0.5 * _317) + _307.y;
        _331 = (_272 * _317) + _307.x;
        _332 = (_271 * _301.w) + _301.xyz;
        _333 = normalize((_247 * _304.w) + ((_304.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _329 = _277;
        _330 = 0.5;
        _331 = _272;
        _332 = _271;
        _333 = _247;
    }
    bool _343 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _349;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _278 + 18u)].w > 0.0) && _343)
    {
        _349 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _349 = 1.0;
    }
    float _396;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _279)].z > 0.0)
    {
        float3 _364 = fast::clamp((_222 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _375 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_364.x), int(_364.y), int(_364.z), 0).xyz), 0));
        _396 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_375.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_364 / float3(_375.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _396 = _349;
    }
    float3 _410 = ((_332 - (_332 * _331)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _417 = (mix(float3(0.07999999821186065673828125 * _330), _332, float3(_331)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _420 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _425;
    if (_420)
    {
        _425 = _410 + (_417 * 0.449999988079071044921875);
    }
    else
    {
        _425 = _410;
    }
    float3 _427 = select(_417, float3(0.0), bool3(_420));
    float3 _429 = float3(dot(_427, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _515;
    if (_343)
    {
        float4 _465 = _158;
        _465.y = (-0.48860299587249755859375) * _333.y;
        float4 _468 = _465;
        _468.z = 0.48860299587249755859375 * _333.z;
        float4 _471 = _468;
        _471.w = (-0.48860299587249755859375) * _333.x;
        float3 _472 = _333 * _333;
        float4 _475 = _155;
        _475.x = (1.09254801273345947265625 * _333.x) * _333.y;
        float4 _478 = _475;
        _478.y = ((-1.09254801273345947265625) * _333.y) * _333.z;
        float4 _483 = _478;
        _483.z = 0.3153919875621795654296875 * ((3.0 * _472.z) - 1.0);
        float4 _486 = _483;
        _486.w = ((-1.09254801273345947265625) * _333.x) * _333.z;
        float4 _490 = _471;
        _490.x = 0.886227548122406005859375;
        float3 _492 = _490.yzw * 2.094395160675048828125;
        float4 _493 = float4(_490.x, _492.x, _492.y, _492.z);
        float4 _494 = _486 * 0.785398185253143310546875;
        float _495 = (_472.x - _472.y) * 0.4290426075458526611328125;
        float3 _501 = float3(0.0);
        _501.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _493) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _494)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _495);
        float3 _507 = _501;
        _507.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _493) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _494)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _495);
        float3 _513 = _507;
        _513.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _493) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _494)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _495);
        _515 = fast::max(float3(0.0), _513);
    }
    else
    {
        _515 = float3(0.0);
    }
    float3 _518 = _515 * View.View_IndirectLightingColorScale;
    float3 _540 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _569;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _568;
        if (any(abs(_222 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _278 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _278 + 19u)].xyz + float3(1.0))))
        {
            _568 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_222, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _568 = _540;
        }
        _569 = _568;
    }
    else
    {
        _569 = _540;
    }
    float4 _576 = float4(((mix(float3(0.0), _425 + (_427 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_518 * _425) * fast::max(float3(1.0), ((((((_332 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_332 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_332 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _569) * 1.0, 0.0);
    float4 _583;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _582 = _576;
        _582.w = 0.0;
        _583 = _582;
    }
    else
    {
        _583 = _576;
    }
    float2 _587 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _595 = (_333 * 0.5) + float3(0.5);
    float4 _597 = float4(_595.x, _595.y, _595.z, float4(0.0).w);
    _597.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _279)].y;
    float4 _598 = float4(0.0);
    _598.x = _331;
    float4 _599 = _598;
    _599.y = _330;
    float4 _600 = _599;
    _600.z = _329;
    float4 _601 = _600;
    _601.w = 0.50588238239288330078125;
    float4 _613 = float4(_332.x, _332.y, _332.z, float4(0.0).w);
    _613.w = ((log2(((dot(_518, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_429 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_429 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_429 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_587.xyx * _587.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _583 * View.View_PreExposure;
    out.out_var_SV_Target1 = _597;
    out.out_var_SV_Target2 = _601;
    out.out_var_SV_Target3 = _613;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_396, 1.0, 1.0, 1.0);
    return out;
}

