

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
    char _m14_pad[188];
    float View_ShowDecalsMask;
    char _m15_pad[184];
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

constant float _128 = {};

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

fragment MainPS_out Main_00002bc6_9b8a3eec(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    float4 _177 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _128, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _182 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _187 = (_182.xyz / float3(_182.w)) - View.View_PreViewTranslation;
    float3 _195 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    uint _204 = in.in_var_PRIMITIVE_ID * 36u;
    uint _205 = _204 + 20u;
    float _250;
    float _251;
    float _252;
    float3 _253;
    float3 _254;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _205)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _223 = ((_177.xy / float2(_177.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _230 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _223, level(0.0));
        float4 _233 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _223, level(0.0));
        float _242 = _233.w;
        _250 = (View.View_RoughnessOverrideParameter.x * _242) + _233.z;
        _251 = (0.5 * _242) + _233.y;
        _252 = _233.x;
        _253 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _223, level(0.0)).xyz;
        _254 = normalize((_195 * _230.w) + ((_230.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _250 = View.View_RoughnessOverrideParameter.x;
        _251 = 0.5;
        _252 = 0.0;
        _253 = float3(0.0);
        _254 = _195;
    }
    float3 _269 = ((_253 - (_253 * _252)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _276 = (mix(float3(0.07999999821186065673828125 * _251), _253, float3(_252)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _279 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _284;
    if (_279)
    {
        _284 = _269 + (_276 * 0.449999988079071044921875);
    }
    else
    {
        _284 = _269;
    }
    float3 _286 = select(_276, float3(0.0), bool3(_279));
    float3 _288 = float3(dot(_286, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _303 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _308 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _303);
    float4 _310 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_303 + float2(0.0, 0.5)));
    uint _312 = in.in_var_LIGHTMAP_ID * 15u;
    float3 _322 = (_308.xyz * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _312 + 4u)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _312 + 6u)].xyz;
    float _323 = dot(_322, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float _342 = (exp2((_323 * 16.0) - 8.0) - 0.00390625) * fast::max(0.0, dot((_310 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _312 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _312 + 7u)], float4(_254.yzx, 1.0)));
    float3 _352 = float4(_322 * (_342 / _323), _342).xyz * View.View_IndirectLightingColorScale;
    float3 _374 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _403;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _402;
        if (any(abs(_187 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _204 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _204 + 19u)].xyz + float3(1.0))))
        {
            _402 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_187, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _402 = _374;
        }
        _403 = _402;
    }
    else
    {
        _403 = _374;
    }
    float4 _410 = float4(((mix(float3(0.0), _284 + (_286 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_352 * _284) * fast::max(float3(1.0), ((((((_253 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_253 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_253 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _403) * 1.0, 0.0);
    float4 _417;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _416 = _410;
        _416.w = 0.0;
        _417 = _416;
    }
    else
    {
        _417 = _410;
    }
    float2 _421 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _429 = (_254 * 0.5) + float3(0.5);
    float4 _431 = float4(_429.x, _429.y, _429.z, float4(0.0).w);
    _431.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _205)].y;
    float4 _432 = float4(0.0);
    _432.x = _252;
    float4 _433 = _432;
    _433.y = _251;
    float4 _434 = _433;
    _434.z = _250;
    float4 _435 = _434;
    _435.w = 0.75686275959014892578125;
    float4 _447 = float4(_253.x, _253.y, _253.z, float4(0.0).w);
    _447.w = ((log2(((dot(_352, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_288 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_288 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_288 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_421.xyx * _421.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _417 * View.View_PreExposure;
    out.out_var_SV_Target1 = _431;
    out.out_var_SV_Target2 = _435;
    out.out_var_SV_Target3 = _447;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

