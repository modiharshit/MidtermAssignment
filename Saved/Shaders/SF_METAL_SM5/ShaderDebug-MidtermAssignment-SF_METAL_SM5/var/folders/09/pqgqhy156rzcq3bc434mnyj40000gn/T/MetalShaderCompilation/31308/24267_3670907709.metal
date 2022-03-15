

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

constant float3 _179 = {};
constant float _194 = {};

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

fragment MainPS_out Main_00005ecb_dacd9b3d(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> Material_Texture2D_0 [[texture(4)]], texture2d<float> Material_Texture2D_1 [[texture(5)]], texture2d<float> Material_Texture2D_2 [[texture(6)]], texture2d<float> Material_Texture2D_3 [[texture(7)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float3x3 _237 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _248 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _194, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _253 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _257 = _253.xyz / float3(_253.w);
    float3 _258 = _257 - View.View_PreViewTranslation;
    float4 _266 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _269 = (_266.xy * float2(2.0)) - float2(1.0);
    float2 _278 = (normalize(-_257) * _237).xy;
    float2 _280 = (_278 * (-0.00310000008903443813323974609375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _282 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _280, bias(View.View_MaterialTextureMipBias));
    float2 _285 = (_282.xy * float2(2.0)) - float2(1.0);
    float2 _294 = (_278 * (-0.0062000001780688762664794921875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _296 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _294, bias(View.View_MaterialTextureMipBias));
    float2 _299 = (_296.xy * float2(2.0)) - float2(1.0);
    float2 _308 = (_278 * (-0.009300000034272670745849609375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _310 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _308, bias(View.View_MaterialTextureMipBias));
    float2 _313 = (_310.xy * float2(2.0)) - float2(1.0);
    float2 _322 = (_278 * (-0.012400000356137752532958984375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _324 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _322, bias(View.View_MaterialTextureMipBias));
    float2 _327 = (_324.xy * float2(2.0)) - float2(1.0);
    float2 _336 = (_278 * (-0.01549999974668025970458984375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _338 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _336, bias(View.View_MaterialTextureMipBias));
    float2 _341 = (_338.xy * float2(2.0)) - float2(1.0);
    float2 _350 = (_278 * (-0.01860000006854534149169921875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _352 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _350, bias(View.View_MaterialTextureMipBias));
    float2 _355 = (_352.xy * float2(2.0)) - float2(1.0);
    float2 _364 = (_278 * (-0.02170000039041042327880859375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _366 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _364, bias(View.View_MaterialTextureMipBias));
    float2 _369 = (_366.xy * float2(2.0)) - float2(1.0);
    float2 _378 = (_278 * (-0.02542000077664852142333984375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _380 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _378, bias(View.View_MaterialTextureMipBias));
    float2 _383 = (_380.xy * float2(2.0)) - float2(1.0);
    float2 _392 = (_278 * (-0.0291399993002414703369140625)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _394 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _392, bias(View.View_MaterialTextureMipBias));
    float2 _397 = (_394.xy * float2(2.0)) - float2(1.0);
    float2 _406 = (_278 * (-0.0340999998152256011962890625)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _408 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _406, bias(View.View_MaterialTextureMipBias));
    float2 _411 = (_408.xy * float2(2.0)) - float2(1.0);
    float2 _420 = (_278 * (-0.039680004119873046875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _422 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _420, bias(View.View_MaterialTextureMipBias));
    float2 _425 = (_422.xy * float2(2.0)) - float2(1.0);
    float4 _436 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.949999988079071044921875), bias(View.View_MaterialTextureMipBias));
    float _439 = _436.x;
    float3 _440 = float3(_439);
    float4 _443 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.89999997615814208984375), bias(View.View_MaterialTextureMipBias));
    float _445 = _443.x;
    float3 _446 = float3(_445);
    float4 _449 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.800000011920928955078125), bias(View.View_MaterialTextureMipBias));
    float _451 = _449.x;
    float3 _452 = float3(_451);
    float4 _455 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.699999988079071044921875), bias(View.View_MaterialTextureMipBias));
    float _457 = _455.x;
    float3 _458 = float3(_457);
    float4 _461 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.60000002384185791015625), bias(View.View_MaterialTextureMipBias));
    float _463 = _461.x;
    float3 _464 = float3(_463);
    float4 _467 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.5), bias(View.View_MaterialTextureMipBias));
    float _469 = _467.x;
    float3 _470 = float3(_469);
    float4 _473 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.39999997615814208984375), bias(View.View_MaterialTextureMipBias));
    float _475 = _473.x;
    float3 _476 = float3(_475);
    float4 _479 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.300000011920928955078125), bias(View.View_MaterialTextureMipBias));
    float _481 = _479.x;
    float3 _482 = float3(_481);
    float4 _485 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.2599999904632568359375), bias(View.View_MaterialTextureMipBias));
    float _487 = _485.x;
    float3 _488 = float3(_487);
    float4 _491 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.2400000095367431640625), bias(View.View_MaterialTextureMipBias));
    float _493 = _491.x;
    float3 _494 = float3(_493);
    float4 _497 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.10000002384185791015625), bias(View.View_MaterialTextureMipBias));
    float _499 = _497.x;
    float3 _500 = float3(_499);
    float3 _509 = normalize(_237 * normalize((mix(float4(_269, sqrt(fast::clamp(1.0 - dot(_269, _269), 0.0, 1.0)), 1.0).xyz, mix(float4(_285, sqrt(fast::clamp(1.0 - dot(_285, _285), 0.0, 1.0)), 1.0).xyz, mix(float4(_299, sqrt(fast::clamp(1.0 - dot(_299, _299), 0.0, 1.0)), 1.0).xyz, mix(float4(_313, sqrt(fast::clamp(1.0 - dot(_313, _313), 0.0, 1.0)), 1.0).xyz, mix(float4(_327, sqrt(fast::clamp(1.0 - dot(_327, _327), 0.0, 1.0)), 1.0).xyz, mix(float4(_341, sqrt(fast::clamp(1.0 - dot(_341, _341), 0.0, 1.0)), 1.0).xyz, mix(float4(_355, sqrt(fast::clamp(1.0 - dot(_355, _355), 0.0, 1.0)), 1.0).xyz, mix(float4(_369, sqrt(fast::clamp(1.0 - dot(_369, _369), 0.0, 1.0)), 1.0).xyz, mix(float4(_383, sqrt(fast::clamp(1.0 - dot(_383, _383), 0.0, 1.0)), 1.0).xyz, mix(float4(_397, sqrt(fast::clamp(1.0 - dot(_397, _397), 0.0, 1.0)), 1.0).xyz, mix(float4(_411, sqrt(fast::clamp(1.0 - dot(_411, _411), 0.0, 1.0)), 1.0).xyz, float4(_425, sqrt(fast::clamp(1.0 - dot(_425, _425), 0.0, 1.0)), 1.0).xyz, _440), _446), _452), _458), _464), _470), _476), _482), _488), _494), _500) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _520 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _530 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_280 * Material.Material_ScalarExpressions[0].y) + float2(0.800000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float4 _540 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_294 * Material.Material_ScalarExpressions[0].y) + float2(0.699999988079071044921875)), bias(View.View_MaterialTextureMipBias));
    float4 _550 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_308 * Material.Material_ScalarExpressions[0].y) + float2(0.60000002384185791015625)), bias(View.View_MaterialTextureMipBias));
    float4 _560 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_322 * Material.Material_ScalarExpressions[0].y) + float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float4 _566 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_336 * Material.Material_ScalarExpressions[0].y) + float2(0.4000000059604644775390625)), bias(View.View_MaterialTextureMipBias));
    float4 _572 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_350 * Material.Material_ScalarExpressions[0].y) + float2(0.300000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float4 _578 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_364 * Material.Material_ScalarExpressions[0].y) + float2(0.25)), bias(View.View_MaterialTextureMipBias));
    float4 _584 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_378 * Material.Material_ScalarExpressions[0].y) + float2(0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float4 _590 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_392 * Material.Material_ScalarExpressions[0].y) + float2(0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float4 _596 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_406 * Material.Material_ScalarExpressions[0].y) + float2(-0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float4 _602 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_420 * Material.Material_ScalarExpressions[0].y) + float2(-0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float4 _606 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _420, bias(View.View_MaterialTextureMipBias));
    float4 _610 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.97500002384185791015625), bias(View.View_MaterialTextureMipBias));
    float _611 = _610.x;
    float3 _637 = fast::clamp(mix(_520.xyz * 1.0, mix((_530.xyz * 1.5) * fast::min(fast::max(0.60000002384185791015625 + _493, -0.0), 1.0), mix((_540.xyz * 1.2000000476837158203125) * fast::min(fast::max(0.60000002384185791015625 + _487, -0.0), 1.0), mix((_550.xyz * 1.0) * fast::min(fast::max(0.60000002384185791015625 + _481, -0.0), 1.0), mix(_560.xyz * 0.699999988079071044921875, mix(_566.xyz * 0.60000002384185791015625, mix(_572.xyz * 0.5, mix(_578.xyz * 0.4000000059604644775390625, mix(_584.xyz * 0.300000011920928955078125, mix(_590.xyz * 0.20000000298023223876953125, mix(_596.xyz * 0.1500000059604644775390625, mix(_602.xyz * 0.13799999654293060302734375, _606.xyz * 0.300000011920928955078125, float3(_611)), _440), _446), _452), _458), _464), _470), _476), _482), _488), _494), _500), float3(0.0), float3(1.0));
    float _642 = (fast::clamp(mix(0.60000002384185791015625, 0.800000011920928955078125, ((((((((((_611 * _439) * _445) * _451) * _457) * _463) * _469) * _475) * _481) * _487) * _493) * _499), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _643 = in.in_var_PRIMITIVE_ID * 36u;
    uint _644 = _643 + 20u;
    float _692;
    float _693;
    float _694;
    float3 _695;
    float3 _696;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _644)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _662 = ((_248.xy / float2(_248.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _666 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _662, level(0.0));
        float4 _669 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _662, level(0.0));
        float4 _672 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _662, level(0.0));
        float _682 = _672.w;
        _692 = (_642 * _682) + _672.z;
        _693 = (0.4000000059604644775390625 * _682) + _672.y;
        _694 = _672.x;
        _695 = (_637 * _666.w) + _666.xyz;
        _696 = normalize((_509 * _669.w) + ((_669.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _692 = _642;
        _693 = 0.4000000059604644775390625;
        _694 = 0.0;
        _695 = _637;
        _696 = _509;
    }
    float3 _711 = ((_695 - (_695 * _694)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _718 = (mix(float3(0.07999999821186065673828125 * _693), _695, float3(_694)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _721 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _726;
    if (_721)
    {
        _726 = _711 + (_718 * 0.449999988079071044921875);
    }
    else
    {
        _726 = _711;
    }
    float3 _728 = select(_718, float3(0.0), bool3(_721));
    float3 _730 = float3(dot(_728, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _745 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _750 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _745);
    float4 _752 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_745 + float2(0.0, 0.5)));
    uint _754 = in.in_var_LIGHTMAP_ID * 15u;
    float3 _764 = (_750.xyz * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _754 + 4u)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _754 + 6u)].xyz;
    float _765 = dot(_764, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float _784 = (exp2((_765 * 16.0) - 8.0) - 0.00390625) * fast::max(0.0, dot((_752 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _754 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _754 + 7u)], float4(_696.yzx, 1.0)));
    float4 _795 = float4(_696, 1.0);
    float3 _799 = _179;
    _799.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _795);
    float3 _803 = _799;
    _803.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _795);
    float3 _807 = _803;
    _807.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _795);
    float4 _810 = _795.xyzz * _795.yzzx;
    float3 _814 = _179;
    _814.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _810);
    float3 _818 = _814;
    _818.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _810);
    float3 _822 = _818;
    _822.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _810);
    float3 _836 = (float4(_764 * (_784 / _765), _784).xyz * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_807 + _822) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_696.x * _696.x) - (_696.y * _696.y)))) * View.View_SkyLightColor.xyz) * 1.0);
    float3 _858 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _887;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _886;
        if (any(abs(_258 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _643 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _643 + 19u)].xyz + float3(1.0))))
        {
            _886 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_258, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _886 = _858;
        }
        _887 = _886;
    }
    else
    {
        _887 = _858;
    }
    float4 _894 = float4(((mix(float3(0.0), _726 + (_728 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_836 * _726) * fast::max(float3(1.0), ((((((_695 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_695 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_695 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _887) * 1.0, 0.0);
    float4 _901;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _900 = _894;
        _900.w = 0.0;
        _901 = _900;
    }
    else
    {
        _901 = _894;
    }
    float2 _905 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _913 = (_696 * 0.5) + float3(0.5);
    float4 _915 = float4(_913.x, _913.y, _913.z, float4(0.0).w);
    _915.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _644)].y;
    float4 _916 = float4(0.0);
    _916.x = _694;
    float4 _917 = _916;
    _917.y = _693;
    float4 _918 = _917;
    _918.z = _692;
    float4 _919 = _918;
    _919.w = 0.75686275959014892578125;
    float4 _931 = float4(_695.x, _695.y, _695.z, float4(0.0).w);
    _931.w = ((log2(((dot(_836, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_730 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_730 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_730 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_905.xyx * _905.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _901 * View.View_PreExposure;
    out.out_var_SV_Target1 = _915;
    out.out_var_SV_Target2 = _919;
    out.out_var_SV_Target3 = _931;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

