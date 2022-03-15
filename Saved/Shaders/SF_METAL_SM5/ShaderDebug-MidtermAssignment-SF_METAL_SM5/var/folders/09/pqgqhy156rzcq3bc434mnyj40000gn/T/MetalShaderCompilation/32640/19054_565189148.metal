

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
    spvUnsafeArray<float4, 4> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _169 = {};
constant float3 _170 = {};
constant float _172 = {};
constant float4 _173 = {};

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

fragment MainPS_out Main_00004a6e_21b01a1c(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(11)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(12)]], texture2d<float> Material_Texture2D_0 [[texture(13)]], texture2d<float> Material_Texture2D_1 [[texture(14)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _230 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _172, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _235 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _240 = (_235.xyz / float3(_235.w)) - View.View_PreViewTranslation;
    float4 _246 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _249 = (_246.xy * float2(2.0)) - float2(1.0);
    float3 _265 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_249, sqrt(fast::clamp(1.0 - dot(_249, _249), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _276 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _280 = _276.x;
    float3 _289 = fast::clamp(Material.Material_VectorExpressions[3].xyz * _280, float3(0.0), float3(1.0));
    float _290 = fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0);
    float _295 = (fast::clamp(mix(Material.Material_ScalarExpressions[0].z, Material.Material_ScalarExpressions[0].w, _280), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _296 = in.in_var_PRIMITIVE_ID * 36u;
    uint _297 = _296 + 20u;
    float _347;
    float _348;
    float _349;
    float3 _350;
    float3 _351;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _297)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _315 = ((_230.xy / float2(_230.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _319 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _315, level(0.0));
        float4 _322 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _315, level(0.0));
        float4 _325 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _315, level(0.0));
        float _335 = _325.w;
        _347 = (_295 * _335) + _325.z;
        _348 = (0.5 * _335) + _325.y;
        _349 = (_290 * _335) + _325.x;
        _350 = (_289 * _319.w) + _319.xyz;
        _351 = normalize((_265 * _322.w) + ((_322.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _347 = _295;
        _348 = 0.5;
        _349 = _290;
        _350 = _289;
        _351 = _265;
    }
    float3 _361 = fast::clamp((_240 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _372 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_361.x), int(_361.y), int(_361.z), 0).xyz), 0));
    float3 _387 = (((_372.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_361 / float3(_372.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _400;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _297)].z > 0.0)
    {
        _400 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _387, level(0.0)).x;
    }
    else
    {
        _400 = 1.0;
    }
    float3 _414 = ((_350 - (_350 * _349)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _421 = (mix(float3(0.07999999821186065673828125 * _348), _350, float3(_349)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _424 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _429;
    if (_424)
    {
        _429 = _414 + (_421 * 0.449999988079071044921875);
    }
    else
    {
        _429 = _414;
    }
    float3 _431 = select(_421, float3(0.0), bool3(_424));
    float3 _433 = float3(dot(_431, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _450 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _387, level(0.0));
    float _466 = _450.x;
    float4 _468 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _387, level(0.0)) * 2.0) - float4(1.0)) * _466) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _469 = _450.y;
    float4 _471 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _387, level(0.0)) * 2.0) - float4(1.0)) * _469) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _472 = _450.z;
    float4 _474 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _387, level(0.0)) * 2.0) - float4(1.0)) * _472) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _491 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _387, level(0.0)) * 2.0) - float4(1.0)) * _466) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _493 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _387, level(0.0)) * 2.0) - float4(1.0)) * _469) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _495 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _387, level(0.0)) * 2.0) - float4(1.0)) * _472) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _528 = _173;
    _528.y = (-0.48860299587249755859375) * _351.y;
    float4 _531 = _528;
    _531.z = 0.48860299587249755859375 * _351.z;
    float4 _534 = _531;
    _534.w = (-0.48860299587249755859375) * _351.x;
    float3 _535 = _351 * _351;
    float4 _538 = _169;
    _538.x = (1.09254801273345947265625 * _351.x) * _351.y;
    float4 _541 = _538;
    _541.y = ((-1.09254801273345947265625) * _351.y) * _351.z;
    float4 _546 = _541;
    _546.z = 0.3153919875621795654296875 * ((3.0 * _535.z) - 1.0);
    float4 _549 = _546;
    _549.w = ((-1.09254801273345947265625) * _351.x) * _351.z;
    float4 _553 = _534;
    _553.x = 0.886227548122406005859375;
    float3 _555 = _553.yzw * 2.094395160675048828125;
    float4 _556 = float4(_553.x, _555.x, _555.y, _555.z);
    float4 _557 = _549 * 0.785398185253143310546875;
    float _558 = (_535.x - _535.y) * 0.4290426075458526611328125;
    float3 _564 = float3(0.0);
    _564.x = (dot(float4(_466, _468.xyz), _556) + dot(float4(_468.w, _491.xyz), _557)) + (_491.w * _558);
    float3 _570 = _564;
    _570.y = (dot(float4(_469, _471.xyz), _556) + dot(float4(_471.w, _493.xyz), _557)) + (_493.w * _558);
    float3 _576 = _570;
    _576.z = (dot(float4(_472, _474.xyz), _556) + dot(float4(_474.w, _495.xyz), _557)) + (_495.w * _558);
    float _605;
    float _606;
    float3 _607;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _592 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _387, level(0.0)).xyz * 2.0) - float3(1.0);
        float _593 = length(_592);
        float3 _596 = _592 / float3(fast::max(_593, 9.9999997473787516355514526367188e-05));
        float _597 = 1.0 - _593;
        float _599 = 1.0 - (_597 * _597);
        _605 = mix(fast::clamp(dot(_596, _351), 0.0, 1.0), 1.0, _599);
        _606 = _593;
        _607 = mix(_596, _351, float3(_599));
    }
    else
    {
        _605 = 1.0;
        _606 = 1.0;
        _607 = _351;
    }
    float4 _611 = float4(_607, 1.0);
    float3 _615 = _170;
    _615.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _611);
    float3 _619 = _615;
    _619.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _611);
    float3 _623 = _619;
    _623.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _611);
    float4 _626 = _611.xyzz * _611.yzzx;
    float3 _630 = _170;
    _630.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _626);
    float3 _634 = _630;
    _634.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _626);
    float3 _638 = _634;
    _638.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _626);
    float3 _653 = ((fast::max(float3(0.0), _576) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_623 + _638) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_607.x * _607.x) - (_607.y * _607.y)))) * View.View_SkyLightColor.xyz) * (_606 * _605));
    float3 _675 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _704;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _703;
        if (any(abs(_240 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _296 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _296 + 19u)].xyz + float3(1.0))))
        {
            _703 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_240, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _703 = _675;
        }
        _704 = _703;
    }
    else
    {
        _704 = _675;
    }
    float4 _711 = float4(((mix(float3(0.0), _429 + (_431 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_653 * _429) * fast::max(float3(1.0), ((((((_350 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_350 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_350 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _704) * 1.0, 0.0);
    float4 _718;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _717 = _711;
        _717.w = 0.0;
        _718 = _717;
    }
    else
    {
        _718 = _711;
    }
    float2 _722 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _730 = (_351 * 0.5) + float3(0.5);
    float4 _732 = float4(_730.x, _730.y, _730.z, float4(0.0).w);
    _732.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _297)].y;
    float4 _733 = float4(0.0);
    _733.x = _349;
    float4 _734 = _733;
    _734.y = _348;
    float4 _735 = _734;
    _735.z = _347;
    float4 _736 = _735;
    _736.w = 0.50588238239288330078125;
    float4 _748 = float4(_350.x, _350.y, _350.z, float4(0.0).w);
    _748.w = ((log2(((dot(_653, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_433 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_433 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_433 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_722.xyx * _722.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _718 * View.View_PreExposure;
    out.out_var_SV_Target1 = _732;
    out.out_var_SV_Target2 = _736;
    out.out_var_SV_Target3 = _748;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_400, 1.0, 1.0, 1.0);
    return out;
}

