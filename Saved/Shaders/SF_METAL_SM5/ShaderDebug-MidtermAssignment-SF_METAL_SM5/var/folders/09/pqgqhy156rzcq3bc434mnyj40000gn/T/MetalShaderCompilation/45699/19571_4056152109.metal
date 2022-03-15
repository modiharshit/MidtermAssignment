

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

struct type_PrimitiveDither
{
    float PrimitiveDither_LODFactor;
};

struct type_Material
{
    spvUnsafeArray<float4, 7> Material_VectorExpressions;
    spvUnsafeArray<float4, 2> Material_ScalarExpressions;
};

constant float4 _177 = {};
constant float3 _178 = {};
constant float _180 = {};
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

fragment MainPS_out Main_00004c73_f1c3f82d(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_PrimitiveDither& PrimitiveDither [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(11)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(12)]], texture2d<float> Material_Texture2D_0 [[texture(13)]], sampler View_MaterialTextureBilinearClampedSampler [[sampler(0)]], sampler View_SharedBilinearClampedSampler [[sampler(1)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _237 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _180, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _242 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _247 = (_242.xyz / float3(_242.w)) - View.View_PreViewTranslation;
    float4 _251 = Material_Texture2D_0.sample(View_MaterialTextureBilinearClampedSampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y));
    float2 _254 = (_251.xy * float2(2.0)) - float2(1.0);
    float3 _270 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_254, sqrt(fast::clamp(1.0 - dot(_254, _254), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    if (PrimitiveDither.PrimitiveDither_LODFactor != 0.0)
    {
        if (abs(PrimitiveDither.PrimitiveDither_LODFactor) > 0.001000000047497451305389404296875)
        {
            float _305 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
            if ((float((PrimitiveDither.PrimitiveDither_LODFactor < 0.0) ? ((PrimitiveDither.PrimitiveDither_LODFactor + 1.0) > _305) : (PrimitiveDither.PrimitiveDither_LODFactor < _305)) - 0.001000000047497451305389404296875) < 0.0)
            {
                discard_fragment();
            }
        }
    }
    float3 _316 = fast::clamp(Material.Material_VectorExpressions[6].xyz, float3(0.0), float3(1.0));
    float _317 = fast::clamp(Material.Material_ScalarExpressions[0].z, 0.0, 1.0);
    float _318 = fast::clamp(Material.Material_ScalarExpressions[0].w, 0.0, 1.0);
    float _319 = fast::clamp(Material.Material_ScalarExpressions[1].y, 0.0, 1.0);
    float _324 = (fast::clamp(Material.Material_ScalarExpressions[1].x, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _325 = in.in_var_PRIMITIVE_ID * 36u;
    uint _326 = _325 + 20u;
    float _376;
    float _377;
    float _378;
    float3 _379;
    float3 _380;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _326)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _344 = ((_237.xy / float2(_237.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _348 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _344, level(0.0));
        float4 _351 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _344, level(0.0));
        float4 _354 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _344, level(0.0));
        float _364 = _354.w;
        _376 = (_324 * _364) + _354.z;
        _377 = (_318 * _364) + _354.y;
        _378 = (_317 * _364) + _354.x;
        _379 = (_316 * _348.w) + _348.xyz;
        _380 = normalize((_270 * _351.w) + ((_351.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _376 = _324;
        _377 = _318;
        _378 = _317;
        _379 = _316;
        _380 = _270;
    }
    float3 _390 = fast::clamp((_247 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _401 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_390.x), int(_390.y), int(_390.z), 0).xyz), 0));
    float3 _416 = (((_401.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_390 / float3(_401.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _429;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _326)].z > 0.0)
    {
        _429 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _416, level(0.0)).x;
    }
    else
    {
        _429 = 1.0;
    }
    float3 _443 = ((_379 - (_379 * _378)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _450 = (mix(float3(0.07999999821186065673828125 * _377), _379, float3(_378)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _453 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _458;
    if (_453)
    {
        _458 = _443 + (_450 * 0.449999988079071044921875);
    }
    else
    {
        _458 = _443;
    }
    float3 _460 = select(_450, float3(0.0), bool3(_453));
    float3 _462 = float3(dot(_460, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _469 = float3(_319);
    float4 _480 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _416, level(0.0));
    float _496 = _480.x;
    float4 _498 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _416, level(0.0)) * 2.0) - float4(1.0)) * _496) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _499 = _480.y;
    float4 _501 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _416, level(0.0)) * 2.0) - float4(1.0)) * _499) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _502 = _480.z;
    float4 _504 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _416, level(0.0)) * 2.0) - float4(1.0)) * _502) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _521 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _416, level(0.0)) * 2.0) - float4(1.0)) * _496) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _523 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _416, level(0.0)) * 2.0) - float4(1.0)) * _499) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _525 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _416, level(0.0)) * 2.0) - float4(1.0)) * _502) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _558 = _181;
    _558.y = (-0.48860299587249755859375) * _380.y;
    float4 _561 = _558;
    _561.z = 0.48860299587249755859375 * _380.z;
    float4 _564 = _561;
    _564.w = (-0.48860299587249755859375) * _380.x;
    float3 _565 = _380 * _380;
    float4 _568 = _177;
    _568.x = (1.09254801273345947265625 * _380.x) * _380.y;
    float4 _571 = _568;
    _571.y = ((-1.09254801273345947265625) * _380.y) * _380.z;
    float4 _576 = _571;
    _576.z = 0.3153919875621795654296875 * ((3.0 * _565.z) - 1.0);
    float4 _579 = _576;
    _579.w = ((-1.09254801273345947265625) * _380.x) * _380.z;
    float4 _583 = _564;
    _583.x = 0.886227548122406005859375;
    float3 _585 = _583.yzw * 2.094395160675048828125;
    float4 _586 = float4(_583.x, _585.x, _585.y, _585.z);
    float4 _587 = _579 * 0.785398185253143310546875;
    float _588 = (_565.x - _565.y) * 0.4290426075458526611328125;
    float3 _594 = float3(0.0);
    _594.x = (dot(float4(_496, _498.xyz), _586) + dot(float4(_498.w, _521.xyz), _587)) + (_521.w * _588);
    float3 _600 = _594;
    _600.y = (dot(float4(_499, _501.xyz), _586) + dot(float4(_501.w, _523.xyz), _587)) + (_523.w * _588);
    float3 _606 = _600;
    _606.z = (dot(float4(_502, _504.xyz), _586) + dot(float4(_504.w, _525.xyz), _587)) + (_525.w * _588);
    float _635;
    float _636;
    float3 _637;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _622 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _416, level(0.0)).xyz * 2.0) - float3(1.0);
        float _623 = length(_622);
        float3 _626 = _622 / float3(fast::max(_623, 9.9999997473787516355514526367188e-05));
        float _627 = 1.0 - _623;
        float _629 = 1.0 - (_627 * _627);
        _635 = mix(fast::clamp(dot(_626, _380), 0.0, 1.0), 1.0, _629);
        _636 = _623;
        _637 = mix(_626, _380, float3(_629));
    }
    else
    {
        _635 = 1.0;
        _636 = 1.0;
        _637 = _380;
    }
    float4 _641 = float4(_637, 1.0);
    float3 _645 = _178;
    _645.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _641);
    float3 _649 = _645;
    _649.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _641);
    float3 _653 = _649;
    _653.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _641);
    float4 _656 = _641.xyzz * _641.yzzx;
    float3 _660 = _178;
    _660.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _656);
    float3 _664 = _660;
    _664.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _656);
    float3 _668 = _664;
    _668.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _656);
    float3 _683 = ((fast::max(float3(0.0), _606) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_653 + _668) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_637.x * _637.x) - (_637.y * _637.y)))) * View.View_SkyLightColor.xyz) * (_636 * _635));
    float3 _705 = fast::max(mix(Material.Material_VectorExpressions[3].xyz, Material.Material_VectorExpressions[4].xyz, float3(Material.Material_ScalarExpressions[0].y)), float3(0.0));
    float3 _734;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _733;
        if (any(abs(_247 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _325 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _325 + 19u)].xyz + float3(1.0))))
        {
            _733 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_247, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _733 = _705;
        }
        _734 = _733;
    }
    else
    {
        _734 = _705;
    }
    float4 _741 = float4(((mix(float3(0.0), _458 + (_460 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_683 * _458) * fast::max(_469, ((((((_379 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _319) + ((_379 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _319) + ((_379 * 2.755199909210205078125) + float3(0.69029998779296875))) * _319))) + _734) * 1.0, 0.0);
    float4 _748;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _747 = _741;
        _747.w = 0.0;
        _748 = _747;
    }
    else
    {
        _748 = _741;
    }
    float2 _752 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _760 = (_380 * 0.5) + float3(0.5);
    float4 _762 = float4(_760.x, _760.y, _760.z, float4(0.0).w);
    _762.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _326)].y;
    float4 _763 = float4(0.0);
    _763.x = _378;
    float4 _764 = _763;
    _764.y = _377;
    float4 _765 = _764;
    _765.z = _376;
    float4 _766 = _765;
    _766.w = 0.50588238239288330078125;
    float4 _778 = float4(_379.x, _379.y, _379.z, float4(0.0).w);
    _778.w = ((log2(((dot(_683, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_469, ((((((_462 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _319) + ((_462 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _319) + ((_462 * 2.755199909210205078125) + float3(0.69029998779296875))) * _319).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_752.xyx * _752.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _748 * View.View_PreExposure;
    out.out_var_SV_Target1 = _762;
    out.out_var_SV_Target2 = _766;
    out.out_var_SV_Target3 = _778;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_429, 1.0, 1.0, 1.0);
    return out;
}

