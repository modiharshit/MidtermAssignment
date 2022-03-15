

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
    char _m15_pad[48];
    float4 View_SkyLightColor;
    char _m16_pad[124];
    float View_ShowDecalsMask;
    char _m17_pad[184];
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

constant float3 _146 = {};
constant float _147 = {};

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

fragment MainPS_out Main_000039ed_5a032c37(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> Material_Texture2D_0 [[texture(4)]], texture2d<float> Material_Texture2D_1 [[texture(5)]], texture2d<float> Material_Texture2D_2 [[texture(6)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _201 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _147, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _206 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _211 = (_206.xyz / float3(_206.w)) - View.View_PreViewTranslation;
    float4 _217 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _220 = (_217.xy * float2(2.0)) - float2(1.0);
    float3 _236 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_220, sqrt(fast::clamp(1.0 - dot(_220, _220), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _248 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _253 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _258 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _262 = (_248.x + 0.5) * ((_253.x + 0.5) * (_258.x + 0.5));
    float4 _268 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _274 = fast::clamp(mix(float3(0.800000011920928955078125), float3(1.0), float3(_262)) * _268.xyz, float3(0.0), float3(1.0));
    float _279 = (fast::clamp(mix(0.800000011920928955078125, 0.5, _262 * _268.w), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _280 = in.in_var_PRIMITIVE_ID * 36u;
    uint _281 = _280 + 20u;
    float _329;
    float _330;
    float _331;
    float3 _332;
    float3 _333;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _281)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _299 = ((_201.xy / float2(_201.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _303 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _299, level(0.0));
        float4 _306 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _299, level(0.0));
        float4 _309 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _299, level(0.0));
        float _319 = _309.w;
        _329 = (_279 * _319) + _309.z;
        _330 = (0.5 * _319) + _309.y;
        _331 = _309.x;
        _332 = (_274 * _303.w) + _303.xyz;
        _333 = normalize((_236 * _306.w) + ((_306.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _329 = _279;
        _330 = 0.5;
        _331 = 0.0;
        _332 = _274;
        _333 = _236;
    }
    float3 _348 = ((_332 - (_332 * _331)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _355 = (mix(float3(0.07999999821186065673828125 * _330), _332, float3(_331)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _358 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _363;
    if (_358)
    {
        _363 = _348 + (_355 * 0.449999988079071044921875);
    }
    else
    {
        _363 = _348;
    }
    float3 _365 = select(_355, float3(0.0), bool3(_358));
    float3 _367 = float3(dot(_365, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _382 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _387 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _382);
    float4 _389 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_382 + float2(0.0, 0.5)));
    uint _391 = in.in_var_LIGHTMAP_ID * 15u;
    float3 _401 = (_387.xyz * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _391 + 4u)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _391 + 6u)].xyz;
    float _402 = dot(_401, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float _421 = (exp2((_402 * 16.0) - 8.0) - 0.00390625) * fast::max(0.0, dot((_389 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _391 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _391 + 7u)], float4(_333.yzx, 1.0)));
    float4 _432 = float4(_333, 1.0);
    float3 _436 = _146;
    _436.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _432);
    float3 _440 = _436;
    _440.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _432);
    float3 _444 = _440;
    _444.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _432);
    float4 _447 = _432.xyzz * _432.yzzx;
    float3 _451 = _146;
    _451.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _447);
    float3 _455 = _451;
    _455.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _447);
    float3 _459 = _455;
    _459.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _447);
    float3 _473 = (float4(_401 * (_421 / _402), _421).xyz * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_444 + _459) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_333.x * _333.x) - (_333.y * _333.y)))) * View.View_SkyLightColor.xyz) * 1.0);
    float3 _495 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _524;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _523;
        if (any(abs(_211 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _280 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _280 + 19u)].xyz + float3(1.0))))
        {
            _523 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_211, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _523 = _495;
        }
        _524 = _523;
    }
    else
    {
        _524 = _495;
    }
    float4 _531 = float4(((mix(float3(0.0), _363 + (_365 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_473 * _363) * fast::max(float3(1.0), ((((((_332 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_332 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_332 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _524) * 1.0, 0.0);
    float4 _538;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _537 = _531;
        _537.w = 0.0;
        _538 = _537;
    }
    else
    {
        _538 = _531;
    }
    float2 _542 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _550 = (_333 * 0.5) + float3(0.5);
    float4 _552 = float4(_550.x, _550.y, _550.z, float4(0.0).w);
    _552.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _281)].y;
    float4 _553 = float4(0.0);
    _553.x = _331;
    float4 _554 = _553;
    _554.y = _330;
    float4 _555 = _554;
    _555.z = _329;
    float4 _556 = _555;
    _556.w = 0.75686275959014892578125;
    float4 _568 = float4(_332.x, _332.y, _332.z, float4(0.0).w);
    _568.w = ((log2(((dot(_473, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_367 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_367 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_367 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_542.xyx * _542.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _538 * View.View_PreExposure;
    out.out_var_SV_Target1 = _552;
    out.out_var_SV_Target2 = _556;
    out.out_var_SV_Target3 = _568;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

