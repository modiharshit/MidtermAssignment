

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
    char _m0_pad[704];
    float4x4 View_SVPositionToTranslatedWorld;
    char _m1_pad[352];
    float3 View_PreViewTranslation;
    char _m2_pad[1028];
    float View_PreExposure;
    float4 View_DiffuseOverrideParameter;
    float4 View_SpecularOverrideParameter;
    float4 View_NormalOverrideParameter;
    float2 View_RoughnessOverrideParameter;
    char _m7_pad[8];
    float View_OutOfBoundsMask;
    char _m8_pad[48];
    float View_MaterialTextureMipBias;
    char _m9_pad[28];
    float View_UnlitViewmodeMask;
    char _m10_pad[612];
    float View_RenderingReflectionCaptureMask;
    char _m11_pad[48];
    float4 View_SkyLightColor;
    char _m12_pad[312];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m13_pad[48];
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

struct type_Primitive
{
    char _m0_pad[80];
    float4 Primitive_ObjectWorldPositionAndRadius;
    char _m1_pad[208];
    float3 Primitive_ObjectBounds;
    char _m2_pad[4];
    float Primitive_PerObjectGBufferData;
    float Primitive_UseVolumetricLightmapShadowFromStationaryLights;
};

struct type_Material
{
    spvUnsafeArray<float4, 4> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float3 _142 = {};

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

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00003034_a770ad16(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> Material_Texture2D_0 [[texture(2)]], texture2d<float> Material_Texture2D_1 [[texture(3)]], texture2d<float> Material_Texture2D_2 [[texture(4)]], texture2d<float> Material_Texture2D_3 [[texture(5)]], sampler View_MaterialTextureBilinearWrapedSampler [[sampler(0)]], sampler View_SharedBilinearClampedSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _179 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _184 = (_179.xyz / float3(_179.w)) - View.View_PreViewTranslation;
    float4 _190 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _193 = (_190.xy * float2(2.0)) - float2(1.0);
    float _197 = sqrt(fast::clamp(1.0 - dot(_193, _193), 0.0, 1.0));
    float3 _205 = float3(float4(_193, _197, 1.0).xy * (-1.0), _197);
    float3 _209 = (float3(0.0, 0.0, 2.0) * dot(float3(0.0, 0.0, 2.0), _205)) - (_205 * 2.0);
    float3 _221 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize(((_209 / float3(sqrt(dot(_209, _209)))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _225 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _243 = Material_Texture2D_2.sample(View_MaterialTextureBilinearWrapedSampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 8.0));
    float3 _247 = float3(_225.x);
    float4 _252 = Material_Texture2D_3.sample(View_MaterialTextureBilinearWrapedSampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 50.0));
    float3 _256 = float3(_225.z);
    float3 _270 = fast::clamp(mix(mix(mix(Material.Material_VectorExpressions[3].xyz, Material.Material_VectorExpressions[3].xyz, float3(_225.y)), _243.xyz * float3(0.25), _247), _252.xyz * float3(0.2249999940395355224609375), _256), float3(0.0), float3(1.0));
    float _271 = fast::clamp(mix(mix(float3(0.0), float3(1.0), _247), float3(0.0), _256).x, 0.0, 1.0);
    float _325;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _293 = fast::clamp((_184 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _304 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_293.x), int(_293.y), int(_293.z), 0).xyz), 0));
        _325 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_304.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_293 / float3(_304.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _325 = 1.0;
    }
    float3 _337 = ((_270 - (_270 * _271)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _344 = (mix(float3(0.039999999105930328369140625), _270, float3(_271)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _347 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _352;
    if (_347)
    {
        _352 = _337 + (_344 * 0.449999988079071044921875);
    }
    else
    {
        _352 = _337;
    }
    float _355 = _221.x;
    float _356 = _221.y;
    float4 _358 = float4(_355, _356, _221.z, 1.0);
    float3 _362 = _142;
    _362.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _358);
    float3 _366 = _362;
    _366.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _358);
    float3 _370 = _366;
    _370.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _358);
    float4 _373 = _358.xyzz * _358.yzzx;
    float3 _377 = _142;
    _377.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _373);
    float3 _381 = _377;
    _381.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _373);
    float3 _385 = _381;
    _385.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _373);
    float3 _419 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _445;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _444;
        if (any(abs(_184 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _444 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_184, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _444 = _419;
        }
        _445 = _444;
    }
    else
    {
        _445 = _419;
    }
    float4 _452 = float4(((mix(float3(0.0), _352 + (select(_344, float3(0.0), bool3(_347)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((((fast::max(float3(0.0), (_370 + _385) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_355 * _355) - (_356 * _356)))) * View.View_SkyLightColor.xyz) * 1.0) * _352) * fast::max(float3(1.0), ((((((_270 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_270 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_270 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _445) * 1.0, 0.0);
    float4 _459;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _458 = _452;
        _458.w = 0.0;
        _459 = _458;
    }
    else
    {
        _459 = _452;
    }
    float2 _464 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _472 = (_221 * 0.5) + float3(0.5);
    float4 _474 = float4(_472.x, _472.y, _472.z, float4(0.0).w);
    _474.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _475 = float4(0.0);
    _475.x = _271;
    float4 _476 = _475;
    _476.y = 0.5;
    float4 _477 = _476;
    _477.z = (fast::clamp(mix(mix(float3(0.100000001490116119384765625), float3(mix(0.37999999523162841796875, 0.550000011920928955078125, _243.x)), _247), float3(mix(0.550000011920928955078125, 0.75, _252.x)), _256).x, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float4 _478 = _477;
    _478.w = 0.50588238239288330078125;
    float4 _481 = float4(_270.x, _270.y, _270.z, float4(0.0).w);
    _481.w = (fract(dot(_464.xyx * _464.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _459 * View.View_PreExposure;
    out.out_var_SV_Target1 = _474;
    out.out_var_SV_Target2 = _478;
    out.out_var_SV_Target3 = _481;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_325, 1.0, 1.0, 1.0);
    return out;
}

