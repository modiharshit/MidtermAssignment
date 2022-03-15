

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

constant float4 _165 = {};
constant float4 _167 = {};

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

fragment MainPS_out Main_00004213_db61c194(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _224 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _228 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _233 = (_228.xyz / float3(_228.w)) - View.View_PreViewTranslation;
    float2 _234 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5;
    float4 _240 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _234, bias(View.View_MaterialTextureMipBias));
    float2 _243 = (_240.xy * float2(2.0)) - float2(1.0);
    float4 _255 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _282;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _282 = _224.w;
                break;
            }
            else
            {
                float _266 = _224.z;
                _282 = ((_266 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_266 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _287 = fast::min(fast::max(((mix(-2000.0, 2000.0, _255.x) + _282) - 500.0) * 0.0005000000237487256526947021484375, 0.0), 1.0);
    float3 _298 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(float4(_243, sqrt(fast::clamp(1.0 - dot(_243, _243), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), float3(_287)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _309 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _234, bias(View.View_MaterialTextureMipBias));
    float4 _313 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _234, bias(View.View_MaterialTextureMipBias));
    float3 _319 = fast::clamp(_309.xyz, float3(0.0), float3(1.0));
    float _320 = fast::clamp(_309.x, 0.0, 1.0);
    float _321 = fast::clamp(_313.w, 0.0, 1.0);
    float _326 = (fast::clamp(mix(_313.x, 0.300000011920928955078125, _287), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _327 = in.in_var_PRIMITIVE_ID * 36u;
    uint _328 = _327 + 20u;
    float _376;
    float _377;
    float _378;
    float3 _379;
    float3 _380;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _328)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _346 = ((_224.xy / float2(_224.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _350 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _346, level(0.0));
        float4 _353 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _346, level(0.0));
        float4 _356 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _346, level(0.0));
        float _366 = _356.w;
        _376 = (_326 * _366) + _356.z;
        _377 = (_320 * _366) + _356.y;
        _378 = _356.x;
        _379 = (_319 * _350.w) + _350.xyz;
        _380 = normalize((_298 * _353.w) + ((_353.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _376 = _326;
        _377 = _320;
        _378 = 0.0;
        _379 = _319;
        _380 = _298;
    }
    bool _390 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _396;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _327 + 18u)].w > 0.0) && _390)
    {
        _396 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _396 = 1.0;
    }
    float _443;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _328)].z > 0.0)
    {
        float3 _411 = fast::clamp((_233 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _422 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_411.x), int(_411.y), int(_411.z), 0).xyz), 0));
        _443 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_422.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_411 / float3(_422.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _443 = _396;
    }
    float3 _457 = ((_379 - (_379 * _378)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _464 = (mix(float3(0.07999999821186065673828125 * _377), _379, float3(_378)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _467 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _472;
    if (_467)
    {
        _472 = _457 + (_464 * 0.449999988079071044921875);
    }
    else
    {
        _472 = _457;
    }
    float3 _474 = select(_464, float3(0.0), bool3(_467));
    float3 _476 = float3(dot(_474, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _483 = float3(_321);
    float3 _563;
    if (_390)
    {
        float4 _513 = _167;
        _513.y = (-0.48860299587249755859375) * _380.y;
        float4 _516 = _513;
        _516.z = 0.48860299587249755859375 * _380.z;
        float4 _519 = _516;
        _519.w = (-0.48860299587249755859375) * _380.x;
        float3 _520 = _380 * _380;
        float4 _523 = _165;
        _523.x = (1.09254801273345947265625 * _380.x) * _380.y;
        float4 _526 = _523;
        _526.y = ((-1.09254801273345947265625) * _380.y) * _380.z;
        float4 _531 = _526;
        _531.z = 0.3153919875621795654296875 * ((3.0 * _520.z) - 1.0);
        float4 _534 = _531;
        _534.w = ((-1.09254801273345947265625) * _380.x) * _380.z;
        float4 _538 = _519;
        _538.x = 0.886227548122406005859375;
        float3 _540 = _538.yzw * 2.094395160675048828125;
        float4 _541 = float4(_538.x, _540.x, _540.y, _540.z);
        float4 _542 = _534 * 0.785398185253143310546875;
        float _543 = (_520.x - _520.y) * 0.4290426075458526611328125;
        float3 _549 = float3(0.0);
        _549.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _541) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _542)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _543);
        float3 _555 = _549;
        _555.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _541) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _542)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _543);
        float3 _561 = _555;
        _561.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _541) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _542)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _543);
        _563 = fast::max(float3(0.0), _561);
    }
    else
    {
        _563 = float3(0.0);
    }
    float3 _566 = _563 * View.View_IndirectLightingColorScale;
    float3 _588 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _617;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _616;
        if (any(abs(_233 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _327 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _327 + 19u)].xyz + float3(1.0))))
        {
            _616 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_233, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _616 = _588;
        }
        _617 = _616;
    }
    else
    {
        _617 = _588;
    }
    float4 _624 = float4(((mix(float3(0.0), _472 + (_474 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_566 * _472) * fast::max(_483, ((((((_379 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _321) + ((_379 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _321) + ((_379 * 2.755199909210205078125) + float3(0.69029998779296875))) * _321))) + _617) * 1.0, 0.0);
    float4 _631;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _630 = _624;
        _630.w = 0.0;
        _631 = _630;
    }
    else
    {
        _631 = _624;
    }
    float2 _635 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _643 = (_380 * 0.5) + float3(0.5);
    float4 _645 = float4(_643.x, _643.y, _643.z, float4(0.0).w);
    _645.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _328)].y;
    float4 _646 = float4(0.0);
    _646.x = _378;
    float4 _647 = _646;
    _647.y = _377;
    float4 _648 = _647;
    _648.z = _376;
    float4 _649 = _648;
    _649.w = 0.50588238239288330078125;
    float4 _661 = float4(_379.x, _379.y, _379.z, float4(0.0).w);
    _661.w = ((log2(((dot(_566, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_483, ((((((_476 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _321) + ((_476 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _321) + ((_476 * 2.755199909210205078125) + float3(0.69029998779296875))) * _321).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_635.xyx * _635.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _631 * View.View_PreExposure;
    out.out_var_SV_Target1 = _645;
    out.out_var_SV_Target2 = _649;
    out.out_var_SV_Target3 = _661;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_443, 1.0, 1.0, 1.0);
    return out;
}

