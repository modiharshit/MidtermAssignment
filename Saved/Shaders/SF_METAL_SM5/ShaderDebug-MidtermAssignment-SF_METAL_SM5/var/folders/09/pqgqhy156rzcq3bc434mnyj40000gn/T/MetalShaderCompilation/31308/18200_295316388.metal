

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

constant float4 _173 = {};

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

fragment MainPS_out Main_00004718_119a2ba4(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], texture2d<float> Material_Texture2D_2 [[texture(10)]], texture2d<float> Material_Texture2D_3 [[texture(11)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], sampler Material_Texture2D_2Sampler [[sampler(5)]], sampler Material_Texture2D_3Sampler [[sampler(6)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _230 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _234 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _239 = (_234.xyz / float3(_234.w)) - View.View_PreViewTranslation;
    float2 _240 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.25;
    float4 _246 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _240, bias(View.View_MaterialTextureMipBias));
    float2 _249 = (_246.xy * float2(2.0)) - float2(1.0);
    float2 _257 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.3499999940395355224609375;
    float4 _259 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _257, bias(View.View_MaterialTextureMipBias));
    float2 _262 = (_259.xy * float2(2.0)) - float2(1.0);
    float4 _274 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _279 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _284 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _288 = (_274.x + 0.5) * ((_279.x + 0.5) * (_284.x + 0.5));
    float _291 = fast::min(fast::max(mix(-2.0, 0.699999988079071044921875, _288), 0.0), 1.0);
    float3 _294 = float3(_291);
    float4 _300 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _327;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _327 = _230.w;
                break;
            }
            else
            {
                float _311 = _230.z;
                _327 = ((_311 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_311 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _342 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(mix(float4(_249, sqrt(fast::clamp(1.0 - dot(_249, _249), 0.0, 1.0)), 1.0).xyz, float4(_262, sqrt(fast::clamp(1.0 - dot(_262, _262), 0.0, 1.0)), 1.0).xyz, _294), float3(0.0, 0.0, 1.0), float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _300.x) + _327) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _355 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _240, bias(View.View_MaterialTextureMipBias));
    float4 _357 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _257, bias(View.View_MaterialTextureMipBias));
    float3 _366 = fast::clamp(mix(float3(0.6349999904632568359375), float3(1.0), float3(_288)) * mix(_355.xyz, _357.xyz, _294), float3(0.0), float3(1.0));
    float _371 = (fast::clamp(mix(0.800000011920928955078125, 0.20000000298023223876953125, mix(_355.w, _357.w, _291)), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _372 = in.in_var_PRIMITIVE_ID * 36u;
    uint _373 = _372 + 20u;
    float _421;
    float _422;
    float _423;
    float3 _424;
    float3 _425;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _373)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _391 = ((_230.xy / float2(_230.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _395 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _391, level(0.0));
        float4 _398 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _391, level(0.0));
        float4 _401 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _391, level(0.0));
        float _411 = _401.w;
        _421 = (_371 * _411) + _401.z;
        _422 = (0.5 * _411) + _401.y;
        _423 = _401.x;
        _424 = (_366 * _395.w) + _395.xyz;
        _425 = normalize((_342 * _398.w) + ((_398.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _421 = _371;
        _422 = 0.5;
        _423 = 0.0;
        _424 = _366;
        _425 = _342;
    }
    bool _435 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _441;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _372 + 18u)].w > 0.0) && _435)
    {
        _441 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _441 = 1.0;
    }
    float _488;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _373)].z > 0.0)
    {
        float3 _456 = fast::clamp((_239 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _467 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_456.x), int(_456.y), int(_456.z), 0).xyz), 0));
        _488 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_467.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_456 / float3(_467.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _488 = _441;
    }
    float3 _502 = ((_424 - (_424 * _423)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _509 = (mix(float3(0.07999999821186065673828125 * _422), _424, float3(_423)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _512 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _517;
    if (_512)
    {
        _517 = _502 + (_509 * 0.449999988079071044921875);
    }
    else
    {
        _517 = _502;
    }
    float3 _519 = select(_509, float3(0.0), bool3(_512));
    float3 _521 = float3(dot(_519, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _595;
    if (_435)
    {
        float3 _547 = fast::clamp((_239 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _551 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _547);
        float4 _555 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _547);
        float4 _558 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _547);
        float4 _576 = _173;
        _576.y = (-0.48860299587249755859375) * _425.y;
        float4 _579 = _576;
        _579.z = 0.48860299587249755859375 * _425.z;
        float4 _582 = _579;
        _582.w = (-0.48860299587249755859375) * _425.x;
        float4 _583 = _582;
        _583.x = 0.886227548122406005859375;
        float3 _585 = _583.yzw * 2.094395160675048828125;
        float4 _586 = float4(_583.x, _585.x, _585.y, _585.z);
        float3 _588 = float3(0.0);
        _588.x = dot(float4(_551.x, _555.x, _558.x, _551.w), _586);
        float3 _590 = _588;
        _590.y = dot(float4(_551.y, _555.y, _558.y, _555.w), _586);
        float3 _592 = _590;
        _592.z = dot(float4(_551.z, _555.z, _558.zw), _586);
        _595 = fast::max(float3(0.0), _592) * float3(0.3183098733425140380859375);
    }
    else
    {
        _595 = float3(0.0);
    }
    float3 _598 = _595 * View.View_IndirectLightingColorScale;
    float3 _620 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _649;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _648;
        if (any(abs(_239 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _372 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _372 + 19u)].xyz + float3(1.0))))
        {
            _648 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_239, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _648 = _620;
        }
        _649 = _648;
    }
    else
    {
        _649 = _620;
    }
    float4 _656 = float4(((mix(float3(0.0), _517 + (_519 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_598 * _517) * fast::max(float3(1.0), ((((((_424 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_424 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_424 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _649) * 1.0, 0.0);
    float4 _663;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _662 = _656;
        _662.w = 0.0;
        _663 = _662;
    }
    else
    {
        _663 = _656;
    }
    float2 _667 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _675 = (_425 * 0.5) + float3(0.5);
    float4 _677 = float4(_675.x, _675.y, _675.z, float4(0.0).w);
    _677.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _373)].y;
    float4 _678 = float4(0.0);
    _678.x = _423;
    float4 _679 = _678;
    _679.y = _422;
    float4 _680 = _679;
    _680.z = _421;
    float4 _681 = _680;
    _681.w = 0.50588238239288330078125;
    float4 _693 = float4(_424.x, _424.y, _424.z, float4(0.0).w);
    _693.w = ((log2(((dot(_598, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_521 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_521 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_521 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_667.xyx * _667.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _663 * View.View_PreExposure;
    out.out_var_SV_Target1 = _677;
    out.out_var_SV_Target2 = _681;
    out.out_var_SV_Target3 = _693;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_488, 1.0, 1.0, 1.0);
    return out;
}

