

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
    char _m14_pad[188];
    float View_ShowDecalsMask;
    char _m15_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m16_pad[48];
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

constant float _177 = {};

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

fragment MainPS_out Main_000054b5_43cb457b(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float3x3 _221 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _232 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _177, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _237 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _241 = _237.xyz / float3(_237.w);
    float3 _242 = _241 - View.View_PreViewTranslation;
    float4 _250 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _253 = (_250.xy * float2(2.0)) - float2(1.0);
    float2 _262 = (normalize(-_241) * _221).xy;
    float2 _264 = (_262 * (-0.00310000008903443813323974609375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _266 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _264, bias(View.View_MaterialTextureMipBias));
    float2 _269 = (_266.xy * float2(2.0)) - float2(1.0);
    float2 _278 = (_262 * (-0.0062000001780688762664794921875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _280 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _278, bias(View.View_MaterialTextureMipBias));
    float2 _283 = (_280.xy * float2(2.0)) - float2(1.0);
    float2 _292 = (_262 * (-0.009300000034272670745849609375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _294 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _292, bias(View.View_MaterialTextureMipBias));
    float2 _297 = (_294.xy * float2(2.0)) - float2(1.0);
    float2 _306 = (_262 * (-0.012400000356137752532958984375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _308 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _306, bias(View.View_MaterialTextureMipBias));
    float2 _311 = (_308.xy * float2(2.0)) - float2(1.0);
    float2 _320 = (_262 * (-0.01549999974668025970458984375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _322 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _320, bias(View.View_MaterialTextureMipBias));
    float2 _325 = (_322.xy * float2(2.0)) - float2(1.0);
    float2 _334 = (_262 * (-0.01860000006854534149169921875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _336 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _334, bias(View.View_MaterialTextureMipBias));
    float2 _339 = (_336.xy * float2(2.0)) - float2(1.0);
    float2 _348 = (_262 * (-0.02170000039041042327880859375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _350 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _348, bias(View.View_MaterialTextureMipBias));
    float2 _353 = (_350.xy * float2(2.0)) - float2(1.0);
    float2 _362 = (_262 * (-0.02542000077664852142333984375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _364 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _362, bias(View.View_MaterialTextureMipBias));
    float2 _367 = (_364.xy * float2(2.0)) - float2(1.0);
    float2 _376 = (_262 * (-0.0291399993002414703369140625)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _378 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _376, bias(View.View_MaterialTextureMipBias));
    float2 _381 = (_378.xy * float2(2.0)) - float2(1.0);
    float2 _390 = (_262 * (-0.0340999998152256011962890625)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _392 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _390, bias(View.View_MaterialTextureMipBias));
    float2 _395 = (_392.xy * float2(2.0)) - float2(1.0);
    float2 _404 = (_262 * (-0.039680004119873046875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _406 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _404, bias(View.View_MaterialTextureMipBias));
    float2 _409 = (_406.xy * float2(2.0)) - float2(1.0);
    float4 _420 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.949999988079071044921875), bias(View.View_MaterialTextureMipBias));
    float _423 = _420.x;
    float3 _424 = float3(_423);
    float4 _427 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.89999997615814208984375), bias(View.View_MaterialTextureMipBias));
    float _429 = _427.x;
    float3 _430 = float3(_429);
    float4 _433 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.800000011920928955078125), bias(View.View_MaterialTextureMipBias));
    float _435 = _433.x;
    float3 _436 = float3(_435);
    float4 _439 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.699999988079071044921875), bias(View.View_MaterialTextureMipBias));
    float _441 = _439.x;
    float3 _442 = float3(_441);
    float4 _445 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.60000002384185791015625), bias(View.View_MaterialTextureMipBias));
    float _447 = _445.x;
    float3 _448 = float3(_447);
    float4 _451 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.5), bias(View.View_MaterialTextureMipBias));
    float _453 = _451.x;
    float3 _454 = float3(_453);
    float4 _457 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.39999997615814208984375), bias(View.View_MaterialTextureMipBias));
    float _459 = _457.x;
    float3 _460 = float3(_459);
    float4 _463 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.300000011920928955078125), bias(View.View_MaterialTextureMipBias));
    float _465 = _463.x;
    float3 _466 = float3(_465);
    float4 _469 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.2599999904632568359375), bias(View.View_MaterialTextureMipBias));
    float _471 = _469.x;
    float3 _472 = float3(_471);
    float4 _475 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.2400000095367431640625), bias(View.View_MaterialTextureMipBias));
    float _477 = _475.x;
    float3 _478 = float3(_477);
    float4 _481 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.10000002384185791015625), bias(View.View_MaterialTextureMipBias));
    float _483 = _481.x;
    float3 _484 = float3(_483);
    float3 _493 = normalize(_221 * normalize((mix(float4(_253, sqrt(fast::clamp(1.0 - dot(_253, _253), 0.0, 1.0)), 1.0).xyz, mix(float4(_269, sqrt(fast::clamp(1.0 - dot(_269, _269), 0.0, 1.0)), 1.0).xyz, mix(float4(_283, sqrt(fast::clamp(1.0 - dot(_283, _283), 0.0, 1.0)), 1.0).xyz, mix(float4(_297, sqrt(fast::clamp(1.0 - dot(_297, _297), 0.0, 1.0)), 1.0).xyz, mix(float4(_311, sqrt(fast::clamp(1.0 - dot(_311, _311), 0.0, 1.0)), 1.0).xyz, mix(float4(_325, sqrt(fast::clamp(1.0 - dot(_325, _325), 0.0, 1.0)), 1.0).xyz, mix(float4(_339, sqrt(fast::clamp(1.0 - dot(_339, _339), 0.0, 1.0)), 1.0).xyz, mix(float4(_353, sqrt(fast::clamp(1.0 - dot(_353, _353), 0.0, 1.0)), 1.0).xyz, mix(float4(_367, sqrt(fast::clamp(1.0 - dot(_367, _367), 0.0, 1.0)), 1.0).xyz, mix(float4(_381, sqrt(fast::clamp(1.0 - dot(_381, _381), 0.0, 1.0)), 1.0).xyz, mix(float4(_395, sqrt(fast::clamp(1.0 - dot(_395, _395), 0.0, 1.0)), 1.0).xyz, float4(_409, sqrt(fast::clamp(1.0 - dot(_409, _409), 0.0, 1.0)), 1.0).xyz, _424), _430), _436), _442), _448), _454), _460), _466), _472), _478), _484) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _504 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _514 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_264 * Material.Material_ScalarExpressions[0].y) + float2(0.800000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float4 _524 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_278 * Material.Material_ScalarExpressions[0].y) + float2(0.699999988079071044921875)), bias(View.View_MaterialTextureMipBias));
    float4 _534 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_292 * Material.Material_ScalarExpressions[0].y) + float2(0.60000002384185791015625)), bias(View.View_MaterialTextureMipBias));
    float4 _544 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_306 * Material.Material_ScalarExpressions[0].y) + float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float4 _550 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_320 * Material.Material_ScalarExpressions[0].y) + float2(0.4000000059604644775390625)), bias(View.View_MaterialTextureMipBias));
    float4 _556 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_334 * Material.Material_ScalarExpressions[0].y) + float2(0.300000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float4 _562 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_348 * Material.Material_ScalarExpressions[0].y) + float2(0.25)), bias(View.View_MaterialTextureMipBias));
    float4 _568 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_362 * Material.Material_ScalarExpressions[0].y) + float2(0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float4 _574 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_376 * Material.Material_ScalarExpressions[0].y) + float2(0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float4 _580 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_390 * Material.Material_ScalarExpressions[0].y) + float2(-0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float4 _586 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_404 * Material.Material_ScalarExpressions[0].y) + float2(-0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float4 _590 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _404, bias(View.View_MaterialTextureMipBias));
    float4 _594 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.97500002384185791015625), bias(View.View_MaterialTextureMipBias));
    float _595 = _594.x;
    float3 _621 = fast::clamp(mix(_504.xyz * 1.0, mix((_514.xyz * 1.5) * fast::min(fast::max(0.60000002384185791015625 + _477, -0.0), 1.0), mix((_524.xyz * 1.2000000476837158203125) * fast::min(fast::max(0.60000002384185791015625 + _471, -0.0), 1.0), mix((_534.xyz * 1.0) * fast::min(fast::max(0.60000002384185791015625 + _465, -0.0), 1.0), mix(_544.xyz * 0.699999988079071044921875, mix(_550.xyz * 0.60000002384185791015625, mix(_556.xyz * 0.5, mix(_562.xyz * 0.4000000059604644775390625, mix(_568.xyz * 0.300000011920928955078125, mix(_574.xyz * 0.20000000298023223876953125, mix(_580.xyz * 0.1500000059604644775390625, mix(_586.xyz * 0.13799999654293060302734375, _590.xyz * 0.300000011920928955078125, float3(_595)), _424), _430), _436), _442), _448), _454), _460), _466), _472), _478), _484), float3(0.0), float3(1.0));
    float _626 = (fast::clamp(mix(0.60000002384185791015625, 0.800000011920928955078125, ((((((((((_595 * _423) * _429) * _435) * _441) * _447) * _453) * _459) * _465) * _471) * _477) * _483), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _627 = in.in_var_PRIMITIVE_ID * 36u;
    uint _628 = _627 + 20u;
    float _676;
    float _677;
    float _678;
    float3 _679;
    float3 _680;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _628)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _646 = ((_232.xy / float2(_232.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _650 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _646, level(0.0));
        float4 _653 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _646, level(0.0));
        float4 _656 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _646, level(0.0));
        float _666 = _656.w;
        _676 = (_626 * _666) + _656.z;
        _677 = (0.4000000059604644775390625 * _666) + _656.y;
        _678 = _656.x;
        _679 = (_621 * _650.w) + _650.xyz;
        _680 = normalize((_493 * _653.w) + ((_653.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _676 = _626;
        _677 = 0.4000000059604644775390625;
        _678 = 0.0;
        _679 = _621;
        _680 = _493;
    }
    float _729;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _628)].z > 0.0)
    {
        float3 _697 = fast::clamp((_242 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _708 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_697.x), int(_697.y), int(_697.z), 0).xyz), 0));
        _729 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_708.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_697 / float3(_708.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _729 = 1.0;
    }
    float3 _743 = ((_679 - (_679 * _678)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _750 = (mix(float3(0.07999999821186065673828125 * _677), _679, float3(_678)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _753 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _758;
    if (_753)
    {
        _758 = _743 + (_750 * 0.449999988079071044921875);
    }
    else
    {
        _758 = _743;
    }
    float3 _767 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _796;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _795;
        if (any(abs(_242 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _627 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _627 + 19u)].xyz + float3(1.0))))
        {
            _795 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_242, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _795 = _767;
        }
        _796 = _795;
    }
    else
    {
        _796 = _767;
    }
    float4 _802 = float4((mix(float3(0.0), _758 + (select(_750, float3(0.0), bool3(_753)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + _796) * 1.0, 0.0);
    float4 _809;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _808 = _802;
        _808.w = 0.0;
        _809 = _808;
    }
    else
    {
        _809 = _802;
    }
    float2 _813 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _821 = (_680 * 0.5) + float3(0.5);
    float4 _823 = float4(_821.x, _821.y, _821.z, float4(0.0).w);
    _823.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _628)].y;
    float4 _824 = float4(0.0);
    _824.x = _678;
    float4 _825 = _824;
    _825.y = _677;
    float4 _826 = _825;
    _826.z = _676;
    float4 _827 = _826;
    _827.w = 0.50588238239288330078125;
    float4 _830 = float4(_679.x, _679.y, _679.z, float4(0.0).w);
    _830.w = (fract(dot(_813.xyx * _813.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _809 * View.View_PreExposure;
    out.out_var_SV_Target1 = _823;
    out.out_var_SV_Target2 = _827;
    out.out_var_SV_Target3 = _830;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_729, 1.0, 1.0, 1.0);
    return out;
}

