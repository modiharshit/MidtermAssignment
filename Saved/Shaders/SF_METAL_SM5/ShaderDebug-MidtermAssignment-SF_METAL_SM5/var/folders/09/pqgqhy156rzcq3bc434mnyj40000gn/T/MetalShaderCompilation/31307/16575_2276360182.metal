

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

fragment MainPS_out Main_000040bf_87ae7ff6(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], texture2d<float> LightmapResourceCluster_StaticShadowTexture [[texture(5)]], texture2d<float> Material_Texture2D_0 [[texture(6)]], texture2d<float> Material_Texture2D_1 [[texture(7)]], texture2d<float> Material_Texture2D_2 [[texture(8)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _205 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _150, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _210 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _215 = (_210.xyz / float3(_210.w)) - View.View_PreViewTranslation;
    float4 _221 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _224 = (_221.xy * float2(2.0)) - float2(1.0);
    float3 _240 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_224, sqrt(fast::clamp(1.0 - dot(_224, _224), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _252 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _257 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _262 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _266 = (_252.x + 0.5) * ((_257.x + 0.5) * (_262.x + 0.5));
    float4 _272 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _278 = fast::clamp(mix(float3(0.5), float3(1.0), float3(_266)) * _272.xyz, float3(0.0), float3(1.0));
    float _283 = (fast::clamp(mix(0.5, 0.300000011920928955078125, _266 * _272.w), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _284 = in.in_var_PRIMITIVE_ID * 36u;
    uint _285 = _284 + 20u;
    float _334;
    float _335;
    float _336;
    float3 _337;
    float3 _338;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _285)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _303 = ((_205.xy / float2(_205.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _307 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _303, level(0.0));
        float4 _310 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _303, level(0.0));
        float4 _313 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _303, level(0.0));
        float _323 = _313.w;
        _334 = (_283 * _323) + _313.z;
        _335 = (0.5 * _323) + _313.y;
        _336 = _323 + _313.x;
        _337 = (_278 * _307.w) + _307.xyz;
        _338 = normalize((_240 * _310.w) + ((_310.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _334 = _283;
        _335 = 0.5;
        _336 = 1.0;
        _337 = _278;
        _338 = _240;
    }
    float4 _345 = LightmapResourceCluster_StaticShadowTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.zw);
    uint _346 = in.in_var_LIGHTMAP_ID * 15u;
    uint _347 = _346 + 1u;
    float4 _354 = fast::clamp((_345 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _347)]) + ((View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _347)] * (-0.5)) + float4(0.5)), float4(0.0), float4(1.0));
    float3 _371 = ((_337 - (_337 * _336)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _378 = (mix(float3(0.07999999821186065673828125 * _335), _337, float3(_336)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _381 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _386;
    if (_381)
    {
        _386 = _371 + (_378 * 0.449999988079071044921875);
    }
    else
    {
        _386 = _371;
    }
    float3 _388 = select(_378, float3(0.0), bool3(_381));
    float3 _390 = float3(dot(_388, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _405 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _409 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _405);
    float4 _411 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_405 + float2(0.0, 0.5)));
    uint _417 = _346 + 4u;
    uint _422 = _346 + 6u;
    float3 _427 = _409.xyz;
    float _479;
    float _480;
    float3 _481;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _463 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _467 = _463.w;
        float _468 = _467 * _467;
        float3 _470 = normalize(((_463.xyz * 2.0) - float3(1.0)).xyz);
        float _471 = 1.0 - _468;
        float _473 = 1.0 - (_471 * _471);
        _479 = mix(fast::clamp(dot(_470, _338), 0.0, 1.0), 1.0, _473);
        _480 = _468;
        _481 = mix(_470, _338, float3(_473));
    }
    else
    {
        _479 = 1.0;
        _480 = 1.0;
        _481 = _338;
    }
    float4 _485 = float4(_481, 1.0);
    float3 _489 = _149;
    _489.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _485);
    float3 _493 = _489;
    _493.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _485);
    float3 _497 = _493;
    _497.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _485);
    float4 _500 = _485.xyzz * _485.yzzx;
    float3 _504 = _149;
    _504.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _500);
    float3 _508 = _504;
    _508.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _500);
    float3 _512 = _508;
    _512.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _500);
    float3 _527 = (((((_427 * _427) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _417)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _422)].xyz) * ((exp2(((_409.w + ((_411.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _417)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _422)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_411 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _346 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _346 + 7u)], float4(_338.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_497 + _512) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_481.x * _481.x) - (_481.y * _481.y)))) * View.View_SkyLightColor.xyz) * (_480 * _479));
    float3 _549 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _578;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _577;
        if (any(abs(_215 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _284 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _284 + 19u)].xyz + float3(1.0))))
        {
            _577 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_215, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _577 = _549;
        }
        _578 = _577;
    }
    else
    {
        _578 = _549;
    }
    float4 _585 = float4(((mix(float3(0.0), _386 + (_388 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_527 * _386) * fast::max(float3(1.0), ((((((_337 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_337 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_337 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _578) * 1.0, 0.0);
    float4 _592;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _591 = _585;
        _591.w = 0.0;
        _592 = _591;
    }
    else
    {
        _592 = _585;
    }
    float2 _596 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _604 = (_338 * 0.5) + float3(0.5);
    float4 _606 = float4(_604.x, _604.y, _604.z, float4(0.0).w);
    _606.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _285)].y;
    float4 _607 = float4(0.0);
    _607.x = _336;
    float4 _608 = _607;
    _608.y = _335;
    float4 _609 = _608;
    _609.z = _334;
    float4 _610 = _609;
    _610.w = 0.50588238239288330078125;
    float4 _622 = float4(_337.x, _337.y, _337.z, float4(0.0).w);
    _622.w = ((log2(((dot(_527, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_390 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_390 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_390 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_596.xyx * _596.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _592 * View.View_PreExposure;
    out.out_var_SV_Target1 = _606;
    out.out_var_SV_Target2 = _610;
    out.out_var_SV_Target3 = _622;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = (View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _346)] * _354) * _354;
    return out;
}

