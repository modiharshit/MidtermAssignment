

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

constant float4 _154 = {};
constant float _156 = {};
constant float4 _157 = {};

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

fragment MainPS_out Main_00003a3f_9e27e127(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _211 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _156, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _216 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _221 = (_216.xyz / float3(_216.w)) - View.View_PreViewTranslation;
    float3 _229 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _242 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _244 = fast::clamp(_242.xyz, float3(0.0), float3(1.0));
    float _248 = (0.949999988079071044921875 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _249 = in.in_var_PRIMITIVE_ID * 36u;
    uint _250 = _249 + 20u;
    float _298;
    float _299;
    float _300;
    float3 _301;
    float3 _302;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _250)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _268 = ((_211.xy / float2(_211.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _272 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _268, level(0.0));
        float4 _275 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _268, level(0.0));
        float4 _278 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _268, level(0.0));
        float _288 = _278.w;
        _298 = (_248 * _288) + _278.z;
        _299 = (0.20000000298023223876953125 * _288) + _278.y;
        _300 = _278.x;
        _301 = (_244 * _272.w) + _272.xyz;
        _302 = normalize((_229 * _275.w) + ((_275.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _298 = _248;
        _299 = 0.20000000298023223876953125;
        _300 = 0.0;
        _301 = _244;
        _302 = _229;
    }
    bool _312 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _318;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _249 + 18u)].w > 0.0) && _312)
    {
        _318 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _318 = 1.0;
    }
    float _365;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _250)].z > 0.0)
    {
        float3 _333 = fast::clamp((_221 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _344 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_333.x), int(_333.y), int(_333.z), 0).xyz), 0));
        _365 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_344.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_333 / float3(_344.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _365 = _318;
    }
    float3 _379 = ((_301 - (_301 * _300)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _386 = (mix(float3(0.07999999821186065673828125 * _299), _301, float3(_300)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _389 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _394;
    if (_389)
    {
        _394 = _379 + (_386 * 0.449999988079071044921875);
    }
    else
    {
        _394 = _379;
    }
    float3 _396 = select(_386, float3(0.0), bool3(_389));
    float3 _398 = float3(dot(_396, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _484;
    if (_312)
    {
        float4 _434 = _157;
        _434.y = (-0.48860299587249755859375) * _302.y;
        float4 _437 = _434;
        _437.z = 0.48860299587249755859375 * _302.z;
        float4 _440 = _437;
        _440.w = (-0.48860299587249755859375) * _302.x;
        float3 _441 = _302 * _302;
        float4 _444 = _154;
        _444.x = (1.09254801273345947265625 * _302.x) * _302.y;
        float4 _447 = _444;
        _447.y = ((-1.09254801273345947265625) * _302.y) * _302.z;
        float4 _452 = _447;
        _452.z = 0.3153919875621795654296875 * ((3.0 * _441.z) - 1.0);
        float4 _455 = _452;
        _455.w = ((-1.09254801273345947265625) * _302.x) * _302.z;
        float4 _459 = _440;
        _459.x = 0.886227548122406005859375;
        float3 _461 = _459.yzw * 2.094395160675048828125;
        float4 _462 = float4(_459.x, _461.x, _461.y, _461.z);
        float4 _463 = _455 * 0.785398185253143310546875;
        float _464 = (_441.x - _441.y) * 0.4290426075458526611328125;
        float3 _470 = float3(0.0);
        _470.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _462) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _463)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _464);
        float3 _476 = _470;
        _476.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _462) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _463)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _464);
        float3 _482 = _476;
        _482.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _462) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _463)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _464);
        _484 = fast::max(float3(0.0), _482);
    }
    else
    {
        _484 = float3(0.0);
    }
    float3 _487 = _484 * View.View_IndirectLightingColorScale;
    float3 _509 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _538;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _537;
        if (any(abs(_221 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _249 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _249 + 19u)].xyz + float3(1.0))))
        {
            _537 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_221, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _537 = _509;
        }
        _538 = _537;
    }
    else
    {
        _538 = _509;
    }
    float4 _545 = float4(((mix(float3(0.0), _394 + (_396 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_487 * _394) * fast::max(float3(1.0), ((((((_301 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_301 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_301 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _538) * 1.0, 0.0);
    float4 _552;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _551 = _545;
        _551.w = 0.0;
        _552 = _551;
    }
    else
    {
        _552 = _545;
    }
    float2 _556 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _564 = (_302 * 0.5) + float3(0.5);
    float4 _566 = float4(_564.x, _564.y, _564.z, float4(0.0).w);
    _566.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _250)].y;
    float4 _567 = float4(0.0);
    _567.x = _300;
    float4 _568 = _567;
    _568.y = _299;
    float4 _569 = _568;
    _569.z = _298;
    float4 _570 = _569;
    _570.w = 0.50588238239288330078125;
    float4 _582 = float4(_301.x, _301.y, _301.z, float4(0.0).w);
    _582.w = ((log2(((dot(_487, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_398 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_398 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_398 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_556.xyx * _556.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _552 * View.View_PreExposure;
    out.out_var_SV_Target1 = _566;
    out.out_var_SV_Target2 = _570;
    out.out_var_SV_Target3 = _582;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_365, 1.0, 1.0, 1.0);
    return out;
}

