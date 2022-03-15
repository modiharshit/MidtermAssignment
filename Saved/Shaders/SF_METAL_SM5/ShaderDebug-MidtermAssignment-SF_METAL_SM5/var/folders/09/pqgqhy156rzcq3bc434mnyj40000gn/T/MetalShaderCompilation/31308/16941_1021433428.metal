

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
    spvUnsafeArray<float4, 6> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _168 = {};
constant float4 _170 = {};

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

fragment MainPS_out Main_0000422d_3ce1d654(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _226 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _230 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _235 = (_230.xyz / float3(_230.w)) - View.View_PreViewTranslation;
    float4 _241 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _244 = (_241.xy * float2(2.0)) - float2(1.0);
    float3 _260 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_244, sqrt(fast::clamp(1.0 - dot(_244, _244), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _271 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _275 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _294 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _321;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _321 = _226.w;
                break;
            }
            else
            {
                float _305 = _226.z;
                _321 = ((_305 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_305 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _330 = fast::clamp(_271.xyz * (mix(Material.Material_VectorExpressions[4].xyz, Material.Material_VectorExpressions[5].xyz, float3(_275.z)) * mix(0.5, 1.0, _275.x)), float3(0.0), float3(1.0));
    float _335 = (fast::clamp(mix(0.5, 0.20000000298023223876953125, mix(_271.w, 0.5, fast::min(fast::max(((mix(-2000.0, 2000.0, _294.x) + _321) - 1000.0) * 0.001000000047497451305389404296875, 0.0), 1.0))), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _336 = in.in_var_PRIMITIVE_ID * 36u;
    uint _337 = _336 + 20u;
    float _385;
    float _386;
    float _387;
    float3 _388;
    float3 _389;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _337)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _355 = ((_226.xy / float2(_226.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _359 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _355, level(0.0));
        float4 _362 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _355, level(0.0));
        float4 _365 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _355, level(0.0));
        float _375 = _365.w;
        _385 = (_335 * _375) + _365.z;
        _386 = (0.5 * _375) + _365.y;
        _387 = _365.x;
        _388 = (_330 * _359.w) + _359.xyz;
        _389 = normalize((_260 * _362.w) + ((_362.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _385 = _335;
        _386 = 0.5;
        _387 = 0.0;
        _388 = _330;
        _389 = _260;
    }
    bool _399 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _405;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _336 + 18u)].w > 0.0) && _399)
    {
        _405 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _405 = 1.0;
    }
    float _452;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _337)].z > 0.0)
    {
        float3 _420 = fast::clamp((_235 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _431 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_420.x), int(_420.y), int(_420.z), 0).xyz), 0));
        _452 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_431.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_420 / float3(_431.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _452 = _405;
    }
    float3 _466 = ((_388 - (_388 * _387)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _473 = (mix(float3(0.07999999821186065673828125 * _386), _388, float3(_387)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _476 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _481;
    if (_476)
    {
        _481 = _466 + (_473 * 0.449999988079071044921875);
    }
    else
    {
        _481 = _466;
    }
    float3 _483 = select(_473, float3(0.0), bool3(_476));
    float3 _485 = float3(dot(_483, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _571;
    if (_399)
    {
        float4 _521 = _170;
        _521.y = (-0.48860299587249755859375) * _389.y;
        float4 _524 = _521;
        _524.z = 0.48860299587249755859375 * _389.z;
        float4 _527 = _524;
        _527.w = (-0.48860299587249755859375) * _389.x;
        float3 _528 = _389 * _389;
        float4 _531 = _168;
        _531.x = (1.09254801273345947265625 * _389.x) * _389.y;
        float4 _534 = _531;
        _534.y = ((-1.09254801273345947265625) * _389.y) * _389.z;
        float4 _539 = _534;
        _539.z = 0.3153919875621795654296875 * ((3.0 * _528.z) - 1.0);
        float4 _542 = _539;
        _542.w = ((-1.09254801273345947265625) * _389.x) * _389.z;
        float4 _546 = _527;
        _546.x = 0.886227548122406005859375;
        float3 _548 = _546.yzw * 2.094395160675048828125;
        float4 _549 = float4(_546.x, _548.x, _548.y, _548.z);
        float4 _550 = _542 * 0.785398185253143310546875;
        float _551 = (_528.x - _528.y) * 0.4290426075458526611328125;
        float3 _557 = float3(0.0);
        _557.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _549) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _550)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _551);
        float3 _563 = _557;
        _563.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _549) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _550)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _551);
        float3 _569 = _563;
        _569.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _549) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _550)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _551);
        _571 = fast::max(float3(0.0), _569);
    }
    else
    {
        _571 = float3(0.0);
    }
    float3 _574 = _571 * View.View_IndirectLightingColorScale;
    float3 _596 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _625;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _624;
        if (any(abs(_235 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _336 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _336 + 19u)].xyz + float3(1.0))))
        {
            _624 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_235, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _624 = _596;
        }
        _625 = _624;
    }
    else
    {
        _625 = _596;
    }
    float4 _632 = float4(((mix(float3(0.0), _481 + (_483 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_574 * _481) * fast::max(float3(1.0), ((((((_388 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_388 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_388 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _625) * 1.0, 0.0);
    float4 _639;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _638 = _632;
        _638.w = 0.0;
        _639 = _638;
    }
    else
    {
        _639 = _632;
    }
    float2 _643 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _651 = (_389 * 0.5) + float3(0.5);
    float4 _653 = float4(_651.x, _651.y, _651.z, float4(0.0).w);
    _653.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _337)].y;
    float4 _654 = float4(0.0);
    _654.x = _387;
    float4 _655 = _654;
    _655.y = _386;
    float4 _656 = _655;
    _656.z = _385;
    float4 _657 = _656;
    _657.w = 0.50588238239288330078125;
    float4 _669 = float4(_388.x, _388.y, _388.z, float4(0.0).w);
    _669.w = ((log2(((dot(_574, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_485 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_485 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_485 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_643.xyx * _643.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _639 * View.View_PreExposure;
    out.out_var_SV_Target1 = _653;
    out.out_var_SV_Target2 = _657;
    out.out_var_SV_Target3 = _669;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_452, 1.0, 1.0, 1.0);
    return out;
}

