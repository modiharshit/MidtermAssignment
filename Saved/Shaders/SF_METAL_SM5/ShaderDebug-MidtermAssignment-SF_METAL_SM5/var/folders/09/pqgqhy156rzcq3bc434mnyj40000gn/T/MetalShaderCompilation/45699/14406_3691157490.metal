

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

constant float _145 = {};
constant float4 _146 = {};

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

fragment MainPS_out Main_00003846_dc0297f2(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _197 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _145, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _202 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _207 = (_202.xyz / float3(_202.w)) - View.View_PreViewTranslation;
    float3 _215 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float _226 = (0.100000001490116119384765625 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _227 = in.in_var_PRIMITIVE_ID * 36u;
    uint _228 = _227 + 20u;
    float _277;
    float _278;
    float _279;
    float3 _280;
    float3 _281;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _228)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _246 = ((_197.xy / float2(_197.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _250 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _246, level(0.0));
        float4 _253 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _246, level(0.0));
        float4 _256 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _246, level(0.0));
        float _266 = _256.w;
        _277 = (_226 * _266) + _256.z;
        _278 = (0.5 * _266) + _256.y;
        _279 = _266 + _256.x;
        _280 = (float3(1.0) * _250.w) + _250.xyz;
        _281 = normalize((_215 * _253.w) + ((_253.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _277 = _226;
        _278 = 0.5;
        _279 = 1.0;
        _280 = float3(1.0);
        _281 = _215;
    }
    bool _291 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _297;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _227 + 18u)].w > 0.0) && _291)
    {
        _297 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _297 = 1.0;
    }
    float _344;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _228)].z > 0.0)
    {
        float3 _312 = fast::clamp((_207 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _323 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_312.x), int(_312.y), int(_312.z), 0).xyz), 0));
        _344 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_323.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_312 / float3(_323.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _344 = _297;
    }
    float3 _358 = ((_280 - (_280 * _279)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _365 = (mix(float3(0.07999999821186065673828125 * _278), _280, float3(_279)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _368 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _373;
    if (_368)
    {
        _373 = _358 + (_365 * 0.449999988079071044921875);
    }
    else
    {
        _373 = _358;
    }
    float3 _375 = select(_365, float3(0.0), bool3(_368));
    float3 _377 = float3(dot(_375, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _451;
    if (_291)
    {
        float3 _403 = fast::clamp((_207 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _407 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _403);
        float4 _411 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _403);
        float4 _414 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _403);
        float4 _432 = _146;
        _432.y = (-0.48860299587249755859375) * _281.y;
        float4 _435 = _432;
        _435.z = 0.48860299587249755859375 * _281.z;
        float4 _438 = _435;
        _438.w = (-0.48860299587249755859375) * _281.x;
        float4 _439 = _438;
        _439.x = 0.886227548122406005859375;
        float3 _441 = _439.yzw * 2.094395160675048828125;
        float4 _442 = float4(_439.x, _441.x, _441.y, _441.z);
        float3 _444 = float3(0.0);
        _444.x = dot(float4(_407.x, _411.x, _414.x, _407.w), _442);
        float3 _446 = _444;
        _446.y = dot(float4(_407.y, _411.y, _414.y, _411.w), _442);
        float3 _448 = _446;
        _448.z = dot(float4(_407.z, _411.z, _414.zw), _442);
        _451 = fast::max(float3(0.0), _448) * float3(0.3183098733425140380859375);
    }
    else
    {
        _451 = float3(0.0);
    }
    float3 _454 = _451 * View.View_IndirectLightingColorScale;
    float3 _476 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _505;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _504;
        if (any(abs(_207 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _227 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _227 + 19u)].xyz + float3(1.0))))
        {
            _504 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_207, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _504 = _476;
        }
        _505 = _504;
    }
    else
    {
        _505 = _476;
    }
    float4 _512 = float4(((mix(float3(0.0), _373 + (_375 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_454 * _373) * fast::max(float3(1.0), ((((((_280 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_280 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_280 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _505) * 1.0, 0.0);
    float4 _519;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _518 = _512;
        _518.w = 0.0;
        _519 = _518;
    }
    else
    {
        _519 = _512;
    }
    float2 _523 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _531 = (_281 * 0.5) + float3(0.5);
    float4 _533 = float4(_531.x, _531.y, _531.z, float4(0.0).w);
    _533.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _228)].y;
    float4 _534 = float4(0.0);
    _534.x = _279;
    float4 _535 = _534;
    _535.y = _278;
    float4 _536 = _535;
    _536.z = _277;
    float4 _537 = _536;
    _537.w = 0.50588238239288330078125;
    float4 _549 = float4(_280.x, _280.y, _280.z, float4(0.0).w);
    _549.w = ((log2(((dot(_454, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_377 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_377 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_377 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_523.xyx * _523.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _519 * View.View_PreExposure;
    out.out_var_SV_Target1 = _533;
    out.out_var_SV_Target2 = _537;
    out.out_var_SV_Target3 = _549;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_344, 1.0, 1.0, 1.0);
    return out;
}

