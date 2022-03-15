

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

fragment MainPS_out Main_000042d6_b0c94cf1(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> Material_Texture2D_0 [[texture(2)]], texture2d<float> Material_Texture2D_1 [[texture(3)]], texture2d<float> Material_Texture2D_2 [[texture(4)]], texture2d<float> Material_Texture2D_3 [[texture(5)]], sampler View_MaterialTextureBilinearWrapedSampler [[sampler(0)]], sampler View_SharedBilinearClampedSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
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
    float4 _269 = Material_Texture2D_2.sample(View_MaterialTextureBilinearWrapedSampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 50.0));
    float3 _273 = float3(_251.x);
    float4 _278 = Material_Texture2D_3.sample(View_MaterialTextureBilinearWrapedSampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 8.0));
    float3 _282 = float3(_251.z);
    float3 _285 = float3(_251.w);
    float3 _300 = fast::clamp(mix(mix(mix(mix(Material.Material_VectorExpressions[3].xyz, Material.Material_VectorExpressions[3].xyz, float3(_251.y)), _269.xyz * float3(0.2249999940395355224609375), _273), _278.xyz * float3(0.25), _282), float3(0.0), _285), float3(0.0), float3(1.0));
    float _301 = fast::clamp(mix(mix(float3(0.0), float3(1.0), _282), float3(0.0), _285).x, 0.0, 1.0);
    bool _314 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _320;
    if ((Primitive.Primitive_UseSingleSampleShadowFromStationaryLights > 0.0) && _314)
    {
        _320 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _320 = 1.0;
    }
    float _367;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _335 = fast::clamp((_210 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _346 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_335.x), int(_335.y), int(_335.z), 0).xyz), 0));
        _367 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_346.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_335 / float3(_346.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _367 = _320;
    }
    float3 _379 = ((_300 - (_300 * _301)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _386 = (mix(float3(0.039999999105930328369140625), _300, float3(_301)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _389 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _394;
    if (_389)
    {
        _394 = _379 + (_386 * 0.449999988079071044921875);
    }
    else
    {
        _394 = _379;
    }
    float3 _396 = select(_386, float3(0.0), bool3(_389));
    float3 _398 = float3(dot(_396, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _484;
    if (_314)
    {
        float _432 = _247.y;
        float4 _434 = _165;
        _434.y = (-0.48860299587249755859375) * _432;
        float _435 = _247.z;
        float4 _437 = _434;
        _437.z = 0.48860299587249755859375 * _435;
        float _438 = _247.x;
        float4 _440 = _437;
        _440.w = (-0.48860299587249755859375) * _438;
        float3 _441 = _247 * _247;
        float4 _444 = _162;
        _444.x = (1.09254801273345947265625 * _438) * _432;
        float4 _447 = _444;
        _447.y = ((-1.09254801273345947265625) * _432) * _435;
        float4 _452 = _447;
        _452.z = 0.3153919875621795654296875 * ((3.0 * _441.z) - 1.0);
        float4 _455 = _452;
        _455.w = ((-1.09254801273345947265625) * _438) * _435;
        float4 _459 = _440;
        _459.x = 0.886227548122406005859375;
        float3 _461 = _459.yzw * 2.094395160675048828125;
        float4 _462 = float4(_459.x, _461.x, _461.y, _461.z);
        float4 _463 = _455 * 0.785398185253143310546875;
        float _464 = (_441.x - _441.y) * 0.4290426075458526611328125;
        float3 _470 = float3(0.0);
        _470.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _462) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _463)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _464);
        float3 _476 = _470;
        _476.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _462) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _463)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _464);
        float3 _482 = _476;
        _482.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _462) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _463)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _464);
        _484 = fast::max(float3(0.0), _482);
    }
    else
    {
        _484 = float3(0.0);
    }
    float _510;
    float _511;
    float3 _512;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _500;
        float _501;
        if (_314)
        {
            _500 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _501 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _500 = _247;
            _501 = 1.0;
        }
        float _502 = 1.0 - _501;
        float _504 = 1.0 - (_502 * _502);
        _510 = mix(fast::clamp(dot(_500, _247), 0.0, 1.0), 1.0, _504);
        _511 = _501;
        _512 = mix(_500, _247, float3(_504));
    }
    else
    {
        _510 = 1.0;
        _511 = 1.0;
        _512 = _247;
    }
    float4 _516 = float4(_512, 1.0);
    float3 _520 = _163;
    _520.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _516);
    float3 _524 = _520;
    _524.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _516);
    float3 _528 = _524;
    _528.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _516);
    float4 _531 = _516.xyzz * _516.yzzx;
    float3 _535 = _163;
    _535.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _531);
    float3 _539 = _535;
    _539.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _531);
    float3 _543 = _539;
    _543.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _531);
    float3 _558 = (_484 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_528 + _543) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_512.x * _512.x) - (_512.y * _512.y)))) * View.View_SkyLightColor.xyz) * (_511 * _510));
    float3 _580 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _606;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _605;
        if (any(abs(_210 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _605 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_210, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _605 = _580;
        }
        _606 = _605;
    }
    else
    {
        _606 = _580;
    }
    float4 _613 = float4(((mix(float3(0.0), _394 + (_396 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_558 * _394) * fast::max(float3(1.0), ((((((_300 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_300 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_300 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _606) * 1.0, 0.0);
    float4 _620;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _619 = _613;
        _619.w = 0.0;
        _620 = _619;
    }
    else
    {
        _620 = _613;
    }
    float2 _625 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _633 = (_247 * 0.5) + float3(0.5);
    float4 _635 = float4(_633.x, _633.y, _633.z, float4(0.0).w);
    _635.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _636 = float4(0.0);
    _636.x = _301;
    float4 _637 = _636;
    _637.y = 0.5;
    float4 _638 = _637;
    _638.z = (fast::clamp(mix(mix(mix(float3(0.100000001490116119384765625), float3(mix(0.550000011920928955078125, 0.75, _269.x)), _273), float3(mix(0.37999999523162841796875, 0.550000011920928955078125, _278.x)), _282), float3(0.100000001490116119384765625), _285).x, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float4 _639 = _638;
    _639.w = 0.50588238239288330078125;
    float4 _651 = float4(_300.x, _300.y, _300.z, float4(0.0).w);
    _651.w = ((log2(((dot(_558, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_398 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_398 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_398 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_625.xyx * _625.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _620 * View.View_PreExposure;
    out.out_var_SV_Target1 = _635;
    out.out_var_SV_Target2 = _639;
    out.out_var_SV_Target3 = _651;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_367, 1.0, 1.0, 1.0);
    return out;
}

