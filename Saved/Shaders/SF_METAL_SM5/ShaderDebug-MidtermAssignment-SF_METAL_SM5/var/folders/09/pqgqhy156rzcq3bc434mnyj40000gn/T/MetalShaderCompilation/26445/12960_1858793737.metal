

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
    spvUnsafeArray<float4, 4> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float3 _131 = {};
constant float _132 = {};

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

fragment MainPS_out Main_000032a0_6ecaf109(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _182 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _132, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _187 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _192 = (_187.xyz / float3(_187.w)) - View.View_PreViewTranslation;
    float3 _200 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _213 = fast::clamp(Material.Material_VectorExpressions[3].xyz, float3(0.0), float3(1.0));
    float _218 = (fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _219 = in.in_var_PRIMITIVE_ID * 36u;
    uint _220 = _219 + 20u;
    float _268;
    float _269;
    float _270;
    float3 _271;
    float3 _272;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _220)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _238 = ((_182.xy / float2(_182.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _242 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _238, level(0.0));
        float4 _245 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _238, level(0.0));
        float4 _248 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _238, level(0.0));
        float _258 = _248.w;
        _268 = (_218 * _258) + _248.z;
        _269 = (0.5 * _258) + _248.y;
        _270 = _248.x;
        _271 = (_213 * _242.w) + _242.xyz;
        _272 = normalize((_200 * _245.w) + ((_245.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _268 = _218;
        _269 = 0.5;
        _270 = 0.0;
        _271 = _213;
        _272 = _200;
    }
    float3 _287 = ((_271 - (_271 * _270)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _294 = (mix(float3(0.07999999821186065673828125 * _269), _271, float3(_270)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _297 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _302;
    if (_297)
    {
        _302 = _287 + (_294 * 0.449999988079071044921875);
    }
    else
    {
        _302 = _287;
    }
    float3 _304 = select(_294, float3(0.0), bool3(_297));
    float3 _306 = float3(dot(_304, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _321 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _326 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _321);
    float4 _328 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_321 + float2(0.0, 0.5)));
    uint _330 = in.in_var_LIGHTMAP_ID * 15u;
    float3 _340 = (_326.xyz * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _330 + 4u)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _330 + 6u)].xyz;
    float _341 = dot(_340, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float _360 = (exp2((_341 * 16.0) - 8.0) - 0.00390625) * fast::max(0.0, dot((_328 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _330 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _330 + 7u)], float4(_272.yzx, 1.0)));
    float4 _371 = float4(_272, 1.0);
    float3 _375 = _131;
    _375.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _371);
    float3 _379 = _375;
    _379.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _371);
    float3 _383 = _379;
    _383.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _371);
    float4 _386 = _371.xyzz * _371.yzzx;
    float3 _390 = _131;
    _390.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _386);
    float3 _394 = _390;
    _394.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _386);
    float3 _398 = _394;
    _398.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _386);
    float3 _412 = (float4(_340 * (_360 / _341), _360).xyz * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_383 + _398) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_272.x * _272.x) - (_272.y * _272.y)))) * View.View_SkyLightColor.xyz) * 1.0);
    float3 _434 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _463;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _462;
        if (any(abs(_192 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _219 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _219 + 19u)].xyz + float3(1.0))))
        {
            _462 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_192, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _462 = _434;
        }
        _463 = _462;
    }
    else
    {
        _463 = _434;
    }
    float4 _470 = float4(((mix(float3(0.0), _302 + (_304 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_412 * _302) * fast::max(float3(1.0), ((((((_271 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_271 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_271 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _463) * 1.0, 0.0);
    float4 _477;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _476 = _470;
        _476.w = 0.0;
        _477 = _476;
    }
    else
    {
        _477 = _470;
    }
    float2 _481 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _489 = (_272 * 0.5) + float3(0.5);
    float4 _491 = float4(_489.x, _489.y, _489.z, float4(0.0).w);
    _491.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _220)].y;
    float4 _492 = float4(0.0);
    _492.x = _270;
    float4 _493 = _492;
    _493.y = _269;
    float4 _494 = _493;
    _494.z = _268;
    float4 _495 = _494;
    _495.w = 0.75686275959014892578125;
    float4 _507 = float4(_271.x, _271.y, _271.z, float4(0.0).w);
    _507.w = ((log2(((dot(_412, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_306 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_306 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_306 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_481.xyx * _481.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _477 * View.View_PreExposure;
    out.out_var_SV_Target1 = _491;
    out.out_var_SV_Target2 = _495;
    out.out_var_SV_Target3 = _507;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

