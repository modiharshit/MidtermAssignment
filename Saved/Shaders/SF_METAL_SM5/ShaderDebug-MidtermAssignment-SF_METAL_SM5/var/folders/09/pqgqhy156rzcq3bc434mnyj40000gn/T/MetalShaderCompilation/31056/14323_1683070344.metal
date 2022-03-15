

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
    char _m1_pad[352];
    float3 View_PreViewTranslation;
    char _m2_pad[1028];
    float View_PreExposure;
    float4 View_DiffuseOverrideParameter;
    float4 View_SpecularOverrideParameter;
    float4 View_NormalOverrideParameter;
    float2 View_RoughnessOverrideParameter;
    char _m7_pad[8];
    float View_OutOfBoundsMask;
    char _m8_pad[48];
    float View_MaterialTextureMipBias;
    char _m9_pad[28];
    float View_UnlitViewmodeMask;
    char _m10_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m11_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m12_pad[376];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m13_pad[48];
    float3 View_VolumetricLightmapWorldToUVScale;
    float3 View_VolumetricLightmapWorldToUVAdd;
    packed_float3 View_VolumetricLightmapIndirectionTextureSize;
    float View_VolumetricLightmapBrickSize;
    float3 View_VolumetricLightmapBrickTexelSize;
    float View_IndirectLightingCacheShowFlag;
};

struct type_Primitive
{
    char _m0_pad[80];
    float4 Primitive_ObjectWorldPositionAndRadius;
    char _m1_pad[204];
    float Primitive_UseSingleSampleShadowFromStationaryLights;
    float3 Primitive_ObjectBounds;
    char _m3_pad[4];
    float Primitive_PerObjectGBufferData;
    float Primitive_UseVolumetricLightmapShadowFromStationaryLights;
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
    spvUnsafeArray<float4, 4> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _154 = {};

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
};

fragment MainPS_out Main_000037f3_64519d88(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(2)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(3)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler View_MaterialTextureBilinearWrapedSampler [[sampler(0)]], sampler View_SharedBilinearClampedSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    float4 _193 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _198 = (_193.xyz / float3(_193.w)) - View.View_PreViewTranslation;
    float4 _204 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _207 = (_204.xy * float2(2.0)) - float2(1.0);
    float _211 = sqrt(fast::clamp(1.0 - dot(_207, _207), 0.0, 1.0));
    float3 _219 = float3(float4(_207, _211, 1.0).xy * (-1.0), _211);
    float3 _223 = (float3(0.0, 0.0, 2.0) * dot(float3(0.0, 0.0, 2.0), _219)) - (_219 * 2.0);
    float3 _235 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize(((_223 / float3(sqrt(dot(_223, _223)))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _239 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _257 = Material_Texture2D_2.sample(View_MaterialTextureBilinearWrapedSampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 8.0));
    float3 _261 = float3(_239.x);
    float4 _266 = Material_Texture2D_3.sample(View_MaterialTextureBilinearWrapedSampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 50.0));
    float3 _270 = float3(_239.z);
    float3 _284 = fast::clamp(mix(mix(mix(Material.Material_VectorExpressions[3].xyz, Material.Material_VectorExpressions[3].xyz, float3(_239.y)), _257.xyz * float3(0.25), _261), _266.xyz * float3(0.2249999940395355224609375), _270), float3(0.0), float3(1.0));
    float _285 = fast::clamp(mix(mix(float3(0.0), float3(1.0), _261), float3(0.0), _270).x, 0.0, 1.0);
    bool _298 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _304;
    if ((Primitive.Primitive_UseSingleSampleShadowFromStationaryLights > 0.0) && _298)
    {
        _304 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _304 = 1.0;
    }
    float _351;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _319 = fast::clamp((_198 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _330 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_319.x), int(_319.y), int(_319.z), 0).xyz), 0));
        _351 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_330.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_319 / float3(_330.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _351 = _304;
    }
    float3 _363 = ((_284 - (_284 * _285)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _370 = (mix(float3(0.039999999105930328369140625), _284, float3(_285)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _373 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _378;
    if (_373)
    {
        _378 = _363 + (_370 * 0.449999988079071044921875);
    }
    else
    {
        _378 = _363;
    }
    float3 _380 = select(_370, float3(0.0), bool3(_373));
    float3 _382 = float3(dot(_380, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _456;
    if (_298)
    {
        float3 _408 = fast::clamp((_198 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _412 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _408);
        float4 _416 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _408);
        float4 _419 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _408);
        float4 _437 = _154;
        _437.y = (-0.48860299587249755859375) * _235.y;
        float4 _440 = _437;
        _440.z = 0.48860299587249755859375 * _235.z;
        float4 _443 = _440;
        _443.w = (-0.48860299587249755859375) * _235.x;
        float4 _444 = _443;
        _444.x = 0.886227548122406005859375;
        float3 _446 = _444.yzw * 2.094395160675048828125;
        float4 _447 = float4(_444.x, _446.x, _446.y, _446.z);
        float3 _449 = float3(0.0);
        _449.x = dot(float4(_412.x, _416.x, _419.x, _412.w), _447);
        float3 _451 = _449;
        _451.y = dot(float4(_412.y, _416.y, _419.y, _416.w), _447);
        float3 _453 = _451;
        _453.z = dot(float4(_412.z, _416.z, _419.zw), _447);
        _456 = fast::max(float3(0.0), _453) * float3(0.3183098733425140380859375);
    }
    else
    {
        _456 = float3(0.0);
    }
    float3 _459 = _456 * View.View_IndirectLightingColorScale;
    float3 _481 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _507;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _506;
        if (any(abs(_198 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _506 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_198, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _506 = _481;
        }
        _507 = _506;
    }
    else
    {
        _507 = _481;
    }
    float4 _514 = float4(((mix(float3(0.0), _378 + (_380 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_459 * _378) * fast::max(float3(1.0), ((((((_284 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_284 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_284 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _507) * 1.0, 0.0);
    float4 _521;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _520 = _514;
        _520.w = 0.0;
        _521 = _520;
    }
    else
    {
        _521 = _514;
    }
    float2 _526 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _534 = (_235 * 0.5) + float3(0.5);
    float4 _536 = float4(_534.x, _534.y, _534.z, float4(0.0).w);
    _536.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _537 = float4(0.0);
    _537.x = _285;
    float4 _538 = _537;
    _538.y = 0.5;
    float4 _539 = _538;
    _539.z = (fast::clamp(mix(mix(float3(0.100000001490116119384765625), float3(mix(0.37999999523162841796875, 0.550000011920928955078125, _257.x)), _261), float3(mix(0.550000011920928955078125, 0.75, _266.x)), _270).x, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float4 _540 = _539;
    _540.w = 0.50588238239288330078125;
    float4 _552 = float4(_284.x, _284.y, _284.z, float4(0.0).w);
    _552.w = ((log2(((dot(_459, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_382 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_382 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_382 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_526.xyx * _526.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _521 * View.View_PreExposure;
    out.out_var_SV_Target1 = _536;
    out.out_var_SV_Target2 = _540;
    out.out_var_SV_Target3 = _552;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_351, 1.0, 1.0, 1.0);
    return out;
}

