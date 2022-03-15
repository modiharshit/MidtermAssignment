

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

fragment MainPS_out Main_000037c4_54ba8836(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _200 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _149, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _205 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _210 = (_205.xyz / float3(_205.w)) - View.View_PreViewTranslation;
    float3 _218 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float _229 = (0.100000001490116119384765625 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _230 = in.in_var_PRIMITIVE_ID * 36u;
    uint _231 = _230 + 20u;
    float _280;
    float _281;
    float _282;
    float3 _283;
    float3 _284;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _231)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _249 = ((_200.xy / float2(_200.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _253 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _249, level(0.0));
        float4 _256 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _249, level(0.0));
        float4 _259 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _249, level(0.0));
        float _269 = _259.w;
        _280 = (_229 * _269) + _259.z;
        _281 = (0.5 * _269) + _259.y;
        _282 = _269 + _259.x;
        _283 = (float3(1.0) * _253.w) + _253.xyz;
        _284 = normalize((_218 * _256.w) + ((_256.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _280 = _229;
        _281 = 0.5;
        _282 = 1.0;
        _283 = float3(1.0);
        _284 = _218;
    }
    bool _294 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _300;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _230 + 18u)].w > 0.0) && _294)
    {
        _300 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _300 = 1.0;
    }
    float _347;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _231)].z > 0.0)
    {
        float3 _315 = fast::clamp((_210 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _326 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_315.x), int(_315.y), int(_315.z), 0).xyz), 0));
        _347 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_326.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_315 / float3(_326.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _347 = _300;
    }
    float3 _361 = ((_283 - (_283 * _282)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _368 = (mix(float3(0.07999999821186065673828125 * _281), _283, float3(_282)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _371 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _376;
    if (_371)
    {
        _376 = _361 + (_368 * 0.449999988079071044921875);
    }
    else
    {
        _376 = _361;
    }
    float3 _378 = select(_368, float3(0.0), bool3(_371));
    float3 _380 = float3(dot(_378, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _466;
    if (_294)
    {
        float4 _416 = _150;
        _416.y = (-0.48860299587249755859375) * _284.y;
        float4 _419 = _416;
        _419.z = 0.48860299587249755859375 * _284.z;
        float4 _422 = _419;
        _422.w = (-0.48860299587249755859375) * _284.x;
        float3 _423 = _284 * _284;
        float4 _426 = _147;
        _426.x = (1.09254801273345947265625 * _284.x) * _284.y;
        float4 _429 = _426;
        _429.y = ((-1.09254801273345947265625) * _284.y) * _284.z;
        float4 _434 = _429;
        _434.z = 0.3153919875621795654296875 * ((3.0 * _423.z) - 1.0);
        float4 _437 = _434;
        _437.w = ((-1.09254801273345947265625) * _284.x) * _284.z;
        float4 _441 = _422;
        _441.x = 0.886227548122406005859375;
        float3 _443 = _441.yzw * 2.094395160675048828125;
        float4 _444 = float4(_441.x, _443.x, _443.y, _443.z);
        float4 _445 = _437 * 0.785398185253143310546875;
        float _446 = (_423.x - _423.y) * 0.4290426075458526611328125;
        float3 _452 = float3(0.0);
        _452.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _444) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _445)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _446);
        float3 _458 = _452;
        _458.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _444) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _445)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _446);
        float3 _464 = _458;
        _464.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _444) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _445)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _446);
        _466 = fast::max(float3(0.0), _464);
    }
    else
    {
        _466 = float3(0.0);
    }
    float3 _469 = _466 * View.View_IndirectLightingColorScale;
    float3 _491 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _520;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _519;
        if (any(abs(_210 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _230 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _230 + 19u)].xyz + float3(1.0))))
        {
            _519 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_210, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _519 = _491;
        }
        _520 = _519;
    }
    else
    {
        _520 = _491;
    }
    float4 _527 = float4(((mix(float3(0.0), _376 + (_378 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_469 * _376) * fast::max(float3(1.0), ((((((_283 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_283 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_283 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _520) * 1.0, 0.0);
    float4 _534;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _533 = _527;
        _533.w = 0.0;
        _534 = _533;
    }
    else
    {
        _534 = _527;
    }
    float2 _538 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _546 = (_284 * 0.5) + float3(0.5);
    float4 _548 = float4(_546.x, _546.y, _546.z, float4(0.0).w);
    _548.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _231)].y;
    float4 _549 = float4(0.0);
    _549.x = _282;
    float4 _550 = _549;
    _550.y = _281;
    float4 _551 = _550;
    _551.z = _280;
    float4 _552 = _551;
    _552.w = 0.50588238239288330078125;
    float4 _564 = float4(_283.x, _283.y, _283.z, float4(0.0).w);
    _564.w = ((log2(((dot(_469, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_380 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_380 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_380 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_538.xyx * _538.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _534 * View.View_PreExposure;
    out.out_var_SV_Target1 = _548;
    out.out_var_SV_Target2 = _552;
    out.out_var_SV_Target3 = _564;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_347, 1.0, 1.0, 1.0);
    return out;
}

