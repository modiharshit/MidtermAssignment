

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

constant float4 _162 = {};
constant float4 _164 = {};

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
    float4 in_var_TEXCOORD0_0 [[user(locn0)]];
    float4 in_var_TANGENTX [[user(locn2)]];
    float4 in_var_TANGENTZ [[user(locn3)]];
};

fragment MainPS_out Main_00003fa3_4524ba55(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    float4 _223 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _227 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _232 = (_227.xyz / float3(_227.w)) - View.View_PreViewTranslation;
    float4 _240 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _243 = (_240.xy * float2(2.0)) - float2(1.0);
    float3 _260 = normalize(float3x3(in.in_var_TANGENTX.xyz, cross(in.in_var_TANGENTZ.xyz, in.in_var_TANGENTX.xyz) * in.in_var_TANGENTZ.w, in.in_var_TANGENTZ.xyz) * normalize(((float4(_243, sqrt(fast::clamp(1.0 - dot(_243, _243), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _272 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 20.0), bias(View.View_MaterialTextureMipBias));
    float _274 = mix(0.4000000059604644775390625, 1.0, _272.x);
    float4 _278 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _303;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _303 = _223.w;
                break;
            }
            else
            {
                float _287 = _223.z;
                _303 = ((_287 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_287 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _307 = fast::min(fast::max((_303 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _308 = _278.y;
    float4 _312 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _314 = _312.y;
    float3 _327 = fast::clamp(float3(mix(_274, 1.0 - _274, mix(_308, 1.0, _307)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_314 + mix(_308, 0.0, _307), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _332 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _314) + mix(mix(0.699999988079071044921875, 1.0, _308), 1.0, _307), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _379;
    float _380;
    float _381;
    float3 _382;
    float3 _383;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _349 = ((_223.xy / float2(_223.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _353 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _349, level(0.0));
        float4 _356 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _349, level(0.0));
        float4 _359 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _349, level(0.0));
        float _369 = _359.w;
        _379 = (_332 * _369) + _359.z;
        _380 = (0.5 * _369) + _359.y;
        _381 = _359.x;
        _382 = (_327 * _353.w) + _353.xyz;
        _383 = normalize((_260 * _356.w) + ((_356.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _379 = _332;
        _380 = 0.5;
        _381 = 0.0;
        _382 = _327;
        _383 = _260;
    }
    bool _391 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _397;
    if ((Primitive.Primitive_UseSingleSampleShadowFromStationaryLights > 0.0) && _391)
    {
        _397 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _397 = 1.0;
    }
    float _444;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _412 = fast::clamp((_232 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _423 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_412.x), int(_412.y), int(_412.z), 0).xyz), 0));
        _444 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_423.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_412 / float3(_423.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _444 = _397;
    }
    float3 _458 = ((_382 - (_382 * _381)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _465 = (mix(float3(0.07999999821186065673828125 * _380), _382, float3(_381)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _468 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _473;
    if (_468)
    {
        _473 = _458 + (_465 * 0.449999988079071044921875);
    }
    else
    {
        _473 = _458;
    }
    float3 _475 = select(_465, float3(0.0), bool3(_468));
    float3 _477 = float3(dot(_475, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _563;
    if (_391)
    {
        float4 _513 = _164;
        _513.y = (-0.48860299587249755859375) * _383.y;
        float4 _516 = _513;
        _516.z = 0.48860299587249755859375 * _383.z;
        float4 _519 = _516;
        _519.w = (-0.48860299587249755859375) * _383.x;
        float3 _520 = _383 * _383;
        float4 _523 = _162;
        _523.x = (1.09254801273345947265625 * _383.x) * _383.y;
        float4 _526 = _523;
        _526.y = ((-1.09254801273345947265625) * _383.y) * _383.z;
        float4 _531 = _526;
        _531.z = 0.3153919875621795654296875 * ((3.0 * _520.z) - 1.0);
        float4 _534 = _531;
        _534.w = ((-1.09254801273345947265625) * _383.x) * _383.z;
        float4 _538 = _519;
        _538.x = 0.886227548122406005859375;
        float3 _540 = _538.yzw * 2.094395160675048828125;
        float4 _541 = float4(_538.x, _540.x, _540.y, _540.z);
        float4 _542 = _534 * 0.785398185253143310546875;
        float _543 = (_520.x - _520.y) * 0.4290426075458526611328125;
        float3 _549 = float3(0.0);
        _549.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _541) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _542)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _543);
        float3 _555 = _549;
        _555.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _541) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _542)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _543);
        float3 _561 = _555;
        _561.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _541) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _542)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _543);
        _563 = fast::max(float3(0.0), _561);
    }
    else
    {
        _563 = float3(0.0);
    }
    float3 _566 = _563 * View.View_IndirectLightingColorScale;
    float3 _588 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _614;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _613;
        if (any(abs(_232 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _613 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_232, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _613 = _588;
        }
        _614 = _613;
    }
    else
    {
        _614 = _588;
    }
    float4 _621 = float4(((mix(float3(0.0), _473 + (_475 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_566 * _473) * fast::max(float3(1.0), ((((((_382 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_382 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_382 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _614) * 1.0, 0.0);
    float4 _628;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _627 = _621;
        _627.w = 0.0;
        _628 = _627;
    }
    else
    {
        _628 = _621;
    }
    float2 _632 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _640 = (_383 * 0.5) + float3(0.5);
    float4 _642 = float4(_640.x, _640.y, _640.z, float4(0.0).w);
    _642.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _643 = float4(0.0);
    _643.x = _381;
    float4 _644 = _643;
    _644.y = _380;
    float4 _645 = _644;
    _645.z = _379;
    float4 _646 = _645;
    _646.w = 0.50588238239288330078125;
    float4 _658 = float4(_382.x, _382.y, _382.z, float4(0.0).w);
    _658.w = ((log2(((dot(_566, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_477 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_477 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_477 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_632.xyx * _632.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _628 * View.View_PreExposure;
    out.out_var_SV_Target1 = _642;
    out.out_var_SV_Target2 = _646;
    out.out_var_SV_Target3 = _658;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_444, 1.0, 1.0, 1.0);
    return out;
}

