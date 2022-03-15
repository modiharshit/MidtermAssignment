

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

constant float _143 = {};

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

fragment MainPS_out Main_00003401_0084082c(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> Material_Texture2D_0 [[texture(4)]], texture2d<float> Material_Texture2D_1 [[texture(5)]], texture2d<float> Material_Texture2D_2 [[texture(6)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    float4 _196 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _143, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _201 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _206 = (_201.xyz / float3(_201.w)) - View.View_PreViewTranslation;
    float4 _212 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _215 = (_212.xy * float2(2.0)) - float2(1.0);
    float3 _231 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_215, sqrt(fast::clamp(1.0 - dot(_215, _215), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _243 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _248 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _253 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _257 = (_243.x + 0.5) * ((_248.x + 0.5) * (_253.x + 0.5));
    float4 _263 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _269 = fast::clamp(mix(float3(0.5), float3(1.0), float3(_257)) * _263.xyz, float3(0.0), float3(1.0));
    float _274 = (fast::clamp(mix(0.800000011920928955078125, 0.4000000059604644775390625, _257 * _263.w), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _275 = in.in_var_PRIMITIVE_ID * 36u;
    uint _276 = _275 + 20u;
    float _324;
    float _325;
    float _326;
    float3 _327;
    float3 _328;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _276)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _294 = ((_196.xy / float2(_196.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _298 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _294, level(0.0));
        float4 _301 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _294, level(0.0));
        float4 _304 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _294, level(0.0));
        float _314 = _304.w;
        _324 = (_274 * _314) + _304.z;
        _325 = (0.5 * _314) + _304.y;
        _326 = _304.x;
        _327 = (_269 * _298.w) + _298.xyz;
        _328 = normalize((_231 * _301.w) + ((_301.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _324 = _274;
        _325 = 0.5;
        _326 = 0.0;
        _327 = _269;
        _328 = _231;
    }
    float3 _343 = ((_327 - (_327 * _326)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _350 = (mix(float3(0.07999999821186065673828125 * _325), _327, float3(_326)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _353 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _358;
    if (_353)
    {
        _358 = _343 + (_350 * 0.449999988079071044921875);
    }
    else
    {
        _358 = _343;
    }
    float3 _360 = select(_350, float3(0.0), bool3(_353));
    float3 _362 = float3(dot(_360, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _377 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _382 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _377);
    float4 _384 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_377 + float2(0.0, 0.5)));
    uint _386 = in.in_var_LIGHTMAP_ID * 15u;
    float3 _396 = (_382.xyz * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _386 + 4u)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _386 + 6u)].xyz;
    float _397 = dot(_396, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float _416 = (exp2((_397 * 16.0) - 8.0) - 0.00390625) * fast::max(0.0, dot((_384 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _386 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _386 + 7u)], float4(_328.yzx, 1.0)));
    float3 _426 = float4(_396 * (_416 / _397), _416).xyz * View.View_IndirectLightingColorScale;
    float3 _448 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _477;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _476;
        if (any(abs(_206 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _275 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _275 + 19u)].xyz + float3(1.0))))
        {
            _476 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_206, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _476 = _448;
        }
        _477 = _476;
    }
    else
    {
        _477 = _448;
    }
    float4 _484 = float4(((mix(float3(0.0), _358 + (_360 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_426 * _358) * fast::max(float3(1.0), ((((((_327 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_327 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_327 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _477) * 1.0, 0.0);
    float4 _491;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _490 = _484;
        _490.w = 0.0;
        _491 = _490;
    }
    else
    {
        _491 = _484;
    }
    float2 _495 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _503 = (_328 * 0.5) + float3(0.5);
    float4 _505 = float4(_503.x, _503.y, _503.z, float4(0.0).w);
    _505.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _276)].y;
    float4 _506 = float4(0.0);
    _506.x = _326;
    float4 _507 = _506;
    _507.y = _325;
    float4 _508 = _507;
    _508.z = _324;
    float4 _509 = _508;
    _509.w = 0.75686275959014892578125;
    float4 _521 = float4(_327.x, _327.y, _327.z, float4(0.0).w);
    _521.w = ((log2(((dot(_426, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_362 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_362 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_362 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_495.xyx * _495.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _491 * View.View_PreExposure;
    out.out_var_SV_Target1 = _505;
    out.out_var_SV_Target2 = _509;
    out.out_var_SV_Target3 = _521;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

