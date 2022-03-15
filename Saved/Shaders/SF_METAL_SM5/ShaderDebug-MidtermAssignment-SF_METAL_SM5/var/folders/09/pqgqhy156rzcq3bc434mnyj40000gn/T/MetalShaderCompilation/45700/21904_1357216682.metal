

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
    char _m16_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m18_pad[124];
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
    float4 IndirectLightingCache_PointSkyBentNormal;
    float IndirectLightingCache_DirectionalLightShadowing;
};

struct type_Material
{
    spvUnsafeArray<float4, 7> Material_VectorExpressions;
    spvUnsafeArray<float4, 6> Material_ScalarExpressions;
};

constant float _170 = {};
constant float3 _171 = {};
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
    float4 in_var_COLOR0 [[user(locn2)]];
    float4 in_var_TEXCOORD0_0 [[user(locn3)]];
    uint in_var_PRIMITIVE_ID [[user(locn4)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00005590_50e57baa(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(6)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_PrimitiveDither& PrimitiveDither [[buffer(3)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(4)]], constant type_Material& Material [[buffer(5)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], texture2d<float> Material_Texture2D_3 [[texture(10)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]], bool gl_FrontFacing [[front_facing]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _237 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _173, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _242 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _247 = (_242.xyz / float3(_242.w)) - View.View_PreViewTranslation;
    uint _248 = in.in_var_PRIMITIVE_ID * 36u;
    float4 _262 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _273 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((((float3(-0.5) + _262.xyz) * 2.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * ((View.View_CullingSign * View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _248 + 4u)].w) * float(gl_FrontFacing ? 1 : (-1)));
    float4 _284 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _291 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    if (PrimitiveDither.PrimitiveDither_LODFactor != 0.0)
    {
        if (abs(PrimitiveDither.PrimitiveDither_LODFactor) > 0.001000000047497451305389404296875)
        {
            float _311 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
            if ((float((PrimitiveDither.PrimitiveDither_LODFactor < 0.0) ? ((PrimitiveDither.PrimitiveDither_LODFactor + 1.0) > _311) : (PrimitiveDither.PrimitiveDither_LODFactor < _311)) - 0.001000000047497451305389404296875) < 0.0)
            {
                discard_fragment();
            }
        }
    }
    if (((in.in_var_COLOR0.w * _284.w) - 0.100000001490116119384765625) < 0.0)
    {
        discard_fragment();
    }
    float3 _326 = fast::clamp(_284.xyz, float3(0.0), float3(1.0));
    float _331 = (fast::clamp(_262.w, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float3 _341 = (fast::clamp(float4(_291.xyz, _170).xyz, float3(0.0), float3(1.0)).xyz * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    uint _342 = _248 + 20u;
    float3 _391;
    float _392;
    float _393;
    float _394;
    float3 _395;
    float3 _396;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _342)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _360 = ((_237.xy / float2(_237.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _364 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _360, level(0.0));
        float4 _367 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _360, level(0.0));
        float4 _370 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _360, level(0.0));
        float _372 = _364.w;
        float _380 = _370.w;
        _391 = _341 * _372;
        _392 = (_331 * _380) + _370.z;
        _393 = (0.5 * _380) + _370.y;
        _394 = _370.x;
        _395 = (_326 * _372) + _364.xyz;
        _396 = normalize((_273 * _367.w) + ((_367.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _391 = _341;
        _392 = _331;
        _393 = 0.5;
        _394 = 0.0;
        _395 = _326;
        _396 = _273;
    }
    bool _406 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _412;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _248 + 18u)].w > 0.0) && _406)
    {
        _412 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _412 = 1.0;
    }
    float _459;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _342)].z > 0.0)
    {
        float3 _427 = fast::clamp((_247 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _438 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_427.x), int(_427.y), int(_427.z), 0).xyz), 0));
        _459 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_438.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_427 / float3(_438.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _459 = _412;
    }
    float3 _462 = sqrt(fast::clamp(_391, float3(0.0), float3(1.0)));
    float4 _464 = float4(_462.x, _462.y, _462.z, float4(0.0).w);
    _464.w = 1.0;
    float3 _472 = ((_395 - (_395 * _394)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _479 = (mix(float3(0.07999999821186065673828125 * _393), _395, float3(_394)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _482 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _487;
    if (_482)
    {
        _487 = _472 + (_479 * 0.449999988079071044921875);
    }
    else
    {
        _487 = _472;
    }
    float3 _489 = select(_479, float3(0.0), bool3(_482));
    float3 _491 = float3(dot(_489, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _587;
    float3 _588;
    if (_406)
    {
        float3 _517 = fast::clamp((_247 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _521 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _517);
        float4 _525 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _517);
        float4 _528 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _517);
        float4 _533 = float4(_521.x, _525.x, _528.x, _521.w);
        float4 _538 = float4(_521.y, _525.y, _528.y, _525.w);
        float4 _543 = float4(_521.z, _525.z, _528.zw);
        float4 _546 = _174;
        _546.y = (-0.48860299587249755859375) * _396.y;
        float4 _549 = _546;
        _549.z = 0.48860299587249755859375 * _396.z;
        float4 _552 = _549;
        _552.w = (-0.48860299587249755859375) * _396.x;
        float4 _553 = _552;
        _553.x = 0.886227548122406005859375;
        float3 _555 = _553.yzw * 2.094395160675048828125;
        float4 _556 = float4(_553.x, _555.x, _555.y, _555.z);
        float3 _558 = float3(0.0);
        _558.x = dot(_533, _556);
        float3 _560 = _558;
        _560.y = dot(_538, _556);
        float3 _562 = _560;
        _562.z = dot(_543, _556);
        float3 _565 = -_396;
        float4 _568 = _174;
        _568.y = (-0.48860299587249755859375) * _565.y;
        float4 _571 = _568;
        _571.z = 0.48860299587249755859375 * _565.z;
        float4 _574 = _571;
        _574.w = (-0.48860299587249755859375) * _565.x;
        float4 _575 = _574;
        _575.x = 0.886227548122406005859375;
        float3 _577 = _575.yzw * 2.094395160675048828125;
        float4 _578 = float4(_575.x, _577.x, _577.y, _577.z);
        float3 _580 = _175;
        _580.x = dot(_533, _578);
        float3 _582 = _580;
        _582.y = dot(_538, _578);
        float3 _584 = _582;
        _584.z = dot(_543, _578);
        _587 = fast::max(float3(0.0), _584) * float3(0.3183098733425140380859375);
        _588 = fast::max(float3(0.0), _562) * float3(0.3183098733425140380859375);
    }
    else
    {
        _587 = float3(0.0);
        _588 = float3(0.0);
    }
    float _615;
    float _616;
    float3 _617;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _605;
        float _606;
        if (_406)
        {
            _605 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _606 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _605 = _396;
            _606 = 1.0;
        }
        float _607 = 1.0 - _606;
        float _609 = 1.0 - (_607 * _607);
        _615 = mix(fast::clamp(dot(_605, _396), 0.0, 1.0), 1.0, _609);
        _616 = _606;
        _617 = mix(_605, _396, float3(_609));
    }
    else
    {
        _615 = 1.0;
        _616 = 1.0;
        _617 = _396;
    }
    float4 _621 = float4(_617, 1.0);
    float3 _625 = _171;
    _625.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _621);
    float3 _629 = _625;
    _629.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _621);
    float3 _633 = _629;
    _633.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _621);
    float4 _636 = _621.xyzz * _621.yzzx;
    float3 _640 = _171;
    _640.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _636);
    float3 _644 = _640;
    _644.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _636);
    float3 _648 = _644;
    _648.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _636);
    float3 _663 = -_396;
    float _664 = _663.x;
    float _665 = _663.y;
    float4 _667 = float4(_664, _665, _663.z, 1.0);
    float3 _670 = _175;
    _670.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _667);
    float3 _673 = _670;
    _673.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _667);
    float3 _676 = _673;
    _676.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _667);
    float4 _679 = _667.xyzz * _667.yzzx;
    float3 _682 = _175;
    _682.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _679);
    float3 _685 = _682;
    _685.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _679);
    float3 _688 = _685;
    _688.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _679);
    float3 _701 = (_588 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_633 + _648) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_617.x * _617.x) - (_617.y * _617.y)))) * View.View_SkyLightColor.xyz) * (_616 * _615));
    float3 _725 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _754;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _753;
        if (any(abs(_247 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _248 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _248 + 19u)].xyz + float3(1.0))))
        {
            _753 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_247, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _753 = _725;
        }
        _754 = _753;
    }
    else
    {
        _754 = _725;
    }
    float4 _761 = float4(((mix(float3(0.0), _487 + (_489 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + (((_701 * _487) + (((_587 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_676 + _688) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_664 * _664) - (_665 * _665)))) * View.View_SkyLightColor.xyz) * _616)) * _391)) * fast::max(float3(1.0), ((((((_395 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_395 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_395 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _754) * 1.0, 0.0);
    float4 _768;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _767 = _761;
        _767.w = 0.0;
        _768 = _767;
    }
    else
    {
        _768 = _761;
    }
    float2 _772 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _780 = (_396 * 0.5) + float3(0.5);
    float4 _782 = float4(_780.x, _780.y, _780.z, float4(0.0).w);
    _782.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _342)].y;
    float4 _783 = float4(0.0);
    _783.x = _394;
    float4 _784 = _783;
    _784.y = _393;
    float4 _785 = _784;
    _785.z = _392;
    float4 _786 = _785;
    _786.w = 0.525490224361419677734375;
    float4 _798 = float4(_395.x, _395.y, _395.z, float4(0.0).w);
    _798.w = ((log2(((dot(_701, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_491 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_491 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_491 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_772.xyx * _772.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _768 * View.View_PreExposure;
    out.out_var_SV_Target1 = _782;
    out.out_var_SV_Target2 = _786;
    out.out_var_SV_Target3 = _798;
    out.out_var_SV_Target4 = _464;
    out.out_var_SV_Target5 = float4(_459, 1.0, 1.0, 1.0);
    return out;
}

