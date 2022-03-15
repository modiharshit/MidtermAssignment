

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

fragment MainPS_out Main_00003e61_b00215f7(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _202 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _147, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _207 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _212 = (_207.xyz / float3(_207.w)) - View.View_PreViewTranslation;
    float4 _218 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _221 = (_218.xy * float2(2.0)) - float2(1.0);
    float _228 = sqrt(fast::clamp(1.0 - dot(_221, _221), 0.0, 1.0)) + 1.0;
    float2 _229 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 2.0;
    float4 _233 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _229, bias(View.View_MaterialTextureMipBias));
    float2 _236 = (_233.xy * float2(2.0)) - float2(1.0);
    float _240 = sqrt(fast::clamp(1.0 - dot(_236, _236), 0.0, 1.0));
    float3 _246 = float3(_221, _228);
    float3 _249 = float3(float4(_236, _240, 1.0).xy * (-1.0), _240);
    float3 _261 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((((_246 * dot(_246, _249)) - (_249 * _228)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _272 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _229, bias(View.View_MaterialTextureMipBias));
    float4 _276 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _281 = fast::clamp(_272.xyz, float3(0.0), float3(1.0));
    float _282 = fast::clamp(_276.x, 0.0, 1.0);
    float _287 = (fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _288 = in.in_var_PRIMITIVE_ID * 36u;
    uint _289 = _288 + 20u;
    float _337;
    float _338;
    float _339;
    float3 _340;
    float3 _341;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _289)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _307 = ((_202.xy / float2(_202.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _311 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _307, level(0.0));
        float4 _314 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _307, level(0.0));
        float4 _317 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _307, level(0.0));
        float _327 = _317.w;
        _337 = (_287 * _327) + _317.z;
        _338 = (0.5 * _327) + _317.y;
        _339 = _317.x;
        _340 = (_281 * _311.w) + _311.xyz;
        _341 = normalize((_261 * _314.w) + ((_314.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _337 = _287;
        _338 = 0.5;
        _339 = 0.0;
        _340 = _281;
        _341 = _261;
    }
    float3 _356 = ((_340 - (_340 * _339)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _363 = (mix(float3(0.07999999821186065673828125 * _338), _340, float3(_339)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _366 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _371;
    if (_366)
    {
        _371 = _356 + (_363 * 0.449999988079071044921875);
    }
    else
    {
        _371 = _356;
    }
    float3 _373 = select(_363, float3(0.0), bool3(_366));
    float3 _375 = float3(dot(_373, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _382 = float3(_282);
    float2 _391 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _396 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _391);
    float4 _398 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_391 + float2(0.0, 0.5)));
    uint _404 = in.in_var_LIGHTMAP_ID * 15u;
    uint _405 = _404 + 4u;
    uint _410 = _404 + 6u;
    float3 _415 = _396.xyz;
    float _467;
    float _468;
    float3 _469;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _451 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _455 = _451.w;
        float _456 = _455 * _455;
        float3 _458 = normalize(((_451.xyz * 2.0) - float3(1.0)).xyz);
        float _459 = 1.0 - _456;
        float _461 = 1.0 - (_459 * _459);
        _467 = mix(fast::clamp(dot(_458, _341), 0.0, 1.0), 1.0, _461);
        _468 = _456;
        _469 = mix(_458, _341, float3(_461));
    }
    else
    {
        _467 = 1.0;
        _468 = 1.0;
        _469 = _341;
    }
    float4 _473 = float4(_469, 1.0);
    float3 _477 = _146;
    _477.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _473);
    float3 _481 = _477;
    _481.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _473);
    float3 _485 = _481;
    _485.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _473);
    float4 _488 = _473.xyzz * _473.yzzx;
    float3 _492 = _146;
    _492.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _488);
    float3 _496 = _492;
    _496.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _488);
    float3 _500 = _496;
    _500.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _488);
    float3 _515 = (((((_415 * _415) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _405)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _410)].xyz) * ((exp2(((_396.w + ((_398.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _405)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _410)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_398 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _404 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _404 + 7u)], float4(_341.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_485 + _500) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_469.x * _469.x) - (_469.y * _469.y)))) * View.View_SkyLightColor.xyz) * (_468 * _467));
    float3 _537 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _566;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _565;
        if (any(abs(_212 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _288 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _288 + 19u)].xyz + float3(1.0))))
        {
            _565 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_212, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _565 = _537;
        }
        _566 = _565;
    }
    else
    {
        _566 = _537;
    }
    float4 _573 = float4(((mix(float3(0.0), _371 + (_373 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_515 * _371) * fast::max(_382, ((((((_340 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _282) + ((_340 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _282) + ((_340 * 2.755199909210205078125) + float3(0.69029998779296875))) * _282))) + _566) * 1.0, 0.0);
    float4 _580;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _579 = _573;
        _579.w = 0.0;
        _580 = _579;
    }
    else
    {
        _580 = _573;
    }
    float2 _584 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _592 = (_341 * 0.5) + float3(0.5);
    float4 _594 = float4(_592.x, _592.y, _592.z, float4(0.0).w);
    _594.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _289)].y;
    float4 _595 = float4(0.0);
    _595.x = _339;
    float4 _596 = _595;
    _596.y = _338;
    float4 _597 = _596;
    _597.z = _337;
    float4 _598 = _597;
    _598.w = 0.75686275959014892578125;
    float4 _610 = float4(_340.x, _340.y, _340.z, float4(0.0).w);
    _610.w = ((log2(((dot(_515, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_382, ((((((_375 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _282) + ((_375 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _282) + ((_375 * 2.755199909210205078125) + float3(0.69029998779296875))) * _282).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_584.xyx * _584.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _580 * View.View_PreExposure;
    out.out_var_SV_Target1 = _594;
    out.out_var_SV_Target2 = _598;
    out.out_var_SV_Target3 = _610;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

