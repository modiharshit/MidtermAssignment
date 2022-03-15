

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

constant float _167 = {};
constant float4 _168 = {};

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

fragment MainPS_out Main_00004414_58bac823(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], texture2d<float> Material_Texture2D_2 [[texture(10)]], texture2d<float> Material_Texture2D_3 [[texture(11)]], texture2d<float> Material_Texture2D_4 [[texture(12)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], sampler Material_Texture2D_2Sampler [[sampler(5)]], sampler Material_Texture2D_3Sampler [[sampler(6)]], sampler Material_Texture2D_4Sampler [[sampler(7)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float3x3 _212 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _223 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _167, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _228 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _232 = _228.xyz / float3(_228.w);
    float3 _233 = _232 - View.View_PreViewTranslation;
    float2 _237 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5;
    float4 _243 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _237, bias(View.View_MaterialTextureMipBias));
    float2 _249 = ((normalize(-_232) * _212).xy * ((0.004999999888241291046142578125 * _243.w) + (-0.00449999980628490447998046875))) + _237;
    float4 _253 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _249, bias(View.View_MaterialTextureMipBias));
    float2 _256 = (_253.xy * float2(2.0)) - float2(1.0);
    float4 _269 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.100000001490116119384765625), bias(2.0 + View.View_MaterialTextureMipBias));
    float2 _272 = (_269.xy * float2(2.0)) - float2(1.0);
    float3 _291 = normalize(_212 * normalize(((float4(_256, sqrt(fast::clamp(1.0 - dot(_256, _256), 0.0, 1.0)), 1.0).xyz + (float4(_272, sqrt(fast::clamp(1.0 - dot(_272, _272), 0.0, 1.0)), 1.0).xyz * float3(0.20000000298023223876953125, 0.20000000298023223876953125, 0.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _303 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _308 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _311 = (_303.x + 0.5) * (_308.x + 0.5);
    float4 _314 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _249, bias(View.View_MaterialTextureMipBias));
    float4 _320 = Material_Texture2D_4.sample(Material_Texture2D_4Sampler, _249, bias(View.View_MaterialTextureMipBias));
    float3 _326 = fast::clamp(_314.xyz * mix(0.5, 1.0, _311), float3(0.0), float3(1.0));
    float _327 = fast::clamp(_320.y, 0.0, 1.0);
    float _332 = (fast::clamp(mix(-0.300000011920928955078125, 0.800000011920928955078125, _320.x + (_311 * 0.20000000298023223876953125)), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _333 = in.in_var_PRIMITIVE_ID * 36u;
    uint _334 = _333 + 20u;
    float _382;
    float _383;
    float _384;
    float3 _385;
    float3 _386;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _334)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _352 = ((_223.xy / float2(_223.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _356 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _352, level(0.0));
        float4 _359 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _352, level(0.0));
        float4 _362 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _352, level(0.0));
        float _372 = _362.w;
        _382 = (_332 * _372) + _362.z;
        _383 = (0.5 * _372) + _362.y;
        _384 = _362.x;
        _385 = (_326 * _356.w) + _356.xyz;
        _386 = normalize((_291 * _359.w) + ((_359.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _382 = _332;
        _383 = 0.5;
        _384 = 0.0;
        _385 = _326;
        _386 = _291;
    }
    bool _396 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _402;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _333 + 18u)].w > 0.0) && _396)
    {
        _402 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _402 = 1.0;
    }
    float _449;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _334)].z > 0.0)
    {
        float3 _417 = fast::clamp((_233 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _428 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_417.x), int(_417.y), int(_417.z), 0).xyz), 0));
        _449 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_428.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_417 / float3(_428.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _449 = _402;
    }
    float3 _463 = ((_385 - (_385 * _384)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _470 = (mix(float3(0.07999999821186065673828125 * _383), _385, float3(_384)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _473 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _478;
    if (_473)
    {
        _478 = _463 + (_470 * 0.449999988079071044921875);
    }
    else
    {
        _478 = _463;
    }
    float3 _480 = select(_470, float3(0.0), bool3(_473));
    float3 _482 = float3(dot(_480, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _489 = float3(_327);
    float3 _557;
    if (_396)
    {
        float3 _509 = fast::clamp((_233 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _513 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _509);
        float4 _517 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _509);
        float4 _520 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _509);
        float4 _538 = _168;
        _538.y = (-0.48860299587249755859375) * _386.y;
        float4 _541 = _538;
        _541.z = 0.48860299587249755859375 * _386.z;
        float4 _544 = _541;
        _544.w = (-0.48860299587249755859375) * _386.x;
        float4 _545 = _544;
        _545.x = 0.886227548122406005859375;
        float3 _547 = _545.yzw * 2.094395160675048828125;
        float4 _548 = float4(_545.x, _547.x, _547.y, _547.z);
        float3 _550 = float3(0.0);
        _550.x = dot(float4(_513.x, _517.x, _520.x, _513.w), _548);
        float3 _552 = _550;
        _552.y = dot(float4(_513.y, _517.y, _520.y, _517.w), _548);
        float3 _554 = _552;
        _554.z = dot(float4(_513.z, _517.z, _520.zw), _548);
        _557 = fast::max(float3(0.0), _554) * float3(0.3183098733425140380859375);
    }
    else
    {
        _557 = float3(0.0);
    }
    float3 _560 = _557 * View.View_IndirectLightingColorScale;
    float3 _582 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _611;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _610;
        if (any(abs(_233 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _333 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _333 + 19u)].xyz + float3(1.0))))
        {
            _610 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_233, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _610 = _582;
        }
        _611 = _610;
    }
    else
    {
        _611 = _582;
    }
    float4 _618 = float4(((mix(float3(0.0), _478 + (_480 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_560 * _478) * fast::max(_489, ((((((_385 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _327) + ((_385 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _327) + ((_385 * 2.755199909210205078125) + float3(0.69029998779296875))) * _327))) + _611) * 1.0, 0.0);
    float4 _625;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _624 = _618;
        _624.w = 0.0;
        _625 = _624;
    }
    else
    {
        _625 = _618;
    }
    float2 _629 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _637 = (_386 * 0.5) + float3(0.5);
    float4 _639 = float4(_637.x, _637.y, _637.z, float4(0.0).w);
    _639.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _334)].y;
    float4 _640 = float4(0.0);
    _640.x = _384;
    float4 _641 = _640;
    _641.y = _383;
    float4 _642 = _641;
    _642.z = _382;
    float4 _643 = _642;
    _643.w = 0.50588238239288330078125;
    float4 _655 = float4(_385.x, _385.y, _385.z, float4(0.0).w);
    _655.w = ((log2(((dot(_560, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_489, ((((((_482 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _327) + ((_482 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _327) + ((_482 * 2.755199909210205078125) + float3(0.69029998779296875))) * _327).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_629.xyx * _629.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _625 * View.View_PreExposure;
    out.out_var_SV_Target1 = _639;
    out.out_var_SV_Target2 = _643;
    out.out_var_SV_Target3 = _655;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_449, 1.0, 1.0, 1.0);
    return out;
}

