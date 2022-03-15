

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
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float3 _146 = {};
constant float _147 = {};

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

fragment MainPS_out Main_00003d5a_cf812d94(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], texture2d<float> LightmapResourceCluster_StaticShadowTexture [[texture(5)]], texture2d<float> Material_Texture2D_0 [[texture(6)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _202 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _147, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _207 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _212 = (_207.xyz / float3(_207.w)) - View.View_PreViewTranslation;
    float3 _220 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _234 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _239 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _244 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float3 _251 = fast::clamp(float3(mix(1.0, 0.89999997615814208984375, (_234.x + 0.5) * ((_239.x + 0.5) * (_244.x + 0.5)))), float3(0.0), float3(1.0));
    float _255 = (0.25 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _256 = in.in_var_PRIMITIVE_ID * 36u;
    uint _257 = _256 + 20u;
    float _306;
    float _307;
    float _308;
    float3 _309;
    float3 _310;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _257)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _275 = ((_202.xy / float2(_202.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _279 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _275, level(0.0));
        float4 _282 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _275, level(0.0));
        float4 _285 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _275, level(0.0));
        float _295 = _285.w;
        _306 = (_255 * _295) + _285.z;
        _307 = (0.5 * _295) + _285.y;
        _308 = _295 + _285.x;
        _309 = (_251 * _279.w) + _279.xyz;
        _310 = normalize((_220 * _282.w) + ((_282.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _306 = _255;
        _307 = 0.5;
        _308 = 1.0;
        _309 = _251;
        _310 = _220;
    }
    float4 _317 = LightmapResourceCluster_StaticShadowTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.zw);
    uint _318 = in.in_var_LIGHTMAP_ID * 15u;
    uint _319 = _318 + 1u;
    float4 _326 = fast::clamp((_317 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _319)]) + ((View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _319)] * (-0.5)) + float4(0.5)), float4(0.0), float4(1.0));
    float3 _343 = ((_309 - (_309 * _308)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _350 = (mix(float3(0.07999999821186065673828125 * _307), _309, float3(_308)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _353 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _358;
    if (_353)
    {
        _358 = _343 + (_350 * 0.449999988079071044921875);
    }
    else
    {
        _358 = _343;
    }
    float3 _360 = select(_350, float3(0.0), bool3(_353));
    float3 _362 = float3(dot(_360, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _377 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _381 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _377);
    float4 _383 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_377 + float2(0.0, 0.5)));
    uint _389 = _318 + 4u;
    uint _394 = _318 + 6u;
    float3 _399 = _381.xyz;
    float _451;
    float _452;
    float3 _453;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _435 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _439 = _435.w;
        float _440 = _439 * _439;
        float3 _442 = normalize(((_435.xyz * 2.0) - float3(1.0)).xyz);
        float _443 = 1.0 - _440;
        float _445 = 1.0 - (_443 * _443);
        _451 = mix(fast::clamp(dot(_442, _310), 0.0, 1.0), 1.0, _445);
        _452 = _440;
        _453 = mix(_442, _310, float3(_445));
    }
    else
    {
        _451 = 1.0;
        _452 = 1.0;
        _453 = _310;
    }
    float4 _457 = float4(_453, 1.0);
    float3 _461 = _146;
    _461.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _457);
    float3 _465 = _461;
    _465.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _457);
    float3 _469 = _465;
    _469.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _457);
    float4 _472 = _457.xyzz * _457.yzzx;
    float3 _476 = _146;
    _476.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _472);
    float3 _480 = _476;
    _480.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _472);
    float3 _484 = _480;
    _484.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _472);
    float3 _499 = (((((_399 * _399) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _389)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _394)].xyz) * ((exp2(((_381.w + ((_383.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _389)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _394)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_383 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _318 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _318 + 7u)], float4(_310.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_469 + _484) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_453.x * _453.x) - (_453.y * _453.y)))) * View.View_SkyLightColor.xyz) * (_452 * _451));
    float3 _521 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _550;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _549;
        if (any(abs(_212 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _256 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _256 + 19u)].xyz + float3(1.0))))
        {
            _549 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_212, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _549 = _521;
        }
        _550 = _549;
    }
    else
    {
        _550 = _521;
    }
    float4 _557 = float4(((mix(float3(0.0), _358 + (_360 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_499 * _358) * fast::max(float3(1.0), ((((((_309 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_309 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_309 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _550) * 1.0, 0.0);
    float4 _564;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _563 = _557;
        _563.w = 0.0;
        _564 = _563;
    }
    else
    {
        _564 = _557;
    }
    float2 _568 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _576 = (_310 * 0.5) + float3(0.5);
    float4 _578 = float4(_576.x, _576.y, _576.z, float4(0.0).w);
    _578.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _257)].y;
    float4 _579 = float4(0.0);
    _579.x = _308;
    float4 _580 = _579;
    _580.y = _307;
    float4 _581 = _580;
    _581.z = _306;
    float4 _582 = _581;
    _582.w = 0.50588238239288330078125;
    float4 _594 = float4(_309.x, _309.y, _309.z, float4(0.0).w);
    _594.w = ((log2(((dot(_499, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_362 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_362 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_362 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_568.xyx * _568.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _564 * View.View_PreExposure;
    out.out_var_SV_Target1 = _578;
    out.out_var_SV_Target2 = _582;
    out.out_var_SV_Target3 = _594;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = (View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _318)] * _326) * _326;
    return out;
}

