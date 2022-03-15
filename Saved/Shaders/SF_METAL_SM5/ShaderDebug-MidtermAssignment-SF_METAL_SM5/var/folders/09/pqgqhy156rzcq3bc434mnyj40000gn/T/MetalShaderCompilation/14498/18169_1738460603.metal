

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

fragment MainPS_out Main_000046f9_679ecdbb(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> Material_Texture2D_0 [[texture(10)]], texture2d<float> Material_Texture2D_1 [[texture(11)]], texture2d<float> Material_Texture2D_2 [[texture(12)]], texture2d<float> Material_Texture2D_3 [[texture(13)]], sampler View_MaterialTextureBilinearWrapedSampler [[sampler(0)]], sampler View_SharedBilinearClampedSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
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
    float4 _280 = Material_Texture2D_2.sample(View_MaterialTextureBilinearWrapedSampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 50.0));
    float3 _284 = float3(_262.x);
    float4 _289 = Material_Texture2D_3.sample(View_MaterialTextureBilinearWrapedSampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 8.0));
    float3 _293 = float3(_262.z);
    float3 _296 = float3(_262.w);
    float3 _311 = fast::clamp(mix(mix(mix(mix(Material.Material_VectorExpressions[3].xyz, Material.Material_VectorExpressions[3].xyz, float3(_262.y)), _280.xyz * float3(0.2249999940395355224609375), _284), _289.xyz * float3(0.25), _293), float3(0.0), _296), float3(0.0), float3(1.0));
    float _312 = fast::clamp(mix(mix(float3(0.0), float3(1.0), _293), float3(0.0), _296).x, 0.0, 1.0);
    float3 _327 = fast::clamp((_221 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _338 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_327.x), int(_327.y), int(_327.z), 0).xyz), 0));
    float3 _353 = (((_338.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_327 / float3(_338.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _366;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        _366 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _353, level(0.0)).x;
    }
    else
    {
        _366 = 1.0;
    }
    float3 _378 = ((_311 - (_311 * _312)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _385 = (mix(float3(0.039999999105930328369140625), _311, float3(_312)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _388 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _393;
    if (_388)
    {
        _393 = _378 + (_385 * 0.449999988079071044921875);
    }
    else
    {
        _393 = _378;
    }
    float3 _395 = select(_385, float3(0.0), bool3(_388));
    float3 _397 = float3(dot(_395, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _414 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _353, level(0.0));
    float _430 = _414.x;
    float4 _432 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _353, level(0.0)) * 2.0) - float4(1.0)) * _430) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _433 = _414.y;
    float4 _435 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _353, level(0.0)) * 2.0) - float4(1.0)) * _433) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _436 = _414.z;
    float4 _438 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _353, level(0.0)) * 2.0) - float4(1.0)) * _436) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _455 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _353, level(0.0)) * 2.0) - float4(1.0)) * _430) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _457 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _353, level(0.0)) * 2.0) - float4(1.0)) * _433) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _459 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _353, level(0.0)) * 2.0) - float4(1.0)) * _436) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float _490 = _258.y;
    float4 _492 = _177;
    _492.y = (-0.48860299587249755859375) * _490;
    float _493 = _258.z;
    float4 _495 = _492;
    _495.z = 0.48860299587249755859375 * _493;
    float _496 = _258.x;
    float4 _498 = _495;
    _498.w = (-0.48860299587249755859375) * _496;
    float3 _499 = _258 * _258;
    float4 _502 = _174;
    _502.x = (1.09254801273345947265625 * _496) * _490;
    float4 _505 = _502;
    _505.y = ((-1.09254801273345947265625) * _490) * _493;
    float4 _510 = _505;
    _510.z = 0.3153919875621795654296875 * ((3.0 * _499.z) - 1.0);
    float4 _513 = _510;
    _513.w = ((-1.09254801273345947265625) * _496) * _493;
    float4 _517 = _498;
    _517.x = 0.886227548122406005859375;
    float3 _519 = _517.yzw * 2.094395160675048828125;
    float4 _520 = float4(_517.x, _519.x, _519.y, _519.z);
    float4 _521 = _513 * 0.785398185253143310546875;
    float _522 = (_499.x - _499.y) * 0.4290426075458526611328125;
    float3 _528 = float3(0.0);
    _528.x = (dot(float4(_430, _432.xyz), _520) + dot(float4(_432.w, _455.xyz), _521)) + (_455.w * _522);
    float3 _534 = _528;
    _534.y = (dot(float4(_433, _435.xyz), _520) + dot(float4(_435.w, _457.xyz), _521)) + (_457.w * _522);
    float3 _540 = _534;
    _540.z = (dot(float4(_436, _438.xyz), _520) + dot(float4(_438.w, _459.xyz), _521)) + (_459.w * _522);
    float _569;
    float _570;
    float3 _571;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _556 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _353, level(0.0)).xyz * 2.0) - float3(1.0);
        float _557 = length(_556);
        float3 _560 = _556 / float3(fast::max(_557, 9.9999997473787516355514526367188e-05));
        float _561 = 1.0 - _557;
        float _563 = 1.0 - (_561 * _561);
        _569 = mix(fast::clamp(dot(_560, _258), 0.0, 1.0), 1.0, _563);
        _570 = _557;
        _571 = mix(_560, _258, float3(_563));
    }
    else
    {
        _569 = 1.0;
        _570 = 1.0;
        _571 = _258;
    }
    float4 _575 = float4(_571, 1.0);
    float3 _579 = _175;
    _579.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _575);
    float3 _583 = _579;
    _583.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _575);
    float3 _587 = _583;
    _587.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _575);
    float4 _590 = _575.xyzz * _575.yzzx;
    float3 _594 = _175;
    _594.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _590);
    float3 _598 = _594;
    _598.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _590);
    float3 _602 = _598;
    _602.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _590);
    float3 _617 = ((fast::max(float3(0.0), _540) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_587 + _602) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_571.x * _571.x) - (_571.y * _571.y)))) * View.View_SkyLightColor.xyz) * (_570 * _569));
    float3 _639 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _665;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _664;
        if (any(abs(_221 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _664 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_221, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _664 = _639;
        }
        _665 = _664;
    }
    else
    {
        _665 = _639;
    }
    float4 _672 = float4(((mix(float3(0.0), _393 + (_395 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_617 * _393) * fast::max(float3(1.0), ((((((_311 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_311 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_311 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _665) * 1.0, 0.0);
    float4 _679;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _678 = _672;
        _678.w = 0.0;
        _679 = _678;
    }
    else
    {
        _679 = _672;
    }
    float2 _684 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _692 = (_258 * 0.5) + float3(0.5);
    float4 _694 = float4(_692.x, _692.y, _692.z, float4(0.0).w);
    _694.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _695 = float4(0.0);
    _695.x = _312;
    float4 _696 = _695;
    _696.y = 0.5;
    float4 _697 = _696;
    _697.z = (fast::clamp(mix(mix(mix(float3(0.100000001490116119384765625), float3(mix(0.550000011920928955078125, 0.75, _280.x)), _284), float3(mix(0.37999999523162841796875, 0.550000011920928955078125, _289.x)), _293), float3(0.100000001490116119384765625), _296).x, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float4 _698 = _697;
    _698.w = 0.50588238239288330078125;
    float4 _710 = float4(_311.x, _311.y, _311.z, float4(0.0).w);
    _710.w = ((log2(((dot(_617, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_397 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_397 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_397 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_684.xyx * _684.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _679 * View.View_PreExposure;
    out.out_var_SV_Target1 = _694;
    out.out_var_SV_Target2 = _698;
    out.out_var_SV_Target3 = _710;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_366, 1.0, 1.0, 1.0);
    return out;
}

