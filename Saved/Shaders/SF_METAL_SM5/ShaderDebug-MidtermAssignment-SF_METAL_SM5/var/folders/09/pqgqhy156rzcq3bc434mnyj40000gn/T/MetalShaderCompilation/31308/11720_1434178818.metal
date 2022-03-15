

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
    spvUnsafeArray<float4, 8> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float _128 = {};

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

fragment MainPS_out Main_00002dc8_557bd502(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _182 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _128, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _187 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _192 = (_187.xyz / float3(_187.w)) - View.View_PreViewTranslation;
    float4 _198 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _201 = (_198.xy * float2(2.0)) - float2(1.0);
    float3 _217 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_201, sqrt(fast::clamp(1.0 - dot(_201, _201), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _228 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _235 = _228.z;
    float _241 = _228.y;
    float3 _255 = fast::clamp(mix(mix(Material.Material_VectorExpressions[4].xyz, Material.Material_VectorExpressions[5].xyz, float3(_235)), Material.Material_VectorExpressions[7].xyz, float3(_241)) * _228.x, float3(0.0), float3(1.0));
    float _256 = fast::clamp(mix(0.0, 1.0, _241), 0.0, 1.0);
    float _261 = (fast::clamp(mix(mix(Material.Material_ScalarExpressions[0].y, Material.Material_ScalarExpressions[0].z, _235), Material.Material_ScalarExpressions[0].w, _241), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _262 = in.in_var_PRIMITIVE_ID * 36u;
    uint _263 = _262 + 20u;
    float _313;
    float _314;
    float _315;
    float3 _316;
    float3 _317;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _263)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _281 = ((_182.xy / float2(_182.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _285 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _281, level(0.0));
        float4 _288 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _281, level(0.0));
        float4 _291 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _281, level(0.0));
        float _301 = _291.w;
        _313 = (_261 * _301) + _291.z;
        _314 = (0.5 * _301) + _291.y;
        _315 = (_256 * _301) + _291.x;
        _316 = (_255 * _285.w) + _285.xyz;
        _317 = normalize((_217 * _288.w) + ((_288.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _313 = _261;
        _314 = 0.5;
        _315 = _256;
        _316 = _255;
        _317 = _217;
    }
    float _366;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _263)].z > 0.0)
    {
        float3 _334 = fast::clamp((_192 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _345 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_334.x), int(_334.y), int(_334.z), 0).xyz), 0));
        _366 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_345.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_334 / float3(_345.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _366 = 1.0;
    }
    float3 _380 = ((_316 - (_316 * _315)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _387 = (mix(float3(0.07999999821186065673828125 * _314), _316, float3(_315)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _390 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _395;
    if (_390)
    {
        _395 = _380 + (_387 * 0.449999988079071044921875);
    }
    else
    {
        _395 = _380;
    }
    float3 _404 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _433;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _432;
        if (any(abs(_192 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _262 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _262 + 19u)].xyz + float3(1.0))))
        {
            _432 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_192, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _432 = _404;
        }
        _433 = _432;
    }
    else
    {
        _433 = _404;
    }
    float4 _439 = float4((mix(float3(0.0), _395 + (select(_387, float3(0.0), bool3(_390)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + _433) * 1.0, 0.0);
    float4 _446;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _445 = _439;
        _445.w = 0.0;
        _446 = _445;
    }
    else
    {
        _446 = _439;
    }
    float2 _450 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _458 = (_317 * 0.5) + float3(0.5);
    float4 _460 = float4(_458.x, _458.y, _458.z, float4(0.0).w);
    _460.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _263)].y;
    float4 _461 = float4(0.0);
    _461.x = _315;
    float4 _462 = _461;
    _462.y = _314;
    float4 _463 = _462;
    _463.z = _313;
    float4 _464 = _463;
    _464.w = 0.50588238239288330078125;
    float4 _467 = float4(_316.x, _316.y, _316.z, float4(0.0).w);
    _467.w = (fract(dot(_450.xyx * _450.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _446 * View.View_PreExposure;
    out.out_var_SV_Target1 = _460;
    out.out_var_SV_Target2 = _464;
    out.out_var_SV_Target3 = _467;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_366, 1.0, 1.0, 1.0);
    return out;
}

