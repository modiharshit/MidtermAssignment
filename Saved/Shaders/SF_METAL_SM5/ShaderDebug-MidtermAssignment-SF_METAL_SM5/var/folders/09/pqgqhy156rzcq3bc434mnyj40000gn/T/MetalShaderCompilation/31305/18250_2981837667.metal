

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
    spvUnsafeArray<float4, 8> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float3 _160 = {};
constant float _162 = {};
constant float4 _163 = {};

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

fragment MainPS_out Main_0000474a_b1bb3b63(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _219 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _162, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _224 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _229 = (_224.xyz / float3(_224.w)) - View.View_PreViewTranslation;
    float4 _235 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _238 = (_235.xy * float2(2.0)) - float2(1.0);
    float3 _254 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_238, sqrt(fast::clamp(1.0 - dot(_238, _238), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _265 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _272 = _265.z;
    float _278 = _265.y;
    float3 _292 = fast::clamp(mix(mix(Material.Material_VectorExpressions[4].xyz, Material.Material_VectorExpressions[5].xyz, float3(_272)), Material.Material_VectorExpressions[7].xyz, float3(_278)) * _265.x, float3(0.0), float3(1.0));
    float _293 = fast::clamp(mix(0.0, 1.0, _278), 0.0, 1.0);
    float _298 = (fast::clamp(mix(mix(Material.Material_ScalarExpressions[0].y, Material.Material_ScalarExpressions[0].z, _272), Material.Material_ScalarExpressions[0].w, _278), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _299 = in.in_var_PRIMITIVE_ID * 36u;
    uint _300 = _299 + 20u;
    float _350;
    float _351;
    float _352;
    float3 _353;
    float3 _354;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _300)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _318 = ((_219.xy / float2(_219.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _322 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _318, level(0.0));
        float4 _325 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _318, level(0.0));
        float4 _328 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _318, level(0.0));
        float _338 = _328.w;
        _350 = (_298 * _338) + _328.z;
        _351 = (0.5 * _338) + _328.y;
        _352 = (_293 * _338) + _328.x;
        _353 = (_292 * _322.w) + _322.xyz;
        _354 = normalize((_254 * _325.w) + ((_325.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _350 = _298;
        _351 = 0.5;
        _352 = _293;
        _353 = _292;
        _354 = _254;
    }
    bool _364 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _370;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _299 + 18u)].w > 0.0) && _364)
    {
        _370 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _370 = 1.0;
    }
    float _417;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _300)].z > 0.0)
    {
        float3 _385 = fast::clamp((_229 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _396 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_385.x), int(_385.y), int(_385.z), 0).xyz), 0));
        _417 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_396.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_385 / float3(_396.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _417 = _370;
    }
    float3 _431 = ((_353 - (_353 * _352)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _438 = (mix(float3(0.07999999821186065673828125 * _351), _353, float3(_352)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _441 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _446;
    if (_441)
    {
        _446 = _431 + (_438 * 0.449999988079071044921875);
    }
    else
    {
        _446 = _431;
    }
    float3 _448 = select(_438, float3(0.0), bool3(_441));
    float3 _450 = float3(dot(_448, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _524;
    if (_364)
    {
        float3 _476 = fast::clamp((_229 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _480 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _476);
        float4 _484 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _476);
        float4 _487 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _476);
        float4 _505 = _163;
        _505.y = (-0.48860299587249755859375) * _354.y;
        float4 _508 = _505;
        _508.z = 0.48860299587249755859375 * _354.z;
        float4 _511 = _508;
        _511.w = (-0.48860299587249755859375) * _354.x;
        float4 _512 = _511;
        _512.x = 0.886227548122406005859375;
        float3 _514 = _512.yzw * 2.094395160675048828125;
        float4 _515 = float4(_512.x, _514.x, _514.y, _514.z);
        float3 _517 = float3(0.0);
        _517.x = dot(float4(_480.x, _484.x, _487.x, _480.w), _515);
        float3 _519 = _517;
        _519.y = dot(float4(_480.y, _484.y, _487.y, _484.w), _515);
        float3 _521 = _519;
        _521.z = dot(float4(_480.z, _484.z, _487.zw), _515);
        _524 = fast::max(float3(0.0), _521) * float3(0.3183098733425140380859375);
    }
    else
    {
        _524 = float3(0.0);
    }
    float _550;
    float _551;
    float3 _552;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _540;
        float _541;
        if (_364)
        {
            _540 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _541 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _540 = _354;
            _541 = 1.0;
        }
        float _542 = 1.0 - _541;
        float _544 = 1.0 - (_542 * _542);
        _550 = mix(fast::clamp(dot(_540, _354), 0.0, 1.0), 1.0, _544);
        _551 = _541;
        _552 = mix(_540, _354, float3(_544));
    }
    else
    {
        _550 = 1.0;
        _551 = 1.0;
        _552 = _354;
    }
    float4 _556 = float4(_552, 1.0);
    float3 _560 = _160;
    _560.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _556);
    float3 _564 = _560;
    _564.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _556);
    float3 _568 = _564;
    _568.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _556);
    float4 _571 = _556.xyzz * _556.yzzx;
    float3 _575 = _160;
    _575.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _571);
    float3 _579 = _575;
    _579.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _571);
    float3 _583 = _579;
    _583.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _571);
    float3 _598 = (_524 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_568 + _583) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_552.x * _552.x) - (_552.y * _552.y)))) * View.View_SkyLightColor.xyz) * (_551 * _550));
    float3 _620 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _649;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _648;
        if (any(abs(_229 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _299 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _299 + 19u)].xyz + float3(1.0))))
        {
            _648 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_229, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _648 = _620;
        }
        _649 = _648;
    }
    else
    {
        _649 = _620;
    }
    float4 _656 = float4(((mix(float3(0.0), _446 + (_448 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_598 * _446) * fast::max(float3(1.0), ((((((_353 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_353 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_353 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _649) * 1.0, 0.0);
    float4 _663;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _662 = _656;
        _662.w = 0.0;
        _663 = _662;
    }
    else
    {
        _663 = _656;
    }
    float2 _667 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _675 = (_354 * 0.5) + float3(0.5);
    float4 _677 = float4(_675.x, _675.y, _675.z, float4(0.0).w);
    _677.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _300)].y;
    float4 _678 = float4(0.0);
    _678.x = _352;
    float4 _679 = _678;
    _679.y = _351;
    float4 _680 = _679;
    _680.z = _350;
    float4 _681 = _680;
    _681.w = 0.50588238239288330078125;
    float4 _693 = float4(_353.x, _353.y, _353.z, float4(0.0).w);
    _693.w = ((log2(((dot(_598, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_450 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_450 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_450 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_667.xyx * _667.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _663 * View.View_PreExposure;
    out.out_var_SV_Target1 = _677;
    out.out_var_SV_Target2 = _681;
    out.out_var_SV_Target3 = _693;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_417, 1.0, 1.0, 1.0);
    return out;
}

