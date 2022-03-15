

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
    char _m17_pad[48];
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
    char _m4_pad[16];
    float IndirectLightingCache_DirectionalLightShadowing;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float _206 = {};
constant float4 _207 = {};

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

fragment MainPS_out Main_000064ed_3f880b8f(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], texture2d<float> Material_Texture2D_2 [[texture(10)]], texture2d<float> Material_Texture2D_3 [[texture(11)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], sampler Material_Texture2D_2Sampler [[sampler(5)]], sampler Material_Texture2D_3Sampler [[sampler(6)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float3x3 _251 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _262 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _206, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _267 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _271 = _267.xyz / float3(_267.w);
    float3 _272 = _271 - View.View_PreViewTranslation;
    float4 _280 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _283 = (_280.xy * float2(2.0)) - float2(1.0);
    float2 _292 = (normalize(-_271) * _251).xy;
    float2 _294 = (_292 * (-0.00310000008903443813323974609375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _296 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _294, bias(View.View_MaterialTextureMipBias));
    float2 _299 = (_296.xy * float2(2.0)) - float2(1.0);
    float2 _308 = (_292 * (-0.0062000001780688762664794921875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _310 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _308, bias(View.View_MaterialTextureMipBias));
    float2 _313 = (_310.xy * float2(2.0)) - float2(1.0);
    float2 _322 = (_292 * (-0.009300000034272670745849609375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _324 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _322, bias(View.View_MaterialTextureMipBias));
    float2 _327 = (_324.xy * float2(2.0)) - float2(1.0);
    float2 _336 = (_292 * (-0.012400000356137752532958984375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _338 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _336, bias(View.View_MaterialTextureMipBias));
    float2 _341 = (_338.xy * float2(2.0)) - float2(1.0);
    float2 _350 = (_292 * (-0.01549999974668025970458984375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _352 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _350, bias(View.View_MaterialTextureMipBias));
    float2 _355 = (_352.xy * float2(2.0)) - float2(1.0);
    float2 _364 = (_292 * (-0.01860000006854534149169921875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _366 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _364, bias(View.View_MaterialTextureMipBias));
    float2 _369 = (_366.xy * float2(2.0)) - float2(1.0);
    float2 _378 = (_292 * (-0.02170000039041042327880859375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _380 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _378, bias(View.View_MaterialTextureMipBias));
    float2 _383 = (_380.xy * float2(2.0)) - float2(1.0);
    float2 _392 = (_292 * (-0.02542000077664852142333984375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _394 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _392, bias(View.View_MaterialTextureMipBias));
    float2 _397 = (_394.xy * float2(2.0)) - float2(1.0);
    float2 _406 = (_292 * (-0.0291399993002414703369140625)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _408 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _406, bias(View.View_MaterialTextureMipBias));
    float2 _411 = (_408.xy * float2(2.0)) - float2(1.0);
    float2 _420 = (_292 * (-0.0340999998152256011962890625)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _422 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _420, bias(View.View_MaterialTextureMipBias));
    float2 _425 = (_422.xy * float2(2.0)) - float2(1.0);
    float2 _434 = (_292 * (-0.039680004119873046875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _436 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _434, bias(View.View_MaterialTextureMipBias));
    float2 _439 = (_436.xy * float2(2.0)) - float2(1.0);
    float4 _450 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.949999988079071044921875), bias(View.View_MaterialTextureMipBias));
    float _453 = _450.x;
    float3 _454 = float3(_453);
    float4 _457 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.89999997615814208984375), bias(View.View_MaterialTextureMipBias));
    float _459 = _457.x;
    float3 _460 = float3(_459);
    float4 _463 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.800000011920928955078125), bias(View.View_MaterialTextureMipBias));
    float _465 = _463.x;
    float3 _466 = float3(_465);
    float4 _469 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.699999988079071044921875), bias(View.View_MaterialTextureMipBias));
    float _471 = _469.x;
    float3 _472 = float3(_471);
    float4 _475 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.60000002384185791015625), bias(View.View_MaterialTextureMipBias));
    float _477 = _475.x;
    float3 _478 = float3(_477);
    float4 _481 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.5), bias(View.View_MaterialTextureMipBias));
    float _483 = _481.x;
    float3 _484 = float3(_483);
    float4 _487 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.39999997615814208984375), bias(View.View_MaterialTextureMipBias));
    float _489 = _487.x;
    float3 _490 = float3(_489);
    float4 _493 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.300000011920928955078125), bias(View.View_MaterialTextureMipBias));
    float _495 = _493.x;
    float3 _496 = float3(_495);
    float4 _499 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.2599999904632568359375), bias(View.View_MaterialTextureMipBias));
    float _501 = _499.x;
    float3 _502 = float3(_501);
    float4 _505 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.2400000095367431640625), bias(View.View_MaterialTextureMipBias));
    float _507 = _505.x;
    float3 _508 = float3(_507);
    float4 _511 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.10000002384185791015625), bias(View.View_MaterialTextureMipBias));
    float _513 = _511.x;
    float3 _514 = float3(_513);
    float3 _523 = normalize(_251 * normalize((mix(float4(_283, sqrt(fast::clamp(1.0 - dot(_283, _283), 0.0, 1.0)), 1.0).xyz, mix(float4(_299, sqrt(fast::clamp(1.0 - dot(_299, _299), 0.0, 1.0)), 1.0).xyz, mix(float4(_313, sqrt(fast::clamp(1.0 - dot(_313, _313), 0.0, 1.0)), 1.0).xyz, mix(float4(_327, sqrt(fast::clamp(1.0 - dot(_327, _327), 0.0, 1.0)), 1.0).xyz, mix(float4(_341, sqrt(fast::clamp(1.0 - dot(_341, _341), 0.0, 1.0)), 1.0).xyz, mix(float4(_355, sqrt(fast::clamp(1.0 - dot(_355, _355), 0.0, 1.0)), 1.0).xyz, mix(float4(_369, sqrt(fast::clamp(1.0 - dot(_369, _369), 0.0, 1.0)), 1.0).xyz, mix(float4(_383, sqrt(fast::clamp(1.0 - dot(_383, _383), 0.0, 1.0)), 1.0).xyz, mix(float4(_397, sqrt(fast::clamp(1.0 - dot(_397, _397), 0.0, 1.0)), 1.0).xyz, mix(float4(_411, sqrt(fast::clamp(1.0 - dot(_411, _411), 0.0, 1.0)), 1.0).xyz, mix(float4(_425, sqrt(fast::clamp(1.0 - dot(_425, _425), 0.0, 1.0)), 1.0).xyz, float4(_439, sqrt(fast::clamp(1.0 - dot(_439, _439), 0.0, 1.0)), 1.0).xyz, _454), _460), _466), _472), _478), _484), _490), _496), _502), _508), _514) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _534 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _544 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_294 * Material.Material_ScalarExpressions[0].y) + float2(0.800000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float4 _554 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_308 * Material.Material_ScalarExpressions[0].y) + float2(0.699999988079071044921875)), bias(View.View_MaterialTextureMipBias));
    float4 _564 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_322 * Material.Material_ScalarExpressions[0].y) + float2(0.60000002384185791015625)), bias(View.View_MaterialTextureMipBias));
    float4 _574 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_336 * Material.Material_ScalarExpressions[0].y) + float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float4 _580 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_350 * Material.Material_ScalarExpressions[0].y) + float2(0.4000000059604644775390625)), bias(View.View_MaterialTextureMipBias));
    float4 _586 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_364 * Material.Material_ScalarExpressions[0].y) + float2(0.300000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float4 _592 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_378 * Material.Material_ScalarExpressions[0].y) + float2(0.25)), bias(View.View_MaterialTextureMipBias));
    float4 _598 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_392 * Material.Material_ScalarExpressions[0].y) + float2(0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float4 _604 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_406 * Material.Material_ScalarExpressions[0].y) + float2(0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float4 _610 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_420 * Material.Material_ScalarExpressions[0].y) + float2(-0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float4 _616 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_434 * Material.Material_ScalarExpressions[0].y) + float2(-0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float4 _620 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _434, bias(View.View_MaterialTextureMipBias));
    float4 _624 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.97500002384185791015625), bias(View.View_MaterialTextureMipBias));
    float _625 = _624.x;
    float3 _651 = fast::clamp(mix(_534.xyz * 1.0, mix((_544.xyz * 1.5) * fast::min(fast::max(0.60000002384185791015625 + _507, -0.0), 1.0), mix((_554.xyz * 1.2000000476837158203125) * fast::min(fast::max(0.60000002384185791015625 + _501, -0.0), 1.0), mix((_564.xyz * 1.0) * fast::min(fast::max(0.60000002384185791015625 + _495, -0.0), 1.0), mix(_574.xyz * 0.699999988079071044921875, mix(_580.xyz * 0.60000002384185791015625, mix(_586.xyz * 0.5, mix(_592.xyz * 0.4000000059604644775390625, mix(_598.xyz * 0.300000011920928955078125, mix(_604.xyz * 0.20000000298023223876953125, mix(_610.xyz * 0.1500000059604644775390625, mix(_616.xyz * 0.13799999654293060302734375, _620.xyz * 0.300000011920928955078125, float3(_625)), _454), _460), _466), _472), _478), _484), _490), _496), _502), _508), _514), float3(0.0), float3(1.0));
    float _656 = (fast::clamp(mix(0.60000002384185791015625, 0.800000011920928955078125, ((((((((((_625 * _453) * _459) * _465) * _471) * _477) * _483) * _489) * _495) * _501) * _507) * _513), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _657 = in.in_var_PRIMITIVE_ID * 36u;
    uint _658 = _657 + 20u;
    float _706;
    float _707;
    float _708;
    float3 _709;
    float3 _710;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _658)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _676 = ((_262.xy / float2(_262.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _680 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _676, level(0.0));
        float4 _683 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _676, level(0.0));
        float4 _686 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _676, level(0.0));
        float _696 = _686.w;
        _706 = (_656 * _696) + _686.z;
        _707 = (0.4000000059604644775390625 * _696) + _686.y;
        _708 = _686.x;
        _709 = (_651 * _680.w) + _680.xyz;
        _710 = normalize((_523 * _683.w) + ((_683.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _706 = _656;
        _707 = 0.4000000059604644775390625;
        _708 = 0.0;
        _709 = _651;
        _710 = _523;
    }
    bool _720 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _726;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _657 + 18u)].w > 0.0) && _720)
    {
        _726 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _726 = 1.0;
    }
    float _773;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _658)].z > 0.0)
    {
        float3 _741 = fast::clamp((_272 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _752 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_741.x), int(_741.y), int(_741.z), 0).xyz), 0));
        _773 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_752.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_741 / float3(_752.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _773 = _726;
    }
    float3 _787 = ((_709 - (_709 * _708)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _794 = (mix(float3(0.07999999821186065673828125 * _707), _709, float3(_708)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _797 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _802;
    if (_797)
    {
        _802 = _787 + (_794 * 0.449999988079071044921875);
    }
    else
    {
        _802 = _787;
    }
    float3 _804 = select(_794, float3(0.0), bool3(_797));
    float3 _806 = float3(dot(_804, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _880;
    if (_720)
    {
        float3 _832 = fast::clamp((_272 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _836 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _832);
        float4 _840 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _832);
        float4 _843 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _832);
        float4 _861 = _207;
        _861.y = (-0.48860299587249755859375) * _710.y;
        float4 _864 = _861;
        _864.z = 0.48860299587249755859375 * _710.z;
        float4 _867 = _864;
        _867.w = (-0.48860299587249755859375) * _710.x;
        float4 _868 = _867;
        _868.x = 0.886227548122406005859375;
        float3 _870 = _868.yzw * 2.094395160675048828125;
        float4 _871 = float4(_868.x, _870.x, _870.y, _870.z);
        float3 _873 = float3(0.0);
        _873.x = dot(float4(_836.x, _840.x, _843.x, _836.w), _871);
        float3 _875 = _873;
        _875.y = dot(float4(_836.y, _840.y, _843.y, _840.w), _871);
        float3 _877 = _875;
        _877.z = dot(float4(_836.z, _840.z, _843.zw), _871);
        _880 = fast::max(float3(0.0), _877) * float3(0.3183098733425140380859375);
    }
    else
    {
        _880 = float3(0.0);
    }
    float3 _883 = _880 * View.View_IndirectLightingColorScale;
    float3 _905 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _934;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _933;
        if (any(abs(_272 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _657 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _657 + 19u)].xyz + float3(1.0))))
        {
            _933 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_272, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _933 = _905;
        }
        _934 = _933;
    }
    else
    {
        _934 = _905;
    }
    float4 _941 = float4(((mix(float3(0.0), _802 + (_804 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_883 * _802) * fast::max(float3(1.0), ((((((_709 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_709 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_709 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _934) * 1.0, 0.0);
    float4 _948;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _947 = _941;
        _947.w = 0.0;
        _948 = _947;
    }
    else
    {
        _948 = _941;
    }
    float2 _952 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _960 = (_710 * 0.5) + float3(0.5);
    float4 _962 = float4(_960.x, _960.y, _960.z, float4(0.0).w);
    _962.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _658)].y;
    float4 _963 = float4(0.0);
    _963.x = _708;
    float4 _964 = _963;
    _964.y = _707;
    float4 _965 = _964;
    _965.z = _706;
    float4 _966 = _965;
    _966.w = 0.50588238239288330078125;
    float4 _978 = float4(_709.x, _709.y, _709.z, float4(0.0).w);
    _978.w = ((log2(((dot(_883, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_806 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_806 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_806 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_952.xyx * _952.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _948 * View.View_PreExposure;
    out.out_var_SV_Target1 = _962;
    out.out_var_SV_Target2 = _966;
    out.out_var_SV_Target3 = _978;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_773, 1.0, 1.0, 1.0);
    return out;
}

