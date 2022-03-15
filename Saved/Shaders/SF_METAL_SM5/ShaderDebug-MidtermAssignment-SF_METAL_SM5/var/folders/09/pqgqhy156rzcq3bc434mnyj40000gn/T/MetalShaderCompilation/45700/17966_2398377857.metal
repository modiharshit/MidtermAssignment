

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
    spvUnsafeArray<float4, 4> Material_VectorExpressions;
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

fragment MainPS_out Main_0000462e_8ef45781(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(11)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(12)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _217 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _163, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _222 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _227 = (_222.xyz / float3(_222.w)) - View.View_PreViewTranslation;
    float3 _235 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _250 = fast::clamp(Material.Material_VectorExpressions[3].xyz, float3(0.0), float3(1.0));
    float _251 = fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0);
    float _256 = (fast::clamp(Material.Material_ScalarExpressions[0].z, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _257 = in.in_var_PRIMITIVE_ID * 36u;
    uint _258 = _257 + 20u;
    float _306;
    float _307;
    float _308;
    float3 _309;
    float3 _310;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _258)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _276 = ((_217.xy / float2(_217.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _280 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _276, level(0.0));
        float4 _283 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _276, level(0.0));
        float4 _286 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _276, level(0.0));
        float _296 = _286.w;
        _306 = (_256 * _296) + _286.z;
        _307 = (_251 * _296) + _286.y;
        _308 = _286.x;
        _309 = (_250 * _280.w) + _280.xyz;
        _310 = normalize((_235 * _283.w) + ((_283.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _306 = _256;
        _307 = _251;
        _308 = 0.0;
        _309 = _250;
        _310 = _235;
    }
    float3 _320 = fast::clamp((_227 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _331 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_320.x), int(_320.y), int(_320.z), 0).xyz), 0));
    float3 _346 = (((_331.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_320 / float3(_331.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _359;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _258)].z > 0.0)
    {
        _359 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _346, level(0.0)).x;
    }
    else
    {
        _359 = 1.0;
    }
    float3 _373 = ((_309 - (_309 * _308)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _380 = (mix(float3(0.07999999821186065673828125 * _307), _309, float3(_308)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _383 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _388;
    if (_383)
    {
        _388 = _373 + (_380 * 0.449999988079071044921875);
    }
    else
    {
        _388 = _373;
    }
    float3 _390 = select(_380, float3(0.0), bool3(_383));
    float3 _392 = float3(dot(_390, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _409 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _346, level(0.0));
    float _425 = _409.x;
    float4 _427 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _346, level(0.0)) * 2.0) - float4(1.0)) * _425) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _428 = _409.y;
    float4 _430 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _346, level(0.0)) * 2.0) - float4(1.0)) * _428) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _431 = _409.z;
    float4 _433 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _346, level(0.0)) * 2.0) - float4(1.0)) * _431) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _450 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _346, level(0.0)) * 2.0) - float4(1.0)) * _425) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _452 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _346, level(0.0)) * 2.0) - float4(1.0)) * _428) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _454 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _346, level(0.0)) * 2.0) - float4(1.0)) * _431) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _487 = _164;
    _487.y = (-0.48860299587249755859375) * _310.y;
    float4 _490 = _487;
    _490.z = 0.48860299587249755859375 * _310.z;
    float4 _493 = _490;
    _493.w = (-0.48860299587249755859375) * _310.x;
    float3 _494 = _310 * _310;
    float4 _497 = _160;
    _497.x = (1.09254801273345947265625 * _310.x) * _310.y;
    float4 _500 = _497;
    _500.y = ((-1.09254801273345947265625) * _310.y) * _310.z;
    float4 _505 = _500;
    _505.z = 0.3153919875621795654296875 * ((3.0 * _494.z) - 1.0);
    float4 _508 = _505;
    _508.w = ((-1.09254801273345947265625) * _310.x) * _310.z;
    float4 _512 = _493;
    _512.x = 0.886227548122406005859375;
    float3 _514 = _512.yzw * 2.094395160675048828125;
    float4 _515 = float4(_512.x, _514.x, _514.y, _514.z);
    float4 _516 = _508 * 0.785398185253143310546875;
    float _517 = (_494.x - _494.y) * 0.4290426075458526611328125;
    float3 _523 = float3(0.0);
    _523.x = (dot(float4(_425, _427.xyz), _515) + dot(float4(_427.w, _450.xyz), _516)) + (_450.w * _517);
    float3 _529 = _523;
    _529.y = (dot(float4(_428, _430.xyz), _515) + dot(float4(_430.w, _452.xyz), _516)) + (_452.w * _517);
    float3 _535 = _529;
    _535.z = (dot(float4(_431, _433.xyz), _515) + dot(float4(_433.w, _454.xyz), _516)) + (_454.w * _517);
    float _564;
    float _565;
    float3 _566;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _551 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _346, level(0.0)).xyz * 2.0) - float3(1.0);
        float _552 = length(_551);
        float3 _555 = _551 / float3(fast::max(_552, 9.9999997473787516355514526367188e-05));
        float _556 = 1.0 - _552;
        float _558 = 1.0 - (_556 * _556);
        _564 = mix(fast::clamp(dot(_555, _310), 0.0, 1.0), 1.0, _558);
        _565 = _552;
        _566 = mix(_555, _310, float3(_558));
    }
    else
    {
        _564 = 1.0;
        _565 = 1.0;
        _566 = _310;
    }
    float4 _570 = float4(_566, 1.0);
    float3 _574 = _161;
    _574.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _570);
    float3 _578 = _574;
    _578.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _570);
    float3 _582 = _578;
    _582.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _570);
    float4 _585 = _570.xyzz * _570.yzzx;
    float3 _589 = _161;
    _589.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _585);
    float3 _593 = _589;
    _593.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _585);
    float3 _597 = _593;
    _597.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _585);
    float3 _612 = ((fast::max(float3(0.0), _535) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_582 + _597) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_566.x * _566.x) - (_566.y * _566.y)))) * View.View_SkyLightColor.xyz) * (_565 * _564));
    float3 _634 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _663;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _662;
        if (any(abs(_227 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _257 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _257 + 19u)].xyz + float3(1.0))))
        {
            _662 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_227, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _662 = _634;
        }
        _663 = _662;
    }
    else
    {
        _663 = _634;
    }
    float4 _670 = float4(((mix(float3(0.0), _388 + (_390 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_612 * _388) * fast::max(float3(1.0), ((((((_309 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_309 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_309 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _663) * 1.0, 0.0);
    float4 _677;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _676 = _670;
        _676.w = 0.0;
        _677 = _676;
    }
    else
    {
        _677 = _670;
    }
    float2 _681 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _689 = (_310 * 0.5) + float3(0.5);
    float4 _691 = float4(_689.x, _689.y, _689.z, float4(0.0).w);
    _691.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _258)].y;
    float4 _692 = float4(0.0);
    _692.x = _308;
    float4 _693 = _692;
    _693.y = _307;
    float4 _694 = _693;
    _694.z = _306;
    float4 _695 = _694;
    _695.w = 0.50588238239288330078125;
    float4 _707 = float4(_309.x, _309.y, _309.z, float4(0.0).w);
    _707.w = ((log2(((dot(_612, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_392 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_392 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_392 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_681.xyx * _681.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _677 * View.View_PreExposure;
    out.out_var_SV_Target1 = _691;
    out.out_var_SV_Target2 = _695;
    out.out_var_SV_Target3 = _707;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_359, 1.0, 1.0, 1.0);
    return out;
}

