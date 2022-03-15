

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

constant float4 _164 = {};
constant float3 _165 = {};
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

fragment MainPS_out Main_000049c3_7fea51ca(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _225 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _167, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _230 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _235 = (_230.xyz / float3(_230.w)) - View.View_PreViewTranslation;
    float4 _241 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _244 = (_241.xy * float2(2.0)) - float2(1.0);
    float _251 = sqrt(fast::clamp(1.0 - dot(_244, _244), 0.0, 1.0)) + 1.0;
    float4 _254 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 2.0), bias(View.View_MaterialTextureMipBias));
    float2 _257 = (_254.xy * float2(2.0)) - float2(1.0);
    float3 _266 = float4(_257, sqrt(fast::clamp(1.0 - dot(_257, _257), 0.0, 1.0)), 1.0).xyz * float3(-1.0, -1.0, 1.0);
    float3 _269 = float3(_244, _251);
    float3 _273 = float3(_266.xy * (-1.0), _266.z);
    float3 _285 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((((_269 * dot(_269, _273)) - (_273 * _251)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _297 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _302 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.02999999932944774627685546875), bias(View.View_MaterialTextureMipBias));
    float4 _311 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _315 = fast::clamp(mix(float3(0.5), float3(1.0), float3((_297.x + 0.5) * (_302.x + 0.5))) * _311.xyz, float3(0.0), float3(1.0));
    float _316 = fast::clamp(_311.w, 0.0, 1.0);
    float _320 = (0.980000019073486328125 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _321 = in.in_var_PRIMITIVE_ID * 36u;
    uint _322 = _321 + 20u;
    float _370;
    float _371;
    float _372;
    float3 _373;
    float3 _374;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _322)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _340 = ((_225.xy / float2(_225.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _344 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _340, level(0.0));
        float4 _347 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _340, level(0.0));
        float4 _350 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _340, level(0.0));
        float _360 = _350.w;
        _370 = (_320 * _360) + _350.z;
        _371 = (_316 * _360) + _350.y;
        _372 = _350.x;
        _373 = (_315 * _344.w) + _344.xyz;
        _374 = normalize((_285 * _347.w) + ((_347.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _370 = _320;
        _371 = _316;
        _372 = 0.0;
        _373 = _315;
        _374 = _285;
    }
    bool _384 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _390;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _321 + 18u)].w > 0.0) && _384)
    {
        _390 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _390 = 1.0;
    }
    float _437;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _322)].z > 0.0)
    {
        float3 _405 = fast::clamp((_235 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _416 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_405.x), int(_405.y), int(_405.z), 0).xyz), 0));
        _437 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_416.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_405 / float3(_416.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _437 = _390;
    }
    float3 _451 = ((_373 - (_373 * _372)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _458 = (mix(float3(0.07999999821186065673828125 * _371), _373, float3(_372)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _461 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _466;
    if (_461)
    {
        _466 = _451 + (_458 * 0.449999988079071044921875);
    }
    else
    {
        _466 = _451;
    }
    float3 _468 = select(_458, float3(0.0), bool3(_461));
    float3 _470 = float3(dot(_468, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _556;
    if (_384)
    {
        float4 _506 = _168;
        _506.y = (-0.48860299587249755859375) * _374.y;
        float4 _509 = _506;
        _509.z = 0.48860299587249755859375 * _374.z;
        float4 _512 = _509;
        _512.w = (-0.48860299587249755859375) * _374.x;
        float3 _513 = _374 * _374;
        float4 _516 = _164;
        _516.x = (1.09254801273345947265625 * _374.x) * _374.y;
        float4 _519 = _516;
        _519.y = ((-1.09254801273345947265625) * _374.y) * _374.z;
        float4 _524 = _519;
        _524.z = 0.3153919875621795654296875 * ((3.0 * _513.z) - 1.0);
        float4 _527 = _524;
        _527.w = ((-1.09254801273345947265625) * _374.x) * _374.z;
        float4 _531 = _512;
        _531.x = 0.886227548122406005859375;
        float3 _533 = _531.yzw * 2.094395160675048828125;
        float4 _534 = float4(_531.x, _533.x, _533.y, _533.z);
        float4 _535 = _527 * 0.785398185253143310546875;
        float _536 = (_513.x - _513.y) * 0.4290426075458526611328125;
        float3 _542 = float3(0.0);
        _542.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _534) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _535)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _536);
        float3 _548 = _542;
        _548.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _534) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _535)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _536);
        float3 _554 = _548;
        _554.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _534) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _535)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _536);
        _556 = fast::max(float3(0.0), _554);
    }
    else
    {
        _556 = float3(0.0);
    }
    float _582;
    float _583;
    float3 _584;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _572;
        float _573;
        if (_384)
        {
            _572 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _573 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _572 = _374;
            _573 = 1.0;
        }
        float _574 = 1.0 - _573;
        float _576 = 1.0 - (_574 * _574);
        _582 = mix(fast::clamp(dot(_572, _374), 0.0, 1.0), 1.0, _576);
        _583 = _573;
        _584 = mix(_572, _374, float3(_576));
    }
    else
    {
        _582 = 1.0;
        _583 = 1.0;
        _584 = _374;
    }
    float4 _588 = float4(_584, 1.0);
    float3 _592 = _165;
    _592.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _588);
    float3 _596 = _592;
    _596.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _588);
    float3 _600 = _596;
    _600.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _588);
    float4 _603 = _588.xyzz * _588.yzzx;
    float3 _607 = _165;
    _607.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _603);
    float3 _611 = _607;
    _611.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _603);
    float3 _615 = _611;
    _615.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _603);
    float3 _630 = (_556 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_600 + _615) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_584.x * _584.x) - (_584.y * _584.y)))) * View.View_SkyLightColor.xyz) * (_583 * _582));
    float3 _652 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _681;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _680;
        if (any(abs(_235 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _321 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _321 + 19u)].xyz + float3(1.0))))
        {
            _680 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_235, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _680 = _652;
        }
        _681 = _680;
    }
    else
    {
        _681 = _652;
    }
    float4 _688 = float4(((mix(float3(0.0), _466 + (_468 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_630 * _466) * fast::max(float3(1.0), ((((((_373 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_373 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_373 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _681) * 1.0, 0.0);
    float4 _695;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _694 = _688;
        _694.w = 0.0;
        _695 = _694;
    }
    else
    {
        _695 = _688;
    }
    float2 _699 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _707 = (_374 * 0.5) + float3(0.5);
    float4 _709 = float4(_707.x, _707.y, _707.z, float4(0.0).w);
    _709.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _322)].y;
    float4 _710 = float4(0.0);
    _710.x = _372;
    float4 _711 = _710;
    _711.y = _371;
    float4 _712 = _711;
    _712.z = _370;
    float4 _713 = _712;
    _713.w = 0.50588238239288330078125;
    float4 _725 = float4(_373.x, _373.y, _373.z, float4(0.0).w);
    _725.w = ((log2(((dot(_630, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_470 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_470 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_470 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_699.xyx * _699.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _695 * View.View_PreExposure;
    out.out_var_SV_Target1 = _709;
    out.out_var_SV_Target2 = _713;
    out.out_var_SV_Target3 = _725;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_437, 1.0, 1.0, 1.0);
    return out;
}

