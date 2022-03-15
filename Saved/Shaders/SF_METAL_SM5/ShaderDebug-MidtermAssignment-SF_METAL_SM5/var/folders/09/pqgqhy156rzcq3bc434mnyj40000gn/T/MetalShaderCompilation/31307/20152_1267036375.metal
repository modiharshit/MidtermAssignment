

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
    char _m0_pad[448];
    float4x4 View_ViewToClip;
    char _m1_pad[192];
    float4x4 View_SVPositionToTranslatedWorld;
    char _m2_pad[272];
    float4 View_InvDeviceZToWorldZTransform;
    float4 View_ScreenPositionScaleBias;
    char _m4_pad[48];
    float3 View_PreViewTranslation;
    char _m5_pad[928];
    float4 View_ViewRectMin;
    float4 View_ViewSizeAndInvSize;
    char _m7_pad[68];
    float View_PreExposure;
    float4 View_DiffuseOverrideParameter;
    float4 View_SpecularOverrideParameter;
    float4 View_NormalOverrideParameter;
    float2 View_RoughnessOverrideParameter;
    char _m12_pad[8];
    float View_OutOfBoundsMask;
    char _m13_pad[48];
    float View_MaterialTextureMipBias;
    char _m14_pad[28];
    float View_UnlitViewmodeMask;
    char _m15_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m16_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m17_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m19_pad[124];
    float View_ShowDecalsMask;
    char _m20_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m21_pad[48];
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

constant float4 _174 = {};
constant float3 _175 = {};
constant float4 _177 = {};

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

