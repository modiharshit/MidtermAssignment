

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

fragment MainPS_out Main_000041ed_7ae2cb4a(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], texture2d<float> Material_Texture2D_2 [[texture(10)]], texture2d<float> Material_Texture2D_3 [[texture(11)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], sampler Material_Texture2D_2Sampler [[sampler(5)]], sampler Material_Texture2D_3Sampler [[sampler(6)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float3x3 _209 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _220 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _164, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _225 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _229 = _225.xyz / float3(_225.w);
    float3 _230 = _229 - View.View_PreViewTranslation;
    float4 _239 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _245 = ((normalize(-_229) * _209).xy * ((0.0599999986588954925537109375 * _239.x) + (-0.021600000560283660888671875))) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _249 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _245, bias(View.View_MaterialTextureMipBias));
    float2 _252 = (_249.xy * float2(2.0)) - float2(1.0);
    float3 _268 = normalize(_209 * normalize((float4(_252, sqrt(fast::clamp(1.0 - dot(_252, _252), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _280 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.20000000298023223876953125), bias(View.View_MaterialTextureMipBias));
    float4 _285 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float4 _290 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0030000000260770320892333984375), bias(View.View_MaterialTextureMipBias));
    float4 _298 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _245, bias(View.View_MaterialTextureMipBias));
    float _301 = _298.w;
    float3 _306 = fast::clamp(_298.xyz * ((_280.x + 0.5) * ((_285.x + 0.5) * (_290.x + 0.5))), float3(0.0), float3(1.0));
    float _307 = fast::clamp(_301 * 4.0, 0.0, 1.0);
    float _312 = (fast::clamp(fast::min(fast::max(mix(1.0, -1.75, _301), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _313 = in.in_var_PRIMITIVE_ID * 36u;
    uint _314 = _313 + 20u;
    float _362;
    float _363;
    float _364;
    float3 _365;
    float3 _366;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _314)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _332 = ((_220.xy / float2(_220.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _336 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _332, level(0.0));
        float4 _339 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _332, level(0.0));
        float4 _342 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _332, level(0.0));
        float _352 = _342.w;
        _362 = (_312 * _352) + _342.z;
        _363 = (_307 * _352) + _342.y;
        _364 = _342.x;
        _365 = (_306 * _336.w) + _336.xyz;
        _366 = normalize((_268 * _339.w) + ((_339.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _362 = _312;
        _363 = _307;
        _364 = 0.0;
        _365 = _306;
        _366 = _268;
    }
    bool _376 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _382;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _313 + 18u)].w > 0.0) && _376)
    {
        _382 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _382 = 1.0;
    }
    float _429;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _314)].z > 0.0)
    {
        float3 _397 = fast::clamp((_230 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _408 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_397.x), int(_397.y), int(_397.z), 0).xyz), 0));
        _429 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_408.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_397 / float3(_408.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _429 = _382;
    }
    float3 _443 = ((_365 - (_365 * _364)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _450 = (mix(float3(0.07999999821186065673828125 * _363), _365, float3(_364)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _453 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _458;
    if (_453)
    {
        _458 = _443 + (_450 * 0.449999988079071044921875);
    }
    else
    {
        _458 = _443;
    }
    float3 _460 = select(_450, float3(0.0), bool3(_453));
    float3 _462 = float3(dot(_460, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _536;
    if (_376)
    {
        float3 _488 = fast::clamp((_230 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _492 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _488);
        float4 _496 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _488);
        float4 _499 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _488);
        float4 _517 = _165;
        _517.y = (-0.48860299587249755859375) * _366.y;
        float4 _520 = _517;
        _520.z = 0.48860299587249755859375 * _366.z;
        float4 _523 = _520;
        _523.w = (-0.48860299587249755859375) * _366.x;
        float4 _524 = _523;
        _524.x = 0.886227548122406005859375;
        float3 _526 = _524.yzw * 2.094395160675048828125;
        float4 _527 = float4(_524.x, _526.x, _526.y, _526.z);
        float3 _529 = float3(0.0);
        _529.x = dot(float4(_492.x, _496.x, _499.x, _492.w), _527);
        float3 _531 = _529;
        _531.y = dot(float4(_492.y, _496.y, _499.y, _496.w), _527);
        float3 _533 = _531;
        _533.z = dot(float4(_492.z, _496.z, _499.zw), _527);
        _536 = fast::max(float3(0.0), _533) * float3(0.3183098733425140380859375);
    }
    else
    {
        _536 = float3(0.0);
    }
    float3 _539 = _536 * View.View_IndirectLightingColorScale;
    float3 _561 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _590;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _589;
        if (any(abs(_230 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _313 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _313 + 19u)].xyz + float3(1.0))))
        {
            _589 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_230, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _589 = _561;
        }
        _590 = _589;
    }
    else
    {
        _590 = _561;
    }
    float4 _597 = float4(((mix(float3(0.0), _458 + (_460 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_539 * _458) * fast::max(float3(1.0), ((((((_365 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_365 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_365 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _590) * 1.0, 0.0);
    float4 _604;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _603 = _597;
        _603.w = 0.0;
        _604 = _603;
    }
    else
    {
        _604 = _597;
    }
    float2 _608 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _616 = (_366 * 0.5) + float3(0.5);
    float4 _618 = float4(_616.x, _616.y, _616.z, float4(0.0).w);
    _618.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _314)].y;
    float4 _619 = float4(0.0);
    _619.x = _364;
    float4 _620 = _619;
    _620.y = _363;
    float4 _621 = _620;
    _621.z = _362;
    float4 _622 = _621;
    _622.w = 0.50588238239288330078125;
    float4 _634 = float4(_365.x, _365.y, _365.z, float4(0.0).w);
    _634.w = ((log2(((dot(_539, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_462 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_462 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_462 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_608.xyx * _608.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _604 * View.View_PreExposure;
    out.out_var_SV_Target1 = _618;
    out.out_var_SV_Target2 = _622;
    out.out_var_SV_Target3 = _634;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_429, 1.0, 1.0, 1.0);
    return out;
}

