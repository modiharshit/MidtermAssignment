

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

fragment MainPS_out Main_000058e1_4a50743d(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> Material_Texture2D_0 [[texture(4)]], texture2d<float> Material_Texture2D_1 [[texture(5)]], texture2d<float> Material_Texture2D_2 [[texture(6)]], texture2d<float> Material_Texture2D_3 [[texture(7)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    float3x3 _232 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _243 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _190, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _248 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _252 = _248.xyz / float3(_248.w);
    float3 _253 = _252 - View.View_PreViewTranslation;
    float4 _261 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _264 = (_261.xy * float2(2.0)) - float2(1.0);
    float2 _273 = (normalize(-_252) * _232).xy;
    float2 _275 = (_273 * (-0.00310000008903443813323974609375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _277 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _275, bias(View.View_MaterialTextureMipBias));
    float2 _280 = (_277.xy * float2(2.0)) - float2(1.0);
    float2 _289 = (_273 * (-0.0062000001780688762664794921875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _291 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _289, bias(View.View_MaterialTextureMipBias));
    float2 _294 = (_291.xy * float2(2.0)) - float2(1.0);
    float2 _303 = (_273 * (-0.009300000034272670745849609375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _305 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _303, bias(View.View_MaterialTextureMipBias));
    float2 _308 = (_305.xy * float2(2.0)) - float2(1.0);
    float2 _317 = (_273 * (-0.012400000356137752532958984375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _319 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _317, bias(View.View_MaterialTextureMipBias));
    float2 _322 = (_319.xy * float2(2.0)) - float2(1.0);
    float2 _331 = (_273 * (-0.01549999974668025970458984375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _333 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _331, bias(View.View_MaterialTextureMipBias));
    float2 _336 = (_333.xy * float2(2.0)) - float2(1.0);
    float2 _345 = (_273 * (-0.01860000006854534149169921875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _347 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _345, bias(View.View_MaterialTextureMipBias));
    float2 _350 = (_347.xy * float2(2.0)) - float2(1.0);
    float2 _359 = (_273 * (-0.02170000039041042327880859375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _361 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _359, bias(View.View_MaterialTextureMipBias));
    float2 _364 = (_361.xy * float2(2.0)) - float2(1.0);
    float2 _373 = (_273 * (-0.02542000077664852142333984375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _375 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _373, bias(View.View_MaterialTextureMipBias));
    float2 _378 = (_375.xy * float2(2.0)) - float2(1.0);
    float2 _387 = (_273 * (-0.0291399993002414703369140625)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _389 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _387, bias(View.View_MaterialTextureMipBias));
    float2 _392 = (_389.xy * float2(2.0)) - float2(1.0);
    float2 _401 = (_273 * (-0.0340999998152256011962890625)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _403 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _401, bias(View.View_MaterialTextureMipBias));
    float2 _406 = (_403.xy * float2(2.0)) - float2(1.0);
    float2 _415 = (_273 * (-0.039680004119873046875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _417 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _415, bias(View.View_MaterialTextureMipBias));
    float2 _420 = (_417.xy * float2(2.0)) - float2(1.0);
    float4 _431 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.949999988079071044921875), bias(View.View_MaterialTextureMipBias));
    float _434 = _431.x;
    float3 _435 = float3(_434);
    float4 _438 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.89999997615814208984375), bias(View.View_MaterialTextureMipBias));
    float _440 = _438.x;
    float3 _441 = float3(_440);
    float4 _444 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.800000011920928955078125), bias(View.View_MaterialTextureMipBias));
    float _446 = _444.x;
    float3 _447 = float3(_446);
    float4 _450 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.699999988079071044921875), bias(View.View_MaterialTextureMipBias));
    float _452 = _450.x;
    float3 _453 = float3(_452);
    float4 _456 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.60000002384185791015625), bias(View.View_MaterialTextureMipBias));
    float _458 = _456.x;
    float3 _459 = float3(_458);
    float4 _462 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.5), bias(View.View_MaterialTextureMipBias));
    float _464 = _462.x;
    float3 _465 = float3(_464);
    float4 _468 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.39999997615814208984375), bias(View.View_MaterialTextureMipBias));
    float _470 = _468.x;
    float3 _471 = float3(_470);
    float4 _474 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.300000011920928955078125), bias(View.View_MaterialTextureMipBias));
    float _476 = _474.x;
    float3 _477 = float3(_476);
    float4 _480 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.2599999904632568359375), bias(View.View_MaterialTextureMipBias));
    float _482 = _480.x;
    float3 _483 = float3(_482);
    float4 _486 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.2400000095367431640625), bias(View.View_MaterialTextureMipBias));
    float _488 = _486.x;
    float3 _489 = float3(_488);
    float4 _492 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.10000002384185791015625), bias(View.View_MaterialTextureMipBias));
    float _494 = _492.x;
    float3 _495 = float3(_494);
    float3 _504 = normalize(_232 * normalize((mix(float4(_264, sqrt(fast::clamp(1.0 - dot(_264, _264), 0.0, 1.0)), 1.0).xyz, mix(float4(_280, sqrt(fast::clamp(1.0 - dot(_280, _280), 0.0, 1.0)), 1.0).xyz, mix(float4(_294, sqrt(fast::clamp(1.0 - dot(_294, _294), 0.0, 1.0)), 1.0).xyz, mix(float4(_308, sqrt(fast::clamp(1.0 - dot(_308, _308), 0.0, 1.0)), 1.0).xyz, mix(float4(_322, sqrt(fast::clamp(1.0 - dot(_322, _322), 0.0, 1.0)), 1.0).xyz, mix(float4(_336, sqrt(fast::clamp(1.0 - dot(_336, _336), 0.0, 1.0)), 1.0).xyz, mix(float4(_350, sqrt(fast::clamp(1.0 - dot(_350, _350), 0.0, 1.0)), 1.0).xyz, mix(float4(_364, sqrt(fast::clamp(1.0 - dot(_364, _364), 0.0, 1.0)), 1.0).xyz, mix(float4(_378, sqrt(fast::clamp(1.0 - dot(_378, _378), 0.0, 1.0)), 1.0).xyz, mix(float4(_392, sqrt(fast::clamp(1.0 - dot(_392, _392), 0.0, 1.0)), 1.0).xyz, mix(float4(_406, sqrt(fast::clamp(1.0 - dot(_406, _406), 0.0, 1.0)), 1.0).xyz, float4(_420, sqrt(fast::clamp(1.0 - dot(_420, _420), 0.0, 1.0)), 1.0).xyz, _435), _441), _447), _453), _459), _465), _471), _477), _483), _489), _495) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _515 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _525 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_275 * Material.Material_ScalarExpressions[0].y) + float2(0.800000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float4 _535 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_289 * Material.Material_ScalarExpressions[0].y) + float2(0.699999988079071044921875)), bias(View.View_MaterialTextureMipBias));
    float4 _545 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_303 * Material.Material_ScalarExpressions[0].y) + float2(0.60000002384185791015625)), bias(View.View_MaterialTextureMipBias));
    float4 _555 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_317 * Material.Material_ScalarExpressions[0].y) + float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float4 _561 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_331 * Material.Material_ScalarExpressions[0].y) + float2(0.4000000059604644775390625)), bias(View.View_MaterialTextureMipBias));
    float4 _567 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_345 * Material.Material_ScalarExpressions[0].y) + float2(0.300000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float4 _573 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_359 * Material.Material_ScalarExpressions[0].y) + float2(0.25)), bias(View.View_MaterialTextureMipBias));
    float4 _579 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_373 * Material.Material_ScalarExpressions[0].y) + float2(0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float4 _585 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_387 * Material.Material_ScalarExpressions[0].y) + float2(0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float4 _591 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_401 * Material.Material_ScalarExpressions[0].y) + float2(-0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float4 _597 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_415 * Material.Material_ScalarExpressions[0].y) + float2(-0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float4 _601 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _415, bias(View.View_MaterialTextureMipBias));
    float4 _605 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.97500002384185791015625), bias(View.View_MaterialTextureMipBias));
    float _606 = _605.x;
    float3 _632 = fast::clamp(mix(_515.xyz * 1.0, mix((_525.xyz * 1.5) * fast::min(fast::max(0.60000002384185791015625 + _488, -0.0), 1.0), mix((_535.xyz * 1.2000000476837158203125) * fast::min(fast::max(0.60000002384185791015625 + _482, -0.0), 1.0), mix((_545.xyz * 1.0) * fast::min(fast::max(0.60000002384185791015625 + _476, -0.0), 1.0), mix(_555.xyz * 0.699999988079071044921875, mix(_561.xyz * 0.60000002384185791015625, mix(_567.xyz * 0.5, mix(_573.xyz * 0.4000000059604644775390625, mix(_579.xyz * 0.300000011920928955078125, mix(_585.xyz * 0.20000000298023223876953125, mix(_591.xyz * 0.1500000059604644775390625, mix(_597.xyz * 0.13799999654293060302734375, _601.xyz * 0.300000011920928955078125, float3(_606)), _435), _441), _447), _453), _459), _465), _471), _477), _483), _489), _495), float3(0.0), float3(1.0));
    float _637 = (fast::clamp(mix(0.60000002384185791015625, 0.800000011920928955078125, ((((((((((_606 * _434) * _440) * _446) * _452) * _458) * _464) * _470) * _476) * _482) * _488) * _494), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _638 = in.in_var_PRIMITIVE_ID * 36u;
    uint _639 = _638 + 20u;
    float _687;
    float _688;
    float _689;
    float3 _690;
    float3 _691;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _639)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _657 = ((_243.xy / float2(_243.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _661 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _657, level(0.0));
        float4 _664 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _657, level(0.0));
        float4 _667 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _657, level(0.0));
        float _677 = _667.w;
        _687 = (_637 * _677) + _667.z;
        _688 = (0.4000000059604644775390625 * _677) + _667.y;
        _689 = _667.x;
        _690 = (_632 * _661.w) + _661.xyz;
        _691 = normalize((_504 * _664.w) + ((_664.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _687 = _637;
        _688 = 0.4000000059604644775390625;
        _689 = 0.0;
        _690 = _632;
        _691 = _504;
    }
    float3 _706 = ((_690 - (_690 * _689)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _713 = (mix(float3(0.07999999821186065673828125 * _688), _690, float3(_689)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _716 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _721;
    if (_716)
    {
        _721 = _706 + (_713 * 0.449999988079071044921875);
    }
    else
    {
        _721 = _706;
    }
    float3 _723 = select(_713, float3(0.0), bool3(_716));
    float3 _725 = float3(dot(_723, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _740 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _745 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _740);
    float4 _747 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_740 + float2(0.0, 0.5)));
    uint _749 = in.in_var_LIGHTMAP_ID * 15u;
    float3 _759 = (_745.xyz * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _749 + 4u)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _749 + 6u)].xyz;
    float _760 = dot(_759, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float _779 = (exp2((_760 * 16.0) - 8.0) - 0.00390625) * fast::max(0.0, dot((_747 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _749 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _749 + 7u)], float4(_691.yzx, 1.0)));
    float3 _789 = float4(_759 * (_779 / _760), _779).xyz * View.View_IndirectLightingColorScale;
    float3 _811 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _840;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _839;
        if (any(abs(_253 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _638 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _638 + 19u)].xyz + float3(1.0))))
        {
            _839 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_253, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _839 = _811;
        }
        _840 = _839;
    }
    else
    {
        _840 = _811;
    }
    float4 _847 = float4(((mix(float3(0.0), _721 + (_723 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_789 * _721) * fast::max(float3(1.0), ((((((_690 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_690 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_690 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _840) * 1.0, 0.0);
    float4 _854;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _853 = _847;
        _853.w = 0.0;
        _854 = _853;
    }
    else
    {
        _854 = _847;
    }
    float2 _858 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _866 = (_691 * 0.5) + float3(0.5);
    float4 _868 = float4(_866.x, _866.y, _866.z, float4(0.0).w);
    _868.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _639)].y;
    float4 _869 = float4(0.0);
    _869.x = _689;
    float4 _870 = _869;
    _870.y = _688;
    float4 _871 = _870;
    _871.z = _687;
    float4 _872 = _871;
    _872.w = 0.75686275959014892578125;
    float4 _884 = float4(_690.x, _690.y, _690.z, float4(0.0).w);
    _884.w = ((log2(((dot(_789, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_725 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_725 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_725 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_858.xyx * _858.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _854 * View.View_PreExposure;
    out.out_var_SV_Target1 = _868;
    out.out_var_SV_Target2 = _872;
    out.out_var_SV_Target3 = _884;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

