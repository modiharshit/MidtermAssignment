

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
    char _m11_pad[48];
    float View_MaterialTextureMipBias;
    char _m12_pad[28];
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
    spvUnsafeArray<float4, 6> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float _127 = {};

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

fragment MainPS_out Main_00002d40_5bb03bae(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _181 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _127, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _186 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _191 = (_186.xyz / float3(_186.w)) - View.View_PreViewTranslation;
    float4 _197 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _200 = (_197.xy * float2(2.0)) - float2(1.0);
    float3 _216 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_200, sqrt(fast::clamp(1.0 - dot(_200, _200), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _227 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _234 = _227.y;
    float3 _245 = fast::clamp(mix(Material.Material_VectorExpressions[4].xyz, Material.Material_VectorExpressions[5].xyz, float3(_234)) * _227.x, float3(0.0), float3(1.0));
    float _246 = fast::clamp(mix(0.0, 1.0, _234), 0.0, 1.0);
    float _251 = (fast::clamp(mix(Material.Material_ScalarExpressions[0].y, Material.Material_ScalarExpressions[0].z, _234), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _252 = in.in_var_PRIMITIVE_ID * 36u;
    uint _253 = _252 + 20u;
    float _303;
    float _304;
    float _305;
    float3 _306;
    float3 _307;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _253)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _271 = ((_181.xy / float2(_181.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _275 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _271, level(0.0));
        float4 _278 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _271, level(0.0));
        float4 _281 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _271, level(0.0));
        float _291 = _281.w;
        _303 = (_251 * _291) + _281.z;
        _304 = (0.5 * _291) + _281.y;
        _305 = (_246 * _291) + _281.x;
        _306 = (_245 * _275.w) + _275.xyz;
        _307 = normalize((_216 * _278.w) + ((_278.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _303 = _251;
        _304 = 0.5;
        _305 = _246;
        _306 = _245;
        _307 = _216;
    }
    float _356;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _253)].z > 0.0)
    {
        float3 _324 = fast::clamp((_191 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _335 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_324.x), int(_324.y), int(_324.z), 0).xyz), 0));
        _356 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_335.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_324 / float3(_335.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _356 = 1.0;
    }
    float3 _370 = ((_306 - (_306 * _305)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _377 = (mix(float3(0.07999999821186065673828125 * _304), _306, float3(_305)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _380 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _385;
    if (_380)
    {
        _385 = _370 + (_377 * 0.449999988079071044921875);
    }
    else
    {
        _385 = _370;
    }
    float3 _394 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _423;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _422;
        if (any(abs(_191 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _252 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _252 + 19u)].xyz + float3(1.0))))
        {
            _422 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_191, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _422 = _394;
        }
        _423 = _422;
    }
    else
    {
        _423 = _394;
    }
    float4 _429 = float4((mix(float3(0.0), _385 + (select(_377, float3(0.0), bool3(_380)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + _423) * 1.0, 0.0);
    float4 _436;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _435 = _429;
        _435.w = 0.0;
        _436 = _435;
    }
    else
    {
        _436 = _429;
    }
    float2 _440 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _448 = (_307 * 0.5) + float3(0.5);
    float4 _450 = float4(_448.x, _448.y, _448.z, float4(0.0).w);
    _450.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _253)].y;
    float4 _451 = float4(0.0);
    _451.x = _305;
    float4 _452 = _451;
    _452.y = _304;
    float4 _453 = _452;
    _453.z = _303;
    float4 _454 = _453;
    _454.w = 0.50588238239288330078125;
    float4 _457 = float4(_306.x, _306.y, _306.z, float4(0.0).w);
    _457.w = (fract(dot(_440.xyx * _440.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _436 * View.View_PreExposure;
    out.out_var_SV_Target1 = _450;
    out.out_var_SV_Target2 = _454;
    out.out_var_SV_Target3 = _457;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_356, 1.0, 1.0, 1.0);
    return out;
}

