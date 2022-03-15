

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
    char _m15_pad[612];
    float View_RenderingReflectionCaptureMask;
    char _m16_pad[188];
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
    uint in_var_PRIMITIVE_ID [[user(locn3)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00003218_bd1f5ca7(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _191 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _195 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _200 = (_195.xyz / float3(_195.w)) - View.View_PreViewTranslation;
    float2 _201 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5;
    float4 _207 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _201, bias(View.View_MaterialTextureMipBias));
    float2 _210 = (_207.xy * float2(2.0)) - float2(1.0);
    float4 _222 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _249;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _249 = _191.w;
                break;
            }
            else
            {
                float _233 = _191.z;
                _249 = ((_233 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_233 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _254 = fast::min(fast::max(((mix(-2000.0, 2000.0, _222.x) + _249) - 500.0) * 0.0005000000237487256526947021484375, 0.0), 1.0);
    float3 _265 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(float4(_210, sqrt(fast::clamp(1.0 - dot(_210, _210), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), float3(_254)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _276 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _201, bias(View.View_MaterialTextureMipBias));
    float4 _280 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _201, bias(View.View_MaterialTextureMipBias));
    float3 _285 = fast::clamp(_276.xyz, float3(0.0), float3(1.0));
    float _286 = fast::clamp(_276.x, 0.0, 1.0);
    float _291 = (fast::clamp(mix(_280.x, 0.300000011920928955078125, _254), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _292 = in.in_var_PRIMITIVE_ID * 36u;
    uint _293 = _292 + 20u;
    float _341;
    float _342;
    float _343;
    float3 _344;
    float3 _345;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _293)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _311 = ((_191.xy / float2(_191.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _315 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _311, level(0.0));
        float4 _318 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _311, level(0.0));
        float4 _321 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _311, level(0.0));
        float _331 = _321.w;
        _341 = (_291 * _331) + _321.z;
        _342 = (_286 * _331) + _321.y;
        _343 = _321.x;
        _344 = (_285 * _315.w) + _315.xyz;
        _345 = normalize((_265 * _318.w) + ((_318.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _341 = _291;
        _342 = _286;
        _343 = 0.0;
        _344 = _285;
        _345 = _265;
    }
    float _394;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _293)].z > 0.0)
    {
        float3 _362 = fast::clamp((_200 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _373 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_362.x), int(_362.y), int(_362.z), 0).xyz), 0));
        _394 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_373.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_362 / float3(_373.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _394 = 1.0;
    }
    float3 _408 = ((_344 - (_344 * _343)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _415 = (mix(float3(0.07999999821186065673828125 * _342), _344, float3(_343)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _418 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _423;
    if (_418)
    {
        _423 = _408 + (_415 * 0.449999988079071044921875);
    }
    else
    {
        _423 = _408;
    }
    float3 _432 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _461;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _460;
        if (any(abs(_200 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _292 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _292 + 19u)].xyz + float3(1.0))))
        {
            _460 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_200, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _460 = _432;
        }
        _461 = _460;
    }
    else
    {
        _461 = _432;
    }
    float4 _467 = float4((mix(float3(0.0), _423 + (select(_415, float3(0.0), bool3(_418)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + _461) * 1.0, 0.0);
    float4 _474;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _473 = _467;
        _473.w = 0.0;
        _474 = _473;
    }
    else
    {
        _474 = _467;
    }
    float2 _478 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _486 = (_345 * 0.5) + float3(0.5);
    float4 _488 = float4(_486.x, _486.y, _486.z, float4(0.0).w);
    _488.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _293)].y;
    float4 _489 = float4(0.0);
    _489.x = _343;
    float4 _490 = _489;
    _490.y = _342;
    float4 _491 = _490;
    _491.z = _341;
    float4 _492 = _491;
    _492.w = 0.50588238239288330078125;
    float4 _495 = float4(_344.x, _344.y, _344.z, float4(0.0).w);
    _495.w = (fract(dot(_478.xyx * _478.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _474 * View.View_PreExposure;
    out.out_var_SV_Target1 = _488;
    out.out_var_SV_Target2 = _492;
    out.out_var_SV_Target3 = _495;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_394, 1.0, 1.0, 1.0);
    return out;
}

