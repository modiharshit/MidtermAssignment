

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

fragment MainPS_out Main_000041e9_bcb2d832(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
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
    float _294;
    float _295;
    float _296;
    float3 _297;
    float3 _298;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _246)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _264 = ((_205.xy / float2(_205.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _268 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _264, level(0.0));
        float4 _271 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _264, level(0.0));
        float4 _274 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _264, level(0.0));
        float _284 = _274.w;
        _294 = (_244 * _284) + _274.z;
        _295 = (_239 * _284) + _274.y;
        _296 = _274.x;
        _297 = (_238 * _268.w) + _268.xyz;
        _298 = normalize((_223 * _271.w) + ((_271.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _294 = _244;
        _295 = _239;
        _296 = 0.0;
        _297 = _238;
        _298 = _223;
    }
    bool _308 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _314;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _245 + 18u)].w > 0.0) && _308)
    {
        _314 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _314 = 1.0;
    }
    float _361;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _246)].z > 0.0)
    {
        float3 _329 = fast::clamp((_215 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _340 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_329.x), int(_329.y), int(_329.z), 0).xyz), 0));
        _361 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_340.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_329 / float3(_340.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _361 = _314;
    }
    float3 _375 = ((_297 - (_297 * _296)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _382 = (mix(float3(0.07999999821186065673828125 * _295), _297, float3(_296)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _385 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _390;
    if (_385)
    {
        _390 = _375 + (_382 * 0.449999988079071044921875);
    }
    else
    {
        _390 = _375;
    }
    float3 _392 = select(_382, float3(0.0), bool3(_385));
    float3 _394 = float3(dot(_392, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _480;
    if (_308)
    {
        float4 _430 = _152;
        _430.y = (-0.48860299587249755859375) * _298.y;
        float4 _433 = _430;
        _433.z = 0.48860299587249755859375 * _298.z;
        float4 _436 = _433;
        _436.w = (-0.48860299587249755859375) * _298.x;
        float3 _437 = _298 * _298;
        float4 _440 = _148;
        _440.x = (1.09254801273345947265625 * _298.x) * _298.y;
        float4 _443 = _440;
        _443.y = ((-1.09254801273345947265625) * _298.y) * _298.z;
        float4 _448 = _443;
        _448.z = 0.3153919875621795654296875 * ((3.0 * _437.z) - 1.0);
        float4 _451 = _448;
        _451.w = ((-1.09254801273345947265625) * _298.x) * _298.z;
        float4 _455 = _436;
        _455.x = 0.886227548122406005859375;
        float3 _457 = _455.yzw * 2.094395160675048828125;
        float4 _458 = float4(_455.x, _457.x, _457.y, _457.z);
        float4 _459 = _451 * 0.785398185253143310546875;
        float _460 = (_437.x - _437.y) * 0.4290426075458526611328125;
        float3 _466 = float3(0.0);
        _466.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _458) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _459)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _460);
        float3 _472 = _466;
        _472.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _458) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _459)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _460);
        float3 _478 = _472;
        _478.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _458) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _459)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _460);
        _480 = fast::max(float3(0.0), _478);
    }
    else
    {
        _480 = float3(0.0);
    }
    float _506;
    float _507;
    float3 _508;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _496;
        float _497;
        if (_308)
        {
            _496 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _497 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _496 = _298;
            _497 = 1.0;
        }
        float _498 = 1.0 - _497;
        float _500 = 1.0 - (_498 * _498);
        _506 = mix(fast::clamp(dot(_496, _298), 0.0, 1.0), 1.0, _500);
        _507 = _497;
        _508 = mix(_496, _298, float3(_500));
    }
    else
    {
        _506 = 1.0;
        _507 = 1.0;
        _508 = _298;
    }
    float4 _512 = float4(_508, 1.0);
    float3 _516 = _149;
    _516.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _512);
    float3 _520 = _516;
    _520.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _512);
    float3 _524 = _520;
    _524.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _512);
    float4 _527 = _512.xyzz * _512.yzzx;
    float3 _531 = _149;
    _531.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _527);
    float3 _535 = _531;
    _535.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _527);
    float3 _539 = _535;
    _539.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _527);
    float3 _554 = (_480 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_524 + _539) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_508.x * _508.x) - (_508.y * _508.y)))) * View.View_SkyLightColor.xyz) * (_507 * _506));
    float3 _576 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _605;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _604;
        if (any(abs(_215 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _245 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _245 + 19u)].xyz + float3(1.0))))
        {
            _604 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_215, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _604 = _576;
        }
        _605 = _604;
    }
    else
    {
        _605 = _576;
    }
    float4 _612 = float4(((mix(float3(0.0), _390 + (_392 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_554 * _390) * fast::max(float3(1.0), ((((((_297 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_297 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_297 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _605) * 1.0, 0.0);
    float4 _619;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _618 = _612;
        _618.w = 0.0;
        _619 = _618;
    }
    else
    {
        _619 = _612;
    }
    float2 _623 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _631 = (_298 * 0.5) + float3(0.5);
    float4 _633 = float4(_631.x, _631.y, _631.z, float4(0.0).w);
    _633.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _246)].y;
    float4 _634 = float4(0.0);
    _634.x = _296;
    float4 _635 = _634;
    _635.y = _295;
    float4 _636 = _635;
    _636.z = _294;
    float4 _637 = _636;
    _637.w = 0.50588238239288330078125;
    float4 _649 = float4(_297.x, _297.y, _297.z, float4(0.0).w);
    _649.w = ((log2(((dot(_554, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_394 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_394 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_394 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_623.xyx * _623.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _619 * View.View_PreExposure;
    out.out_var_SV_Target1 = _633;
    out.out_var_SV_Target2 = _637;
    out.out_var_SV_Target3 = _649;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_361, 1.0, 1.0, 1.0);
    return out;
}

