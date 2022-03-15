

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

constant float4 _178 = {};
constant float3 _179 = {};
constant float _181 = {};
constant float4 _182 = {};

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

fragment MainPS_out Main_00004f22_e76ee5b2(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(11)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(12)]], texture2d<float> Material_Texture2D_0 [[texture(13)]], texture2d<float> Material_Texture2D_1 [[texture(14)]], texture2d<float> Material_Texture2D_2 [[texture(15)]], texture2d<float> Material_Texture2D_3 [[texture(16)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _239 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _181, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _244 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _249 = (_244.xyz / float3(_244.w)) - View.View_PreViewTranslation;
    float2 _250 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5;
    float4 _256 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _250, bias(View.View_MaterialTextureMipBias));
    float2 _259 = (_256.xy * float2(2.0)) - float2(1.0);
    float3 _275 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_259, sqrt(fast::clamp(1.0 - dot(_259, _259), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _287 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _292 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _297 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _301 = (_287.x + 0.5) * ((_292.x + 0.5) * (_297.x + 0.5));
    float4 _306 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _250, bias(View.View_MaterialTextureMipBias));
    float4 _312 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _250, bias(View.View_MaterialTextureMipBias));
    float _313 = _312.w;
    float3 _320 = fast::clamp(_306.xyz * mix(0.800000011920928955078125, 1.2000000476837158203125, _301), float3(0.0), float3(1.0));
    float _321 = fast::clamp(fast::min(fast::max(_313, 0.0), 1.0) * 2.0, 0.0, 1.0);
    float _322 = fast::clamp(_313, 0.0, 1.0);
    float _327 = (fast::clamp(mix(0.20000000298023223876953125, mix(0.60000002384185791015625, 1.0, _301), _312.x), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _328 = in.in_var_PRIMITIVE_ID * 36u;
    uint _329 = _328 + 20u;
    float _377;
    float _378;
    float _379;
    float3 _380;
    float3 _381;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _329)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _347 = ((_239.xy / float2(_239.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _351 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _347, level(0.0));
        float4 _354 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _347, level(0.0));
        float4 _357 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _347, level(0.0));
        float _367 = _357.w;
        _377 = (_327 * _367) + _357.z;
        _378 = (_321 * _367) + _357.y;
        _379 = _357.x;
        _380 = (_320 * _351.w) + _351.xyz;
        _381 = normalize((_275 * _354.w) + ((_354.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _377 = _327;
        _378 = _321;
        _379 = 0.0;
        _380 = _320;
        _381 = _275;
    }
    float3 _391 = fast::clamp((_249 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _402 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_391.x), int(_391.y), int(_391.z), 0).xyz), 0));
    float3 _417 = (((_402.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_391 / float3(_402.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _430;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _329)].z > 0.0)
    {
        _430 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _417, level(0.0)).x;
    }
    else
    {
        _430 = 1.0;
    }
    float3 _444 = ((_380 - (_380 * _379)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _451 = (mix(float3(0.07999999821186065673828125 * _378), _380, float3(_379)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _454 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _459;
    if (_454)
    {
        _459 = _444 + (_451 * 0.449999988079071044921875);
    }
    else
    {
        _459 = _444;
    }
    float3 _461 = select(_451, float3(0.0), bool3(_454));
    float3 _463 = float3(dot(_461, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _470 = float3(_322);
    float4 _481 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _417, level(0.0));
    float _497 = _481.x;
    float4 _499 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _417, level(0.0)) * 2.0) - float4(1.0)) * _497) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _500 = _481.y;
    float4 _502 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _417, level(0.0)) * 2.0) - float4(1.0)) * _500) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _503 = _481.z;
    float4 _505 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _417, level(0.0)) * 2.0) - float4(1.0)) * _503) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _522 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _417, level(0.0)) * 2.0) - float4(1.0)) * _497) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _524 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _417, level(0.0)) * 2.0) - float4(1.0)) * _500) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _526 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _417, level(0.0)) * 2.0) - float4(1.0)) * _503) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _559 = _182;
    _559.y = (-0.48860299587249755859375) * _381.y;
    float4 _562 = _559;
    _562.z = 0.48860299587249755859375 * _381.z;
    float4 _565 = _562;
    _565.w = (-0.48860299587249755859375) * _381.x;
    float3 _566 = _381 * _381;
    float4 _569 = _178;
    _569.x = (1.09254801273345947265625 * _381.x) * _381.y;
    float4 _572 = _569;
    _572.y = ((-1.09254801273345947265625) * _381.y) * _381.z;
    float4 _577 = _572;
    _577.z = 0.3153919875621795654296875 * ((3.0 * _566.z) - 1.0);
    float4 _580 = _577;
    _580.w = ((-1.09254801273345947265625) * _381.x) * _381.z;
    float4 _584 = _565;
    _584.x = 0.886227548122406005859375;
    float3 _586 = _584.yzw * 2.094395160675048828125;
    float4 _587 = float4(_584.x, _586.x, _586.y, _586.z);
    float4 _588 = _580 * 0.785398185253143310546875;
    float _589 = (_566.x - _566.y) * 0.4290426075458526611328125;
    float3 _595 = float3(0.0);
    _595.x = (dot(float4(_497, _499.xyz), _587) + dot(float4(_499.w, _522.xyz), _588)) + (_522.w * _589);
    float3 _601 = _595;
    _601.y = (dot(float4(_500, _502.xyz), _587) + dot(float4(_502.w, _524.xyz), _588)) + (_524.w * _589);
    float3 _607 = _601;
    _607.z = (dot(float4(_503, _505.xyz), _587) + dot(float4(_505.w, _526.xyz), _588)) + (_526.w * _589);
    float _636;
    float _637;
    float3 _638;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _623 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _417, level(0.0)).xyz * 2.0) - float3(1.0);
        float _624 = length(_623);
        float3 _627 = _623 / float3(fast::max(_624, 9.9999997473787516355514526367188e-05));
        float _628 = 1.0 - _624;
        float _630 = 1.0 - (_628 * _628);
        _636 = mix(fast::clamp(dot(_627, _381), 0.0, 1.0), 1.0, _630);
        _637 = _624;
        _638 = mix(_627, _381, float3(_630));
    }
    else
    {
        _636 = 1.0;
        _637 = 1.0;
        _638 = _381;
    }
    float4 _642 = float4(_638, 1.0);
    float3 _646 = _179;
    _646.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _642);
    float3 _650 = _646;
    _650.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _642);
    float3 _654 = _650;
    _654.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _642);
    float4 _657 = _642.xyzz * _642.yzzx;
    float3 _661 = _179;
    _661.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _657);
    float3 _665 = _661;
    _665.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _657);
    float3 _669 = _665;
    _669.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _657);
    float3 _684 = ((fast::max(float3(0.0), _607) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_654 + _669) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_638.x * _638.x) - (_638.y * _638.y)))) * View.View_SkyLightColor.xyz) * (_637 * _636));
    float3 _706 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _735;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _734;
        if (any(abs(_249 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _328 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _328 + 19u)].xyz + float3(1.0))))
        {
            _734 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_249, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _734 = _706;
        }
        _735 = _734;
    }
    else
    {
        _735 = _706;
    }
    float4 _742 = float4(((mix(float3(0.0), _459 + (_461 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_684 * _459) * fast::max(_470, ((((((_380 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _322) + ((_380 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _322) + ((_380 * 2.755199909210205078125) + float3(0.69029998779296875))) * _322))) + _735) * 1.0, 0.0);
    float4 _749;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _748 = _742;
        _748.w = 0.0;
        _749 = _748;
    }
    else
    {
        _749 = _742;
    }
    float2 _753 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _761 = (_381 * 0.5) + float3(0.5);
    float4 _763 = float4(_761.x, _761.y, _761.z, float4(0.0).w);
    _763.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _329)].y;
    float4 _764 = float4(0.0);
    _764.x = _379;
    float4 _765 = _764;
    _765.y = _378;
    float4 _766 = _765;
    _766.z = _377;
    float4 _767 = _766;
    _767.w = 0.50588238239288330078125;
    float4 _779 = float4(_380.x, _380.y, _380.z, float4(0.0).w);
    _779.w = ((log2(((dot(_684, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_470, ((((((_463 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _322) + ((_463 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _322) + ((_463 * 2.755199909210205078125) + float3(0.69029998779296875))) * _322).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_753.xyx * _753.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _749 * View.View_PreExposure;
    out.out_var_SV_Target1 = _763;
    out.out_var_SV_Target2 = _767;
    out.out_var_SV_Target3 = _779;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_430, 1.0, 1.0, 1.0);
    return out;
}

