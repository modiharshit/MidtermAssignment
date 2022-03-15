

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
    char _m0_pad[448];
    float4x4 View_ViewToClip;
    char _m1_pad[192];
    float4x4 View_SVPositionToTranslatedWorld;
    char _m2_pad[272];
    float4 View_InvDeviceZToWorldZTransform;
    float4 View_ScreenPositionScaleBias;
    char _m4_pad[48];
    float3 View_PreViewTranslation;
    char _m5_pad[928];
    float4 View_ViewRectMin;
    float4 View_ViewSizeAndInvSize;
    char _m7_pad[68];
    float View_PreExposure;
    float4 View_DiffuseOverrideParameter;
    float4 View_SpecularOverrideParameter;
    float4 View_NormalOverrideParameter;
    float2 View_RoughnessOverrideParameter;
    char _m12_pad[8];
    float View_OutOfBoundsMask;
    char _m13_pad[48];
    float View_MaterialTextureMipBias;
    char _m14_pad[28];
    float View_UnlitViewmodeMask;
    char _m15_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m16_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m17_pad[188];
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

fragment MainPS_out Main_000039c6_ec8c2790(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_StaticShadowTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    float4 _208 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _212 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _217 = (_212.xyz / float3(_212.w)) - View.View_PreViewTranslation;
    float4 _225 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _228 = (_225.xy * float2(2.0)) - float2(1.0);
    float3 _245 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize(((float4(_228, sqrt(fast::clamp(1.0 - dot(_228, _228), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _257 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 20.0), bias(View.View_MaterialTextureMipBias));
    float _259 = mix(0.4000000059604644775390625, 1.0, _257.x);
    float4 _263 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _288;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _288 = _208.w;
                break;
            }
            else
            {
                float _272 = _208.z;
                _288 = ((_272 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_272 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _292 = fast::min(fast::max((_288 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _293 = _263.y;
    float4 _297 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _299 = _297.y;
    float3 _312 = fast::clamp(float3(mix(_259, 1.0 - _259, mix(_293, 1.0, _292)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_299 + mix(_293, 0.0, _292), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _317 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _299) + mix(mix(0.699999988079071044921875, 1.0, _293), 1.0, _292), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _318 = in.in_var_PRIMITIVE_ID * 36u;
    uint _319 = _318 + 20u;
    float _367;
    float _368;
    float _369;
    float3 _370;
    float3 _371;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _319)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _337 = ((_208.xy / float2(_208.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _341 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _337, level(0.0));
        float4 _344 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _337, level(0.0));
        float4 _347 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _337, level(0.0));
        float _357 = _347.w;
        _367 = (_317 * _357) + _347.z;
        _368 = (0.5 * _357) + _347.y;
        _369 = _347.x;
        _370 = (_312 * _341.w) + _341.xyz;
        _371 = normalize((_245 * _344.w) + ((_344.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _367 = _317;
        _368 = 0.5;
        _369 = 0.0;
        _370 = _312;
        _371 = _245;
    }
    float4 _378 = LightmapResourceCluster_StaticShadowTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.zw);
    uint _379 = in.in_var_LIGHTMAP_ID * 15u;
    uint _380 = _379 + 1u;
    float4 _387 = fast::clamp((_378 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _380)]) + ((View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _380)] * (-0.5)) + float4(0.5)), float4(0.0), float4(1.0));
    float3 _404 = ((_370 - (_370 * _369)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _411 = (mix(float3(0.07999999821186065673828125 * _368), _370, float3(_369)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _414 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _419;
    if (_414)
    {
        _419 = _404 + (_411 * 0.449999988079071044921875);
    }
    else
    {
        _419 = _404;
    }
    float3 _421 = select(_411, float3(0.0), bool3(_414));
    float3 _423 = float3(dot(_421, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _438 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _442 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _438);
    float4 _444 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_438 + float2(0.0, 0.5)));
    uint _450 = _379 + 4u;
    uint _455 = _379 + 6u;
    float3 _460 = _442.xyz;
    float3 _488 = ((((_460 * _460) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _450)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _455)].xyz) * ((exp2(((_442.w + ((_444.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _450)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _455)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_444 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _379 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _379 + 7u)], float4(_371.yzx, 1.0))))) * View.View_IndirectLightingColorScale;
    float3 _510 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _539;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _538;
        if (any(abs(_217 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _318 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _318 + 19u)].xyz + float3(1.0))))
        {
            _538 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_217, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _538 = _510;
        }
        _539 = _538;
    }
    else
    {
        _539 = _510;
    }
    float4 _546 = float4(((mix(float3(0.0), _419 + (_421 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_488 * _419) * fast::max(float3(1.0), ((((((_370 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_370 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_370 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _539) * 1.0, 0.0);
    float4 _553;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _552 = _546;
        _552.w = 0.0;
        _553 = _552;
    }
    else
    {
        _553 = _546;
    }
    float2 _557 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _565 = (_371 * 0.5) + float3(0.5);
    float4 _567 = float4(_565.x, _565.y, _565.z, float4(0.0).w);
    _567.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _319)].y;
    float4 _568 = float4(0.0);
    _568.x = _369;
    float4 _569 = _568;
    _569.y = _368;
    float4 _570 = _569;
    _570.z = _367;
    float4 _571 = _570;
    _571.w = 0.50588238239288330078125;
    float4 _583 = float4(_370.x, _370.y, _370.z, float4(0.0).w);
    _583.w = ((log2(((dot(_488, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_423 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_423 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_423 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_557.xyx * _557.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _553 * View.View_PreExposure;
    out.out_var_SV_Target1 = _567;
    out.out_var_SV_Target2 = _571;
    out.out_var_SV_Target3 = _583;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = (View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _379)] * _387) * _387;
    return out;
}

