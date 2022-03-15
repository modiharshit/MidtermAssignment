

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
    char _m11_pad[16];
    float View_OutOfBoundsMask;
    char _m12_pad[48];
    float View_MaterialTextureMipBias;
    char _m13_pad[28];
    float View_UnlitViewmodeMask;
    char _m14_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m15_pad[452];
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
    spvUnsafeArray<float4, 8> Material_VectorExpressions;
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

fragment MainPS_out Main_00004a1c_01ffb5f9(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _232 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _236 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _241 = (_236.xyz / float3(_236.w)) - View.View_PreViewTranslation;
    float2 _242 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5;
    float4 _248 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _242, bias(View.View_MaterialTextureMipBias));
    float2 _251 = (_248.xy * float2(2.0)) - float2(1.0);
    float2 _259 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125;
    float4 _263 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _259, bias(View.View_MaterialTextureMipBias));
    float _290;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _290 = _232.w;
                break;
            }
            else
            {
                float _274 = _232.z;
                _290 = ((_274 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_274 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _297 = float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _263.x) + _290) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0));
    float3 _306 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(float4(_251, sqrt(fast::clamp(1.0 - dot(_251, _251), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), _297) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _317 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _242, bias(View.View_MaterialTextureMipBias));
    float4 _333 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.75) * 0.00999999977648258209228515625), bias(View.View_MaterialTextureMipBias));
    float3 _339 = mix(Material.Material_VectorExpressions[3].xyz * _317.y, _317.xyz * Material.Material_VectorExpressions[5].xyz, float3(fast::min(fast::max(mix(-0.25, 2.0, _333.x), 0.0), 1.0)));
    float4 _341 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _259, bias(View.View_MaterialTextureMipBias));
    float4 _349 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.004999999888241291046142578125), bias(View.View_MaterialTextureMipBias));
    float3 _354 = fast::clamp(mix(_339, mix(_339, mix(_341.xyz, Material.Material_VectorExpressions[7].xyz, float3(0.300000011920928955078125)), float3(_349.x)), _297), float3(0.0), float3(1.0));
    uint _355 = in.in_var_PRIMITIVE_ID * 36u;
    uint _356 = _355 + 20u;
    float _403;
    float _404;
    float _405;
    float3 _406;
    float3 _407;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _356)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _374 = ((_232.xy / float2(_232.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _378 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _374, level(0.0));
        float4 _381 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _374, level(0.0));
        float4 _384 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _374, level(0.0));
        float _394 = _384.w;
        _403 = _394 + _384.z;
        _404 = (0.5 * _394) + _384.y;
        _405 = _384.x;
        _406 = (_354 * _378.w) + _378.xyz;
        _407 = normalize((_306 * _381.w) + ((_381.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _403 = 1.0;
        _404 = 0.5;
        _405 = 0.0;
        _406 = _354;
        _407 = _306;
    }
    bool _417 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _423;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _355 + 18u)].w > 0.0) && _417)
    {
        _423 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _423 = 1.0;
    }
    float _470;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _356)].z > 0.0)
    {
        float3 _438 = fast::clamp((_241 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _449 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_438.x), int(_438.y), int(_438.z), 0).xyz), 0));
        _470 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_449.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_438 / float3(_449.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _470 = _423;
    }
    float3 _493 = (((_406 - (_406 * _405)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz) + (((mix(float3(0.07999999821186065673828125 * _404), _406, float3(_405)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz) * 0.449999988079071044921875);
    float3 _566;
    if (_417)
    {
        float4 _516 = _177;
        _516.y = (-0.48860299587249755859375) * _407.y;
        float4 _519 = _516;
        _519.z = 0.48860299587249755859375 * _407.z;
        float4 _522 = _519;
        _522.w = (-0.48860299587249755859375) * _407.x;
        float3 _523 = _407 * _407;
        float4 _526 = _174;
        _526.x = (1.09254801273345947265625 * _407.x) * _407.y;
        float4 _529 = _526;
        _529.y = ((-1.09254801273345947265625) * _407.y) * _407.z;
        float4 _534 = _529;
        _534.z = 0.3153919875621795654296875 * ((3.0 * _523.z) - 1.0);
        float4 _537 = _534;
        _537.w = ((-1.09254801273345947265625) * _407.x) * _407.z;
        float4 _541 = _522;
        _541.x = 0.886227548122406005859375;
        float3 _543 = _541.yzw * 2.094395160675048828125;
        float4 _544 = float4(_541.x, _543.x, _543.y, _543.z);
        float4 _545 = _537 * 0.785398185253143310546875;
        float _546 = (_523.x - _523.y) * 0.4290426075458526611328125;
        float3 _552 = float3(0.0);
        _552.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _544) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _545)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _546);
        float3 _558 = _552;
        _558.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _544) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _545)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _546);
        float3 _564 = _558;
        _564.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _544) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _545)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _546);
        _566 = fast::max(float3(0.0), _564);
    }
    else
    {
        _566 = float3(0.0);
    }
    float _592;
    float _593;
    float3 _594;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _582;
        float _583;
        if (_417)
        {
            _582 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _583 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _582 = _407;
            _583 = 1.0;
        }
        float _584 = 1.0 - _583;
        float _586 = 1.0 - (_584 * _584);
        _592 = mix(fast::clamp(dot(_582, _407), 0.0, 1.0), 1.0, _586);
        _593 = _583;
        _594 = mix(_582, _407, float3(_586));
    }
    else
    {
        _592 = 1.0;
        _593 = 1.0;
        _594 = _407;
    }
    float4 _598 = float4(_594, 1.0);
    float3 _602 = _175;
    _602.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _598);
    float3 _606 = _602;
    _606.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _598);
    float3 _610 = _606;
    _610.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _598);
    float4 _613 = _598.xyzz * _598.yzzx;
    float3 _617 = _175;
    _617.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _613);
    float3 _621 = _617;
    _621.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _613);
    float3 _625 = _621;
    _625.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _613);
    float3 _640 = (_566 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_610 + _625) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_594.x * _594.x) - (_594.y * _594.y)))) * View.View_SkyLightColor.xyz) * (_593 * _592));
    float3 _660 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _689;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _688;
        if (any(abs(_241 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _355 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _355 + 19u)].xyz + float3(1.0))))
        {
            _688 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_241, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _688 = _660;
        }
        _689 = _688;
    }
    else
    {
        _689 = _660;
    }
    float4 _696 = float4(((mix(float3(0.0), _493, float3(View.View_UnlitViewmodeMask)) + ((_640 * _493) * fast::max(float3(1.0), ((((((_406 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_406 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_406 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _689) * 1.0, 0.0);
    float4 _703;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _702 = _696;
        _702.w = 0.0;
        _703 = _702;
    }
    else
    {
        _703 = _696;
    }
    float2 _707 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _715 = (_407 * 0.5) + float3(0.5);
    float4 _717 = float4(_715.x, _715.y, _715.z, float4(0.0).w);
    _717.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _356)].y;
    float4 _718 = float4(0.0);
    _718.x = _405;
    float4 _719 = _718;
    _719.y = _404;
    float4 _720 = _719;
    _720.z = _403;
    float4 _721 = _720;
    _721.w = 0.50588238239288330078125;
    float4 _732 = float4(_406.x, _406.y, _406.z, float4(0.0).w);
    _732.w = ((log2((dot(_640, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_707.xyx * _707.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _703 * View.View_PreExposure;
    out.out_var_SV_Target1 = _717;
    out.out_var_SV_Target2 = _721;
    out.out_var_SV_Target3 = _732;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_470, 1.0, 1.0, 1.0);
    return out;
}

