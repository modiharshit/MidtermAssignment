

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
    spvUnsafeArray<float4, 6> Material_VectorExpressions;
    spvUnsafeArray<float4, 2> Material_ScalarExpressions;
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

fragment MainPS_out Main_000031b2_b87cc181(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> Material_Texture2D_0 [[texture(4)]], texture2d<float> Material_Texture2D_1 [[texture(5)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    float4 _193 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _140, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _198 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _203 = (_198.xyz / float3(_198.w)) - View.View_PreViewTranslation;
    float4 _209 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _212 = (_209.xy * float2(2.0)) - float2(1.0);
    float3 _228 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_212, sqrt(fast::clamp(1.0 - dot(_212, _212), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _239 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _246 = _239.y;
    float3 _261 = fast::clamp(mix(Material.Material_VectorExpressions[4].xyz, Material.Material_VectorExpressions[5].xyz, float3(_246)) * _239.x, float3(0.0), float3(1.0));
    float _262 = fast::clamp(mix(Material.Material_ScalarExpressions[0].y, Material.Material_ScalarExpressions[0].z, _246), 0.0, 1.0);
    float _267 = (fast::clamp(mix(Material.Material_ScalarExpressions[0].w, Material.Material_ScalarExpressions[1].x, _246), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _268 = in.in_var_PRIMITIVE_ID * 36u;
    uint _269 = _268 + 20u;
    float _319;
    float _320;
    float _321;
    float3 _322;
    float3 _323;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _269)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _287 = ((_193.xy / float2(_193.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _291 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _287, level(0.0));
        float4 _294 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _287, level(0.0));
        float4 _297 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _287, level(0.0));
        float _307 = _297.w;
        _319 = (_267 * _307) + _297.z;
        _320 = (0.5 * _307) + _297.y;
        _321 = (_262 * _307) + _297.x;
        _322 = (_261 * _291.w) + _291.xyz;
        _323 = normalize((_228 * _294.w) + ((_294.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _319 = _267;
        _320 = 0.5;
        _321 = _262;
        _322 = _261;
        _323 = _228;
    }
    float3 _338 = ((_322 - (_322 * _321)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _345 = (mix(float3(0.07999999821186065673828125 * _320), _322, float3(_321)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _348 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _353;
    if (_348)
    {
        _353 = _338 + (_345 * 0.449999988079071044921875);
    }
    else
    {
        _353 = _338;
    }
    float3 _355 = select(_345, float3(0.0), bool3(_348));
    float3 _357 = float3(dot(_355, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _372 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _377 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _372);
    float4 _379 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_372 + float2(0.0, 0.5)));
    uint _381 = in.in_var_LIGHTMAP_ID * 15u;
    float3 _391 = (_377.xyz * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _381 + 4u)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _381 + 6u)].xyz;
    float _392 = dot(_391, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float _411 = (exp2((_392 * 16.0) - 8.0) - 0.00390625) * fast::max(0.0, dot((_379 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _381 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _381 + 7u)], float4(_323.yzx, 1.0)));
    float3 _421 = float4(_391 * (_411 / _392), _411).xyz * View.View_IndirectLightingColorScale;
    float3 _443 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _472;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _471;
        if (any(abs(_203 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _268 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _268 + 19u)].xyz + float3(1.0))))
        {
            _471 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_203, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _471 = _443;
        }
        _472 = _471;
    }
    else
    {
        _472 = _443;
    }
    float4 _479 = float4(((mix(float3(0.0), _353 + (_355 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_421 * _353) * fast::max(float3(1.0), ((((((_322 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_322 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_322 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _472) * 1.0, 0.0);
    float4 _486;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _485 = _479;
        _485.w = 0.0;
        _486 = _485;
    }
    else
    {
        _486 = _479;
    }
    float2 _490 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _498 = (_323 * 0.5) + float3(0.5);
    float4 _500 = float4(_498.x, _498.y, _498.z, float4(0.0).w);
    _500.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _269)].y;
    float4 _501 = float4(0.0);
    _501.x = _321;
    float4 _502 = _501;
    _502.y = _320;
    float4 _503 = _502;
    _503.z = _319;
    float4 _504 = _503;
    _504.w = 0.75686275959014892578125;
    float4 _516 = float4(_322.x, _322.y, _322.z, float4(0.0).w);
    _516.w = ((log2(((dot(_421, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_357 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_357 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_357 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_490.xyx * _490.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _486 * View.View_PreExposure;
    out.out_var_SV_Target1 = _500;
    out.out_var_SV_Target2 = _504;
    out.out_var_SV_Target3 = _516;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

