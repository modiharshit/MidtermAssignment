

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
    char _m16_pad[188];
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

constant float _170 = {};
constant float4 _171 = {};
constant float _173 = {};
constant float4 _174 = {};
constant float3 _175 = {};

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

fragment MainPS_out Main_00004a7b_12c018da(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(11)]], texture2d<float> Material_Texture2D_0 [[texture(12)]], texture2d<float> Material_Texture2D_1 [[texture(13)]], texture2d<float> Material_Texture2D_3 [[texture(14)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_3Sampler [[sampler(4)]], float4 gl_FragCoord [[position]], bool gl_FrontFacing [[front_facing]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    float4 _237 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _173, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _242 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _247 = (_242.xyz / float3(_242.w)) - View.View_PreViewTranslation;
    float4 _259 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _270 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((((float3(-0.5) + _259.xyz) * 2.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * ((View.View_CullingSign * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w) * float(gl_FrontFacing ? 1 : (-1)));
    float4 _281 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _288 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    if (abs(in.in_var_COLOR1.w) > 0.001000000047497451305389404296875)
    {
        float _304 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
        if ((float((in.in_var_COLOR1.w < 0.0) ? ((in.in_var_COLOR1.w + 1.0) > _304) : (in.in_var_COLOR1.w < _304)) - 0.001000000047497451305389404296875) < 0.0)
        {
            discard_fragment();
        }
    }
    if (((in.in_var_COLOR0.w * _281.w) - 0.100000001490116119384765625) < 0.0)
    {
        discard_fragment();
    }
    float3 _319 = fast::clamp(_281.xyz, float3(0.0), float3(1.0));
    float _324 = (fast::clamp(_259.w, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float3 _334 = (fast::clamp(float4(_288.xyz, _170).xyz, float3(0.0), float3(1.0)).xyz * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _382;
    float _383;
    float _384;
    float _385;
    float3 _386;
    float3 _387;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _351 = ((_237.xy / float2(_237.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _355 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _351, level(0.0));
        float4 _358 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _351, level(0.0));
        float4 _361 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _351, level(0.0));
        float _363 = _355.w;
        float _371 = _361.w;
        _382 = _334 * _363;
        _383 = (_324 * _371) + _361.z;
        _384 = (0.5 * _371) + _361.y;
        _385 = _361.x;
        _386 = (_319 * _363) + _355.xyz;
        _387 = normalize((_270 * _358.w) + ((_358.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _382 = _334;
        _383 = _324;
        _384 = 0.5;
        _385 = 0.0;
        _386 = _319;
        _387 = _270;
    }
    float3 _397 = fast::clamp((_247 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _408 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_397.x), int(_397.y), int(_397.z), 0).xyz), 0));
    float3 _423 = (((_408.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_397 / float3(_408.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _436;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        _436 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _423, level(0.0)).x;
    }
    else
    {
        _436 = 1.0;
    }
    float3 _439 = sqrt(fast::clamp(_382, float3(0.0), float3(1.0)));
    float4 _441 = float4(_439.x, _439.y, _439.z, float4(0.0).w);
    _441.w = 1.0;
    float3 _449 = ((_386 - (_386 * _385)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _456 = (mix(float3(0.07999999821186065673828125 * _384), _386, float3(_385)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _459 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _464;
    if (_459)
    {
        _464 = _449 + (_456 * 0.449999988079071044921875);
    }
    else
    {
        _464 = _449;
    }
    float3 _466 = select(_456, float3(0.0), bool3(_459));
    float3 _468 = float3(dot(_466, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _485 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _423, level(0.0));
    float _501 = _485.x;
    float4 _503 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _423, level(0.0)) * 2.0) - float4(1.0)) * _501) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _504 = _485.y;
    float4 _506 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _423, level(0.0)) * 2.0) - float4(1.0)) * _504) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _507 = _485.z;
    float4 _509 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _423, level(0.0)) * 2.0) - float4(1.0)) * _507) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _526 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _423, level(0.0)) * 2.0) - float4(1.0)) * _501) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _528 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _423, level(0.0)) * 2.0) - float4(1.0)) * _504) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _530 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _423, level(0.0)) * 2.0) - float4(1.0)) * _507) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _534 = float4(_501, _503.xyz);
    float4 _539 = float4(_503.w, _526.xyz);
    float _540 = _526.w;
    float4 _544 = float4(_504, _506.xyz);
    float4 _549 = float4(_506.w, _528.xyz);
    float _550 = _528.w;
    float4 _554 = float4(_507, _509.xyz);
    float4 _559 = float4(_509.w, _530.xyz);
    float _560 = _530.w;
    float4 _563 = _174;
    _563.y = (-0.48860299587249755859375) * _387.y;
    float4 _566 = _563;
    _566.z = 0.48860299587249755859375 * _387.z;
    float4 _569 = _566;
    _569.w = (-0.48860299587249755859375) * _387.x;
    float3 _570 = _387 * _387;
    float4 _573 = _171;
    _573.x = (1.09254801273345947265625 * _387.x) * _387.y;
    float4 _576 = _573;
    _576.y = ((-1.09254801273345947265625) * _387.y) * _387.z;
    float4 _581 = _576;
    _581.z = 0.3153919875621795654296875 * ((3.0 * _570.z) - 1.0);
    float4 _584 = _581;
    _584.w = ((-1.09254801273345947265625) * _387.x) * _387.z;
    float4 _588 = _569;
    _588.x = 0.886227548122406005859375;
    float3 _590 = _588.yzw * 2.094395160675048828125;
    float4 _591 = float4(_588.x, _590.x, _590.y, _590.z);
    float4 _592 = _584 * 0.785398185253143310546875;
    float _593 = (_570.x - _570.y) * 0.4290426075458526611328125;
    float3 _599 = float3(0.0);
    _599.x = (dot(_534, _591) + dot(_539, _592)) + (_540 * _593);
    float3 _605 = _599;
    _605.y = (dot(_544, _591) + dot(_549, _592)) + (_550 * _593);
    float3 _611 = _605;
    _611.z = (dot(_554, _591) + dot(_559, _592)) + (_560 * _593);
    float3 _614 = -_387;
    float _615 = _614.y;
    float4 _617 = _174;
    _617.y = (-0.48860299587249755859375) * _615;
    float _618 = _614.z;
    float4 _620 = _617;
    _620.z = 0.48860299587249755859375 * _618;
    float _621 = _614.x;
    float4 _623 = _620;
    _623.w = (-0.48860299587249755859375) * _621;
    float3 _624 = _614 * _614;
    float4 _627 = _171;
    _627.x = (1.09254801273345947265625 * _621) * _615;
    float4 _630 = _627;
    _630.y = ((-1.09254801273345947265625) * _615) * _618;
    float4 _635 = _630;
    _635.z = 0.3153919875621795654296875 * ((3.0 * _624.z) - 1.0);
    float4 _638 = _635;
    _638.w = ((-1.09254801273345947265625) * _621) * _618;
    float4 _642 = _623;
    _642.x = 0.886227548122406005859375;
    float3 _644 = _642.yzw * 2.094395160675048828125;
    float4 _645 = float4(_642.x, _644.x, _644.y, _644.z);
    float4 _646 = _638 * 0.785398185253143310546875;
    float _647 = (_624.x - _624.y) * 0.4290426075458526611328125;
    float3 _653 = _175;
    _653.x = (dot(_534, _645) + dot(_539, _646)) + (_540 * _647);
    float3 _659 = _653;
    _659.y = (dot(_544, _645) + dot(_549, _646)) + (_550 * _647);
    float3 _665 = _659;
    _665.z = (dot(_554, _645) + dot(_559, _646)) + (_560 * _647);
    float3 _670 = (fast::max(float3(0.0), _611) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    float3 _695 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _721;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _720;
        if (any(abs(_247 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _720 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_247, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _720 = _695;
        }
        _721 = _720;
    }
    else
    {
        _721 = _695;
    }
    float4 _728 = float4(((mix(float3(0.0), _464 + (_466 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + (((_670 * _464) + (((fast::max(float3(0.0), _665) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) * _382)) * fast::max(float3(1.0), ((((((_386 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_386 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_386 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _721) * 1.0, 0.0);
    float4 _735;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _734 = _728;
        _734.w = 0.0;
        _735 = _734;
    }
    else
    {
        _735 = _728;
    }
    float2 _739 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _747 = (_387 * 0.5) + float3(0.5);
    float4 _749 = float4(_747.x, _747.y, _747.z, float4(0.0).w);
    _749.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _750 = float4(0.0);
    _750.x = _385;
    float4 _751 = _750;
    _751.y = _384;
    float4 _752 = _751;
    _752.z = _383;
    float4 _753 = _752;
    _753.w = 0.525490224361419677734375;
    float4 _765 = float4(_386.x, _386.y, _386.z, float4(0.0).w);
    _765.w = ((log2(((dot(_670, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_468 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_468 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_468 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_739.xyx * _739.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _735 * View.View_PreExposure;
    out.out_var_SV_Target1 = _749;
    out.out_var_SV_Target2 = _753;
    out.out_var_SV_Target3 = _765;
    out.out_var_SV_Target4 = _441;
    out.out_var_SV_Target5 = float4(_436, 1.0, 1.0, 1.0);
    return out;
}

