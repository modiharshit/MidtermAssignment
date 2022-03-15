

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
    float2 View_RoughnessOverrideParameter;
    char _m10_pad[8];
    float View_OutOfBoundsMask;
    char _m11_pad[48];
    float View_MaterialTextureMipBias;
    char _m12_pad[28];
    float View_UnlitViewmodeMask;
    char _m13_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m14_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m15_pad[36];
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
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float3 _162 = {};
constant float _164 = {};
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

fragment MainPS_out Main_00004a31_2b2979fa(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], texture2d<float> Material_Texture2D_2 [[texture(10)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], sampler Material_Texture2D_2Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _222 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _164, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _227 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _232 = (_227.xyz / float3(_227.w)) - View.View_PreViewTranslation;
    float4 _238 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _241 = (_238.xy * float2(2.0)) - float2(1.0);
    float _248 = sqrt(fast::clamp(1.0 - dot(_241, _241), 0.0, 1.0)) + 1.0;
    float4 _251 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 2.0), bias(View.View_MaterialTextureMipBias));
    float2 _254 = (_251.xy * float2(2.0)) - float2(1.0);
    float3 _263 = float4(_254, sqrt(fast::clamp(1.0 - dot(_254, _254), 0.0, 1.0)), 1.0).xyz * float3(-1.0, -1.0, 1.0);
    float3 _266 = float3(_241, _248);
    float3 _270 = float3(_263.xy * (-1.0), _263.z);
    float3 _282 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((((_266 * dot(_266, _270)) - (_270 * _248)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _294 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _299 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.02999999932944774627685546875), bias(View.View_MaterialTextureMipBias));
    float4 _308 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _312 = fast::clamp(mix(float3(0.5), float3(1.0), float3((_294.x + 0.5) * (_299.x + 0.5))) * _308.xyz, float3(0.0), float3(1.0));
    float _313 = fast::clamp(_308.w, 0.0, 1.0);
    float _317 = (0.980000019073486328125 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _318 = in.in_var_PRIMITIVE_ID * 36u;
    uint _319 = _318 + 20u;
    float _367;
    float _368;
    float _369;
    float3 _370;
    float3 _371;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _319)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _337 = ((_222.xy / float2(_222.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _341 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _337, level(0.0));
        float4 _344 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _337, level(0.0));
        float4 _347 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _337, level(0.0));
        float _357 = _347.w;
        _367 = (_317 * _357) + _347.z;
        _368 = (_313 * _357) + _347.y;
        _369 = _347.x;
        _370 = (_312 * _341.w) + _341.xyz;
        _371 = normalize((_282 * _344.w) + ((_344.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _367 = _317;
        _368 = _313;
        _369 = 0.0;
        _370 = _312;
        _371 = _282;
    }
    bool _381 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _387;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _318 + 18u)].w > 0.0) && _381)
    {
        _387 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _387 = 1.0;
    }
    float _434;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _319)].z > 0.0)
    {
        float3 _402 = fast::clamp((_232 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _413 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_402.x), int(_402.y), int(_402.z), 0).xyz), 0));
        _434 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_413.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_402 / float3(_413.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _434 = _387;
    }
    float3 _448 = ((_370 - (_370 * _369)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _455 = (mix(float3(0.07999999821186065673828125 * _368), _370, float3(_369)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _458 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _463;
    if (_458)
    {
        _463 = _448 + (_455 * 0.449999988079071044921875);
    }
    else
    {
        _463 = _448;
    }
    float3 _465 = select(_455, float3(0.0), bool3(_458));
    float3 _467 = float3(dot(_465, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _541;
    if (_381)
    {
        float3 _493 = fast::clamp((_232 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _497 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _493);
        float4 _501 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _493);
        float4 _504 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _493);
        float4 _522 = _165;
        _522.y = (-0.48860299587249755859375) * _371.y;
        float4 _525 = _522;
        _525.z = 0.48860299587249755859375 * _371.z;
        float4 _528 = _525;
        _528.w = (-0.48860299587249755859375) * _371.x;
        float4 _529 = _528;
        _529.x = 0.886227548122406005859375;
        float3 _531 = _529.yzw * 2.094395160675048828125;
        float4 _532 = float4(_529.x, _531.x, _531.y, _531.z);
        float3 _534 = float3(0.0);
        _534.x = dot(float4(_497.x, _501.x, _504.x, _497.w), _532);
        float3 _536 = _534;
        _536.y = dot(float4(_497.y, _501.y, _504.y, _501.w), _532);
        float3 _538 = _536;
        _538.z = dot(float4(_497.z, _501.z, _504.zw), _532);
        _541 = fast::max(float3(0.0), _538) * float3(0.3183098733425140380859375);
    }
    else
    {
        _541 = float3(0.0);
    }
    float _567;
    float _568;
    float3 _569;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _557;
        float _558;
        if (_381)
        {
            _557 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _558 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _557 = _371;
            _558 = 1.0;
        }
        float _559 = 1.0 - _558;
        float _561 = 1.0 - (_559 * _559);
        _567 = mix(fast::clamp(dot(_557, _371), 0.0, 1.0), 1.0, _561);
        _568 = _558;
        _569 = mix(_557, _371, float3(_561));
    }
    else
    {
        _567 = 1.0;
        _568 = 1.0;
        _569 = _371;
    }
    float4 _573 = float4(_569, 1.0);
    float3 _577 = _162;
    _577.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _573);
    float3 _581 = _577;
    _581.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _573);
    float3 _585 = _581;
    _585.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _573);
    float4 _588 = _573.xyzz * _573.yzzx;
    float3 _592 = _162;
    _592.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _588);
    float3 _596 = _592;
    _596.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _588);
    float3 _600 = _596;
    _600.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _588);
    float3 _615 = (_541 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_585 + _600) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_569.x * _569.x) - (_569.y * _569.y)))) * View.View_SkyLightColor.xyz) * (_568 * _567));
    float3 _637 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _666;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _665;
        if (any(abs(_232 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _318 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _318 + 19u)].xyz + float3(1.0))))
        {
            _665 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_232, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _665 = _637;
        }
        _666 = _665;
    }
    else
    {
        _666 = _637;
    }
    float4 _673 = float4(((mix(float3(0.0), _463 + (_465 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_615 * _463) * fast::max(float3(1.0), ((((((_370 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_370 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_370 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _666) * 1.0, 0.0);
    float4 _680;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _679 = _673;
        _679.w = 0.0;
        _680 = _679;
    }
    else
    {
        _680 = _673;
    }
    float2 _684 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _692 = (_371 * 0.5) + float3(0.5);
    float4 _694 = float4(_692.x, _692.y, _692.z, float4(0.0).w);
    _694.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _319)].y;
    float4 _695 = float4(0.0);
    _695.x = _369;
    float4 _696 = _695;
    _696.y = _368;
    float4 _697 = _696;
    _697.z = _367;
    float4 _698 = _697;
    _698.w = 0.50588238239288330078125;
    float4 _710 = float4(_370.x, _370.y, _370.z, float4(0.0).w);
    _710.w = ((log2(((dot(_615, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_467 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_467 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_467 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_684.xyx * _684.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _680 * View.View_PreExposure;
    out.out_var_SV_Target1 = _694;
    out.out_var_SV_Target2 = _698;
    out.out_var_SV_Target3 = _710;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_434, 1.0, 1.0, 1.0);
    return out;
}

