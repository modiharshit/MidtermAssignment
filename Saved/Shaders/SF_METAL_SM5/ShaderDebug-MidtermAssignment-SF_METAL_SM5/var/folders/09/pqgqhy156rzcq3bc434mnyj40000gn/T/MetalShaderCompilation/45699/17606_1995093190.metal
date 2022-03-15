

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
    char _m16_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m18_pad[124];
    float View_ShowDecalsMask;
    char _m19_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_Primitive
{
    char _m0_pad[64];
    float4 Primitive_InvNonUniformScaleAndDeterminantSign;
    float4 Primitive_ObjectWorldPositionAndRadius;
    char _m2_pad[208];
    float3 Primitive_ObjectBounds;
    float Primitive_DecalReceiverMask;
    float Primitive_PerObjectGBufferData;
};

struct type_PrecomputedLightingBuffer
{
    char _m0_pad[64];
    spvUnsafeArray<float4, 2> PrecomputedLightingBuffer_LightMapScale;
    spvUnsafeArray<float4, 2> PrecomputedLightingBuffer_LightMapAdd;
};

struct type_Material
{
    spvUnsafeArray<float4, 7> Material_VectorExpressions;
    spvUnsafeArray<float4, 6> Material_ScalarExpressions;
};

constant float _153 = {};
constant float3 _154 = {};
constant float _155 = {};
constant float3 _156 = {};

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
    float4 in_var_TEXCOORD4 [[user(locn5)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_000044c6_76eab4c6(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_PrecomputedLightingBuffer& PrecomputedLightingBuffer [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_3 [[texture(7)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_3Sampler [[sampler(4)]], float4 gl_FragCoord [[position]], bool gl_FrontFacing [[front_facing]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _215 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _155, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _220 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _225 = (_220.xyz / float3(_220.w)) - View.View_PreViewTranslation;
    float4 _237 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _248 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((((float3(-0.5) + _237.xyz) * 2.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * ((View.View_CullingSign * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w) * float(gl_FrontFacing ? 1 : (-1)));
    float4 _259 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _266 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    if (abs(in.in_var_COLOR1.w) > 0.001000000047497451305389404296875)
    {
        float _282 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
        if ((float((in.in_var_COLOR1.w < 0.0) ? ((in.in_var_COLOR1.w + 1.0) > _282) : (in.in_var_COLOR1.w < _282)) - 0.001000000047497451305389404296875) < 0.0)
        {
            discard_fragment();
        }
    }
    if (((in.in_var_COLOR0.w * _259.w) - 0.100000001490116119384765625) < 0.0)
    {
        discard_fragment();
    }
    float3 _297 = fast::clamp(_259.xyz, float3(0.0), float3(1.0));
    float _302 = (fast::clamp(_237.w, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float3 _312 = (fast::clamp(float4(_266.xyz, _153).xyz, float3(0.0), float3(1.0)).xyz * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _360;
    float _361;
    float _362;
    float _363;
    float3 _364;
    float3 _365;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _329 = ((_215.xy / float2(_215.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _333 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _329, level(0.0));
        float4 _336 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _329, level(0.0));
        float4 _339 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _329, level(0.0));
        float _341 = _333.w;
        float _349 = _339.w;
        _360 = _312 * _341;
        _361 = (_302 * _349) + _339.z;
        _362 = (0.5 * _349) + _339.y;
        _363 = _339.x;
        _364 = (_297 * _341) + _333.xyz;
        _365 = normalize((_248 * _336.w) + ((_336.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _360 = _312;
        _361 = _302;
        _362 = 0.5;
        _363 = 0.0;
        _364 = _297;
        _365 = _248;
    }
    float3 _369 = sqrt(fast::clamp(_360, float3(0.0), float3(1.0)));
    float4 _371 = float4(_369.x, _369.y, _369.z, float4(0.0).w);
    _371.w = 1.0;
    float3 _379 = ((_364 - (_364 * _363)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _386 = (mix(float3(0.07999999821186065673828125 * _362), _364, float3(_363)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _389 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _394;
    if (_389)
    {
        _394 = _379 + (_386 * 0.449999988079071044921875);
    }
    else
    {
        _394 = _379;
    }
    float3 _396 = select(_386, float3(0.0), bool3(_389));
    float3 _398 = float3(dot(_396, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _413 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _418 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _413);
    float4 _420 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_413 + float2(0.0, 0.5)));
    float3 _434 = _418.xyz;
    float3 _441 = ((_434 * _434) * PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapScale[0].xyz) + PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapAdd[0].xyz;
    float _443 = exp2(((_418.w + ((_420.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapScale[0].w) + PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapAdd[0].w) - 0.0185813605785369873046875;
    float4 _449 = (_420 * PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapScale[1]) + PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapAdd[1];
    float _495;
    float _496;
    float3 _497;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _479 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _483 = _479.w;
        float _484 = _483 * _483;
        float3 _486 = normalize(((_479.xyz * 2.0) - float3(1.0)).xyz);
        float _487 = 1.0 - _484;
        float _489 = 1.0 - (_487 * _487);
        _495 = mix(fast::clamp(dot(_486, _365), 0.0, 1.0), 1.0, _489);
        _496 = _484;
        _497 = mix(_486, _365, float3(_489));
    }
    else
    {
        _495 = 1.0;
        _496 = 1.0;
        _497 = _365;
    }
    float4 _501 = float4(_497, 1.0);
    float3 _505 = _154;
    _505.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _501);
    float3 _509 = _505;
    _509.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _501);
    float3 _513 = _509;
    _513.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _501);
    float4 _516 = _501.xyzz * _501.yzzx;
    float3 _520 = _154;
    _520.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _516);
    float3 _524 = _520;
    _524.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _516);
    float3 _528 = _524;
    _528.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _516);
    float3 _543 = -_365;
    float _544 = _543.x;
    float _545 = _543.y;
    float4 _547 = float4(_544, _545, _543.z, 1.0);
    float3 _550 = _156;
    _550.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _547);
    float3 _553 = _550;
    _553.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _547);
    float3 _556 = _553;
    _556.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _547);
    float4 _559 = _547.xyzz * _547.yzzx;
    float3 _562 = _156;
    _562.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _559);
    float3 _565 = _562;
    _565.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _559);
    float3 _568 = _565;
    _568.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _559);
    float3 _581 = ((_441 * (_443 * fast::max(0.0, dot(_449, float4(_365.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_513 + _528) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_497.x * _497.x) - (_497.y * _497.y)))) * View.View_SkyLightColor.xyz) * (_496 * _495));
    float3 _605 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _631;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _630;
        if (any(abs(_225 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _630 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_225, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _630 = _605;
        }
        _631 = _630;
    }
    else
    {
        _631 = _605;
    }
    float4 _638 = float4(((mix(float3(0.0), _394 + (_396 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + (((_581 * _394) + ((((_441 * (_443 * fast::max(0.0, dot(_449, float4(-_365.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_556 + _568) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_544 * _544) - (_545 * _545)))) * View.View_SkyLightColor.xyz) * _496)) * _360)) * fast::max(float3(1.0), ((((((_364 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_364 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_364 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _631) * 1.0, 0.0);
    float4 _645;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _644 = _638;
        _644.w = 0.0;
        _645 = _644;
    }
    else
    {
        _645 = _638;
    }
    float2 _649 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _657 = (_365 * 0.5) + float3(0.5);
    float4 _659 = float4(_657.x, _657.y, _657.z, float4(0.0).w);
    _659.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _660 = float4(0.0);
    _660.x = _363;
    float4 _661 = _660;
    _661.y = _362;
    float4 _662 = _661;
    _662.z = _361;
    float4 _663 = _662;
    _663.w = 0.776470601558685302734375;
    float4 _675 = float4(_364.x, _364.y, _364.z, float4(0.0).w);
    _675.w = ((log2(((dot(_581, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_398 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_398 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_398 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_649.xyx * _649.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _645 * View.View_PreExposure;
    out.out_var_SV_Target1 = _659;
    out.out_var_SV_Target2 = _663;
    out.out_var_SV_Target3 = _675;
    out.out_var_SV_Target4 = _371;
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

