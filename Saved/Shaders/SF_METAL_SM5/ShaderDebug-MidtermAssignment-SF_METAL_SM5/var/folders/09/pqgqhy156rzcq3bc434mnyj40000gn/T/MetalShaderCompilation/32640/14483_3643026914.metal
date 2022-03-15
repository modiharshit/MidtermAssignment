

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

fragment MainPS_out Main_00003893_d9242de2(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], texture2d<float> LightmapResourceCluster_StaticShadowTexture [[texture(5)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _188 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _137, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _193 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _198 = (_193.xyz / float3(_193.w)) - View.View_PreViewTranslation;
    float3 _206 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    uint _215 = in.in_var_PRIMITIVE_ID * 36u;
    uint _216 = _215 + 20u;
    float _261;
    float _262;
    float _263;
    float3 _264;
    float3 _265;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _216)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _234 = ((_188.xy / float2(_188.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _241 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _234, level(0.0));
        float4 _244 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _234, level(0.0));
        float _253 = _244.w;
        _261 = (View.View_RoughnessOverrideParameter.x * _253) + _244.z;
        _262 = (0.5 * _253) + _244.y;
        _263 = _244.x;
        _264 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _234, level(0.0)).xyz;
        _265 = normalize((_206 * _241.w) + ((_241.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _261 = View.View_RoughnessOverrideParameter.x;
        _262 = 0.5;
        _263 = 0.0;
        _264 = float3(0.0);
        _265 = _206;
    }
    float4 _272 = LightmapResourceCluster_StaticShadowTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.zw);
    uint _273 = in.in_var_LIGHTMAP_ID * 15u;
    uint _274 = _273 + 1u;
    float4 _281 = fast::clamp((_272 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _274)]) + ((View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _274)] * (-0.5)) + float4(0.5)), float4(0.0), float4(1.0));
    float3 _298 = ((_264 - (_264 * _263)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _305 = (mix(float3(0.07999999821186065673828125 * _262), _264, float3(_263)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _308 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _313;
    if (_308)
    {
        _313 = _298 + (_305 * 0.449999988079071044921875);
    }
    else
    {
        _313 = _298;
    }
    float3 _315 = select(_305, float3(0.0), bool3(_308));
    float3 _317 = float3(dot(_315, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _332 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _336 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _332);
    float4 _338 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_332 + float2(0.0, 0.5)));
    uint _344 = _273 + 4u;
    uint _349 = _273 + 6u;
    float3 _354 = _336.xyz;
    float _406;
    float _407;
    float3 _408;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _390 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _394 = _390.w;
        float _395 = _394 * _394;
        float3 _397 = normalize(((_390.xyz * 2.0) - float3(1.0)).xyz);
        float _398 = 1.0 - _395;
        float _400 = 1.0 - (_398 * _398);
        _406 = mix(fast::clamp(dot(_397, _265), 0.0, 1.0), 1.0, _400);
        _407 = _395;
        _408 = mix(_397, _265, float3(_400));
    }
    else
    {
        _406 = 1.0;
        _407 = 1.0;
        _408 = _265;
    }
    float4 _412 = float4(_408, 1.0);
    float3 _416 = _136;
    _416.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _412);
    float3 _420 = _416;
    _420.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _412);
    float3 _424 = _420;
    _424.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _412);
    float4 _427 = _412.xyzz * _412.yzzx;
    float3 _431 = _136;
    _431.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _427);
    float3 _435 = _431;
    _435.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _427);
    float3 _439 = _435;
    _439.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _427);
    float3 _454 = (((((_354 * _354) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _344)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _349)].xyz) * ((exp2(((_336.w + ((_338.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _344)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _349)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_338 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _273 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _273 + 7u)], float4(_265.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_424 + _439) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_408.x * _408.x) - (_408.y * _408.y)))) * View.View_SkyLightColor.xyz) * (_407 * _406));
    float3 _476 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _505;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _504;
        if (any(abs(_198 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _215 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _215 + 19u)].xyz + float3(1.0))))
        {
            _504 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_198, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _504 = _476;
        }
        _505 = _504;
    }
    else
    {
        _505 = _476;
    }
    float4 _512 = float4(((mix(float3(0.0), _313 + (_315 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_454 * _313) * fast::max(float3(1.0), ((((((_264 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_264 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_264 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _505) * 1.0, 0.0);
    float4 _519;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _518 = _512;
        _518.w = 0.0;
        _519 = _518;
    }
    else
    {
        _519 = _512;
    }
    float2 _523 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _531 = (_265 * 0.5) + float3(0.5);
    float4 _533 = float4(_531.x, _531.y, _531.z, float4(0.0).w);
    _533.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _216)].y;
    float4 _534 = float4(0.0);
    _534.x = _263;
    float4 _535 = _534;
    _535.y = _262;
    float4 _536 = _535;
    _536.z = _261;
    float4 _537 = _536;
    _537.w = 0.50588238239288330078125;
    float4 _549 = float4(_264.x, _264.y, _264.z, float4(0.0).w);
    _549.w = ((log2(((dot(_454, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_317 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_317 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_317 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_523.xyx * _523.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _519 * View.View_PreExposure;
    out.out_var_SV_Target1 = _533;
    out.out_var_SV_Target2 = _537;
    out.out_var_SV_Target3 = _549;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = (View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _273)] * _281) * _281;
    return out;
}

