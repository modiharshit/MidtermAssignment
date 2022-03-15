

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

fragment MainPS_out Main_00002fb0_e84b2574(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    float4 _187 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _191 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _196 = (_191.xyz / float3(_191.w)) - View.View_PreViewTranslation;
    float4 _204 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (in_var_TEXCOORD0[0].xy * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _207 = (_204.xy * float2(2.0)) - float2(1.0);
    float3 _224 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize(((float4(_207, sqrt(fast::clamp(1.0 - dot(_207, _207), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _236 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in_var_TEXCOORD0[0].xy * 20.0), bias(View.View_MaterialTextureMipBias));
    float _238 = mix(0.4000000059604644775390625, 1.0, _236.x);
    float4 _242 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in_var_TEXCOORD0[0].xy * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _267;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _267 = _187.w;
                break;
            }
            else
            {
                float _251 = _187.z;
                _267 = ((_251 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_251 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _271 = fast::min(fast::max((_267 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _272 = _242.y;
    float4 _276 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in_var_TEXCOORD0[0].xy * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _278 = _276.y;
    float3 _291 = fast::clamp(float3(mix(_238, 1.0 - _238, mix(_272, 1.0, _271)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_278 + mix(_272, 0.0, _271), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _296 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _278) + mix(mix(0.699999988079071044921875, 1.0, _272), 1.0, _271), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _343;
    float _344;
    float _345;
    float3 _346;
    float3 _347;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _313 = ((_187.xy / float2(_187.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _317 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _313, level(0.0));
        float4 _320 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _313, level(0.0));
        float4 _323 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _313, level(0.0));
        float _333 = _323.w;
        _343 = (_296 * _333) + _323.z;
        _344 = (0.5 * _333) + _323.y;
        _345 = _323.x;
        _346 = (_291 * _317.w) + _317.xyz;
        _347 = normalize((_224 * _320.w) + ((_320.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _343 = _296;
        _344 = 0.5;
        _345 = 0.0;
        _346 = _291;
        _347 = _224;
    }
    float _396;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _364 = fast::clamp((_196 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _375 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_364.x), int(_364.y), int(_364.z), 0).xyz), 0));
        _396 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_375.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_364 / float3(_375.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _396 = 1.0;
    }
    float3 _410 = ((_346 - (_346 * _345)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _417 = (mix(float3(0.07999999821186065673828125 * _344), _346, float3(_345)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _420 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _425;
    if (_420)
    {
        _425 = _410 + (_417 * 0.449999988079071044921875);
    }
    else
    {
        _425 = _410;
    }
    float3 _434 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _460;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _459;
        if (any(abs(_196 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _459 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_196, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _459 = _434;
        }
        _460 = _459;
    }
    else
    {
        _460 = _434;
    }
    float4 _466 = float4((mix(float3(0.0), _425 + (select(_417, float3(0.0), bool3(_420)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + _460) * 1.0, 0.0);
    float4 _473;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _472 = _466;
        _472.w = 0.0;
        _473 = _472;
    }
    else
    {
        _473 = _466;
    }
    float2 _477 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _485 = (_347 * 0.5) + float3(0.5);
    float4 _487 = float4(_485.x, _485.y, _485.z, float4(0.0).w);
    _487.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _488 = float4(0.0);
    _488.x = _345;
    float4 _489 = _488;
    _489.y = _344;
    float4 _490 = _489;
    _490.z = _343;
    float4 _491 = _490;
    _491.w = 0.50588238239288330078125;
    float4 _494 = float4(_346.x, _346.y, _346.z, float4(0.0).w);
    _494.w = (fract(dot(_477.xyx * _477.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _473 * View.View_PreExposure;
    out.out_var_SV_Target1 = _487;
    out.out_var_SV_Target2 = _491;
    out.out_var_SV_Target3 = _494;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_396, 1.0, 1.0, 1.0);
    return out;
}

