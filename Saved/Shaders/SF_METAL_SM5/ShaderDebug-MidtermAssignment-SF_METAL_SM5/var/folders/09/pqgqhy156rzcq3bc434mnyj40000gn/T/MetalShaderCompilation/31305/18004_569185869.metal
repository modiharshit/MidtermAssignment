

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

constant float4 _170 = {};

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

fragment MainPS_out Main_00004654_21ed164d(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], texture2d<float> Material_Texture2D_2 [[texture(10)]], texture2d<float> Material_Texture2D_3 [[texture(11)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], sampler Material_Texture2D_2Sampler [[sampler(5)]], sampler Material_Texture2D_3Sampler [[sampler(6)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _227 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _231 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _235 = _231.xyz / float3(_231.w);
    float3 _236 = _235 - View.View_PreViewTranslation;
    float4 _244 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _247 = (_244.xy * float2(2.0)) - float2(1.0);
    float4 _259 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _286;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _286 = _227.w;
                break;
            }
            else
            {
                float _270 = _227.z;
                _286 = ((_270 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_270 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _302 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(float4(_247, sqrt(fast::clamp(1.0 - dot(_247, _247), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _259.x) + _286) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _314 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _319 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _324 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _328 = (_314.x + 0.5) * ((_319.x + 0.5) * (_324.x + 0.5));
    float4 _332 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _334 = _332.xyz * _328;
    float _336 = _334.x;
    float _340 = _334.y;
    float _344 = _334.z;
    float _353 = fast::max(abs(1.0 - fast::max(0.0, dot(in.in_var_TEXCOORD11_centroid.xyz, normalize(-_235)))), 9.9999997473787516355514526367188e-05);
    float3 _362 = fast::clamp(mix(_334 * 0.5, float3((_336 <= 0.0) ? 0.0 : pow(_336, 0.4000000059604644775390625), (_340 <= 0.0) ? 0.0 : pow(_340, 0.4000000059604644775390625), (_344 <= 0.0) ? 0.0 : pow(_344, 0.4000000059604644775390625)), float3((_353 <= 0.0) ? 0.0 : pow(_353, 3.0))), float3(0.0), float3(1.0));
    float _367 = (fast::clamp(mix(0.89999997615814208984375, 0.5, _328 * _332.w), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _368 = in.in_var_PRIMITIVE_ID * 36u;
    uint _369 = _368 + 20u;
    float _417;
    float _418;
    float _419;
    float3 _420;
    float3 _421;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _369)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _387 = ((_227.xy / float2(_227.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _391 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _387, level(0.0));
        float4 _394 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _387, level(0.0));
        float4 _397 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _387, level(0.0));
        float _407 = _397.w;
        _417 = (_367 * _407) + _397.z;
        _418 = (0.5 * _407) + _397.y;
        _419 = _397.x;
        _420 = (_362 * _391.w) + _391.xyz;
        _421 = normalize((_302 * _394.w) + ((_394.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _417 = _367;
        _418 = 0.5;
        _419 = 0.0;
        _420 = _362;
        _421 = _302;
    }
    bool _431 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _437;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _368 + 18u)].w > 0.0) && _431)
    {
        _437 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _437 = 1.0;
    }
    float _484;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _369)].z > 0.0)
    {
        float3 _452 = fast::clamp((_236 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _463 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_452.x), int(_452.y), int(_452.z), 0).xyz), 0));
        _484 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_463.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_452 / float3(_463.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _484 = _437;
    }
    float3 _498 = ((_420 - (_420 * _419)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _505 = (mix(float3(0.07999999821186065673828125 * _418), _420, float3(_419)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _508 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _513;
    if (_508)
    {
        _513 = _498 + (_505 * 0.449999988079071044921875);
    }
    else
    {
        _513 = _498;
    }
    float3 _515 = select(_505, float3(0.0), bool3(_508));
    float3 _517 = float3(dot(_515, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _591;
    if (_431)
    {
        float3 _543 = fast::clamp((_236 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _547 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _543);
        float4 _551 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _543);
        float4 _554 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _543);
        float4 _572 = _170;
        _572.y = (-0.48860299587249755859375) * _421.y;
        float4 _575 = _572;
        _575.z = 0.48860299587249755859375 * _421.z;
        float4 _578 = _575;
        _578.w = (-0.48860299587249755859375) * _421.x;
        float4 _579 = _578;
        _579.x = 0.886227548122406005859375;
        float3 _581 = _579.yzw * 2.094395160675048828125;
        float4 _582 = float4(_579.x, _581.x, _581.y, _581.z);
        float3 _584 = float3(0.0);
        _584.x = dot(float4(_547.x, _551.x, _554.x, _547.w), _582);
        float3 _586 = _584;
        _586.y = dot(float4(_547.y, _551.y, _554.y, _551.w), _582);
        float3 _588 = _586;
        _588.z = dot(float4(_547.z, _551.z, _554.zw), _582);
        _591 = fast::max(float3(0.0), _588) * float3(0.3183098733425140380859375);
    }
    else
    {
        _591 = float3(0.0);
    }
    float3 _594 = _591 * View.View_IndirectLightingColorScale;
    float3 _616 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _645;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _644;
        if (any(abs(_236 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _368 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _368 + 19u)].xyz + float3(1.0))))
        {
            _644 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_236, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _644 = _616;
        }
        _645 = _644;
    }
    else
    {
        _645 = _616;
    }
    float4 _652 = float4(((mix(float3(0.0), _513 + (_515 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_594 * _513) * fast::max(float3(1.0), ((((((_420 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_420 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_420 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _645) * 1.0, 0.0);
    float4 _659;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _658 = _652;
        _658.w = 0.0;
        _659 = _658;
    }
    else
    {
        _659 = _652;
    }
    float2 _663 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _671 = (_421 * 0.5) + float3(0.5);
    float4 _673 = float4(_671.x, _671.y, _671.z, float4(0.0).w);
    _673.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _369)].y;
    float4 _674 = float4(0.0);
    _674.x = _419;
    float4 _675 = _674;
    _675.y = _418;
    float4 _676 = _675;
    _676.z = _417;
    float4 _677 = _676;
    _677.w = 0.50588238239288330078125;
    float4 _689 = float4(_420.x, _420.y, _420.z, float4(0.0).w);
    _689.w = ((log2(((dot(_594, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_517 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_517 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_517 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_663.xyx * _663.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _659 * View.View_PreExposure;
    out.out_var_SV_Target1 = _673;
    out.out_var_SV_Target2 = _677;
    out.out_var_SV_Target3 = _689;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_484, 1.0, 1.0, 1.0);
    return out;
}

