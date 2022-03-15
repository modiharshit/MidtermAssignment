

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

constant float3 _137 = {};
constant float _138 = {};

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

fragment MainPS_out Main_000039e0_47cd7f69(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], texture2d<float> LightmapResourceCluster_StaticShadowTexture [[texture(5)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _189 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _138, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _194 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _199 = (_194.xyz / float3(_194.w)) - View.View_PreViewTranslation;
    float3 _207 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _222 = fast::clamp(Material.Material_VectorExpressions[3].xyz, float3(0.0), float3(1.0));
    float _223 = fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0);
    float _228 = (fast::clamp(Material.Material_ScalarExpressions[0].z, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _229 = in.in_var_PRIMITIVE_ID * 36u;
    uint _230 = _229 + 20u;
    float _280;
    float _281;
    float _282;
    float3 _283;
    float3 _284;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _230)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _248 = ((_189.xy / float2(_189.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _252 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _248, level(0.0));
        float4 _255 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _248, level(0.0));
        float4 _258 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _248, level(0.0));
        float _268 = _258.w;
        _280 = (_228 * _268) + _258.z;
        _281 = (0.5 * _268) + _258.y;
        _282 = (_223 * _268) + _258.x;
        _283 = (_222 * _252.w) + _252.xyz;
        _284 = normalize((_207 * _255.w) + ((_255.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _280 = _228;
        _281 = 0.5;
        _282 = _223;
        _283 = _222;
        _284 = _207;
    }
    float4 _291 = LightmapResourceCluster_StaticShadowTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.zw);
    uint _292 = in.in_var_LIGHTMAP_ID * 15u;
    uint _293 = _292 + 1u;
    float4 _300 = fast::clamp((_291 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _293)]) + ((View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _293)] * (-0.5)) + float4(0.5)), float4(0.0), float4(1.0));
    float3 _317 = ((_283 - (_283 * _282)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _324 = (mix(float3(0.07999999821186065673828125 * _281), _283, float3(_282)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _327 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _332;
    if (_327)
    {
        _332 = _317 + (_324 * 0.449999988079071044921875);
    }
    else
    {
        _332 = _317;
    }
    float3 _334 = select(_324, float3(0.0), bool3(_327));
    float3 _336 = float3(dot(_334, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _351 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _355 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _351);
    float4 _357 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_351 + float2(0.0, 0.5)));
    uint _363 = _292 + 4u;
    uint _368 = _292 + 6u;
    float3 _373 = _355.xyz;
    float _425;
    float _426;
    float3 _427;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _409 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _413 = _409.w;
        float _414 = _413 * _413;
        float3 _416 = normalize(((_409.xyz * 2.0) - float3(1.0)).xyz);
        float _417 = 1.0 - _414;
        float _419 = 1.0 - (_417 * _417);
        _425 = mix(fast::clamp(dot(_416, _284), 0.0, 1.0), 1.0, _419);
        _426 = _414;
        _427 = mix(_416, _284, float3(_419));
    }
    else
    {
        _425 = 1.0;
        _426 = 1.0;
        _427 = _284;
    }
    float4 _431 = float4(_427, 1.0);
    float3 _435 = _137;
    _435.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _431);
    float3 _439 = _435;
    _439.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _431);
    float3 _443 = _439;
    _443.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _431);
    float4 _446 = _431.xyzz * _431.yzzx;
    float3 _450 = _137;
    _450.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _446);
    float3 _454 = _450;
    _454.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _446);
    float3 _458 = _454;
    _458.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _446);
    float3 _473 = (((((_373 * _373) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _363)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _368)].xyz) * ((exp2(((_355.w + ((_357.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _363)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _368)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_357 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _292 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _292 + 7u)], float4(_284.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_443 + _458) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_427.x * _427.x) - (_427.y * _427.y)))) * View.View_SkyLightColor.xyz) * (_426 * _425));
    float3 _495 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _524;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _523;
        if (any(abs(_199 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _229 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _229 + 19u)].xyz + float3(1.0))))
        {
            _523 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_199, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _523 = _495;
        }
        _524 = _523;
    }
    else
    {
        _524 = _495;
    }
    float4 _531 = float4(((mix(float3(0.0), _332 + (_334 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_473 * _332) * fast::max(float3(1.0), ((((((_283 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_283 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_283 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _524) * 1.0, 0.0);
    float4 _538;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _537 = _531;
        _537.w = 0.0;
        _538 = _537;
    }
    else
    {
        _538 = _531;
    }
    float2 _542 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _550 = (_284 * 0.5) + float3(0.5);
    float4 _552 = float4(_550.x, _550.y, _550.z, float4(0.0).w);
    _552.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _230)].y;
    float4 _553 = float4(0.0);
    _553.x = _282;
    float4 _554 = _553;
    _554.y = _281;
    float4 _555 = _554;
    _555.z = _280;
    float4 _556 = _555;
    _556.w = 0.50588238239288330078125;
    float4 _568 = float4(_283.x, _283.y, _283.z, float4(0.0).w);
    _568.w = ((log2(((dot(_473, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_336 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_336 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_336 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_542.xyx * _542.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _538 * View.View_PreExposure;
    out.out_var_SV_Target1 = _552;
    out.out_var_SV_Target2 = _556;
    out.out_var_SV_Target3 = _568;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = (View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _292)] * _300) * _300;
    return out;
}

