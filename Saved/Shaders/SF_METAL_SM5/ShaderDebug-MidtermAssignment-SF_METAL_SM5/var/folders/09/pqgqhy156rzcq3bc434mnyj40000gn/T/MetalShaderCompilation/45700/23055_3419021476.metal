

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
    char _m11_pad[24];
    float View_CullingSign;
    char _m12_pad[20];
    float View_MaterialTextureMipBias;
    char _m13_pad[28];
    float View_UnlitViewmodeMask;
    char _m14_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m15_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m16_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m18_pad[124];
    float View_ShowDecalsMask;
    char _m19_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m20_pad[48];
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

struct type_PrimitiveDither
{
    float PrimitiveDither_LODFactor;
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
    spvUnsafeArray<float4, 7> Material_VectorExpressions;
    spvUnsafeArray<float4, 6> Material_ScalarExpressions;
};

constant float _172 = {};
constant float4 _173 = {};
constant float3 _174 = {};
constant float _176 = {};
constant float4 _177 = {};
constant float3 _178 = {};

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
    float4 in_var_COLOR0 [[user(locn2)]];
    float4 in_var_TEXCOORD0_0 [[user(locn3)]];
    uint in_var_PRIMITIVE_ID [[user(locn4)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00005a0f_cbca20a4(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(6)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_PrimitiveDither& PrimitiveDither [[buffer(3)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(4)]], constant type_Material& Material [[buffer(5)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_3 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_3Sampler [[sampler(4)]], float4 gl_FragCoord [[position]], bool gl_FrontFacing [[front_facing]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _240 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _176, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _245 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _250 = (_245.xyz / float3(_245.w)) - View.View_PreViewTranslation;
    uint _251 = in.in_var_PRIMITIVE_ID * 36u;
    float4 _265 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _276 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((((float3(-0.5) + _265.xyz) * 2.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * ((View.View_CullingSign * View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _251 + 4u)].w) * float(gl_FrontFacing ? 1 : (-1)));
    float4 _287 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _294 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    if (PrimitiveDither.PrimitiveDither_LODFactor != 0.0)
    {
        if (abs(PrimitiveDither.PrimitiveDither_LODFactor) > 0.001000000047497451305389404296875)
        {
            float _314 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
            if ((float((PrimitiveDither.PrimitiveDither_LODFactor < 0.0) ? ((PrimitiveDither.PrimitiveDither_LODFactor + 1.0) > _314) : (PrimitiveDither.PrimitiveDither_LODFactor < _314)) - 0.001000000047497451305389404296875) < 0.0)
            {
                discard_fragment();
            }
        }
    }
    if (((in.in_var_COLOR0.w * _287.w) - 0.100000001490116119384765625) < 0.0)
    {
        discard_fragment();
    }
    float3 _329 = fast::clamp(_287.xyz, float3(0.0), float3(1.0));
    float _334 = (fast::clamp(_265.w, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float3 _344 = (fast::clamp(float4(_294.xyz, _172).xyz, float3(0.0), float3(1.0)).xyz * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    uint _345 = _251 + 20u;
    float3 _394;
    float _395;
    float _396;
    float _397;
    float3 _398;
    float3 _399;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _345)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _363 = ((_240.xy / float2(_240.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _367 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _363, level(0.0));
        float4 _370 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _363, level(0.0));
        float4 _373 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _363, level(0.0));
        float _375 = _367.w;
        float _383 = _373.w;
        _394 = _344 * _375;
        _395 = (_334 * _383) + _373.z;
        _396 = (0.5 * _383) + _373.y;
        _397 = _373.x;
        _398 = (_329 * _375) + _367.xyz;
        _399 = normalize((_276 * _370.w) + ((_370.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _394 = _344;
        _395 = _334;
        _396 = 0.5;
        _397 = 0.0;
        _398 = _329;
        _399 = _276;
    }
    bool _409 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _415;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _251 + 18u)].w > 0.0) && _409)
    {
        _415 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _415 = 1.0;
    }
    float _462;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _345)].z > 0.0)
    {
        float3 _430 = fast::clamp((_250 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _441 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_430.x), int(_430.y), int(_430.z), 0).xyz), 0));
        _462 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_441.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_430 / float3(_441.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _462 = _415;
    }
    float3 _465 = sqrt(fast::clamp(_394, float3(0.0), float3(1.0)));
    float4 _467 = float4(_465.x, _465.y, _465.z, float4(0.0).w);
    _467.w = 1.0;
    float3 _475 = ((_398 - (_398 * _397)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _482 = (mix(float3(0.07999999821186065673828125 * _396), _398, float3(_397)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _485 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _490;
    if (_485)
    {
        _490 = _475 + (_482 * 0.449999988079071044921875);
    }
    else
    {
        _490 = _475;
    }
    float3 _492 = select(_482, float3(0.0), bool3(_485));
    float3 _494 = float3(dot(_492, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _633;
    float3 _634;
    if (_409)
    {
        float4 _530 = _177;
        _530.y = (-0.48860299587249755859375) * _399.y;
        float4 _533 = _530;
        _533.z = 0.48860299587249755859375 * _399.z;
        float4 _536 = _533;
        _536.w = (-0.48860299587249755859375) * _399.x;
        float3 _537 = _399 * _399;
        float4 _540 = _173;
        _540.x = (1.09254801273345947265625 * _399.x) * _399.y;
        float4 _543 = _540;
        _543.y = ((-1.09254801273345947265625) * _399.y) * _399.z;
        float4 _548 = _543;
        _548.z = 0.3153919875621795654296875 * ((3.0 * _537.z) - 1.0);
        float4 _551 = _548;
        _551.w = ((-1.09254801273345947265625) * _399.x) * _399.z;
        float4 _555 = _536;
        _555.x = 0.886227548122406005859375;
        float3 _557 = _555.yzw * 2.094395160675048828125;
        float4 _558 = float4(_555.x, _557.x, _557.y, _557.z);
        float4 _559 = _551 * 0.785398185253143310546875;
        float _560 = (_537.x - _537.y) * 0.4290426075458526611328125;
        float3 _566 = float3(0.0);
        _566.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _558) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _559)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _560);
        float3 _572 = _566;
        _572.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _558) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _559)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _560);
        float3 _578 = _572;
        _578.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _558) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _559)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _560);
        float3 _580 = -_399;
        float _581 = _580.y;
        float4 _583 = _177;
        _583.y = (-0.48860299587249755859375) * _581;
        float _584 = _580.z;
        float4 _586 = _583;
        _586.z = 0.48860299587249755859375 * _584;
        float _587 = _580.x;
        float4 _589 = _586;
        _589.w = (-0.48860299587249755859375) * _587;
        float3 _590 = _580 * _580;
        float4 _593 = _173;
        _593.x = (1.09254801273345947265625 * _587) * _581;
        float4 _596 = _593;
        _596.y = ((-1.09254801273345947265625) * _581) * _584;
        float4 _601 = _596;
        _601.z = 0.3153919875621795654296875 * ((3.0 * _590.z) - 1.0);
        float4 _604 = _601;
        _604.w = ((-1.09254801273345947265625) * _587) * _584;
        float4 _608 = _589;
        _608.x = 0.886227548122406005859375;
        float3 _610 = _608.yzw * 2.094395160675048828125;
        float4 _611 = float4(_608.x, _610.x, _610.y, _610.z);
        float4 _612 = _604 * 0.785398185253143310546875;
        float _613 = (_590.x - _590.y) * 0.4290426075458526611328125;
        float3 _619 = _178;
        _619.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _611) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _612)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _613);
        float3 _625 = _619;
        _625.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _611) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _612)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _613);
        float3 _631 = _625;
        _631.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _611) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _612)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _613);
        _633 = fast::max(float3(0.0), _631);
        _634 = fast::max(float3(0.0), _578);
    }
    else
    {
        _633 = float3(0.0);
        _634 = float3(0.0);
    }
    float _661;
    float _662;
    float3 _663;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _651;
        float _652;
        if (_409)
        {
            _651 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _652 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _651 = _399;
            _652 = 1.0;
        }
        float _653 = 1.0 - _652;
        float _655 = 1.0 - (_653 * _653);
        _661 = mix(fast::clamp(dot(_651, _399), 0.0, 1.0), 1.0, _655);
        _662 = _652;
        _663 = mix(_651, _399, float3(_655));
    }
    else
    {
        _661 = 1.0;
        _662 = 1.0;
        _663 = _399;
    }
    float4 _667 = float4(_663, 1.0);
    float3 _671 = _174;
    _671.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _667);
    float3 _675 = _671;
    _675.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _667);
    float3 _679 = _675;
    _679.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _667);
    float4 _682 = _667.xyzz * _667.yzzx;
    float3 _686 = _174;
    _686.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _682);
    float3 _690 = _686;
    _690.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _682);
    float3 _694 = _690;
    _694.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _682);
    float3 _709 = -_399;
    float _710 = _709.x;
    float _711 = _709.y;
    float4 _713 = float4(_710, _711, _709.z, 1.0);
    float3 _716 = _178;
    _716.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _713);
    float3 _719 = _716;
    _719.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _713);
    float3 _722 = _719;
    _722.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _713);
    float4 _725 = _713.xyzz * _713.yzzx;
    float3 _728 = _178;
    _728.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _725);
    float3 _731 = _728;
    _731.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _725);
    float3 _734 = _731;
    _734.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _725);
    float3 _747 = (_634 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_679 + _694) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_663.x * _663.x) - (_663.y * _663.y)))) * View.View_SkyLightColor.xyz) * (_662 * _661));
    float3 _771 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _800;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _799;
        if (any(abs(_250 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _251 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _251 + 19u)].xyz + float3(1.0))))
        {
            _799 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_250, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _799 = _771;
        }
        _800 = _799;
    }
    else
    {
        _800 = _771;
    }
    float4 _807 = float4(((mix(float3(0.0), _490 + (_492 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + (((_747 * _490) + (((_633 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_722 + _734) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_710 * _710) - (_711 * _711)))) * View.View_SkyLightColor.xyz) * _662)) * _394)) * fast::max(float3(1.0), ((((((_398 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_398 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_398 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _800) * 1.0, 0.0);
    float4 _814;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _813 = _807;
        _813.w = 0.0;
        _814 = _813;
    }
    else
    {
        _814 = _807;
    }
    float2 _818 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _826 = (_399 * 0.5) + float3(0.5);
    float4 _828 = float4(_826.x, _826.y, _826.z, float4(0.0).w);
    _828.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _345)].y;
    float4 _829 = float4(0.0);
    _829.x = _397;
    float4 _830 = _829;
    _830.y = _396;
    float4 _831 = _830;
    _831.z = _395;
    float4 _832 = _831;
    _832.w = 0.525490224361419677734375;
    float4 _844 = float4(_398.x, _398.y, _398.z, float4(0.0).w);
    _844.w = ((log2(((dot(_747, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_494 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_494 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_494 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_818.xyx * _818.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _814 * View.View_PreExposure;
    out.out_var_SV_Target1 = _828;
    out.out_var_SV_Target2 = _832;
    out.out_var_SV_Target3 = _844;
    out.out_var_SV_Target4 = _467;
    out.out_var_SV_Target5 = float4(_462, 1.0, 1.0, 1.0);
    return out;
}

