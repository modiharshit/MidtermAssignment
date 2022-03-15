

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

constant float3 _164 = {};
constant float _166 = {};
constant float4 _167 = {};

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

fragment MainPS_out Main_00004bd6_445916d0(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], texture2d<float> Material_Texture2D_2 [[texture(10)]], texture2d<float> Material_Texture2D_3 [[texture(11)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], sampler Material_Texture2D_2Sampler [[sampler(5)]], sampler Material_Texture2D_3Sampler [[sampler(6)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float3x3 _213 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _224 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _166, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _229 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _233 = _229.xyz / float3(_229.w);
    float3 _234 = _233 - View.View_PreViewTranslation;
    float2 _238 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5;
    float4 _244 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _238, bias(View.View_MaterialTextureMipBias));
    float2 _250 = ((normalize(-_233) * _213).xy * ((0.00999999977648258209228515625 * _244.w) + (-0.008000000379979610443115234375))) + _238;
    float4 _254 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _250, bias(View.View_MaterialTextureMipBias));
    float2 _257 = (_254.xy * float2(2.0)) - float2(1.0);
    float3 _273 = normalize(_213 * normalize((float4(_257, sqrt(fast::clamp(1.0 - dot(_257, _257), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _285 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _290 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _295 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _299 = (_285.x + 0.5) * ((_290.x + 0.5) * (_295.x + 0.5));
    float4 _302 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _250, bias(View.View_MaterialTextureMipBias));
    float4 _308 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _250, bias(View.View_MaterialTextureMipBias));
    float3 _313 = fast::clamp(_302.xyz * mix(0.5, 1.0, _299), float3(0.0), float3(1.0));
    float _314 = fast::clamp(_308.y, 0.0, 1.0);
    float _319 = (fast::clamp(mix(0.300000011920928955078125, 0.800000011920928955078125, _299 * _308.x), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _320 = in.in_var_PRIMITIVE_ID * 36u;
    uint _321 = _320 + 20u;
    float _369;
    float _370;
    float _371;
    float3 _372;
    float3 _373;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _321)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _339 = ((_224.xy / float2(_224.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _343 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _339, level(0.0));
        float4 _346 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _339, level(0.0));
        float4 _349 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _339, level(0.0));
        float _359 = _349.w;
        _369 = (_319 * _359) + _349.z;
        _370 = (0.5 * _359) + _349.y;
        _371 = _349.x;
        _372 = (_313 * _343.w) + _343.xyz;
        _373 = normalize((_273 * _346.w) + ((_346.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _369 = _319;
        _370 = 0.5;
        _371 = 0.0;
        _372 = _313;
        _373 = _273;
    }
    bool _383 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _389;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _320 + 18u)].w > 0.0) && _383)
    {
        _389 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _389 = 1.0;
    }
    float _436;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _321)].z > 0.0)
    {
        float3 _404 = fast::clamp((_234 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _415 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_404.x), int(_404.y), int(_404.z), 0).xyz), 0));
        _436 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_415.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_404 / float3(_415.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _436 = _389;
    }
    float3 _450 = ((_372 - (_372 * _371)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _457 = (mix(float3(0.07999999821186065673828125 * _370), _372, float3(_371)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _460 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _465;
    if (_460)
    {
        _465 = _450 + (_457 * 0.449999988079071044921875);
    }
    else
    {
        _465 = _450;
    }
    float3 _467 = select(_457, float3(0.0), bool3(_460));
    float3 _469 = float3(dot(_467, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _476 = float3(_314);
    float3 _544;
    if (_383)
    {
        float3 _496 = fast::clamp((_234 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _500 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _496);
        float4 _504 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _496);
        float4 _507 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _496);
        float4 _525 = _167;
        _525.y = (-0.48860299587249755859375) * _373.y;
        float4 _528 = _525;
        _528.z = 0.48860299587249755859375 * _373.z;
        float4 _531 = _528;
        _531.w = (-0.48860299587249755859375) * _373.x;
        float4 _532 = _531;
        _532.x = 0.886227548122406005859375;
        float3 _534 = _532.yzw * 2.094395160675048828125;
        float4 _535 = float4(_532.x, _534.x, _534.y, _534.z);
        float3 _537 = float3(0.0);
        _537.x = dot(float4(_500.x, _504.x, _507.x, _500.w), _535);
        float3 _539 = _537;
        _539.y = dot(float4(_500.y, _504.y, _507.y, _504.w), _535);
        float3 _541 = _539;
        _541.z = dot(float4(_500.z, _504.z, _507.zw), _535);
        _544 = fast::max(float3(0.0), _541) * float3(0.3183098733425140380859375);
    }
    else
    {
        _544 = float3(0.0);
    }
    float _570;
    float _571;
    float3 _572;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _560;
        float _561;
        if (_383)
        {
            _560 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _561 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _560 = _373;
            _561 = 1.0;
        }
        float _562 = 1.0 - _561;
        float _564 = 1.0 - (_562 * _562);
        _570 = mix(fast::clamp(dot(_560, _373), 0.0, 1.0), 1.0, _564);
        _571 = _561;
        _572 = mix(_560, _373, float3(_564));
    }
    else
    {
        _570 = 1.0;
        _571 = 1.0;
        _572 = _373;
    }
    float4 _576 = float4(_572, 1.0);
    float3 _580 = _164;
    _580.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _576);
    float3 _584 = _580;
    _584.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _576);
    float3 _588 = _584;
    _588.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _576);
    float4 _591 = _576.xyzz * _576.yzzx;
    float3 _595 = _164;
    _595.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _591);
    float3 _599 = _595;
    _599.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _591);
    float3 _603 = _599;
    _603.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _591);
    float3 _618 = (_544 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_588 + _603) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_572.x * _572.x) - (_572.y * _572.y)))) * View.View_SkyLightColor.xyz) * (_571 * _570));
    float3 _640 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _669;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _668;
        if (any(abs(_234 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _320 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _320 + 19u)].xyz + float3(1.0))))
        {
            _668 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_234, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _668 = _640;
        }
        _669 = _668;
    }
    else
    {
        _669 = _640;
    }
    float4 _676 = float4(((mix(float3(0.0), _465 + (_467 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_618 * _465) * fast::max(_476, ((((((_372 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _314) + ((_372 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _314) + ((_372 * 2.755199909210205078125) + float3(0.69029998779296875))) * _314))) + _669) * 1.0, 0.0);
    float4 _683;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _682 = _676;
        _682.w = 0.0;
        _683 = _682;
    }
    else
    {
        _683 = _676;
    }
    float2 _687 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _695 = (_373 * 0.5) + float3(0.5);
    float4 _697 = float4(_695.x, _695.y, _695.z, float4(0.0).w);
    _697.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _321)].y;
    float4 _698 = float4(0.0);
    _698.x = _371;
    float4 _699 = _698;
    _699.y = _370;
    float4 _700 = _699;
    _700.z = _369;
    float4 _701 = _700;
    _701.w = 0.50588238239288330078125;
    float4 _713 = float4(_372.x, _372.y, _372.z, float4(0.0).w);
    _713.w = ((log2(((dot(_618, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_476, ((((((_469 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _314) + ((_469 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _314) + ((_469 * 2.755199909210205078125) + float3(0.69029998779296875))) * _314).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_687.xyx * _687.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _683 * View.View_PreExposure;
    out.out_var_SV_Target1 = _697;
    out.out_var_SV_Target2 = _701;
    out.out_var_SV_Target3 = _713;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_436, 1.0, 1.0, 1.0);
    return out;
}

