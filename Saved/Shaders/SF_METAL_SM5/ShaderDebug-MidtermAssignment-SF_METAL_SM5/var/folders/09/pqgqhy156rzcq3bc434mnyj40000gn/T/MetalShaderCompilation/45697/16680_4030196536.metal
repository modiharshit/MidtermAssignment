

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
    char _m11_pad[80];
    float View_UnlitViewmodeMask;
    char _m12_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m13_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m14_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m16_pad[124];
    float View_ShowDecalsMask;
    char _m17_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m18_pad[48];
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

constant float4 _149 = {};
constant float3 _150 = {};
constant float _152 = {};
constant float4 _153 = {};

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

fragment MainPS_out Main_00004128_f037eb38(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _206 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _152, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _211 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _216 = (_211.xyz / float3(_211.w)) - View.View_PreViewTranslation;
    float3 _224 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float _235 = (0.100000001490116119384765625 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _236 = in.in_var_PRIMITIVE_ID * 36u;
    uint _237 = _236 + 20u;
    float _286;
    float _287;
    float _288;
    float3 _289;
    float3 _290;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _237)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _255 = ((_206.xy / float2(_206.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _259 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _255, level(0.0));
        float4 _262 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _255, level(0.0));
        float4 _265 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _255, level(0.0));
        float _275 = _265.w;
        _286 = (_235 * _275) + _265.z;
        _287 = (0.5 * _275) + _265.y;
        _288 = _275 + _265.x;
        _289 = (float3(1.0) * _259.w) + _259.xyz;
        _290 = normalize((_224 * _262.w) + ((_262.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _286 = _235;
        _287 = 0.5;
        _288 = 1.0;
        _289 = float3(1.0);
        _290 = _224;
    }
    bool _300 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _306;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _236 + 18u)].w > 0.0) && _300)
    {
        _306 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _306 = 1.0;
    }
    float _353;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _237)].z > 0.0)
    {
        float3 _321 = fast::clamp((_216 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _332 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_321.x), int(_321.y), int(_321.z), 0).xyz), 0));
        _353 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_332.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_321 / float3(_332.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _353 = _306;
    }
    float3 _367 = ((_289 - (_289 * _288)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _374 = (mix(float3(0.07999999821186065673828125 * _287), _289, float3(_288)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _377 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _382;
    if (_377)
    {
        _382 = _367 + (_374 * 0.449999988079071044921875);
    }
    else
    {
        _382 = _367;
    }
    float3 _384 = select(_374, float3(0.0), bool3(_377));
    float3 _386 = float3(dot(_384, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _472;
    if (_300)
    {
        float4 _422 = _153;
        _422.y = (-0.48860299587249755859375) * _290.y;
        float4 _425 = _422;
        _425.z = 0.48860299587249755859375 * _290.z;
        float4 _428 = _425;
        _428.w = (-0.48860299587249755859375) * _290.x;
        float3 _429 = _290 * _290;
        float4 _432 = _149;
        _432.x = (1.09254801273345947265625 * _290.x) * _290.y;
        float4 _435 = _432;
        _435.y = ((-1.09254801273345947265625) * _290.y) * _290.z;
        float4 _440 = _435;
        _440.z = 0.3153919875621795654296875 * ((3.0 * _429.z) - 1.0);
        float4 _443 = _440;
        _443.w = ((-1.09254801273345947265625) * _290.x) * _290.z;
        float4 _447 = _428;
        _447.x = 0.886227548122406005859375;
        float3 _449 = _447.yzw * 2.094395160675048828125;
        float4 _450 = float4(_447.x, _449.x, _449.y, _449.z);
        float4 _451 = _443 * 0.785398185253143310546875;
        float _452 = (_429.x - _429.y) * 0.4290426075458526611328125;
        float3 _458 = float3(0.0);
        _458.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _450) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _451)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _452);
        float3 _464 = _458;
        _464.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _450) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _451)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _452);
        float3 _470 = _464;
        _470.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _450) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _451)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _452);
        _472 = fast::max(float3(0.0), _470);
    }
    else
    {
        _472 = float3(0.0);
    }
    float _498;
    float _499;
    float3 _500;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _488;
        float _489;
        if (_300)
        {
            _488 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _489 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _488 = _290;
            _489 = 1.0;
        }
        float _490 = 1.0 - _489;
        float _492 = 1.0 - (_490 * _490);
        _498 = mix(fast::clamp(dot(_488, _290), 0.0, 1.0), 1.0, _492);
        _499 = _489;
        _500 = mix(_488, _290, float3(_492));
    }
    else
    {
        _498 = 1.0;
        _499 = 1.0;
        _500 = _290;
    }
    float4 _504 = float4(_500, 1.0);
    float3 _508 = _150;
    _508.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _504);
    float3 _512 = _508;
    _512.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _504);
    float3 _516 = _512;
    _516.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _504);
    float4 _519 = _504.xyzz * _504.yzzx;
    float3 _523 = _150;
    _523.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _519);
    float3 _527 = _523;
    _527.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _519);
    float3 _531 = _527;
    _531.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _519);
    float3 _546 = (_472 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_516 + _531) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_500.x * _500.x) - (_500.y * _500.y)))) * View.View_SkyLightColor.xyz) * (_499 * _498));
    float3 _568 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _597;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _596;
        if (any(abs(_216 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _236 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _236 + 19u)].xyz + float3(1.0))))
        {
            _596 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_216, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _596 = _568;
        }
        _597 = _596;
    }
    else
    {
        _597 = _568;
    }
    float4 _604 = float4(((mix(float3(0.0), _382 + (_384 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_546 * _382) * fast::max(float3(1.0), ((((((_289 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_289 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_289 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _597) * 1.0, 0.0);
    float4 _611;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _610 = _604;
        _610.w = 0.0;
        _611 = _610;
    }
    else
    {
        _611 = _604;
    }
    float2 _615 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _623 = (_290 * 0.5) + float3(0.5);
    float4 _625 = float4(_623.x, _623.y, _623.z, float4(0.0).w);
    _625.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _237)].y;
    float4 _626 = float4(0.0);
    _626.x = _288;
    float4 _627 = _626;
    _627.y = _287;
    float4 _628 = _627;
    _628.z = _286;
    float4 _629 = _628;
    _629.w = 0.50588238239288330078125;
    float4 _641 = float4(_289.x, _289.y, _289.z, float4(0.0).w);
    _641.w = ((log2(((dot(_546, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_386 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_386 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_386 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_615.xyx * _615.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _611 * View.View_PreExposure;
    out.out_var_SV_Target1 = _625;
    out.out_var_SV_Target2 = _629;
    out.out_var_SV_Target3 = _641;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_353, 1.0, 1.0, 1.0);
    return out;
}

