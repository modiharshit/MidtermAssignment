

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
    char _m11_pad[80];
    float View_UnlitViewmodeMask;
    char _m12_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m13_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m14_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
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
    spvUnsafeArray<float4, 4> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float3 _136 = {};
constant float _137 = {};

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
    float4 in_var_TEXCOORD4 [[user(locn2)]];
    uint in_var_PRIMITIVE_ID [[user(locn3)]];
    uint in_var_LIGHTMAP_ID [[user(locn4)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00003983_2e583a2e(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], texture2d<float> LightmapResourceCluster_StaticShadowTexture [[texture(5)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _188 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _137, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _193 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _198 = (_193.xyz / float3(_193.w)) - View.View_PreViewTranslation;
    float3 _206 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _219 = fast::clamp(Material.Material_VectorExpressions[3].xyz, float3(0.0), float3(1.0));
    float _224 = (fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _225 = in.in_var_PRIMITIVE_ID * 36u;
    uint _226 = _225 + 20u;
    float _274;
    float _275;
    float _276;
    float3 _277;
    float3 _278;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _226)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _244 = ((_188.xy / float2(_188.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _248 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _244, level(0.0));
        float4 _251 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _244, level(0.0));
        float4 _254 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _244, level(0.0));
        float _264 = _254.w;
        _274 = (_224 * _264) + _254.z;
        _275 = (0.5 * _264) + _254.y;
        _276 = _254.x;
        _277 = (_219 * _248.w) + _248.xyz;
        _278 = normalize((_206 * _251.w) + ((_251.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _274 = _224;
        _275 = 0.5;
        _276 = 0.0;
        _277 = _219;
        _278 = _206;
    }
    float4 _285 = LightmapResourceCluster_StaticShadowTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.zw);
    uint _286 = in.in_var_LIGHTMAP_ID * 15u;
    uint _287 = _286 + 1u;
    float4 _294 = fast::clamp((_285 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _287)]) + ((View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _287)] * (-0.5)) + float4(0.5)), float4(0.0), float4(1.0));
    float3 _311 = ((_277 - (_277 * _276)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _318 = (mix(float3(0.07999999821186065673828125 * _275), _277, float3(_276)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _321 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _326;
    if (_321)
    {
        _326 = _311 + (_318 * 0.449999988079071044921875);
    }
    else
    {
        _326 = _311;
    }
    float3 _328 = select(_318, float3(0.0), bool3(_321));
    float3 _330 = float3(dot(_328, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _345 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _349 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _345);
    float4 _351 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_345 + float2(0.0, 0.5)));
    uint _357 = _286 + 4u;
    uint _362 = _286 + 6u;
    float3 _367 = _349.xyz;
    float _419;
    float _420;
    float3 _421;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _403 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _407 = _403.w;
        float _408 = _407 * _407;
        float3 _410 = normalize(((_403.xyz * 2.0) - float3(1.0)).xyz);
        float _411 = 1.0 - _408;
        float _413 = 1.0 - (_411 * _411);
        _419 = mix(fast::clamp(dot(_410, _278), 0.0, 1.0), 1.0, _413);
        _420 = _408;
        _421 = mix(_410, _278, float3(_413));
    }
    else
    {
        _419 = 1.0;
        _420 = 1.0;
        _421 = _278;
    }
    float4 _425 = float4(_421, 1.0);
    float3 _429 = _136;
    _429.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _425);
    float3 _433 = _429;
    _433.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _425);
    float3 _437 = _433;
    _437.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _425);
    float4 _440 = _425.xyzz * _425.yzzx;
    float3 _444 = _136;
    _444.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _440);
    float3 _448 = _444;
    _448.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _440);
    float3 _452 = _448;
    _452.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _440);
    float3 _467 = (((((_367 * _367) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _357)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _362)].xyz) * ((exp2(((_349.w + ((_351.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _357)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _362)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_351 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _286 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _286 + 7u)], float4(_278.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_437 + _452) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_421.x * _421.x) - (_421.y * _421.y)))) * View.View_SkyLightColor.xyz) * (_420 * _419));
    float3 _489 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _518;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _517;
        if (any(abs(_198 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _225 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _225 + 19u)].xyz + float3(1.0))))
        {
            _517 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_198, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _517 = _489;
        }
        _518 = _517;
    }
    else
    {
        _518 = _489;
    }
    float4 _525 = float4(((mix(float3(0.0), _326 + (_328 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_467 * _326) * fast::max(float3(1.0), ((((((_277 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_277 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_277 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _518) * 1.0, 0.0);
    float4 _532;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _531 = _525;
        _531.w = 0.0;
        _532 = _531;
    }
    else
    {
        _532 = _525;
    }
    float2 _536 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _544 = (_278 * 0.5) + float3(0.5);
    float4 _546 = float4(_544.x, _544.y, _544.z, float4(0.0).w);
    _546.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _226)].y;
    float4 _547 = float4(0.0);
    _547.x = _276;
    float4 _548 = _547;
    _548.y = _275;
    float4 _549 = _548;
    _549.z = _274;
    float4 _550 = _549;
    _550.w = 0.50588238239288330078125;
    float4 _562 = float4(_277.x, _277.y, _277.z, float4(0.0).w);
    _562.w = ((log2(((dot(_467, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_330 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_330 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_330 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_536.xyx * _536.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _532 * View.View_PreExposure;
    out.out_var_SV_Target1 = _546;
    out.out_var_SV_Target2 = _550;
    out.out_var_SV_Target3 = _562;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = (View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _286)] * _294) * _294;
    return out;
}

