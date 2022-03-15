

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
    float4 in_var_TEXCOORD0_0 [[user(locn2)]];
    uint in_var_PRIMITIVE_ID [[user(locn3)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_000041f7_051309d7(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], texture2d<float> Material_Texture2D_2 [[texture(10)]], texture2d<float> Material_Texture2D_3 [[texture(11)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], sampler Material_Texture2D_2Sampler [[sampler(5)]], sampler Material_Texture2D_3Sampler [[sampler(6)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _219 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _163, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _224 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _229 = (_224.xyz / float3(_224.w)) - View.View_PreViewTranslation;
    float2 _230 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5;
    float4 _236 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _230, bias(View.View_MaterialTextureMipBias));
    float2 _239 = (_236.xy * float2(2.0)) - float2(1.0);
    float3 _255 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_239, sqrt(fast::clamp(1.0 - dot(_239, _239), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _267 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _272 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _277 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _281 = (_267.x + 0.5) * ((_272.x + 0.5) * (_277.x + 0.5));
    float4 _286 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _230, bias(View.View_MaterialTextureMipBias));
    float4 _292 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _230, bias(View.View_MaterialTextureMipBias));
    float _293 = _292.w;
    float3 _300 = fast::clamp(_286.xyz * mix(0.800000011920928955078125, 1.2000000476837158203125, _281), float3(0.0), float3(1.0));
    float _301 = fast::clamp(fast::min(fast::max(_293, 0.0), 1.0) * 2.0, 0.0, 1.0);
    float _302 = fast::clamp(_293, 0.0, 1.0);
    float _307 = (fast::clamp(mix(0.20000000298023223876953125, mix(0.60000002384185791015625, 1.0, _281), _292.x), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _308 = in.in_var_PRIMITIVE_ID * 36u;
    uint _309 = _308 + 20u;
    float _357;
    float _358;
    float _359;
    float3 _360;
    float3 _361;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _309)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _327 = ((_219.xy / float2(_219.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _331 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _327, level(0.0));
        float4 _334 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _327, level(0.0));
        float4 _337 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _327, level(0.0));
        float _347 = _337.w;
        _357 = (_307 * _347) + _337.z;
        _358 = (_301 * _347) + _337.y;
        _359 = _337.x;
        _360 = (_300 * _331.w) + _331.xyz;
        _361 = normalize((_255 * _334.w) + ((_334.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _357 = _307;
        _358 = _301;
        _359 = 0.0;
        _360 = _300;
        _361 = _255;
    }
    bool _371 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _377;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _308 + 18u)].w > 0.0) && _371)
    {
        _377 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _377 = 1.0;
    }
    float _424;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _309)].z > 0.0)
    {
        float3 _392 = fast::clamp((_229 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _403 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_392.x), int(_392.y), int(_392.z), 0).xyz), 0));
        _424 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_403.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_392 / float3(_403.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _424 = _377;
    }
    float3 _438 = ((_360 - (_360 * _359)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _445 = (mix(float3(0.07999999821186065673828125 * _358), _360, float3(_359)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _448 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _453;
    if (_448)
    {
        _453 = _438 + (_445 * 0.449999988079071044921875);
    }
    else
    {
        _453 = _438;
    }
    float3 _455 = select(_445, float3(0.0), bool3(_448));
    float3 _457 = float3(dot(_455, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _464 = float3(_302);
    float3 _532;
    if (_371)
    {
        float3 _484 = fast::clamp((_229 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _488 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _484);
        float4 _492 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _484);
        float4 _495 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _484);
        float4 _513 = _164;
        _513.y = (-0.48860299587249755859375) * _361.y;
        float4 _516 = _513;
        _516.z = 0.48860299587249755859375 * _361.z;
        float4 _519 = _516;
        _519.w = (-0.48860299587249755859375) * _361.x;
        float4 _520 = _519;
        _520.x = 0.886227548122406005859375;
        float3 _522 = _520.yzw * 2.094395160675048828125;
        float4 _523 = float4(_520.x, _522.x, _522.y, _522.z);
        float3 _525 = float3(0.0);
        _525.x = dot(float4(_488.x, _492.x, _495.x, _488.w), _523);
        float3 _527 = _525;
        _527.y = dot(float4(_488.y, _492.y, _495.y, _492.w), _523);
        float3 _529 = _527;
        _529.z = dot(float4(_488.z, _492.z, _495.zw), _523);
        _532 = fast::max(float3(0.0), _529) * float3(0.3183098733425140380859375);
    }
    else
    {
        _532 = float3(0.0);
    }
    float3 _535 = _532 * View.View_IndirectLightingColorScale;
    float3 _557 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _586;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _585;
        if (any(abs(_229 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _308 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _308 + 19u)].xyz + float3(1.0))))
        {
            _585 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_229, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _585 = _557;
        }
        _586 = _585;
    }
    else
    {
        _586 = _557;
    }
    float4 _593 = float4(((mix(float3(0.0), _453 + (_455 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_535 * _453) * fast::max(_464, ((((((_360 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _302) + ((_360 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _302) + ((_360 * 2.755199909210205078125) + float3(0.69029998779296875))) * _302))) + _586) * 1.0, 0.0);
    float4 _600;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _599 = _593;
        _599.w = 0.0;
        _600 = _599;
    }
    else
    {
        _600 = _593;
    }
    float2 _604 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _612 = (_361 * 0.5) + float3(0.5);
    float4 _614 = float4(_612.x, _612.y, _612.z, float4(0.0).w);
    _614.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _309)].y;
    float4 _615 = float4(0.0);
    _615.x = _359;
    float4 _616 = _615;
    _616.y = _358;
    float4 _617 = _616;
    _617.z = _357;
    float4 _618 = _617;
    _618.w = 0.50588238239288330078125;
    float4 _630 = float4(_360.x, _360.y, _360.z, float4(0.0).w);
    _630.w = ((log2(((dot(_535, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_464, ((((((_457 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _302) + ((_457 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _302) + ((_457 * 2.755199909210205078125) + float3(0.69029998779296875))) * _302).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_604.xyx * _604.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _600 * View.View_PreExposure;
    out.out_var_SV_Target1 = _614;
    out.out_var_SV_Target2 = _618;
    out.out_var_SV_Target3 = _630;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_424, 1.0, 1.0, 1.0);
    return out;
}

