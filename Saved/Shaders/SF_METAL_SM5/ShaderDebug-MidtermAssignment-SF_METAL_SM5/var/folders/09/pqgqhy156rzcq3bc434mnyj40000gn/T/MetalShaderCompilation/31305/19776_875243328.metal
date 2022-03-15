

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

fragment MainPS_out Main_00004d40_342b2740(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(11)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(12)]], texture2d<float> Material_Texture2D_0 [[texture(13)]], texture2d<float> Material_Texture2D_1 [[texture(14)]], texture2d<float> Material_Texture2D_2 [[texture(15)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
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
    float3 _308 = fast::clamp(mix(float3(0.5), float3(1.0), float3(_296)) * _302.xyz, float3(0.0), float3(1.0));
    float _313 = (fast::clamp(mix(0.60000002384185791015625, 0.4000000059604644775390625, _296 * _302.w), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _314 = in.in_var_PRIMITIVE_ID * 36u;
    uint _315 = _314 + 20u;
    float _364;
    float _365;
    float _366;
    float3 _367;
    float3 _368;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _315)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _333 = ((_235.xy / float2(_235.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _337 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _333, level(0.0));
        float4 _340 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _333, level(0.0));
        float4 _343 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _333, level(0.0));
        float _353 = _343.w;
        _364 = (_313 * _353) + _343.z;
        _365 = (0.5 * _353) + _343.y;
        _366 = _353 + _343.x;
        _367 = (_308 * _337.w) + _337.xyz;
        _368 = normalize((_270 * _340.w) + ((_340.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _364 = _313;
        _365 = 0.5;
        _366 = 1.0;
        _367 = _308;
        _368 = _270;
    }
    float3 _378 = fast::clamp((_245 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _389 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_378.x), int(_378.y), int(_378.z), 0).xyz), 0));
    float3 _404 = (((_389.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_378 / float3(_389.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _417;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _315)].z > 0.0)
    {
        _417 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _404, level(0.0)).x;
    }
    else
    {
        _417 = 1.0;
    }
    float3 _431 = ((_367 - (_367 * _366)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _438 = (mix(float3(0.07999999821186065673828125 * _365), _367, float3(_366)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _441 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _446;
    if (_441)
    {
        _446 = _431 + (_438 * 0.449999988079071044921875);
    }
    else
    {
        _446 = _431;
    }
    float3 _448 = select(_438, float3(0.0), bool3(_441));
    float3 _450 = float3(dot(_448, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _467 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _404, level(0.0));
    float _483 = _467.x;
    float4 _485 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _404, level(0.0)) * 2.0) - float4(1.0)) * _483) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _486 = _467.y;
    float4 _488 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _404, level(0.0)) * 2.0) - float4(1.0)) * _486) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _489 = _467.z;
    float4 _491 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _404, level(0.0)) * 2.0) - float4(1.0)) * _489) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _508 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _404, level(0.0)) * 2.0) - float4(1.0)) * _483) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _510 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _404, level(0.0)) * 2.0) - float4(1.0)) * _486) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _512 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _404, level(0.0)) * 2.0) - float4(1.0)) * _489) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _545 = _178;
    _545.y = (-0.48860299587249755859375) * _368.y;
    float4 _548 = _545;
    _548.z = 0.48860299587249755859375 * _368.z;
    float4 _551 = _548;
    _551.w = (-0.48860299587249755859375) * _368.x;
    float3 _552 = _368 * _368;
    float4 _555 = _174;
    _555.x = (1.09254801273345947265625 * _368.x) * _368.y;
    float4 _558 = _555;
    _558.y = ((-1.09254801273345947265625) * _368.y) * _368.z;
    float4 _563 = _558;
    _563.z = 0.3153919875621795654296875 * ((3.0 * _552.z) - 1.0);
    float4 _566 = _563;
    _566.w = ((-1.09254801273345947265625) * _368.x) * _368.z;
    float4 _570 = _551;
    _570.x = 0.886227548122406005859375;
    float3 _572 = _570.yzw * 2.094395160675048828125;
    float4 _573 = float4(_570.x, _572.x, _572.y, _572.z);
    float4 _574 = _566 * 0.785398185253143310546875;
    float _575 = (_552.x - _552.y) * 0.4290426075458526611328125;
    float3 _581 = float3(0.0);
    _581.x = (dot(float4(_483, _485.xyz), _573) + dot(float4(_485.w, _508.xyz), _574)) + (_508.w * _575);
    float3 _587 = _581;
    _587.y = (dot(float4(_486, _488.xyz), _573) + dot(float4(_488.w, _510.xyz), _574)) + (_510.w * _575);
    float3 _593 = _587;
    _593.z = (dot(float4(_489, _491.xyz), _573) + dot(float4(_491.w, _512.xyz), _574)) + (_512.w * _575);
    float _622;
    float _623;
    float3 _624;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _609 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _404, level(0.0)).xyz * 2.0) - float3(1.0);
        float _610 = length(_609);
        float3 _613 = _609 / float3(fast::max(_610, 9.9999997473787516355514526367188e-05));
        float _614 = 1.0 - _610;
        float _616 = 1.0 - (_614 * _614);
        _622 = mix(fast::clamp(dot(_613, _368), 0.0, 1.0), 1.0, _616);
        _623 = _610;
        _624 = mix(_613, _368, float3(_616));
    }
    else
    {
        _622 = 1.0;
        _623 = 1.0;
        _624 = _368;
    }
    float4 _628 = float4(_624, 1.0);
    float3 _632 = _175;
    _632.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _628);
    float3 _636 = _632;
    _636.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _628);
    float3 _640 = _636;
    _640.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _628);
    float4 _643 = _628.xyzz * _628.yzzx;
    float3 _647 = _175;
    _647.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _643);
    float3 _651 = _647;
    _651.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _643);
    float3 _655 = _651;
    _655.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _643);
    float3 _670 = ((fast::max(float3(0.0), _593) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_640 + _655) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_624.x * _624.x) - (_624.y * _624.y)))) * View.View_SkyLightColor.xyz) * (_623 * _622));
    float3 _692 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _721;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _720;
        if (any(abs(_245 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _314 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _314 + 19u)].xyz + float3(1.0))))
        {
            _720 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_245, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _720 = _692;
        }
        _721 = _720;
    }
    else
    {
        _721 = _692;
    }
    float4 _728 = float4(((mix(float3(0.0), _446 + (_448 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_670 * _446) * fast::max(float3(1.0), ((((((_367 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_367 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_367 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _721) * 1.0, 0.0);
    float4 _735;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _734 = _728;
        _734.w = 0.0;
        _735 = _734;
    }
    else
    {
        _735 = _728;
    }
    float2 _739 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _747 = (_368 * 0.5) + float3(0.5);
    float4 _749 = float4(_747.x, _747.y, _747.z, float4(0.0).w);
    _749.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _315)].y;
    float4 _750 = float4(0.0);
    _750.x = _366;
    float4 _751 = _750;
    _751.y = _365;
    float4 _752 = _751;
    _752.z = _364;
    float4 _753 = _752;
    _753.w = 0.50588238239288330078125;
    float4 _765 = float4(_367.x, _367.y, _367.z, float4(0.0).w);
    _765.w = ((log2(((dot(_670, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_450 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_450 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_450 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_739.xyx * _739.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _735 * View.View_PreExposure;
    out.out_var_SV_Target1 = _749;
    out.out_var_SV_Target2 = _753;
    out.out_var_SV_Target3 = _765;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_417, 1.0, 1.0, 1.0);
    return out;
}

