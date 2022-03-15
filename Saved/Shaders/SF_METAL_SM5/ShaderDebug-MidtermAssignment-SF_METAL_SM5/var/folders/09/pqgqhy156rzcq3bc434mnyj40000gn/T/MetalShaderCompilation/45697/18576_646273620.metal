

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
    float View_IndirectLightingCacheShowFlag;
};

struct type_Primitive
{
    char _m0_pad[64];
    float4 Primitive_InvNonUniformScaleAndDeterminantSign;
    float4 Primitive_ObjectWorldPositionAndRadius;
    char _m2_pad[204];
    float Primitive_UseSingleSampleShadowFromStationaryLights;
    float3 Primitive_ObjectBounds;
    float Primitive_DecalReceiverMask;
    float Primitive_PerObjectGBufferData;
    float Primitive_UseVolumetricLightmapShadowFromStationaryLights;
};

struct type_IndirectLightingCache
{
    char _m0_pad[80];
    float IndirectLightingCache_DirectionalLightShadowing;
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients0;
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients1;
    float4 IndirectLightingCache_IndirectLightingSHCoefficients2;
};

struct type_Material
{
    spvUnsafeArray<float4, 7> Material_VectorExpressions;
    spvUnsafeArray<float4, 6> Material_ScalarExpressions;
};

constant float _162 = {};
constant float4 _163 = {};
constant float _165 = {};
constant float4 _166 = {};
constant float3 _167 = {};

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

