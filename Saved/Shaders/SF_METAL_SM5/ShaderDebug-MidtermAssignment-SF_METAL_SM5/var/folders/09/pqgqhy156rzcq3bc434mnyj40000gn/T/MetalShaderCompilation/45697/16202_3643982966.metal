

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
    float3 IndirectLightingCache_IndirectLightingCachePrimitiveAdd;
    float3 IndirectLightingCache_IndirectLightingCachePrimitiveScale;
    float3 IndirectLightingCache_IndirectLightingCacheMinUV;
    float3 IndirectLightingCache_IndirectLightingCacheMaxUV;
    char _m4_pad[16];
    float IndirectLightingCache_DirectionalLightShadowing;
};

struct type_Material
{
    spvUnsafeArray<float4, 7> Material_VectorExpressions;
    spvUnsafeArray<float4, 2> Material_ScalarExpressions;
};

constant float _162 = {};
constant float4 _163 = {};

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

fragment MainPS_out Main_00003f4a_d932c476(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_PrimitiveDither& PrimitiveDither [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], sampler View_MaterialTextureBilinearClampedSampler [[sampler(0)]], sampler View_SharedBilinearClampedSampler [[sampler(1)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(2)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _217 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _162, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _222 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _227 = (_222.xyz / float3(_222.w)) - View.View_PreViewTranslation;
    float4 _231 = Material_Texture2D_0.sample(View_MaterialTextureBilinearClampedSampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y));
    float2 _234 = (_231.xy * float2(2.0)) - float2(1.0);
    float3 _250 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_234, sqrt(fast::clamp(1.0 - dot(_234, _234), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    if (PrimitiveDither.PrimitiveDither_LODFactor != 0.0)
    {
        if (abs(PrimitiveDither.PrimitiveDither_LODFactor) > 0.001000000047497451305389404296875)
        {
            float _285 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
            if ((float((PrimitiveDither.PrimitiveDither_LODFactor < 0.0) ? ((PrimitiveDither.PrimitiveDither_LODFactor + 1.0) > _285) : (PrimitiveDither.PrimitiveDither_LODFactor < _285)) - 0.001000000047497451305389404296875) < 0.0)
            {
                discard_fragment();
            }
        }
    }
    float3 _296 = fast::clamp(Material.Material_VectorExpressions[6].xyz, float3(0.0), float3(1.0));
    float _297 = fast::clamp(Material.Material_ScalarExpressions[0].z, 0.0, 1.0);
    float _298 = fast::clamp(Material.Material_ScalarExpressions[0].w, 0.0, 1.0);
    float _299 = fast::clamp(Material.Material_ScalarExpressions[1].y, 0.0, 1.0);
    float _304 = (fast::clamp(Material.Material_ScalarExpressions[1].x, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _305 = in.in_var_PRIMITIVE_ID * 36u;
    uint _306 = _305 + 20u;
    float _356;
    float _357;
    float _358;
    float3 _359;
    float3 _360;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _306)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _324 = ((_217.xy / float2(_217.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _328 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _324, level(0.0));
        float4 _331 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _324, level(0.0));
        float4 _334 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _324, level(0.0));
        float _344 = _334.w;
        _356 = (_304 * _344) + _334.z;
        _357 = (_298 * _344) + _334.y;
        _358 = (_297 * _344) + _334.x;
        _359 = (_296 * _328.w) + _328.xyz;
        _360 = normalize((_250 * _331.w) + ((_331.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _356 = _304;
        _357 = _298;
        _358 = _297;
        _359 = _296;
        _360 = _250;
    }
    bool _370 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _376;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _305 + 18u)].w > 0.0) && _370)
    {
        _376 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _376 = 1.0;
    }
    float _423;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _306)].z > 0.0)
    {
        float3 _391 = fast::clamp((_227 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _402 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_391.x), int(_391.y), int(_391.z), 0).xyz), 0));
        _423 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_402.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_391 / float3(_402.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _423 = _376;
    }
    float3 _437 = ((_359 - (_359 * _358)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _444 = (mix(float3(0.07999999821186065673828125 * _357), _359, float3(_358)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _447 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _452;
    if (_447)
    {
        _452 = _437 + (_444 * 0.449999988079071044921875);
    }
    else
    {
        _452 = _437;
    }
    float3 _454 = select(_444, float3(0.0), bool3(_447));
    float3 _456 = float3(dot(_454, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _463 = float3(_299);
    float3 _531;
    if (_370)
    {
        float3 _483 = fast::clamp((_227 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _487 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _483);
        float4 _491 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _483);
        float4 _494 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _483);
        float4 _512 = _163;
        _512.y = (-0.48860299587249755859375) * _360.y;
        float4 _515 = _512;
        _515.z = 0.48860299587249755859375 * _360.z;
        float4 _518 = _515;
        _518.w = (-0.48860299587249755859375) * _360.x;
        float4 _519 = _518;
        _519.x = 0.886227548122406005859375;
        float3 _521 = _519.yzw * 2.094395160675048828125;
        float4 _522 = float4(_519.x, _521.x, _521.y, _521.z);
        float3 _524 = float3(0.0);
        _524.x = dot(float4(_487.x, _491.x, _494.x, _487.w), _522);
        float3 _526 = _524;
        _526.y = dot(float4(_487.y, _491.y, _494.y, _491.w), _522);
        float3 _528 = _526;
        _528.z = dot(float4(_487.z, _491.z, _494.zw), _522);
        _531 = fast::max(float3(0.0), _528) * float3(0.3183098733425140380859375);
    }
    else
    {
        _531 = float3(0.0);
    }
    float3 _534 = _531 * View.View_IndirectLightingColorScale;
    float3 _556 = fast::max(mix(Material.Material_VectorExpressions[3].xyz, Material.Material_VectorExpressions[4].xyz, float3(Material.Material_ScalarExpressions[0].y)), float3(0.0));
    float3 _585;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _584;
        if (any(abs(_227 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _305 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _305 + 19u)].xyz + float3(1.0))))
        {
            _584 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_227, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _584 = _556;
        }
        _585 = _584;
    }
    else
    {
        _585 = _556;
    }
    float4 _592 = float4(((mix(float3(0.0), _452 + (_454 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_534 * _452) * fast::max(_463, ((((((_359 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _299) + ((_359 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _299) + ((_359 * 2.755199909210205078125) + float3(0.69029998779296875))) * _299))) + _585) * 1.0, 0.0);
    float4 _599;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _598 = _592;
        _598.w = 0.0;
        _599 = _598;
    }
    else
    {
        _599 = _592;
    }
    float2 _603 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _611 = (_360 * 0.5) + float3(0.5);
    float4 _613 = float4(_611.x, _611.y, _611.z, float4(0.0).w);
    _613.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _306)].y;
    float4 _614 = float4(0.0);
    _614.x = _358;
    float4 _615 = _614;
    _615.y = _357;
    float4 _616 = _615;
    _616.z = _356;
    float4 _617 = _616;
    _617.w = 0.50588238239288330078125;
    float4 _629 = float4(_359.x, _359.y, _359.z, float4(0.0).w);
    _629.w = ((log2(((dot(_534, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_463, ((((((_456 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _299) + ((_456 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _299) + ((_456 * 2.755199909210205078125) + float3(0.69029998779296875))) * _299).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_603.xyx * _603.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _599 * View.View_PreExposure;
    out.out_var_SV_Target1 = _613;
    out.out_var_SV_Target2 = _617;
    out.out_var_SV_Target3 = _629;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_423, 1.0, 1.0, 1.0);
    return out;
}

