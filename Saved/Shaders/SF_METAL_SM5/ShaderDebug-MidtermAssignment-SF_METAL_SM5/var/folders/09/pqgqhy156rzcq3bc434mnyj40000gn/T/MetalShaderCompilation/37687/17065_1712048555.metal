

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
    char _m14_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m16_pad[124];
    float View_ShowDecalsMask;
    char _m17_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m18_pad[48];
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
    char _m0_pad[64];
    float4 IndirectLightingCache_PointSkyBentNormal;
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

constant float4 _160 = {};
constant float3 _161 = {};
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

fragment MainPS_out Main_000042a9_660bc9ab(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _219 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _163, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _224 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _229 = (_224.xyz / float3(_224.w)) - View.View_PreViewTranslation;
    float3 _237 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _251 = fast::clamp(mix(float3(0.25), float3(0.569999992847442626953125, 0.3332314789295196533203125, 0.0342000015079975128173828125), float3(fast::min(fast::max(mix(-20.0, 20.0, in_var_TEXCOORD0[0].y), 0.0), 1.0))), float3(0.0), float3(1.0));
    float _255 = (0.20000000298023223876953125 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _256 = in.in_var_PRIMITIVE_ID * 36u;
    uint _257 = _256 + 20u;
    float _305;
    float _306;
    float _307;
    float3 _308;
    float3 _309;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _257)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _275 = ((_219.xy / float2(_219.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _279 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _275, level(0.0));
        float4 _282 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _275, level(0.0));
        float4 _285 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _275, level(0.0));
        float _295 = _285.w;
        _305 = (_255 * _295) + _285.z;
        _306 = (0.5 * _295) + _285.y;
        _307 = _285.x;
        _308 = (_251 * _279.w) + _279.xyz;
        _309 = normalize((_237 * _282.w) + ((_282.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _305 = _255;
        _306 = 0.5;
        _307 = 0.0;
        _308 = _251;
        _309 = _237;
    }
    bool _319 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _325;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _256 + 18u)].w > 0.0) && _319)
    {
        _325 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _325 = 1.0;
    }
    float _372;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _257)].z > 0.0)
    {
        float3 _340 = fast::clamp((_229 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _351 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_340.x), int(_340.y), int(_340.z), 0).xyz), 0));
        _372 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_351.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_340 / float3(_351.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _372 = _325;
    }
    float3 _386 = ((_308 - (_308 * _307)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _393 = (mix(float3(0.07999999821186065673828125 * _306), _308, float3(_307)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _396 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _401;
    if (_396)
    {
        _401 = _386 + (_393 * 0.449999988079071044921875);
    }
    else
    {
        _401 = _386;
    }
    float3 _403 = select(_393, float3(0.0), bool3(_396));
    float3 _405 = float3(dot(_403, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _491;
    if (_319)
    {
        float4 _441 = _164;
        _441.y = (-0.48860299587249755859375) * _309.y;
        float4 _444 = _441;
        _444.z = 0.48860299587249755859375 * _309.z;
        float4 _447 = _444;
        _447.w = (-0.48860299587249755859375) * _309.x;
        float3 _448 = _309 * _309;
        float4 _451 = _160;
        _451.x = (1.09254801273345947265625 * _309.x) * _309.y;
        float4 _454 = _451;
        _454.y = ((-1.09254801273345947265625) * _309.y) * _309.z;
        float4 _459 = _454;
        _459.z = 0.3153919875621795654296875 * ((3.0 * _448.z) - 1.0);
        float4 _462 = _459;
        _462.w = ((-1.09254801273345947265625) * _309.x) * _309.z;
        float4 _466 = _447;
        _466.x = 0.886227548122406005859375;
        float3 _468 = _466.yzw * 2.094395160675048828125;
        float4 _469 = float4(_466.x, _468.x, _468.y, _468.z);
        float4 _470 = _462 * 0.785398185253143310546875;
        float _471 = (_448.x - _448.y) * 0.4290426075458526611328125;
        float3 _477 = float3(0.0);
        _477.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _469) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _470)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _471);
        float3 _483 = _477;
        _483.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _469) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _470)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _471);
        float3 _489 = _483;
        _489.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _469) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _470)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _471);
        _491 = fast::max(float3(0.0), _489);
    }
    else
    {
        _491 = float3(0.0);
    }
    float _517;
    float _518;
    float3 _519;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _507;
        float _508;
        if (_319)
        {
            _507 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _508 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _507 = _309;
            _508 = 1.0;
        }
        float _509 = 1.0 - _508;
        float _511 = 1.0 - (_509 * _509);
        _517 = mix(fast::clamp(dot(_507, _309), 0.0, 1.0), 1.0, _511);
        _518 = _508;
        _519 = mix(_507, _309, float3(_511));
    }
    else
    {
        _517 = 1.0;
        _518 = 1.0;
        _519 = _309;
    }
    float4 _523 = float4(_519, 1.0);
    float3 _527 = _161;
    _527.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _523);
    float3 _531 = _527;
    _531.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _523);
    float3 _535 = _531;
    _535.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _523);
    float4 _538 = _523.xyzz * _523.yzzx;
    float3 _542 = _161;
    _542.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _538);
    float3 _546 = _542;
    _546.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _538);
    float3 _550 = _546;
    _550.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _538);
    float3 _565 = (_491 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_535 + _550) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_519.x * _519.x) - (_519.y * _519.y)))) * View.View_SkyLightColor.xyz) * (_518 * _517));
    float3 _587 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _616;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _615;
        if (any(abs(_229 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _256 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _256 + 19u)].xyz + float3(1.0))))
        {
            _615 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_229, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _615 = _587;
        }
        _616 = _615;
    }
    else
    {
        _616 = _587;
    }
    float4 _623 = float4(((mix(float3(0.0), _401 + (_403 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_565 * _401) * fast::max(float3(1.0), ((((((_308 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_308 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_308 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _616) * 1.0, 0.0);
    float4 _630;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _629 = _623;
        _629.w = 0.0;
        _630 = _629;
    }
    else
    {
        _630 = _623;
    }
    float2 _634 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _642 = (_309 * 0.5) + float3(0.5);
    float4 _644 = float4(_642.x, _642.y, _642.z, float4(0.0).w);
    _644.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _257)].y;
    float4 _645 = float4(0.0);
    _645.x = _307;
    float4 _646 = _645;
    _646.y = _306;
    float4 _647 = _646;
    _647.z = _305;
    float4 _648 = _647;
    _648.w = 0.50588238239288330078125;
    float4 _660 = float4(_308.x, _308.y, _308.z, float4(0.0).w);
    _660.w = ((log2(((dot(_565, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_405 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_405 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_405 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_634.xyx * _634.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _630 * View.View_PreExposure;
    out.out_var_SV_Target1 = _644;
    out.out_var_SV_Target2 = _648;
    out.out_var_SV_Target3 = _660;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_372, 1.0, 1.0, 1.0);
    return out;
}

