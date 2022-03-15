

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

constant float4 _201 = {};
constant float _217 = {};
constant float4 _218 = {};

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

fragment MainPS_out Main_000068ef_73f3dd44(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(11)]], texture2d<float> Material_Texture2D_0 [[texture(12)]], texture2d<float> Material_Texture2D_1 [[texture(13)]], texture2d<float> Material_Texture2D_2 [[texture(14)]], texture2d<float> Material_Texture2D_3 [[texture(15)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float3x3 _263 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _274 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _217, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _279 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _283 = _279.xyz / float3(_279.w);
    float3 _284 = _283 - View.View_PreViewTranslation;
    float4 _292 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _295 = (_292.xy * float2(2.0)) - float2(1.0);
    float2 _304 = (normalize(-_283) * _263).xy;
    float2 _306 = (_304 * (-0.00310000008903443813323974609375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _308 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _306, bias(View.View_MaterialTextureMipBias));
    float2 _311 = (_308.xy * float2(2.0)) - float2(1.0);
    float2 _320 = (_304 * (-0.0062000001780688762664794921875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _322 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _320, bias(View.View_MaterialTextureMipBias));
    float2 _325 = (_322.xy * float2(2.0)) - float2(1.0);
    float2 _334 = (_304 * (-0.009300000034272670745849609375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _336 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _334, bias(View.View_MaterialTextureMipBias));
    float2 _339 = (_336.xy * float2(2.0)) - float2(1.0);
    float2 _348 = (_304 * (-0.012400000356137752532958984375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _350 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _348, bias(View.View_MaterialTextureMipBias));
    float2 _353 = (_350.xy * float2(2.0)) - float2(1.0);
    float2 _362 = (_304 * (-0.01549999974668025970458984375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _364 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _362, bias(View.View_MaterialTextureMipBias));
    float2 _367 = (_364.xy * float2(2.0)) - float2(1.0);
    float2 _376 = (_304 * (-0.01860000006854534149169921875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _378 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _376, bias(View.View_MaterialTextureMipBias));
    float2 _381 = (_378.xy * float2(2.0)) - float2(1.0);
    float2 _390 = (_304 * (-0.02170000039041042327880859375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _392 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _390, bias(View.View_MaterialTextureMipBias));
    float2 _395 = (_392.xy * float2(2.0)) - float2(1.0);
    float2 _404 = (_304 * (-0.02542000077664852142333984375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _406 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _404, bias(View.View_MaterialTextureMipBias));
    float2 _409 = (_406.xy * float2(2.0)) - float2(1.0);
    float2 _418 = (_304 * (-0.0291399993002414703369140625)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _420 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _418, bias(View.View_MaterialTextureMipBias));
    float2 _423 = (_420.xy * float2(2.0)) - float2(1.0);
    float2 _432 = (_304 * (-0.0340999998152256011962890625)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _434 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _432, bias(View.View_MaterialTextureMipBias));
    float2 _437 = (_434.xy * float2(2.0)) - float2(1.0);
    float2 _446 = (_304 * (-0.039680004119873046875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _448 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _446, bias(View.View_MaterialTextureMipBias));
    float2 _451 = (_448.xy * float2(2.0)) - float2(1.0);
    float4 _462 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.949999988079071044921875), bias(View.View_MaterialTextureMipBias));
    float _465 = _462.x;
    float3 _466 = float3(_465);
    float4 _469 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.89999997615814208984375), bias(View.View_MaterialTextureMipBias));
    float _471 = _469.x;
    float3 _472 = float3(_471);
    float4 _475 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.800000011920928955078125), bias(View.View_MaterialTextureMipBias));
    float _477 = _475.x;
    float3 _478 = float3(_477);
    float4 _481 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.699999988079071044921875), bias(View.View_MaterialTextureMipBias));
    float _483 = _481.x;
    float3 _484 = float3(_483);
    float4 _487 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.60000002384185791015625), bias(View.View_MaterialTextureMipBias));
    float _489 = _487.x;
    float3 _490 = float3(_489);
    float4 _493 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.5), bias(View.View_MaterialTextureMipBias));
    float _495 = _493.x;
    float3 _496 = float3(_495);
    float4 _499 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.39999997615814208984375), bias(View.View_MaterialTextureMipBias));
    float _501 = _499.x;
    float3 _502 = float3(_501);
    float4 _505 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.300000011920928955078125), bias(View.View_MaterialTextureMipBias));
    float _507 = _505.x;
    float3 _508 = float3(_507);
    float4 _511 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.2599999904632568359375), bias(View.View_MaterialTextureMipBias));
    float _513 = _511.x;
    float3 _514 = float3(_513);
    float4 _517 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.2400000095367431640625), bias(View.View_MaterialTextureMipBias));
    float _519 = _517.x;
    float3 _520 = float3(_519);
    float4 _523 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.10000002384185791015625), bias(View.View_MaterialTextureMipBias));
    float _525 = _523.x;
    float3 _526 = float3(_525);
    float3 _535 = normalize(_263 * normalize((mix(float4(_295, sqrt(fast::clamp(1.0 - dot(_295, _295), 0.0, 1.0)), 1.0).xyz, mix(float4(_311, sqrt(fast::clamp(1.0 - dot(_311, _311), 0.0, 1.0)), 1.0).xyz, mix(float4(_325, sqrt(fast::clamp(1.0 - dot(_325, _325), 0.0, 1.0)), 1.0).xyz, mix(float4(_339, sqrt(fast::clamp(1.0 - dot(_339, _339), 0.0, 1.0)), 1.0).xyz, mix(float4(_353, sqrt(fast::clamp(1.0 - dot(_353, _353), 0.0, 1.0)), 1.0).xyz, mix(float4(_367, sqrt(fast::clamp(1.0 - dot(_367, _367), 0.0, 1.0)), 1.0).xyz, mix(float4(_381, sqrt(fast::clamp(1.0 - dot(_381, _381), 0.0, 1.0)), 1.0).xyz, mix(float4(_395, sqrt(fast::clamp(1.0 - dot(_395, _395), 0.0, 1.0)), 1.0).xyz, mix(float4(_409, sqrt(fast::clamp(1.0 - dot(_409, _409), 0.0, 1.0)), 1.0).xyz, mix(float4(_423, sqrt(fast::clamp(1.0 - dot(_423, _423), 0.0, 1.0)), 1.0).xyz, mix(float4(_437, sqrt(fast::clamp(1.0 - dot(_437, _437), 0.0, 1.0)), 1.0).xyz, float4(_451, sqrt(fast::clamp(1.0 - dot(_451, _451), 0.0, 1.0)), 1.0).xyz, _466), _472), _478), _484), _490), _496), _502), _508), _514), _520), _526) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _546 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _556 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_306 * Material.Material_ScalarExpressions[0].y) + float2(0.800000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float4 _566 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_320 * Material.Material_ScalarExpressions[0].y) + float2(0.699999988079071044921875)), bias(View.View_MaterialTextureMipBias));
    float4 _576 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_334 * Material.Material_ScalarExpressions[0].y) + float2(0.60000002384185791015625)), bias(View.View_MaterialTextureMipBias));
    float4 _586 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_348 * Material.Material_ScalarExpressions[0].y) + float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float4 _592 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_362 * Material.Material_ScalarExpressions[0].y) + float2(0.4000000059604644775390625)), bias(View.View_MaterialTextureMipBias));
    float4 _598 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_376 * Material.Material_ScalarExpressions[0].y) + float2(0.300000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float4 _604 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_390 * Material.Material_ScalarExpressions[0].y) + float2(0.25)), bias(View.View_MaterialTextureMipBias));
    float4 _610 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_404 * Material.Material_ScalarExpressions[0].y) + float2(0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float4 _616 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_418 * Material.Material_ScalarExpressions[0].y) + float2(0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float4 _622 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_432 * Material.Material_ScalarExpressions[0].y) + float2(-0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float4 _628 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_446 * Material.Material_ScalarExpressions[0].y) + float2(-0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float4 _632 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _446, bias(View.View_MaterialTextureMipBias));
    float4 _636 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.97500002384185791015625), bias(View.View_MaterialTextureMipBias));
    float _637 = _636.x;
    float3 _663 = fast::clamp(mix(_546.xyz * 1.0, mix((_556.xyz * 1.5) * fast::min(fast::max(0.60000002384185791015625 + _519, -0.0), 1.0), mix((_566.xyz * 1.2000000476837158203125) * fast::min(fast::max(0.60000002384185791015625 + _513, -0.0), 1.0), mix((_576.xyz * 1.0) * fast::min(fast::max(0.60000002384185791015625 + _507, -0.0), 1.0), mix(_586.xyz * 0.699999988079071044921875, mix(_592.xyz * 0.60000002384185791015625, mix(_598.xyz * 0.5, mix(_604.xyz * 0.4000000059604644775390625, mix(_610.xyz * 0.300000011920928955078125, mix(_616.xyz * 0.20000000298023223876953125, mix(_622.xyz * 0.1500000059604644775390625, mix(_628.xyz * 0.13799999654293060302734375, _632.xyz * 0.300000011920928955078125, float3(_637)), _466), _472), _478), _484), _490), _496), _502), _508), _514), _520), _526), float3(0.0), float3(1.0));
    float _668 = (fast::clamp(mix(0.60000002384185791015625, 0.800000011920928955078125, ((((((((((_637 * _465) * _471) * _477) * _483) * _489) * _495) * _501) * _507) * _513) * _519) * _525), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _669 = in.in_var_PRIMITIVE_ID * 36u;
    uint _670 = _669 + 20u;
    float _718;
    float _719;
    float _720;
    float3 _721;
    float3 _722;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _670)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _688 = ((_274.xy / float2(_274.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _692 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _688, level(0.0));
        float4 _695 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _688, level(0.0));
        float4 _698 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _688, level(0.0));
        float _708 = _698.w;
        _718 = (_668 * _708) + _698.z;
        _719 = (0.4000000059604644775390625 * _708) + _698.y;
        _720 = _698.x;
        _721 = (_663 * _692.w) + _692.xyz;
        _722 = normalize((_535 * _695.w) + ((_695.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _718 = _668;
        _719 = 0.4000000059604644775390625;
        _720 = 0.0;
        _721 = _663;
        _722 = _535;
    }
    float3 _732 = fast::clamp((_284 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _743 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_732.x), int(_732.y), int(_732.z), 0).xyz), 0));
    float3 _758 = (((_743.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_732 / float3(_743.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _771;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _670)].z > 0.0)
    {
        _771 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _758, level(0.0)).x;
    }
    else
    {
        _771 = 1.0;
    }
    float3 _785 = ((_721 - (_721 * _720)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _792 = (mix(float3(0.07999999821186065673828125 * _719), _721, float3(_720)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _795 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _800;
    if (_795)
    {
        _800 = _785 + (_792 * 0.449999988079071044921875);
    }
    else
    {
        _800 = _785;
    }
    float3 _802 = select(_792, float3(0.0), bool3(_795));
    float3 _804 = float3(dot(_802, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _821 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _758, level(0.0));
    float _837 = _821.x;
    float4 _839 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _758, level(0.0)) * 2.0) - float4(1.0)) * _837) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _840 = _821.y;
    float4 _842 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _758, level(0.0)) * 2.0) - float4(1.0)) * _840) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _843 = _821.z;
    float4 _845 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _758, level(0.0)) * 2.0) - float4(1.0)) * _843) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _862 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _758, level(0.0)) * 2.0) - float4(1.0)) * _837) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _864 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _758, level(0.0)) * 2.0) - float4(1.0)) * _840) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _866 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _758, level(0.0)) * 2.0) - float4(1.0)) * _843) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _899 = _218;
    _899.y = (-0.48860299587249755859375) * _722.y;
    float4 _902 = _899;
    _902.z = 0.48860299587249755859375 * _722.z;
    float4 _905 = _902;
    _905.w = (-0.48860299587249755859375) * _722.x;
    float3 _906 = _722 * _722;
    float4 _909 = _201;
    _909.x = (1.09254801273345947265625 * _722.x) * _722.y;
    float4 _912 = _909;
    _912.y = ((-1.09254801273345947265625) * _722.y) * _722.z;
    float4 _917 = _912;
    _917.z = 0.3153919875621795654296875 * ((3.0 * _906.z) - 1.0);
    float4 _920 = _917;
    _920.w = ((-1.09254801273345947265625) * _722.x) * _722.z;
    float4 _924 = _905;
    _924.x = 0.886227548122406005859375;
    float3 _926 = _924.yzw * 2.094395160675048828125;
    float4 _927 = float4(_924.x, _926.x, _926.y, _926.z);
    float4 _928 = _920 * 0.785398185253143310546875;
    float _929 = (_906.x - _906.y) * 0.4290426075458526611328125;
    float3 _935 = float3(0.0);
    _935.x = (dot(float4(_837, _839.xyz), _927) + dot(float4(_839.w, _862.xyz), _928)) + (_862.w * _929);
    float3 _941 = _935;
    _941.y = (dot(float4(_840, _842.xyz), _927) + dot(float4(_842.w, _864.xyz), _928)) + (_864.w * _929);
    float3 _947 = _941;
    _947.z = (dot(float4(_843, _845.xyz), _927) + dot(float4(_845.w, _866.xyz), _928)) + (_866.w * _929);
    float3 _952 = (fast::max(float3(0.0), _947) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    float3 _974 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _1003;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _1002;
        if (any(abs(_284 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _669 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _669 + 19u)].xyz + float3(1.0))))
        {
            _1002 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_284, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _1002 = _974;
        }
        _1003 = _1002;
    }
    else
    {
        _1003 = _974;
    }
    float4 _1010 = float4(((mix(float3(0.0), _800 + (_802 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_952 * _800) * fast::max(float3(1.0), ((((((_721 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_721 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_721 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _1003) * 1.0, 0.0);
    float4 _1017;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _1016 = _1010;
        _1016.w = 0.0;
        _1017 = _1016;
    }
    else
    {
        _1017 = _1010;
    }
    float2 _1021 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _1029 = (_722 * 0.5) + float3(0.5);
    float4 _1031 = float4(_1029.x, _1029.y, _1029.z, float4(0.0).w);
    _1031.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _670)].y;
    float4 _1032 = float4(0.0);
    _1032.x = _720;
    float4 _1033 = _1032;
    _1033.y = _719;
    float4 _1034 = _1033;
    _1034.z = _718;
    float4 _1035 = _1034;
    _1035.w = 0.50588238239288330078125;
    float4 _1047 = float4(_721.x, _721.y, _721.z, float4(0.0).w);
    _1047.w = ((log2(((dot(_952, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_804 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_804 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_804 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_1021.xyx * _1021.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _1017 * View.View_PreExposure;
    out.out_var_SV_Target1 = _1031;
    out.out_var_SV_Target2 = _1035;
    out.out_var_SV_Target3 = _1047;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_771, 1.0, 1.0, 1.0);
    return out;
}

