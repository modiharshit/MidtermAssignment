

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
    char _m11_pad[36];
    float View_GameTime;
    char _m12_pad[8];
    float View_MaterialTextureMipBias;
    char _m13_pad[28];
    float View_UnlitViewmodeMask;
    char _m14_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m15_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m16_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m18_pad[124];
    float View_ShowDecalsMask;
    char _m19_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_Material
{
    spvUnsafeArray<float4, 6> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float3 _154 = {};
constant float _155 = {};

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

fragment MainPS_out Main_000040d2_26a0b8ec(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], texture2d<float> LightmapResourceCluster_StaticShadowTexture [[texture(5)]], texture2d<float> Material_Texture2D_0 [[texture(6)]], texture2d<float> Material_Texture2D_1 [[texture(7)]], texture2d<float> Material_Texture2D_2 [[texture(8)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float3x3 _199 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _210 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _155, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _215 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _219 = _215.xyz / float3(_215.w);
    float3 _220 = _219 - View.View_PreViewTranslation;
    float4 _229 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _235 = ((normalize(-_219) * _199).xy * ((0.0500000007450580596923828125 * _229.z) + (-0.02500000037252902984619140625))) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _239 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _235, bias(View.View_MaterialTextureMipBias));
    float2 _242 = (_239.xy * float2(2.0)) - float2(1.0);
    float3 _258 = normalize(_199 * normalize((float4(_242, sqrt(fast::clamp(1.0 - dot(_242, _242), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _260 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _235, bias(View.View_MaterialTextureMipBias));
    float _273 = _260.y;
    float4 _285 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _293 = fast::clamp(float3(mix(0.25, 0.4000000059604644775390625, _285.x) * 0.25), float3(0.0), float3(1.0));
    float _298 = (fast::clamp(fast::min(fast::max(0.25 + _273, 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _299 = in.in_var_PRIMITIVE_ID * 36u;
    uint _300 = _299 + 20u;
    float _348;
    float _349;
    float _350;
    float3 _351;
    float3 _352;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _300)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _318 = ((_210.xy / float2(_210.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _322 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _318, level(0.0));
        float4 _325 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _318, level(0.0));
        float4 _328 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _318, level(0.0));
        float _338 = _328.w;
        _348 = (_298 * _338) + _328.z;
        _349 = (0.5 * _338) + _328.y;
        _350 = _328.x;
        _351 = (_293 * _322.w) + _322.xyz;
        _352 = normalize((_258 * _325.w) + ((_325.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _348 = _298;
        _349 = 0.5;
        _350 = 0.0;
        _351 = _293;
        _352 = _258;
    }
    float4 _359 = LightmapResourceCluster_StaticShadowTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.zw);
    uint _360 = in.in_var_LIGHTMAP_ID * 15u;
    uint _361 = _360 + 1u;
    float4 _368 = fast::clamp((_359 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _361)]) + ((View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _361)] * (-0.5)) + float4(0.5)), float4(0.0), float4(1.0));
    float3 _385 = ((_351 - (_351 * _350)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _392 = (mix(float3(0.07999999821186065673828125 * _349), _351, float3(_350)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _395 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _400;
    if (_395)
    {
        _400 = _385 + (_392 * 0.449999988079071044921875);
    }
    else
    {
        _400 = _385;
    }
    float3 _402 = select(_392, float3(0.0), bool3(_395));
    float3 _404 = float3(dot(_402, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _419 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _423 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _419);
    float4 _425 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_419 + float2(0.0, 0.5)));
    uint _431 = _360 + 4u;
    uint _436 = _360 + 6u;
    float3 _441 = _423.xyz;
    float _493;
    float _494;
    float3 _495;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _477 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _481 = _477.w;
        float _482 = _481 * _481;
        float3 _484 = normalize(((_477.xyz * 2.0) - float3(1.0)).xyz);
        float _485 = 1.0 - _482;
        float _487 = 1.0 - (_485 * _485);
        _493 = mix(fast::clamp(dot(_484, _352), 0.0, 1.0), 1.0, _487);
        _494 = _482;
        _495 = mix(_484, _352, float3(_487));
    }
    else
    {
        _493 = 1.0;
        _494 = 1.0;
        _495 = _352;
    }
    float4 _499 = float4(_495, 1.0);
    float3 _503 = _154;
    _503.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _499);
    float3 _507 = _503;
    _507.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _499);
    float3 _511 = _507;
    _511.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _499);
    float4 _514 = _499.xyzz * _499.yzzx;
    float3 _518 = _154;
    _518.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _514);
    float3 _522 = _518;
    _522.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _514);
    float3 _526 = _522;
    _526.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _514);
    float3 _541 = (((((_441 * _441) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _431)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _436)].xyz) * ((exp2(((_423.w + ((_425.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _431)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _436)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_425 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _360 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _360 + 7u)], float4(_352.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_511 + _526) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_495.x * _495.x) - (_495.y * _495.y)))) * View.View_SkyLightColor.xyz) * (_494 * _493));
    float3 _563 = fast::max(mix(mix(Material.Material_VectorExpressions[3].xyz, Material.Material_VectorExpressions[4].xyz, float3(sin(View.View_GameTime * 1.57079637050628662109375))) * _273, Material.Material_VectorExpressions[5].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _592;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _591;
        if (any(abs(_220 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _299 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _299 + 19u)].xyz + float3(1.0))))
        {
            _591 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_220, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _591 = _563;
        }
        _592 = _591;
    }
    else
    {
        _592 = _563;
    }
    float4 _599 = float4(((mix(float3(0.0), _400 + (_402 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_541 * _400) * fast::max(float3(1.0), ((((((_351 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_351 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_351 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _592) * 1.0, 0.0);
    float4 _606;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _605 = _599;
        _605.w = 0.0;
        _606 = _605;
    }
    else
    {
        _606 = _599;
    }
    float2 _610 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _618 = (_352 * 0.5) + float3(0.5);
    float4 _620 = float4(_618.x, _618.y, _618.z, float4(0.0).w);
    _620.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _300)].y;
    float4 _621 = float4(0.0);
    _621.x = _350;
    float4 _622 = _621;
    _622.y = _349;
    float4 _623 = _622;
    _623.z = _348;
    float4 _624 = _623;
    _624.w = 0.50588238239288330078125;
    float4 _636 = float4(_351.x, _351.y, _351.z, float4(0.0).w);
    _636.w = ((log2(((dot(_541, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_404 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_404 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_404 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_610.xyx * _610.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _606 * View.View_PreExposure;
    out.out_var_SV_Target1 = _620;
    out.out_var_SV_Target2 = _624;
    out.out_var_SV_Target3 = _636;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = (View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _360)] * _368) * _368;
    return out;
}

