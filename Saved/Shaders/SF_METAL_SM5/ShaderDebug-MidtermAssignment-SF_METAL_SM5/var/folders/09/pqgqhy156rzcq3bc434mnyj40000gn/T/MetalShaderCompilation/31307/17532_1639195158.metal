

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

constant float4 _169 = {};

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

fragment MainPS_out Main_0000447c_61b42216(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], texture2d<float> Material_Texture2D_2 [[texture(10)]], texture2d<float> Material_Texture2D_3 [[texture(11)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], sampler Material_Texture2D_2Sampler [[sampler(5)]], sampler Material_Texture2D_3Sampler [[sampler(6)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _226 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _230 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _235 = (_230.xyz / float3(_230.w)) - View.View_PreViewTranslation;
    float2 _236 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.25;
    float4 _242 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _236, bias(View.View_MaterialTextureMipBias));
    float2 _245 = (_242.xy * float2(2.0)) - float2(1.0);
    float4 _257 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _284;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _284 = _226.w;
                break;
            }
            else
            {
                float _268 = _226.z;
                _284 = ((_268 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_268 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _300 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(float4(_245, sqrt(fast::clamp(1.0 - dot(_245, _245), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _257.x) + _284) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _312 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _317 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _322 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _326 = (_312.x + 0.5) * ((_317.x + 0.5) * (_322.x + 0.5));
    float4 _332 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _236, bias(View.View_MaterialTextureMipBias));
    float3 _338 = fast::clamp(mix(float3(0.5), float3(1.0), float3(_326)) * _332.xyz, float3(0.0), float3(1.0));
    float _343 = (fast::clamp(mix(0.800000011920928955078125, 0.20000000298023223876953125, _326 * _332.w), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _344 = in.in_var_PRIMITIVE_ID * 36u;
    uint _345 = _344 + 20u;
    float _393;
    float _394;
    float _395;
    float3 _396;
    float3 _397;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _345)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _363 = ((_226.xy / float2(_226.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _367 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _363, level(0.0));
        float4 _370 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _363, level(0.0));
        float4 _373 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _363, level(0.0));
        float _383 = _373.w;
        _393 = (_343 * _383) + _373.z;
        _394 = (0.5 * _383) + _373.y;
        _395 = _373.x;
        _396 = (_338 * _367.w) + _367.xyz;
        _397 = normalize((_300 * _370.w) + ((_370.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _393 = _343;
        _394 = 0.5;
        _395 = 0.0;
        _396 = _338;
        _397 = _300;
    }
    bool _407 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _413;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _344 + 18u)].w > 0.0) && _407)
    {
        _413 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _413 = 1.0;
    }
    float _460;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _345)].z > 0.0)
    {
        float3 _428 = fast::clamp((_235 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _439 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_428.x), int(_428.y), int(_428.z), 0).xyz), 0));
        _460 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_439.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_428 / float3(_439.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _460 = _413;
    }
    float3 _474 = ((_396 - (_396 * _395)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _481 = (mix(float3(0.07999999821186065673828125 * _394), _396, float3(_395)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _484 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _489;
    if (_484)
    {
        _489 = _474 + (_481 * 0.449999988079071044921875);
    }
    else
    {
        _489 = _474;
    }
    float3 _491 = select(_481, float3(0.0), bool3(_484));
    float3 _493 = float3(dot(_491, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _567;
    if (_407)
    {
        float3 _519 = fast::clamp((_235 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _523 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _519);
        float4 _527 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _519);
        float4 _530 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _519);
        float4 _548 = _169;
        _548.y = (-0.48860299587249755859375) * _397.y;
        float4 _551 = _548;
        _551.z = 0.48860299587249755859375 * _397.z;
        float4 _554 = _551;
        _554.w = (-0.48860299587249755859375) * _397.x;
        float4 _555 = _554;
        _555.x = 0.886227548122406005859375;
        float3 _557 = _555.yzw * 2.094395160675048828125;
        float4 _558 = float4(_555.x, _557.x, _557.y, _557.z);
        float3 _560 = float3(0.0);
        _560.x = dot(float4(_523.x, _527.x, _530.x, _523.w), _558);
        float3 _562 = _560;
        _562.y = dot(float4(_523.y, _527.y, _530.y, _527.w), _558);
        float3 _564 = _562;
        _564.z = dot(float4(_523.z, _527.z, _530.zw), _558);
        _567 = fast::max(float3(0.0), _564) * float3(0.3183098733425140380859375);
    }
    else
    {
        _567 = float3(0.0);
    }
    float3 _570 = _567 * View.View_IndirectLightingColorScale;
    float3 _592 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _621;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _620;
        if (any(abs(_235 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _344 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _344 + 19u)].xyz + float3(1.0))))
        {
            _620 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_235, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _620 = _592;
        }
        _621 = _620;
    }
    else
    {
        _621 = _592;
    }
    float4 _628 = float4(((mix(float3(0.0), _489 + (_491 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_570 * _489) * fast::max(float3(1.0), ((((((_396 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_396 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_396 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _621) * 1.0, 0.0);
    float4 _635;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _634 = _628;
        _634.w = 0.0;
        _635 = _634;
    }
    else
    {
        _635 = _628;
    }
    float2 _639 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _647 = (_397 * 0.5) + float3(0.5);
    float4 _649 = float4(_647.x, _647.y, _647.z, float4(0.0).w);
    _649.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _345)].y;
    float4 _650 = float4(0.0);
    _650.x = _395;
    float4 _651 = _650;
    _651.y = _394;
    float4 _652 = _651;
    _652.z = _393;
    float4 _653 = _652;
    _653.w = 0.50588238239288330078125;
    float4 _665 = float4(_396.x, _396.y, _396.z, float4(0.0).w);
    _665.w = ((log2(((dot(_570, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_493 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_493 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_493 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_639.xyx * _639.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _635 * View.View_PreExposure;
    out.out_var_SV_Target1 = _649;
    out.out_var_SV_Target2 = _653;
    out.out_var_SV_Target3 = _665;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_460, 1.0, 1.0, 1.0);
    return out;
}

