

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
    char _m17_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m19_pad[124];
    float View_ShowDecalsMask;
    char _m20_pad[184];
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

constant float3 _155 = {};

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

fragment MainPS_out Main_0000435a_b9e9fd31(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], texture2d<float> LightmapResourceCluster_StaticShadowTexture [[texture(5)]], texture2d<float> Material_Texture2D_0 [[texture(6)]], texture2d<float> Material_Texture2D_1 [[texture(7)]], texture2d<float> Material_Texture2D_2 [[texture(8)]], texture2d<float> Material_Texture2D_3 [[texture(9)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _211 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _215 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _220 = (_215.xyz / float3(_215.w)) - View.View_PreViewTranslation;
    float2 _221 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5;
    float4 _227 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _221, bias(View.View_MaterialTextureMipBias));
    float2 _230 = (_227.xy * float2(2.0)) - float2(1.0);
    float4 _242 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _269;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _269 = _211.w;
                break;
            }
            else
            {
                float _253 = _211.z;
                _269 = ((_253 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_253 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _274 = fast::min(fast::max(((mix(-2000.0, 2000.0, _242.x) + _269) - 500.0) * 0.0005000000237487256526947021484375, 0.0), 1.0);
    float3 _285 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(float4(_230, sqrt(fast::clamp(1.0 - dot(_230, _230), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), float3(_274)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _296 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _221, bias(View.View_MaterialTextureMipBias));
    float4 _300 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _221, bias(View.View_MaterialTextureMipBias));
    float3 _306 = fast::clamp(_296.xyz, float3(0.0), float3(1.0));
    float _307 = fast::clamp(_296.x, 0.0, 1.0);
    float _308 = fast::clamp(_300.w, 0.0, 1.0);
    float _313 = (fast::clamp(mix(_300.x, 0.300000011920928955078125, _274), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _314 = in.in_var_PRIMITIVE_ID * 36u;
    uint _315 = _314 + 20u;
    float _363;
    float _364;
    float _365;
    float3 _366;
    float3 _367;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _315)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _333 = ((_211.xy / float2(_211.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _337 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _333, level(0.0));
        float4 _340 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _333, level(0.0));
        float4 _343 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _333, level(0.0));
        float _353 = _343.w;
        _363 = (_313 * _353) + _343.z;
        _364 = (_307 * _353) + _343.y;
        _365 = _343.x;
        _366 = (_306 * _337.w) + _337.xyz;
        _367 = normalize((_285 * _340.w) + ((_340.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _363 = _313;
        _364 = _307;
        _365 = 0.0;
        _366 = _306;
        _367 = _285;
    }
    float4 _374 = LightmapResourceCluster_StaticShadowTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.zw);
    uint _375 = in.in_var_LIGHTMAP_ID * 15u;
    uint _376 = _375 + 1u;
    float4 _383 = fast::clamp((_374 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _376)]) + ((View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _376)] * (-0.5)) + float4(0.5)), float4(0.0), float4(1.0));
    float3 _400 = ((_366 - (_366 * _365)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _407 = (mix(float3(0.07999999821186065673828125 * _364), _366, float3(_365)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _410 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _415;
    if (_410)
    {
        _415 = _400 + (_407 * 0.449999988079071044921875);
    }
    else
    {
        _415 = _400;
    }
    float3 _417 = select(_407, float3(0.0), bool3(_410));
    float3 _419 = float3(dot(_417, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _426 = float3(_308);
    float2 _435 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _439 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _435);
    float4 _441 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_435 + float2(0.0, 0.5)));
    uint _447 = _375 + 4u;
    uint _452 = _375 + 6u;
    float3 _457 = _439.xyz;
    float _509;
    float _510;
    float3 _511;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _493 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _497 = _493.w;
        float _498 = _497 * _497;
        float3 _500 = normalize(((_493.xyz * 2.0) - float3(1.0)).xyz);
        float _501 = 1.0 - _498;
        float _503 = 1.0 - (_501 * _501);
        _509 = mix(fast::clamp(dot(_500, _367), 0.0, 1.0), 1.0, _503);
        _510 = _498;
        _511 = mix(_500, _367, float3(_503));
    }
    else
    {
        _509 = 1.0;
        _510 = 1.0;
        _511 = _367;
    }
    float4 _515 = float4(_511, 1.0);
    float3 _519 = _155;
    _519.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _515);
    float3 _523 = _519;
    _523.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _515);
    float3 _527 = _523;
    _527.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _515);
    float4 _530 = _515.xyzz * _515.yzzx;
    float3 _534 = _155;
    _534.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _530);
    float3 _538 = _534;
    _538.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _530);
    float3 _542 = _538;
    _542.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _530);
    float3 _557 = (((((_457 * _457) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _447)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _452)].xyz) * ((exp2(((_439.w + ((_441.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _447)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _452)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_441 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _375 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _375 + 7u)], float4(_367.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_527 + _542) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_511.x * _511.x) - (_511.y * _511.y)))) * View.View_SkyLightColor.xyz) * (_510 * _509));
    float3 _579 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _608;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _607;
        if (any(abs(_220 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _314 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _314 + 19u)].xyz + float3(1.0))))
        {
            _607 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_220, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _607 = _579;
        }
        _608 = _607;
    }
    else
    {
        _608 = _579;
    }
    float4 _615 = float4(((mix(float3(0.0), _415 + (_417 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_557 * _415) * fast::max(_426, ((((((_366 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _308) + ((_366 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _308) + ((_366 * 2.755199909210205078125) + float3(0.69029998779296875))) * _308))) + _608) * 1.0, 0.0);
    float4 _622;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _621 = _615;
        _621.w = 0.0;
        _622 = _621;
    }
    else
    {
        _622 = _615;
    }
    float2 _626 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _634 = (_367 * 0.5) + float3(0.5);
    float4 _636 = float4(_634.x, _634.y, _634.z, float4(0.0).w);
    _636.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _315)].y;
    float4 _637 = float4(0.0);
    _637.x = _365;
    float4 _638 = _637;
    _638.y = _364;
    float4 _639 = _638;
    _639.z = _363;
    float4 _640 = _639;
    _640.w = 0.50588238239288330078125;
    float4 _652 = float4(_366.x, _366.y, _366.z, float4(0.0).w);
    _652.w = ((log2(((dot(_557, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_426, ((((((_419 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _308) + ((_419 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _308) + ((_419 * 2.755199909210205078125) + float3(0.69029998779296875))) * _308).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_626.xyx * _626.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _622 * View.View_PreExposure;
    out.out_var_SV_Target1 = _636;
    out.out_var_SV_Target2 = _640;
    out.out_var_SV_Target3 = _652;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = (View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _375)] * _383) * _383;
    return out;
}

