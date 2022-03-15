

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

constant float4 _162 = {};
constant float3 _163 = {};
constant float _165 = {};
constant float4 _166 = {};

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

fragment MainPS_out Main_000048dc_ecc6fb24(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _223 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _165, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _228 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _233 = (_228.xyz / float3(_228.w)) - View.View_PreViewTranslation;
    float4 _239 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _242 = (_239.xy * float2(2.0)) - float2(1.0);
    float3 _258 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_242, sqrt(fast::clamp(1.0 - dot(_242, _242), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _270 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _275 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _280 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _284 = (_270.x + 0.5) * ((_275.x + 0.5) * (_280.x + 0.5));
    float4 _290 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _296 = fast::clamp(mix(float3(0.5), float3(1.0), float3(_284)) * _290.xyz, float3(0.0), float3(1.0));
    float _301 = (fast::clamp(mix(0.60000002384185791015625, 0.5, _284 * _290.w), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _302 = in.in_var_PRIMITIVE_ID * 36u;
    uint _303 = _302 + 20u;
    float _352;
    float _353;
    float _354;
    float3 _355;
    float3 _356;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _303)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _321 = ((_223.xy / float2(_223.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _325 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _321, level(0.0));
        float4 _328 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _321, level(0.0));
        float4 _331 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _321, level(0.0));
        float _341 = _331.w;
        _352 = (_301 * _341) + _331.z;
        _353 = (0.5 * _341) + _331.y;
        _354 = _341 + _331.x;
        _355 = (_296 * _325.w) + _325.xyz;
        _356 = normalize((_258 * _328.w) + ((_328.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _352 = _301;
        _353 = 0.5;
        _354 = 1.0;
        _355 = _296;
        _356 = _258;
    }
    bool _366 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _372;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _302 + 18u)].w > 0.0) && _366)
    {
        _372 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _372 = 1.0;
    }
    float _419;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _303)].z > 0.0)
    {
        float3 _387 = fast::clamp((_233 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _398 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_387.x), int(_387.y), int(_387.z), 0).xyz), 0));
        _419 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_398.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_387 / float3(_398.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _419 = _372;
    }
    float3 _433 = ((_355 - (_355 * _354)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _440 = (mix(float3(0.07999999821186065673828125 * _353), _355, float3(_354)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _443 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _448;
    if (_443)
    {
        _448 = _433 + (_440 * 0.449999988079071044921875);
    }
    else
    {
        _448 = _433;
    }
    float3 _450 = select(_440, float3(0.0), bool3(_443));
    float3 _452 = float3(dot(_450, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _538;
    if (_366)
    {
        float4 _488 = _166;
        _488.y = (-0.48860299587249755859375) * _356.y;
        float4 _491 = _488;
        _491.z = 0.48860299587249755859375 * _356.z;
        float4 _494 = _491;
        _494.w = (-0.48860299587249755859375) * _356.x;
        float3 _495 = _356 * _356;
        float4 _498 = _162;
        _498.x = (1.09254801273345947265625 * _356.x) * _356.y;
        float4 _501 = _498;
        _501.y = ((-1.09254801273345947265625) * _356.y) * _356.z;
        float4 _506 = _501;
        _506.z = 0.3153919875621795654296875 * ((3.0 * _495.z) - 1.0);
        float4 _509 = _506;
        _509.w = ((-1.09254801273345947265625) * _356.x) * _356.z;
        float4 _513 = _494;
        _513.x = 0.886227548122406005859375;
        float3 _515 = _513.yzw * 2.094395160675048828125;
        float4 _516 = float4(_513.x, _515.x, _515.y, _515.z);
        float4 _517 = _509 * 0.785398185253143310546875;
        float _518 = (_495.x - _495.y) * 0.4290426075458526611328125;
        float3 _524 = float3(0.0);
        _524.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _516) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _517)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _518);
        float3 _530 = _524;
        _530.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _516) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _517)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _518);
        float3 _536 = _530;
        _536.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _516) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _517)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _518);
        _538 = fast::max(float3(0.0), _536);
    }
    else
    {
        _538 = float3(0.0);
    }
    float _564;
    float _565;
    float3 _566;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _554;
        float _555;
        if (_366)
        {
            _554 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _555 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _554 = _356;
            _555 = 1.0;
        }
        float _556 = 1.0 - _555;
        float _558 = 1.0 - (_556 * _556);
        _564 = mix(fast::clamp(dot(_554, _356), 0.0, 1.0), 1.0, _558);
        _565 = _555;
        _566 = mix(_554, _356, float3(_558));
    }
    else
    {
        _564 = 1.0;
        _565 = 1.0;
        _566 = _356;
    }
    float4 _570 = float4(_566, 1.0);
    float3 _574 = _163;
    _574.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _570);
    float3 _578 = _574;
    _578.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _570);
    float3 _582 = _578;
    _582.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _570);
    float4 _585 = _570.xyzz * _570.yzzx;
    float3 _589 = _163;
    _589.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _585);
    float3 _593 = _589;
    _593.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _585);
    float3 _597 = _593;
    _597.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _585);
    float3 _612 = (_538 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_582 + _597) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_566.x * _566.x) - (_566.y * _566.y)))) * View.View_SkyLightColor.xyz) * (_565 * _564));
    float3 _634 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _663;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _662;
        if (any(abs(_233 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _302 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _302 + 19u)].xyz + float3(1.0))))
        {
            _662 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_233, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _662 = _634;
        }
        _663 = _662;
    }
    else
    {
        _663 = _634;
    }
    float4 _670 = float4(((mix(float3(0.0), _448 + (_450 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_612 * _448) * fast::max(float3(1.0), ((((((_355 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_355 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_355 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _663) * 1.0, 0.0);
    float4 _677;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _676 = _670;
        _676.w = 0.0;
        _677 = _676;
    }
    else
    {
        _677 = _670;
    }
    float2 _681 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _689 = (_356 * 0.5) + float3(0.5);
    float4 _691 = float4(_689.x, _689.y, _689.z, float4(0.0).w);
    _691.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _303)].y;
    float4 _692 = float4(0.0);
    _692.x = _354;
    float4 _693 = _692;
    _693.y = _353;
    float4 _694 = _693;
    _694.z = _352;
    float4 _695 = _694;
    _695.w = 0.50588238239288330078125;
    float4 _707 = float4(_355.x, _355.y, _355.z, float4(0.0).w);
    _707.w = ((log2(((dot(_612, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_452 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_452 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_452 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_681.xyx * _681.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _677 * View.View_PreExposure;
    out.out_var_SV_Target1 = _691;
    out.out_var_SV_Target2 = _695;
    out.out_var_SV_Target3 = _707;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_419, 1.0, 1.0, 1.0);
    return out;
}

