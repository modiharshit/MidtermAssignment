

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
    char _m15_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m17_pad[124];
    float View_ShowDecalsMask;
    char _m18_pad[184];
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

constant float3 _148 = {};
constant float _149 = {};

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

fragment MainPS_out Main_00003e7f_47e586b4(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], texture2d<float> LightmapResourceCluster_StaticShadowTexture [[texture(5)]], texture2d<float> Material_Texture2D_0 [[texture(6)]], texture2d<float> Material_Texture2D_1 [[texture(7)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _204 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _149, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _209 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _214 = (_209.xyz / float3(_209.w)) - View.View_PreViewTranslation;
    float4 _220 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _223 = (_220.xy * float2(2.0)) - float2(1.0);
    float3 _239 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_223, sqrt(fast::clamp(1.0 - dot(_223, _223), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _250 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _257 = _250.y;
    float3 _272 = fast::clamp(mix(Material.Material_VectorExpressions[4].xyz, Material.Material_VectorExpressions[5].xyz, float3(_257)) * _250.x, float3(0.0), float3(1.0));
    float _273 = fast::clamp(mix(Material.Material_ScalarExpressions[0].y, Material.Material_ScalarExpressions[0].z, _257), 0.0, 1.0);
    float _278 = (fast::clamp(mix(Material.Material_ScalarExpressions[0].w, Material.Material_ScalarExpressions[1].x, _257), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _279 = in.in_var_PRIMITIVE_ID * 36u;
    uint _280 = _279 + 20u;
    float _330;
    float _331;
    float _332;
    float3 _333;
    float3 _334;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _280)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _298 = ((_204.xy / float2(_204.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _302 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _298, level(0.0));
        float4 _305 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _298, level(0.0));
        float4 _308 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _298, level(0.0));
        float _318 = _308.w;
        _330 = (_278 * _318) + _308.z;
        _331 = (0.5 * _318) + _308.y;
        _332 = (_273 * _318) + _308.x;
        _333 = (_272 * _302.w) + _302.xyz;
        _334 = normalize((_239 * _305.w) + ((_305.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _330 = _278;
        _331 = 0.5;
        _332 = _273;
        _333 = _272;
        _334 = _239;
    }
    float4 _341 = LightmapResourceCluster_StaticShadowTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.zw);
    uint _342 = in.in_var_LIGHTMAP_ID * 15u;
    uint _343 = _342 + 1u;
    float4 _350 = fast::clamp((_341 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _343)]) + ((View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _343)] * (-0.5)) + float4(0.5)), float4(0.0), float4(1.0));
    float3 _367 = ((_333 - (_333 * _332)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _374 = (mix(float3(0.07999999821186065673828125 * _331), _333, float3(_332)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _377 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _382;
    if (_377)
    {
        _382 = _367 + (_374 * 0.449999988079071044921875);
    }
    else
    {
        _382 = _367;
    }
    float3 _384 = select(_374, float3(0.0), bool3(_377));
    float3 _386 = float3(dot(_384, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _401 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _405 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _401);
    float4 _407 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_401 + float2(0.0, 0.5)));
    uint _413 = _342 + 4u;
    uint _418 = _342 + 6u;
    float3 _423 = _405.xyz;
    float _475;
    float _476;
    float3 _477;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _459 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _463 = _459.w;
        float _464 = _463 * _463;
        float3 _466 = normalize(((_459.xyz * 2.0) - float3(1.0)).xyz);
        float _467 = 1.0 - _464;
        float _469 = 1.0 - (_467 * _467);
        _475 = mix(fast::clamp(dot(_466, _334), 0.0, 1.0), 1.0, _469);
        _476 = _464;
        _477 = mix(_466, _334, float3(_469));
    }
    else
    {
        _475 = 1.0;
        _476 = 1.0;
        _477 = _334;
    }
    float4 _481 = float4(_477, 1.0);
    float3 _485 = _148;
    _485.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _481);
    float3 _489 = _485;
    _489.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _481);
    float3 _493 = _489;
    _493.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _481);
    float4 _496 = _481.xyzz * _481.yzzx;
    float3 _500 = _148;
    _500.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _496);
    float3 _504 = _500;
    _504.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _496);
    float3 _508 = _504;
    _508.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _496);
    float3 _523 = (((((_423 * _423) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _413)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _418)].xyz) * ((exp2(((_405.w + ((_407.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _413)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _418)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_407 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _342 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _342 + 7u)], float4(_334.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_493 + _508) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_477.x * _477.x) - (_477.y * _477.y)))) * View.View_SkyLightColor.xyz) * (_476 * _475));
    float3 _545 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _574;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _573;
        if (any(abs(_214 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _279 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _279 + 19u)].xyz + float3(1.0))))
        {
            _573 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_214, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _573 = _545;
        }
        _574 = _573;
    }
    else
    {
        _574 = _545;
    }
    float4 _581 = float4(((mix(float3(0.0), _382 + (_384 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_523 * _382) * fast::max(float3(1.0), ((((((_333 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_333 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_333 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _574) * 1.0, 0.0);
    float4 _588;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _587 = _581;
        _587.w = 0.0;
        _588 = _587;
    }
    else
    {
        _588 = _581;
    }
    float2 _592 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _600 = (_334 * 0.5) + float3(0.5);
    float4 _602 = float4(_600.x, _600.y, _600.z, float4(0.0).w);
    _602.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _280)].y;
    float4 _603 = float4(0.0);
    _603.x = _332;
    float4 _604 = _603;
    _604.y = _331;
    float4 _605 = _604;
    _605.z = _330;
    float4 _606 = _605;
    _606.w = 0.50588238239288330078125;
    float4 _618 = float4(_333.x, _333.y, _333.z, float4(0.0).w);
    _618.w = ((log2(((dot(_523, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_386 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_386 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_386 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_592.xyx * _592.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _588 * View.View_PreExposure;
    out.out_var_SV_Target1 = _602;
    out.out_var_SV_Target2 = _606;
    out.out_var_SV_Target3 = _618;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = (View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _342)] * _350) * _350;
    return out;
}

