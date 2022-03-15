

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

constant float3 _184 = {};
constant float _199 = {};

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

fragment MainPS_out Main_000065ae_1da2f423(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], texture2d<float> LightmapResourceCluster_StaticShadowTexture [[texture(5)]], texture2d<float> Material_Texture2D_0 [[texture(6)]], texture2d<float> Material_Texture2D_1 [[texture(7)]], texture2d<float> Material_Texture2D_2 [[texture(8)]], texture2d<float> Material_Texture2D_3 [[texture(9)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float3x3 _243 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _254 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _199, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _259 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _263 = _259.xyz / float3(_259.w);
    float3 _264 = _263 - View.View_PreViewTranslation;
    float4 _272 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _275 = (_272.xy * float2(2.0)) - float2(1.0);
    float2 _284 = (normalize(-_263) * _243).xy;
    float2 _286 = (_284 * (-0.00310000008903443813323974609375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _288 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _286, bias(View.View_MaterialTextureMipBias));
    float2 _291 = (_288.xy * float2(2.0)) - float2(1.0);
    float2 _300 = (_284 * (-0.0062000001780688762664794921875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _302 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _300, bias(View.View_MaterialTextureMipBias));
    float2 _305 = (_302.xy * float2(2.0)) - float2(1.0);
    float2 _314 = (_284 * (-0.009300000034272670745849609375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _316 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _314, bias(View.View_MaterialTextureMipBias));
    float2 _319 = (_316.xy * float2(2.0)) - float2(1.0);
    float2 _328 = (_284 * (-0.012400000356137752532958984375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _330 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _328, bias(View.View_MaterialTextureMipBias));
    float2 _333 = (_330.xy * float2(2.0)) - float2(1.0);
    float2 _342 = (_284 * (-0.01549999974668025970458984375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _344 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _342, bias(View.View_MaterialTextureMipBias));
    float2 _347 = (_344.xy * float2(2.0)) - float2(1.0);
    float2 _356 = (_284 * (-0.01860000006854534149169921875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _358 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _356, bias(View.View_MaterialTextureMipBias));
    float2 _361 = (_358.xy * float2(2.0)) - float2(1.0);
    float2 _370 = (_284 * (-0.02170000039041042327880859375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _372 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _370, bias(View.View_MaterialTextureMipBias));
    float2 _375 = (_372.xy * float2(2.0)) - float2(1.0);
    float2 _384 = (_284 * (-0.02542000077664852142333984375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _386 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _384, bias(View.View_MaterialTextureMipBias));
    float2 _389 = (_386.xy * float2(2.0)) - float2(1.0);
    float2 _398 = (_284 * (-0.0291399993002414703369140625)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _400 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _398, bias(View.View_MaterialTextureMipBias));
    float2 _403 = (_400.xy * float2(2.0)) - float2(1.0);
    float2 _412 = (_284 * (-0.0340999998152256011962890625)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _414 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _412, bias(View.View_MaterialTextureMipBias));
    float2 _417 = (_414.xy * float2(2.0)) - float2(1.0);
    float2 _426 = (_284 * (-0.039680004119873046875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _428 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _426, bias(View.View_MaterialTextureMipBias));
    float2 _431 = (_428.xy * float2(2.0)) - float2(1.0);
    float4 _442 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.949999988079071044921875), bias(View.View_MaterialTextureMipBias));
    float _445 = _442.x;
    float3 _446 = float3(_445);
    float4 _449 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.89999997615814208984375), bias(View.View_MaterialTextureMipBias));
    float _451 = _449.x;
    float3 _452 = float3(_451);
    float4 _455 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.800000011920928955078125), bias(View.View_MaterialTextureMipBias));
    float _457 = _455.x;
    float3 _458 = float3(_457);
    float4 _461 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.699999988079071044921875), bias(View.View_MaterialTextureMipBias));
    float _463 = _461.x;
    float3 _464 = float3(_463);
    float4 _467 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.60000002384185791015625), bias(View.View_MaterialTextureMipBias));
    float _469 = _467.x;
    float3 _470 = float3(_469);
    float4 _473 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.5), bias(View.View_MaterialTextureMipBias));
    float _475 = _473.x;
    float3 _476 = float3(_475);
    float4 _479 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.39999997615814208984375), bias(View.View_MaterialTextureMipBias));
    float _481 = _479.x;
    float3 _482 = float3(_481);
    float4 _485 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.300000011920928955078125), bias(View.View_MaterialTextureMipBias));
    float _487 = _485.x;
    float3 _488 = float3(_487);
    float4 _491 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.2599999904632568359375), bias(View.View_MaterialTextureMipBias));
    float _493 = _491.x;
    float3 _494 = float3(_493);
    float4 _497 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.2400000095367431640625), bias(View.View_MaterialTextureMipBias));
    float _499 = _497.x;
    float3 _500 = float3(_499);
    float4 _503 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.10000002384185791015625), bias(View.View_MaterialTextureMipBias));
    float _505 = _503.x;
    float3 _506 = float3(_505);
    float3 _515 = normalize(_243 * normalize((mix(float4(_275, sqrt(fast::clamp(1.0 - dot(_275, _275), 0.0, 1.0)), 1.0).xyz, mix(float4(_291, sqrt(fast::clamp(1.0 - dot(_291, _291), 0.0, 1.0)), 1.0).xyz, mix(float4(_305, sqrt(fast::clamp(1.0 - dot(_305, _305), 0.0, 1.0)), 1.0).xyz, mix(float4(_319, sqrt(fast::clamp(1.0 - dot(_319, _319), 0.0, 1.0)), 1.0).xyz, mix(float4(_333, sqrt(fast::clamp(1.0 - dot(_333, _333), 0.0, 1.0)), 1.0).xyz, mix(float4(_347, sqrt(fast::clamp(1.0 - dot(_347, _347), 0.0, 1.0)), 1.0).xyz, mix(float4(_361, sqrt(fast::clamp(1.0 - dot(_361, _361), 0.0, 1.0)), 1.0).xyz, mix(float4(_375, sqrt(fast::clamp(1.0 - dot(_375, _375), 0.0, 1.0)), 1.0).xyz, mix(float4(_389, sqrt(fast::clamp(1.0 - dot(_389, _389), 0.0, 1.0)), 1.0).xyz, mix(float4(_403, sqrt(fast::clamp(1.0 - dot(_403, _403), 0.0, 1.0)), 1.0).xyz, mix(float4(_417, sqrt(fast::clamp(1.0 - dot(_417, _417), 0.0, 1.0)), 1.0).xyz, float4(_431, sqrt(fast::clamp(1.0 - dot(_431, _431), 0.0, 1.0)), 1.0).xyz, _446), _452), _458), _464), _470), _476), _482), _488), _494), _500), _506) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _526 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _536 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_286 * Material.Material_ScalarExpressions[0].y) + float2(0.800000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float4 _546 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_300 * Material.Material_ScalarExpressions[0].y) + float2(0.699999988079071044921875)), bias(View.View_MaterialTextureMipBias));
    float4 _556 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_314 * Material.Material_ScalarExpressions[0].y) + float2(0.60000002384185791015625)), bias(View.View_MaterialTextureMipBias));
    float4 _566 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_328 * Material.Material_ScalarExpressions[0].y) + float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float4 _572 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_342 * Material.Material_ScalarExpressions[0].y) + float2(0.4000000059604644775390625)), bias(View.View_MaterialTextureMipBias));
    float4 _578 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_356 * Material.Material_ScalarExpressions[0].y) + float2(0.300000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float4 _584 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_370 * Material.Material_ScalarExpressions[0].y) + float2(0.25)), bias(View.View_MaterialTextureMipBias));
    float4 _590 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_384 * Material.Material_ScalarExpressions[0].y) + float2(0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float4 _596 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_398 * Material.Material_ScalarExpressions[0].y) + float2(0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float4 _602 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_412 * Material.Material_ScalarExpressions[0].y) + float2(-0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float4 _608 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_426 * Material.Material_ScalarExpressions[0].y) + float2(-0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float4 _612 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _426, bias(View.View_MaterialTextureMipBias));
    float4 _616 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.97500002384185791015625), bias(View.View_MaterialTextureMipBias));
    float _617 = _616.x;
    float3 _643 = fast::clamp(mix(_526.xyz * 1.0, mix((_536.xyz * 1.5) * fast::min(fast::max(0.60000002384185791015625 + _499, -0.0), 1.0), mix((_546.xyz * 1.2000000476837158203125) * fast::min(fast::max(0.60000002384185791015625 + _493, -0.0), 1.0), mix((_556.xyz * 1.0) * fast::min(fast::max(0.60000002384185791015625 + _487, -0.0), 1.0), mix(_566.xyz * 0.699999988079071044921875, mix(_572.xyz * 0.60000002384185791015625, mix(_578.xyz * 0.5, mix(_584.xyz * 0.4000000059604644775390625, mix(_590.xyz * 0.300000011920928955078125, mix(_596.xyz * 0.20000000298023223876953125, mix(_602.xyz * 0.1500000059604644775390625, mix(_608.xyz * 0.13799999654293060302734375, _612.xyz * 0.300000011920928955078125, float3(_617)), _446), _452), _458), _464), _470), _476), _482), _488), _494), _500), _506), float3(0.0), float3(1.0));
    float _648 = (fast::clamp(mix(0.60000002384185791015625, 0.800000011920928955078125, ((((((((((_617 * _445) * _451) * _457) * _463) * _469) * _475) * _481) * _487) * _493) * _499) * _505), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _649 = in.in_var_PRIMITIVE_ID * 36u;
    uint _650 = _649 + 20u;
    float _698;
    float _699;
    float _700;
    float3 _701;
    float3 _702;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _650)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _668 = ((_254.xy / float2(_254.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _672 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _668, level(0.0));
        float4 _675 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _668, level(0.0));
        float4 _678 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _668, level(0.0));
        float _688 = _678.w;
        _698 = (_648 * _688) + _678.z;
        _699 = (0.4000000059604644775390625 * _688) + _678.y;
        _700 = _678.x;
        _701 = (_643 * _672.w) + _672.xyz;
        _702 = normalize((_515 * _675.w) + ((_675.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _698 = _648;
        _699 = 0.4000000059604644775390625;
        _700 = 0.0;
        _701 = _643;
        _702 = _515;
    }
    float4 _709 = LightmapResourceCluster_StaticShadowTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.zw);
    uint _710 = in.in_var_LIGHTMAP_ID * 15u;
    uint _711 = _710 + 1u;
    float4 _718 = fast::clamp((_709 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _711)]) + ((View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _711)] * (-0.5)) + float4(0.5)), float4(0.0), float4(1.0));
    float3 _735 = ((_701 - (_701 * _700)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _742 = (mix(float3(0.07999999821186065673828125 * _699), _701, float3(_700)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _745 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _750;
    if (_745)
    {
        _750 = _735 + (_742 * 0.449999988079071044921875);
    }
    else
    {
        _750 = _735;
    }
    float3 _752 = select(_742, float3(0.0), bool3(_745));
    float3 _754 = float3(dot(_752, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _769 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _773 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _769);
    float4 _775 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_769 + float2(0.0, 0.5)));
    uint _781 = _710 + 4u;
    uint _786 = _710 + 6u;
    float3 _791 = _773.xyz;
    float _843;
    float _844;
    float3 _845;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _827 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _831 = _827.w;
        float _832 = _831 * _831;
        float3 _834 = normalize(((_827.xyz * 2.0) - float3(1.0)).xyz);
        float _835 = 1.0 - _832;
        float _837 = 1.0 - (_835 * _835);
        _843 = mix(fast::clamp(dot(_834, _702), 0.0, 1.0), 1.0, _837);
        _844 = _832;
        _845 = mix(_834, _702, float3(_837));
    }
    else
    {
        _843 = 1.0;
        _844 = 1.0;
        _845 = _702;
    }
    float4 _849 = float4(_845, 1.0);
    float3 _853 = _184;
    _853.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _849);
    float3 _857 = _853;
    _857.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _849);
    float3 _861 = _857;
    _861.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _849);
    float4 _864 = _849.xyzz * _849.yzzx;
    float3 _868 = _184;
    _868.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _864);
    float3 _872 = _868;
    _872.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _864);
    float3 _876 = _872;
    _876.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _864);
    float3 _891 = (((((_791 * _791) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _781)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _786)].xyz) * ((exp2(((_773.w + ((_775.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _781)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _786)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_775 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _710 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _710 + 7u)], float4(_702.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_861 + _876) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_845.x * _845.x) - (_845.y * _845.y)))) * View.View_SkyLightColor.xyz) * (_844 * _843));
    float3 _913 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _942;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _941;
        if (any(abs(_264 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _649 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _649 + 19u)].xyz + float3(1.0))))
        {
            _941 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_264, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _941 = _913;
        }
        _942 = _941;
    }
    else
    {
        _942 = _913;
    }
    float4 _949 = float4(((mix(float3(0.0), _750 + (_752 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_891 * _750) * fast::max(float3(1.0), ((((((_701 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_701 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_701 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _942) * 1.0, 0.0);
    float4 _956;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _955 = _949;
        _955.w = 0.0;
        _956 = _955;
    }
    else
    {
        _956 = _949;
    }
    float2 _960 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _968 = (_702 * 0.5) + float3(0.5);
    float4 _970 = float4(_968.x, _968.y, _968.z, float4(0.0).w);
    _970.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _650)].y;
    float4 _971 = float4(0.0);
    _971.x = _700;
    float4 _972 = _971;
    _972.y = _699;
    float4 _973 = _972;
    _973.z = _698;
    float4 _974 = _973;
    _974.w = 0.50588238239288330078125;
    float4 _986 = float4(_701.x, _701.y, _701.z, float4(0.0).w);
    _986.w = ((log2(((dot(_891, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_754 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_754 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_754 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_960.xyx * _960.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _956 * View.View_PreExposure;
    out.out_var_SV_Target1 = _970;
    out.out_var_SV_Target2 = _974;
    out.out_var_SV_Target3 = _986;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = (View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _710)] * _718) * _718;
    return out;
}

