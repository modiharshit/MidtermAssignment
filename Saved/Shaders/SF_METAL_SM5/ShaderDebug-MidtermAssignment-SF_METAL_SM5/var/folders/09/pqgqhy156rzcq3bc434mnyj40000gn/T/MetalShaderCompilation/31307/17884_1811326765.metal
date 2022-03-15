

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
    char _m13_pad[48];
    float View_MaterialTextureMipBias;
    char _m14_pad[28];
    float View_UnlitViewmodeMask;
    char _m15_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m16_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m17_pad[188];
    float View_ShowDecalsMask;
    char _m18_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m19_pad[48];
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

constant float4 _171 = {};

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

fragment MainPS_out Main_000045dc_6bf6a72d(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], texture2d<float> Material_Texture2D_2 [[texture(10)]], texture2d<float> Material_Texture2D_3 [[texture(11)]], texture2d<float> Material_Texture2D_4 [[texture(12)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], sampler Material_Texture2D_2Sampler [[sampler(5)]], sampler Material_Texture2D_3Sampler [[sampler(6)]], sampler Material_Texture2D_4Sampler [[sampler(7)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _228 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _232 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _237 = (_232.xyz / float3(_232.w)) - View.View_PreViewTranslation;
    float2 _238 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5;
    float4 _244 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _238, bias(View.View_MaterialTextureMipBias));
    float2 _247 = (_244.xy * float2(2.0)) - float2(1.0);
    float3 _263 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_247, sqrt(fast::clamp(1.0 - dot(_247, _247), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _275 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (_238 * float2(0.25)), bias(View.View_MaterialTextureMipBias));
    float2 _278 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 2.0;
    float4 _283 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (_278 * 0.2134999930858612060546875), bias(View.View_MaterialTextureMipBias));
    float4 _288 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (_278 * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float _315;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _315 = _228.w;
                break;
            }
            else
            {
                float _299 = _228.z;
                _315 = ((_299 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_299 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float4 _323 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _326 = mix(_283.x + 0.5, _288.x + 0.5, fast::min(fast::max((_315 - 24.0) * 0.0009765625, 0.0), 1.0)) * (_323.x + 0.5);
    float4 _331 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _238, bias(View.View_MaterialTextureMipBias));
    float4 _344 = Material_Texture2D_4.sample(Material_Texture2D_4Sampler, _238, bias(View.View_MaterialTextureMipBias));
    float3 _350 = fast::clamp(fast::min(fast::max(((_331.xyz * mix(0.60000002384185791015625, 1.0, _326)) * mix(0.1500000059604644775390625, 0.699999988079071044921875, _275.x)) * Material.Material_VectorExpressions[3].xyz, float3(0.0)), float3(1.0)), float3(0.0), float3(1.0));
    float _351 = fast::clamp(_344.y, 0.0, 1.0);
    float _356 = (fast::clamp(mix(-0.300000011920928955078125, 1.0, _344.x + (_326 * 0.20000000298023223876953125)), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _357 = in.in_var_PRIMITIVE_ID * 36u;
    uint _358 = _357 + 20u;
    float _406;
    float _407;
    float _408;
    float3 _409;
    float3 _410;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _358)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _376 = ((_228.xy / float2(_228.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _380 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _376, level(0.0));
        float4 _383 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _376, level(0.0));
        float4 _386 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _376, level(0.0));
        float _396 = _386.w;
        _406 = (_356 * _396) + _386.z;
        _407 = (0.5 * _396) + _386.y;
        _408 = _386.x;
        _409 = (_350 * _380.w) + _380.xyz;
        _410 = normalize((_263 * _383.w) + ((_383.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _406 = _356;
        _407 = 0.5;
        _408 = 0.0;
        _409 = _350;
        _410 = _263;
    }
    bool _420 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _426;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _357 + 18u)].w > 0.0) && _420)
    {
        _426 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _426 = 1.0;
    }
    float _473;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _358)].z > 0.0)
    {
        float3 _441 = fast::clamp((_237 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _452 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_441.x), int(_441.y), int(_441.z), 0).xyz), 0));
        _473 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_452.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_441 / float3(_452.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _473 = _426;
    }
    float3 _487 = ((_409 - (_409 * _408)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _494 = (mix(float3(0.07999999821186065673828125 * _407), _409, float3(_408)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _497 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _502;
    if (_497)
    {
        _502 = _487 + (_494 * 0.449999988079071044921875);
    }
    else
    {
        _502 = _487;
    }
    float3 _504 = select(_494, float3(0.0), bool3(_497));
    float3 _506 = float3(dot(_504, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _513 = float3(_351);
    float3 _581;
    if (_420)
    {
        float3 _533 = fast::clamp((_237 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _537 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _533);
        float4 _541 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _533);
        float4 _544 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _533);
        float4 _562 = _171;
        _562.y = (-0.48860299587249755859375) * _410.y;
        float4 _565 = _562;
        _565.z = 0.48860299587249755859375 * _410.z;
        float4 _568 = _565;
        _568.w = (-0.48860299587249755859375) * _410.x;
        float4 _569 = _568;
        _569.x = 0.886227548122406005859375;
        float3 _571 = _569.yzw * 2.094395160675048828125;
        float4 _572 = float4(_569.x, _571.x, _571.y, _571.z);
        float3 _574 = float3(0.0);
        _574.x = dot(float4(_537.x, _541.x, _544.x, _537.w), _572);
        float3 _576 = _574;
        _576.y = dot(float4(_537.y, _541.y, _544.y, _541.w), _572);
        float3 _578 = _576;
        _578.z = dot(float4(_537.z, _541.z, _544.zw), _572);
        _581 = fast::max(float3(0.0), _578) * float3(0.3183098733425140380859375);
    }
    else
    {
        _581 = float3(0.0);
    }
    float3 _584 = _581 * View.View_IndirectLightingColorScale;
    float3 _606 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _635;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _634;
        if (any(abs(_237 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _357 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _357 + 19u)].xyz + float3(1.0))))
        {
            _634 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_237, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _634 = _606;
        }
        _635 = _634;
    }
    else
    {
        _635 = _606;
    }
    float4 _642 = float4(((mix(float3(0.0), _502 + (_504 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_584 * _502) * fast::max(_513, ((((((_409 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _351) + ((_409 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _351) + ((_409 * 2.755199909210205078125) + float3(0.69029998779296875))) * _351))) + _635) * 1.0, 0.0);
    float4 _649;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _648 = _642;
        _648.w = 0.0;
        _649 = _648;
    }
    else
    {
        _649 = _642;
    }
    float2 _653 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _661 = (_410 * 0.5) + float3(0.5);
    float4 _663 = float4(_661.x, _661.y, _661.z, float4(0.0).w);
    _663.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _358)].y;
    float4 _664 = float4(0.0);
    _664.x = _408;
    float4 _665 = _664;
    _665.y = _407;
    float4 _666 = _665;
    _666.z = _406;
    float4 _667 = _666;
    _667.w = 0.50588238239288330078125;
    float4 _679 = float4(_409.x, _409.y, _409.z, float4(0.0).w);
    _679.w = ((log2(((dot(_584, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_513, ((((((_506 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _351) + ((_506 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _351) + ((_506 * 2.755199909210205078125) + float3(0.69029998779296875))) * _351).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_653.xyx * _653.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _649 * View.View_PreExposure;
    out.out_var_SV_Target1 = _663;
    out.out_var_SV_Target2 = _667;
    out.out_var_SV_Target3 = _679;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_473, 1.0, 1.0, 1.0);
    return out;
}

