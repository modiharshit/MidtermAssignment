

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
    char _m0_pad[80];
    float IndirectLightingCache_DirectionalLightShadowing;
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients0;
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients1;
    float4 IndirectLightingCache_IndirectLightingSHCoefficients2;
};

struct type_Material
{
    spvUnsafeArray<float4, 8> Material_VectorExpressions;
    spvUnsafeArray<float4, 2> Material_ScalarExpressions;
};

constant float4 _159 = {};
constant float _161 = {};
constant float4 _162 = {};

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

fragment MainPS_out Main_00003e55_43b2890c(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _215 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _161, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _220 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _225 = (_220.xyz / float3(_220.w)) - View.View_PreViewTranslation;
    float4 _231 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _234 = (_231.xy * float2(2.0)) - float2(1.0);
    float3 _250 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_234, sqrt(fast::clamp(1.0 - dot(_234, _234), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _261 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _268 = _261.y;
    float _274 = _261.z;
    float _277 = _261.x;
    float3 _295 = fast::clamp(mix(mix(Material.Material_VectorExpressions[4].xyz, Material.Material_VectorExpressions[5].xyz, float3(_268)), Material.Material_VectorExpressions[7].xyz, float3(_274)) * _277, float3(0.0), float3(1.0));
    float _296 = fast::clamp(mix(mix(Material.Material_ScalarExpressions[0].y, Material.Material_ScalarExpressions[0].z, _268), Material.Material_ScalarExpressions[0].w, _274), 0.0, 1.0);
    float _297 = fast::clamp(_277, 0.0, 1.0);
    float _302 = (fast::clamp(mix(mix(Material.Material_ScalarExpressions[1].x, Material.Material_ScalarExpressions[1].y, _268), Material.Material_ScalarExpressions[1].z, _274), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _303 = in.in_var_PRIMITIVE_ID * 36u;
    uint _304 = _303 + 20u;
    float _354;
    float _355;
    float _356;
    float3 _357;
    float3 _358;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _304)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _322 = ((_215.xy / float2(_215.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _326 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _322, level(0.0));
        float4 _329 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _322, level(0.0));
        float4 _332 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _322, level(0.0));
        float _342 = _332.w;
        _354 = (_302 * _342) + _332.z;
        _355 = (0.5 * _342) + _332.y;
        _356 = (_296 * _342) + _332.x;
        _357 = (_295 * _326.w) + _326.xyz;
        _358 = normalize((_250 * _329.w) + ((_329.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _354 = _302;
        _355 = 0.5;
        _356 = _296;
        _357 = _295;
        _358 = _250;
    }
    bool _368 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _374;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _303 + 18u)].w > 0.0) && _368)
    {
        _374 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _374 = 1.0;
    }
    float _421;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _304)].z > 0.0)
    {
        float3 _389 = fast::clamp((_225 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _400 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_389.x), int(_389.y), int(_389.z), 0).xyz), 0));
        _421 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_400.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_389 / float3(_400.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _421 = _374;
    }
    float3 _435 = ((_357 - (_357 * _356)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _442 = (mix(float3(0.07999999821186065673828125 * _355), _357, float3(_356)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _445 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _450;
    if (_445)
    {
        _450 = _435 + (_442 * 0.449999988079071044921875);
    }
    else
    {
        _450 = _435;
    }
    float3 _452 = select(_442, float3(0.0), bool3(_445));
    float3 _454 = float3(dot(_452, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _461 = float3(_297);
    float3 _541;
    if (_368)
    {
        float4 _491 = _162;
        _491.y = (-0.48860299587249755859375) * _358.y;
        float4 _494 = _491;
        _494.z = 0.48860299587249755859375 * _358.z;
        float4 _497 = _494;
        _497.w = (-0.48860299587249755859375) * _358.x;
        float3 _498 = _358 * _358;
        float4 _501 = _159;
        _501.x = (1.09254801273345947265625 * _358.x) * _358.y;
        float4 _504 = _501;
        _504.y = ((-1.09254801273345947265625) * _358.y) * _358.z;
        float4 _509 = _504;
        _509.z = 0.3153919875621795654296875 * ((3.0 * _498.z) - 1.0);
        float4 _512 = _509;
        _512.w = ((-1.09254801273345947265625) * _358.x) * _358.z;
        float4 _516 = _497;
        _516.x = 0.886227548122406005859375;
        float3 _518 = _516.yzw * 2.094395160675048828125;
        float4 _519 = float4(_516.x, _518.x, _518.y, _518.z);
        float4 _520 = _512 * 0.785398185253143310546875;
        float _521 = (_498.x - _498.y) * 0.4290426075458526611328125;
        float3 _527 = float3(0.0);
        _527.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _519) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _520)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _521);
        float3 _533 = _527;
        _533.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _519) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _520)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _521);
        float3 _539 = _533;
        _539.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _519) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _520)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _521);
        _541 = fast::max(float3(0.0), _539);
    }
    else
    {
        _541 = float3(0.0);
    }
    float3 _544 = _541 * View.View_IndirectLightingColorScale;
    float3 _566 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _595;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _594;
        if (any(abs(_225 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _303 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _303 + 19u)].xyz + float3(1.0))))
        {
            _594 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_225, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _594 = _566;
        }
        _595 = _594;
    }
    else
    {
        _595 = _566;
    }
    float4 _602 = float4(((mix(float3(0.0), _450 + (_452 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_544 * _450) * fast::max(_461, ((((((_357 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _297) + ((_357 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _297) + ((_357 * 2.755199909210205078125) + float3(0.69029998779296875))) * _297))) + _595) * 1.0, 0.0);
    float4 _609;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _608 = _602;
        _608.w = 0.0;
        _609 = _608;
    }
    else
    {
        _609 = _602;
    }
    float2 _613 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _621 = (_358 * 0.5) + float3(0.5);
    float4 _623 = float4(_621.x, _621.y, _621.z, float4(0.0).w);
    _623.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _304)].y;
    float4 _624 = float4(0.0);
    _624.x = _356;
    float4 _625 = _624;
    _625.y = _355;
    float4 _626 = _625;
    _626.z = _354;
    float4 _627 = _626;
    _627.w = 0.50588238239288330078125;
    float4 _639 = float4(_357.x, _357.y, _357.z, float4(0.0).w);
    _639.w = ((log2(((dot(_544, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_461, ((((((_454 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _297) + ((_454 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _297) + ((_454 * 2.755199909210205078125) + float3(0.69029998779296875))) * _297).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_613.xyx * _613.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _609 * View.View_PreExposure;
    out.out_var_SV_Target1 = _623;
    out.out_var_SV_Target2 = _627;
    out.out_var_SV_Target3 = _639;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_421, 1.0, 1.0, 1.0);
    return out;
}

