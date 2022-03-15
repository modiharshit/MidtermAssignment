

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
    char _m12_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m13_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m14_pad[188];
    float View_ShowDecalsMask;
    char _m15_pad[184];
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

constant float _133 = {};

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

fragment MainPS_out Main_00002fc1_0dc29b2a(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_StaticShadowTexture [[texture(4)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    float4 _182 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _133, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _187 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _192 = (_187.xyz / float3(_187.w)) - View.View_PreViewTranslation;
    float3 _200 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float _211 = (0.300000011920928955078125 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _212 = in.in_var_PRIMITIVE_ID * 36u;
    uint _213 = _212 + 20u;
    float _261;
    float _262;
    float _263;
    float3 _264;
    float3 _265;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _213)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _231 = ((_182.xy / float2(_182.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _235 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _231, level(0.0));
        float4 _238 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _231, level(0.0));
        float4 _241 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _231, level(0.0));
        float _251 = _241.w;
        _261 = (_211 * _251) + _241.z;
        _262 = (0.5 * _251) + _241.y;
        _263 = _241.x;
        _264 = (float3(0.300000011920928955078125) * _235.w) + _235.xyz;
        _265 = normalize((_200 * _238.w) + ((_238.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _261 = _211;
        _262 = 0.5;
        _263 = 0.0;
        _264 = float3(0.300000011920928955078125);
        _265 = _200;
    }
    float4 _272 = LightmapResourceCluster_StaticShadowTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.zw);
    uint _273 = in.in_var_LIGHTMAP_ID * 15u;
    uint _274 = _273 + 1u;
    float4 _281 = fast::clamp((_272 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _274)]) + ((View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _274)] * (-0.5)) + float4(0.5)), float4(0.0), float4(1.0));
    float3 _298 = ((_264 - (_264 * _263)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _305 = (mix(float3(0.07999999821186065673828125 * _262), _264, float3(_263)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _308 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _313;
    if (_308)
    {
        _313 = _298 + (_305 * 0.449999988079071044921875);
    }
    else
    {
        _313 = _298;
    }
    float3 _315 = select(_305, float3(0.0), bool3(_308));
    float3 _317 = float3(dot(_315, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _332 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _336 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _332);
    float4 _338 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_332 + float2(0.0, 0.5)));
    uint _344 = _273 + 4u;
    uint _349 = _273 + 6u;
    float3 _354 = _336.xyz;
    float3 _382 = ((((_354 * _354) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _344)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _349)].xyz) * ((exp2(((_336.w + ((_338.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _344)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _349)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_338 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _273 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _273 + 7u)], float4(_265.yzx, 1.0))))) * View.View_IndirectLightingColorScale;
    float3 _404 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _433;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _432;
        if (any(abs(_192 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _212 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _212 + 19u)].xyz + float3(1.0))))
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
    float4 _440 = float4(((mix(float3(0.0), _313 + (_315 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_382 * _313) * fast::max(float3(1.0), ((((((_264 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_264 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_264 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _433) * 1.0, 0.0);
    float4 _447;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _446 = _440;
        _446.w = 0.0;
        _447 = _446;
    }
    else
    {
        _447 = _440;
    }
    float2 _451 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _459 = (_265 * 0.5) + float3(0.5);
    float4 _461 = float4(_459.x, _459.y, _459.z, float4(0.0).w);
    _461.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _213)].y;
    float4 _462 = float4(0.0);
    _462.x = _263;
    float4 _463 = _462;
    _463.y = _262;
    float4 _464 = _463;
    _464.z = _261;
    float4 _465 = _464;
    _465.w = 0.50588238239288330078125;
    float4 _477 = float4(_264.x, _264.y, _264.z, float4(0.0).w);
    _477.w = ((log2(((dot(_382, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_317 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_317 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_317 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_451.xyx * _451.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _447 * View.View_PreExposure;
    out.out_var_SV_Target1 = _461;
    out.out_var_SV_Target2 = _465;
    out.out_var_SV_Target3 = _477;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = (View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _273)] * _281) * _281;
    return out;
}

