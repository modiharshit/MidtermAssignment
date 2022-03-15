

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

constant float3 _159 = {};

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

fragment MainPS_out Main_0000468a_21b7e6c0(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], texture2d<float> LightmapResourceCluster_StaticShadowTexture [[texture(5)]], texture2d<float> Material_Texture2D_0 [[texture(6)]], texture2d<float> Material_Texture2D_1 [[texture(7)]], texture2d<float> Material_Texture2D_2 [[texture(8)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _215 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _219 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _224 = (_219.xyz / float3(_219.w)) - View.View_PreViewTranslation;
    float4 _230 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _233 = (_230.xy * float2(2.0)) - float2(1.0);
    float2 _243 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125;
    float4 _247 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _243, bias(View.View_MaterialTextureMipBias));
    float _274;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _274 = _215.w;
                break;
            }
            else
            {
                float _258 = _215.z;
                _274 = ((_258 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_258 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _280 = float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _247.x) + _274) - 150.0) * 0.0005000000237487256526947021484375, 0.0), 1.0));
    float3 _289 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(float3(0.5, 0.5, 1.0) * float4(_233, sqrt(fast::clamp(1.0 - dot(_233, _233), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), _280) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _301 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _304 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _313 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.449999988079071044921875), bias(View.View_MaterialTextureMipBias));
    float _314 = _313.x;
    float _318 = _313.y;
    float _322 = _313.z;
    float4 _328 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _243, bias(View.View_MaterialTextureMipBias));
    float _329 = _328.x;
    float _333 = _328.y;
    float _337 = _328.z;
    float3 _345 = fast::min(fast::max(mix(float3((_314 <= 0.0) ? 0.0 : pow(_314, 2.0), (_318 <= 0.0) ? 0.0 : pow(_318, 2.0), (_322 <= 0.0) ? 0.0 : pow(_322, 2.0)), float3((_329 <= 0.0) ? 0.0 : pow(_329, 2.0), (_333 <= 0.0) ? 0.0 : pow(_333, 2.0), (_337 <= 0.0) ? 0.0 : pow(_337, 2.0)), _280) * fast::min(fast::max(1.0 - (_301.x * _304.x), 0.0), 1.0), float3(0.0)), float3(1.0));
    float3 _350 = fast::clamp(mix(_345, float3(dot(_345, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375))), float3(0.4000000059604644775390625)) * 0.699999988079071044921875, float3(0.0), float3(1.0));
    uint _352 = in.in_var_PRIMITIVE_ID * 36u;
    uint _353 = _352 + 20u;
    float _401;
    float _402;
    float _403;
    float3 _404;
    float3 _405;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _353)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _371 = ((_215.xy / float2(_215.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _375 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _371, level(0.0));
        float4 _378 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _371, level(0.0));
        float4 _381 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _371, level(0.0));
        float _391 = _381.w;
        _401 = (View.View_RoughnessOverrideParameter.x * _391) + _381.z;
        _402 = (0.5 * _391) + _381.y;
        _403 = _381.x;
        _404 = (_350 * _375.w) + _375.xyz;
        _405 = normalize((_289 * _378.w) + ((_378.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _401 = View.View_RoughnessOverrideParameter.x;
        _402 = 0.5;
        _403 = 0.0;
        _404 = _350;
        _405 = _289;
    }
    float4 _412 = LightmapResourceCluster_StaticShadowTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.zw);
    uint _413 = in.in_var_LIGHTMAP_ID * 15u;
    uint _414 = _413 + 1u;
    float4 _421 = fast::clamp((_412 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _414)]) + ((View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _414)] * (-0.5)) + float4(0.5)), float4(0.0), float4(1.0));
    float3 _438 = ((_404 - (_404 * _403)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _445 = (mix(float3(0.07999999821186065673828125 * _402), _404, float3(_403)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _448 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _453;
    if (_448)
    {
        _453 = _438 + (_445 * 0.449999988079071044921875);
    }
    else
    {
        _453 = _438;
    }
    float3 _455 = select(_445, float3(0.0), bool3(_448));
    float3 _457 = float3(dot(_455, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _472 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _476 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _472);
    float4 _478 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_472 + float2(0.0, 0.5)));
    uint _484 = _413 + 4u;
    uint _489 = _413 + 6u;
    float3 _494 = _476.xyz;
    float _546;
    float _547;
    float3 _548;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _530 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _534 = _530.w;
        float _535 = _534 * _534;
        float3 _537 = normalize(((_530.xyz * 2.0) - float3(1.0)).xyz);
        float _538 = 1.0 - _535;
        float _540 = 1.0 - (_538 * _538);
        _546 = mix(fast::clamp(dot(_537, _405), 0.0, 1.0), 1.0, _540);
        _547 = _535;
        _548 = mix(_537, _405, float3(_540));
    }
    else
    {
        _546 = 1.0;
        _547 = 1.0;
        _548 = _405;
    }
    float4 _552 = float4(_548, 1.0);
    float3 _556 = _159;
    _556.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _552);
    float3 _560 = _556;
    _560.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _552);
    float3 _564 = _560;
    _564.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _552);
    float4 _567 = _552.xyzz * _552.yzzx;
    float3 _571 = _159;
    _571.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _567);
    float3 _575 = _571;
    _575.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _567);
    float3 _579 = _575;
    _579.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _567);
    float3 _594 = (((((_494 * _494) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _484)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _489)].xyz) * ((exp2(((_476.w + ((_478.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _484)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _489)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_478 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _413 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _413 + 7u)], float4(_405.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_564 + _579) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_548.x * _548.x) - (_548.y * _548.y)))) * View.View_SkyLightColor.xyz) * (_547 * _546));
    float3 _616 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _645;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _644;
        if (any(abs(_224 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _352 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _352 + 19u)].xyz + float3(1.0))))
        {
            _644 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_224, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _644 = _616;
        }
        _645 = _644;
    }
    else
    {
        _645 = _616;
    }
    float4 _652 = float4(((mix(float3(0.0), _453 + (_455 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_594 * _453) * fast::max(float3(1.0), ((((((_404 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_404 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_404 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _645) * 1.0, 0.0);
    float4 _659;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _658 = _652;
        _658.w = 0.0;
        _659 = _658;
    }
    else
    {
        _659 = _652;
    }
    float2 _663 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _671 = (_405 * 0.5) + float3(0.5);
    float4 _673 = float4(_671.x, _671.y, _671.z, float4(0.0).w);
    _673.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _353)].y;
    float4 _674 = float4(0.0);
    _674.x = _403;
    float4 _675 = _674;
    _675.y = _402;
    float4 _676 = _675;
    _676.z = _401;
    float4 _677 = _676;
    _677.w = 0.50588238239288330078125;
    float4 _689 = float4(_404.x, _404.y, _404.z, float4(0.0).w);
    _689.w = ((log2(((dot(_594, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_457 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_457 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_457 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_663.xyx * _663.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _659 * View.View_PreExposure;
    out.out_var_SV_Target1 = _673;
    out.out_var_SV_Target2 = _677;
    out.out_var_SV_Target3 = _689;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = (View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _413)] * _421) * _421;
    return out;
}

