

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
    char _m0_pad[256];
    float4x4 View_ViewToTranslatedWorld;
    char _m1_pad[384];
    float4x4 View_SVPositionToTranslatedWorld;
    char _m2_pad[288];
    float4 View_ScreenPositionScaleBias;
    float3 View_WorldCameraOrigin;
    char _m4_pad[32];
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
    char _m16_pad[400];
    packed_float3 View_NormalCurvatureToRoughnessScaleBias;
    float View_RenderingReflectionCaptureMask;
    char _m18_pad[188];
    float View_ShowDecalsMask;
    char _m19_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m20_pad[48];
    float3 View_VolumetricLightmapWorldToUVScale;
    float3 View_VolumetricLightmapWorldToUVAdd;
    packed_float3 View_VolumetricLightmapIndirectionTextureSize;
    float View_VolumetricLightmapBrickSize;
    float3 View_VolumetricLightmapBrickTexelSize;
    float View_IndirectLightingCacheShowFlag;
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_PrimitiveDither
{
    float PrimitiveDither_LODFactor;
};

struct type_IndirectLightingCache
{
    char _m0_pad[80];
    float IndirectLightingCache_DirectionalLightShadowing;
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients0;
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients1;
    float4 IndirectLightingCache_IndirectLightingSHCoefficients2;
};

struct type_Material
{
    spvUnsafeArray<float4, 6> Material_VectorExpressions;
    spvUnsafeArray<float4, 4> Material_ScalarExpressions;
};

