

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
    char _m11_pad[24];
    float View_CullingSign;
    char _m12_pad[52];
    float View_UnlitViewmodeMask;
    char _m13_pad[612];
    float View_RenderingReflectionCaptureMask;
    char _m14_pad[188];
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

constant float _116 = {};

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
    float4 in_var_COLOR0 [[user(locn2)]];
    uint in_var_PRIMITIVE_ID [[user(locn3)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_0000293a_9f27e8eb(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]], bool gl_FrontFacing [[front_facing]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _172 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _116, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _177 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _182 = (_177.xyz / float3(_177.w)) - View.View_PreViewTranslation;
    uint _183 = in.in_var_PRIMITIVE_ID * 36u;
    float3 _199 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * ((View.View_CullingSign * View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _183 + 4u)].w) * float(gl_FrontFacing ? 1 : (-1)));
    float3 _208 = fast::clamp(in.in_var_COLOR0.xyz, float3(0.0), float3(1.0));
    float _212 = (0.5 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _213 = _183 + 20u;
    float _259;
    float _260;
    float _261;
    float3 _262;
    float3 _263;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _213)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _231 = ((_172.xy / float2(_172.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _235 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _231, level(0.0));
        float4 _238 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _231, level(0.0));
        float4 _241 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _231, level(0.0));
        _259 = (_212 * _241.w) + _241.z;
        _260 = _241.y;
        _261 = _241.x;
        _262 = (_208 * _235.w) + _235.xyz;
        _263 = normalize((_199 * _238.w) + ((_238.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _259 = _212;
        _260 = 0.0;
        _261 = 0.0;
        _262 = _208;
        _263 = _199;
    }
    float _312;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _213)].z > 0.0)
    {
        float3 _280 = fast::clamp((_182 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _291 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_280.x), int(_280.y), int(_280.z), 0).xyz), 0));
        _312 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_291.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_280 / float3(_291.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _312 = 1.0;
    }
    float3 _326 = ((_262 - (_262 * _261)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _333 = (mix(float3(0.07999999821186065673828125 * _260), _262, float3(_261)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _336 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _341;
    if (_336)
    {
        _341 = _326 + (_333 * 0.449999988079071044921875);
    }
    else
    {
        _341 = _326;
    }
    float3 _350 = fast::max(mix(in.in_var_COLOR0.xyz, Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _379;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _378;
        if (any(abs(_182 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _183 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _183 + 19u)].xyz + float3(1.0))))
        {
            _378 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_182, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _378 = _350;
        }
        _379 = _378;
    }
    else
    {
        _379 = _350;
    }
    float4 _385 = float4((mix(float3(0.0), _341 + (select(_333, float3(0.0), bool3(_336)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + _379) * 1.0, 0.0);
    float4 _392;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _391 = _385;
        _391.w = 0.0;
        _392 = _391;
    }
    else
    {
        _392 = _385;
    }
    float2 _396 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _404 = (_263 * 0.5) + float3(0.5);
    float4 _406 = float4(_404.x, _404.y, _404.z, float4(0.0).w);
    _406.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _213)].y;
    float4 _407 = float4(0.0);
    _407.x = _261;
    float4 _408 = _407;
    _408.y = _260;
    float4 _409 = _408;
    _409.z = _259;
    float4 _410 = _409;
    _410.w = 0.50588238239288330078125;
    float4 _413 = float4(_262.x, _262.y, _262.z, float4(0.0).w);
    _413.w = (fract(dot(_396.xyx * _396.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _392 * View.View_PreExposure;
    out.out_var_SV_Target1 = _406;
    out.out_var_SV_Target2 = _410;
    out.out_var_SV_Target3 = _413;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_312, 1.0, 1.0, 1.0);
    return out;
}

