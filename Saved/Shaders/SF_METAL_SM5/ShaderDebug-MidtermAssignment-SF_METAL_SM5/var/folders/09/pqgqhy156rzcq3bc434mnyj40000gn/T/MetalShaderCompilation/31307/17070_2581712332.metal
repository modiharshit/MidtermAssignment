

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

constant float3 _156 = {};
constant float _157 = {};

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

fragment MainPS_out Main_000042ae_99e1cdcc(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], texture2d<float> LightmapResourceCluster_StaticShadowTexture [[texture(5)]], texture2d<float> Material_Texture2D_0 [[texture(6)]], texture2d<float> Material_Texture2D_1 [[texture(7)]], texture2d<float> Material_Texture2D_2 [[texture(8)]], texture2d<float> Material_Texture2D_3 [[texture(9)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float3x3 _201 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _212 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _157, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _217 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _221 = _217.xyz / float3(_217.w);
    float3 _222 = _221 - View.View_PreViewTranslation;
    float4 _231 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _237 = ((normalize(-_221) * _201).xy * ((0.0599999986588954925537109375 * _231.x) + (-0.021600000560283660888671875))) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _241 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _237, bias(View.View_MaterialTextureMipBias));
    float2 _244 = (_241.xy * float2(2.0)) - float2(1.0);
    float3 _260 = normalize(_201 * normalize((float4(_244, sqrt(fast::clamp(1.0 - dot(_244, _244), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _272 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.20000000298023223876953125), bias(View.View_MaterialTextureMipBias));
    float4 _277 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float4 _282 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0030000000260770320892333984375), bias(View.View_MaterialTextureMipBias));
    float4 _290 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _237, bias(View.View_MaterialTextureMipBias));
    float _293 = _290.w;
    float3 _298 = fast::clamp(_290.xyz * ((_272.x + 0.5) * ((_277.x + 0.5) * (_282.x + 0.5))), float3(0.0), float3(1.0));
    float _299 = fast::clamp(_293 * 4.0, 0.0, 1.0);
    float _304 = (fast::clamp(fast::min(fast::max(mix(1.0, -1.75, _293), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _305 = in.in_var_PRIMITIVE_ID * 36u;
    uint _306 = _305 + 20u;
    float _354;
    float _355;
    float _356;
    float3 _357;
    float3 _358;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _306)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _324 = ((_212.xy / float2(_212.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _328 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _324, level(0.0));
        float4 _331 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _324, level(0.0));
        float4 _334 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _324, level(0.0));
        float _344 = _334.w;
        _354 = (_304 * _344) + _334.z;
        _355 = (_299 * _344) + _334.y;
        _356 = _334.x;
        _357 = (_298 * _328.w) + _328.xyz;
        _358 = normalize((_260 * _331.w) + ((_331.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _354 = _304;
        _355 = _299;
        _356 = 0.0;
        _357 = _298;
        _358 = _260;
    }
    float4 _365 = LightmapResourceCluster_StaticShadowTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.zw);
    uint _366 = in.in_var_LIGHTMAP_ID * 15u;
    uint _367 = _366 + 1u;
    float4 _374 = fast::clamp((_365 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _367)]) + ((View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _367)] * (-0.5)) + float4(0.5)), float4(0.0), float4(1.0));
    float3 _391 = ((_357 - (_357 * _356)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _398 = (mix(float3(0.07999999821186065673828125 * _355), _357, float3(_356)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _401 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _406;
    if (_401)
    {
        _406 = _391 + (_398 * 0.449999988079071044921875);
    }
    else
    {
        _406 = _391;
    }
    float3 _408 = select(_398, float3(0.0), bool3(_401));
    float3 _410 = float3(dot(_408, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _425 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _429 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _425);
    float4 _431 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_425 + float2(0.0, 0.5)));
    uint _437 = _366 + 4u;
    uint _442 = _366 + 6u;
    float3 _447 = _429.xyz;
    float _499;
    float _500;
    float3 _501;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _483 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _487 = _483.w;
        float _488 = _487 * _487;
        float3 _490 = normalize(((_483.xyz * 2.0) - float3(1.0)).xyz);
        float _491 = 1.0 - _488;
        float _493 = 1.0 - (_491 * _491);
        _499 = mix(fast::clamp(dot(_490, _358), 0.0, 1.0), 1.0, _493);
        _500 = _488;
        _501 = mix(_490, _358, float3(_493));
    }
    else
    {
        _499 = 1.0;
        _500 = 1.0;
        _501 = _358;
    }
    float4 _505 = float4(_501, 1.0);
    float3 _509 = _156;
    _509.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _505);
    float3 _513 = _509;
    _513.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _505);
    float3 _517 = _513;
    _517.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _505);
    float4 _520 = _505.xyzz * _505.yzzx;
    float3 _524 = _156;
    _524.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _520);
    float3 _528 = _524;
    _528.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _520);
    float3 _532 = _528;
    _532.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _520);
    float3 _547 = (((((_447 * _447) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _437)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _442)].xyz) * ((exp2(((_429.w + ((_431.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _437)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _442)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_431 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _366 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _366 + 7u)], float4(_358.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_517 + _532) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_501.x * _501.x) - (_501.y * _501.y)))) * View.View_SkyLightColor.xyz) * (_500 * _499));
    float3 _569 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _598;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _597;
        if (any(abs(_222 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _305 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _305 + 19u)].xyz + float3(1.0))))
        {
            _597 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_222, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _597 = _569;
        }
        _598 = _597;
    }
    else
    {
        _598 = _569;
    }
    float4 _605 = float4(((mix(float3(0.0), _406 + (_408 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_547 * _406) * fast::max(float3(1.0), ((((((_357 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_357 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_357 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _598) * 1.0, 0.0);
    float4 _612;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _611 = _605;
        _611.w = 0.0;
        _612 = _611;
    }
    else
    {
        _612 = _605;
    }
    float2 _616 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _624 = (_358 * 0.5) + float3(0.5);
    float4 _626 = float4(_624.x, _624.y, _624.z, float4(0.0).w);
    _626.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _306)].y;
    float4 _627 = float4(0.0);
    _627.x = _356;
    float4 _628 = _627;
    _628.y = _355;
    float4 _629 = _628;
    _629.z = _354;
    float4 _630 = _629;
    _630.w = 0.50588238239288330078125;
    float4 _642 = float4(_357.x, _357.y, _357.z, float4(0.0).w);
    _642.w = ((log2(((dot(_547, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_410 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_410 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_410 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_616.xyx * _616.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _612 * View.View_PreExposure;
    out.out_var_SV_Target1 = _626;
    out.out_var_SV_Target2 = _630;
    out.out_var_SV_Target3 = _642;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = (View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _366)] * _374) * _374;
    return out;
}

