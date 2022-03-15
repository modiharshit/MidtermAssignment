

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
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float _160 = {};
constant float4 _161 = {};

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

fragment MainPS_out Main_000040e3_c04d622c(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], texture2d<float> Material_Texture2D_2 [[texture(10)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], sampler Material_Texture2D_2Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _216 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _160, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _221 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _226 = (_221.xyz / float3(_221.w)) - View.View_PreViewTranslation;
    float4 _232 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _235 = (_232.xy * float2(2.0)) - float2(1.0);
    float _242 = sqrt(fast::clamp(1.0 - dot(_235, _235), 0.0, 1.0)) + 1.0;
    float4 _245 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 2.0), bias(View.View_MaterialTextureMipBias));
    float2 _248 = (_245.xy * float2(2.0)) - float2(1.0);
    float3 _257 = float4(_248, sqrt(fast::clamp(1.0 - dot(_248, _248), 0.0, 1.0)), 1.0).xyz * float3(-1.0, -1.0, 1.0);
    float3 _260 = float3(_235, _242);
    float3 _264 = float3(_257.xy * (-1.0), _257.z);
    float3 _276 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((((_260 * dot(_260, _264)) - (_264 * _242)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _288 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _293 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.02999999932944774627685546875), bias(View.View_MaterialTextureMipBias));
    float4 _302 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _306 = fast::clamp(mix(float3(0.5), float3(1.0), float3((_288.x + 0.5) * (_293.x + 0.5))) * _302.xyz, float3(0.0), float3(1.0));
    float _307 = fast::clamp(_302.w, 0.0, 1.0);
    float _311 = (0.980000019073486328125 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _312 = in.in_var_PRIMITIVE_ID * 36u;
    uint _313 = _312 + 20u;
    float _361;
    float _362;
    float _363;
    float3 _364;
    float3 _365;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _313)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _331 = ((_216.xy / float2(_216.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _335 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _331, level(0.0));
        float4 _338 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _331, level(0.0));
        float4 _341 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _331, level(0.0));
        float _351 = _341.w;
        _361 = (_311 * _351) + _341.z;
        _362 = (_307 * _351) + _341.y;
        _363 = _341.x;
        _364 = (_306 * _335.w) + _335.xyz;
        _365 = normalize((_276 * _338.w) + ((_338.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _361 = _311;
        _362 = _307;
        _363 = 0.0;
        _364 = _306;
        _365 = _276;
    }
    bool _375 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _381;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _312 + 18u)].w > 0.0) && _375)
    {
        _381 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _381 = 1.0;
    }
    float _428;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _313)].z > 0.0)
    {
        float3 _396 = fast::clamp((_226 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _407 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_396.x), int(_396.y), int(_396.z), 0).xyz), 0));
        _428 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_407.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_396 / float3(_407.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _428 = _381;
    }
    float3 _442 = ((_364 - (_364 * _363)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _449 = (mix(float3(0.07999999821186065673828125 * _362), _364, float3(_363)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _452 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _457;
    if (_452)
    {
        _457 = _442 + (_449 * 0.449999988079071044921875);
    }
    else
    {
        _457 = _442;
    }
    float3 _459 = select(_449, float3(0.0), bool3(_452));
    float3 _461 = float3(dot(_459, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _535;
    if (_375)
    {
        float3 _487 = fast::clamp((_226 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _491 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _487);
        float4 _495 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _487);
        float4 _498 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _487);
        float4 _516 = _161;
        _516.y = (-0.48860299587249755859375) * _365.y;
        float4 _519 = _516;
        _519.z = 0.48860299587249755859375 * _365.z;
        float4 _522 = _519;
        _522.w = (-0.48860299587249755859375) * _365.x;
        float4 _523 = _522;
        _523.x = 0.886227548122406005859375;
        float3 _525 = _523.yzw * 2.094395160675048828125;
        float4 _526 = float4(_523.x, _525.x, _525.y, _525.z);
        float3 _528 = float3(0.0);
        _528.x = dot(float4(_491.x, _495.x, _498.x, _491.w), _526);
        float3 _530 = _528;
        _530.y = dot(float4(_491.y, _495.y, _498.y, _495.w), _526);
        float3 _532 = _530;
        _532.z = dot(float4(_491.z, _495.z, _498.zw), _526);
        _535 = fast::max(float3(0.0), _532) * float3(0.3183098733425140380859375);
    }
    else
    {
        _535 = float3(0.0);
    }
    float3 _538 = _535 * View.View_IndirectLightingColorScale;
    float3 _560 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _589;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _588;
        if (any(abs(_226 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _312 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _312 + 19u)].xyz + float3(1.0))))
        {
            _588 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_226, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _588 = _560;
        }
        _589 = _588;
    }
    else
    {
        _589 = _560;
    }
    float4 _596 = float4(((mix(float3(0.0), _457 + (_459 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_538 * _457) * fast::max(float3(1.0), ((((((_364 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_364 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_364 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _589) * 1.0, 0.0);
    float4 _603;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _602 = _596;
        _602.w = 0.0;
        _603 = _602;
    }
    else
    {
        _603 = _596;
    }
    float2 _607 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _615 = (_365 * 0.5) + float3(0.5);
    float4 _617 = float4(_615.x, _615.y, _615.z, float4(0.0).w);
    _617.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _313)].y;
    float4 _618 = float4(0.0);
    _618.x = _363;
    float4 _619 = _618;
    _619.y = _362;
    float4 _620 = _619;
    _620.z = _361;
    float4 _621 = _620;
    _621.w = 0.50588238239288330078125;
    float4 _633 = float4(_364.x, _364.y, _364.z, float4(0.0).w);
    _633.w = ((log2(((dot(_538, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_461 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_461 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_461 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_607.xyx * _607.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _603 * View.View_PreExposure;
    out.out_var_SV_Target1 = _617;
    out.out_var_SV_Target2 = _621;
    out.out_var_SV_Target3 = _633;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_428, 1.0, 1.0, 1.0);
    return out;
}

