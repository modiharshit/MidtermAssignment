

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
    float View_IndirectLightingCacheShowFlag;
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_IndirectLightingCache
{
    char _m0_pad[64];
    float4 IndirectLightingCache_PointSkyBentNormal;
    float IndirectLightingCache_DirectionalLightShadowing;
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients0;
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients1;
    float4 IndirectLightingCache_IndirectLightingSHCoefficients2;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _171 = {};
constant float3 _172 = {};
constant float4 _174 = {};

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

fragment MainPS_out Main_00004d41_f215ebce(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _234 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _238 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _243 = (_238.xyz / float3(_238.w)) - View.View_PreViewTranslation;
    float4 _249 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _252 = (_249.xy * float2(2.0)) - float2(1.0);
    float4 _264 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _291;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _291 = _234.w;
                break;
            }
            else
            {
                float _275 = _234.z;
                _291 = ((_275 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_275 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _307 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(float4(_252, sqrt(fast::clamp(1.0 - dot(_252, _252), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _264.x) + _291) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _319 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _324 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _329 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _333 = (_319.x + 0.5) * ((_324.x + 0.5) * (_329.x + 0.5));
    float4 _337 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _343 = fast::clamp(_337.xyz * _333, float3(0.0), float3(1.0));
    float _348 = (fast::clamp(mix(0.800000011920928955078125, 0.4000000059604644775390625, _333 * _337.w), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _349 = in.in_var_PRIMITIVE_ID * 36u;
    uint _350 = _349 + 20u;
    float _398;
    float _399;
    float _400;
    float3 _401;
    float3 _402;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _350)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _368 = ((_234.xy / float2(_234.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _372 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _368, level(0.0));
        float4 _375 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _368, level(0.0));
        float4 _378 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _368, level(0.0));
        float _388 = _378.w;
        _398 = (_348 * _388) + _378.z;
        _399 = (0.5 * _388) + _378.y;
        _400 = _378.x;
        _401 = (_343 * _372.w) + _372.xyz;
        _402 = normalize((_307 * _375.w) + ((_375.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _398 = _348;
        _399 = 0.5;
        _400 = 0.0;
        _401 = _343;
        _402 = _307;
    }
    bool _412 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _418;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _349 + 18u)].w > 0.0) && _412)
    {
        _418 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _418 = 1.0;
    }
    float _465;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _350)].z > 0.0)
    {
        float3 _433 = fast::clamp((_243 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _444 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_433.x), int(_433.y), int(_433.z), 0).xyz), 0));
        _465 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_444.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_433 / float3(_444.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _465 = _418;
    }
    float3 _479 = ((_401 - (_401 * _400)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _486 = (mix(float3(0.07999999821186065673828125 * _399), _401, float3(_400)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _489 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _494;
    if (_489)
    {
        _494 = _479 + (_486 * 0.449999988079071044921875);
    }
    else
    {
        _494 = _479;
    }
    float3 _496 = select(_486, float3(0.0), bool3(_489));
    float3 _498 = float3(dot(_496, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _584;
    if (_412)
    {
        float4 _534 = _174;
        _534.y = (-0.48860299587249755859375) * _402.y;
        float4 _537 = _534;
        _537.z = 0.48860299587249755859375 * _402.z;
        float4 _540 = _537;
        _540.w = (-0.48860299587249755859375) * _402.x;
        float3 _541 = _402 * _402;
        float4 _544 = _171;
        _544.x = (1.09254801273345947265625 * _402.x) * _402.y;
        float4 _547 = _544;
        _547.y = ((-1.09254801273345947265625) * _402.y) * _402.z;
        float4 _552 = _547;
        _552.z = 0.3153919875621795654296875 * ((3.0 * _541.z) - 1.0);
        float4 _555 = _552;
        _555.w = ((-1.09254801273345947265625) * _402.x) * _402.z;
        float4 _559 = _540;
        _559.x = 0.886227548122406005859375;
        float3 _561 = _559.yzw * 2.094395160675048828125;
        float4 _562 = float4(_559.x, _561.x, _561.y, _561.z);
        float4 _563 = _555 * 0.785398185253143310546875;
        float _564 = (_541.x - _541.y) * 0.4290426075458526611328125;
        float3 _570 = float3(0.0);
        _570.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _562) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _563)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _564);
        float3 _576 = _570;
        _576.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _562) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _563)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _564);
        float3 _582 = _576;
        _582.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _562) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _563)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _564);
        _584 = fast::max(float3(0.0), _582);
    }
    else
    {
        _584 = float3(0.0);
    }
    float _610;
    float _611;
    float3 _612;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _600;
        float _601;
        if (_412)
        {
            _600 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _601 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _600 = _402;
            _601 = 1.0;
        }
        float _602 = 1.0 - _601;
        float _604 = 1.0 - (_602 * _602);
        _610 = mix(fast::clamp(dot(_600, _402), 0.0, 1.0), 1.0, _604);
        _611 = _601;
        _612 = mix(_600, _402, float3(_604));
    }
    else
    {
        _610 = 1.0;
        _611 = 1.0;
        _612 = _402;
    }
    float4 _616 = float4(_612, 1.0);
    float3 _620 = _172;
    _620.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _616);
    float3 _624 = _620;
    _624.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _616);
    float3 _628 = _624;
    _628.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _616);
    float4 _631 = _616.xyzz * _616.yzzx;
    float3 _635 = _172;
    _635.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _631);
    float3 _639 = _635;
    _639.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _631);
    float3 _643 = _639;
    _643.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _631);
    float3 _658 = (_584 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_628 + _643) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_612.x * _612.x) - (_612.y * _612.y)))) * View.View_SkyLightColor.xyz) * (_611 * _610));
    float3 _680 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _709;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _708;
        if (any(abs(_243 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _349 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _349 + 19u)].xyz + float3(1.0))))
        {
            _708 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_243, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _708 = _680;
        }
        _709 = _708;
    }
    else
    {
        _709 = _680;
    }
    float4 _716 = float4(((mix(float3(0.0), _494 + (_496 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_658 * _494) * fast::max(float3(1.0), ((((((_401 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_401 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_401 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _709) * 1.0, 0.0);
    float4 _723;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _722 = _716;
        _722.w = 0.0;
        _723 = _722;
    }
    else
    {
        _723 = _716;
    }
    float2 _727 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _735 = (_402 * 0.5) + float3(0.5);
    float4 _737 = float4(_735.x, _735.y, _735.z, float4(0.0).w);
    _737.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _350)].y;
    float4 _738 = float4(0.0);
    _738.x = _400;
    float4 _739 = _738;
    _739.y = _399;
    float4 _740 = _739;
    _740.z = _398;
    float4 _741 = _740;
    _741.w = 0.50588238239288330078125;
    float4 _753 = float4(_401.x, _401.y, _401.z, float4(0.0).w);
    _753.w = ((log2(((dot(_658, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_498 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_498 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_498 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_727.xyx * _727.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _723 * View.View_PreExposure;
    out.out_var_SV_Target1 = _737;
    out.out_var_SV_Target2 = _741;
    out.out_var_SV_Target3 = _753;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_465, 1.0, 1.0, 1.0);
    return out;
}

