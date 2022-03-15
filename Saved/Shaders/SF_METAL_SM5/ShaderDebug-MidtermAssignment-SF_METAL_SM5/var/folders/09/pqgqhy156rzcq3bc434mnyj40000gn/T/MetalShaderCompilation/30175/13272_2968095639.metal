

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
    char _m0_pad[64];
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

fragment MainPS_out Main_000033d8_b0e98b97(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_PrecomputedLightingBuffer& PrecomputedLightingBuffer [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> Material_Texture2D_0 [[texture(4)]], texture2d<float> Material_Texture2D_1 [[texture(5)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    float4 _197 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _201 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _206 = (_201.xyz / float3(_201.w)) - View.View_PreViewTranslation;
    float4 _214 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _217 = (_214.xy * float2(2.0)) - float2(1.0);
    float3 _234 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize(((float4(_217, sqrt(fast::clamp(1.0 - dot(_217, _217), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _246 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 20.0), bias(View.View_MaterialTextureMipBias));
    float _248 = mix(0.4000000059604644775390625, 1.0, _246.x);
    float4 _252 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _277;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _277 = _197.w;
                break;
            }
            else
            {
                float _261 = _197.z;
                _277 = ((_261 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_261 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _281 = fast::min(fast::max((_277 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _282 = _252.y;
    float4 _286 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _288 = _286.y;
    float3 _301 = fast::clamp(float3(mix(_248, 1.0 - _248, mix(_282, 1.0, _281)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_288 + mix(_282, 0.0, _281), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _306 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _288) + mix(mix(0.699999988079071044921875, 1.0, _282), 1.0, _281), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _353;
    float _354;
    float _355;
    float3 _356;
    float3 _357;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _323 = ((_197.xy / float2(_197.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _327 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _323, level(0.0));
        float4 _330 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _323, level(0.0));
        float4 _333 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _323, level(0.0));
        float _343 = _333.w;
        _353 = (_306 * _343) + _333.z;
        _354 = (0.5 * _343) + _333.y;
        _355 = _333.x;
        _356 = (_301 * _327.w) + _327.xyz;
        _357 = normalize((_234 * _330.w) + ((_330.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _353 = _306;
        _354 = 0.5;
        _355 = 0.0;
        _356 = _301;
        _357 = _234;
    }
    float3 _372 = ((_356 - (_356 * _355)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _379 = (mix(float3(0.07999999821186065673828125 * _354), _356, float3(_355)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _382 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _387;
    if (_382)
    {
        _387 = _372 + (_379 * 0.449999988079071044921875);
    }
    else
    {
        _387 = _372;
    }
    float3 _389 = select(_379, float3(0.0), bool3(_382));
    float3 _391 = float3(dot(_389, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _406 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _411 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _406);
    float4 _413 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_406 + float2(0.0, 0.5)));
    float3 _422 = (_411.xyz * PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapScale[0].xyz) + PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapAdd[0].xyz;
    float _423 = dot(_422, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float _440 = (exp2((_423 * 16.0) - 8.0) - 0.00390625) * fast::max(0.0, dot((_413 * PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapScale[1]) + PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapAdd[1], float4(_357.yzx, 1.0)));
    float3 _450 = float4(_422 * (_440 / _423), _440).xyz * View.View_IndirectLightingColorScale;
    float3 _472 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _498;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _497;
        if (any(abs(_206 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _497 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_206, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _497 = _472;
        }
        _498 = _497;
    }
    else
    {
        _498 = _472;
    }
    float4 _505 = float4(((mix(float3(0.0), _387 + (_389 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_450 * _387) * fast::max(float3(1.0), ((((((_356 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_356 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_356 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _498) * 1.0, 0.0);
    float4 _512;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _511 = _505;
        _511.w = 0.0;
        _512 = _511;
    }
    else
    {
        _512 = _505;
    }
    float2 _516 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _524 = (_357 * 0.5) + float3(0.5);
    float4 _526 = float4(_524.x, _524.y, _524.z, float4(0.0).w);
    _526.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _527 = float4(0.0);
    _527.x = _355;
    float4 _528 = _527;
    _528.y = _354;
    float4 _529 = _528;
    _529.z = _353;
    float4 _530 = _529;
    _530.w = 0.75686275959014892578125;
    float4 _542 = float4(_356.x, _356.y, _356.z, float4(0.0).w);
    _542.w = ((log2(((dot(_450, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_391 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_391 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_391 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_516.xyx * _516.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _512 * View.View_PreExposure;
    out.out_var_SV_Target1 = _526;
    out.out_var_SV_Target2 = _530;
    out.out_var_SV_Target3 = _542;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

