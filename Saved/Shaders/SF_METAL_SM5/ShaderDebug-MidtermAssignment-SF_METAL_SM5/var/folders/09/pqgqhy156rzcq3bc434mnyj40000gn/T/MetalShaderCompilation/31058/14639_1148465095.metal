

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
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float3 _139 = {};
constant float _140 = {};

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

fragment MainPS_out Main_0000392f_44742fc7(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], texture2d<float> LightmapResourceCluster_StaticShadowTexture [[texture(5)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _191 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _140, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _196 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _201 = (_196.xyz / float3(_196.w)) - View.View_PreViewTranslation;
    float3 _209 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float _220 = (0.699999988079071044921875 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _221 = in.in_var_PRIMITIVE_ID * 36u;
    uint _222 = _221 + 20u;
    float _270;
    float _271;
    float _272;
    float3 _273;
    float3 _274;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _222)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _240 = ((_191.xy / float2(_191.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _244 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _240, level(0.0));
        float4 _247 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _240, level(0.0));
        float4 _250 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _240, level(0.0));
        float _260 = _250.w;
        _270 = (_220 * _260) + _250.z;
        _271 = (0.5 * _260) + _250.y;
        _272 = _250.x;
        _273 = (float3(0.180000007152557373046875) * _244.w) + _244.xyz;
        _274 = normalize((_209 * _247.w) + ((_247.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _270 = _220;
        _271 = 0.5;
        _272 = 0.0;
        _273 = float3(0.180000007152557373046875);
        _274 = _209;
    }
    float4 _281 = LightmapResourceCluster_StaticShadowTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.zw);
    uint _282 = in.in_var_LIGHTMAP_ID * 15u;
    uint _283 = _282 + 1u;
    float4 _290 = fast::clamp((_281 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _283)]) + ((View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _283)] * (-0.5)) + float4(0.5)), float4(0.0), float4(1.0));
    float3 _307 = ((_273 - (_273 * _272)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _314 = (mix(float3(0.07999999821186065673828125 * _271), _273, float3(_272)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _317 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _322;
    if (_317)
    {
        _322 = _307 + (_314 * 0.449999988079071044921875);
    }
    else
    {
        _322 = _307;
    }
    float3 _324 = select(_314, float3(0.0), bool3(_317));
    float3 _326 = float3(dot(_324, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _341 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _345 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _341);
    float4 _347 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_341 + float2(0.0, 0.5)));
    uint _353 = _282 + 4u;
    uint _358 = _282 + 6u;
    float3 _363 = _345.xyz;
    float _415;
    float _416;
    float3 _417;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _399 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _403 = _399.w;
        float _404 = _403 * _403;
        float3 _406 = normalize(((_399.xyz * 2.0) - float3(1.0)).xyz);
        float _407 = 1.0 - _404;
        float _409 = 1.0 - (_407 * _407);
        _415 = mix(fast::clamp(dot(_406, _274), 0.0, 1.0), 1.0, _409);
        _416 = _404;
        _417 = mix(_406, _274, float3(_409));
    }
    else
    {
        _415 = 1.0;
        _416 = 1.0;
        _417 = _274;
    }
    float4 _421 = float4(_417, 1.0);
    float3 _425 = _139;
    _425.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _421);
    float3 _429 = _425;
    _429.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _421);
    float3 _433 = _429;
    _433.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _421);
    float4 _436 = _421.xyzz * _421.yzzx;
    float3 _440 = _139;
    _440.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _436);
    float3 _444 = _440;
    _444.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _436);
    float3 _448 = _444;
    _448.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _436);
    float3 _463 = (((((_363 * _363) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _353)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _358)].xyz) * ((exp2(((_345.w + ((_347.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _353)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _358)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_347 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _282 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _282 + 7u)], float4(_274.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_433 + _448) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_417.x * _417.x) - (_417.y * _417.y)))) * View.View_SkyLightColor.xyz) * (_416 * _415));
    float3 _485 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _514;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _513;
        if (any(abs(_201 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _221 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _221 + 19u)].xyz + float3(1.0))))
        {
            _513 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_201, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _513 = _485;
        }
        _514 = _513;
    }
    else
    {
        _514 = _485;
    }
    float4 _521 = float4(((mix(float3(0.0), _322 + (_324 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_463 * _322) * fast::max(float3(1.0), ((((((_273 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_273 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_273 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _514) * 1.0, 0.0);
    float4 _528;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _527 = _521;
        _527.w = 0.0;
        _528 = _527;
    }
    else
    {
        _528 = _521;
    }
    float2 _532 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _540 = (_274 * 0.5) + float3(0.5);
    float4 _542 = float4(_540.x, _540.y, _540.z, float4(0.0).w);
    _542.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _222)].y;
    float4 _543 = float4(0.0);
    _543.x = _272;
    float4 _544 = _543;
    _544.y = _271;
    float4 _545 = _544;
    _545.z = _270;
    float4 _546 = _545;
    _546.w = 0.50588238239288330078125;
    float4 _558 = float4(_273.x, _273.y, _273.z, float4(0.0).w);
    _558.w = ((log2(((dot(_463, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_326 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_326 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_326 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_532.xyx * _532.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _528 * View.View_PreExposure;
    out.out_var_SV_Target1 = _542;
    out.out_var_SV_Target2 = _546;
    out.out_var_SV_Target3 = _558;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = (View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _282)] * _290) * _290;
    return out;
}

