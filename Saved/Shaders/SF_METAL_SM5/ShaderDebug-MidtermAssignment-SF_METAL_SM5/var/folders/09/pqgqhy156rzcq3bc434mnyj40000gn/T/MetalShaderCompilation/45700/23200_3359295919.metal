

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
    char _m0_pad[256];
    float4x4 View_ViewToTranslatedWorld;
    char _m1_pad[384];
    float4x4 View_SVPositionToTranslatedWorld;
    char _m2_pad[288];
    float4 View_ScreenPositionScaleBias;
    float3 View_WorldCameraOrigin;
    char _m4_pad[32];
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
    char _m16_pad[400];
    packed_float3 View_NormalCurvatureToRoughnessScaleBias;
    float View_RenderingReflectionCaptureMask;
    char _m18_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m20_pad[124];
    float View_ShowDecalsMask;
    char _m21_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m22_pad[48];
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
    float3 IndirectLightingCache_IndirectLightingCachePrimitiveAdd;
    float3 IndirectLightingCache_IndirectLightingCachePrimitiveScale;
    float3 IndirectLightingCache_IndirectLightingCacheMinUV;
    float3 IndirectLightingCache_IndirectLightingCacheMaxUV;
    float4 IndirectLightingCache_PointSkyBentNormal;
    float IndirectLightingCache_DirectionalLightShadowing;
};

struct type_Material
{
    spvUnsafeArray<float4, 6> Material_VectorExpressions;
    spvUnsafeArray<float4, 4> Material_ScalarExpressions;
};

