

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
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _173 = {};
constant float3 _174 = {};
constant float4 _176 = {};

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

fragment MainPS_out Main_00004ef2_1bed65a8(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _236 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _240 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _245 = (_240.xyz / float3(_240.w)) - View.View_PreViewTranslation;
    float2 _246 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.300000011920928955078125;
    float4 _252 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _246, bias(View.View_MaterialTextureMipBias));
    float2 _255 = (_252.xy * float2(2.0)) - float2(1.0);
    float2 _263 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.20000000298023223876953125;
    float4 _265 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _263, bias(View.View_MaterialTextureMipBias));
    float2 _268 = (_265.xy * float2(2.0)) - float2(1.0);
    float4 _280 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.008000000379979610443115234375), bias(View.View_MaterialTextureMipBias));
    float4 _285 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.004999999888241291046142578125), bias(View.View_MaterialTextureMipBias));
    float _287 = (_280.x + 0.5) * _285.x;
    float _289 = fast::min(fast::max(_287, 0.0), 1.0);
    float3 _292 = float3(_289);
    float4 _298 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _325;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _325 = _236.w;
                break;
            }
            else
            {
                float _309 = _236.z;
                _325 = ((_309 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_309 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _340 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(mix(float4(_255, sqrt(fast::clamp(1.0 - dot(_255, _255), 0.0, 1.0)), 1.0).xyz, float4(_268, sqrt(fast::clamp(1.0 - dot(_268, _268), 0.0, 1.0)), 1.0).xyz, _292), float3(0.0, 0.0, 1.0), float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _298.x) + _325) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _352 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _246, bias(View.View_MaterialTextureMipBias));
    float4 _354 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _263, bias(View.View_MaterialTextureMipBias));
    float3 _364 = fast::clamp(mix(_352.xyz, _354.xyz, _292) * mix(0.60000002384185791015625, 1.0, _287), float3(0.0), float3(1.0));
    float _369 = (fast::clamp(mix(0.949999988079071044921875, 0.699999988079071044921875, _287 * mix(_352.w, _354.w, _289)), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _370 = in.in_var_PRIMITIVE_ID * 36u;
    uint _371 = _370 + 20u;
    float _419;
    float _420;
    float _421;
    float3 _422;
    float3 _423;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _371)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _389 = ((_236.xy / float2(_236.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _393 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _389, level(0.0));
        float4 _396 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _389, level(0.0));
        float4 _399 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _389, level(0.0));
        float _409 = _399.w;
        _419 = (_369 * _409) + _399.z;
        _420 = (0.5 * _409) + _399.y;
        _421 = _399.x;
        _422 = (_364 * _393.w) + _393.xyz;
        _423 = normalize((_340 * _396.w) + ((_396.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _419 = _369;
        _420 = 0.5;
        _421 = 0.0;
        _422 = _364;
        _423 = _340;
    }
    bool _433 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _439;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _370 + 18u)].w > 0.0) && _433)
    {
        _439 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _439 = 1.0;
    }
    float _486;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _371)].z > 0.0)
    {
        float3 _454 = fast::clamp((_245 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _465 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_454.x), int(_454.y), int(_454.z), 0).xyz), 0));
        _486 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_465.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_454 / float3(_465.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _486 = _439;
    }
    float3 _500 = ((_422 - (_422 * _421)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _507 = (mix(float3(0.07999999821186065673828125 * _420), _422, float3(_421)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _510 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _515;
    if (_510)
    {
        _515 = _500 + (_507 * 0.449999988079071044921875);
    }
    else
    {
        _515 = _500;
    }
    float3 _517 = select(_507, float3(0.0), bool3(_510));
    float3 _519 = float3(dot(_517, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _605;
    if (_433)
    {
        float4 _555 = _176;
        _555.y = (-0.48860299587249755859375) * _423.y;
        float4 _558 = _555;
        _558.z = 0.48860299587249755859375 * _423.z;
        float4 _561 = _558;
        _561.w = (-0.48860299587249755859375) * _423.x;
        float3 _562 = _423 * _423;
        float4 _565 = _173;
        _565.x = (1.09254801273345947265625 * _423.x) * _423.y;
        float4 _568 = _565;
        _568.y = ((-1.09254801273345947265625) * _423.y) * _423.z;
        float4 _573 = _568;
        _573.z = 0.3153919875621795654296875 * ((3.0 * _562.z) - 1.0);
        float4 _576 = _573;
        _576.w = ((-1.09254801273345947265625) * _423.x) * _423.z;
        float4 _580 = _561;
        _580.x = 0.886227548122406005859375;
        float3 _582 = _580.yzw * 2.094395160675048828125;
        float4 _583 = float4(_580.x, _582.x, _582.y, _582.z);
        float4 _584 = _576 * 0.785398185253143310546875;
        float _585 = (_562.x - _562.y) * 0.4290426075458526611328125;
        float3 _591 = float3(0.0);
        _591.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _583) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _584)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _585);
        float3 _597 = _591;
        _597.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _583) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _584)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _585);
        float3 _603 = _597;
        _603.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _583) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _584)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _585);
        _605 = fast::max(float3(0.0), _603);
    }
    else
    {
        _605 = float3(0.0);
    }
    float _631;
    float _632;
    float3 _633;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _621;
        float _622;
        if (_433)
        {
            _621 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _622 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _621 = _423;
            _622 = 1.0;
        }
        float _623 = 1.0 - _622;
        float _625 = 1.0 - (_623 * _623);
        _631 = mix(fast::clamp(dot(_621, _423), 0.0, 1.0), 1.0, _625);
        _632 = _622;
        _633 = mix(_621, _423, float3(_625));
    }
    else
    {
        _631 = 1.0;
        _632 = 1.0;
        _633 = _423;
    }
    float4 _637 = float4(_633, 1.0);
    float3 _641 = _174;
    _641.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _637);
    float3 _645 = _641;
    _645.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _637);
    float3 _649 = _645;
    _649.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _637);
    float4 _652 = _637.xyzz * _637.yzzx;
    float3 _656 = _174;
    _656.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _652);
    float3 _660 = _656;
    _660.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _652);
    float3 _664 = _660;
    _664.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _652);
    float3 _679 = (_605 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_649 + _664) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_633.x * _633.x) - (_633.y * _633.y)))) * View.View_SkyLightColor.xyz) * (_632 * _631));
    float3 _701 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _730;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _729;
        if (any(abs(_245 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _370 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _370 + 19u)].xyz + float3(1.0))))
        {
            _729 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_245, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _729 = _701;
        }
        _730 = _729;
    }
    else
    {
        _730 = _701;
    }
    float4 _737 = float4(((mix(float3(0.0), _515 + (_517 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_679 * _515) * fast::max(float3(1.0), ((((((_422 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_422 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_422 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _730) * 1.0, 0.0);
    float4 _744;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _743 = _737;
        _743.w = 0.0;
        _744 = _743;
    }
    else
    {
        _744 = _737;
    }
    float2 _748 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _756 = (_423 * 0.5) + float3(0.5);
    float4 _758 = float4(_756.x, _756.y, _756.z, float4(0.0).w);
    _758.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _371)].y;
    float4 _759 = float4(0.0);
    _759.x = _421;
    float4 _760 = _759;
    _760.y = _420;
    float4 _761 = _760;
    _761.z = _419;
    float4 _762 = _761;
    _762.w = 0.50588238239288330078125;
    float4 _774 = float4(_422.x, _422.y, _422.z, float4(0.0).w);
    _774.w = ((log2(((dot(_679, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_519 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_519 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_519 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_748.xyx * _748.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _744 * View.View_PreExposure;
    out.out_var_SV_Target1 = _758;
    out.out_var_SV_Target2 = _762;
    out.out_var_SV_Target3 = _774;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_486, 1.0, 1.0, 1.0);
    return out;
}

