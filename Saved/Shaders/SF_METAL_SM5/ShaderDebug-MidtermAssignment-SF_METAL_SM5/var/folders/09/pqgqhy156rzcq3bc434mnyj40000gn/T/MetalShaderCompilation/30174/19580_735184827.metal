

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
    float View_IndirectLightingCacheShowFlag;
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_Primitive
{
    char _m0_pad[80];
    float4 Primitive_ObjectWorldPositionAndRadius;
    char _m1_pad[204];
    float Primitive_UseSingleSampleShadowFromStationaryLights;
    float3 Primitive_ObjectBounds;
    float Primitive_DecalReceiverMask;
    float Primitive_PerObjectGBufferData;
    float Primitive_UseVolumetricLightmapShadowFromStationaryLights;
};

struct type_IndirectLightingCache
{
    char _m0_pad[64];
    float4 IndirectLightingCache_PointSkyBentNormal;
    float IndirectLightingCache_DirectionalLightShadowing;
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients0;
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients1;
    float4 IndirectLightingCache_IndirectLightingSHCoefficients2;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _172 = {};
constant float3 _173 = {};
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
    float4 in_var_COLOR1 [[user(locn2)]];
    float4 in_var_TEXCOORD0_0 [[user(locn3)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00004c7c_2bd207bb(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _237 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _241 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _246 = (_241.xyz / float3(_241.w)) - View.View_PreViewTranslation;
    float4 _254 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _257 = (_254.xy * float2(2.0)) - float2(1.0);
    float3 _274 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize(((float4(_257, sqrt(fast::clamp(1.0 - dot(_257, _257), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _286 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 20.0), bias(View.View_MaterialTextureMipBias));
    float _288 = mix(0.4000000059604644775390625, 1.0, _286.x);
    float4 _292 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(5.0)), bias(View.View_MaterialTextureMipBias));
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
    float4 _326 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _328 = _326.y;
    if (abs(in.in_var_COLOR1.w) > 0.001000000047497451305389404296875)
    {
        float _350 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
        if ((float((in.in_var_COLOR1.w < 0.0) ? ((in.in_var_COLOR1.w + 1.0) > _350) : (in.in_var_COLOR1.w < _350)) - 0.001000000047497451305389404296875) < 0.0)
        {
            discard_fragment();
        }
    }
    float3 _361 = fast::clamp(float3(mix(_288, 1.0 - _288, mix(_322, 1.0, _321)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_328 + mix(_322, 0.0, _321), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _366 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _328) + mix(mix(0.699999988079071044921875, 1.0, _322), 1.0, _321), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _413;
    float _414;
    float _415;
    float3 _416;
    float3 _417;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _383 = ((_237.xy / float2(_237.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _387 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _383, level(0.0));
        float4 _390 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _383, level(0.0));
        float4 _393 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _383, level(0.0));
        float _403 = _393.w;
        _413 = (_366 * _403) + _393.z;
        _414 = (0.5 * _403) + _393.y;
        _415 = _393.x;
        _416 = (_361 * _387.w) + _387.xyz;
        _417 = normalize((_274 * _390.w) + ((_390.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _413 = _366;
        _414 = 0.5;
        _415 = 0.0;
        _416 = _361;
        _417 = _274;
    }
    bool _425 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _431;
    if ((Primitive.Primitive_UseSingleSampleShadowFromStationaryLights > 0.0) && _425)
    {
        _431 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _431 = 1.0;
    }
    float _478;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _446 = fast::clamp((_246 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _457 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_446.x), int(_446.y), int(_446.z), 0).xyz), 0));
        _478 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_457.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_446 / float3(_457.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _478 = _431;
    }
    float3 _492 = ((_416 - (_416 * _415)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _499 = (mix(float3(0.07999999821186065673828125 * _414), _416, float3(_415)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _502 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _507;
    if (_502)
    {
        _507 = _492 + (_499 * 0.449999988079071044921875);
    }
    else
    {
        _507 = _492;
    }
    float3 _509 = select(_499, float3(0.0), bool3(_502));
    float3 _511 = float3(dot(_509, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _597;
    if (_425)
    {
        float4 _547 = _175;
        _547.y = (-0.48860299587249755859375) * _417.y;
        float4 _550 = _547;
        _550.z = 0.48860299587249755859375 * _417.z;
        float4 _553 = _550;
        _553.w = (-0.48860299587249755859375) * _417.x;
        float3 _554 = _417 * _417;
        float4 _557 = _172;
        _557.x = (1.09254801273345947265625 * _417.x) * _417.y;
        float4 _560 = _557;
        _560.y = ((-1.09254801273345947265625) * _417.y) * _417.z;
        float4 _565 = _560;
        _565.z = 0.3153919875621795654296875 * ((3.0 * _554.z) - 1.0);
        float4 _568 = _565;
        _568.w = ((-1.09254801273345947265625) * _417.x) * _417.z;
        float4 _572 = _553;
        _572.x = 0.886227548122406005859375;
        float3 _574 = _572.yzw * 2.094395160675048828125;
        float4 _575 = float4(_572.x, _574.x, _574.y, _574.z);
        float4 _576 = _568 * 0.785398185253143310546875;
        float _577 = (_554.x - _554.y) * 0.4290426075458526611328125;
        float3 _583 = float3(0.0);
        _583.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _575) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _576)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _577);
        float3 _589 = _583;
        _589.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _575) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _576)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _577);
        float3 _595 = _589;
        _595.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _575) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _576)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _577);
        _597 = fast::max(float3(0.0), _595);
    }
    else
    {
        _597 = float3(0.0);
    }
    float _623;
    float _624;
    float3 _625;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _613;
        float _614;
        if (_425)
        {
            _613 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _614 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _613 = _417;
            _614 = 1.0;
        }
        float _615 = 1.0 - _614;
        float _617 = 1.0 - (_615 * _615);
        _623 = mix(fast::clamp(dot(_613, _417), 0.0, 1.0), 1.0, _617);
        _624 = _614;
        _625 = mix(_613, _417, float3(_617));
    }
    else
    {
        _623 = 1.0;
        _624 = 1.0;
        _625 = _417;
    }
    float4 _629 = float4(_625, 1.0);
    float3 _633 = _173;
    _633.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _629);
    float3 _637 = _633;
    _637.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _629);
    float3 _641 = _637;
    _641.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _629);
    float4 _644 = _629.xyzz * _629.yzzx;
    float3 _648 = _173;
    _648.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _644);
    float3 _652 = _648;
    _652.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _644);
    float3 _656 = _652;
    _656.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _644);
    float3 _671 = (_597 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_641 + _656) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_625.x * _625.x) - (_625.y * _625.y)))) * View.View_SkyLightColor.xyz) * (_624 * _623));
    float3 _693 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _719;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _718;
        if (any(abs(_246 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _718 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_246, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _718 = _693;
        }
        _719 = _718;
    }
    else
    {
        _719 = _693;
    }
    float4 _726 = float4(((mix(float3(0.0), _507 + (_509 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_671 * _507) * fast::max(float3(1.0), ((((((_416 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_416 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_416 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _719) * 1.0, 0.0);
    float4 _733;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _732 = _726;
        _732.w = 0.0;
        _733 = _732;
    }
    else
    {
        _733 = _726;
    }
    float2 _737 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _745 = (_417 * 0.5) + float3(0.5);
    float4 _747 = float4(_745.x, _745.y, _745.z, float4(0.0).w);
    _747.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _748 = float4(0.0);
    _748.x = _415;
    float4 _749 = _748;
    _749.y = _414;
    float4 _750 = _749;
    _750.z = _413;
    float4 _751 = _750;
    _751.w = 0.50588238239288330078125;
    float4 _763 = float4(_416.x, _416.y, _416.z, float4(0.0).w);
    _763.w = ((log2(((dot(_671, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_511 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_511 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_511 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_737.xyx * _737.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _733 * View.View_PreExposure;
    out.out_var_SV_Target1 = _747;
    out.out_var_SV_Target2 = _751;
    out.out_var_SV_Target3 = _763;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_478, 1.0, 1.0, 1.0);
    return out;
}

