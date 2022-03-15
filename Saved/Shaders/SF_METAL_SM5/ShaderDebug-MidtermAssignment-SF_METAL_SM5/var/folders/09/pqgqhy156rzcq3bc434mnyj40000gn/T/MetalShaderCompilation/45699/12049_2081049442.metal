

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
    float2 View_RoughnessOverrideParameter;
    char _m10_pad[8];
    float View_OutOfBoundsMask;
    char _m11_pad[80];
    float View_UnlitViewmodeMask;
    char _m12_pad[612];
    float View_RenderingReflectionCaptureMask;
    char _m13_pad[48];
    float4 View_SkyLightColor;
    char _m14_pad[124];
    float View_ShowDecalsMask;
    char _m15_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m16_pad[48];
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

fragment MainPS_out Main_00002f11_7c0a4b62(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _180 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _128, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _185 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _190 = (_185.xyz / float3(_185.w)) - View.View_PreViewTranslation;
    float3 _198 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float _209 = (0.100000001490116119384765625 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _210 = in.in_var_PRIMITIVE_ID * 36u;
    uint _211 = _210 + 20u;
    float _260;
    float _261;
    float _262;
    float3 _263;
    float3 _264;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _211)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _229 = ((_180.xy / float2(_180.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _233 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _229, level(0.0));
        float4 _236 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _229, level(0.0));
        float4 _239 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _229, level(0.0));
        float _249 = _239.w;
        _260 = (_209 * _249) + _239.z;
        _261 = (0.5 * _249) + _239.y;
        _262 = _249 + _239.x;
        _263 = (float3(1.0) * _233.w) + _233.xyz;
        _264 = normalize((_198 * _236.w) + ((_236.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _260 = _209;
        _261 = 0.5;
        _262 = 1.0;
        _263 = float3(1.0);
        _264 = _198;
    }
    float _313;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _211)].z > 0.0)
    {
        float3 _281 = fast::clamp((_190 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _292 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_281.x), int(_281.y), int(_281.z), 0).xyz), 0));
        _313 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_292.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_281 / float3(_292.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _313 = 1.0;
    }
    float3 _327 = ((_263 - (_263 * _262)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _334 = (mix(float3(0.07999999821186065673828125 * _261), _263, float3(_262)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _337 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _342;
    if (_337)
    {
        _342 = _327 + (_334 * 0.449999988079071044921875);
    }
    else
    {
        _342 = _327;
    }
    float4 _348 = float4(_264, 1.0);
    float3 _352 = _129;
    _352.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _348);
    float3 _356 = _352;
    _356.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _348);
    float3 _360 = _356;
    _360.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _348);
    float4 _363 = _348.xyzz * _348.yzzx;
    float3 _367 = _129;
    _367.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _363);
    float3 _371 = _367;
    _371.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _363);
    float3 _375 = _371;
    _375.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _363);
    float3 _409 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _438;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _437;
        if (any(abs(_190 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _210 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _210 + 19u)].xyz + float3(1.0))))
        {
            _437 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_190, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _437 = _409;
        }
        _438 = _437;
    }
    else
    {
        _438 = _409;
    }
    float4 _445 = float4(((mix(float3(0.0), _342 + (select(_334, float3(0.0), bool3(_337)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((((fast::max(float3(0.0), (_360 + _375) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_264.x * _264.x) - (_264.y * _264.y)))) * View.View_SkyLightColor.xyz) * 1.0) * _342) * fast::max(float3(1.0), ((((((_263 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_263 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_263 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _438) * 1.0, 0.0);
    float4 _452;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _451 = _445;
        _451.w = 0.0;
        _452 = _451;
    }
    else
    {
        _452 = _445;
    }
    float2 _456 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _464 = (_264 * 0.5) + float3(0.5);
    float4 _466 = float4(_464.x, _464.y, _464.z, float4(0.0).w);
    _466.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _211)].y;
    float4 _467 = float4(0.0);
    _467.x = _262;
    float4 _468 = _467;
    _468.y = _261;
    float4 _469 = _468;
    _469.z = _260;
    float4 _470 = _469;
    _470.w = 0.50588238239288330078125;
    float4 _473 = float4(_263.x, _263.y, _263.z, float4(0.0).w);
    _473.w = (fract(dot(_456.xyx * _456.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _452 * View.View_PreExposure;
    out.out_var_SV_Target1 = _466;
    out.out_var_SV_Target2 = _470;
    out.out_var_SV_Target3 = _473;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_313, 1.0, 1.0, 1.0);
    return out;
}

