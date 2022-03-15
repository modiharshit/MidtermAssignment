

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

fragment MainPS_out Main_0000309a_f1235632(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> Material_Texture2D_0 [[texture(2)]], texture2d<float> Material_Texture2D_1 [[texture(3)]], texture2d<float> Material_Texture2D_2 [[texture(4)]], texture2d<float> Material_Texture2D_3 [[texture(5)]], sampler View_MaterialTextureBilinearWrapedSampler [[sampler(0)]], sampler View_SharedBilinearClampedSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
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
    float4 _243 = Material_Texture2D_2.sample(View_MaterialTextureBilinearWrapedSampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 50.0));
    float3 _247 = float3(_225.x);
    float4 _252 = Material_Texture2D_3.sample(View_MaterialTextureBilinearWrapedSampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 8.0));
    float3 _256 = float3(_225.z);
    float3 _259 = float3(_225.w);
    float3 _274 = fast::clamp(mix(mix(mix(mix(Material.Material_VectorExpressions[3].xyz, Material.Material_VectorExpressions[3].xyz, float3(_225.y)), _243.xyz * float3(0.2249999940395355224609375), _247), _252.xyz * float3(0.25), _256), float3(0.0), _259), float3(0.0), float3(1.0));
    float _275 = fast::clamp(mix(mix(float3(0.0), float3(1.0), _256), float3(0.0), _259).x, 0.0, 1.0);
    float _329;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _297 = fast::clamp((_184 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _308 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_297.x), int(_297.y), int(_297.z), 0).xyz), 0));
        _329 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_308.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_297 / float3(_308.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _329 = 1.0;
    }
    float3 _341 = ((_274 - (_274 * _275)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _348 = (mix(float3(0.039999999105930328369140625), _274, float3(_275)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _351 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _356;
    if (_351)
    {
        _356 = _341 + (_348 * 0.449999988079071044921875);
    }
    else
    {
        _356 = _341;
    }
    float _359 = _221.x;
    float _360 = _221.y;
    float4 _362 = float4(_359, _360, _221.z, 1.0);
    float3 _366 = _142;
    _366.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _362);
    float3 _370 = _366;
    _370.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _362);
    float3 _374 = _370;
    _374.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _362);
    float4 _377 = _362.xyzz * _362.yzzx;
    float3 _381 = _142;
    _381.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _377);
    float3 _385 = _381;
    _385.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _377);
    float3 _389 = _385;
    _389.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _377);
    float3 _423 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _449;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _448;
        if (any(abs(_184 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _448 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_184, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _448 = _423;
        }
        _449 = _448;
    }
    else
    {
        _449 = _423;
    }
    float4 _456 = float4(((mix(float3(0.0), _356 + (select(_348, float3(0.0), bool3(_351)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((((fast::max(float3(0.0), (_374 + _389) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_359 * _359) - (_360 * _360)))) * View.View_SkyLightColor.xyz) * 1.0) * _356) * fast::max(float3(1.0), ((((((_274 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_274 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_274 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _449) * 1.0, 0.0);
    float4 _463;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _462 = _456;
        _462.w = 0.0;
        _463 = _462;
    }
    else
    {
        _463 = _456;
    }
    float2 _468 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _476 = (_221 * 0.5) + float3(0.5);
    float4 _478 = float4(_476.x, _476.y, _476.z, float4(0.0).w);
    _478.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _479 = float4(0.0);
    _479.x = _275;
    float4 _480 = _479;
    _480.y = 0.5;
    float4 _481 = _480;
    _481.z = (fast::clamp(mix(mix(mix(float3(0.100000001490116119384765625), float3(mix(0.550000011920928955078125, 0.75, _243.x)), _247), float3(mix(0.37999999523162841796875, 0.550000011920928955078125, _252.x)), _256), float3(0.100000001490116119384765625), _259).x, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float4 _482 = _481;
    _482.w = 0.50588238239288330078125;
    float4 _485 = float4(_274.x, _274.y, _274.z, float4(0.0).w);
    _485.w = (fract(dot(_468.xyx * _468.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _463 * View.View_PreExposure;
    out.out_var_SV_Target1 = _478;
    out.out_var_SV_Target2 = _482;
    out.out_var_SV_Target3 = _485;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_329, 1.0, 1.0, 1.0);
    return out;
}

