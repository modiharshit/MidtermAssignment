

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
};

struct type_Primitive
{
    char _m0_pad[80];
    float4 Primitive_ObjectWorldPositionAndRadius;
    char _m1_pad[208];
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
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

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
    float4 in_var_TEXCOORD0_0 [[user(locn2)]];
    float4 in_var_TEXCOORD4 [[user(locn3)]];
};

fragment MainPS_out Main_00003703_200b29f2(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_PrecomputedLightingBuffer& PrecomputedLightingBuffer [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_StaticShadowTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    float4 _201 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _205 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _210 = (_205.xyz / float3(_205.w)) - View.View_PreViewTranslation;
    float4 _218 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _221 = (_218.xy * float2(2.0)) - float2(1.0);
    float3 _238 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize(((float4(_221, sqrt(fast::clamp(1.0 - dot(_221, _221), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _250 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 20.0), bias(View.View_MaterialTextureMipBias));
    float _252 = mix(0.4000000059604644775390625, 1.0, _250.x);
    float4 _256 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _281;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _281 = _201.w;
                break;
            }
            else
            {
                float _265 = _201.z;
                _281 = ((_265 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_265 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _285 = fast::min(fast::max((_281 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _286 = _256.y;
    float4 _290 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _292 = _290.y;
    float3 _305 = fast::clamp(float3(mix(_252, 1.0 - _252, mix(_286, 1.0, _285)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_292 + mix(_286, 0.0, _285), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _310 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _292) + mix(mix(0.699999988079071044921875, 1.0, _286), 1.0, _285), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _357;
    float _358;
    float _359;
    float3 _360;
    float3 _361;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _327 = ((_201.xy / float2(_201.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _331 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _327, level(0.0));
        float4 _334 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _327, level(0.0));
        float4 _337 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _327, level(0.0));
        float _347 = _337.w;
        _357 = (_310 * _347) + _337.z;
        _358 = (0.5 * _347) + _337.y;
        _359 = _337.x;
        _360 = (_305 * _331.w) + _331.xyz;
        _361 = normalize((_238 * _334.w) + ((_334.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _357 = _310;
        _358 = 0.5;
        _359 = 0.0;
        _360 = _305;
        _361 = _238;
    }
    float4 _368 = LightmapResourceCluster_StaticShadowTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.zw);
    float4 _375 = fast::clamp((_368 * PrecomputedLightingBuffer.PrecomputedLightingBuffer_InvUniformPenumbraSizes) + ((PrecomputedLightingBuffer.PrecomputedLightingBuffer_InvUniformPenumbraSizes * (-0.5)) + float4(0.5)), float4(0.0), float4(1.0));
    float3 _392 = ((_360 - (_360 * _359)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _399 = (mix(float3(0.07999999821186065673828125 * _358), _360, float3(_359)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _402 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _407;
    if (_402)
    {
        _407 = _392 + (_399 * 0.449999988079071044921875);
    }
    else
    {
        _407 = _392;
    }
    float3 _409 = select(_399, float3(0.0), bool3(_402));
    float3 _411 = float3(dot(_409, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _426 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _430 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _426);
    float4 _432 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_426 + float2(0.0, 0.5)));
    float3 _446 = _430.xyz;
    float3 _472 = ((((_446 * _446) * PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapScale[0].xyz) + PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapAdd[0].xyz) * ((exp2(((_430.w + ((_432.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapScale[0].w) + PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapAdd[0].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_432 * PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapScale[1]) + PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapAdd[1], float4(_361.yzx, 1.0))))) * View.View_IndirectLightingColorScale;
    float3 _494 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _520;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _519;
        if (any(abs(_210 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _519 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_210, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _519 = _494;
        }
        _520 = _519;
    }
    else
    {
        _520 = _494;
    }
    float4 _527 = float4(((mix(float3(0.0), _407 + (_409 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_472 * _407) * fast::max(float3(1.0), ((((((_360 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_360 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_360 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _520) * 1.0, 0.0);
    float4 _534;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _533 = _527;
        _533.w = 0.0;
        _534 = _533;
    }
    else
    {
        _534 = _527;
    }
    float2 _538 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _546 = (_361 * 0.5) + float3(0.5);
    float4 _548 = float4(_546.x, _546.y, _546.z, float4(0.0).w);
    _548.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _549 = float4(0.0);
    _549.x = _359;
    float4 _550 = _549;
    _550.y = _358;
    float4 _551 = _550;
    _551.z = _357;
    float4 _552 = _551;
    _552.w = 0.50588238239288330078125;
    float4 _564 = float4(_360.x, _360.y, _360.z, float4(0.0).w);
    _564.w = ((log2(((dot(_472, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_411 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_411 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_411 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_538.xyx * _538.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _534 * View.View_PreExposure;
    out.out_var_SV_Target1 = _548;
    out.out_var_SV_Target2 = _552;
    out.out_var_SV_Target3 = _564;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = (PrecomputedLightingBuffer.PrecomputedLightingBuffer_StaticShadowMapMasks * _375) * _375;
    return out;
}

