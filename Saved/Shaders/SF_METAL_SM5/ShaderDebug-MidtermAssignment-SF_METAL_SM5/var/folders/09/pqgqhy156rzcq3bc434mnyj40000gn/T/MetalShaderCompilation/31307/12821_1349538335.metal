

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
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float _140 = {};

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

fragment MainPS_out Main_00003215_5070521f(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_StaticShadowTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    float4 _193 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _140, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _198 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _203 = (_198.xyz / float3(_198.w)) - View.View_PreViewTranslation;
    float3 _211 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _224 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _226 = fast::clamp(_224.xyz, float3(0.0), float3(1.0));
    float _230 = (0.949999988079071044921875 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _231 = in.in_var_PRIMITIVE_ID * 36u;
    uint _232 = _231 + 20u;
    float _280;
    float _281;
    float _282;
    float3 _283;
    float3 _284;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _232)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _250 = ((_193.xy / float2(_193.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _254 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _250, level(0.0));
        float4 _257 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _250, level(0.0));
        float4 _260 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _250, level(0.0));
        float _270 = _260.w;
        _280 = (_230 * _270) + _260.z;
        _281 = (0.20000000298023223876953125 * _270) + _260.y;
        _282 = _260.x;
        _283 = (_226 * _254.w) + _254.xyz;
        _284 = normalize((_211 * _257.w) + ((_257.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _280 = _230;
        _281 = 0.20000000298023223876953125;
        _282 = 0.0;
        _283 = _226;
        _284 = _211;
    }
    float4 _291 = LightmapResourceCluster_StaticShadowTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.zw);
    uint _292 = in.in_var_LIGHTMAP_ID * 15u;
    uint _293 = _292 + 1u;
    float4 _300 = fast::clamp((_291 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _293)]) + ((View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _293)] * (-0.5)) + float4(0.5)), float4(0.0), float4(1.0));
    float3 _317 = ((_283 - (_283 * _282)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _324 = (mix(float3(0.07999999821186065673828125 * _281), _283, float3(_282)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _327 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _332;
    if (_327)
    {
        _332 = _317 + (_324 * 0.449999988079071044921875);
    }
    else
    {
        _332 = _317;
    }
    float3 _334 = select(_324, float3(0.0), bool3(_327));
    float3 _336 = float3(dot(_334, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _351 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _355 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _351);
    float4 _357 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_351 + float2(0.0, 0.5)));
    uint _363 = _292 + 4u;
    uint _368 = _292 + 6u;
    float3 _373 = _355.xyz;
    float3 _401 = ((((_373 * _373) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _363)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _368)].xyz) * ((exp2(((_355.w + ((_357.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _363)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _368)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_357 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _292 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _292 + 7u)], float4(_284.yzx, 1.0))))) * View.View_IndirectLightingColorScale;
    float3 _423 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _452;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _451;
        if (any(abs(_203 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _231 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _231 + 19u)].xyz + float3(1.0))))
        {
            _451 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_203, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _451 = _423;
        }
        _452 = _451;
    }
    else
    {
        _452 = _423;
    }
    float4 _459 = float4(((mix(float3(0.0), _332 + (_334 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_401 * _332) * fast::max(float3(1.0), ((((((_283 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_283 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_283 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _452) * 1.0, 0.0);
    float4 _466;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _465 = _459;
        _465.w = 0.0;
        _466 = _465;
    }
    else
    {
        _466 = _459;
    }
    float2 _470 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _478 = (_284 * 0.5) + float3(0.5);
    float4 _480 = float4(_478.x, _478.y, _478.z, float4(0.0).w);
    _480.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _232)].y;
    float4 _481 = float4(0.0);
    _481.x = _282;
    float4 _482 = _481;
    _482.y = _281;
    float4 _483 = _482;
    _483.z = _280;
    float4 _484 = _483;
    _484.w = 0.50588238239288330078125;
    float4 _496 = float4(_283.x, _283.y, _283.z, float4(0.0).w);
    _496.w = ((log2(((dot(_401, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_336 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_336 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_336 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_470.xyx * _470.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _466 * View.View_PreExposure;
    out.out_var_SV_Target1 = _480;
    out.out_var_SV_Target2 = _484;
    out.out_var_SV_Target3 = _496;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = (View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _292)] * _300) * _300;
    return out;
}

