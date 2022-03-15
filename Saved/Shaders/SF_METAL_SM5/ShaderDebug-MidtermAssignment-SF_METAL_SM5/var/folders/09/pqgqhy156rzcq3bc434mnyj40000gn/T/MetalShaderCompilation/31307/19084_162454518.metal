

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
    char _m11_pad[16];
    float View_OutOfBoundsMask;
    char _m12_pad[48];
    float View_MaterialTextureMipBias;
    char _m13_pad[28];
    float View_UnlitViewmodeMask;
    char _m14_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m15_pad[452];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m17_pad[124];
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
    float4 IndirectLightingCache_PointSkyBentNormal;
    float IndirectLightingCache_DirectionalLightShadowing;
};

struct type_Material
{
    spvUnsafeArray<float4, 8> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float3 _172 = {};
constant float4 _174 = {};

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

fragment MainPS_out Main_00004a8c_09aedbf6(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], texture2d<float> Material_Texture2D_2 [[texture(10)]], texture2d<float> Material_Texture2D_3 [[texture(11)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], sampler Material_Texture2D_2Sampler [[sampler(5)]], sampler Material_Texture2D_3Sampler [[sampler(6)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _229 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _233 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _238 = (_233.xyz / float3(_233.w)) - View.View_PreViewTranslation;
    float2 _239 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5;
    float4 _245 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _239, bias(View.View_MaterialTextureMipBias));
    float2 _248 = (_245.xy * float2(2.0)) - float2(1.0);
    float2 _256 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125;
    float4 _260 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _256, bias(View.View_MaterialTextureMipBias));
    float _287;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _287 = _229.w;
                break;
            }
            else
            {
                float _271 = _229.z;
                _287 = ((_271 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_271 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _294 = float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _260.x) + _287) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0));
    float3 _303 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(float4(_248, sqrt(fast::clamp(1.0 - dot(_248, _248), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), _294) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _314 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _239, bias(View.View_MaterialTextureMipBias));
    float4 _330 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.75) * 0.00999999977648258209228515625), bias(View.View_MaterialTextureMipBias));
    float3 _336 = mix(Material.Material_VectorExpressions[3].xyz * _314.y, _314.xyz * Material.Material_VectorExpressions[5].xyz, float3(fast::min(fast::max(mix(-0.25, 2.0, _330.x), 0.0), 1.0)));
    float4 _338 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _256, bias(View.View_MaterialTextureMipBias));
    float4 _346 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.004999999888241291046142578125), bias(View.View_MaterialTextureMipBias));
    float3 _351 = fast::clamp(mix(_336, mix(_336, mix(_338.xyz, Material.Material_VectorExpressions[7].xyz, float3(0.300000011920928955078125)), float3(_346.x)), _294), float3(0.0), float3(1.0));
    uint _352 = in.in_var_PRIMITIVE_ID * 36u;
    uint _353 = _352 + 20u;
    float _400;
    float _401;
    float _402;
    float3 _403;
    float3 _404;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _353)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _371 = ((_229.xy / float2(_229.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _375 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _371, level(0.0));
        float4 _378 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _371, level(0.0));
        float4 _381 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _371, level(0.0));
        float _391 = _381.w;
        _400 = _391 + _381.z;
        _401 = (0.5 * _391) + _381.y;
        _402 = _381.x;
        _403 = (_351 * _375.w) + _375.xyz;
        _404 = normalize((_303 * _378.w) + ((_378.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _400 = 1.0;
        _401 = 0.5;
        _402 = 0.0;
        _403 = _351;
        _404 = _303;
    }
    bool _414 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _420;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _352 + 18u)].w > 0.0) && _414)
    {
        _420 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _420 = 1.0;
    }
    float _467;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _353)].z > 0.0)
    {
        float3 _435 = fast::clamp((_238 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _446 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_435.x), int(_435.y), int(_435.z), 0).xyz), 0));
        _467 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_446.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_435 / float3(_446.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _467 = _420;
    }
    float3 _490 = (((_403 - (_403 * _402)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz) + (((mix(float3(0.07999999821186065673828125 * _401), _403, float3(_402)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz) * 0.449999988079071044921875);
    float3 _551;
    if (_414)
    {
        float3 _503 = fast::clamp((_238 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _507 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _503);
        float4 _511 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _503);
        float4 _514 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _503);
        float4 _532 = _174;
        _532.y = (-0.48860299587249755859375) * _404.y;
        float4 _535 = _532;
        _535.z = 0.48860299587249755859375 * _404.z;
        float4 _538 = _535;
        _538.w = (-0.48860299587249755859375) * _404.x;
        float4 _539 = _538;
        _539.x = 0.886227548122406005859375;
        float3 _541 = _539.yzw * 2.094395160675048828125;
        float4 _542 = float4(_539.x, _541.x, _541.y, _541.z);
        float3 _544 = float3(0.0);
        _544.x = dot(float4(_507.x, _511.x, _514.x, _507.w), _542);
        float3 _546 = _544;
        _546.y = dot(float4(_507.y, _511.y, _514.y, _511.w), _542);
        float3 _548 = _546;
        _548.z = dot(float4(_507.z, _511.z, _514.zw), _542);
        _551 = fast::max(float3(0.0), _548) * float3(0.3183098733425140380859375);
    }
    else
    {
        _551 = float3(0.0);
    }
    float _577;
    float _578;
    float3 _579;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _567;
        float _568;
        if (_414)
        {
            _567 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _568 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _567 = _404;
            _568 = 1.0;
        }
        float _569 = 1.0 - _568;
        float _571 = 1.0 - (_569 * _569);
        _577 = mix(fast::clamp(dot(_567, _404), 0.0, 1.0), 1.0, _571);
        _578 = _568;
        _579 = mix(_567, _404, float3(_571));
    }
    else
    {
        _577 = 1.0;
        _578 = 1.0;
        _579 = _404;
    }
    float4 _583 = float4(_579, 1.0);
    float3 _587 = _172;
    _587.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _583);
    float3 _591 = _587;
    _591.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _583);
    float3 _595 = _591;
    _595.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _583);
    float4 _598 = _583.xyzz * _583.yzzx;
    float3 _602 = _172;
    _602.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _598);
    float3 _606 = _602;
    _606.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _598);
    float3 _610 = _606;
    _610.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _598);
    float3 _625 = (_551 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_595 + _610) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_579.x * _579.x) - (_579.y * _579.y)))) * View.View_SkyLightColor.xyz) * (_578 * _577));
    float3 _645 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _674;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _673;
        if (any(abs(_238 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _352 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _352 + 19u)].xyz + float3(1.0))))
        {
            _673 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_238, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _673 = _645;
        }
        _674 = _673;
    }
    else
    {
        _674 = _645;
    }
    float4 _681 = float4(((mix(float3(0.0), _490, float3(View.View_UnlitViewmodeMask)) + ((_625 * _490) * fast::max(float3(1.0), ((((((_403 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_403 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_403 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _674) * 1.0, 0.0);
    float4 _688;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _687 = _681;
        _687.w = 0.0;
        _688 = _687;
    }
    else
    {
        _688 = _681;
    }
    float2 _692 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _700 = (_404 * 0.5) + float3(0.5);
    float4 _702 = float4(_700.x, _700.y, _700.z, float4(0.0).w);
    _702.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _353)].y;
    float4 _703 = float4(0.0);
    _703.x = _402;
    float4 _704 = _703;
    _704.y = _401;
    float4 _705 = _704;
    _705.z = _400;
    float4 _706 = _705;
    _706.w = 0.50588238239288330078125;
    float4 _717 = float4(_403.x, _403.y, _403.z, float4(0.0).w);
    _717.w = ((log2((dot(_625, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_692.xyx * _692.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _688 * View.View_PreExposure;
    out.out_var_SV_Target1 = _702;
    out.out_var_SV_Target2 = _706;
    out.out_var_SV_Target3 = _717;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_467, 1.0, 1.0, 1.0);
    return out;
}

