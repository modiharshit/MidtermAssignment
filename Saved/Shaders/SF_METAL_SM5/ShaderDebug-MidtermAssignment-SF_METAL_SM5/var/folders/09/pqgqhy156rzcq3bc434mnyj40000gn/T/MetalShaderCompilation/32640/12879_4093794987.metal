

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
    char _m14_pad[48];
    float4 View_SkyLightColor;
    char _m15_pad[124];
    float View_ShowDecalsMask;
    char _m16_pad[184];
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

fragment MainPS_out Main_0000324f_f4025aab(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _183 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _133, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _188 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _193 = (_188.xyz / float3(_188.w)) - View.View_PreViewTranslation;
    float3 _201 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float _212 = (0.300000011920928955078125 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _213 = in.in_var_PRIMITIVE_ID * 36u;
    uint _214 = _213 + 20u;
    float _262;
    float _263;
    float _264;
    float3 _265;
    float3 _266;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _214)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _232 = ((_183.xy / float2(_183.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _236 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _232, level(0.0));
        float4 _239 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _232, level(0.0));
        float4 _242 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _232, level(0.0));
        float _252 = _242.w;
        _262 = (_212 * _252) + _242.z;
        _263 = (0.5 * _252) + _242.y;
        _264 = _242.x;
        _265 = (float3(0.300000011920928955078125) * _236.w) + _236.xyz;
        _266 = normalize((_201 * _239.w) + ((_239.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _262 = _212;
        _263 = 0.5;
        _264 = 0.0;
        _265 = float3(0.300000011920928955078125);
        _266 = _201;
    }
    float3 _281 = ((_265 - (_265 * _264)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _288 = (mix(float3(0.07999999821186065673828125 * _263), _265, float3(_264)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _291 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _296;
    if (_291)
    {
        _296 = _281 + (_288 * 0.449999988079071044921875);
    }
    else
    {
        _296 = _281;
    }
    float3 _298 = select(_288, float3(0.0), bool3(_291));
    float3 _300 = float3(dot(_298, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _315 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _320 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _315);
    float4 _322 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_315 + float2(0.0, 0.5)));
    uint _324 = in.in_var_LIGHTMAP_ID * 15u;
    float3 _334 = (_320.xyz * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _324 + 4u)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _324 + 6u)].xyz;
    float _335 = dot(_334, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float _354 = (exp2((_335 * 16.0) - 8.0) - 0.00390625) * fast::max(0.0, dot((_322 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _324 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _324 + 7u)], float4(_266.yzx, 1.0)));
    float4 _365 = float4(_266, 1.0);
    float3 _369 = _132;
    _369.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _365);
    float3 _373 = _369;
    _373.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _365);
    float3 _377 = _373;
    _377.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _365);
    float4 _380 = _365.xyzz * _365.yzzx;
    float3 _384 = _132;
    _384.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _380);
    float3 _388 = _384;
    _388.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _380);
    float3 _392 = _388;
    _392.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _380);
    float3 _406 = (float4(_334 * (_354 / _335), _354).xyz * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_377 + _392) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_266.x * _266.x) - (_266.y * _266.y)))) * View.View_SkyLightColor.xyz) * 1.0);
    float3 _428 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _457;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _456;
        if (any(abs(_193 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _213 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _213 + 19u)].xyz + float3(1.0))))
        {
            _456 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_193, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _456 = _428;
        }
        _457 = _456;
    }
    else
    {
        _457 = _428;
    }
    float4 _464 = float4(((mix(float3(0.0), _296 + (_298 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_406 * _296) * fast::max(float3(1.0), ((((((_265 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_265 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_265 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _457) * 1.0, 0.0);
    float4 _471;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _470 = _464;
        _470.w = 0.0;
        _471 = _470;
    }
    else
    {
        _471 = _464;
    }
    float2 _475 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _483 = (_266 * 0.5) + float3(0.5);
    float4 _485 = float4(_483.x, _483.y, _483.z, float4(0.0).w);
    _485.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _214)].y;
    float4 _486 = float4(0.0);
    _486.x = _264;
    float4 _487 = _486;
    _487.y = _263;
    float4 _488 = _487;
    _488.z = _262;
    float4 _489 = _488;
    _489.w = 0.75686275959014892578125;
    float4 _501 = float4(_265.x, _265.y, _265.z, float4(0.0).w);
    _501.w = ((log2(((dot(_406, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_300 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_300 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_300 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_475.xyx * _475.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _471 * View.View_PreExposure;
    out.out_var_SV_Target1 = _485;
    out.out_var_SV_Target2 = _489;
    out.out_var_SV_Target3 = _501;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

