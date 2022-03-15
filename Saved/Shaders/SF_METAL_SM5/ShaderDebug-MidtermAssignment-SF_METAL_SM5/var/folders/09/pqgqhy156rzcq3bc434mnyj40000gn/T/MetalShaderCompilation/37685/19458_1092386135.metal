

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
    spvUnsafeArray<float4, 8> Material_VectorExpressions;
    spvUnsafeArray<float4, 2> Material_ScalarExpressions;
};

constant float4 _173 = {};
constant float3 _174 = {};
constant float _176 = {};
constant float4 _177 = {};

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

fragment MainPS_out Main_00004c02_411c7d57(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(11)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(12)]], texture2d<float> Material_Texture2D_0 [[texture(13)]], texture2d<float> Material_Texture2D_1 [[texture(14)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _233 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _176, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _238 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _243 = (_238.xyz / float3(_238.w)) - View.View_PreViewTranslation;
    float4 _249 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _252 = (_249.xy * float2(2.0)) - float2(1.0);
    float3 _268 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_252, sqrt(fast::clamp(1.0 - dot(_252, _252), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _279 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _286 = _279.y;
    float _292 = _279.z;
    float _295 = _279.x;
    float3 _313 = fast::clamp(mix(mix(Material.Material_VectorExpressions[4].xyz, Material.Material_VectorExpressions[5].xyz, float3(_286)), Material.Material_VectorExpressions[7].xyz, float3(_292)) * _295, float3(0.0), float3(1.0));
    float _314 = fast::clamp(mix(mix(Material.Material_ScalarExpressions[0].y, Material.Material_ScalarExpressions[0].z, _286), Material.Material_ScalarExpressions[0].w, _292), 0.0, 1.0);
    float _315 = fast::clamp(_295, 0.0, 1.0);
    float _320 = (fast::clamp(mix(mix(Material.Material_ScalarExpressions[1].x, Material.Material_ScalarExpressions[1].y, _286), Material.Material_ScalarExpressions[1].z, _292), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _321 = in.in_var_PRIMITIVE_ID * 36u;
    uint _322 = _321 + 20u;
    float _372;
    float _373;
    float _374;
    float3 _375;
    float3 _376;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _322)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _340 = ((_233.xy / float2(_233.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _344 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _340, level(0.0));
        float4 _347 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _340, level(0.0));
        float4 _350 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _340, level(0.0));
        float _360 = _350.w;
        _372 = (_320 * _360) + _350.z;
        _373 = (0.5 * _360) + _350.y;
        _374 = (_314 * _360) + _350.x;
        _375 = (_313 * _344.w) + _344.xyz;
        _376 = normalize((_268 * _347.w) + ((_347.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _372 = _320;
        _373 = 0.5;
        _374 = _314;
        _375 = _313;
        _376 = _268;
    }
    float3 _386 = fast::clamp((_243 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _397 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_386.x), int(_386.y), int(_386.z), 0).xyz), 0));
    float3 _412 = (((_397.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_386 / float3(_397.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _425;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _322)].z > 0.0)
    {
        _425 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _412, level(0.0)).x;
    }
    else
    {
        _425 = 1.0;
    }
    float3 _439 = ((_375 - (_375 * _374)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _446 = (mix(float3(0.07999999821186065673828125 * _373), _375, float3(_374)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _449 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _454;
    if (_449)
    {
        _454 = _439 + (_446 * 0.449999988079071044921875);
    }
    else
    {
        _454 = _439;
    }
    float3 _456 = select(_446, float3(0.0), bool3(_449));
    float3 _458 = float3(dot(_456, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _465 = float3(_315);
    float4 _476 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _412, level(0.0));
    float _492 = _476.x;
    float4 _494 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _412, level(0.0)) * 2.0) - float4(1.0)) * _492) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _495 = _476.y;
    float4 _497 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _412, level(0.0)) * 2.0) - float4(1.0)) * _495) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _498 = _476.z;
    float4 _500 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _412, level(0.0)) * 2.0) - float4(1.0)) * _498) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _517 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _412, level(0.0)) * 2.0) - float4(1.0)) * _492) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _519 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _412, level(0.0)) * 2.0) - float4(1.0)) * _495) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _521 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _412, level(0.0)) * 2.0) - float4(1.0)) * _498) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _554 = _177;
    _554.y = (-0.48860299587249755859375) * _376.y;
    float4 _557 = _554;
    _557.z = 0.48860299587249755859375 * _376.z;
    float4 _560 = _557;
    _560.w = (-0.48860299587249755859375) * _376.x;
    float3 _561 = _376 * _376;
    float4 _564 = _173;
    _564.x = (1.09254801273345947265625 * _376.x) * _376.y;
    float4 _567 = _564;
    _567.y = ((-1.09254801273345947265625) * _376.y) * _376.z;
    float4 _572 = _567;
    _572.z = 0.3153919875621795654296875 * ((3.0 * _561.z) - 1.0);
    float4 _575 = _572;
    _575.w = ((-1.09254801273345947265625) * _376.x) * _376.z;
    float4 _579 = _560;
    _579.x = 0.886227548122406005859375;
    float3 _581 = _579.yzw * 2.094395160675048828125;
    float4 _582 = float4(_579.x, _581.x, _581.y, _581.z);
    float4 _583 = _575 * 0.785398185253143310546875;
    float _584 = (_561.x - _561.y) * 0.4290426075458526611328125;
    float3 _590 = float3(0.0);
    _590.x = (dot(float4(_492, _494.xyz), _582) + dot(float4(_494.w, _517.xyz), _583)) + (_517.w * _584);
    float3 _596 = _590;
    _596.y = (dot(float4(_495, _497.xyz), _582) + dot(float4(_497.w, _519.xyz), _583)) + (_519.w * _584);
    float3 _602 = _596;
    _602.z = (dot(float4(_498, _500.xyz), _582) + dot(float4(_500.w, _521.xyz), _583)) + (_521.w * _584);
    float _631;
    float _632;
    float3 _633;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _618 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _412, level(0.0)).xyz * 2.0) - float3(1.0);
        float _619 = length(_618);
        float3 _622 = _618 / float3(fast::max(_619, 9.9999997473787516355514526367188e-05));
        float _623 = 1.0 - _619;
        float _625 = 1.0 - (_623 * _623);
        _631 = mix(fast::clamp(dot(_622, _376), 0.0, 1.0), 1.0, _625);
        _632 = _619;
        _633 = mix(_622, _376, float3(_625));
    }
    else
    {
        _631 = 1.0;
        _632 = 1.0;
        _633 = _376;
    }
    float4 _637 = float4(_633, 1.0);
    float3 _641 = _174;
    _641.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _637);
    float3 _645 = _641;
    _645.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _637);
    float3 _649 = _645;
    _649.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _637);
    float4 _652 = _637.xyzz * _637.yzzx;
    float3 _656 = _174;
    _656.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _652);
    float3 _660 = _656;
    _660.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _652);
    float3 _664 = _660;
    _664.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _652);
    float3 _679 = ((fast::max(float3(0.0), _602) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_649 + _664) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_633.x * _633.x) - (_633.y * _633.y)))) * View.View_SkyLightColor.xyz) * (_632 * _631));
    float3 _701 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _730;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _729;
        if (any(abs(_243 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _321 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _321 + 19u)].xyz + float3(1.0))))
        {
            _729 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_243, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _729 = _701;
        }
        _730 = _729;
    }
    else
    {
        _730 = _701;
    }
    float4 _737 = float4(((mix(float3(0.0), _454 + (_456 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_679 * _454) * fast::max(_465, ((((((_375 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _315) + ((_375 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _315) + ((_375 * 2.755199909210205078125) + float3(0.69029998779296875))) * _315))) + _730) * 1.0, 0.0);
    float4 _744;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _743 = _737;
        _743.w = 0.0;
        _744 = _743;
    }
    else
    {
        _744 = _737;
    }
    float2 _748 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _756 = (_376 * 0.5) + float3(0.5);
    float4 _758 = float4(_756.x, _756.y, _756.z, float4(0.0).w);
    _758.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _322)].y;
    float4 _759 = float4(0.0);
    _759.x = _374;
    float4 _760 = _759;
    _760.y = _373;
    float4 _761 = _760;
    _761.z = _372;
    float4 _762 = _761;
    _762.w = 0.50588238239288330078125;
    float4 _774 = float4(_375.x, _375.y, _375.z, float4(0.0).w);
    _774.w = ((log2(((dot(_679, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_465, ((((((_458 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _315) + ((_458 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _315) + ((_458 * 2.755199909210205078125) + float3(0.69029998779296875))) * _315).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_748.xyx * _748.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _744 * View.View_PreExposure;
    out.out_var_SV_Target1 = _758;
    out.out_var_SV_Target2 = _762;
    out.out_var_SV_Target3 = _774;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_425, 1.0, 1.0, 1.0);
    return out;
}

