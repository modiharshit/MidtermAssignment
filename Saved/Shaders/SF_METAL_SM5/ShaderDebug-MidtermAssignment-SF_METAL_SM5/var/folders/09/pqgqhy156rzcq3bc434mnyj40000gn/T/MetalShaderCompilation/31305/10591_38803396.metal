

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
    char _m11_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m12_pad[604];
    float View_ShowDecalsMask;
    char _m13_pad[184];
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

constant float _129 = {};

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
    float4 in_var_TEXCOORD4 [[user(locn2)]];
    uint in_var_PRIMITIVE_ID [[user(locn3)]];
    uint in_var_LIGHTMAP_ID [[user(locn4)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_0000295f_025017c4(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    float4 _175 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _129, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _180 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _185 = (_180.xyz / float3(_180.w)) - View.View_PreViewTranslation;
    float3 _193 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    uint _201 = in.in_var_PRIMITIVE_ID * 36u;
    uint _202 = _201 + 20u;
    float _249;
    float _250;
    float _251;
    float3 _252;
    float3 _253;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _202)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _220 = ((_175.xy / float2(_175.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _224 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _220, level(0.0));
        float4 _227 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _220, level(0.0));
        float4 _230 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _220, level(0.0));
        float _240 = _230.w;
        _249 = _240 + _230.z;
        _250 = (0.5 * _240) + _230.y;
        _251 = _230.x;
        _252 = (float3(0.180000007152557373046875) * _224.w) + _224.xyz;
        _253 = normalize((_193 * _227.w) + ((_227.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _249 = 1.0;
        _250 = 0.5;
        _251 = 0.0;
        _252 = float3(0.180000007152557373046875);
        _253 = _193;
    }
    float3 _277 = (((_252 - (_252 * _251)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz) + (((mix(float3(0.07999999821186065673828125 * _250), _252, float3(_251)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz) * 0.449999988079071044921875);
    float2 _279 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _284 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _279);
    float4 _286 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_279 + float2(0.0, 0.5)));
    uint _292 = in.in_var_LIGHTMAP_ID * 15u;
    uint _293 = _292 + 4u;
    uint _298 = _292 + 6u;
    float3 _303 = _284.xyz;
    float3 _331 = ((((_303 * _303) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _293)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _298)].xyz) * ((exp2(((_284.w + ((_286.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _293)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _298)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_286 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _292 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _292 + 7u)], float4(_253.yzx, 1.0))))) * View.View_IndirectLightingColorScale;
    float3 _351 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _380;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _379;
        if (any(abs(_185 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _201 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _201 + 19u)].xyz + float3(1.0))))
        {
            _379 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_185, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _379 = _351;
        }
        _380 = _379;
    }
    else
    {
        _380 = _351;
    }
    float4 _387 = float4(((mix(float3(0.0), _277, float3(View.View_UnlitViewmodeMask)) + ((_331 * _277) * fast::max(float3(1.0), ((((((_252 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_252 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_252 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _380) * 1.0, 0.0);
    float4 _394;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _393 = _387;
        _393.w = 0.0;
        _394 = _393;
    }
    else
    {
        _394 = _387;
    }
    float2 _398 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _406 = (_253 * 0.5) + float3(0.5);
    float4 _408 = float4(_406.x, _406.y, _406.z, float4(0.0).w);
    _408.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _202)].y;
    float4 _409 = float4(0.0);
    _409.x = _251;
    float4 _410 = _409;
    _410.y = _250;
    float4 _411 = _410;
    _411.z = _249;
    float4 _412 = _411;
    _412.w = 0.75686275959014892578125;
    float4 _423 = float4(_252.x, _252.y, _252.z, float4(0.0).w);
    _423.w = ((log2((dot(_331, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_398.xyx * _398.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _394 * View.View_PreExposure;
    out.out_var_SV_Target1 = _408;
    out.out_var_SV_Target2 = _412;
    out.out_var_SV_Target3 = _423;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

