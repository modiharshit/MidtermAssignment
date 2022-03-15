

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
    char _m0_pad[64];
    float4 IndirectLightingCache_PointSkyBentNormal;
    float IndirectLightingCache_DirectionalLightShadowing;
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients0;
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients1;
    float4 IndirectLightingCache_IndirectLightingSHCoefficients2;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _167 = {};
constant float3 _168 = {};
constant float _170 = {};
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

fragment MainPS_out Main_00004ad5_60353feb(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _228 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _170, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _233 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _238 = (_233.xyz / float3(_233.w)) - View.View_PreViewTranslation;
    float2 _239 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5;
    float4 _245 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _239, bias(View.View_MaterialTextureMipBias));
    float2 _248 = (_245.xy * float2(2.0)) - float2(1.0);
    float3 _264 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_248, sqrt(fast::clamp(1.0 - dot(_248, _248), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _276 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _281 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _286 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _290 = (_276.x + 0.5) * ((_281.x + 0.5) * (_286.x + 0.5));
    float4 _295 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _239, bias(View.View_MaterialTextureMipBias));
    float4 _301 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _239, bias(View.View_MaterialTextureMipBias));
    float _302 = _301.w;
    float3 _309 = fast::clamp(_295.xyz * mix(0.800000011920928955078125, 1.2000000476837158203125, _290), float3(0.0), float3(1.0));
    float _310 = fast::clamp(fast::min(fast::max(_302, 0.0), 1.0) * 2.0, 0.0, 1.0);
    float _311 = fast::clamp(_302, 0.0, 1.0);
    float _316 = (fast::clamp(mix(0.20000000298023223876953125, mix(0.60000002384185791015625, 1.0, _290), _301.x), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _317 = in.in_var_PRIMITIVE_ID * 36u;
    uint _318 = _317 + 20u;
    float _366;
    float _367;
    float _368;
    float3 _369;
    float3 _370;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _318)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _336 = ((_228.xy / float2(_228.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _340 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _336, level(0.0));
        float4 _343 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _336, level(0.0));
        float4 _346 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _336, level(0.0));
        float _356 = _346.w;
        _366 = (_316 * _356) + _346.z;
        _367 = (_310 * _356) + _346.y;
        _368 = _346.x;
        _369 = (_309 * _340.w) + _340.xyz;
        _370 = normalize((_264 * _343.w) + ((_343.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _366 = _316;
        _367 = _310;
        _368 = 0.0;
        _369 = _309;
        _370 = _264;
    }
    bool _380 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _386;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _317 + 18u)].w > 0.0) && _380)
    {
        _386 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _386 = 1.0;
    }
    float _433;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _318)].z > 0.0)
    {
        float3 _401 = fast::clamp((_238 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _412 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_401.x), int(_401.y), int(_401.z), 0).xyz), 0));
        _433 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_412.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_401 / float3(_412.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _433 = _386;
    }
    float3 _447 = ((_369 - (_369 * _368)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _454 = (mix(float3(0.07999999821186065673828125 * _367), _369, float3(_368)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _457 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _462;
    if (_457)
    {
        _462 = _447 + (_454 * 0.449999988079071044921875);
    }
    else
    {
        _462 = _447;
    }
    float3 _464 = select(_454, float3(0.0), bool3(_457));
    float3 _466 = float3(dot(_464, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _473 = float3(_311);
    float3 _553;
    if (_380)
    {
        float4 _503 = _171;
        _503.y = (-0.48860299587249755859375) * _370.y;
        float4 _506 = _503;
        _506.z = 0.48860299587249755859375 * _370.z;
        float4 _509 = _506;
        _509.w = (-0.48860299587249755859375) * _370.x;
        float3 _510 = _370 * _370;
        float4 _513 = _167;
        _513.x = (1.09254801273345947265625 * _370.x) * _370.y;
        float4 _516 = _513;
        _516.y = ((-1.09254801273345947265625) * _370.y) * _370.z;
        float4 _521 = _516;
        _521.z = 0.3153919875621795654296875 * ((3.0 * _510.z) - 1.0);
        float4 _524 = _521;
        _524.w = ((-1.09254801273345947265625) * _370.x) * _370.z;
        float4 _528 = _509;
        _528.x = 0.886227548122406005859375;
        float3 _530 = _528.yzw * 2.094395160675048828125;
        float4 _531 = float4(_528.x, _530.x, _530.y, _530.z);
        float4 _532 = _524 * 0.785398185253143310546875;
        float _533 = (_510.x - _510.y) * 0.4290426075458526611328125;
        float3 _539 = float3(0.0);
        _539.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _531) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _532)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _533);
        float3 _545 = _539;
        _545.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _531) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _532)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _533);
        float3 _551 = _545;
        _551.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _531) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _532)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _533);
        _553 = fast::max(float3(0.0), _551);
    }
    else
    {
        _553 = float3(0.0);
    }
    float _579;
    float _580;
    float3 _581;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _569;
        float _570;
        if (_380)
        {
            _569 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _570 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _569 = _370;
            _570 = 1.0;
        }
        float _571 = 1.0 - _570;
        float _573 = 1.0 - (_571 * _571);
        _579 = mix(fast::clamp(dot(_569, _370), 0.0, 1.0), 1.0, _573);
        _580 = _570;
        _581 = mix(_569, _370, float3(_573));
    }
    else
    {
        _579 = 1.0;
        _580 = 1.0;
        _581 = _370;
    }
    float4 _585 = float4(_581, 1.0);
    float3 _589 = _168;
    _589.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _585);
    float3 _593 = _589;
    _593.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _585);
    float3 _597 = _593;
    _597.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _585);
    float4 _600 = _585.xyzz * _585.yzzx;
    float3 _604 = _168;
    _604.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _600);
    float3 _608 = _604;
    _608.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _600);
    float3 _612 = _608;
    _612.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _600);
    float3 _627 = (_553 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_597 + _612) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_581.x * _581.x) - (_581.y * _581.y)))) * View.View_SkyLightColor.xyz) * (_580 * _579));
    float3 _649 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _678;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _677;
        if (any(abs(_238 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _317 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _317 + 19u)].xyz + float3(1.0))))
        {
            _677 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_238, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _677 = _649;
        }
        _678 = _677;
    }
    else
    {
        _678 = _649;
    }
    float4 _685 = float4(((mix(float3(0.0), _462 + (_464 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_627 * _462) * fast::max(_473, ((((((_369 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _311) + ((_369 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _311) + ((_369 * 2.755199909210205078125) + float3(0.69029998779296875))) * _311))) + _678) * 1.0, 0.0);
    float4 _692;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _691 = _685;
        _691.w = 0.0;
        _692 = _691;
    }
    else
    {
        _692 = _685;
    }
    float2 _696 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _704 = (_370 * 0.5) + float3(0.5);
    float4 _706 = float4(_704.x, _704.y, _704.z, float4(0.0).w);
    _706.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _318)].y;
    float4 _707 = float4(0.0);
    _707.x = _368;
    float4 _708 = _707;
    _708.y = _367;
    float4 _709 = _708;
    _709.z = _366;
    float4 _710 = _709;
    _710.w = 0.50588238239288330078125;
    float4 _722 = float4(_369.x, _369.y, _369.z, float4(0.0).w);
    _722.w = ((log2(((dot(_627, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_473, ((((((_466 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _311) + ((_466 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _311) + ((_466 * 2.755199909210205078125) + float3(0.69029998779296875))) * _311).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_696.xyx * _696.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _692 * View.View_PreExposure;
    out.out_var_SV_Target1 = _706;
    out.out_var_SV_Target2 = _710;
    out.out_var_SV_Target3 = _722;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_433, 1.0, 1.0, 1.0);
    return out;
}

