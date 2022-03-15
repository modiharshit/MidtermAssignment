

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
    float4 in_var_COLOR1 [[user(locn2)]];
    float4 in_var_TEXCOORD0_0 [[user(locn3)]];
    float4 in_var_TEXCOORD4 [[user(locn4)]];
};

fragment MainPS_out Main_000035a9_f184b97b(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_PrecomputedLightingBuffer& PrecomputedLightingBuffer [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> Material_Texture2D_0 [[texture(4)]], texture2d<float> Material_Texture2D_1 [[texture(5)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    float4 _204 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _208 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _213 = (_208.xyz / float3(_208.w)) - View.View_PreViewTranslation;
    float4 _221 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _224 = (_221.xy * float2(2.0)) - float2(1.0);
    float3 _241 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize(((float4(_224, sqrt(fast::clamp(1.0 - dot(_224, _224), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _253 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 20.0), bias(View.View_MaterialTextureMipBias));
    float _255 = mix(0.4000000059604644775390625, 1.0, _253.x);
    float4 _259 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _284;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _284 = _204.w;
                break;
            }
            else
            {
                float _268 = _204.z;
                _284 = ((_268 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_268 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _288 = fast::min(fast::max((_284 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _289 = _259.y;
    float4 _293 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _295 = _293.y;
    if (abs(in.in_var_COLOR1.w) > 0.001000000047497451305389404296875)
    {
        float _317 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
        if ((float((in.in_var_COLOR1.w < 0.0) ? ((in.in_var_COLOR1.w + 1.0) > _317) : (in.in_var_COLOR1.w < _317)) - 0.001000000047497451305389404296875) < 0.0)
        {
            discard_fragment();
        }
    }
    float3 _328 = fast::clamp(float3(mix(_255, 1.0 - _255, mix(_289, 1.0, _288)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_295 + mix(_289, 0.0, _288), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _333 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _295) + mix(mix(0.699999988079071044921875, 1.0, _289), 1.0, _288), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _380;
    float _381;
    float _382;
    float3 _383;
    float3 _384;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _350 = ((_204.xy / float2(_204.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _354 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _350, level(0.0));
        float4 _357 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _350, level(0.0));
        float4 _360 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _350, level(0.0));
        float _370 = _360.w;
        _380 = (_333 * _370) + _360.z;
        _381 = (0.5 * _370) + _360.y;
        _382 = _360.x;
        _383 = (_328 * _354.w) + _354.xyz;
        _384 = normalize((_241 * _357.w) + ((_357.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _380 = _333;
        _381 = 0.5;
        _382 = 0.0;
        _383 = _328;
        _384 = _241;
    }
    float3 _399 = ((_383 - (_383 * _382)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _406 = (mix(float3(0.07999999821186065673828125 * _381), _383, float3(_382)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _409 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _414;
    if (_409)
    {
        _414 = _399 + (_406 * 0.449999988079071044921875);
    }
    else
    {
        _414 = _399;
    }
    float3 _416 = select(_406, float3(0.0), bool3(_409));
    float3 _418 = float3(dot(_416, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _433 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _438 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _433);
    float4 _440 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_433 + float2(0.0, 0.5)));
    float3 _449 = (_438.xyz * PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapScale[0].xyz) + PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapAdd[0].xyz;
    float _450 = dot(_449, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float _467 = (exp2((_450 * 16.0) - 8.0) - 0.00390625) * fast::max(0.0, dot((_440 * PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapScale[1]) + PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapAdd[1], float4(_384.yzx, 1.0)));
    float3 _477 = float4(_449 * (_467 / _450), _467).xyz * View.View_IndirectLightingColorScale;
    float3 _499 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _525;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _524;
        if (any(abs(_213 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _524 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_213, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _524 = _499;
        }
        _525 = _524;
    }
    else
    {
        _525 = _499;
    }
    float4 _532 = float4(((mix(float3(0.0), _414 + (_416 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_477 * _414) * fast::max(float3(1.0), ((((((_383 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_383 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_383 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _525) * 1.0, 0.0);
    float4 _539;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _538 = _532;
        _538.w = 0.0;
        _539 = _538;
    }
    else
    {
        _539 = _532;
    }
    float2 _543 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _551 = (_384 * 0.5) + float3(0.5);
    float4 _553 = float4(_551.x, _551.y, _551.z, float4(0.0).w);
    _553.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _554 = float4(0.0);
    _554.x = _382;
    float4 _555 = _554;
    _555.y = _381;
    float4 _556 = _555;
    _556.z = _380;
    float4 _557 = _556;
    _557.w = 0.75686275959014892578125;
    float4 _569 = float4(_383.x, _383.y, _383.z, float4(0.0).w);
    _569.w = ((log2(((dot(_477, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_418 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_418 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_418 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_543.xyx * _543.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _539 * View.View_PreExposure;
    out.out_var_SV_Target1 = _553;
    out.out_var_SV_Target2 = _557;
    out.out_var_SV_Target3 = _569;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

