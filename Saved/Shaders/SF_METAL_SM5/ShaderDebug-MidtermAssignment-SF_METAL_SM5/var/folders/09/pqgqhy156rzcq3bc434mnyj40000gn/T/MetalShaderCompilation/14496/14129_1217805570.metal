

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

constant float3 _133 = {};
constant float _134 = {};

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

fragment MainPS_out Main_00003731_48963d02(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _185 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _134, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _190 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _195 = (_190.xyz / float3(_190.w)) - View.View_PreViewTranslation;
    float3 _203 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _218 = fast::clamp(Material.Material_VectorExpressions[3].xyz, float3(0.0), float3(1.0));
    float _219 = fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0);
    float _224 = (fast::clamp(Material.Material_ScalarExpressions[0].z, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _225 = in.in_var_PRIMITIVE_ID * 36u;
    uint _226 = _225 + 20u;
    float _276;
    float _277;
    float _278;
    float3 _279;
    float3 _280;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _226)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _244 = ((_185.xy / float2(_185.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _248 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _244, level(0.0));
        float4 _251 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _244, level(0.0));
        float4 _254 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _244, level(0.0));
        float _264 = _254.w;
        _276 = (_224 * _264) + _254.z;
        _277 = (0.5 * _264) + _254.y;
        _278 = (_219 * _264) + _254.x;
        _279 = (_218 * _248.w) + _248.xyz;
        _280 = normalize((_203 * _251.w) + ((_251.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _276 = _224;
        _277 = 0.5;
        _278 = _219;
        _279 = _218;
        _280 = _203;
    }
    float3 _295 = ((_279 - (_279 * _278)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _302 = (mix(float3(0.07999999821186065673828125 * _277), _279, float3(_278)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _305 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _310;
    if (_305)
    {
        _310 = _295 + (_302 * 0.449999988079071044921875);
    }
    else
    {
        _310 = _295;
    }
    float3 _312 = select(_302, float3(0.0), bool3(_305));
    float3 _314 = float3(dot(_312, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _329 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _334 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _329);
    float4 _336 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_329 + float2(0.0, 0.5)));
    uint _342 = in.in_var_LIGHTMAP_ID * 15u;
    uint _343 = _342 + 4u;
    uint _348 = _342 + 6u;
    float3 _353 = _334.xyz;
    float _405;
    float _406;
    float3 _407;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _389 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _393 = _389.w;
        float _394 = _393 * _393;
        float3 _396 = normalize(((_389.xyz * 2.0) - float3(1.0)).xyz);
        float _397 = 1.0 - _394;
        float _399 = 1.0 - (_397 * _397);
        _405 = mix(fast::clamp(dot(_396, _280), 0.0, 1.0), 1.0, _399);
        _406 = _394;
        _407 = mix(_396, _280, float3(_399));
    }
    else
    {
        _405 = 1.0;
        _406 = 1.0;
        _407 = _280;
    }
    float4 _411 = float4(_407, 1.0);
    float3 _415 = _133;
    _415.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _411);
    float3 _419 = _415;
    _419.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _411);
    float3 _423 = _419;
    _423.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _411);
    float4 _426 = _411.xyzz * _411.yzzx;
    float3 _430 = _133;
    _430.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _426);
    float3 _434 = _430;
    _434.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _426);
    float3 _438 = _434;
    _438.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _426);
    float3 _453 = (((((_353 * _353) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _343)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _348)].xyz) * ((exp2(((_334.w + ((_336.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _343)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _348)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_336 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _342 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _342 + 7u)], float4(_280.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_423 + _438) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_407.x * _407.x) - (_407.y * _407.y)))) * View.View_SkyLightColor.xyz) * (_406 * _405));
    float3 _475 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _504;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _503;
        if (any(abs(_195 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _225 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _225 + 19u)].xyz + float3(1.0))))
        {
            _503 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_195, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _503 = _475;
        }
        _504 = _503;
    }
    else
    {
        _504 = _475;
    }
    float4 _511 = float4(((mix(float3(0.0), _310 + (_312 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_453 * _310) * fast::max(float3(1.0), ((((((_279 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_279 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_279 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _504) * 1.0, 0.0);
    float4 _518;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _517 = _511;
        _517.w = 0.0;
        _518 = _517;
    }
    else
    {
        _518 = _511;
    }
    float2 _522 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _530 = (_280 * 0.5) + float3(0.5);
    float4 _532 = float4(_530.x, _530.y, _530.z, float4(0.0).w);
    _532.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _226)].y;
    float4 _533 = float4(0.0);
    _533.x = _278;
    float4 _534 = _533;
    _534.y = _277;
    float4 _535 = _534;
    _535.z = _276;
    float4 _536 = _535;
    _536.w = 0.75686275959014892578125;
    float4 _548 = float4(_279.x, _279.y, _279.z, float4(0.0).w);
    _548.w = ((log2(((dot(_453, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_314 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_314 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_314 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_522.xyx * _522.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _518 * View.View_PreExposure;
    out.out_var_SV_Target1 = _532;
    out.out_var_SV_Target2 = _536;
    out.out_var_SV_Target3 = _548;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

