

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

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _160 = {};
constant float3 _161 = {};
constant float _163 = {};
constant float4 _164 = {};

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
    uint in_var_PRIMITIVE_ID [[user(locn2)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_0000456d_1e08bc5c(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(11)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(12)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _217 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _163, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _222 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _227 = (_222.xyz / float3(_222.w)) - View.View_PreViewTranslation;
    float3 _235 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float _246 = (0.100000001490116119384765625 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _247 = in.in_var_PRIMITIVE_ID * 36u;
    uint _248 = _247 + 20u;
    float _297;
    float _298;
    float _299;
    float3 _300;
    float3 _301;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _248)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _266 = ((_217.xy / float2(_217.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _270 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _266, level(0.0));
        float4 _273 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _266, level(0.0));
        float4 _276 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _266, level(0.0));
        float _286 = _276.w;
        _297 = (_246 * _286) + _276.z;
        _298 = (0.5 * _286) + _276.y;
        _299 = _286 + _276.x;
        _300 = (float3(1.0) * _270.w) + _270.xyz;
        _301 = normalize((_235 * _273.w) + ((_273.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _297 = _246;
        _298 = 0.5;
        _299 = 1.0;
        _300 = float3(1.0);
        _301 = _235;
    }
    float3 _311 = fast::clamp((_227 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _322 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_311.x), int(_311.y), int(_311.z), 0).xyz), 0));
    float3 _337 = (((_322.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_311 / float3(_322.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _350;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _248)].z > 0.0)
    {
        _350 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _337, level(0.0)).x;
    }
    else
    {
        _350 = 1.0;
    }
    float3 _364 = ((_300 - (_300 * _299)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _371 = (mix(float3(0.07999999821186065673828125 * _298), _300, float3(_299)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _374 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _379;
    if (_374)
    {
        _379 = _364 + (_371 * 0.449999988079071044921875);
    }
    else
    {
        _379 = _364;
    }
    float3 _381 = select(_371, float3(0.0), bool3(_374));
    float3 _383 = float3(dot(_381, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _400 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _337, level(0.0));
    float _416 = _400.x;
    float4 _418 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _337, level(0.0)) * 2.0) - float4(1.0)) * _416) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _419 = _400.y;
    float4 _421 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _337, level(0.0)) * 2.0) - float4(1.0)) * _419) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _422 = _400.z;
    float4 _424 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _337, level(0.0)) * 2.0) - float4(1.0)) * _422) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _441 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _337, level(0.0)) * 2.0) - float4(1.0)) * _416) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _443 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _337, level(0.0)) * 2.0) - float4(1.0)) * _419) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _445 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _337, level(0.0)) * 2.0) - float4(1.0)) * _422) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _478 = _164;
    _478.y = (-0.48860299587249755859375) * _301.y;
    float4 _481 = _478;
    _481.z = 0.48860299587249755859375 * _301.z;
    float4 _484 = _481;
    _484.w = (-0.48860299587249755859375) * _301.x;
    float3 _485 = _301 * _301;
    float4 _488 = _160;
    _488.x = (1.09254801273345947265625 * _301.x) * _301.y;
    float4 _491 = _488;
    _491.y = ((-1.09254801273345947265625) * _301.y) * _301.z;
    float4 _496 = _491;
    _496.z = 0.3153919875621795654296875 * ((3.0 * _485.z) - 1.0);
    float4 _499 = _496;
    _499.w = ((-1.09254801273345947265625) * _301.x) * _301.z;
    float4 _503 = _484;
    _503.x = 0.886227548122406005859375;
    float3 _505 = _503.yzw * 2.094395160675048828125;
    float4 _506 = float4(_503.x, _505.x, _505.y, _505.z);
    float4 _507 = _499 * 0.785398185253143310546875;
    float _508 = (_485.x - _485.y) * 0.4290426075458526611328125;
    float3 _514 = float3(0.0);
    _514.x = (dot(float4(_416, _418.xyz), _506) + dot(float4(_418.w, _441.xyz), _507)) + (_441.w * _508);
    float3 _520 = _514;
    _520.y = (dot(float4(_419, _421.xyz), _506) + dot(float4(_421.w, _443.xyz), _507)) + (_443.w * _508);
    float3 _526 = _520;
    _526.z = (dot(float4(_422, _424.xyz), _506) + dot(float4(_424.w, _445.xyz), _507)) + (_445.w * _508);
    float _555;
    float _556;
    float3 _557;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _542 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _337, level(0.0)).xyz * 2.0) - float3(1.0);
        float _543 = length(_542);
        float3 _546 = _542 / float3(fast::max(_543, 9.9999997473787516355514526367188e-05));
        float _547 = 1.0 - _543;
        float _549 = 1.0 - (_547 * _547);
        _555 = mix(fast::clamp(dot(_546, _301), 0.0, 1.0), 1.0, _549);
        _556 = _543;
        _557 = mix(_546, _301, float3(_549));
    }
    else
    {
        _555 = 1.0;
        _556 = 1.0;
        _557 = _301;
    }
    float4 _561 = float4(_557, 1.0);
    float3 _565 = _161;
    _565.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _561);
    float3 _569 = _565;
    _569.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _561);
    float3 _573 = _569;
    _573.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _561);
    float4 _576 = _561.xyzz * _561.yzzx;
    float3 _580 = _161;
    _580.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _576);
    float3 _584 = _580;
    _584.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _576);
    float3 _588 = _584;
    _588.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _576);
    float3 _603 = ((fast::max(float3(0.0), _526) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_573 + _588) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_557.x * _557.x) - (_557.y * _557.y)))) * View.View_SkyLightColor.xyz) * (_556 * _555));
    float3 _625 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _654;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _653;
        if (any(abs(_227 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _247 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _247 + 19u)].xyz + float3(1.0))))
        {
            _653 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_227, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _653 = _625;
        }
        _654 = _653;
    }
    else
    {
        _654 = _625;
    }
    float4 _661 = float4(((mix(float3(0.0), _379 + (_381 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_603 * _379) * fast::max(float3(1.0), ((((((_300 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_300 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_300 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _654) * 1.0, 0.0);
    float4 _668;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _667 = _661;
        _667.w = 0.0;
        _668 = _667;
    }
    else
    {
        _668 = _661;
    }
    float2 _672 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _680 = (_301 * 0.5) + float3(0.5);
    float4 _682 = float4(_680.x, _680.y, _680.z, float4(0.0).w);
    _682.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _248)].y;
    float4 _683 = float4(0.0);
    _683.x = _299;
    float4 _684 = _683;
    _684.y = _298;
    float4 _685 = _684;
    _685.z = _297;
    float4 _686 = _685;
    _686.w = 0.50588238239288330078125;
    float4 _698 = float4(_300.x, _300.y, _300.z, float4(0.0).w);
    _698.w = ((log2(((dot(_603, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_383 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_383 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_383 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_672.xyx * _672.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _668 * View.View_PreExposure;
    out.out_var_SV_Target1 = _682;
    out.out_var_SV_Target2 = _686;
    out.out_var_SV_Target3 = _698;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_350, 1.0, 1.0, 1.0);
    return out;
}

