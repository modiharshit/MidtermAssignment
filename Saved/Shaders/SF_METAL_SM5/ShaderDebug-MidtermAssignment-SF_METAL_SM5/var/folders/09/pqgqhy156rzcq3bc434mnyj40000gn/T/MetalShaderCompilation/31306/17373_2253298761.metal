

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
    char _m19_pad[48];
    float3 View_VolumetricLightmapWorldToUVScale;
    float3 View_VolumetricLightmapWorldToUVAdd;
    packed_float3 View_VolumetricLightmapIndirectionTextureSize;
    float View_VolumetricLightmapBrickSize;
    float3 View_VolumetricLightmapBrickTexelSize;
    float View_IndirectLightingCacheShowFlag;
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_IndirectLightingCache
{
    char _m0_pad[80];
    float IndirectLightingCache_DirectionalLightShadowing;
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients0;
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients1;
    float4 IndirectLightingCache_IndirectLightingSHCoefficients2;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _169 = {};
constant float4 _171 = {};

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

fragment MainPS_out Main_000043dd_864e9c49(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _228 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _232 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _237 = (_232.xyz / float3(_232.w)) - View.View_PreViewTranslation;
    float4 _243 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _246 = (_243.xy * float2(2.0)) - float2(1.0);
    float4 _258 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _285;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _285 = _228.w;
                break;
            }
            else
            {
                float _269 = _228.z;
                _285 = ((_269 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_269 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _301 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(float4(_246, sqrt(fast::clamp(1.0 - dot(_246, _246), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _258.x) + _285) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _313 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _318 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _323 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _327 = (_313.x + 0.5) * ((_318.x + 0.5) * (_323.x + 0.5));
    float4 _331 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _337 = fast::clamp(_331.xyz * _327, float3(0.0), float3(1.0));
    float _342 = (fast::clamp(mix(0.800000011920928955078125, 0.4000000059604644775390625, _327 * _331.w), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _343 = in.in_var_PRIMITIVE_ID * 36u;
    uint _344 = _343 + 20u;
    float _392;
    float _393;
    float _394;
    float3 _395;
    float3 _396;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _344)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _362 = ((_228.xy / float2(_228.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _366 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _362, level(0.0));
        float4 _369 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _362, level(0.0));
        float4 _372 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _362, level(0.0));
        float _382 = _372.w;
        _392 = (_342 * _382) + _372.z;
        _393 = (0.5 * _382) + _372.y;
        _394 = _372.x;
        _395 = (_337 * _366.w) + _366.xyz;
        _396 = normalize((_301 * _369.w) + ((_369.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _392 = _342;
        _393 = 0.5;
        _394 = 0.0;
        _395 = _337;
        _396 = _301;
    }
    bool _406 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _412;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _343 + 18u)].w > 0.0) && _406)
    {
        _412 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _412 = 1.0;
    }
    float _459;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _344)].z > 0.0)
    {
        float3 _427 = fast::clamp((_237 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _438 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_427.x), int(_427.y), int(_427.z), 0).xyz), 0));
        _459 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_438.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_427 / float3(_438.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _459 = _412;
    }
    float3 _473 = ((_395 - (_395 * _394)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _480 = (mix(float3(0.07999999821186065673828125 * _393), _395, float3(_394)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _483 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _488;
    if (_483)
    {
        _488 = _473 + (_480 * 0.449999988079071044921875);
    }
    else
    {
        _488 = _473;
    }
    float3 _490 = select(_480, float3(0.0), bool3(_483));
    float3 _492 = float3(dot(_490, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _578;
    if (_406)
    {
        float4 _528 = _171;
        _528.y = (-0.48860299587249755859375) * _396.y;
        float4 _531 = _528;
        _531.z = 0.48860299587249755859375 * _396.z;
        float4 _534 = _531;
        _534.w = (-0.48860299587249755859375) * _396.x;
        float3 _535 = _396 * _396;
        float4 _538 = _169;
        _538.x = (1.09254801273345947265625 * _396.x) * _396.y;
        float4 _541 = _538;
        _541.y = ((-1.09254801273345947265625) * _396.y) * _396.z;
        float4 _546 = _541;
        _546.z = 0.3153919875621795654296875 * ((3.0 * _535.z) - 1.0);
        float4 _549 = _546;
        _549.w = ((-1.09254801273345947265625) * _396.x) * _396.z;
        float4 _553 = _534;
        _553.x = 0.886227548122406005859375;
        float3 _555 = _553.yzw * 2.094395160675048828125;
        float4 _556 = float4(_553.x, _555.x, _555.y, _555.z);
        float4 _557 = _549 * 0.785398185253143310546875;
        float _558 = (_535.x - _535.y) * 0.4290426075458526611328125;
        float3 _564 = float3(0.0);
        _564.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _556) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _557)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _558);
        float3 _570 = _564;
        _570.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _556) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _557)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _558);
        float3 _576 = _570;
        _576.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _556) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _557)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _558);
        _578 = fast::max(float3(0.0), _576);
    }
    else
    {
        _578 = float3(0.0);
    }
    float3 _581 = _578 * View.View_IndirectLightingColorScale;
    float3 _603 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _632;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _631;
        if (any(abs(_237 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _343 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _343 + 19u)].xyz + float3(1.0))))
        {
            _631 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_237, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _631 = _603;
        }
        _632 = _631;
    }
    else
    {
        _632 = _603;
    }
    float4 _639 = float4(((mix(float3(0.0), _488 + (_490 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_581 * _488) * fast::max(float3(1.0), ((((((_395 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_395 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_395 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _632) * 1.0, 0.0);
    float4 _646;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _645 = _639;
        _645.w = 0.0;
        _646 = _645;
    }
    else
    {
        _646 = _639;
    }
    float2 _650 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _658 = (_396 * 0.5) + float3(0.5);
    float4 _660 = float4(_658.x, _658.y, _658.z, float4(0.0).w);
    _660.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _344)].y;
    float4 _661 = float4(0.0);
    _661.x = _394;
    float4 _662 = _661;
    _662.y = _393;
    float4 _663 = _662;
    _663.z = _392;
    float4 _664 = _663;
    _664.w = 0.50588238239288330078125;
    float4 _676 = float4(_395.x, _395.y, _395.z, float4(0.0).w);
    _676.w = ((log2(((dot(_581, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_492 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_492 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_492 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_650.xyx * _650.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _646 * View.View_PreExposure;
    out.out_var_SV_Target1 = _660;
    out.out_var_SV_Target2 = _664;
    out.out_var_SV_Target3 = _676;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_459, 1.0, 1.0, 1.0);
    return out;
}

