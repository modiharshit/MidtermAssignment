

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
    spvUnsafeArray<float4, 4> Material_VectorExpressions;
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

fragment MainPS_out Main_00005307_5d117d69(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(11)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(12)]], texture2d<float> Material_Texture2D_0 [[texture(13)]], texture2d<float> Material_Texture2D_1 [[texture(14)]], texture2d<float> Material_Texture2D_2 [[texture(15)]], texture2d<float> Material_Texture2D_3 [[texture(16)]], texture2d<float> Material_Texture2D_4 [[texture(17)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], sampler Material_Texture2D_4Sampler [[sampler(6)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _248 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _252 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _257 = (_252.xyz / float3(_252.w)) - View.View_PreViewTranslation;
    float2 _258 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5;
    float4 _264 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _258, bias(View.View_MaterialTextureMipBias));
    float2 _267 = (_264.xy * float2(2.0)) - float2(1.0);
    float3 _283 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_267, sqrt(fast::clamp(1.0 - dot(_267, _267), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _295 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (_258 * float2(0.25)), bias(View.View_MaterialTextureMipBias));
    float2 _298 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 2.0;
    float4 _303 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (_298 * 0.2134999930858612060546875), bias(View.View_MaterialTextureMipBias));
    float4 _308 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (_298 * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float _335;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _335 = _248.w;
                break;
            }
            else
            {
                float _319 = _248.z;
                _335 = ((_319 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_319 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float4 _343 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _346 = mix(_303.x + 0.5, _308.x + 0.5, fast::min(fast::max((_335 - 24.0) * 0.0009765625, 0.0), 1.0)) * (_343.x + 0.5);
    float4 _351 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _258, bias(View.View_MaterialTextureMipBias));
    float4 _364 = Material_Texture2D_4.sample(Material_Texture2D_4Sampler, _258, bias(View.View_MaterialTextureMipBias));
    float3 _370 = fast::clamp(fast::min(fast::max(((_351.xyz * mix(0.60000002384185791015625, 1.0, _346)) * mix(0.1500000059604644775390625, 0.699999988079071044921875, _295.x)) * Material.Material_VectorExpressions[3].xyz, float3(0.0)), float3(1.0)), float3(0.0), float3(1.0));
    float _371 = fast::clamp(_364.y, 0.0, 1.0);
    float _376 = (fast::clamp(mix(-0.300000011920928955078125, 1.0, _364.x + (_346 * 0.20000000298023223876953125)), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _377 = in.in_var_PRIMITIVE_ID * 36u;
    uint _378 = _377 + 20u;
    float _426;
    float _427;
    float _428;
    float3 _429;
    float3 _430;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _378)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _396 = ((_248.xy / float2(_248.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _400 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _396, level(0.0));
        float4 _403 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _396, level(0.0));
        float4 _406 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _396, level(0.0));
        float _416 = _406.w;
        _426 = (_376 * _416) + _406.z;
        _427 = (0.5 * _416) + _406.y;
        _428 = _406.x;
        _429 = (_370 * _400.w) + _400.xyz;
        _430 = normalize((_283 * _403.w) + ((_403.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _426 = _376;
        _427 = 0.5;
        _428 = 0.0;
        _429 = _370;
        _430 = _283;
    }
    float3 _440 = fast::clamp((_257 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _451 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_440.x), int(_440.y), int(_440.z), 0).xyz), 0));
    float3 _466 = (((_451.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_440 / float3(_451.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _479;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _378)].z > 0.0)
    {
        _479 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _466, level(0.0)).x;
    }
    else
    {
        _479 = 1.0;
    }
    float3 _493 = ((_429 - (_429 * _428)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _500 = (mix(float3(0.07999999821186065673828125 * _427), _429, float3(_428)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _503 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _508;
    if (_503)
    {
        _508 = _493 + (_500 * 0.449999988079071044921875);
    }
    else
    {
        _508 = _493;
    }
    float3 _510 = select(_500, float3(0.0), bool3(_503));
    float3 _512 = float3(dot(_510, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _519 = float3(_371);
    float4 _530 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _466, level(0.0));
    float _546 = _530.x;
    float4 _548 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _466, level(0.0)) * 2.0) - float4(1.0)) * _546) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _549 = _530.y;
    float4 _551 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _466, level(0.0)) * 2.0) - float4(1.0)) * _549) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _552 = _530.z;
    float4 _554 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _466, level(0.0)) * 2.0) - float4(1.0)) * _552) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _571 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _466, level(0.0)) * 2.0) - float4(1.0)) * _546) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _573 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _466, level(0.0)) * 2.0) - float4(1.0)) * _549) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _575 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _466, level(0.0)) * 2.0) - float4(1.0)) * _552) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _608 = _188;
    _608.y = (-0.48860299587249755859375) * _430.y;
    float4 _611 = _608;
    _611.z = 0.48860299587249755859375 * _430.z;
    float4 _614 = _611;
    _614.w = (-0.48860299587249755859375) * _430.x;
    float3 _615 = _430 * _430;
    float4 _618 = _185;
    _618.x = (1.09254801273345947265625 * _430.x) * _430.y;
    float4 _621 = _618;
    _621.y = ((-1.09254801273345947265625) * _430.y) * _430.z;
    float4 _626 = _621;
    _626.z = 0.3153919875621795654296875 * ((3.0 * _615.z) - 1.0);
    float4 _629 = _626;
    _629.w = ((-1.09254801273345947265625) * _430.x) * _430.z;
    float4 _633 = _614;
    _633.x = 0.886227548122406005859375;
    float3 _635 = _633.yzw * 2.094395160675048828125;
    float4 _636 = float4(_633.x, _635.x, _635.y, _635.z);
    float4 _637 = _629 * 0.785398185253143310546875;
    float _638 = (_615.x - _615.y) * 0.4290426075458526611328125;
    float3 _644 = float3(0.0);
    _644.x = (dot(float4(_546, _548.xyz), _636) + dot(float4(_548.w, _571.xyz), _637)) + (_571.w * _638);
    float3 _650 = _644;
    _650.y = (dot(float4(_549, _551.xyz), _636) + dot(float4(_551.w, _573.xyz), _637)) + (_573.w * _638);
    float3 _656 = _650;
    _656.z = (dot(float4(_552, _554.xyz), _636) + dot(float4(_554.w, _575.xyz), _637)) + (_575.w * _638);
    float _685;
    float _686;
    float3 _687;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _672 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _466, level(0.0)).xyz * 2.0) - float3(1.0);
        float _673 = length(_672);
        float3 _676 = _672 / float3(fast::max(_673, 9.9999997473787516355514526367188e-05));
        float _677 = 1.0 - _673;
        float _679 = 1.0 - (_677 * _677);
        _685 = mix(fast::clamp(dot(_676, _430), 0.0, 1.0), 1.0, _679);
        _686 = _673;
        _687 = mix(_676, _430, float3(_679));
    }
    else
    {
        _685 = 1.0;
        _686 = 1.0;
        _687 = _430;
    }
    float4 _691 = float4(_687, 1.0);
    float3 _695 = _186;
    _695.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _691);
    float3 _699 = _695;
    _699.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _691);
    float3 _703 = _699;
    _703.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _691);
    float4 _706 = _691.xyzz * _691.yzzx;
    float3 _710 = _186;
    _710.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _706);
    float3 _714 = _710;
    _714.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _706);
    float3 _718 = _714;
    _718.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _706);
    float3 _733 = ((fast::max(float3(0.0), _656) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_703 + _718) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_687.x * _687.x) - (_687.y * _687.y)))) * View.View_SkyLightColor.xyz) * (_686 * _685));
    float3 _755 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _784;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _783;
        if (any(abs(_257 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _377 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _377 + 19u)].xyz + float3(1.0))))
        {
            _783 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_257, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _783 = _755;
        }
        _784 = _783;
    }
    else
    {
        _784 = _755;
    }
    float4 _791 = float4(((mix(float3(0.0), _508 + (_510 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_733 * _508) * fast::max(_519, ((((((_429 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _371) + ((_429 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _371) + ((_429 * 2.755199909210205078125) + float3(0.69029998779296875))) * _371))) + _784) * 1.0, 0.0);
    float4 _798;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _797 = _791;
        _797.w = 0.0;
        _798 = _797;
    }
    else
    {
        _798 = _791;
    }
    float2 _802 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _810 = (_430 * 0.5) + float3(0.5);
    float4 _812 = float4(_810.x, _810.y, _810.z, float4(0.0).w);
    _812.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _378)].y;
    float4 _813 = float4(0.0);
    _813.x = _428;
    float4 _814 = _813;
    _814.y = _427;
    float4 _815 = _814;
    _815.z = _426;
    float4 _816 = _815;
    _816.w = 0.50588238239288330078125;
    float4 _828 = float4(_429.x, _429.y, _429.z, float4(0.0).w);
    _828.w = ((log2(((dot(_733, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_519, ((((((_512 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _371) + ((_512 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _371) + ((_512 * 2.755199909210205078125) + float3(0.69029998779296875))) * _371).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_802.xyx * _802.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _798 * View.View_PreExposure;
    out.out_var_SV_Target1 = _812;
    out.out_var_SV_Target2 = _816;
    out.out_var_SV_Target3 = _828;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_479, 1.0, 1.0, 1.0);
    return out;
}

