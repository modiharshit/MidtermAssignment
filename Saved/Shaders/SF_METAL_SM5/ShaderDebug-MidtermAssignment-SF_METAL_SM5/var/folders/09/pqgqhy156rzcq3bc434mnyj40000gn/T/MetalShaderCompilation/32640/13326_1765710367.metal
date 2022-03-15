

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
    char _m13_pad[612];
    float View_RenderingReflectionCaptureMask;
    char _m14_pad[48];
    float4 View_SkyLightColor;
    char _m15_pad[124];
    float View_ShowDecalsMask;
    char _m16_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m17_pad[48];
    float3 View_VolumetricLightmapWorldToUVScale;
    float3 View_VolumetricLightmapWorldToUVAdd;
    packed_float3 View_VolumetricLightmapIndirectionTextureSize;
    float View_VolumetricLightmapBrickSize;
    float3 View_VolumetricLightmapBrickTexelSize;
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

constant float _137 = {};
constant float3 _138 = {};

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
    uint in_var_PRIMITIVE_ID [[user(locn3)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_0000340e_693e9a1f(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _193 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _137, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _198 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _203 = (_198.xyz / float3(_198.w)) - View.View_PreViewTranslation;
    float4 _209 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _212 = (_209.xy * float2(2.0)) - float2(1.0);
    float3 _228 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_212, sqrt(fast::clamp(1.0 - dot(_212, _212), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _239 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _243 = _239.x;
    float3 _252 = fast::clamp(Material.Material_VectorExpressions[3].xyz * _243, float3(0.0), float3(1.0));
    float _253 = fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0);
    float _258 = (fast::clamp(mix(Material.Material_ScalarExpressions[0].z, Material.Material_ScalarExpressions[0].w, _243), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _259 = in.in_var_PRIMITIVE_ID * 36u;
    uint _260 = _259 + 20u;
    float _310;
    float _311;
    float _312;
    float3 _313;
    float3 _314;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _260)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _278 = ((_193.xy / float2(_193.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _282 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _278, level(0.0));
        float4 _285 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _278, level(0.0));
        float4 _288 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _278, level(0.0));
        float _298 = _288.w;
        _310 = (_258 * _298) + _288.z;
        _311 = (0.5 * _298) + _288.y;
        _312 = (_253 * _298) + _288.x;
        _313 = (_252 * _282.w) + _282.xyz;
        _314 = normalize((_228 * _285.w) + ((_285.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _310 = _258;
        _311 = 0.5;
        _312 = _253;
        _313 = _252;
        _314 = _228;
    }
    float _363;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _260)].z > 0.0)
    {
        float3 _331 = fast::clamp((_203 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _342 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_331.x), int(_331.y), int(_331.z), 0).xyz), 0));
        _363 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_342.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_331 / float3(_342.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _363 = 1.0;
    }
    float3 _377 = ((_313 - (_313 * _312)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _384 = (mix(float3(0.07999999821186065673828125 * _311), _313, float3(_312)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _387 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _392;
    if (_387)
    {
        _392 = _377 + (_384 * 0.449999988079071044921875);
    }
    else
    {
        _392 = _377;
    }
    float4 _398 = float4(_314, 1.0);
    float3 _402 = _138;
    _402.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _398);
    float3 _406 = _402;
    _406.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _398);
    float3 _410 = _406;
    _410.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _398);
    float4 _413 = _398.xyzz * _398.yzzx;
    float3 _417 = _138;
    _417.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _413);
    float3 _421 = _417;
    _421.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _413);
    float3 _425 = _421;
    _425.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _413);
    float3 _459 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _488;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _487;
        if (any(abs(_203 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _259 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _259 + 19u)].xyz + float3(1.0))))
        {
            _487 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_203, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _487 = _459;
        }
        _488 = _487;
    }
    else
    {
        _488 = _459;
    }
    float4 _495 = float4(((mix(float3(0.0), _392 + (select(_384, float3(0.0), bool3(_387)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((((fast::max(float3(0.0), (_410 + _425) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_314.x * _314.x) - (_314.y * _314.y)))) * View.View_SkyLightColor.xyz) * 1.0) * _392) * fast::max(float3(1.0), ((((((_313 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_313 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_313 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _488) * 1.0, 0.0);
    float4 _502;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _501 = _495;
        _501.w = 0.0;
        _502 = _501;
    }
    else
    {
        _502 = _495;
    }
    float2 _506 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _514 = (_314 * 0.5) + float3(0.5);
    float4 _516 = float4(_514.x, _514.y, _514.z, float4(0.0).w);
    _516.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _260)].y;
    float4 _517 = float4(0.0);
    _517.x = _312;
    float4 _518 = _517;
    _518.y = _311;
    float4 _519 = _518;
    _519.z = _310;
    float4 _520 = _519;
    _520.w = 0.50588238239288330078125;
    float4 _523 = float4(_313.x, _313.y, _313.z, float4(0.0).w);
    _523.w = (fract(dot(_506.xyx * _506.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _502 * View.View_PreExposure;
    out.out_var_SV_Target1 = _516;
    out.out_var_SV_Target2 = _520;
    out.out_var_SV_Target3 = _523;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_363, 1.0, 1.0, 1.0);
    return out;
}

