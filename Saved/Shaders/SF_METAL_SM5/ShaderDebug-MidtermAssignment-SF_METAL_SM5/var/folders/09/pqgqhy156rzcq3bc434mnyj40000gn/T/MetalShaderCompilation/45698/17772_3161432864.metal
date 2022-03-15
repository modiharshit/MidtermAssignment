

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

struct type_Primitive
{
    char _m0_pad[80];
    float4 Primitive_ObjectWorldPositionAndRadius;
    char _m1_pad[208];
    float3 Primitive_ObjectBounds;
    float Primitive_DecalReceiverMask;
    float Primitive_PerObjectGBufferData;
    float Primitive_UseVolumetricLightmapShadowFromStationaryLights;
};

struct type_Material
{
    spvUnsafeArray<float4, 4> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _158 = {};
constant float3 _159 = {};
constant float _161 = {};
constant float4 _162 = {};

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
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_0000456c_bc6fa320(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(11)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(12)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _215 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _161, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _220 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _225 = (_220.xyz / float3(_220.w)) - View.View_PreViewTranslation;
    float3 _233 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _248 = fast::clamp(Material.Material_VectorExpressions[3].xyz, float3(0.0), float3(1.0));
    float _249 = fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0);
    float _254 = (fast::clamp(Material.Material_ScalarExpressions[0].z, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _301;
    float _302;
    float _303;
    float3 _304;
    float3 _305;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _271 = ((_215.xy / float2(_215.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _275 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _271, level(0.0));
        float4 _278 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _271, level(0.0));
        float4 _281 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _271, level(0.0));
        float _291 = _281.w;
        _301 = (_254 * _291) + _281.z;
        _302 = (_249 * _291) + _281.y;
        _303 = _281.x;
        _304 = (_248 * _275.w) + _275.xyz;
        _305 = normalize((_233 * _278.w) + ((_278.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _301 = _254;
        _302 = _249;
        _303 = 0.0;
        _304 = _248;
        _305 = _233;
    }
    float3 _315 = fast::clamp((_225 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _326 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_315.x), int(_315.y), int(_315.z), 0).xyz), 0));
    float3 _341 = (((_326.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_315 / float3(_326.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _354;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        _354 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _341, level(0.0)).x;
    }
    else
    {
        _354 = 1.0;
    }
    float3 _368 = ((_304 - (_304 * _303)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _375 = (mix(float3(0.07999999821186065673828125 * _302), _304, float3(_303)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _378 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _383;
    if (_378)
    {
        _383 = _368 + (_375 * 0.449999988079071044921875);
    }
    else
    {
        _383 = _368;
    }
    float3 _385 = select(_375, float3(0.0), bool3(_378));
    float3 _387 = float3(dot(_385, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _404 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _341, level(0.0));
    float _420 = _404.x;
    float4 _422 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _341, level(0.0)) * 2.0) - float4(1.0)) * _420) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _423 = _404.y;
    float4 _425 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _341, level(0.0)) * 2.0) - float4(1.0)) * _423) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _426 = _404.z;
    float4 _428 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _341, level(0.0)) * 2.0) - float4(1.0)) * _426) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _445 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _341, level(0.0)) * 2.0) - float4(1.0)) * _420) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _447 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _341, level(0.0)) * 2.0) - float4(1.0)) * _423) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _449 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _341, level(0.0)) * 2.0) - float4(1.0)) * _426) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _482 = _162;
    _482.y = (-0.48860299587249755859375) * _305.y;
    float4 _485 = _482;
    _485.z = 0.48860299587249755859375 * _305.z;
    float4 _488 = _485;
    _488.w = (-0.48860299587249755859375) * _305.x;
    float3 _489 = _305 * _305;
    float4 _492 = _158;
    _492.x = (1.09254801273345947265625 * _305.x) * _305.y;
    float4 _495 = _492;
    _495.y = ((-1.09254801273345947265625) * _305.y) * _305.z;
    float4 _500 = _495;
    _500.z = 0.3153919875621795654296875 * ((3.0 * _489.z) - 1.0);
    float4 _503 = _500;
    _503.w = ((-1.09254801273345947265625) * _305.x) * _305.z;
    float4 _507 = _488;
    _507.x = 0.886227548122406005859375;
    float3 _509 = _507.yzw * 2.094395160675048828125;
    float4 _510 = float4(_507.x, _509.x, _509.y, _509.z);
    float4 _511 = _503 * 0.785398185253143310546875;
    float _512 = (_489.x - _489.y) * 0.4290426075458526611328125;
    float3 _518 = float3(0.0);
    _518.x = (dot(float4(_420, _422.xyz), _510) + dot(float4(_422.w, _445.xyz), _511)) + (_445.w * _512);
    float3 _524 = _518;
    _524.y = (dot(float4(_423, _425.xyz), _510) + dot(float4(_425.w, _447.xyz), _511)) + (_447.w * _512);
    float3 _530 = _524;
    _530.z = (dot(float4(_426, _428.xyz), _510) + dot(float4(_428.w, _449.xyz), _511)) + (_449.w * _512);
    float _559;
    float _560;
    float3 _561;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _546 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _341, level(0.0)).xyz * 2.0) - float3(1.0);
        float _547 = length(_546);
        float3 _550 = _546 / float3(fast::max(_547, 9.9999997473787516355514526367188e-05));
        float _551 = 1.0 - _547;
        float _553 = 1.0 - (_551 * _551);
        _559 = mix(fast::clamp(dot(_550, _305), 0.0, 1.0), 1.0, _553);
        _560 = _547;
        _561 = mix(_550, _305, float3(_553));
    }
    else
    {
        _559 = 1.0;
        _560 = 1.0;
        _561 = _305;
    }
    float4 _565 = float4(_561, 1.0);
    float3 _569 = _159;
    _569.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _565);
    float3 _573 = _569;
    _573.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _565);
    float3 _577 = _573;
    _577.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _565);
    float4 _580 = _565.xyzz * _565.yzzx;
    float3 _584 = _159;
    _584.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _580);
    float3 _588 = _584;
    _588.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _580);
    float3 _592 = _588;
    _592.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _580);
    float3 _607 = ((fast::max(float3(0.0), _530) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_577 + _592) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_561.x * _561.x) - (_561.y * _561.y)))) * View.View_SkyLightColor.xyz) * (_560 * _559));
    float3 _629 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _655;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _654;
        if (any(abs(_225 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _654 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_225, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _654 = _629;
        }
        _655 = _654;
    }
    else
    {
        _655 = _629;
    }
    float4 _662 = float4(((mix(float3(0.0), _383 + (_385 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_607 * _383) * fast::max(float3(1.0), ((((((_304 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_304 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_304 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _655) * 1.0, 0.0);
    float4 _669;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _668 = _662;
        _668.w = 0.0;
        _669 = _668;
    }
    else
    {
        _669 = _662;
    }
    float2 _673 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _681 = (_305 * 0.5) + float3(0.5);
    float4 _683 = float4(_681.x, _681.y, _681.z, float4(0.0).w);
    _683.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _684 = float4(0.0);
    _684.x = _303;
    float4 _685 = _684;
    _685.y = _302;
    float4 _686 = _685;
    _686.z = _301;
    float4 _687 = _686;
    _687.w = 0.50588238239288330078125;
    float4 _699 = float4(_304.x, _304.y, _304.z, float4(0.0).w);
    _699.w = ((log2(((dot(_607, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_387 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_387 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_387 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_673.xyx * _673.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _669 * View.View_PreExposure;
    out.out_var_SV_Target1 = _683;
    out.out_var_SV_Target2 = _687;
    out.out_var_SV_Target3 = _699;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_354, 1.0, 1.0, 1.0);
    return out;
}

