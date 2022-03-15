

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

constant float4 _171 = {};
constant float3 _172 = {};
constant float4 _174 = {};

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

fragment MainPS_out Main_00004d6b_2b7d06b9(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _234 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _238 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _243 = (_238.xyz / float3(_238.w)) - View.View_PreViewTranslation;
    float4 _249 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _252 = (_249.xy * float2(2.0)) - float2(1.0);
    float4 _264 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _291;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _291 = _234.w;
                break;
            }
            else
            {
                float _275 = _234.z;
                _291 = ((_275 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_275 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _307 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(float4(_252, sqrt(fast::clamp(1.0 - dot(_252, _252), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _264.x) + _291) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _319 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _324 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _329 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _333 = (_319.x + 0.5) * ((_324.x + 0.5) * (_329.x + 0.5));
    float4 _339 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _345 = fast::clamp(mix(float3(0.300000011920928955078125), float3(1.0), float3(_333)) * _339.xyz, float3(0.0), float3(1.0));
    float _350 = (fast::clamp(mix(0.5, 0.20000000298023223876953125, _333 * _339.w), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _351 = in.in_var_PRIMITIVE_ID * 36u;
    uint _352 = _351 + 20u;
    float _400;
    float _401;
    float _402;
    float3 _403;
    float3 _404;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _352)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _370 = ((_234.xy / float2(_234.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _374 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _370, level(0.0));
        float4 _377 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _370, level(0.0));
        float4 _380 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _370, level(0.0));
        float _390 = _380.w;
        _400 = (_350 * _390) + _380.z;
        _401 = (0.5 * _390) + _380.y;
        _402 = _380.x;
        _403 = (_345 * _374.w) + _374.xyz;
        _404 = normalize((_307 * _377.w) + ((_377.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _400 = _350;
        _401 = 0.5;
        _402 = 0.0;
        _403 = _345;
        _404 = _307;
    }
    bool _414 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _420;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _351 + 18u)].w > 0.0) && _414)
    {
        _420 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _420 = 1.0;
    }
    float _467;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _352)].z > 0.0)
    {
        float3 _435 = fast::clamp((_243 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _446 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_435.x), int(_435.y), int(_435.z), 0).xyz), 0));
        _467 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_446.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_435 / float3(_446.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _467 = _420;
    }
    float3 _481 = ((_403 - (_403 * _402)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _488 = (mix(float3(0.07999999821186065673828125 * _401), _403, float3(_402)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _491 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _496;
    if (_491)
    {
        _496 = _481 + (_488 * 0.449999988079071044921875);
    }
    else
    {
        _496 = _481;
    }
    float3 _498 = select(_488, float3(0.0), bool3(_491));
    float3 _500 = float3(dot(_498, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _586;
    if (_414)
    {
        float4 _536 = _174;
        _536.y = (-0.48860299587249755859375) * _404.y;
        float4 _539 = _536;
        _539.z = 0.48860299587249755859375 * _404.z;
        float4 _542 = _539;
        _542.w = (-0.48860299587249755859375) * _404.x;
        float3 _543 = _404 * _404;
        float4 _546 = _171;
        _546.x = (1.09254801273345947265625 * _404.x) * _404.y;
        float4 _549 = _546;
        _549.y = ((-1.09254801273345947265625) * _404.y) * _404.z;
        float4 _554 = _549;
        _554.z = 0.3153919875621795654296875 * ((3.0 * _543.z) - 1.0);
        float4 _557 = _554;
        _557.w = ((-1.09254801273345947265625) * _404.x) * _404.z;
        float4 _561 = _542;
        _561.x = 0.886227548122406005859375;
        float3 _563 = _561.yzw * 2.094395160675048828125;
        float4 _564 = float4(_561.x, _563.x, _563.y, _563.z);
        float4 _565 = _557 * 0.785398185253143310546875;
        float _566 = (_543.x - _543.y) * 0.4290426075458526611328125;
        float3 _572 = float3(0.0);
        _572.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _564) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _565)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _566);
        float3 _578 = _572;
        _578.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _564) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _565)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _566);
        float3 _584 = _578;
        _584.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _564) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _565)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _566);
        _586 = fast::max(float3(0.0), _584);
    }
    else
    {
        _586 = float3(0.0);
    }
    float _612;
    float _613;
    float3 _614;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _602;
        float _603;
        if (_414)
        {
            _602 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _603 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _602 = _404;
            _603 = 1.0;
        }
        float _604 = 1.0 - _603;
        float _606 = 1.0 - (_604 * _604);
        _612 = mix(fast::clamp(dot(_602, _404), 0.0, 1.0), 1.0, _606);
        _613 = _603;
        _614 = mix(_602, _404, float3(_606));
    }
    else
    {
        _612 = 1.0;
        _613 = 1.0;
        _614 = _404;
    }
    float4 _618 = float4(_614, 1.0);
    float3 _622 = _172;
    _622.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _618);
    float3 _626 = _622;
    _626.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _618);
    float3 _630 = _626;
    _630.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _618);
    float4 _633 = _618.xyzz * _618.yzzx;
    float3 _637 = _172;
    _637.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _633);
    float3 _641 = _637;
    _641.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _633);
    float3 _645 = _641;
    _645.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _633);
    float3 _660 = (_586 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_630 + _645) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_614.x * _614.x) - (_614.y * _614.y)))) * View.View_SkyLightColor.xyz) * (_613 * _612));
    float3 _682 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _711;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _710;
        if (any(abs(_243 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _351 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _351 + 19u)].xyz + float3(1.0))))
        {
            _710 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_243, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _710 = _682;
        }
        _711 = _710;
    }
    else
    {
        _711 = _682;
    }
    float4 _718 = float4(((mix(float3(0.0), _496 + (_498 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_660 * _496) * fast::max(float3(1.0), ((((((_403 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_403 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_403 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _711) * 1.0, 0.0);
    float4 _725;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _724 = _718;
        _724.w = 0.0;
        _725 = _724;
    }
    else
    {
        _725 = _718;
    }
    float2 _729 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _737 = (_404 * 0.5) + float3(0.5);
    float4 _739 = float4(_737.x, _737.y, _737.z, float4(0.0).w);
    _739.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _352)].y;
    float4 _740 = float4(0.0);
    _740.x = _402;
    float4 _741 = _740;
    _741.y = _401;
    float4 _742 = _741;
    _742.z = _400;
    float4 _743 = _742;
    _743.w = 0.50588238239288330078125;
    float4 _755 = float4(_403.x, _403.y, _403.z, float4(0.0).w);
    _755.w = ((log2(((dot(_660, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_500 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_500 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_500 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_729.xyx * _729.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _725 * View.View_PreExposure;
    out.out_var_SV_Target1 = _739;
    out.out_var_SV_Target2 = _743;
    out.out_var_SV_Target3 = _755;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_467, 1.0, 1.0, 1.0);
    return out;
}

