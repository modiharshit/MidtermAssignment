

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

fragment MainPS_out Main_00003aca_da412d01(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], float4 gl_FragCoord [[position]])
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
    float3 _216 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _230 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _235 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _240 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float3 _247 = fast::clamp(float3(mix(1.0, 0.89999997615814208984375, (_230.x + 0.5) * ((_235.x + 0.5) * (_240.x + 0.5)))), float3(0.0), float3(1.0));
    float _251 = (0.4000000059604644775390625 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _252 = in.in_var_PRIMITIVE_ID * 36u;
    uint _253 = _252 + 20u;
    float _302;
    float _303;
    float _304;
    float3 _305;
    float3 _306;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _253)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _271 = ((_198.xy / float2(_198.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _275 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _271, level(0.0));
        float4 _278 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _271, level(0.0));
        float4 _281 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _271, level(0.0));
        float _291 = _281.w;
        _302 = (_251 * _291) + _281.z;
        _303 = (0.5 * _291) + _281.y;
        _304 = _291 + _281.x;
        _305 = (_247 * _275.w) + _275.xyz;
        _306 = normalize((_216 * _278.w) + ((_278.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _302 = _251;
        _303 = 0.5;
        _304 = 1.0;
        _305 = _247;
        _306 = _216;
    }
    float3 _321 = ((_305 - (_305 * _304)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _328 = (mix(float3(0.07999999821186065673828125 * _303), _305, float3(_304)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _331 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _336;
    if (_331)
    {
        _336 = _321 + (_328 * 0.449999988079071044921875);
    }
    else
    {
        _336 = _321;
    }
    float3 _338 = select(_328, float3(0.0), bool3(_331));
    float3 _340 = float3(dot(_338, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _355 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _360 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _355);
    float4 _362 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_355 + float2(0.0, 0.5)));
    uint _368 = in.in_var_LIGHTMAP_ID * 15u;
    uint _369 = _368 + 4u;
    uint _374 = _368 + 6u;
    float3 _379 = _360.xyz;
    float _431;
    float _432;
    float3 _433;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _415 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _419 = _415.w;
        float _420 = _419 * _419;
        float3 _422 = normalize(((_415.xyz * 2.0) - float3(1.0)).xyz);
        float _423 = 1.0 - _420;
        float _425 = 1.0 - (_423 * _423);
        _431 = mix(fast::clamp(dot(_422, _306), 0.0, 1.0), 1.0, _425);
        _432 = _420;
        _433 = mix(_422, _306, float3(_425));
    }
    else
    {
        _431 = 1.0;
        _432 = 1.0;
        _433 = _306;
    }
    float4 _437 = float4(_433, 1.0);
    float3 _441 = _142;
    _441.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _437);
    float3 _445 = _441;
    _445.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _437);
    float3 _449 = _445;
    _449.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _437);
    float4 _452 = _437.xyzz * _437.yzzx;
    float3 _456 = _142;
    _456.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _452);
    float3 _460 = _456;
    _460.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _452);
    float3 _464 = _460;
    _464.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _452);
    float3 _479 = (((((_379 * _379) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _369)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _374)].xyz) * ((exp2(((_360.w + ((_362.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _369)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _374)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_362 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _368 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _368 + 7u)], float4(_306.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_449 + _464) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_433.x * _433.x) - (_433.y * _433.y)))) * View.View_SkyLightColor.xyz) * (_432 * _431));
    float3 _501 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _530;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _529;
        if (any(abs(_208 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _252 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _252 + 19u)].xyz + float3(1.0))))
        {
            _529 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_208, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _529 = _501;
        }
        _530 = _529;
    }
    else
    {
        _530 = _501;
    }
    float4 _537 = float4(((mix(float3(0.0), _336 + (_338 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_479 * _336) * fast::max(float3(1.0), ((((((_305 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_305 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_305 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _530) * 1.0, 0.0);
    float4 _544;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _543 = _537;
        _543.w = 0.0;
        _544 = _543;
    }
    else
    {
        _544 = _537;
    }
    float2 _548 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _556 = (_306 * 0.5) + float3(0.5);
    float4 _558 = float4(_556.x, _556.y, _556.z, float4(0.0).w);
    _558.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _253)].y;
    float4 _559 = float4(0.0);
    _559.x = _304;
    float4 _560 = _559;
    _560.y = _303;
    float4 _561 = _560;
    _561.z = _302;
    float4 _562 = _561;
    _562.w = 0.75686275959014892578125;
    float4 _574 = float4(_305.x, _305.y, _305.z, float4(0.0).w);
    _574.w = ((log2(((dot(_479, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_340 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_340 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_340 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_548.xyx * _548.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _544 * View.View_PreExposure;
    out.out_var_SV_Target1 = _558;
    out.out_var_SV_Target2 = _562;
    out.out_var_SV_Target3 = _574;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

