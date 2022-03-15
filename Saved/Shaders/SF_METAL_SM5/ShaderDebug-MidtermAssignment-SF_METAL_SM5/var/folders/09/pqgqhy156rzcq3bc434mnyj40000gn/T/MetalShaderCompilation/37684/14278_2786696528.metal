

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

constant float4 _147 = {};
constant float _149 = {};
constant float4 _150 = {};

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

fragment MainPS_out Main_000037c6_a6199d50(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _200 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _149, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _205 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _210 = (_205.xyz / float3(_205.w)) - View.View_PreViewTranslation;
    float3 _218 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float _229 = (0.20000000298023223876953125 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _230 = in.in_var_PRIMITIVE_ID * 36u;
    uint _231 = _230 + 20u;
    float _279;
    float _280;
    float _281;
    float3 _282;
    float3 _283;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _231)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _249 = ((_200.xy / float2(_200.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _253 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _249, level(0.0));
        float4 _256 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _249, level(0.0));
        float4 _259 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _249, level(0.0));
        float _269 = _259.w;
        _279 = (_229 * _269) + _259.z;
        _280 = (0.5 * _269) + _259.y;
        _281 = _259.x;
        _282 = (float3(0.5) * _253.w) + _253.xyz;
        _283 = normalize((_218 * _256.w) + ((_256.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _279 = _229;
        _280 = 0.5;
        _281 = 0.0;
        _282 = float3(0.5);
        _283 = _218;
    }
    bool _293 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _299;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _230 + 18u)].w > 0.0) && _293)
    {
        _299 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _299 = 1.0;
    }
    float _346;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _231)].z > 0.0)
    {
        float3 _314 = fast::clamp((_210 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _325 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_314.x), int(_314.y), int(_314.z), 0).xyz), 0));
        _346 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_325.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_314 / float3(_325.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _346 = _299;
    }
    float3 _360 = ((_282 - (_282 * _281)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _367 = (mix(float3(0.07999999821186065673828125 * _280), _282, float3(_281)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _370 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _375;
    if (_370)
    {
        _375 = _360 + (_367 * 0.449999988079071044921875);
    }
    else
    {
        _375 = _360;
    }
    float3 _377 = select(_367, float3(0.0), bool3(_370));
    float3 _379 = float3(dot(_377, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _465;
    if (_293)
    {
        float4 _415 = _150;
        _415.y = (-0.48860299587249755859375) * _283.y;
        float4 _418 = _415;
        _418.z = 0.48860299587249755859375 * _283.z;
        float4 _421 = _418;
        _421.w = (-0.48860299587249755859375) * _283.x;
        float3 _422 = _283 * _283;
        float4 _425 = _147;
        _425.x = (1.09254801273345947265625 * _283.x) * _283.y;
        float4 _428 = _425;
        _428.y = ((-1.09254801273345947265625) * _283.y) * _283.z;
        float4 _433 = _428;
        _433.z = 0.3153919875621795654296875 * ((3.0 * _422.z) - 1.0);
        float4 _436 = _433;
        _436.w = ((-1.09254801273345947265625) * _283.x) * _283.z;
        float4 _440 = _421;
        _440.x = 0.886227548122406005859375;
        float3 _442 = _440.yzw * 2.094395160675048828125;
        float4 _443 = float4(_440.x, _442.x, _442.y, _442.z);
        float4 _444 = _436 * 0.785398185253143310546875;
        float _445 = (_422.x - _422.y) * 0.4290426075458526611328125;
        float3 _451 = float3(0.0);
        _451.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _443) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _444)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _445);
        float3 _457 = _451;
        _457.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _443) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _444)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _445);
        float3 _463 = _457;
        _463.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _443) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _444)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _445);
        _465 = fast::max(float3(0.0), _463);
    }
    else
    {
        _465 = float3(0.0);
    }
    float3 _468 = _465 * View.View_IndirectLightingColorScale;
    float3 _490 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _519;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _518;
        if (any(abs(_210 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _230 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _230 + 19u)].xyz + float3(1.0))))
        {
            _518 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_210, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _518 = _490;
        }
        _519 = _518;
    }
    else
    {
        _519 = _490;
    }
    float4 _526 = float4(((mix(float3(0.0), _375 + (_377 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_468 * _375) * fast::max(float3(1.0), ((((((_282 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_282 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_282 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _519) * 1.0, 0.0);
    float4 _533;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _532 = _526;
        _532.w = 0.0;
        _533 = _532;
    }
    else
    {
        _533 = _526;
    }
    float2 _537 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _545 = (_283 * 0.5) + float3(0.5);
    float4 _547 = float4(_545.x, _545.y, _545.z, float4(0.0).w);
    _547.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _231)].y;
    float4 _548 = float4(0.0);
    _548.x = _281;
    float4 _549 = _548;
    _549.y = _280;
    float4 _550 = _549;
    _550.z = _279;
    float4 _551 = _550;
    _551.w = 0.50588238239288330078125;
    float4 _563 = float4(_282.x, _282.y, _282.z, float4(0.0).w);
    _563.w = ((log2(((dot(_468, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_379 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_379 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_379 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_537.xyx * _537.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _533 * View.View_PreExposure;
    out.out_var_SV_Target1 = _547;
    out.out_var_SV_Target2 = _551;
    out.out_var_SV_Target3 = _563;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_346, 1.0, 1.0, 1.0);
    return out;
}

