

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

constant float3 _145 = {};
constant float _146 = {};

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

fragment MainPS_out Main_00003e10_5f18cc34(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _201 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _146, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _206 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _211 = (_206.xyz / float3(_206.w)) - View.View_PreViewTranslation;
    float4 _217 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _220 = (_217.xy * float2(2.0)) - float2(1.0);
    float3 _236 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_220, sqrt(fast::clamp(1.0 - dot(_220, _220), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _248 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _253 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _258 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _262 = (_248.x + 0.5) * ((_253.x + 0.5) * (_258.x + 0.5));
    float4 _268 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _274 = fast::clamp(mix(float3(0.5), float3(1.0), float3(_262)) * _268.xyz, float3(0.0), float3(1.0));
    float _279 = (fast::clamp(mix(0.5, 0.300000011920928955078125, _262 * _268.w), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _280 = in.in_var_PRIMITIVE_ID * 36u;
    uint _281 = _280 + 20u;
    float _330;
    float _331;
    float _332;
    float3 _333;
    float3 _334;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _281)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _299 = ((_201.xy / float2(_201.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _303 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _299, level(0.0));
        float4 _306 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _299, level(0.0));
        float4 _309 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _299, level(0.0));
        float _319 = _309.w;
        _330 = (_279 * _319) + _309.z;
        _331 = (0.5 * _319) + _309.y;
        _332 = _319 + _309.x;
        _333 = (_274 * _303.w) + _303.xyz;
        _334 = normalize((_236 * _306.w) + ((_306.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _330 = _279;
        _331 = 0.5;
        _332 = 1.0;
        _333 = _274;
        _334 = _236;
    }
    float3 _349 = ((_333 - (_333 * _332)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _356 = (mix(float3(0.07999999821186065673828125 * _331), _333, float3(_332)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _359 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _364;
    if (_359)
    {
        _364 = _349 + (_356 * 0.449999988079071044921875);
    }
    else
    {
        _364 = _349;
    }
    float3 _366 = select(_356, float3(0.0), bool3(_359));
    float3 _368 = float3(dot(_366, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _383 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _388 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _383);
    float4 _390 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_383 + float2(0.0, 0.5)));
    uint _396 = in.in_var_LIGHTMAP_ID * 15u;
    uint _397 = _396 + 4u;
    uint _402 = _396 + 6u;
    float3 _407 = _388.xyz;
    float _459;
    float _460;
    float3 _461;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _443 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _447 = _443.w;
        float _448 = _447 * _447;
        float3 _450 = normalize(((_443.xyz * 2.0) - float3(1.0)).xyz);
        float _451 = 1.0 - _448;
        float _453 = 1.0 - (_451 * _451);
        _459 = mix(fast::clamp(dot(_450, _334), 0.0, 1.0), 1.0, _453);
        _460 = _448;
        _461 = mix(_450, _334, float3(_453));
    }
    else
    {
        _459 = 1.0;
        _460 = 1.0;
        _461 = _334;
    }
    float4 _465 = float4(_461, 1.0);
    float3 _469 = _145;
    _469.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _465);
    float3 _473 = _469;
    _473.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _465);
    float3 _477 = _473;
    _477.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _465);
    float4 _480 = _465.xyzz * _465.yzzx;
    float3 _484 = _145;
    _484.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _480);
    float3 _488 = _484;
    _488.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _480);
    float3 _492 = _488;
    _492.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _480);
    float3 _507 = (((((_407 * _407) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _397)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _402)].xyz) * ((exp2(((_388.w + ((_390.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _397)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _402)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_390 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _396 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _396 + 7u)], float4(_334.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_477 + _492) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_461.x * _461.x) - (_461.y * _461.y)))) * View.View_SkyLightColor.xyz) * (_460 * _459));
    float3 _529 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _558;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _557;
        if (any(abs(_211 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _280 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _280 + 19u)].xyz + float3(1.0))))
        {
            _557 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_211, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _557 = _529;
        }
        _558 = _557;
    }
    else
    {
        _558 = _529;
    }
    float4 _565 = float4(((mix(float3(0.0), _364 + (_366 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_507 * _364) * fast::max(float3(1.0), ((((((_333 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_333 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_333 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _558) * 1.0, 0.0);
    float4 _572;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _571 = _565;
        _571.w = 0.0;
        _572 = _571;
    }
    else
    {
        _572 = _565;
    }
    float2 _576 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _584 = (_334 * 0.5) + float3(0.5);
    float4 _586 = float4(_584.x, _584.y, _584.z, float4(0.0).w);
    _586.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _281)].y;
    float4 _587 = float4(0.0);
    _587.x = _332;
    float4 _588 = _587;
    _588.y = _331;
    float4 _589 = _588;
    _589.z = _330;
    float4 _590 = _589;
    _590.w = 0.75686275959014892578125;
    float4 _602 = float4(_333.x, _333.y, _333.z, float4(0.0).w);
    _602.w = ((log2(((dot(_507, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_368 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_368 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_368 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_576.xyx * _576.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _572 * View.View_PreExposure;
    out.out_var_SV_Target1 = _586;
    out.out_var_SV_Target2 = _590;
    out.out_var_SV_Target3 = _602;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

