

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
    char _m14_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m15_pad[412];
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

fragment MainPS_out Main_00003f8b_057a392e(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float3x3 _211 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _222 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _167, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _227 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _231 = _227.xyz / float3(_227.w);
    float3 _232 = _231 - View.View_PreViewTranslation;
    float4 _241 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _247 = ((normalize(-_231) * _211).xy * ((0.0500000007450580596923828125 * _241.z) + (-0.02500000037252902984619140625))) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _251 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _247, bias(View.View_MaterialTextureMipBias));
    float2 _254 = (_251.xy * float2(2.0)) - float2(1.0);
    float3 _270 = normalize(_211 * normalize((float4(_254, sqrt(fast::clamp(1.0 - dot(_254, _254), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _272 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _247, bias(View.View_MaterialTextureMipBias));
    float _285 = _272.y;
    float4 _297 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _305 = fast::clamp(float3(mix(0.25, 0.4000000059604644775390625, _297.x) * 0.25), float3(0.0), float3(1.0));
    float _310 = (fast::clamp(fast::min(fast::max(0.25 + _285, 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
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
        _361 = (0.5 * _350) + _340.y;
        _362 = _340.x;
        _363 = (_305 * _334.w) + _334.xyz;
        _364 = normalize((_270 * _337.w) + ((_337.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _360 = _310;
        _361 = 0.5;
        _362 = 0.0;
        _363 = _305;
        _364 = _270;
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
    float3 _546;
    if (_374)
    {
        float4 _496 = _168;
        _496.y = (-0.48860299587249755859375) * _364.y;
        float4 _499 = _496;
        _499.z = 0.48860299587249755859375 * _364.z;
        float4 _502 = _499;
        _502.w = (-0.48860299587249755859375) * _364.x;
        float3 _503 = _364 * _364;
        float4 _506 = _165;
        _506.x = (1.09254801273345947265625 * _364.x) * _364.y;
        float4 _509 = _506;
        _509.y = ((-1.09254801273345947265625) * _364.y) * _364.z;
        float4 _514 = _509;
        _514.z = 0.3153919875621795654296875 * ((3.0 * _503.z) - 1.0);
        float4 _517 = _514;
        _517.w = ((-1.09254801273345947265625) * _364.x) * _364.z;
        float4 _521 = _502;
        _521.x = 0.886227548122406005859375;
        float3 _523 = _521.yzw * 2.094395160675048828125;
        float4 _524 = float4(_521.x, _523.x, _523.y, _523.z);
        float4 _525 = _517 * 0.785398185253143310546875;
        float _526 = (_503.x - _503.y) * 0.4290426075458526611328125;
        float3 _532 = float3(0.0);
        _532.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _524) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _525)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _526);
        float3 _538 = _532;
        _538.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _524) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _525)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _526);
        float3 _544 = _538;
        _544.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _524) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _525)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _526);
        _546 = fast::max(float3(0.0), _544);
    }
    else
    {
        _546 = float3(0.0);
    }
    float3 _549 = _546 * View.View_IndirectLightingColorScale;
    float3 _571 = fast::max(mix(mix(Material.Material_VectorExpressions[3].xyz, Material.Material_VectorExpressions[4].xyz, float3(sin(View.View_GameTime * 1.57079637050628662109375))) * _285, Material.Material_VectorExpressions[5].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _600;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _599;
        if (any(abs(_232 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _311 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _311 + 19u)].xyz + float3(1.0))))
        {
            _599 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_232, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _599 = _571;
        }
        _600 = _599;
    }
    else
    {
        _600 = _571;
    }
    float4 _607 = float4(((mix(float3(0.0), _456 + (_458 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_549 * _456) * fast::max(float3(1.0), ((((((_363 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_363 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_363 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _600) * 1.0, 0.0);
    float4 _614;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _613 = _607;
        _613.w = 0.0;
        _614 = _613;
    }
    else
    {
        _614 = _607;
    }
    float2 _618 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _626 = (_364 * 0.5) + float3(0.5);
    float4 _628 = float4(_626.x, _626.y, _626.z, float4(0.0).w);
    _628.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _312)].y;
    float4 _629 = float4(0.0);
    _629.x = _362;
    float4 _630 = _629;
    _630.y = _361;
    float4 _631 = _630;
    _631.z = _360;
    float4 _632 = _631;
    _632.w = 0.50588238239288330078125;
    float4 _644 = float4(_363.x, _363.y, _363.z, float4(0.0).w);
    _644.w = ((log2(((dot(_549, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_460 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_460 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_460 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_618.xyx * _618.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _614 * View.View_PreExposure;
    out.out_var_SV_Target1 = _628;
    out.out_var_SV_Target2 = _632;
    out.out_var_SV_Target3 = _644;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_427, 1.0, 1.0, 1.0);
    return out;
}

