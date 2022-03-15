

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
    char _m17_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m19_pad[124];
    float View_ShowDecalsMask;
    char _m20_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m21_pad[48];
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

constant float4 _175 = {};
constant float3 _176 = {};
constant float4 _178 = {};

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

fragment MainPS_out Main_00004fe1_bcd9170b(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _238 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _242 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _247 = (_242.xyz / float3(_242.w)) - View.View_PreViewTranslation;
    float2 _248 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.25;
    float4 _254 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _248, bias(View.View_MaterialTextureMipBias));
    float2 _257 = (_254.xy * float2(2.0)) - float2(1.0);
    float2 _265 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.3499999940395355224609375;
    float4 _267 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _265, bias(View.View_MaterialTextureMipBias));
    float2 _270 = (_267.xy * float2(2.0)) - float2(1.0);
    float4 _282 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _287 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _292 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _296 = (_282.x + 0.5) * ((_287.x + 0.5) * (_292.x + 0.5));
    float _299 = fast::min(fast::max(mix(-2.0, 0.699999988079071044921875, _296), 0.0), 1.0);
    float3 _302 = float3(_299);
    float4 _308 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _335;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _335 = _238.w;
                break;
            }
            else
            {
                float _319 = _238.z;
                _335 = ((_319 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_319 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _350 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(mix(float4(_257, sqrt(fast::clamp(1.0 - dot(_257, _257), 0.0, 1.0)), 1.0).xyz, float4(_270, sqrt(fast::clamp(1.0 - dot(_270, _270), 0.0, 1.0)), 1.0).xyz, _302), float3(0.0, 0.0, 1.0), float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _308.x) + _335) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _363 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _248, bias(View.View_MaterialTextureMipBias));
    float4 _365 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _265, bias(View.View_MaterialTextureMipBias));
    float3 _375 = fast::clamp(mix(float3(0.6349999904632568359375), float3(1.0), float3(_296)) * mix(_363.xyz, _365.xyz, _302), float3(0.0), float3(1.0));
    float _380 = (fast::clamp(mix(0.800000011920928955078125, 0.5, _296 * mix(_363.w, _365.w, _299)), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _381 = in.in_var_PRIMITIVE_ID * 36u;
    uint _382 = _381 + 20u;
    float _430;
    float _431;
    float _432;
    float3 _433;
    float3 _434;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _382)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _400 = ((_238.xy / float2(_238.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _404 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _400, level(0.0));
        float4 _407 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _400, level(0.0));
        float4 _410 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _400, level(0.0));
        float _420 = _410.w;
        _430 = (_380 * _420) + _410.z;
        _431 = (0.5 * _420) + _410.y;
        _432 = _410.x;
        _433 = (_375 * _404.w) + _404.xyz;
        _434 = normalize((_350 * _407.w) + ((_407.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _430 = _380;
        _431 = 0.5;
        _432 = 0.0;
        _433 = _375;
        _434 = _350;
    }
    bool _444 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _450;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _381 + 18u)].w > 0.0) && _444)
    {
        _450 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _450 = 1.0;
    }
    float _497;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _382)].z > 0.0)
    {
        float3 _465 = fast::clamp((_247 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _476 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_465.x), int(_465.y), int(_465.z), 0).xyz), 0));
        _497 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_476.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_465 / float3(_476.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _497 = _450;
    }
    float3 _511 = ((_433 - (_433 * _432)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _518 = (mix(float3(0.07999999821186065673828125 * _431), _433, float3(_432)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _521 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _526;
    if (_521)
    {
        _526 = _511 + (_518 * 0.449999988079071044921875);
    }
    else
    {
        _526 = _511;
    }
    float3 _528 = select(_518, float3(0.0), bool3(_521));
    float3 _530 = float3(dot(_528, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _616;
    if (_444)
    {
        float4 _566 = _178;
        _566.y = (-0.48860299587249755859375) * _434.y;
        float4 _569 = _566;
        _569.z = 0.48860299587249755859375 * _434.z;
        float4 _572 = _569;
        _572.w = (-0.48860299587249755859375) * _434.x;
        float3 _573 = _434 * _434;
        float4 _576 = _175;
        _576.x = (1.09254801273345947265625 * _434.x) * _434.y;
        float4 _579 = _576;
        _579.y = ((-1.09254801273345947265625) * _434.y) * _434.z;
        float4 _584 = _579;
        _584.z = 0.3153919875621795654296875 * ((3.0 * _573.z) - 1.0);
        float4 _587 = _584;
        _587.w = ((-1.09254801273345947265625) * _434.x) * _434.z;
        float4 _591 = _572;
        _591.x = 0.886227548122406005859375;
        float3 _593 = _591.yzw * 2.094395160675048828125;
        float4 _594 = float4(_591.x, _593.x, _593.y, _593.z);
        float4 _595 = _587 * 0.785398185253143310546875;
        float _596 = (_573.x - _573.y) * 0.4290426075458526611328125;
        float3 _602 = float3(0.0);
        _602.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _594) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _595)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _596);
        float3 _608 = _602;
        _608.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _594) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _595)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _596);
        float3 _614 = _608;
        _614.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _594) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _595)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _596);
        _616 = fast::max(float3(0.0), _614);
    }
    else
    {
        _616 = float3(0.0);
    }
    float _642;
    float _643;
    float3 _644;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _632;
        float _633;
        if (_444)
        {
            _632 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _633 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _632 = _434;
            _633 = 1.0;
        }
        float _634 = 1.0 - _633;
        float _636 = 1.0 - (_634 * _634);
        _642 = mix(fast::clamp(dot(_632, _434), 0.0, 1.0), 1.0, _636);
        _643 = _633;
        _644 = mix(_632, _434, float3(_636));
    }
    else
    {
        _642 = 1.0;
        _643 = 1.0;
        _644 = _434;
    }
    float4 _648 = float4(_644, 1.0);
    float3 _652 = _176;
    _652.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _648);
    float3 _656 = _652;
    _656.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _648);
    float3 _660 = _656;
    _660.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _648);
    float4 _663 = _648.xyzz * _648.yzzx;
    float3 _667 = _176;
    _667.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _663);
    float3 _671 = _667;
    _671.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _663);
    float3 _675 = _671;
    _675.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _663);
    float3 _690 = (_616 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_660 + _675) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_644.x * _644.x) - (_644.y * _644.y)))) * View.View_SkyLightColor.xyz) * (_643 * _642));
    float3 _712 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _741;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _740;
        if (any(abs(_247 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _381 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _381 + 19u)].xyz + float3(1.0))))
        {
            _740 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_247, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _740 = _712;
        }
        _741 = _740;
    }
    else
    {
        _741 = _712;
    }
    float4 _748 = float4(((mix(float3(0.0), _526 + (_528 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_690 * _526) * fast::max(float3(1.0), ((((((_433 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_433 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_433 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _741) * 1.0, 0.0);
    float4 _755;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _754 = _748;
        _754.w = 0.0;
        _755 = _754;
    }
    else
    {
        _755 = _748;
    }
    float2 _759 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _767 = (_434 * 0.5) + float3(0.5);
    float4 _769 = float4(_767.x, _767.y, _767.z, float4(0.0).w);
    _769.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _382)].y;
    float4 _770 = float4(0.0);
    _770.x = _432;
    float4 _771 = _770;
    _771.y = _431;
    float4 _772 = _771;
    _772.z = _430;
    float4 _773 = _772;
    _773.w = 0.50588238239288330078125;
    float4 _785 = float4(_433.x, _433.y, _433.z, float4(0.0).w);
    _785.w = ((log2(((dot(_690, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_530 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_530 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_530 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_759.xyx * _759.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _755 * View.View_PreExposure;
    out.out_var_SV_Target1 = _769;
    out.out_var_SV_Target2 = _773;
    out.out_var_SV_Target3 = _785;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_497, 1.0, 1.0, 1.0);
    return out;
}

