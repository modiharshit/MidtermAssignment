

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
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float3 _149 = {};

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

fragment MainPS_out Main_0000393e_09a3e032(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _207 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _211 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _216 = (_211.xyz / float3(_211.w)) - View.View_PreViewTranslation;
    float4 _224 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _227 = (_224.xy * float2(2.0)) - float2(1.0);
    float3 _244 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize(((float4(_227, sqrt(fast::clamp(1.0 - dot(_227, _227), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _256 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 20.0), bias(View.View_MaterialTextureMipBias));
    float _258 = mix(0.4000000059604644775390625, 1.0, _256.x);
    float4 _262 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _287;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _287 = _207.w;
                break;
            }
            else
            {
                float _271 = _207.z;
                _287 = ((_271 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_271 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _291 = fast::min(fast::max((_287 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _292 = _262.y;
    float4 _296 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _298 = _296.y;
    float3 _311 = fast::clamp(float3(mix(_258, 1.0 - _258, mix(_292, 1.0, _291)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_298 + mix(_292, 0.0, _291), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _316 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _298) + mix(mix(0.699999988079071044921875, 1.0, _292), 1.0, _291), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _317 = in.in_var_PRIMITIVE_ID * 36u;
    uint _318 = _317 + 20u;
    float _366;
    float _367;
    float _368;
    float3 _369;
    float3 _370;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _318)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _336 = ((_207.xy / float2(_207.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _340 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _336, level(0.0));
        float4 _343 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _336, level(0.0));
        float4 _346 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _336, level(0.0));
        float _356 = _346.w;
        _366 = (_316 * _356) + _346.z;
        _367 = (0.5 * _356) + _346.y;
        _368 = _346.x;
        _369 = (_311 * _340.w) + _340.xyz;
        _370 = normalize((_244 * _343.w) + ((_343.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _366 = _316;
        _367 = 0.5;
        _368 = 0.0;
        _369 = _311;
        _370 = _244;
    }
    float _419;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _318)].z > 0.0)
    {
        float3 _387 = fast::clamp((_216 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _398 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_387.x), int(_387.y), int(_387.z), 0).xyz), 0));
        _419 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_398.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_387 / float3(_398.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _419 = 1.0;
    }
    float3 _433 = ((_369 - (_369 * _368)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _440 = (mix(float3(0.07999999821186065673828125 * _367), _369, float3(_368)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _443 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _448;
    if (_443)
    {
        _448 = _433 + (_440 * 0.449999988079071044921875);
    }
    else
    {
        _448 = _433;
    }
    float4 _454 = float4(_370, 1.0);
    float3 _458 = _149;
    _458.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _454);
    float3 _462 = _458;
    _462.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _454);
    float3 _466 = _462;
    _466.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _454);
    float4 _469 = _454.xyzz * _454.yzzx;
    float3 _473 = _149;
    _473.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _469);
    float3 _477 = _473;
    _477.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _469);
    float3 _481 = _477;
    _481.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _469);
    float3 _515 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _544;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _543;
        if (any(abs(_216 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _317 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _317 + 19u)].xyz + float3(1.0))))
        {
            _543 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_216, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _543 = _515;
        }
        _544 = _543;
    }
    else
    {
        _544 = _515;
    }
    float4 _551 = float4(((mix(float3(0.0), _448 + (select(_440, float3(0.0), bool3(_443)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((((fast::max(float3(0.0), (_466 + _481) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_370.x * _370.x) - (_370.y * _370.y)))) * View.View_SkyLightColor.xyz) * 1.0) * _448) * fast::max(float3(1.0), ((((((_369 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_369 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_369 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _544) * 1.0, 0.0);
    float4 _558;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _557 = _551;
        _557.w = 0.0;
        _558 = _557;
    }
    else
    {
        _558 = _551;
    }
    float2 _562 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _570 = (_370 * 0.5) + float3(0.5);
    float4 _572 = float4(_570.x, _570.y, _570.z, float4(0.0).w);
    _572.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _318)].y;
    float4 _573 = float4(0.0);
    _573.x = _368;
    float4 _574 = _573;
    _574.y = _367;
    float4 _575 = _574;
    _575.z = _366;
    float4 _576 = _575;
    _576.w = 0.50588238239288330078125;
    float4 _579 = float4(_369.x, _369.y, _369.z, float4(0.0).w);
    _579.w = (fract(dot(_562.xyx * _562.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _558 * View.View_PreExposure;
    out.out_var_SV_Target1 = _572;
    out.out_var_SV_Target2 = _576;
    out.out_var_SV_Target3 = _579;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_419, 1.0, 1.0, 1.0);
    return out;
}

