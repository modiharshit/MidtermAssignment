

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

constant float4 _182 = {};
constant float3 _183 = {};
constant float4 _185 = {};

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

fragment MainPS_out Main_0000537f_41c55f25(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(11)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(12)]], texture2d<float> Material_Texture2D_0 [[texture(13)]], texture2d<float> Material_Texture2D_1 [[texture(14)]], texture2d<float> Material_Texture2D_2 [[texture(15)]], texture2d<float> Material_Texture2D_3 [[texture(16)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _245 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _249 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _253 = _249.xyz / float3(_249.w);
    float3 _254 = _253 - View.View_PreViewTranslation;
    float4 _262 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _265 = (_262.xy * float2(2.0)) - float2(1.0);
    float4 _277 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _304;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _304 = _245.w;
                break;
            }
            else
            {
                float _288 = _245.z;
                _304 = ((_288 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_288 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _320 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(float4(_265, sqrt(fast::clamp(1.0 - dot(_265, _265), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _277.x) + _304) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _332 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _337 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _342 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _346 = (_332.x + 0.5) * ((_337.x + 0.5) * (_342.x + 0.5));
    float4 _350 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _352 = _350.xyz * _346;
    float _354 = _352.x;
    float _358 = _352.y;
    float _362 = _352.z;
    float _371 = fast::max(abs(1.0 - fast::max(0.0, dot(in.in_var_TEXCOORD11_centroid.xyz, normalize(-_253)))), 9.9999997473787516355514526367188e-05);
    float3 _380 = fast::clamp(mix(_352 * 0.5, float3((_354 <= 0.0) ? 0.0 : pow(_354, 0.4000000059604644775390625), (_358 <= 0.0) ? 0.0 : pow(_358, 0.4000000059604644775390625), (_362 <= 0.0) ? 0.0 : pow(_362, 0.4000000059604644775390625)), float3((_371 <= 0.0) ? 0.0 : pow(_371, 3.0))), float3(0.0), float3(1.0));
    float _385 = (fast::clamp(mix(0.89999997615814208984375, 0.5, _346 * _350.w), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _386 = in.in_var_PRIMITIVE_ID * 36u;
    uint _387 = _386 + 20u;
    float _435;
    float _436;
    float _437;
    float3 _438;
    float3 _439;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _387)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _405 = ((_245.xy / float2(_245.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _409 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _405, level(0.0));
        float4 _412 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _405, level(0.0));
        float4 _415 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _405, level(0.0));
        float _425 = _415.w;
        _435 = (_385 * _425) + _415.z;
        _436 = (0.5 * _425) + _415.y;
        _437 = _415.x;
        _438 = (_380 * _409.w) + _409.xyz;
        _439 = normalize((_320 * _412.w) + ((_412.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _435 = _385;
        _436 = 0.5;
        _437 = 0.0;
        _438 = _380;
        _439 = _320;
    }
    float3 _449 = fast::clamp((_254 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _460 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_449.x), int(_449.y), int(_449.z), 0).xyz), 0));
    float3 _475 = (((_460.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_449 / float3(_460.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _488;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _387)].z > 0.0)
    {
        _488 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _475, level(0.0)).x;
    }
    else
    {
        _488 = 1.0;
    }
    float3 _502 = ((_438 - (_438 * _437)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _509 = (mix(float3(0.07999999821186065673828125 * _436), _438, float3(_437)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _512 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _517;
    if (_512)
    {
        _517 = _502 + (_509 * 0.449999988079071044921875);
    }
    else
    {
        _517 = _502;
    }
    float3 _519 = select(_509, float3(0.0), bool3(_512));
    float3 _521 = float3(dot(_519, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _538 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _475, level(0.0));
    float _554 = _538.x;
    float4 _556 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _475, level(0.0)) * 2.0) - float4(1.0)) * _554) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _557 = _538.y;
    float4 _559 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _475, level(0.0)) * 2.0) - float4(1.0)) * _557) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _560 = _538.z;
    float4 _562 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _475, level(0.0)) * 2.0) - float4(1.0)) * _560) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _579 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _475, level(0.0)) * 2.0) - float4(1.0)) * _554) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _581 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _475, level(0.0)) * 2.0) - float4(1.0)) * _557) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _583 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _475, level(0.0)) * 2.0) - float4(1.0)) * _560) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _616 = _185;
    _616.y = (-0.48860299587249755859375) * _439.y;
    float4 _619 = _616;
    _619.z = 0.48860299587249755859375 * _439.z;
    float4 _622 = _619;
    _622.w = (-0.48860299587249755859375) * _439.x;
    float3 _623 = _439 * _439;
    float4 _626 = _182;
    _626.x = (1.09254801273345947265625 * _439.x) * _439.y;
    float4 _629 = _626;
    _629.y = ((-1.09254801273345947265625) * _439.y) * _439.z;
    float4 _634 = _629;
    _634.z = 0.3153919875621795654296875 * ((3.0 * _623.z) - 1.0);
    float4 _637 = _634;
    _637.w = ((-1.09254801273345947265625) * _439.x) * _439.z;
    float4 _641 = _622;
    _641.x = 0.886227548122406005859375;
    float3 _643 = _641.yzw * 2.094395160675048828125;
    float4 _644 = float4(_641.x, _643.x, _643.y, _643.z);
    float4 _645 = _637 * 0.785398185253143310546875;
    float _646 = (_623.x - _623.y) * 0.4290426075458526611328125;
    float3 _652 = float3(0.0);
    _652.x = (dot(float4(_554, _556.xyz), _644) + dot(float4(_556.w, _579.xyz), _645)) + (_579.w * _646);
    float3 _658 = _652;
    _658.y = (dot(float4(_557, _559.xyz), _644) + dot(float4(_559.w, _581.xyz), _645)) + (_581.w * _646);
    float3 _664 = _658;
    _664.z = (dot(float4(_560, _562.xyz), _644) + dot(float4(_562.w, _583.xyz), _645)) + (_583.w * _646);
    float _693;
    float _694;
    float3 _695;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _680 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _475, level(0.0)).xyz * 2.0) - float3(1.0);
        float _681 = length(_680);
        float3 _684 = _680 / float3(fast::max(_681, 9.9999997473787516355514526367188e-05));
        float _685 = 1.0 - _681;
        float _687 = 1.0 - (_685 * _685);
        _693 = mix(fast::clamp(dot(_684, _439), 0.0, 1.0), 1.0, _687);
        _694 = _681;
        _695 = mix(_684, _439, float3(_687));
    }
    else
    {
        _693 = 1.0;
        _694 = 1.0;
        _695 = _439;
    }
    float4 _699 = float4(_695, 1.0);
    float3 _703 = _183;
    _703.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _699);
    float3 _707 = _703;
    _707.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _699);
    float3 _711 = _707;
    _711.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _699);
    float4 _714 = _699.xyzz * _699.yzzx;
    float3 _718 = _183;
    _718.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _714);
    float3 _722 = _718;
    _722.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _714);
    float3 _726 = _722;
    _726.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _714);
    float3 _741 = ((fast::max(float3(0.0), _664) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_711 + _726) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_695.x * _695.x) - (_695.y * _695.y)))) * View.View_SkyLightColor.xyz) * (_694 * _693));
    float3 _763 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _792;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _791;
        if (any(abs(_254 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _386 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _386 + 19u)].xyz + float3(1.0))))
        {
            _791 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_254, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _791 = _763;
        }
        _792 = _791;
    }
    else
    {
        _792 = _763;
    }
    float4 _799 = float4(((mix(float3(0.0), _517 + (_519 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_741 * _517) * fast::max(float3(1.0), ((((((_438 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_438 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_438 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _792) * 1.0, 0.0);
    float4 _806;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _805 = _799;
        _805.w = 0.0;
        _806 = _805;
    }
    else
    {
        _806 = _799;
    }
    float2 _810 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _818 = (_439 * 0.5) + float3(0.5);
    float4 _820 = float4(_818.x, _818.y, _818.z, float4(0.0).w);
    _820.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _387)].y;
    float4 _821 = float4(0.0);
    _821.x = _437;
    float4 _822 = _821;
    _822.y = _436;
    float4 _823 = _822;
    _823.z = _435;
    float4 _824 = _823;
    _824.w = 0.50588238239288330078125;
    float4 _836 = float4(_438.x, _438.y, _438.z, float4(0.0).w);
    _836.w = ((log2(((dot(_741, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_521 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_521 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_521 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_810.xyx * _810.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _806 * View.View_PreExposure;
    out.out_var_SV_Target1 = _820;
    out.out_var_SV_Target2 = _824;
    out.out_var_SV_Target3 = _836;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_488, 1.0, 1.0, 1.0);
    return out;
}

