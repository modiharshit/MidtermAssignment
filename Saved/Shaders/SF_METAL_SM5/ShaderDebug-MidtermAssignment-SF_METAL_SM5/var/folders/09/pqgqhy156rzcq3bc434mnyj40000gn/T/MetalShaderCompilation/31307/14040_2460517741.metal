

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
    char _m11_pad[36];
    float View_GameTime;
    char _m12_pad[8];
    float View_MaterialTextureMipBias;
    char _m13_pad[28];
    float View_UnlitViewmodeMask;
    char _m14_pad[612];
    float View_RenderingReflectionCaptureMask;
    char _m15_pad[48];
    float4 View_SkyLightColor;
    char _m16_pad[124];
    float View_ShowDecalsMask;
    char _m17_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m18_pad[48];
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
    spvUnsafeArray<float4, 6> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float _145 = {};
constant float3 _146 = {};

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

fragment MainPS_out Main_000036d8_92a8856d(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float3x3 _191 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _202 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _145, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _207 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _211 = _207.xyz / float3(_207.w);
    float3 _212 = _211 - View.View_PreViewTranslation;
    float4 _221 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _227 = ((normalize(-_211) * _191).xy * ((0.0500000007450580596923828125 * _221.z) + (-0.02500000037252902984619140625))) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _231 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _227, bias(View.View_MaterialTextureMipBias));
    float2 _234 = (_231.xy * float2(2.0)) - float2(1.0);
    float3 _250 = normalize(_191 * normalize((float4(_234, sqrt(fast::clamp(1.0 - dot(_234, _234), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _252 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _227, bias(View.View_MaterialTextureMipBias));
    float _265 = _252.y;
    float4 _277 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _285 = fast::clamp(float3(mix(0.25, 0.4000000059604644775390625, _277.x) * 0.25), float3(0.0), float3(1.0));
    float _290 = (fast::clamp(fast::min(fast::max(0.25 + _265, 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _291 = in.in_var_PRIMITIVE_ID * 36u;
    uint _292 = _291 + 20u;
    float _340;
    float _341;
    float _342;
    float3 _343;
    float3 _344;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _292)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _310 = ((_202.xy / float2(_202.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _314 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _310, level(0.0));
        float4 _317 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _310, level(0.0));
        float4 _320 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _310, level(0.0));
        float _330 = _320.w;
        _340 = (_290 * _330) + _320.z;
        _341 = (0.5 * _330) + _320.y;
        _342 = _320.x;
        _343 = (_285 * _314.w) + _314.xyz;
        _344 = normalize((_250 * _317.w) + ((_317.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _340 = _290;
        _341 = 0.5;
        _342 = 0.0;
        _343 = _285;
        _344 = _250;
    }
    float _393;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _292)].z > 0.0)
    {
        float3 _361 = fast::clamp((_212 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _372 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_361.x), int(_361.y), int(_361.z), 0).xyz), 0));
        _393 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_372.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_361 / float3(_372.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _393 = 1.0;
    }
    float3 _407 = ((_343 - (_343 * _342)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _414 = (mix(float3(0.07999999821186065673828125 * _341), _343, float3(_342)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _417 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _422;
    if (_417)
    {
        _422 = _407 + (_414 * 0.449999988079071044921875);
    }
    else
    {
        _422 = _407;
    }
    float4 _428 = float4(_344, 1.0);
    float3 _432 = _146;
    _432.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _428);
    float3 _436 = _432;
    _436.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _428);
    float3 _440 = _436;
    _440.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _428);
    float4 _443 = _428.xyzz * _428.yzzx;
    float3 _447 = _146;
    _447.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _443);
    float3 _451 = _447;
    _451.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _443);
    float3 _455 = _451;
    _455.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _443);
    float3 _489 = fast::max(mix(mix(Material.Material_VectorExpressions[3].xyz, Material.Material_VectorExpressions[4].xyz, float3(sin(View.View_GameTime * 1.57079637050628662109375))) * _265, Material.Material_VectorExpressions[5].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _518;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _517;
        if (any(abs(_212 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _291 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _291 + 19u)].xyz + float3(1.0))))
        {
            _517 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_212, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _517 = _489;
        }
        _518 = _517;
    }
    else
    {
        _518 = _489;
    }
    float4 _525 = float4(((mix(float3(0.0), _422 + (select(_414, float3(0.0), bool3(_417)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((((fast::max(float3(0.0), (_440 + _455) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_344.x * _344.x) - (_344.y * _344.y)))) * View.View_SkyLightColor.xyz) * 1.0) * _422) * fast::max(float3(1.0), ((((((_343 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_343 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_343 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _518) * 1.0, 0.0);
    float4 _532;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _531 = _525;
        _531.w = 0.0;
        _532 = _531;
    }
    else
    {
        _532 = _525;
    }
    float2 _536 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _544 = (_344 * 0.5) + float3(0.5);
    float4 _546 = float4(_544.x, _544.y, _544.z, float4(0.0).w);
    _546.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _292)].y;
    float4 _547 = float4(0.0);
    _547.x = _342;
    float4 _548 = _547;
    _548.y = _341;
    float4 _549 = _548;
    _549.z = _340;
    float4 _550 = _549;
    _550.w = 0.50588238239288330078125;
    float4 _553 = float4(_343.x, _343.y, _343.z, float4(0.0).w);
    _553.w = (fract(dot(_536.xyx * _536.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _532 * View.View_PreExposure;
    out.out_var_SV_Target1 = _546;
    out.out_var_SV_Target2 = _550;
    out.out_var_SV_Target3 = _553;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_393, 1.0, 1.0, 1.0);
    return out;
}

