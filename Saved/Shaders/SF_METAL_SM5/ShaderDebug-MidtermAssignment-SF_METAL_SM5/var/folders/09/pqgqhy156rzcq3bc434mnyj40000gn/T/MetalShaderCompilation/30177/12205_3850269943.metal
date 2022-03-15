

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
    char _m15_pad[612];
    float View_RenderingReflectionCaptureMask;
    char _m16_pad[188];
    float View_ShowDecalsMask;
    char _m17_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m18_pad[48];
    float3 View_VolumetricLightmapWorldToUVScale;
    float3 View_VolumetricLightmapWorldToUVAdd;
    packed_float3 View_VolumetricLightmapIndirectionTextureSize;
    float View_VolumetricLightmapBrickSize;
    float3 View_VolumetricLightmapBrickTexelSize;
};

struct type_Primitive
{
    char _m0_pad[80];
    float4 Primitive_ObjectWorldPositionAndRadius;
    char _m1_pad[208];
    float3 Primitive_ObjectBounds;
    float Primitive_DecalReceiverMask;
    float Primitive_PerObjectGBufferData;
    float Primitive_UseVolumetricLightmapShadowFromStationaryLights;
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
};

fragment MainPS_out Main_00002fad_e57e74f7(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    float4 _188 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _192 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _197 = (_192.xyz / float3(_192.w)) - View.View_PreViewTranslation;
    float4 _205 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (in_var_TEXCOORD0[0].xy * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _208 = (_205.xy * float2(2.0)) - float2(1.0);
    float3 _225 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize(((float4(_208, sqrt(fast::clamp(1.0 - dot(_208, _208), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _237 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in_var_TEXCOORD0[0].xy * 20.0), bias(View.View_MaterialTextureMipBias));
    float _239 = mix(0.4000000059604644775390625, 1.0, _237.x);
    float4 _243 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in_var_TEXCOORD0[0].xy * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _268;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _268 = _188.w;
                break;
            }
            else
            {
                float _252 = _188.z;
                _268 = ((_252 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_252 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _272 = fast::min(fast::max((_268 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _273 = _243.y;
    float4 _277 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in_var_TEXCOORD0[0].xy * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _279 = _277.y;
    float3 _292 = fast::clamp(float3(mix(_239, 1.0 - _239, mix(_273, 1.0, _272)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_279 + mix(_273, 0.0, _272), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _297 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _279) + mix(mix(0.699999988079071044921875, 1.0, _273), 1.0, _272), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _344;
    float _345;
    float _346;
    float3 _347;
    float3 _348;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _314 = ((_188.xy / float2(_188.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _318 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _314, level(0.0));
        float4 _321 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _314, level(0.0));
        float4 _324 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _314, level(0.0));
        float _334 = _324.w;
        _344 = (_297 * _334) + _324.z;
        _345 = (0.5 * _334) + _324.y;
        _346 = _324.x;
        _347 = (_292 * _318.w) + _318.xyz;
        _348 = normalize((_225 * _321.w) + ((_321.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _344 = _297;
        _345 = 0.5;
        _346 = 0.0;
        _347 = _292;
        _348 = _225;
    }
    float _397;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _365 = fast::clamp((_197 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _376 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_365.x), int(_365.y), int(_365.z), 0).xyz), 0));
        _397 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_376.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_365 / float3(_376.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _397 = 1.0;
    }
    float3 _411 = ((_347 - (_347 * _346)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _418 = (mix(float3(0.07999999821186065673828125 * _345), _347, float3(_346)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _421 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _426;
    if (_421)
    {
        _426 = _411 + (_418 * 0.449999988079071044921875);
    }
    else
    {
        _426 = _411;
    }
    float3 _435 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _461;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _460;
        if (any(abs(_197 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _460 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_197, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _460 = _435;
        }
        _461 = _460;
    }
    else
    {
        _461 = _435;
    }
    float4 _467 = float4((mix(float3(0.0), _426 + (select(_418, float3(0.0), bool3(_421)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + _461) * 1.0, 0.0);
    float4 _474;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _473 = _467;
        _473.w = 0.0;
        _474 = _473;
    }
    else
    {
        _474 = _467;
    }
    float2 _478 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _486 = (_348 * 0.5) + float3(0.5);
    float4 _488 = float4(_486.x, _486.y, _486.z, float4(0.0).w);
    _488.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _489 = float4(0.0);
    _489.x = _346;
    float4 _490 = _489;
    _490.y = _345;
    float4 _491 = _490;
    _491.z = _344;
    float4 _492 = _491;
    _492.w = 0.50588238239288330078125;
    float4 _495 = float4(_347.x, _347.y, _347.z, float4(0.0).w);
    _495.w = (fract(dot(_478.xyx * _478.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _474 * View.View_PreExposure;
    out.out_var_SV_Target1 = _488;
    out.out_var_SV_Target2 = _492;
    out.out_var_SV_Target3 = _495;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_397, 1.0, 1.0, 1.0);
    return out;
}

