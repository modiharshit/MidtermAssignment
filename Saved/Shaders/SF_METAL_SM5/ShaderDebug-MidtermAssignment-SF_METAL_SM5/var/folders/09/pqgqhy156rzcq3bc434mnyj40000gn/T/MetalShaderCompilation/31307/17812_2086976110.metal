

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

fragment MainPS_out Main_00004594_7c64ba6e(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(11)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(12)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _217 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _163, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _222 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _227 = (_222.xyz / float3(_222.w)) - View.View_PreViewTranslation;
    float3 _235 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float _246 = (0.300000011920928955078125 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _247 = in.in_var_PRIMITIVE_ID * 36u;
    uint _248 = _247 + 20u;
    float _296;
    float _297;
    float _298;
    float3 _299;
    float3 _300;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _248)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _266 = ((_217.xy / float2(_217.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _270 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _266, level(0.0));
        float4 _273 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _266, level(0.0));
        float4 _276 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _266, level(0.0));
        float _286 = _276.w;
        _296 = (_246 * _286) + _276.z;
        _297 = (0.5 * _286) + _276.y;
        _298 = _276.x;
        _299 = (float3(0.300000011920928955078125) * _270.w) + _270.xyz;
        _300 = normalize((_235 * _273.w) + ((_273.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _296 = _246;
        _297 = 0.5;
        _298 = 0.0;
        _299 = float3(0.300000011920928955078125);
        _300 = _235;
    }
    float3 _310 = fast::clamp((_227 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _321 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_310.x), int(_310.y), int(_310.z), 0).xyz), 0));
    float3 _336 = (((_321.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_310 / float3(_321.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _349;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _248)].z > 0.0)
    {
        _349 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _336, level(0.0)).x;
    }
    else
    {
        _349 = 1.0;
    }
    float3 _363 = ((_299 - (_299 * _298)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _370 = (mix(float3(0.07999999821186065673828125 * _297), _299, float3(_298)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _373 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _378;
    if (_373)
    {
        _378 = _363 + (_370 * 0.449999988079071044921875);
    }
    else
    {
        _378 = _363;
    }
    float3 _380 = select(_370, float3(0.0), bool3(_373));
    float3 _382 = float3(dot(_380, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _399 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _336, level(0.0));
    float _415 = _399.x;
    float4 _417 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _336, level(0.0)) * 2.0) - float4(1.0)) * _415) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _418 = _399.y;
    float4 _420 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _336, level(0.0)) * 2.0) - float4(1.0)) * _418) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _421 = _399.z;
    float4 _423 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _336, level(0.0)) * 2.0) - float4(1.0)) * _421) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _440 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _336, level(0.0)) * 2.0) - float4(1.0)) * _415) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _442 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _336, level(0.0)) * 2.0) - float4(1.0)) * _418) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _444 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _336, level(0.0)) * 2.0) - float4(1.0)) * _421) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _477 = _164;
    _477.y = (-0.48860299587249755859375) * _300.y;
    float4 _480 = _477;
    _480.z = 0.48860299587249755859375 * _300.z;
    float4 _483 = _480;
    _483.w = (-0.48860299587249755859375) * _300.x;
    float3 _484 = _300 * _300;
    float4 _487 = _160;
    _487.x = (1.09254801273345947265625 * _300.x) * _300.y;
    float4 _490 = _487;
    _490.y = ((-1.09254801273345947265625) * _300.y) * _300.z;
    float4 _495 = _490;
    _495.z = 0.3153919875621795654296875 * ((3.0 * _484.z) - 1.0);
    float4 _498 = _495;
    _498.w = ((-1.09254801273345947265625) * _300.x) * _300.z;
    float4 _502 = _483;
    _502.x = 0.886227548122406005859375;
    float3 _504 = _502.yzw * 2.094395160675048828125;
    float4 _505 = float4(_502.x, _504.x, _504.y, _504.z);
    float4 _506 = _498 * 0.785398185253143310546875;
    float _507 = (_484.x - _484.y) * 0.4290426075458526611328125;
    float3 _513 = float3(0.0);
    _513.x = (dot(float4(_415, _417.xyz), _505) + dot(float4(_417.w, _440.xyz), _506)) + (_440.w * _507);
    float3 _519 = _513;
    _519.y = (dot(float4(_418, _420.xyz), _505) + dot(float4(_420.w, _442.xyz), _506)) + (_442.w * _507);
    float3 _525 = _519;
    _525.z = (dot(float4(_421, _423.xyz), _505) + dot(float4(_423.w, _444.xyz), _506)) + (_444.w * _507);
    float _554;
    float _555;
    float3 _556;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _541 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _336, level(0.0)).xyz * 2.0) - float3(1.0);
        float _542 = length(_541);
        float3 _545 = _541 / float3(fast::max(_542, 9.9999997473787516355514526367188e-05));
        float _546 = 1.0 - _542;
        float _548 = 1.0 - (_546 * _546);
        _554 = mix(fast::clamp(dot(_545, _300), 0.0, 1.0), 1.0, _548);
        _555 = _542;
        _556 = mix(_545, _300, float3(_548));
    }
    else
    {
        _554 = 1.0;
        _555 = 1.0;
        _556 = _300;
    }
    float4 _560 = float4(_556, 1.0);
    float3 _564 = _161;
    _564.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _560);
    float3 _568 = _564;
    _568.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _560);
    float3 _572 = _568;
    _572.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _560);
    float4 _575 = _560.xyzz * _560.yzzx;
    float3 _579 = _161;
    _579.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _575);
    float3 _583 = _579;
    _583.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _575);
    float3 _587 = _583;
    _587.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _575);
    float3 _602 = ((fast::max(float3(0.0), _525) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_572 + _587) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_556.x * _556.x) - (_556.y * _556.y)))) * View.View_SkyLightColor.xyz) * (_555 * _554));
    float3 _624 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _653;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _652;
        if (any(abs(_227 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _247 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _247 + 19u)].xyz + float3(1.0))))
        {
            _652 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_227, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _652 = _624;
        }
        _653 = _652;
    }
    else
    {
        _653 = _624;
    }
    float4 _660 = float4(((mix(float3(0.0), _378 + (_380 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_602 * _378) * fast::max(float3(1.0), ((((((_299 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_299 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_299 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _653) * 1.0, 0.0);
    float4 _667;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _666 = _660;
        _666.w = 0.0;
        _667 = _666;
    }
    else
    {
        _667 = _660;
    }
    float2 _671 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _679 = (_300 * 0.5) + float3(0.5);
    float4 _681 = float4(_679.x, _679.y, _679.z, float4(0.0).w);
    _681.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _248)].y;
    float4 _682 = float4(0.0);
    _682.x = _298;
    float4 _683 = _682;
    _683.y = _297;
    float4 _684 = _683;
    _684.z = _296;
    float4 _685 = _684;
    _685.w = 0.50588238239288330078125;
    float4 _697 = float4(_299.x, _299.y, _299.z, float4(0.0).w);
    _697.w = ((log2(((dot(_602, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_382 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_382 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_382 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_671.xyx * _671.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _667 * View.View_PreExposure;
    out.out_var_SV_Target1 = _681;
    out.out_var_SV_Target2 = _685;
    out.out_var_SV_Target3 = _697;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_349, 1.0, 1.0, 1.0);
    return out;
}

