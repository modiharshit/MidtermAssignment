

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
    float3 IndirectLightingCache_IndirectLightingCachePrimitiveAdd;
    float3 IndirectLightingCache_IndirectLightingCachePrimitiveScale;
    float3 IndirectLightingCache_IndirectLightingCacheMinUV;
    float3 IndirectLightingCache_IndirectLightingCacheMaxUV;
    float4 IndirectLightingCache_PointSkyBentNormal;
    float IndirectLightingCache_DirectionalLightShadowing;
};

struct type_Material
{
    spvUnsafeArray<float4, 4> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float3 _163 = {};
constant float4 _165 = {};

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

fragment MainPS_out Main_0000437c_b913c68b(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(2)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(3)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler View_MaterialTextureBilinearWrapedSampler [[sampler(0)]], sampler View_SharedBilinearClampedSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _204 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _209 = (_204.xyz / float3(_204.w)) - View.View_PreViewTranslation;
    float4 _215 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _218 = (_215.xy * float2(2.0)) - float2(1.0);
    float _222 = sqrt(fast::clamp(1.0 - dot(_218, _218), 0.0, 1.0));
    float3 _230 = float3(float4(_218, _222, 1.0).xy * (-1.0), _222);
    float3 _234 = (float3(0.0, 0.0, 2.0) * dot(float3(0.0, 0.0, 2.0), _230)) - (_230 * 2.0);
    float3 _246 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize(((_234 / float3(sqrt(dot(_234, _234)))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _250 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _268 = Material_Texture2D_2.sample(View_MaterialTextureBilinearWrapedSampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 50.0));
    float3 _272 = float3(_250.x);
    float4 _277 = Material_Texture2D_3.sample(View_MaterialTextureBilinearWrapedSampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 8.0));
    float3 _281 = float3(_250.z);
    float3 _284 = float3(_250.w);
    float3 _299 = fast::clamp(mix(mix(mix(mix(Material.Material_VectorExpressions[3].xyz, Material.Material_VectorExpressions[3].xyz, float3(_250.y)), _268.xyz * float3(0.2249999940395355224609375), _272), _277.xyz * float3(0.25), _281), float3(0.0), _284), float3(0.0), float3(1.0));
    float _300 = fast::clamp(mix(mix(float3(0.0), float3(1.0), _281), float3(0.0), _284).x, 0.0, 1.0);
    uint _306 = in.in_var_PRIMITIVE_ID * 36u;
    uint _307 = _306 + 20u;
    bool _318 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _324;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _306 + 18u)].w > 0.0) && _318)
    {
        _324 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _324 = 1.0;
    }
    float _371;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _307)].z > 0.0)
    {
        float3 _339 = fast::clamp((_209 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _350 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_339.x), int(_339.y), int(_339.z), 0).xyz), 0));
        _371 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_350.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_339 / float3(_350.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _371 = _324;
    }
    float3 _383 = ((_299 - (_299 * _300)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _390 = (mix(float3(0.039999999105930328369140625), _299, float3(_300)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _393 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _398;
    if (_393)
    {
        _398 = _383 + (_390 * 0.449999988079071044921875);
    }
    else
    {
        _398 = _383;
    }
    float3 _400 = select(_390, float3(0.0), bool3(_393));
    float3 _402 = float3(dot(_400, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _476;
    if (_318)
    {
        float3 _428 = fast::clamp((_209 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _432 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _428);
        float4 _436 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _428);
        float4 _439 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _428);
        float4 _457 = _165;
        _457.y = (-0.48860299587249755859375) * _246.y;
        float4 _460 = _457;
        _460.z = 0.48860299587249755859375 * _246.z;
        float4 _463 = _460;
        _463.w = (-0.48860299587249755859375) * _246.x;
        float4 _464 = _463;
        _464.x = 0.886227548122406005859375;
        float3 _466 = _464.yzw * 2.094395160675048828125;
        float4 _467 = float4(_464.x, _466.x, _466.y, _466.z);
        float3 _469 = float3(0.0);
        _469.x = dot(float4(_432.x, _436.x, _439.x, _432.w), _467);
        float3 _471 = _469;
        _471.y = dot(float4(_432.y, _436.y, _439.y, _436.w), _467);
        float3 _473 = _471;
        _473.z = dot(float4(_432.z, _436.z, _439.zw), _467);
        _476 = fast::max(float3(0.0), _473) * float3(0.3183098733425140380859375);
    }
    else
    {
        _476 = float3(0.0);
    }
    float _502;
    float _503;
    float3 _504;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _492;
        float _493;
        if (_318)
        {
            _492 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _493 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _492 = _246;
            _493 = 1.0;
        }
        float _494 = 1.0 - _493;
        float _496 = 1.0 - (_494 * _494);
        _502 = mix(fast::clamp(dot(_492, _246), 0.0, 1.0), 1.0, _496);
        _503 = _493;
        _504 = mix(_492, _246, float3(_496));
    }
    else
    {
        _502 = 1.0;
        _503 = 1.0;
        _504 = _246;
    }
    float4 _508 = float4(_504, 1.0);
    float3 _512 = _163;
    _512.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _508);
    float3 _516 = _512;
    _516.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _508);
    float3 _520 = _516;
    _520.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _508);
    float4 _523 = _508.xyzz * _508.yzzx;
    float3 _527 = _163;
    _527.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _523);
    float3 _531 = _527;
    _531.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _523);
    float3 _535 = _531;
    _535.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _523);
    float3 _550 = (_476 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_520 + _535) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_504.x * _504.x) - (_504.y * _504.y)))) * View.View_SkyLightColor.xyz) * (_503 * _502));
    float3 _572 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _601;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _600;
        if (any(abs(_209 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _306 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _306 + 19u)].xyz + float3(1.0))))
        {
            _600 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_209, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _600 = _572;
        }
        _601 = _600;
    }
    else
    {
        _601 = _572;
    }
    float4 _608 = float4(((mix(float3(0.0), _398 + (_400 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_550 * _398) * fast::max(float3(1.0), ((((((_299 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_299 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_299 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _601) * 1.0, 0.0);
    float4 _615;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _614 = _608;
        _614.w = 0.0;
        _615 = _614;
    }
    else
    {
        _615 = _608;
    }
    float2 _620 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _628 = (_246 * 0.5) + float3(0.5);
    float4 _630 = float4(_628.x, _628.y, _628.z, float4(0.0).w);
    _630.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _307)].y;
    float4 _631 = float4(0.0);
    _631.x = _300;
    float4 _632 = _631;
    _632.y = 0.5;
    float4 _633 = _632;
    _633.z = (fast::clamp(mix(mix(mix(float3(0.100000001490116119384765625), float3(mix(0.550000011920928955078125, 0.75, _268.x)), _272), float3(mix(0.37999999523162841796875, 0.550000011920928955078125, _277.x)), _281), float3(0.100000001490116119384765625), _284).x, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float4 _634 = _633;
    _634.w = 0.50588238239288330078125;
    float4 _646 = float4(_299.x, _299.y, _299.z, float4(0.0).w);
    _646.w = ((log2(((dot(_550, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_402 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_402 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_402 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_620.xyx * _620.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _615 * View.View_PreExposure;
    out.out_var_SV_Target1 = _630;
    out.out_var_SV_Target2 = _634;
    out.out_var_SV_Target3 = _646;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_371, 1.0, 1.0, 1.0);
    return out;
}

