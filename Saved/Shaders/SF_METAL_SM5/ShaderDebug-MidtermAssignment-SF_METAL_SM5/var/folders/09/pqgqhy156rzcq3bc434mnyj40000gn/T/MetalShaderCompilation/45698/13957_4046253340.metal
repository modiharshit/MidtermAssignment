

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
    spvUnsafeArray<float4, 4> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _139 = {};
constant float _141 = {};
constant float4 _142 = {};

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

fragment MainPS_out Main_00003685_f12ced1c(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    float4 _194 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _141, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _199 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _204 = (_199.xyz / float3(_199.w)) - View.View_PreViewTranslation;
    float3 _212 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _227 = fast::clamp(Material.Material_VectorExpressions[3].xyz, float3(0.0), float3(1.0));
    float _228 = fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0);
    float _233 = (fast::clamp(Material.Material_ScalarExpressions[0].z, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _280;
    float _281;
    float _282;
    float3 _283;
    float3 _284;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _250 = ((_194.xy / float2(_194.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _254 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _250, level(0.0));
        float4 _257 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _250, level(0.0));
        float4 _260 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _250, level(0.0));
        float _270 = _260.w;
        _280 = (_233 * _270) + _260.z;
        _281 = (_228 * _270) + _260.y;
        _282 = _260.x;
        _283 = (_227 * _254.w) + _254.xyz;
        _284 = normalize((_212 * _257.w) + ((_257.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _280 = _233;
        _281 = _228;
        _282 = 0.0;
        _283 = _227;
        _284 = _212;
    }
    bool _292 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _298;
    if ((Primitive.Primitive_UseSingleSampleShadowFromStationaryLights > 0.0) && _292)
    {
        _298 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _298 = 1.0;
    }
    float _345;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _313 = fast::clamp((_204 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _324 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_313.x), int(_313.y), int(_313.z), 0).xyz), 0));
        _345 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_324.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_313 / float3(_324.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _345 = _298;
    }
    float3 _359 = ((_283 - (_283 * _282)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _366 = (mix(float3(0.07999999821186065673828125 * _281), _283, float3(_282)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _369 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _374;
    if (_369)
    {
        _374 = _359 + (_366 * 0.449999988079071044921875);
    }
    else
    {
        _374 = _359;
    }
    float3 _376 = select(_366, float3(0.0), bool3(_369));
    float3 _378 = float3(dot(_376, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _464;
    if (_292)
    {
        float4 _414 = _142;
        _414.y = (-0.48860299587249755859375) * _284.y;
        float4 _417 = _414;
        _417.z = 0.48860299587249755859375 * _284.z;
        float4 _420 = _417;
        _420.w = (-0.48860299587249755859375) * _284.x;
        float3 _421 = _284 * _284;
        float4 _424 = _139;
        _424.x = (1.09254801273345947265625 * _284.x) * _284.y;
        float4 _427 = _424;
        _427.y = ((-1.09254801273345947265625) * _284.y) * _284.z;
        float4 _432 = _427;
        _432.z = 0.3153919875621795654296875 * ((3.0 * _421.z) - 1.0);
        float4 _435 = _432;
        _435.w = ((-1.09254801273345947265625) * _284.x) * _284.z;
        float4 _439 = _420;
        _439.x = 0.886227548122406005859375;
        float3 _441 = _439.yzw * 2.094395160675048828125;
        float4 _442 = float4(_439.x, _441.x, _441.y, _441.z);
        float4 _443 = _435 * 0.785398185253143310546875;
        float _444 = (_421.x - _421.y) * 0.4290426075458526611328125;
        float3 _450 = float3(0.0);
        _450.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _442) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _443)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _444);
        float3 _456 = _450;
        _456.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _442) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _443)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _444);
        float3 _462 = _456;
        _462.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _442) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _443)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _444);
        _464 = fast::max(float3(0.0), _462);
    }
    else
    {
        _464 = float3(0.0);
    }
    float3 _467 = _464 * View.View_IndirectLightingColorScale;
    float3 _489 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _515;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _514;
        if (any(abs(_204 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _514 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_204, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _514 = _489;
        }
        _515 = _514;
    }
    else
    {
        _515 = _489;
    }
    float4 _522 = float4(((mix(float3(0.0), _374 + (_376 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_467 * _374) * fast::max(float3(1.0), ((((((_283 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_283 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_283 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _515) * 1.0, 0.0);
    float4 _529;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _528 = _522;
        _528.w = 0.0;
        _529 = _528;
    }
    else
    {
        _529 = _522;
    }
    float2 _533 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _541 = (_284 * 0.5) + float3(0.5);
    float4 _543 = float4(_541.x, _541.y, _541.z, float4(0.0).w);
    _543.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _544 = float4(0.0);
    _544.x = _282;
    float4 _545 = _544;
    _545.y = _281;
    float4 _546 = _545;
    _546.z = _280;
    float4 _547 = _546;
    _547.w = 0.50588238239288330078125;
    float4 _559 = float4(_283.x, _283.y, _283.z, float4(0.0).w);
    _559.w = ((log2(((dot(_467, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_378 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_378 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_378 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_533.xyx * _533.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _529 * View.View_PreExposure;
    out.out_var_SV_Target1 = _543;
    out.out_var_SV_Target2 = _547;
    out.out_var_SV_Target3 = _559;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_345, 1.0, 1.0, 1.0);
    return out;
}

