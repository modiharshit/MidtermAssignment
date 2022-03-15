

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
    char _m9_pad[16];
    float View_OutOfBoundsMask;
    char _m10_pad[80];
    float View_UnlitViewmodeMask;
    char _m11_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m12_pad[604];
    float View_ShowDecalsMask;
    char _m13_pad[184];
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

constant float _133 = {};

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

fragment MainPS_out Main_00002c0e_9f17d807(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_StaticShadowTexture [[texture(4)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    float4 _179 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _133, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _184 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _189 = (_184.xyz / float3(_184.w)) - View.View_PreViewTranslation;
    float3 _197 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    uint _205 = in.in_var_PRIMITIVE_ID * 36u;
    uint _206 = _205 + 20u;
    float _253;
    float _254;
    float _255;
    float3 _256;
    float3 _257;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _206)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _224 = ((_179.xy / float2(_179.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _228 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _224, level(0.0));
        float4 _231 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _224, level(0.0));
        float4 _234 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _224, level(0.0));
        float _244 = _234.w;
        _253 = _244 + _234.z;
        _254 = (0.5 * _244) + _234.y;
        _255 = _234.x;
        _256 = (float3(0.180000007152557373046875) * _228.w) + _228.xyz;
        _257 = normalize((_197 * _231.w) + ((_231.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _253 = 1.0;
        _254 = 0.5;
        _255 = 0.0;
        _256 = float3(0.180000007152557373046875);
        _257 = _197;
    }
    float4 _264 = LightmapResourceCluster_StaticShadowTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.zw);
    uint _265 = in.in_var_LIGHTMAP_ID * 15u;
    uint _266 = _265 + 1u;
    float4 _273 = fast::clamp((_264 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _266)]) + ((View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _266)] * (-0.5)) + float4(0.5)), float4(0.0), float4(1.0));
    float3 _299 = (((_256 - (_256 * _255)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz) + (((mix(float3(0.07999999821186065673828125 * _254), _256, float3(_255)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz) * 0.449999988079071044921875);
    float2 _301 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _305 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _301);
    float4 _307 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_301 + float2(0.0, 0.5)));
    uint _313 = _265 + 4u;
    uint _318 = _265 + 6u;
    float3 _323 = _305.xyz;
    float3 _351 = ((((_323 * _323) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _313)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _318)].xyz) * ((exp2(((_305.w + ((_307.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _313)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _318)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_307 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _265 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _265 + 7u)], float4(_257.yzx, 1.0))))) * View.View_IndirectLightingColorScale;
    float3 _371 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _400;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _399;
        if (any(abs(_189 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _205 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _205 + 19u)].xyz + float3(1.0))))
        {
            _399 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_189, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _399 = _371;
        }
        _400 = _399;
    }
    else
    {
        _400 = _371;
    }
    float4 _407 = float4(((mix(float3(0.0), _299, float3(View.View_UnlitViewmodeMask)) + ((_351 * _299) * fast::max(float3(1.0), ((((((_256 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_256 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_256 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _400) * 1.0, 0.0);
    float4 _414;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _413 = _407;
        _413.w = 0.0;
        _414 = _413;
    }
    else
    {
        _414 = _407;
    }
    float2 _418 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _426 = (_257 * 0.5) + float3(0.5);
    float4 _428 = float4(_426.x, _426.y, _426.z, float4(0.0).w);
    _428.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _206)].y;
    float4 _429 = float4(0.0);
    _429.x = _255;
    float4 _430 = _429;
    _430.y = _254;
    float4 _431 = _430;
    _431.z = _253;
    float4 _432 = _431;
    _432.w = 0.50588238239288330078125;
    float4 _443 = float4(_256.x, _256.y, _256.z, float4(0.0).w);
    _443.w = ((log2((dot(_351, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_418.xyx * _418.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _414 * View.View_PreExposure;
    out.out_var_SV_Target1 = _428;
    out.out_var_SV_Target2 = _432;
    out.out_var_SV_Target3 = _443;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = (View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _265)] * _273) * _273;
    return out;
}

