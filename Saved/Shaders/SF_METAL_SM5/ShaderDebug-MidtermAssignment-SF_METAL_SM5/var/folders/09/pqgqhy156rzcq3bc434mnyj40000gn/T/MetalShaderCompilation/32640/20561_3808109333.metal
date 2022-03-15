

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
    float3 IndirectLightingCache_IndirectLightingCachePrimitiveAdd;
    float3 IndirectLightingCache_IndirectLightingCachePrimitiveScale;
    float3 IndirectLightingCache_IndirectLightingCacheMinUV;
    float3 IndirectLightingCache_IndirectLightingCacheMaxUV;
    float4 IndirectLightingCache_PointSkyBentNormal;
    float IndirectLightingCache_DirectionalLightShadowing;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float3 _173 = {};
constant float4 _175 = {};

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

fragment MainPS_out Main_00005051_e2fb2315(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], texture2d<float> Material_Texture2D_2 [[texture(10)]], texture2d<float> Material_Texture2D_3 [[texture(11)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], sampler Material_Texture2D_2Sampler [[sampler(5)]], sampler Material_Texture2D_3Sampler [[sampler(6)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _235 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _239 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _244 = (_239.xyz / float3(_239.w)) - View.View_PreViewTranslation;
    float2 _245 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.25;
    float4 _251 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _245, bias(View.View_MaterialTextureMipBias));
    float2 _254 = (_251.xy * float2(2.0)) - float2(1.0);
    float2 _262 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.3499999940395355224609375;
    float4 _264 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _262, bias(View.View_MaterialTextureMipBias));
    float2 _267 = (_264.xy * float2(2.0)) - float2(1.0);
    float4 _279 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _284 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _289 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _293 = (_279.x + 0.5) * ((_284.x + 0.5) * (_289.x + 0.5));
    float _296 = fast::min(fast::max(mix(-2.0, 0.699999988079071044921875, _293), 0.0), 1.0);
    float3 _299 = float3(_296);
    float4 _305 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _332;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _332 = _235.w;
                break;
            }
            else
            {
                float _316 = _235.z;
                _332 = ((_316 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_316 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _347 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(mix(float4(_254, sqrt(fast::clamp(1.0 - dot(_254, _254), 0.0, 1.0)), 1.0).xyz, float4(_267, sqrt(fast::clamp(1.0 - dot(_267, _267), 0.0, 1.0)), 1.0).xyz, _299), float3(0.0, 0.0, 1.0), float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _305.x) + _332) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _360 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _245, bias(View.View_MaterialTextureMipBias));
    float4 _362 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _262, bias(View.View_MaterialTextureMipBias));
    float3 _372 = fast::clamp(mix(float3(0.6349999904632568359375), float3(1.0), float3(_293)) * mix(_360.xyz, _362.xyz, _299), float3(0.0), float3(1.0));
    float _377 = (fast::clamp(mix(0.800000011920928955078125, 0.5, _293 * mix(_360.w, _362.w, _296)), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _378 = in.in_var_PRIMITIVE_ID * 36u;
    uint _379 = _378 + 20u;
    float _427;
    float _428;
    float _429;
    float3 _430;
    float3 _431;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _379)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _397 = ((_235.xy / float2(_235.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _401 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _397, level(0.0));
        float4 _404 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _397, level(0.0));
        float4 _407 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _397, level(0.0));
        float _417 = _407.w;
        _427 = (_377 * _417) + _407.z;
        _428 = (0.5 * _417) + _407.y;
        _429 = _407.x;
        _430 = (_372 * _401.w) + _401.xyz;
        _431 = normalize((_347 * _404.w) + ((_404.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _427 = _377;
        _428 = 0.5;
        _429 = 0.0;
        _430 = _372;
        _431 = _347;
    }
    bool _441 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _447;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _378 + 18u)].w > 0.0) && _441)
    {
        _447 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _447 = 1.0;
    }
    float _494;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _379)].z > 0.0)
    {
        float3 _462 = fast::clamp((_244 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _473 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_462.x), int(_462.y), int(_462.z), 0).xyz), 0));
        _494 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_473.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_462 / float3(_473.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _494 = _447;
    }
    float3 _508 = ((_430 - (_430 * _429)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _515 = (mix(float3(0.07999999821186065673828125 * _428), _430, float3(_429)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _518 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _523;
    if (_518)
    {
        _523 = _508 + (_515 * 0.449999988079071044921875);
    }
    else
    {
        _523 = _508;
    }
    float3 _525 = select(_515, float3(0.0), bool3(_518));
    float3 _527 = float3(dot(_525, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _601;
    if (_441)
    {
        float3 _553 = fast::clamp((_244 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _557 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _553);
        float4 _561 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _553);
        float4 _564 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _553);
        float4 _582 = _175;
        _582.y = (-0.48860299587249755859375) * _431.y;
        float4 _585 = _582;
        _585.z = 0.48860299587249755859375 * _431.z;
        float4 _588 = _585;
        _588.w = (-0.48860299587249755859375) * _431.x;
        float4 _589 = _588;
        _589.x = 0.886227548122406005859375;
        float3 _591 = _589.yzw * 2.094395160675048828125;
        float4 _592 = float4(_589.x, _591.x, _591.y, _591.z);
        float3 _594 = float3(0.0);
        _594.x = dot(float4(_557.x, _561.x, _564.x, _557.w), _592);
        float3 _596 = _594;
        _596.y = dot(float4(_557.y, _561.y, _564.y, _561.w), _592);
        float3 _598 = _596;
        _598.z = dot(float4(_557.z, _561.z, _564.zw), _592);
        _601 = fast::max(float3(0.0), _598) * float3(0.3183098733425140380859375);
    }
    else
    {
        _601 = float3(0.0);
    }
    float _627;
    float _628;
    float3 _629;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _617;
        float _618;
        if (_441)
        {
            _617 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _618 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _617 = _431;
            _618 = 1.0;
        }
        float _619 = 1.0 - _618;
        float _621 = 1.0 - (_619 * _619);
        _627 = mix(fast::clamp(dot(_617, _431), 0.0, 1.0), 1.0, _621);
        _628 = _618;
        _629 = mix(_617, _431, float3(_621));
    }
    else
    {
        _627 = 1.0;
        _628 = 1.0;
        _629 = _431;
    }
    float4 _633 = float4(_629, 1.0);
    float3 _637 = _173;
    _637.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _633);
    float3 _641 = _637;
    _641.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _633);
    float3 _645 = _641;
    _645.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _633);
    float4 _648 = _633.xyzz * _633.yzzx;
    float3 _652 = _173;
    _652.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _648);
    float3 _656 = _652;
    _656.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _648);
    float3 _660 = _656;
    _660.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _648);
    float3 _675 = (_601 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_645 + _660) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_629.x * _629.x) - (_629.y * _629.y)))) * View.View_SkyLightColor.xyz) * (_628 * _627));
    float3 _697 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _726;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _725;
        if (any(abs(_244 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _378 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _378 + 19u)].xyz + float3(1.0))))
        {
            _725 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_244, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _725 = _697;
        }
        _726 = _725;
    }
    else
    {
        _726 = _697;
    }
    float4 _733 = float4(((mix(float3(0.0), _523 + (_525 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_675 * _523) * fast::max(float3(1.0), ((((((_430 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_430 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_430 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _726) * 1.0, 0.0);
    float4 _740;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _739 = _733;
        _739.w = 0.0;
        _740 = _739;
    }
    else
    {
        _740 = _733;
    }
    float2 _744 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _752 = (_431 * 0.5) + float3(0.5);
    float4 _754 = float4(_752.x, _752.y, _752.z, float4(0.0).w);
    _754.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _379)].y;
    float4 _755 = float4(0.0);
    _755.x = _429;
    float4 _756 = _755;
    _756.y = _428;
    float4 _757 = _756;
    _757.z = _427;
    float4 _758 = _757;
    _758.w = 0.50588238239288330078125;
    float4 _770 = float4(_430.x, _430.y, _430.z, float4(0.0).w);
    _770.w = ((log2(((dot(_675, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_527 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_527 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_527 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_744.xyx * _744.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _740 * View.View_PreExposure;
    out.out_var_SV_Target1 = _754;
    out.out_var_SV_Target2 = _758;
    out.out_var_SV_Target3 = _770;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_494, 1.0, 1.0, 1.0);
    return out;
}