fragment MainPS_out Main_00004890_26855a54(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_3 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_3Sampler [[sampler(4)]], float4 gl_FragCoord [[position]], bool gl_FrontFacing [[front_facing]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    float4 _228 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _165, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _233 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _238 = (_233.xyz / float3(_233.w)) - View.View_PreViewTranslation;
    float4 _250 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _261 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((((float3(-0.5) + _250.xyz) * 2.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * ((View.View_CullingSign * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w) * float(gl_FrontFacing ? 1 : (-1)));
    float4 _272 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _279 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    if (abs(in.in_var_COLOR1.w) > 0.001000000047497451305389404296875)
    {
        float _295 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
        if ((float((in.in_var_COLOR1.w < 0.0) ? ((in.in_var_COLOR1.w + 1.0) > _295) : (in.in_var_COLOR1.w < _295)) - 0.001000000047497451305389404296875) < 0.0)
        {
            discard_fragment();
        }
    }
    if (((in.in_var_COLOR0.w * _272.w) - 0.100000001490116119384765625) < 0.0)
    {
        discard_fragment();
    }
    float3 _310 = fast::clamp(_272.xyz, float3(0.0), float3(1.0));
    float _315 = (fast::clamp(_250.w, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float3 _325 = (fast::clamp(float4(_279.xyz, _162).xyz, float3(0.0), float3(1.0)).xyz * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _373;
    float _374;
    float _375;
    float _376;
    float3 _377;
    float3 _378;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _342 = ((_228.xy / float2(_228.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _346 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _342, level(0.0));
        float4 _349 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _342, level(0.0));
        float4 _352 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _342, level(0.0));
        float _354 = _346.w;
        float _362 = _352.w;
        _373 = _325 * _354;
        _374 = (_315 * _362) + _352.z;
        _375 = (0.5 * _362) + _352.y;
        _376 = _352.x;
        _377 = (_310 * _354) + _346.xyz;
        _378 = normalize((_261 * _349.w) + ((_349.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _373 = _325;
        _374 = _315;
        _375 = 0.5;
        _376 = 0.0;
        _377 = _310;
        _378 = _261;
    }
    bool _386 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _392;
    if ((Primitive.Primitive_UseSingleSampleShadowFromStationaryLights > 0.0) && _386)
    {
        _392 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _392 = 1.0;
    }
    float _439;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _407 = fast::clamp((_238 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _418 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_407.x), int(_407.y), int(_407.z), 0).xyz), 0));
        _439 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_418.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_407 / float3(_418.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _439 = _392;
    }
    float3 _442 = sqrt(fast::clamp(_373, float3(0.0), float3(1.0)));
    float4 _444 = float4(_442.x, _442.y, _442.z, float4(0.0).w);
    _444.w = 1.0;
    float3 _452 = ((_377 - (_377 * _376)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _459 = (mix(float3(0.07999999821186065673828125 * _375), _377, float3(_376)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _462 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _467;
    if (_462)
    {
        _467 = _452 + (_459 * 0.449999988079071044921875);
    }
    else
    {
        _467 = _452;
    }
    float3 _469 = select(_459, float3(0.0), bool3(_462));
    float3 _471 = float3(dot(_469, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _610;
    float3 _611;
    if (_386)
    {
        float4 _507 = _166;
        _507.y = (-0.48860299587249755859375) * _378.y;
        float4 _510 = _507;
        _510.z = 0.48860299587249755859375 * _378.z;
        float4 _513 = _510;
        _513.w = (-0.48860299587249755859375) * _378.x;
        float3 _514 = _378 * _378;
        float4 _517 = _163;
        _517.x = (1.09254801273345947265625 * _378.x) * _378.y;
        float4 _520 = _517;
        _520.y = ((-1.09254801273345947265625) * _378.y) * _378.z;
        float4 _525 = _520;
        _525.z = 0.3153919875621795654296875 * ((3.0 * _514.z) - 1.0);
        float4 _528 = _525;
        _528.w = ((-1.09254801273345947265625) * _378.x) * _378.z;
        float4 _532 = _513;
        _532.x = 0.886227548122406005859375;
        float3 _534 = _532.yzw * 2.094395160675048828125;
        float4 _535 = float4(_532.x, _534.x, _534.y, _534.z);
        float4 _536 = _528 * 0.785398185253143310546875;
        float _537 = (_514.x - _514.y) * 0.4290426075458526611328125;
        float3 _543 = float3(0.0);
        _543.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _535) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _536)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _537);
        float3 _549 = _543;
        _549.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _535) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _536)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _537);
        float3 _555 = _549;
        _555.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _535) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _536)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _537);
        float3 _557 = -_378;
        float _558 = _557.y;
        float4 _560 = _166;
        _560.y = (-0.48860299587249755859375) * _558;
        float _561 = _557.z;
        float4 _563 = _560;
        _563.z = 0.48860299587249755859375 * _561;
        float _564 = _557.x;
        float4 _566 = _563;
        _566.w = (-0.48860299587249755859375) * _564;
        float3 _567 = _557 * _557;
        float4 _570 = _163;
        _570.x = (1.09254801273345947265625 * _564) * _558;
        float4 _573 = _570;
        _573.y = ((-1.09254801273345947265625) * _558) * _561;
        float4 _578 = _573;
        _578.z = 0.3153919875621795654296875 * ((3.0 * _567.z) - 1.0);
        float4 _581 = _578;
        _581.w = ((-1.09254801273345947265625) * _564) * _561;
        float4 _585 = _566;
        _585.x = 0.886227548122406005859375;
        float3 _587 = _585.yzw * 2.094395160675048828125;
        float4 _588 = float4(_585.x, _587.x, _587.y, _587.z);
        float4 _589 = _581 * 0.785398185253143310546875;
        float _590 = (_567.x - _567.y) * 0.4290426075458526611328125;
        float3 _596 = _167;
        _596.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _588) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _589)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _590);
        float3 _602 = _596;
        _602.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _588) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _589)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _590);
        float3 _608 = _602;
        _608.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _588) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _589)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _590);
        _610 = fast::max(float3(0.0), _608);
        _611 = fast::max(float3(0.0), _555);
    }
    else
    {
        _610 = float3(0.0);
        _611 = float3(0.0);
    }
    float3 _614 = _611 * View.View_IndirectLightingColorScale;
    float3 _639 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _665;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _664;
        if (any(abs(_238 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _664 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_238, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _664 = _639;
        }
        _665 = _664;
    }
    else
    {
        _665 = _639;
    }
    float4 _672 = float4(((mix(float3(0.0), _467 + (_469 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + (((_614 * _467) + ((_610 * View.View_IndirectLightingColorScale) * _373)) * fast::max(float3(1.0), ((((((_377 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_377 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_377 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _665) * 1.0, 0.0);
    float4 _679;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _678 = _672;
        _678.w = 0.0;
        _679 = _678;
    }
    else
    {
        _679 = _672;
    }
    float2 _683 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _691 = (_378 * 0.5) + float3(0.5);
    float4 _693 = float4(_691.x, _691.y, _691.z, float4(0.0).w);
    _693.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _694 = float4(0.0);
    _694.x = _376;
    float4 _695 = _694;
    _695.y = _375;
    float4 _696 = _695;
    _696.z = _374;
    float4 _697 = _696;
    _697.w = 0.525490224361419677734375;
    float4 _709 = float4(_377.x, _377.y, _377.z, float4(0.0).w);
    _709.w = ((log2(((dot(_614, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_471 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_471 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_471 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_683.xyx * _683.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _679 * View.View_PreExposure;
    out.out_var_SV_Target1 = _693;
    out.out_var_SV_Target2 = _697;
    out.out_var_SV_Target3 = _709;
    out.out_var_SV_Target4 = _444;
    out.out_var_SV_Target5 = float4(_439, 1.0, 1.0, 1.0);
    return out;
}

