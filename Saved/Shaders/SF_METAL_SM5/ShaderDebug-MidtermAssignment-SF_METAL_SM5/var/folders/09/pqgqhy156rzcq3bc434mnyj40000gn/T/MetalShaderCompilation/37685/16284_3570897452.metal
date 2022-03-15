

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
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_Material
{
    spvUnsafeArray<float4, 8> Material_VectorExpressions;
    spvUnsafeArray<float4, 2> Material_ScalarExpressions;
};

constant float3 _150 = {};
constant float _151 = {};

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
    float4 in_var_TEXCOORD4 [[user(locn3)]];
    uint in_var_PRIMITIVE_ID [[user(locn4)]];
    uint in_var_LIGHTMAP_ID [[user(locn5)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00003f9c_d4d7922c(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], texture2d<float> LightmapResourceCluster_StaticShadowTexture [[texture(5)]], texture2d<float> Material_Texture2D_0 [[texture(6)]], texture2d<float> Material_Texture2D_1 [[texture(7)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _205 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _151, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _210 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _215 = (_210.xyz / float3(_210.w)) - View.View_PreViewTranslation;
    float4 _221 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _224 = (_221.xy * float2(2.0)) - float2(1.0);
    float3 _240 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_224, sqrt(fast::clamp(1.0 - dot(_224, _224), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _251 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _258 = _251.y;
    float _264 = _251.z;
    float _267 = _251.x;
    float3 _285 = fast::clamp(mix(mix(Material.Material_VectorExpressions[4].xyz, Material.Material_VectorExpressions[5].xyz, float3(_258)), Material.Material_VectorExpressions[7].xyz, float3(_264)) * _267, float3(0.0), float3(1.0));
    float _286 = fast::clamp(mix(mix(Material.Material_ScalarExpressions[0].y, Material.Material_ScalarExpressions[0].z, _258), Material.Material_ScalarExpressions[0].w, _264), 0.0, 1.0);
    float _287 = fast::clamp(_267, 0.0, 1.0);
    float _292 = (fast::clamp(mix(mix(Material.Material_ScalarExpressions[1].x, Material.Material_ScalarExpressions[1].y, _258), Material.Material_ScalarExpressions[1].z, _264), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _293 = in.in_var_PRIMITIVE_ID * 36u;
    uint _294 = _293 + 20u;
    float _344;
    float _345;
    float _346;
    float3 _347;
    float3 _348;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _294)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _312 = ((_205.xy / float2(_205.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _316 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _312, level(0.0));
        float4 _319 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _312, level(0.0));
        float4 _322 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _312, level(0.0));
        float _332 = _322.w;
        _344 = (_292 * _332) + _322.z;
        _345 = (0.5 * _332) + _322.y;
        _346 = (_286 * _332) + _322.x;
        _347 = (_285 * _316.w) + _316.xyz;
        _348 = normalize((_240 * _319.w) + ((_319.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _344 = _292;
        _345 = 0.5;
        _346 = _286;
        _347 = _285;
        _348 = _240;
    }
    float4 _355 = LightmapResourceCluster_StaticShadowTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.zw);
    uint _356 = in.in_var_LIGHTMAP_ID * 15u;
    uint _357 = _356 + 1u;
    float4 _364 = fast::clamp((_355 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _357)]) + ((View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _357)] * (-0.5)) + float4(0.5)), float4(0.0), float4(1.0));
    float3 _381 = ((_347 - (_347 * _346)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _388 = (mix(float3(0.07999999821186065673828125 * _345), _347, float3(_346)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _391 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _396;
    if (_391)
    {
        _396 = _381 + (_388 * 0.449999988079071044921875);
    }
    else
    {
        _396 = _381;
    }
    float3 _398 = select(_388, float3(0.0), bool3(_391));
    float3 _400 = float3(dot(_398, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _407 = float3(_287);
    float2 _416 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _420 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _416);
    float4 _422 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_416 + float2(0.0, 0.5)));
    uint _428 = _356 + 4u;
    uint _433 = _356 + 6u;
    float3 _438 = _420.xyz;
    float _490;
    float _491;
    float3 _492;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _474 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _478 = _474.w;
        float _479 = _478 * _478;
        float3 _481 = normalize(((_474.xyz * 2.0) - float3(1.0)).xyz);
        float _482 = 1.0 - _479;
        float _484 = 1.0 - (_482 * _482);
        _490 = mix(fast::clamp(dot(_481, _348), 0.0, 1.0), 1.0, _484);
        _491 = _479;
        _492 = mix(_481, _348, float3(_484));
    }
    else
    {
        _490 = 1.0;
        _491 = 1.0;
        _492 = _348;
    }
    float4 _496 = float4(_492, 1.0);
    float3 _500 = _150;
    _500.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _496);
    float3 _504 = _500;
    _504.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _496);
    float3 _508 = _504;
    _508.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _496);
    float4 _511 = _496.xyzz * _496.yzzx;
    float3 _515 = _150;
    _515.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _511);
    float3 _519 = _515;
    _519.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _511);
    float3 _523 = _519;
    _523.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _511);
    float3 _538 = (((((_438 * _438) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _428)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _433)].xyz) * ((exp2(((_420.w + ((_422.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _428)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _433)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_422 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _356 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _356 + 7u)], float4(_348.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_508 + _523) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_492.x * _492.x) - (_492.y * _492.y)))) * View.View_SkyLightColor.xyz) * (_491 * _490));
    float3 _560 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _589;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _588;
        if (any(abs(_215 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _293 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _293 + 19u)].xyz + float3(1.0))))
        {
            _588 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_215, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _588 = _560;
        }
        _589 = _588;
    }
    else
    {
        _589 = _560;
    }
    float4 _596 = float4(((mix(float3(0.0), _396 + (_398 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_538 * _396) * fast::max(_407, ((((((_347 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _287) + ((_347 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _287) + ((_347 * 2.755199909210205078125) + float3(0.69029998779296875))) * _287))) + _589) * 1.0, 0.0);
    float4 _603;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _602 = _596;
        _602.w = 0.0;
        _603 = _602;
    }
    else
    {
        _603 = _596;
    }
    float2 _607 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _615 = (_348 * 0.5) + float3(0.5);
    float4 _617 = float4(_615.x, _615.y, _615.z, float4(0.0).w);
    _617.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _294)].y;
    float4 _618 = float4(0.0);
    _618.x = _346;
    float4 _619 = _618;
    _619.y = _345;
    float4 _620 = _619;
    _620.z = _344;
    float4 _621 = _620;
    _621.w = 0.50588238239288330078125;
    float4 _633 = float4(_347.x, _347.y, _347.z, float4(0.0).w);
    _633.w = ((log2(((dot(_538, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_407, ((((((_400 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _287) + ((_400 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _287) + ((_400 * 2.755199909210205078125) + float3(0.69029998779296875))) * _287).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_607.xyx * _607.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _603 * View.View_PreExposure;
    out.out_var_SV_Target1 = _617;
    out.out_var_SV_Target2 = _621;
    out.out_var_SV_Target3 = _633;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = (View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _356)] * _364) * _364;
    return out;
}

