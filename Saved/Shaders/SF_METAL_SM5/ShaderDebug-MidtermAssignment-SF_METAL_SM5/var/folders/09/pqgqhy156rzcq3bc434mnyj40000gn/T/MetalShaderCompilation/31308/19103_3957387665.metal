

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
    spvUnsafeArray<float4, 6> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _171 = {};
constant float3 _172 = {};
constant float _174 = {};
constant float4 _175 = {};

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

fragment MainPS_out Main_00004a9f_ebe0f191(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(11)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(12)]], texture2d<float> Material_Texture2D_0 [[texture(13)]], texture2d<float> Material_Texture2D_1 [[texture(14)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _232 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _174, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _237 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _242 = (_237.xyz / float3(_237.w)) - View.View_PreViewTranslation;
    float4 _248 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _251 = (_248.xy * float2(2.0)) - float2(1.0);
    float3 _267 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_251, sqrt(fast::clamp(1.0 - dot(_251, _251), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _278 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _285 = _278.y;
    float3 _296 = fast::clamp(mix(Material.Material_VectorExpressions[4].xyz, Material.Material_VectorExpressions[5].xyz, float3(_285)) * _278.x, float3(0.0), float3(1.0));
    float _297 = fast::clamp(mix(0.0, 1.0, _285), 0.0, 1.0);
    float _302 = (fast::clamp(mix(Material.Material_ScalarExpressions[0].y, Material.Material_ScalarExpressions[0].z, _285), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _303 = in.in_var_PRIMITIVE_ID * 36u;
    uint _304 = _303 + 20u;
    float _354;
    float _355;
    float _356;
    float3 _357;
    float3 _358;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _304)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _322 = ((_232.xy / float2(_232.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _326 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _322, level(0.0));
        float4 _329 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _322, level(0.0));
        float4 _332 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _322, level(0.0));
        float _342 = _332.w;
        _354 = (_302 * _342) + _332.z;
        _355 = (0.5 * _342) + _332.y;
        _356 = (_297 * _342) + _332.x;
        _357 = (_296 * _326.w) + _326.xyz;
        _358 = normalize((_267 * _329.w) + ((_329.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _354 = _302;
        _355 = 0.5;
        _356 = _297;
        _357 = _296;
        _358 = _267;
    }
    float3 _368 = fast::clamp((_242 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _379 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_368.x), int(_368.y), int(_368.z), 0).xyz), 0));
    float3 _394 = (((_379.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_368 / float3(_379.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _407;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _304)].z > 0.0)
    {
        _407 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _394, level(0.0)).x;
    }
    else
    {
        _407 = 1.0;
    }
    float3 _421 = ((_357 - (_357 * _356)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _428 = (mix(float3(0.07999999821186065673828125 * _355), _357, float3(_356)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _431 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _436;
    if (_431)
    {
        _436 = _421 + (_428 * 0.449999988079071044921875);
    }
    else
    {
        _436 = _421;
    }
    float3 _438 = select(_428, float3(0.0), bool3(_431));
    float3 _440 = float3(dot(_438, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _457 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _394, level(0.0));
    float _473 = _457.x;
    float4 _475 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _394, level(0.0)) * 2.0) - float4(1.0)) * _473) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _476 = _457.y;
    float4 _478 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _394, level(0.0)) * 2.0) - float4(1.0)) * _476) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _479 = _457.z;
    float4 _481 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _394, level(0.0)) * 2.0) - float4(1.0)) * _479) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _498 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _394, level(0.0)) * 2.0) - float4(1.0)) * _473) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _500 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _394, level(0.0)) * 2.0) - float4(1.0)) * _476) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _502 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _394, level(0.0)) * 2.0) - float4(1.0)) * _479) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _535 = _175;
    _535.y = (-0.48860299587249755859375) * _358.y;
    float4 _538 = _535;
    _538.z = 0.48860299587249755859375 * _358.z;
    float4 _541 = _538;
    _541.w = (-0.48860299587249755859375) * _358.x;
    float3 _542 = _358 * _358;
    float4 _545 = _171;
    _545.x = (1.09254801273345947265625 * _358.x) * _358.y;
    float4 _548 = _545;
    _548.y = ((-1.09254801273345947265625) * _358.y) * _358.z;
    float4 _553 = _548;
    _553.z = 0.3153919875621795654296875 * ((3.0 * _542.z) - 1.0);
    float4 _556 = _553;
    _556.w = ((-1.09254801273345947265625) * _358.x) * _358.z;
    float4 _560 = _541;
    _560.x = 0.886227548122406005859375;
    float3 _562 = _560.yzw * 2.094395160675048828125;
    float4 _563 = float4(_560.x, _562.x, _562.y, _562.z);
    float4 _564 = _556 * 0.785398185253143310546875;
    float _565 = (_542.x - _542.y) * 0.4290426075458526611328125;
    float3 _571 = float3(0.0);
    _571.x = (dot(float4(_473, _475.xyz), _563) + dot(float4(_475.w, _498.xyz), _564)) + (_498.w * _565);
    float3 _577 = _571;
    _577.y = (dot(float4(_476, _478.xyz), _563) + dot(float4(_478.w, _500.xyz), _564)) + (_500.w * _565);
    float3 _583 = _577;
    _583.z = (dot(float4(_479, _481.xyz), _563) + dot(float4(_481.w, _502.xyz), _564)) + (_502.w * _565);
    float _612;
    float _613;
    float3 _614;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _599 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _394, level(0.0)).xyz * 2.0) - float3(1.0);
        float _600 = length(_599);
        float3 _603 = _599 / float3(fast::max(_600, 9.9999997473787516355514526367188e-05));
        float _604 = 1.0 - _600;
        float _606 = 1.0 - (_604 * _604);
        _612 = mix(fast::clamp(dot(_603, _358), 0.0, 1.0), 1.0, _606);
        _613 = _600;
        _614 = mix(_603, _358, float3(_606));
    }
    else
    {
        _612 = 1.0;
        _613 = 1.0;
        _614 = _358;
    }
    float4 _618 = float4(_614, 1.0);
    float3 _622 = _172;
    _622.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _618);
    float3 _626 = _622;
    _626.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _618);
    float3 _630 = _626;
    _630.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _618);
    float4 _633 = _618.xyzz * _618.yzzx;
    float3 _637 = _172;
    _637.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _633);
    float3 _641 = _637;
    _641.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _633);
    float3 _645 = _641;
    _645.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _633);
    float3 _660 = ((fast::max(float3(0.0), _583) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_630 + _645) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_614.x * _614.x) - (_614.y * _614.y)))) * View.View_SkyLightColor.xyz) * (_613 * _612));
    float3 _682 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _711;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _710;
        if (any(abs(_242 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _303 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _303 + 19u)].xyz + float3(1.0))))
        {
            _710 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_242, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _710 = _682;
        }
        _711 = _710;
    }
    else
    {
        _711 = _682;
    }
    float4 _718 = float4(((mix(float3(0.0), _436 + (_438 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_660 * _436) * fast::max(float3(1.0), ((((((_357 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_357 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_357 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _711) * 1.0, 0.0);
    float4 _725;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _724 = _718;
        _724.w = 0.0;
        _725 = _724;
    }
    else
    {
        _725 = _718;
    }
    float2 _729 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _737 = (_358 * 0.5) + float3(0.5);
    float4 _739 = float4(_737.x, _737.y, _737.z, float4(0.0).w);
    _739.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _304)].y;
    float4 _740 = float4(0.0);
    _740.x = _356;
    float4 _741 = _740;
    _741.y = _355;
    float4 _742 = _741;
    _742.z = _354;
    float4 _743 = _742;
    _743.w = 0.50588238239288330078125;
    float4 _755 = float4(_357.x, _357.y, _357.z, float4(0.0).w);
    _755.w = ((log2(((dot(_660, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_440 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_440 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_440 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_729.xyx * _729.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _725 * View.View_PreExposure;
    out.out_var_SV_Target1 = _739;
    out.out_var_SV_Target2 = _743;
    out.out_var_SV_Target3 = _755;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_407, 1.0, 1.0, 1.0);
    return out;
}

