

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

constant float4 _163 = {};
constant float3 _164 = {};
constant float _166 = {};
constant float4 _167 = {};

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

fragment MainPS_out Main_00004619_67aef5d3(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(11)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(12)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _220 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _166, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _225 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _230 = (_225.xyz / float3(_225.w)) - View.View_PreViewTranslation;
    float3 _238 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float _249 = (0.64999997615814208984375 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _250 = in.in_var_PRIMITIVE_ID * 36u;
    uint _251 = _250 + 20u;
    float _300;
    float _301;
    float _302;
    float3 _303;
    float3 _304;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _251)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _269 = ((_220.xy / float2(_220.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _273 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _269, level(0.0));
        float4 _276 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _269, level(0.0));
        float4 _279 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _269, level(0.0));
        float _289 = _279.w;
        _300 = (_249 * _289) + _279.z;
        _301 = (0.5 * _289) + _279.y;
        _302 = _289 + _279.x;
        _303 = (float3(0.180000007152557373046875) * _273.w) + _273.xyz;
        _304 = normalize((_238 * _276.w) + ((_276.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _300 = _249;
        _301 = 0.5;
        _302 = 1.0;
        _303 = float3(0.180000007152557373046875);
        _304 = _238;
    }
    float3 _314 = fast::clamp((_230 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _325 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_314.x), int(_314.y), int(_314.z), 0).xyz), 0));
    float3 _340 = (((_325.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_314 / float3(_325.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _353;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _251)].z > 0.0)
    {
        _353 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _340, level(0.0)).x;
    }
    else
    {
        _353 = 1.0;
    }
    float4 _355 = float4(0.0);
    _355.x = 1.0;
    float4 _356 = _355;
    _356.y = 0.0;
    float3 _370 = ((_303 - (_303 * _302)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _377 = (mix(float3(0.07999999821186065673828125 * _301), _303, float3(_302)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _380 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _385;
    if (_380)
    {
        _385 = _370 + (_377 * 0.449999988079071044921875);
    }
    else
    {
        _385 = _370;
    }
    float3 _387 = select(_377, float3(0.0), bool3(_380));
    float3 _389 = float3(dot(_387, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _406 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _340, level(0.0));
    float _422 = _406.x;
    float4 _424 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _340, level(0.0)) * 2.0) - float4(1.0)) * _422) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _425 = _406.y;
    float4 _427 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _340, level(0.0)) * 2.0) - float4(1.0)) * _425) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _428 = _406.z;
    float4 _430 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _340, level(0.0)) * 2.0) - float4(1.0)) * _428) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _447 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _340, level(0.0)) * 2.0) - float4(1.0)) * _422) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _449 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _340, level(0.0)) * 2.0) - float4(1.0)) * _425) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _451 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _340, level(0.0)) * 2.0) - float4(1.0)) * _428) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _484 = _167;
    _484.y = (-0.48860299587249755859375) * _304.y;
    float4 _487 = _484;
    _487.z = 0.48860299587249755859375 * _304.z;
    float4 _490 = _487;
    _490.w = (-0.48860299587249755859375) * _304.x;
    float3 _491 = _304 * _304;
    float4 _494 = _163;
    _494.x = (1.09254801273345947265625 * _304.x) * _304.y;
    float4 _497 = _494;
    _497.y = ((-1.09254801273345947265625) * _304.y) * _304.z;
    float4 _502 = _497;
    _502.z = 0.3153919875621795654296875 * ((3.0 * _491.z) - 1.0);
    float4 _505 = _502;
    _505.w = ((-1.09254801273345947265625) * _304.x) * _304.z;
    float4 _509 = _490;
    _509.x = 0.886227548122406005859375;
    float3 _511 = _509.yzw * 2.094395160675048828125;
    float4 _512 = float4(_509.x, _511.x, _511.y, _511.z);
    float4 _513 = _505 * 0.785398185253143310546875;
    float _514 = (_491.x - _491.y) * 0.4290426075458526611328125;
    float3 _520 = float3(0.0);
    _520.x = (dot(float4(_422, _424.xyz), _512) + dot(float4(_424.w, _447.xyz), _513)) + (_447.w * _514);
    float3 _526 = _520;
    _526.y = (dot(float4(_425, _427.xyz), _512) + dot(float4(_427.w, _449.xyz), _513)) + (_449.w * _514);
    float3 _532 = _526;
    _532.z = (dot(float4(_428, _430.xyz), _512) + dot(float4(_430.w, _451.xyz), _513)) + (_451.w * _514);
    float _561;
    float _562;
    float3 _563;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _548 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _340, level(0.0)).xyz * 2.0) - float3(1.0);
        float _549 = length(_548);
        float3 _552 = _548 / float3(fast::max(_549, 9.9999997473787516355514526367188e-05));
        float _553 = 1.0 - _549;
        float _555 = 1.0 - (_553 * _553);
        _561 = mix(fast::clamp(dot(_552, _304), 0.0, 1.0), 1.0, _555);
        _562 = _549;
        _563 = mix(_552, _304, float3(_555));
    }
    else
    {
        _561 = 1.0;
        _562 = 1.0;
        _563 = _304;
    }
    float4 _567 = float4(_563, 1.0);
    float3 _571 = _164;
    _571.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _567);
    float3 _575 = _571;
    _575.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _567);
    float3 _579 = _575;
    _579.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _567);
    float4 _582 = _567.xyzz * _567.yzzx;
    float3 _586 = _164;
    _586.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _582);
    float3 _590 = _586;
    _590.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _582);
    float3 _594 = _590;
    _594.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _582);
    float3 _609 = ((fast::max(float3(0.0), _532) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_579 + _594) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_563.x * _563.x) - (_563.y * _563.y)))) * View.View_SkyLightColor.xyz) * (_562 * _561));
    float3 _631 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _660;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _659;
        if (any(abs(_230 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _250 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _250 + 19u)].xyz + float3(1.0))))
        {
            _659 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_230, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _659 = _631;
        }
        _660 = _659;
    }
    else
    {
        _660 = _631;
    }
    float4 _667 = float4(((mix(float3(0.0), _385 + (_387 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_609 * _385) * fast::max(float3(1.0), ((((((_303 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_303 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_303 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _660) * 1.0, 0.0);
    float4 _674;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _673 = _667;
        _673.w = 0.0;
        _674 = _673;
    }
    else
    {
        _674 = _667;
    }
    float2 _678 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _686 = (_304 * 0.5) + float3(0.5);
    float4 _688 = float4(_686.x, _686.y, _686.z, float4(0.0).w);
    _688.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _251)].y;
    float4 _689 = float4(0.0);
    _689.x = _302;
    float4 _690 = _689;
    _690.y = _301;
    float4 _691 = _690;
    _691.z = fast::clamp(_300, 0.0, 0.996078431606292724609375);
    float4 _692 = _691;
    _692.w = 0.517647087574005126953125;
    float4 _704 = float4(_303.x, _303.y, _303.z, float4(0.0).w);
    _704.w = ((log2(((dot(_609, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_389 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_389 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_389 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_678.xyx * _678.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _674 * View.View_PreExposure;
    out.out_var_SV_Target1 = _688;
    out.out_var_SV_Target2 = _692;
    out.out_var_SV_Target3 = _704;
    out.out_var_SV_Target4 = _356;
    out.out_var_SV_Target5 = float4(_353, 1.0, 1.0, 1.0);
    return out;
}

