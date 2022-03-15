

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

struct type_LandscapeParameters
{
    char _m0_pad[144];
    float4x4 LandscapeParameters_LocalToWorldNoScaling;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _181 = {};
constant float3 _182 = {};
constant float4 _184 = {};

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
    float2 in_var_TEXCOORD0 [[user(locn0)]];
    float4 in_var_TEXCOORD1 [[user(locn1)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_0000512e_08b3dd46(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_LandscapeParameters& LandscapeParameters [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(11)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(12)]], texture2d<float> LandscapeParameters_NormalmapTexture [[texture(13)]], texture2d<float> Material_Texture2D_0 [[texture(14)]], texture2d<float> Material_Texture2D_1 [[texture(15)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler LandscapeParameters_NormalmapTextureSampler [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _228 = LandscapeParameters_NormalmapTexture.sample(LandscapeParameters_NormalmapTextureSampler, in.in_var_TEXCOORD1.zw);
    float2 _233 = (float2(_228.zw) * float2(2.0)) - float2(1.0);
    float _237 = sqrt(fast::max(1.0 - dot(_233, _233), 0.0));
    float _238 = _233.x;
    float3 _240 = float3(_238, _233.y, _237);
    float3 _243 = normalize(float3(_237, 0.0, -_238));
    float4 _267 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _271 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _276 = (_271.xyz / float3(_271.w)) - View.View_PreViewTranslation;
    float4 _284 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (in.in_var_TEXCOORD0 * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _287 = (_284.xy * float2(2.0)) - float2(1.0);
    float3 _304 = normalize((float3x3(LandscapeParameters.LandscapeParameters_LocalToWorldNoScaling[0].xyz, LandscapeParameters.LandscapeParameters_LocalToWorldNoScaling[1].xyz, LandscapeParameters.LandscapeParameters_LocalToWorldNoScaling[2].xyz) * float3x3(_243, cross(_240, _243), _240)) * normalize(((float4(_287, sqrt(fast::clamp(1.0 - dot(_287, _287), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _316 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in.in_var_TEXCOORD0 * 20.0), bias(View.View_MaterialTextureMipBias));
    float _318 = mix(0.4000000059604644775390625, 1.0, _316.x);
    float4 _322 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in.in_var_TEXCOORD0 * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _347;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _347 = _267.w;
                break;
            }
            else
            {
                float _331 = _267.z;
                _347 = ((_331 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_331 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _351 = fast::min(fast::max((_347 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _352 = _322.y;
    float4 _356 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in.in_var_TEXCOORD0 * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _358 = _356.y;
    float3 _371 = fast::clamp(float3(mix(_318, 1.0 - _318, mix(_352, 1.0, _351)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_358 + mix(_352, 0.0, _351), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _376 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _358) + mix(mix(0.699999988079071044921875, 1.0, _352), 1.0, _351), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _423;
    float _424;
    float _425;
    float3 _426;
    float3 _427;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _393 = ((_267.xy / float2(_267.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _397 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _393, level(0.0));
        float4 _400 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _393, level(0.0));
        float4 _403 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _393, level(0.0));
        float _413 = _403.w;
        _423 = (_376 * _413) + _403.z;
        _424 = (0.5 * _413) + _403.y;
        _425 = _403.x;
        _426 = (_371 * _397.w) + _397.xyz;
        _427 = normalize((_304 * _400.w) + ((_400.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _423 = _376;
        _424 = 0.5;
        _425 = 0.0;
        _426 = _371;
        _427 = _304;
    }
    float3 _437 = fast::clamp((_276 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _448 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_437.x), int(_437.y), int(_437.z), 0).xyz), 0));
    float3 _463 = (((_448.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_437 / float3(_448.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _476;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        _476 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _463, level(0.0)).x;
    }
    else
    {
        _476 = 1.0;
    }
    float3 _490 = ((_426 - (_426 * _425)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _497 = (mix(float3(0.07999999821186065673828125 * _424), _426, float3(_425)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _500 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _505;
    if (_500)
    {
        _505 = _490 + (_497 * 0.449999988079071044921875);
    }
    else
    {
        _505 = _490;
    }
    float3 _507 = select(_497, float3(0.0), bool3(_500));
    float3 _509 = float3(dot(_507, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _526 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _463, level(0.0));
    float _542 = _526.x;
    float4 _544 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _463, level(0.0)) * 2.0) - float4(1.0)) * _542) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _545 = _526.y;
    float4 _547 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _463, level(0.0)) * 2.0) - float4(1.0)) * _545) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _548 = _526.z;
    float4 _550 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _463, level(0.0)) * 2.0) - float4(1.0)) * _548) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _567 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _463, level(0.0)) * 2.0) - float4(1.0)) * _542) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _569 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _463, level(0.0)) * 2.0) - float4(1.0)) * _545) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _571 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _463, level(0.0)) * 2.0) - float4(1.0)) * _548) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _604 = _184;
    _604.y = (-0.48860299587249755859375) * _427.y;
    float4 _607 = _604;
    _607.z = 0.48860299587249755859375 * _427.z;
    float4 _610 = _607;
    _610.w = (-0.48860299587249755859375) * _427.x;
    float3 _611 = _427 * _427;
    float4 _614 = _181;
    _614.x = (1.09254801273345947265625 * _427.x) * _427.y;
    float4 _617 = _614;
    _617.y = ((-1.09254801273345947265625) * _427.y) * _427.z;
    float4 _622 = _617;
    _622.z = 0.3153919875621795654296875 * ((3.0 * _611.z) - 1.0);
    float4 _625 = _622;
    _625.w = ((-1.09254801273345947265625) * _427.x) * _427.z;
    float4 _629 = _610;
    _629.x = 0.886227548122406005859375;
    float3 _631 = _629.yzw * 2.094395160675048828125;
    float4 _632 = float4(_629.x, _631.x, _631.y, _631.z);
    float4 _633 = _625 * 0.785398185253143310546875;
    float _634 = (_611.x - _611.y) * 0.4290426075458526611328125;
    float3 _640 = float3(0.0);
    _640.x = (dot(float4(_542, _544.xyz), _632) + dot(float4(_544.w, _567.xyz), _633)) + (_567.w * _634);
    float3 _646 = _640;
    _646.y = (dot(float4(_545, _547.xyz), _632) + dot(float4(_547.w, _569.xyz), _633)) + (_569.w * _634);
    float3 _652 = _646;
    _652.z = (dot(float4(_548, _550.xyz), _632) + dot(float4(_550.w, _571.xyz), _633)) + (_571.w * _634);
    float _681;
    float _682;
    float3 _683;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _668 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _463, level(0.0)).xyz * 2.0) - float3(1.0);
        float _669 = length(_668);
        float3 _672 = _668 / float3(fast::max(_669, 9.9999997473787516355514526367188e-05));
        float _673 = 1.0 - _669;
        float _675 = 1.0 - (_673 * _673);
        _681 = mix(fast::clamp(dot(_672, _427), 0.0, 1.0), 1.0, _675);
        _682 = _669;
        _683 = mix(_672, _427, float3(_675));
    }
    else
    {
        _681 = 1.0;
        _682 = 1.0;
        _683 = _427;
    }
    float4 _687 = float4(_683, 1.0);
    float3 _691 = _182;
    _691.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _687);
    float3 _695 = _691;
    _695.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _687);
    float3 _699 = _695;
    _699.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _687);
    float4 _702 = _687.xyzz * _687.yzzx;
    float3 _706 = _182;
    _706.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _702);
    float3 _710 = _706;
    _710.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _702);
    float3 _714 = _710;
    _714.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _702);
    float3 _729 = ((fast::max(float3(0.0), _652) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_699 + _714) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_683.x * _683.x) - (_683.y * _683.y)))) * View.View_SkyLightColor.xyz) * (_682 * _681));
    float3 _751 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _777;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _776;
        if (any(abs(_276 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _776 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_276, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _776 = _751;
        }
        _777 = _776;
    }
    else
    {
        _777 = _751;
    }
    float4 _784 = float4(((mix(float3(0.0), _505 + (_507 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_729 * _505) * fast::max(float3(1.0), ((((((_426 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_426 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_426 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _777) * 1.0, 0.0);
    float4 _791;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _790 = _784;
        _790.w = 0.0;
        _791 = _790;
    }
    else
    {
        _791 = _784;
    }
    float2 _795 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _803 = (_427 * 0.5) + float3(0.5);
    float4 _805 = float4(_803.x, _803.y, _803.z, float4(0.0).w);
    _805.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _806 = float4(0.0);
    _806.x = _425;
    float4 _807 = _806;
    _807.y = _424;
    float4 _808 = _807;
    _808.z = _423;
    float4 _809 = _808;
    _809.w = 0.50588238239288330078125;
    float4 _821 = float4(_426.x, _426.y, _426.z, float4(0.0).w);
    _821.w = ((log2(((dot(_729, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_509 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_509 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_509 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_795.xyx * _795.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _791 * View.View_PreExposure;
    out.out_var_SV_Target1 = _805;
    out.out_var_SV_Target2 = _809;
    out.out_var_SV_Target3 = _821;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_476, 1.0, 1.0, 1.0);
    return out;
}