constant float _172 = {};
constant float4x4 _173 = {};
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
    float4 in_var_TEXCOORD15 [[user(locn2)]];
    float4 in_var_TEXCOORD0_0 [[user(locn3)]];
    uint in_var_PRIMITIVE_ID [[user(locn4)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00005aa0_c83ac9af(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(6)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_PrimitiveDither& PrimitiveDither [[buffer(3)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(4)]], constant type_Material& Material [[buffer(5)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], texture2d<float> Material_Texture2D_3 [[texture(10)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float3x3 _232 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _244 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _176, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _249 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _254 = (_249.xyz / float3(_249.w)) - View.View_PreViewTranslation;
    uint _255 = in.in_var_PRIMITIVE_ID * 36u;
    float4x4 _258 = _173;
    _258[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _255)];
    float4x4 _262 = _258;
    _262[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _255 + 1u)];
    float4x4 _266 = _262;
    _266[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _255 + 2u)];
    float4x4 _270 = _266;
    _270[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _255 + 3u)];
    float3 _273 = (_270 * float4(0.0, 0.0, 0.0, 1.0)).xyz - View.View_WorldCameraOrigin;
    float4 _285 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _288 = (float3(-0.5) + _285.xyz) * 2.0;
    float3 _304 = ((((_273 / float3(sqrt(dot(_273, _273)))) * _232) * (-1.0)) * _288.z) + (float3(_288.xy, 0.0) * ((float3x3(View.View_ViewToTranslatedWorld[0].xyz, View.View_ViewToTranslatedWorld[1].xyz, View.View_ViewToTranslatedWorld[2].xyz) * float3(1.0, 1.0, 0.0)) * _232));
    float3 _316 = normalize(_232 * normalize(((_304 / float3(sqrt(dot(_304, _304)))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _327 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _334 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    if (PrimitiveDither.PrimitiveDither_LODFactor != 0.0)
    {
        if (abs(PrimitiveDither.PrimitiveDither_LODFactor) > 0.001000000047497451305389404296875)
        {
            float _354 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
            if ((float((PrimitiveDither.PrimitiveDither_LODFactor < 0.0) ? ((PrimitiveDither.PrimitiveDither_LODFactor + 1.0) > _354) : (PrimitiveDither.PrimitiveDither_LODFactor < _354)) - 0.001000000047497451305389404296875) < 0.0)
            {
                discard_fragment();
            }
        }
    }
    if (((_327.w * in_var_TEXCOORD0[0].z) - 0.100000001490116119384765625) < 0.0)
    {
        discard_fragment();
    }
    float3 _369 = fast::clamp(_327.xyz, float3(0.0), float3(1.0));
    float _374 = (fast::clamp(_285.w, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float3 _384 = (fast::clamp(float4(_334.xyz, _172).xyz, float3(0.0), float3(1.0)).xyz * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    uint _385 = _255 + 20u;
    float3 _434;
    float _435;
    float _436;
    float _437;
    float3 _438;
    float3 _439;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _385)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _403 = ((_244.xy / float2(_244.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _407 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _403, level(0.0));
        float4 _410 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _403, level(0.0));
        float4 _413 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _403, level(0.0));
        float _415 = _407.w;
        float _423 = _413.w;
        _434 = _384 * _415;
        _435 = (_374 * _423) + _413.z;
        _436 = (0.5 * _423) + _413.y;
        _437 = _413.x;
        _438 = (_369 * _415) + _407.xyz;
        _439 = normalize((_316 * _410.w) + ((_410.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _434 = _384;
        _435 = _374;
        _436 = 0.5;
        _437 = 0.0;
        _438 = _369;
        _439 = _316;
    }
    bool _449 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _455;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _255 + 18u)].w > 0.0) && _449)
    {
        _455 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _455 = 1.0;
    }
    float _502;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _385)].z > 0.0)
    {
        float3 _470 = fast::clamp((_254 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _481 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_470.x), int(_470.y), int(_470.z), 0).xyz), 0));
        _502 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_481.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_470 / float3(_481.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _502 = _455;
    }
    float3 _505 = sqrt(fast::clamp(_434, float3(0.0), float3(1.0)));
    float4 _507 = float4(_505.x, _505.y, _505.z, float4(0.0).w);
    _507.w = 1.0;
    float3 _512 = dfdx(in.in_var_TEXCOORD15.xyz);
    float3 _513 = dfdy(in.in_var_TEXCOORD15.xyz);
    float3 _531 = ((_438 - (_438 * _437)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _538 = (mix(float3(0.07999999821186065673828125 * _436), _438, float3(_437)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _541 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _546;
    if (_541)
    {
        _546 = _531 + (_538 * 0.449999988079071044921875);
    }
    else
    {
        _546 = _531;
    }
    float3 _548 = select(_538, float3(0.0), bool3(_541));
    float3 _550 = float3(dot(_548, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _646;
    float3 _647;
    if (_449)
    {
        float3 _576 = fast::clamp((_254 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _580 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _576);
        float4 _584 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _576);
        float4 _587 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _576);
        float4 _592 = float4(_580.x, _584.x, _587.x, _580.w);
        float4 _597 = float4(_580.y, _584.y, _587.y, _584.w);
        float4 _602 = float4(_580.z, _584.z, _587.zw);
        float4 _605 = _177;
        _605.y = (-0.48860299587249755859375) * _439.y;
        float4 _608 = _605;
        _608.z = 0.48860299587249755859375 * _439.z;
        float4 _611 = _608;
        _611.w = (-0.48860299587249755859375) * _439.x;
        float4 _612 = _611;
        _612.x = 0.886227548122406005859375;
        float3 _614 = _612.yzw * 2.094395160675048828125;
        float4 _615 = float4(_612.x, _614.x, _614.y, _614.z);
        float3 _617 = float3(0.0);
        _617.x = dot(_592, _615);
        float3 _619 = _617;
        _619.y = dot(_597, _615);
        float3 _621 = _619;
        _621.z = dot(_602, _615);
        float3 _624 = -_439;
        float4 _627 = _177;
        _627.y = (-0.48860299587249755859375) * _624.y;
        float4 _630 = _627;
        _630.z = 0.48860299587249755859375 * _624.z;
        float4 _633 = _630;
        _633.w = (-0.48860299587249755859375) * _624.x;
        float4 _634 = _633;
        _634.x = 0.886227548122406005859375;
        float3 _636 = _634.yzw * 2.094395160675048828125;
        float4 _637 = float4(_634.x, _636.x, _636.y, _636.z);
        float3 _639 = _178;
        _639.x = dot(_592, _637);
        float3 _641 = _639;
        _641.y = dot(_597, _637);
        float3 _643 = _641;
        _643.z = dot(_602, _637);
        _646 = fast::max(float3(0.0), _643) * float3(0.3183098733425140380859375);
        _647 = fast::max(float3(0.0), _621) * float3(0.3183098733425140380859375);
    }
    else
    {
        _646 = float3(0.0);
        _647 = float3(0.0);
    }
    float _674;
    float _675;
    float3 _676;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _664;
        float _665;
        if (_449)
        {
            _664 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _665 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _664 = _439;
            _665 = 1.0;
        }
        float _666 = 1.0 - _665;
        float _668 = 1.0 - (_666 * _666);
        _674 = mix(fast::clamp(dot(_664, _439), 0.0, 1.0), 1.0, _668);
        _675 = _665;
        _676 = mix(_664, _439, float3(_668));
    }
    else
    {
        _674 = 1.0;
        _675 = 1.0;
        _676 = _439;
    }
    float4 _680 = float4(_676, 1.0);
    float3 _684 = _174;
    _684.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _680);
    float3 _688 = _684;
    _688.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _680);
    float3 _692 = _688;
    _692.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _680);
    float4 _695 = _680.xyzz * _680.yzzx;
    float3 _699 = _174;
    _699.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _695);
    float3 _703 = _699;
    _703.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _695);
    float3 _707 = _703;
    _707.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _695);
    float3 _722 = -_439;
    float _723 = _722.x;
    float _724 = _722.y;
    float4 _726 = float4(_723, _724, _722.z, 1.0);
    float3 _729 = _178;
    _729.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _726);
    float3 _732 = _729;
    _732.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _726);
    float3 _735 = _732;
    _735.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _726);
    float4 _738 = _726.xyzz * _726.yzzx;
    float3 _741 = _178;
    _741.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _738);
    float3 _744 = _741;
    _744.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _738);
    float3 _747 = _744;
    _747.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _738);
    float3 _760 = (_647 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_692 + _707) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_676.x * _676.x) - (_676.y * _676.y)))) * View.View_SkyLightColor.xyz) * (_675 * _674));
    float3 _784 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _813;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _812;
        if (any(abs(_254 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _255 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _255 + 19u)].xyz + float3(1.0))))
        {
            _812 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_254, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _812 = _784;
        }
        _813 = _812;
    }
    else
    {
        _813 = _784;
    }
    float4 _820 = float4(((mix(float3(0.0), _546 + (_548 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + (((_760 * _546) + (((_646 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_735 + _747) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_723 * _723) - (_724 * _724)))) * View.View_SkyLightColor.xyz) * _675)) * _434)) * fast::max(float3(1.0), ((((((_438 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_438 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_438 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _813) * 1.0, 0.0);
    float4 _827;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _826 = _820;
        _826.w = 0.0;
        _827 = _826;
    }
    else
    {
        _827 = _820;
    }
    float2 _831 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _839 = (_439 * 0.5) + float3(0.5);
    float4 _841 = float4(_839.x, _839.y, _839.z, float4(0.0).w);
    _841.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _385)].y;
    float4 _842 = float4(0.0);
    _842.x = _437;
    float4 _843 = _842;
    _843.y = _436;
    float4 _844 = _843;
    _844.z = fast::max(_435, fast::clamp((pow(fast::max(dot(_512, _512), dot(_513, _513)), View.View_NormalCurvatureToRoughnessScaleBias[2]) * View.View_NormalCurvatureToRoughnessScaleBias[0]) + View.View_NormalCurvatureToRoughnessScaleBias[1], 0.0, 1.0));
    float4 _845 = _844;
    _845.w = 0.525490224361419677734375;
    float4 _857 = float4(_438.x, _438.y, _438.z, float4(0.0).w);
    _857.w = ((log2(((dot(_760, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_550 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_550 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_550 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_831.xyx * _831.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _827 * View.View_PreExposure;
    out.out_var_SV_Target1 = _841;
    out.out_var_SV_Target2 = _845;
    out.out_var_SV_Target3 = _857;
    out.out_var_SV_Target4 = _507;
    out.out_var_SV_Target5 = float4(_502, 1.0, 1.0, 1.0);
    return out;
}

