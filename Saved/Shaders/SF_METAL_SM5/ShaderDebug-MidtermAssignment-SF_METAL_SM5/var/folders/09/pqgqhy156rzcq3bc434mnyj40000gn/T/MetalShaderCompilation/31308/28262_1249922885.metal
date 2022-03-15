

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
    char _m19_pad[48];
    float3 View_VolumetricLightmapWorldToUVScale;
    float3 View_VolumetricLightmapWorldToUVAdd;
    packed_float3 View_VolumetricLightmapIndirectionTextureSize;
    float View_VolumetricLightmapBrickSize;
    float3 View_VolumetricLightmapBrickTexelSize;
    float View_IndirectLightingCacheShowFlag;
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_IndirectLightingCache
{
    float3 IndirectLightingCache_IndirectLightingCachePrimitiveAdd;
    float3 IndirectLightingCache_IndirectLightingCachePrimitiveScale;
    float3 IndirectLightingCache_IndirectLightingCacheMinUV;
    float3 IndirectLightingCache_IndirectLightingCacheMaxUV;
    float4 IndirectLightingCache_PointSkyBentNormal;
    float IndirectLightingCache_DirectionalLightShadowing;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float3 _194 = {};
constant float _210 = {};
constant float4 _211 = {};

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
    uint in_var_PRIMITIVE_ID [[user(locn3)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00006e66_4a804f45(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], texture2d<float> Material_Texture2D_2 [[texture(10)]], texture2d<float> Material_Texture2D_3 [[texture(11)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], sampler Material_Texture2D_2Sampler [[sampler(5)]], sampler Material_Texture2D_3Sampler [[sampler(6)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float3x3 _257 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _268 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _210, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _273 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _277 = _273.xyz / float3(_273.w);
    float3 _278 = _277 - View.View_PreViewTranslation;
    float4 _286 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _289 = (_286.xy * float2(2.0)) - float2(1.0);
    float2 _298 = (normalize(-_277) * _257).xy;
    float2 _300 = (_298 * (-0.00310000008903443813323974609375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _302 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _300, bias(View.View_MaterialTextureMipBias));
    float2 _305 = (_302.xy * float2(2.0)) - float2(1.0);
    float2 _314 = (_298 * (-0.0062000001780688762664794921875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _316 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _314, bias(View.View_MaterialTextureMipBias));
    float2 _319 = (_316.xy * float2(2.0)) - float2(1.0);
    float2 _328 = (_298 * (-0.009300000034272670745849609375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _330 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _328, bias(View.View_MaterialTextureMipBias));
    float2 _333 = (_330.xy * float2(2.0)) - float2(1.0);
    float2 _342 = (_298 * (-0.012400000356137752532958984375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _344 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _342, bias(View.View_MaterialTextureMipBias));
    float2 _347 = (_344.xy * float2(2.0)) - float2(1.0);
    float2 _356 = (_298 * (-0.01549999974668025970458984375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _358 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _356, bias(View.View_MaterialTextureMipBias));
    float2 _361 = (_358.xy * float2(2.0)) - float2(1.0);
    float2 _370 = (_298 * (-0.01860000006854534149169921875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _372 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _370, bias(View.View_MaterialTextureMipBias));
    float2 _375 = (_372.xy * float2(2.0)) - float2(1.0);
    float2 _384 = (_298 * (-0.02170000039041042327880859375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _386 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _384, bias(View.View_MaterialTextureMipBias));
    float2 _389 = (_386.xy * float2(2.0)) - float2(1.0);
    float2 _398 = (_298 * (-0.02542000077664852142333984375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _400 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _398, bias(View.View_MaterialTextureMipBias));
    float2 _403 = (_400.xy * float2(2.0)) - float2(1.0);
    float2 _412 = (_298 * (-0.0291399993002414703369140625)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _414 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _412, bias(View.View_MaterialTextureMipBias));
    float2 _417 = (_414.xy * float2(2.0)) - float2(1.0);
    float2 _426 = (_298 * (-0.0340999998152256011962890625)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _428 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _426, bias(View.View_MaterialTextureMipBias));
    float2 _431 = (_428.xy * float2(2.0)) - float2(1.0);
    float2 _440 = (_298 * (-0.039680004119873046875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _442 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _440, bias(View.View_MaterialTextureMipBias));
    float2 _445 = (_442.xy * float2(2.0)) - float2(1.0);
    float4 _456 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.949999988079071044921875), bias(View.View_MaterialTextureMipBias));
    float _459 = _456.x;
    float3 _460 = float3(_459);
    float4 _463 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.89999997615814208984375), bias(View.View_MaterialTextureMipBias));
    float _465 = _463.x;
    float3 _466 = float3(_465);
    float4 _469 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.800000011920928955078125), bias(View.View_MaterialTextureMipBias));
    float _471 = _469.x;
    float3 _472 = float3(_471);
    float4 _475 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.699999988079071044921875), bias(View.View_MaterialTextureMipBias));
    float _477 = _475.x;
    float3 _478 = float3(_477);
    float4 _481 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.60000002384185791015625), bias(View.View_MaterialTextureMipBias));
    float _483 = _481.x;
    float3 _484 = float3(_483);
    float4 _487 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.5), bias(View.View_MaterialTextureMipBias));
    float _489 = _487.x;
    float3 _490 = float3(_489);
    float4 _493 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.39999997615814208984375), bias(View.View_MaterialTextureMipBias));
    float _495 = _493.x;
    float3 _496 = float3(_495);
    float4 _499 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.300000011920928955078125), bias(View.View_MaterialTextureMipBias));
    float _501 = _499.x;
    float3 _502 = float3(_501);
    float4 _505 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.2599999904632568359375), bias(View.View_MaterialTextureMipBias));
    float _507 = _505.x;
    float3 _508 = float3(_507);
    float4 _511 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.2400000095367431640625), bias(View.View_MaterialTextureMipBias));
    float _513 = _511.x;
    float3 _514 = float3(_513);
    float4 _517 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.10000002384185791015625), bias(View.View_MaterialTextureMipBias));
    float _519 = _517.x;
    float3 _520 = float3(_519);
    float3 _529 = normalize(_257 * normalize((mix(float4(_289, sqrt(fast::clamp(1.0 - dot(_289, _289), 0.0, 1.0)), 1.0).xyz, mix(float4(_305, sqrt(fast::clamp(1.0 - dot(_305, _305), 0.0, 1.0)), 1.0).xyz, mix(float4(_319, sqrt(fast::clamp(1.0 - dot(_319, _319), 0.0, 1.0)), 1.0).xyz, mix(float4(_333, sqrt(fast::clamp(1.0 - dot(_333, _333), 0.0, 1.0)), 1.0).xyz, mix(float4(_347, sqrt(fast::clamp(1.0 - dot(_347, _347), 0.0, 1.0)), 1.0).xyz, mix(float4(_361, sqrt(fast::clamp(1.0 - dot(_361, _361), 0.0, 1.0)), 1.0).xyz, mix(float4(_375, sqrt(fast::clamp(1.0 - dot(_375, _375), 0.0, 1.0)), 1.0).xyz, mix(float4(_389, sqrt(fast::clamp(1.0 - dot(_389, _389), 0.0, 1.0)), 1.0).xyz, mix(float4(_403, sqrt(fast::clamp(1.0 - dot(_403, _403), 0.0, 1.0)), 1.0).xyz, mix(float4(_417, sqrt(fast::clamp(1.0 - dot(_417, _417), 0.0, 1.0)), 1.0).xyz, mix(float4(_431, sqrt(fast::clamp(1.0 - dot(_431, _431), 0.0, 1.0)), 1.0).xyz, float4(_445, sqrt(fast::clamp(1.0 - dot(_445, _445), 0.0, 1.0)), 1.0).xyz, _460), _466), _472), _478), _484), _490), _496), _502), _508), _514), _520) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _540 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _550 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_300 * Material.Material_ScalarExpressions[0].y) + float2(0.800000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float4 _560 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_314 * Material.Material_ScalarExpressions[0].y) + float2(0.699999988079071044921875)), bias(View.View_MaterialTextureMipBias));
    float4 _570 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_328 * Material.Material_ScalarExpressions[0].y) + float2(0.60000002384185791015625)), bias(View.View_MaterialTextureMipBias));
    float4 _580 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_342 * Material.Material_ScalarExpressions[0].y) + float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float4 _586 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_356 * Material.Material_ScalarExpressions[0].y) + float2(0.4000000059604644775390625)), bias(View.View_MaterialTextureMipBias));
    float4 _592 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_370 * Material.Material_ScalarExpressions[0].y) + float2(0.300000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float4 _598 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_384 * Material.Material_ScalarExpressions[0].y) + float2(0.25)), bias(View.View_MaterialTextureMipBias));
    float4 _604 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_398 * Material.Material_ScalarExpressions[0].y) + float2(0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float4 _610 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_412 * Material.Material_ScalarExpressions[0].y) + float2(0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float4 _616 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_426 * Material.Material_ScalarExpressions[0].y) + float2(-0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float4 _622 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_440 * Material.Material_ScalarExpressions[0].y) + float2(-0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float4 _626 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _440, bias(View.View_MaterialTextureMipBias));
    float4 _630 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.97500002384185791015625), bias(View.View_MaterialTextureMipBias));
    float _631 = _630.x;
    float3 _657 = fast::clamp(mix(_540.xyz * 1.0, mix((_550.xyz * 1.5) * fast::min(fast::max(0.60000002384185791015625 + _513, -0.0), 1.0), mix((_560.xyz * 1.2000000476837158203125) * fast::min(fast::max(0.60000002384185791015625 + _507, -0.0), 1.0), mix((_570.xyz * 1.0) * fast::min(fast::max(0.60000002384185791015625 + _501, -0.0), 1.0), mix(_580.xyz * 0.699999988079071044921875, mix(_586.xyz * 0.60000002384185791015625, mix(_592.xyz * 0.5, mix(_598.xyz * 0.4000000059604644775390625, mix(_604.xyz * 0.300000011920928955078125, mix(_610.xyz * 0.20000000298023223876953125, mix(_616.xyz * 0.1500000059604644775390625, mix(_622.xyz * 0.13799999654293060302734375, _626.xyz * 0.300000011920928955078125, float3(_631)), _460), _466), _472), _478), _484), _490), _496), _502), _508), _514), _520), float3(0.0), float3(1.0));
    float _662 = (fast::clamp(mix(0.60000002384185791015625, 0.800000011920928955078125, ((((((((((_631 * _459) * _465) * _471) * _477) * _483) * _489) * _495) * _501) * _507) * _513) * _519), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _663 = in.in_var_PRIMITIVE_ID * 36u;
    uint _664 = _663 + 20u;
    float _712;
    float _713;
    float _714;
    float3 _715;
    float3 _716;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _664)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _682 = ((_268.xy / float2(_268.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _686 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _682, level(0.0));
        float4 _689 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _682, level(0.0));
        float4 _692 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _682, level(0.0));
        float _702 = _692.w;
        _712 = (_662 * _702) + _692.z;
        _713 = (0.4000000059604644775390625 * _702) + _692.y;
        _714 = _692.x;
        _715 = (_657 * _686.w) + _686.xyz;
        _716 = normalize((_529 * _689.w) + ((_689.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _712 = _662;
        _713 = 0.4000000059604644775390625;
        _714 = 0.0;
        _715 = _657;
        _716 = _529;
    }
    bool _726 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _732;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _663 + 18u)].w > 0.0) && _726)
    {
        _732 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _732 = 1.0;
    }
    float _779;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _664)].z > 0.0)
    {
        float3 _747 = fast::clamp((_278 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _758 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_747.x), int(_747.y), int(_747.z), 0).xyz), 0));
        _779 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_758.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_747 / float3(_758.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _779 = _732;
    }
    float3 _793 = ((_715 - (_715 * _714)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _800 = (mix(float3(0.07999999821186065673828125 * _713), _715, float3(_714)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _803 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _808;
    if (_803)
    {
        _808 = _793 + (_800 * 0.449999988079071044921875);
    }
    else
    {
        _808 = _793;
    }
    float3 _810 = select(_800, float3(0.0), bool3(_803));
    float3 _812 = float3(dot(_810, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _886;
    if (_726)
    {
        float3 _838 = fast::clamp((_278 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _842 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _838);
        float4 _846 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _838);
        float4 _849 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _838);
        float4 _867 = _211;
        _867.y = (-0.48860299587249755859375) * _716.y;
        float4 _870 = _867;
        _870.z = 0.48860299587249755859375 * _716.z;
        float4 _873 = _870;
        _873.w = (-0.48860299587249755859375) * _716.x;
        float4 _874 = _873;
        _874.x = 0.886227548122406005859375;
        float3 _876 = _874.yzw * 2.094395160675048828125;
        float4 _877 = float4(_874.x, _876.x, _876.y, _876.z);
        float3 _879 = float3(0.0);
        _879.x = dot(float4(_842.x, _846.x, _849.x, _842.w), _877);
        float3 _881 = _879;
        _881.y = dot(float4(_842.y, _846.y, _849.y, _846.w), _877);
        float3 _883 = _881;
        _883.z = dot(float4(_842.z, _846.z, _849.zw), _877);
        _886 = fast::max(float3(0.0), _883) * float3(0.3183098733425140380859375);
    }
    else
    {
        _886 = float3(0.0);
    }
    float _912;
    float _913;
    float3 _914;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _902;
        float _903;
        if (_726)
        {
            _902 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _903 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _902 = _716;
            _903 = 1.0;
        }
        float _904 = 1.0 - _903;
        float _906 = 1.0 - (_904 * _904);
        _912 = mix(fast::clamp(dot(_902, _716), 0.0, 1.0), 1.0, _906);
        _913 = _903;
        _914 = mix(_902, _716, float3(_906));
    }
    else
    {
        _912 = 1.0;
        _913 = 1.0;
        _914 = _716;
    }
    float4 _918 = float4(_914, 1.0);
    float3 _922 = _194;
    _922.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _918);
    float3 _926 = _922;
    _926.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _918);
    float3 _930 = _926;
    _930.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _918);
    float4 _933 = _918.xyzz * _918.yzzx;
    float3 _937 = _194;
    _937.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _933);
    float3 _941 = _937;
    _941.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _933);
    float3 _945 = _941;
    _945.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _933);
    float3 _960 = (_886 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_930 + _945) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_914.x * _914.x) - (_914.y * _914.y)))) * View.View_SkyLightColor.xyz) * (_913 * _912));
    float3 _982 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _1011;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _1010;
        if (any(abs(_278 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _663 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _663 + 19u)].xyz + float3(1.0))))
        {
            _1010 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_278, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _1010 = _982;
        }
        _1011 = _1010;
    }
    else
    {
        _1011 = _982;
    }
    float4 _1018 = float4(((mix(float3(0.0), _808 + (_810 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_960 * _808) * fast::max(float3(1.0), ((((((_715 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_715 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_715 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _1011) * 1.0, 0.0);
    float4 _1025;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _1024 = _1018;
        _1024.w = 0.0;
        _1025 = _1024;
    }
    else
    {
        _1025 = _1018;
    }
    float2 _1029 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _1037 = (_716 * 0.5) + float3(0.5);
    float4 _1039 = float4(_1037.x, _1037.y, _1037.z, float4(0.0).w);
    _1039.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _664)].y;
    float4 _1040 = float4(0.0);
    _1040.x = _714;
    float4 _1041 = _1040;
    _1041.y = _713;
    float4 _1042 = _1041;
    _1042.z = _712;
    float4 _1043 = _1042;
    _1043.w = 0.50588238239288330078125;
    float4 _1055 = float4(_715.x, _715.y, _715.z, float4(0.0).w);
    _1055.w = ((log2(((dot(_960, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_812 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_812 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_812 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_1029.xyx * _1029.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _1025 * View.View_PreExposure;
    out.out_var_SV_Target1 = _1039;
    out.out_var_SV_Target2 = _1043;
    out.out_var_SV_Target3 = _1055;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_779, 1.0, 1.0, 1.0);
    return out;
}

