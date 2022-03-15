

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

constant float4 _172 = {};
constant float3 _173 = {};
constant float _175 = {};
constant float4 _176 = {};

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

fragment MainPS_out Main_00004d27_c15ddc0d(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(11)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(12)]], texture2d<float> Material_Texture2D_0 [[texture(13)]], texture2d<float> Material_Texture2D_1 [[texture(14)]], texture2d<float> Material_Texture2D_2 [[texture(15)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _233 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _175, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _238 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _243 = (_238.xyz / float3(_238.w)) - View.View_PreViewTranslation;
    float4 _249 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _252 = (_249.xy * float2(2.0)) - float2(1.0);
    float3 _268 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_252, sqrt(fast::clamp(1.0 - dot(_252, _252), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _280 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _285 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _290 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _294 = (_280.x + 0.5) * ((_285.x + 0.5) * (_290.x + 0.5));
    float4 _300 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _306 = fast::clamp(mix(float3(0.5), float3(1.0), float3(_294)) * _300.xyz, float3(0.0), float3(1.0));
    float _311 = (fast::clamp(mix(0.5, 0.300000011920928955078125, _294 * _300.w), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _312 = in.in_var_PRIMITIVE_ID * 36u;
    uint _313 = _312 + 20u;
    float _362;
    float _363;
    float _364;
    float3 _365;
    float3 _366;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _313)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _331 = ((_233.xy / float2(_233.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _335 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _331, level(0.0));
        float4 _338 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _331, level(0.0));
        float4 _341 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _331, level(0.0));
        float _351 = _341.w;
        _362 = (_311 * _351) + _341.z;
        _363 = (0.5 * _351) + _341.y;
        _364 = _351 + _341.x;
        _365 = (_306 * _335.w) + _335.xyz;
        _366 = normalize((_268 * _338.w) + ((_338.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _362 = _311;
        _363 = 0.5;
        _364 = 1.0;
        _365 = _306;
        _366 = _268;
    }
    float3 _376 = fast::clamp((_243 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _387 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_376.x), int(_376.y), int(_376.z), 0).xyz), 0));
    float3 _402 = (((_387.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_376 / float3(_387.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _415;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _313)].z > 0.0)
    {
        _415 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _402, level(0.0)).x;
    }
    else
    {
        _415 = 1.0;
    }
    float3 _429 = ((_365 - (_365 * _364)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _436 = (mix(float3(0.07999999821186065673828125 * _363), _365, float3(_364)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _439 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _444;
    if (_439)
    {
        _444 = _429 + (_436 * 0.449999988079071044921875);
    }
    else
    {
        _444 = _429;
    }
    float3 _446 = select(_436, float3(0.0), bool3(_439));
    float3 _448 = float3(dot(_446, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _465 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _402, level(0.0));
    float _481 = _465.x;
    float4 _483 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _402, level(0.0)) * 2.0) - float4(1.0)) * _481) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _484 = _465.y;
    float4 _486 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _402, level(0.0)) * 2.0) - float4(1.0)) * _484) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _487 = _465.z;
    float4 _489 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _402, level(0.0)) * 2.0) - float4(1.0)) * _487) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _506 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _402, level(0.0)) * 2.0) - float4(1.0)) * _481) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _508 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _402, level(0.0)) * 2.0) - float4(1.0)) * _484) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _510 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _402, level(0.0)) * 2.0) - float4(1.0)) * _487) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _543 = _176;
    _543.y = (-0.48860299587249755859375) * _366.y;
    float4 _546 = _543;
    _546.z = 0.48860299587249755859375 * _366.z;
    float4 _549 = _546;
    _549.w = (-0.48860299587249755859375) * _366.x;
    float3 _550 = _366 * _366;
    float4 _553 = _172;
    _553.x = (1.09254801273345947265625 * _366.x) * _366.y;
    float4 _556 = _553;
    _556.y = ((-1.09254801273345947265625) * _366.y) * _366.z;
    float4 _561 = _556;
    _561.z = 0.3153919875621795654296875 * ((3.0 * _550.z) - 1.0);
    float4 _564 = _561;
    _564.w = ((-1.09254801273345947265625) * _366.x) * _366.z;
    float4 _568 = _549;
    _568.x = 0.886227548122406005859375;
    float3 _570 = _568.yzw * 2.094395160675048828125;
    float4 _571 = float4(_568.x, _570.x, _570.y, _570.z);
    float4 _572 = _564 * 0.785398185253143310546875;
    float _573 = (_550.x - _550.y) * 0.4290426075458526611328125;
    float3 _579 = float3(0.0);
    _579.x = (dot(float4(_481, _483.xyz), _571) + dot(float4(_483.w, _506.xyz), _572)) + (_506.w * _573);
    float3 _585 = _579;
    _585.y = (dot(float4(_484, _486.xyz), _571) + dot(float4(_486.w, _508.xyz), _572)) + (_508.w * _573);
    float3 _591 = _585;
    _591.z = (dot(float4(_487, _489.xyz), _571) + dot(float4(_489.w, _510.xyz), _572)) + (_510.w * _573);
    float _620;
    float _621;
    float3 _622;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _607 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _402, level(0.0)).xyz * 2.0) - float3(1.0);
        float _608 = length(_607);
        float3 _611 = _607 / float3(fast::max(_608, 9.9999997473787516355514526367188e-05));
        float _612 = 1.0 - _608;
        float _614 = 1.0 - (_612 * _612);
        _620 = mix(fast::clamp(dot(_611, _366), 0.0, 1.0), 1.0, _614);
        _621 = _608;
        _622 = mix(_611, _366, float3(_614));
    }
    else
    {
        _620 = 1.0;
        _621 = 1.0;
        _622 = _366;
    }
    float4 _626 = float4(_622, 1.0);
    float3 _630 = _173;
    _630.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _626);
    float3 _634 = _630;
    _634.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _626);
    float3 _638 = _634;
    _638.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _626);
    float4 _641 = _626.xyzz * _626.yzzx;
    float3 _645 = _173;
    _645.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _641);
    float3 _649 = _645;
    _649.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _641);
    float3 _653 = _649;
    _653.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _641);
    float3 _668 = ((fast::max(float3(0.0), _591) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_638 + _653) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_622.x * _622.x) - (_622.y * _622.y)))) * View.View_SkyLightColor.xyz) * (_621 * _620));
    float3 _690 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _719;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _718;
        if (any(abs(_243 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _312 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _312 + 19u)].xyz + float3(1.0))))
        {
            _718 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_243, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _718 = _690;
        }
        _719 = _718;
    }
    else
    {
        _719 = _690;
    }
    float4 _726 = float4(((mix(float3(0.0), _444 + (_446 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_668 * _444) * fast::max(float3(1.0), ((((((_365 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_365 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_365 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _719) * 1.0, 0.0);
    float4 _733;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _732 = _726;
        _732.w = 0.0;
        _733 = _732;
    }
    else
    {
        _733 = _726;
    }
    float2 _737 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _745 = (_366 * 0.5) + float3(0.5);
    float4 _747 = float4(_745.x, _745.y, _745.z, float4(0.0).w);
    _747.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _313)].y;
    float4 _748 = float4(0.0);
    _748.x = _364;
    float4 _749 = _748;
    _749.y = _363;
    float4 _750 = _749;
    _750.z = _362;
    float4 _751 = _750;
    _751.w = 0.50588238239288330078125;
    float4 _763 = float4(_365.x, _365.y, _365.z, float4(0.0).w);
    _763.w = ((log2(((dot(_668, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_448 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_448 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_448 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_737.xyx * _737.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _733 * View.View_PreExposure;
    out.out_var_SV_Target1 = _747;
    out.out_var_SV_Target2 = _751;
    out.out_var_SV_Target3 = _763;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_415, 1.0, 1.0, 1.0);
    return out;
}

