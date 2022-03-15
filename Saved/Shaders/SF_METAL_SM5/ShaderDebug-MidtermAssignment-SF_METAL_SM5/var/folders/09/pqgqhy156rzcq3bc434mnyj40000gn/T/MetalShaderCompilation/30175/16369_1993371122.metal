

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
    char _m17_pad[188];
    float View_ShowDecalsMask;
    char _m18_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m19_pad[48];
    float3 View_VolumetricLightmapWorldToUVScale;
    float3 View_VolumetricLightmapWorldToUVAdd;
    packed_float3 View_VolumetricLightmapIndirectionTextureSize;
    float View_VolumetricLightmapBrickSize;
    float3 View_VolumetricLightmapBrickTexelSize;
    float View_IndirectLightingCacheShowFlag;
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
    char _m0_pad[80];
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

constant float4 _160 = {};
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
    float4 in_var_TEXCOORD0_0 [[user(locn2)]];
};

fragment MainPS_out Main_00003ff1_76d06df2(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    float4 _221 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _225 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _230 = (_225.xyz / float3(_225.w)) - View.View_PreViewTranslation;
    float4 _238 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _241 = (_238.xy * float2(2.0)) - float2(1.0);
    float3 _258 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize(((float4(_241, sqrt(fast::clamp(1.0 - dot(_241, _241), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _270 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 20.0), bias(View.View_MaterialTextureMipBias));
    float _272 = mix(0.4000000059604644775390625, 1.0, _270.x);
    float4 _276 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _301;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _301 = _221.w;
                break;
            }
            else
            {
                float _285 = _221.z;
                _301 = ((_285 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_285 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _305 = fast::min(fast::max((_301 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _306 = _276.y;
    float4 _310 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _312 = _310.y;
    float3 _325 = fast::clamp(float3(mix(_272, 1.0 - _272, mix(_306, 1.0, _305)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_312 + mix(_306, 0.0, _305), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _330 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _312) + mix(mix(0.699999988079071044921875, 1.0, _306), 1.0, _305), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _377;
    float _378;
    float _379;
    float3 _380;
    float3 _381;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _347 = ((_221.xy / float2(_221.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _351 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _347, level(0.0));
        float4 _354 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _347, level(0.0));
        float4 _357 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _347, level(0.0));
        float _367 = _357.w;
        _377 = (_330 * _367) + _357.z;
        _378 = (0.5 * _367) + _357.y;
        _379 = _357.x;
        _380 = (_325 * _351.w) + _351.xyz;
        _381 = normalize((_258 * _354.w) + ((_354.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _377 = _330;
        _378 = 0.5;
        _379 = 0.0;
        _380 = _325;
        _381 = _258;
    }
    bool _389 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _395;
    if ((Primitive.Primitive_UseSingleSampleShadowFromStationaryLights > 0.0) && _389)
    {
        _395 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _395 = 1.0;
    }
    float _442;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _410 = fast::clamp((_230 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _421 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_410.x), int(_410.y), int(_410.z), 0).xyz), 0));
        _442 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_421.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_410 / float3(_421.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _442 = _395;
    }
    float3 _456 = ((_380 - (_380 * _379)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _463 = (mix(float3(0.07999999821186065673828125 * _378), _380, float3(_379)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _466 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _471;
    if (_466)
    {
        _471 = _456 + (_463 * 0.449999988079071044921875);
    }
    else
    {
        _471 = _456;
    }
    float3 _473 = select(_463, float3(0.0), bool3(_466));
    float3 _475 = float3(dot(_473, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _561;
    if (_389)
    {
        float4 _511 = _162;
        _511.y = (-0.48860299587249755859375) * _381.y;
        float4 _514 = _511;
        _514.z = 0.48860299587249755859375 * _381.z;
        float4 _517 = _514;
        _517.w = (-0.48860299587249755859375) * _381.x;
        float3 _518 = _381 * _381;
        float4 _521 = _160;
        _521.x = (1.09254801273345947265625 * _381.x) * _381.y;
        float4 _524 = _521;
        _524.y = ((-1.09254801273345947265625) * _381.y) * _381.z;
        float4 _529 = _524;
        _529.z = 0.3153919875621795654296875 * ((3.0 * _518.z) - 1.0);
        float4 _532 = _529;
        _532.w = ((-1.09254801273345947265625) * _381.x) * _381.z;
        float4 _536 = _517;
        _536.x = 0.886227548122406005859375;
        float3 _538 = _536.yzw * 2.094395160675048828125;
        float4 _539 = float4(_536.x, _538.x, _538.y, _538.z);
        float4 _540 = _532 * 0.785398185253143310546875;
        float _541 = (_518.x - _518.y) * 0.4290426075458526611328125;
        float3 _547 = float3(0.0);
        _547.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _539) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _540)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _541);
        float3 _553 = _547;
        _553.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _539) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _540)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _541);
        float3 _559 = _553;
        _559.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _539) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _540)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _541);
        _561 = fast::max(float3(0.0), _559);
    }
    else
    {
        _561 = float3(0.0);
    }
    float3 _564 = _561 * View.View_IndirectLightingColorScale;
    float3 _586 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _612;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _611;
        if (any(abs(_230 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _611 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_230, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _611 = _586;
        }
        _612 = _611;
    }
    else
    {
        _612 = _586;
    }
    float4 _619 = float4(((mix(float3(0.0), _471 + (_473 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_564 * _471) * fast::max(float3(1.0), ((((((_380 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_380 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_380 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _612) * 1.0, 0.0);
    float4 _626;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _625 = _619;
        _625.w = 0.0;
        _626 = _625;
    }
    else
    {
        _626 = _619;
    }
    float2 _630 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _638 = (_381 * 0.5) + float3(0.5);
    float4 _640 = float4(_638.x, _638.y, _638.z, float4(0.0).w);
    _640.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _641 = float4(0.0);
    _641.x = _379;
    float4 _642 = _641;
    _642.y = _378;
    float4 _643 = _642;
    _643.z = _377;
    float4 _644 = _643;
    _644.w = 0.50588238239288330078125;
    float4 _656 = float4(_380.x, _380.y, _380.z, float4(0.0).w);
    _656.w = ((log2(((dot(_564, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_475 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_475 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_475 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_630.xyx * _630.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _626 * View.View_PreExposure;
    out.out_var_SV_Target1 = _640;
    out.out_var_SV_Target2 = _644;
    out.out_var_SV_Target3 = _656;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_442, 1.0, 1.0, 1.0);
    return out;
}

