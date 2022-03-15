

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

fragment MainPS_out Main_00005c3d_a2613fda(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_StaticShadowTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    float3x3 _236 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _247 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _194, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _252 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _256 = _252.xyz / float3(_252.w);
    float3 _257 = _256 - View.View_PreViewTranslation;
    float4 _265 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _268 = (_265.xy * float2(2.0)) - float2(1.0);
    float2 _277 = (normalize(-_256) * _236).xy;
    float2 _279 = (_277 * (-0.00310000008903443813323974609375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _281 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _279, bias(View.View_MaterialTextureMipBias));
    float2 _284 = (_281.xy * float2(2.0)) - float2(1.0);
    float2 _293 = (_277 * (-0.0062000001780688762664794921875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _295 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _293, bias(View.View_MaterialTextureMipBias));
    float2 _298 = (_295.xy * float2(2.0)) - float2(1.0);
    float2 _307 = (_277 * (-0.009300000034272670745849609375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _309 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _307, bias(View.View_MaterialTextureMipBias));
    float2 _312 = (_309.xy * float2(2.0)) - float2(1.0);
    float2 _321 = (_277 * (-0.012400000356137752532958984375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _323 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _321, bias(View.View_MaterialTextureMipBias));
    float2 _326 = (_323.xy * float2(2.0)) - float2(1.0);
    float2 _335 = (_277 * (-0.01549999974668025970458984375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _337 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _335, bias(View.View_MaterialTextureMipBias));
    float2 _340 = (_337.xy * float2(2.0)) - float2(1.0);
    float2 _349 = (_277 * (-0.01860000006854534149169921875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _351 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _349, bias(View.View_MaterialTextureMipBias));
    float2 _354 = (_351.xy * float2(2.0)) - float2(1.0);
    float2 _363 = (_277 * (-0.02170000039041042327880859375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _365 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _363, bias(View.View_MaterialTextureMipBias));
    float2 _368 = (_365.xy * float2(2.0)) - float2(1.0);
    float2 _377 = (_277 * (-0.02542000077664852142333984375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _379 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _377, bias(View.View_MaterialTextureMipBias));
    float2 _382 = (_379.xy * float2(2.0)) - float2(1.0);
    float2 _391 = (_277 * (-0.0291399993002414703369140625)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _393 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _391, bias(View.View_MaterialTextureMipBias));
    float2 _396 = (_393.xy * float2(2.0)) - float2(1.0);
    float2 _405 = (_277 * (-0.0340999998152256011962890625)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _407 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _405, bias(View.View_MaterialTextureMipBias));
    float2 _410 = (_407.xy * float2(2.0)) - float2(1.0);
    float2 _419 = (_277 * (-0.039680004119873046875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _421 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _419, bias(View.View_MaterialTextureMipBias));
    float2 _424 = (_421.xy * float2(2.0)) - float2(1.0);
    float4 _435 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.949999988079071044921875), bias(View.View_MaterialTextureMipBias));
    float _438 = _435.x;
    float3 _439 = float3(_438);
    float4 _442 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.89999997615814208984375), bias(View.View_MaterialTextureMipBias));
    float _444 = _442.x;
    float3 _445 = float3(_444);
    float4 _448 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.800000011920928955078125), bias(View.View_MaterialTextureMipBias));
    float _450 = _448.x;
    float3 _451 = float3(_450);
    float4 _454 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.699999988079071044921875), bias(View.View_MaterialTextureMipBias));
    float _456 = _454.x;
    float3 _457 = float3(_456);
    float4 _460 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.60000002384185791015625), bias(View.View_MaterialTextureMipBias));
    float _462 = _460.x;
    float3 _463 = float3(_462);
    float4 _466 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.5), bias(View.View_MaterialTextureMipBias));
    float _468 = _466.x;
    float3 _469 = float3(_468);
    float4 _472 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.39999997615814208984375), bias(View.View_MaterialTextureMipBias));
    float _474 = _472.x;
    float3 _475 = float3(_474);
    float4 _478 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.300000011920928955078125), bias(View.View_MaterialTextureMipBias));
    float _480 = _478.x;
    float3 _481 = float3(_480);
    float4 _484 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.2599999904632568359375), bias(View.View_MaterialTextureMipBias));
    float _486 = _484.x;
    float3 _487 = float3(_486);
    float4 _490 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.2400000095367431640625), bias(View.View_MaterialTextureMipBias));
    float _492 = _490.x;
    float3 _493 = float3(_492);
    float4 _496 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.10000002384185791015625), bias(View.View_MaterialTextureMipBias));
    float _498 = _496.x;
    float3 _499 = float3(_498);
    float3 _508 = normalize(_236 * normalize((mix(float4(_268, sqrt(fast::clamp(1.0 - dot(_268, _268), 0.0, 1.0)), 1.0).xyz, mix(float4(_284, sqrt(fast::clamp(1.0 - dot(_284, _284), 0.0, 1.0)), 1.0).xyz, mix(float4(_298, sqrt(fast::clamp(1.0 - dot(_298, _298), 0.0, 1.0)), 1.0).xyz, mix(float4(_312, sqrt(fast::clamp(1.0 - dot(_312, _312), 0.0, 1.0)), 1.0).xyz, mix(float4(_326, sqrt(fast::clamp(1.0 - dot(_326, _326), 0.0, 1.0)), 1.0).xyz, mix(float4(_340, sqrt(fast::clamp(1.0 - dot(_340, _340), 0.0, 1.0)), 1.0).xyz, mix(float4(_354, sqrt(fast::clamp(1.0 - dot(_354, _354), 0.0, 1.0)), 1.0).xyz, mix(float4(_368, sqrt(fast::clamp(1.0 - dot(_368, _368), 0.0, 1.0)), 1.0).xyz, mix(float4(_382, sqrt(fast::clamp(1.0 - dot(_382, _382), 0.0, 1.0)), 1.0).xyz, mix(float4(_396, sqrt(fast::clamp(1.0 - dot(_396, _396), 0.0, 1.0)), 1.0).xyz, mix(float4(_410, sqrt(fast::clamp(1.0 - dot(_410, _410), 0.0, 1.0)), 1.0).xyz, float4(_424, sqrt(fast::clamp(1.0 - dot(_424, _424), 0.0, 1.0)), 1.0).xyz, _439), _445), _451), _457), _463), _469), _475), _481), _487), _493), _499) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _519 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _529 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_279 * Material.Material_ScalarExpressions[0].y) + float2(0.800000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float4 _539 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_293 * Material.Material_ScalarExpressions[0].y) + float2(0.699999988079071044921875)), bias(View.View_MaterialTextureMipBias));
    float4 _549 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_307 * Material.Material_ScalarExpressions[0].y) + float2(0.60000002384185791015625)), bias(View.View_MaterialTextureMipBias));
    float4 _559 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_321 * Material.Material_ScalarExpressions[0].y) + float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float4 _565 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_335 * Material.Material_ScalarExpressions[0].y) + float2(0.4000000059604644775390625)), bias(View.View_MaterialTextureMipBias));
    float4 _571 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_349 * Material.Material_ScalarExpressions[0].y) + float2(0.300000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float4 _577 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_363 * Material.Material_ScalarExpressions[0].y) + float2(0.25)), bias(View.View_MaterialTextureMipBias));
    float4 _583 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_377 * Material.Material_ScalarExpressions[0].y) + float2(0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float4 _589 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_391 * Material.Material_ScalarExpressions[0].y) + float2(0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float4 _595 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_405 * Material.Material_ScalarExpressions[0].y) + float2(-0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float4 _601 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_419 * Material.Material_ScalarExpressions[0].y) + float2(-0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float4 _605 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _419, bias(View.View_MaterialTextureMipBias));
    float4 _609 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.97500002384185791015625), bias(View.View_MaterialTextureMipBias));
    float _610 = _609.x;
    float3 _636 = fast::clamp(mix(_519.xyz * 1.0, mix((_529.xyz * 1.5) * fast::min(fast::max(0.60000002384185791015625 + _492, -0.0), 1.0), mix((_539.xyz * 1.2000000476837158203125) * fast::min(fast::max(0.60000002384185791015625 + _486, -0.0), 1.0), mix((_549.xyz * 1.0) * fast::min(fast::max(0.60000002384185791015625 + _480, -0.0), 1.0), mix(_559.xyz * 0.699999988079071044921875, mix(_565.xyz * 0.60000002384185791015625, mix(_571.xyz * 0.5, mix(_577.xyz * 0.4000000059604644775390625, mix(_583.xyz * 0.300000011920928955078125, mix(_589.xyz * 0.20000000298023223876953125, mix(_595.xyz * 0.1500000059604644775390625, mix(_601.xyz * 0.13799999654293060302734375, _605.xyz * 0.300000011920928955078125, float3(_610)), _439), _445), _451), _457), _463), _469), _475), _481), _487), _493), _499), float3(0.0), float3(1.0));
    float _641 = (fast::clamp(mix(0.60000002384185791015625, 0.800000011920928955078125, ((((((((((_610 * _438) * _444) * _450) * _456) * _462) * _468) * _474) * _480) * _486) * _492) * _498), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _642 = in.in_var_PRIMITIVE_ID * 36u;
    uint _643 = _642 + 20u;
    float _691;
    float _692;
    float _693;
    float3 _694;
    float3 _695;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _643)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _661 = ((_247.xy / float2(_247.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _665 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _661, level(0.0));
        float4 _668 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _661, level(0.0));
        float4 _671 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _661, level(0.0));
        float _681 = _671.w;
        _691 = (_641 * _681) + _671.z;
        _692 = (0.4000000059604644775390625 * _681) + _671.y;
        _693 = _671.x;
        _694 = (_636 * _665.w) + _665.xyz;
        _695 = normalize((_508 * _668.w) + ((_668.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _691 = _641;
        _692 = 0.4000000059604644775390625;
        _693 = 0.0;
        _694 = _636;
        _695 = _508;
    }
    float4 _702 = LightmapResourceCluster_StaticShadowTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.zw);
    uint _703 = in.in_var_LIGHTMAP_ID * 15u;
    uint _704 = _703 + 1u;
    float4 _711 = fast::clamp((_702 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _704)]) + ((View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _704)] * (-0.5)) + float4(0.5)), float4(0.0), float4(1.0));
    float3 _728 = ((_694 - (_694 * _693)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _735 = (mix(float3(0.07999999821186065673828125 * _692), _694, float3(_693)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _738 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _743;
    if (_738)
    {
        _743 = _728 + (_735 * 0.449999988079071044921875);
    }
    else
    {
        _743 = _728;
    }
    float3 _745 = select(_735, float3(0.0), bool3(_738));
    float3 _747 = float3(dot(_745, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _762 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _766 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _762);
    float4 _768 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_762 + float2(0.0, 0.5)));
    uint _774 = _703 + 4u;
    uint _779 = _703 + 6u;
    float3 _784 = _766.xyz;
    float3 _812 = ((((_784 * _784) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _774)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _779)].xyz) * ((exp2(((_766.w + ((_768.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _774)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _779)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_768 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _703 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _703 + 7u)], float4(_695.yzx, 1.0))))) * View.View_IndirectLightingColorScale;
    float3 _834 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _863;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _862;
        if (any(abs(_257 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _642 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _642 + 19u)].xyz + float3(1.0))))
        {
            _862 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_257, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _862 = _834;
        }
        _863 = _862;
    }
    else
    {
        _863 = _834;
    }
    float4 _870 = float4(((mix(float3(0.0), _743 + (_745 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_812 * _743) * fast::max(float3(1.0), ((((((_694 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_694 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_694 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _863) * 1.0, 0.0);
    float4 _877;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _876 = _870;
        _876.w = 0.0;
        _877 = _876;
    }
    else
    {
        _877 = _870;
    }
    float2 _881 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _889 = (_695 * 0.5) + float3(0.5);
    float4 _891 = float4(_889.x, _889.y, _889.z, float4(0.0).w);
    _891.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _643)].y;
    float4 _892 = float4(0.0);
    _892.x = _693;
    float4 _893 = _892;
    _893.y = _692;
    float4 _894 = _893;
    _894.z = _691;
    float4 _895 = _894;
    _895.w = 0.50588238239288330078125;
    float4 _907 = float4(_694.x, _694.y, _694.z, float4(0.0).w);
    _907.w = ((log2(((dot(_812, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_747 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_747 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_747 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_881.xyx * _881.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _877 * View.View_PreExposure;
    out.out_var_SV_Target1 = _891;
    out.out_var_SV_Target2 = _895;
    out.out_var_SV_Target3 = _907;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = (View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _703)] * _711) * _711;
    return out;
}

