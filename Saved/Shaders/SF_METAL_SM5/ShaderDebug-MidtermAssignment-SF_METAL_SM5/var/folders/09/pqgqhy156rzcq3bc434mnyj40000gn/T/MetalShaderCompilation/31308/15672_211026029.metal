

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
    spvUnsafeArray<float4, 6> Material_VectorExpressions;
    spvUnsafeArray<float4, 2> Material_ScalarExpressions;
};

constant float4 _158 = {};
constant float _160 = {};
constant float4 _161 = {};

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

fragment MainPS_out Main_00003d38_0c94006d(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _214 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _160, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _219 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _224 = (_219.xyz / float3(_219.w)) - View.View_PreViewTranslation;
    float4 _230 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _233 = (_230.xy * float2(2.0)) - float2(1.0);
    float3 _249 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_233, sqrt(fast::clamp(1.0 - dot(_233, _233), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _260 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _267 = _260.y;
    float3 _282 = fast::clamp(mix(Material.Material_VectorExpressions[4].xyz, Material.Material_VectorExpressions[5].xyz, float3(_267)) * _260.x, float3(0.0), float3(1.0));
    float _283 = fast::clamp(mix(Material.Material_ScalarExpressions[0].y, Material.Material_ScalarExpressions[0].z, _267), 0.0, 1.0);
    float _288 = (fast::clamp(mix(Material.Material_ScalarExpressions[0].w, Material.Material_ScalarExpressions[1].x, _267), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _289 = in.in_var_PRIMITIVE_ID * 36u;
    uint _290 = _289 + 20u;
    float _340;
    float _341;
    float _342;
    float3 _343;
    float3 _344;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _290)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _308 = ((_214.xy / float2(_214.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _312 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _308, level(0.0));
        float4 _315 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _308, level(0.0));
        float4 _318 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _308, level(0.0));
        float _328 = _318.w;
        _340 = (_288 * _328) + _318.z;
        _341 = (0.5 * _328) + _318.y;
        _342 = (_283 * _328) + _318.x;
        _343 = (_282 * _312.w) + _312.xyz;
        _344 = normalize((_249 * _315.w) + ((_315.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _340 = _288;
        _341 = 0.5;
        _342 = _283;
        _343 = _282;
        _344 = _249;
    }
    bool _354 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _360;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _289 + 18u)].w > 0.0) && _354)
    {
        _360 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _360 = 1.0;
    }
    float _407;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _290)].z > 0.0)
    {
        float3 _375 = fast::clamp((_224 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _386 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_375.x), int(_375.y), int(_375.z), 0).xyz), 0));
        _407 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_386.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_375 / float3(_386.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _407 = _360;
    }
    float3 _421 = ((_343 - (_343 * _342)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _428 = (mix(float3(0.07999999821186065673828125 * _341), _343, float3(_342)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _431 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _436;
    if (_431)
    {
        _436 = _421 + (_428 * 0.449999988079071044921875);
    }
    else
    {
        _436 = _421;
    }
    float3 _438 = select(_428, float3(0.0), bool3(_431));
    float3 _440 = float3(dot(_438, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _526;
    if (_354)
    {
        float4 _476 = _161;
        _476.y = (-0.48860299587249755859375) * _344.y;
        float4 _479 = _476;
        _479.z = 0.48860299587249755859375 * _344.z;
        float4 _482 = _479;
        _482.w = (-0.48860299587249755859375) * _344.x;
        float3 _483 = _344 * _344;
        float4 _486 = _158;
        _486.x = (1.09254801273345947265625 * _344.x) * _344.y;
        float4 _489 = _486;
        _489.y = ((-1.09254801273345947265625) * _344.y) * _344.z;
        float4 _494 = _489;
        _494.z = 0.3153919875621795654296875 * ((3.0 * _483.z) - 1.0);
        float4 _497 = _494;
        _497.w = ((-1.09254801273345947265625) * _344.x) * _344.z;
        float4 _501 = _482;
        _501.x = 0.886227548122406005859375;
        float3 _503 = _501.yzw * 2.094395160675048828125;
        float4 _504 = float4(_501.x, _503.x, _503.y, _503.z);
        float4 _505 = _497 * 0.785398185253143310546875;
        float _506 = (_483.x - _483.y) * 0.4290426075458526611328125;
        float3 _512 = float3(0.0);
        _512.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _504) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _505)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _506);
        float3 _518 = _512;
        _518.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _504) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _505)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _506);
        float3 _524 = _518;
        _524.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _504) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _505)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _506);
        _526 = fast::max(float3(0.0), _524);
    }
    else
    {
        _526 = float3(0.0);
    }
    float3 _529 = _526 * View.View_IndirectLightingColorScale;
    float3 _551 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _580;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _579;
        if (any(abs(_224 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _289 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _289 + 19u)].xyz + float3(1.0))))
        {
            _579 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_224, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _579 = _551;
        }
        _580 = _579;
    }
    else
    {
        _580 = _551;
    }
    float4 _587 = float4(((mix(float3(0.0), _436 + (_438 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_529 * _436) * fast::max(float3(1.0), ((((((_343 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_343 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_343 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _580) * 1.0, 0.0);
    float4 _594;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _593 = _587;
        _593.w = 0.0;
        _594 = _593;
    }
    else
    {
        _594 = _587;
    }
    float2 _598 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _606 = (_344 * 0.5) + float3(0.5);
    float4 _608 = float4(_606.x, _606.y, _606.z, float4(0.0).w);
    _608.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _290)].y;
    float4 _609 = float4(0.0);
    _609.x = _342;
    float4 _610 = _609;
    _610.y = _341;
    float4 _611 = _610;
    _611.z = _340;
    float4 _612 = _611;
    _612.w = 0.50588238239288330078125;
    float4 _624 = float4(_343.x, _343.y, _343.z, float4(0.0).w);
    _624.w = ((log2(((dot(_529, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_440 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_440 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_440 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_598.xyx * _598.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _594 * View.View_PreExposure;
    out.out_var_SV_Target1 = _608;
    out.out_var_SV_Target2 = _612;
    out.out_var_SV_Target3 = _624;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_407, 1.0, 1.0, 1.0);
    return out;
}

