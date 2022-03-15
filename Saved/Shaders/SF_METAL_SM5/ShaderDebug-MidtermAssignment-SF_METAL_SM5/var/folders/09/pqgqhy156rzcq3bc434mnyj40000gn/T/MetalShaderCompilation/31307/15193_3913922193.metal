

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
    spvUnsafeArray<float4, 4> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float3 _142 = {};
constant float _143 = {};

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

fragment MainPS_out Main_00003b59_e949b691(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _198 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _143, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _203 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _208 = (_203.xyz / float3(_203.w)) - View.View_PreViewTranslation;
    float4 _214 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _217 = (_214.xy * float2(2.0)) - float2(1.0);
    float3 _233 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_217, sqrt(fast::clamp(1.0 - dot(_217, _217), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _244 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _248 = _244.x;
    float3 _257 = fast::clamp(Material.Material_VectorExpressions[3].xyz * _248, float3(0.0), float3(1.0));
    float _258 = fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0);
    float _263 = (fast::clamp(mix(Material.Material_ScalarExpressions[0].z, Material.Material_ScalarExpressions[0].w, _248), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _264 = in.in_var_PRIMITIVE_ID * 36u;
    uint _265 = _264 + 20u;
    float _315;
    float _316;
    float _317;
    float3 _318;
    float3 _319;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _265)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _283 = ((_198.xy / float2(_198.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _287 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _283, level(0.0));
        float4 _290 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _283, level(0.0));
        float4 _293 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _283, level(0.0));
        float _303 = _293.w;
        _315 = (_263 * _303) + _293.z;
        _316 = (0.5 * _303) + _293.y;
        _317 = (_258 * _303) + _293.x;
        _318 = (_257 * _287.w) + _287.xyz;
        _319 = normalize((_233 * _290.w) + ((_290.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _315 = _263;
        _316 = 0.5;
        _317 = _258;
        _318 = _257;
        _319 = _233;
    }
    float3 _334 = ((_318 - (_318 * _317)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _341 = (mix(float3(0.07999999821186065673828125 * _316), _318, float3(_317)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _344 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _349;
    if (_344)
    {
        _349 = _334 + (_341 * 0.449999988079071044921875);
    }
    else
    {
        _349 = _334;
    }
    float3 _351 = select(_341, float3(0.0), bool3(_344));
    float3 _353 = float3(dot(_351, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _368 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _373 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _368);
    float4 _375 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_368 + float2(0.0, 0.5)));
    uint _381 = in.in_var_LIGHTMAP_ID * 15u;
    uint _382 = _381 + 4u;
    uint _387 = _381 + 6u;
    float3 _392 = _373.xyz;
    float _444;
    float _445;
    float3 _446;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _428 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _432 = _428.w;
        float _433 = _432 * _432;
        float3 _435 = normalize(((_428.xyz * 2.0) - float3(1.0)).xyz);
        float _436 = 1.0 - _433;
        float _438 = 1.0 - (_436 * _436);
        _444 = mix(fast::clamp(dot(_435, _319), 0.0, 1.0), 1.0, _438);
        _445 = _433;
        _446 = mix(_435, _319, float3(_438));
    }
    else
    {
        _444 = 1.0;
        _445 = 1.0;
        _446 = _319;
    }
    float4 _450 = float4(_446, 1.0);
    float3 _454 = _142;
    _454.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _450);
    float3 _458 = _454;
    _458.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _450);
    float3 _462 = _458;
    _462.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _450);
    float4 _465 = _450.xyzz * _450.yzzx;
    float3 _469 = _142;
    _469.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _465);
    float3 _473 = _469;
    _473.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _465);
    float3 _477 = _473;
    _477.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _465);
    float3 _492 = (((((_392 * _392) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _382)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _387)].xyz) * ((exp2(((_373.w + ((_375.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _382)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _387)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_375 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _381 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _381 + 7u)], float4(_319.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_462 + _477) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_446.x * _446.x) - (_446.y * _446.y)))) * View.View_SkyLightColor.xyz) * (_445 * _444));
    float3 _514 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _543;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _542;
        if (any(abs(_208 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _264 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _264 + 19u)].xyz + float3(1.0))))
        {
            _542 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_208, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _542 = _514;
        }
        _543 = _542;
    }
    else
    {
        _543 = _514;
    }
    float4 _550 = float4(((mix(float3(0.0), _349 + (_351 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_492 * _349) * fast::max(float3(1.0), ((((((_318 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_318 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_318 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _543) * 1.0, 0.0);
    float4 _557;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _556 = _550;
        _556.w = 0.0;
        _557 = _556;
    }
    else
    {
        _557 = _550;
    }
    float2 _561 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _569 = (_319 * 0.5) + float3(0.5);
    float4 _571 = float4(_569.x, _569.y, _569.z, float4(0.0).w);
    _571.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _265)].y;
    float4 _572 = float4(0.0);
    _572.x = _317;
    float4 _573 = _572;
    _573.y = _316;
    float4 _574 = _573;
    _574.z = _315;
    float4 _575 = _574;
    _575.w = 0.75686275959014892578125;
    float4 _587 = float4(_318.x, _318.y, _318.z, float4(0.0).w);
    _587.w = ((log2(((dot(_492, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_353 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_353 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_353 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_561.xyx * _561.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _557 * View.View_PreExposure;
    out.out_var_SV_Target1 = _571;
    out.out_var_SV_Target2 = _575;
    out.out_var_SV_Target3 = _587;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

