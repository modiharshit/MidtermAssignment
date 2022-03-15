

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
    char _m1_pad[352];
    float3 View_PreViewTranslation;
    char _m2_pad[1028];
    float View_PreExposure;
    float4 View_DiffuseOverrideParameter;
    float4 View_SpecularOverrideParameter;
    float4 View_NormalOverrideParameter;
    float2 View_RoughnessOverrideParameter;
    char _m7_pad[8];
    float View_OutOfBoundsMask;
    char _m8_pad[48];
    float View_MaterialTextureMipBias;
    char _m9_pad[28];
    float View_UnlitViewmodeMask;
    char _m10_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m11_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m12_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m14_pad[312];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m15_pad[48];
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

struct type_Primitive
{
    char _m0_pad[80];
    float4 Primitive_ObjectWorldPositionAndRadius;
    char _m1_pad[204];
    float Primitive_UseSingleSampleShadowFromStationaryLights;
    float3 Primitive_ObjectBounds;
    char _m3_pad[4];
    float Primitive_PerObjectGBufferData;
    float Primitive_UseVolumetricLightmapShadowFromStationaryLights;
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

constant float4 _162 = {};
constant float3 _163 = {};
constant float4 _165 = {};

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
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00004270_c49ea827(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> Material_Texture2D_0 [[texture(2)]], texture2d<float> Material_Texture2D_1 [[texture(3)]], texture2d<float> Material_Texture2D_2 [[texture(4)]], texture2d<float> Material_Texture2D_3 [[texture(5)]], sampler View_MaterialTextureBilinearWrapedSampler [[sampler(0)]], sampler View_SharedBilinearClampedSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _205 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _210 = (_205.xyz / float3(_205.w)) - View.View_PreViewTranslation;
    float4 _216 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _219 = (_216.xy * float2(2.0)) - float2(1.0);
    float _223 = sqrt(fast::clamp(1.0 - dot(_219, _219), 0.0, 1.0));
    float3 _231 = float3(float4(_219, _223, 1.0).xy * (-1.0), _223);
    float3 _235 = (float3(0.0, 0.0, 2.0) * dot(float3(0.0, 0.0, 2.0), _231)) - (_231 * 2.0);
    float3 _247 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize(((_235 / float3(sqrt(dot(_235, _235)))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _251 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _269 = Material_Texture2D_2.sample(View_MaterialTextureBilinearWrapedSampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 8.0));
    float3 _273 = float3(_251.x);
    float4 _278 = Material_Texture2D_3.sample(View_MaterialTextureBilinearWrapedSampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 50.0));
    float3 _282 = float3(_251.z);
    float3 _296 = fast::clamp(mix(mix(mix(Material.Material_VectorExpressions[3].xyz, Material.Material_VectorExpressions[3].xyz, float3(_251.y)), _269.xyz * float3(0.25), _273), _278.xyz * float3(0.2249999940395355224609375), _282), float3(0.0), float3(1.0));
    float _297 = fast::clamp(mix(mix(float3(0.0), float3(1.0), _273), float3(0.0), _282).x, 0.0, 1.0);
    bool _310 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _316;
    if ((Primitive.Primitive_UseSingleSampleShadowFromStationaryLights > 0.0) && _310)
    {
        _316 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _316 = 1.0;
    }
    float _363;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _331 = fast::clamp((_210 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _342 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_331.x), int(_331.y), int(_331.z), 0).xyz), 0));
        _363 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_342.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_331 / float3(_342.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _363 = _316;
    }
    float3 _375 = ((_296 - (_296 * _297)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _382 = (mix(float3(0.039999999105930328369140625), _296, float3(_297)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
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
    if (_310)
    {
        float _428 = _247.y;
        float4 _430 = _165;
        _430.y = (-0.48860299587249755859375) * _428;
        float _431 = _247.z;
        float4 _433 = _430;
        _433.z = 0.48860299587249755859375 * _431;
        float _434 = _247.x;
        float4 _436 = _433;
        _436.w = (-0.48860299587249755859375) * _434;
        float3 _437 = _247 * _247;
        float4 _440 = _162;
        _440.x = (1.09254801273345947265625 * _434) * _428;
        float4 _443 = _440;
        _443.y = ((-1.09254801273345947265625) * _428) * _431;
        float4 _448 = _443;
        _448.z = 0.3153919875621795654296875 * ((3.0 * _437.z) - 1.0);
        float4 _451 = _448;
        _451.w = ((-1.09254801273345947265625) * _434) * _431;
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
        if (_310)
        {
            _496 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _497 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _496 = _247;
            _497 = 1.0;
        }
        float _498 = 1.0 - _497;
        float _500 = 1.0 - (_498 * _498);
        _506 = mix(fast::clamp(dot(_496, _247), 0.0, 1.0), 1.0, _500);
        _507 = _497;
        _508 = mix(_496, _247, float3(_500));
    }
    else
    {
        _506 = 1.0;
        _507 = 1.0;
        _508 = _247;
    }
    float4 _512 = float4(_508, 1.0);
    float3 _516 = _163;
    _516.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _512);
    float3 _520 = _516;
    _520.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _512);
    float3 _524 = _520;
    _524.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _512);
    float4 _527 = _512.xyzz * _512.yzzx;
    float3 _531 = _163;
    _531.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _527);
    float3 _535 = _531;
    _535.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _527);
    float3 _539 = _535;
    _539.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _527);
    float3 _554 = (_480 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_524 + _539) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_508.x * _508.x) - (_508.y * _508.y)))) * View.View_SkyLightColor.xyz) * (_507 * _506));
    float3 _576 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _602;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _601;
        if (any(abs(_210 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _601 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_210, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _601 = _576;
        }
        _602 = _601;
    }
    else
    {
        _602 = _576;
    }
    float4 _609 = float4(((mix(float3(0.0), _390 + (_392 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_554 * _390) * fast::max(float3(1.0), ((((((_296 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_296 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_296 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _602) * 1.0, 0.0);
    float4 _616;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _615 = _609;
        _615.w = 0.0;
        _616 = _615;
    }
    else
    {
        _616 = _609;
    }
    float2 _621 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _629 = (_247 * 0.5) + float3(0.5);
    float4 _631 = float4(_629.x, _629.y, _629.z, float4(0.0).w);
    _631.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _632 = float4(0.0);
    _632.x = _297;
    float4 _633 = _632;
    _633.y = 0.5;
    float4 _634 = _633;
    _634.z = (fast::clamp(mix(mix(float3(0.100000001490116119384765625), float3(mix(0.37999999523162841796875, 0.550000011920928955078125, _269.x)), _273), float3(mix(0.550000011920928955078125, 0.75, _278.x)), _282).x, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float4 _635 = _634;
    _635.w = 0.50588238239288330078125;
    float4 _647 = float4(_296.x, _296.y, _296.z, float4(0.0).w);
    _647.w = ((log2(((dot(_554, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_394 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_394 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_394 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_621.xyx * _621.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _616 * View.View_PreExposure;
    out.out_var_SV_Target1 = _631;
    out.out_var_SV_Target2 = _635;
    out.out_var_SV_Target3 = _647;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_363, 1.0, 1.0, 1.0);
    return out;
}

