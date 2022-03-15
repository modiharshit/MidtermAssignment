

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

struct type_Material
{
    spvUnsafeArray<float4, 4> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _176 = {};
constant float3 _177 = {};
constant float4 _179 = {};

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

fragment MainPS_out Main_00004790_ca99c793(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> Material_Texture2D_0 [[texture(10)]], texture2d<float> Material_Texture2D_1 [[texture(11)]], texture2d<float> Material_Texture2D_2 [[texture(12)]], texture2d<float> Material_Texture2D_3 [[texture(13)]], sampler View_MaterialTextureBilinearWrapedSampler [[sampler(0)]], sampler View_SharedBilinearClampedSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _219 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _224 = (_219.xyz / float3(_219.w)) - View.View_PreViewTranslation;
    float4 _230 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _233 = (_230.xy * float2(2.0)) - float2(1.0);
    float _237 = sqrt(fast::clamp(1.0 - dot(_233, _233), 0.0, 1.0));
    float3 _245 = float3(float4(_233, _237, 1.0).xy * (-1.0), _237);
    float3 _249 = (float3(0.0, 0.0, 2.0) * dot(float3(0.0, 0.0, 2.0), _245)) - (_245 * 2.0);
    float3 _261 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize(((_249 / float3(sqrt(dot(_249, _249)))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _265 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _283 = Material_Texture2D_2.sample(View_MaterialTextureBilinearWrapedSampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 50.0));
    float3 _287 = float3(_265.x);
    float4 _292 = Material_Texture2D_3.sample(View_MaterialTextureBilinearWrapedSampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 8.0));
    float3 _296 = float3(_265.z);
    float3 _299 = float3(_265.w);
    float3 _314 = fast::clamp(mix(mix(mix(mix(Material.Material_VectorExpressions[3].xyz, Material.Material_VectorExpressions[3].xyz, float3(_265.y)), _283.xyz * float3(0.2249999940395355224609375), _287), _292.xyz * float3(0.25), _296), float3(0.0), _299), float3(0.0), float3(1.0));
    float _315 = fast::clamp(mix(mix(float3(0.0), float3(1.0), _296), float3(0.0), _299).x, 0.0, 1.0);
    float3 _330 = fast::clamp((_224 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _341 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_330.x), int(_330.y), int(_330.z), 0).xyz), 0));
    float3 _356 = (((_341.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_330 / float3(_341.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    uint _357 = in.in_var_PRIMITIVE_ID * 36u;
    uint _358 = _357 + 20u;
    float _372;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _358)].z > 0.0)
    {
        _372 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _356, level(0.0)).x;
    }
    else
    {
        _372 = 1.0;
    }
    float3 _384 = ((_314 - (_314 * _315)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _391 = (mix(float3(0.039999999105930328369140625), _314, float3(_315)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _394 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _399;
    if (_394)
    {
        _399 = _384 + (_391 * 0.449999988079071044921875);
    }
    else
    {
        _399 = _384;
    }
    float3 _401 = select(_391, float3(0.0), bool3(_394));
    float3 _403 = float3(dot(_401, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _420 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _356, level(0.0));
    float _436 = _420.x;
    float4 _438 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _356, level(0.0)) * 2.0) - float4(1.0)) * _436) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _439 = _420.y;
    float4 _441 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _356, level(0.0)) * 2.0) - float4(1.0)) * _439) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _442 = _420.z;
    float4 _444 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _356, level(0.0)) * 2.0) - float4(1.0)) * _442) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _461 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _356, level(0.0)) * 2.0) - float4(1.0)) * _436) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _463 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _356, level(0.0)) * 2.0) - float4(1.0)) * _439) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _465 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _356, level(0.0)) * 2.0) - float4(1.0)) * _442) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float _496 = _261.y;
    float4 _498 = _179;
    _498.y = (-0.48860299587249755859375) * _496;
    float _499 = _261.z;
    float4 _501 = _498;
    _501.z = 0.48860299587249755859375 * _499;
    float _502 = _261.x;
    float4 _504 = _501;
    _504.w = (-0.48860299587249755859375) * _502;
    float3 _505 = _261 * _261;
    float4 _508 = _176;
    _508.x = (1.09254801273345947265625 * _502) * _496;
    float4 _511 = _508;
    _511.y = ((-1.09254801273345947265625) * _496) * _499;
    float4 _516 = _511;
    _516.z = 0.3153919875621795654296875 * ((3.0 * _505.z) - 1.0);
    float4 _519 = _516;
    _519.w = ((-1.09254801273345947265625) * _502) * _499;
    float4 _523 = _504;
    _523.x = 0.886227548122406005859375;
    float3 _525 = _523.yzw * 2.094395160675048828125;
    float4 _526 = float4(_523.x, _525.x, _525.y, _525.z);
    float4 _527 = _519 * 0.785398185253143310546875;
    float _528 = (_505.x - _505.y) * 0.4290426075458526611328125;
    float3 _534 = float3(0.0);
    _534.x = (dot(float4(_436, _438.xyz), _526) + dot(float4(_438.w, _461.xyz), _527)) + (_461.w * _528);
    float3 _540 = _534;
    _540.y = (dot(float4(_439, _441.xyz), _526) + dot(float4(_441.w, _463.xyz), _527)) + (_463.w * _528);
    float3 _546 = _540;
    _546.z = (dot(float4(_442, _444.xyz), _526) + dot(float4(_444.w, _465.xyz), _527)) + (_465.w * _528);
    float _575;
    float _576;
    float3 _577;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _562 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _356, level(0.0)).xyz * 2.0) - float3(1.0);
        float _563 = length(_562);
        float3 _566 = _562 / float3(fast::max(_563, 9.9999997473787516355514526367188e-05));
        float _567 = 1.0 - _563;
        float _569 = 1.0 - (_567 * _567);
        _575 = mix(fast::clamp(dot(_566, _261), 0.0, 1.0), 1.0, _569);
        _576 = _563;
        _577 = mix(_566, _261, float3(_569));
    }
    else
    {
        _575 = 1.0;
        _576 = 1.0;
        _577 = _261;
    }
    float4 _581 = float4(_577, 1.0);
    float3 _585 = _177;
    _585.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _581);
    float3 _589 = _585;
    _589.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _581);
    float3 _593 = _589;
    _593.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _581);
    float4 _596 = _581.xyzz * _581.yzzx;
    float3 _600 = _177;
    _600.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _596);
    float3 _604 = _600;
    _604.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _596);
    float3 _608 = _604;
    _608.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _596);
    float3 _623 = ((fast::max(float3(0.0), _546) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_593 + _608) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_577.x * _577.x) - (_577.y * _577.y)))) * View.View_SkyLightColor.xyz) * (_576 * _575));
    float3 _645 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _674;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _673;
        if (any(abs(_224 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _357 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _357 + 19u)].xyz + float3(1.0))))
        {
            _673 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_224, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _673 = _645;
        }
        _674 = _673;
    }
    else
    {
        _674 = _645;
    }
    float4 _681 = float4(((mix(float3(0.0), _399 + (_401 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_623 * _399) * fast::max(float3(1.0), ((((((_314 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_314 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_314 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _674) * 1.0, 0.0);
    float4 _688;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _687 = _681;
        _687.w = 0.0;
        _688 = _687;
    }
    else
    {
        _688 = _681;
    }
    float2 _693 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _701 = (_261 * 0.5) + float3(0.5);
    float4 _703 = float4(_701.x, _701.y, _701.z, float4(0.0).w);
    _703.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _358)].y;
    float4 _704 = float4(0.0);
    _704.x = _315;
    float4 _705 = _704;
    _705.y = 0.5;
    float4 _706 = _705;
    _706.z = (fast::clamp(mix(mix(mix(float3(0.100000001490116119384765625), float3(mix(0.550000011920928955078125, 0.75, _283.x)), _287), float3(mix(0.37999999523162841796875, 0.550000011920928955078125, _292.x)), _296), float3(0.100000001490116119384765625), _299).x, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float4 _707 = _706;
    _707.w = 0.50588238239288330078125;
    float4 _719 = float4(_314.x, _314.y, _314.z, float4(0.0).w);
    _719.w = ((log2(((dot(_623, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_403 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_403 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_403 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_693.xyx * _693.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _688 * View.View_PreExposure;
    out.out_var_SV_Target1 = _703;
    out.out_var_SV_Target2 = _707;
    out.out_var_SV_Target3 = _719;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_372, 1.0, 1.0, 1.0);
    return out;
}

