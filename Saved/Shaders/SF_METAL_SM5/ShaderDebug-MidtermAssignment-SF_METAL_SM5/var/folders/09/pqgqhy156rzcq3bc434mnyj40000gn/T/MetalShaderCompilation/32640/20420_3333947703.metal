

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
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _178 = {};
constant float3 _179 = {};
constant float4 _181 = {};

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

fragment MainPS_out Main_00004fc4_c6b80137(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(11)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(12)]], texture2d<float> Material_Texture2D_0 [[texture(13)]], texture2d<float> Material_Texture2D_1 [[texture(14)]], texture2d<float> Material_Texture2D_2 [[texture(15)]], texture2d<float> Material_Texture2D_3 [[texture(16)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _241 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _245 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _250 = (_245.xyz / float3(_245.w)) - View.View_PreViewTranslation;
    float2 _251 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5;
    float4 _257 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _251, bias(View.View_MaterialTextureMipBias));
    float2 _260 = (_257.xy * float2(2.0)) - float2(1.0);
    float4 _272 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _299;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _299 = _241.w;
                break;
            }
            else
            {
                float _283 = _241.z;
                _299 = ((_283 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_283 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _304 = fast::min(fast::max(((mix(-2000.0, 2000.0, _272.x) + _299) - 500.0) * 0.0005000000237487256526947021484375, 0.0), 1.0);
    float3 _315 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(float4(_260, sqrt(fast::clamp(1.0 - dot(_260, _260), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), float3(_304)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _326 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _251, bias(View.View_MaterialTextureMipBias));
    float4 _330 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _251, bias(View.View_MaterialTextureMipBias));
    float3 _336 = fast::clamp(_326.xyz, float3(0.0), float3(1.0));
    float _337 = fast::clamp(_326.x, 0.0, 1.0);
    float _338 = fast::clamp(_330.w, 0.0, 1.0);
    float _343 = (fast::clamp(mix(_330.x, 0.300000011920928955078125, _304), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _344 = in.in_var_PRIMITIVE_ID * 36u;
    uint _345 = _344 + 20u;
    float _393;
    float _394;
    float _395;
    float3 _396;
    float3 _397;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _345)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _363 = ((_241.xy / float2(_241.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _367 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _363, level(0.0));
        float4 _370 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _363, level(0.0));
        float4 _373 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _363, level(0.0));
        float _383 = _373.w;
        _393 = (_343 * _383) + _373.z;
        _394 = (_337 * _383) + _373.y;
        _395 = _373.x;
        _396 = (_336 * _367.w) + _367.xyz;
        _397 = normalize((_315 * _370.w) + ((_370.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _393 = _343;
        _394 = _337;
        _395 = 0.0;
        _396 = _336;
        _397 = _315;
    }
    float3 _407 = fast::clamp((_250 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _418 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_407.x), int(_407.y), int(_407.z), 0).xyz), 0));
    float3 _433 = (((_418.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_407 / float3(_418.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _446;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _345)].z > 0.0)
    {
        _446 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _433, level(0.0)).x;
    }
    else
    {
        _446 = 1.0;
    }
    float3 _460 = ((_396 - (_396 * _395)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _467 = (mix(float3(0.07999999821186065673828125 * _394), _396, float3(_395)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _470 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _475;
    if (_470)
    {
        _475 = _460 + (_467 * 0.449999988079071044921875);
    }
    else
    {
        _475 = _460;
    }
    float3 _477 = select(_467, float3(0.0), bool3(_470));
    float3 _479 = float3(dot(_477, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _486 = float3(_338);
    float4 _497 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _433, level(0.0));
    float _513 = _497.x;
    float4 _515 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _433, level(0.0)) * 2.0) - float4(1.0)) * _513) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _516 = _497.y;
    float4 _518 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _433, level(0.0)) * 2.0) - float4(1.0)) * _516) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _519 = _497.z;
    float4 _521 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _433, level(0.0)) * 2.0) - float4(1.0)) * _519) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _538 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _433, level(0.0)) * 2.0) - float4(1.0)) * _513) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _540 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _433, level(0.0)) * 2.0) - float4(1.0)) * _516) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _542 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _433, level(0.0)) * 2.0) - float4(1.0)) * _519) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _575 = _181;
    _575.y = (-0.48860299587249755859375) * _397.y;
    float4 _578 = _575;
    _578.z = 0.48860299587249755859375 * _397.z;
    float4 _581 = _578;
    _581.w = (-0.48860299587249755859375) * _397.x;
    float3 _582 = _397 * _397;
    float4 _585 = _178;
    _585.x = (1.09254801273345947265625 * _397.x) * _397.y;
    float4 _588 = _585;
    _588.y = ((-1.09254801273345947265625) * _397.y) * _397.z;
    float4 _593 = _588;
    _593.z = 0.3153919875621795654296875 * ((3.0 * _582.z) - 1.0);
    float4 _596 = _593;
    _596.w = ((-1.09254801273345947265625) * _397.x) * _397.z;
    float4 _600 = _581;
    _600.x = 0.886227548122406005859375;
    float3 _602 = _600.yzw * 2.094395160675048828125;
    float4 _603 = float4(_600.x, _602.x, _602.y, _602.z);
    float4 _604 = _596 * 0.785398185253143310546875;
    float _605 = (_582.x - _582.y) * 0.4290426075458526611328125;
    float3 _611 = float3(0.0);
    _611.x = (dot(float4(_513, _515.xyz), _603) + dot(float4(_515.w, _538.xyz), _604)) + (_538.w * _605);
    float3 _617 = _611;
    _617.y = (dot(float4(_516, _518.xyz), _603) + dot(float4(_518.w, _540.xyz), _604)) + (_540.w * _605);
    float3 _623 = _617;
    _623.z = (dot(float4(_519, _521.xyz), _603) + dot(float4(_521.w, _542.xyz), _604)) + (_542.w * _605);
    float _652;
    float _653;
    float3 _654;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _639 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _433, level(0.0)).xyz * 2.0) - float3(1.0);
        float _640 = length(_639);
        float3 _643 = _639 / float3(fast::max(_640, 9.9999997473787516355514526367188e-05));
        float _644 = 1.0 - _640;
        float _646 = 1.0 - (_644 * _644);
        _652 = mix(fast::clamp(dot(_643, _397), 0.0, 1.0), 1.0, _646);
        _653 = _640;
        _654 = mix(_643, _397, float3(_646));
    }
    else
    {
        _652 = 1.0;
        _653 = 1.0;
        _654 = _397;
    }
    float4 _658 = float4(_654, 1.0);
    float3 _662 = _179;
    _662.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _658);
    float3 _666 = _662;
    _666.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _658);
    float3 _670 = _666;
    _670.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _658);
    float4 _673 = _658.xyzz * _658.yzzx;
    float3 _677 = _179;
    _677.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _673);
    float3 _681 = _677;
    _681.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _673);
    float3 _685 = _681;
    _685.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _673);
    float3 _700 = ((fast::max(float3(0.0), _623) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_670 + _685) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_654.x * _654.x) - (_654.y * _654.y)))) * View.View_SkyLightColor.xyz) * (_653 * _652));
    float3 _722 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _751;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _750;
        if (any(abs(_250 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _344 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _344 + 19u)].xyz + float3(1.0))))
        {
            _750 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_250, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _750 = _722;
        }
        _751 = _750;
    }
    else
    {
        _751 = _722;
    }
    float4 _758 = float4(((mix(float3(0.0), _475 + (_477 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_700 * _475) * fast::max(_486, ((((((_396 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _338) + ((_396 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _338) + ((_396 * 2.755199909210205078125) + float3(0.69029998779296875))) * _338))) + _751) * 1.0, 0.0);
    float4 _765;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _764 = _758;
        _764.w = 0.0;
        _765 = _764;
    }
    else
    {
        _765 = _758;
    }
    float2 _769 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _777 = (_397 * 0.5) + float3(0.5);
    float4 _779 = float4(_777.x, _777.y, _777.z, float4(0.0).w);
    _779.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _345)].y;
    float4 _780 = float4(0.0);
    _780.x = _395;
    float4 _781 = _780;
    _781.y = _394;
    float4 _782 = _781;
    _782.z = _393;
    float4 _783 = _782;
    _783.w = 0.50588238239288330078125;
    float4 _795 = float4(_396.x, _396.y, _396.z, float4(0.0).w);
    _795.w = ((log2(((dot(_700, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_486, ((((((_479 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _338) + ((_479 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _338) + ((_479 * 2.755199909210205078125) + float3(0.69029998779296875))) * _338).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_769.xyx * _769.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _765 * View.View_PreExposure;
    out.out_var_SV_Target1 = _779;
    out.out_var_SV_Target2 = _783;
    out.out_var_SV_Target3 = _795;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_446, 1.0, 1.0, 1.0);
    return out;
}

