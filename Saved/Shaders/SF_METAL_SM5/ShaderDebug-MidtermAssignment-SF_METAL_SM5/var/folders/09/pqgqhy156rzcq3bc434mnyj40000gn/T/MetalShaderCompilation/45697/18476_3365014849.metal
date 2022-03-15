

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
    char _m11_pad[80];
    float View_UnlitViewmodeMask;
    char _m12_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m13_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m14_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m16_pad[124];
    float View_ShowDecalsMask;
    char _m17_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m18_pad[48];
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
    spvUnsafeArray<float4, 7> Material_VectorExpressions;
    spvUnsafeArray<float4, 2> Material_ScalarExpressions;
};

constant float4 _165 = {};
constant float3 _166 = {};
constant float _168 = {};
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

fragment MainPS_out Main_0000482c_c8920d41(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(6)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_PrimitiveDither& PrimitiveDither [[buffer(3)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(4)]], constant type_Material& Material [[buffer(5)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], sampler View_MaterialTextureBilinearClampedSampler [[sampler(0)]], sampler View_SharedBilinearClampedSampler [[sampler(1)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _225 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _168, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _230 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _235 = (_230.xyz / float3(_230.w)) - View.View_PreViewTranslation;
    float4 _239 = Material_Texture2D_0.sample(View_MaterialTextureBilinearClampedSampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y));
    float2 _242 = (_239.xy * float2(2.0)) - float2(1.0);
    float3 _258 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_242, sqrt(fast::clamp(1.0 - dot(_242, _242), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    if (PrimitiveDither.PrimitiveDither_LODFactor != 0.0)
    {
        if (abs(PrimitiveDither.PrimitiveDither_LODFactor) > 0.001000000047497451305389404296875)
        {
            float _293 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
            if ((float((PrimitiveDither.PrimitiveDither_LODFactor < 0.0) ? ((PrimitiveDither.PrimitiveDither_LODFactor + 1.0) > _293) : (PrimitiveDither.PrimitiveDither_LODFactor < _293)) - 0.001000000047497451305389404296875) < 0.0)
            {
                discard_fragment();
            }
        }
    }
    float3 _304 = fast::clamp(Material.Material_VectorExpressions[6].xyz, float3(0.0), float3(1.0));
    float _305 = fast::clamp(Material.Material_ScalarExpressions[0].z, 0.0, 1.0);
    float _306 = fast::clamp(Material.Material_ScalarExpressions[0].w, 0.0, 1.0);
    float _307 = fast::clamp(Material.Material_ScalarExpressions[1].y, 0.0, 1.0);
    float _312 = (fast::clamp(Material.Material_ScalarExpressions[1].x, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _313 = in.in_var_PRIMITIVE_ID * 36u;
    uint _314 = _313 + 20u;
    float _364;
    float _365;
    float _366;
    float3 _367;
    float3 _368;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _314)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _332 = ((_225.xy / float2(_225.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _336 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _332, level(0.0));
        float4 _339 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _332, level(0.0));
        float4 _342 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _332, level(0.0));
        float _352 = _342.w;
        _364 = (_312 * _352) + _342.z;
        _365 = (_306 * _352) + _342.y;
        _366 = (_305 * _352) + _342.x;
        _367 = (_304 * _336.w) + _336.xyz;
        _368 = normalize((_258 * _339.w) + ((_339.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _364 = _312;
        _365 = _306;
        _366 = _305;
        _367 = _304;
        _368 = _258;
    }
    bool _378 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _384;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _313 + 18u)].w > 0.0) && _378)
    {
        _384 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _384 = 1.0;
    }
    float _431;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _314)].z > 0.0)
    {
        float3 _399 = fast::clamp((_235 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _410 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_399.x), int(_399.y), int(_399.z), 0).xyz), 0));
        _431 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_410.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_399 / float3(_410.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _431 = _384;
    }
    float3 _445 = ((_367 - (_367 * _366)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _452 = (mix(float3(0.07999999821186065673828125 * _365), _367, float3(_366)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _455 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _460;
    if (_455)
    {
        _460 = _445 + (_452 * 0.449999988079071044921875);
    }
    else
    {
        _460 = _445;
    }
    float3 _462 = select(_452, float3(0.0), bool3(_455));
    float3 _464 = float3(dot(_462, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _471 = float3(_307);
    float3 _551;
    if (_378)
    {
        float4 _501 = _169;
        _501.y = (-0.48860299587249755859375) * _368.y;
        float4 _504 = _501;
        _504.z = 0.48860299587249755859375 * _368.z;
        float4 _507 = _504;
        _507.w = (-0.48860299587249755859375) * _368.x;
        float3 _508 = _368 * _368;
        float4 _511 = _165;
        _511.x = (1.09254801273345947265625 * _368.x) * _368.y;
        float4 _514 = _511;
        _514.y = ((-1.09254801273345947265625) * _368.y) * _368.z;
        float4 _519 = _514;
        _519.z = 0.3153919875621795654296875 * ((3.0 * _508.z) - 1.0);
        float4 _522 = _519;
        _522.w = ((-1.09254801273345947265625) * _368.x) * _368.z;
        float4 _526 = _507;
        _526.x = 0.886227548122406005859375;
        float3 _528 = _526.yzw * 2.094395160675048828125;
        float4 _529 = float4(_526.x, _528.x, _528.y, _528.z);
        float4 _530 = _522 * 0.785398185253143310546875;
        float _531 = (_508.x - _508.y) * 0.4290426075458526611328125;
        float3 _537 = float3(0.0);
        _537.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _529) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _530)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _531);
        float3 _543 = _537;
        _543.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _529) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _530)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _531);
        float3 _549 = _543;
        _549.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _529) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _530)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _531);
        _551 = fast::max(float3(0.0), _549);
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
        if (_378)
        {
            _567 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _568 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _567 = _368;
            _568 = 1.0;
        }
        float _569 = 1.0 - _568;
        float _571 = 1.0 - (_569 * _569);
        _577 = mix(fast::clamp(dot(_567, _368), 0.0, 1.0), 1.0, _571);
        _578 = _568;
        _579 = mix(_567, _368, float3(_571));
    }
    else
    {
        _577 = 1.0;
        _578 = 1.0;
        _579 = _368;
    }
    float4 _583 = float4(_579, 1.0);
    float3 _587 = _166;
    _587.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _583);
    float3 _591 = _587;
    _591.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _583);
    float3 _595 = _591;
    _595.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _583);
    float4 _598 = _583.xyzz * _583.yzzx;
    float3 _602 = _166;
    _602.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _598);
    float3 _606 = _602;
    _606.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _598);
    float3 _610 = _606;
    _610.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _598);
    float3 _625 = (_551 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_595 + _610) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_579.x * _579.x) - (_579.y * _579.y)))) * View.View_SkyLightColor.xyz) * (_578 * _577));
    float3 _647 = fast::max(mix(Material.Material_VectorExpressions[3].xyz, Material.Material_VectorExpressions[4].xyz, float3(Material.Material_ScalarExpressions[0].y)), float3(0.0));
    float3 _676;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _675;
        if (any(abs(_235 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _313 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _313 + 19u)].xyz + float3(1.0))))
        {
            _675 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_235, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _675 = _647;
        }
        _676 = _675;
    }
    else
    {
        _676 = _647;
    }
    float4 _683 = float4(((mix(float3(0.0), _460 + (_462 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_625 * _460) * fast::max(_471, ((((((_367 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _307) + ((_367 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _307) + ((_367 * 2.755199909210205078125) + float3(0.69029998779296875))) * _307))) + _676) * 1.0, 0.0);
    float4 _690;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _689 = _683;
        _689.w = 0.0;
        _690 = _689;
    }
    else
    {
        _690 = _683;
    }
    float2 _694 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _702 = (_368 * 0.5) + float3(0.5);
    float4 _704 = float4(_702.x, _702.y, _702.z, float4(0.0).w);
    _704.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _314)].y;
    float4 _705 = float4(0.0);
    _705.x = _366;
    float4 _706 = _705;
    _706.y = _365;
    float4 _707 = _706;
    _707.z = _364;
    float4 _708 = _707;
    _708.w = 0.50588238239288330078125;
    float4 _720 = float4(_367.x, _367.y, _367.z, float4(0.0).w);
    _720.w = ((log2(((dot(_625, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_471, ((((((_464 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _307) + ((_464 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _307) + ((_464 * 2.755199909210205078125) + float3(0.69029998779296875))) * _307).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_694.xyx * _694.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _690 * View.View_PreExposure;
    out.out_var_SV_Target1 = _704;
    out.out_var_SV_Target2 = _708;
    out.out_var_SV_Target3 = _720;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_431, 1.0, 1.0, 1.0);
    return out;
}

