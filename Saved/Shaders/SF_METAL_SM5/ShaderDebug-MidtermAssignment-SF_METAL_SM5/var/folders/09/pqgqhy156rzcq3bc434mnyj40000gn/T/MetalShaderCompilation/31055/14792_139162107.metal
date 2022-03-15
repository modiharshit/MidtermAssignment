

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
    float3 IndirectLightingCache_IndirectLightingCachePrimitiveAdd;
    float3 IndirectLightingCache_IndirectLightingCachePrimitiveScale;
    float3 IndirectLightingCache_IndirectLightingCacheMinUV;
    float3 IndirectLightingCache_IndirectLightingCacheMaxUV;
    char _m4_pad[16];
    float IndirectLightingCache_DirectionalLightShadowing;
};

struct type_Material
{
    spvUnsafeArray<float4, 4> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _161 = {};

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

fragment MainPS_out Main_000039c8_084b71fb(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(2)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(3)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler View_MaterialTextureBilinearWrapedSampler [[sampler(0)]], sampler View_SharedBilinearClampedSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _200 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _205 = (_200.xyz / float3(_200.w)) - View.View_PreViewTranslation;
    float4 _211 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _214 = (_211.xy * float2(2.0)) - float2(1.0);
    float _218 = sqrt(fast::clamp(1.0 - dot(_214, _214), 0.0, 1.0));
    float3 _226 = float3(float4(_214, _218, 1.0).xy * (-1.0), _218);
    float3 _230 = (float3(0.0, 0.0, 2.0) * dot(float3(0.0, 0.0, 2.0), _226)) - (_226 * 2.0);
    float3 _242 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize(((_230 / float3(sqrt(dot(_230, _230)))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _246 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _264 = Material_Texture2D_2.sample(View_MaterialTextureBilinearWrapedSampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 8.0));
    float3 _268 = float3(_246.x);
    float4 _273 = Material_Texture2D_3.sample(View_MaterialTextureBilinearWrapedSampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 50.0));
    float3 _277 = float3(_246.z);
    float3 _291 = fast::clamp(mix(mix(mix(Material.Material_VectorExpressions[3].xyz, Material.Material_VectorExpressions[3].xyz, float3(_246.y)), _264.xyz * float3(0.25), _268), _273.xyz * float3(0.2249999940395355224609375), _277), float3(0.0), float3(1.0));
    float _292 = fast::clamp(mix(mix(float3(0.0), float3(1.0), _268), float3(0.0), _277).x, 0.0, 1.0);
    uint _298 = in.in_var_PRIMITIVE_ID * 36u;
    uint _299 = _298 + 20u;
    bool _310 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _316;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _298 + 18u)].w > 0.0) && _310)
    {
        _316 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _316 = 1.0;
    }
    float _363;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _299)].z > 0.0)
    {
        float3 _331 = fast::clamp((_205 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _342 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_331.x), int(_331.y), int(_331.z), 0).xyz), 0));
        _363 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_342.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_331 / float3(_342.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _363 = _316;
    }
    float3 _375 = ((_291 - (_291 * _292)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _382 = (mix(float3(0.039999999105930328369140625), _291, float3(_292)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _385 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _390;
    if (_385)
    {
        _390 = _375 + (_382 * 0.449999988079071044921875);
    }
    else
    {
        _390 = _375;
    }
    float3 _392 = select(_382, float3(0.0), bool3(_385));
    float3 _394 = float3(dot(_392, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _468;
    if (_310)
    {
        float3 _420 = fast::clamp((_205 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _424 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _420);
        float4 _428 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _420);
        float4 _431 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _420);
        float4 _449 = _161;
        _449.y = (-0.48860299587249755859375) * _242.y;
        float4 _452 = _449;
        _452.z = 0.48860299587249755859375 * _242.z;
        float4 _455 = _452;
        _455.w = (-0.48860299587249755859375) * _242.x;
        float4 _456 = _455;
        _456.x = 0.886227548122406005859375;
        float3 _458 = _456.yzw * 2.094395160675048828125;
        float4 _459 = float4(_456.x, _458.x, _458.y, _458.z);
        float3 _461 = float3(0.0);
        _461.x = dot(float4(_424.x, _428.x, _431.x, _424.w), _459);
        float3 _463 = _461;
        _463.y = dot(float4(_424.y, _428.y, _431.y, _428.w), _459);
        float3 _465 = _463;
        _465.z = dot(float4(_424.z, _428.z, _431.zw), _459);
        _468 = fast::max(float3(0.0), _465) * float3(0.3183098733425140380859375);
    }
    else
    {
        _468 = float3(0.0);
    }
    float3 _471 = _468 * View.View_IndirectLightingColorScale;
    float3 _493 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _522;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _521;
        if (any(abs(_205 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _298 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _298 + 19u)].xyz + float3(1.0))))
        {
            _521 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_205, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _521 = _493;
        }
        _522 = _521;
    }
    else
    {
        _522 = _493;
    }
    float4 _529 = float4(((mix(float3(0.0), _390 + (_392 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_471 * _390) * fast::max(float3(1.0), ((((((_291 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_291 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_291 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _522) * 1.0, 0.0);
    float4 _536;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _535 = _529;
        _535.w = 0.0;
        _536 = _535;
    }
    else
    {
        _536 = _529;
    }
    float2 _541 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _549 = (_242 * 0.5) + float3(0.5);
    float4 _551 = float4(_549.x, _549.y, _549.z, float4(0.0).w);
    _551.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _299)].y;
    float4 _552 = float4(0.0);
    _552.x = _292;
    float4 _553 = _552;
    _553.y = 0.5;
    float4 _554 = _553;
    _554.z = (fast::clamp(mix(mix(float3(0.100000001490116119384765625), float3(mix(0.37999999523162841796875, 0.550000011920928955078125, _264.x)), _268), float3(mix(0.550000011920928955078125, 0.75, _273.x)), _277).x, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float4 _555 = _554;
    _555.w = 0.50588238239288330078125;
    float4 _567 = float4(_291.x, _291.y, _291.z, float4(0.0).w);
    _567.w = ((log2(((dot(_471, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_394 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_394 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_394 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_541.xyx * _541.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _536 * View.View_PreExposure;
    out.out_var_SV_Target1 = _551;
    out.out_var_SV_Target2 = _555;
    out.out_var_SV_Target3 = _567;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_363, 1.0, 1.0, 1.0);
    return out;
}

