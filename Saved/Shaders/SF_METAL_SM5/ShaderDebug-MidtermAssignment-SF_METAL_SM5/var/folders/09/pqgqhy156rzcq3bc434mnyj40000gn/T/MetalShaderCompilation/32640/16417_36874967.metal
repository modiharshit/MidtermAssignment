

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

constant float _158 = {};
constant float4 _159 = {};

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

fragment MainPS_out Main_00004021_0232aad7(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], texture2d<float> Material_Texture2D_2 [[texture(10)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], sampler Material_Texture2D_2Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _214 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _158, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _219 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _224 = (_219.xyz / float3(_219.w)) - View.View_PreViewTranslation;
    float4 _230 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _233 = (_230.xy * float2(2.0)) - float2(1.0);
    float3 _249 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_233, sqrt(fast::clamp(1.0 - dot(_233, _233), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _261 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _266 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _271 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _275 = (_261.x + 0.5) * ((_266.x + 0.5) * (_271.x + 0.5));
    float4 _281 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _287 = fast::clamp(mix(float3(0.5), float3(1.0), float3(_275)) * _281.xyz, float3(0.0), float3(1.0));
    float _292 = (fast::clamp(mix(0.300000011920928955078125, 0.100000001490116119384765625, _275 * _281.w), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _293 = in.in_var_PRIMITIVE_ID * 36u;
    uint _294 = _293 + 20u;
    float _343;
    float _344;
    float _345;
    float3 _346;
    float3 _347;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _294)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _312 = ((_214.xy / float2(_214.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _316 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _312, level(0.0));
        float4 _319 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _312, level(0.0));
        float4 _322 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _312, level(0.0));
        float _332 = _322.w;
        _343 = (_292 * _332) + _322.z;
        _344 = (0.5 * _332) + _322.y;
        _345 = _332 + _322.x;
        _346 = (_287 * _316.w) + _316.xyz;
        _347 = normalize((_249 * _319.w) + ((_319.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _343 = _292;
        _344 = 0.5;
        _345 = 1.0;
        _346 = _287;
        _347 = _249;
    }
    bool _357 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _363;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _293 + 18u)].w > 0.0) && _357)
    {
        _363 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _363 = 1.0;
    }
    float _410;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _294)].z > 0.0)
    {
        float3 _378 = fast::clamp((_224 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _389 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_378.x), int(_378.y), int(_378.z), 0).xyz), 0));
        _410 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_389.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_378 / float3(_389.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _410 = _363;
    }
    float3 _424 = ((_346 - (_346 * _345)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _431 = (mix(float3(0.07999999821186065673828125 * _344), _346, float3(_345)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _434 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _439;
    if (_434)
    {
        _439 = _424 + (_431 * 0.449999988079071044921875);
    }
    else
    {
        _439 = _424;
    }
    float3 _441 = select(_431, float3(0.0), bool3(_434));
    float3 _443 = float3(dot(_441, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _517;
    if (_357)
    {
        float3 _469 = fast::clamp((_224 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _473 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _469);
        float4 _477 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _469);
        float4 _480 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _469);
        float4 _498 = _159;
        _498.y = (-0.48860299587249755859375) * _347.y;
        float4 _501 = _498;
        _501.z = 0.48860299587249755859375 * _347.z;
        float4 _504 = _501;
        _504.w = (-0.48860299587249755859375) * _347.x;
        float4 _505 = _504;
        _505.x = 0.886227548122406005859375;
        float3 _507 = _505.yzw * 2.094395160675048828125;
        float4 _508 = float4(_505.x, _507.x, _507.y, _507.z);
        float3 _510 = float3(0.0);
        _510.x = dot(float4(_473.x, _477.x, _480.x, _473.w), _508);
        float3 _512 = _510;
        _512.y = dot(float4(_473.y, _477.y, _480.y, _477.w), _508);
        float3 _514 = _512;
        _514.z = dot(float4(_473.z, _477.z, _480.zw), _508);
        _517 = fast::max(float3(0.0), _514) * float3(0.3183098733425140380859375);
    }
    else
    {
        _517 = float3(0.0);
    }
    float3 _520 = _517 * View.View_IndirectLightingColorScale;
    float3 _542 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _571;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _570;
        if (any(abs(_224 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _293 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _293 + 19u)].xyz + float3(1.0))))
        {
            _570 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_224, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _570 = _542;
        }
        _571 = _570;
    }
    else
    {
        _571 = _542;
    }
    float4 _578 = float4(((mix(float3(0.0), _439 + (_441 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_520 * _439) * fast::max(float3(1.0), ((((((_346 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_346 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_346 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _571) * 1.0, 0.0);
    float4 _585;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _584 = _578;
        _584.w = 0.0;
        _585 = _584;
    }
    else
    {
        _585 = _578;
    }
    float2 _589 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _597 = (_347 * 0.5) + float3(0.5);
    float4 _599 = float4(_597.x, _597.y, _597.z, float4(0.0).w);
    _599.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _294)].y;
    float4 _600 = float4(0.0);
    _600.x = _345;
    float4 _601 = _600;
    _601.y = _344;
    float4 _602 = _601;
    _602.z = _343;
    float4 _603 = _602;
    _603.w = 0.50588238239288330078125;
    float4 _615 = float4(_346.x, _346.y, _346.z, float4(0.0).w);
    _615.w = ((log2(((dot(_520, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_443 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_443 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_443 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_589.xyx * _589.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _585 * View.View_PreExposure;
    out.out_var_SV_Target1 = _599;
    out.out_var_SV_Target2 = _603;
    out.out_var_SV_Target3 = _615;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_410, 1.0, 1.0, 1.0);
    return out;
}