constant float _172 = {};
constant float4x4 _173 = {};
constant float4 _174 = {};
constant float _176 = {};
constant float4 _177 = {};
constant float3 _178 = {};

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
    float4 in_var_TEXCOORD15 [[user(locn2)]];
    float4 in_var_TEXCOORD0_0 [[user(locn3)]];
    uint in_var_PRIMITIVE_ID [[user(locn4)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_000050b5_d25aa755(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_PrimitiveDither& PrimitiveDither [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_3 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_3Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float3x3 _228 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _240 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _176, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _245 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _250 = (_245.xyz / float3(_245.w)) - View.View_PreViewTranslation;
    uint _251 = in.in_var_PRIMITIVE_ID * 36u;
    float4x4 _254 = _173;
    _254[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _251)];
    float4x4 _258 = _254;
    _258[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _251 + 1u)];
    float4x4 _262 = _258;
    _262[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _251 + 2u)];
    float4x4 _266 = _262;
    _266[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _251 + 3u)];
    float3 _269 = (_266 * float4(0.0, 0.0, 0.0, 1.0)).xyz - View.View_WorldCameraOrigin;
    float4 _281 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _284 = (float3(-0.5) + _281.xyz) * 2.0;
    float3 _300 = ((((_269 / float3(sqrt(dot(_269, _269)))) * _228) * (-1.0)) * _284.z) + (float3(_284.xy, 0.0) * ((float3x3(View.View_ViewToTranslatedWorld[0].xyz, View.View_ViewToTranslatedWorld[1].xyz, View.View_ViewToTranslatedWorld[2].xyz) * float3(1.0, 1.0, 0.0)) * _228));
    float3 _312 = normalize(_228 * normalize(((_300 / float3(sqrt(dot(_300, _300)))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _323 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _330 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    if (PrimitiveDither.PrimitiveDither_LODFactor != 0.0)
    {
        if (abs(PrimitiveDither.PrimitiveDither_LODFactor) > 0.001000000047497451305389404296875)
        {
            float _350 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
            if ((float((PrimitiveDither.PrimitiveDither_LODFactor < 0.0) ? ((PrimitiveDither.PrimitiveDither_LODFactor + 1.0) > _350) : (PrimitiveDither.PrimitiveDither_LODFactor < _350)) - 0.001000000047497451305389404296875) < 0.0)
            {
                discard_fragment();
            }
        }
    }
    if (((_323.w * in_var_TEXCOORD0[0].z) - 0.100000001490116119384765625) < 0.0)
    {
        discard_fragment();
    }
    float3 _365 = fast::clamp(_323.xyz, float3(0.0), float3(1.0));
    float _370 = (fast::clamp(_281.w, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float3 _380 = (fast::clamp(float4(_330.xyz, _172).xyz, float3(0.0), float3(1.0)).xyz * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    uint _381 = _251 + 20u;
    float3 _430;
    float _431;
    float _432;
    float _433;
    float3 _434;
    float3 _435;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _381)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _399 = ((_240.xy / float2(_240.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _403 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _399, level(0.0));
        float4 _406 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _399, level(0.0));
        float4 _409 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _399, level(0.0));
        float _411 = _403.w;
        float _419 = _409.w;
        _430 = _380 * _411;
        _431 = (_370 * _419) + _409.z;
        _432 = (0.5 * _419) + _409.y;
        _433 = _409.x;
        _434 = (_365 * _411) + _403.xyz;
        _435 = normalize((_312 * _406.w) + ((_406.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _430 = _380;
        _431 = _370;
        _432 = 0.5;
        _433 = 0.0;
        _434 = _365;
        _435 = _312;
    }
    bool _445 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _451;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _251 + 18u)].w > 0.0) && _445)
    {
        _451 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _451 = 1.0;
    }
    float _498;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _381)].z > 0.0)
    {
        float3 _466 = fast::clamp((_250 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _477 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_466.x), int(_466.y), int(_466.z), 0).xyz), 0));
        _498 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_477.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_466 / float3(_477.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _498 = _451;
    }
    float3 _501 = sqrt(fast::clamp(_430, float3(0.0), float3(1.0)));
    float4 _503 = float4(_501.x, _501.y, _501.z, float4(0.0).w);
    _503.w = 1.0;
    float3 _508 = dfdx(in.in_var_TEXCOORD15.xyz);
    float3 _509 = dfdy(in.in_var_TEXCOORD15.xyz);
    float3 _527 = ((_434 - (_434 * _433)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _534 = (mix(float3(0.07999999821186065673828125 * _432), _434, float3(_433)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _537 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _542;
    if (_537)
    {
        _542 = _527 + (_534 * 0.449999988079071044921875);
    }
    else
    {
        _542 = _527;
    }
    float3 _544 = select(_534, float3(0.0), bool3(_537));
    float3 _546 = float3(dot(_544, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _685;
    float3 _686;
    if (_445)
    {
        float4 _582 = _177;
        _582.y = (-0.48860299587249755859375) * _435.y;
        float4 _585 = _582;
        _585.z = 0.48860299587249755859375 * _435.z;
        float4 _588 = _585;
        _588.w = (-0.48860299587249755859375) * _435.x;
        float3 _589 = _435 * _435;
        float4 _592 = _174;
        _592.x = (1.09254801273345947265625 * _435.x) * _435.y;
        float4 _595 = _592;
        _595.y = ((-1.09254801273345947265625) * _435.y) * _435.z;
        float4 _600 = _595;
        _600.z = 0.3153919875621795654296875 * ((3.0 * _589.z) - 1.0);
        float4 _603 = _600;
        _603.w = ((-1.09254801273345947265625) * _435.x) * _435.z;
        float4 _607 = _588;
        _607.x = 0.886227548122406005859375;
        float3 _609 = _607.yzw * 2.094395160675048828125;
        float4 _610 = float4(_607.x, _609.x, _609.y, _609.z);
        float4 _611 = _603 * 0.785398185253143310546875;
        float _612 = (_589.x - _589.y) * 0.4290426075458526611328125;
        float3 _618 = float3(0.0);
        _618.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _610) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _611)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _612);
        float3 _624 = _618;
        _624.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _610) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _611)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _612);
        float3 _630 = _624;
        _630.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _610) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _611)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _612);
        float3 _632 = -_435;
        float _633 = _632.y;
        float4 _635 = _177;
        _635.y = (-0.48860299587249755859375) * _633;
        float _636 = _632.z;
        float4 _638 = _635;
        _638.z = 0.48860299587249755859375 * _636;
        float _639 = _632.x;
        float4 _641 = _638;
        _641.w = (-0.48860299587249755859375) * _639;
        float3 _642 = _632 * _632;
        float4 _645 = _174;
        _645.x = (1.09254801273345947265625 * _639) * _633;
        float4 _648 = _645;
        _648.y = ((-1.09254801273345947265625) * _633) * _636;
        float4 _653 = _648;
        _653.z = 0.3153919875621795654296875 * ((3.0 * _642.z) - 1.0);
        float4 _656 = _653;
        _656.w = ((-1.09254801273345947265625) * _639) * _636;
        float4 _660 = _641;
        _660.x = 0.886227548122406005859375;
        float3 _662 = _660.yzw * 2.094395160675048828125;
        float4 _663 = float4(_660.x, _662.x, _662.y, _662.z);
        float4 _664 = _656 * 0.785398185253143310546875;
        float _665 = (_642.x - _642.y) * 0.4290426075458526611328125;
        float3 _671 = _178;
        _671.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _663) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _664)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _665);
        float3 _677 = _671;
        _677.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _663) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _664)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _665);
        float3 _683 = _677;
        _683.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _663) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _664)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _665);
        _685 = fast::max(float3(0.0), _683);
        _686 = fast::max(float3(0.0), _630);
    }
    else
    {
        _685 = float3(0.0);
        _686 = float3(0.0);
    }
    float3 _689 = _686 * View.View_IndirectLightingColorScale;
    float3 _714 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _743;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _742;
        if (any(abs(_250 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _251 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _251 + 19u)].xyz + float3(1.0))))
        {
            _742 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_250, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _742 = _714;
        }
        _743 = _742;
    }
    else
    {
        _743 = _714;
    }
    float4 _750 = float4(((mix(float3(0.0), _542 + (_544 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + (((_689 * _542) + ((_685 * View.View_IndirectLightingColorScale) * _430)) * fast::max(float3(1.0), ((((((_434 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_434 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_434 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _743) * 1.0, 0.0);
    float4 _757;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _756 = _750;
        _756.w = 0.0;
        _757 = _756;
    }
    else
    {
        _757 = _750;
    }
    float2 _761 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _769 = (_435 * 0.5) + float3(0.5);
    float4 _771 = float4(_769.x, _769.y, _769.z, float4(0.0).w);
    _771.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _381)].y;
    float4 _772 = float4(0.0);
    _772.x = _433;
    float4 _773 = _772;
    _773.y = _432;
    float4 _774 = _773;
    _774.z = fast::max(_431, fast::clamp((pow(fast::max(dot(_508, _508), dot(_509, _509)), View.View_NormalCurvatureToRoughnessScaleBias[2]) * View.View_NormalCurvatureToRoughnessScaleBias[0]) + View.View_NormalCurvatureToRoughnessScaleBias[1], 0.0, 1.0));
    float4 _775 = _774;
    _775.w = 0.525490224361419677734375;
    float4 _787 = float4(_434.x, _434.y, _434.z, float4(0.0).w);
    _787.w = ((log2(((dot(_689, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_546 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_546 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_546 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_761.xyx * _761.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _757 * View.View_PreExposure;
    out.out_var_SV_Target1 = _771;
    out.out_var_SV_Target2 = _775;
    out.out_var_SV_Target3 = _787;
    out.out_var_SV_Target4 = _503;
    out.out_var_SV_Target5 = float4(_498, 1.0, 1.0, 1.0);
    return out;
}

