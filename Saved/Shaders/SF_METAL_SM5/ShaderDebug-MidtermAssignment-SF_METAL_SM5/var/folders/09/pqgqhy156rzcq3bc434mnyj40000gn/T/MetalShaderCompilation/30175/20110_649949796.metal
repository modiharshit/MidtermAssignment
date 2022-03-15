

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
    char _m0_pad[448];
    float4x4 View_ViewToClip;
    char _m1_pad[192];
    float4x4 View_SVPositionToTranslatedWorld;
    char _m2_pad[272];
    float4 View_InvDeviceZToWorldZTransform;
    float4 View_ScreenPositionScaleBias;
    char _m4_pad[48];
    float3 View_PreViewTranslation;
    char _m5_pad[928];
    float4 View_ViewRectMin;
    float4 View_ViewSizeAndInvSize;
    char _m7_pad[68];
    float View_PreExposure;
    float4 View_DiffuseOverrideParameter;
    float4 View_SpecularOverrideParameter;
    float4 View_NormalOverrideParameter;
    float2 View_RoughnessOverrideParameter;
    char _m12_pad[8];
    float View_OutOfBoundsMask;
    char _m13_pad[48];
    float View_MaterialTextureMipBias;
    char _m14_pad[28];
    float View_UnlitViewmodeMask;
    char _m15_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m16_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m17_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m19_pad[124];
    float View_ShowDecalsMask;
    char _m20_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m21_pad[48];
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

