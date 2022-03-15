

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
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_Material
{
    spvUnsafeArray<float4, 6> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _180 = {};
constant float3 _181 = {};
constant float4 _183 = {};

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

fragment MainPS_out Main_00004fde_fb481b1b(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(11)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(12)]], texture2d<float> Material_Texture2D_0 [[texture(13)]], texture2d<float> Material_Texture2D_1 [[texture(14)]], texture2d<float> Material_Texture2D_2 [[texture(15)]], texture2d<float> Material_Texture2D_3 [[texture(16)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _243 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _247 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _252 = (_247.xyz / float3(_247.w)) - View.View_PreViewTranslation;
    float4 _258 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _261 = (_258.xy * float2(2.0)) - float2(1.0);
    float3 _277 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_261, sqrt(fast::clamp(1.0 - dot(_261, _261), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _288 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _292 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _311 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _338;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _338 = _243.w;
                break;
            }
            else
            {
                float _322 = _243.z;
                _338 = ((_322 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_322 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _347 = fast::clamp(_288.xyz * (mix(Material.Material_VectorExpressions[4].xyz, Material.Material_VectorExpressions[5].xyz, float3(_292.z)) * mix(0.5, 1.0, _292.x)), float3(0.0), float3(1.0));
    float _352 = (fast::clamp(mix(0.5, 0.20000000298023223876953125, mix(_288.w, 0.5, fast::min(fast::max(((mix(-2000.0, 2000.0, _311.x) + _338) - 1000.0) * 0.001000000047497451305389404296875, 0.0), 1.0))), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
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
        _405 = (_347 * _376.w) + _376.xyz;
        _406 = normalize((_277 * _379.w) + ((_379.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _402 = _352;
        _403 = 0.5;
        _404 = 0.0;
        _405 = _347;
        _406 = _277;
    }
    float3 _416 = fast::clamp((_252 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
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
    float4 _505 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _442, level(0.0));
    float _521 = _505.x;
    float4 _523 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _442, level(0.0)) * 2.0) - float4(1.0)) * _521) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _524 = _505.y;
    float4 _526 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _442, level(0.0)) * 2.0) - float4(1.0)) * _524) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _527 = _505.z;
    float4 _529 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _442, level(0.0)) * 2.0) - float4(1.0)) * _527) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _546 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _442, level(0.0)) * 2.0) - float4(1.0)) * _521) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _548 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _442, level(0.0)) * 2.0) - float4(1.0)) * _524) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _550 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _442, level(0.0)) * 2.0) - float4(1.0)) * _527) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _583 = _183;
    _583.y = (-0.48860299587249755859375) * _406.y;
    float4 _586 = _583;
    _586.z = 0.48860299587249755859375 * _406.z;
    float4 _589 = _586;
    _589.w = (-0.48860299587249755859375) * _406.x;
    float3 _590 = _406 * _406;
    float4 _593 = _180;
    _593.x = (1.09254801273345947265625 * _406.x) * _406.y;
    float4 _596 = _593;
    _596.y = ((-1.09254801273345947265625) * _406.y) * _406.z;
    float4 _601 = _596;
    _601.z = 0.3153919875621795654296875 * ((3.0 * _590.z) - 1.0);
    float4 _604 = _601;
    _604.w = ((-1.09254801273345947265625) * _406.x) * _406.z;
    float4 _608 = _589;
    _608.x = 0.886227548122406005859375;
    float3 _610 = _608.yzw * 2.094395160675048828125;
    float4 _611 = float4(_608.x, _610.x, _610.y, _610.z);
    float4 _612 = _604 * 0.785398185253143310546875;
    float _613 = (_590.x - _590.y) * 0.4290426075458526611328125;
    float3 _619 = float3(0.0);
    _619.x = (dot(float4(_521, _523.xyz), _611) + dot(float4(_523.w, _546.xyz), _612)) + (_546.w * _613);
    float3 _625 = _619;
    _625.y = (dot(float4(_524, _526.xyz), _611) + dot(float4(_526.w, _548.xyz), _612)) + (_548.w * _613);
    float3 _631 = _625;
    _631.z = (dot(float4(_527, _529.xyz), _611) + dot(float4(_529.w, _550.xyz), _612)) + (_550.w * _613);
    float _660;
    float _661;
    float3 _662;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _647 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _442, level(0.0)).xyz * 2.0) - float3(1.0);
        float _648 = length(_647);
        float3 _651 = _647 / float3(fast::max(_648, 9.9999997473787516355514526367188e-05));
        float _652 = 1.0 - _648;
        float _654 = 1.0 - (_652 * _652);
        _660 = mix(fast::clamp(dot(_651, _406), 0.0, 1.0), 1.0, _654);
        _661 = _648;
        _662 = mix(_651, _406, float3(_654));
    }
    else
    {
        _660 = 1.0;
        _661 = 1.0;
        _662 = _406;
    }
    float4 _666 = float4(_662, 1.0);
    float3 _670 = _181;
    _670.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _666);
    float3 _674 = _670;
    _674.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _666);
    float3 _678 = _674;
    _678.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _666);
    float4 _681 = _666.xyzz * _666.yzzx;
    float3 _685 = _181;
    _685.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _681);
    float3 _689 = _685;
    _689.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _681);
    float3 _693 = _689;
    _693.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _681);
    float3 _708 = ((fast::max(float3(0.0), _631) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_678 + _693) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_662.x * _662.x) - (_662.y * _662.y)))) * View.View_SkyLightColor.xyz) * (_661 * _660));
    float3 _730 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _759;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _758;
        if (any(abs(_252 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _353 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _353 + 19u)].xyz + float3(1.0))))
        {
            _758 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_252, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _758 = _730;
        }
        _759 = _758;
    }
    else
    {
        _759 = _730;
    }
    float4 _766 = float4(((mix(float3(0.0), _484 + (_486 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_708 * _484) * fast::max(float3(1.0), ((((((_405 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_405 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_405 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _759) * 1.0, 0.0);
    float4 _773;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _772 = _766;
        _772.w = 0.0;
        _773 = _772;
    }
    else
    {
        _773 = _766;
    }
    float2 _777 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _785 = (_406 * 0.5) + float3(0.5);
    float4 _787 = float4(_785.x, _785.y, _785.z, float4(0.0).w);
    _787.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _354)].y;
    float4 _788 = float4(0.0);
    _788.x = _404;
    float4 _789 = _788;
    _789.y = _403;
    float4 _790 = _789;
    _790.z = _402;
    float4 _791 = _790;
    _791.w = 0.50588238239288330078125;
    float4 _803 = float4(_405.x, _405.y, _405.z, float4(0.0).w);
    _803.w = ((log2(((dot(_708, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_488 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_488 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_488 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_777.xyx * _777.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _773 * View.View_PreExposure;
    out.out_var_SV_Target1 = _787;
    out.out_var_SV_Target2 = _791;
    out.out_var_SV_Target3 = _803;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_455, 1.0, 1.0, 1.0);
    return out;
}

