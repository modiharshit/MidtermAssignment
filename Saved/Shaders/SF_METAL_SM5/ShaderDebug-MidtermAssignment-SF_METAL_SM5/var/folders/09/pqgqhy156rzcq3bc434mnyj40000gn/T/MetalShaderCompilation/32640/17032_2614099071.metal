

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

constant float _162 = {};
constant float4 _163 = {};

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

fragment MainPS_out Main_00004288_9bcffc7f(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], texture2d<float> Material_Texture2D_2 [[texture(10)]], texture2d<float> Material_Texture2D_3 [[texture(11)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], sampler Material_Texture2D_2Sampler [[sampler(5)]], sampler Material_Texture2D_3Sampler [[sampler(6)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float3x3 _207 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _218 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _162, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _223 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _227 = _223.xyz / float3(_223.w);
    float3 _228 = _227 - View.View_PreViewTranslation;
    float2 _232 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5;
    float4 _238 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _232, bias(View.View_MaterialTextureMipBias));
    float2 _244 = ((normalize(-_227) * _207).xy * ((0.00999999977648258209228515625 * _238.w) + (-0.008000000379979610443115234375))) + _232;
    float4 _248 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _244, bias(View.View_MaterialTextureMipBias));
    float2 _251 = (_248.xy * float2(2.0)) - float2(1.0);
    float3 _267 = normalize(_207 * normalize((float4(_251, sqrt(fast::clamp(1.0 - dot(_251, _251), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _279 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _284 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _289 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _293 = (_279.x + 0.5) * ((_284.x + 0.5) * (_289.x + 0.5));
    float4 _296 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _244, bias(View.View_MaterialTextureMipBias));
    float4 _302 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _244, bias(View.View_MaterialTextureMipBias));
    float3 _307 = fast::clamp(_296.xyz * mix(0.5, 1.0, _293), float3(0.0), float3(1.0));
    float _308 = fast::clamp(_302.y, 0.0, 1.0);
    float _313 = (fast::clamp(mix(0.300000011920928955078125, 0.800000011920928955078125, _293 * _302.x), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _314 = in.in_var_PRIMITIVE_ID * 36u;
    uint _315 = _314 + 20u;
    float _363;
    float _364;
    float _365;
    float3 _366;
    float3 _367;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _315)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _333 = ((_218.xy / float2(_218.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _337 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _333, level(0.0));
        float4 _340 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _333, level(0.0));
        float4 _343 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _333, level(0.0));
        float _353 = _343.w;
        _363 = (_313 * _353) + _343.z;
        _364 = (0.5 * _353) + _343.y;
        _365 = _343.x;
        _366 = (_307 * _337.w) + _337.xyz;
        _367 = normalize((_267 * _340.w) + ((_340.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _363 = _313;
        _364 = 0.5;
        _365 = 0.0;
        _366 = _307;
        _367 = _267;
    }
    bool _377 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _383;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _314 + 18u)].w > 0.0) && _377)
    {
        _383 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _383 = 1.0;
    }
    float _430;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _315)].z > 0.0)
    {
        float3 _398 = fast::clamp((_228 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _409 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_398.x), int(_398.y), int(_398.z), 0).xyz), 0));
        _430 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_409.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_398 / float3(_409.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _430 = _383;
    }
    float3 _444 = ((_366 - (_366 * _365)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _451 = (mix(float3(0.07999999821186065673828125 * _364), _366, float3(_365)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _454 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _459;
    if (_454)
    {
        _459 = _444 + (_451 * 0.449999988079071044921875);
    }
    else
    {
        _459 = _444;
    }
    float3 _461 = select(_451, float3(0.0), bool3(_454));
    float3 _463 = float3(dot(_461, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _470 = float3(_308);
    float3 _538;
    if (_377)
    {
        float3 _490 = fast::clamp((_228 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _494 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _490);
        float4 _498 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _490);
        float4 _501 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _490);
        float4 _519 = _163;
        _519.y = (-0.48860299587249755859375) * _367.y;
        float4 _522 = _519;
        _522.z = 0.48860299587249755859375 * _367.z;
        float4 _525 = _522;
        _525.w = (-0.48860299587249755859375) * _367.x;
        float4 _526 = _525;
        _526.x = 0.886227548122406005859375;
        float3 _528 = _526.yzw * 2.094395160675048828125;
        float4 _529 = float4(_526.x, _528.x, _528.y, _528.z);
        float3 _531 = float3(0.0);
        _531.x = dot(float4(_494.x, _498.x, _501.x, _494.w), _529);
        float3 _533 = _531;
        _533.y = dot(float4(_494.y, _498.y, _501.y, _498.w), _529);
        float3 _535 = _533;
        _535.z = dot(float4(_494.z, _498.z, _501.zw), _529);
        _538 = fast::max(float3(0.0), _535) * float3(0.3183098733425140380859375);
    }
    else
    {
        _538 = float3(0.0);
    }
    float3 _541 = _538 * View.View_IndirectLightingColorScale;
    float3 _563 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _592;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _591;
        if (any(abs(_228 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _314 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _314 + 19u)].xyz + float3(1.0))))
        {
            _591 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_228, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _591 = _563;
        }
        _592 = _591;
    }
    else
    {
        _592 = _563;
    }
    float4 _599 = float4(((mix(float3(0.0), _459 + (_461 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_541 * _459) * fast::max(_470, ((((((_366 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _308) + ((_366 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _308) + ((_366 * 2.755199909210205078125) + float3(0.69029998779296875))) * _308))) + _592) * 1.0, 0.0);
    float4 _606;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _605 = _599;
        _605.w = 0.0;
        _606 = _605;
    }
    else
    {
        _606 = _599;
    }
    float2 _610 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _618 = (_367 * 0.5) + float3(0.5);
    float4 _620 = float4(_618.x, _618.y, _618.z, float4(0.0).w);
    _620.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _315)].y;
    float4 _621 = float4(0.0);
    _621.x = _365;
    float4 _622 = _621;
    _622.y = _364;
    float4 _623 = _622;
    _623.z = _363;
    float4 _624 = _623;
    _624.w = 0.50588238239288330078125;
    float4 _636 = float4(_366.x, _366.y, _366.z, float4(0.0).w);
    _636.w = ((log2(((dot(_541, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_470, ((((((_463 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _308) + ((_463 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _308) + ((_463 * 2.755199909210205078125) + float3(0.69029998779296875))) * _308).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_610.xyx * _610.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _606 * View.View_PreExposure;
    out.out_var_SV_Target1 = _620;
    out.out_var_SV_Target2 = _624;
    out.out_var_SV_Target3 = _636;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_430, 1.0, 1.0, 1.0);
    return out;
}

