

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
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _175 = {};
constant float3 _176 = {};
constant float4 _178 = {};

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
    float4 in_var_TEXCOORD2 [[user(locn2)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00004e03_c4a1305a(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(11)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(12)]], texture2d<float> Material_Texture2D_0 [[texture(13)]], texture2d<float> Material_Texture2D_1 [[texture(14)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _237 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _241 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _246 = (_241.xyz / float3(_241.w)) - View.View_PreViewTranslation;
    float4 _254 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (in.in_var_TEXCOORD2.xy * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _257 = (_254.xy * float2(2.0)) - float2(1.0);
    float3 _274 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize(((float4(_257, sqrt(fast::clamp(1.0 - dot(_257, _257), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _286 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in.in_var_TEXCOORD2.xy * 20.0), bias(View.View_MaterialTextureMipBias));
    float _288 = mix(0.4000000059604644775390625, 1.0, _286.x);
    float4 _292 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in.in_var_TEXCOORD2.xy * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _317;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _317 = _237.w;
                break;
            }
            else
            {
                float _301 = _237.z;
                _317 = ((_301 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_301 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _321 = fast::min(fast::max((_317 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _322 = _292.y;
    float4 _326 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in.in_var_TEXCOORD2.xy * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _328 = _326.y;
    float3 _341 = fast::clamp(float3(mix(_288, 1.0 - _288, mix(_322, 1.0, _321)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_328 + mix(_322, 0.0, _321), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _346 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _328) + mix(mix(0.699999988079071044921875, 1.0, _322), 1.0, _321), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _393;
    float _394;
    float _395;
    float3 _396;
    float3 _397;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _363 = ((_237.xy / float2(_237.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _367 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _363, level(0.0));
        float4 _370 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _363, level(0.0));
        float4 _373 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _363, level(0.0));
        float _383 = _373.w;
        _393 = (_346 * _383) + _373.z;
        _394 = (0.5 * _383) + _373.y;
        _395 = _373.x;
        _396 = (_341 * _367.w) + _367.xyz;
        _397 = normalize((_274 * _370.w) + ((_370.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _393 = _346;
        _394 = 0.5;
        _395 = 0.0;
        _396 = _341;
        _397 = _274;
    }
    float3 _407 = fast::clamp((_246 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _418 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_407.x), int(_407.y), int(_407.z), 0).xyz), 0));
    float3 _433 = (((_418.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_407 / float3(_418.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _446;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        _446 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _433, level(0.0)).x;
    }
    else
    {
        _446 = 1.0;
    }
    float3 _460 = ((_396 - (_396 * _395)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _467 = (mix(float3(0.07999999821186065673828125 * _394), _396, float3(_395)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _470 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _475;
    if (_470)
    {
        _475 = _460 + (_467 * 0.449999988079071044921875);
    }
    else
    {
        _475 = _460;
    }
    float3 _477 = select(_467, float3(0.0), bool3(_470));
    float3 _479 = float3(dot(_477, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _496 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _433, level(0.0));
    float _512 = _496.x;
    float4 _514 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _433, level(0.0)) * 2.0) - float4(1.0)) * _512) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _515 = _496.y;
    float4 _517 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _433, level(0.0)) * 2.0) - float4(1.0)) * _515) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _518 = _496.z;
    float4 _520 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _433, level(0.0)) * 2.0) - float4(1.0)) * _518) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _537 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _433, level(0.0)) * 2.0) - float4(1.0)) * _512) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _539 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _433, level(0.0)) * 2.0) - float4(1.0)) * _515) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _541 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _433, level(0.0)) * 2.0) - float4(1.0)) * _518) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _574 = _178;
    _574.y = (-0.48860299587249755859375) * _397.y;
    float4 _577 = _574;
    _577.z = 0.48860299587249755859375 * _397.z;
    float4 _580 = _577;
    _580.w = (-0.48860299587249755859375) * _397.x;
    float3 _581 = _397 * _397;
    float4 _584 = _175;
    _584.x = (1.09254801273345947265625 * _397.x) * _397.y;
    float4 _587 = _584;
    _587.y = ((-1.09254801273345947265625) * _397.y) * _397.z;
    float4 _592 = _587;
    _592.z = 0.3153919875621795654296875 * ((3.0 * _581.z) - 1.0);
    float4 _595 = _592;
    _595.w = ((-1.09254801273345947265625) * _397.x) * _397.z;
    float4 _599 = _580;
    _599.x = 0.886227548122406005859375;
    float3 _601 = _599.yzw * 2.094395160675048828125;
    float4 _602 = float4(_599.x, _601.x, _601.y, _601.z);
    float4 _603 = _595 * 0.785398185253143310546875;
    float _604 = (_581.x - _581.y) * 0.4290426075458526611328125;
    float3 _610 = float3(0.0);
    _610.x = (dot(float4(_512, _514.xyz), _602) + dot(float4(_514.w, _537.xyz), _603)) + (_537.w * _604);
    float3 _616 = _610;
    _616.y = (dot(float4(_515, _517.xyz), _602) + dot(float4(_517.w, _539.xyz), _603)) + (_539.w * _604);
    float3 _622 = _616;
    _622.z = (dot(float4(_518, _520.xyz), _602) + dot(float4(_520.w, _541.xyz), _603)) + (_541.w * _604);
    float _651;
    float _652;
    float3 _653;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _638 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _433, level(0.0)).xyz * 2.0) - float3(1.0);
        float _639 = length(_638);
        float3 _642 = _638 / float3(fast::max(_639, 9.9999997473787516355514526367188e-05));
        float _643 = 1.0 - _639;
        float _645 = 1.0 - (_643 * _643);
        _651 = mix(fast::clamp(dot(_642, _397), 0.0, 1.0), 1.0, _645);
        _652 = _639;
        _653 = mix(_642, _397, float3(_645));
    }
    else
    {
        _651 = 1.0;
        _652 = 1.0;
        _653 = _397;
    }
    float4 _657 = float4(_653, 1.0);
    float3 _661 = _176;
    _661.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _657);
    float3 _665 = _661;
    _665.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _657);
    float3 _669 = _665;
    _669.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _657);
    float4 _672 = _657.xyzz * _657.yzzx;
    float3 _676 = _176;
    _676.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _672);
    float3 _680 = _676;
    _680.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _672);
    float3 _684 = _680;
    _684.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _672);
    float3 _699 = ((fast::max(float3(0.0), _622) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_669 + _684) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_653.x * _653.x) - (_653.y * _653.y)))) * View.View_SkyLightColor.xyz) * (_652 * _651));
    float3 _721 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _747;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _746;
        if (any(abs(_246 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _746 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_246, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _746 = _721;
        }
        _747 = _746;
    }
    else
    {
        _747 = _721;
    }
    float4 _754 = float4(((mix(float3(0.0), _475 + (_477 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_699 * _475) * fast::max(float3(1.0), ((((((_396 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_396 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_396 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _747) * 1.0, 0.0);
    float4 _761;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _760 = _754;
        _760.w = 0.0;
        _761 = _760;
    }
    else
    {
        _761 = _754;
    }
    float2 _765 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _773 = (_397 * 0.5) + float3(0.5);
    float4 _775 = float4(_773.x, _773.y, _773.z, float4(0.0).w);
    _775.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _776 = float4(0.0);
    _776.x = _395;
    float4 _777 = _776;
    _777.y = _394;
    float4 _778 = _777;
    _778.z = _393;
    float4 _779 = _778;
    _779.w = 0.50588238239288330078125;
    float4 _791 = float4(_396.x, _396.y, _396.z, float4(0.0).w);
    _791.w = ((log2(((dot(_699, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_479 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_479 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_479 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_765.xyx * _765.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _761 * View.View_PreExposure;
    out.out_var_SV_Target1 = _775;
    out.out_var_SV_Target2 = _779;
    out.out_var_SV_Target3 = _791;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_446, 1.0, 1.0, 1.0);
    return out;
}

