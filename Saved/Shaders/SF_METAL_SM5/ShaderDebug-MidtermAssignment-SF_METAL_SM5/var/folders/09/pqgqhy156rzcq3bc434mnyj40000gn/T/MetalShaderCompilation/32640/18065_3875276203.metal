

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
    spvUnsafeArray<float4, 4> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float3 _156 = {};
constant float _158 = {};
constant float4 _159 = {};

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

fragment MainPS_out Main_00004691_e6fc05ab(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _216 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _158, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _221 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _226 = (_221.xyz / float3(_221.w)) - View.View_PreViewTranslation;
    float4 _232 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _235 = (_232.xy * float2(2.0)) - float2(1.0);
    float3 _251 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_235, sqrt(fast::clamp(1.0 - dot(_235, _235), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _262 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _266 = _262.x;
    float3 _275 = fast::clamp(Material.Material_VectorExpressions[3].xyz * _266, float3(0.0), float3(1.0));
    float _276 = fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0);
    float _281 = (fast::clamp(mix(Material.Material_ScalarExpressions[0].z, Material.Material_ScalarExpressions[0].w, _266), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _282 = in.in_var_PRIMITIVE_ID * 36u;
    uint _283 = _282 + 20u;
    float _333;
    float _334;
    float _335;
    float3 _336;
    float3 _337;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _283)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _301 = ((_216.xy / float2(_216.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _305 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _301, level(0.0));
        float4 _308 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _301, level(0.0));
        float4 _311 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _301, level(0.0));
        float _321 = _311.w;
        _333 = (_281 * _321) + _311.z;
        _334 = (0.5 * _321) + _311.y;
        _335 = (_276 * _321) + _311.x;
        _336 = (_275 * _305.w) + _305.xyz;
        _337 = normalize((_251 * _308.w) + ((_308.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _333 = _281;
        _334 = 0.5;
        _335 = _276;
        _336 = _275;
        _337 = _251;
    }
    bool _347 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _353;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _282 + 18u)].w > 0.0) && _347)
    {
        _353 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _353 = 1.0;
    }
    float _400;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _283)].z > 0.0)
    {
        float3 _368 = fast::clamp((_226 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _379 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_368.x), int(_368.y), int(_368.z), 0).xyz), 0));
        _400 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_379.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_368 / float3(_379.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _400 = _353;
    }
    float3 _414 = ((_336 - (_336 * _335)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _421 = (mix(float3(0.07999999821186065673828125 * _334), _336, float3(_335)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _424 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _429;
    if (_424)
    {
        _429 = _414 + (_421 * 0.449999988079071044921875);
    }
    else
    {
        _429 = _414;
    }
    float3 _431 = select(_421, float3(0.0), bool3(_424));
    float3 _433 = float3(dot(_431, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _507;
    if (_347)
    {
        float3 _459 = fast::clamp((_226 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _463 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _459);
        float4 _467 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _459);
        float4 _470 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _459);
        float4 _488 = _159;
        _488.y = (-0.48860299587249755859375) * _337.y;
        float4 _491 = _488;
        _491.z = 0.48860299587249755859375 * _337.z;
        float4 _494 = _491;
        _494.w = (-0.48860299587249755859375) * _337.x;
        float4 _495 = _494;
        _495.x = 0.886227548122406005859375;
        float3 _497 = _495.yzw * 2.094395160675048828125;
        float4 _498 = float4(_495.x, _497.x, _497.y, _497.z);
        float3 _500 = float3(0.0);
        _500.x = dot(float4(_463.x, _467.x, _470.x, _463.w), _498);
        float3 _502 = _500;
        _502.y = dot(float4(_463.y, _467.y, _470.y, _467.w), _498);
        float3 _504 = _502;
        _504.z = dot(float4(_463.z, _467.z, _470.zw), _498);
        _507 = fast::max(float3(0.0), _504) * float3(0.3183098733425140380859375);
    }
    else
    {
        _507 = float3(0.0);
    }
    float _533;
    float _534;
    float3 _535;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _523;
        float _524;
        if (_347)
        {
            _523 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _524 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _523 = _337;
            _524 = 1.0;
        }
        float _525 = 1.0 - _524;
        float _527 = 1.0 - (_525 * _525);
        _533 = mix(fast::clamp(dot(_523, _337), 0.0, 1.0), 1.0, _527);
        _534 = _524;
        _535 = mix(_523, _337, float3(_527));
    }
    else
    {
        _533 = 1.0;
        _534 = 1.0;
        _535 = _337;
    }
    float4 _539 = float4(_535, 1.0);
    float3 _543 = _156;
    _543.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _539);
    float3 _547 = _543;
    _547.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _539);
    float3 _551 = _547;
    _551.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _539);
    float4 _554 = _539.xyzz * _539.yzzx;
    float3 _558 = _156;
    _558.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _554);
    float3 _562 = _558;
    _562.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _554);
    float3 _566 = _562;
    _566.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _554);
    float3 _581 = (_507 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_551 + _566) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_535.x * _535.x) - (_535.y * _535.y)))) * View.View_SkyLightColor.xyz) * (_534 * _533));
    float3 _603 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _632;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _631;
        if (any(abs(_226 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _282 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _282 + 19u)].xyz + float3(1.0))))
        {
            _631 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_226, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _631 = _603;
        }
        _632 = _631;
    }
    else
    {
        _632 = _603;
    }
    float4 _639 = float4(((mix(float3(0.0), _429 + (_431 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_581 * _429) * fast::max(float3(1.0), ((((((_336 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_336 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_336 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _632) * 1.0, 0.0);
    float4 _646;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _645 = _639;
        _645.w = 0.0;
        _646 = _645;
    }
    else
    {
        _646 = _639;
    }
    float2 _650 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _658 = (_337 * 0.5) + float3(0.5);
    float4 _660 = float4(_658.x, _658.y, _658.z, float4(0.0).w);
    _660.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _283)].y;
    float4 _661 = float4(0.0);
    _661.x = _335;
    float4 _662 = _661;
    _662.y = _334;
    float4 _663 = _662;
    _663.z = _333;
    float4 _664 = _663;
    _664.w = 0.50588238239288330078125;
    float4 _676 = float4(_336.x, _336.y, _336.z, float4(0.0).w);
    _676.w = ((log2(((dot(_581, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_433 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_433 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_433 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_650.xyx * _650.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _646 * View.View_PreExposure;
    out.out_var_SV_Target1 = _660;
    out.out_var_SV_Target2 = _664;
    out.out_var_SV_Target3 = _676;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_400, 1.0, 1.0, 1.0);
    return out;
}