struct type_Primitive
{
    char _m0_pad[80];
    float4 Primitive_ObjectWorldPositionAndRadius;
    char _m1_pad[208];
    float3 Primitive_ObjectBounds;
    float Primitive_DecalReceiverMask;
    float Primitive_PerObjectGBufferData;
    float Primitive_UseVolumetricLightmapShadowFromStationaryLights;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _180 = {};
constant float3 _181 = {};
constant float4 _183 = {};

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
    float4 in_var_TEXCOORD0_0 [[user(locn0)]];
    float4 in_var_TANGENTX [[user(locn2)]];
    float4 in_var_TANGENTZ [[user(locn3)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00004e8e_26bd7264(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(11)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(12)]], texture2d<float> Material_Texture2D_0 [[texture(13)]], texture2d<float> Material_Texture2D_1 [[texture(14)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _243 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _247 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _252 = (_247.xyz / float3(_247.w)) - View.View_PreViewTranslation;
    float4 _260 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _263 = (_260.xy * float2(2.0)) - float2(1.0);
    float3 _280 = normalize(float3x3(in.in_var_TANGENTX.xyz, cross(in.in_var_TANGENTZ.xyz, in.in_var_TANGENTX.xyz) * in.in_var_TANGENTZ.w, in.in_var_TANGENTZ.xyz) * normalize(((float4(_263, sqrt(fast::clamp(1.0 - dot(_263, _263), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _292 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 20.0), bias(View.View_MaterialTextureMipBias));
    float _294 = mix(0.4000000059604644775390625, 1.0, _292.x);
    float4 _298 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _323;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _323 = _243.w;
                break;
            }
            else
            {
                float _307 = _243.z;
                _323 = ((_307 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_307 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _327 = fast::min(fast::max((_323 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _328 = _298.y;
    float4 _332 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _334 = _332.y;
    float3 _347 = fast::clamp(float3(mix(_294, 1.0 - _294, mix(_328, 1.0, _327)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_334 + mix(_328, 0.0, _327), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _352 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _334) + mix(mix(0.699999988079071044921875, 1.0, _328), 1.0, _327), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _399;
    float _400;
    float _401;
    float3 _402;
    float3 _403;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _369 = ((_243.xy / float2(_243.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _373 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _369, level(0.0));
        float4 _376 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _369, level(0.0));
        float4 _379 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _369, level(0.0));
        float _389 = _379.w;
        _399 = (_352 * _389) + _379.z;
        _400 = (0.5 * _389) + _379.y;
        _401 = _379.x;
        _402 = (_347 * _373.w) + _373.xyz;
        _403 = normalize((_280 * _376.w) + ((_376.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _399 = _352;
        _400 = 0.5;
        _401 = 0.0;
        _402 = _347;
        _403 = _280;
    }
    float3 _413 = fast::clamp((_252 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _424 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_413.x), int(_413.y), int(_413.z), 0).xyz), 0));
    float3 _439 = (((_424.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_413 / float3(_424.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _452;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        _452 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _439, level(0.0)).x;
    }
    else
    {
        _452 = 1.0;
    }
    float3 _466 = ((_402 - (_402 * _401)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _473 = (mix(float3(0.07999999821186065673828125 * _400), _402, float3(_401)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _476 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _481;
    if (_476)
    {
        _481 = _466 + (_473 * 0.449999988079071044921875);
    }
    else
    {
        _481 = _466;
    }
    float3 _483 = select(_473, float3(0.0), bool3(_476));
    float3 _485 = float3(dot(_483, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _502 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _439, level(0.0));
    float _518 = _502.x;
    float4 _520 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _439, level(0.0)) * 2.0) - float4(1.0)) * _518) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _521 = _502.y;
    float4 _523 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _439, level(0.0)) * 2.0) - float4(1.0)) * _521) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _524 = _502.z;
    float4 _526 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _439, level(0.0)) * 2.0) - float4(1.0)) * _524) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _543 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _439, level(0.0)) * 2.0) - float4(1.0)) * _518) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _545 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _439, level(0.0)) * 2.0) - float4(1.0)) * _521) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _547 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _439, level(0.0)) * 2.0) - float4(1.0)) * _524) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _580 = _183;
    _580.y = (-0.48860299587249755859375) * _403.y;
    float4 _583 = _580;
    _583.z = 0.48860299587249755859375 * _403.z;
    float4 _586 = _583;
    _586.w = (-0.48860299587249755859375) * _403.x;
    float3 _587 = _403 * _403;
    float4 _590 = _180;
    _590.x = (1.09254801273345947265625 * _403.x) * _403.y;
    float4 _593 = _590;
    _593.y = ((-1.09254801273345947265625) * _403.y) * _403.z;
    float4 _598 = _593;
    _598.z = 0.3153919875621795654296875 * ((3.0 * _587.z) - 1.0);
    float4 _601 = _598;
    _601.w = ((-1.09254801273345947265625) * _403.x) * _403.z;
    float4 _605 = _586;
    _605.x = 0.886227548122406005859375;
    float3 _607 = _605.yzw * 2.094395160675048828125;
    float4 _608 = float4(_605.x, _607.x, _607.y, _607.z);
    float4 _609 = _601 * 0.785398185253143310546875;
    float _610 = (_587.x - _587.y) * 0.4290426075458526611328125;
    float3 _616 = float3(0.0);
    _616.x = (dot(float4(_518, _520.xyz), _608) + dot(float4(_520.w, _543.xyz), _609)) + (_543.w * _610);
    float3 _622 = _616;
    _622.y = (dot(float4(_521, _523.xyz), _608) + dot(float4(_523.w, _545.xyz), _609)) + (_545.w * _610);
    float3 _628 = _622;
    _628.z = (dot(float4(_524, _526.xyz), _608) + dot(float4(_526.w, _547.xyz), _609)) + (_547.w * _610);
    float _657;
    float _658;
    float3 _659;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _644 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _439, level(0.0)).xyz * 2.0) - float3(1.0);
        float _645 = length(_644);
        float3 _648 = _644 / float3(fast::max(_645, 9.9999997473787516355514526367188e-05));
        float _649 = 1.0 - _645;
        float _651 = 1.0 - (_649 * _649);
        _657 = mix(fast::clamp(dot(_648, _403), 0.0, 1.0), 1.0, _651);
        _658 = _645;
        _659 = mix(_648, _403, float3(_651));
    }
    else
    {
        _657 = 1.0;
        _658 = 1.0;
        _659 = _403;
    }
    float4 _663 = float4(_659, 1.0);
    float3 _667 = _181;
    _667.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _663);
    float3 _671 = _667;
    _671.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _663);
    float3 _675 = _671;
    _675.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _663);
    float4 _678 = _663.xyzz * _663.yzzx;
    float3 _682 = _181;
    _682.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _678);
    float3 _686 = _682;
    _686.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _678);
    float3 _690 = _686;
    _690.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _678);
    float3 _705 = ((fast::max(float3(0.0), _628) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_675 + _690) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_659.x * _659.x) - (_659.y * _659.y)))) * View.View_SkyLightColor.xyz) * (_658 * _657));
    float3 _727 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _753;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _752;
        if (any(abs(_252 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _752 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_252, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _752 = _727;
        }
        _753 = _752;
    }
    else
    {
        _753 = _727;
    }
    float4 _760 = float4(((mix(float3(0.0), _481 + (_483 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_705 * _481) * fast::max(float3(1.0), ((((((_402 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_402 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_402 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _753) * 1.0, 0.0);
    float4 _767;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _766 = _760;
        _766.w = 0.0;
        _767 = _766;
    }
    else
    {
        _767 = _760;
    }
    float2 _771 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _779 = (_403 * 0.5) + float3(0.5);
    float4 _781 = float4(_779.x, _779.y, _779.z, float4(0.0).w);
    _781.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _782 = float4(0.0);
    _782.x = _401;
    float4 _783 = _782;
    _783.y = _400;
    float4 _784 = _783;
    _784.z = _399;
    float4 _785 = _784;
    _785.w = 0.50588238239288330078125;
    float4 _797 = float4(_402.x, _402.y, _402.z, float4(0.0).w);
    _797.w = ((log2(((dot(_705, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_485 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_485 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_485 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_771.xyx * _771.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _767 * View.View_PreExposure;
    out.out_var_SV_Target1 = _781;
    out.out_var_SV_Target2 = _785;
    out.out_var_SV_Target3 = _797;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_452, 1.0, 1.0, 1.0);
    return out;
}

