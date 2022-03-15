

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
    char _m0_pad[256];
    float4x4 View_ViewToTranslatedWorld;
    char _m1_pad[384];
    float4x4 View_SVPositionToTranslatedWorld;
    char _m2_pad[288];
    float4 View_ScreenPositionScaleBias;
    float3 View_WorldCameraOrigin;
    char _m4_pad[32];
    float3 View_PreViewTranslation;
    char _m5_pad[928];
    float4 View_ViewRectMin;
    float4 View_ViewSizeAndInvSize;
    char _m7_pad[68];
    float View_PreExposure;
    float4 View_DiffuseOverrideParameter;
    float4 View_SpecularOverrideParameter;
    float4 View_NormalOverrideParameter;
    float2 View_RoughnessOverrideParameter;
    char _m12_pad[8];
    float View_OutOfBoundsMask;
    char _m13_pad[48];
    float View_MaterialTextureMipBias;
    char _m14_pad[28];
    float View_UnlitViewmodeMask;
    char _m15_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m16_pad[400];
    packed_float3 View_NormalCurvatureToRoughnessScaleBias;
    float View_RenderingReflectionCaptureMask;
    char _m18_pad[188];
    float View_ShowDecalsMask;
    char _m19_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m20_pad[48];
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

struct type_PrimitiveDither
{
    float PrimitiveDither_LODFactor;
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
    spvUnsafeArray<float4, 4> Material_ScalarExpressions;
};

