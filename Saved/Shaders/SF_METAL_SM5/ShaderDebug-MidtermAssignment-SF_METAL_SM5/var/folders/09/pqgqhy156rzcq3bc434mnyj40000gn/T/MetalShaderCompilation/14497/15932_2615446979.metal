

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
    char _m12_pad[376];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m13_pad[48];
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

constant float4 _170 = {};
constant float4 _172 = {};

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

fragment MainPS_out Main_00003e3c_9be48dc3(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> Material_Texture2D_0 [[texture(9)]], texture2d<float> Material_Texture2D_1 [[texture(10)]], texture2d<float> Material_Texture2D_2 [[texture(11)]], texture2d<float> Material_Texture2D_3 [[texture(12)]], sampler View_MaterialTextureBilinearWrapedSampler [[sampler(0)]], sampler View_SharedBilinearClampedSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _212 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _217 = (_212.xyz / float3(_212.w)) - View.View_PreViewTranslation;
    float4 _223 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _226 = (_223.xy * float2(2.0)) - float2(1.0);
    float _230 = sqrt(fast::clamp(1.0 - dot(_226, _226), 0.0, 1.0));
    float3 _238 = float3(float4(_226, _230, 1.0).xy * (-1.0), _230);
    float3 _242 = (float3(0.0, 0.0, 2.0) * dot(float3(0.0, 0.0, 2.0), _238)) - (_238 * 2.0);
    float3 _254 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize(((_242 / float3(sqrt(dot(_242, _242)))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _258 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _276 = Material_Texture2D_2.sample(View_MaterialTextureBilinearWrapedSampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 50.0));
    float3 _280 = float3(_258.x);
    float4 _285 = Material_Texture2D_3.sample(View_MaterialTextureBilinearWrapedSampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 8.0));
    float3 _289 = float3(_258.z);
    float3 _292 = float3(_258.w);
    float3 _307 = fast::clamp(mix(mix(mix(mix(Material.Material_VectorExpressions[3].xyz, Material.Material_VectorExpressions[3].xyz, float3(_258.y)), _276.xyz * float3(0.2249999940395355224609375), _280), _285.xyz * float3(0.25), _289), float3(0.0), _292), float3(0.0), float3(1.0));
    float _308 = fast::clamp(mix(mix(float3(0.0), float3(1.0), _289), float3(0.0), _292).x, 0.0, 1.0);
    float3 _323 = fast::clamp((_217 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _334 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_323.x), int(_323.y), int(_323.z), 0).xyz), 0));
    float3 _349 = (((_334.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_323 / float3(_334.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    uint _350 = in.in_var_PRIMITIVE_ID * 36u;
    uint _351 = _350 + 20u;
    float _365;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _351)].z > 0.0)
    {
        _365 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _349, level(0.0)).x;
    }
    else
    {
        _365 = 1.0;
    }
    float3 _377 = ((_307 - (_307 * _308)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _384 = (mix(float3(0.039999999105930328369140625), _307, float3(_308)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _387 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _392;
    if (_387)
    {
        _392 = _377 + (_384 * 0.449999988079071044921875);
    }
    else
    {
        _392 = _377;
    }
    float3 _394 = select(_384, float3(0.0), bool3(_387));
    float3 _396 = float3(dot(_394, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _413 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _349, level(0.0));
    float _429 = _413.x;
    float4 _431 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _349, level(0.0)) * 2.0) - float4(1.0)) * _429) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _432 = _413.y;
    float4 _434 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _349, level(0.0)) * 2.0) - float4(1.0)) * _432) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _435 = _413.z;
    float4 _437 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _349, level(0.0)) * 2.0) - float4(1.0)) * _435) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _454 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _349, level(0.0)) * 2.0) - float4(1.0)) * _429) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _456 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _349, level(0.0)) * 2.0) - float4(1.0)) * _432) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _458 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _349, level(0.0)) * 2.0) - float4(1.0)) * _435) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float _489 = _254.y;
    float4 _491 = _172;
    _491.y = (-0.48860299587249755859375) * _489;
    float _492 = _254.z;
    float4 _494 = _491;
    _494.z = 0.48860299587249755859375 * _492;
    float _495 = _254.x;
    float4 _497 = _494;
    _497.w = (-0.48860299587249755859375) * _495;
    float3 _498 = _254 * _254;
    float4 _501 = _170;
    _501.x = (1.09254801273345947265625 * _495) * _489;
    float4 _504 = _501;
    _504.y = ((-1.09254801273345947265625) * _489) * _492;
    float4 _509 = _504;
    _509.z = 0.3153919875621795654296875 * ((3.0 * _498.z) - 1.0);
    float4 _512 = _509;
    _512.w = ((-1.09254801273345947265625) * _495) * _492;
    float4 _516 = _497;
    _516.x = 0.886227548122406005859375;
    float3 _518 = _516.yzw * 2.094395160675048828125;
    float4 _519 = float4(_516.x, _518.x, _518.y, _518.z);
    float4 _520 = _512 * 0.785398185253143310546875;
    float _521 = (_498.x - _498.y) * 0.4290426075458526611328125;
    float3 _527 = float3(0.0);
    _527.x = (dot(float4(_429, _431.xyz), _519) + dot(float4(_431.w, _454.xyz), _520)) + (_454.w * _521);
    float3 _533 = _527;
    _533.y = (dot(float4(_432, _434.xyz), _519) + dot(float4(_434.w, _456.xyz), _520)) + (_456.w * _521);
    float3 _539 = _533;
    _539.z = (dot(float4(_435, _437.xyz), _519) + dot(float4(_437.w, _458.xyz), _520)) + (_458.w * _521);
    float3 _544 = (fast::max(float3(0.0), _539) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    float3 _566 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _595;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _594;
        if (any(abs(_217 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _350 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _350 + 19u)].xyz + float3(1.0))))
        {
            _594 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_217, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _594 = _566;
        }
        _595 = _594;
    }
    else
    {
        _595 = _566;
    }
    float4 _602 = float4(((mix(float3(0.0), _392 + (_394 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_544 * _392) * fast::max(float3(1.0), ((((((_307 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_307 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_307 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _595) * 1.0, 0.0);
    float4 _609;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _608 = _602;
        _608.w = 0.0;
        _609 = _608;
    }
    else
    {
        _609 = _602;
    }
    float2 _614 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _622 = (_254 * 0.5) + float3(0.5);
    float4 _624 = float4(_622.x, _622.y, _622.z, float4(0.0).w);
    _624.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _351)].y;
    float4 _625 = float4(0.0);
    _625.x = _308;
    float4 _626 = _625;
    _626.y = 0.5;
    float4 _627 = _626;
    _627.z = (fast::clamp(mix(mix(mix(float3(0.100000001490116119384765625), float3(mix(0.550000011920928955078125, 0.75, _276.x)), _280), float3(mix(0.37999999523162841796875, 0.550000011920928955078125, _285.x)), _289), float3(0.100000001490116119384765625), _292).x, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float4 _628 = _627;
    _628.w = 0.50588238239288330078125;
    float4 _640 = float4(_307.x, _307.y, _307.z, float4(0.0).w);
    _640.w = ((log2(((dot(_544, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_396 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_396 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_396 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_614.xyx * _614.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _609 * View.View_PreExposure;
    out.out_var_SV_Target1 = _624;
    out.out_var_SV_Target2 = _628;
    out.out_var_SV_Target3 = _640;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_365, 1.0, 1.0, 1.0);
    return out;
}

