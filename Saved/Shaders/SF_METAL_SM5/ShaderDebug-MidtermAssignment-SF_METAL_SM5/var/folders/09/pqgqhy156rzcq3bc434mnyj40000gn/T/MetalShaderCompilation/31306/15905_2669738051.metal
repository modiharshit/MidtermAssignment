

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

constant float3 _147 = {};
constant float _148 = {};

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

fragment MainPS_out Main_00003e21_9f20f843(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _203 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _148, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _208 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _213 = (_208.xyz / float3(_208.w)) - View.View_PreViewTranslation;
    float4 _219 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _222 = (_219.xy * float2(2.0)) - float2(1.0);
    float3 _238 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_222, sqrt(fast::clamp(1.0 - dot(_222, _222), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _250 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _255 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _260 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _264 = (_250.x + 0.5) * ((_255.x + 0.5) * (_260.x + 0.5));
    float4 _270 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _276 = fast::clamp(mix(float3(0.800000011920928955078125), float3(1.0), float3(_264)) * _270.xyz, float3(0.0), float3(1.0));
    float _281 = (fast::clamp(mix(0.800000011920928955078125, 0.5, _264 * _270.w), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _282 = in.in_var_PRIMITIVE_ID * 36u;
    uint _283 = _282 + 20u;
    float _331;
    float _332;
    float _333;
    float3 _334;
    float3 _335;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _283)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _301 = ((_203.xy / float2(_203.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _305 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _301, level(0.0));
        float4 _308 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _301, level(0.0));
        float4 _311 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _301, level(0.0));
        float _321 = _311.w;
        _331 = (_281 * _321) + _311.z;
        _332 = (0.5 * _321) + _311.y;
        _333 = _311.x;
        _334 = (_276 * _305.w) + _305.xyz;
        _335 = normalize((_238 * _308.w) + ((_308.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _331 = _281;
        _332 = 0.5;
        _333 = 0.0;
        _334 = _276;
        _335 = _238;
    }
    float3 _350 = ((_334 - (_334 * _333)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _357 = (mix(float3(0.07999999821186065673828125 * _332), _334, float3(_333)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _360 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _365;
    if (_360)
    {
        _365 = _350 + (_357 * 0.449999988079071044921875);
    }
    else
    {
        _365 = _350;
    }
    float3 _367 = select(_357, float3(0.0), bool3(_360));
    float3 _369 = float3(dot(_367, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _384 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _389 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _384);
    float4 _391 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_384 + float2(0.0, 0.5)));
    uint _397 = in.in_var_LIGHTMAP_ID * 15u;
    uint _398 = _397 + 4u;
    uint _403 = _397 + 6u;
    float3 _408 = _389.xyz;
    float _460;
    float _461;
    float3 _462;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _444 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _448 = _444.w;
        float _449 = _448 * _448;
        float3 _451 = normalize(((_444.xyz * 2.0) - float3(1.0)).xyz);
        float _452 = 1.0 - _449;
        float _454 = 1.0 - (_452 * _452);
        _460 = mix(fast::clamp(dot(_451, _335), 0.0, 1.0), 1.0, _454);
        _461 = _449;
        _462 = mix(_451, _335, float3(_454));
    }
    else
    {
        _460 = 1.0;
        _461 = 1.0;
        _462 = _335;
    }
    float4 _466 = float4(_462, 1.0);
    float3 _470 = _147;
    _470.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _466);
    float3 _474 = _470;
    _474.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _466);
    float3 _478 = _474;
    _478.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _466);
    float4 _481 = _466.xyzz * _466.yzzx;
    float3 _485 = _147;
    _485.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _481);
    float3 _489 = _485;
    _489.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _481);
    float3 _493 = _489;
    _493.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _481);
    float3 _508 = (((((_408 * _408) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _398)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _403)].xyz) * ((exp2(((_389.w + ((_391.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _398)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _403)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_391 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _397 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _397 + 7u)], float4(_335.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_478 + _493) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_462.x * _462.x) - (_462.y * _462.y)))) * View.View_SkyLightColor.xyz) * (_461 * _460));
    float3 _530 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _559;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _558;
        if (any(abs(_213 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _282 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _282 + 19u)].xyz + float3(1.0))))
        {
            _558 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_213, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _558 = _530;
        }
        _559 = _558;
    }
    else
    {
        _559 = _530;
    }
    float4 _566 = float4(((mix(float3(0.0), _365 + (_367 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_508 * _365) * fast::max(float3(1.0), ((((((_334 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_334 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_334 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _559) * 1.0, 0.0);
    float4 _573;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _572 = _566;
        _572.w = 0.0;
        _573 = _572;
    }
    else
    {
        _573 = _566;
    }
    float2 _577 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _585 = (_335 * 0.5) + float3(0.5);
    float4 _587 = float4(_585.x, _585.y, _585.z, float4(0.0).w);
    _587.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _283)].y;
    float4 _588 = float4(0.0);
    _588.x = _333;
    float4 _589 = _588;
    _589.y = _332;
    float4 _590 = _589;
    _590.z = _331;
    float4 _591 = _590;
    _591.w = 0.75686275959014892578125;
    float4 _603 = float4(_334.x, _334.y, _334.z, float4(0.0).w);
    _603.w = ((log2(((dot(_508, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_369 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_369 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_369 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_577.xyx * _577.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _573 * View.View_PreExposure;
    out.out_var_SV_Target1 = _587;
    out.out_var_SV_Target2 = _591;
    out.out_var_SV_Target3 = _603;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

