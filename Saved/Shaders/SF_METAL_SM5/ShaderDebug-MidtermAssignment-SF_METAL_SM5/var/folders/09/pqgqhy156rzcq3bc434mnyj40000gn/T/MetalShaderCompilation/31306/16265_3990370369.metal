

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

constant float4 _161 = {};
constant float _163 = {};
constant float4 _164 = {};

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

fragment MainPS_out Main_00003f89_edd83841(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _218 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _163, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _223 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _228 = (_223.xyz / float3(_223.w)) - View.View_PreViewTranslation;
    float4 _234 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _237 = (_234.xy * float2(2.0)) - float2(1.0);
    float3 _253 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_237, sqrt(fast::clamp(1.0 - dot(_237, _237), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _265 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _270 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _275 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _279 = (_265.x + 0.5) * ((_270.x + 0.5) * (_275.x + 0.5));
    float4 _285 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _291 = fast::clamp(mix(float3(0.800000011920928955078125), float3(1.0), float3(_279)) * _285.xyz, float3(0.0), float3(1.0));
    float _296 = (fast::clamp(mix(0.800000011920928955078125, 0.5, _279 * _285.w), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _297 = in.in_var_PRIMITIVE_ID * 36u;
    uint _298 = _297 + 20u;
    float _346;
    float _347;
    float _348;
    float3 _349;
    float3 _350;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _298)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _316 = ((_218.xy / float2(_218.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _320 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _316, level(0.0));
        float4 _323 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _316, level(0.0));
        float4 _326 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _316, level(0.0));
        float _336 = _326.w;
        _346 = (_296 * _336) + _326.z;
        _347 = (0.5 * _336) + _326.y;
        _348 = _326.x;
        _349 = (_291 * _320.w) + _320.xyz;
        _350 = normalize((_253 * _323.w) + ((_323.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _346 = _296;
        _347 = 0.5;
        _348 = 0.0;
        _349 = _291;
        _350 = _253;
    }
    bool _360 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _366;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _297 + 18u)].w > 0.0) && _360)
    {
        _366 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _366 = 1.0;
    }
    float _413;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _298)].z > 0.0)
    {
        float3 _381 = fast::clamp((_228 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _392 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_381.x), int(_381.y), int(_381.z), 0).xyz), 0));
        _413 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_392.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_381 / float3(_392.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _413 = _366;
    }
    float3 _427 = ((_349 - (_349 * _348)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _434 = (mix(float3(0.07999999821186065673828125 * _347), _349, float3(_348)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _437 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _442;
    if (_437)
    {
        _442 = _427 + (_434 * 0.449999988079071044921875);
    }
    else
    {
        _442 = _427;
    }
    float3 _444 = select(_434, float3(0.0), bool3(_437));
    float3 _446 = float3(dot(_444, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _532;
    if (_360)
    {
        float4 _482 = _164;
        _482.y = (-0.48860299587249755859375) * _350.y;
        float4 _485 = _482;
        _485.z = 0.48860299587249755859375 * _350.z;
        float4 _488 = _485;
        _488.w = (-0.48860299587249755859375) * _350.x;
        float3 _489 = _350 * _350;
        float4 _492 = _161;
        _492.x = (1.09254801273345947265625 * _350.x) * _350.y;
        float4 _495 = _492;
        _495.y = ((-1.09254801273345947265625) * _350.y) * _350.z;
        float4 _500 = _495;
        _500.z = 0.3153919875621795654296875 * ((3.0 * _489.z) - 1.0);
        float4 _503 = _500;
        _503.w = ((-1.09254801273345947265625) * _350.x) * _350.z;
        float4 _507 = _488;
        _507.x = 0.886227548122406005859375;
        float3 _509 = _507.yzw * 2.094395160675048828125;
        float4 _510 = float4(_507.x, _509.x, _509.y, _509.z);
        float4 _511 = _503 * 0.785398185253143310546875;
        float _512 = (_489.x - _489.y) * 0.4290426075458526611328125;
        float3 _518 = float3(0.0);
        _518.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _510) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _511)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _512);
        float3 _524 = _518;
        _524.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _510) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _511)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _512);
        float3 _530 = _524;
        _530.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _510) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _511)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _512);
        _532 = fast::max(float3(0.0), _530);
    }
    else
    {
        _532 = float3(0.0);
    }
    float3 _535 = _532 * View.View_IndirectLightingColorScale;
    float3 _557 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _586;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _585;
        if (any(abs(_228 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _297 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _297 + 19u)].xyz + float3(1.0))))
        {
            _585 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_228, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _585 = _557;
        }
        _586 = _585;
    }
    else
    {
        _586 = _557;
    }
    float4 _593 = float4(((mix(float3(0.0), _442 + (_444 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_535 * _442) * fast::max(float3(1.0), ((((((_349 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_349 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_349 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _586) * 1.0, 0.0);
    float4 _600;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _599 = _593;
        _599.w = 0.0;
        _600 = _599;
    }
    else
    {
        _600 = _593;
    }
    float2 _604 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _612 = (_350 * 0.5) + float3(0.5);
    float4 _614 = float4(_612.x, _612.y, _612.z, float4(0.0).w);
    _614.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _298)].y;
    float4 _615 = float4(0.0);
    _615.x = _348;
    float4 _616 = _615;
    _616.y = _347;
    float4 _617 = _616;
    _617.z = _346;
    float4 _618 = _617;
    _618.w = 0.50588238239288330078125;
    float4 _630 = float4(_349.x, _349.y, _349.z, float4(0.0).w);
    _630.w = ((log2(((dot(_535, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_446 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_446 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_446 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_604.xyx * _604.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _600 * View.View_PreExposure;
    out.out_var_SV_Target1 = _614;
    out.out_var_SV_Target2 = _618;
    out.out_var_SV_Target3 = _630;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_413, 1.0, 1.0, 1.0);
    return out;
}

