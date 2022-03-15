

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
    char _m11_pad[80];
    float View_UnlitViewmodeMask;
    char _m12_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m13_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m14_pad[188];
    float View_ShowDecalsMask;
    char _m15_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m16_pad[48];
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

struct type_PrimitiveDither
{
    float PrimitiveDither_LODFactor;
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
    spvUnsafeArray<float4, 7> Material_VectorExpressions;
    spvUnsafeArray<float4, 2> Material_ScalarExpressions;
};

constant float4 _163 = {};
constant float _165 = {};
constant float4 _166 = {};

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

fragment MainPS_out Main_00003ec8_e54fdeb2(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_PrimitiveDither& PrimitiveDither [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], sampler View_MaterialTextureBilinearClampedSampler [[sampler(0)]], sampler View_SharedBilinearClampedSampler [[sampler(1)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _219 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _165, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _224 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _229 = (_224.xyz / float3(_224.w)) - View.View_PreViewTranslation;
    float4 _233 = Material_Texture2D_0.sample(View_MaterialTextureBilinearClampedSampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y));
    float2 _236 = (_233.xy * float2(2.0)) - float2(1.0);
    float3 _252 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_236, sqrt(fast::clamp(1.0 - dot(_236, _236), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    if (PrimitiveDither.PrimitiveDither_LODFactor != 0.0)
    {
        if (abs(PrimitiveDither.PrimitiveDither_LODFactor) > 0.001000000047497451305389404296875)
        {
            float _287 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
            if ((float((PrimitiveDither.PrimitiveDither_LODFactor < 0.0) ? ((PrimitiveDither.PrimitiveDither_LODFactor + 1.0) > _287) : (PrimitiveDither.PrimitiveDither_LODFactor < _287)) - 0.001000000047497451305389404296875) < 0.0)
            {
                discard_fragment();
            }
        }
    }
    float3 _298 = fast::clamp(Material.Material_VectorExpressions[6].xyz, float3(0.0), float3(1.0));
    float _299 = fast::clamp(Material.Material_ScalarExpressions[0].z, 0.0, 1.0);
    float _300 = fast::clamp(Material.Material_ScalarExpressions[0].w, 0.0, 1.0);
    float _301 = fast::clamp(Material.Material_ScalarExpressions[1].y, 0.0, 1.0);
    float _306 = (fast::clamp(Material.Material_ScalarExpressions[1].x, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _307 = in.in_var_PRIMITIVE_ID * 36u;
    uint _308 = _307 + 20u;
    float _358;
    float _359;
    float _360;
    float3 _361;
    float3 _362;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _308)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _326 = ((_219.xy / float2(_219.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _330 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _326, level(0.0));
        float4 _333 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _326, level(0.0));
        float4 _336 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _326, level(0.0));
        float _346 = _336.w;
        _358 = (_306 * _346) + _336.z;
        _359 = (_300 * _346) + _336.y;
        _360 = (_299 * _346) + _336.x;
        _361 = (_298 * _330.w) + _330.xyz;
        _362 = normalize((_252 * _333.w) + ((_333.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _358 = _306;
        _359 = _300;
        _360 = _299;
        _361 = _298;
        _362 = _252;
    }
    bool _372 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _378;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _307 + 18u)].w > 0.0) && _372)
    {
        _378 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _378 = 1.0;
    }
    float _425;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _308)].z > 0.0)
    {
        float3 _393 = fast::clamp((_229 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _404 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_393.x), int(_393.y), int(_393.z), 0).xyz), 0));
        _425 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_404.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_393 / float3(_404.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _425 = _378;
    }
    float3 _439 = ((_361 - (_361 * _360)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _446 = (mix(float3(0.07999999821186065673828125 * _359), _361, float3(_360)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _449 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _454;
    if (_449)
    {
        _454 = _439 + (_446 * 0.449999988079071044921875);
    }
    else
    {
        _454 = _439;
    }
    float3 _456 = select(_446, float3(0.0), bool3(_449));
    float3 _458 = float3(dot(_456, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _465 = float3(_301);
    float3 _545;
    if (_372)
    {
        float4 _495 = _166;
        _495.y = (-0.48860299587249755859375) * _362.y;
        float4 _498 = _495;
        _498.z = 0.48860299587249755859375 * _362.z;
        float4 _501 = _498;
        _501.w = (-0.48860299587249755859375) * _362.x;
        float3 _502 = _362 * _362;
        float4 _505 = _163;
        _505.x = (1.09254801273345947265625 * _362.x) * _362.y;
        float4 _508 = _505;
        _508.y = ((-1.09254801273345947265625) * _362.y) * _362.z;
        float4 _513 = _508;
        _513.z = 0.3153919875621795654296875 * ((3.0 * _502.z) - 1.0);
        float4 _516 = _513;
        _516.w = ((-1.09254801273345947265625) * _362.x) * _362.z;
        float4 _520 = _501;
        _520.x = 0.886227548122406005859375;
        float3 _522 = _520.yzw * 2.094395160675048828125;
        float4 _523 = float4(_520.x, _522.x, _522.y, _522.z);
        float4 _524 = _516 * 0.785398185253143310546875;
        float _525 = (_502.x - _502.y) * 0.4290426075458526611328125;
        float3 _531 = float3(0.0);
        _531.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _523) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _524)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _525);
        float3 _537 = _531;
        _537.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _523) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _524)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _525);
        float3 _543 = _537;
        _543.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _523) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _524)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _525);
        _545 = fast::max(float3(0.0), _543);
    }
    else
    {
        _545 = float3(0.0);
    }
    float3 _548 = _545 * View.View_IndirectLightingColorScale;
    float3 _570 = fast::max(mix(Material.Material_VectorExpressions[3].xyz, Material.Material_VectorExpressions[4].xyz, float3(Material.Material_ScalarExpressions[0].y)), float3(0.0));
    float3 _599;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _598;
        if (any(abs(_229 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _307 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _307 + 19u)].xyz + float3(1.0))))
        {
            _598 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_229, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _598 = _570;
        }
        _599 = _598;
    }
    else
    {
        _599 = _570;
    }
    float4 _606 = float4(((mix(float3(0.0), _454 + (_456 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_548 * _454) * fast::max(_465, ((((((_361 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _301) + ((_361 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _301) + ((_361 * 2.755199909210205078125) + float3(0.69029998779296875))) * _301))) + _599) * 1.0, 0.0);
    float4 _613;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _612 = _606;
        _612.w = 0.0;
        _613 = _612;
    }
    else
    {
        _613 = _606;
    }
    float2 _617 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _625 = (_362 * 0.5) + float3(0.5);
    float4 _627 = float4(_625.x, _625.y, _625.z, float4(0.0).w);
    _627.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _308)].y;
    float4 _628 = float4(0.0);
    _628.x = _360;
    float4 _629 = _628;
    _629.y = _359;
    float4 _630 = _629;
    _630.z = _358;
    float4 _631 = _630;
    _631.w = 0.50588238239288330078125;
    float4 _643 = float4(_361.x, _361.y, _361.z, float4(0.0).w);
    _643.w = ((log2(((dot(_548, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_465, ((((((_458 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _301) + ((_458 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _301) + ((_458 * 2.755199909210205078125) + float3(0.69029998779296875))) * _301).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_617.xyx * _617.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _613 * View.View_PreExposure;
    out.out_var_SV_Target1 = _627;
    out.out_var_SV_Target2 = _631;
    out.out_var_SV_Target3 = _643;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_425, 1.0, 1.0, 1.0);
    return out;
}

