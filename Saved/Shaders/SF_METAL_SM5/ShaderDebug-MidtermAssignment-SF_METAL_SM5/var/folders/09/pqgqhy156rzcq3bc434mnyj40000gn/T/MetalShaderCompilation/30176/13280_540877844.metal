

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
    float4 in_var_TEXCOORD0_0 [[user(locn3)]];
    float4 in_var_TEXCOORD4 [[user(locn4)]];
};

fragment MainPS_out Main_000033e0_203d2414(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_PrecomputedLightingBuffer& PrecomputedLightingBuffer [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> Material_Texture2D_0 [[texture(4)]], texture2d<float> Material_Texture2D_1 [[texture(5)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    float4 _198 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _202 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _207 = (_202.xyz / float3(_202.w)) - View.View_PreViewTranslation;
    float4 _215 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _218 = (_215.xy * float2(2.0)) - float2(1.0);
    float3 _235 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize(((float4(_218, sqrt(fast::clamp(1.0 - dot(_218, _218), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _247 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 20.0), bias(View.View_MaterialTextureMipBias));
    float _249 = mix(0.4000000059604644775390625, 1.0, _247.x);
    float4 _253 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _278;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _278 = _198.w;
                break;
            }
            else
            {
                float _262 = _198.z;
                _278 = ((_262 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_262 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _282 = fast::min(fast::max((_278 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _283 = _253.y;
    float4 _287 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _289 = _287.y;
    float3 _302 = fast::clamp(float3(mix(_249, 1.0 - _249, mix(_283, 1.0, _282)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_289 + mix(_283, 0.0, _282), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _307 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _289) + mix(mix(0.699999988079071044921875, 1.0, _283), 1.0, _282), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _354;
    float _355;
    float _356;
    float3 _357;
    float3 _358;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _324 = ((_198.xy / float2(_198.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _328 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _324, level(0.0));
        float4 _331 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _324, level(0.0));
        float4 _334 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _324, level(0.0));
        float _344 = _334.w;
        _354 = (_307 * _344) + _334.z;
        _355 = (0.5 * _344) + _334.y;
        _356 = _334.x;
        _357 = (_302 * _328.w) + _328.xyz;
        _358 = normalize((_235 * _331.w) + ((_331.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _354 = _307;
        _355 = 0.5;
        _356 = 0.0;
        _357 = _302;
        _358 = _235;
    }
    float3 _373 = ((_357 - (_357 * _356)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _380 = (mix(float3(0.07999999821186065673828125 * _355), _357, float3(_356)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _383 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _388;
    if (_383)
    {
        _388 = _373 + (_380 * 0.449999988079071044921875);
    }
    else
    {
        _388 = _373;
    }
    float3 _390 = select(_380, float3(0.0), bool3(_383));
    float3 _392 = float3(dot(_390, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _407 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _412 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _407);
    float4 _414 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_407 + float2(0.0, 0.5)));
    float3 _423 = (_412.xyz * PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapScale[0].xyz) + PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapAdd[0].xyz;
    float _424 = dot(_423, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float _441 = (exp2((_424 * 16.0) - 8.0) - 0.00390625) * fast::max(0.0, dot((_414 * PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapScale[1]) + PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapAdd[1], float4(_358.yzx, 1.0)));
    float3 _451 = float4(_423 * (_441 / _424), _441).xyz * View.View_IndirectLightingColorScale;
    float3 _473 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _499;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _498;
        if (any(abs(_207 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _498 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_207, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _498 = _473;
        }
        _499 = _498;
    }
    else
    {
        _499 = _473;
    }
    float4 _506 = float4(((mix(float3(0.0), _388 + (_390 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_451 * _388) * fast::max(float3(1.0), ((((((_357 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_357 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_357 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _499) * 1.0, 0.0);
    float4 _513;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _512 = _506;
        _512.w = 0.0;
        _513 = _512;
    }
    else
    {
        _513 = _506;
    }
    float2 _517 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _525 = (_358 * 0.5) + float3(0.5);
    float4 _527 = float4(_525.x, _525.y, _525.z, float4(0.0).w);
    _527.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _528 = float4(0.0);
    _528.x = _356;
    float4 _529 = _528;
    _529.y = _355;
    float4 _530 = _529;
    _530.z = _354;
    float4 _531 = _530;
    _531.w = 0.75686275959014892578125;
    float4 _543 = float4(_357.x, _357.y, _357.z, float4(0.0).w);
    _543.w = ((log2(((dot(_451, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_392 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_392 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_392 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_517.xyx * _517.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _513 * View.View_PreExposure;
    out.out_var_SV_Target1 = _527;
    out.out_var_SV_Target2 = _531;
    out.out_var_SV_Target3 = _543;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