fragment MainPS_out Main_00004eb8_4b8570d7(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], texture2d<float> Material_Texture2D_4 [[texture(9)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], sampler Material_Texture2D_4Sampler [[sampler(6)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _237 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _241 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _246 = (_241.xyz / float3(_241.w)) - View.View_PreViewTranslation;
    float2 _247 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5;
    float4 _253 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _247, bias(View.View_MaterialTextureMipBias));
    float2 _256 = (_253.xy * float2(2.0)) - float2(1.0);
    float3 _272 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_256, sqrt(fast::clamp(1.0 - dot(_256, _256), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _284 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (_247 * float2(0.25)), bias(View.View_MaterialTextureMipBias));
    float2 _287 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 2.0;
    float4 _292 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (_287 * 0.2134999930858612060546875), bias(View.View_MaterialTextureMipBias));
    float4 _297 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (_287 * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float _324;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _324 = _237.w;
                break;
            }
            else
            {
                float _308 = _237.z;
                _324 = ((_308 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_308 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float4 _332 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _335 = mix(_292.x + 0.5, _297.x + 0.5, fast::min(fast::max((_324 - 24.0) * 0.0009765625, 0.0), 1.0)) * (_332.x + 0.5);
    float4 _340 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _247, bias(View.View_MaterialTextureMipBias));
    float4 _353 = Material_Texture2D_4.sample(Material_Texture2D_4Sampler, _247, bias(View.View_MaterialTextureMipBias));
    float3 _359 = fast::clamp(fast::min(fast::max(((_340.xyz * mix(0.60000002384185791015625, 1.0, _335)) * mix(0.1500000059604644775390625, 0.699999988079071044921875, _284.x)) * Material.Material_VectorExpressions[3].xyz, float3(0.0)), float3(1.0)), float3(0.0), float3(1.0));
    float _360 = fast::clamp(_353.y, 0.0, 1.0);
    float _365 = (fast::clamp(mix(-0.300000011920928955078125, 1.0, _353.x + (_335 * 0.20000000298023223876953125)), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _366 = in.in_var_PRIMITIVE_ID * 36u;
    uint _367 = _366 + 20u;
    float _415;
    float _416;
    float _417;
    float3 _418;
    float3 _419;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _367)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _385 = ((_237.xy / float2(_237.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _389 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _385, level(0.0));
        float4 _392 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _385, level(0.0));
        float4 _395 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _385, level(0.0));
        float _405 = _395.w;
        _415 = (_365 * _405) + _395.z;
        _416 = (0.5 * _405) + _395.y;
        _417 = _395.x;
        _418 = (_359 * _389.w) + _389.xyz;
        _419 = normalize((_272 * _392.w) + ((_392.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _415 = _365;
        _416 = 0.5;
        _417 = 0.0;
        _418 = _359;
        _419 = _272;
    }
    bool _429 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _435;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _366 + 18u)].w > 0.0) && _429)
    {
        _435 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _435 = 1.0;
    }
    float _482;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _367)].z > 0.0)
    {
        float3 _450 = fast::clamp((_246 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _461 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_450.x), int(_450.y), int(_450.z), 0).xyz), 0));
        _482 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_461.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_450 / float3(_461.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _482 = _435;
    }
    float3 _496 = ((_418 - (_418 * _417)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _503 = (mix(float3(0.07999999821186065673828125 * _416), _418, float3(_417)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _506 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _511;
    if (_506)
    {
        _511 = _496 + (_503 * 0.449999988079071044921875);
    }
    else
    {
        _511 = _496;
    }
    float3 _513 = select(_503, float3(0.0), bool3(_506));
    float3 _515 = float3(dot(_513, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _522 = float3(_360);
    float3 _602;
    if (_429)
    {
        float4 _552 = _177;
        _552.y = (-0.48860299587249755859375) * _419.y;
        float4 _555 = _552;
        _555.z = 0.48860299587249755859375 * _419.z;
        float4 _558 = _555;
        _558.w = (-0.48860299587249755859375) * _419.x;
        float3 _559 = _419 * _419;
        float4 _562 = _174;
        _562.x = (1.09254801273345947265625 * _419.x) * _419.y;
        float4 _565 = _562;
        _565.y = ((-1.09254801273345947265625) * _419.y) * _419.z;
        float4 _570 = _565;
        _570.z = 0.3153919875621795654296875 * ((3.0 * _559.z) - 1.0);
        float4 _573 = _570;
        _573.w = ((-1.09254801273345947265625) * _419.x) * _419.z;
        float4 _577 = _558;
        _577.x = 0.886227548122406005859375;
        float3 _579 = _577.yzw * 2.094395160675048828125;
        float4 _580 = float4(_577.x, _579.x, _579.y, _579.z);
        float4 _581 = _573 * 0.785398185253143310546875;
        float _582 = (_559.x - _559.y) * 0.4290426075458526611328125;
        float3 _588 = float3(0.0);
        _588.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _580) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _581)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _582);
        float3 _594 = _588;
        _594.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _580) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _581)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _582);
        float3 _600 = _594;
        _600.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _580) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _581)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _582);
        _602 = fast::max(float3(0.0), _600);
    }
    else
    {
        _602 = float3(0.0);
    }
    float _628;
    float _629;
    float3 _630;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _618;
        float _619;
        if (_429)
        {
            _618 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _619 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _618 = _419;
            _619 = 1.0;
        }
        float _620 = 1.0 - _619;
        float _622 = 1.0 - (_620 * _620);
        _628 = mix(fast::clamp(dot(_618, _419), 0.0, 1.0), 1.0, _622);
        _629 = _619;
        _630 = mix(_618, _419, float3(_622));
    }
    else
    {
        _628 = 1.0;
        _629 = 1.0;
        _630 = _419;
    }
    float4 _634 = float4(_630, 1.0);
    float3 _638 = _175;
    _638.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _634);
    float3 _642 = _638;
    _642.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _634);
    float3 _646 = _642;
    _646.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _634);
    float4 _649 = _634.xyzz * _634.yzzx;
    float3 _653 = _175;
    _653.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _649);
    float3 _657 = _653;
    _657.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _649);
    float3 _661 = _657;
    _661.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _649);
    float3 _676 = (_602 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_646 + _661) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_630.x * _630.x) - (_630.y * _630.y)))) * View.View_SkyLightColor.xyz) * (_629 * _628));
    float3 _698 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _727;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _726;
        if (any(abs(_246 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _366 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _366 + 19u)].xyz + float3(1.0))))
        {
            _726 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_246, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _726 = _698;
        }
        _727 = _726;
    }
    else
    {
        _727 = _698;
    }
    float4 _734 = float4(((mix(float3(0.0), _511 + (_513 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_676 * _511) * fast::max(_522, ((((((_418 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _360) + ((_418 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _360) + ((_418 * 2.755199909210205078125) + float3(0.69029998779296875))) * _360))) + _727) * 1.0, 0.0);
    float4 _741;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _740 = _734;
        _740.w = 0.0;
        _741 = _740;
    }
    else
    {
        _741 = _734;
    }
    float2 _745 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _753 = (_419 * 0.5) + float3(0.5);
    float4 _755 = float4(_753.x, _753.y, _753.z, float4(0.0).w);
    _755.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _367)].y;
    float4 _756 = float4(0.0);
    _756.x = _417;
    float4 _757 = _756;
    _757.y = _416;
    float4 _758 = _757;
    _758.z = _415;
    float4 _759 = _758;
    _759.w = 0.50588238239288330078125;
    float4 _771 = float4(_418.x, _418.y, _418.z, float4(0.0).w);
    _771.w = ((log2(((dot(_676, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_522, ((((((_515 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _360) + ((_515 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _360) + ((_515 * 2.755199909210205078125) + float3(0.69029998779296875))) * _360).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_745.xyx * _745.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _741 * View.View_PreExposure;
    out.out_var_SV_Target1 = _755;
    out.out_var_SV_Target2 = _759;
    out.out_var_SV_Target3 = _771;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_482, 1.0, 1.0, 1.0);
    return out;
}

