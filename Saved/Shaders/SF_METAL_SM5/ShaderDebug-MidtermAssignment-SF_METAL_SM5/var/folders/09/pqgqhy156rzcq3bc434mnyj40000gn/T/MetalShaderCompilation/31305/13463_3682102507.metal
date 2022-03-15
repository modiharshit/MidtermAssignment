

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
    char _m13_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m14_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m15_pad[188];
    float View_ShowDecalsMask;
    char _m16_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_Material
{
    spvUnsafeArray<float4, 4> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float _142 = {};

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
    float4 in_var_TEXCOORD4 [[user(locn3)]];
    uint in_var_PRIMITIVE_ID [[user(locn4)]];
    uint in_var_LIGHTMAP_ID [[user(locn5)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00003497_db786ceb(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_StaticShadowTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    float4 _195 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _142, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _200 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _205 = (_200.xyz / float3(_200.w)) - View.View_PreViewTranslation;
    float4 _211 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _214 = (_211.xy * float2(2.0)) - float2(1.0);
    float3 _230 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_214, sqrt(fast::clamp(1.0 - dot(_214, _214), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _241 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _245 = _241.x;
    float3 _254 = fast::clamp(Material.Material_VectorExpressions[3].xyz * _245, float3(0.0), float3(1.0));
    float _255 = fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0);
    float _260 = (fast::clamp(mix(Material.Material_ScalarExpressions[0].z, Material.Material_ScalarExpressions[0].w, _245), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _261 = in.in_var_PRIMITIVE_ID * 36u;
    uint _262 = _261 + 20u;
    float _312;
    float _313;
    float _314;
    float3 _315;
    float3 _316;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _262)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _280 = ((_195.xy / float2(_195.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _284 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _280, level(0.0));
        float4 _287 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _280, level(0.0));
        float4 _290 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _280, level(0.0));
        float _300 = _290.w;
        _312 = (_260 * _300) + _290.z;
        _313 = (0.5 * _300) + _290.y;
        _314 = (_255 * _300) + _290.x;
        _315 = (_254 * _284.w) + _284.xyz;
        _316 = normalize((_230 * _287.w) + ((_287.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _312 = _260;
        _313 = 0.5;
        _314 = _255;
        _315 = _254;
        _316 = _230;
    }
    float4 _323 = LightmapResourceCluster_StaticShadowTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.zw);
    uint _324 = in.in_var_LIGHTMAP_ID * 15u;
    uint _325 = _324 + 1u;
    float4 _332 = fast::clamp((_323 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _325)]) + ((View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _325)] * (-0.5)) + float4(0.5)), float4(0.0), float4(1.0));
    float3 _349 = ((_315 - (_315 * _314)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _356 = (mix(float3(0.07999999821186065673828125 * _313), _315, float3(_314)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _359 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _364;
    if (_359)
    {
        _364 = _349 + (_356 * 0.449999988079071044921875);
    }
    else
    {
        _364 = _349;
    }
    float3 _366 = select(_356, float3(0.0), bool3(_359));
    float3 _368 = float3(dot(_366, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _383 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _387 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _383);
    float4 _389 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_383 + float2(0.0, 0.5)));
    uint _395 = _324 + 4u;
    uint _400 = _324 + 6u;
    float3 _405 = _387.xyz;
    float3 _433 = ((((_405 * _405) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _395)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _400)].xyz) * ((exp2(((_387.w + ((_389.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _395)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _400)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_389 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _324 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _324 + 7u)], float4(_316.yzx, 1.0))))) * View.View_IndirectLightingColorScale;
    float3 _455 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _484;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _483;
        if (any(abs(_205 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _261 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _261 + 19u)].xyz + float3(1.0))))
        {
            _483 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_205, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _483 = _455;
        }
        _484 = _483;
    }
    else
    {
        _484 = _455;
    }
    float4 _491 = float4(((mix(float3(0.0), _364 + (_366 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_433 * _364) * fast::max(float3(1.0), ((((((_315 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_315 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_315 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _484) * 1.0, 0.0);
    float4 _498;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _497 = _491;
        _497.w = 0.0;
        _498 = _497;
    }
    else
    {
        _498 = _491;
    }
    float2 _502 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _510 = (_316 * 0.5) + float3(0.5);
    float4 _512 = float4(_510.x, _510.y, _510.z, float4(0.0).w);
    _512.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _262)].y;
    float4 _513 = float4(0.0);
    _513.x = _314;
    float4 _514 = _513;
    _514.y = _313;
    float4 _515 = _514;
    _515.z = _312;
    float4 _516 = _515;
    _516.w = 0.50588238239288330078125;
    float4 _528 = float4(_315.x, _315.y, _315.z, float4(0.0).w);
    _528.w = ((log2(((dot(_433, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_368 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_368 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_368 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_502.xyx * _502.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _498 * View.View_PreExposure;
    out.out_var_SV_Target1 = _512;
    out.out_var_SV_Target2 = _516;
    out.out_var_SV_Target3 = _528;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = (View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _324)] * _332) * _332;
    return out;
}

