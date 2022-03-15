

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

constant float4 _154 = {};
constant float3 _155 = {};
constant float _157 = {};
constant float4 _158 = {};

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

fragment MainPS_out Main_00004365_fa758235(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _215 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _157, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _220 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _225 = (_220.xyz / float3(_220.w)) - View.View_PreViewTranslation;
    float3 _233 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _246 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _248 = fast::clamp(_246.xyz, float3(0.0), float3(1.0));
    float _252 = (0.5 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _253 = in.in_var_PRIMITIVE_ID * 36u;
    uint _254 = _253 + 20u;
    float _302;
    float _303;
    float _304;
    float3 _305;
    float3 _306;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _254)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _272 = ((_215.xy / float2(_215.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _276 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _272, level(0.0));
        float4 _279 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _272, level(0.0));
        float4 _282 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _272, level(0.0));
        float _292 = _282.w;
        _302 = (_252 * _292) + _282.z;
        _303 = (0.5 * _292) + _282.y;
        _304 = _282.x;
        _305 = (_248 * _276.w) + _276.xyz;
        _306 = normalize((_233 * _279.w) + ((_279.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _302 = _252;
        _303 = 0.5;
        _304 = 0.0;
        _305 = _248;
        _306 = _233;
    }
    bool _316 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _322;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _253 + 18u)].w > 0.0) && _316)
    {
        _322 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _322 = 1.0;
    }
    float _369;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _254)].z > 0.0)
    {
        float3 _337 = fast::clamp((_225 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _348 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_337.x), int(_337.y), int(_337.z), 0).xyz), 0));
        _369 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_348.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_337 / float3(_348.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _369 = _322;
    }
    float3 _383 = ((_305 - (_305 * _304)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _390 = (mix(float3(0.07999999821186065673828125 * _303), _305, float3(_304)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _393 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _398;
    if (_393)
    {
        _398 = _383 + (_390 * 0.449999988079071044921875);
    }
    else
    {
        _398 = _383;
    }
    float3 _400 = select(_390, float3(0.0), bool3(_393));
    float3 _402 = float3(dot(_400, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _488;
    if (_316)
    {
        float4 _438 = _158;
        _438.y = (-0.48860299587249755859375) * _306.y;
        float4 _441 = _438;
        _441.z = 0.48860299587249755859375 * _306.z;
        float4 _444 = _441;
        _444.w = (-0.48860299587249755859375) * _306.x;
        float3 _445 = _306 * _306;
        float4 _448 = _154;
        _448.x = (1.09254801273345947265625 * _306.x) * _306.y;
        float4 _451 = _448;
        _451.y = ((-1.09254801273345947265625) * _306.y) * _306.z;
        float4 _456 = _451;
        _456.z = 0.3153919875621795654296875 * ((3.0 * _445.z) - 1.0);
        float4 _459 = _456;
        _459.w = ((-1.09254801273345947265625) * _306.x) * _306.z;
        float4 _463 = _444;
        _463.x = 0.886227548122406005859375;
        float3 _465 = _463.yzw * 2.094395160675048828125;
        float4 _466 = float4(_463.x, _465.x, _465.y, _465.z);
        float4 _467 = _459 * 0.785398185253143310546875;
        float _468 = (_445.x - _445.y) * 0.4290426075458526611328125;
        float3 _474 = float3(0.0);
        _474.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _466) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _467)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _468);
        float3 _480 = _474;
        _480.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _466) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _467)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _468);
        float3 _486 = _480;
        _486.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _466) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _467)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _468);
        _488 = fast::max(float3(0.0), _486);
    }
    else
    {
        _488 = float3(0.0);
    }
    float _514;
    float _515;
    float3 _516;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _504;
        float _505;
        if (_316)
        {
            _504 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _505 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _504 = _306;
            _505 = 1.0;
        }
        float _506 = 1.0 - _505;
        float _508 = 1.0 - (_506 * _506);
        _514 = mix(fast::clamp(dot(_504, _306), 0.0, 1.0), 1.0, _508);
        _515 = _505;
        _516 = mix(_504, _306, float3(_508));
    }
    else
    {
        _514 = 1.0;
        _515 = 1.0;
        _516 = _306;
    }
    float4 _520 = float4(_516, 1.0);
    float3 _524 = _155;
    _524.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _520);
    float3 _528 = _524;
    _528.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _520);
    float3 _532 = _528;
    _532.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _520);
    float4 _535 = _520.xyzz * _520.yzzx;
    float3 _539 = _155;
    _539.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _535);
    float3 _543 = _539;
    _543.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _535);
    float3 _547 = _543;
    _547.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _535);
    float3 _562 = (_488 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_532 + _547) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_516.x * _516.x) - (_516.y * _516.y)))) * View.View_SkyLightColor.xyz) * (_515 * _514));
    float3 _584 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _613;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _612;
        if (any(abs(_225 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _253 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _253 + 19u)].xyz + float3(1.0))))
        {
            _612 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_225, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _612 = _584;
        }
        _613 = _612;
    }
    else
    {
        _613 = _584;
    }
    float4 _620 = float4(((mix(float3(0.0), _398 + (_400 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_562 * _398) * fast::max(float3(1.0), ((((((_305 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_305 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_305 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _613) * 1.0, 0.0);
    float4 _627;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _626 = _620;
        _626.w = 0.0;
        _627 = _626;
    }
    else
    {
        _627 = _620;
    }
    float2 _631 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _639 = (_306 * 0.5) + float3(0.5);
    float4 _641 = float4(_639.x, _639.y, _639.z, float4(0.0).w);
    _641.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _254)].y;
    float4 _642 = float4(0.0);
    _642.x = _304;
    float4 _643 = _642;
    _643.y = _303;
    float4 _644 = _643;
    _644.z = _302;
    float4 _645 = _644;
    _645.w = 0.50588238239288330078125;
    float4 _657 = float4(_305.x, _305.y, _305.z, float4(0.0).w);
    _657.w = ((log2(((dot(_562, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_402 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_402 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_402 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_631.xyx * _631.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _627 * View.View_PreExposure;
    out.out_var_SV_Target1 = _641;
    out.out_var_SV_Target2 = _645;
    out.out_var_SV_Target3 = _657;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_369, 1.0, 1.0, 1.0);
    return out;
}

