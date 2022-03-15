

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

constant float3 _139 = {};
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

fragment MainPS_out Main_000034a3_c36faf55(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> Material_Texture2D_0 [[texture(4)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _194 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _140, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _199 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _204 = (_199.xyz / float3(_199.w)) - View.View_PreViewTranslation;
    float3 _212 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _225 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _227 = fast::clamp(_225.xyz, float3(0.0), float3(1.0));
    float _231 = (0.949999988079071044921875 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _232 = in.in_var_PRIMITIVE_ID * 36u;
    uint _233 = _232 + 20u;
    float _281;
    float _282;
    float _283;
    float3 _284;
    float3 _285;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _233)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _251 = ((_194.xy / float2(_194.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _255 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _251, level(0.0));
        float4 _258 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _251, level(0.0));
        float4 _261 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _251, level(0.0));
        float _271 = _261.w;
        _281 = (_231 * _271) + _261.z;
        _282 = (0.20000000298023223876953125 * _271) + _261.y;
        _283 = _261.x;
        _284 = (_227 * _255.w) + _255.xyz;
        _285 = normalize((_212 * _258.w) + ((_258.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _281 = _231;
        _282 = 0.20000000298023223876953125;
        _283 = 0.0;
        _284 = _227;
        _285 = _212;
    }
    float3 _300 = ((_284 - (_284 * _283)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _307 = (mix(float3(0.07999999821186065673828125 * _282), _284, float3(_283)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _310 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _315;
    if (_310)
    {
        _315 = _300 + (_307 * 0.449999988079071044921875);
    }
    else
    {
        _315 = _300;
    }
    float3 _317 = select(_307, float3(0.0), bool3(_310));
    float3 _319 = float3(dot(_317, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _334 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _339 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _334);
    float4 _341 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_334 + float2(0.0, 0.5)));
    uint _343 = in.in_var_LIGHTMAP_ID * 15u;
    float3 _353 = (_339.xyz * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _343 + 4u)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _343 + 6u)].xyz;
    float _354 = dot(_353, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float _373 = (exp2((_354 * 16.0) - 8.0) - 0.00390625) * fast::max(0.0, dot((_341 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _343 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _343 + 7u)], float4(_285.yzx, 1.0)));
    float4 _384 = float4(_285, 1.0);
    float3 _388 = _139;
    _388.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _384);
    float3 _392 = _388;
    _392.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _384);
    float3 _396 = _392;
    _396.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _384);
    float4 _399 = _384.xyzz * _384.yzzx;
    float3 _403 = _139;
    _403.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _399);
    float3 _407 = _403;
    _407.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _399);
    float3 _411 = _407;
    _411.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _399);
    float3 _425 = (float4(_353 * (_373 / _354), _373).xyz * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_396 + _411) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_285.x * _285.x) - (_285.y * _285.y)))) * View.View_SkyLightColor.xyz) * 1.0);
    float3 _447 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _476;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _475;
        if (any(abs(_204 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _232 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _232 + 19u)].xyz + float3(1.0))))
        {
            _475 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_204, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _475 = _447;
        }
        _476 = _475;
    }
    else
    {
        _476 = _447;
    }
    float4 _483 = float4(((mix(float3(0.0), _315 + (_317 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_425 * _315) * fast::max(float3(1.0), ((((((_284 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_284 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_284 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _476) * 1.0, 0.0);
    float4 _490;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _489 = _483;
        _489.w = 0.0;
        _490 = _489;
    }
    else
    {
        _490 = _483;
    }
    float2 _494 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _502 = (_285 * 0.5) + float3(0.5);
    float4 _504 = float4(_502.x, _502.y, _502.z, float4(0.0).w);
    _504.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _233)].y;
    float4 _505 = float4(0.0);
    _505.x = _283;
    float4 _506 = _505;
    _506.y = _282;
    float4 _507 = _506;
    _507.z = _281;
    float4 _508 = _507;
    _508.w = 0.75686275959014892578125;
    float4 _520 = float4(_284.x, _284.y, _284.z, float4(0.0).w);
    _520.w = ((log2(((dot(_425, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_319 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_319 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_319 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_494.xyx * _494.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _490 * View.View_PreExposure;
    out.out_var_SV_Target1 = _504;
    out.out_var_SV_Target2 = _508;
    out.out_var_SV_Target3 = _520;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

