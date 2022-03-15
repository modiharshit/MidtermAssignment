

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

constant float4 _182 = {};
constant float3 _183 = {};
constant float _185 = {};
constant float4 _186 = {};

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

fragment MainPS_out Main_0000513f_151ac80d(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(11)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(12)]], texture2d<float> Material_Texture2D_0 [[texture(13)]], texture2d<float> Material_Texture2D_1 [[texture(14)]], texture2d<float> Material_Texture2D_2 [[texture(15)]], texture2d<float> Material_Texture2D_3 [[texture(16)]], texture2d<float> Material_Texture2D_4 [[texture(17)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], sampler Material_Texture2D_4Sampler [[sampler(6)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float3x3 _232 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _243 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _185, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _248 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _252 = _248.xyz / float3(_248.w);
    float3 _253 = _252 - View.View_PreViewTranslation;
    float2 _257 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5;
    float4 _263 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _257, bias(View.View_MaterialTextureMipBias));
    float2 _269 = ((normalize(-_252) * _232).xy * ((0.004999999888241291046142578125 * _263.w) + (-0.00449999980628490447998046875))) + _257;
    float4 _273 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _269, bias(View.View_MaterialTextureMipBias));
    float2 _276 = (_273.xy * float2(2.0)) - float2(1.0);
    float4 _289 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.100000001490116119384765625), bias(2.0 + View.View_MaterialTextureMipBias));
    float2 _292 = (_289.xy * float2(2.0)) - float2(1.0);
    float3 _311 = normalize(_232 * normalize(((float4(_276, sqrt(fast::clamp(1.0 - dot(_276, _276), 0.0, 1.0)), 1.0).xyz + (float4(_292, sqrt(fast::clamp(1.0 - dot(_292, _292), 0.0, 1.0)), 1.0).xyz * float3(0.20000000298023223876953125, 0.20000000298023223876953125, 0.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _323 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _328 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _331 = (_323.x + 0.5) * (_328.x + 0.5);
    float4 _334 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _269, bias(View.View_MaterialTextureMipBias));
    float4 _340 = Material_Texture2D_4.sample(Material_Texture2D_4Sampler, _269, bias(View.View_MaterialTextureMipBias));
    float3 _346 = fast::clamp(_334.xyz * mix(0.5, 1.0, _331), float3(0.0), float3(1.0));
    float _347 = fast::clamp(_340.y, 0.0, 1.0);
    float _352 = (fast::clamp(mix(-0.300000011920928955078125, 0.800000011920928955078125, _340.x + (_331 * 0.20000000298023223876953125)), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _353 = in.in_var_PRIMITIVE_ID * 36u;
    uint _354 = _353 + 20u;
    float _402;
    float _403;
    float _404;
    float3 _405;
    float3 _406;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _354)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _372 = ((_243.xy / float2(_243.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _376 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _372, level(0.0));
        float4 _379 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _372, level(0.0));
        float4 _382 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _372, level(0.0));
        float _392 = _382.w;
        _402 = (_352 * _392) + _382.z;
        _403 = (0.5 * _392) + _382.y;
        _404 = _382.x;
        _405 = (_346 * _376.w) + _376.xyz;
        _406 = normalize((_311 * _379.w) + ((_379.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _402 = _352;
        _403 = 0.5;
        _404 = 0.0;
        _405 = _346;
        _406 = _311;
    }
    float3 _416 = fast::clamp((_253 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _427 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_416.x), int(_416.y), int(_416.z), 0).xyz), 0));
    float3 _442 = (((_427.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_416 / float3(_427.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _455;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _354)].z > 0.0)
    {
        _455 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _442, level(0.0)).x;
    }
    else
    {
        _455 = 1.0;
    }
    float3 _469 = ((_405 - (_405 * _404)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _476 = (mix(float3(0.07999999821186065673828125 * _403), _405, float3(_404)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _479 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _484;
    if (_479)
    {
        _484 = _469 + (_476 * 0.449999988079071044921875);
    }
    else
    {
        _484 = _469;
    }
    float3 _486 = select(_476, float3(0.0), bool3(_479));
    float3 _488 = float3(dot(_486, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _495 = float3(_347);
    float4 _506 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _442, level(0.0));
    float _522 = _506.x;
    float4 _524 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _442, level(0.0)) * 2.0) - float4(1.0)) * _522) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _525 = _506.y;
    float4 _527 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _442, level(0.0)) * 2.0) - float4(1.0)) * _525) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _528 = _506.z;
    float4 _530 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _442, level(0.0)) * 2.0) - float4(1.0)) * _528) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _547 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _442, level(0.0)) * 2.0) - float4(1.0)) * _522) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _549 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _442, level(0.0)) * 2.0) - float4(1.0)) * _525) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _551 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _442, level(0.0)) * 2.0) - float4(1.0)) * _528) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _584 = _186;
    _584.y = (-0.48860299587249755859375) * _406.y;
    float4 _587 = _584;
    _587.z = 0.48860299587249755859375 * _406.z;
    float4 _590 = _587;
    _590.w = (-0.48860299587249755859375) * _406.x;
    float3 _591 = _406 * _406;
    float4 _594 = _182;
    _594.x = (1.09254801273345947265625 * _406.x) * _406.y;
    float4 _597 = _594;
    _597.y = ((-1.09254801273345947265625) * _406.y) * _406.z;
    float4 _602 = _597;
    _602.z = 0.3153919875621795654296875 * ((3.0 * _591.z) - 1.0);
    float4 _605 = _602;
    _605.w = ((-1.09254801273345947265625) * _406.x) * _406.z;
    float4 _609 = _590;
    _609.x = 0.886227548122406005859375;
    float3 _611 = _609.yzw * 2.094395160675048828125;
    float4 _612 = float4(_609.x, _611.x, _611.y, _611.z);
    float4 _613 = _605 * 0.785398185253143310546875;
    float _614 = (_591.x - _591.y) * 0.4290426075458526611328125;
    float3 _620 = float3(0.0);
    _620.x = (dot(float4(_522, _524.xyz), _612) + dot(float4(_524.w, _547.xyz), _613)) + (_547.w * _614);
    float3 _626 = _620;
    _626.y = (dot(float4(_525, _527.xyz), _612) + dot(float4(_527.w, _549.xyz), _613)) + (_549.w * _614);
    float3 _632 = _626;
    _632.z = (dot(float4(_528, _530.xyz), _612) + dot(float4(_530.w, _551.xyz), _613)) + (_551.w * _614);
    float _661;
    float _662;
    float3 _663;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _648 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _442, level(0.0)).xyz * 2.0) - float3(1.0);
        float _649 = length(_648);
        float3 _652 = _648 / float3(fast::max(_649, 9.9999997473787516355514526367188e-05));
        float _653 = 1.0 - _649;
        float _655 = 1.0 - (_653 * _653);
        _661 = mix(fast::clamp(dot(_652, _406), 0.0, 1.0), 1.0, _655);
        _662 = _649;
        _663 = mix(_652, _406, float3(_655));
    }
    else
    {
        _661 = 1.0;
        _662 = 1.0;
        _663 = _406;
    }
    float4 _667 = float4(_663, 1.0);
    float3 _671 = _183;
    _671.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _667);
    float3 _675 = _671;
    _675.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _667);
    float3 _679 = _675;
    _679.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _667);
    float4 _682 = _667.xyzz * _667.yzzx;
    float3 _686 = _183;
    _686.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _682);
    float3 _690 = _686;
    _690.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _682);
    float3 _694 = _690;
    _694.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _682);
    float3 _709 = ((fast::max(float3(0.0), _632) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_679 + _694) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_663.x * _663.x) - (_663.y * _663.y)))) * View.View_SkyLightColor.xyz) * (_662 * _661));
    float3 _731 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _760;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _759;
        if (any(abs(_253 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _353 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _353 + 19u)].xyz + float3(1.0))))
        {
            _759 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_253, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _759 = _731;
        }
        _760 = _759;
    }
    else
    {
        _760 = _731;
    }
    float4 _767 = float4(((mix(float3(0.0), _484 + (_486 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_709 * _484) * fast::max(_495, ((((((_405 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _347) + ((_405 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _347) + ((_405 * 2.755199909210205078125) + float3(0.69029998779296875))) * _347))) + _760) * 1.0, 0.0);
    float4 _774;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _773 = _767;
        _773.w = 0.0;
        _774 = _773;
    }
    else
    {
        _774 = _767;
    }
    float2 _778 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _786 = (_406 * 0.5) + float3(0.5);
    float4 _788 = float4(_786.x, _786.y, _786.z, float4(0.0).w);
    _788.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _354)].y;
    float4 _789 = float4(0.0);
    _789.x = _404;
    float4 _790 = _789;
    _790.y = _403;
    float4 _791 = _790;
    _791.z = _402;
    float4 _792 = _791;
    _792.w = 0.50588238239288330078125;
    float4 _804 = float4(_405.x, _405.y, _405.z, float4(0.0).w);
    _804.w = ((log2(((dot(_709, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_495, ((((((_488 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _347) + ((_488 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _347) + ((_488 * 2.755199909210205078125) + float3(0.69029998779296875))) * _347).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_778.xyx * _778.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _774 * View.View_PreExposure;
    out.out_var_SV_Target1 = _788;
    out.out_var_SV_Target2 = _792;
    out.out_var_SV_Target3 = _804;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_455, 1.0, 1.0, 1.0);
    return out;
}

