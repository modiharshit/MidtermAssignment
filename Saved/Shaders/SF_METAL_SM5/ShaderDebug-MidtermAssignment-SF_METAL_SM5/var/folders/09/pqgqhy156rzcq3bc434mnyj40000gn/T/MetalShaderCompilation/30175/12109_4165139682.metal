

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
    float4 in_var_TEXCOORD2 [[user(locn2)]];
};

fragment MainPS_out Main_00002f4d_f842fce2(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    float4 _184 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _188 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _193 = (_188.xyz / float3(_188.w)) - View.View_PreViewTranslation;
    float4 _201 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (in.in_var_TEXCOORD2.xy * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _204 = (_201.xy * float2(2.0)) - float2(1.0);
    float3 _221 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize(((float4(_204, sqrt(fast::clamp(1.0 - dot(_204, _204), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _233 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in.in_var_TEXCOORD2.xy * 20.0), bias(View.View_MaterialTextureMipBias));
    float _235 = mix(0.4000000059604644775390625, 1.0, _233.x);
    float4 _239 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in.in_var_TEXCOORD2.xy * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _264;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _264 = _184.w;
                break;
            }
            else
            {
                float _248 = _184.z;
                _264 = ((_248 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_248 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _268 = fast::min(fast::max((_264 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _269 = _239.y;
    float4 _273 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in.in_var_TEXCOORD2.xy * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _275 = _273.y;
    float3 _288 = fast::clamp(float3(mix(_235, 1.0 - _235, mix(_269, 1.0, _268)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_275 + mix(_269, 0.0, _268), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _293 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _275) + mix(mix(0.699999988079071044921875, 1.0, _269), 1.0, _268), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _340;
    float _341;
    float _342;
    float3 _343;
    float3 _344;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _310 = ((_184.xy / float2(_184.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _314 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _310, level(0.0));
        float4 _317 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _310, level(0.0));
        float4 _320 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _310, level(0.0));
        float _330 = _320.w;
        _340 = (_293 * _330) + _320.z;
        _341 = (0.5 * _330) + _320.y;
        _342 = _320.x;
        _343 = (_288 * _314.w) + _314.xyz;
        _344 = normalize((_221 * _317.w) + ((_317.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _340 = _293;
        _341 = 0.5;
        _342 = 0.0;
        _343 = _288;
        _344 = _221;
    }
    float _393;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _361 = fast::clamp((_193 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _372 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_361.x), int(_361.y), int(_361.z), 0).xyz), 0));
        _393 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_372.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_361 / float3(_372.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _393 = 1.0;
    }
    float3 _407 = ((_343 - (_343 * _342)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _414 = (mix(float3(0.07999999821186065673828125 * _341), _343, float3(_342)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _417 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _422;
    if (_417)
    {
        _422 = _407 + (_414 * 0.449999988079071044921875);
    }
    else
    {
        _422 = _407;
    }
    float3 _431 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _457;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _456;
        if (any(abs(_193 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _456 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_193, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _456 = _431;
        }
        _457 = _456;
    }
    else
    {
        _457 = _431;
    }
    float4 _463 = float4((mix(float3(0.0), _422 + (select(_414, float3(0.0), bool3(_417)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + _457) * 1.0, 0.0);
    float4 _470;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _469 = _463;
        _469.w = 0.0;
        _470 = _469;
    }
    else
    {
        _470 = _463;
    }
    float2 _474 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _482 = (_344 * 0.5) + float3(0.5);
    float4 _484 = float4(_482.x, _482.y, _482.z, float4(0.0).w);
    _484.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _485 = float4(0.0);
    _485.x = _342;
    float4 _486 = _485;
    _486.y = _341;
    float4 _487 = _486;
    _487.z = _340;
    float4 _488 = _487;
    _488.w = 0.50588238239288330078125;
    float4 _491 = float4(_343.x, _343.y, _343.z, float4(0.0).w);
    _491.w = (fract(dot(_474.xyx * _474.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _470 * View.View_PreExposure;
    out.out_var_SV_Target1 = _484;
    out.out_var_SV_Target2 = _488;
    out.out_var_SV_Target3 = _491;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_393, 1.0, 1.0, 1.0);
    return out;
}

