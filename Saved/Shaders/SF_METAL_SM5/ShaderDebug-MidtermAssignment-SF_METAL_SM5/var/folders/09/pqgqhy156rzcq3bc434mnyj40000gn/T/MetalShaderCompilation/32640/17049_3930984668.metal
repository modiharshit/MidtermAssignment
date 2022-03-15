

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
    char _m0_pad[448];
    float4x4 View_ViewToClip;
    char _m1_pad[192];
    float4x4 View_SVPositionToTranslatedWorld;
    char _m2_pad[272];
    float4 View_InvDeviceZToWorldZTransform;
    float4 View_ScreenPositionScaleBias;
    char _m4_pad[48];
    float3 View_PreViewTranslation;
    char _m5_pad[928];
    float4 View_ViewRectMin;
    float4 View_ViewSizeAndInvSize;
    char _m7_pad[68];
    float View_PreExposure;
    float4 View_DiffuseOverrideParameter;
    float4 View_SpecularOverrideParameter;
    float4 View_NormalOverrideParameter;
    float2 View_RoughnessOverrideParameter;
    char _m12_pad[8];
    float View_OutOfBoundsMask;
    char _m13_pad[48];
    float View_MaterialTextureMipBias;
    char _m14_pad[28];
    float View_UnlitViewmodeMask;
    char _m15_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m16_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m17_pad[188];
    float View_ShowDecalsMask;
    char _m18_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m19_pad[48];
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

fragment MainPS_out Main_00004299_ea4e10dc(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], texture2d<float> Material_Texture2D_2 [[texture(10)]], texture2d<float> Material_Texture2D_3 [[texture(11)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], sampler Material_Texture2D_2Sampler [[sampler(5)]], sampler Material_Texture2D_3Sampler [[sampler(6)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _221 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _225 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _230 = (_225.xyz / float3(_225.w)) - View.View_PreViewTranslation;
    float2 _231 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5;
    float4 _237 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _231, bias(View.View_MaterialTextureMipBias));
    float2 _240 = (_237.xy * float2(2.0)) - float2(1.0);
    float4 _252 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _279;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _279 = _221.w;
                break;
            }
            else
            {
                float _263 = _221.z;
                _279 = ((_263 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_263 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _284 = fast::min(fast::max(((mix(-2000.0, 2000.0, _252.x) + _279) - 500.0) * 0.0005000000237487256526947021484375, 0.0), 1.0);
    float3 _295 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(float4(_240, sqrt(fast::clamp(1.0 - dot(_240, _240), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), float3(_284)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _306 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _231, bias(View.View_MaterialTextureMipBias));
    float4 _310 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _231, bias(View.View_MaterialTextureMipBias));
    float3 _316 = fast::clamp(_306.xyz, float3(0.0), float3(1.0));
    float _317 = fast::clamp(_306.x, 0.0, 1.0);
    float _318 = fast::clamp(_310.w, 0.0, 1.0);
    float _323 = (fast::clamp(mix(_310.x, 0.300000011920928955078125, _284), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _324 = in.in_var_PRIMITIVE_ID * 36u;
    uint _325 = _324 + 20u;
    float _373;
    float _374;
    float _375;
    float3 _376;
    float3 _377;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _325)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _343 = ((_221.xy / float2(_221.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _347 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _343, level(0.0));
        float4 _350 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _343, level(0.0));
        float4 _353 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _343, level(0.0));
        float _363 = _353.w;
        _373 = (_323 * _363) + _353.z;
        _374 = (_317 * _363) + _353.y;
        _375 = _353.x;
        _376 = (_316 * _347.w) + _347.xyz;
        _377 = normalize((_295 * _350.w) + ((_350.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _373 = _323;
        _374 = _317;
        _375 = 0.0;
        _376 = _316;
        _377 = _295;
    }
    bool _387 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _393;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _324 + 18u)].w > 0.0) && _387)
    {
        _393 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _393 = 1.0;
    }
    float _440;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _325)].z > 0.0)
    {
        float3 _408 = fast::clamp((_230 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _419 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_408.x), int(_408.y), int(_408.z), 0).xyz), 0));
        _440 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_419.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_408 / float3(_419.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _440 = _393;
    }
    float3 _454 = ((_376 - (_376 * _375)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _461 = (mix(float3(0.07999999821186065673828125 * _374), _376, float3(_375)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _464 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _469;
    if (_464)
    {
        _469 = _454 + (_461 * 0.449999988079071044921875);
    }
    else
    {
        _469 = _454;
    }
    float3 _471 = select(_461, float3(0.0), bool3(_464));
    float3 _473 = float3(dot(_471, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _480 = float3(_318);
    float3 _548;
    if (_387)
    {
        float3 _500 = fast::clamp((_230 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _504 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _500);
        float4 _508 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _500);
        float4 _511 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _500);
        float4 _529 = _164;
        _529.y = (-0.48860299587249755859375) * _377.y;
        float4 _532 = _529;
        _532.z = 0.48860299587249755859375 * _377.z;
        float4 _535 = _532;
        _535.w = (-0.48860299587249755859375) * _377.x;
        float4 _536 = _535;
        _536.x = 0.886227548122406005859375;
        float3 _538 = _536.yzw * 2.094395160675048828125;
        float4 _539 = float4(_536.x, _538.x, _538.y, _538.z);
        float3 _541 = float3(0.0);
        _541.x = dot(float4(_504.x, _508.x, _511.x, _504.w), _539);
        float3 _543 = _541;
        _543.y = dot(float4(_504.y, _508.y, _511.y, _508.w), _539);
        float3 _545 = _543;
        _545.z = dot(float4(_504.z, _508.z, _511.zw), _539);
        _548 = fast::max(float3(0.0), _545) * float3(0.3183098733425140380859375);
    }
    else
    {
        _548 = float3(0.0);
    }
    float3 _551 = _548 * View.View_IndirectLightingColorScale;
    float3 _573 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _602;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _601;
        if (any(abs(_230 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _324 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _324 + 19u)].xyz + float3(1.0))))
        {
            _601 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_230, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _601 = _573;
        }
        _602 = _601;
    }
    else
    {
        _602 = _573;
    }
    float4 _609 = float4(((mix(float3(0.0), _469 + (_471 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_551 * _469) * fast::max(_480, ((((((_376 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _318) + ((_376 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _318) + ((_376 * 2.755199909210205078125) + float3(0.69029998779296875))) * _318))) + _602) * 1.0, 0.0);
    float4 _616;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _615 = _609;
        _615.w = 0.0;
        _616 = _615;
    }
    else
    {
        _616 = _609;
    }
    float2 _620 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _628 = (_377 * 0.5) + float3(0.5);
    float4 _630 = float4(_628.x, _628.y, _628.z, float4(0.0).w);
    _630.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _325)].y;
    float4 _631 = float4(0.0);
    _631.x = _375;
    float4 _632 = _631;
    _632.y = _374;
    float4 _633 = _632;
    _633.z = _373;
    float4 _634 = _633;
    _634.w = 0.50588238239288330078125;
    float4 _646 = float4(_376.x, _376.y, _376.z, float4(0.0).w);
    _646.w = ((log2(((dot(_551, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_480, ((((((_473 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _318) + ((_473 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _318) + ((_473 * 2.755199909210205078125) + float3(0.69029998779296875))) * _318).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_620.xyx * _620.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _616 * View.View_PreExposure;
    out.out_var_SV_Target1 = _630;
    out.out_var_SV_Target2 = _634;
    out.out_var_SV_Target3 = _646;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_440, 1.0, 1.0, 1.0);
    return out;
}

