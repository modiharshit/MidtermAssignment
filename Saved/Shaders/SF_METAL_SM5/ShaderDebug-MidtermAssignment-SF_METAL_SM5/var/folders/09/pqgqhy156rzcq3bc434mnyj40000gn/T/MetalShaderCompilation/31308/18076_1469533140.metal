

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
    spvUnsafeArray<float4, 6> Material_VectorExpressions;
    spvUnsafeArray<float4, 2> Material_ScalarExpressions;
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

fragment MainPS_out Main_0000469c_57974bd4(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _220 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _162, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _225 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _230 = (_225.xyz / float3(_225.w)) - View.View_PreViewTranslation;
    float4 _236 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _239 = (_236.xy * float2(2.0)) - float2(1.0);
    float3 _255 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_239, sqrt(fast::clamp(1.0 - dot(_239, _239), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _266 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _273 = _266.y;
    float3 _288 = fast::clamp(mix(Material.Material_VectorExpressions[4].xyz, Material.Material_VectorExpressions[5].xyz, float3(_273)) * _266.x, float3(0.0), float3(1.0));
    float _289 = fast::clamp(mix(Material.Material_ScalarExpressions[0].y, Material.Material_ScalarExpressions[0].z, _273), 0.0, 1.0);
    float _294 = (fast::clamp(mix(Material.Material_ScalarExpressions[0].w, Material.Material_ScalarExpressions[1].x, _273), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _295 = in.in_var_PRIMITIVE_ID * 36u;
    uint _296 = _295 + 20u;
    float _346;
    float _347;
    float _348;
    float3 _349;
    float3 _350;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _296)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _314 = ((_220.xy / float2(_220.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _318 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _314, level(0.0));
        float4 _321 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _314, level(0.0));
        float4 _324 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _314, level(0.0));
        float _334 = _324.w;
        _346 = (_294 * _334) + _324.z;
        _347 = (0.5 * _334) + _324.y;
        _348 = (_289 * _334) + _324.x;
        _349 = (_288 * _318.w) + _318.xyz;
        _350 = normalize((_255 * _321.w) + ((_321.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _346 = _294;
        _347 = 0.5;
        _348 = _289;
        _349 = _288;
        _350 = _255;
    }
    bool _360 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _366;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _295 + 18u)].w > 0.0) && _360)
    {
        _366 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _366 = 1.0;
    }
    float _413;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _296)].z > 0.0)
    {
        float3 _381 = fast::clamp((_230 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _392 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_381.x), int(_381.y), int(_381.z), 0).xyz), 0));
        _413 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_392.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_381 / float3(_392.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _413 = _366;
    }
    float3 _427 = ((_349 - (_349 * _348)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _434 = (mix(float3(0.07999999821186065673828125 * _347), _349, float3(_348)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _437 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _442;
    if (_437)
    {
        _442 = _427 + (_434 * 0.449999988079071044921875);
    }
    else
    {
        _442 = _427;
    }
    float3 _444 = select(_434, float3(0.0), bool3(_437));
    float3 _446 = float3(dot(_444, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _532;
    if (_360)
    {
        float4 _482 = _163;
        _482.y = (-0.48860299587249755859375) * _350.y;
        float4 _485 = _482;
        _485.z = 0.48860299587249755859375 * _350.z;
        float4 _488 = _485;
        _488.w = (-0.48860299587249755859375) * _350.x;
        float3 _489 = _350 * _350;
        float4 _492 = _159;
        _492.x = (1.09254801273345947265625 * _350.x) * _350.y;
        float4 _495 = _492;
        _495.y = ((-1.09254801273345947265625) * _350.y) * _350.z;
        float4 _500 = _495;
        _500.z = 0.3153919875621795654296875 * ((3.0 * _489.z) - 1.0);
        float4 _503 = _500;
        _503.w = ((-1.09254801273345947265625) * _350.x) * _350.z;
        float4 _507 = _488;
        _507.x = 0.886227548122406005859375;
        float3 _509 = _507.yzw * 2.094395160675048828125;
        float4 _510 = float4(_507.x, _509.x, _509.y, _509.z);
        float4 _511 = _503 * 0.785398185253143310546875;
        float _512 = (_489.x - _489.y) * 0.4290426075458526611328125;
        float3 _518 = float3(0.0);
        _518.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _510) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _511)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _512);
        float3 _524 = _518;
        _524.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _510) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _511)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _512);
        float3 _530 = _524;
        _530.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _510) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _511)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _512);
        _532 = fast::max(float3(0.0), _530);
    }
    else
    {
        _532 = float3(0.0);
    }
    float _558;
    float _559;
    float3 _560;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _548;
        float _549;
        if (_360)
        {
            _548 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _549 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _548 = _350;
            _549 = 1.0;
        }
        float _550 = 1.0 - _549;
        float _552 = 1.0 - (_550 * _550);
        _558 = mix(fast::clamp(dot(_548, _350), 0.0, 1.0), 1.0, _552);
        _559 = _549;
        _560 = mix(_548, _350, float3(_552));
    }
    else
    {
        _558 = 1.0;
        _559 = 1.0;
        _560 = _350;
    }
    float4 _564 = float4(_560, 1.0);
    float3 _568 = _160;
    _568.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _564);
    float3 _572 = _568;
    _572.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _564);
    float3 _576 = _572;
    _576.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _564);
    float4 _579 = _564.xyzz * _564.yzzx;
    float3 _583 = _160;
    _583.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _579);
    float3 _587 = _583;
    _587.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _579);
    float3 _591 = _587;
    _591.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _579);
    float3 _606 = (_532 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_576 + _591) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_560.x * _560.x) - (_560.y * _560.y)))) * View.View_SkyLightColor.xyz) * (_559 * _558));
    float3 _628 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _657;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _656;
        if (any(abs(_230 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _295 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _295 + 19u)].xyz + float3(1.0))))
        {
            _656 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_230, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _656 = _628;
        }
        _657 = _656;
    }
    else
    {
        _657 = _628;
    }
    float4 _664 = float4(((mix(float3(0.0), _442 + (_444 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_606 * _442) * fast::max(float3(1.0), ((((((_349 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_349 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_349 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _657) * 1.0, 0.0);
    float4 _671;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _670 = _664;
        _670.w = 0.0;
        _671 = _670;
    }
    else
    {
        _671 = _664;
    }
    float2 _675 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _683 = (_350 * 0.5) + float3(0.5);
    float4 _685 = float4(_683.x, _683.y, _683.z, float4(0.0).w);
    _685.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _296)].y;
    float4 _686 = float4(0.0);
    _686.x = _348;
    float4 _687 = _686;
    _687.y = _347;
    float4 _688 = _687;
    _688.z = _346;
    float4 _689 = _688;
    _689.w = 0.50588238239288330078125;
    float4 _701 = float4(_349.x, _349.y, _349.z, float4(0.0).w);
    _701.w = ((log2(((dot(_606, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_446 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_446 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_446 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_675.xyx * _675.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _671 * View.View_PreExposure;
    out.out_var_SV_Target1 = _685;
    out.out_var_SV_Target2 = _689;
    out.out_var_SV_Target3 = _701;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_413, 1.0, 1.0, 1.0);
    return out;
}

