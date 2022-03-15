

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
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _183 = {};
constant float3 _184 = {};
constant float4 _186 = {};

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

fragment MainPS_out Main_000051cf_213b4688(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(11)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(12)]], texture2d<float> Material_Texture2D_0 [[texture(13)]], texture2d<float> Material_Texture2D_1 [[texture(14)]], texture2d<float> Material_Texture2D_2 [[texture(15)]], texture2d<float> Material_Texture2D_3 [[texture(16)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _246 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _250 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _255 = (_250.xyz / float3(_250.w)) - View.View_PreViewTranslation;
    float4 _261 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _264 = (_261.xy * float2(2.0)) - float2(1.0);
    float4 _276 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _303;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _303 = _246.w;
                break;
            }
            else
            {
                float _287 = _246.z;
                _303 = ((_287 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_287 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _319 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(float4(_264, sqrt(fast::clamp(1.0 - dot(_264, _264), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _276.x) + _303) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _331 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _336 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _341 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _345 = (_331.x + 0.5) * ((_336.x + 0.5) * (_341.x + 0.5));
    float4 _351 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _357 = fast::clamp(mix(float3(0.20000000298023223876953125), float3(1.0), float3(_345)) * _351.xyz, float3(0.0), float3(1.0));
    float _362 = (fast::clamp(mix(0.800000011920928955078125, 0.300000011920928955078125, _345 * _351.w), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _363 = in.in_var_PRIMITIVE_ID * 36u;
    uint _364 = _363 + 20u;
    float _412;
    float _413;
    float _414;
    float3 _415;
    float3 _416;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _364)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _382 = ((_246.xy / float2(_246.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _386 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _382, level(0.0));
        float4 _389 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _382, level(0.0));
        float4 _392 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _382, level(0.0));
        float _402 = _392.w;
        _412 = (_362 * _402) + _392.z;
        _413 = (0.5 * _402) + _392.y;
        _414 = _392.x;
        _415 = (_357 * _386.w) + _386.xyz;
        _416 = normalize((_319 * _389.w) + ((_389.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _412 = _362;
        _413 = 0.5;
        _414 = 0.0;
        _415 = _357;
        _416 = _319;
    }
    float3 _426 = fast::clamp((_255 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _437 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_426.x), int(_426.y), int(_426.z), 0).xyz), 0));
    float3 _452 = (((_437.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_426 / float3(_437.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _465;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _364)].z > 0.0)
    {
        _465 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _452, level(0.0)).x;
    }
    else
    {
        _465 = 1.0;
    }
    float3 _479 = ((_415 - (_415 * _414)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _486 = (mix(float3(0.07999999821186065673828125 * _413), _415, float3(_414)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _489 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _494;
    if (_489)
    {
        _494 = _479 + (_486 * 0.449999988079071044921875);
    }
    else
    {
        _494 = _479;
    }
    float3 _496 = select(_486, float3(0.0), bool3(_489));
    float3 _498 = float3(dot(_496, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _515 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _452, level(0.0));
    float _531 = _515.x;
    float4 _533 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _452, level(0.0)) * 2.0) - float4(1.0)) * _531) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _534 = _515.y;
    float4 _536 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _452, level(0.0)) * 2.0) - float4(1.0)) * _534) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _537 = _515.z;
    float4 _539 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _452, level(0.0)) * 2.0) - float4(1.0)) * _537) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _556 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _452, level(0.0)) * 2.0) - float4(1.0)) * _531) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _558 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _452, level(0.0)) * 2.0) - float4(1.0)) * _534) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _560 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _452, level(0.0)) * 2.0) - float4(1.0)) * _537) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _593 = _186;
    _593.y = (-0.48860299587249755859375) * _416.y;
    float4 _596 = _593;
    _596.z = 0.48860299587249755859375 * _416.z;
    float4 _599 = _596;
    _599.w = (-0.48860299587249755859375) * _416.x;
    float3 _600 = _416 * _416;
    float4 _603 = _183;
    _603.x = (1.09254801273345947265625 * _416.x) * _416.y;
    float4 _606 = _603;
    _606.y = ((-1.09254801273345947265625) * _416.y) * _416.z;
    float4 _611 = _606;
    _611.z = 0.3153919875621795654296875 * ((3.0 * _600.z) - 1.0);
    float4 _614 = _611;
    _614.w = ((-1.09254801273345947265625) * _416.x) * _416.z;
    float4 _618 = _599;
    _618.x = 0.886227548122406005859375;
    float3 _620 = _618.yzw * 2.094395160675048828125;
    float4 _621 = float4(_618.x, _620.x, _620.y, _620.z);
    float4 _622 = _614 * 0.785398185253143310546875;
    float _623 = (_600.x - _600.y) * 0.4290426075458526611328125;
    float3 _629 = float3(0.0);
    _629.x = (dot(float4(_531, _533.xyz), _621) + dot(float4(_533.w, _556.xyz), _622)) + (_556.w * _623);
    float3 _635 = _629;
    _635.y = (dot(float4(_534, _536.xyz), _621) + dot(float4(_536.w, _558.xyz), _622)) + (_558.w * _623);
    float3 _641 = _635;
    _641.z = (dot(float4(_537, _539.xyz), _621) + dot(float4(_539.w, _560.xyz), _622)) + (_560.w * _623);
    float _670;
    float _671;
    float3 _672;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _657 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _452, level(0.0)).xyz * 2.0) - float3(1.0);
        float _658 = length(_657);
        float3 _661 = _657 / float3(fast::max(_658, 9.9999997473787516355514526367188e-05));
        float _662 = 1.0 - _658;
        float _664 = 1.0 - (_662 * _662);
        _670 = mix(fast::clamp(dot(_661, _416), 0.0, 1.0), 1.0, _664);
        _671 = _658;
        _672 = mix(_661, _416, float3(_664));
    }
    else
    {
        _670 = 1.0;
        _671 = 1.0;
        _672 = _416;
    }
    float4 _676 = float4(_672, 1.0);
    float3 _680 = _184;
    _680.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _676);
    float3 _684 = _680;
    _684.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _676);
    float3 _688 = _684;
    _688.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _676);
    float4 _691 = _676.xyzz * _676.yzzx;
    float3 _695 = _184;
    _695.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _691);
    float3 _699 = _695;
    _699.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _691);
    float3 _703 = _699;
    _703.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _691);
    float3 _718 = ((fast::max(float3(0.0), _641) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_688 + _703) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_672.x * _672.x) - (_672.y * _672.y)))) * View.View_SkyLightColor.xyz) * (_671 * _670));
    float3 _740 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _769;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _768;
        if (any(abs(_255 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _363 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _363 + 19u)].xyz + float3(1.0))))
        {
            _768 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_255, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _768 = _740;
        }
        _769 = _768;
    }
    else
    {
        _769 = _740;
    }
    float4 _776 = float4(((mix(float3(0.0), _494 + (_496 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_718 * _494) * fast::max(float3(1.0), ((((((_415 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_415 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_415 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _769) * 1.0, 0.0);
    float4 _783;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _782 = _776;
        _782.w = 0.0;
        _783 = _782;
    }
    else
    {
        _783 = _776;
    }
    float2 _787 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _795 = (_416 * 0.5) + float3(0.5);
    float4 _797 = float4(_795.x, _795.y, _795.z, float4(0.0).w);
    _797.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _364)].y;
    float4 _798 = float4(0.0);
    _798.x = _414;
    float4 _799 = _798;
    _799.y = _413;
    float4 _800 = _799;
    _800.z = _412;
    float4 _801 = _800;
    _801.w = 0.50588238239288330078125;
    float4 _813 = float4(_415.x, _415.y, _415.z, float4(0.0).w);
    _813.w = ((log2(((dot(_718, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_498 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_498 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_498 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_787.xyx * _787.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _783 * View.View_PreExposure;
    out.out_var_SV_Target1 = _797;
    out.out_var_SV_Target2 = _801;
    out.out_var_SV_Target3 = _813;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_465, 1.0, 1.0, 1.0);
    return out;
}

