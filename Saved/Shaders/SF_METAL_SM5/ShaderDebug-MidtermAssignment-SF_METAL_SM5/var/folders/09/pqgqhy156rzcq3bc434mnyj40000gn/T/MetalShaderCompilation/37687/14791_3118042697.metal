

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
    char _m11_pad[80];
    float View_UnlitViewmodeMask;
    char _m12_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m13_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m14_pad[188];
    float View_ShowDecalsMask;
    char _m15_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m16_pad[48];
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

constant float _156 = {};
constant float4 _157 = {};

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

fragment MainPS_out Main_000039c7_b9d98e49(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _210 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _156, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _215 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _220 = (_215.xyz / float3(_215.w)) - View.View_PreViewTranslation;
    float3 _228 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _242 = fast::clamp(mix(float3(0.25), float3(0.569999992847442626953125, 0.3332314789295196533203125, 0.0342000015079975128173828125), float3(fast::min(fast::max(mix(-20.0, 20.0, in_var_TEXCOORD0[0].y), 0.0), 1.0))), float3(0.0), float3(1.0));
    float _246 = (0.20000000298023223876953125 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _247 = in.in_var_PRIMITIVE_ID * 36u;
    uint _248 = _247 + 20u;
    float _296;
    float _297;
    float _298;
    float3 _299;
    float3 _300;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _248)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _266 = ((_210.xy / float2(_210.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _270 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _266, level(0.0));
        float4 _273 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _266, level(0.0));
        float4 _276 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _266, level(0.0));
        float _286 = _276.w;
        _296 = (_246 * _286) + _276.z;
        _297 = (0.5 * _286) + _276.y;
        _298 = _276.x;
        _299 = (_242 * _270.w) + _270.xyz;
        _300 = normalize((_228 * _273.w) + ((_273.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _296 = _246;
        _297 = 0.5;
        _298 = 0.0;
        _299 = _242;
        _300 = _228;
    }
    bool _310 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _316;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _247 + 18u)].w > 0.0) && _310)
    {
        _316 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _316 = 1.0;
    }
    float _363;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _248)].z > 0.0)
    {
        float3 _331 = fast::clamp((_220 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _342 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_331.x), int(_331.y), int(_331.z), 0).xyz), 0));
        _363 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_342.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_331 / float3(_342.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _363 = _316;
    }
    float3 _377 = ((_299 - (_299 * _298)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _384 = (mix(float3(0.07999999821186065673828125 * _297), _299, float3(_298)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _387 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _392;
    if (_387)
    {
        _392 = _377 + (_384 * 0.449999988079071044921875);
    }
    else
    {
        _392 = _377;
    }
    float3 _394 = select(_384, float3(0.0), bool3(_387));
    float3 _396 = float3(dot(_394, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _470;
    if (_310)
    {
        float3 _422 = fast::clamp((_220 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _426 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _422);
        float4 _430 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _422);
        float4 _433 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _422);
        float4 _451 = _157;
        _451.y = (-0.48860299587249755859375) * _300.y;
        float4 _454 = _451;
        _454.z = 0.48860299587249755859375 * _300.z;
        float4 _457 = _454;
        _457.w = (-0.48860299587249755859375) * _300.x;
        float4 _458 = _457;
        _458.x = 0.886227548122406005859375;
        float3 _460 = _458.yzw * 2.094395160675048828125;
        float4 _461 = float4(_458.x, _460.x, _460.y, _460.z);
        float3 _463 = float3(0.0);
        _463.x = dot(float4(_426.x, _430.x, _433.x, _426.w), _461);
        float3 _465 = _463;
        _465.y = dot(float4(_426.y, _430.y, _433.y, _430.w), _461);
        float3 _467 = _465;
        _467.z = dot(float4(_426.z, _430.z, _433.zw), _461);
        _470 = fast::max(float3(0.0), _467) * float3(0.3183098733425140380859375);
    }
    else
    {
        _470 = float3(0.0);
    }
    float3 _473 = _470 * View.View_IndirectLightingColorScale;
    float3 _495 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _524;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _523;
        if (any(abs(_220 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _247 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _247 + 19u)].xyz + float3(1.0))))
        {
            _523 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_220, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _523 = _495;
        }
        _524 = _523;
    }
    else
    {
        _524 = _495;
    }
    float4 _531 = float4(((mix(float3(0.0), _392 + (_394 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_473 * _392) * fast::max(float3(1.0), ((((((_299 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_299 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_299 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _524) * 1.0, 0.0);
    float4 _538;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _537 = _531;
        _537.w = 0.0;
        _538 = _537;
    }
    else
    {
        _538 = _531;
    }
    float2 _542 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _550 = (_300 * 0.5) + float3(0.5);
    float4 _552 = float4(_550.x, _550.y, _550.z, float4(0.0).w);
    _552.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _248)].y;
    float4 _553 = float4(0.0);
    _553.x = _298;
    float4 _554 = _553;
    _554.y = _297;
    float4 _555 = _554;
    _555.z = _296;
    float4 _556 = _555;
    _556.w = 0.50588238239288330078125;
    float4 _568 = float4(_299.x, _299.y, _299.z, float4(0.0).w);
    _568.w = ((log2(((dot(_473, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_396 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_396 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_396 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_542.xyx * _542.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _538 * View.View_PreExposure;
    out.out_var_SV_Target1 = _552;
    out.out_var_SV_Target2 = _556;
    out.out_var_SV_Target3 = _568;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_363, 1.0, 1.0, 1.0);
    return out;
}

