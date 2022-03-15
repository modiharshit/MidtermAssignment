

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

fragment MainPS_out Main_000041fd_f16fc5ee(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _205 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _151, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _210 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _215 = (_210.xyz / float3(_210.w)) - View.View_PreViewTranslation;
    float3 _223 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _238 = fast::clamp(Material.Material_VectorExpressions[3].xyz, float3(0.0), float3(1.0));
    float _239 = fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0);
    float _244 = (fast::clamp(Material.Material_ScalarExpressions[0].z, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _245 = in.in_var_PRIMITIVE_ID * 36u;
    uint _246 = _245 + 20u;
    float _296;
    float _297;
    float _298;
    float3 _299;
    float3 _300;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _246)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _264 = ((_205.xy / float2(_205.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _268 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _264, level(0.0));
        float4 _271 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _264, level(0.0));
        float4 _274 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _264, level(0.0));
        float _284 = _274.w;
        _296 = (_244 * _284) + _274.z;
        _297 = (0.5 * _284) + _274.y;
        _298 = (_239 * _284) + _274.x;
        _299 = (_238 * _268.w) + _268.xyz;
        _300 = normalize((_223 * _271.w) + ((_271.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _296 = _244;
        _297 = 0.5;
        _298 = _239;
        _299 = _238;
        _300 = _223;
    }
    bool _310 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _316;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _245 + 18u)].w > 0.0) && _310)
    {
        _316 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _316 = 1.0;
    }
    float _363;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _246)].z > 0.0)
    {
        float3 _331 = fast::clamp((_215 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _342 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_331.x), int(_331.y), int(_331.z), 0).xyz), 0));
        _363 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_342.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_331 / float3(_342.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _363 = _316;
    }
    float3 _377 = ((_299 - (_299 * _298)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _384 = (mix(float3(0.07999999821186065673828125 * _297), _299, float3(_298)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _387 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _392;
    if (_387)
    {
        _392 = _377 + (_384 * 0.449999988079071044921875);
    }
    else
    {
        _392 = _377;
    }
    float3 _394 = select(_384, float3(0.0), bool3(_387));
    float3 _396 = float3(dot(_394, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _482;
    if (_310)
    {
        float4 _432 = _152;
        _432.y = (-0.48860299587249755859375) * _300.y;
        float4 _435 = _432;
        _435.z = 0.48860299587249755859375 * _300.z;
        float4 _438 = _435;
        _438.w = (-0.48860299587249755859375) * _300.x;
        float3 _439 = _300 * _300;
        float4 _442 = _148;
        _442.x = (1.09254801273345947265625 * _300.x) * _300.y;
        float4 _445 = _442;
        _445.y = ((-1.09254801273345947265625) * _300.y) * _300.z;
        float4 _450 = _445;
        _450.z = 0.3153919875621795654296875 * ((3.0 * _439.z) - 1.0);
        float4 _453 = _450;
        _453.w = ((-1.09254801273345947265625) * _300.x) * _300.z;
        float4 _457 = _438;
        _457.x = 0.886227548122406005859375;
        float3 _459 = _457.yzw * 2.094395160675048828125;
        float4 _460 = float4(_457.x, _459.x, _459.y, _459.z);
        float4 _461 = _453 * 0.785398185253143310546875;
        float _462 = (_439.x - _439.y) * 0.4290426075458526611328125;
        float3 _468 = float3(0.0);
        _468.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _460) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _461)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _462);
        float3 _474 = _468;
        _474.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _460) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _461)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _462);
        float3 _480 = _474;
        _480.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _460) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _461)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _462);
        _482 = fast::max(float3(0.0), _480);
    }
    else
    {
        _482 = float3(0.0);
    }
    float _508;
    float _509;
    float3 _510;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _498;
        float _499;
        if (_310)
        {
            _498 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _499 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _498 = _300;
            _499 = 1.0;
        }
        float _500 = 1.0 - _499;
        float _502 = 1.0 - (_500 * _500);
        _508 = mix(fast::clamp(dot(_498, _300), 0.0, 1.0), 1.0, _502);
        _509 = _499;
        _510 = mix(_498, _300, float3(_502));
    }
    else
    {
        _508 = 1.0;
        _509 = 1.0;
        _510 = _300;
    }
    float4 _514 = float4(_510, 1.0);
    float3 _518 = _149;
    _518.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _514);
    float3 _522 = _518;
    _522.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _514);
    float3 _526 = _522;
    _526.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _514);
    float4 _529 = _514.xyzz * _514.yzzx;
    float3 _533 = _149;
    _533.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _529);
    float3 _537 = _533;
    _537.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _529);
    float3 _541 = _537;
    _541.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _529);
    float3 _556 = (_482 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_526 + _541) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_510.x * _510.x) - (_510.y * _510.y)))) * View.View_SkyLightColor.xyz) * (_509 * _508));
    float3 _578 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _607;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _606;
        if (any(abs(_215 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _245 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _245 + 19u)].xyz + float3(1.0))))
        {
            _606 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_215, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _606 = _578;
        }
        _607 = _606;
    }
    else
    {
        _607 = _578;
    }
    float4 _614 = float4(((mix(float3(0.0), _392 + (_394 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_556 * _392) * fast::max(float3(1.0), ((((((_299 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_299 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_299 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _607) * 1.0, 0.0);
    float4 _621;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _620 = _614;
        _620.w = 0.0;
        _621 = _620;
    }
    else
    {
        _621 = _614;
    }
    float2 _625 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _633 = (_300 * 0.5) + float3(0.5);
    float4 _635 = float4(_633.x, _633.y, _633.z, float4(0.0).w);
    _635.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _246)].y;
    float4 _636 = float4(0.0);
    _636.x = _298;
    float4 _637 = _636;
    _637.y = _297;
    float4 _638 = _637;
    _638.z = _296;
    float4 _639 = _638;
    _639.w = 0.50588238239288330078125;
    float4 _651 = float4(_299.x, _299.y, _299.z, float4(0.0).w);
    _651.w = ((log2(((dot(_556, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_396 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_396 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_396 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_625.xyx * _625.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _621 * View.View_PreExposure;
    out.out_var_SV_Target1 = _635;
    out.out_var_SV_Target2 = _639;
    out.out_var_SV_Target3 = _651;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_363, 1.0, 1.0, 1.0);
    return out;
}

