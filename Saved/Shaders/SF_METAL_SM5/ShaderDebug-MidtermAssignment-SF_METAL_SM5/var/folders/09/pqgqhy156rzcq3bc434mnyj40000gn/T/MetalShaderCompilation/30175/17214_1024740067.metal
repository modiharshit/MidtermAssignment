

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
    char _m15_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m17_pad[124];
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
    float4 IndirectLightingCache_PointSkyBentNormal;
    float IndirectLightingCache_DirectionalLightShadowing;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float3 _149 = {};
constant float _151 = {};
constant float4 _152 = {};

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

fragment MainPS_out Main_0000433e_3d144ae3(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float2 _200 = (gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw;
    float4 _206 = float4((_200 - float2(0.5)) * float2(2.0, -2.0), _151, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _211 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _216 = (_211.xyz / float3(_211.w)) - View.View_PreViewTranslation;
    float3 _224 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _231 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (_200 * 4.0), bias(View.View_MaterialTextureMipBias));
    float3 _232 = _231.xyz;
    float3 _240 = fast::clamp(_232, float3(0.0), float3(1.0));
    float _244 = (0.5 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _245 = in.in_var_PRIMITIVE_ID * 36u;
    uint _246 = _245 + 20u;
    float _294;
    float _295;
    float _296;
    float3 _297;
    float3 _298;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _246)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _264 = ((_206.xy / float2(_206.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _268 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _264, level(0.0));
        float4 _271 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _264, level(0.0));
        float4 _274 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _264, level(0.0));
        float _284 = _274.w;
        _294 = (_244 * _284) + _274.z;
        _295 = (0.5 * _284) + _274.y;
        _296 = _274.x;
        _297 = (_240 * _268.w) + _268.xyz;
        _298 = normalize((_224 * _271.w) + ((_271.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _294 = _244;
        _295 = 0.5;
        _296 = 0.0;
        _297 = _240;
        _298 = _224;
    }
    bool _308 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _314;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _245 + 18u)].w > 0.0) && _308)
    {
        _314 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _314 = 1.0;
    }
    float _361;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _246)].z > 0.0)
    {
        float3 _329 = fast::clamp((_216 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _340 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_329.x), int(_329.y), int(_329.z), 0).xyz), 0));
        _361 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_340.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_329 / float3(_340.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _361 = _314;
    }
    float3 _375 = ((_297 - (_297 * _296)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _382 = (mix(float3(0.07999999821186065673828125 * _295), _297, float3(_296)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _385 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _390;
    if (_385)
    {
        _390 = _375 + (_382 * 0.449999988079071044921875);
    }
    else
    {
        _390 = _375;
    }
    float3 _392 = select(_382, float3(0.0), bool3(_385));
    float3 _394 = float3(dot(_392, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _468;
    if (_308)
    {
        float3 _420 = fast::clamp((_216 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _424 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _420);
        float4 _428 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _420);
        float4 _431 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _420);
        float4 _449 = _152;
        _449.y = (-0.48860299587249755859375) * _298.y;
        float4 _452 = _449;
        _452.z = 0.48860299587249755859375 * _298.z;
        float4 _455 = _452;
        _455.w = (-0.48860299587249755859375) * _298.x;
        float4 _456 = _455;
        _456.x = 0.886227548122406005859375;
        float3 _458 = _456.yzw * 2.094395160675048828125;
        float4 _459 = float4(_456.x, _458.x, _458.y, _458.z);
        float3 _461 = float3(0.0);
        _461.x = dot(float4(_424.x, _428.x, _431.x, _424.w), _459);
        float3 _463 = _461;
        _463.y = dot(float4(_424.y, _428.y, _431.y, _428.w), _459);
        float3 _465 = _463;
        _465.z = dot(float4(_424.z, _428.z, _431.zw), _459);
        _468 = fast::max(float3(0.0), _465) * float3(0.3183098733425140380859375);
    }
    else
    {
        _468 = float3(0.0);
    }
    float _494;
    float _495;
    float3 _496;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _484;
        float _485;
        if (_308)
        {
            _484 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _485 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _484 = _298;
            _485 = 1.0;
        }
        float _486 = 1.0 - _485;
        float _488 = 1.0 - (_486 * _486);
        _494 = mix(fast::clamp(dot(_484, _298), 0.0, 1.0), 1.0, _488);
        _495 = _485;
        _496 = mix(_484, _298, float3(_488));
    }
    else
    {
        _494 = 1.0;
        _495 = 1.0;
        _496 = _298;
    }
    float4 _500 = float4(_496, 1.0);
    float3 _504 = _149;
    _504.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _500);
    float3 _508 = _504;
    _508.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _500);
    float3 _512 = _508;
    _512.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _500);
    float4 _515 = _500.xyzz * _500.yzzx;
    float3 _519 = _149;
    _519.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _515);
    float3 _523 = _519;
    _523.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _515);
    float3 _527 = _523;
    _527.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _515);
    float3 _542 = (_468 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_512 + _527) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_496.x * _496.x) - (_496.y * _496.y)))) * View.View_SkyLightColor.xyz) * (_495 * _494));
    float3 _564 = fast::max(mix(_232, Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _593;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _592;
        if (any(abs(_216 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _245 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _245 + 19u)].xyz + float3(1.0))))
        {
            _592 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_216, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _592 = _564;
        }
        _593 = _592;
    }
    else
    {
        _593 = _564;
    }
    float4 _600 = float4(((mix(float3(0.0), _390 + (_392 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_542 * _390) * fast::max(float3(1.0), ((((((_297 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_297 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_297 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _593) * 1.0, 0.0);
    float4 _607;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _606 = _600;
        _606.w = 0.0;
        _607 = _606;
    }
    else
    {
        _607 = _600;
    }
    float2 _611 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _619 = (_298 * 0.5) + float3(0.5);
    float4 _621 = float4(_619.x, _619.y, _619.z, float4(0.0).w);
    _621.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _246)].y;
    float4 _622 = float4(0.0);
    _622.x = _296;
    float4 _623 = _622;
    _623.y = _295;
    float4 _624 = _623;
    _624.z = _294;
    float4 _625 = _624;
    _625.w = 0.50588238239288330078125;
    float4 _637 = float4(_297.x, _297.y, _297.z, float4(0.0).w);
    _637.w = ((log2(((dot(_542, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_394 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_394 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_394 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_611.xyx * _611.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _607 * View.View_PreExposure;
    out.out_var_SV_Target1 = _621;
    out.out_var_SV_Target2 = _625;
    out.out_var_SV_Target3 = _637;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_361, 1.0, 1.0, 1.0);
    return out;
}

