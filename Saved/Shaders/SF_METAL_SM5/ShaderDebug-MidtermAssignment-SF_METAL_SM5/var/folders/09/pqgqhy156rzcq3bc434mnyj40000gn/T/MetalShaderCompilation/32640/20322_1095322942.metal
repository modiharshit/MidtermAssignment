

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

constant float3 _171 = {};
constant float4 _173 = {};

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

fragment MainPS_out Main_00004f62_41494d3e(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], texture2d<float> Material_Texture2D_2 [[texture(10)]], texture2d<float> Material_Texture2D_3 [[texture(11)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], sampler Material_Texture2D_2Sampler [[sampler(5)]], sampler Material_Texture2D_3Sampler [[sampler(6)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _233 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _237 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _242 = (_237.xyz / float3(_237.w)) - View.View_PreViewTranslation;
    float2 _243 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.300000011920928955078125;
    float4 _249 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _243, bias(View.View_MaterialTextureMipBias));
    float2 _252 = (_249.xy * float2(2.0)) - float2(1.0);
    float2 _260 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.20000000298023223876953125;
    float4 _262 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _260, bias(View.View_MaterialTextureMipBias));
    float2 _265 = (_262.xy * float2(2.0)) - float2(1.0);
    float4 _277 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.008000000379979610443115234375), bias(View.View_MaterialTextureMipBias));
    float4 _282 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.004999999888241291046142578125), bias(View.View_MaterialTextureMipBias));
    float _284 = (_277.x + 0.5) * _282.x;
    float _286 = fast::min(fast::max(_284, 0.0), 1.0);
    float3 _289 = float3(_286);
    float4 _295 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _322;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _322 = _233.w;
                break;
            }
            else
            {
                float _306 = _233.z;
                _322 = ((_306 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_306 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _337 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(mix(float4(_252, sqrt(fast::clamp(1.0 - dot(_252, _252), 0.0, 1.0)), 1.0).xyz, float4(_265, sqrt(fast::clamp(1.0 - dot(_265, _265), 0.0, 1.0)), 1.0).xyz, _289), float3(0.0, 0.0, 1.0), float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _295.x) + _322) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _349 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _243, bias(View.View_MaterialTextureMipBias));
    float4 _351 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _260, bias(View.View_MaterialTextureMipBias));
    float3 _361 = fast::clamp(mix(_349.xyz, _351.xyz, _289) * mix(0.60000002384185791015625, 1.0, _284), float3(0.0), float3(1.0));
    float _366 = (fast::clamp(mix(0.949999988079071044921875, 0.699999988079071044921875, _284 * mix(_349.w, _351.w, _286)), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _367 = in.in_var_PRIMITIVE_ID * 36u;
    uint _368 = _367 + 20u;
    float _416;
    float _417;
    float _418;
    float3 _419;
    float3 _420;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _368)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _386 = ((_233.xy / float2(_233.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _390 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _386, level(0.0));
        float4 _393 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _386, level(0.0));
        float4 _396 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _386, level(0.0));
        float _406 = _396.w;
        _416 = (_366 * _406) + _396.z;
        _417 = (0.5 * _406) + _396.y;
        _418 = _396.x;
        _419 = (_361 * _390.w) + _390.xyz;
        _420 = normalize((_337 * _393.w) + ((_393.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _416 = _366;
        _417 = 0.5;
        _418 = 0.0;
        _419 = _361;
        _420 = _337;
    }
    bool _430 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _436;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _367 + 18u)].w > 0.0) && _430)
    {
        _436 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _436 = 1.0;
    }
    float _483;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _368)].z > 0.0)
    {
        float3 _451 = fast::clamp((_242 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _462 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_451.x), int(_451.y), int(_451.z), 0).xyz), 0));
        _483 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_462.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_451 / float3(_462.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _483 = _436;
    }
    float3 _497 = ((_419 - (_419 * _418)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _504 = (mix(float3(0.07999999821186065673828125 * _417), _419, float3(_418)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _507 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _512;
    if (_507)
    {
        _512 = _497 + (_504 * 0.449999988079071044921875);
    }
    else
    {
        _512 = _497;
    }
    float3 _514 = select(_504, float3(0.0), bool3(_507));
    float3 _516 = float3(dot(_514, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _590;
    if (_430)
    {
        float3 _542 = fast::clamp((_242 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _546 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _542);
        float4 _550 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _542);
        float4 _553 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _542);
        float4 _571 = _173;
        _571.y = (-0.48860299587249755859375) * _420.y;
        float4 _574 = _571;
        _574.z = 0.48860299587249755859375 * _420.z;
        float4 _577 = _574;
        _577.w = (-0.48860299587249755859375) * _420.x;
        float4 _578 = _577;
        _578.x = 0.886227548122406005859375;
        float3 _580 = _578.yzw * 2.094395160675048828125;
        float4 _581 = float4(_578.x, _580.x, _580.y, _580.z);
        float3 _583 = float3(0.0);
        _583.x = dot(float4(_546.x, _550.x, _553.x, _546.w), _581);
        float3 _585 = _583;
        _585.y = dot(float4(_546.y, _550.y, _553.y, _550.w), _581);
        float3 _587 = _585;
        _587.z = dot(float4(_546.z, _550.z, _553.zw), _581);
        _590 = fast::max(float3(0.0), _587) * float3(0.3183098733425140380859375);
    }
    else
    {
        _590 = float3(0.0);
    }
    float _616;
    float _617;
    float3 _618;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _606;
        float _607;
        if (_430)
        {
            _606 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _607 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _606 = _420;
            _607 = 1.0;
        }
        float _608 = 1.0 - _607;
        float _610 = 1.0 - (_608 * _608);
        _616 = mix(fast::clamp(dot(_606, _420), 0.0, 1.0), 1.0, _610);
        _617 = _607;
        _618 = mix(_606, _420, float3(_610));
    }
    else
    {
        _616 = 1.0;
        _617 = 1.0;
        _618 = _420;
    }
    float4 _622 = float4(_618, 1.0);
    float3 _626 = _171;
    _626.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _622);
    float3 _630 = _626;
    _630.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _622);
    float3 _634 = _630;
    _634.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _622);
    float4 _637 = _622.xyzz * _622.yzzx;
    float3 _641 = _171;
    _641.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _637);
    float3 _645 = _641;
    _645.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _637);
    float3 _649 = _645;
    _649.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _637);
    float3 _664 = (_590 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_634 + _649) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_618.x * _618.x) - (_618.y * _618.y)))) * View.View_SkyLightColor.xyz) * (_617 * _616));
    float3 _686 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _715;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _714;
        if (any(abs(_242 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _367 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _367 + 19u)].xyz + float3(1.0))))
        {
            _714 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_242, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _714 = _686;
        }
        _715 = _714;
    }
    else
    {
        _715 = _686;
    }
    float4 _722 = float4(((mix(float3(0.0), _512 + (_514 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_664 * _512) * fast::max(float3(1.0), ((((((_419 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_419 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_419 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _715) * 1.0, 0.0);
    float4 _729;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _728 = _722;
        _728.w = 0.0;
        _729 = _728;
    }
    else
    {
        _729 = _722;
    }
    float2 _733 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _741 = (_420 * 0.5) + float3(0.5);
    float4 _743 = float4(_741.x, _741.y, _741.z, float4(0.0).w);
    _743.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _368)].y;
    float4 _744 = float4(0.0);
    _744.x = _418;
    float4 _745 = _744;
    _745.y = _417;
    float4 _746 = _745;
    _746.z = _416;
    float4 _747 = _746;
    _747.w = 0.50588238239288330078125;
    float4 _759 = float4(_419.x, _419.y, _419.z, float4(0.0).w);
    _759.w = ((log2(((dot(_664, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_516 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_516 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_516 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_733.xyx * _733.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _729 * View.View_PreExposure;
    out.out_var_SV_Target1 = _743;
    out.out_var_SV_Target2 = _747;
    out.out_var_SV_Target3 = _759;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_483, 1.0, 1.0, 1.0);
    return out;
}

