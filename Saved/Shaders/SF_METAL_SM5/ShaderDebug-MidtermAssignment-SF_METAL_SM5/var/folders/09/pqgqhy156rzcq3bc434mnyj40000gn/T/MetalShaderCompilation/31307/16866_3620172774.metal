

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
    char _m9_pad[16];
    float View_OutOfBoundsMask;
    char _m10_pad[80];
    float View_UnlitViewmodeMask;
    char _m11_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m12_pad[452];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m14_pad[124];
    float View_ShowDecalsMask;
    char _m15_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m16_pad[48];
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

constant float4 _160 = {};
constant float3 _161 = {};
constant float _163 = {};
constant float4 _164 = {};

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

fragment MainPS_out Main_000041e2_d7c773e6(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(11)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(12)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _213 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _163, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _218 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _223 = (_218.xyz / float3(_218.w)) - View.View_PreViewTranslation;
    float3 _231 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    uint _239 = in.in_var_PRIMITIVE_ID * 36u;
    uint _240 = _239 + 20u;
    float _287;
    float _288;
    float _289;
    float3 _290;
    float3 _291;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _240)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _258 = ((_213.xy / float2(_213.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _262 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _258, level(0.0));
        float4 _265 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _258, level(0.0));
        float4 _268 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _258, level(0.0));
        float _278 = _268.w;
        _287 = _278 + _268.z;
        _288 = (0.5 * _278) + _268.y;
        _289 = _268.x;
        _290 = (float3(0.180000007152557373046875) * _262.w) + _262.xyz;
        _291 = normalize((_231 * _265.w) + ((_265.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _287 = 1.0;
        _288 = 0.5;
        _289 = 0.0;
        _290 = float3(0.180000007152557373046875);
        _291 = _231;
    }
    float3 _301 = fast::clamp((_223 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _312 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_301.x), int(_301.y), int(_301.z), 0).xyz), 0));
    float3 _327 = (((_312.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_301 / float3(_312.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _340;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _240)].z > 0.0)
    {
        _340 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _327, level(0.0)).x;
    }
    else
    {
        _340 = 1.0;
    }
    float3 _363 = (((_290 - (_290 * _289)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz) + (((mix(float3(0.07999999821186065673828125 * _288), _290, float3(_289)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz) * 0.449999988079071044921875);
    float4 _367 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _327, level(0.0));
    float _383 = _367.x;
    float4 _385 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _327, level(0.0)) * 2.0) - float4(1.0)) * _383) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _386 = _367.y;
    float4 _388 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _327, level(0.0)) * 2.0) - float4(1.0)) * _386) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _389 = _367.z;
    float4 _391 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _327, level(0.0)) * 2.0) - float4(1.0)) * _389) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _408 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _327, level(0.0)) * 2.0) - float4(1.0)) * _383) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _410 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _327, level(0.0)) * 2.0) - float4(1.0)) * _386) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _412 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _327, level(0.0)) * 2.0) - float4(1.0)) * _389) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _445 = _164;
    _445.y = (-0.48860299587249755859375) * _291.y;
    float4 _448 = _445;
    _448.z = 0.48860299587249755859375 * _291.z;
    float4 _451 = _448;
    _451.w = (-0.48860299587249755859375) * _291.x;
    float3 _452 = _291 * _291;
    float4 _455 = _160;
    _455.x = (1.09254801273345947265625 * _291.x) * _291.y;
    float4 _458 = _455;
    _458.y = ((-1.09254801273345947265625) * _291.y) * _291.z;
    float4 _463 = _458;
    _463.z = 0.3153919875621795654296875 * ((3.0 * _452.z) - 1.0);
    float4 _466 = _463;
    _466.w = ((-1.09254801273345947265625) * _291.x) * _291.z;
    float4 _470 = _451;
    _470.x = 0.886227548122406005859375;
    float3 _472 = _470.yzw * 2.094395160675048828125;
    float4 _473 = float4(_470.x, _472.x, _472.y, _472.z);
    float4 _474 = _466 * 0.785398185253143310546875;
    float _475 = (_452.x - _452.y) * 0.4290426075458526611328125;
    float3 _481 = float3(0.0);
    _481.x = (dot(float4(_383, _385.xyz), _473) + dot(float4(_385.w, _408.xyz), _474)) + (_408.w * _475);
    float3 _487 = _481;
    _487.y = (dot(float4(_386, _388.xyz), _473) + dot(float4(_388.w, _410.xyz), _474)) + (_410.w * _475);
    float3 _493 = _487;
    _493.z = (dot(float4(_389, _391.xyz), _473) + dot(float4(_391.w, _412.xyz), _474)) + (_412.w * _475);
    float _522;
    float _523;
    float3 _524;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _509 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _327, level(0.0)).xyz * 2.0) - float3(1.0);
        float _510 = length(_509);
        float3 _513 = _509 / float3(fast::max(_510, 9.9999997473787516355514526367188e-05));
        float _514 = 1.0 - _510;
        float _516 = 1.0 - (_514 * _514);
        _522 = mix(fast::clamp(dot(_513, _291), 0.0, 1.0), 1.0, _516);
        _523 = _510;
        _524 = mix(_513, _291, float3(_516));
    }
    else
    {
        _522 = 1.0;
        _523 = 1.0;
        _524 = _291;
    }
    float4 _528 = float4(_524, 1.0);
    float3 _532 = _161;
    _532.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _528);
    float3 _536 = _532;
    _536.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _528);
    float3 _540 = _536;
    _540.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _528);
    float4 _543 = _528.xyzz * _528.yzzx;
    float3 _547 = _161;
    _547.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _543);
    float3 _551 = _547;
    _551.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _543);
    float3 _555 = _551;
    _555.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _543);
    float3 _570 = ((fast::max(float3(0.0), _493) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_540 + _555) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_524.x * _524.x) - (_524.y * _524.y)))) * View.View_SkyLightColor.xyz) * (_523 * _522));
    float3 _590 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _619;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _618;
        if (any(abs(_223 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _239 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _239 + 19u)].xyz + float3(1.0))))
        {
            _618 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_223, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _618 = _590;
        }
        _619 = _618;
    }
    else
    {
        _619 = _590;
    }
    float4 _626 = float4(((mix(float3(0.0), _363, float3(View.View_UnlitViewmodeMask)) + ((_570 * _363) * fast::max(float3(1.0), ((((((_290 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_290 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_290 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _619) * 1.0, 0.0);
    float4 _633;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _632 = _626;
        _632.w = 0.0;
        _633 = _632;
    }
    else
    {
        _633 = _626;
    }
    float2 _637 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _645 = (_291 * 0.5) + float3(0.5);
    float4 _647 = float4(_645.x, _645.y, _645.z, float4(0.0).w);
    _647.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _240)].y;
    float4 _648 = float4(0.0);
    _648.x = _289;
    float4 _649 = _648;
    _649.y = _288;
    float4 _650 = _649;
    _650.z = _287;
    float4 _651 = _650;
    _651.w = 0.50588238239288330078125;
    float4 _662 = float4(_290.x, _290.y, _290.z, float4(0.0).w);
    _662.w = ((log2((dot(_570, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_637.xyx * _637.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _633 * View.View_PreExposure;
    out.out_var_SV_Target1 = _647;
    out.out_var_SV_Target2 = _651;
    out.out_var_SV_Target3 = _662;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_340, 1.0, 1.0, 1.0);
    return out;
}

