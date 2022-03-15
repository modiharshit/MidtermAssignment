

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
    char _m12_pad[52];
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
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
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
    float4 in_var_COLOR0 [[user(locn2)]];
    uint in_var_PRIMITIVE_ID [[user(locn3)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00004695_25f52a5c(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(11)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(12)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]], bool gl_FrontFacing [[front_facing]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _223 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _164, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _228 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _233 = (_228.xyz / float3(_228.w)) - View.View_PreViewTranslation;
    uint _234 = in.in_var_PRIMITIVE_ID * 36u;
    float3 _250 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * ((View.View_CullingSign * View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _234 + 4u)].w) * float(gl_FrontFacing ? 1 : (-1)));
    float3 _259 = fast::clamp(in.in_var_COLOR0.xyz, float3(0.0), float3(1.0));
    float _263 = (0.5 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _264 = _234 + 20u;
    float _310;
    float _311;
    float _312;
    float3 _313;
    float3 _314;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _264)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _282 = ((_223.xy / float2(_223.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _286 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _282, level(0.0));
        float4 _289 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _282, level(0.0));
        float4 _292 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _282, level(0.0));
        _310 = (_263 * _292.w) + _292.z;
        _311 = _292.y;
        _312 = _292.x;
        _313 = (_259 * _286.w) + _286.xyz;
        _314 = normalize((_250 * _289.w) + ((_289.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _310 = _263;
        _311 = 0.0;
        _312 = 0.0;
        _313 = _259;
        _314 = _250;
    }
    float3 _324 = fast::clamp((_233 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _335 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_324.x), int(_324.y), int(_324.z), 0).xyz), 0));
    float3 _350 = (((_335.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_324 / float3(_335.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _363;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _264)].z > 0.0)
    {
        _363 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _350, level(0.0)).x;
    }
    else
    {
        _363 = 1.0;
    }
    float3 _377 = ((_313 - (_313 * _312)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _384 = (mix(float3(0.07999999821186065673828125 * _311), _313, float3(_312)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _387 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _392;
    if (_387)
    {
        _392 = _377 + (_384 * 0.449999988079071044921875);
    }
    else
    {
        _392 = _377;
    }
    float3 _394 = select(_384, float3(0.0), bool3(_387));
    float3 _396 = float3(dot(_394, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _413 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _350, level(0.0));
    float _429 = _413.x;
    float4 _431 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _350, level(0.0)) * 2.0) - float4(1.0)) * _429) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _432 = _413.y;
    float4 _434 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _350, level(0.0)) * 2.0) - float4(1.0)) * _432) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _435 = _413.z;
    float4 _437 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _350, level(0.0)) * 2.0) - float4(1.0)) * _435) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _454 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _350, level(0.0)) * 2.0) - float4(1.0)) * _429) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _456 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _350, level(0.0)) * 2.0) - float4(1.0)) * _432) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _458 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _350, level(0.0)) * 2.0) - float4(1.0)) * _435) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _491 = _165;
    _491.y = (-0.48860299587249755859375) * _314.y;
    float4 _494 = _491;
    _494.z = 0.48860299587249755859375 * _314.z;
    float4 _497 = _494;
    _497.w = (-0.48860299587249755859375) * _314.x;
    float3 _498 = _314 * _314;
    float4 _501 = _161;
    _501.x = (1.09254801273345947265625 * _314.x) * _314.y;
    float4 _504 = _501;
    _504.y = ((-1.09254801273345947265625) * _314.y) * _314.z;
    float4 _509 = _504;
    _509.z = 0.3153919875621795654296875 * ((3.0 * _498.z) - 1.0);
    float4 _512 = _509;
    _512.w = ((-1.09254801273345947265625) * _314.x) * _314.z;
    float4 _516 = _497;
    _516.x = 0.886227548122406005859375;
    float3 _518 = _516.yzw * 2.094395160675048828125;
    float4 _519 = float4(_516.x, _518.x, _518.y, _518.z);
    float4 _520 = _512 * 0.785398185253143310546875;
    float _521 = (_498.x - _498.y) * 0.4290426075458526611328125;
    float3 _527 = float3(0.0);
    _527.x = (dot(float4(_429, _431.xyz), _519) + dot(float4(_431.w, _454.xyz), _520)) + (_454.w * _521);
    float3 _533 = _527;
    _533.y = (dot(float4(_432, _434.xyz), _519) + dot(float4(_434.w, _456.xyz), _520)) + (_456.w * _521);
    float3 _539 = _533;
    _539.z = (dot(float4(_435, _437.xyz), _519) + dot(float4(_437.w, _458.xyz), _520)) + (_458.w * _521);
    float _568;
    float _569;
    float3 _570;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _555 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _350, level(0.0)).xyz * 2.0) - float3(1.0);
        float _556 = length(_555);
        float3 _559 = _555 / float3(fast::max(_556, 9.9999997473787516355514526367188e-05));
        float _560 = 1.0 - _556;
        float _562 = 1.0 - (_560 * _560);
        _568 = mix(fast::clamp(dot(_559, _314), 0.0, 1.0), 1.0, _562);
        _569 = _556;
        _570 = mix(_559, _314, float3(_562));
    }
    else
    {
        _568 = 1.0;
        _569 = 1.0;
        _570 = _314;
    }
    float4 _574 = float4(_570, 1.0);
    float3 _578 = _162;
    _578.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _574);
    float3 _582 = _578;
    _582.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _574);
    float3 _586 = _582;
    _586.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _574);
    float4 _589 = _574.xyzz * _574.yzzx;
    float3 _593 = _162;
    _593.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _589);
    float3 _597 = _593;
    _597.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _589);
    float3 _601 = _597;
    _601.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _589);
    float3 _616 = ((fast::max(float3(0.0), _539) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_586 + _601) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_570.x * _570.x) - (_570.y * _570.y)))) * View.View_SkyLightColor.xyz) * (_569 * _568));
    float3 _638 = fast::max(mix(in.in_var_COLOR0.xyz, Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _667;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _666;
        if (any(abs(_233 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _234 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _234 + 19u)].xyz + float3(1.0))))
        {
            _666 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_233, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _666 = _638;
        }
        _667 = _666;
    }
    else
    {
        _667 = _638;
    }
    float4 _674 = float4(((mix(float3(0.0), _392 + (_394 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_616 * _392) * fast::max(float3(1.0), ((((((_313 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_313 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_313 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _667) * 1.0, 0.0);
    float4 _681;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _680 = _674;
        _680.w = 0.0;
        _681 = _680;
    }
    else
    {
        _681 = _674;
    }
    float2 _685 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _693 = (_314 * 0.5) + float3(0.5);
    float4 _695 = float4(_693.x, _693.y, _693.z, float4(0.0).w);
    _695.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _264)].y;
    float4 _696 = float4(0.0);
    _696.x = _312;
    float4 _697 = _696;
    _697.y = _311;
    float4 _698 = _697;
    _698.z = _310;
    float4 _699 = _698;
    _699.w = 0.50588238239288330078125;
    float4 _711 = float4(_313.x, _313.y, _313.z, float4(0.0).w);
    _711.w = ((log2(((dot(_616, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_396 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_396 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_396 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_685.xyx * _685.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _681 * View.View_PreExposure;
    out.out_var_SV_Target1 = _695;
    out.out_var_SV_Target2 = _699;
    out.out_var_SV_Target3 = _711;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_363, 1.0, 1.0, 1.0);
    return out;
}

