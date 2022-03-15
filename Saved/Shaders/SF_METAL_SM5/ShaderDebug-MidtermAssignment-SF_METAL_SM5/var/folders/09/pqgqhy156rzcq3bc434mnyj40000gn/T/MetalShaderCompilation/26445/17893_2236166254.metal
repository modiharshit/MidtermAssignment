

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
    spvUnsafeArray<float4, 4> Material_VectorExpressions;
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
    uint in_var_PRIMITIVE_ID [[user(locn2)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_000045e5_8549306e(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(11)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(12)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _216 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _162, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _221 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _226 = (_221.xyz / float3(_221.w)) - View.View_PreViewTranslation;
    float3 _234 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _247 = fast::clamp(Material.Material_VectorExpressions[3].xyz, float3(0.0), float3(1.0));
    float _252 = (fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _253 = in.in_var_PRIMITIVE_ID * 36u;
    uint _254 = _253 + 20u;
    float _302;
    float _303;
    float _304;
    float3 _305;
    float3 _306;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _254)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _272 = ((_216.xy / float2(_216.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _276 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _272, level(0.0));
        float4 _279 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _272, level(0.0));
        float4 _282 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _272, level(0.0));
        float _292 = _282.w;
        _302 = (_252 * _292) + _282.z;
        _303 = (0.5 * _292) + _282.y;
        _304 = _282.x;
        _305 = (_247 * _276.w) + _276.xyz;
        _306 = normalize((_234 * _279.w) + ((_279.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _302 = _252;
        _303 = 0.5;
        _304 = 0.0;
        _305 = _247;
        _306 = _234;
    }
    float3 _316 = fast::clamp((_226 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _327 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_316.x), int(_316.y), int(_316.z), 0).xyz), 0));
    float3 _342 = (((_327.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_316 / float3(_327.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _355;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _254)].z > 0.0)
    {
        _355 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _342, level(0.0)).x;
    }
    else
    {
        _355 = 1.0;
    }
    float3 _369 = ((_305 - (_305 * _304)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _376 = (mix(float3(0.07999999821186065673828125 * _303), _305, float3(_304)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _379 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _384;
    if (_379)
    {
        _384 = _369 + (_376 * 0.449999988079071044921875);
    }
    else
    {
        _384 = _369;
    }
    float3 _386 = select(_376, float3(0.0), bool3(_379));
    float3 _388 = float3(dot(_386, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _405 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _342, level(0.0));
    float _421 = _405.x;
    float4 _423 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _342, level(0.0)) * 2.0) - float4(1.0)) * _421) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _424 = _405.y;
    float4 _426 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _342, level(0.0)) * 2.0) - float4(1.0)) * _424) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _427 = _405.z;
    float4 _429 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _342, level(0.0)) * 2.0) - float4(1.0)) * _427) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _446 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _342, level(0.0)) * 2.0) - float4(1.0)) * _421) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _448 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _342, level(0.0)) * 2.0) - float4(1.0)) * _424) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _450 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _342, level(0.0)) * 2.0) - float4(1.0)) * _427) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _483 = _163;
    _483.y = (-0.48860299587249755859375) * _306.y;
    float4 _486 = _483;
    _486.z = 0.48860299587249755859375 * _306.z;
    float4 _489 = _486;
    _489.w = (-0.48860299587249755859375) * _306.x;
    float3 _490 = _306 * _306;
    float4 _493 = _159;
    _493.x = (1.09254801273345947265625 * _306.x) * _306.y;
    float4 _496 = _493;
    _496.y = ((-1.09254801273345947265625) * _306.y) * _306.z;
    float4 _501 = _496;
    _501.z = 0.3153919875621795654296875 * ((3.0 * _490.z) - 1.0);
    float4 _504 = _501;
    _504.w = ((-1.09254801273345947265625) * _306.x) * _306.z;
    float4 _508 = _489;
    _508.x = 0.886227548122406005859375;
    float3 _510 = _508.yzw * 2.094395160675048828125;
    float4 _511 = float4(_508.x, _510.x, _510.y, _510.z);
    float4 _512 = _504 * 0.785398185253143310546875;
    float _513 = (_490.x - _490.y) * 0.4290426075458526611328125;
    float3 _519 = float3(0.0);
    _519.x = (dot(float4(_421, _423.xyz), _511) + dot(float4(_423.w, _446.xyz), _512)) + (_446.w * _513);
    float3 _525 = _519;
    _525.y = (dot(float4(_424, _426.xyz), _511) + dot(float4(_426.w, _448.xyz), _512)) + (_448.w * _513);
    float3 _531 = _525;
    _531.z = (dot(float4(_427, _429.xyz), _511) + dot(float4(_429.w, _450.xyz), _512)) + (_450.w * _513);
    float _560;
    float _561;
    float3 _562;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _547 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _342, level(0.0)).xyz * 2.0) - float3(1.0);
        float _548 = length(_547);
        float3 _551 = _547 / float3(fast::max(_548, 9.9999997473787516355514526367188e-05));
        float _552 = 1.0 - _548;
        float _554 = 1.0 - (_552 * _552);
        _560 = mix(fast::clamp(dot(_551, _306), 0.0, 1.0), 1.0, _554);
        _561 = _548;
        _562 = mix(_551, _306, float3(_554));
    }
    else
    {
        _560 = 1.0;
        _561 = 1.0;
        _562 = _306;
    }
    float4 _566 = float4(_562, 1.0);
    float3 _570 = _160;
    _570.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _566);
    float3 _574 = _570;
    _574.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _566);
    float3 _578 = _574;
    _578.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _566);
    float4 _581 = _566.xyzz * _566.yzzx;
    float3 _585 = _160;
    _585.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _581);
    float3 _589 = _585;
    _589.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _581);
    float3 _593 = _589;
    _593.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _581);
    float3 _608 = ((fast::max(float3(0.0), _531) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_578 + _593) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_562.x * _562.x) - (_562.y * _562.y)))) * View.View_SkyLightColor.xyz) * (_561 * _560));
    float3 _630 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _659;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _658;
        if (any(abs(_226 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _253 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _253 + 19u)].xyz + float3(1.0))))
        {
            _658 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_226, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _658 = _630;
        }
        _659 = _658;
    }
    else
    {
        _659 = _630;
    }
    float4 _666 = float4(((mix(float3(0.0), _384 + (_386 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_608 * _384) * fast::max(float3(1.0), ((((((_305 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_305 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_305 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _659) * 1.0, 0.0);
    float4 _673;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _672 = _666;
        _672.w = 0.0;
        _673 = _672;
    }
    else
    {
        _673 = _666;
    }
    float2 _677 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _685 = (_306 * 0.5) + float3(0.5);
    float4 _687 = float4(_685.x, _685.y, _685.z, float4(0.0).w);
    _687.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _254)].y;
    float4 _688 = float4(0.0);
    _688.x = _304;
    float4 _689 = _688;
    _689.y = _303;
    float4 _690 = _689;
    _690.z = _302;
    float4 _691 = _690;
    _691.w = 0.50588238239288330078125;
    float4 _703 = float4(_305.x, _305.y, _305.z, float4(0.0).w);
    _703.w = ((log2(((dot(_608, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_388 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_388 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_388 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_677.xyx * _677.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _673 * View.View_PreExposure;
    out.out_var_SV_Target1 = _687;
    out.out_var_SV_Target2 = _691;
    out.out_var_SV_Target3 = _703;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_355, 1.0, 1.0, 1.0);
    return out;
}

