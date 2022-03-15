

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

constant float _152 = {};
constant float4 _153 = {};

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

fragment MainPS_out Main_00003ac1_4dbf0985(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _208 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _152, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _213 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _218 = (_213.xyz / float3(_213.w)) - View.View_PreViewTranslation;
    float3 _226 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _239 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _241 = fast::clamp(_239.xyz, float3(0.0), float3(1.0));
    float _245 = (0.949999988079071044921875 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _246 = in.in_var_PRIMITIVE_ID * 36u;
    uint _247 = _246 + 20u;
    float _295;
    float _296;
    float _297;
    float3 _298;
    float3 _299;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _247)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _265 = ((_208.xy / float2(_208.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _269 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _265, level(0.0));
        float4 _272 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _265, level(0.0));
        float4 _275 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _265, level(0.0));
        float _285 = _275.w;
        _295 = (_245 * _285) + _275.z;
        _296 = (0.20000000298023223876953125 * _285) + _275.y;
        _297 = _275.x;
        _298 = (_241 * _269.w) + _269.xyz;
        _299 = normalize((_226 * _272.w) + ((_272.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _295 = _245;
        _296 = 0.20000000298023223876953125;
        _297 = 0.0;
        _298 = _241;
        _299 = _226;
    }
    bool _309 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _315;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _246 + 18u)].w > 0.0) && _309)
    {
        _315 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _315 = 1.0;
    }
    float _362;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _247)].z > 0.0)
    {
        float3 _330 = fast::clamp((_218 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _341 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_330.x), int(_330.y), int(_330.z), 0).xyz), 0));
        _362 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_341.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_330 / float3(_341.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _362 = _315;
    }
    float3 _376 = ((_298 - (_298 * _297)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _383 = (mix(float3(0.07999999821186065673828125 * _296), _298, float3(_297)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _386 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _391;
    if (_386)
    {
        _391 = _376 + (_383 * 0.449999988079071044921875);
    }
    else
    {
        _391 = _376;
    }
    float3 _393 = select(_383, float3(0.0), bool3(_386));
    float3 _395 = float3(dot(_393, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _469;
    if (_309)
    {
        float3 _421 = fast::clamp((_218 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _425 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _421);
        float4 _429 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _421);
        float4 _432 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _421);
        float4 _450 = _153;
        _450.y = (-0.48860299587249755859375) * _299.y;
        float4 _453 = _450;
        _453.z = 0.48860299587249755859375 * _299.z;
        float4 _456 = _453;
        _456.w = (-0.48860299587249755859375) * _299.x;
        float4 _457 = _456;
        _457.x = 0.886227548122406005859375;
        float3 _459 = _457.yzw * 2.094395160675048828125;
        float4 _460 = float4(_457.x, _459.x, _459.y, _459.z);
        float3 _462 = float3(0.0);
        _462.x = dot(float4(_425.x, _429.x, _432.x, _425.w), _460);
        float3 _464 = _462;
        _464.y = dot(float4(_425.y, _429.y, _432.y, _429.w), _460);
        float3 _466 = _464;
        _466.z = dot(float4(_425.z, _429.z, _432.zw), _460);
        _469 = fast::max(float3(0.0), _466) * float3(0.3183098733425140380859375);
    }
    else
    {
        _469 = float3(0.0);
    }
    float3 _472 = _469 * View.View_IndirectLightingColorScale;
    float3 _494 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _523;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _522;
        if (any(abs(_218 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _246 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _246 + 19u)].xyz + float3(1.0))))
        {
            _522 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_218, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _522 = _494;
        }
        _523 = _522;
    }
    else
    {
        _523 = _494;
    }
    float4 _530 = float4(((mix(float3(0.0), _391 + (_393 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_472 * _391) * fast::max(float3(1.0), ((((((_298 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_298 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_298 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _523) * 1.0, 0.0);
    float4 _537;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _536 = _530;
        _536.w = 0.0;
        _537 = _536;
    }
    else
    {
        _537 = _530;
    }
    float2 _541 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _549 = (_299 * 0.5) + float3(0.5);
    float4 _551 = float4(_549.x, _549.y, _549.z, float4(0.0).w);
    _551.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _247)].y;
    float4 _552 = float4(0.0);
    _552.x = _297;
    float4 _553 = _552;
    _553.y = _296;
    float4 _554 = _553;
    _554.z = _295;
    float4 _555 = _554;
    _555.w = 0.50588238239288330078125;
    float4 _567 = float4(_298.x, _298.y, _298.z, float4(0.0).w);
    _567.w = ((log2(((dot(_472, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_395 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_395 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_395 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_541.xyx * _541.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _537 * View.View_PreExposure;
    out.out_var_SV_Target1 = _551;
    out.out_var_SV_Target2 = _555;
    out.out_var_SV_Target3 = _567;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_362, 1.0, 1.0, 1.0);
    return out;
}

