

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

fragment MainPS_out Main_0000398b_38429bf8(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> Material_Texture2D_0 [[texture(2)]], texture2d<float> Material_Texture2D_1 [[texture(3)]], texture2d<float> Material_Texture2D_2 [[texture(4)]], texture2d<float> Material_Texture2D_3 [[texture(5)]], sampler View_MaterialTextureBilinearWrapedSampler [[sampler(0)]], sampler View_SharedBilinearClampedSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
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
    float4 _267 = Material_Texture2D_2.sample(View_MaterialTextureBilinearWrapedSampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 8.0));
    float3 _271 = float3(_249.x);
    float4 _276 = Material_Texture2D_3.sample(View_MaterialTextureBilinearWrapedSampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 50.0));
    float3 _280 = float3(_249.z);
    float3 _294 = fast::clamp(mix(mix(mix(Material.Material_VectorExpressions[3].xyz, Material.Material_VectorExpressions[3].xyz, float3(_249.y)), _267.xyz * float3(0.25), _271), _276.xyz * float3(0.2249999940395355224609375), _280), float3(0.0), float3(1.0));
    float _295 = fast::clamp(mix(mix(float3(0.0), float3(1.0), _271), float3(0.0), _280).x, 0.0, 1.0);
    uint _301 = in.in_var_PRIMITIVE_ID * 36u;
    uint _302 = _301 + 20u;
    bool _313 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _319;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _301 + 18u)].w > 0.0) && _313)
    {
        _319 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _319 = 1.0;
    }
    float _366;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _302)].z > 0.0)
    {
        float3 _334 = fast::clamp((_208 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _345 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_334.x), int(_334.y), int(_334.z), 0).xyz), 0));
        _366 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_345.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_334 / float3(_345.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _366 = _319;
    }
    float3 _378 = ((_294 - (_294 * _295)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _385 = (mix(float3(0.039999999105930328369140625), _294, float3(_295)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _388 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _393;
    if (_388)
    {
        _393 = _378 + (_385 * 0.449999988079071044921875);
    }
    else
    {
        _393 = _378;
    }
    float3 _395 = select(_385, float3(0.0), bool3(_388));
    float3 _397 = float3(dot(_395, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _483;
    if (_313)
    {
        float _431 = _245.y;
        float4 _433 = _165;
        _433.y = (-0.48860299587249755859375) * _431;
        float _434 = _245.z;
        float4 _436 = _433;
        _436.z = 0.48860299587249755859375 * _434;
        float _437 = _245.x;
        float4 _439 = _436;
        _439.w = (-0.48860299587249755859375) * _437;
        float3 _440 = _245 * _245;
        float4 _443 = _163;
        _443.x = (1.09254801273345947265625 * _437) * _431;
        float4 _446 = _443;
        _446.y = ((-1.09254801273345947265625) * _431) * _434;
        float4 _451 = _446;
        _451.z = 0.3153919875621795654296875 * ((3.0 * _440.z) - 1.0);
        float4 _454 = _451;
        _454.w = ((-1.09254801273345947265625) * _437) * _434;
        float4 _458 = _439;
        _458.x = 0.886227548122406005859375;
        float3 _460 = _458.yzw * 2.094395160675048828125;
        float4 _461 = float4(_458.x, _460.x, _460.y, _460.z);
        float4 _462 = _454 * 0.785398185253143310546875;
        float _463 = (_440.x - _440.y) * 0.4290426075458526611328125;
        float3 _469 = float3(0.0);
        _469.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _461) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _462)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _463);
        float3 _475 = _469;
        _475.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _461) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _462)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _463);
        float3 _481 = _475;
        _481.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _461) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _462)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _463);
        _483 = fast::max(float3(0.0), _481);
    }
    else
    {
        _483 = float3(0.0);
    }
    float3 _486 = _483 * View.View_IndirectLightingColorScale;
    float3 _508 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _537;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _536;
        if (any(abs(_208 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _301 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _301 + 19u)].xyz + float3(1.0))))
        {
            _536 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_208, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _536 = _508;
        }
        _537 = _536;
    }
    else
    {
        _537 = _508;
    }
    float4 _544 = float4(((mix(float3(0.0), _393 + (_395 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_486 * _393) * fast::max(float3(1.0), ((((((_294 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_294 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_294 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _537) * 1.0, 0.0);
    float4 _551;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _550 = _544;
        _550.w = 0.0;
        _551 = _550;
    }
    else
    {
        _551 = _544;
    }
    float2 _556 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _564 = (_245 * 0.5) + float3(0.5);
    float4 _566 = float4(_564.x, _564.y, _564.z, float4(0.0).w);
    _566.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _302)].y;
    float4 _567 = float4(0.0);
    _567.x = _295;
    float4 _568 = _567;
    _568.y = 0.5;
    float4 _569 = _568;
    _569.z = (fast::clamp(mix(mix(float3(0.100000001490116119384765625), float3(mix(0.37999999523162841796875, 0.550000011920928955078125, _267.x)), _271), float3(mix(0.550000011920928955078125, 0.75, _276.x)), _280).x, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float4 _570 = _569;
    _570.w = 0.50588238239288330078125;
    float4 _582 = float4(_294.x, _294.y, _294.z, float4(0.0).w);
    _582.w = ((log2(((dot(_486, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_397 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_397 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_397 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_556.xyx * _556.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _551 * View.View_PreExposure;
    out.out_var_SV_Target1 = _566;
    out.out_var_SV_Target2 = _570;
    out.out_var_SV_Target3 = _582;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_366, 1.0, 1.0, 1.0);
    return out;
}

