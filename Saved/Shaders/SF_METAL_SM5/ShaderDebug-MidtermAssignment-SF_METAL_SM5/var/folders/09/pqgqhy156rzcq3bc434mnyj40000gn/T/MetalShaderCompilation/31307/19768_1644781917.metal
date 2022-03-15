

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
    char _m11_pad[48];
    float View_MaterialTextureMipBias;
    char _m12_pad[28];
    float View_UnlitViewmodeMask;
    char _m13_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m14_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m15_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m17_pad[124];
    float View_ShowDecalsMask;
    char _m18_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m19_pad[48];
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

constant float4 _174 = {};
constant float3 _175 = {};
constant float _177 = {};
constant float4 _178 = {};

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

fragment MainPS_out Main_00004d38_6209615d(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(11)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(12)]], texture2d<float> Material_Texture2D_0 [[texture(13)]], texture2d<float> Material_Texture2D_1 [[texture(14)]], texture2d<float> Material_Texture2D_2 [[texture(15)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _235 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _177, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _240 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _245 = (_240.xyz / float3(_240.w)) - View.View_PreViewTranslation;
    float4 _251 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _254 = (_251.xy * float2(2.0)) - float2(1.0);
    float3 _270 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_254, sqrt(fast::clamp(1.0 - dot(_254, _254), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _282 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _287 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _292 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _296 = (_282.x + 0.5) * ((_287.x + 0.5) * (_292.x + 0.5));
    float4 _302 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _308 = fast::clamp(mix(float3(0.800000011920928955078125), float3(1.0), float3(_296)) * _302.xyz, float3(0.0), float3(1.0));
    float _313 = (fast::clamp(mix(0.800000011920928955078125, 0.5, _296 * _302.w), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _314 = in.in_var_PRIMITIVE_ID * 36u;
    uint _315 = _314 + 20u;
    float _363;
    float _364;
    float _365;
    float3 _366;
    float3 _367;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _315)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _333 = ((_235.xy / float2(_235.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _337 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _333, level(0.0));
        float4 _340 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _333, level(0.0));
        float4 _343 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _333, level(0.0));
        float _353 = _343.w;
        _363 = (_313 * _353) + _343.z;
        _364 = (0.5 * _353) + _343.y;
        _365 = _343.x;
        _366 = (_308 * _337.w) + _337.xyz;
        _367 = normalize((_270 * _340.w) + ((_340.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _363 = _313;
        _364 = 0.5;
        _365 = 0.0;
        _366 = _308;
        _367 = _270;
    }
    float3 _377 = fast::clamp((_245 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _388 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_377.x), int(_377.y), int(_377.z), 0).xyz), 0));
    float3 _403 = (((_388.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_377 / float3(_388.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _416;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _315)].z > 0.0)
    {
        _416 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _403, level(0.0)).x;
    }
    else
    {
        _416 = 1.0;
    }
    float3 _430 = ((_366 - (_366 * _365)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _437 = (mix(float3(0.07999999821186065673828125 * _364), _366, float3(_365)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _440 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _445;
    if (_440)
    {
        _445 = _430 + (_437 * 0.449999988079071044921875);
    }
    else
    {
        _445 = _430;
    }
    float3 _447 = select(_437, float3(0.0), bool3(_440));
    float3 _449 = float3(dot(_447, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _466 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _403, level(0.0));
    float _482 = _466.x;
    float4 _484 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _403, level(0.0)) * 2.0) - float4(1.0)) * _482) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _485 = _466.y;
    float4 _487 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _403, level(0.0)) * 2.0) - float4(1.0)) * _485) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _488 = _466.z;
    float4 _490 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _403, level(0.0)) * 2.0) - float4(1.0)) * _488) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _507 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _403, level(0.0)) * 2.0) - float4(1.0)) * _482) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _509 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _403, level(0.0)) * 2.0) - float4(1.0)) * _485) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _511 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _403, level(0.0)) * 2.0) - float4(1.0)) * _488) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _544 = _178;
    _544.y = (-0.48860299587249755859375) * _367.y;
    float4 _547 = _544;
    _547.z = 0.48860299587249755859375 * _367.z;
    float4 _550 = _547;
    _550.w = (-0.48860299587249755859375) * _367.x;
    float3 _551 = _367 * _367;
    float4 _554 = _174;
    _554.x = (1.09254801273345947265625 * _367.x) * _367.y;
    float4 _557 = _554;
    _557.y = ((-1.09254801273345947265625) * _367.y) * _367.z;
    float4 _562 = _557;
    _562.z = 0.3153919875621795654296875 * ((3.0 * _551.z) - 1.0);
    float4 _565 = _562;
    _565.w = ((-1.09254801273345947265625) * _367.x) * _367.z;
    float4 _569 = _550;
    _569.x = 0.886227548122406005859375;
    float3 _571 = _569.yzw * 2.094395160675048828125;
    float4 _572 = float4(_569.x, _571.x, _571.y, _571.z);
    float4 _573 = _565 * 0.785398185253143310546875;
    float _574 = (_551.x - _551.y) * 0.4290426075458526611328125;
    float3 _580 = float3(0.0);
    _580.x = (dot(float4(_482, _484.xyz), _572) + dot(float4(_484.w, _507.xyz), _573)) + (_507.w * _574);
    float3 _586 = _580;
    _586.y = (dot(float4(_485, _487.xyz), _572) + dot(float4(_487.w, _509.xyz), _573)) + (_509.w * _574);
    float3 _592 = _586;
    _592.z = (dot(float4(_488, _490.xyz), _572) + dot(float4(_490.w, _511.xyz), _573)) + (_511.w * _574);
    float _621;
    float _622;
    float3 _623;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _608 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _403, level(0.0)).xyz * 2.0) - float3(1.0);
        float _609 = length(_608);
        float3 _612 = _608 / float3(fast::max(_609, 9.9999997473787516355514526367188e-05));
        float _613 = 1.0 - _609;
        float _615 = 1.0 - (_613 * _613);
        _621 = mix(fast::clamp(dot(_612, _367), 0.0, 1.0), 1.0, _615);
        _622 = _609;
        _623 = mix(_612, _367, float3(_615));
    }
    else
    {
        _621 = 1.0;
        _622 = 1.0;
        _623 = _367;
    }
    float4 _627 = float4(_623, 1.0);
    float3 _631 = _175;
    _631.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _627);
    float3 _635 = _631;
    _635.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _627);
    float3 _639 = _635;
    _639.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _627);
    float4 _642 = _627.xyzz * _627.yzzx;
    float3 _646 = _175;
    _646.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _642);
    float3 _650 = _646;
    _650.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _642);
    float3 _654 = _650;
    _654.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _642);
    float3 _669 = ((fast::max(float3(0.0), _592) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_639 + _654) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_623.x * _623.x) - (_623.y * _623.y)))) * View.View_SkyLightColor.xyz) * (_622 * _621));
    float3 _691 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _720;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _719;
        if (any(abs(_245 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _314 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _314 + 19u)].xyz + float3(1.0))))
        {
            _719 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_245, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _719 = _691;
        }
        _720 = _719;
    }
    else
    {
        _720 = _691;
    }
    float4 _727 = float4(((mix(float3(0.0), _445 + (_447 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_669 * _445) * fast::max(float3(1.0), ((((((_366 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_366 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_366 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _720) * 1.0, 0.0);
    float4 _734;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _733 = _727;
        _733.w = 0.0;
        _734 = _733;
    }
    else
    {
        _734 = _727;
    }
    float2 _738 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _746 = (_367 * 0.5) + float3(0.5);
    float4 _748 = float4(_746.x, _746.y, _746.z, float4(0.0).w);
    _748.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _315)].y;
    float4 _749 = float4(0.0);
    _749.x = _365;
    float4 _750 = _749;
    _750.y = _364;
    float4 _751 = _750;
    _751.z = _363;
    float4 _752 = _751;
    _752.w = 0.50588238239288330078125;
    float4 _764 = float4(_366.x, _366.y, _366.z, float4(0.0).w);
    _764.w = ((log2(((dot(_669, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_449 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_449 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_449 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_738.xyx * _738.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _734 * View.View_PreExposure;
    out.out_var_SV_Target1 = _748;
    out.out_var_SV_Target2 = _752;
    out.out_var_SV_Target3 = _764;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_416, 1.0, 1.0, 1.0);
    return out;
}

