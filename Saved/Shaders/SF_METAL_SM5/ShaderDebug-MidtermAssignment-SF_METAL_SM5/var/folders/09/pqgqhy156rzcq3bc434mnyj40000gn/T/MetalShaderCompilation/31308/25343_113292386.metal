

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

constant float3 _180 = {};
constant float _195 = {};

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

fragment MainPS_out Main_000062ff_06c0b462(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float3x3 _239 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _250 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _195, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _255 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _259 = _255.xyz / float3(_255.w);
    float3 _260 = _259 - View.View_PreViewTranslation;
    float4 _268 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _271 = (_268.xy * float2(2.0)) - float2(1.0);
    float2 _280 = (normalize(-_259) * _239).xy;
    float2 _282 = (_280 * (-0.00310000008903443813323974609375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _284 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _282, bias(View.View_MaterialTextureMipBias));
    float2 _287 = (_284.xy * float2(2.0)) - float2(1.0);
    float2 _296 = (_280 * (-0.0062000001780688762664794921875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _298 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _296, bias(View.View_MaterialTextureMipBias));
    float2 _301 = (_298.xy * float2(2.0)) - float2(1.0);
    float2 _310 = (_280 * (-0.009300000034272670745849609375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _312 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _310, bias(View.View_MaterialTextureMipBias));
    float2 _315 = (_312.xy * float2(2.0)) - float2(1.0);
    float2 _324 = (_280 * (-0.012400000356137752532958984375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _326 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _324, bias(View.View_MaterialTextureMipBias));
    float2 _329 = (_326.xy * float2(2.0)) - float2(1.0);
    float2 _338 = (_280 * (-0.01549999974668025970458984375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _340 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _338, bias(View.View_MaterialTextureMipBias));
    float2 _343 = (_340.xy * float2(2.0)) - float2(1.0);
    float2 _352 = (_280 * (-0.01860000006854534149169921875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _354 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _352, bias(View.View_MaterialTextureMipBias));
    float2 _357 = (_354.xy * float2(2.0)) - float2(1.0);
    float2 _366 = (_280 * (-0.02170000039041042327880859375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _368 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _366, bias(View.View_MaterialTextureMipBias));
    float2 _371 = (_368.xy * float2(2.0)) - float2(1.0);
    float2 _380 = (_280 * (-0.02542000077664852142333984375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _382 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _380, bias(View.View_MaterialTextureMipBias));
    float2 _385 = (_382.xy * float2(2.0)) - float2(1.0);
    float2 _394 = (_280 * (-0.0291399993002414703369140625)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _396 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _394, bias(View.View_MaterialTextureMipBias));
    float2 _399 = (_396.xy * float2(2.0)) - float2(1.0);
    float2 _408 = (_280 * (-0.0340999998152256011962890625)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _410 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _408, bias(View.View_MaterialTextureMipBias));
    float2 _413 = (_410.xy * float2(2.0)) - float2(1.0);
    float2 _422 = (_280 * (-0.039680004119873046875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _424 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _422, bias(View.View_MaterialTextureMipBias));
    float2 _427 = (_424.xy * float2(2.0)) - float2(1.0);
    float4 _438 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.949999988079071044921875), bias(View.View_MaterialTextureMipBias));
    float _441 = _438.x;
    float3 _442 = float3(_441);
    float4 _445 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.89999997615814208984375), bias(View.View_MaterialTextureMipBias));
    float _447 = _445.x;
    float3 _448 = float3(_447);
    float4 _451 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.800000011920928955078125), bias(View.View_MaterialTextureMipBias));
    float _453 = _451.x;
    float3 _454 = float3(_453);
    float4 _457 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.699999988079071044921875), bias(View.View_MaterialTextureMipBias));
    float _459 = _457.x;
    float3 _460 = float3(_459);
    float4 _463 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.60000002384185791015625), bias(View.View_MaterialTextureMipBias));
    float _465 = _463.x;
    float3 _466 = float3(_465);
    float4 _469 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.5), bias(View.View_MaterialTextureMipBias));
    float _471 = _469.x;
    float3 _472 = float3(_471);
    float4 _475 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.39999997615814208984375), bias(View.View_MaterialTextureMipBias));
    float _477 = _475.x;
    float3 _478 = float3(_477);
    float4 _481 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.300000011920928955078125), bias(View.View_MaterialTextureMipBias));
    float _483 = _481.x;
    float3 _484 = float3(_483);
    float4 _487 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.2599999904632568359375), bias(View.View_MaterialTextureMipBias));
    float _489 = _487.x;
    float3 _490 = float3(_489);
    float4 _493 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.2400000095367431640625), bias(View.View_MaterialTextureMipBias));
    float _495 = _493.x;
    float3 _496 = float3(_495);
    float4 _499 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.10000002384185791015625), bias(View.View_MaterialTextureMipBias));
    float _501 = _499.x;
    float3 _502 = float3(_501);
    float3 _511 = normalize(_239 * normalize((mix(float4(_271, sqrt(fast::clamp(1.0 - dot(_271, _271), 0.0, 1.0)), 1.0).xyz, mix(float4(_287, sqrt(fast::clamp(1.0 - dot(_287, _287), 0.0, 1.0)), 1.0).xyz, mix(float4(_301, sqrt(fast::clamp(1.0 - dot(_301, _301), 0.0, 1.0)), 1.0).xyz, mix(float4(_315, sqrt(fast::clamp(1.0 - dot(_315, _315), 0.0, 1.0)), 1.0).xyz, mix(float4(_329, sqrt(fast::clamp(1.0 - dot(_329, _329), 0.0, 1.0)), 1.0).xyz, mix(float4(_343, sqrt(fast::clamp(1.0 - dot(_343, _343), 0.0, 1.0)), 1.0).xyz, mix(float4(_357, sqrt(fast::clamp(1.0 - dot(_357, _357), 0.0, 1.0)), 1.0).xyz, mix(float4(_371, sqrt(fast::clamp(1.0 - dot(_371, _371), 0.0, 1.0)), 1.0).xyz, mix(float4(_385, sqrt(fast::clamp(1.0 - dot(_385, _385), 0.0, 1.0)), 1.0).xyz, mix(float4(_399, sqrt(fast::clamp(1.0 - dot(_399, _399), 0.0, 1.0)), 1.0).xyz, mix(float4(_413, sqrt(fast::clamp(1.0 - dot(_413, _413), 0.0, 1.0)), 1.0).xyz, float4(_427, sqrt(fast::clamp(1.0 - dot(_427, _427), 0.0, 1.0)), 1.0).xyz, _442), _448), _454), _460), _466), _472), _478), _484), _490), _496), _502) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _522 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _532 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_282 * Material.Material_ScalarExpressions[0].y) + float2(0.800000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float4 _542 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_296 * Material.Material_ScalarExpressions[0].y) + float2(0.699999988079071044921875)), bias(View.View_MaterialTextureMipBias));
    float4 _552 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_310 * Material.Material_ScalarExpressions[0].y) + float2(0.60000002384185791015625)), bias(View.View_MaterialTextureMipBias));
    float4 _562 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_324 * Material.Material_ScalarExpressions[0].y) + float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float4 _568 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_338 * Material.Material_ScalarExpressions[0].y) + float2(0.4000000059604644775390625)), bias(View.View_MaterialTextureMipBias));
    float4 _574 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_352 * Material.Material_ScalarExpressions[0].y) + float2(0.300000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float4 _580 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_366 * Material.Material_ScalarExpressions[0].y) + float2(0.25)), bias(View.View_MaterialTextureMipBias));
    float4 _586 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_380 * Material.Material_ScalarExpressions[0].y) + float2(0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float4 _592 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_394 * Material.Material_ScalarExpressions[0].y) + float2(0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float4 _598 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_408 * Material.Material_ScalarExpressions[0].y) + float2(-0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float4 _604 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_422 * Material.Material_ScalarExpressions[0].y) + float2(-0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float4 _608 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _422, bias(View.View_MaterialTextureMipBias));
    float4 _612 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.97500002384185791015625), bias(View.View_MaterialTextureMipBias));
    float _613 = _612.x;
    float3 _639 = fast::clamp(mix(_522.xyz * 1.0, mix((_532.xyz * 1.5) * fast::min(fast::max(0.60000002384185791015625 + _495, -0.0), 1.0), mix((_542.xyz * 1.2000000476837158203125) * fast::min(fast::max(0.60000002384185791015625 + _489, -0.0), 1.0), mix((_552.xyz * 1.0) * fast::min(fast::max(0.60000002384185791015625 + _483, -0.0), 1.0), mix(_562.xyz * 0.699999988079071044921875, mix(_568.xyz * 0.60000002384185791015625, mix(_574.xyz * 0.5, mix(_580.xyz * 0.4000000059604644775390625, mix(_586.xyz * 0.300000011920928955078125, mix(_592.xyz * 0.20000000298023223876953125, mix(_598.xyz * 0.1500000059604644775390625, mix(_604.xyz * 0.13799999654293060302734375, _608.xyz * 0.300000011920928955078125, float3(_613)), _442), _448), _454), _460), _466), _472), _478), _484), _490), _496), _502), float3(0.0), float3(1.0));
    float _644 = (fast::clamp(mix(0.60000002384185791015625, 0.800000011920928955078125, ((((((((((_613 * _441) * _447) * _453) * _459) * _465) * _471) * _477) * _483) * _489) * _495) * _501), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _645 = in.in_var_PRIMITIVE_ID * 36u;
    uint _646 = _645 + 20u;
    float _694;
    float _695;
    float _696;
    float3 _697;
    float3 _698;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _646)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _664 = ((_250.xy / float2(_250.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _668 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _664, level(0.0));
        float4 _671 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _664, level(0.0));
        float4 _674 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _664, level(0.0));
        float _684 = _674.w;
        _694 = (_644 * _684) + _674.z;
        _695 = (0.4000000059604644775390625 * _684) + _674.y;
        _696 = _674.x;
        _697 = (_639 * _668.w) + _668.xyz;
        _698 = normalize((_511 * _671.w) + ((_671.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _694 = _644;
        _695 = 0.4000000059604644775390625;
        _696 = 0.0;
        _697 = _639;
        _698 = _511;
    }
    float3 _713 = ((_697 - (_697 * _696)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _720 = (mix(float3(0.07999999821186065673828125 * _695), _697, float3(_696)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _723 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _728;
    if (_723)
    {
        _728 = _713 + (_720 * 0.449999988079071044921875);
    }
    else
    {
        _728 = _713;
    }
    float3 _730 = select(_720, float3(0.0), bool3(_723));
    float3 _732 = float3(dot(_730, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _747 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _752 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _747);
    float4 _754 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_747 + float2(0.0, 0.5)));
    uint _760 = in.in_var_LIGHTMAP_ID * 15u;
    uint _761 = _760 + 4u;
    uint _766 = _760 + 6u;
    float3 _771 = _752.xyz;
    float _823;
    float _824;
    float3 _825;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _807 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _811 = _807.w;
        float _812 = _811 * _811;
        float3 _814 = normalize(((_807.xyz * 2.0) - float3(1.0)).xyz);
        float _815 = 1.0 - _812;
        float _817 = 1.0 - (_815 * _815);
        _823 = mix(fast::clamp(dot(_814, _698), 0.0, 1.0), 1.0, _817);
        _824 = _812;
        _825 = mix(_814, _698, float3(_817));
    }
    else
    {
        _823 = 1.0;
        _824 = 1.0;
        _825 = _698;
    }
    float4 _829 = float4(_825, 1.0);
    float3 _833 = _180;
    _833.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _829);
    float3 _837 = _833;
    _837.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _829);
    float3 _841 = _837;
    _841.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _829);
    float4 _844 = _829.xyzz * _829.yzzx;
    float3 _848 = _180;
    _848.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _844);
    float3 _852 = _848;
    _852.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _844);
    float3 _856 = _852;
    _856.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _844);
    float3 _871 = (((((_771 * _771) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _761)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _766)].xyz) * ((exp2(((_752.w + ((_754.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _761)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _766)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_754 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _760 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _760 + 7u)], float4(_698.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_841 + _856) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_825.x * _825.x) - (_825.y * _825.y)))) * View.View_SkyLightColor.xyz) * (_824 * _823));
    float3 _893 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _922;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _921;
        if (any(abs(_260 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _645 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _645 + 19u)].xyz + float3(1.0))))
        {
            _921 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_260, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _921 = _893;
        }
        _922 = _921;
    }
    else
    {
        _922 = _893;
    }
    float4 _929 = float4(((mix(float3(0.0), _728 + (_730 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_871 * _728) * fast::max(float3(1.0), ((((((_697 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_697 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_697 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _922) * 1.0, 0.0);
    float4 _936;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _935 = _929;
        _935.w = 0.0;
        _936 = _935;
    }
    else
    {
        _936 = _929;
    }
    float2 _940 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _948 = (_698 * 0.5) + float3(0.5);
    float4 _950 = float4(_948.x, _948.y, _948.z, float4(0.0).w);
    _950.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _646)].y;
    float4 _951 = float4(0.0);
    _951.x = _696;
    float4 _952 = _951;
    _952.y = _695;
    float4 _953 = _952;
    _953.z = _694;
    float4 _954 = _953;
    _954.w = 0.75686275959014892578125;
    float4 _966 = float4(_697.x, _697.y, _697.z, float4(0.0).w);
    _966.w = ((log2(((dot(_871, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_732 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_732 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_732 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_940.xyx * _940.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _936 * View.View_PreExposure;
    out.out_var_SV_Target1 = _950;
    out.out_var_SV_Target2 = _954;
    out.out_var_SV_Target3 = _966;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

