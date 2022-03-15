

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
    char _m11_pad[24];
    float View_CullingSign;
    char _m12_pad[20];
    float View_MaterialTextureMipBias;
    char _m13_pad[28];
    float View_UnlitViewmodeMask;
    char _m14_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m15_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m16_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m18_pad[124];
    float View_ShowDecalsMask;
    char _m19_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m20_pad[48];
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
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _159 = {};
constant float3 _160 = {};
constant float _162 = {};
constant float4 _163 = {};

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

fragment MainPS_out Main_00004662_7ecb2004(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]], bool gl_FrontFacing [[front_facing]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _224 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _162, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _229 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _234 = (_229.xyz / float3(_229.w)) - View.View_PreViewTranslation;
    uint _235 = in.in_var_PRIMITIVE_ID * 36u;
    float4 _249 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _252 = (_249.xy * float2(2.0)) - float2(1.0);
    float3 _268 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_252, sqrt(fast::clamp(1.0 - dot(_252, _252), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * ((View.View_CullingSign * View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _235 + 4u)].w) * float(gl_FrontFacing ? 1 : (-1)));
    float4 _279 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    if ((_279.w - 0.33329999446868896484375) < 0.0)
    {
        discard_fragment();
    }
    float3 _286 = fast::clamp(_279.xyz, float3(0.0), float3(1.0));
    float _290 = (0.5 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _291 = _235 + 20u;
    float _339;
    float _340;
    float _341;
    float3 _342;
    float3 _343;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _291)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _309 = ((_224.xy / float2(_224.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _313 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _309, level(0.0));
        float4 _316 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _309, level(0.0));
        float4 _319 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _309, level(0.0));
        float _329 = _319.w;
        _339 = (_290 * _329) + _319.z;
        _340 = (0.5 * _329) + _319.y;
        _341 = _319.x;
        _342 = (_286 * _313.w) + _313.xyz;
        _343 = normalize((_268 * _316.w) + ((_316.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _339 = _290;
        _340 = 0.5;
        _341 = 0.0;
        _342 = _286;
        _343 = _268;
    }
    bool _353 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _359;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _235 + 18u)].w > 0.0) && _353)
    {
        _359 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _359 = 1.0;
    }
    float _406;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _291)].z > 0.0)
    {
        float3 _374 = fast::clamp((_234 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _385 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_374.x), int(_374.y), int(_374.z), 0).xyz), 0));
        _406 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_385.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_374 / float3(_385.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _406 = _359;
    }
    float3 _420 = ((_342 - (_342 * _341)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _427 = (mix(float3(0.07999999821186065673828125 * _340), _342, float3(_341)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _430 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _435;
    if (_430)
    {
        _435 = _420 + (_427 * 0.449999988079071044921875);
    }
    else
    {
        _435 = _420;
    }
    float3 _437 = select(_427, float3(0.0), bool3(_430));
    float3 _439 = float3(dot(_437, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _525;
    if (_353)
    {
        float4 _475 = _163;
        _475.y = (-0.48860299587249755859375) * _343.y;
        float4 _478 = _475;
        _478.z = 0.48860299587249755859375 * _343.z;
        float4 _481 = _478;
        _481.w = (-0.48860299587249755859375) * _343.x;
        float3 _482 = _343 * _343;
        float4 _485 = _159;
        _485.x = (1.09254801273345947265625 * _343.x) * _343.y;
        float4 _488 = _485;
        _488.y = ((-1.09254801273345947265625) * _343.y) * _343.z;
        float4 _493 = _488;
        _493.z = 0.3153919875621795654296875 * ((3.0 * _482.z) - 1.0);
        float4 _496 = _493;
        _496.w = ((-1.09254801273345947265625) * _343.x) * _343.z;
        float4 _500 = _481;
        _500.x = 0.886227548122406005859375;
        float3 _502 = _500.yzw * 2.094395160675048828125;
        float4 _503 = float4(_500.x, _502.x, _502.y, _502.z);
        float4 _504 = _496 * 0.785398185253143310546875;
        float _505 = (_482.x - _482.y) * 0.4290426075458526611328125;
        float3 _511 = float3(0.0);
        _511.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _503) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _504)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _505);
        float3 _517 = _511;
        _517.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _503) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _504)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _505);
        float3 _523 = _517;
        _523.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _503) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _504)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _505);
        _525 = fast::max(float3(0.0), _523);
    }
    else
    {
        _525 = float3(0.0);
    }
    float _551;
    float _552;
    float3 _553;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _541;
        float _542;
        if (_353)
        {
            _541 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _542 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _541 = _343;
            _542 = 1.0;
        }
        float _543 = 1.0 - _542;
        float _545 = 1.0 - (_543 * _543);
        _551 = mix(fast::clamp(dot(_541, _343), 0.0, 1.0), 1.0, _545);
        _552 = _542;
        _553 = mix(_541, _343, float3(_545));
    }
    else
    {
        _551 = 1.0;
        _552 = 1.0;
        _553 = _343;
    }
    float4 _557 = float4(_553, 1.0);
    float3 _561 = _160;
    _561.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _557);
    float3 _565 = _561;
    _565.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _557);
    float3 _569 = _565;
    _569.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _557);
    float4 _572 = _557.xyzz * _557.yzzx;
    float3 _576 = _160;
    _576.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _572);
    float3 _580 = _576;
    _580.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _572);
    float3 _584 = _580;
    _584.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _572);
    float3 _599 = (_525 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_569 + _584) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_553.x * _553.x) - (_553.y * _553.y)))) * View.View_SkyLightColor.xyz) * (_552 * _551));
    float3 _621 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _650;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _649;
        if (any(abs(_234 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _235 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _235 + 19u)].xyz + float3(1.0))))
        {
            _649 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_234, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _649 = _621;
        }
        _650 = _649;
    }
    else
    {
        _650 = _621;
    }
    float4 _657 = float4(((mix(float3(0.0), _435 + (_437 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_599 * _435) * fast::max(float3(1.0), ((((((_342 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_342 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_342 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _650) * 1.0, 0.0);
    float4 _664;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _663 = _657;
        _663.w = 0.0;
        _664 = _663;
    }
    else
    {
        _664 = _657;
    }
    float2 _668 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _676 = (_343 * 0.5) + float3(0.5);
    float4 _678 = float4(_676.x, _676.y, _676.z, float4(0.0).w);
    _678.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _291)].y;
    float4 _679 = float4(0.0);
    _679.x = _341;
    float4 _680 = _679;
    _680.y = _340;
    float4 _681 = _680;
    _681.z = _339;
    float4 _682 = _681;
    _682.w = 0.50588238239288330078125;
    float4 _694 = float4(_342.x, _342.y, _342.z, float4(0.0).w);
    _694.w = ((log2(((dot(_599, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_439 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_439 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_439 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_668.xyx * _668.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _664 * View.View_PreExposure;
    out.out_var_SV_Target1 = _678;
    out.out_var_SV_Target2 = _682;
    out.out_var_SV_Target3 = _694;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_406, 1.0, 1.0, 1.0);
    return out;
}

