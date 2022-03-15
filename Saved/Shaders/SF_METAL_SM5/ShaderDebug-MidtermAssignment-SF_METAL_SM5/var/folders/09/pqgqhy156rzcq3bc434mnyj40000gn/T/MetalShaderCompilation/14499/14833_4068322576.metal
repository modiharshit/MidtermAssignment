

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
    char _m12_pad[376];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m13_pad[48];
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
    spvUnsafeArray<float4, 4> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _163 = {};
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

fragment MainPS_out Main_000039f1_f27dad10(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> Material_Texture2D_0 [[texture(2)]], texture2d<float> Material_Texture2D_1 [[texture(3)]], texture2d<float> Material_Texture2D_2 [[texture(4)]], texture2d<float> Material_Texture2D_3 [[texture(5)]], sampler View_MaterialTextureBilinearWrapedSampler [[sampler(0)]], sampler View_SharedBilinearClampedSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _203 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _208 = (_203.xyz / float3(_203.w)) - View.View_PreViewTranslation;
    float4 _214 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _217 = (_214.xy * float2(2.0)) - float2(1.0);
    float _221 = sqrt(fast::clamp(1.0 - dot(_217, _217), 0.0, 1.0));
    float3 _229 = float3(float4(_217, _221, 1.0).xy * (-1.0), _221);
    float3 _233 = (float3(0.0, 0.0, 2.0) * dot(float3(0.0, 0.0, 2.0), _229)) - (_229 * 2.0);
    float3 _245 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize(((_233 / float3(sqrt(dot(_233, _233)))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _249 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _267 = Material_Texture2D_2.sample(View_MaterialTextureBilinearWrapedSampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 50.0));
    float3 _271 = float3(_249.x);
    float4 _276 = Material_Texture2D_3.sample(View_MaterialTextureBilinearWrapedSampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 8.0));
    float3 _280 = float3(_249.z);
    float3 _283 = float3(_249.w);
    float3 _298 = fast::clamp(mix(mix(mix(mix(Material.Material_VectorExpressions[3].xyz, Material.Material_VectorExpressions[3].xyz, float3(_249.y)), _267.xyz * float3(0.2249999940395355224609375), _271), _276.xyz * float3(0.25), _280), float3(0.0), _283), float3(0.0), float3(1.0));
    float _299 = fast::clamp(mix(mix(float3(0.0), float3(1.0), _280), float3(0.0), _283).x, 0.0, 1.0);
    uint _305 = in.in_var_PRIMITIVE_ID * 36u;
    uint _306 = _305 + 20u;
    bool _317 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _323;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _305 + 18u)].w > 0.0) && _317)
    {
        _323 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _323 = 1.0;
    }
    float _370;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _306)].z > 0.0)
    {
        float3 _338 = fast::clamp((_208 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _349 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_338.x), int(_338.y), int(_338.z), 0).xyz), 0));
        _370 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_349.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_338 / float3(_349.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _370 = _323;
    }
    float3 _382 = ((_298 - (_298 * _299)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _389 = (mix(float3(0.039999999105930328369140625), _298, float3(_299)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _392 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _397;
    if (_392)
    {
        _397 = _382 + (_389 * 0.449999988079071044921875);
    }
    else
    {
        _397 = _382;
    }
    float3 _399 = select(_389, float3(0.0), bool3(_392));
    float3 _401 = float3(dot(_399, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _487;
    if (_317)
    {
        float _435 = _245.y;
        float4 _437 = _165;
        _437.y = (-0.48860299587249755859375) * _435;
        float _438 = _245.z;
        float4 _440 = _437;
        _440.z = 0.48860299587249755859375 * _438;
        float _441 = _245.x;
        float4 _443 = _440;
        _443.w = (-0.48860299587249755859375) * _441;
        float3 _444 = _245 * _245;
        float4 _447 = _163;
        _447.x = (1.09254801273345947265625 * _441) * _435;
        float4 _450 = _447;
        _450.y = ((-1.09254801273345947265625) * _435) * _438;
        float4 _455 = _450;
        _455.z = 0.3153919875621795654296875 * ((3.0 * _444.z) - 1.0);
        float4 _458 = _455;
        _458.w = ((-1.09254801273345947265625) * _441) * _438;
        float4 _462 = _443;
        _462.x = 0.886227548122406005859375;
        float3 _464 = _462.yzw * 2.094395160675048828125;
        float4 _465 = float4(_462.x, _464.x, _464.y, _464.z);
        float4 _466 = _458 * 0.785398185253143310546875;
        float _467 = (_444.x - _444.y) * 0.4290426075458526611328125;
        float3 _473 = float3(0.0);
        _473.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _465) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _466)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _467);
        float3 _479 = _473;
        _479.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _465) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _466)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _467);
        float3 _485 = _479;
        _485.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _465) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _466)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _467);
        _487 = fast::max(float3(0.0), _485);
    }
    else
    {
        _487 = float3(0.0);
    }
    float3 _490 = _487 * View.View_IndirectLightingColorScale;
    float3 _512 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _541;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _540;
        if (any(abs(_208 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _305 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _305 + 19u)].xyz + float3(1.0))))
        {
            _540 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_208, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _540 = _512;
        }
        _541 = _540;
    }
    else
    {
        _541 = _512;
    }
    float4 _548 = float4(((mix(float3(0.0), _397 + (_399 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_490 * _397) * fast::max(float3(1.0), ((((((_298 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_298 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_298 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _541) * 1.0, 0.0);
    float4 _555;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _554 = _548;
        _554.w = 0.0;
        _555 = _554;
    }
    else
    {
        _555 = _548;
    }
    float2 _560 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _568 = (_245 * 0.5) + float3(0.5);
    float4 _570 = float4(_568.x, _568.y, _568.z, float4(0.0).w);
    _570.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _306)].y;
    float4 _571 = float4(0.0);
    _571.x = _299;
    float4 _572 = _571;
    _572.y = 0.5;
    float4 _573 = _572;
    _573.z = (fast::clamp(mix(mix(mix(float3(0.100000001490116119384765625), float3(mix(0.550000011920928955078125, 0.75, _267.x)), _271), float3(mix(0.37999999523162841796875, 0.550000011920928955078125, _276.x)), _280), float3(0.100000001490116119384765625), _283).x, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float4 _574 = _573;
    _574.w = 0.50588238239288330078125;
    float4 _586 = float4(_298.x, _298.y, _298.z, float4(0.0).w);
    _586.w = ((log2(((dot(_490, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_401 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_401 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_401 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_560.xyx * _560.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _555 * View.View_PreExposure;
    out.out_var_SV_Target1 = _570;
    out.out_var_SV_Target2 = _574;
    out.out_var_SV_Target3 = _586;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_370, 1.0, 1.0, 1.0);
    return out;
}

