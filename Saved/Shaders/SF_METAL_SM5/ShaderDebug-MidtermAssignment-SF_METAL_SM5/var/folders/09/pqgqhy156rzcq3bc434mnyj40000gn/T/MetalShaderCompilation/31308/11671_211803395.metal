

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

constant float _132 = {};

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

fragment MainPS_out Main_00002d97_0c9fdd03(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    float4 _181 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _132, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _186 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _191 = (_186.xyz / float3(_186.w)) - View.View_PreViewTranslation;
    float3 _199 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float _210 = (0.64999997615814208984375 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _211 = in.in_var_PRIMITIVE_ID * 36u;
    uint _212 = _211 + 20u;
    float _261;
    float _262;
    float _263;
    float3 _264;
    float3 _265;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _212)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _230 = ((_181.xy / float2(_181.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _234 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _230, level(0.0));
        float4 _237 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _230, level(0.0));
        float4 _240 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _230, level(0.0));
        float _250 = _240.w;
        _261 = (_210 * _250) + _240.z;
        _262 = (0.5 * _250) + _240.y;
        _263 = _250 + _240.x;
        _264 = (float3(0.180000007152557373046875) * _234.w) + _234.xyz;
        _265 = normalize((_199 * _237.w) + ((_237.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _261 = _210;
        _262 = 0.5;
        _263 = 1.0;
        _264 = float3(0.180000007152557373046875);
        _265 = _199;
    }
    float4 _268 = float4(0.0);
    _268.x = 1.0;
    float4 _269 = _268;
    _269.y = 0.0;
    float3 _283 = ((_264 - (_264 * _263)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _290 = (mix(float3(0.07999999821186065673828125 * _262), _264, float3(_263)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _293 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _298;
    if (_293)
    {
        _298 = _283 + (_290 * 0.449999988079071044921875);
    }
    else
    {
        _298 = _283;
    }
    float3 _300 = select(_290, float3(0.0), bool3(_293));
    float3 _302 = float3(dot(_300, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _317 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _322 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _317);
    float4 _324 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_317 + float2(0.0, 0.5)));
    uint _330 = in.in_var_LIGHTMAP_ID * 15u;
    uint _331 = _330 + 4u;
    uint _336 = _330 + 6u;
    float3 _341 = _322.xyz;
    float3 _369 = ((((_341 * _341) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _331)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _336)].xyz) * ((exp2(((_322.w + ((_324.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _331)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _336)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_324 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _330 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _330 + 7u)], float4(_265.yzx, 1.0))))) * View.View_IndirectLightingColorScale;
    float3 _391 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _420;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _419;
        if (any(abs(_191 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _211 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _211 + 19u)].xyz + float3(1.0))))
        {
            _419 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_191, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
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
    float4 _427 = float4(((mix(float3(0.0), _298 + (_300 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_369 * _298) * fast::max(float3(1.0), ((((((_264 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_264 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_264 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _420) * 1.0, 0.0);
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
    float3 _446 = (_265 * 0.5) + float3(0.5);
    float4 _448 = float4(_446.x, _446.y, _446.z, float4(0.0).w);
    _448.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _212)].y;
    float4 _449 = float4(0.0);
    _449.x = _263;
    float4 _450 = _449;
    _450.y = _262;
    float4 _451 = _450;
    _451.z = fast::clamp(_261, 0.0, 0.996078431606292724609375);
    float4 _452 = _451;
    _452.w = 0.768627464771270751953125;
    float4 _464 = float4(_264.x, _264.y, _264.z, float4(0.0).w);
    _464.w = ((log2(((dot(_369, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_302 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_302 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_302 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_438.xyx * _438.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _434 * View.View_PreExposure;
    out.out_var_SV_Target1 = _448;
    out.out_var_SV_Target2 = _452;
    out.out_var_SV_Target3 = _464;
    out.out_var_SV_Target4 = _269;
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

