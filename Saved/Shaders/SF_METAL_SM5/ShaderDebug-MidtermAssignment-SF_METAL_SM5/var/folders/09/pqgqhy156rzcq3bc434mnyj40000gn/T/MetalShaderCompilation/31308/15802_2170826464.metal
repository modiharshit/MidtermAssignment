

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
    float3 IndirectLightingCache_IndirectLightingCachePrimitiveAdd;
    float3 IndirectLightingCache_IndirectLightingCachePrimitiveScale;
    float3 IndirectLightingCache_IndirectLightingCacheMinUV;
    float3 IndirectLightingCache_IndirectLightingCacheMaxUV;
    char _m4_pad[16];
    float IndirectLightingCache_DirectionalLightShadowing;
};

struct type_Material
{
    spvUnsafeArray<float4, 6> Material_VectorExpressions;
    spvUnsafeArray<float4, 2> Material_ScalarExpressions;
};

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

fragment MainPS_out Main_00003dba_81642ee0(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
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
    float _265 = _258.y;
    float3 _280 = fast::clamp(mix(Material.Material_VectorExpressions[4].xyz, Material.Material_VectorExpressions[5].xyz, float3(_265)) * _258.x, float3(0.0), float3(1.0));
    float _281 = fast::clamp(mix(Material.Material_ScalarExpressions[0].y, Material.Material_ScalarExpressions[0].z, _265), 0.0, 1.0);
    float _286 = (fast::clamp(mix(Material.Material_ScalarExpressions[0].w, Material.Material_ScalarExpressions[1].x, _265), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _287 = in.in_var_PRIMITIVE_ID * 36u;
    uint _288 = _287 + 20u;
    float _338;
    float _339;
    float _340;
    float3 _341;
    float3 _342;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _288)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _306 = ((_212.xy / float2(_212.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _310 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _306, level(0.0));
        float4 _313 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _306, level(0.0));
        float4 _316 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _306, level(0.0));
        float _326 = _316.w;
        _338 = (_286 * _326) + _316.z;
        _339 = (0.5 * _326) + _316.y;
        _340 = (_281 * _326) + _316.x;
        _341 = (_280 * _310.w) + _310.xyz;
        _342 = normalize((_247 * _313.w) + ((_313.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _338 = _286;
        _339 = 0.5;
        _340 = _281;
        _341 = _280;
        _342 = _247;
    }
    bool _352 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _358;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _287 + 18u)].w > 0.0) && _352)
    {
        _358 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _358 = 1.0;
    }
    float _405;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _288)].z > 0.0)
    {
        float3 _373 = fast::clamp((_222 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _384 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_373.x), int(_373.y), int(_373.z), 0).xyz), 0));
        _405 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_384.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_373 / float3(_384.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _405 = _358;
    }
    float3 _419 = ((_341 - (_341 * _340)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _426 = (mix(float3(0.07999999821186065673828125 * _339), _341, float3(_340)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _429 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _434;
    if (_429)
    {
        _434 = _419 + (_426 * 0.449999988079071044921875);
    }
    else
    {
        _434 = _419;
    }
    float3 _436 = select(_426, float3(0.0), bool3(_429));
    float3 _438 = float3(dot(_436, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _512;
    if (_352)
    {
        float3 _464 = fast::clamp((_222 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _468 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _464);
        float4 _472 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _464);
        float4 _475 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _464);
        float4 _493 = _158;
        _493.y = (-0.48860299587249755859375) * _342.y;
        float4 _496 = _493;
        _496.z = 0.48860299587249755859375 * _342.z;
        float4 _499 = _496;
        _499.w = (-0.48860299587249755859375) * _342.x;
        float4 _500 = _499;
        _500.x = 0.886227548122406005859375;
        float3 _502 = _500.yzw * 2.094395160675048828125;
        float4 _503 = float4(_500.x, _502.x, _502.y, _502.z);
        float3 _505 = float3(0.0);
        _505.x = dot(float4(_468.x, _472.x, _475.x, _468.w), _503);
        float3 _507 = _505;
        _507.y = dot(float4(_468.y, _472.y, _475.y, _472.w), _503);
        float3 _509 = _507;
        _509.z = dot(float4(_468.z, _472.z, _475.zw), _503);
        _512 = fast::max(float3(0.0), _509) * float3(0.3183098733425140380859375);
    }
    else
    {
        _512 = float3(0.0);
    }
    float3 _515 = _512 * View.View_IndirectLightingColorScale;
    float3 _537 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _566;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _565;
        if (any(abs(_222 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _287 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _287 + 19u)].xyz + float3(1.0))))
        {
            _565 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_222, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _565 = _537;
        }
        _566 = _565;
    }
    else
    {
        _566 = _537;
    }
    float4 _573 = float4(((mix(float3(0.0), _434 + (_436 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_515 * _434) * fast::max(float3(1.0), ((((((_341 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_341 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_341 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _566) * 1.0, 0.0);
    float4 _580;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _579 = _573;
        _579.w = 0.0;
        _580 = _579;
    }
    else
    {
        _580 = _573;
    }
    float2 _584 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _592 = (_342 * 0.5) + float3(0.5);
    float4 _594 = float4(_592.x, _592.y, _592.z, float4(0.0).w);
    _594.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _288)].y;
    float4 _595 = float4(0.0);
    _595.x = _340;
    float4 _596 = _595;
    _596.y = _339;
    float4 _597 = _596;
    _597.z = _338;
    float4 _598 = _597;
    _598.w = 0.50588238239288330078125;
    float4 _610 = float4(_341.x, _341.y, _341.z, float4(0.0).w);
    _610.w = ((log2(((dot(_515, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_438 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_438 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_438 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_584.xyx * _584.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _580 * View.View_PreExposure;
    out.out_var_SV_Target1 = _594;
    out.out_var_SV_Target2 = _598;
    out.out_var_SV_Target3 = _610;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_405, 1.0, 1.0, 1.0);
    return out;
}

