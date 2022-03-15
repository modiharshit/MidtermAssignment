

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

constant float4 _163 = {};
constant float4 _165 = {};

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
    float4 in_var_TEXCOORD10 [[user(locn0)]];
    float4 in_var_TEXCOORD11 [[user(locn1)]];
    float4 in_var_TEXCOORD1_0 [[user(locn2)]];
};

fragment MainPS_out Main_00003fb5_a111d71b(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD1 = {};
    in_var_TEXCOORD1[0] = in.in_var_TEXCOORD1_0;
    float4 _224 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _228 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _233 = (_228.xyz / float3(_228.w)) - View.View_PreViewTranslation;
    float4 _241 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD1[0].x, in_var_TEXCOORD1[0].y) * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _244 = (_241.xy * float2(2.0)) - float2(1.0);
    float3 _261 = normalize(float3x3(in.in_var_TEXCOORD10.xyz, cross(in.in_var_TEXCOORD11.xyz, in.in_var_TEXCOORD10.xyz) * in.in_var_TEXCOORD11.w, in.in_var_TEXCOORD11.xyz) * normalize(((float4(_244, sqrt(fast::clamp(1.0 - dot(_244, _244), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _273 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD1[0].x, in_var_TEXCOORD1[0].y) * 20.0), bias(View.View_MaterialTextureMipBias));
    float _275 = mix(0.4000000059604644775390625, 1.0, _273.x);
    float4 _279 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD1[0].x, in_var_TEXCOORD1[0].y) * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _304;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _304 = _224.w;
                break;
            }
            else
            {
                float _288 = _224.z;
                _304 = ((_288 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_288 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _308 = fast::min(fast::max((_304 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _309 = _279.y;
    float4 _313 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD1[0].x, in_var_TEXCOORD1[0].y) * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _315 = _313.y;
    float3 _328 = fast::clamp(float3(mix(_275, 1.0 - _275, mix(_309, 1.0, _308)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_315 + mix(_309, 0.0, _308), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _333 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _315) + mix(mix(0.699999988079071044921875, 1.0, _309), 1.0, _308), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _380;
    float _381;
    float _382;
    float3 _383;
    float3 _384;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _350 = ((_224.xy / float2(_224.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _354 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _350, level(0.0));
        float4 _357 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _350, level(0.0));
        float4 _360 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _350, level(0.0));
        float _370 = _360.w;
        _380 = (_333 * _370) + _360.z;
        _381 = (0.5 * _370) + _360.y;
        _382 = _360.x;
        _383 = (_328 * _354.w) + _354.xyz;
        _384 = normalize((_261 * _357.w) + ((_357.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _380 = _333;
        _381 = 0.5;
        _382 = 0.0;
        _383 = _328;
        _384 = _261;
    }
    bool _392 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _398;
    if ((Primitive.Primitive_UseSingleSampleShadowFromStationaryLights > 0.0) && _392)
    {
        _398 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _398 = 1.0;
    }
    float _445;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _413 = fast::clamp((_233 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _424 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_413.x), int(_413.y), int(_413.z), 0).xyz), 0));
        _445 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_424.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_413 / float3(_424.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _445 = _398;
    }
    float3 _459 = ((_383 - (_383 * _382)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _466 = (mix(float3(0.07999999821186065673828125 * _381), _383, float3(_382)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _469 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _474;
    if (_469)
    {
        _474 = _459 + (_466 * 0.449999988079071044921875);
    }
    else
    {
        _474 = _459;
    }
    float3 _476 = select(_466, float3(0.0), bool3(_469));
    float3 _478 = float3(dot(_476, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _564;
    if (_392)
    {
        float4 _514 = _165;
        _514.y = (-0.48860299587249755859375) * _384.y;
        float4 _517 = _514;
        _517.z = 0.48860299587249755859375 * _384.z;
        float4 _520 = _517;
        _520.w = (-0.48860299587249755859375) * _384.x;
        float3 _521 = _384 * _384;
        float4 _524 = _163;
        _524.x = (1.09254801273345947265625 * _384.x) * _384.y;
        float4 _527 = _524;
        _527.y = ((-1.09254801273345947265625) * _384.y) * _384.z;
        float4 _532 = _527;
        _532.z = 0.3153919875621795654296875 * ((3.0 * _521.z) - 1.0);
        float4 _535 = _532;
        _535.w = ((-1.09254801273345947265625) * _384.x) * _384.z;
        float4 _539 = _520;
        _539.x = 0.886227548122406005859375;
        float3 _541 = _539.yzw * 2.094395160675048828125;
        float4 _542 = float4(_539.x, _541.x, _541.y, _541.z);
        float4 _543 = _535 * 0.785398185253143310546875;
        float _544 = (_521.x - _521.y) * 0.4290426075458526611328125;
        float3 _550 = float3(0.0);
        _550.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _542) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _543)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _544);
        float3 _556 = _550;
        _556.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _542) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _543)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _544);
        float3 _562 = _556;
        _562.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _542) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _543)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _544);
        _564 = fast::max(float3(0.0), _562);
    }
    else
    {
        _564 = float3(0.0);
    }
    float3 _567 = _564 * View.View_IndirectLightingColorScale;
    float3 _589 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _615;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _614;
        if (any(abs(_233 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _614 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_233, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _614 = _589;
        }
        _615 = _614;
    }
    else
    {
        _615 = _589;
    }
    float4 _622 = float4(((mix(float3(0.0), _474 + (_476 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_567 * _474) * fast::max(float3(1.0), ((((((_383 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_383 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_383 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _615) * 1.0, 0.0);
    float4 _629;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _628 = _622;
        _628.w = 0.0;
        _629 = _628;
    }
    else
    {
        _629 = _622;
    }
    float2 _633 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _641 = (_384 * 0.5) + float3(0.5);
    float4 _643 = float4(_641.x, _641.y, _641.z, float4(0.0).w);
    _643.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _644 = float4(0.0);
    _644.x = _382;
    float4 _645 = _644;
    _645.y = _381;
    float4 _646 = _645;
    _646.z = _380;
    float4 _647 = _646;
    _647.w = 0.50588238239288330078125;
    float4 _659 = float4(_383.x, _383.y, _383.z, float4(0.0).w);
    _659.w = ((log2(((dot(_567, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_478 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_478 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_478 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_633.xyx * _633.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _629 * View.View_PreExposure;
    out.out_var_SV_Target1 = _643;
    out.out_var_SV_Target2 = _647;
    out.out_var_SV_Target3 = _659;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_445, 1.0, 1.0, 1.0);
    return out;
}

