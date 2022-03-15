

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

constant float _131 = {};

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

fragment MainPS_out Main_00002c62_65990442(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    float4 _180 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _131, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _185 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _190 = (_185.xyz / float3(_185.w)) - View.View_PreViewTranslation;
    float3 _198 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float _209 = (0.699999988079071044921875 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _210 = in.in_var_PRIMITIVE_ID * 36u;
    uint _211 = _210 + 20u;
    float _259;
    float _260;
    float _261;
    float3 _262;
    float3 _263;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _211)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _229 = ((_180.xy / float2(_180.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _233 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _229, level(0.0));
        float4 _236 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _229, level(0.0));
        float4 _239 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _229, level(0.0));
        float _249 = _239.w;
        _259 = (_209 * _249) + _239.z;
        _260 = (0.5 * _249) + _239.y;
        _261 = _239.x;
        _262 = (float3(0.180000007152557373046875) * _233.w) + _233.xyz;
        _263 = normalize((_198 * _236.w) + ((_236.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _259 = _209;
        _260 = 0.5;
        _261 = 0.0;
        _262 = float3(0.180000007152557373046875);
        _263 = _198;
    }
    float3 _278 = ((_262 - (_262 * _261)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _285 = (mix(float3(0.07999999821186065673828125 * _260), _262, float3(_261)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _288 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _293;
    if (_288)
    {
        _293 = _278 + (_285 * 0.449999988079071044921875);
    }
    else
    {
        _293 = _278;
    }
    float3 _295 = select(_285, float3(0.0), bool3(_288));
    float3 _297 = float3(dot(_295, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _312 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _317 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _312);
    float4 _319 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_312 + float2(0.0, 0.5)));
    uint _321 = in.in_var_LIGHTMAP_ID * 15u;
    float3 _331 = (_317.xyz * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _321 + 4u)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _321 + 6u)].xyz;
    float _332 = dot(_331, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float _351 = (exp2((_332 * 16.0) - 8.0) - 0.00390625) * fast::max(0.0, dot((_319 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _321 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _321 + 7u)], float4(_263.yzx, 1.0)));
    float3 _361 = float4(_331 * (_351 / _332), _351).xyz * View.View_IndirectLightingColorScale;
    float3 _383 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _412;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _411;
        if (any(abs(_190 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _210 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _210 + 19u)].xyz + float3(1.0))))
        {
            _411 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_190, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _411 = _383;
        }
        _412 = _411;
    }
    else
    {
        _412 = _383;
    }
    float4 _419 = float4(((mix(float3(0.0), _293 + (_295 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_361 * _293) * fast::max(float3(1.0), ((((((_262 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_262 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_262 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _412) * 1.0, 0.0);
    float4 _426;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _425 = _419;
        _425.w = 0.0;
        _426 = _425;
    }
    else
    {
        _426 = _419;
    }
    float2 _430 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _438 = (_263 * 0.5) + float3(0.5);
    float4 _440 = float4(_438.x, _438.y, _438.z, float4(0.0).w);
    _440.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _211)].y;
    float4 _441 = float4(0.0);
    _441.x = _261;
    float4 _442 = _441;
    _442.y = _260;
    float4 _443 = _442;
    _443.z = _259;
    float4 _444 = _443;
    _444.w = 0.75686275959014892578125;
    float4 _456 = float4(_262.x, _262.y, _262.z, float4(0.0).w);
    _456.w = ((log2(((dot(_361, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_297 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_297 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_297 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_430.xyx * _430.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _426 * View.View_PreExposure;
    out.out_var_SV_Target1 = _440;
    out.out_var_SV_Target2 = _444;
    out.out_var_SV_Target3 = _456;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

