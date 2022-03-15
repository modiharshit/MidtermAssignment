

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
    char _m0_pad[256];
    float4x4 View_ViewToTranslatedWorld;
    char _m1_pad[384];
    float4x4 View_SVPositionToTranslatedWorld;
    char _m2_pad[288];
    float4 View_ScreenPositionScaleBias;
    float3 View_WorldCameraOrigin;
    char _m4_pad[32];
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
    char _m16_pad[400];
    packed_float3 View_NormalCurvatureToRoughnessScaleBias;
    float View_RenderingReflectionCaptureMask;
    char _m18_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m20_pad[124];
    float View_ShowDecalsMask;
    char _m21_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m22_pad[48];
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

struct type_PrimitiveDither
{
    float PrimitiveDither_LODFactor;
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
    spvUnsafeArray<float4, 4> Material_ScalarExpressions;
};

constant float _173 = {};
constant float4x4 _174 = {};
constant float4 _175 = {};
constant float3 _176 = {};
constant float _178 = {};
constant float4 _179 = {};
constant float3 _180 = {};

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
    float4 in_var_TEXCOORD15 [[user(locn2)]];
    float4 in_var_TEXCOORD0_0 [[user(locn3)]];
    uint in_var_PRIMITIVE_ID [[user(locn4)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00005f1f_3b09fe9d(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(6)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_PrimitiveDither& PrimitiveDither [[buffer(3)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(4)]], constant type_Material& Material [[buffer(5)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_3 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_3Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float3x3 _234 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _246 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _178, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _251 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _256 = (_251.xyz / float3(_251.w)) - View.View_PreViewTranslation;
    uint _257 = in.in_var_PRIMITIVE_ID * 36u;
    float4x4 _260 = _174;
    _260[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _257)];
    float4x4 _264 = _260;
    _264[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _257 + 1u)];
    float4x4 _268 = _264;
    _268[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _257 + 2u)];
    float4x4 _272 = _268;
    _272[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _257 + 3u)];
    float3 _275 = (_272 * float4(0.0, 0.0, 0.0, 1.0)).xyz - View.View_WorldCameraOrigin;
    float4 _287 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _290 = (float3(-0.5) + _287.xyz) * 2.0;
    float3 _306 = ((((_275 / float3(sqrt(dot(_275, _275)))) * _234) * (-1.0)) * _290.z) + (float3(_290.xy, 0.0) * ((float3x3(View.View_ViewToTranslatedWorld[0].xyz, View.View_ViewToTranslatedWorld[1].xyz, View.View_ViewToTranslatedWorld[2].xyz) * float3(1.0, 1.0, 0.0)) * _234));
    float3 _318 = normalize(_234 * normalize(((_306 / float3(sqrt(dot(_306, _306)))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _329 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _336 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    if (PrimitiveDither.PrimitiveDither_LODFactor != 0.0)
    {
        if (abs(PrimitiveDither.PrimitiveDither_LODFactor) > 0.001000000047497451305389404296875)
        {
            float _356 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
            if ((float((PrimitiveDither.PrimitiveDither_LODFactor < 0.0) ? ((PrimitiveDither.PrimitiveDither_LODFactor + 1.0) > _356) : (PrimitiveDither.PrimitiveDither_LODFactor < _356)) - 0.001000000047497451305389404296875) < 0.0)
            {
                discard_fragment();
            }
        }
    }
    if (((_329.w * in_var_TEXCOORD0[0].z) - 0.100000001490116119384765625) < 0.0)
    {
        discard_fragment();
    }
    float3 _371 = fast::clamp(_329.xyz, float3(0.0), float3(1.0));
    float _376 = (fast::clamp(_287.w, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float3 _386 = (fast::clamp(float4(_336.xyz, _173).xyz, float3(0.0), float3(1.0)).xyz * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    uint _387 = _257 + 20u;
    float3 _436;
    float _437;
    float _438;
    float _439;
    float3 _440;
    float3 _441;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _387)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _405 = ((_246.xy / float2(_246.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _409 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _405, level(0.0));
        float4 _412 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _405, level(0.0));
        float4 _415 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _405, level(0.0));
        float _417 = _409.w;
        float _425 = _415.w;
        _436 = _386 * _417;
        _437 = (_376 * _425) + _415.z;
        _438 = (0.5 * _425) + _415.y;
        _439 = _415.x;
        _440 = (_371 * _417) + _409.xyz;
        _441 = normalize((_318 * _412.w) + ((_412.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _436 = _386;
        _437 = _376;
        _438 = 0.5;
        _439 = 0.0;
        _440 = _371;
        _441 = _318;
    }
    bool _451 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _457;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _257 + 18u)].w > 0.0) && _451)
    {
        _457 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _457 = 1.0;
    }
    float _504;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _387)].z > 0.0)
    {
        float3 _472 = fast::clamp((_256 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _483 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_472.x), int(_472.y), int(_472.z), 0).xyz), 0));
        _504 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_483.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_472 / float3(_483.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _504 = _457;
    }
    float3 _507 = sqrt(fast::clamp(_436, float3(0.0), float3(1.0)));
    float4 _509 = float4(_507.x, _507.y, _507.z, float4(0.0).w);
    _509.w = 1.0;
    float3 _514 = dfdx(in.in_var_TEXCOORD15.xyz);
    float3 _515 = dfdy(in.in_var_TEXCOORD15.xyz);
    float3 _533 = ((_440 - (_440 * _439)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _540 = (mix(float3(0.07999999821186065673828125 * _438), _440, float3(_439)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _543 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _548;
    if (_543)
    {
        _548 = _533 + (_540 * 0.449999988079071044921875);
    }
    else
    {
        _548 = _533;
    }
    float3 _550 = select(_540, float3(0.0), bool3(_543));
    float3 _552 = float3(dot(_550, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _691;
    float3 _692;
    if (_451)
    {
        float4 _588 = _179;
        _588.y = (-0.48860299587249755859375) * _441.y;
        float4 _591 = _588;
        _591.z = 0.48860299587249755859375 * _441.z;
        float4 _594 = _591;
        _594.w = (-0.48860299587249755859375) * _441.x;
        float3 _595 = _441 * _441;
        float4 _598 = _175;
        _598.x = (1.09254801273345947265625 * _441.x) * _441.y;
        float4 _601 = _598;
        _601.y = ((-1.09254801273345947265625) * _441.y) * _441.z;
        float4 _606 = _601;
        _606.z = 0.3153919875621795654296875 * ((3.0 * _595.z) - 1.0);
        float4 _609 = _606;
        _609.w = ((-1.09254801273345947265625) * _441.x) * _441.z;
        float4 _613 = _594;
        _613.x = 0.886227548122406005859375;
        float3 _615 = _613.yzw * 2.094395160675048828125;
        float4 _616 = float4(_613.x, _615.x, _615.y, _615.z);
        float4 _617 = _609 * 0.785398185253143310546875;
        float _618 = (_595.x - _595.y) * 0.4290426075458526611328125;
        float3 _624 = float3(0.0);
        _624.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _616) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _617)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _618);
        float3 _630 = _624;
        _630.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _616) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _617)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _618);
        float3 _636 = _630;
        _636.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _616) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _617)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _618);
        float3 _638 = -_441;
        float _639 = _638.y;
        float4 _641 = _179;
        _641.y = (-0.48860299587249755859375) * _639;
        float _642 = _638.z;
        float4 _644 = _641;
        _644.z = 0.48860299587249755859375 * _642;
        float _645 = _638.x;
        float4 _647 = _644;
        _647.w = (-0.48860299587249755859375) * _645;
        float3 _648 = _638 * _638;
        float4 _651 = _175;
        _651.x = (1.09254801273345947265625 * _645) * _639;
        float4 _654 = _651;
        _654.y = ((-1.09254801273345947265625) * _639) * _642;
        float4 _659 = _654;
        _659.z = 0.3153919875621795654296875 * ((3.0 * _648.z) - 1.0);
        float4 _662 = _659;
        _662.w = ((-1.09254801273345947265625) * _645) * _642;
        float4 _666 = _647;
        _666.x = 0.886227548122406005859375;
        float3 _668 = _666.yzw * 2.094395160675048828125;
        float4 _669 = float4(_666.x, _668.x, _668.y, _668.z);
        float4 _670 = _662 * 0.785398185253143310546875;
        float _671 = (_648.x - _648.y) * 0.4290426075458526611328125;
        float3 _677 = _180;
        _677.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _669) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _670)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _671);
        float3 _683 = _677;
        _683.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _669) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _670)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _671);
        float3 _689 = _683;
        _689.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _669) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _670)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _671);
        _691 = fast::max(float3(0.0), _689);
        _692 = fast::max(float3(0.0), _636);
    }
    else
    {
        _691 = float3(0.0);
        _692 = float3(0.0);
    }
    float _719;
    float _720;
    float3 _721;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _709;
        float _710;
        if (_451)
        {
            _709 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _710 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _709 = _441;
            _710 = 1.0;
        }
        float _711 = 1.0 - _710;
        float _713 = 1.0 - (_711 * _711);
        _719 = mix(fast::clamp(dot(_709, _441), 0.0, 1.0), 1.0, _713);
        _720 = _710;
        _721 = mix(_709, _441, float3(_713));
    }
    else
    {
        _719 = 1.0;
        _720 = 1.0;
        _721 = _441;
    }
    float4 _725 = float4(_721, 1.0);
    float3 _729 = _176;
    _729.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _725);
    float3 _733 = _729;
    _733.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _725);
    float3 _737 = _733;
    _737.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _725);
    float4 _740 = _725.xyzz * _725.yzzx;
    float3 _744 = _176;
    _744.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _740);
    float3 _748 = _744;
    _748.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _740);
    float3 _752 = _748;
    _752.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _740);
    float3 _767 = -_441;
    float _768 = _767.x;
    float _769 = _767.y;
    float4 _771 = float4(_768, _769, _767.z, 1.0);
    float3 _774 = _180;
    _774.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _771);
    float3 _777 = _774;
    _777.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _771);
    float3 _780 = _777;
    _780.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _771);
    float4 _783 = _771.xyzz * _771.yzzx;
    float3 _786 = _180;
    _786.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _783);
    float3 _789 = _786;
    _789.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _783);
    float3 _792 = _789;
    _792.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _783);
    float3 _805 = (_692 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_737 + _752) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_721.x * _721.x) - (_721.y * _721.y)))) * View.View_SkyLightColor.xyz) * (_720 * _719));
    float3 _829 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _858;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _857;
        if (any(abs(_256 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _257 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _257 + 19u)].xyz + float3(1.0))))
        {
            _857 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_256, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _857 = _829;
        }
        _858 = _857;
    }
    else
    {
        _858 = _829;
    }
    float4 _865 = float4(((mix(float3(0.0), _548 + (_550 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + (((_805 * _548) + (((_691 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_780 + _792) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_768 * _768) - (_769 * _769)))) * View.View_SkyLightColor.xyz) * _720)) * _436)) * fast::max(float3(1.0), ((((((_440 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_440 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_440 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _858) * 1.0, 0.0);
    float4 _872;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _871 = _865;
        _871.w = 0.0;
        _872 = _871;
    }
    else
    {
        _872 = _865;
    }
    float2 _876 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _884 = (_441 * 0.5) + float3(0.5);
    float4 _886 = float4(_884.x, _884.y, _884.z, float4(0.0).w);
    _886.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _387)].y;
    float4 _887 = float4(0.0);
    _887.x = _439;
    float4 _888 = _887;
    _888.y = _438;
    float4 _889 = _888;
    _889.z = fast::max(_437, fast::clamp((pow(fast::max(dot(_514, _514), dot(_515, _515)), View.View_NormalCurvatureToRoughnessScaleBias[2]) * View.View_NormalCurvatureToRoughnessScaleBias[0]) + View.View_NormalCurvatureToRoughnessScaleBias[1], 0.0, 1.0));
    float4 _890 = _889;
    _890.w = 0.525490224361419677734375;
    float4 _902 = float4(_440.x, _440.y, _440.z, float4(0.0).w);
    _902.w = ((log2(((dot(_805, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_552 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_552 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_552 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_876.xyx * _876.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _872 * View.View_PreExposure;
    out.out_var_SV_Target1 = _886;
    out.out_var_SV_Target2 = _890;
    out.out_var_SV_Target3 = _902;
    out.out_var_SV_Target4 = _509;
    out.out_var_SV_Target5 = float4(_504, 1.0, 1.0, 1.0);
    return out;
}

