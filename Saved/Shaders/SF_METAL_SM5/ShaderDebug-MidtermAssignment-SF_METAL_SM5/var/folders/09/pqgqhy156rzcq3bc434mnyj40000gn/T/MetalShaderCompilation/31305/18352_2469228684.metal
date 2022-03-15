

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
    char _m0_pad[64];
    float4 IndirectLightingCache_PointSkyBentNormal;
    float IndirectLightingCache_DirectionalLightShadowing;
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients0;
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients1;
    float4 IndirectLightingCache_IndirectLightingSHCoefficients2;
};

struct type_Material
{
    spvUnsafeArray<float4, 10> Material_VectorExpressions;
    spvUnsafeArray<float4, 2> Material_ScalarExpressions;
};

constant float4 _161 = {};
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

fragment MainPS_out Main_000047b0_932d708c(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _221 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _164, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _226 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _231 = (_226.xyz / float3(_226.w)) - View.View_PreViewTranslation;
    float4 _237 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _240 = (_237.xy * float2(2.0)) - float2(1.0);
    float3 _256 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_240, sqrt(fast::clamp(1.0 - dot(_240, _240), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _260 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _264 = _260.z;
    float _287 = _260.y;
    float3 _308 = fast::clamp(mix(mix(Material.Material_VectorExpressions[6].xyz, Material.Material_VectorExpressions[7].xyz, float3(_264)), Material.Material_VectorExpressions[9].xyz, float3(_287)) * _260.x, float3(0.0), float3(1.0));
    float _309 = fast::clamp(mix(mix(Material.Material_ScalarExpressions[0].z, Material.Material_ScalarExpressions[0].w, _264), Material.Material_ScalarExpressions[1].x, _287), 0.0, 1.0);
    float _314 = (fast::clamp(mix(mix(Material.Material_ScalarExpressions[1].y, Material.Material_ScalarExpressions[1].z, _264), Material.Material_ScalarExpressions[1].w, _287), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _315 = in.in_var_PRIMITIVE_ID * 36u;
    uint _316 = _315 + 20u;
    float _366;
    float _367;
    float _368;
    float3 _369;
    float3 _370;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _316)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _334 = ((_221.xy / float2(_221.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _338 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _334, level(0.0));
        float4 _341 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _334, level(0.0));
        float4 _344 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _334, level(0.0));
        float _354 = _344.w;
        _366 = (_314 * _354) + _344.z;
        _367 = (0.5 * _354) + _344.y;
        _368 = (_309 * _354) + _344.x;
        _369 = (_308 * _338.w) + _338.xyz;
        _370 = normalize((_256 * _341.w) + ((_341.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _366 = _314;
        _367 = 0.5;
        _368 = _309;
        _369 = _308;
        _370 = _256;
    }
    bool _380 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _386;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _315 + 18u)].w > 0.0) && _380)
    {
        _386 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _386 = 1.0;
    }
    float _433;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _316)].z > 0.0)
    {
        float3 _401 = fast::clamp((_231 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _412 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_401.x), int(_401.y), int(_401.z), 0).xyz), 0));
        _433 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_412.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_401 / float3(_412.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _433 = _386;
    }
    float3 _447 = ((_369 - (_369 * _368)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _454 = (mix(float3(0.07999999821186065673828125 * _367), _369, float3(_368)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _457 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _462;
    if (_457)
    {
        _462 = _447 + (_454 * 0.449999988079071044921875);
    }
    else
    {
        _462 = _447;
    }
    float3 _464 = select(_454, float3(0.0), bool3(_457));
    float3 _466 = float3(dot(_464, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _552;
    if (_380)
    {
        float4 _502 = _165;
        _502.y = (-0.48860299587249755859375) * _370.y;
        float4 _505 = _502;
        _505.z = 0.48860299587249755859375 * _370.z;
        float4 _508 = _505;
        _508.w = (-0.48860299587249755859375) * _370.x;
        float3 _509 = _370 * _370;
        float4 _512 = _161;
        _512.x = (1.09254801273345947265625 * _370.x) * _370.y;
        float4 _515 = _512;
        _515.y = ((-1.09254801273345947265625) * _370.y) * _370.z;
        float4 _520 = _515;
        _520.z = 0.3153919875621795654296875 * ((3.0 * _509.z) - 1.0);
        float4 _523 = _520;
        _523.w = ((-1.09254801273345947265625) * _370.x) * _370.z;
        float4 _527 = _508;
        _527.x = 0.886227548122406005859375;
        float3 _529 = _527.yzw * 2.094395160675048828125;
        float4 _530 = float4(_527.x, _529.x, _529.y, _529.z);
        float4 _531 = _523 * 0.785398185253143310546875;
        float _532 = (_509.x - _509.y) * 0.4290426075458526611328125;
        float3 _538 = float3(0.0);
        _538.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _530) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _531)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _532);
        float3 _544 = _538;
        _544.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _530) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _531)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _532);
        float3 _550 = _544;
        _550.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _530) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _531)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _532);
        _552 = fast::max(float3(0.0), _550);
    }
    else
    {
        _552 = float3(0.0);
    }
    float _578;
    float _579;
    float3 _580;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _568;
        float _569;
        if (_380)
        {
            _568 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _569 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _568 = _370;
            _569 = 1.0;
        }
        float _570 = 1.0 - _569;
        float _572 = 1.0 - (_570 * _570);
        _578 = mix(fast::clamp(dot(_568, _370), 0.0, 1.0), 1.0, _572);
        _579 = _569;
        _580 = mix(_568, _370, float3(_572));
    }
    else
    {
        _578 = 1.0;
        _579 = 1.0;
        _580 = _370;
    }
    float4 _584 = float4(_580, 1.0);
    float3 _588 = _162;
    _588.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _584);
    float3 _592 = _588;
    _592.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _584);
    float3 _596 = _592;
    _596.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _584);
    float4 _599 = _584.xyzz * _584.yzzx;
    float3 _603 = _162;
    _603.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _599);
    float3 _607 = _603;
    _607.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _599);
    float3 _611 = _607;
    _611.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _599);
    float3 _626 = (_552 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_596 + _611) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_580.x * _580.x) - (_580.y * _580.y)))) * View.View_SkyLightColor.xyz) * (_579 * _578));
    float3 _648 = fast::max(mix((Material.Material_VectorExpressions[2].xyz * _264) * Material.Material_ScalarExpressions[0].x, Material.Material_VectorExpressions[3].xyz, float3(Material.Material_ScalarExpressions[0].y)), float3(0.0));
    float3 _677;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _676;
        if (any(abs(_231 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _315 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _315 + 19u)].xyz + float3(1.0))))
        {
            _676 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_231, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _676 = _648;
        }
        _677 = _676;
    }
    else
    {
        _677 = _648;
    }
    float4 _684 = float4(((mix(float3(0.0), _462 + (_464 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_626 * _462) * fast::max(float3(1.0), ((((((_369 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_369 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_369 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _677) * 1.0, 0.0);
    float4 _691;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _690 = _684;
        _690.w = 0.0;
        _691 = _690;
    }
    else
    {
        _691 = _684;
    }
    float2 _695 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _703 = (_370 * 0.5) + float3(0.5);
    float4 _705 = float4(_703.x, _703.y, _703.z, float4(0.0).w);
    _705.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _316)].y;
    float4 _706 = float4(0.0);
    _706.x = _368;
    float4 _707 = _706;
    _707.y = _367;
    float4 _708 = _707;
    _708.z = _366;
    float4 _709 = _708;
    _709.w = 0.50588238239288330078125;
    float4 _721 = float4(_369.x, _369.y, _369.z, float4(0.0).w);
    _721.w = ((log2(((dot(_626, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_466 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_466 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_466 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_695.xyx * _695.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _691 * View.View_PreExposure;
    out.out_var_SV_Target1 = _705;
    out.out_var_SV_Target2 = _709;
    out.out_var_SV_Target3 = _721;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_433, 1.0, 1.0, 1.0);
    return out;
}

