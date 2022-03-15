

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
    char _m11_pad[80];
    float View_UnlitViewmodeMask;
    char _m12_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m13_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m14_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m16_pad[124];
    float View_ShowDecalsMask;
    char _m17_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m18_pad[48];
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

constant float4 _171 = {};
constant float3 _172 = {};
constant float _174 = {};
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

fragment MainPS_out Main_000046ee_5c04ef81(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(11)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(12)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _230 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _174, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _235 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _240 = (_235.xyz / float3(_235.w)) - View.View_PreViewTranslation;
    float3 _248 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _262 = fast::clamp(mix(float3(0.25), float3(0.569999992847442626953125, 0.3332314789295196533203125, 0.0342000015079975128173828125), float3(fast::min(fast::max(mix(-20.0, 20.0, in_var_TEXCOORD0[0].y), 0.0), 1.0))), float3(0.0), float3(1.0));
    float _266 = (0.20000000298023223876953125 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _267 = in.in_var_PRIMITIVE_ID * 36u;
    uint _268 = _267 + 20u;
    float _316;
    float _317;
    float _318;
    float3 _319;
    float3 _320;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _268)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _286 = ((_230.xy / float2(_230.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _290 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _286, level(0.0));
        float4 _293 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _286, level(0.0));
        float4 _296 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _286, level(0.0));
        float _306 = _296.w;
        _316 = (_266 * _306) + _296.z;
        _317 = (0.5 * _306) + _296.y;
        _318 = _296.x;
        _319 = (_262 * _290.w) + _290.xyz;
        _320 = normalize((_248 * _293.w) + ((_293.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _316 = _266;
        _317 = 0.5;
        _318 = 0.0;
        _319 = _262;
        _320 = _248;
    }
    float3 _330 = fast::clamp((_240 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _341 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_330.x), int(_330.y), int(_330.z), 0).xyz), 0));
    float3 _356 = (((_341.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_330 / float3(_341.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _369;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _268)].z > 0.0)
    {
        _369 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _356, level(0.0)).x;
    }
    else
    {
        _369 = 1.0;
    }
    float3 _383 = ((_319 - (_319 * _318)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _390 = (mix(float3(0.07999999821186065673828125 * _317), _319, float3(_318)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _393 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _398;
    if (_393)
    {
        _398 = _383 + (_390 * 0.449999988079071044921875);
    }
    else
    {
        _398 = _383;
    }
    float3 _400 = select(_390, float3(0.0), bool3(_393));
    float3 _402 = float3(dot(_400, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _419 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _356, level(0.0));
    float _435 = _419.x;
    float4 _437 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _356, level(0.0)) * 2.0) - float4(1.0)) * _435) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _438 = _419.y;
    float4 _440 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _356, level(0.0)) * 2.0) - float4(1.0)) * _438) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _441 = _419.z;
    float4 _443 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _356, level(0.0)) * 2.0) - float4(1.0)) * _441) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _460 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _356, level(0.0)) * 2.0) - float4(1.0)) * _435) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _462 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _356, level(0.0)) * 2.0) - float4(1.0)) * _438) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _464 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _356, level(0.0)) * 2.0) - float4(1.0)) * _441) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _497 = _175;
    _497.y = (-0.48860299587249755859375) * _320.y;
    float4 _500 = _497;
    _500.z = 0.48860299587249755859375 * _320.z;
    float4 _503 = _500;
    _503.w = (-0.48860299587249755859375) * _320.x;
    float3 _504 = _320 * _320;
    float4 _507 = _171;
    _507.x = (1.09254801273345947265625 * _320.x) * _320.y;
    float4 _510 = _507;
    _510.y = ((-1.09254801273345947265625) * _320.y) * _320.z;
    float4 _515 = _510;
    _515.z = 0.3153919875621795654296875 * ((3.0 * _504.z) - 1.0);
    float4 _518 = _515;
    _518.w = ((-1.09254801273345947265625) * _320.x) * _320.z;
    float4 _522 = _503;
    _522.x = 0.886227548122406005859375;
    float3 _524 = _522.yzw * 2.094395160675048828125;
    float4 _525 = float4(_522.x, _524.x, _524.y, _524.z);
    float4 _526 = _518 * 0.785398185253143310546875;
    float _527 = (_504.x - _504.y) * 0.4290426075458526611328125;
    float3 _533 = float3(0.0);
    _533.x = (dot(float4(_435, _437.xyz), _525) + dot(float4(_437.w, _460.xyz), _526)) + (_460.w * _527);
    float3 _539 = _533;
    _539.y = (dot(float4(_438, _440.xyz), _525) + dot(float4(_440.w, _462.xyz), _526)) + (_462.w * _527);
    float3 _545 = _539;
    _545.z = (dot(float4(_441, _443.xyz), _525) + dot(float4(_443.w, _464.xyz), _526)) + (_464.w * _527);
    float _574;
    float _575;
    float3 _576;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _561 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _356, level(0.0)).xyz * 2.0) - float3(1.0);
        float _562 = length(_561);
        float3 _565 = _561 / float3(fast::max(_562, 9.9999997473787516355514526367188e-05));
        float _566 = 1.0 - _562;
        float _568 = 1.0 - (_566 * _566);
        _574 = mix(fast::clamp(dot(_565, _320), 0.0, 1.0), 1.0, _568);
        _575 = _562;
        _576 = mix(_565, _320, float3(_568));
    }
    else
    {
        _574 = 1.0;
        _575 = 1.0;
        _576 = _320;
    }
    float4 _580 = float4(_576, 1.0);
    float3 _584 = _172;
    _584.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _580);
    float3 _588 = _584;
    _588.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _580);
    float3 _592 = _588;
    _592.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _580);
    float4 _595 = _580.xyzz * _580.yzzx;
    float3 _599 = _172;
    _599.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _595);
    float3 _603 = _599;
    _603.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _595);
    float3 _607 = _603;
    _607.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _595);
    float3 _622 = ((fast::max(float3(0.0), _545) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_592 + _607) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_576.x * _576.x) - (_576.y * _576.y)))) * View.View_SkyLightColor.xyz) * (_575 * _574));
    float3 _644 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _673;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _672;
        if (any(abs(_240 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _267 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _267 + 19u)].xyz + float3(1.0))))
        {
            _672 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_240, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _672 = _644;
        }
        _673 = _672;
    }
    else
    {
        _673 = _644;
    }
    float4 _680 = float4(((mix(float3(0.0), _398 + (_400 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_622 * _398) * fast::max(float3(1.0), ((((((_319 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_319 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_319 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _673) * 1.0, 0.0);
    float4 _687;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _686 = _680;
        _686.w = 0.0;
        _687 = _686;
    }
    else
    {
        _687 = _680;
    }
    float2 _691 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _699 = (_320 * 0.5) + float3(0.5);
    float4 _701 = float4(_699.x, _699.y, _699.z, float4(0.0).w);
    _701.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _268)].y;
    float4 _702 = float4(0.0);
    _702.x = _318;
    float4 _703 = _702;
    _703.y = _317;
    float4 _704 = _703;
    _704.z = _316;
    float4 _705 = _704;
    _705.w = 0.50588238239288330078125;
    float4 _717 = float4(_319.x, _319.y, _319.z, float4(0.0).w);
    _717.w = ((log2(((dot(_622, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_402 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_402 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_402 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_691.xyx * _691.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _687 * View.View_PreExposure;
    out.out_var_SV_Target1 = _701;
    out.out_var_SV_Target2 = _705;
    out.out_var_SV_Target3 = _717;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_369, 1.0, 1.0, 1.0);
    return out;
}

