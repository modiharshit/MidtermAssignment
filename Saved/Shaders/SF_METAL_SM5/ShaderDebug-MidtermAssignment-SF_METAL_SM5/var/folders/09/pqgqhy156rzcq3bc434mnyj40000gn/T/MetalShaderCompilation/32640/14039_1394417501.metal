

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

constant float _142 = {};
constant float3 _143 = {};

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

fragment MainPS_out Main_000036d7_531d1f5d(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float3x3 _187 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _198 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _142, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _203 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _207 = _203.xyz / float3(_203.w);
    float3 _208 = _207 - View.View_PreViewTranslation;
    float4 _217 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _223 = ((normalize(-_207) * _187).xy * ((0.0500000007450580596923828125 * _217.z) + (-0.02500000037252902984619140625))) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _227 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _223, bias(View.View_MaterialTextureMipBias));
    float2 _230 = (_227.xy * float2(2.0)) - float2(1.0);
    float _237 = sqrt(fast::clamp(1.0 - dot(_230, _230), 0.0, 1.0)) + 1.0;
    float4 _240 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 8.0), bias(View.View_MaterialTextureMipBias));
    float2 _243 = (_240.xy * float2(2.0)) - float2(1.0);
    float4 _252 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _223, bias(View.View_MaterialTextureMipBias));
    float _254 = _252.y;
    float3 _256 = mix(float4(_243, sqrt(fast::clamp(1.0 - dot(_243, _243), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), float3(_254));
    float3 _259 = float3(_230, _237);
    float3 _263 = float3(_256.xy * (-1.0), _256.z);
    float3 _275 = normalize(_187 * normalize((((_259 * dot(_259, _263)) - (_263 * _237)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _289 = fast::clamp(Material.Material_VectorExpressions[3].xyz * _252.x, float3(0.0), float3(1.0));
    float _290 = fast::clamp(mix(1.0, 0.0, _254), 0.0, 1.0);
    float _294 = (0.300000011920928955078125 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _295 = in.in_var_PRIMITIVE_ID * 36u;
    uint _296 = _295 + 20u;
    float _346;
    float _347;
    float _348;
    float3 _349;
    float3 _350;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _296)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _314 = ((_198.xy / float2(_198.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _318 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _314, level(0.0));
        float4 _321 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _314, level(0.0));
        float4 _324 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _314, level(0.0));
        float _334 = _324.w;
        _346 = (_294 * _334) + _324.z;
        _347 = (0.5 * _334) + _324.y;
        _348 = (_290 * _334) + _324.x;
        _349 = (_289 * _318.w) + _318.xyz;
        _350 = normalize((_275 * _321.w) + ((_321.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _346 = _294;
        _347 = 0.5;
        _348 = _290;
        _349 = _289;
        _350 = _275;
    }
    float _399;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _296)].z > 0.0)
    {
        float3 _367 = fast::clamp((_208 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _378 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_367.x), int(_367.y), int(_367.z), 0).xyz), 0));
        _399 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_378.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_367 / float3(_378.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _399 = 1.0;
    }
    float3 _413 = ((_349 - (_349 * _348)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _420 = (mix(float3(0.07999999821186065673828125 * _347), _349, float3(_348)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _423 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _428;
    if (_423)
    {
        _428 = _413 + (_420 * 0.449999988079071044921875);
    }
    else
    {
        _428 = _413;
    }
    float4 _434 = float4(_350, 1.0);
    float3 _438 = _143;
    _438.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _434);
    float3 _442 = _438;
    _442.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _434);
    float3 _446 = _442;
    _446.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _434);
    float4 _449 = _434.xyzz * _434.yzzx;
    float3 _453 = _143;
    _453.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _449);
    float3 _457 = _453;
    _457.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _449);
    float3 _461 = _457;
    _461.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _449);
    float3 _495 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _524;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _523;
        if (any(abs(_208 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _295 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _295 + 19u)].xyz + float3(1.0))))
        {
            _523 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_208, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _523 = _495;
        }
        _524 = _523;
    }
    else
    {
        _524 = _495;
    }
    float4 _531 = float4(((mix(float3(0.0), _428 + (select(_420, float3(0.0), bool3(_423)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((((fast::max(float3(0.0), (_446 + _461) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_350.x * _350.x) - (_350.y * _350.y)))) * View.View_SkyLightColor.xyz) * 1.0) * _428) * fast::max(float3(1.0), ((((((_349 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_349 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_349 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _524) * 1.0, 0.0);
    float4 _538;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _537 = _531;
        _537.w = 0.0;
        _538 = _537;
    }
    else
    {
        _538 = _531;
    }
    float2 _542 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _550 = (_350 * 0.5) + float3(0.5);
    float4 _552 = float4(_550.x, _550.y, _550.z, float4(0.0).w);
    _552.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _296)].y;
    float4 _553 = float4(0.0);
    _553.x = _348;
    float4 _554 = _553;
    _554.y = _347;
    float4 _555 = _554;
    _555.z = _346;
    float4 _556 = _555;
    _556.w = 0.50588238239288330078125;
    float4 _559 = float4(_349.x, _349.y, _349.z, float4(0.0).w);
    _559.w = (fract(dot(_542.xyx * _542.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _538 * View.View_PreExposure;
    out.out_var_SV_Target1 = _552;
    out.out_var_SV_Target2 = _556;
    out.out_var_SV_Target3 = _559;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_399, 1.0, 1.0, 1.0);
    return out;
}

