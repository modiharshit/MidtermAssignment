

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
    spvUnsafeArray<float4, 6> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _172 = {};

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

fragment MainPS_out Main_000043fa_a3654070(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], texture2d<float> Material_Texture2D_2 [[texture(10)]], texture2d<float> Material_Texture2D_3 [[texture(11)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], sampler Material_Texture2D_2Sampler [[sampler(5)]], sampler Material_Texture2D_3Sampler [[sampler(6)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _228 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _232 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _237 = (_232.xyz / float3(_232.w)) - View.View_PreViewTranslation;
    float4 _244 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 10.0), bias(View.View_MaterialTextureMipBias));
    float2 _247 = (_244.xy * float2(2.0)) - float2(1.0);
    float4 _260 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _263 = (_260.xy * float2(2.0)) - float2(1.0);
    float _297;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _297 = _228.w;
                break;
            }
            else
            {
                float _281 = _228.z;
                _297 = ((_281 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_281 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _301 = fast::min(fast::max((_297 - 24.0) * 0.00022222222469281405210494995117188, 0.0), 1.0);
    float3 _312 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((((float4(_247, sqrt(fast::clamp(1.0 - dot(_247, _247), 0.0, 1.0)), 1.0).xyz * float3(0.5, 0.5, 1.0)) + mix(float4(_263, sqrt(fast::clamp(1.0 - dot(_263, _263), 0.0, 1.0)), 1.0).xyz * float3(0.25, 0.25, 1.0), float3(0.0, 0.0, 1.0), float3(_301))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _324 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 5.0), bias(View.View_MaterialTextureMipBias));
    float _326 = mix(0.4000000059604644775390625, 1.0, _324.x);
    float _329 = mix(0.699999988079071044921875, 0.89999997615814208984375, _324.y);
    float4 _334 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _349 = fast::clamp(mix(Material.Material_VectorExpressions[4].xyz, Material.Material_VectorExpressions[5].xyz, float3(fast::min(fast::max(_334.y + _301, 0.0), 1.0))) * mix(_326, 1.0 - _326, _329), float3(0.0), float3(1.0));
    float _354 = (fast::clamp(_326 * _329, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _355 = in.in_var_PRIMITIVE_ID * 36u;
    uint _356 = _355 + 20u;
    float _404;
    float _405;
    float _406;
    float3 _407;
    float3 _408;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _356)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _374 = ((_228.xy / float2(_228.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _378 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _374, level(0.0));
        float4 _381 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _374, level(0.0));
        float4 _384 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _374, level(0.0));
        float _394 = _384.w;
        _404 = (_354 * _394) + _384.z;
        _405 = (0.5 * _394) + _384.y;
        _406 = _384.x;
        _407 = (_349 * _378.w) + _378.xyz;
        _408 = normalize((_312 * _381.w) + ((_381.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _404 = _354;
        _405 = 0.5;
        _406 = 0.0;
        _407 = _349;
        _408 = _312;
    }
    bool _418 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _424;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _355 + 18u)].w > 0.0) && _418)
    {
        _424 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _424 = 1.0;
    }
    float _471;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _356)].z > 0.0)
    {
        float3 _439 = fast::clamp((_237 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _450 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_439.x), int(_439.y), int(_439.z), 0).xyz), 0));
        _471 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_450.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_439 / float3(_450.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _471 = _424;
    }
    float3 _485 = ((_407 - (_407 * _406)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _492 = (mix(float3(0.07999999821186065673828125 * _405), _407, float3(_406)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _495 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _500;
    if (_495)
    {
        _500 = _485 + (_492 * 0.449999988079071044921875);
    }
    else
    {
        _500 = _485;
    }
    float3 _502 = select(_492, float3(0.0), bool3(_495));
    float3 _504 = float3(dot(_502, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _578;
    if (_418)
    {
        float3 _530 = fast::clamp((_237 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _534 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _530);
        float4 _538 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _530);
        float4 _541 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _530);
        float4 _559 = _172;
        _559.y = (-0.48860299587249755859375) * _408.y;
        float4 _562 = _559;
        _562.z = 0.48860299587249755859375 * _408.z;
        float4 _565 = _562;
        _565.w = (-0.48860299587249755859375) * _408.x;
        float4 _566 = _565;
        _566.x = 0.886227548122406005859375;
        float3 _568 = _566.yzw * 2.094395160675048828125;
        float4 _569 = float4(_566.x, _568.x, _568.y, _568.z);
        float3 _571 = float3(0.0);
        _571.x = dot(float4(_534.x, _538.x, _541.x, _534.w), _569);
        float3 _573 = _571;
        _573.y = dot(float4(_534.y, _538.y, _541.y, _538.w), _569);
        float3 _575 = _573;
        _575.z = dot(float4(_534.z, _538.z, _541.zw), _569);
        _578 = fast::max(float3(0.0), _575) * float3(0.3183098733425140380859375);
    }
    else
    {
        _578 = float3(0.0);
    }
    float3 _581 = _578 * View.View_IndirectLightingColorScale;
    float3 _603 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _632;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _631;
        if (any(abs(_237 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _355 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _355 + 19u)].xyz + float3(1.0))))
        {
            _631 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_237, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _631 = _603;
        }
        _632 = _631;
    }
    else
    {
        _632 = _603;
    }
    float4 _639 = float4(((mix(float3(0.0), _500 + (_502 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_581 * _500) * fast::max(float3(1.0), ((((((_407 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_407 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_407 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _632) * 1.0, 0.0);
    float4 _646;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _645 = _639;
        _645.w = 0.0;
        _646 = _645;
    }
    else
    {
        _646 = _639;
    }
    float2 _650 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _658 = (_408 * 0.5) + float3(0.5);
    float4 _660 = float4(_658.x, _658.y, _658.z, float4(0.0).w);
    _660.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _356)].y;
    float4 _661 = float4(0.0);
    _661.x = _406;
    float4 _662 = _661;
    _662.y = _405;
    float4 _663 = _662;
    _663.z = _404;
    float4 _664 = _663;
    _664.w = 0.50588238239288330078125;
    float4 _676 = float4(_407.x, _407.y, _407.z, float4(0.0).w);
    _676.w = ((log2(((dot(_581, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_504 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_504 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_504 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_650.xyx * _650.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _646 * View.View_PreExposure;
    out.out_var_SV_Target1 = _660;
    out.out_var_SV_Target2 = _664;
    out.out_var_SV_Target3 = _676;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_471, 1.0, 1.0, 1.0);
    return out;
}

