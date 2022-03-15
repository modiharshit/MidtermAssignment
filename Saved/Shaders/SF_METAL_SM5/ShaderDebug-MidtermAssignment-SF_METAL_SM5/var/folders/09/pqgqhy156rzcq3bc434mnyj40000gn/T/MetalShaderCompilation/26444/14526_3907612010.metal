

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
    spvUnsafeArray<float4, 4> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float _144 = {};
constant float4 _145 = {};

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
    uint in_var_PRIMITIVE_ID [[user(locn2)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_000038be_e8e96d6a(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _196 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _144, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _201 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _206 = (_201.xyz / float3(_201.w)) - View.View_PreViewTranslation;
    float3 _214 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _227 = fast::clamp(Material.Material_VectorExpressions[3].xyz, float3(0.0), float3(1.0));
    float _232 = (fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _233 = in.in_var_PRIMITIVE_ID * 36u;
    uint _234 = _233 + 20u;
    float _282;
    float _283;
    float _284;
    float3 _285;
    float3 _286;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _234)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _252 = ((_196.xy / float2(_196.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _256 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _252, level(0.0));
        float4 _259 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _252, level(0.0));
        float4 _262 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _252, level(0.0));
        float _272 = _262.w;
        _282 = (_232 * _272) + _262.z;
        _283 = (0.5 * _272) + _262.y;
        _284 = _262.x;
        _285 = (_227 * _256.w) + _256.xyz;
        _286 = normalize((_214 * _259.w) + ((_259.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _282 = _232;
        _283 = 0.5;
        _284 = 0.0;
        _285 = _227;
        _286 = _214;
    }
    bool _296 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _302;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _233 + 18u)].w > 0.0) && _296)
    {
        _302 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _302 = 1.0;
    }
    float _349;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _234)].z > 0.0)
    {
        float3 _317 = fast::clamp((_206 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _328 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_317.x), int(_317.y), int(_317.z), 0).xyz), 0));
        _349 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_328.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_317 / float3(_328.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _349 = _302;
    }
    float3 _363 = ((_285 - (_285 * _284)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _370 = (mix(float3(0.07999999821186065673828125 * _283), _285, float3(_284)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _373 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _378;
    if (_373)
    {
        _378 = _363 + (_370 * 0.449999988079071044921875);
    }
    else
    {
        _378 = _363;
    }
    float3 _380 = select(_370, float3(0.0), bool3(_373));
    float3 _382 = float3(dot(_380, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _456;
    if (_296)
    {
        float3 _408 = fast::clamp((_206 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _412 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _408);
        float4 _416 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _408);
        float4 _419 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _408);
        float4 _437 = _145;
        _437.y = (-0.48860299587249755859375) * _286.y;
        float4 _440 = _437;
        _440.z = 0.48860299587249755859375 * _286.z;
        float4 _443 = _440;
        _443.w = (-0.48860299587249755859375) * _286.x;
        float4 _444 = _443;
        _444.x = 0.886227548122406005859375;
        float3 _446 = _444.yzw * 2.094395160675048828125;
        float4 _447 = float4(_444.x, _446.x, _446.y, _446.z);
        float3 _449 = float3(0.0);
        _449.x = dot(float4(_412.x, _416.x, _419.x, _412.w), _447);
        float3 _451 = _449;
        _451.y = dot(float4(_412.y, _416.y, _419.y, _416.w), _447);
        float3 _453 = _451;
        _453.z = dot(float4(_412.z, _416.z, _419.zw), _447);
        _456 = fast::max(float3(0.0), _453) * float3(0.3183098733425140380859375);
    }
    else
    {
        _456 = float3(0.0);
    }
    float3 _459 = _456 * View.View_IndirectLightingColorScale;
    float3 _481 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _510;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _509;
        if (any(abs(_206 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _233 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _233 + 19u)].xyz + float3(1.0))))
        {
            _509 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_206, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _509 = _481;
        }
        _510 = _509;
    }
    else
    {
        _510 = _481;
    }
    float4 _517 = float4(((mix(float3(0.0), _378 + (_380 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_459 * _378) * fast::max(float3(1.0), ((((((_285 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_285 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_285 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _510) * 1.0, 0.0);
    float4 _524;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _523 = _517;
        _523.w = 0.0;
        _524 = _523;
    }
    else
    {
        _524 = _517;
    }
    float2 _528 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _536 = (_286 * 0.5) + float3(0.5);
    float4 _538 = float4(_536.x, _536.y, _536.z, float4(0.0).w);
    _538.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _234)].y;
    float4 _539 = float4(0.0);
    _539.x = _284;
    float4 _540 = _539;
    _540.y = _283;
    float4 _541 = _540;
    _541.z = _282;
    float4 _542 = _541;
    _542.w = 0.50588238239288330078125;
    float4 _554 = float4(_285.x, _285.y, _285.z, float4(0.0).w);
    _554.w = ((log2(((dot(_459, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_382 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_382 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_382 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_528.xyx * _528.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _524 * View.View_PreExposure;
    out.out_var_SV_Target1 = _538;
    out.out_var_SV_Target2 = _542;
    out.out_var_SV_Target3 = _554;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_349, 1.0, 1.0, 1.0);
    return out;
}

