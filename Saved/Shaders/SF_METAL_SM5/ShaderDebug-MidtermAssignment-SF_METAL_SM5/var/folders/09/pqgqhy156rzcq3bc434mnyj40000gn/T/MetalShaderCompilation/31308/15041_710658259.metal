

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
    char _m16_pad[48];
    float4 View_SkyLightColor;
    char _m17_pad[124];
    float View_ShowDecalsMask;
    char _m18_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m19_pad[48];
    float3 View_VolumetricLightmapWorldToUVScale;
    float3 View_VolumetricLightmapWorldToUVAdd;
    packed_float3 View_VolumetricLightmapIndirectionTextureSize;
    float View_VolumetricLightmapBrickSize;
    float3 View_VolumetricLightmapBrickTexelSize;
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_Material
{
    spvUnsafeArray<float4, 6> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float3 _153 = {};

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
    uint in_var_PRIMITIVE_ID [[user(locn3)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00003ac1_2a5bc8d3(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _211 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _215 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _220 = (_215.xyz / float3(_215.w)) - View.View_PreViewTranslation;
    float4 _227 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 10.0), bias(View.View_MaterialTextureMipBias));
    float2 _230 = (_227.xy * float2(2.0)) - float2(1.0);
    float4 _243 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _246 = (_243.xy * float2(2.0)) - float2(1.0);
    float _280;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _280 = _211.w;
                break;
            }
            else
            {
                float _264 = _211.z;
                _280 = ((_264 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_264 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _284 = fast::min(fast::max((_280 - 24.0) * 0.00022222222469281405210494995117188, 0.0), 1.0);
    float3 _295 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((((float4(_230, sqrt(fast::clamp(1.0 - dot(_230, _230), 0.0, 1.0)), 1.0).xyz * float3(0.5, 0.5, 1.0)) + mix(float4(_246, sqrt(fast::clamp(1.0 - dot(_246, _246), 0.0, 1.0)), 1.0).xyz * float3(0.25, 0.25, 1.0), float3(0.0, 0.0, 1.0), float3(_284))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _307 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 5.0), bias(View.View_MaterialTextureMipBias));
    float _309 = mix(0.4000000059604644775390625, 1.0, _307.x);
    float _312 = mix(0.699999988079071044921875, 0.89999997615814208984375, _307.y);
    float4 _317 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _332 = fast::clamp(mix(Material.Material_VectorExpressions[4].xyz, Material.Material_VectorExpressions[5].xyz, float3(fast::min(fast::max(_317.y + _284, 0.0), 1.0))) * mix(_309, 1.0 - _309, _312), float3(0.0), float3(1.0));
    float _337 = (fast::clamp(_309 * _312, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _338 = in.in_var_PRIMITIVE_ID * 36u;
    uint _339 = _338 + 20u;
    float _387;
    float _388;
    float _389;
    float3 _390;
    float3 _391;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _339)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _357 = ((_211.xy / float2(_211.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _361 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _357, level(0.0));
        float4 _364 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _357, level(0.0));
        float4 _367 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _357, level(0.0));
        float _377 = _367.w;
        _387 = (_337 * _377) + _367.z;
        _388 = (0.5 * _377) + _367.y;
        _389 = _367.x;
        _390 = (_332 * _361.w) + _361.xyz;
        _391 = normalize((_295 * _364.w) + ((_364.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _387 = _337;
        _388 = 0.5;
        _389 = 0.0;
        _390 = _332;
        _391 = _295;
    }
    float _440;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _339)].z > 0.0)
    {
        float3 _408 = fast::clamp((_220 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _419 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_408.x), int(_408.y), int(_408.z), 0).xyz), 0));
        _440 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_419.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_408 / float3(_419.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _440 = 1.0;
    }
    float3 _454 = ((_390 - (_390 * _389)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _461 = (mix(float3(0.07999999821186065673828125 * _388), _390, float3(_389)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _464 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _469;
    if (_464)
    {
        _469 = _454 + (_461 * 0.449999988079071044921875);
    }
    else
    {
        _469 = _454;
    }
    float4 _475 = float4(_391, 1.0);
    float3 _479 = _153;
    _479.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _475);
    float3 _483 = _479;
    _483.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _475);
    float3 _487 = _483;
    _487.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _475);
    float4 _490 = _475.xyzz * _475.yzzx;
    float3 _494 = _153;
    _494.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _490);
    float3 _498 = _494;
    _498.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _490);
    float3 _502 = _498;
    _502.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _490);
    float3 _536 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _565;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _564;
        if (any(abs(_220 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _338 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _338 + 19u)].xyz + float3(1.0))))
        {
            _564 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_220, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _564 = _536;
        }
        _565 = _564;
    }
    else
    {
        _565 = _536;
    }
    float4 _572 = float4(((mix(float3(0.0), _469 + (select(_461, float3(0.0), bool3(_464)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((((fast::max(float3(0.0), (_487 + _502) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_391.x * _391.x) - (_391.y * _391.y)))) * View.View_SkyLightColor.xyz) * 1.0) * _469) * fast::max(float3(1.0), ((((((_390 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_390 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_390 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _565) * 1.0, 0.0);
    float4 _579;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _578 = _572;
        _578.w = 0.0;
        _579 = _578;
    }
    else
    {
        _579 = _572;
    }
    float2 _583 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _591 = (_391 * 0.5) + float3(0.5);
    float4 _593 = float4(_591.x, _591.y, _591.z, float4(0.0).w);
    _593.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _339)].y;
    float4 _594 = float4(0.0);
    _594.x = _389;
    float4 _595 = _594;
    _595.y = _388;
    float4 _596 = _595;
    _596.z = _387;
    float4 _597 = _596;
    _597.w = 0.50588238239288330078125;
    float4 _600 = float4(_390.x, _390.y, _390.z, float4(0.0).w);
    _600.w = (fract(dot(_583.xyx * _583.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _579 * View.View_PreExposure;
    out.out_var_SV_Target1 = _593;
    out.out_var_SV_Target2 = _597;
    out.out_var_SV_Target3 = _600;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_440, 1.0, 1.0, 1.0);
    return out;
}

