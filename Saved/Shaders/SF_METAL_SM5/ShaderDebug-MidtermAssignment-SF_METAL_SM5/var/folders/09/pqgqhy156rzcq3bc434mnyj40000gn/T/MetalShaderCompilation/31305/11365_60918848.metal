

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

constant float _129 = {};

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

fragment MainPS_out Main_00002c65_03a18c40(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    float4 _178 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _129, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _183 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _188 = (_183.xyz / float3(_183.w)) - View.View_PreViewTranslation;
    float3 _196 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float _207 = (0.300000011920928955078125 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _208 = in.in_var_PRIMITIVE_ID * 36u;
    uint _209 = _208 + 20u;
    float _257;
    float _258;
    float _259;
    float3 _260;
    float3 _261;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _209)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _227 = ((_178.xy / float2(_178.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _231 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _227, level(0.0));
        float4 _234 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _227, level(0.0));
        float4 _237 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _227, level(0.0));
        float _247 = _237.w;
        _257 = (_207 * _247) + _237.z;
        _258 = (0.5 * _247) + _237.y;
        _259 = _237.x;
        _260 = (float3(0.300000011920928955078125) * _231.w) + _231.xyz;
        _261 = normalize((_196 * _234.w) + ((_234.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _257 = _207;
        _258 = 0.5;
        _259 = 0.0;
        _260 = float3(0.300000011920928955078125);
        _261 = _196;
    }
    float3 _276 = ((_260 - (_260 * _259)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _283 = (mix(float3(0.07999999821186065673828125 * _258), _260, float3(_259)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _286 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _291;
    if (_286)
    {
        _291 = _276 + (_283 * 0.449999988079071044921875);
    }
    else
    {
        _291 = _276;
    }
    float3 _293 = select(_283, float3(0.0), bool3(_286));
    float3 _295 = float3(dot(_293, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _310 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _315 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _310);
    float4 _317 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_310 + float2(0.0, 0.5)));
    uint _319 = in.in_var_LIGHTMAP_ID * 15u;
    float3 _329 = (_315.xyz * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _319 + 4u)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _319 + 6u)].xyz;
    float _330 = dot(_329, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float _349 = (exp2((_330 * 16.0) - 8.0) - 0.00390625) * fast::max(0.0, dot((_317 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _319 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _319 + 7u)], float4(_261.yzx, 1.0)));
    float3 _359 = float4(_329 * (_349 / _330), _349).xyz * View.View_IndirectLightingColorScale;
    float3 _381 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _410;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _409;
        if (any(abs(_188 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _208 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _208 + 19u)].xyz + float3(1.0))))
        {
            _409 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_188, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _409 = _381;
        }
        _410 = _409;
    }
    else
    {
        _410 = _381;
    }
    float4 _417 = float4(((mix(float3(0.0), _291 + (_293 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_359 * _291) * fast::max(float3(1.0), ((((((_260 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_260 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_260 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _410) * 1.0, 0.0);
    float4 _424;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _423 = _417;
        _423.w = 0.0;
        _424 = _423;
    }
    else
    {
        _424 = _417;
    }
    float2 _428 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _436 = (_261 * 0.5) + float3(0.5);
    float4 _438 = float4(_436.x, _436.y, _436.z, float4(0.0).w);
    _438.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _209)].y;
    float4 _439 = float4(0.0);
    _439.x = _259;
    float4 _440 = _439;
    _440.y = _258;
    float4 _441 = _440;
    _441.z = _257;
    float4 _442 = _441;
    _442.w = 0.75686275959014892578125;
    float4 _454 = float4(_260.x, _260.y, _260.z, float4(0.0).w);
    _454.w = ((log2(((dot(_359, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_295 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_295 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_295 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_428.xyx * _428.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _424 * View.View_PreExposure;
    out.out_var_SV_Target1 = _438;
    out.out_var_SV_Target2 = _442;
    out.out_var_SV_Target3 = _454;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

