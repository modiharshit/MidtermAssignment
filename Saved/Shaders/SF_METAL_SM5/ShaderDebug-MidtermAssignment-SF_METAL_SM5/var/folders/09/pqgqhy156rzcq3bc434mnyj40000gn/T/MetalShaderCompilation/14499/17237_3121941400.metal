

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
    char _m1_pad[352];
    float3 View_PreViewTranslation;
    char _m2_pad[1028];
    float View_PreExposure;
    float4 View_DiffuseOverrideParameter;
    float4 View_SpecularOverrideParameter;
    float4 View_NormalOverrideParameter;
    float2 View_RoughnessOverrideParameter;
    char _m7_pad[8];
    float View_OutOfBoundsMask;
    char _m8_pad[48];
    float View_MaterialTextureMipBias;
    char _m9_pad[28];
    float View_UnlitViewmodeMask;
    char _m10_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m11_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m12_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m14_pad[312];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m15_pad[48];
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
    spvUnsafeArray<float4, 4> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _165 = {};
constant float3 _166 = {};
constant float4 _168 = {};

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

fragment MainPS_out Main_00004355_ba150b98(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> Material_Texture2D_0 [[texture(2)]], texture2d<float> Material_Texture2D_1 [[texture(3)]], texture2d<float> Material_Texture2D_2 [[texture(4)]], texture2d<float> Material_Texture2D_3 [[texture(5)]], sampler View_MaterialTextureBilinearWrapedSampler [[sampler(0)]], sampler View_SharedBilinearClampedSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _207 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _212 = (_207.xyz / float3(_207.w)) - View.View_PreViewTranslation;
    float4 _218 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _221 = (_218.xy * float2(2.0)) - float2(1.0);
    float _225 = sqrt(fast::clamp(1.0 - dot(_221, _221), 0.0, 1.0));
    float3 _233 = float3(float4(_221, _225, 1.0).xy * (-1.0), _225);
    float3 _237 = (float3(0.0, 0.0, 2.0) * dot(float3(0.0, 0.0, 2.0), _233)) - (_233 * 2.0);
    float3 _249 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize(((_237 / float3(sqrt(dot(_237, _237)))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _253 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _271 = Material_Texture2D_2.sample(View_MaterialTextureBilinearWrapedSampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 50.0));
    float3 _275 = float3(_253.x);
    float4 _280 = Material_Texture2D_3.sample(View_MaterialTextureBilinearWrapedSampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 8.0));
    float3 _284 = float3(_253.z);
    float3 _287 = float3(_253.w);
    float3 _302 = fast::clamp(mix(mix(mix(mix(Material.Material_VectorExpressions[3].xyz, Material.Material_VectorExpressions[3].xyz, float3(_253.y)), _271.xyz * float3(0.2249999940395355224609375), _275), _280.xyz * float3(0.25), _284), float3(0.0), _287), float3(0.0), float3(1.0));
    float _303 = fast::clamp(mix(mix(float3(0.0), float3(1.0), _284), float3(0.0), _287).x, 0.0, 1.0);
    uint _309 = in.in_var_PRIMITIVE_ID * 36u;
    uint _310 = _309 + 20u;
    bool _321 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _327;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _309 + 18u)].w > 0.0) && _321)
    {
        _327 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _327 = 1.0;
    }
    float _374;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _310)].z > 0.0)
    {
        float3 _342 = fast::clamp((_212 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _353 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_342.x), int(_342.y), int(_342.z), 0).xyz), 0));
        _374 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_353.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_342 / float3(_353.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _374 = _327;
    }
    float3 _386 = ((_302 - (_302 * _303)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _393 = (mix(float3(0.039999999105930328369140625), _302, float3(_303)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
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
    if (_321)
    {
        float _439 = _249.y;
        float4 _441 = _168;
        _441.y = (-0.48860299587249755859375) * _439;
        float _442 = _249.z;
        float4 _444 = _441;
        _444.z = 0.48860299587249755859375 * _442;
        float _445 = _249.x;
        float4 _447 = _444;
        _447.w = (-0.48860299587249755859375) * _445;
        float3 _448 = _249 * _249;
        float4 _451 = _165;
        _451.x = (1.09254801273345947265625 * _445) * _439;
        float4 _454 = _451;
        _454.y = ((-1.09254801273345947265625) * _439) * _442;
        float4 _459 = _454;
        _459.z = 0.3153919875621795654296875 * ((3.0 * _448.z) - 1.0);
        float4 _462 = _459;
        _462.w = ((-1.09254801273345947265625) * _445) * _442;
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
        if (_321)
        {
            _507 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _508 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _507 = _249;
            _508 = 1.0;
        }
        float _509 = 1.0 - _508;
        float _511 = 1.0 - (_509 * _509);
        _517 = mix(fast::clamp(dot(_507, _249), 0.0, 1.0), 1.0, _511);
        _518 = _508;
        _519 = mix(_507, _249, float3(_511));
    }
    else
    {
        _517 = 1.0;
        _518 = 1.0;
        _519 = _249;
    }
    float4 _523 = float4(_519, 1.0);
    float3 _527 = _166;
    _527.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _523);
    float3 _531 = _527;
    _531.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _523);
    float3 _535 = _531;
    _535.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _523);
    float4 _538 = _523.xyzz * _523.yzzx;
    float3 _542 = _166;
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
        if (any(abs(_212 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _309 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _309 + 19u)].xyz + float3(1.0))))
        {
            _615 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_212, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
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
    float4 _623 = float4(((mix(float3(0.0), _401 + (_403 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_565 * _401) * fast::max(float3(1.0), ((((((_302 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_302 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_302 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _616) * 1.0, 0.0);
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
    float2 _635 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _643 = (_249 * 0.5) + float3(0.5);
    float4 _645 = float4(_643.x, _643.y, _643.z, float4(0.0).w);
    _645.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _310)].y;
    float4 _646 = float4(0.0);
    _646.x = _303;
    float4 _647 = _646;
    _647.y = 0.5;
    float4 _648 = _647;
    _648.z = (fast::clamp(mix(mix(mix(float3(0.100000001490116119384765625), float3(mix(0.550000011920928955078125, 0.75, _271.x)), _275), float3(mix(0.37999999523162841796875, 0.550000011920928955078125, _280.x)), _284), float3(0.100000001490116119384765625), _287).x, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float4 _649 = _648;
    _649.w = 0.50588238239288330078125;
    float4 _661 = float4(_302.x, _302.y, _302.z, float4(0.0).w);
    _661.w = ((log2(((dot(_565, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_405 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_405 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_405 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_635.xyx * _635.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _630 * View.View_PreExposure;
    out.out_var_SV_Target1 = _645;
    out.out_var_SV_Target2 = _649;
    out.out_var_SV_Target3 = _661;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_374, 1.0, 1.0, 1.0);
    return out;
}

