

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
    char _m1_pad[288];
    float4 View_ScreenPositionScaleBias;
    char _m2_pad[48];
    float3 View_PreViewTranslation;
    char _m3_pad[928];
    float4 View_ViewRectMin;
    float4 View_ViewSizeAndInvSize;
    char _m5_pad[68];
    float View_PreExposure;
    float4 View_DiffuseOverrideParameter;
    float4 View_SpecularOverrideParameter;
    float4 View_NormalOverrideParameter;
    char _m9_pad[16];
    float View_OutOfBoundsMask;
    char _m10_pad[80];
    float View_UnlitViewmodeMask;
    char _m11_pad[656];
    float4 View_SkyLightColor;
    char _m12_pad[124];
    float View_ShowDecalsMask;
    char _m13_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m14_pad[48];
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
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float _128 = {};
constant float3 _129 = {};

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
    uint in_var_PRIMITIVE_ID [[user(locn2)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00002d2f_387208cf(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _178 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _128, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _183 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _188 = (_183.xyz / float3(_183.w)) - View.View_PreViewTranslation;
    float3 _196 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    uint _204 = in.in_var_PRIMITIVE_ID * 36u;
    uint _205 = _204 + 20u;
    float _252;
    float _253;
    float _254;
    float3 _255;
    float3 _256;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _205)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _223 = ((_178.xy / float2(_178.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _227 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _223, level(0.0));
        float4 _230 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _223, level(0.0));
        float4 _233 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _223, level(0.0));
        float _243 = _233.w;
        _252 = _243 + _233.z;
        _253 = (0.5 * _243) + _233.y;
        _254 = _233.x;
        _255 = (float3(0.180000007152557373046875) * _227.w) + _227.xyz;
        _256 = normalize((_196 * _230.w) + ((_230.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _252 = 1.0;
        _253 = 0.5;
        _254 = 0.0;
        _255 = float3(0.180000007152557373046875);
        _256 = _196;
    }
    float _305;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _205)].z > 0.0)
    {
        float3 _273 = fast::clamp((_188 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _284 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_273.x), int(_273.y), int(_273.z), 0).xyz), 0));
        _305 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_284.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_273 / float3(_284.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _305 = 1.0;
    }
    float3 _328 = (((_255 - (_255 * _254)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz) + (((mix(float3(0.07999999821186065673828125 * _253), _255, float3(_254)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz) * 0.449999988079071044921875);
    float4 _332 = float4(_256, 1.0);
    float3 _336 = _129;
    _336.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _332);
    float3 _340 = _336;
    _340.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _332);
    float3 _344 = _340;
    _344.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _332);
    float4 _347 = _332.xyzz * _332.yzzx;
    float3 _351 = _129;
    _351.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _347);
    float3 _355 = _351;
    _355.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _347);
    float3 _359 = _355;
    _359.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _347);
    float3 _391 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _420;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _419;
        if (any(abs(_188 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _204 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _204 + 19u)].xyz + float3(1.0))))
        {
            _419 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_188, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _419 = _391;
        }
        _420 = _419;
    }
    else
    {
        _420 = _391;
    }
    float4 _427 = float4(((mix(float3(0.0), _328, float3(View.View_UnlitViewmodeMask)) + ((((fast::max(float3(0.0), (_344 + _359) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_256.x * _256.x) - (_256.y * _256.y)))) * View.View_SkyLightColor.xyz) * 1.0) * _328) * fast::max(float3(1.0), ((((((_255 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_255 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_255 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _420) * 1.0, 0.0);
    float4 _434;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _433 = _427;
        _433.w = 0.0;
        _434 = _433;
    }
    else
    {
        _434 = _427;
    }
    float2 _438 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _446 = (_256 * 0.5) + float3(0.5);
    float4 _448 = float4(_446.x, _446.y, _446.z, float4(0.0).w);
    _448.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _205)].y;
    float4 _449 = float4(0.0);
    _449.x = _254;
    float4 _450 = _449;
    _450.y = _253;
    float4 _451 = _450;
    _451.z = _252;
    float4 _452 = _451;
    _452.w = 0.50588238239288330078125;
    float4 _455 = float4(_255.x, _255.y, _255.z, float4(0.0).w);
    _455.w = (fract(dot(_438.xyx * _438.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _434 * View.View_PreExposure;
    out.out_var_SV_Target1 = _448;
    out.out_var_SV_Target2 = _452;
    out.out_var_SV_Target3 = _455;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_305, 1.0, 1.0, 1.0);
    return out;
}

