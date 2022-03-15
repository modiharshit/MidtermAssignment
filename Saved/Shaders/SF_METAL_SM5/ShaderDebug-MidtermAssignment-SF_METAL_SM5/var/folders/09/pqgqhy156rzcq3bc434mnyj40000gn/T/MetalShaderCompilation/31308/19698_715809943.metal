

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
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _171 = {};
constant float3 _172 = {};
constant float _174 = {};
constant float4 _175 = {};

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

fragment MainPS_out Main_00004cf2_2aaa6497(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], texture2d<float> Material_Texture2D_4 [[texture(9)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], sampler Material_Texture2D_4Sampler [[sampler(6)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float3x3 _221 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _232 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _174, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _237 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _241 = _237.xyz / float3(_237.w);
    float3 _242 = _241 - View.View_PreViewTranslation;
    float2 _246 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5;
    float4 _252 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _246, bias(View.View_MaterialTextureMipBias));
    float2 _258 = ((normalize(-_241) * _221).xy * ((0.00999999977648258209228515625 * _252.w) + (-0.004999999888241291046142578125))) + _246;
    float4 _262 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _258, bias(View.View_MaterialTextureMipBias));
    float2 _265 = (_262.xy * float2(2.0)) - float2(1.0);
    float4 _278 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.100000001490116119384765625), bias(2.0 + View.View_MaterialTextureMipBias));
    float2 _281 = (_278.xy * float2(2.0)) - float2(1.0);
    float3 _300 = normalize(_221 * normalize(((float4(_265, sqrt(fast::clamp(1.0 - dot(_265, _265), 0.0, 1.0)), 1.0).xyz + (float4(_281, sqrt(fast::clamp(1.0 - dot(_281, _281), 0.0, 1.0)), 1.0).xyz * float3(0.20000000298023223876953125, 0.20000000298023223876953125, 0.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _312 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _317 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _320 = (_312.x + 0.5) * (_317.x + 0.5);
    float4 _323 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _258, bias(View.View_MaterialTextureMipBias));
    float4 _329 = Material_Texture2D_4.sample(Material_Texture2D_4Sampler, _258, bias(View.View_MaterialTextureMipBias));
    float3 _335 = fast::clamp(_323.xyz * mix(0.5, 1.0, _320), float3(0.0), float3(1.0));
    float _336 = fast::clamp(_329.y, 0.0, 1.0);
    float _341 = (fast::clamp(mix(-0.300000011920928955078125, 0.800000011920928955078125, _329.x + (_320 * 0.20000000298023223876953125)), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _342 = in.in_var_PRIMITIVE_ID * 36u;
    uint _343 = _342 + 20u;
    float _391;
    float _392;
    float _393;
    float3 _394;
    float3 _395;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _343)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _361 = ((_232.xy / float2(_232.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _365 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _361, level(0.0));
        float4 _368 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _361, level(0.0));
        float4 _371 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _361, level(0.0));
        float _381 = _371.w;
        _391 = (_341 * _381) + _371.z;
        _392 = (0.5 * _381) + _371.y;
        _393 = _371.x;
        _394 = (_335 * _365.w) + _365.xyz;
        _395 = normalize((_300 * _368.w) + ((_368.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _391 = _341;
        _392 = 0.5;
        _393 = 0.0;
        _394 = _335;
        _395 = _300;
    }
    bool _405 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _411;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _342 + 18u)].w > 0.0) && _405)
    {
        _411 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _411 = 1.0;
    }
    float _458;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _343)].z > 0.0)
    {
        float3 _426 = fast::clamp((_242 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _437 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_426.x), int(_426.y), int(_426.z), 0).xyz), 0));
        _458 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_437.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_426 / float3(_437.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _458 = _411;
    }
    float3 _472 = ((_394 - (_394 * _393)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _479 = (mix(float3(0.07999999821186065673828125 * _392), _394, float3(_393)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _482 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _487;
    if (_482)
    {
        _487 = _472 + (_479 * 0.449999988079071044921875);
    }
    else
    {
        _487 = _472;
    }
    float3 _489 = select(_479, float3(0.0), bool3(_482));
    float3 _491 = float3(dot(_489, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _498 = float3(_336);
    float3 _578;
    if (_405)
    {
        float4 _528 = _175;
        _528.y = (-0.48860299587249755859375) * _395.y;
        float4 _531 = _528;
        _531.z = 0.48860299587249755859375 * _395.z;
        float4 _534 = _531;
        _534.w = (-0.48860299587249755859375) * _395.x;
        float3 _535 = _395 * _395;
        float4 _538 = _171;
        _538.x = (1.09254801273345947265625 * _395.x) * _395.y;
        float4 _541 = _538;
        _541.y = ((-1.09254801273345947265625) * _395.y) * _395.z;
        float4 _546 = _541;
        _546.z = 0.3153919875621795654296875 * ((3.0 * _535.z) - 1.0);
        float4 _549 = _546;
        _549.w = ((-1.09254801273345947265625) * _395.x) * _395.z;
        float4 _553 = _534;
        _553.x = 0.886227548122406005859375;
        float3 _555 = _553.yzw * 2.094395160675048828125;
        float4 _556 = float4(_553.x, _555.x, _555.y, _555.z);
        float4 _557 = _549 * 0.785398185253143310546875;
        float _558 = (_535.x - _535.y) * 0.4290426075458526611328125;
        float3 _564 = float3(0.0);
        _564.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _556) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _557)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _558);
        float3 _570 = _564;
        _570.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _556) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _557)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _558);
        float3 _576 = _570;
        _576.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _556) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _557)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _558);
        _578 = fast::max(float3(0.0), _576);
    }
    else
    {
        _578 = float3(0.0);
    }
    float _604;
    float _605;
    float3 _606;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _594;
        float _595;
        if (_405)
        {
            _594 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _595 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _594 = _395;
            _595 = 1.0;
        }
        float _596 = 1.0 - _595;
        float _598 = 1.0 - (_596 * _596);
        _604 = mix(fast::clamp(dot(_594, _395), 0.0, 1.0), 1.0, _598);
        _605 = _595;
        _606 = mix(_594, _395, float3(_598));
    }
    else
    {
        _604 = 1.0;
        _605 = 1.0;
        _606 = _395;
    }
    float4 _610 = float4(_606, 1.0);
    float3 _614 = _172;
    _614.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _610);
    float3 _618 = _614;
    _618.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _610);
    float3 _622 = _618;
    _622.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _610);
    float4 _625 = _610.xyzz * _610.yzzx;
    float3 _629 = _172;
    _629.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _625);
    float3 _633 = _629;
    _633.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _625);
    float3 _637 = _633;
    _637.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _625);
    float3 _652 = (_578 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_622 + _637) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_606.x * _606.x) - (_606.y * _606.y)))) * View.View_SkyLightColor.xyz) * (_605 * _604));
    float3 _674 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _703;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _702;
        if (any(abs(_242 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _342 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _342 + 19u)].xyz + float3(1.0))))
        {
            _702 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_242, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _702 = _674;
        }
        _703 = _702;
    }
    else
    {
        _703 = _674;
    }
    float4 _710 = float4(((mix(float3(0.0), _487 + (_489 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_652 * _487) * fast::max(_498, ((((((_394 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _336) + ((_394 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _336) + ((_394 * 2.755199909210205078125) + float3(0.69029998779296875))) * _336))) + _703) * 1.0, 0.0);
    float4 _717;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _716 = _710;
        _716.w = 0.0;
        _717 = _716;
    }
    else
    {
        _717 = _710;
    }
    float2 _721 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _729 = (_395 * 0.5) + float3(0.5);
    float4 _731 = float4(_729.x, _729.y, _729.z, float4(0.0).w);
    _731.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _343)].y;
    float4 _732 = float4(0.0);
    _732.x = _393;
    float4 _733 = _732;
    _733.y = _392;
    float4 _734 = _733;
    _734.z = _391;
    float4 _735 = _734;
    _735.w = 0.50588238239288330078125;
    float4 _747 = float4(_394.x, _394.y, _394.z, float4(0.0).w);
    _747.w = ((log2(((dot(_652, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_498, ((((((_491 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _336) + ((_491 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _336) + ((_491 * 2.755199909210205078125) + float3(0.69029998779296875))) * _336).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_721.xyx * _721.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _717 * View.View_PreExposure;
    out.out_var_SV_Target1 = _731;
    out.out_var_SV_Target2 = _735;
    out.out_var_SV_Target3 = _747;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_458, 1.0, 1.0, 1.0);
    return out;
}

