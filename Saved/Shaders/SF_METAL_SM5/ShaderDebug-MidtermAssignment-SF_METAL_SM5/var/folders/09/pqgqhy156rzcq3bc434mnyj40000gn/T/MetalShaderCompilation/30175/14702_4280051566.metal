

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

constant float4 _149 = {};
constant float _151 = {};
constant float4 _152 = {};

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

fragment MainPS_out Main_0000396e_ff1c676e(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float2 _197 = (gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw;
    float4 _203 = float4((_197 - float2(0.5)) * float2(2.0, -2.0), _151, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _208 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _213 = (_208.xyz / float3(_208.w)) - View.View_PreViewTranslation;
    float3 _221 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _228 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (_197 * 4.0), bias(View.View_MaterialTextureMipBias));
    float3 _229 = _228.xyz;
    float3 _237 = fast::clamp(_229, float3(0.0), float3(1.0));
    float _241 = (0.5 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _242 = in.in_var_PRIMITIVE_ID * 36u;
    uint _243 = _242 + 20u;
    float _291;
    float _292;
    float _293;
    float3 _294;
    float3 _295;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _243)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _261 = ((_203.xy / float2(_203.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _265 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _261, level(0.0));
        float4 _268 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _261, level(0.0));
        float4 _271 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _261, level(0.0));
        float _281 = _271.w;
        _291 = (_241 * _281) + _271.z;
        _292 = (0.5 * _281) + _271.y;
        _293 = _271.x;
        _294 = (_237 * _265.w) + _265.xyz;
        _295 = normalize((_221 * _268.w) + ((_268.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _291 = _241;
        _292 = 0.5;
        _293 = 0.0;
        _294 = _237;
        _295 = _221;
    }
    bool _305 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _311;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _242 + 18u)].w > 0.0) && _305)
    {
        _311 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _311 = 1.0;
    }
    float _358;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _243)].z > 0.0)
    {
        float3 _326 = fast::clamp((_213 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _337 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_326.x), int(_326.y), int(_326.z), 0).xyz), 0));
        _358 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_337.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_326 / float3(_337.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _358 = _311;
    }
    float3 _372 = ((_294 - (_294 * _293)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _379 = (mix(float3(0.07999999821186065673828125 * _292), _294, float3(_293)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _382 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _387;
    if (_382)
    {
        _387 = _372 + (_379 * 0.449999988079071044921875);
    }
    else
    {
        _387 = _372;
    }
    float3 _389 = select(_379, float3(0.0), bool3(_382));
    float3 _391 = float3(dot(_389, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _477;
    if (_305)
    {
        float4 _427 = _152;
        _427.y = (-0.48860299587249755859375) * _295.y;
        float4 _430 = _427;
        _430.z = 0.48860299587249755859375 * _295.z;
        float4 _433 = _430;
        _433.w = (-0.48860299587249755859375) * _295.x;
        float3 _434 = _295 * _295;
        float4 _437 = _149;
        _437.x = (1.09254801273345947265625 * _295.x) * _295.y;
        float4 _440 = _437;
        _440.y = ((-1.09254801273345947265625) * _295.y) * _295.z;
        float4 _445 = _440;
        _445.z = 0.3153919875621795654296875 * ((3.0 * _434.z) - 1.0);
        float4 _448 = _445;
        _448.w = ((-1.09254801273345947265625) * _295.x) * _295.z;
        float4 _452 = _433;
        _452.x = 0.886227548122406005859375;
        float3 _454 = _452.yzw * 2.094395160675048828125;
        float4 _455 = float4(_452.x, _454.x, _454.y, _454.z);
        float4 _456 = _448 * 0.785398185253143310546875;
        float _457 = (_434.x - _434.y) * 0.4290426075458526611328125;
        float3 _463 = float3(0.0);
        _463.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _455) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _456)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _457);
        float3 _469 = _463;
        _469.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _455) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _456)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _457);
        float3 _475 = _469;
        _475.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _455) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _456)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _457);
        _477 = fast::max(float3(0.0), _475);
    }
    else
    {
        _477 = float3(0.0);
    }
    float3 _480 = _477 * View.View_IndirectLightingColorScale;
    float3 _502 = fast::max(mix(_229, Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _531;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _530;
        if (any(abs(_213 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _242 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _242 + 19u)].xyz + float3(1.0))))
        {
            _530 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_213, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _530 = _502;
        }
        _531 = _530;
    }
    else
    {
        _531 = _502;
    }
    float4 _538 = float4(((mix(float3(0.0), _387 + (_389 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_480 * _387) * fast::max(float3(1.0), ((((((_294 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_294 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_294 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _531) * 1.0, 0.0);
    float4 _545;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _544 = _538;
        _544.w = 0.0;
        _545 = _544;
    }
    else
    {
        _545 = _538;
    }
    float2 _549 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _557 = (_295 * 0.5) + float3(0.5);
    float4 _559 = float4(_557.x, _557.y, _557.z, float4(0.0).w);
    _559.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _243)].y;
    float4 _560 = float4(0.0);
    _560.x = _293;
    float4 _561 = _560;
    _561.y = _292;
    float4 _562 = _561;
    _562.z = _291;
    float4 _563 = _562;
    _563.w = 0.50588238239288330078125;
    float4 _575 = float4(_294.x, _294.y, _294.z, float4(0.0).w);
    _575.w = ((log2(((dot(_480, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_391 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_391 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_391 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_549.xyx * _549.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _545 * View.View_PreExposure;
    out.out_var_SV_Target1 = _559;
    out.out_var_SV_Target2 = _563;
    out.out_var_SV_Target3 = _575;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_358, 1.0, 1.0, 1.0);
    return out;
}

