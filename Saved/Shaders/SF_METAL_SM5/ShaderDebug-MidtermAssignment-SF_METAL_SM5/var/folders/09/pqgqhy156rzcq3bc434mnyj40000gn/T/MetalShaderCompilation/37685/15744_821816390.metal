

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
    char _m11_pad[24];
    float View_CullingSign;
    char _m12_pad[20];
    float View_MaterialTextureMipBias;
    char _m13_pad[28];
    float View_UnlitViewmodeMask;
    char _m14_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m15_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m16_pad[188];
    float View_ShowDecalsMask;
    char _m17_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m18_pad[48];
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

constant float _155 = {};
constant float4 _156 = {};

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

fragment MainPS_out Main_00003d80_30fbec46(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], float4 gl_FragCoord [[position]], bool gl_FrontFacing [[front_facing]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _215 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _155, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _220 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _225 = (_220.xyz / float3(_220.w)) - View.View_PreViewTranslation;
    uint _226 = in.in_var_PRIMITIVE_ID * 36u;
    float4 _240 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _243 = (_240.xy * float2(2.0)) - float2(1.0);
    float3 _259 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_243, sqrt(fast::clamp(1.0 - dot(_243, _243), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * ((View.View_CullingSign * View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _226 + 4u)].w) * float(gl_FrontFacing ? 1 : (-1)));
    float4 _270 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    if ((_270.w - 0.33329999446868896484375) < 0.0)
    {
        discard_fragment();
    }
    float3 _277 = fast::clamp(_270.xyz, float3(0.0), float3(1.0));
    float _281 = (0.5 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _282 = _226 + 20u;
    float _330;
    float _331;
    float _332;
    float3 _333;
    float3 _334;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _282)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _300 = ((_215.xy / float2(_215.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _304 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _300, level(0.0));
        float4 _307 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _300, level(0.0));
        float4 _310 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _300, level(0.0));
        float _320 = _310.w;
        _330 = (_281 * _320) + _310.z;
        _331 = (0.5 * _320) + _310.y;
        _332 = _310.x;
        _333 = (_277 * _304.w) + _304.xyz;
        _334 = normalize((_259 * _307.w) + ((_307.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _330 = _281;
        _331 = 0.5;
        _332 = 0.0;
        _333 = _277;
        _334 = _259;
    }
    bool _344 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _350;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _226 + 18u)].w > 0.0) && _344)
    {
        _350 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _350 = 1.0;
    }
    float _397;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _282)].z > 0.0)
    {
        float3 _365 = fast::clamp((_225 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _376 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_365.x), int(_365.y), int(_365.z), 0).xyz), 0));
        _397 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_376.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_365 / float3(_376.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _397 = _350;
    }
    float3 _411 = ((_333 - (_333 * _332)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _418 = (mix(float3(0.07999999821186065673828125 * _331), _333, float3(_332)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _421 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _426;
    if (_421)
    {
        _426 = _411 + (_418 * 0.449999988079071044921875);
    }
    else
    {
        _426 = _411;
    }
    float3 _428 = select(_418, float3(0.0), bool3(_421));
    float3 _430 = float3(dot(_428, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _504;
    if (_344)
    {
        float3 _456 = fast::clamp((_225 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _460 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _456);
        float4 _464 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _456);
        float4 _467 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _456);
        float4 _485 = _156;
        _485.y = (-0.48860299587249755859375) * _334.y;
        float4 _488 = _485;
        _488.z = 0.48860299587249755859375 * _334.z;
        float4 _491 = _488;
        _491.w = (-0.48860299587249755859375) * _334.x;
        float4 _492 = _491;
        _492.x = 0.886227548122406005859375;
        float3 _494 = _492.yzw * 2.094395160675048828125;
        float4 _495 = float4(_492.x, _494.x, _494.y, _494.z);
        float3 _497 = float3(0.0);
        _497.x = dot(float4(_460.x, _464.x, _467.x, _460.w), _495);
        float3 _499 = _497;
        _499.y = dot(float4(_460.y, _464.y, _467.y, _464.w), _495);
        float3 _501 = _499;
        _501.z = dot(float4(_460.z, _464.z, _467.zw), _495);
        _504 = fast::max(float3(0.0), _501) * float3(0.3183098733425140380859375);
    }
    else
    {
        _504 = float3(0.0);
    }
    float3 _507 = _504 * View.View_IndirectLightingColorScale;
    float3 _529 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _558;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _557;
        if (any(abs(_225 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _226 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _226 + 19u)].xyz + float3(1.0))))
        {
            _557 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_225, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _557 = _529;
        }
        _558 = _557;
    }
    else
    {
        _558 = _529;
    }
    float4 _565 = float4(((mix(float3(0.0), _426 + (_428 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_507 * _426) * fast::max(float3(1.0), ((((((_333 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_333 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_333 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _558) * 1.0, 0.0);
    float4 _572;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _571 = _565;
        _571.w = 0.0;
        _572 = _571;
    }
    else
    {
        _572 = _565;
    }
    float2 _576 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _584 = (_334 * 0.5) + float3(0.5);
    float4 _586 = float4(_584.x, _584.y, _584.z, float4(0.0).w);
    _586.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _282)].y;
    float4 _587 = float4(0.0);
    _587.x = _332;
    float4 _588 = _587;
    _588.y = _331;
    float4 _589 = _588;
    _589.z = _330;
    float4 _590 = _589;
    _590.w = 0.50588238239288330078125;
    float4 _602 = float4(_333.x, _333.y, _333.z, float4(0.0).w);
    _602.w = ((log2(((dot(_507, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_430 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_430 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_430 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_576.xyx * _576.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _572 * View.View_PreExposure;
    out.out_var_SV_Target1 = _586;
    out.out_var_SV_Target2 = _590;
    out.out_var_SV_Target3 = _602;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_397, 1.0, 1.0, 1.0);
    return out;
}

