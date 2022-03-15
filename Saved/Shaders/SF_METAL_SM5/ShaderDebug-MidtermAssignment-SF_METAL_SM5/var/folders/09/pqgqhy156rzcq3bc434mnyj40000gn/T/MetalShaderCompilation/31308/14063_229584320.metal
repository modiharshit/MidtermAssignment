

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

constant float3 _132 = {};
constant float _133 = {};

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

fragment MainPS_out Main_000036ef_0daf2dc0(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _184 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _133, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _189 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _194 = (_189.xyz / float3(_189.w)) - View.View_PreViewTranslation;
    float3 _202 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _215 = fast::clamp(Material.Material_VectorExpressions[3].xyz, float3(0.0), float3(1.0));
    float _220 = (fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _221 = in.in_var_PRIMITIVE_ID * 36u;
    uint _222 = _221 + 20u;
    float _271;
    float _272;
    float _273;
    float3 _274;
    float3 _275;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _222)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _240 = ((_184.xy / float2(_184.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _244 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _240, level(0.0));
        float4 _247 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _240, level(0.0));
        float4 _250 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _240, level(0.0));
        float _260 = _250.w;
        float _266 = 0.5 * _260;
        _271 = (_220 * _260) + _250.z;
        _272 = _266 + _250.y;
        _273 = _266 + _250.x;
        _274 = (_215 * _244.w) + _244.xyz;
        _275 = normalize((_202 * _247.w) + ((_247.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _271 = _220;
        _272 = 0.5;
        _273 = 0.5;
        _274 = _215;
        _275 = _202;
    }
    float3 _290 = ((_274 - (_274 * _273)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _297 = (mix(float3(0.07999999821186065673828125 * _272), _274, float3(_273)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _300 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _305;
    if (_300)
    {
        _305 = _290 + (_297 * 0.449999988079071044921875);
    }
    else
    {
        _305 = _290;
    }
    float3 _307 = select(_297, float3(0.0), bool3(_300));
    float3 _309 = float3(dot(_307, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _324 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _329 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _324);
    float4 _331 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_324 + float2(0.0, 0.5)));
    uint _337 = in.in_var_LIGHTMAP_ID * 15u;
    uint _338 = _337 + 4u;
    uint _343 = _337 + 6u;
    float3 _348 = _329.xyz;
    float _400;
    float _401;
    float3 _402;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _384 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _388 = _384.w;
        float _389 = _388 * _388;
        float3 _391 = normalize(((_384.xyz * 2.0) - float3(1.0)).xyz);
        float _392 = 1.0 - _389;
        float _394 = 1.0 - (_392 * _392);
        _400 = mix(fast::clamp(dot(_391, _275), 0.0, 1.0), 1.0, _394);
        _401 = _389;
        _402 = mix(_391, _275, float3(_394));
    }
    else
    {
        _400 = 1.0;
        _401 = 1.0;
        _402 = _275;
    }
    float4 _406 = float4(_402, 1.0);
    float3 _410 = _132;
    _410.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _406);
    float3 _414 = _410;
    _414.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _406);
    float3 _418 = _414;
    _418.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _406);
    float4 _421 = _406.xyzz * _406.yzzx;
    float3 _425 = _132;
    _425.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _421);
    float3 _429 = _425;
    _429.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _421);
    float3 _433 = _429;
    _433.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _421);
    float3 _448 = (((((_348 * _348) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _338)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _343)].xyz) * ((exp2(((_329.w + ((_331.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _338)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _343)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_331 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _337 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _337 + 7u)], float4(_275.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_418 + _433) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_402.x * _402.x) - (_402.y * _402.y)))) * View.View_SkyLightColor.xyz) * (_401 * _400));
    float3 _470 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _499;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _498;
        if (any(abs(_194 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _221 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _221 + 19u)].xyz + float3(1.0))))
        {
            _498 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_194, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _498 = _470;
        }
        _499 = _498;
    }
    else
    {
        _499 = _470;
    }
    float4 _506 = float4(((mix(float3(0.0), _305 + (_307 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_448 * _305) * fast::max(float3(1.0), ((((((_274 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_274 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_274 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _499) * 1.0, 0.0);
    float4 _513;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _512 = _506;
        _512.w = 0.0;
        _513 = _512;
    }
    else
    {
        _513 = _506;
    }
    float2 _517 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _525 = (_275 * 0.5) + float3(0.5);
    float4 _527 = float4(_525.x, _525.y, _525.z, float4(0.0).w);
    _527.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _222)].y;
    float4 _528 = float4(0.0);
    _528.x = _273;
    float4 _529 = _528;
    _529.y = _272;
    float4 _530 = _529;
    _530.z = _271;
    float4 _531 = _530;
    _531.w = 0.75686275959014892578125;
    float4 _543 = float4(_274.x, _274.y, _274.z, float4(0.0).w);
    _543.w = ((log2(((dot(_448, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_309 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_309 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_309 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_517.xyx * _517.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _513 * View.View_PreExposure;
    out.out_var_SV_Target1 = _527;
    out.out_var_SV_Target2 = _531;
    out.out_var_SV_Target3 = _543;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

