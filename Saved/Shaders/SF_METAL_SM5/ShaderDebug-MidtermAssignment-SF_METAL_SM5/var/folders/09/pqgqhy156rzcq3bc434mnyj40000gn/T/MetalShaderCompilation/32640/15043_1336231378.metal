

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

constant float3 _147 = {};
constant float _148 = {};

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

fragment MainPS_out Main_00003ac3_4fa545d2(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> Material_Texture2D_0 [[texture(4)]], texture2d<float> Material_Texture2D_1 [[texture(5)]], texture2d<float> Material_Texture2D_2 [[texture(6)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _202 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _148, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _207 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _212 = (_207.xyz / float3(_207.w)) - View.View_PreViewTranslation;
    float4 _218 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _221 = (_218.xy * float2(2.0)) - float2(1.0);
    float _228 = sqrt(fast::clamp(1.0 - dot(_221, _221), 0.0, 1.0)) + 1.0;
    float4 _231 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 2.0), bias(View.View_MaterialTextureMipBias));
    float2 _234 = (_231.xy * float2(2.0)) - float2(1.0);
    float3 _243 = float4(_234, sqrt(fast::clamp(1.0 - dot(_234, _234), 0.0, 1.0)), 1.0).xyz * float3(-1.0, -1.0, 1.0);
    float3 _246 = float3(_221, _228);
    float3 _250 = float3(_243.xy * (-1.0), _243.z);
    float3 _262 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((((_246 * dot(_246, _250)) - (_250 * _228)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _274 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _279 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.02999999932944774627685546875), bias(View.View_MaterialTextureMipBias));
    float4 _288 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _292 = fast::clamp(mix(float3(0.5), float3(1.0), float3((_274.x + 0.5) * (_279.x + 0.5))) * _288.xyz, float3(0.0), float3(1.0));
    float _293 = fast::clamp(_288.w, 0.0, 1.0);
    float _297 = (0.980000019073486328125 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _298 = in.in_var_PRIMITIVE_ID * 36u;
    uint _299 = _298 + 20u;
    float _347;
    float _348;
    float _349;
    float3 _350;
    float3 _351;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _299)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _317 = ((_202.xy / float2(_202.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _321 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _317, level(0.0));
        float4 _324 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _317, level(0.0));
        float4 _327 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _317, level(0.0));
        float _337 = _327.w;
        _347 = (_297 * _337) + _327.z;
        _348 = (_293 * _337) + _327.y;
        _349 = _327.x;
        _350 = (_292 * _321.w) + _321.xyz;
        _351 = normalize((_262 * _324.w) + ((_324.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _347 = _297;
        _348 = _293;
        _349 = 0.0;
        _350 = _292;
        _351 = _262;
    }
    float3 _366 = ((_350 - (_350 * _349)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _373 = (mix(float3(0.07999999821186065673828125 * _348), _350, float3(_349)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _376 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _381;
    if (_376)
    {
        _381 = _366 + (_373 * 0.449999988079071044921875);
    }
    else
    {
        _381 = _366;
    }
    float3 _383 = select(_373, float3(0.0), bool3(_376));
    float3 _385 = float3(dot(_383, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _400 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _405 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _400);
    float4 _407 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_400 + float2(0.0, 0.5)));
    uint _409 = in.in_var_LIGHTMAP_ID * 15u;
    float3 _419 = (_405.xyz * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _409 + 4u)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _409 + 6u)].xyz;
    float _420 = dot(_419, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float _439 = (exp2((_420 * 16.0) - 8.0) - 0.00390625) * fast::max(0.0, dot((_407 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _409 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _409 + 7u)], float4(_351.yzx, 1.0)));
    float4 _450 = float4(_351, 1.0);
    float3 _454 = _147;
    _454.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _450);
    float3 _458 = _454;
    _458.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _450);
    float3 _462 = _458;
    _462.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _450);
    float4 _465 = _450.xyzz * _450.yzzx;
    float3 _469 = _147;
    _469.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _465);
    float3 _473 = _469;
    _473.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _465);
    float3 _477 = _473;
    _477.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _465);
    float3 _491 = (float4(_419 * (_439 / _420), _439).xyz * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_462 + _477) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_351.x * _351.x) - (_351.y * _351.y)))) * View.View_SkyLightColor.xyz) * 1.0);
    float3 _513 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _542;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _541;
        if (any(abs(_212 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _298 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _298 + 19u)].xyz + float3(1.0))))
        {
            _541 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_212, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _541 = _513;
        }
        _542 = _541;
    }
    else
    {
        _542 = _513;
    }
    float4 _549 = float4(((mix(float3(0.0), _381 + (_383 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_491 * _381) * fast::max(float3(1.0), ((((((_350 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_350 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_350 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _542) * 1.0, 0.0);
    float4 _556;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _555 = _549;
        _555.w = 0.0;
        _556 = _555;
    }
    else
    {
        _556 = _549;
    }
    float2 _560 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _568 = (_351 * 0.5) + float3(0.5);
    float4 _570 = float4(_568.x, _568.y, _568.z, float4(0.0).w);
    _570.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _299)].y;
    float4 _571 = float4(0.0);
    _571.x = _349;
    float4 _572 = _571;
    _572.y = _348;
    float4 _573 = _572;
    _573.z = _347;
    float4 _574 = _573;
    _574.w = 0.75686275959014892578125;
    float4 _586 = float4(_350.x, _350.y, _350.z, float4(0.0).w);
    _586.w = ((log2(((dot(_491, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_385 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_385 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_385 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_560.xyx * _560.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _556 * View.View_PreExposure;
    out.out_var_SV_Target1 = _570;
    out.out_var_SV_Target2 = _574;
    out.out_var_SV_Target3 = _586;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

