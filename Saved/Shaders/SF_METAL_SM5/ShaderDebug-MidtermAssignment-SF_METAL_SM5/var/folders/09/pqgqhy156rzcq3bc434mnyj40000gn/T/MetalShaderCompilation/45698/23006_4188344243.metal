

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
    char _m11_pad[24];
    float View_CullingSign;
    char _m12_pad[20];
    float View_MaterialTextureMipBias;
    char _m13_pad[28];
    float View_UnlitViewmodeMask;
    char _m14_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m15_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m16_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m18_pad[124];
    float View_ShowDecalsMask;
    char _m19_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m20_pad[48];
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
    char _m0_pad[64];
    float4 Primitive_InvNonUniformScaleAndDeterminantSign;
    float4 Primitive_ObjectWorldPositionAndRadius;
    char _m2_pad[208];
    float3 Primitive_ObjectBounds;
    float Primitive_DecalReceiverMask;
    float Primitive_PerObjectGBufferData;
    float Primitive_UseVolumetricLightmapShadowFromStationaryLights;
};

struct type_Material
{
    spvUnsafeArray<float4, 7> Material_VectorExpressions;
    spvUnsafeArray<float4, 6> Material_ScalarExpressions;
};

constant float _179 = {};
constant float4 _180 = {};
constant float3 _181 = {};
constant float _183 = {};
constant float4 _184 = {};
constant float3 _185 = {};

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
    float4 in_var_COLOR0 [[user(locn2)]];
    float4 in_var_COLOR1 [[user(locn3)]];
    float4 in_var_TEXCOORD0_0 [[user(locn4)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_000059de_f9a50fb3(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(11)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(12)]], texture2d<float> Material_Texture2D_0 [[texture(13)]], texture2d<float> Material_Texture2D_1 [[texture(14)]], texture2d<float> Material_Texture2D_3 [[texture(15)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_3Sampler [[sampler(4)]], float4 gl_FragCoord [[position]], bool gl_FrontFacing [[front_facing]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _248 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _183, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _253 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _258 = (_253.xyz / float3(_253.w)) - View.View_PreViewTranslation;
    float4 _270 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _281 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((((float3(-0.5) + _270.xyz) * 2.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * ((View.View_CullingSign * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w) * float(gl_FrontFacing ? 1 : (-1)));
    float4 _292 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _299 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    if (abs(in.in_var_COLOR1.w) > 0.001000000047497451305389404296875)
    {
        float _315 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
        if ((float((in.in_var_COLOR1.w < 0.0) ? ((in.in_var_COLOR1.w + 1.0) > _315) : (in.in_var_COLOR1.w < _315)) - 0.001000000047497451305389404296875) < 0.0)
        {
            discard_fragment();
        }
    }
    if (((in.in_var_COLOR0.w * _292.w) - 0.100000001490116119384765625) < 0.0)
    {
        discard_fragment();
    }
    float3 _330 = fast::clamp(_292.xyz, float3(0.0), float3(1.0));
    float _335 = (fast::clamp(_270.w, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float3 _345 = (fast::clamp(float4(_299.xyz, _179).xyz, float3(0.0), float3(1.0)).xyz * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _393;
    float _394;
    float _395;
    float _396;
    float3 _397;
    float3 _398;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _362 = ((_248.xy / float2(_248.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _366 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _362, level(0.0));
        float4 _369 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _362, level(0.0));
        float4 _372 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _362, level(0.0));
        float _374 = _366.w;
        float _382 = _372.w;
        _393 = _345 * _374;
        _394 = (_335 * _382) + _372.z;
        _395 = (0.5 * _382) + _372.y;
        _396 = _372.x;
        _397 = (_330 * _374) + _366.xyz;
        _398 = normalize((_281 * _369.w) + ((_369.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _393 = _345;
        _394 = _335;
        _395 = 0.5;
        _396 = 0.0;
        _397 = _330;
        _398 = _281;
    }
    float3 _408 = fast::clamp((_258 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _419 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_408.x), int(_408.y), int(_408.z), 0).xyz), 0));
    float3 _434 = (((_419.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_408 / float3(_419.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _447;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        _447 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _434, level(0.0)).x;
    }
    else
    {
        _447 = 1.0;
    }
    float3 _450 = sqrt(fast::clamp(_393, float3(0.0), float3(1.0)));
    float4 _452 = float4(_450.x, _450.y, _450.z, float4(0.0).w);
    _452.w = 1.0;
    float3 _460 = ((_397 - (_397 * _396)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _467 = (mix(float3(0.07999999821186065673828125 * _395), _397, float3(_396)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
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
    float4 _496 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _434, level(0.0));
    float _512 = _496.x;
    float4 _514 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _434, level(0.0)) * 2.0) - float4(1.0)) * _512) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _515 = _496.y;
    float4 _517 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _434, level(0.0)) * 2.0) - float4(1.0)) * _515) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _518 = _496.z;
    float4 _520 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _434, level(0.0)) * 2.0) - float4(1.0)) * _518) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _537 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _434, level(0.0)) * 2.0) - float4(1.0)) * _512) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _539 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _434, level(0.0)) * 2.0) - float4(1.0)) * _515) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _541 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _434, level(0.0)) * 2.0) - float4(1.0)) * _518) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _545 = float4(_512, _514.xyz);
    float4 _550 = float4(_514.w, _537.xyz);
    float _551 = _537.w;
    float4 _555 = float4(_515, _517.xyz);
    float4 _560 = float4(_517.w, _539.xyz);
    float _561 = _539.w;
    float4 _565 = float4(_518, _520.xyz);
    float4 _570 = float4(_520.w, _541.xyz);
    float _571 = _541.w;
    float4 _574 = _184;
    _574.y = (-0.48860299587249755859375) * _398.y;
    float4 _577 = _574;
    _577.z = 0.48860299587249755859375 * _398.z;
    float4 _580 = _577;
    _580.w = (-0.48860299587249755859375) * _398.x;
    float3 _581 = _398 * _398;
    float4 _584 = _180;
    _584.x = (1.09254801273345947265625 * _398.x) * _398.y;
    float4 _587 = _584;
    _587.y = ((-1.09254801273345947265625) * _398.y) * _398.z;
    float4 _592 = _587;
    _592.z = 0.3153919875621795654296875 * ((3.0 * _581.z) - 1.0);
    float4 _595 = _592;
    _595.w = ((-1.09254801273345947265625) * _398.x) * _398.z;
    float4 _599 = _580;
    _599.x = 0.886227548122406005859375;
    float3 _601 = _599.yzw * 2.094395160675048828125;
    float4 _602 = float4(_599.x, _601.x, _601.y, _601.z);
    float4 _603 = _595 * 0.785398185253143310546875;
    float _604 = (_581.x - _581.y) * 0.4290426075458526611328125;
    float3 _610 = float3(0.0);
    _610.x = (dot(_545, _602) + dot(_550, _603)) + (_551 * _604);
    float3 _616 = _610;
    _616.y = (dot(_555, _602) + dot(_560, _603)) + (_561 * _604);
    float3 _622 = _616;
    _622.z = (dot(_565, _602) + dot(_570, _603)) + (_571 * _604);
    float3 _625 = -_398;
    float _626 = _625.y;
    float4 _628 = _184;
    _628.y = (-0.48860299587249755859375) * _626;
    float _629 = _625.z;
    float4 _631 = _628;
    _631.z = 0.48860299587249755859375 * _629;
    float _632 = _625.x;
    float4 _634 = _631;
    _634.w = (-0.48860299587249755859375) * _632;
    float3 _635 = _625 * _625;
    float4 _638 = _180;
    _638.x = (1.09254801273345947265625 * _632) * _626;
    float4 _641 = _638;
    _641.y = ((-1.09254801273345947265625) * _626) * _629;
    float4 _646 = _641;
    _646.z = 0.3153919875621795654296875 * ((3.0 * _635.z) - 1.0);
    float4 _649 = _646;
    _649.w = ((-1.09254801273345947265625) * _632) * _629;
    float4 _653 = _634;
    _653.x = 0.886227548122406005859375;
    float3 _655 = _653.yzw * 2.094395160675048828125;
    float4 _656 = float4(_653.x, _655.x, _655.y, _655.z);
    float4 _657 = _649 * 0.785398185253143310546875;
    float _658 = (_635.x - _635.y) * 0.4290426075458526611328125;
    float3 _664 = _185;
    _664.x = (dot(_545, _656) + dot(_550, _657)) + (_551 * _658);
    float3 _670 = _664;
    _670.y = (dot(_555, _656) + dot(_560, _657)) + (_561 * _658);
    float3 _676 = _670;
    _676.z = (dot(_565, _656) + dot(_570, _657)) + (_571 * _658);
    float _706;
    float _707;
    float3 _708;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _693 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _434, level(0.0)).xyz * 2.0) - float3(1.0);
        float _694 = length(_693);
        float3 _697 = _693 / float3(fast::max(_694, 9.9999997473787516355514526367188e-05));
        float _698 = 1.0 - _694;
        float _700 = 1.0 - (_698 * _698);
        _706 = mix(fast::clamp(dot(_697, _398), 0.0, 1.0), 1.0, _700);
        _707 = _694;
        _708 = mix(_697, _398, float3(_700));
    }
    else
    {
        _706 = 1.0;
        _707 = 1.0;
        _708 = _398;
    }
    float4 _712 = float4(_708, 1.0);
    float3 _716 = _181;
    _716.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _712);
    float3 _720 = _716;
    _720.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _712);
    float3 _724 = _720;
    _724.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _712);
    float4 _727 = _712.xyzz * _712.yzzx;
    float3 _731 = _181;
    _731.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _727);
    float3 _735 = _731;
    _735.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _727);
    float3 _739 = _735;
    _739.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _727);
    float4 _754 = float4(_632, _626, _629, 1.0);
    float3 _757 = _185;
    _757.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _754);
    float3 _760 = _757;
    _760.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _754);
    float3 _763 = _760;
    _763.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _754);
    float4 _766 = _754.xyzz * _754.yzzx;
    float3 _769 = _185;
    _769.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _766);
    float3 _772 = _769;
    _772.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _766);
    float3 _775 = _772;
    _775.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _766);
    float3 _788 = ((fast::max(float3(0.0), _622) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_724 + _739) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_708.x * _708.x) - (_708.y * _708.y)))) * View.View_SkyLightColor.xyz) * (_707 * _706));
    float3 _812 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _838;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _837;
        if (any(abs(_258 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _837 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_258, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _837 = _812;
        }
        _838 = _837;
    }
    else
    {
        _838 = _812;
    }
    float4 _845 = float4(((mix(float3(0.0), _475 + (_477 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + (((_788 * _475) + ((((fast::max(float3(0.0), _676) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_763 + _775) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_632 * _632) - (_626 * _626)))) * View.View_SkyLightColor.xyz) * _707)) * _393)) * fast::max(float3(1.0), ((((((_397 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_397 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_397 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _838) * 1.0, 0.0);
    float4 _852;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _851 = _845;
        _851.w = 0.0;
        _852 = _851;
    }
    else
    {
        _852 = _845;
    }
    float2 _856 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _864 = (_398 * 0.5) + float3(0.5);
    float4 _866 = float4(_864.x, _864.y, _864.z, float4(0.0).w);
    _866.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _867 = float4(0.0);
    _867.x = _396;
    float4 _868 = _867;
    _868.y = _395;
    float4 _869 = _868;
    _869.z = _394;
    float4 _870 = _869;
    _870.w = 0.525490224361419677734375;
    float4 _882 = float4(_397.x, _397.y, _397.z, float4(0.0).w);
    _882.w = ((log2(((dot(_788, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_479 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_479 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_479 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_856.xyx * _856.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _852 * View.View_PreExposure;
    out.out_var_SV_Target1 = _866;
    out.out_var_SV_Target2 = _870;
    out.out_var_SV_Target3 = _882;
    out.out_var_SV_Target4 = _452;
    out.out_var_SV_Target5 = float4(_447, 1.0, 1.0, 1.0);
    return out;
}