constant float _170 = {};
constant float4x4 _171 = {};
constant float _173 = {};
constant float4 _174 = {};
constant float3 _175 = {};

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
    float4 in_var_TEXCOORD15 [[user(locn2)]];
    float4 in_var_TEXCOORD0_0 [[user(locn3)]];
    uint in_var_PRIMITIVE_ID [[user(locn4)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00004c4c_74b85cbe(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_PrimitiveDither& PrimitiveDither [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], texture2d<float> Material_Texture2D_3 [[texture(10)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float3x3 _226 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _238 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _173, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _243 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _248 = (_243.xyz / float3(_243.w)) - View.View_PreViewTranslation;
    uint _249 = in.in_var_PRIMITIVE_ID * 36u;
    float4x4 _252 = _171;
    _252[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _249)];
    float4x4 _256 = _252;
    _256[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _249 + 1u)];
    float4x4 _260 = _256;
    _260[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _249 + 2u)];
    float4x4 _264 = _260;
    _264[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _249 + 3u)];
    float3 _267 = (_264 * float4(0.0, 0.0, 0.0, 1.0)).xyz - View.View_WorldCameraOrigin;
    float4 _279 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _282 = (float3(-0.5) + _279.xyz) * 2.0;
    float3 _298 = ((((_267 / float3(sqrt(dot(_267, _267)))) * _226) * (-1.0)) * _282.z) + (float3(_282.xy, 0.0) * ((float3x3(View.View_ViewToTranslatedWorld[0].xyz, View.View_ViewToTranslatedWorld[1].xyz, View.View_ViewToTranslatedWorld[2].xyz) * float3(1.0, 1.0, 0.0)) * _226));
    float3 _310 = normalize(_226 * normalize(((_298 / float3(sqrt(dot(_298, _298)))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _321 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _328 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    if (PrimitiveDither.PrimitiveDither_LODFactor != 0.0)
    {
        if (abs(PrimitiveDither.PrimitiveDither_LODFactor) > 0.001000000047497451305389404296875)
        {
            float _348 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
            if ((float((PrimitiveDither.PrimitiveDither_LODFactor < 0.0) ? ((PrimitiveDither.PrimitiveDither_LODFactor + 1.0) > _348) : (PrimitiveDither.PrimitiveDither_LODFactor < _348)) - 0.001000000047497451305389404296875) < 0.0)
            {
                discard_fragment();
            }
        }
    }
    if (((_321.w * in_var_TEXCOORD0[0].z) - 0.100000001490116119384765625) < 0.0)
    {
        discard_fragment();
    }
    float3 _363 = fast::clamp(_321.xyz, float3(0.0), float3(1.0));
    float _368 = (fast::clamp(_279.w, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float3 _378 = (fast::clamp(float4(_328.xyz, _170).xyz, float3(0.0), float3(1.0)).xyz * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    uint _379 = _249 + 20u;
    float3 _428;
    float _429;
    float _430;
    float _431;
    float3 _432;
    float3 _433;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _379)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _397 = ((_238.xy / float2(_238.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _401 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _397, level(0.0));
        float4 _404 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _397, level(0.0));
        float4 _407 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _397, level(0.0));
        float _409 = _401.w;
        float _417 = _407.w;
        _428 = _378 * _409;
        _429 = (_368 * _417) + _407.z;
        _430 = (0.5 * _417) + _407.y;
        _431 = _407.x;
        _432 = (_363 * _409) + _401.xyz;
        _433 = normalize((_310 * _404.w) + ((_404.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _428 = _378;
        _429 = _368;
        _430 = 0.5;
        _431 = 0.0;
        _432 = _363;
        _433 = _310;
    }
    bool _443 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _449;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _249 + 18u)].w > 0.0) && _443)
    {
        _449 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _449 = 1.0;
    }
    float _496;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _379)].z > 0.0)
    {
        float3 _464 = fast::clamp((_248 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _475 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_464.x), int(_464.y), int(_464.z), 0).xyz), 0));
        _496 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_475.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_464 / float3(_475.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _496 = _449;
    }
    float3 _499 = sqrt(fast::clamp(_428, float3(0.0), float3(1.0)));
    float4 _501 = float4(_499.x, _499.y, _499.z, float4(0.0).w);
    _501.w = 1.0;
    float3 _506 = dfdx(in.in_var_TEXCOORD15.xyz);
    float3 _507 = dfdy(in.in_var_TEXCOORD15.xyz);
    float3 _525 = ((_432 - (_432 * _431)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _532 = (mix(float3(0.07999999821186065673828125 * _430), _432, float3(_431)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _535 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _540;
    if (_535)
    {
        _540 = _525 + (_532 * 0.449999988079071044921875);
    }
    else
    {
        _540 = _525;
    }
    float3 _542 = select(_532, float3(0.0), bool3(_535));
    float3 _544 = float3(dot(_542, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _640;
    float3 _641;
    if (_443)
    {
        float3 _570 = fast::clamp((_248 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _574 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _570);
        float4 _578 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _570);
        float4 _581 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _570);
        float4 _586 = float4(_574.x, _578.x, _581.x, _574.w);
        float4 _591 = float4(_574.y, _578.y, _581.y, _578.w);
        float4 _596 = float4(_574.z, _578.z, _581.zw);
        float4 _599 = _174;
        _599.y = (-0.48860299587249755859375) * _433.y;
        float4 _602 = _599;
        _602.z = 0.48860299587249755859375 * _433.z;
        float4 _605 = _602;
        _605.w = (-0.48860299587249755859375) * _433.x;
        float4 _606 = _605;
        _606.x = 0.886227548122406005859375;
        float3 _608 = _606.yzw * 2.094395160675048828125;
        float4 _609 = float4(_606.x, _608.x, _608.y, _608.z);
        float3 _611 = float3(0.0);
        _611.x = dot(_586, _609);
        float3 _613 = _611;
        _613.y = dot(_591, _609);
        float3 _615 = _613;
        _615.z = dot(_596, _609);
        float3 _618 = -_433;
        float4 _621 = _174;
        _621.y = (-0.48860299587249755859375) * _618.y;
        float4 _624 = _621;
        _624.z = 0.48860299587249755859375 * _618.z;
        float4 _627 = _624;
        _627.w = (-0.48860299587249755859375) * _618.x;
        float4 _628 = _627;
        _628.x = 0.886227548122406005859375;
        float3 _630 = _628.yzw * 2.094395160675048828125;
        float4 _631 = float4(_628.x, _630.x, _630.y, _630.z);
        float3 _633 = _175;
        _633.x = dot(_586, _631);
        float3 _635 = _633;
        _635.y = dot(_591, _631);
        float3 _637 = _635;
        _637.z = dot(_596, _631);
        _640 = fast::max(float3(0.0), _637) * float3(0.3183098733425140380859375);
        _641 = fast::max(float3(0.0), _615) * float3(0.3183098733425140380859375);
    }
    else
    {
        _640 = float3(0.0);
        _641 = float3(0.0);
    }
    float3 _644 = _641 * View.View_IndirectLightingColorScale;
    float3 _669 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _698;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _697;
        if (any(abs(_248 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _249 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _249 + 19u)].xyz + float3(1.0))))
        {
            _697 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_248, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _697 = _669;
        }
        _698 = _697;
    }
    else
    {
        _698 = _669;
    }
    float4 _705 = float4(((mix(float3(0.0), _540 + (_542 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + (((_644 * _540) + ((_640 * View.View_IndirectLightingColorScale) * _428)) * fast::max(float3(1.0), ((((((_432 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_432 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_432 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _698) * 1.0, 0.0);
    float4 _712;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _711 = _705;
        _711.w = 0.0;
        _712 = _711;
    }
    else
    {
        _712 = _705;
    }
    float2 _716 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _724 = (_433 * 0.5) + float3(0.5);
    float4 _726 = float4(_724.x, _724.y, _724.z, float4(0.0).w);
    _726.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _379)].y;
    float4 _727 = float4(0.0);
    _727.x = _431;
    float4 _728 = _727;
    _728.y = _430;
    float4 _729 = _728;
    _729.z = fast::max(_429, fast::clamp((pow(fast::max(dot(_506, _506), dot(_507, _507)), View.View_NormalCurvatureToRoughnessScaleBias[2]) * View.View_NormalCurvatureToRoughnessScaleBias[0]) + View.View_NormalCurvatureToRoughnessScaleBias[1], 0.0, 1.0));
    float4 _730 = _729;
    _730.w = 0.525490224361419677734375;
    float4 _742 = float4(_432.x, _432.y, _432.z, float4(0.0).w);
    _742.w = ((log2(((dot(_644, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_544 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_544 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_544 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_716.xyx * _716.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _712 * View.View_PreExposure;
    out.out_var_SV_Target1 = _726;
    out.out_var_SV_Target2 = _730;
    out.out_var_SV_Target3 = _742;
    out.out_var_SV_Target4 = _501;
    out.out_var_SV_Target5 = float4(_496, 1.0, 1.0, 1.0);
    return out;
}

