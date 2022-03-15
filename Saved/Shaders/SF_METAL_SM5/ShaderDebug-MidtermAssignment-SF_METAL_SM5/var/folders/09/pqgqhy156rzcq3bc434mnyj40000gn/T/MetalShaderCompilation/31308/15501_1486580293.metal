

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
    char _m16_pad[48];
    float4 View_SkyLightColor;
    char _m17_pad[124];
    float View_ShowDecalsMask;
    char _m18_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m19_pad[48];
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

constant float3 _153 = {};

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

fragment MainPS_out Main_00003c8d_589b6a45(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], texture2d<float> Material_Texture2D_4 [[texture(9)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], sampler Material_Texture2D_4Sampler [[sampler(6)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _211 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _215 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _220 = (_215.xyz / float3(_215.w)) - View.View_PreViewTranslation;
    float2 _221 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5;
    float4 _227 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _221, bias(View.View_MaterialTextureMipBias));
    float2 _230 = (_227.xy * float2(2.0)) - float2(1.0);
    float3 _246 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_230, sqrt(fast::clamp(1.0 - dot(_230, _230), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _258 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (_221 * float2(0.25)), bias(View.View_MaterialTextureMipBias));
    float2 _261 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 2.0;
    float4 _266 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (_261 * 0.2134999930858612060546875), bias(View.View_MaterialTextureMipBias));
    float4 _271 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (_261 * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float _298;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _298 = _211.w;
                break;
            }
            else
            {
                float _282 = _211.z;
                _298 = ((_282 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_282 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float4 _306 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _309 = mix(_266.x + 0.5, _271.x + 0.5, fast::min(fast::max((_298 - 24.0) * 0.0009765625, 0.0), 1.0)) * (_306.x + 0.5);
    float4 _314 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _221, bias(View.View_MaterialTextureMipBias));
    float4 _327 = Material_Texture2D_4.sample(Material_Texture2D_4Sampler, _221, bias(View.View_MaterialTextureMipBias));
    float3 _333 = fast::clamp(fast::min(fast::max(((_314.xyz * mix(0.60000002384185791015625, 1.0, _309)) * mix(0.1500000059604644775390625, 0.699999988079071044921875, _258.x)) * Material.Material_VectorExpressions[3].xyz, float3(0.0)), float3(1.0)), float3(0.0), float3(1.0));
    float _334 = fast::clamp(_327.y, 0.0, 1.0);
    float _339 = (fast::clamp(mix(-0.300000011920928955078125, 1.0, _327.x + (_309 * 0.20000000298023223876953125)), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _340 = in.in_var_PRIMITIVE_ID * 36u;
    uint _341 = _340 + 20u;
    float _389;
    float _390;
    float _391;
    float3 _392;
    float3 _393;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _341)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _359 = ((_211.xy / float2(_211.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _363 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _359, level(0.0));
        float4 _366 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _359, level(0.0));
        float4 _369 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _359, level(0.0));
        float _379 = _369.w;
        _389 = (_339 * _379) + _369.z;
        _390 = (0.5 * _379) + _369.y;
        _391 = _369.x;
        _392 = (_333 * _363.w) + _363.xyz;
        _393 = normalize((_246 * _366.w) + ((_366.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _389 = _339;
        _390 = 0.5;
        _391 = 0.0;
        _392 = _333;
        _393 = _246;
    }
    float _442;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _341)].z > 0.0)
    {
        float3 _410 = fast::clamp((_220 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _421 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_410.x), int(_410.y), int(_410.z), 0).xyz), 0));
        _442 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_421.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_410 / float3(_421.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _442 = 1.0;
    }
    float3 _456 = ((_392 - (_392 * _391)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _463 = (mix(float3(0.07999999821186065673828125 * _390), _392, float3(_391)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _466 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _471;
    if (_466)
    {
        _471 = _456 + (_463 * 0.449999988079071044921875);
    }
    else
    {
        _471 = _456;
    }
    float4 _477 = float4(_393, 1.0);
    float3 _481 = _153;
    _481.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _477);
    float3 _485 = _481;
    _485.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _477);
    float3 _489 = _485;
    _489.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _477);
    float4 _492 = _477.xyzz * _477.yzzx;
    float3 _496 = _153;
    _496.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _492);
    float3 _500 = _496;
    _500.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _492);
    float3 _504 = _500;
    _504.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _492);
    float3 _539 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _568;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _567;
        if (any(abs(_220 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _340 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _340 + 19u)].xyz + float3(1.0))))
        {
            _567 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_220, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _567 = _539;
        }
        _568 = _567;
    }
    else
    {
        _568 = _539;
    }
    float4 _575 = float4(((mix(float3(0.0), _471 + (select(_463, float3(0.0), bool3(_466)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((((fast::max(float3(0.0), (_489 + _504) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_393.x * _393.x) - (_393.y * _393.y)))) * View.View_SkyLightColor.xyz) * 1.0) * _471) * fast::max(float3(_334), ((((((_392 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _334) + ((_392 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _334) + ((_392 * 2.755199909210205078125) + float3(0.69029998779296875))) * _334))) + _568) * 1.0, 0.0);
    float4 _582;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _581 = _575;
        _581.w = 0.0;
        _582 = _581;
    }
    else
    {
        _582 = _575;
    }
    float2 _586 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _594 = (_393 * 0.5) + float3(0.5);
    float4 _596 = float4(_594.x, _594.y, _594.z, float4(0.0).w);
    _596.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _341)].y;
    float4 _597 = float4(0.0);
    _597.x = _391;
    float4 _598 = _597;
    _598.y = _390;
    float4 _599 = _598;
    _599.z = _389;
    float4 _600 = _599;
    _600.w = 0.50588238239288330078125;
    float4 _603 = float4(_392.x, _392.y, _392.z, float4(0.0).w);
    _603.w = (fract(dot(_586.xyx * _586.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _582 * View.View_PreExposure;
    out.out_var_SV_Target1 = _596;
    out.out_var_SV_Target2 = _600;
    out.out_var_SV_Target3 = _603;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_442, 1.0, 1.0, 1.0);
    return out;
}

