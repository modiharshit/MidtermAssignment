

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
    char _m11_pad[80];
    float View_UnlitViewmodeMask;
    char _m12_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m13_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m14_pad[188];
    float View_ShowDecalsMask;
    char _m15_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m16_pad[48];
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

constant float4 _140 = {};
constant float _142 = {};
constant float4 _143 = {};

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
};

fragment MainPS_out Main_000035c8_d25c6171(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    float4 _195 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _142, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _200 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _205 = (_200.xyz / float3(_200.w)) - View.View_PreViewTranslation;
    float3 _213 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float _224 = (0.100000001490116119384765625 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _272;
    float _273;
    float _274;
    float3 _275;
    float3 _276;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _241 = ((_195.xy / float2(_195.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _245 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _241, level(0.0));
        float4 _248 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _241, level(0.0));
        float4 _251 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _241, level(0.0));
        float _261 = _251.w;
        _272 = (_224 * _261) + _251.z;
        _273 = (0.5 * _261) + _251.y;
        _274 = _261 + _251.x;
        _275 = (float3(1.0) * _245.w) + _245.xyz;
        _276 = normalize((_213 * _248.w) + ((_248.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _272 = _224;
        _273 = 0.5;
        _274 = 1.0;
        _275 = float3(1.0);
        _276 = _213;
    }
    bool _284 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _290;
    if ((Primitive.Primitive_UseSingleSampleShadowFromStationaryLights > 0.0) && _284)
    {
        _290 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _290 = 1.0;
    }
    float _337;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _305 = fast::clamp((_205 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _316 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_305.x), int(_305.y), int(_305.z), 0).xyz), 0));
        _337 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_316.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_305 / float3(_316.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _337 = _290;
    }
    float3 _351 = ((_275 - (_275 * _274)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _358 = (mix(float3(0.07999999821186065673828125 * _273), _275, float3(_274)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _361 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _366;
    if (_361)
    {
        _366 = _351 + (_358 * 0.449999988079071044921875);
    }
    else
    {
        _366 = _351;
    }
    float3 _368 = select(_358, float3(0.0), bool3(_361));
    float3 _370 = float3(dot(_368, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _456;
    if (_284)
    {
        float4 _406 = _143;
        _406.y = (-0.48860299587249755859375) * _276.y;
        float4 _409 = _406;
        _409.z = 0.48860299587249755859375 * _276.z;
        float4 _412 = _409;
        _412.w = (-0.48860299587249755859375) * _276.x;
        float3 _413 = _276 * _276;
        float4 _416 = _140;
        _416.x = (1.09254801273345947265625 * _276.x) * _276.y;
        float4 _419 = _416;
        _419.y = ((-1.09254801273345947265625) * _276.y) * _276.z;
        float4 _424 = _419;
        _424.z = 0.3153919875621795654296875 * ((3.0 * _413.z) - 1.0);
        float4 _427 = _424;
        _427.w = ((-1.09254801273345947265625) * _276.x) * _276.z;
        float4 _431 = _412;
        _431.x = 0.886227548122406005859375;
        float3 _433 = _431.yzw * 2.094395160675048828125;
        float4 _434 = float4(_431.x, _433.x, _433.y, _433.z);
        float4 _435 = _427 * 0.785398185253143310546875;
        float _436 = (_413.x - _413.y) * 0.4290426075458526611328125;
        float3 _442 = float3(0.0);
        _442.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _434) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _435)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _436);
        float3 _448 = _442;
        _448.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _434) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _435)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _436);
        float3 _454 = _448;
        _454.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _434) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _435)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _436);
        _456 = fast::max(float3(0.0), _454);
    }
    else
    {
        _456 = float3(0.0);
    }
    float3 _459 = _456 * View.View_IndirectLightingColorScale;
    float3 _481 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _507;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _506;
        if (any(abs(_205 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _506 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_205, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _506 = _481;
        }
        _507 = _506;
    }
    else
    {
        _507 = _481;
    }
    float4 _514 = float4(((mix(float3(0.0), _366 + (_368 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_459 * _366) * fast::max(float3(1.0), ((((((_275 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_275 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_275 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _507) * 1.0, 0.0);
    float4 _521;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _520 = _514;
        _520.w = 0.0;
        _521 = _520;
    }
    else
    {
        _521 = _514;
    }
    float2 _525 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _533 = (_276 * 0.5) + float3(0.5);
    float4 _535 = float4(_533.x, _533.y, _533.z, float4(0.0).w);
    _535.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _536 = float4(0.0);
    _536.x = _274;
    float4 _537 = _536;
    _537.y = _273;
    float4 _538 = _537;
    _538.z = _272;
    float4 _539 = _538;
    _539.w = 0.50588238239288330078125;
    float4 _551 = float4(_275.x, _275.y, _275.z, float4(0.0).w);
    _551.w = ((log2(((dot(_459, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_370 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_370 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_370 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_525.xyx * _525.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _521 * View.View_PreExposure;
    out.out_var_SV_Target1 = _535;
    out.out_var_SV_Target2 = _539;
    out.out_var_SV_Target3 = _551;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_337, 1.0, 1.0, 1.0);
    return out;
}

