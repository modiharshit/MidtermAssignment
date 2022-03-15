

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
    float4 PrecomputedLightingBuffer_StaticShadowMapMasks;
    float4 PrecomputedLightingBuffer_InvUniformPenumbraSizes;
    char _m2_pad[32];
    spvUnsafeArray<float4, 2> PrecomputedLightingBuffer_LightMapScale;
    spvUnsafeArray<float4, 2> PrecomputedLightingBuffer_LightMapAdd;
};

struct type_Material
{
    spvUnsafeArray<float4, 7> Material_VectorExpressions;
    spvUnsafeArray<float4, 6> Material_ScalarExpressions;
};

constant float _156 = {};
constant float3 _157 = {};
constant float _158 = {};
constant float3 _159 = {};

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

fragment MainPS_out Main_000047a0_6a9b15b6(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_PrecomputedLightingBuffer& PrecomputedLightingBuffer [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], texture2d<float> LightmapResourceCluster_StaticShadowTexture [[texture(5)]], texture2d<float> Material_Texture2D_0 [[texture(6)]], texture2d<float> Material_Texture2D_1 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_3Sampler [[sampler(4)]], float4 gl_FragCoord [[position]], bool gl_FrontFacing [[front_facing]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _218 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _158, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _223 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _228 = (_223.xyz / float3(_223.w)) - View.View_PreViewTranslation;
    float4 _240 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _251 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((((float3(-0.5) + _240.xyz) * 2.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * ((View.View_CullingSign * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w) * float(gl_FrontFacing ? 1 : (-1)));
    float4 _262 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _269 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    if (abs(in.in_var_COLOR1.w) > 0.001000000047497451305389404296875)
    {
        float _285 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
        if ((float((in.in_var_COLOR1.w < 0.0) ? ((in.in_var_COLOR1.w + 1.0) > _285) : (in.in_var_COLOR1.w < _285)) - 0.001000000047497451305389404296875) < 0.0)
        {
            discard_fragment();
        }
    }
    if (((in.in_var_COLOR0.w * _262.w) - 0.100000001490116119384765625) < 0.0)
    {
        discard_fragment();
    }
    float3 _300 = fast::clamp(_262.xyz, float3(0.0), float3(1.0));
    float _305 = (fast::clamp(_240.w, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float3 _315 = (fast::clamp(float4(_269.xyz, _156).xyz, float3(0.0), float3(1.0)).xyz * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _363;
    float _364;
    float _365;
    float _366;
    float3 _367;
    float3 _368;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _332 = ((_218.xy / float2(_218.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _336 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _332, level(0.0));
        float4 _339 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _332, level(0.0));
        float4 _342 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _332, level(0.0));
        float _344 = _336.w;
        float _352 = _342.w;
        _363 = _315 * _344;
        _364 = (_305 * _352) + _342.z;
        _365 = (0.5 * _352) + _342.y;
        _366 = _342.x;
        _367 = (_300 * _344) + _336.xyz;
        _368 = normalize((_251 * _339.w) + ((_339.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _363 = _315;
        _364 = _305;
        _365 = 0.5;
        _366 = 0.0;
        _367 = _300;
        _368 = _251;
    }
    float4 _375 = LightmapResourceCluster_StaticShadowTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.zw);
    float4 _382 = fast::clamp((_375 * PrecomputedLightingBuffer.PrecomputedLightingBuffer_InvUniformPenumbraSizes) + ((PrecomputedLightingBuffer.PrecomputedLightingBuffer_InvUniformPenumbraSizes * (-0.5)) + float4(0.5)), float4(0.0), float4(1.0));
    float3 _388 = sqrt(fast::clamp(_363, float3(0.0), float3(1.0)));
    float4 _390 = float4(_388.x, _388.y, _388.z, float4(0.0).w);
    _390.w = 1.0;
    float3 _398 = ((_367 - (_367 * _366)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _405 = (mix(float3(0.07999999821186065673828125 * _365), _367, float3(_366)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _408 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _413;
    if (_408)
    {
        _413 = _398 + (_405 * 0.449999988079071044921875);
    }
    else
    {
        _413 = _398;
    }
    float3 _415 = select(_405, float3(0.0), bool3(_408));
    float3 _417 = float3(dot(_415, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _432 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _436 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _432);
    float4 _438 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_432 + float2(0.0, 0.5)));
    float3 _452 = _436.xyz;
    float3 _459 = ((_452 * _452) * PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapScale[0].xyz) + PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapAdd[0].xyz;
    float _461 = exp2(((_436.w + ((_438.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapScale[0].w) + PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapAdd[0].w) - 0.0185813605785369873046875;
    float4 _467 = (_438 * PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapScale[1]) + PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapAdd[1];
    float _513;
    float _514;
    float3 _515;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _497 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _501 = _497.w;
        float _502 = _501 * _501;
        float3 _504 = normalize(((_497.xyz * 2.0) - float3(1.0)).xyz);
        float _505 = 1.0 - _502;
        float _507 = 1.0 - (_505 * _505);
        _513 = mix(fast::clamp(dot(_504, _368), 0.0, 1.0), 1.0, _507);
        _514 = _502;
        _515 = mix(_504, _368, float3(_507));
    }
    else
    {
        _513 = 1.0;
        _514 = 1.0;
        _515 = _368;
    }
    float4 _519 = float4(_515, 1.0);
    float3 _523 = _157;
    _523.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _519);
    float3 _527 = _523;
    _527.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _519);
    float3 _531 = _527;
    _531.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _519);
    float4 _534 = _519.xyzz * _519.yzzx;
    float3 _538 = _157;
    _538.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _534);
    float3 _542 = _538;
    _542.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _534);
    float3 _546 = _542;
    _546.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _534);
    float3 _561 = -_368;
    float _562 = _561.x;
    float _563 = _561.y;
    float4 _565 = float4(_562, _563, _561.z, 1.0);
    float3 _568 = _159;
    _568.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _565);
    float3 _571 = _568;
    _571.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _565);
    float3 _574 = _571;
    _574.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _565);
    float4 _577 = _565.xyzz * _565.yzzx;
    float3 _580 = _159;
    _580.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _577);
    float3 _583 = _580;
    _583.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _577);
    float3 _586 = _583;
    _586.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _577);
    float3 _599 = ((_459 * (_461 * fast::max(0.0, dot(_467, float4(_368.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_531 + _546) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_515.x * _515.x) - (_515.y * _515.y)))) * View.View_SkyLightColor.xyz) * (_514 * _513));
    float3 _623 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _649;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _648;
        if (any(abs(_228 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _648 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_228, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _648 = _623;
        }
        _649 = _648;
    }
    else
    {
        _649 = _623;
    }
    float4 _656 = float4(((mix(float3(0.0), _413 + (_415 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + (((_599 * _413) + ((((_459 * (_461 * fast::max(0.0, dot(_467, float4(-_368.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_574 + _586) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_562 * _562) - (_563 * _563)))) * View.View_SkyLightColor.xyz) * _514)) * _363)) * fast::max(float3(1.0), ((((((_367 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_367 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_367 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _649) * 1.0, 0.0);
    float4 _663;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _662 = _656;
        _662.w = 0.0;
        _663 = _662;
    }
    else
    {
        _663 = _656;
    }
    float2 _667 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _675 = (_368 * 0.5) + float3(0.5);
    float4 _677 = float4(_675.x, _675.y, _675.z, float4(0.0).w);
    _677.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _678 = float4(0.0);
    _678.x = _366;
    float4 _679 = _678;
    _679.y = _365;
    float4 _680 = _679;
    _680.z = _364;
    float4 _681 = _680;
    _681.w = 0.525490224361419677734375;
    float4 _693 = float4(_367.x, _367.y, _367.z, float4(0.0).w);
    _693.w = ((log2(((dot(_599, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_417 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_417 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_417 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_667.xyx * _667.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _663 * View.View_PreExposure;
    out.out_var_SV_Target1 = _677;
    out.out_var_SV_Target2 = _681;
    out.out_var_SV_Target3 = _693;
    out.out_var_SV_Target4 = _390;
    out.out_var_SV_Target5 = (PrecomputedLightingBuffer.PrecomputedLightingBuffer_StaticShadowMapMasks * _382) * _382;
    return out;
}

