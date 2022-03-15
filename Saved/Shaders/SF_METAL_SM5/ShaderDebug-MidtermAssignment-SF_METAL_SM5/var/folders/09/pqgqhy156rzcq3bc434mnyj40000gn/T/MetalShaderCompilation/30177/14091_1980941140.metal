

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
    float4 in_var_TEXCOORD0_0 [[user(locn3)]];
    float4 in_var_TEXCOORD4 [[user(locn4)]];
};

fragment MainPS_out Main_0000370b_7612c354(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_PrecomputedLightingBuffer& PrecomputedLightingBuffer [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_StaticShadowTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    float4 _202 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _206 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _211 = (_206.xyz / float3(_206.w)) - View.View_PreViewTranslation;
    float4 _219 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _222 = (_219.xy * float2(2.0)) - float2(1.0);
    float3 _239 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize(((float4(_222, sqrt(fast::clamp(1.0 - dot(_222, _222), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _251 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 20.0), bias(View.View_MaterialTextureMipBias));
    float _253 = mix(0.4000000059604644775390625, 1.0, _251.x);
    float4 _257 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _282;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _282 = _202.w;
                break;
            }
            else
            {
                float _266 = _202.z;
                _282 = ((_266 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_266 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _286 = fast::min(fast::max((_282 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _287 = _257.y;
    float4 _291 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _293 = _291.y;
    float3 _306 = fast::clamp(float3(mix(_253, 1.0 - _253, mix(_287, 1.0, _286)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_293 + mix(_287, 0.0, _286), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _311 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _293) + mix(mix(0.699999988079071044921875, 1.0, _287), 1.0, _286), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _358;
    float _359;
    float _360;
    float3 _361;
    float3 _362;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _328 = ((_202.xy / float2(_202.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _332 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _328, level(0.0));
        float4 _335 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _328, level(0.0));
        float4 _338 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _328, level(0.0));
        float _348 = _338.w;
        _358 = (_311 * _348) + _338.z;
        _359 = (0.5 * _348) + _338.y;
        _360 = _338.x;
        _361 = (_306 * _332.w) + _332.xyz;
        _362 = normalize((_239 * _335.w) + ((_335.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _358 = _311;
        _359 = 0.5;
        _360 = 0.0;
        _361 = _306;
        _362 = _239;
    }
    float4 _369 = LightmapResourceCluster_StaticShadowTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.zw);
    float4 _376 = fast::clamp((_369 * PrecomputedLightingBuffer.PrecomputedLightingBuffer_InvUniformPenumbraSizes) + ((PrecomputedLightingBuffer.PrecomputedLightingBuffer_InvUniformPenumbraSizes * (-0.5)) + float4(0.5)), float4(0.0), float4(1.0));
    float3 _393 = ((_361 - (_361 * _360)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _400 = (mix(float3(0.07999999821186065673828125 * _359), _361, float3(_360)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _403 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _408;
    if (_403)
    {
        _408 = _393 + (_400 * 0.449999988079071044921875);
    }
    else
    {
        _408 = _393;
    }
    float3 _410 = select(_400, float3(0.0), bool3(_403));
    float3 _412 = float3(dot(_410, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _427 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _431 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _427);
    float4 _433 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_427 + float2(0.0, 0.5)));
    float3 _447 = _431.xyz;
    float3 _473 = ((((_447 * _447) * PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapScale[0].xyz) + PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapAdd[0].xyz) * ((exp2(((_431.w + ((_433.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapScale[0].w) + PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapAdd[0].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_433 * PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapScale[1]) + PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapAdd[1], float4(_362.yzx, 1.0))))) * View.View_IndirectLightingColorScale;
    float3 _495 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _521;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _520;
        if (any(abs(_211 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _520 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_211, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _520 = _495;
        }
        _521 = _520;
    }
    else
    {
        _521 = _495;
    }
    float4 _528 = float4(((mix(float3(0.0), _408 + (_410 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_473 * _408) * fast::max(float3(1.0), ((((((_361 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_361 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_361 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _521) * 1.0, 0.0);
    float4 _535;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _534 = _528;
        _534.w = 0.0;
        _535 = _534;
    }
    else
    {
        _535 = _528;
    }
    float2 _539 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _547 = (_362 * 0.5) + float3(0.5);
    float4 _549 = float4(_547.x, _547.y, _547.z, float4(0.0).w);
    _549.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _550 = float4(0.0);
    _550.x = _360;
    float4 _551 = _550;
    _551.y = _359;
    float4 _552 = _551;
    _552.z = _358;
    float4 _553 = _552;
    _553.w = 0.50588238239288330078125;
    float4 _565 = float4(_361.x, _361.y, _361.z, float4(0.0).w);
    _565.w = ((log2(((dot(_473, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_412 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_412 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_412 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_539.xyx * _539.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _535 * View.View_PreExposure;
    out.out_var_SV_Target1 = _549;
    out.out_var_SV_Target2 = _553;
    out.out_var_SV_Target3 = _565;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = (PrecomputedLightingBuffer.PrecomputedLightingBuffer_StaticShadowMapMasks * _376) * _376;
    return out;
}

