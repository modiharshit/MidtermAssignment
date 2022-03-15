

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
    char _m12_pad[52];
    float View_UnlitViewmodeMask;
    char _m13_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m14_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m15_pad[188];
    float View_ShowDecalsMask;
    char _m16_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m17_pad[48];
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
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _142 = {};
constant float _144 = {};
constant float4 _145 = {};

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
};

fragment MainPS_out Main_00003706_989f963e(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]], bool gl_FrontFacing [[front_facing]])
{
    MainPS_out out = {};
    float4 _202 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _144, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _207 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _212 = (_207.xyz / float3(_207.w)) - View.View_PreViewTranslation;
    float3 _226 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * ((View.View_CullingSign * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w) * float(gl_FrontFacing ? 1 : (-1)));
    float3 _235 = fast::clamp(in.in_var_COLOR0.xyz, float3(0.0), float3(1.0));
    float _239 = (0.5 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _284;
    float _285;
    float _286;
    float3 _287;
    float3 _288;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _256 = ((_202.xy / float2(_202.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _260 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _256, level(0.0));
        float4 _263 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _256, level(0.0));
        float4 _266 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _256, level(0.0));
        _284 = (_239 * _266.w) + _266.z;
        _285 = _266.y;
        _286 = _266.x;
        _287 = (_235 * _260.w) + _260.xyz;
        _288 = normalize((_226 * _263.w) + ((_263.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _284 = _239;
        _285 = 0.0;
        _286 = 0.0;
        _287 = _235;
        _288 = _226;
    }
    bool _296 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _302;
    if ((Primitive.Primitive_UseSingleSampleShadowFromStationaryLights > 0.0) && _296)
    {
        _302 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _302 = 1.0;
    }
    float _349;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _317 = fast::clamp((_212 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _328 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_317.x), int(_317.y), int(_317.z), 0).xyz), 0));
        _349 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_328.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_317 / float3(_328.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _349 = _302;
    }
    float3 _363 = ((_287 - (_287 * _286)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _370 = (mix(float3(0.07999999821186065673828125 * _285), _287, float3(_286)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _373 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _378;
    if (_373)
    {
        _378 = _363 + (_370 * 0.449999988079071044921875);
    }
    else
    {
        _378 = _363;
    }
    float3 _380 = select(_370, float3(0.0), bool3(_373));
    float3 _382 = float3(dot(_380, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _468;
    if (_296)
    {
        float4 _418 = _145;
        _418.y = (-0.48860299587249755859375) * _288.y;
        float4 _421 = _418;
        _421.z = 0.48860299587249755859375 * _288.z;
        float4 _424 = _421;
        _424.w = (-0.48860299587249755859375) * _288.x;
        float3 _425 = _288 * _288;
        float4 _428 = _142;
        _428.x = (1.09254801273345947265625 * _288.x) * _288.y;
        float4 _431 = _428;
        _431.y = ((-1.09254801273345947265625) * _288.y) * _288.z;
        float4 _436 = _431;
        _436.z = 0.3153919875621795654296875 * ((3.0 * _425.z) - 1.0);
        float4 _439 = _436;
        _439.w = ((-1.09254801273345947265625) * _288.x) * _288.z;
        float4 _443 = _424;
        _443.x = 0.886227548122406005859375;
        float3 _445 = _443.yzw * 2.094395160675048828125;
        float4 _446 = float4(_443.x, _445.x, _445.y, _445.z);
        float4 _447 = _439 * 0.785398185253143310546875;
        float _448 = (_425.x - _425.y) * 0.4290426075458526611328125;
        float3 _454 = float3(0.0);
        _454.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _446) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _447)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _448);
        float3 _460 = _454;
        _460.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _446) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _447)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _448);
        float3 _466 = _460;
        _466.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _446) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _447)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _448);
        _468 = fast::max(float3(0.0), _466);
    }
    else
    {
        _468 = float3(0.0);
    }
    float3 _471 = _468 * View.View_IndirectLightingColorScale;
    float3 _493 = fast::max(mix(in.in_var_COLOR0.xyz, Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _519;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _518;
        if (any(abs(_212 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _518 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_212, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _518 = _493;
        }
        _519 = _518;
    }
    else
    {
        _519 = _493;
    }
    float4 _526 = float4(((mix(float3(0.0), _378 + (_380 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_471 * _378) * fast::max(float3(1.0), ((((((_287 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_287 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_287 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _519) * 1.0, 0.0);
    float4 _533;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _532 = _526;
        _532.w = 0.0;
        _533 = _532;
    }
    else
    {
        _533 = _526;
    }
    float2 _537 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _545 = (_288 * 0.5) + float3(0.5);
    float4 _547 = float4(_545.x, _545.y, _545.z, float4(0.0).w);
    _547.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _548 = float4(0.0);
    _548.x = _286;
    float4 _549 = _548;
    _549.y = _285;
    float4 _550 = _549;
    _550.z = _284;
    float4 _551 = _550;
    _551.w = 0.50588238239288330078125;
    float4 _563 = float4(_287.x, _287.y, _287.z, float4(0.0).w);
    _563.w = ((log2(((dot(_471, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_382 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_382 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_382 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_537.xyx * _537.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _533 * View.View_PreExposure;
    out.out_var_SV_Target1 = _547;
    out.out_var_SV_Target2 = _551;
    out.out_var_SV_Target3 = _563;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_349, 1.0, 1.0, 1.0);
    return out;
}

