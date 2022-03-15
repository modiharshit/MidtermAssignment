

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
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_Material
{
    spvUnsafeArray<float4, 6> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _185 = {};
constant float3 _186 = {};
constant float4 _188 = {};

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

fragment MainPS_out Main_00005125_88f01f0a(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(11)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(12)]], texture2d<float> Material_Texture2D_0 [[texture(13)]], texture2d<float> Material_Texture2D_1 [[texture(14)]], texture2d<float> Material_Texture2D_2 [[texture(15)]], texture2d<float> Material_Texture2D_3 [[texture(16)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _248 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _252 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _257 = (_252.xyz / float3(_252.w)) - View.View_PreViewTranslation;
    float4 _264 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 10.0), bias(View.View_MaterialTextureMipBias));
    float2 _267 = (_264.xy * float2(2.0)) - float2(1.0);
    float4 _280 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _283 = (_280.xy * float2(2.0)) - float2(1.0);
    float _317;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _317 = _248.w;
                break;
            }
            else
            {
                float _301 = _248.z;
                _317 = ((_301 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_301 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _321 = fast::min(fast::max((_317 - 24.0) * 0.00022222222469281405210494995117188, 0.0), 1.0);
    float3 _332 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((((float4(_267, sqrt(fast::clamp(1.0 - dot(_267, _267), 0.0, 1.0)), 1.0).xyz * float3(0.5, 0.5, 1.0)) + mix(float4(_283, sqrt(fast::clamp(1.0 - dot(_283, _283), 0.0, 1.0)), 1.0).xyz * float3(0.25, 0.25, 1.0), float3(0.0, 0.0, 1.0), float3(_321))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _344 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 5.0), bias(View.View_MaterialTextureMipBias));
    float _346 = mix(0.4000000059604644775390625, 1.0, _344.x);
    float _349 = mix(0.699999988079071044921875, 0.89999997615814208984375, _344.y);
    float4 _354 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _369 = fast::clamp(mix(Material.Material_VectorExpressions[4].xyz, Material.Material_VectorExpressions[5].xyz, float3(fast::min(fast::max(_354.y + _321, 0.0), 1.0))) * mix(_346, 1.0 - _346, _349), float3(0.0), float3(1.0));
    float _374 = (fast::clamp(_346 * _349, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _375 = in.in_var_PRIMITIVE_ID * 36u;
    uint _376 = _375 + 20u;
    float _424;
    float _425;
    float _426;
    float3 _427;
    float3 _428;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _376)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _394 = ((_248.xy / float2(_248.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _398 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _394, level(0.0));
        float4 _401 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _394, level(0.0));
        float4 _404 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _394, level(0.0));
        float _414 = _404.w;
        _424 = (_374 * _414) + _404.z;
        _425 = (0.5 * _414) + _404.y;
        _426 = _404.x;
        _427 = (_369 * _398.w) + _398.xyz;
        _428 = normalize((_332 * _401.w) + ((_401.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _424 = _374;
        _425 = 0.5;
        _426 = 0.0;
        _427 = _369;
        _428 = _332;
    }
    float3 _438 = fast::clamp((_257 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _449 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_438.x), int(_438.y), int(_438.z), 0).xyz), 0));
    float3 _464 = (((_449.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_438 / float3(_449.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _477;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _376)].z > 0.0)
    {
        _477 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _464, level(0.0)).x;
    }
    else
    {
        _477 = 1.0;
    }
    float3 _491 = ((_427 - (_427 * _426)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _498 = (mix(float3(0.07999999821186065673828125 * _425), _427, float3(_426)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _501 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _506;
    if (_501)
    {
        _506 = _491 + (_498 * 0.449999988079071044921875);
    }
    else
    {
        _506 = _491;
    }
    float3 _508 = select(_498, float3(0.0), bool3(_501));
    float3 _510 = float3(dot(_508, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _527 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _464, level(0.0));
    float _543 = _527.x;
    float4 _545 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _464, level(0.0)) * 2.0) - float4(1.0)) * _543) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _546 = _527.y;
    float4 _548 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _464, level(0.0)) * 2.0) - float4(1.0)) * _546) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _549 = _527.z;
    float4 _551 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _464, level(0.0)) * 2.0) - float4(1.0)) * _549) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _568 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _464, level(0.0)) * 2.0) - float4(1.0)) * _543) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _570 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _464, level(0.0)) * 2.0) - float4(1.0)) * _546) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _572 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _464, level(0.0)) * 2.0) - float4(1.0)) * _549) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _605 = _188;
    _605.y = (-0.48860299587249755859375) * _428.y;
    float4 _608 = _605;
    _608.z = 0.48860299587249755859375 * _428.z;
    float4 _611 = _608;
    _611.w = (-0.48860299587249755859375) * _428.x;
    float3 _612 = _428 * _428;
    float4 _615 = _185;
    _615.x = (1.09254801273345947265625 * _428.x) * _428.y;
    float4 _618 = _615;
    _618.y = ((-1.09254801273345947265625) * _428.y) * _428.z;
    float4 _623 = _618;
    _623.z = 0.3153919875621795654296875 * ((3.0 * _612.z) - 1.0);
    float4 _626 = _623;
    _626.w = ((-1.09254801273345947265625) * _428.x) * _428.z;
    float4 _630 = _611;
    _630.x = 0.886227548122406005859375;
    float3 _632 = _630.yzw * 2.094395160675048828125;
    float4 _633 = float4(_630.x, _632.x, _632.y, _632.z);
    float4 _634 = _626 * 0.785398185253143310546875;
    float _635 = (_612.x - _612.y) * 0.4290426075458526611328125;
    float3 _641 = float3(0.0);
    _641.x = (dot(float4(_543, _545.xyz), _633) + dot(float4(_545.w, _568.xyz), _634)) + (_568.w * _635);
    float3 _647 = _641;
    _647.y = (dot(float4(_546, _548.xyz), _633) + dot(float4(_548.w, _570.xyz), _634)) + (_570.w * _635);
    float3 _653 = _647;
    _653.z = (dot(float4(_549, _551.xyz), _633) + dot(float4(_551.w, _572.xyz), _634)) + (_572.w * _635);
    float _682;
    float _683;
    float3 _684;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _669 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _464, level(0.0)).xyz * 2.0) - float3(1.0);
        float _670 = length(_669);
        float3 _673 = _669 / float3(fast::max(_670, 9.9999997473787516355514526367188e-05));
        float _674 = 1.0 - _670;
        float _676 = 1.0 - (_674 * _674);
        _682 = mix(fast::clamp(dot(_673, _428), 0.0, 1.0), 1.0, _676);
        _683 = _670;
        _684 = mix(_673, _428, float3(_676));
    }
    else
    {
        _682 = 1.0;
        _683 = 1.0;
        _684 = _428;
    }
    float4 _688 = float4(_684, 1.0);
    float3 _692 = _186;
    _692.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _688);
    float3 _696 = _692;
    _696.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _688);
    float3 _700 = _696;
    _700.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _688);
    float4 _703 = _688.xyzz * _688.yzzx;
    float3 _707 = _186;
    _707.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _703);
    float3 _711 = _707;
    _711.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _703);
    float3 _715 = _711;
    _715.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _703);
    float3 _730 = ((fast::max(float3(0.0), _653) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_700 + _715) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_684.x * _684.x) - (_684.y * _684.y)))) * View.View_SkyLightColor.xyz) * (_683 * _682));
    float3 _752 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _781;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _780;
        if (any(abs(_257 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _375 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _375 + 19u)].xyz + float3(1.0))))
        {
            _780 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_257, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _780 = _752;
        }
        _781 = _780;
    }
    else
    {
        _781 = _752;
    }
    float4 _788 = float4(((mix(float3(0.0), _506 + (_508 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_730 * _506) * fast::max(float3(1.0), ((((((_427 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_427 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_427 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _781) * 1.0, 0.0);
    float4 _795;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _794 = _788;
        _794.w = 0.0;
        _795 = _794;
    }
    else
    {
        _795 = _788;
    }
    float2 _799 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _807 = (_428 * 0.5) + float3(0.5);
    float4 _809 = float4(_807.x, _807.y, _807.z, float4(0.0).w);
    _809.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _376)].y;
    float4 _810 = float4(0.0);
    _810.x = _426;
    float4 _811 = _810;
    _811.y = _425;
    float4 _812 = _811;
    _812.z = _424;
    float4 _813 = _812;
    _813.w = 0.50588238239288330078125;
    float4 _825 = float4(_427.x, _427.y, _427.z, float4(0.0).w);
    _825.w = ((log2(((dot(_730, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_510 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_510 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_510 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_799.xyx * _799.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _795 * View.View_PreExposure;
    out.out_var_SV_Target1 = _809;
    out.out_var_SV_Target2 = _813;
    out.out_var_SV_Target3 = _825;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_477, 1.0, 1.0, 1.0);
    return out;
}

