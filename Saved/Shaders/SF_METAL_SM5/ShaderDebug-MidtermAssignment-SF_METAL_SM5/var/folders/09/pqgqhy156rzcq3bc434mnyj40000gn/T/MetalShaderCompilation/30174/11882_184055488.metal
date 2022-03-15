

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
    float2 in_var_TEXCOORD0 [[user(locn0)]];
};

fragment MainPS_out Main_00002e6a_0af876c0(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    float4 _178 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _182 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _187 = (_182.xyz / float3(_182.w)) - View.View_PreViewTranslation;
    float4 _195 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (in.in_var_TEXCOORD0 * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _198 = (_195.xy * float2(2.0)) - float2(1.0);
    float3 _215 = normalize(float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0)) * normalize(((float4(_198, sqrt(fast::clamp(1.0 - dot(_198, _198), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _227 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in.in_var_TEXCOORD0 * 20.0), bias(View.View_MaterialTextureMipBias));
    float _229 = mix(0.4000000059604644775390625, 1.0, _227.x);
    float4 _233 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in.in_var_TEXCOORD0 * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _258;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _258 = _178.w;
                break;
            }
            else
            {
                float _242 = _178.z;
                _258 = ((_242 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_242 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _262 = fast::min(fast::max((_258 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _263 = _233.y;
    float4 _267 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in.in_var_TEXCOORD0 * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _269 = _267.y;
    float3 _282 = fast::clamp(float3(mix(_229, 1.0 - _229, mix(_263, 1.0, _262)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_269 + mix(_263, 0.0, _262), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _287 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _269) + mix(mix(0.699999988079071044921875, 1.0, _263), 1.0, _262), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _334;
    float _335;
    float _336;
    float3 _337;
    float3 _338;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _304 = ((_178.xy / float2(_178.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _308 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _304, level(0.0));
        float4 _311 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _304, level(0.0));
        float4 _314 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _304, level(0.0));
        float _324 = _314.w;
        _334 = (_287 * _324) + _314.z;
        _335 = (0.5 * _324) + _314.y;
        _336 = _314.x;
        _337 = (_282 * _308.w) + _308.xyz;
        _338 = normalize((_215 * _311.w) + ((_311.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _334 = _287;
        _335 = 0.5;
        _336 = 0.0;
        _337 = _282;
        _338 = _215;
    }
    float _387;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _355 = fast::clamp((_187 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _366 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_355.x), int(_355.y), int(_355.z), 0).xyz), 0));
        _387 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_366.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_355 / float3(_366.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _387 = 1.0;
    }
    float3 _401 = ((_337 - (_337 * _336)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _408 = (mix(float3(0.07999999821186065673828125 * _335), _337, float3(_336)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _411 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _416;
    if (_411)
    {
        _416 = _401 + (_408 * 0.449999988079071044921875);
    }
    else
    {
        _416 = _401;
    }
    float3 _425 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _451;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _450;
        if (any(abs(_187 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _450 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_187, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _450 = _425;
        }
        _451 = _450;
    }
    else
    {
        _451 = _425;
    }
    float4 _457 = float4((mix(float3(0.0), _416 + (select(_408, float3(0.0), bool3(_411)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + _451) * 1.0, 0.0);
    float4 _464;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _463 = _457;
        _463.w = 0.0;
        _464 = _463;
    }
    else
    {
        _464 = _457;
    }
    float2 _468 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _476 = (_338 * 0.5) + float3(0.5);
    float4 _478 = float4(_476.x, _476.y, _476.z, float4(0.0).w);
    _478.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _479 = float4(0.0);
    _479.x = _336;
    float4 _480 = _479;
    _480.y = _335;
    float4 _481 = _480;
    _481.z = _334;
    float4 _482 = _481;
    _482.w = 0.50588238239288330078125;
    float4 _485 = float4(_337.x, _337.y, _337.z, float4(0.0).w);
    _485.w = (fract(dot(_468.xyx * _468.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _464 * View.View_PreExposure;
    out.out_var_SV_Target1 = _478;
    out.out_var_SV_Target2 = _482;
    out.out_var_SV_Target3 = _485;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_387, 1.0, 1.0, 1.0);
    return out;
}

