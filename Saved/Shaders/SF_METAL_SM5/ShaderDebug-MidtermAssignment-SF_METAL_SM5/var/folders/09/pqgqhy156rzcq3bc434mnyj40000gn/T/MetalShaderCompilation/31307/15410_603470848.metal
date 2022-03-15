

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

constant float4 _156 = {};
constant float _158 = {};
constant float4 _159 = {};

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

fragment MainPS_out Main_00003c32_23f83c00(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _213 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _158, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _218 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _223 = (_218.xyz / float3(_218.w)) - View.View_PreViewTranslation;
    float3 _231 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _245 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _250 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _255 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float3 _262 = fast::clamp(float3(mix(1.0, 0.89999997615814208984375, (_245.x + 0.5) * ((_250.x + 0.5) * (_255.x + 0.5)))), float3(0.0), float3(1.0));
    float _266 = (0.4000000059604644775390625 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _267 = in.in_var_PRIMITIVE_ID * 36u;
    uint _268 = _267 + 20u;
    float _317;
    float _318;
    float _319;
    float3 _320;
    float3 _321;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _268)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _286 = ((_213.xy / float2(_213.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _290 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _286, level(0.0));
        float4 _293 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _286, level(0.0));
        float4 _296 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _286, level(0.0));
        float _306 = _296.w;
        _317 = (_266 * _306) + _296.z;
        _318 = (0.5 * _306) + _296.y;
        _319 = _306 + _296.x;
        _320 = (_262 * _290.w) + _290.xyz;
        _321 = normalize((_231 * _293.w) + ((_293.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _317 = _266;
        _318 = 0.5;
        _319 = 1.0;
        _320 = _262;
        _321 = _231;
    }
    bool _331 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _337;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _267 + 18u)].w > 0.0) && _331)
    {
        _337 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _337 = 1.0;
    }
    float _384;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _268)].z > 0.0)
    {
        float3 _352 = fast::clamp((_223 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _363 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_352.x), int(_352.y), int(_352.z), 0).xyz), 0));
        _384 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_363.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_352 / float3(_363.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _384 = _337;
    }
    float3 _398 = ((_320 - (_320 * _319)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _405 = (mix(float3(0.07999999821186065673828125 * _318), _320, float3(_319)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _408 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _413;
    if (_408)
    {
        _413 = _398 + (_405 * 0.449999988079071044921875);
    }
    else
    {
        _413 = _398;
    }
    float3 _415 = select(_405, float3(0.0), bool3(_408));
    float3 _417 = float3(dot(_415, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _503;
    if (_331)
    {
        float4 _453 = _159;
        _453.y = (-0.48860299587249755859375) * _321.y;
        float4 _456 = _453;
        _456.z = 0.48860299587249755859375 * _321.z;
        float4 _459 = _456;
        _459.w = (-0.48860299587249755859375) * _321.x;
        float3 _460 = _321 * _321;
        float4 _463 = _156;
        _463.x = (1.09254801273345947265625 * _321.x) * _321.y;
        float4 _466 = _463;
        _466.y = ((-1.09254801273345947265625) * _321.y) * _321.z;
        float4 _471 = _466;
        _471.z = 0.3153919875621795654296875 * ((3.0 * _460.z) - 1.0);
        float4 _474 = _471;
        _474.w = ((-1.09254801273345947265625) * _321.x) * _321.z;
        float4 _478 = _459;
        _478.x = 0.886227548122406005859375;
        float3 _480 = _478.yzw * 2.094395160675048828125;
        float4 _481 = float4(_478.x, _480.x, _480.y, _480.z);
        float4 _482 = _474 * 0.785398185253143310546875;
        float _483 = (_460.x - _460.y) * 0.4290426075458526611328125;
        float3 _489 = float3(0.0);
        _489.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _481) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _482)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _483);
        float3 _495 = _489;
        _495.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _481) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _482)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _483);
        float3 _501 = _495;
        _501.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _481) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _482)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _483);
        _503 = fast::max(float3(0.0), _501);
    }
    else
    {
        _503 = float3(0.0);
    }
    float3 _506 = _503 * View.View_IndirectLightingColorScale;
    float3 _528 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _557;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _556;
        if (any(abs(_223 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _267 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _267 + 19u)].xyz + float3(1.0))))
        {
            _556 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_223, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _556 = _528;
        }
        _557 = _556;
    }
    else
    {
        _557 = _528;
    }
    float4 _564 = float4(((mix(float3(0.0), _413 + (_415 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_506 * _413) * fast::max(float3(1.0), ((((((_320 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_320 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_320 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _557) * 1.0, 0.0);
    float4 _571;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _570 = _564;
        _570.w = 0.0;
        _571 = _570;
    }
    else
    {
        _571 = _564;
    }
    float2 _575 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _583 = (_321 * 0.5) + float3(0.5);
    float4 _585 = float4(_583.x, _583.y, _583.z, float4(0.0).w);
    _585.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _268)].y;
    float4 _586 = float4(0.0);
    _586.x = _319;
    float4 _587 = _586;
    _587.y = _318;
    float4 _588 = _587;
    _588.z = _317;
    float4 _589 = _588;
    _589.w = 0.50588238239288330078125;
    float4 _601 = float4(_320.x, _320.y, _320.z, float4(0.0).w);
    _601.w = ((log2(((dot(_506, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_417 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_417 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_417 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_575.xyx * _575.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _571 * View.View_PreExposure;
    out.out_var_SV_Target1 = _585;
    out.out_var_SV_Target2 = _589;
    out.out_var_SV_Target3 = _601;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_384, 1.0, 1.0, 1.0);
    return out;
}

