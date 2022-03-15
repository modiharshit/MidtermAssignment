

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
    float4 in_var_TEXCOORD0_0 [[user(locn3)]];
};

fragment MainPS_out Main_0000302e_c67a7636(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    float4 _189 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _193 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _198 = (_193.xyz / float3(_193.w)) - View.View_PreViewTranslation;
    float4 _206 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _209 = (_206.xy * float2(2.0)) - float2(1.0);
    float3 _226 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize(((float4(_209, sqrt(fast::clamp(1.0 - dot(_209, _209), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _238 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 20.0), bias(View.View_MaterialTextureMipBias));
    float _240 = mix(0.4000000059604644775390625, 1.0, _238.x);
    float4 _244 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _269;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _269 = _189.w;
                break;
            }
            else
            {
                float _253 = _189.z;
                _269 = ((_253 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_253 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _273 = fast::min(fast::max((_269 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _274 = _244.y;
    float4 _278 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _280 = _278.y;
    float3 _293 = fast::clamp(float3(mix(_240, 1.0 - _240, mix(_274, 1.0, _273)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_280 + mix(_274, 0.0, _273), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _298 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _280) + mix(mix(0.699999988079071044921875, 1.0, _274), 1.0, _273), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _345;
    float _346;
    float _347;
    float3 _348;
    float3 _349;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _315 = ((_189.xy / float2(_189.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _319 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _315, level(0.0));
        float4 _322 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _315, level(0.0));
        float4 _325 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _315, level(0.0));
        float _335 = _325.w;
        _345 = (_298 * _335) + _325.z;
        _346 = (0.5 * _335) + _325.y;
        _347 = _325.x;
        _348 = (_293 * _319.w) + _319.xyz;
        _349 = normalize((_226 * _322.w) + ((_322.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _345 = _298;
        _346 = 0.5;
        _347 = 0.0;
        _348 = _293;
        _349 = _226;
    }
    float _398;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _366 = fast::clamp((_198 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _377 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_366.x), int(_366.y), int(_366.z), 0).xyz), 0));
        _398 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_377.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_366 / float3(_377.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _398 = 1.0;
    }
    float3 _412 = ((_348 - (_348 * _347)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _419 = (mix(float3(0.07999999821186065673828125 * _346), _348, float3(_347)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _422 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _427;
    if (_422)
    {
        _427 = _412 + (_419 * 0.449999988079071044921875);
    }
    else
    {
        _427 = _412;
    }
    float3 _436 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _462;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _461;
        if (any(abs(_198 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _461 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_198, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _461 = _436;
        }
        _462 = _461;
    }
    else
    {
        _462 = _436;
    }
    float4 _468 = float4((mix(float3(0.0), _427 + (select(_419, float3(0.0), bool3(_422)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + _462) * 1.0, 0.0);
    float4 _475;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _474 = _468;
        _474.w = 0.0;
        _475 = _474;
    }
    else
    {
        _475 = _468;
    }
    float2 _479 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _487 = (_349 * 0.5) + float3(0.5);
    float4 _489 = float4(_487.x, _487.y, _487.z, float4(0.0).w);
    _489.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _490 = float4(0.0);
    _490.x = _347;
    float4 _491 = _490;
    _491.y = _346;
    float4 _492 = _491;
    _492.z = _345;
    float4 _493 = _492;
    _493.w = 0.50588238239288330078125;
    float4 _496 = float4(_348.x, _348.y, _348.z, float4(0.0).w);
    _496.w = (fract(dot(_479.xyx * _479.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _475 * View.View_PreExposure;
    out.out_var_SV_Target1 = _489;
    out.out_var_SV_Target2 = _493;
    out.out_var_SV_Target3 = _496;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_398, 1.0, 1.0, 1.0);
    return out;
}

