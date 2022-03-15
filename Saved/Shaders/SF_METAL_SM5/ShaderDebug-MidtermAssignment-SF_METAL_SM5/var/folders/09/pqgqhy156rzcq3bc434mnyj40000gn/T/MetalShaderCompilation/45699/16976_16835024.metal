

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
    char _m11_pad[24];
    float View_CullingSign;
    char _m12_pad[52];
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

constant float4 _150 = {};
constant float3 _151 = {};
constant float _153 = {};
constant float4 _154 = {};

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
    float4 in_var_COLOR0 [[user(locn2)]];
    uint in_var_PRIMITIVE_ID [[user(locn3)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00004250_0100e1d0(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]], bool gl_FrontFacing [[front_facing]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _212 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _153, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _217 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _222 = (_217.xyz / float3(_217.w)) - View.View_PreViewTranslation;
    uint _223 = in.in_var_PRIMITIVE_ID * 36u;
    float3 _239 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * ((View.View_CullingSign * View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _223 + 4u)].w) * float(gl_FrontFacing ? 1 : (-1)));
    float3 _248 = fast::clamp(in.in_var_COLOR0.xyz, float3(0.0), float3(1.0));
    float _252 = (0.5 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _253 = _223 + 20u;
    float _299;
    float _300;
    float _301;
    float3 _302;
    float3 _303;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _253)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _271 = ((_212.xy / float2(_212.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _275 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _271, level(0.0));
        float4 _278 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _271, level(0.0));
        float4 _281 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _271, level(0.0));
        _299 = (_252 * _281.w) + _281.z;
        _300 = _281.y;
        _301 = _281.x;
        _302 = (_248 * _275.w) + _275.xyz;
        _303 = normalize((_239 * _278.w) + ((_278.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _299 = _252;
        _300 = 0.0;
        _301 = 0.0;
        _302 = _248;
        _303 = _239;
    }
    bool _313 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _319;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _223 + 18u)].w > 0.0) && _313)
    {
        _319 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _319 = 1.0;
    }
    float _366;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _253)].z > 0.0)
    {
        float3 _334 = fast::clamp((_222 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _345 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_334.x), int(_334.y), int(_334.z), 0).xyz), 0));
        _366 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_345.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_334 / float3(_345.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _366 = _319;
    }
    float3 _380 = ((_302 - (_302 * _301)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _387 = (mix(float3(0.07999999821186065673828125 * _300), _302, float3(_301)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _390 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _395;
    if (_390)
    {
        _395 = _380 + (_387 * 0.449999988079071044921875);
    }
    else
    {
        _395 = _380;
    }
    float3 _397 = select(_387, float3(0.0), bool3(_390));
    float3 _399 = float3(dot(_397, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _485;
    if (_313)
    {
        float4 _435 = _154;
        _435.y = (-0.48860299587249755859375) * _303.y;
        float4 _438 = _435;
        _438.z = 0.48860299587249755859375 * _303.z;
        float4 _441 = _438;
        _441.w = (-0.48860299587249755859375) * _303.x;
        float3 _442 = _303 * _303;
        float4 _445 = _150;
        _445.x = (1.09254801273345947265625 * _303.x) * _303.y;
        float4 _448 = _445;
        _448.y = ((-1.09254801273345947265625) * _303.y) * _303.z;
        float4 _453 = _448;
        _453.z = 0.3153919875621795654296875 * ((3.0 * _442.z) - 1.0);
        float4 _456 = _453;
        _456.w = ((-1.09254801273345947265625) * _303.x) * _303.z;
        float4 _460 = _441;
        _460.x = 0.886227548122406005859375;
        float3 _462 = _460.yzw * 2.094395160675048828125;
        float4 _463 = float4(_460.x, _462.x, _462.y, _462.z);
        float4 _464 = _456 * 0.785398185253143310546875;
        float _465 = (_442.x - _442.y) * 0.4290426075458526611328125;
        float3 _471 = float3(0.0);
        _471.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _463) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _464)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _465);
        float3 _477 = _471;
        _477.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _463) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _464)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _465);
        float3 _483 = _477;
        _483.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _463) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _464)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _465);
        _485 = fast::max(float3(0.0), _483);
    }
    else
    {
        _485 = float3(0.0);
    }
    float _511;
    float _512;
    float3 _513;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _501;
        float _502;
        if (_313)
        {
            _501 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _502 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _501 = _303;
            _502 = 1.0;
        }
        float _503 = 1.0 - _502;
        float _505 = 1.0 - (_503 * _503);
        _511 = mix(fast::clamp(dot(_501, _303), 0.0, 1.0), 1.0, _505);
        _512 = _502;
        _513 = mix(_501, _303, float3(_505));
    }
    else
    {
        _511 = 1.0;
        _512 = 1.0;
        _513 = _303;
    }
    float4 _517 = float4(_513, 1.0);
    float3 _521 = _151;
    _521.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _517);
    float3 _525 = _521;
    _525.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _517);
    float3 _529 = _525;
    _529.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _517);
    float4 _532 = _517.xyzz * _517.yzzx;
    float3 _536 = _151;
    _536.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _532);
    float3 _540 = _536;
    _540.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _532);
    float3 _544 = _540;
    _544.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _532);
    float3 _559 = (_485 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_529 + _544) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_513.x * _513.x) - (_513.y * _513.y)))) * View.View_SkyLightColor.xyz) * (_512 * _511));
    float3 _581 = fast::max(mix(in.in_var_COLOR0.xyz, Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _610;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _609;
        if (any(abs(_222 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _223 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _223 + 19u)].xyz + float3(1.0))))
        {
            _609 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_222, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _609 = _581;
        }
        _610 = _609;
    }
    else
    {
        _610 = _581;
    }
    float4 _617 = float4(((mix(float3(0.0), _395 + (_397 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_559 * _395) * fast::max(float3(1.0), ((((((_302 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_302 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_302 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _610) * 1.0, 0.0);
    float4 _624;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _623 = _617;
        _623.w = 0.0;
        _624 = _623;
    }
    else
    {
        _624 = _617;
    }
    float2 _628 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _636 = (_303 * 0.5) + float3(0.5);
    float4 _638 = float4(_636.x, _636.y, _636.z, float4(0.0).w);
    _638.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _253)].y;
    float4 _639 = float4(0.0);
    _639.x = _301;
    float4 _640 = _639;
    _640.y = _300;
    float4 _641 = _640;
    _641.z = _299;
    float4 _642 = _641;
    _642.w = 0.50588238239288330078125;
    float4 _654 = float4(_302.x, _302.y, _302.z, float4(0.0).w);
    _654.w = ((log2(((dot(_559, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_399 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_399 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_399 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_628.xyx * _628.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _624 * View.View_PreExposure;
    out.out_var_SV_Target1 = _638;
    out.out_var_SV_Target2 = _642;
    out.out_var_SV_Target3 = _654;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_366, 1.0, 1.0, 1.0);
    return out;
}

