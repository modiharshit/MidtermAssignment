

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

constant float4 _157 = {};
constant float4 _159 = {};

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
    float4 in_var_TEXCOORD2 [[user(locn2)]];
};

fragment MainPS_out Main_00003f18_b4647e22(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    float4 _217 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _221 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _226 = (_221.xyz / float3(_221.w)) - View.View_PreViewTranslation;
    float4 _234 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (in.in_var_TEXCOORD2.xy * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _237 = (_234.xy * float2(2.0)) - float2(1.0);
    float3 _254 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize(((float4(_237, sqrt(fast::clamp(1.0 - dot(_237, _237), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _266 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in.in_var_TEXCOORD2.xy * 20.0), bias(View.View_MaterialTextureMipBias));
    float _268 = mix(0.4000000059604644775390625, 1.0, _266.x);
    float4 _272 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in.in_var_TEXCOORD2.xy * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _297;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _297 = _217.w;
                break;
            }
            else
            {
                float _281 = _217.z;
                _297 = ((_281 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_281 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _301 = fast::min(fast::max((_297 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _302 = _272.y;
    float4 _306 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in.in_var_TEXCOORD2.xy * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _308 = _306.y;
    float3 _321 = fast::clamp(float3(mix(_268, 1.0 - _268, mix(_302, 1.0, _301)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_308 + mix(_302, 0.0, _301), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _326 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _308) + mix(mix(0.699999988079071044921875, 1.0, _302), 1.0, _301), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _373;
    float _374;
    float _375;
    float3 _376;
    float3 _377;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _343 = ((_217.xy / float2(_217.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _347 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _343, level(0.0));
        float4 _350 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _343, level(0.0));
        float4 _353 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _343, level(0.0));
        float _363 = _353.w;
        _373 = (_326 * _363) + _353.z;
        _374 = (0.5 * _363) + _353.y;
        _375 = _353.x;
        _376 = (_321 * _347.w) + _347.xyz;
        _377 = normalize((_254 * _350.w) + ((_350.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _373 = _326;
        _374 = 0.5;
        _375 = 0.0;
        _376 = _321;
        _377 = _254;
    }
    bool _385 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _391;
    if ((Primitive.Primitive_UseSingleSampleShadowFromStationaryLights > 0.0) && _385)
    {
        _391 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _391 = 1.0;
    }
    float _438;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _406 = fast::clamp((_226 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _417 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_406.x), int(_406.y), int(_406.z), 0).xyz), 0));
        _438 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_417.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_406 / float3(_417.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _438 = _391;
    }
    float3 _452 = ((_376 - (_376 * _375)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _459 = (mix(float3(0.07999999821186065673828125 * _374), _376, float3(_375)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
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
    float3 _557;
    if (_385)
    {
        float4 _507 = _159;
        _507.y = (-0.48860299587249755859375) * _377.y;
        float4 _510 = _507;
        _510.z = 0.48860299587249755859375 * _377.z;
        float4 _513 = _510;
        _513.w = (-0.48860299587249755859375) * _377.x;
        float3 _514 = _377 * _377;
        float4 _517 = _157;
        _517.x = (1.09254801273345947265625 * _377.x) * _377.y;
        float4 _520 = _517;
        _520.y = ((-1.09254801273345947265625) * _377.y) * _377.z;
        float4 _525 = _520;
        _525.z = 0.3153919875621795654296875 * ((3.0 * _514.z) - 1.0);
        float4 _528 = _525;
        _528.w = ((-1.09254801273345947265625) * _377.x) * _377.z;
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
        _557 = fast::max(float3(0.0), _555);
    }
    else
    {
        _557 = float3(0.0);
    }
    float3 _560 = _557 * View.View_IndirectLightingColorScale;
    float3 _582 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _608;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _607;
        if (any(abs(_226 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _607 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_226, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _607 = _582;
        }
        _608 = _607;
    }
    else
    {
        _608 = _582;
    }
    float4 _615 = float4(((mix(float3(0.0), _467 + (_469 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_560 * _467) * fast::max(float3(1.0), ((((((_376 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_376 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_376 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _608) * 1.0, 0.0);
    float4 _622;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _621 = _615;
        _621.w = 0.0;
        _622 = _621;
    }
    else
    {
        _622 = _615;
    }
    float2 _626 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _634 = (_377 * 0.5) + float3(0.5);
    float4 _636 = float4(_634.x, _634.y, _634.z, float4(0.0).w);
    _636.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _637 = float4(0.0);
    _637.x = _375;
    float4 _638 = _637;
    _638.y = _374;
    float4 _639 = _638;
    _639.z = _373;
    float4 _640 = _639;
    _640.w = 0.50588238239288330078125;
    float4 _652 = float4(_376.x, _376.y, _376.z, float4(0.0).w);
    _652.w = ((log2(((dot(_560, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_471 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_471 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_471 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_626.xyx * _626.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _622 * View.View_PreExposure;
    out.out_var_SV_Target1 = _636;
    out.out_var_SV_Target2 = _640;
    out.out_var_SV_Target3 = _652;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_438, 1.0, 1.0, 1.0);
    return out;
}

