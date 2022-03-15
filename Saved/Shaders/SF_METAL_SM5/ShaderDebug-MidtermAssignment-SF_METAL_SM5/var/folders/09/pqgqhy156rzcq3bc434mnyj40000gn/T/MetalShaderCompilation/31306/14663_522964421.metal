

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

constant float _151 = {};

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

fragment MainPS_out Main_00003947_1f2bcdc5(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_StaticShadowTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    float4 _204 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _151, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _209 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _214 = (_209.xyz / float3(_209.w)) - View.View_PreViewTranslation;
    float2 _215 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5;
    float4 _221 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _215, bias(View.View_MaterialTextureMipBias));
    float2 _224 = (_221.xy * float2(2.0)) - float2(1.0);
    float3 _240 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_224, sqrt(fast::clamp(1.0 - dot(_224, _224), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _252 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _257 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _262 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _266 = (_252.x + 0.5) * ((_257.x + 0.5) * (_262.x + 0.5));
    float4 _271 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _215, bias(View.View_MaterialTextureMipBias));
    float4 _277 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _215, bias(View.View_MaterialTextureMipBias));
    float _278 = _277.w;
    float3 _285 = fast::clamp(_271.xyz * mix(0.800000011920928955078125, 1.2000000476837158203125, _266), float3(0.0), float3(1.0));
    float _286 = fast::clamp(fast::min(fast::max(_278, 0.0), 1.0) * 2.0, 0.0, 1.0);
    float _287 = fast::clamp(_278, 0.0, 1.0);
    float _292 = (fast::clamp(mix(0.20000000298023223876953125, mix(0.60000002384185791015625, 1.0, _266), _277.x), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _293 = in.in_var_PRIMITIVE_ID * 36u;
    uint _294 = _293 + 20u;
    float _342;
    float _343;
    float _344;
    float3 _345;
    float3 _346;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _294)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _312 = ((_204.xy / float2(_204.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _316 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _312, level(0.0));
        float4 _319 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _312, level(0.0));
        float4 _322 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _312, level(0.0));
        float _332 = _322.w;
        _342 = (_292 * _332) + _322.z;
        _343 = (_286 * _332) + _322.y;
        _344 = _322.x;
        _345 = (_285 * _316.w) + _316.xyz;
        _346 = normalize((_240 * _319.w) + ((_319.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _342 = _292;
        _343 = _286;
        _344 = 0.0;
        _345 = _285;
        _346 = _240;
    }
    float4 _353 = LightmapResourceCluster_StaticShadowTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.zw);
    uint _354 = in.in_var_LIGHTMAP_ID * 15u;
    uint _355 = _354 + 1u;
    float4 _362 = fast::clamp((_353 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _355)]) + ((View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _355)] * (-0.5)) + float4(0.5)), float4(0.0), float4(1.0));
    float3 _379 = ((_345 - (_345 * _344)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _386 = (mix(float3(0.07999999821186065673828125 * _343), _345, float3(_344)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _389 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _394;
    if (_389)
    {
        _394 = _379 + (_386 * 0.449999988079071044921875);
    }
    else
    {
        _394 = _379;
    }
    float3 _396 = select(_386, float3(0.0), bool3(_389));
    float3 _398 = float3(dot(_396, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _405 = float3(_287);
    float2 _414 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _418 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _414);
    float4 _420 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_414 + float2(0.0, 0.5)));
    uint _426 = _354 + 4u;
    uint _431 = _354 + 6u;
    float3 _436 = _418.xyz;
    float3 _464 = ((((_436 * _436) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _426)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _431)].xyz) * ((exp2(((_418.w + ((_420.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _426)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _431)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_420 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _354 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _354 + 7u)], float4(_346.yzx, 1.0))))) * View.View_IndirectLightingColorScale;
    float3 _486 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _515;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _514;
        if (any(abs(_214 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _293 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _293 + 19u)].xyz + float3(1.0))))
        {
            _514 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_214, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _514 = _486;
        }
        _515 = _514;
    }
    else
    {
        _515 = _486;
    }
    float4 _522 = float4(((mix(float3(0.0), _394 + (_396 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_464 * _394) * fast::max(_405, ((((((_345 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _287) + ((_345 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _287) + ((_345 * 2.755199909210205078125) + float3(0.69029998779296875))) * _287))) + _515) * 1.0, 0.0);
    float4 _529;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _528 = _522;
        _528.w = 0.0;
        _529 = _528;
    }
    else
    {
        _529 = _522;
    }
    float2 _533 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _541 = (_346 * 0.5) + float3(0.5);
    float4 _543 = float4(_541.x, _541.y, _541.z, float4(0.0).w);
    _543.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _294)].y;
    float4 _544 = float4(0.0);
    _544.x = _344;
    float4 _545 = _544;
    _545.y = _343;
    float4 _546 = _545;
    _546.z = _342;
    float4 _547 = _546;
    _547.w = 0.50588238239288330078125;
    float4 _559 = float4(_345.x, _345.y, _345.z, float4(0.0).w);
    _559.w = ((log2(((dot(_464, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_405, ((((((_398 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _287) + ((_398 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _287) + ((_398 * 2.755199909210205078125) + float3(0.69029998779296875))) * _287).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_533.xyx * _533.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _529 * View.View_PreExposure;
    out.out_var_SV_Target1 = _543;
    out.out_var_SV_Target2 = _547;
    out.out_var_SV_Target3 = _559;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = (View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _354)] * _362) * _362;
    return out;
}

