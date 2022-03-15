

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
    char _m16_pad[188];
    float View_ShowDecalsMask;
    char _m17_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
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

constant float _149 = {};
constant float _150 = {};

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

fragment MainPS_out Main_000037b8_9084cd72(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_PrecomputedLightingBuffer& PrecomputedLightingBuffer [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_StaticShadowTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_3 [[texture(7)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_3Sampler [[sampler(4)]], float4 gl_FragCoord [[position]], bool gl_FrontFacing [[front_facing]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    float4 _207 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _150, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _212 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _217 = (_212.xyz / float3(_212.w)) - View.View_PreViewTranslation;
    float4 _229 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _240 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((((float3(-0.5) + _229.xyz) * 2.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * ((View.View_CullingSign * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w) * float(gl_FrontFacing ? 1 : (-1)));
    float4 _251 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _258 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    if (abs(in.in_var_COLOR1.w) > 0.001000000047497451305389404296875)
    {
        float _274 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
        if ((float((in.in_var_COLOR1.w < 0.0) ? ((in.in_var_COLOR1.w + 1.0) > _274) : (in.in_var_COLOR1.w < _274)) - 0.001000000047497451305389404296875) < 0.0)
        {
            discard_fragment();
        }
    }
    if (((in.in_var_COLOR0.w * _251.w) - 0.100000001490116119384765625) < 0.0)
    {
        discard_fragment();
    }
    float3 _289 = fast::clamp(_251.xyz, float3(0.0), float3(1.0));
    float _294 = (fast::clamp(_229.w, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float3 _304 = (fast::clamp(float4(_258.xyz, _149).xyz, float3(0.0), float3(1.0)).xyz * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _352;
    float _353;
    float _354;
    float _355;
    float3 _356;
    float3 _357;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _321 = ((_207.xy / float2(_207.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _325 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _321, level(0.0));
        float4 _328 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _321, level(0.0));
        float4 _331 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _321, level(0.0));
        float _333 = _325.w;
        float _341 = _331.w;
        _352 = _304 * _333;
        _353 = (_294 * _341) + _331.z;
        _354 = (0.5 * _341) + _331.y;
        _355 = _331.x;
        _356 = (_289 * _333) + _325.xyz;
        _357 = normalize((_240 * _328.w) + ((_328.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _352 = _304;
        _353 = _294;
        _354 = 0.5;
        _355 = 0.0;
        _356 = _289;
        _357 = _240;
    }
    float4 _364 = LightmapResourceCluster_StaticShadowTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.zw);
    float4 _371 = fast::clamp((_364 * PrecomputedLightingBuffer.PrecomputedLightingBuffer_InvUniformPenumbraSizes) + ((PrecomputedLightingBuffer.PrecomputedLightingBuffer_InvUniformPenumbraSizes * (-0.5)) + float4(0.5)), float4(0.0), float4(1.0));
    float3 _377 = sqrt(fast::clamp(_352, float3(0.0), float3(1.0)));
    float4 _379 = float4(_377.x, _377.y, _377.z, float4(0.0).w);
    _379.w = 1.0;
    float3 _387 = ((_356 - (_356 * _355)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _394 = (mix(float3(0.07999999821186065673828125 * _354), _356, float3(_355)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _397 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _402;
    if (_397)
    {
        _402 = _387 + (_394 * 0.449999988079071044921875);
    }
    else
    {
        _402 = _387;
    }
    float3 _404 = select(_394, float3(0.0), bool3(_397));
    float3 _406 = float3(dot(_404, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _421 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _425 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _421);
    float4 _427 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_421 + float2(0.0, 0.5)));
    float3 _441 = _425.xyz;
    float3 _448 = ((_441 * _441) * PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapScale[0].xyz) + PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapAdd[0].xyz;
    float _450 = exp2(((_425.w + ((_427.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapScale[0].w) + PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapAdd[0].w) - 0.0185813605785369873046875;
    float4 _456 = (_427 * PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapScale[1]) + PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapAdd[1];
    float3 _477 = (_448 * (_450 * fast::max(0.0, dot(_456, float4(_357.yzx, 1.0))))) * View.View_IndirectLightingColorScale;
    float3 _502 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _528;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _527;
        if (any(abs(_217 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _527 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_217, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _527 = _502;
        }
        _528 = _527;
    }
    else
    {
        _528 = _502;
    }
    float4 _535 = float4(((mix(float3(0.0), _402 + (_404 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + (((_477 * _402) + (((_448 * (_450 * fast::max(0.0, dot(_456, float4(-_357.yzx, 1.0))))) * View.View_IndirectLightingColorScale) * _352)) * fast::max(float3(1.0), ((((((_356 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_356 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_356 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _528) * 1.0, 0.0);
    float4 _542;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _541 = _535;
        _541.w = 0.0;
        _542 = _541;
    }
    else
    {
        _542 = _535;
    }
    float2 _546 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _554 = (_357 * 0.5) + float3(0.5);
    float4 _556 = float4(_554.x, _554.y, _554.z, float4(0.0).w);
    _556.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _557 = float4(0.0);
    _557.x = _355;
    float4 _558 = _557;
    _558.y = _354;
    float4 _559 = _558;
    _559.z = _353;
    float4 _560 = _559;
    _560.w = 0.525490224361419677734375;
    float4 _572 = float4(_356.x, _356.y, _356.z, float4(0.0).w);
    _572.w = ((log2(((dot(_477, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_406 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_406 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_406 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_546.xyx * _546.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _542 * View.View_PreExposure;
    out.out_var_SV_Target1 = _556;
    out.out_var_SV_Target2 = _560;
    out.out_var_SV_Target3 = _572;
    out.out_var_SV_Target4 = _379;
    out.out_var_SV_Target5 = (PrecomputedLightingBuffer.PrecomputedLightingBuffer_StaticShadowMapMasks * _371) * _371;
    return out;
}

