

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
    float2 in_var_TEXCOORD0 [[user(locn0)]];
    float4 in_var_TEXCOORD1 [[user(locn1)]];
};

fragment MainPS_out Main_00004249_20f68d0a(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_LandscapeParameters& LandscapeParameters [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> LandscapeParameters_NormalmapTexture [[texture(5)]], texture2d<float> Material_Texture2D_0 [[texture(6)]], texture2d<float> Material_Texture2D_1 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler LandscapeParameters_NormalmapTextureSampler [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    float4 _208 = LandscapeParameters_NormalmapTexture.sample(LandscapeParameters_NormalmapTextureSampler, in.in_var_TEXCOORD1.zw);
    float2 _213 = (float2(_208.zw) * float2(2.0)) - float2(1.0);
    float _217 = sqrt(fast::max(1.0 - dot(_213, _213), 0.0));
    float _218 = _213.x;
    float3 _220 = float3(_218, _213.y, _217);
    float3 _223 = normalize(float3(_217, 0.0, -_218));
    float4 _247 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _251 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _256 = (_251.xyz / float3(_251.w)) - View.View_PreViewTranslation;
    float4 _264 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (in.in_var_TEXCOORD0 * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _267 = (_264.xy * float2(2.0)) - float2(1.0);
    float3 _284 = normalize((float3x3(LandscapeParameters.LandscapeParameters_LocalToWorldNoScaling[0].xyz, LandscapeParameters.LandscapeParameters_LocalToWorldNoScaling[1].xyz, LandscapeParameters.LandscapeParameters_LocalToWorldNoScaling[2].xyz) * float3x3(_223, cross(_220, _223), _220)) * normalize(((float4(_267, sqrt(fast::clamp(1.0 - dot(_267, _267), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _296 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in.in_var_TEXCOORD0 * 20.0), bias(View.View_MaterialTextureMipBias));
    float _298 = mix(0.4000000059604644775390625, 1.0, _296.x);
    float4 _302 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in.in_var_TEXCOORD0 * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _327;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _327 = _247.w;
                break;
            }
            else
            {
                float _311 = _247.z;
                _327 = ((_311 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_311 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _331 = fast::min(fast::max((_327 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _332 = _302.y;
    float4 _336 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in.in_var_TEXCOORD0 * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _338 = _336.y;
    float3 _351 = fast::clamp(float3(mix(_298, 1.0 - _298, mix(_332, 1.0, _331)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_338 + mix(_332, 0.0, _331), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _356 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _338) + mix(mix(0.699999988079071044921875, 1.0, _332), 1.0, _331), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _403;
    float _404;
    float _405;
    float3 _406;
    float3 _407;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _373 = ((_247.xy / float2(_247.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _377 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _373, level(0.0));
        float4 _380 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _373, level(0.0));
        float4 _383 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _373, level(0.0));
        float _393 = _383.w;
        _403 = (_356 * _393) + _383.z;
        _404 = (0.5 * _393) + _383.y;
        _405 = _383.x;
        _406 = (_351 * _377.w) + _377.xyz;
        _407 = normalize((_284 * _380.w) + ((_380.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _403 = _356;
        _404 = 0.5;
        _405 = 0.0;
        _406 = _351;
        _407 = _284;
    }
    bool _415 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _421;
    if ((Primitive.Primitive_UseSingleSampleShadowFromStationaryLights > 0.0) && _415)
    {
        _421 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _421 = 1.0;
    }
    float _468;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _436 = fast::clamp((_256 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _447 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_436.x), int(_436.y), int(_436.z), 0).xyz), 0));
        _468 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_447.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_436 / float3(_447.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _468 = _421;
    }
    float3 _482 = ((_406 - (_406 * _405)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _489 = (mix(float3(0.07999999821186065673828125 * _404), _406, float3(_405)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _492 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _497;
    if (_492)
    {
        _497 = _482 + (_489 * 0.449999988079071044921875);
    }
    else
    {
        _497 = _482;
    }
    float3 _499 = select(_489, float3(0.0), bool3(_492));
    float3 _501 = float3(dot(_499, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _587;
    if (_415)
    {
        float4 _537 = _165;
        _537.y = (-0.48860299587249755859375) * _407.y;
        float4 _540 = _537;
        _540.z = 0.48860299587249755859375 * _407.z;
        float4 _543 = _540;
        _543.w = (-0.48860299587249755859375) * _407.x;
        float3 _544 = _407 * _407;
        float4 _547 = _163;
        _547.x = (1.09254801273345947265625 * _407.x) * _407.y;
        float4 _550 = _547;
        _550.y = ((-1.09254801273345947265625) * _407.y) * _407.z;
        float4 _555 = _550;
        _555.z = 0.3153919875621795654296875 * ((3.0 * _544.z) - 1.0);
        float4 _558 = _555;
        _558.w = ((-1.09254801273345947265625) * _407.x) * _407.z;
        float4 _562 = _543;
        _562.x = 0.886227548122406005859375;
        float3 _564 = _562.yzw * 2.094395160675048828125;
        float4 _565 = float4(_562.x, _564.x, _564.y, _564.z);
        float4 _566 = _558 * 0.785398185253143310546875;
        float _567 = (_544.x - _544.y) * 0.4290426075458526611328125;
        float3 _573 = float3(0.0);
        _573.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _565) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _566)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _567);
        float3 _579 = _573;
        _579.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _565) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _566)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _567);
        float3 _585 = _579;
        _585.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _565) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _566)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _567);
        _587 = fast::max(float3(0.0), _585);
    }
    else
    {
        _587 = float3(0.0);
    }
    float3 _590 = _587 * View.View_IndirectLightingColorScale;
    float3 _612 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _638;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _637;
        if (any(abs(_256 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _637 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_256, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _637 = _612;
        }
        _638 = _637;
    }
    else
    {
        _638 = _612;
    }
    float4 _645 = float4(((mix(float3(0.0), _497 + (_499 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_590 * _497) * fast::max(float3(1.0), ((((((_406 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_406 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_406 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _638) * 1.0, 0.0);
    float4 _652;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _651 = _645;
        _651.w = 0.0;
        _652 = _651;
    }
    else
    {
        _652 = _645;
    }
    float2 _656 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _664 = (_407 * 0.5) + float3(0.5);
    float4 _666 = float4(_664.x, _664.y, _664.z, float4(0.0).w);
    _666.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _667 = float4(0.0);
    _667.x = _405;
    float4 _668 = _667;
    _668.y = _404;
    float4 _669 = _668;
    _669.z = _403;
    float4 _670 = _669;
    _670.w = 0.50588238239288330078125;
    float4 _682 = float4(_406.x, _406.y, _406.z, float4(0.0).w);
    _682.w = ((log2(((dot(_590, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_501 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_501 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_501 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_656.xyx * _656.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _652 * View.View_PreExposure;
    out.out_var_SV_Target1 = _666;
    out.out_var_SV_Target2 = _670;
    out.out_var_SV_Target3 = _682;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_468, 1.0, 1.0, 1.0);
    return out;
}

