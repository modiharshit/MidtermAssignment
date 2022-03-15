

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
    float4 in_var_TEXCOORD10 [[user(locn0)]];
    float4 in_var_TEXCOORD11 [[user(locn1)]];
    float4 in_var_TEXCOORD3_0 [[user(locn2)]];
};

fragment MainPS_out Main_00002feb_d5f1f364(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD3 = {};
    in_var_TEXCOORD3[0] = in.in_var_TEXCOORD3_0;
    float4 _190 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _194 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _199 = (_194.xyz / float3(_194.w)) - View.View_PreViewTranslation;
    float4 _207 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD3[0].x, in_var_TEXCOORD3[0].y) * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _210 = (_207.xy * float2(2.0)) - float2(1.0);
    float3 _227 = normalize(float3x3(in.in_var_TEXCOORD10.xyz, cross(in.in_var_TEXCOORD11.xyz, in.in_var_TEXCOORD10.xyz) * in.in_var_TEXCOORD11.w, in.in_var_TEXCOORD11.xyz) * normalize(((float4(_210, sqrt(fast::clamp(1.0 - dot(_210, _210), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _239 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD3[0].x, in_var_TEXCOORD3[0].y) * 20.0), bias(View.View_MaterialTextureMipBias));
    float _241 = mix(0.4000000059604644775390625, 1.0, _239.x);
    float4 _245 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD3[0].x, in_var_TEXCOORD3[0].y) * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _270;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _270 = _190.w;
                break;
            }
            else
            {
                float _254 = _190.z;
                _270 = ((_254 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_254 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _274 = fast::min(fast::max((_270 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _275 = _245.y;
    float4 _279 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD3[0].x, in_var_TEXCOORD3[0].y) * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _281 = _279.y;
    float3 _294 = fast::clamp(float3(mix(_241, 1.0 - _241, mix(_275, 1.0, _274)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_281 + mix(_275, 0.0, _274), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _299 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _281) + mix(mix(0.699999988079071044921875, 1.0, _275), 1.0, _274), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _346;
    float _347;
    float _348;
    float3 _349;
    float3 _350;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _316 = ((_190.xy / float2(_190.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _320 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _316, level(0.0));
        float4 _323 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _316, level(0.0));
        float4 _326 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _316, level(0.0));
        float _336 = _326.w;
        _346 = (_299 * _336) + _326.z;
        _347 = (0.5 * _336) + _326.y;
        _348 = _326.x;
        _349 = (_294 * _320.w) + _320.xyz;
        _350 = normalize((_227 * _323.w) + ((_323.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _346 = _299;
        _347 = 0.5;
        _348 = 0.0;
        _349 = _294;
        _350 = _227;
    }
    float _399;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _367 = fast::clamp((_199 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _378 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_367.x), int(_367.y), int(_367.z), 0).xyz), 0));
        _399 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_378.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_367 / float3(_378.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _399 = 1.0;
    }
    float3 _413 = ((_349 - (_349 * _348)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _420 = (mix(float3(0.07999999821186065673828125 * _347), _349, float3(_348)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _423 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _428;
    if (_423)
    {
        _428 = _413 + (_420 * 0.449999988079071044921875);
    }
    else
    {
        _428 = _413;
    }
    float3 _437 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _463;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _462;
        if (any(abs(_199 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _462 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_199, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _462 = _437;
        }
        _463 = _462;
    }
    else
    {
        _463 = _437;
    }
    float4 _469 = float4((mix(float3(0.0), _428 + (select(_420, float3(0.0), bool3(_423)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + _463) * 1.0, 0.0);
    float4 _476;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _475 = _469;
        _475.w = 0.0;
        _476 = _475;
    }
    else
    {
        _476 = _469;
    }
    float2 _480 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _488 = (_350 * 0.5) + float3(0.5);
    float4 _490 = float4(_488.x, _488.y, _488.z, float4(0.0).w);
    _490.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _491 = float4(0.0);
    _491.x = _348;
    float4 _492 = _491;
    _492.y = _347;
    float4 _493 = _492;
    _493.z = _346;
    float4 _494 = _493;
    _494.w = 0.50588238239288330078125;
    float4 _497 = float4(_349.x, _349.y, _349.z, float4(0.0).w);
    _497.w = (fract(dot(_480.xyx * _480.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _476 * View.View_PreExposure;
    out.out_var_SV_Target1 = _490;
    out.out_var_SV_Target2 = _494;
    out.out_var_SV_Target3 = _497;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_399, 1.0, 1.0, 1.0);
    return out;
}

