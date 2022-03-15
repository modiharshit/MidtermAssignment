

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
    spvUnsafeArray<float4, 4> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _157 = {};
constant float3 _158 = {};
constant float _160 = {};
constant float4 _161 = {};

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

fragment MainPS_out Main_00004625_d3dbb27b(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _218 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _160, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _223 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _228 = (_223.xyz / float3(_223.w)) - View.View_PreViewTranslation;
    float4 _234 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _237 = (_234.xy * float2(2.0)) - float2(1.0);
    float3 _253 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_237, sqrt(fast::clamp(1.0 - dot(_237, _237), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _264 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _268 = _264.x;
    float3 _277 = fast::clamp(Material.Material_VectorExpressions[3].xyz * _268, float3(0.0), float3(1.0));
    float _278 = fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0);
    float _283 = (fast::clamp(mix(Material.Material_ScalarExpressions[0].z, Material.Material_ScalarExpressions[0].w, _268), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _284 = in.in_var_PRIMITIVE_ID * 36u;
    uint _285 = _284 + 20u;
    float _335;
    float _336;
    float _337;
    float3 _338;
    float3 _339;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _285)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _303 = ((_218.xy / float2(_218.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _307 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _303, level(0.0));
        float4 _310 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _303, level(0.0));
        float4 _313 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _303, level(0.0));
        float _323 = _313.w;
        _335 = (_283 * _323) + _313.z;
        _336 = (0.5 * _323) + _313.y;
        _337 = (_278 * _323) + _313.x;
        _338 = (_277 * _307.w) + _307.xyz;
        _339 = normalize((_253 * _310.w) + ((_310.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _335 = _283;
        _336 = 0.5;
        _337 = _278;
        _338 = _277;
        _339 = _253;
    }
    bool _349 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _355;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _284 + 18u)].w > 0.0) && _349)
    {
        _355 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _355 = 1.0;
    }
    float _402;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _285)].z > 0.0)
    {
        float3 _370 = fast::clamp((_228 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _381 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_370.x), int(_370.y), int(_370.z), 0).xyz), 0));
        _402 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_381.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_370 / float3(_381.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _402 = _355;
    }
    float3 _416 = ((_338 - (_338 * _337)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _423 = (mix(float3(0.07999999821186065673828125 * _336), _338, float3(_337)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _426 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _431;
    if (_426)
    {
        _431 = _416 + (_423 * 0.449999988079071044921875);
    }
    else
    {
        _431 = _416;
    }
    float3 _433 = select(_423, float3(0.0), bool3(_426));
    float3 _435 = float3(dot(_433, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _521;
    if (_349)
    {
        float4 _471 = _161;
        _471.y = (-0.48860299587249755859375) * _339.y;
        float4 _474 = _471;
        _474.z = 0.48860299587249755859375 * _339.z;
        float4 _477 = _474;
        _477.w = (-0.48860299587249755859375) * _339.x;
        float3 _478 = _339 * _339;
        float4 _481 = _157;
        _481.x = (1.09254801273345947265625 * _339.x) * _339.y;
        float4 _484 = _481;
        _484.y = ((-1.09254801273345947265625) * _339.y) * _339.z;
        float4 _489 = _484;
        _489.z = 0.3153919875621795654296875 * ((3.0 * _478.z) - 1.0);
        float4 _492 = _489;
        _492.w = ((-1.09254801273345947265625) * _339.x) * _339.z;
        float4 _496 = _477;
        _496.x = 0.886227548122406005859375;
        float3 _498 = _496.yzw * 2.094395160675048828125;
        float4 _499 = float4(_496.x, _498.x, _498.y, _498.z);
        float4 _500 = _492 * 0.785398185253143310546875;
        float _501 = (_478.x - _478.y) * 0.4290426075458526611328125;
        float3 _507 = float3(0.0);
        _507.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _499) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _500)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _501);
        float3 _513 = _507;
        _513.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _499) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _500)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _501);
        float3 _519 = _513;
        _519.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _499) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _500)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _501);
        _521 = fast::max(float3(0.0), _519);
    }
    else
    {
        _521 = float3(0.0);
    }
    float _547;
    float _548;
    float3 _549;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _537;
        float _538;
        if (_349)
        {
            _537 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _538 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _537 = _339;
            _538 = 1.0;
        }
        float _539 = 1.0 - _538;
        float _541 = 1.0 - (_539 * _539);
        _547 = mix(fast::clamp(dot(_537, _339), 0.0, 1.0), 1.0, _541);
        _548 = _538;
        _549 = mix(_537, _339, float3(_541));
    }
    else
    {
        _547 = 1.0;
        _548 = 1.0;
        _549 = _339;
    }
    float4 _553 = float4(_549, 1.0);
    float3 _557 = _158;
    _557.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _553);
    float3 _561 = _557;
    _561.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _553);
    float3 _565 = _561;
    _565.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _553);
    float4 _568 = _553.xyzz * _553.yzzx;
    float3 _572 = _158;
    _572.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _568);
    float3 _576 = _572;
    _576.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _568);
    float3 _580 = _576;
    _580.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _568);
    float3 _595 = (_521 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_565 + _580) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_549.x * _549.x) - (_549.y * _549.y)))) * View.View_SkyLightColor.xyz) * (_548 * _547));
    float3 _617 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _646;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _645;
        if (any(abs(_228 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _284 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _284 + 19u)].xyz + float3(1.0))))
        {
            _645 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_228, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _645 = _617;
        }
        _646 = _645;
    }
    else
    {
        _646 = _617;
    }
    float4 _653 = float4(((mix(float3(0.0), _431 + (_433 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_595 * _431) * fast::max(float3(1.0), ((((((_338 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_338 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_338 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _646) * 1.0, 0.0);
    float4 _660;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _659 = _653;
        _659.w = 0.0;
        _660 = _659;
    }
    else
    {
        _660 = _653;
    }
    float2 _664 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _672 = (_339 * 0.5) + float3(0.5);
    float4 _674 = float4(_672.x, _672.y, _672.z, float4(0.0).w);
    _674.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _285)].y;
    float4 _675 = float4(0.0);
    _675.x = _337;
    float4 _676 = _675;
    _676.y = _336;
    float4 _677 = _676;
    _677.z = _335;
    float4 _678 = _677;
    _678.w = 0.50588238239288330078125;
    float4 _690 = float4(_338.x, _338.y, _338.z, float4(0.0).w);
    _690.w = ((log2(((dot(_595, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_435 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_435 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_435 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_664.xyx * _664.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _660 * View.View_PreExposure;
    out.out_var_SV_Target1 = _674;
    out.out_var_SV_Target2 = _678;
    out.out_var_SV_Target3 = _690;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_402, 1.0, 1.0, 1.0);
    return out;
}

