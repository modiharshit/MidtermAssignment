

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
    char _m1_pad[352];
    float3 View_PreViewTranslation;
    char _m2_pad[1028];
    float View_PreExposure;
    float4 View_DiffuseOverrideParameter;
    float4 View_SpecularOverrideParameter;
    float4 View_NormalOverrideParameter;
    float2 View_RoughnessOverrideParameter;
    char _m7_pad[8];
    float View_OutOfBoundsMask;
    char _m8_pad[48];
    float View_MaterialTextureMipBias;
    char _m9_pad[28];
    float View_UnlitViewmodeMask;
    char _m10_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m11_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m12_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m14_pad[312];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m15_pad[48];
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

struct type_Primitive
{
    char _m0_pad[80];
    float4 Primitive_ObjectWorldPositionAndRadius;
    char _m1_pad[208];
    float3 Primitive_ObjectBounds;
    char _m2_pad[4];
    float Primitive_PerObjectGBufferData;
    float Primitive_UseVolumetricLightmapShadowFromStationaryLights;
};

struct type_Material
{
    spvUnsafeArray<float4, 4> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _174 = {};
constant float3 _175 = {};
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
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00004693_81f3b192(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> Material_Texture2D_0 [[texture(10)]], texture2d<float> Material_Texture2D_1 [[texture(11)]], texture2d<float> Material_Texture2D_2 [[texture(12)]], texture2d<float> Material_Texture2D_3 [[texture(13)]], sampler View_MaterialTextureBilinearWrapedSampler [[sampler(0)]], sampler View_SharedBilinearClampedSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _216 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _221 = (_216.xyz / float3(_216.w)) - View.View_PreViewTranslation;
    float4 _227 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _230 = (_227.xy * float2(2.0)) - float2(1.0);
    float _234 = sqrt(fast::clamp(1.0 - dot(_230, _230), 0.0, 1.0));
    float3 _242 = float3(float4(_230, _234, 1.0).xy * (-1.0), _234);
    float3 _246 = (float3(0.0, 0.0, 2.0) * dot(float3(0.0, 0.0, 2.0), _242)) - (_242 * 2.0);
    float3 _258 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize(((_246 / float3(sqrt(dot(_246, _246)))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _262 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _280 = Material_Texture2D_2.sample(View_MaterialTextureBilinearWrapedSampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 8.0));
    float3 _284 = float3(_262.x);
    float4 _289 = Material_Texture2D_3.sample(View_MaterialTextureBilinearWrapedSampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 50.0));
    float3 _293 = float3(_262.z);
    float3 _307 = fast::clamp(mix(mix(mix(Material.Material_VectorExpressions[3].xyz, Material.Material_VectorExpressions[3].xyz, float3(_262.y)), _280.xyz * float3(0.25), _284), _289.xyz * float3(0.2249999940395355224609375), _293), float3(0.0), float3(1.0));
    float _308 = fast::clamp(mix(mix(float3(0.0), float3(1.0), _284), float3(0.0), _293).x, 0.0, 1.0);
    float3 _323 = fast::clamp((_221 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _334 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_323.x), int(_323.y), int(_323.z), 0).xyz), 0));
    float3 _349 = (((_334.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_323 / float3(_334.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _362;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        _362 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _349, level(0.0)).x;
    }
    else
    {
        _362 = 1.0;
    }
    float3 _374 = ((_307 - (_307 * _308)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _381 = (mix(float3(0.039999999105930328369140625), _307, float3(_308)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _384 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _389;
    if (_384)
    {
        _389 = _374 + (_381 * 0.449999988079071044921875);
    }
    else
    {
        _389 = _374;
    }
    float3 _391 = select(_381, float3(0.0), bool3(_384));
    float3 _393 = float3(dot(_391, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _410 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _349, level(0.0));
    float _426 = _410.x;
    float4 _428 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _349, level(0.0)) * 2.0) - float4(1.0)) * _426) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _429 = _410.y;
    float4 _431 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _349, level(0.0)) * 2.0) - float4(1.0)) * _429) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _432 = _410.z;
    float4 _434 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _349, level(0.0)) * 2.0) - float4(1.0)) * _432) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _451 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _349, level(0.0)) * 2.0) - float4(1.0)) * _426) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _453 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _349, level(0.0)) * 2.0) - float4(1.0)) * _429) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _455 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _349, level(0.0)) * 2.0) - float4(1.0)) * _432) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float _486 = _258.y;
    float4 _488 = _177;
    _488.y = (-0.48860299587249755859375) * _486;
    float _489 = _258.z;
    float4 _491 = _488;
    _491.z = 0.48860299587249755859375 * _489;
    float _492 = _258.x;
    float4 _494 = _491;
    _494.w = (-0.48860299587249755859375) * _492;
    float3 _495 = _258 * _258;
    float4 _498 = _174;
    _498.x = (1.09254801273345947265625 * _492) * _486;
    float4 _501 = _498;
    _501.y = ((-1.09254801273345947265625) * _486) * _489;
    float4 _506 = _501;
    _506.z = 0.3153919875621795654296875 * ((3.0 * _495.z) - 1.0);
    float4 _509 = _506;
    _509.w = ((-1.09254801273345947265625) * _492) * _489;
    float4 _513 = _494;
    _513.x = 0.886227548122406005859375;
    float3 _515 = _513.yzw * 2.094395160675048828125;
    float4 _516 = float4(_513.x, _515.x, _515.y, _515.z);
    float4 _517 = _509 * 0.785398185253143310546875;
    float _518 = (_495.x - _495.y) * 0.4290426075458526611328125;
    float3 _524 = float3(0.0);
    _524.x = (dot(float4(_426, _428.xyz), _516) + dot(float4(_428.w, _451.xyz), _517)) + (_451.w * _518);
    float3 _530 = _524;
    _530.y = (dot(float4(_429, _431.xyz), _516) + dot(float4(_431.w, _453.xyz), _517)) + (_453.w * _518);
    float3 _536 = _530;
    _536.z = (dot(float4(_432, _434.xyz), _516) + dot(float4(_434.w, _455.xyz), _517)) + (_455.w * _518);
    float _565;
    float _566;
    float3 _567;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _552 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _349, level(0.0)).xyz * 2.0) - float3(1.0);
        float _553 = length(_552);
        float3 _556 = _552 / float3(fast::max(_553, 9.9999997473787516355514526367188e-05));
        float _557 = 1.0 - _553;
        float _559 = 1.0 - (_557 * _557);
        _565 = mix(fast::clamp(dot(_556, _258), 0.0, 1.0), 1.0, _559);
        _566 = _553;
        _567 = mix(_556, _258, float3(_559));
    }
    else
    {
        _565 = 1.0;
        _566 = 1.0;
        _567 = _258;
    }
    float4 _571 = float4(_567, 1.0);
    float3 _575 = _175;
    _575.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _571);
    float3 _579 = _575;
    _579.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _571);
    float3 _583 = _579;
    _583.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _571);
    float4 _586 = _571.xyzz * _571.yzzx;
    float3 _590 = _175;
    _590.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _586);
    float3 _594 = _590;
    _594.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _586);
    float3 _598 = _594;
    _598.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _586);
    float3 _613 = ((fast::max(float3(0.0), _536) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_583 + _598) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_567.x * _567.x) - (_567.y * _567.y)))) * View.View_SkyLightColor.xyz) * (_566 * _565));
    float3 _635 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _661;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _660;
        if (any(abs(_221 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _660 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_221, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _660 = _635;
        }
        _661 = _660;
    }
    else
    {
        _661 = _635;
    }
    float4 _668 = float4(((mix(float3(0.0), _389 + (_391 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_613 * _389) * fast::max(float3(1.0), ((((((_307 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_307 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_307 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _661) * 1.0, 0.0);
    float4 _675;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _674 = _668;
        _674.w = 0.0;
        _675 = _674;
    }
    else
    {
        _675 = _668;
    }
    float2 _680 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _688 = (_258 * 0.5) + float3(0.5);
    float4 _690 = float4(_688.x, _688.y, _688.z, float4(0.0).w);
    _690.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _691 = float4(0.0);
    _691.x = _308;
    float4 _692 = _691;
    _692.y = 0.5;
    float4 _693 = _692;
    _693.z = (fast::clamp(mix(mix(float3(0.100000001490116119384765625), float3(mix(0.37999999523162841796875, 0.550000011920928955078125, _280.x)), _284), float3(mix(0.550000011920928955078125, 0.75, _289.x)), _293).x, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float4 _694 = _693;
    _694.w = 0.50588238239288330078125;
    float4 _706 = float4(_307.x, _307.y, _307.z, float4(0.0).w);
    _706.w = ((log2(((dot(_613, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_393 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_393 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_393 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_680.xyx * _680.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _675 * View.View_PreExposure;
    out.out_var_SV_Target1 = _690;
    out.out_var_SV_Target2 = _694;
    out.out_var_SV_Target3 = _706;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_362, 1.0, 1.0, 1.0);
    return out;
}

