

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
    char _m11_pad[24];
    float View_CullingSign;
    char _m12_pad[52];
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
    float3 IndirectLightingCache_IndirectLightingCachePrimitiveAdd;
    float3 IndirectLightingCache_IndirectLightingCachePrimitiveScale;
    float3 IndirectLightingCache_IndirectLightingCacheMinUV;
    float3 IndirectLightingCache_IndirectLightingCacheMaxUV;
    char _m4_pad[16];
    float IndirectLightingCache_DirectionalLightShadowing;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float _146 = {};
constant float4 _147 = {};

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
    float4 in_var_COLOR0 [[user(locn2)]];
    uint in_var_PRIMITIVE_ID [[user(locn3)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_0000396e_4bf3b75b(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], float4 gl_FragCoord [[position]], bool gl_FrontFacing [[front_facing]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _203 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _146, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _208 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _213 = (_208.xyz / float3(_208.w)) - View.View_PreViewTranslation;
    uint _214 = in.in_var_PRIMITIVE_ID * 36u;
    float3 _230 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * ((View.View_CullingSign * View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _214 + 4u)].w) * float(gl_FrontFacing ? 1 : (-1)));
    float3 _239 = fast::clamp(in.in_var_COLOR0.xyz, float3(0.0), float3(1.0));
    float _243 = (0.5 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _244 = _214 + 20u;
    float _290;
    float _291;
    float _292;
    float3 _293;
    float3 _294;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _244)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _262 = ((_203.xy / float2(_203.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _266 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _262, level(0.0));
        float4 _269 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _262, level(0.0));
        float4 _272 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _262, level(0.0));
        _290 = (_243 * _272.w) + _272.z;
        _291 = _272.y;
        _292 = _272.x;
        _293 = (_239 * _266.w) + _266.xyz;
        _294 = normalize((_230 * _269.w) + ((_269.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _290 = _243;
        _291 = 0.0;
        _292 = 0.0;
        _293 = _239;
        _294 = _230;
    }
    bool _304 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _310;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _214 + 18u)].w > 0.0) && _304)
    {
        _310 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _310 = 1.0;
    }
    float _357;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _244)].z > 0.0)
    {
        float3 _325 = fast::clamp((_213 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _336 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_325.x), int(_325.y), int(_325.z), 0).xyz), 0));
        _357 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_336.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_325 / float3(_336.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _357 = _310;
    }
    float3 _371 = ((_293 - (_293 * _292)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _378 = (mix(float3(0.07999999821186065673828125 * _291), _293, float3(_292)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _381 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _386;
    if (_381)
    {
        _386 = _371 + (_378 * 0.449999988079071044921875);
    }
    else
    {
        _386 = _371;
    }
    float3 _388 = select(_378, float3(0.0), bool3(_381));
    float3 _390 = float3(dot(_388, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _464;
    if (_304)
    {
        float3 _416 = fast::clamp((_213 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _420 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _416);
        float4 _424 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _416);
        float4 _427 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _416);
        float4 _445 = _147;
        _445.y = (-0.48860299587249755859375) * _294.y;
        float4 _448 = _445;
        _448.z = 0.48860299587249755859375 * _294.z;
        float4 _451 = _448;
        _451.w = (-0.48860299587249755859375) * _294.x;
        float4 _452 = _451;
        _452.x = 0.886227548122406005859375;
        float3 _454 = _452.yzw * 2.094395160675048828125;
        float4 _455 = float4(_452.x, _454.x, _454.y, _454.z);
        float3 _457 = float3(0.0);
        _457.x = dot(float4(_420.x, _424.x, _427.x, _420.w), _455);
        float3 _459 = _457;
        _459.y = dot(float4(_420.y, _424.y, _427.y, _424.w), _455);
        float3 _461 = _459;
        _461.z = dot(float4(_420.z, _424.z, _427.zw), _455);
        _464 = fast::max(float3(0.0), _461) * float3(0.3183098733425140380859375);
    }
    else
    {
        _464 = float3(0.0);
    }
    float3 _467 = _464 * View.View_IndirectLightingColorScale;
    float3 _489 = fast::max(mix(in.in_var_COLOR0.xyz, Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _518;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _517;
        if (any(abs(_213 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _214 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _214 + 19u)].xyz + float3(1.0))))
        {
            _517 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_213, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _517 = _489;
        }
        _518 = _517;
    }
    else
    {
        _518 = _489;
    }
    float4 _525 = float4(((mix(float3(0.0), _386 + (_388 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_467 * _386) * fast::max(float3(1.0), ((((((_293 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_293 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_293 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _518) * 1.0, 0.0);
    float4 _532;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _531 = _525;
        _531.w = 0.0;
        _532 = _531;
    }
    else
    {
        _532 = _525;
    }
    float2 _536 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _544 = (_294 * 0.5) + float3(0.5);
    float4 _546 = float4(_544.x, _544.y, _544.z, float4(0.0).w);
    _546.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _244)].y;
    float4 _547 = float4(0.0);
    _547.x = _292;
    float4 _548 = _547;
    _548.y = _291;
    float4 _549 = _548;
    _549.z = _290;
    float4 _550 = _549;
    _550.w = 0.50588238239288330078125;
    float4 _562 = float4(_293.x, _293.y, _293.z, float4(0.0).w);
    _562.w = ((log2(((dot(_467, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_390 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_390 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_390 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_536.xyx * _536.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _532 * View.View_PreExposure;
    out.out_var_SV_Target1 = _546;
    out.out_var_SV_Target2 = _550;
    out.out_var_SV_Target3 = _562;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_357, 1.0, 1.0, 1.0);
    return out;
}

