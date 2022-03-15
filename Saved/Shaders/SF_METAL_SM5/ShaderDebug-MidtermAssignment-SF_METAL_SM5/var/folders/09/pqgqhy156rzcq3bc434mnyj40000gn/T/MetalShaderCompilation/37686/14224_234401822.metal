

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
    char _m15_pad[48];
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
    spvUnsafeArray<float4, 6> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float3 _143 = {};
constant float _144 = {};

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

fragment MainPS_out Main_00003790_0df8b01e(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> Material_Texture2D_0 [[texture(4)]], texture2d<float> Material_Texture2D_1 [[texture(5)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _198 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _144, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _203 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _208 = (_203.xyz / float3(_203.w)) - View.View_PreViewTranslation;
    float4 _214 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _217 = (_214.xy * float2(2.0)) - float2(1.0);
    float3 _233 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_217, sqrt(fast::clamp(1.0 - dot(_217, _217), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _244 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _251 = _244.y;
    float3 _261 = fast::clamp(mix(Material.Material_VectorExpressions[4].xyz, Material.Material_VectorExpressions[5].xyz, float3(_251)), float3(0.0), float3(1.0));
    float _262 = fast::clamp(mix(0.0, 1.0, _251), 0.0, 1.0);
    float _263 = fast::clamp(_244.x, 0.0, 1.0);
    float _268 = (fast::clamp(mix(Material.Material_ScalarExpressions[0].y, Material.Material_ScalarExpressions[0].z, _251), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _269 = in.in_var_PRIMITIVE_ID * 36u;
    uint _270 = _269 + 20u;
    float _320;
    float _321;
    float _322;
    float3 _323;
    float3 _324;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _270)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _288 = ((_198.xy / float2(_198.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _292 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _288, level(0.0));
        float4 _295 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _288, level(0.0));
        float4 _298 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _288, level(0.0));
        float _308 = _298.w;
        _320 = (_268 * _308) + _298.z;
        _321 = (0.5 * _308) + _298.y;
        _322 = (_262 * _308) + _298.x;
        _323 = (_261 * _292.w) + _292.xyz;
        _324 = normalize((_233 * _295.w) + ((_295.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _320 = _268;
        _321 = 0.5;
        _322 = _262;
        _323 = _261;
        _324 = _233;
    }
    float3 _339 = ((_323 - (_323 * _322)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _346 = (mix(float3(0.07999999821186065673828125 * _321), _323, float3(_322)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _349 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _354;
    if (_349)
    {
        _354 = _339 + (_346 * 0.449999988079071044921875);
    }
    else
    {
        _354 = _339;
    }
    float3 _356 = select(_346, float3(0.0), bool3(_349));
    float3 _358 = float3(dot(_356, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _365 = float3(_263);
    float2 _374 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _379 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _374);
    float4 _381 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_374 + float2(0.0, 0.5)));
    uint _383 = in.in_var_LIGHTMAP_ID * 15u;
    float3 _393 = (_379.xyz * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _383 + 4u)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _383 + 6u)].xyz;
    float _394 = dot(_393, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float _413 = (exp2((_394 * 16.0) - 8.0) - 0.00390625) * fast::max(0.0, dot((_381 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _383 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _383 + 7u)], float4(_324.yzx, 1.0)));
    float4 _424 = float4(_324, 1.0);
    float3 _428 = _143;
    _428.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _424);
    float3 _432 = _428;
    _432.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _424);
    float3 _436 = _432;
    _436.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _424);
    float4 _439 = _424.xyzz * _424.yzzx;
    float3 _443 = _143;
    _443.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _439);
    float3 _447 = _443;
    _447.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _439);
    float3 _451 = _447;
    _451.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _439);
    float3 _465 = (float4(_393 * (_413 / _394), _413).xyz * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_436 + _451) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_324.x * _324.x) - (_324.y * _324.y)))) * View.View_SkyLightColor.xyz) * 1.0);
    float3 _487 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _516;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _515;
        if (any(abs(_208 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _269 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _269 + 19u)].xyz + float3(1.0))))
        {
            _515 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_208, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _515 = _487;
        }
        _516 = _515;
    }
    else
    {
        _516 = _487;
    }
    float4 _523 = float4(((mix(float3(0.0), _354 + (_356 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_465 * _354) * fast::max(_365, ((((((_323 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _263) + ((_323 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _263) + ((_323 * 2.755199909210205078125) + float3(0.69029998779296875))) * _263))) + _516) * 1.0, 0.0);
    float4 _530;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _529 = _523;
        _529.w = 0.0;
        _530 = _529;
    }
    else
    {
        _530 = _523;
    }
    float2 _534 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _542 = (_324 * 0.5) + float3(0.5);
    float4 _544 = float4(_542.x, _542.y, _542.z, float4(0.0).w);
    _544.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _270)].y;
    float4 _545 = float4(0.0);
    _545.x = _322;
    float4 _546 = _545;
    _546.y = _321;
    float4 _547 = _546;
    _547.z = _320;
    float4 _548 = _547;
    _548.w = 0.75686275959014892578125;
    float4 _560 = float4(_323.x, _323.y, _323.z, float4(0.0).w);
    _560.w = ((log2(((dot(_465, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_365, ((((((_358 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _263) + ((_358 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _263) + ((_358 * 2.755199909210205078125) + float3(0.69029998779296875))) * _263).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_534.xyx * _534.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _530 * View.View_PreExposure;
    out.out_var_SV_Target1 = _544;
    out.out_var_SV_Target2 = _548;
    out.out_var_SV_Target3 = _560;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

