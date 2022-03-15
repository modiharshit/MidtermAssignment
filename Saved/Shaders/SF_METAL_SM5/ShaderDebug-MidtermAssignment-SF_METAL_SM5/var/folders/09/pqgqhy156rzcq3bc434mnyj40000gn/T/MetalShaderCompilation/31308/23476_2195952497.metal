

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
    char _m13_pad[612];
    float View_RenderingReflectionCaptureMask;
    char _m14_pad[48];
    float4 View_SkyLightColor;
    char _m15_pad[124];
    float View_ShowDecalsMask;
    char _m16_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m17_pad[48];
    float3 View_VolumetricLightmapWorldToUVScale;
    float3 View_VolumetricLightmapWorldToUVAdd;
    packed_float3 View_VolumetricLightmapIndirectionTextureSize;
    float View_VolumetricLightmapBrickSize;
    float3 View_VolumetricLightmapBrickTexelSize;
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

constant float _190 = {};
constant float3 _191 = {};

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

fragment MainPS_out Main_00005bb4_82e39371(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float3x3 _235 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _246 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _190, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _251 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _255 = _251.xyz / float3(_251.w);
    float3 _256 = _255 - View.View_PreViewTranslation;
    float4 _264 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _267 = (_264.xy * float2(2.0)) - float2(1.0);
    float2 _276 = (normalize(-_255) * _235).xy;
    float2 _278 = (_276 * (-0.00310000008903443813323974609375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _280 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _278, bias(View.View_MaterialTextureMipBias));
    float2 _283 = (_280.xy * float2(2.0)) - float2(1.0);
    float2 _292 = (_276 * (-0.0062000001780688762664794921875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _294 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _292, bias(View.View_MaterialTextureMipBias));
    float2 _297 = (_294.xy * float2(2.0)) - float2(1.0);
    float2 _306 = (_276 * (-0.009300000034272670745849609375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _308 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _306, bias(View.View_MaterialTextureMipBias));
    float2 _311 = (_308.xy * float2(2.0)) - float2(1.0);
    float2 _320 = (_276 * (-0.012400000356137752532958984375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _322 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _320, bias(View.View_MaterialTextureMipBias));
    float2 _325 = (_322.xy * float2(2.0)) - float2(1.0);
    float2 _334 = (_276 * (-0.01549999974668025970458984375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _336 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _334, bias(View.View_MaterialTextureMipBias));
    float2 _339 = (_336.xy * float2(2.0)) - float2(1.0);
    float2 _348 = (_276 * (-0.01860000006854534149169921875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _350 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _348, bias(View.View_MaterialTextureMipBias));
    float2 _353 = (_350.xy * float2(2.0)) - float2(1.0);
    float2 _362 = (_276 * (-0.02170000039041042327880859375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _364 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _362, bias(View.View_MaterialTextureMipBias));
    float2 _367 = (_364.xy * float2(2.0)) - float2(1.0);
    float2 _376 = (_276 * (-0.02542000077664852142333984375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _378 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _376, bias(View.View_MaterialTextureMipBias));
    float2 _381 = (_378.xy * float2(2.0)) - float2(1.0);
    float2 _390 = (_276 * (-0.0291399993002414703369140625)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _392 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _390, bias(View.View_MaterialTextureMipBias));
    float2 _395 = (_392.xy * float2(2.0)) - float2(1.0);
    float2 _404 = (_276 * (-0.0340999998152256011962890625)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _406 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _404, bias(View.View_MaterialTextureMipBias));
    float2 _409 = (_406.xy * float2(2.0)) - float2(1.0);
    float2 _418 = (_276 * (-0.039680004119873046875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _420 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _418, bias(View.View_MaterialTextureMipBias));
    float2 _423 = (_420.xy * float2(2.0)) - float2(1.0);
    float4 _434 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.949999988079071044921875), bias(View.View_MaterialTextureMipBias));
    float _437 = _434.x;
    float3 _438 = float3(_437);
    float4 _441 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.89999997615814208984375), bias(View.View_MaterialTextureMipBias));
    float _443 = _441.x;
    float3 _444 = float3(_443);
    float4 _447 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.800000011920928955078125), bias(View.View_MaterialTextureMipBias));
    float _449 = _447.x;
    float3 _450 = float3(_449);
    float4 _453 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.699999988079071044921875), bias(View.View_MaterialTextureMipBias));
    float _455 = _453.x;
    float3 _456 = float3(_455);
    float4 _459 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.60000002384185791015625), bias(View.View_MaterialTextureMipBias));
    float _461 = _459.x;
    float3 _462 = float3(_461);
    float4 _465 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.5), bias(View.View_MaterialTextureMipBias));
    float _467 = _465.x;
    float3 _468 = float3(_467);
    float4 _471 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.39999997615814208984375), bias(View.View_MaterialTextureMipBias));
    float _473 = _471.x;
    float3 _474 = float3(_473);
    float4 _477 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.300000011920928955078125), bias(View.View_MaterialTextureMipBias));
    float _479 = _477.x;
    float3 _480 = float3(_479);
    float4 _483 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.2599999904632568359375), bias(View.View_MaterialTextureMipBias));
    float _485 = _483.x;
    float3 _486 = float3(_485);
    float4 _489 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.2400000095367431640625), bias(View.View_MaterialTextureMipBias));
    float _491 = _489.x;
    float3 _492 = float3(_491);
    float4 _495 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.10000002384185791015625), bias(View.View_MaterialTextureMipBias));
    float _497 = _495.x;
    float3 _498 = float3(_497);
    float3 _507 = normalize(_235 * normalize((mix(float4(_267, sqrt(fast::clamp(1.0 - dot(_267, _267), 0.0, 1.0)), 1.0).xyz, mix(float4(_283, sqrt(fast::clamp(1.0 - dot(_283, _283), 0.0, 1.0)), 1.0).xyz, mix(float4(_297, sqrt(fast::clamp(1.0 - dot(_297, _297), 0.0, 1.0)), 1.0).xyz, mix(float4(_311, sqrt(fast::clamp(1.0 - dot(_311, _311), 0.0, 1.0)), 1.0).xyz, mix(float4(_325, sqrt(fast::clamp(1.0 - dot(_325, _325), 0.0, 1.0)), 1.0).xyz, mix(float4(_339, sqrt(fast::clamp(1.0 - dot(_339, _339), 0.0, 1.0)), 1.0).xyz, mix(float4(_353, sqrt(fast::clamp(1.0 - dot(_353, _353), 0.0, 1.0)), 1.0).xyz, mix(float4(_367, sqrt(fast::clamp(1.0 - dot(_367, _367), 0.0, 1.0)), 1.0).xyz, mix(float4(_381, sqrt(fast::clamp(1.0 - dot(_381, _381), 0.0, 1.0)), 1.0).xyz, mix(float4(_395, sqrt(fast::clamp(1.0 - dot(_395, _395), 0.0, 1.0)), 1.0).xyz, mix(float4(_409, sqrt(fast::clamp(1.0 - dot(_409, _409), 0.0, 1.0)), 1.0).xyz, float4(_423, sqrt(fast::clamp(1.0 - dot(_423, _423), 0.0, 1.0)), 1.0).xyz, _438), _444), _450), _456), _462), _468), _474), _480), _486), _492), _498) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _518 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _528 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_278 * Material.Material_ScalarExpressions[0].y) + float2(0.800000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float4 _538 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_292 * Material.Material_ScalarExpressions[0].y) + float2(0.699999988079071044921875)), bias(View.View_MaterialTextureMipBias));
    float4 _548 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_306 * Material.Material_ScalarExpressions[0].y) + float2(0.60000002384185791015625)), bias(View.View_MaterialTextureMipBias));
    float4 _558 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_320 * Material.Material_ScalarExpressions[0].y) + float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float4 _564 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_334 * Material.Material_ScalarExpressions[0].y) + float2(0.4000000059604644775390625)), bias(View.View_MaterialTextureMipBias));
    float4 _570 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_348 * Material.Material_ScalarExpressions[0].y) + float2(0.300000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float4 _576 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_362 * Material.Material_ScalarExpressions[0].y) + float2(0.25)), bias(View.View_MaterialTextureMipBias));
    float4 _582 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_376 * Material.Material_ScalarExpressions[0].y) + float2(0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float4 _588 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_390 * Material.Material_ScalarExpressions[0].y) + float2(0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float4 _594 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_404 * Material.Material_ScalarExpressions[0].y) + float2(-0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float4 _600 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_418 * Material.Material_ScalarExpressions[0].y) + float2(-0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float4 _604 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _418, bias(View.View_MaterialTextureMipBias));
    float4 _608 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.97500002384185791015625), bias(View.View_MaterialTextureMipBias));
    float _609 = _608.x;
    float3 _635 = fast::clamp(mix(_518.xyz * 1.0, mix((_528.xyz * 1.5) * fast::min(fast::max(0.60000002384185791015625 + _491, -0.0), 1.0), mix((_538.xyz * 1.2000000476837158203125) * fast::min(fast::max(0.60000002384185791015625 + _485, -0.0), 1.0), mix((_548.xyz * 1.0) * fast::min(fast::max(0.60000002384185791015625 + _479, -0.0), 1.0), mix(_558.xyz * 0.699999988079071044921875, mix(_564.xyz * 0.60000002384185791015625, mix(_570.xyz * 0.5, mix(_576.xyz * 0.4000000059604644775390625, mix(_582.xyz * 0.300000011920928955078125, mix(_588.xyz * 0.20000000298023223876953125, mix(_594.xyz * 0.1500000059604644775390625, mix(_600.xyz * 0.13799999654293060302734375, _604.xyz * 0.300000011920928955078125, float3(_609)), _438), _444), _450), _456), _462), _468), _474), _480), _486), _492), _498), float3(0.0), float3(1.0));
    float _640 = (fast::clamp(mix(0.60000002384185791015625, 0.800000011920928955078125, ((((((((((_609 * _437) * _443) * _449) * _455) * _461) * _467) * _473) * _479) * _485) * _491) * _497), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _641 = in.in_var_PRIMITIVE_ID * 36u;
    uint _642 = _641 + 20u;
    float _690;
    float _691;
    float _692;
    float3 _693;
    float3 _694;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _642)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _660 = ((_246.xy / float2(_246.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _664 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _660, level(0.0));
        float4 _667 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _660, level(0.0));
        float4 _670 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _660, level(0.0));
        float _680 = _670.w;
        _690 = (_640 * _680) + _670.z;
        _691 = (0.4000000059604644775390625 * _680) + _670.y;
        _692 = _670.x;
        _693 = (_635 * _664.w) + _664.xyz;
        _694 = normalize((_507 * _667.w) + ((_667.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _690 = _640;
        _691 = 0.4000000059604644775390625;
        _692 = 0.0;
        _693 = _635;
        _694 = _507;
    }
    float _743;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _642)].z > 0.0)
    {
        float3 _711 = fast::clamp((_256 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _722 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_711.x), int(_711.y), int(_711.z), 0).xyz), 0));
        _743 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_722.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_711 / float3(_722.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _743 = 1.0;
    }
    float3 _757 = ((_693 - (_693 * _692)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _764 = (mix(float3(0.07999999821186065673828125 * _691), _693, float3(_692)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _767 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _772;
    if (_767)
    {
        _772 = _757 + (_764 * 0.449999988079071044921875);
    }
    else
    {
        _772 = _757;
    }
    float4 _778 = float4(_694, 1.0);
    float3 _782 = _191;
    _782.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _778);
    float3 _786 = _782;
    _786.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _778);
    float3 _790 = _786;
    _790.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _778);
    float4 _793 = _778.xyzz * _778.yzzx;
    float3 _797 = _191;
    _797.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _793);
    float3 _801 = _797;
    _801.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _793);
    float3 _805 = _801;
    _805.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _793);
    float3 _839 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _868;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _867;
        if (any(abs(_256 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _641 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _641 + 19u)].xyz + float3(1.0))))
        {
            _867 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_256, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _867 = _839;
        }
        _868 = _867;
    }
    else
    {
        _868 = _839;
    }
    float4 _875 = float4(((mix(float3(0.0), _772 + (select(_764, float3(0.0), bool3(_767)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((((fast::max(float3(0.0), (_790 + _805) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_694.x * _694.x) - (_694.y * _694.y)))) * View.View_SkyLightColor.xyz) * 1.0) * _772) * fast::max(float3(1.0), ((((((_693 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_693 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_693 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _868) * 1.0, 0.0);
    float4 _882;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _881 = _875;
        _881.w = 0.0;
        _882 = _881;
    }
    else
    {
        _882 = _875;
    }
    float2 _886 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _894 = (_694 * 0.5) + float3(0.5);
    float4 _896 = float4(_894.x, _894.y, _894.z, float4(0.0).w);
    _896.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _642)].y;
    float4 _897 = float4(0.0);
    _897.x = _692;
    float4 _898 = _897;
    _898.y = _691;
    float4 _899 = _898;
    _899.z = _690;
    float4 _900 = _899;
    _900.w = 0.50588238239288330078125;
    float4 _903 = float4(_693.x, _693.y, _693.z, float4(0.0).w);
    _903.w = (fract(dot(_886.xyx * _886.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _882 * View.View_PreExposure;
    out.out_var_SV_Target1 = _896;
    out.out_var_SV_Target2 = _900;
    out.out_var_SV_Target3 = _903;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_743, 1.0, 1.0, 1.0);
    return out;
}

