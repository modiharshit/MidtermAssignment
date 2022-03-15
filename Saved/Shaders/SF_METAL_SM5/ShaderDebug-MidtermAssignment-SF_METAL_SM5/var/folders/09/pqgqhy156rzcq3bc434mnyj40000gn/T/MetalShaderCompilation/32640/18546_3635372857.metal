

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
    char _m0_pad[448];
    float4x4 View_ViewToClip;
    char _m1_pad[192];
    float4x4 View_SVPositionToTranslatedWorld;
    char _m2_pad[272];
    float4 View_InvDeviceZToWorldZTransform;
    float4 View_ScreenPositionScaleBias;
    char _m4_pad[48];
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
    char _m13_pad[36];
    float View_GameTime;
    char _m14_pad[8];
    float View_MaterialTextureMipBias;
    char _m15_pad[28];
    float View_UnlitViewmodeMask;
    char _m16_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m17_pad[412];
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
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _180 = {};

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

fragment MainPS_out Main_00004872_d8af6339(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], texture2d<float> Material_Texture2D_2 [[texture(10)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], sampler Material_Texture2D_2Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _237 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _241 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _246 = (_241.xyz / float3(_241.w)) - View.View_PreViewTranslation;
    float2 _253 = float2(View.View_GameTime * (-0.02999999932944774627685546875), View.View_GameTime * (-0.0199999995529651641845703125)) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(0.0500000007450580596923828125, 0.07999999821186065673828125));
    float4 _259 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _253, bias(View.View_MaterialTextureMipBias));
    float2 _262 = (_259.xy * float2(2.0)) - float2(1.0);
    float _269 = sqrt(fast::clamp(1.0 - dot(_262, _262), 0.0, 1.0)) + 1.0;
    float _277 = sin(((_246.x * 0.006666666828095912933349609375) + (View.View_GameTime * Material.Material_ScalarExpressions[0].x)) * 1.256637096405029296875);
    float4 _284 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(_277 * (-0.0599999986588954925537109375), _277 * (-0.039999999105930328369140625)) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(0.180000007152557373046875, 0.1500000059604644775390625))), bias(View.View_MaterialTextureMipBias));
    float2 _287 = (_284.xy * float2(2.0)) - float2(1.0);
    float3 _296 = float4(_287, sqrt(fast::clamp(1.0 - dot(_287, _287), 0.0, 1.0)), 1.0).xyz * float3(-1.0, -1.0, 1.0);
    float3 _299 = float3(_262, _269);
    float3 _303 = float3(_296.xy * (-1.0), _296.z);
    float3 _307 = (_299 * dot(_299, _303)) - (_303 * _269);
    float _309 = _307.z + 1.0;
    float2 _313 = float2(View.View_GameTime * (-0.070000000298023223876953125)) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.75);
    float4 _315 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _313, bias(View.View_MaterialTextureMipBias));
    float2 _318 = (_315.xy * float2(2.0)) - float2(1.0);
    float4 _330 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _357;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _357 = _237.w;
                break;
            }
            else
            {
                float _341 = _237.z;
                _357 = ((_341 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_341 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _364 = float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _330.x) + _357) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0));
    float3 _365 = mix(float4(_318, sqrt(fast::clamp(1.0 - dot(_318, _318), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), _364);
    float3 _370 = float3(_307.xy, _309);
    float3 _374 = float3(_365.xy * (-1.0), _365.z);
    float3 _386 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((((_370 * dot(_370, _374)) - (_374 * _309)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _397 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _313, bias(View.View_MaterialTextureMipBias));
    float4 _399 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _253, bias(View.View_MaterialTextureMipBias));
    float3 _414 = fast::clamp(mix(mix(Material.Material_VectorExpressions[4].xyz, Material.Material_VectorExpressions[5].xyz, float3(fast::min(fast::max(_397.x * _399.x, 0.0), 1.0))), Material.Material_VectorExpressions[4].xyz, _364), float3(0.0), float3(1.0));
    float _418 = (0.100000001490116119384765625 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _419 = in.in_var_PRIMITIVE_ID * 36u;
    uint _420 = _419 + 20u;
    float _468;
    float _469;
    float _470;
    float3 _471;
    float3 _472;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _420)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _438 = ((_237.xy / float2(_237.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _442 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _438, level(0.0));
        float4 _445 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _438, level(0.0));
        float4 _448 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _438, level(0.0));
        float _458 = _448.w;
        _468 = (_418 * _458) + _448.z;
        _469 = (0.5 * _458) + _448.y;
        _470 = _448.x;
        _471 = (_414 * _442.w) + _442.xyz;
        _472 = normalize((_386 * _445.w) + ((_445.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _468 = _418;
        _469 = 0.5;
        _470 = 0.0;
        _471 = _414;
        _472 = _386;
    }
    bool _482 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _488;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _419 + 18u)].w > 0.0) && _482)
    {
        _488 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _488 = 1.0;
    }
    float _535;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _420)].z > 0.0)
    {
        float3 _503 = fast::clamp((_246 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _514 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_503.x), int(_503.y), int(_503.z), 0).xyz), 0));
        _535 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_514.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_503 / float3(_514.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _535 = _488;
    }
    float3 _549 = ((_471 - (_471 * _470)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _556 = (mix(float3(0.07999999821186065673828125 * _469), _471, float3(_470)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _559 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _564;
    if (_559)
    {
        _564 = _549 + (_556 * 0.449999988079071044921875);
    }
    else
    {
        _564 = _549;
    }
    float3 _566 = select(_556, float3(0.0), bool3(_559));
    float3 _568 = float3(dot(_566, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _642;
    if (_482)
    {
        float3 _594 = fast::clamp((_246 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _598 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _594);
        float4 _602 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _594);
        float4 _605 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _594);
        float4 _623 = _180;
        _623.y = (-0.48860299587249755859375) * _472.y;
        float4 _626 = _623;
        _626.z = 0.48860299587249755859375 * _472.z;
        float4 _629 = _626;
        _629.w = (-0.48860299587249755859375) * _472.x;
        float4 _630 = _629;
        _630.x = 0.886227548122406005859375;
        float3 _632 = _630.yzw * 2.094395160675048828125;
        float4 _633 = float4(_630.x, _632.x, _632.y, _632.z);
        float3 _635 = float3(0.0);
        _635.x = dot(float4(_598.x, _602.x, _605.x, _598.w), _633);
        float3 _637 = _635;
        _637.y = dot(float4(_598.y, _602.y, _605.y, _602.w), _633);
        float3 _639 = _637;
        _639.z = dot(float4(_598.z, _602.z, _605.zw), _633);
        _642 = fast::max(float3(0.0), _639) * float3(0.3183098733425140380859375);
    }
    else
    {
        _642 = float3(0.0);
    }
    float3 _645 = _642 * View.View_IndirectLightingColorScale;
    float3 _667 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].y)), float3(0.0));
    float3 _696;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _695;
        if (any(abs(_246 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _419 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _419 + 19u)].xyz + float3(1.0))))
        {
            _695 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_246, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _695 = _667;
        }
        _696 = _695;
    }
    else
    {
        _696 = _667;
    }
    float4 _703 = float4(((mix(float3(0.0), _564 + (_566 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_645 * _564) * fast::max(float3(1.0), ((((((_471 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_471 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_471 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _696) * 1.0, 0.0);
    float4 _710;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _709 = _703;
        _709.w = 0.0;
        _710 = _709;
    }
    else
    {
        _710 = _703;
    }
    float2 _714 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _722 = (_472 * 0.5) + float3(0.5);
    float4 _724 = float4(_722.x, _722.y, _722.z, float4(0.0).w);
    _724.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _420)].y;
    float4 _725 = float4(0.0);
    _725.x = _470;
    float4 _726 = _725;
    _726.y = _469;
    float4 _727 = _726;
    _727.z = _468;
    float4 _728 = _727;
    _728.w = 0.50588238239288330078125;
    float4 _740 = float4(_471.x, _471.y, _471.z, float4(0.0).w);
    _740.w = ((log2(((dot(_645, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_568 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_568 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_568 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_714.xyx * _714.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _710 * View.View_PreExposure;
    out.out_var_SV_Target1 = _724;
    out.out_var_SV_Target2 = _728;
    out.out_var_SV_Target3 = _740;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_535, 1.0, 1.0, 1.0);
    return out;
}

