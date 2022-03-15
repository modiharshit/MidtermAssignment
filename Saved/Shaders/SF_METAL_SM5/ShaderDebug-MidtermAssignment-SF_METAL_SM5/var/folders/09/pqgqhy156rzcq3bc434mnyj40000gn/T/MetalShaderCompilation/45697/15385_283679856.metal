

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
    char _m14_pad[188];
    float View_ShowDecalsMask;
    char _m15_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m16_pad[48];
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

constant float4 _154 = {};
constant float _156 = {};
constant float4 _157 = {};

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

fragment MainPS_out Main_00003c19_10e89c70(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(11)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _209 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _156, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _214 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _219 = (_214.xyz / float3(_214.w)) - View.View_PreViewTranslation;
    float3 _227 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float _238 = (0.100000001490116119384765625 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _239 = in.in_var_PRIMITIVE_ID * 36u;
    uint _240 = _239 + 20u;
    float _289;
    float _290;
    float _291;
    float3 _292;
    float3 _293;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _240)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _258 = ((_209.xy / float2(_209.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _262 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _258, level(0.0));
        float4 _265 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _258, level(0.0));
        float4 _268 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _258, level(0.0));
        float _278 = _268.w;
        _289 = (_238 * _278) + _268.z;
        _290 = (0.5 * _278) + _268.y;
        _291 = _278 + _268.x;
        _292 = (float3(1.0) * _262.w) + _262.xyz;
        _293 = normalize((_227 * _265.w) + ((_265.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _289 = _238;
        _290 = 0.5;
        _291 = 1.0;
        _292 = float3(1.0);
        _293 = _227;
    }
    float3 _303 = fast::clamp((_219 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _314 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_303.x), int(_303.y), int(_303.z), 0).xyz), 0));
    float3 _329 = (((_314.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_303 / float3(_314.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _342;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _240)].z > 0.0)
    {
        _342 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _329, level(0.0)).x;
    }
    else
    {
        _342 = 1.0;
    }
    float3 _356 = ((_292 - (_292 * _291)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _363 = (mix(float3(0.07999999821186065673828125 * _290), _292, float3(_291)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _366 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _371;
    if (_366)
    {
        _371 = _356 + (_363 * 0.449999988079071044921875);
    }
    else
    {
        _371 = _356;
    }
    float3 _373 = select(_363, float3(0.0), bool3(_366));
    float3 _375 = float3(dot(_373, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _392 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _329, level(0.0));
    float _408 = _392.x;
    float4 _410 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _329, level(0.0)) * 2.0) - float4(1.0)) * _408) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _411 = _392.y;
    float4 _413 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _329, level(0.0)) * 2.0) - float4(1.0)) * _411) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _414 = _392.z;
    float4 _416 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _329, level(0.0)) * 2.0) - float4(1.0)) * _414) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _433 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _329, level(0.0)) * 2.0) - float4(1.0)) * _408) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _435 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _329, level(0.0)) * 2.0) - float4(1.0)) * _411) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _437 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _329, level(0.0)) * 2.0) - float4(1.0)) * _414) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _470 = _157;
    _470.y = (-0.48860299587249755859375) * _293.y;
    float4 _473 = _470;
    _473.z = 0.48860299587249755859375 * _293.z;
    float4 _476 = _473;
    _476.w = (-0.48860299587249755859375) * _293.x;
    float3 _477 = _293 * _293;
    float4 _480 = _154;
    _480.x = (1.09254801273345947265625 * _293.x) * _293.y;
    float4 _483 = _480;
    _483.y = ((-1.09254801273345947265625) * _293.y) * _293.z;
    float4 _488 = _483;
    _488.z = 0.3153919875621795654296875 * ((3.0 * _477.z) - 1.0);
    float4 _491 = _488;
    _491.w = ((-1.09254801273345947265625) * _293.x) * _293.z;
    float4 _495 = _476;
    _495.x = 0.886227548122406005859375;
    float3 _497 = _495.yzw * 2.094395160675048828125;
    float4 _498 = float4(_495.x, _497.x, _497.y, _497.z);
    float4 _499 = _491 * 0.785398185253143310546875;
    float _500 = (_477.x - _477.y) * 0.4290426075458526611328125;
    float3 _506 = float3(0.0);
    _506.x = (dot(float4(_408, _410.xyz), _498) + dot(float4(_410.w, _433.xyz), _499)) + (_433.w * _500);
    float3 _512 = _506;
    _512.y = (dot(float4(_411, _413.xyz), _498) + dot(float4(_413.w, _435.xyz), _499)) + (_435.w * _500);
    float3 _518 = _512;
    _518.z = (dot(float4(_414, _416.xyz), _498) + dot(float4(_416.w, _437.xyz), _499)) + (_437.w * _500);
    float3 _523 = (fast::max(float3(0.0), _518) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    float3 _545 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _574;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _573;
        if (any(abs(_219 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _239 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _239 + 19u)].xyz + float3(1.0))))
        {
            _573 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_219, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _573 = _545;
        }
        _574 = _573;
    }
    else
    {
        _574 = _545;
    }
    float4 _581 = float4(((mix(float3(0.0), _371 + (_373 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_523 * _371) * fast::max(float3(1.0), ((((((_292 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_292 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_292 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _574) * 1.0, 0.0);
    float4 _588;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _587 = _581;
        _587.w = 0.0;
        _588 = _587;
    }
    else
    {
        _588 = _581;
    }
    float2 _592 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _600 = (_293 * 0.5) + float3(0.5);
    float4 _602 = float4(_600.x, _600.y, _600.z, float4(0.0).w);
    _602.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _240)].y;
    float4 _603 = float4(0.0);
    _603.x = _291;
    float4 _604 = _603;
    _604.y = _290;
    float4 _605 = _604;
    _605.z = _289;
    float4 _606 = _605;
    _606.w = 0.50588238239288330078125;
    float4 _618 = float4(_292.x, _292.y, _292.z, float4(0.0).w);
    _618.w = ((log2(((dot(_523, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_375 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_375 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_375 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_592.xyx * _592.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _588 * View.View_PreExposure;
    out.out_var_SV_Target1 = _602;
    out.out_var_SV_Target2 = _606;
    out.out_var_SV_Target3 = _618;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_342, 1.0, 1.0, 1.0);
    return out;
}

