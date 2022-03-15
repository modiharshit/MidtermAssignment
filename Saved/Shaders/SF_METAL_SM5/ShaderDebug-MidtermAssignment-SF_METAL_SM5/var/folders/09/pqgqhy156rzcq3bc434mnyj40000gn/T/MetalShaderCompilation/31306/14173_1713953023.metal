

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

fragment MainPS_out Main_0000375d_6628d8ff(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_StaticShadowTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    float4 _200 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _147, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _205 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _210 = (_205.xyz / float3(_205.w)) - View.View_PreViewTranslation;
    float4 _216 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _219 = (_216.xy * float2(2.0)) - float2(1.0);
    float3 _235 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_219, sqrt(fast::clamp(1.0 - dot(_219, _219), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _247 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _252 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _257 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _261 = (_247.x + 0.5) * ((_252.x + 0.5) * (_257.x + 0.5));
    float4 _267 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _273 = fast::clamp(mix(float3(0.5), float3(1.0), float3(_261)) * _267.xyz, float3(0.0), float3(1.0));
    float _278 = (fast::clamp(mix(0.800000011920928955078125, 0.4000000059604644775390625, _261 * _267.w), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _279 = in.in_var_PRIMITIVE_ID * 36u;
    uint _280 = _279 + 20u;
    float _328;
    float _329;
    float _330;
    float3 _331;
    float3 _332;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _280)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _298 = ((_200.xy / float2(_200.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _302 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _298, level(0.0));
        float4 _305 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _298, level(0.0));
        float4 _308 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _298, level(0.0));
        float _318 = _308.w;
        _328 = (_278 * _318) + _308.z;
        _329 = (0.5 * _318) + _308.y;
        _330 = _308.x;
        _331 = (_273 * _302.w) + _302.xyz;
        _332 = normalize((_235 * _305.w) + ((_305.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _328 = _278;
        _329 = 0.5;
        _330 = 0.0;
        _331 = _273;
        _332 = _235;
    }
    float4 _339 = LightmapResourceCluster_StaticShadowTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.zw);
    uint _340 = in.in_var_LIGHTMAP_ID * 15u;
    uint _341 = _340 + 1u;
    float4 _348 = fast::clamp((_339 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _341)]) + ((View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _341)] * (-0.5)) + float4(0.5)), float4(0.0), float4(1.0));
    float3 _365 = ((_331 - (_331 * _330)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _372 = (mix(float3(0.07999999821186065673828125 * _329), _331, float3(_330)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _375 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _380;
    if (_375)
    {
        _380 = _365 + (_372 * 0.449999988079071044921875);
    }
    else
    {
        _380 = _365;
    }
    float3 _382 = select(_372, float3(0.0), bool3(_375));
    float3 _384 = float3(dot(_382, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _399 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _403 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _399);
    float4 _405 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_399 + float2(0.0, 0.5)));
    uint _411 = _340 + 4u;
    uint _416 = _340 + 6u;
    float3 _421 = _403.xyz;
    float3 _449 = ((((_421 * _421) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _411)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _416)].xyz) * ((exp2(((_403.w + ((_405.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _411)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _416)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_405 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _340 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _340 + 7u)], float4(_332.yzx, 1.0))))) * View.View_IndirectLightingColorScale;
    float3 _471 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _500;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _499;
        if (any(abs(_210 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _279 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _279 + 19u)].xyz + float3(1.0))))
        {
            _499 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_210, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _499 = _471;
        }
        _500 = _499;
    }
    else
    {
        _500 = _471;
    }
    float4 _507 = float4(((mix(float3(0.0), _380 + (_382 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_449 * _380) * fast::max(float3(1.0), ((((((_331 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_331 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_331 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _500) * 1.0, 0.0);
    float4 _514;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _513 = _507;
        _513.w = 0.0;
        _514 = _513;
    }
    else
    {
        _514 = _507;
    }
    float2 _518 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _526 = (_332 * 0.5) + float3(0.5);
    float4 _528 = float4(_526.x, _526.y, _526.z, float4(0.0).w);
    _528.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _280)].y;
    float4 _529 = float4(0.0);
    _529.x = _330;
    float4 _530 = _529;
    _530.y = _329;
    float4 _531 = _530;
    _531.z = _328;
    float4 _532 = _531;
    _532.w = 0.50588238239288330078125;
    float4 _544 = float4(_331.x, _331.y, _331.z, float4(0.0).w);
    _544.w = ((log2(((dot(_449, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_384 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_384 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_384 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_518.xyx * _518.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _514 * View.View_PreExposure;
    out.out_var_SV_Target1 = _528;
    out.out_var_SV_Target2 = _532;
    out.out_var_SV_Target3 = _544;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = (View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _340)] * _348) * _348;
    return out;
}

