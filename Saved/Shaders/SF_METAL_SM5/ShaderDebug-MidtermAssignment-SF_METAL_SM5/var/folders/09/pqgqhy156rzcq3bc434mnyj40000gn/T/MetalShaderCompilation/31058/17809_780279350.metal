

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

constant float4 _162 = {};
constant float3 _163 = {};
constant float _165 = {};
constant float4 _166 = {};

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
    uint in_var_PRIMITIVE_ID [[user(locn2)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00004591_2e821e36(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(11)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(12)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _219 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _165, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _224 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _229 = (_224.xyz / float3(_224.w)) - View.View_PreViewTranslation;
    float3 _237 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float _248 = (0.699999988079071044921875 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _249 = in.in_var_PRIMITIVE_ID * 36u;
    uint _250 = _249 + 20u;
    float _298;
    float _299;
    float _300;
    float3 _301;
    float3 _302;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _250)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _268 = ((_219.xy / float2(_219.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _272 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _268, level(0.0));
        float4 _275 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _268, level(0.0));
        float4 _278 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _268, level(0.0));
        float _288 = _278.w;
        _298 = (_248 * _288) + _278.z;
        _299 = (0.5 * _288) + _278.y;
        _300 = _278.x;
        _301 = (float3(0.180000007152557373046875) * _272.w) + _272.xyz;
        _302 = normalize((_237 * _275.w) + ((_275.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _298 = _248;
        _299 = 0.5;
        _300 = 0.0;
        _301 = float3(0.180000007152557373046875);
        _302 = _237;
    }
    float3 _312 = fast::clamp((_229 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _323 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_312.x), int(_312.y), int(_312.z), 0).xyz), 0));
    float3 _338 = (((_323.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_312 / float3(_323.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _351;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _250)].z > 0.0)
    {
        _351 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _338, level(0.0)).x;
    }
    else
    {
        _351 = 1.0;
    }
    float3 _365 = ((_301 - (_301 * _300)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _372 = (mix(float3(0.07999999821186065673828125 * _299), _301, float3(_300)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _375 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _380;
    if (_375)
    {
        _380 = _365 + (_372 * 0.449999988079071044921875);
    }
    else
    {
        _380 = _365;
    }
    float3 _382 = select(_372, float3(0.0), bool3(_375));
    float3 _384 = float3(dot(_382, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _401 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _338, level(0.0));
    float _417 = _401.x;
    float4 _419 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _338, level(0.0)) * 2.0) - float4(1.0)) * _417) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _420 = _401.y;
    float4 _422 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _338, level(0.0)) * 2.0) - float4(1.0)) * _420) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _423 = _401.z;
    float4 _425 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _338, level(0.0)) * 2.0) - float4(1.0)) * _423) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _442 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _338, level(0.0)) * 2.0) - float4(1.0)) * _417) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _444 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _338, level(0.0)) * 2.0) - float4(1.0)) * _420) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _446 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _338, level(0.0)) * 2.0) - float4(1.0)) * _423) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _479 = _166;
    _479.y = (-0.48860299587249755859375) * _302.y;
    float4 _482 = _479;
    _482.z = 0.48860299587249755859375 * _302.z;
    float4 _485 = _482;
    _485.w = (-0.48860299587249755859375) * _302.x;
    float3 _486 = _302 * _302;
    float4 _489 = _162;
    _489.x = (1.09254801273345947265625 * _302.x) * _302.y;
    float4 _492 = _489;
    _492.y = ((-1.09254801273345947265625) * _302.y) * _302.z;
    float4 _497 = _492;
    _497.z = 0.3153919875621795654296875 * ((3.0 * _486.z) - 1.0);
    float4 _500 = _497;
    _500.w = ((-1.09254801273345947265625) * _302.x) * _302.z;
    float4 _504 = _485;
    _504.x = 0.886227548122406005859375;
    float3 _506 = _504.yzw * 2.094395160675048828125;
    float4 _507 = float4(_504.x, _506.x, _506.y, _506.z);
    float4 _508 = _500 * 0.785398185253143310546875;
    float _509 = (_486.x - _486.y) * 0.4290426075458526611328125;
    float3 _515 = float3(0.0);
    _515.x = (dot(float4(_417, _419.xyz), _507) + dot(float4(_419.w, _442.xyz), _508)) + (_442.w * _509);
    float3 _521 = _515;
    _521.y = (dot(float4(_420, _422.xyz), _507) + dot(float4(_422.w, _444.xyz), _508)) + (_444.w * _509);
    float3 _527 = _521;
    _527.z = (dot(float4(_423, _425.xyz), _507) + dot(float4(_425.w, _446.xyz), _508)) + (_446.w * _509);
    float _556;
    float _557;
    float3 _558;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _543 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _338, level(0.0)).xyz * 2.0) - float3(1.0);
        float _544 = length(_543);
        float3 _547 = _543 / float3(fast::max(_544, 9.9999997473787516355514526367188e-05));
        float _548 = 1.0 - _544;
        float _550 = 1.0 - (_548 * _548);
        _556 = mix(fast::clamp(dot(_547, _302), 0.0, 1.0), 1.0, _550);
        _557 = _544;
        _558 = mix(_547, _302, float3(_550));
    }
    else
    {
        _556 = 1.0;
        _557 = 1.0;
        _558 = _302;
    }
    float4 _562 = float4(_558, 1.0);
    float3 _566 = _163;
    _566.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _562);
    float3 _570 = _566;
    _570.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _562);
    float3 _574 = _570;
    _574.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _562);
    float4 _577 = _562.xyzz * _562.yzzx;
    float3 _581 = _163;
    _581.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _577);
    float3 _585 = _581;
    _585.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _577);
    float3 _589 = _585;
    _589.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _577);
    float3 _604 = ((fast::max(float3(0.0), _527) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_574 + _589) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_558.x * _558.x) - (_558.y * _558.y)))) * View.View_SkyLightColor.xyz) * (_557 * _556));
    float3 _626 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _655;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _654;
        if (any(abs(_229 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _249 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _249 + 19u)].xyz + float3(1.0))))
        {
            _654 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_229, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _654 = _626;
        }
        _655 = _654;
    }
    else
    {
        _655 = _626;
    }
    float4 _662 = float4(((mix(float3(0.0), _380 + (_382 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_604 * _380) * fast::max(float3(1.0), ((((((_301 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_301 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_301 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _655) * 1.0, 0.0);
    float4 _669;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _668 = _662;
        _668.w = 0.0;
        _669 = _668;
    }
    else
    {
        _669 = _662;
    }
    float2 _673 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _681 = (_302 * 0.5) + float3(0.5);
    float4 _683 = float4(_681.x, _681.y, _681.z, float4(0.0).w);
    _683.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _250)].y;
    float4 _684 = float4(0.0);
    _684.x = _300;
    float4 _685 = _684;
    _685.y = _299;
    float4 _686 = _685;
    _686.z = _298;
    float4 _687 = _686;
    _687.w = 0.50588238239288330078125;
    float4 _699 = float4(_301.x, _301.y, _301.z, float4(0.0).w);
    _699.w = ((log2(((dot(_604, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_384 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_384 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_384 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_673.xyx * _673.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _669 * View.View_PreExposure;
    out.out_var_SV_Target1 = _683;
    out.out_var_SV_Target2 = _687;
    out.out_var_SV_Target3 = _699;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_351, 1.0, 1.0, 1.0);
    return out;
}

