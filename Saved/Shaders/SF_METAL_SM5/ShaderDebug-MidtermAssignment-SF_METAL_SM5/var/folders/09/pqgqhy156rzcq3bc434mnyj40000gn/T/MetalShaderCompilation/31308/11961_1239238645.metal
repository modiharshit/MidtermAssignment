

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
    char _m15_pad[188];
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
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float _136 = {};

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

fragment MainPS_out Main_00002eb9_49dd47f5(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> Material_Texture2D_0 [[texture(4)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    float4 _189 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _136, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _194 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _199 = (_194.xyz / float3(_194.w)) - View.View_PreViewTranslation;
    float3 _207 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _220 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _222 = fast::clamp(_220.xyz, float3(0.0), float3(1.0));
    float _226 = (0.949999988079071044921875 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _227 = in.in_var_PRIMITIVE_ID * 36u;
    uint _228 = _227 + 20u;
    float _276;
    float _277;
    float _278;
    float3 _279;
    float3 _280;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _228)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _246 = ((_189.xy / float2(_189.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _250 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _246, level(0.0));
        float4 _253 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _246, level(0.0));
        float4 _256 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _246, level(0.0));
        float _266 = _256.w;
        _276 = (_226 * _266) + _256.z;
        _277 = (0.20000000298023223876953125 * _266) + _256.y;
        _278 = _256.x;
        _279 = (_222 * _250.w) + _250.xyz;
        _280 = normalize((_207 * _253.w) + ((_253.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _276 = _226;
        _277 = 0.20000000298023223876953125;
        _278 = 0.0;
        _279 = _222;
        _280 = _207;
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
    uint _338 = in.in_var_LIGHTMAP_ID * 15u;
    float3 _348 = (_334.xyz * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _338 + 4u)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _338 + 6u)].xyz;
    float _349 = dot(_348, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float _368 = (exp2((_349 * 16.0) - 8.0) - 0.00390625) * fast::max(0.0, dot((_336 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _338 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _338 + 7u)], float4(_280.yzx, 1.0)));
    float3 _378 = float4(_348 * (_368 / _349), _368).xyz * View.View_IndirectLightingColorScale;
    float3 _400 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _429;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _428;
        if (any(abs(_199 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _227 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _227 + 19u)].xyz + float3(1.0))))
        {
            _428 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_199, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _428 = _400;
        }
        _429 = _428;
    }
    else
    {
        _429 = _400;
    }
    float4 _436 = float4(((mix(float3(0.0), _310 + (_312 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_378 * _310) * fast::max(float3(1.0), ((((((_279 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_279 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_279 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _429) * 1.0, 0.0);
    float4 _443;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _442 = _436;
        _442.w = 0.0;
        _443 = _442;
    }
    else
    {
        _443 = _436;
    }
    float2 _447 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _455 = (_280 * 0.5) + float3(0.5);
    float4 _457 = float4(_455.x, _455.y, _455.z, float4(0.0).w);
    _457.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _228)].y;
    float4 _458 = float4(0.0);
    _458.x = _278;
    float4 _459 = _458;
    _459.y = _277;
    float4 _460 = _459;
    _460.z = _276;
    float4 _461 = _460;
    _461.w = 0.75686275959014892578125;
    float4 _473 = float4(_279.x, _279.y, _279.z, float4(0.0).w);
    _473.w = ((log2(((dot(_378, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_314 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_314 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_314 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_447.xyx * _447.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _443 * View.View_PreExposure;
    out.out_var_SV_Target1 = _457;
    out.out_var_SV_Target2 = _461;
    out.out_var_SV_Target3 = _473;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

