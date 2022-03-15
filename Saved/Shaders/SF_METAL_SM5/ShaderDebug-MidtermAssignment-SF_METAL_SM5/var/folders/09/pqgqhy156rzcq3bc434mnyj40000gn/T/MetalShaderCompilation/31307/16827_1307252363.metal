

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
    spvUnsafeArray<float4, 4> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _148 = {};
constant float3 _149 = {};
constant float _151 = {};
constant float4 _152 = {};

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

fragment MainPS_out Main_000041bb_4deb168b(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _205 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _151, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _210 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _215 = (_210.xyz / float3(_210.w)) - View.View_PreViewTranslation;
    float3 _223 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _236 = fast::clamp(Material.Material_VectorExpressions[3].xyz, float3(0.0), float3(1.0));
    float _241 = (fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _242 = in.in_var_PRIMITIVE_ID * 36u;
    uint _243 = _242 + 20u;
    float _292;
    float _293;
    float _294;
    float3 _295;
    float3 _296;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _243)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _261 = ((_205.xy / float2(_205.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _265 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _261, level(0.0));
        float4 _268 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _261, level(0.0));
        float4 _271 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _261, level(0.0));
        float _281 = _271.w;
        float _287 = 0.5 * _281;
        _292 = (_241 * _281) + _271.z;
        _293 = _287 + _271.y;
        _294 = _287 + _271.x;
        _295 = (_236 * _265.w) + _265.xyz;
        _296 = normalize((_223 * _268.w) + ((_268.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _292 = _241;
        _293 = 0.5;
        _294 = 0.5;
        _295 = _236;
        _296 = _223;
    }
    bool _306 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _312;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _242 + 18u)].w > 0.0) && _306)
    {
        _312 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _312 = 1.0;
    }
    float _359;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _243)].z > 0.0)
    {
        float3 _327 = fast::clamp((_215 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _338 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_327.x), int(_327.y), int(_327.z), 0).xyz), 0));
        _359 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_338.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_327 / float3(_338.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _359 = _312;
    }
    float3 _373 = ((_295 - (_295 * _294)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _380 = (mix(float3(0.07999999821186065673828125 * _293), _295, float3(_294)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _383 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _388;
    if (_383)
    {
        _388 = _373 + (_380 * 0.449999988079071044921875);
    }
    else
    {
        _388 = _373;
    }
    float3 _390 = select(_380, float3(0.0), bool3(_383));
    float3 _392 = float3(dot(_390, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _478;
    if (_306)
    {
        float4 _428 = _152;
        _428.y = (-0.48860299587249755859375) * _296.y;
        float4 _431 = _428;
        _431.z = 0.48860299587249755859375 * _296.z;
        float4 _434 = _431;
        _434.w = (-0.48860299587249755859375) * _296.x;
        float3 _435 = _296 * _296;
        float4 _438 = _148;
        _438.x = (1.09254801273345947265625 * _296.x) * _296.y;
        float4 _441 = _438;
        _441.y = ((-1.09254801273345947265625) * _296.y) * _296.z;
        float4 _446 = _441;
        _446.z = 0.3153919875621795654296875 * ((3.0 * _435.z) - 1.0);
        float4 _449 = _446;
        _449.w = ((-1.09254801273345947265625) * _296.x) * _296.z;
        float4 _453 = _434;
        _453.x = 0.886227548122406005859375;
        float3 _455 = _453.yzw * 2.094395160675048828125;
        float4 _456 = float4(_453.x, _455.x, _455.y, _455.z);
        float4 _457 = _449 * 0.785398185253143310546875;
        float _458 = (_435.x - _435.y) * 0.4290426075458526611328125;
        float3 _464 = float3(0.0);
        _464.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _456) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _457)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _458);
        float3 _470 = _464;
        _470.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _456) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _457)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _458);
        float3 _476 = _470;
        _476.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _456) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _457)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _458);
        _478 = fast::max(float3(0.0), _476);
    }
    else
    {
        _478 = float3(0.0);
    }
    float _504;
    float _505;
    float3 _506;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _494;
        float _495;
        if (_306)
        {
            _494 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _495 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _494 = _296;
            _495 = 1.0;
        }
        float _496 = 1.0 - _495;
        float _498 = 1.0 - (_496 * _496);
        _504 = mix(fast::clamp(dot(_494, _296), 0.0, 1.0), 1.0, _498);
        _505 = _495;
        _506 = mix(_494, _296, float3(_498));
    }
    else
    {
        _504 = 1.0;
        _505 = 1.0;
        _506 = _296;
    }
    float4 _510 = float4(_506, 1.0);
    float3 _514 = _149;
    _514.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _510);
    float3 _518 = _514;
    _518.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _510);
    float3 _522 = _518;
    _522.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _510);
    float4 _525 = _510.xyzz * _510.yzzx;
    float3 _529 = _149;
    _529.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _525);
    float3 _533 = _529;
    _533.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _525);
    float3 _537 = _533;
    _537.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _525);
    float3 _552 = (_478 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_522 + _537) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_506.x * _506.x) - (_506.y * _506.y)))) * View.View_SkyLightColor.xyz) * (_505 * _504));
    float3 _574 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _603;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _602;
        if (any(abs(_215 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _242 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _242 + 19u)].xyz + float3(1.0))))
        {
            _602 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_215, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _602 = _574;
        }
        _603 = _602;
    }
    else
    {
        _603 = _574;
    }
    float4 _610 = float4(((mix(float3(0.0), _388 + (_390 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_552 * _388) * fast::max(float3(1.0), ((((((_295 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_295 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_295 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _603) * 1.0, 0.0);
    float4 _617;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _616 = _610;
        _616.w = 0.0;
        _617 = _616;
    }
    else
    {
        _617 = _610;
    }
    float2 _621 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _629 = (_296 * 0.5) + float3(0.5);
    float4 _631 = float4(_629.x, _629.y, _629.z, float4(0.0).w);
    _631.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _243)].y;
    float4 _632 = float4(0.0);
    _632.x = _294;
    float4 _633 = _632;
    _633.y = _293;
    float4 _634 = _633;
    _634.z = _292;
    float4 _635 = _634;
    _635.w = 0.50588238239288330078125;
    float4 _647 = float4(_295.x, _295.y, _295.z, float4(0.0).w);
    _647.w = ((log2(((dot(_552, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_392 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_392 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_392 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_621.xyx * _621.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _617 * View.View_PreExposure;
    out.out_var_SV_Target1 = _631;
    out.out_var_SV_Target2 = _635;
    out.out_var_SV_Target3 = _647;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_359, 1.0, 1.0, 1.0);
    return out;
}

