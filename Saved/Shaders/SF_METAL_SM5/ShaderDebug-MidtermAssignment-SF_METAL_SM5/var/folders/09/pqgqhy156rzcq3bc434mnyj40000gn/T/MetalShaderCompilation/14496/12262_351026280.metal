

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
    char _m12_pad[612];
    float View_RenderingReflectionCaptureMask;
    char _m13_pad[48];
    float4 View_SkyLightColor;
    char _m14_pad[124];
    float View_ShowDecalsMask;
    char _m15_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m16_pad[48];
    float3 View_VolumetricLightmapWorldToUVScale;
    float3 View_VolumetricLightmapWorldToUVAdd;
    packed_float3 View_VolumetricLightmapIndirectionTextureSize;
    float View_VolumetricLightmapBrickSize;
    float3 View_VolumetricLightmapBrickTexelSize;
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_Material
{
    spvUnsafeArray<float4, 4> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float _128 = {};
constant float3 _129 = {};

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
    uint in_var_PRIMITIVE_ID [[user(locn2)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00002fe6_14ec3c68(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _180 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _128, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _185 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _190 = (_185.xyz / float3(_185.w)) - View.View_PreViewTranslation;
    float3 _198 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _213 = fast::clamp(Material.Material_VectorExpressions[3].xyz, float3(0.0), float3(1.0));
    float _214 = fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0);
    float _219 = (fast::clamp(Material.Material_ScalarExpressions[0].z, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _220 = in.in_var_PRIMITIVE_ID * 36u;
    uint _221 = _220 + 20u;
    float _271;
    float _272;
    float _273;
    float3 _274;
    float3 _275;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _221)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _239 = ((_180.xy / float2(_180.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _243 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _239, level(0.0));
        float4 _246 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _239, level(0.0));
        float4 _249 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _239, level(0.0));
        float _259 = _249.w;
        _271 = (_219 * _259) + _249.z;
        _272 = (0.5 * _259) + _249.y;
        _273 = (_214 * _259) + _249.x;
        _274 = (_213 * _243.w) + _243.xyz;
        _275 = normalize((_198 * _246.w) + ((_246.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _271 = _219;
        _272 = 0.5;
        _273 = _214;
        _274 = _213;
        _275 = _198;
    }
    float _324;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _221)].z > 0.0)
    {
        float3 _292 = fast::clamp((_190 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _303 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_292.x), int(_292.y), int(_292.z), 0).xyz), 0));
        _324 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_303.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_292 / float3(_303.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _324 = 1.0;
    }
    float3 _338 = ((_274 - (_274 * _273)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _345 = (mix(float3(0.07999999821186065673828125 * _272), _274, float3(_273)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _348 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _353;
    if (_348)
    {
        _353 = _338 + (_345 * 0.449999988079071044921875);
    }
    else
    {
        _353 = _338;
    }
    float4 _359 = float4(_275, 1.0);
    float3 _363 = _129;
    _363.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _359);
    float3 _367 = _363;
    _367.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _359);
    float3 _371 = _367;
    _371.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _359);
    float4 _374 = _359.xyzz * _359.yzzx;
    float3 _378 = _129;
    _378.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _374);
    float3 _382 = _378;
    _382.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _374);
    float3 _386 = _382;
    _386.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _374);
    float3 _420 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _449;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _448;
        if (any(abs(_190 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _220 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _220 + 19u)].xyz + float3(1.0))))
        {
            _448 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_190, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _448 = _420;
        }
        _449 = _448;
    }
    else
    {
        _449 = _420;
    }
    float4 _456 = float4(((mix(float3(0.0), _353 + (select(_345, float3(0.0), bool3(_348)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((((fast::max(float3(0.0), (_371 + _386) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_275.x * _275.x) - (_275.y * _275.y)))) * View.View_SkyLightColor.xyz) * 1.0) * _353) * fast::max(float3(1.0), ((((((_274 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_274 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_274 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _449) * 1.0, 0.0);
    float4 _463;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _462 = _456;
        _462.w = 0.0;
        _463 = _462;
    }
    else
    {
        _463 = _456;
    }
    float2 _467 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _475 = (_275 * 0.5) + float3(0.5);
    float4 _477 = float4(_475.x, _475.y, _475.z, float4(0.0).w);
    _477.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _221)].y;
    float4 _478 = float4(0.0);
    _478.x = _273;
    float4 _479 = _478;
    _479.y = _272;
    float4 _480 = _479;
    _480.z = _271;
    float4 _481 = _480;
    _481.w = 0.50588238239288330078125;
    float4 _484 = float4(_274.x, _274.y, _274.z, float4(0.0).w);
    _484.w = (fract(dot(_467.xyx * _467.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _463 * View.View_PreExposure;
    out.out_var_SV_Target1 = _477;
    out.out_var_SV_Target2 = _481;
    out.out_var_SV_Target3 = _484;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_324, 1.0, 1.0, 1.0);
    return out;
}

