

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
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float3 _149 = {};
constant float _150 = {};

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

fragment MainPS_out Main_00003c66_e8826904(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> Material_Texture2D_0 [[texture(4)]], texture2d<float> Material_Texture2D_1 [[texture(5)]], texture2d<float> Material_Texture2D_2 [[texture(6)]], texture2d<float> Material_Texture2D_3 [[texture(7)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float3x3 _193 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _204 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _150, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _209 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _213 = _209.xyz / float3(_209.w);
    float3 _214 = _213 - View.View_PreViewTranslation;
    float2 _218 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5;
    float4 _224 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _218, bias(View.View_MaterialTextureMipBias));
    float2 _230 = ((normalize(-_213) * _193).xy * ((0.00999999977648258209228515625 * _224.w) + (-0.008000000379979610443115234375))) + _218;
    float4 _234 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _230, bias(View.View_MaterialTextureMipBias));
    float2 _237 = (_234.xy * float2(2.0)) - float2(1.0);
    float3 _253 = normalize(_193 * normalize((float4(_237, sqrt(fast::clamp(1.0 - dot(_237, _237), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _265 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _270 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _275 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _279 = (_265.x + 0.5) * ((_270.x + 0.5) * (_275.x + 0.5));
    float4 _282 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _230, bias(View.View_MaterialTextureMipBias));
    float4 _288 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _230, bias(View.View_MaterialTextureMipBias));
    float3 _293 = fast::clamp(_282.xyz * mix(0.5, 1.0, _279), float3(0.0), float3(1.0));
    float _294 = fast::clamp(_288.y, 0.0, 1.0);
    float _299 = (fast::clamp(mix(0.300000011920928955078125, 0.800000011920928955078125, _279 * _288.x), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _300 = in.in_var_PRIMITIVE_ID * 36u;
    uint _301 = _300 + 20u;
    float _349;
    float _350;
    float _351;
    float3 _352;
    float3 _353;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _301)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _319 = ((_204.xy / float2(_204.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _323 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _319, level(0.0));
        float4 _326 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _319, level(0.0));
        float4 _329 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _319, level(0.0));
        float _339 = _329.w;
        _349 = (_299 * _339) + _329.z;
        _350 = (0.5 * _339) + _329.y;
        _351 = _329.x;
        _352 = (_293 * _323.w) + _323.xyz;
        _353 = normalize((_253 * _326.w) + ((_326.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _349 = _299;
        _350 = 0.5;
        _351 = 0.0;
        _352 = _293;
        _353 = _253;
    }
    float3 _368 = ((_352 - (_352 * _351)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _375 = (mix(float3(0.07999999821186065673828125 * _350), _352, float3(_351)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _378 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _383;
    if (_378)
    {
        _383 = _368 + (_375 * 0.449999988079071044921875);
    }
    else
    {
        _383 = _368;
    }
    float3 _385 = select(_375, float3(0.0), bool3(_378));
    float3 _387 = float3(dot(_385, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _394 = float3(_294);
    float2 _403 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _408 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _403);
    float4 _410 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_403 + float2(0.0, 0.5)));
    uint _412 = in.in_var_LIGHTMAP_ID * 15u;
    float3 _422 = (_408.xyz * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _412 + 4u)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _412 + 6u)].xyz;
    float _423 = dot(_422, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float _442 = (exp2((_423 * 16.0) - 8.0) - 0.00390625) * fast::max(0.0, dot((_410 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _412 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _412 + 7u)], float4(_353.yzx, 1.0)));
    float4 _453 = float4(_353, 1.0);
    float3 _457 = _149;
    _457.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _453);
    float3 _461 = _457;
    _461.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _453);
    float3 _465 = _461;
    _465.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _453);
    float4 _468 = _453.xyzz * _453.yzzx;
    float3 _472 = _149;
    _472.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _468);
    float3 _476 = _472;
    _476.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _468);
    float3 _480 = _476;
    _480.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _468);
    float3 _494 = (float4(_422 * (_442 / _423), _442).xyz * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_465 + _480) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_353.x * _353.x) - (_353.y * _353.y)))) * View.View_SkyLightColor.xyz) * 1.0);
    float3 _516 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _545;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _544;
        if (any(abs(_214 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _300 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _300 + 19u)].xyz + float3(1.0))))
        {
            _544 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_214, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _544 = _516;
        }
        _545 = _544;
    }
    else
    {
        _545 = _516;
    }
    float4 _552 = float4(((mix(float3(0.0), _383 + (_385 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_494 * _383) * fast::max(_394, ((((((_352 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _294) + ((_352 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _294) + ((_352 * 2.755199909210205078125) + float3(0.69029998779296875))) * _294))) + _545) * 1.0, 0.0);
    float4 _559;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _558 = _552;
        _558.w = 0.0;
        _559 = _558;
    }
    else
    {
        _559 = _552;
    }
    float2 _563 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _571 = (_353 * 0.5) + float3(0.5);
    float4 _573 = float4(_571.x, _571.y, _571.z, float4(0.0).w);
    _573.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _301)].y;
    float4 _574 = float4(0.0);
    _574.x = _351;
    float4 _575 = _574;
    _575.y = _350;
    float4 _576 = _575;
    _576.z = _349;
    float4 _577 = _576;
    _577.w = 0.75686275959014892578125;
    float4 _589 = float4(_352.x, _352.y, _352.z, float4(0.0).w);
    _589.w = ((log2(((dot(_494, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_394, ((((((_387 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _294) + ((_387 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _294) + ((_387 * 2.755199909210205078125) + float3(0.69029998779296875))) * _294).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_563.xyx * _563.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _559 * View.View_PreExposure;
    out.out_var_SV_Target1 = _573;
    out.out_var_SV_Target2 = _577;
    out.out_var_SV_Target3 = _589;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

