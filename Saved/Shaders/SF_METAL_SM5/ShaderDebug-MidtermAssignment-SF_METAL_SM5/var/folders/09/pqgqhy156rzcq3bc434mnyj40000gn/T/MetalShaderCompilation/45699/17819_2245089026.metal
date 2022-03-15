

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

constant float4 _159 = {};
constant float3 _160 = {};
constant float _162 = {};
constant float4 _163 = {};

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

fragment MainPS_out Main_0000459b_85d15702(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(11)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(12)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _216 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _162, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _221 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _226 = (_221.xyz / float3(_221.w)) - View.View_PreViewTranslation;
    float3 _234 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _245 = fast::clamp(Material.Material_VectorExpressions[3].xyz, float3(0.0), float3(1.0));
    float _249 = (0.5 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _250 = in.in_var_PRIMITIVE_ID * 36u;
    uint _251 = _250 + 20u;
    float _299;
    float _300;
    float _301;
    float3 _302;
    float3 _303;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _251)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _269 = ((_216.xy / float2(_216.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _273 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _269, level(0.0));
        float4 _276 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _269, level(0.0));
        float4 _279 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _269, level(0.0));
        float _289 = _279.w;
        _299 = (_249 * _289) + _279.z;
        _300 = (0.5 * _289) + _279.y;
        _301 = _279.x;
        _302 = (_245 * _273.w) + _273.xyz;
        _303 = normalize((_234 * _276.w) + ((_276.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _299 = _249;
        _300 = 0.5;
        _301 = 0.0;
        _302 = _245;
        _303 = _234;
    }
    float3 _313 = fast::clamp((_226 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _324 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_313.x), int(_313.y), int(_313.z), 0).xyz), 0));
    float3 _339 = (((_324.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_313 / float3(_324.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _352;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _251)].z > 0.0)
    {
        _352 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _339, level(0.0)).x;
    }
    else
    {
        _352 = 1.0;
    }
    float3 _366 = ((_302 - (_302 * _301)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _373 = (mix(float3(0.07999999821186065673828125 * _300), _302, float3(_301)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _376 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _381;
    if (_376)
    {
        _381 = _366 + (_373 * 0.449999988079071044921875);
    }
    else
    {
        _381 = _366;
    }
    float3 _383 = select(_373, float3(0.0), bool3(_376));
    float3 _385 = float3(dot(_383, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _402 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _339, level(0.0));
    float _418 = _402.x;
    float4 _420 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _339, level(0.0)) * 2.0) - float4(1.0)) * _418) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _421 = _402.y;
    float4 _423 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _339, level(0.0)) * 2.0) - float4(1.0)) * _421) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _424 = _402.z;
    float4 _426 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _339, level(0.0)) * 2.0) - float4(1.0)) * _424) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _443 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _339, level(0.0)) * 2.0) - float4(1.0)) * _418) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _445 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _339, level(0.0)) * 2.0) - float4(1.0)) * _421) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _447 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _339, level(0.0)) * 2.0) - float4(1.0)) * _424) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _480 = _163;
    _480.y = (-0.48860299587249755859375) * _303.y;
    float4 _483 = _480;
    _483.z = 0.48860299587249755859375 * _303.z;
    float4 _486 = _483;
    _486.w = (-0.48860299587249755859375) * _303.x;
    float3 _487 = _303 * _303;
    float4 _490 = _159;
    _490.x = (1.09254801273345947265625 * _303.x) * _303.y;
    float4 _493 = _490;
    _493.y = ((-1.09254801273345947265625) * _303.y) * _303.z;
    float4 _498 = _493;
    _498.z = 0.3153919875621795654296875 * ((3.0 * _487.z) - 1.0);
    float4 _501 = _498;
    _501.w = ((-1.09254801273345947265625) * _303.x) * _303.z;
    float4 _505 = _486;
    _505.x = 0.886227548122406005859375;
    float3 _507 = _505.yzw * 2.094395160675048828125;
    float4 _508 = float4(_505.x, _507.x, _507.y, _507.z);
    float4 _509 = _501 * 0.785398185253143310546875;
    float _510 = (_487.x - _487.y) * 0.4290426075458526611328125;
    float3 _516 = float3(0.0);
    _516.x = (dot(float4(_418, _420.xyz), _508) + dot(float4(_420.w, _443.xyz), _509)) + (_443.w * _510);
    float3 _522 = _516;
    _522.y = (dot(float4(_421, _423.xyz), _508) + dot(float4(_423.w, _445.xyz), _509)) + (_445.w * _510);
    float3 _528 = _522;
    _528.z = (dot(float4(_424, _426.xyz), _508) + dot(float4(_426.w, _447.xyz), _509)) + (_447.w * _510);
    float _557;
    float _558;
    float3 _559;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _544 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _339, level(0.0)).xyz * 2.0) - float3(1.0);
        float _545 = length(_544);
        float3 _548 = _544 / float3(fast::max(_545, 9.9999997473787516355514526367188e-05));
        float _549 = 1.0 - _545;
        float _551 = 1.0 - (_549 * _549);
        _557 = mix(fast::clamp(dot(_548, _303), 0.0, 1.0), 1.0, _551);
        _558 = _545;
        _559 = mix(_548, _303, float3(_551));
    }
    else
    {
        _557 = 1.0;
        _558 = 1.0;
        _559 = _303;
    }
    float4 _563 = float4(_559, 1.0);
    float3 _567 = _160;
    _567.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _563);
    float3 _571 = _567;
    _571.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _563);
    float3 _575 = _571;
    _575.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _563);
    float4 _578 = _563.xyzz * _563.yzzx;
    float3 _582 = _160;
    _582.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _578);
    float3 _586 = _582;
    _586.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _578);
    float3 _590 = _586;
    _590.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _578);
    float3 _605 = ((fast::max(float3(0.0), _528) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_575 + _590) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_559.x * _559.x) - (_559.y * _559.y)))) * View.View_SkyLightColor.xyz) * (_558 * _557));
    float3 _627 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _656;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _655;
        if (any(abs(_226 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _250 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _250 + 19u)].xyz + float3(1.0))))
        {
            _655 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_226, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _655 = _627;
        }
        _656 = _655;
    }
    else
    {
        _656 = _627;
    }
    float4 _663 = float4(((mix(float3(0.0), _381 + (_383 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_605 * _381) * fast::max(float3(1.0), ((((((_302 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_302 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_302 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _656) * 1.0, 0.0);
    float4 _670;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _669 = _663;
        _669.w = 0.0;
        _670 = _669;
    }
    else
    {
        _670 = _663;
    }
    float2 _674 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _682 = (_303 * 0.5) + float3(0.5);
    float4 _684 = float4(_682.x, _682.y, _682.z, float4(0.0).w);
    _684.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _251)].y;
    float4 _685 = float4(0.0);
    _685.x = _301;
    float4 _686 = _685;
    _686.y = _300;
    float4 _687 = _686;
    _687.z = _299;
    float4 _688 = _687;
    _688.w = 0.50588238239288330078125;
    float4 _700 = float4(_302.x, _302.y, _302.z, float4(0.0).w);
    _700.w = ((log2(((dot(_605, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_385 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_385 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_385 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_674.xyx * _674.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _670 * View.View_PreExposure;
    out.out_var_SV_Target1 = _684;
    out.out_var_SV_Target2 = _688;
    out.out_var_SV_Target3 = _700;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_352, 1.0, 1.0, 1.0);
    return out;
}

