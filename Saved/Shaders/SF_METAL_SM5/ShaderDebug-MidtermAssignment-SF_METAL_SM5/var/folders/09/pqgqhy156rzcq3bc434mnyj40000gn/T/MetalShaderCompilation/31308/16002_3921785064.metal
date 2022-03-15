

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
    char _m0_pad[448];
    float4x4 View_ViewToClip;
    char _m1_pad[192];
    float4x4 View_SVPositionToTranslatedWorld;
    char _m2_pad[272];
    float4 View_InvDeviceZToWorldZTransform;
    float4 View_ScreenPositionScaleBias;
    char _m4_pad[48];
    float3 View_PreViewTranslation;
    char _m5_pad[928];
    float4 View_ViewRectMin;
    float4 View_ViewSizeAndInvSize;
    char _m7_pad[68];
    float View_PreExposure;
    float4 View_DiffuseOverrideParameter;
    float4 View_SpecularOverrideParameter;
    float4 View_NormalOverrideParameter;
    float2 View_RoughnessOverrideParameter;
    char _m12_pad[8];
    float View_OutOfBoundsMask;
    char _m13_pad[48];
    float View_MaterialTextureMipBias;
    char _m14_pad[28];
    float View_UnlitViewmodeMask;
    char _m15_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m16_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m17_pad[48];
    float4 View_SkyLightColor;
    char _m18_pad[124];
    float View_ShowDecalsMask;
    char _m19_pad[184];
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

constant float3 _156 = {};

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

fragment MainPS_out Main_00003e82_e9c1b0e8(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> Material_Texture2D_0 [[texture(4)]], texture2d<float> Material_Texture2D_1 [[texture(5)]], texture2d<float> Material_Texture2D_2 [[texture(6)]], texture2d<float> Material_Texture2D_3 [[texture(7)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _212 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _216 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _221 = (_216.xyz / float3(_216.w)) - View.View_PreViewTranslation;
    float4 _227 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _230 = (_227.xy * float2(2.0)) - float2(1.0);
    float4 _242 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _269;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _269 = _212.w;
                break;
            }
            else
            {
                float _253 = _212.z;
                _269 = ((_253 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_253 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _285 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(float4(_230, sqrt(fast::clamp(1.0 - dot(_230, _230), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _242.x) + _269) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _297 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _302 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _307 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _311 = (_297.x + 0.5) * ((_302.x + 0.5) * (_307.x + 0.5));
    float4 _317 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _323 = fast::clamp(mix(float3(0.20000000298023223876953125), float3(1.0), float3(_311)) * _317.xyz, float3(0.0), float3(1.0));
    float _328 = (fast::clamp(mix(0.4000000059604644775390625, 0.800000011920928955078125, _311 * _317.w), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _329 = in.in_var_PRIMITIVE_ID * 36u;
    uint _330 = _329 + 20u;
    float _378;
    float _379;
    float _380;
    float3 _381;
    float3 _382;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _330)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _348 = ((_212.xy / float2(_212.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _352 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _348, level(0.0));
        float4 _355 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _348, level(0.0));
        float4 _358 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _348, level(0.0));
        float _368 = _358.w;
        _378 = (_328 * _368) + _358.z;
        _379 = (0.5 * _368) + _358.y;
        _380 = _358.x;
        _381 = (_323 * _352.w) + _352.xyz;
        _382 = normalize((_285 * _355.w) + ((_355.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _378 = _328;
        _379 = 0.5;
        _380 = 0.0;
        _381 = _323;
        _382 = _285;
    }
    float3 _397 = ((_381 - (_381 * _380)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _404 = (mix(float3(0.07999999821186065673828125 * _379), _381, float3(_380)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _407 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _412;
    if (_407)
    {
        _412 = _397 + (_404 * 0.449999988079071044921875);
    }
    else
    {
        _412 = _397;
    }
    float3 _414 = select(_404, float3(0.0), bool3(_407));
    float3 _416 = float3(dot(_414, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _431 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _436 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _431);
    float4 _438 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_431 + float2(0.0, 0.5)));
    uint _440 = in.in_var_LIGHTMAP_ID * 15u;
    float3 _450 = (_436.xyz * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _440 + 4u)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _440 + 6u)].xyz;
    float _451 = dot(_450, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float _470 = (exp2((_451 * 16.0) - 8.0) - 0.00390625) * fast::max(0.0, dot((_438 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _440 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _440 + 7u)], float4(_382.yzx, 1.0)));
    float4 _481 = float4(_382, 1.0);
    float3 _485 = _156;
    _485.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _481);
    float3 _489 = _485;
    _489.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _481);
    float3 _493 = _489;
    _493.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _481);
    float4 _496 = _481.xyzz * _481.yzzx;
    float3 _500 = _156;
    _500.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _496);
    float3 _504 = _500;
    _504.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _496);
    float3 _508 = _504;
    _508.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _496);
    float3 _522 = (float4(_450 * (_470 / _451), _470).xyz * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_493 + _508) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_382.x * _382.x) - (_382.y * _382.y)))) * View.View_SkyLightColor.xyz) * 1.0);
    float3 _544 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _573;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _572;
        if (any(abs(_221 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _329 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _329 + 19u)].xyz + float3(1.0))))
        {
            _572 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_221, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _572 = _544;
        }
        _573 = _572;
    }
    else
    {
        _573 = _544;
    }
    float4 _580 = float4(((mix(float3(0.0), _412 + (_414 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_522 * _412) * fast::max(float3(1.0), ((((((_381 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_381 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_381 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _573) * 1.0, 0.0);
    float4 _587;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _586 = _580;
        _586.w = 0.0;
        _587 = _586;
    }
    else
    {
        _587 = _580;
    }
    float2 _591 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _599 = (_382 * 0.5) + float3(0.5);
    float4 _601 = float4(_599.x, _599.y, _599.z, float4(0.0).w);
    _601.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _330)].y;
    float4 _602 = float4(0.0);
    _602.x = _380;
    float4 _603 = _602;
    _603.y = _379;
    float4 _604 = _603;
    _604.z = _378;
    float4 _605 = _604;
    _605.w = 0.75686275959014892578125;
    float4 _617 = float4(_381.x, _381.y, _381.z, float4(0.0).w);
    _617.w = ((log2(((dot(_522, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_416 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_416 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_416 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_591.xyx * _591.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _587 * View.View_PreExposure;
    out.out_var_SV_Target1 = _601;
    out.out_var_SV_Target2 = _605;
    out.out_var_SV_Target3 = _617;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

