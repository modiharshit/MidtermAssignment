

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
    char _m0_pad[256];
    float4x4 View_ViewToTranslatedWorld;
    char _m1_pad[384];
    float4x4 View_SVPositionToTranslatedWorld;
    char _m2_pad[288];
    float4 View_ScreenPositionScaleBias;
    float3 View_WorldCameraOrigin;
    char _m4_pad[32];
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
    char _m16_pad[400];
    packed_float3 View_NormalCurvatureToRoughnessScaleBias;
    float View_RenderingReflectionCaptureMask;
    char _m18_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m20_pad[124];
    float View_ShowDecalsMask;
    char _m21_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m22_pad[48];
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
    float4x4 Primitive_LocalToWorld;
    char _m1_pad[16];
    float4 Primitive_ObjectWorldPositionAndRadius;
    char _m2_pad[208];
    float3 Primitive_ObjectBounds;
    float Primitive_DecalReceiverMask;
    float Primitive_PerObjectGBufferData;
    float Primitive_UseVolumetricLightmapShadowFromStationaryLights;
};

struct type_Material
{
    spvUnsafeArray<float4, 6> Material_VectorExpressions;
    spvUnsafeArray<float4, 4> Material_ScalarExpressions;
};

constant float _181 = {};
constant float4 _182 = {};
constant float3 _183 = {};
constant float _185 = {};
constant float4 _186 = {};
constant float3 _187 = {};

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
    float4 in_var_TEXCOORD15 [[user(locn2)]];
    float4 in_var_COLOR1 [[user(locn3)]];
    float4 in_var_TEXCOORD0_0 [[user(locn4)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00005cd9_981a7a2a(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(11)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(12)]], texture2d<float> Material_Texture2D_0 [[texture(13)]], texture2d<float> Material_Texture2D_1 [[texture(14)]], texture2d<float> Material_Texture2D_3 [[texture(15)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_3Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float3x3 _242 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _254 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _185, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _259 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _264 = (_259.xyz / float3(_259.w)) - View.View_PreViewTranslation;
    float3 _269 = (Primitive.Primitive_LocalToWorld * float4(0.0, 0.0, 0.0, 1.0)).xyz - View.View_WorldCameraOrigin;
    float4 _281 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _284 = (float3(-0.5) + _281.xyz) * 2.0;
    float3 _300 = ((((_269 / float3(sqrt(dot(_269, _269)))) * _242) * (-1.0)) * _284.z) + (float3(_284.xy, 0.0) * ((float3x3(View.View_ViewToTranslatedWorld[0].xyz, View.View_ViewToTranslatedWorld[1].xyz, View.View_ViewToTranslatedWorld[2].xyz) * float3(1.0, 1.0, 0.0)) * _242));
    float3 _312 = normalize(_242 * normalize(((_300 / float3(sqrt(dot(_300, _300)))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _323 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _330 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    if (abs(in.in_var_COLOR1.w) > 0.001000000047497451305389404296875)
    {
        float _346 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
        if ((float((in.in_var_COLOR1.w < 0.0) ? ((in.in_var_COLOR1.w + 1.0) > _346) : (in.in_var_COLOR1.w < _346)) - 0.001000000047497451305389404296875) < 0.0)
        {
            discard_fragment();
        }
    }
    if (((_323.w * in_var_TEXCOORD0[0].z) - 0.100000001490116119384765625) < 0.0)
    {
        discard_fragment();
    }
    float3 _361 = fast::clamp(_323.xyz, float3(0.0), float3(1.0));
    float _366 = (fast::clamp(_281.w, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float3 _376 = (fast::clamp(float4(_330.xyz, _181).xyz, float3(0.0), float3(1.0)).xyz * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _424;
    float _425;
    float _426;
    float _427;
    float3 _428;
    float3 _429;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _393 = ((_254.xy / float2(_254.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _397 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _393, level(0.0));
        float4 _400 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _393, level(0.0));
        float4 _403 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _393, level(0.0));
        float _405 = _397.w;
        float _413 = _403.w;
        _424 = _376 * _405;
        _425 = (_366 * _413) + _403.z;
        _426 = (0.5 * _413) + _403.y;
        _427 = _403.x;
        _428 = (_361 * _405) + _397.xyz;
        _429 = normalize((_312 * _400.w) + ((_400.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _424 = _376;
        _425 = _366;
        _426 = 0.5;
        _427 = 0.0;
        _428 = _361;
        _429 = _312;
    }
    float3 _439 = fast::clamp((_264 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _450 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_439.x), int(_439.y), int(_439.z), 0).xyz), 0));
    float3 _465 = (((_450.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_439 / float3(_450.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _478;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        _478 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _465, level(0.0)).x;
    }
    else
    {
        _478 = 1.0;
    }
    float3 _481 = sqrt(fast::clamp(_424, float3(0.0), float3(1.0)));
    float4 _483 = float4(_481.x, _481.y, _481.z, float4(0.0).w);
    _483.w = 1.0;
    float3 _488 = dfdx(in.in_var_TEXCOORD15.xyz);
    float3 _489 = dfdy(in.in_var_TEXCOORD15.xyz);
    float3 _507 = ((_428 - (_428 * _427)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _514 = (mix(float3(0.07999999821186065673828125 * _426), _428, float3(_427)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _517 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _522;
    if (_517)
    {
        _522 = _507 + (_514 * 0.449999988079071044921875);
    }
    else
    {
        _522 = _507;
    }
    float3 _524 = select(_514, float3(0.0), bool3(_517));
    float3 _526 = float3(dot(_524, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _543 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _465, level(0.0));
    float _559 = _543.x;
    float4 _561 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _465, level(0.0)) * 2.0) - float4(1.0)) * _559) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _562 = _543.y;
    float4 _564 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _465, level(0.0)) * 2.0) - float4(1.0)) * _562) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _565 = _543.z;
    float4 _567 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _465, level(0.0)) * 2.0) - float4(1.0)) * _565) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _584 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _465, level(0.0)) * 2.0) - float4(1.0)) * _559) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _586 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _465, level(0.0)) * 2.0) - float4(1.0)) * _562) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _588 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _465, level(0.0)) * 2.0) - float4(1.0)) * _565) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _592 = float4(_559, _561.xyz);
    float4 _597 = float4(_561.w, _584.xyz);
    float _598 = _584.w;
    float4 _602 = float4(_562, _564.xyz);
    float4 _607 = float4(_564.w, _586.xyz);
    float _608 = _586.w;
    float4 _612 = float4(_565, _567.xyz);
    float4 _617 = float4(_567.w, _588.xyz);
    float _618 = _588.w;
    float4 _621 = _186;
    _621.y = (-0.48860299587249755859375) * _429.y;
    float4 _624 = _621;
    _624.z = 0.48860299587249755859375 * _429.z;
    float4 _627 = _624;
    _627.w = (-0.48860299587249755859375) * _429.x;
    float3 _628 = _429 * _429;
    float4 _631 = _182;
    _631.x = (1.09254801273345947265625 * _429.x) * _429.y;
    float4 _634 = _631;
    _634.y = ((-1.09254801273345947265625) * _429.y) * _429.z;
    float4 _639 = _634;
    _639.z = 0.3153919875621795654296875 * ((3.0 * _628.z) - 1.0);
    float4 _642 = _639;
    _642.w = ((-1.09254801273345947265625) * _429.x) * _429.z;
    float4 _646 = _627;
    _646.x = 0.886227548122406005859375;
    float3 _648 = _646.yzw * 2.094395160675048828125;
    float4 _649 = float4(_646.x, _648.x, _648.y, _648.z);
    float4 _650 = _642 * 0.785398185253143310546875;
    float _651 = (_628.x - _628.y) * 0.4290426075458526611328125;
    float3 _657 = float3(0.0);
    _657.x = (dot(_592, _649) + dot(_597, _650)) + (_598 * _651);
    float3 _663 = _657;
    _663.y = (dot(_602, _649) + dot(_607, _650)) + (_608 * _651);
    float3 _669 = _663;
    _669.z = (dot(_612, _649) + dot(_617, _650)) + (_618 * _651);
    float3 _672 = -_429;
    float _673 = _672.y;
    float4 _675 = _186;
    _675.y = (-0.48860299587249755859375) * _673;
    float _676 = _672.z;
    float4 _678 = _675;
    _678.z = 0.48860299587249755859375 * _676;
    float _679 = _672.x;
    float4 _681 = _678;
    _681.w = (-0.48860299587249755859375) * _679;
    float3 _682 = _672 * _672;
    float4 _685 = _182;
    _685.x = (1.09254801273345947265625 * _679) * _673;
    float4 _688 = _685;
    _688.y = ((-1.09254801273345947265625) * _673) * _676;
    float4 _693 = _688;
    _693.z = 0.3153919875621795654296875 * ((3.0 * _682.z) - 1.0);
    float4 _696 = _693;
    _696.w = ((-1.09254801273345947265625) * _679) * _676;
    float4 _700 = _681;
    _700.x = 0.886227548122406005859375;
    float3 _702 = _700.yzw * 2.094395160675048828125;
    float4 _703 = float4(_700.x, _702.x, _702.y, _702.z);
    float4 _704 = _696 * 0.785398185253143310546875;
    float _705 = (_682.x - _682.y) * 0.4290426075458526611328125;
    float3 _711 = _187;
    _711.x = (dot(_592, _703) + dot(_597, _704)) + (_598 * _705);
    float3 _717 = _711;
    _717.y = (dot(_602, _703) + dot(_607, _704)) + (_608 * _705);
    float3 _723 = _717;
    _723.z = (dot(_612, _703) + dot(_617, _704)) + (_618 * _705);
    float _753;
    float _754;
    float3 _755;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _740 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _465, level(0.0)).xyz * 2.0) - float3(1.0);
        float _741 = length(_740);
        float3 _744 = _740 / float3(fast::max(_741, 9.9999997473787516355514526367188e-05));
        float _745 = 1.0 - _741;
        float _747 = 1.0 - (_745 * _745);
        _753 = mix(fast::clamp(dot(_744, _429), 0.0, 1.0), 1.0, _747);
        _754 = _741;
        _755 = mix(_744, _429, float3(_747));
    }
    else
    {
        _753 = 1.0;
        _754 = 1.0;
        _755 = _429;
    }
    float4 _759 = float4(_755, 1.0);
    float3 _763 = _183;
    _763.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _759);
    float3 _767 = _763;
    _767.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _759);
    float3 _771 = _767;
    _771.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _759);
    float4 _774 = _759.xyzz * _759.yzzx;
    float3 _778 = _183;
    _778.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _774);
    float3 _782 = _778;
    _782.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _774);
    float3 _786 = _782;
    _786.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _774);
    float4 _801 = float4(_679, _673, _676, 1.0);
    float3 _804 = _187;
    _804.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _801);
    float3 _807 = _804;
    _807.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _801);
    float3 _810 = _807;
    _810.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _801);
    float4 _813 = _801.xyzz * _801.yzzx;
    float3 _816 = _187;
    _816.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _813);
    float3 _819 = _816;
    _819.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _813);
    float3 _822 = _819;
    _822.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _813);
    float3 _835 = ((fast::max(float3(0.0), _669) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_771 + _786) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_755.x * _755.x) - (_755.y * _755.y)))) * View.View_SkyLightColor.xyz) * (_754 * _753));
    float3 _859 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _885;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _884;
        if (any(abs(_264 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _884 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_264, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _884 = _859;
        }
        _885 = _884;
    }
    else
    {
        _885 = _859;
    }
    float4 _892 = float4(((mix(float3(0.0), _522 + (_524 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + (((_835 * _522) + ((((fast::max(float3(0.0), _723) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_810 + _822) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_679 * _679) - (_673 * _673)))) * View.View_SkyLightColor.xyz) * _754)) * _424)) * fast::max(float3(1.0), ((((((_428 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_428 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_428 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _885) * 1.0, 0.0);
    float4 _899;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _898 = _892;
        _898.w = 0.0;
        _899 = _898;
    }
    else
    {
        _899 = _892;
    }
    float2 _903 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _911 = (_429 * 0.5) + float3(0.5);
    float4 _913 = float4(_911.x, _911.y, _911.z, float4(0.0).w);
    _913.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _914 = float4(0.0);
    _914.x = _427;
    float4 _915 = _914;
    _915.y = _426;
    float4 _916 = _915;
    _916.z = fast::max(_425, fast::clamp((pow(fast::max(dot(_488, _488), dot(_489, _489)), View.View_NormalCurvatureToRoughnessScaleBias[2]) * View.View_NormalCurvatureToRoughnessScaleBias[0]) + View.View_NormalCurvatureToRoughnessScaleBias[1], 0.0, 1.0));
    float4 _917 = _916;
    _917.w = 0.525490224361419677734375;
    float4 _929 = float4(_428.x, _428.y, _428.z, float4(0.0).w);
    _929.w = ((log2(((dot(_835, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_526 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_526 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_526 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_903.xyx * _903.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _899 * View.View_PreExposure;
    out.out_var_SV_Target1 = _913;
    out.out_var_SV_Target2 = _917;
    out.out_var_SV_Target3 = _929;
    out.out_var_SV_Target4 = _483;
    out.out_var_SV_Target5 = float4(_478, 1.0, 1.0, 1.0);
    return out;
}

