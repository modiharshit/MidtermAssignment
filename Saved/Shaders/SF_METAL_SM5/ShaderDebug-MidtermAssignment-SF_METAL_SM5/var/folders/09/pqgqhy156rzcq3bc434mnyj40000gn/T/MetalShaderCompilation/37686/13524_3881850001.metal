

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
    char _m11_pad[24];
    float View_CullingSign;
    char _m12_pad[20];
    float View_MaterialTextureMipBias;
    char _m13_pad[28];
    float View_UnlitViewmodeMask;
    char _m14_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m15_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m16_pad[188];
    float View_ShowDecalsMask;
    char _m17_pad[184];
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

fragment MainPS_out Main_000034d4_e7605491(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_StaticShadowTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]], bool gl_FrontFacing [[front_facing]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    float4 _200 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _143, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _205 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _210 = (_205.xyz / float3(_205.w)) - View.View_PreViewTranslation;
    uint _211 = in.in_var_PRIMITIVE_ID * 36u;
    float4 _225 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _228 = (_225.xy * float2(2.0)) - float2(1.0);
    float3 _244 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_228, sqrt(fast::clamp(1.0 - dot(_228, _228), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * ((View.View_CullingSign * View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _211 + 4u)].w) * float(gl_FrontFacing ? 1 : (-1)));
    float4 _255 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    if ((_255.w - 0.33329999446868896484375) < 0.0)
    {
        discard_fragment();
    }
    float3 _262 = fast::clamp(_255.xyz, float3(0.0), float3(1.0));
    float _266 = (0.5 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _267 = _211 + 20u;
    float _315;
    float _316;
    float _317;
    float3 _318;
    float3 _319;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _267)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _285 = ((_200.xy / float2(_200.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _289 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _285, level(0.0));
        float4 _292 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _285, level(0.0));
        float4 _295 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _285, level(0.0));
        float _305 = _295.w;
        _315 = (_266 * _305) + _295.z;
        _316 = (0.5 * _305) + _295.y;
        _317 = _295.x;
        _318 = (_262 * _289.w) + _289.xyz;
        _319 = normalize((_244 * _292.w) + ((_292.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _315 = _266;
        _316 = 0.5;
        _317 = 0.0;
        _318 = _262;
        _319 = _244;
    }
    float4 _326 = LightmapResourceCluster_StaticShadowTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.zw);
    uint _327 = in.in_var_LIGHTMAP_ID * 15u;
    uint _328 = _327 + 1u;
    float4 _335 = fast::clamp((_326 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _328)]) + ((View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _328)] * (-0.5)) + float4(0.5)), float4(0.0), float4(1.0));
    float3 _352 = ((_318 - (_318 * _317)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _359 = (mix(float3(0.07999999821186065673828125 * _316), _318, float3(_317)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _362 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _367;
    if (_362)
    {
        _367 = _352 + (_359 * 0.449999988079071044921875);
    }
    else
    {
        _367 = _352;
    }
    float3 _369 = select(_359, float3(0.0), bool3(_362));
    float3 _371 = float3(dot(_369, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _386 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _390 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _386);
    float4 _392 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_386 + float2(0.0, 0.5)));
    uint _398 = _327 + 4u;
    uint _403 = _327 + 6u;
    float3 _408 = _390.xyz;
    float3 _436 = ((((_408 * _408) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _398)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _403)].xyz) * ((exp2(((_390.w + ((_392.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _398)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _403)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_392 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _327 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _327 + 7u)], float4(_319.yzx, 1.0))))) * View.View_IndirectLightingColorScale;
    float3 _458 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _487;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _486;
        if (any(abs(_210 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _211 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _211 + 19u)].xyz + float3(1.0))))
        {
            _486 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_210, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _486 = _458;
        }
        _487 = _486;
    }
    else
    {
        _487 = _458;
    }
    float4 _494 = float4(((mix(float3(0.0), _367 + (_369 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_436 * _367) * fast::max(float3(1.0), ((((((_318 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_318 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_318 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _487) * 1.0, 0.0);
    float4 _501;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _500 = _494;
        _500.w = 0.0;
        _501 = _500;
    }
    else
    {
        _501 = _494;
    }
    float2 _505 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _513 = (_319 * 0.5) + float3(0.5);
    float4 _515 = float4(_513.x, _513.y, _513.z, float4(0.0).w);
    _515.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _267)].y;
    float4 _516 = float4(0.0);
    _516.x = _317;
    float4 _517 = _516;
    _517.y = _316;
    float4 _518 = _517;
    _518.z = _315;
    float4 _519 = _518;
    _519.w = 0.50588238239288330078125;
    float4 _531 = float4(_318.x, _318.y, _318.z, float4(0.0).w);
    _531.w = ((log2(((dot(_436, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_371 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_371 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_371 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_505.xyx * _505.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _501 * View.View_PreExposure;
    out.out_var_SV_Target1 = _515;
    out.out_var_SV_Target2 = _519;
    out.out_var_SV_Target3 = _531;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = (View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _327)] * _335) * _335;
    return out;
}

