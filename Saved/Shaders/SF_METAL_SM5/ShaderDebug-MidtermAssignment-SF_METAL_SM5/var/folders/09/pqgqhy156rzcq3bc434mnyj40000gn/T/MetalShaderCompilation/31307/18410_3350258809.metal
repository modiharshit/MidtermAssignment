

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

constant float4 _167 = {};
constant float3 _168 = {};
constant float _170 = {};
constant float4 _171 = {};

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

fragment MainPS_out Main_000047ea_c7b0e479(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(11)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(12)]], texture2d<float> Material_Texture2D_0 [[texture(13)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _228 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _170, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _233 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _238 = (_233.xyz / float3(_233.w)) - View.View_PreViewTranslation;
    float3 _246 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _259 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _261 = fast::clamp(_259.xyz, float3(0.0), float3(1.0));
    float _265 = (0.949999988079071044921875 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _266 = in.in_var_PRIMITIVE_ID * 36u;
    uint _267 = _266 + 20u;
    float _315;
    float _316;
    float _317;
    float3 _318;
    float3 _319;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _267)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _285 = ((_228.xy / float2(_228.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _289 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _285, level(0.0));
        float4 _292 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _285, level(0.0));
        float4 _295 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _285, level(0.0));
        float _305 = _295.w;
        _315 = (_265 * _305) + _295.z;
        _316 = (0.20000000298023223876953125 * _305) + _295.y;
        _317 = _295.x;
        _318 = (_261 * _289.w) + _289.xyz;
        _319 = normalize((_246 * _292.w) + ((_292.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _315 = _265;
        _316 = 0.20000000298023223876953125;
        _317 = 0.0;
        _318 = _261;
        _319 = _246;
    }
    float3 _329 = fast::clamp((_238 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _340 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_329.x), int(_329.y), int(_329.z), 0).xyz), 0));
    float3 _355 = (((_340.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_329 / float3(_340.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _368;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _267)].z > 0.0)
    {
        _368 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _355, level(0.0)).x;
    }
    else
    {
        _368 = 1.0;
    }
    float3 _382 = ((_318 - (_318 * _317)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _389 = (mix(float3(0.07999999821186065673828125 * _316), _318, float3(_317)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _392 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _397;
    if (_392)
    {
        _397 = _382 + (_389 * 0.449999988079071044921875);
    }
    else
    {
        _397 = _382;
    }
    float3 _399 = select(_389, float3(0.0), bool3(_392));
    float3 _401 = float3(dot(_399, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _418 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _355, level(0.0));
    float _434 = _418.x;
    float4 _436 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _355, level(0.0)) * 2.0) - float4(1.0)) * _434) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _437 = _418.y;
    float4 _439 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _355, level(0.0)) * 2.0) - float4(1.0)) * _437) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _440 = _418.z;
    float4 _442 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _355, level(0.0)) * 2.0) - float4(1.0)) * _440) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _459 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _355, level(0.0)) * 2.0) - float4(1.0)) * _434) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _461 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _355, level(0.0)) * 2.0) - float4(1.0)) * _437) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _463 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _355, level(0.0)) * 2.0) - float4(1.0)) * _440) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _496 = _171;
    _496.y = (-0.48860299587249755859375) * _319.y;
    float4 _499 = _496;
    _499.z = 0.48860299587249755859375 * _319.z;
    float4 _502 = _499;
    _502.w = (-0.48860299587249755859375) * _319.x;
    float3 _503 = _319 * _319;
    float4 _506 = _167;
    _506.x = (1.09254801273345947265625 * _319.x) * _319.y;
    float4 _509 = _506;
    _509.y = ((-1.09254801273345947265625) * _319.y) * _319.z;
    float4 _514 = _509;
    _514.z = 0.3153919875621795654296875 * ((3.0 * _503.z) - 1.0);
    float4 _517 = _514;
    _517.w = ((-1.09254801273345947265625) * _319.x) * _319.z;
    float4 _521 = _502;
    _521.x = 0.886227548122406005859375;
    float3 _523 = _521.yzw * 2.094395160675048828125;
    float4 _524 = float4(_521.x, _523.x, _523.y, _523.z);
    float4 _525 = _517 * 0.785398185253143310546875;
    float _526 = (_503.x - _503.y) * 0.4290426075458526611328125;
    float3 _532 = float3(0.0);
    _532.x = (dot(float4(_434, _436.xyz), _524) + dot(float4(_436.w, _459.xyz), _525)) + (_459.w * _526);
    float3 _538 = _532;
    _538.y = (dot(float4(_437, _439.xyz), _524) + dot(float4(_439.w, _461.xyz), _525)) + (_461.w * _526);
    float3 _544 = _538;
    _544.z = (dot(float4(_440, _442.xyz), _524) + dot(float4(_442.w, _463.xyz), _525)) + (_463.w * _526);
    float _573;
    float _574;
    float3 _575;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _560 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _355, level(0.0)).xyz * 2.0) - float3(1.0);
        float _561 = length(_560);
        float3 _564 = _560 / float3(fast::max(_561, 9.9999997473787516355514526367188e-05));
        float _565 = 1.0 - _561;
        float _567 = 1.0 - (_565 * _565);
        _573 = mix(fast::clamp(dot(_564, _319), 0.0, 1.0), 1.0, _567);
        _574 = _561;
        _575 = mix(_564, _319, float3(_567));
    }
    else
    {
        _573 = 1.0;
        _574 = 1.0;
        _575 = _319;
    }
    float4 _579 = float4(_575, 1.0);
    float3 _583 = _168;
    _583.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _579);
    float3 _587 = _583;
    _587.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _579);
    float3 _591 = _587;
    _591.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _579);
    float4 _594 = _579.xyzz * _579.yzzx;
    float3 _598 = _168;
    _598.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _594);
    float3 _602 = _598;
    _602.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _594);
    float3 _606 = _602;
    _606.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _594);
    float3 _621 = ((fast::max(float3(0.0), _544) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_591 + _606) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_575.x * _575.x) - (_575.y * _575.y)))) * View.View_SkyLightColor.xyz) * (_574 * _573));
    float3 _643 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _672;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _671;
        if (any(abs(_238 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _266 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _266 + 19u)].xyz + float3(1.0))))
        {
            _671 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_238, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _671 = _643;
        }
        _672 = _671;
    }
    else
    {
        _672 = _643;
    }
    float4 _679 = float4(((mix(float3(0.0), _397 + (_399 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_621 * _397) * fast::max(float3(1.0), ((((((_318 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_318 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_318 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _672) * 1.0, 0.0);
    float4 _686;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _685 = _679;
        _685.w = 0.0;
        _686 = _685;
    }
    else
    {
        _686 = _679;
    }
    float2 _690 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _698 = (_319 * 0.5) + float3(0.5);
    float4 _700 = float4(_698.x, _698.y, _698.z, float4(0.0).w);
    _700.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _267)].y;
    float4 _701 = float4(0.0);
    _701.x = _317;
    float4 _702 = _701;
    _702.y = _316;
    float4 _703 = _702;
    _703.z = _315;
    float4 _704 = _703;
    _704.w = 0.50588238239288330078125;
    float4 _716 = float4(_318.x, _318.y, _318.z, float4(0.0).w);
    _716.w = ((log2(((dot(_621, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_401 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_401 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_401 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_690.xyx * _690.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _686 * View.View_PreExposure;
    out.out_var_SV_Target1 = _700;
    out.out_var_SV_Target2 = _704;
    out.out_var_SV_Target3 = _716;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_368, 1.0, 1.0, 1.0);
    return out;
}

