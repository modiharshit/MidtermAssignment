

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
    char _m13_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m14_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m15_pad[188];
    float View_ShowDecalsMask;
    char _m16_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m17_pad[48];
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
constant float _167 = {};
constant float4 _168 = {};

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

fragment MainPS_out Main_00004171_927e73aa(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _222 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _167, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _227 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _232 = (_227.xyz / float3(_227.w)) - View.View_PreViewTranslation;
    float2 _233 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5;
    float4 _239 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _233, bias(View.View_MaterialTextureMipBias));
    float2 _242 = (_239.xy * float2(2.0)) - float2(1.0);
    float3 _258 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_242, sqrt(fast::clamp(1.0 - dot(_242, _242), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _270 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _275 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _280 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _284 = (_270.x + 0.5) * ((_275.x + 0.5) * (_280.x + 0.5));
    float4 _289 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _233, bias(View.View_MaterialTextureMipBias));
    float4 _295 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _233, bias(View.View_MaterialTextureMipBias));
    float _296 = _295.w;
    float3 _303 = fast::clamp(_289.xyz * mix(0.800000011920928955078125, 1.2000000476837158203125, _284), float3(0.0), float3(1.0));
    float _304 = fast::clamp(fast::min(fast::max(_296, 0.0), 1.0) * 2.0, 0.0, 1.0);
    float _305 = fast::clamp(_296, 0.0, 1.0);
    float _310 = (fast::clamp(mix(0.20000000298023223876953125, mix(0.60000002384185791015625, 1.0, _284), _295.x), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _311 = in.in_var_PRIMITIVE_ID * 36u;
    uint _312 = _311 + 20u;
    float _360;
    float _361;
    float _362;
    float3 _363;
    float3 _364;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _312)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _330 = ((_222.xy / float2(_222.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _334 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _330, level(0.0));
        float4 _337 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _330, level(0.0));
        float4 _340 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _330, level(0.0));
        float _350 = _340.w;
        _360 = (_310 * _350) + _340.z;
        _361 = (_304 * _350) + _340.y;
        _362 = _340.x;
        _363 = (_303 * _334.w) + _334.xyz;
        _364 = normalize((_258 * _337.w) + ((_337.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _360 = _310;
        _361 = _304;
        _362 = 0.0;
        _363 = _303;
        _364 = _258;
    }
    bool _374 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _380;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _311 + 18u)].w > 0.0) && _374)
    {
        _380 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _380 = 1.0;
    }
    float _427;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _312)].z > 0.0)
    {
        float3 _395 = fast::clamp((_232 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _406 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_395.x), int(_395.y), int(_395.z), 0).xyz), 0));
        _427 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_406.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_395 / float3(_406.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _427 = _380;
    }
    float3 _441 = ((_363 - (_363 * _362)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _448 = (mix(float3(0.07999999821186065673828125 * _361), _363, float3(_362)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _451 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _456;
    if (_451)
    {
        _456 = _441 + (_448 * 0.449999988079071044921875);
    }
    else
    {
        _456 = _441;
    }
    float3 _458 = select(_448, float3(0.0), bool3(_451));
    float3 _460 = float3(dot(_458, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _467 = float3(_305);
    float3 _547;
    if (_374)
    {
        float4 _497 = _168;
        _497.y = (-0.48860299587249755859375) * _364.y;
        float4 _500 = _497;
        _500.z = 0.48860299587249755859375 * _364.z;
        float4 _503 = _500;
        _503.w = (-0.48860299587249755859375) * _364.x;
        float3 _504 = _364 * _364;
        float4 _507 = _165;
        _507.x = (1.09254801273345947265625 * _364.x) * _364.y;
        float4 _510 = _507;
        _510.y = ((-1.09254801273345947265625) * _364.y) * _364.z;
        float4 _515 = _510;
        _515.z = 0.3153919875621795654296875 * ((3.0 * _504.z) - 1.0);
        float4 _518 = _515;
        _518.w = ((-1.09254801273345947265625) * _364.x) * _364.z;
        float4 _522 = _503;
        _522.x = 0.886227548122406005859375;
        float3 _524 = _522.yzw * 2.094395160675048828125;
        float4 _525 = float4(_522.x, _524.x, _524.y, _524.z);
        float4 _526 = _518 * 0.785398185253143310546875;
        float _527 = (_504.x - _504.y) * 0.4290426075458526611328125;
        float3 _533 = float3(0.0);
        _533.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _525) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _526)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _527);
        float3 _539 = _533;
        _539.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _525) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _526)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _527);
        float3 _545 = _539;
        _545.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _525) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _526)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _527);
        _547 = fast::max(float3(0.0), _545);
    }
    else
    {
        _547 = float3(0.0);
    }
    float3 _550 = _547 * View.View_IndirectLightingColorScale;
    float3 _572 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _601;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _600;
        if (any(abs(_232 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _311 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _311 + 19u)].xyz + float3(1.0))))
        {
            _600 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_232, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _600 = _572;
        }
        _601 = _600;
    }
    else
    {
        _601 = _572;
    }
    float4 _608 = float4(((mix(float3(0.0), _456 + (_458 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_550 * _456) * fast::max(_467, ((((((_363 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _305) + ((_363 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _305) + ((_363 * 2.755199909210205078125) + float3(0.69029998779296875))) * _305))) + _601) * 1.0, 0.0);
    float4 _615;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _614 = _608;
        _614.w = 0.0;
        _615 = _614;
    }
    else
    {
        _615 = _608;
    }
    float2 _619 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _627 = (_364 * 0.5) + float3(0.5);
    float4 _629 = float4(_627.x, _627.y, _627.z, float4(0.0).w);
    _629.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _312)].y;
    float4 _630 = float4(0.0);
    _630.x = _362;
    float4 _631 = _630;
    _631.y = _361;
    float4 _632 = _631;
    _632.z = _360;
    float4 _633 = _632;
    _633.w = 0.50588238239288330078125;
    float4 _645 = float4(_363.x, _363.y, _363.z, float4(0.0).w);
    _645.w = ((log2(((dot(_550, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_467, ((((((_460 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _305) + ((_460 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _305) + ((_460 * 2.755199909210205078125) + float3(0.69029998779296875))) * _305).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_619.xyx * _619.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _615 * View.View_PreExposure;
    out.out_var_SV_Target1 = _629;
    out.out_var_SV_Target2 = _633;
    out.out_var_SV_Target3 = _645;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_427, 1.0, 1.0, 1.0);
    return out;
}

