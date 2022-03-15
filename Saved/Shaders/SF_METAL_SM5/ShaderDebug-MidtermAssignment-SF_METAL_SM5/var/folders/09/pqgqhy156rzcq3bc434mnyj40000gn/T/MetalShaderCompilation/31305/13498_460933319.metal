

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
    char _m9_pad[16];
    float View_OutOfBoundsMask;
    char _m10_pad[80];
    float View_UnlitViewmodeMask;
    char _m11_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m12_pad[604];
    float View_ShowDecalsMask;
    char _m13_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m14_pad[48];
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

constant float _145 = {};
constant float4 _146 = {};

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

fragment MainPS_out Main_000034ba_1b7948c7(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _194 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _145, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _199 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _204 = (_199.xyz / float3(_199.w)) - View.View_PreViewTranslation;
    float3 _212 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    uint _220 = in.in_var_PRIMITIVE_ID * 36u;
    uint _221 = _220 + 20u;
    float _268;
    float _269;
    float _270;
    float3 _271;
    float3 _272;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _221)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _239 = ((_194.xy / float2(_194.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _243 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _239, level(0.0));
        float4 _246 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _239, level(0.0));
        float4 _249 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _239, level(0.0));
        float _259 = _249.w;
        _268 = _259 + _249.z;
        _269 = (0.5 * _259) + _249.y;
        _270 = _249.x;
        _271 = (float3(0.180000007152557373046875) * _243.w) + _243.xyz;
        _272 = normalize((_212 * _246.w) + ((_246.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _268 = 1.0;
        _269 = 0.5;
        _270 = 0.0;
        _271 = float3(0.180000007152557373046875);
        _272 = _212;
    }
    bool _282 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _288;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _220 + 18u)].w > 0.0) && _282)
    {
        _288 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _288 = 1.0;
    }
    float _335;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _221)].z > 0.0)
    {
        float3 _303 = fast::clamp((_204 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _314 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_303.x), int(_303.y), int(_303.z), 0).xyz), 0));
        _335 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_314.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_303 / float3(_314.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _335 = _288;
    }
    float3 _358 = (((_271 - (_271 * _270)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz) + (((mix(float3(0.07999999821186065673828125 * _269), _271, float3(_270)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz) * 0.449999988079071044921875);
    float3 _419;
    if (_282)
    {
        float3 _371 = fast::clamp((_204 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _375 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _371);
        float4 _379 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _371);
        float4 _382 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _371);
        float4 _400 = _146;
        _400.y = (-0.48860299587249755859375) * _272.y;
        float4 _403 = _400;
        _403.z = 0.48860299587249755859375 * _272.z;
        float4 _406 = _403;
        _406.w = (-0.48860299587249755859375) * _272.x;
        float4 _407 = _406;
        _407.x = 0.886227548122406005859375;
        float3 _409 = _407.yzw * 2.094395160675048828125;
        float4 _410 = float4(_407.x, _409.x, _409.y, _409.z);
        float3 _412 = float3(0.0);
        _412.x = dot(float4(_375.x, _379.x, _382.x, _375.w), _410);
        float3 _414 = _412;
        _414.y = dot(float4(_375.y, _379.y, _382.y, _379.w), _410);
        float3 _416 = _414;
        _416.z = dot(float4(_375.z, _379.z, _382.zw), _410);
        _419 = fast::max(float3(0.0), _416) * float3(0.3183098733425140380859375);
    }
    else
    {
        _419 = float3(0.0);
    }
    float3 _422 = _419 * View.View_IndirectLightingColorScale;
    float3 _442 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _471;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _470;
        if (any(abs(_204 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _220 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _220 + 19u)].xyz + float3(1.0))))
        {
            _470 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_204, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _470 = _442;
        }
        _471 = _470;
    }
    else
    {
        _471 = _442;
    }
    float4 _478 = float4(((mix(float3(0.0), _358, float3(View.View_UnlitViewmodeMask)) + ((_422 * _358) * fast::max(float3(1.0), ((((((_271 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_271 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_271 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _471) * 1.0, 0.0);
    float4 _485;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _484 = _478;
        _484.w = 0.0;
        _485 = _484;
    }
    else
    {
        _485 = _478;
    }
    float2 _489 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _497 = (_272 * 0.5) + float3(0.5);
    float4 _499 = float4(_497.x, _497.y, _497.z, float4(0.0).w);
    _499.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _221)].y;
    float4 _500 = float4(0.0);
    _500.x = _270;
    float4 _501 = _500;
    _501.y = _269;
    float4 _502 = _501;
    _502.z = _268;
    float4 _503 = _502;
    _503.w = 0.50588238239288330078125;
    float4 _514 = float4(_271.x, _271.y, _271.z, float4(0.0).w);
    _514.w = ((log2((dot(_422, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_489.xyx * _489.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _485 * View.View_PreExposure;
    out.out_var_SV_Target1 = _499;
    out.out_var_SV_Target2 = _503;
    out.out_var_SV_Target3 = _514;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_335, 1.0, 1.0, 1.0);
    return out;
}

