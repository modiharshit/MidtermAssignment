

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

fragment MainPS_out Main_00003228_44c2f56c(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _183 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _133, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _188 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _193 = (_188.xyz / float3(_188.w)) - View.View_PreViewTranslation;
    float3 _201 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float _212 = (0.100000001490116119384765625 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _213 = in.in_var_PRIMITIVE_ID * 36u;
    uint _214 = _213 + 20u;
    float _263;
    float _264;
    float _265;
    float3 _266;
    float3 _267;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _214)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _232 = ((_183.xy / float2(_183.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _236 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _232, level(0.0));
        float4 _239 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _232, level(0.0));
        float4 _242 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _232, level(0.0));
        float _252 = _242.w;
        _263 = (_212 * _252) + _242.z;
        _264 = (0.5 * _252) + _242.y;
        _265 = _252 + _242.x;
        _266 = (float3(1.0) * _236.w) + _236.xyz;
        _267 = normalize((_201 * _239.w) + ((_239.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _263 = _212;
        _264 = 0.5;
        _265 = 1.0;
        _266 = float3(1.0);
        _267 = _201;
    }
    float3 _282 = ((_266 - (_266 * _265)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _289 = (mix(float3(0.07999999821186065673828125 * _264), _266, float3(_265)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _292 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _297;
    if (_292)
    {
        _297 = _282 + (_289 * 0.449999988079071044921875);
    }
    else
    {
        _297 = _282;
    }
    float3 _299 = select(_289, float3(0.0), bool3(_292));
    float3 _301 = float3(dot(_299, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _316 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _321 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _316);
    float4 _323 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_316 + float2(0.0, 0.5)));
    uint _325 = in.in_var_LIGHTMAP_ID * 15u;
    float3 _335 = (_321.xyz * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _325 + 4u)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _325 + 6u)].xyz;
    float _336 = dot(_335, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float _355 = (exp2((_336 * 16.0) - 8.0) - 0.00390625) * fast::max(0.0, dot((_323 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _325 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _325 + 7u)], float4(_267.yzx, 1.0)));
    float4 _366 = float4(_267, 1.0);
    float3 _370 = _132;
    _370.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _366);
    float3 _374 = _370;
    _374.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _366);
    float3 _378 = _374;
    _378.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _366);
    float4 _381 = _366.xyzz * _366.yzzx;
    float3 _385 = _132;
    _385.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _381);
    float3 _389 = _385;
    _389.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _381);
    float3 _393 = _389;
    _393.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _381);
    float3 _407 = (float4(_335 * (_355 / _336), _355).xyz * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_378 + _393) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_267.x * _267.x) - (_267.y * _267.y)))) * View.View_SkyLightColor.xyz) * 1.0);
    float3 _429 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _458;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _457;
        if (any(abs(_193 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _213 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _213 + 19u)].xyz + float3(1.0))))
        {
            _457 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_193, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _457 = _429;
        }
        _458 = _457;
    }
    else
    {
        _458 = _429;
    }
    float4 _465 = float4(((mix(float3(0.0), _297 + (_299 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_407 * _297) * fast::max(float3(1.0), ((((((_266 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_266 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_266 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _458) * 1.0, 0.0);
    float4 _472;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _471 = _465;
        _471.w = 0.0;
        _472 = _471;
    }
    else
    {
        _472 = _465;
    }
    float2 _476 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _484 = (_267 * 0.5) + float3(0.5);
    float4 _486 = float4(_484.x, _484.y, _484.z, float4(0.0).w);
    _486.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _214)].y;
    float4 _487 = float4(0.0);
    _487.x = _265;
    float4 _488 = _487;
    _488.y = _264;
    float4 _489 = _488;
    _489.z = _263;
    float4 _490 = _489;
    _490.w = 0.75686275959014892578125;
    float4 _502 = float4(_266.x, _266.y, _266.z, float4(0.0).w);
    _502.w = ((log2(((dot(_407, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_301 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_301 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_301 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_476.xyx * _476.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _472 * View.View_PreExposure;
    out.out_var_SV_Target1 = _486;
    out.out_var_SV_Target2 = _490;
    out.out_var_SV_Target3 = _502;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

