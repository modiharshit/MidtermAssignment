

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

constant float4 _164 = {};
constant float _166 = {};
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

fragment MainPS_out Main_00004202_f94f187d(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float3x3 _210 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _221 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _166, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _226 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _230 = _226.xyz / float3(_226.w);
    float3 _231 = _230 - View.View_PreViewTranslation;
    float2 _235 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5;
    float4 _241 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _235, bias(View.View_MaterialTextureMipBias));
    float2 _247 = ((normalize(-_230) * _210).xy * ((0.00999999977648258209228515625 * _241.w) + (-0.008000000379979610443115234375))) + _235;
    float4 _251 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _247, bias(View.View_MaterialTextureMipBias));
    float2 _254 = (_251.xy * float2(2.0)) - float2(1.0);
    float3 _270 = normalize(_210 * normalize((float4(_254, sqrt(fast::clamp(1.0 - dot(_254, _254), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _282 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _287 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _292 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _296 = (_282.x + 0.5) * ((_287.x + 0.5) * (_292.x + 0.5));
    float4 _299 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _247, bias(View.View_MaterialTextureMipBias));
    float4 _305 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _247, bias(View.View_MaterialTextureMipBias));
    float3 _310 = fast::clamp(_299.xyz * mix(0.5, 1.0, _296), float3(0.0), float3(1.0));
    float _311 = fast::clamp(_305.y, 0.0, 1.0);
    float _316 = (fast::clamp(mix(0.300000011920928955078125, 0.800000011920928955078125, _296 * _305.x), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _317 = in.in_var_PRIMITIVE_ID * 36u;
    uint _318 = _317 + 20u;
    float _366;
    float _367;
    float _368;
    float3 _369;
    float3 _370;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _318)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _336 = ((_221.xy / float2(_221.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _340 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _336, level(0.0));
        float4 _343 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _336, level(0.0));
        float4 _346 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _336, level(0.0));
        float _356 = _346.w;
        _366 = (_316 * _356) + _346.z;
        _367 = (0.5 * _356) + _346.y;
        _368 = _346.x;
        _369 = (_310 * _340.w) + _340.xyz;
        _370 = normalize((_270 * _343.w) + ((_343.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _366 = _316;
        _367 = 0.5;
        _368 = 0.0;
        _369 = _310;
        _370 = _270;
    }
    bool _380 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _386;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _317 + 18u)].w > 0.0) && _380)
    {
        _386 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _386 = 1.0;
    }
    float _433;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _318)].z > 0.0)
    {
        float3 _401 = fast::clamp((_231 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _412 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_401.x), int(_401.y), int(_401.z), 0).xyz), 0));
        _433 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_412.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_401 / float3(_412.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _433 = _386;
    }
    float3 _447 = ((_369 - (_369 * _368)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _454 = (mix(float3(0.07999999821186065673828125 * _367), _369, float3(_368)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _457 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _462;
    if (_457)
    {
        _462 = _447 + (_454 * 0.449999988079071044921875);
    }
    else
    {
        _462 = _447;
    }
    float3 _464 = select(_454, float3(0.0), bool3(_457));
    float3 _466 = float3(dot(_464, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _473 = float3(_311);
    float3 _553;
    if (_380)
    {
        float4 _503 = _167;
        _503.y = (-0.48860299587249755859375) * _370.y;
        float4 _506 = _503;
        _506.z = 0.48860299587249755859375 * _370.z;
        float4 _509 = _506;
        _509.w = (-0.48860299587249755859375) * _370.x;
        float3 _510 = _370 * _370;
        float4 _513 = _164;
        _513.x = (1.09254801273345947265625 * _370.x) * _370.y;
        float4 _516 = _513;
        _516.y = ((-1.09254801273345947265625) * _370.y) * _370.z;
        float4 _521 = _516;
        _521.z = 0.3153919875621795654296875 * ((3.0 * _510.z) - 1.0);
        float4 _524 = _521;
        _524.w = ((-1.09254801273345947265625) * _370.x) * _370.z;
        float4 _528 = _509;
        _528.x = 0.886227548122406005859375;
        float3 _530 = _528.yzw * 2.094395160675048828125;
        float4 _531 = float4(_528.x, _530.x, _530.y, _530.z);
        float4 _532 = _524 * 0.785398185253143310546875;
        float _533 = (_510.x - _510.y) * 0.4290426075458526611328125;
        float3 _539 = float3(0.0);
        _539.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _531) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _532)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _533);
        float3 _545 = _539;
        _545.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _531) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _532)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _533);
        float3 _551 = _545;
        _551.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _531) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _532)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _533);
        _553 = fast::max(float3(0.0), _551);
    }
    else
    {
        _553 = float3(0.0);
    }
    float3 _556 = _553 * View.View_IndirectLightingColorScale;
    float3 _578 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _607;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _606;
        if (any(abs(_231 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _317 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _317 + 19u)].xyz + float3(1.0))))
        {
            _606 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_231, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _606 = _578;
        }
        _607 = _606;
    }
    else
    {
        _607 = _578;
    }
    float4 _614 = float4(((mix(float3(0.0), _462 + (_464 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_556 * _462) * fast::max(_473, ((((((_369 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _311) + ((_369 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _311) + ((_369 * 2.755199909210205078125) + float3(0.69029998779296875))) * _311))) + _607) * 1.0, 0.0);
    float4 _621;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _620 = _614;
        _620.w = 0.0;
        _621 = _620;
    }
    else
    {
        _621 = _614;
    }
    float2 _625 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _633 = (_370 * 0.5) + float3(0.5);
    float4 _635 = float4(_633.x, _633.y, _633.z, float4(0.0).w);
    _635.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _318)].y;
    float4 _636 = float4(0.0);
    _636.x = _368;
    float4 _637 = _636;
    _637.y = _367;
    float4 _638 = _637;
    _638.z = _366;
    float4 _639 = _638;
    _639.w = 0.50588238239288330078125;
    float4 _651 = float4(_369.x, _369.y, _369.z, float4(0.0).w);
    _651.w = ((log2(((dot(_556, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_473, ((((((_466 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _311) + ((_466 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _311) + ((_466 * 2.755199909210205078125) + float3(0.69029998779296875))) * _311).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_625.xyx * _625.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _621 * View.View_PreExposure;
    out.out_var_SV_Target1 = _635;
    out.out_var_SV_Target2 = _639;
    out.out_var_SV_Target3 = _651;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_433, 1.0, 1.0, 1.0);
    return out;
}

