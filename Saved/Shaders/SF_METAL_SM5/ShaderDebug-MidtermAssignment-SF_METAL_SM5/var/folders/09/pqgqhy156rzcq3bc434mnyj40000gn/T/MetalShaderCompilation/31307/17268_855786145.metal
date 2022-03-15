

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
    char _m17_pad[188];
    float View_ShowDecalsMask;
    char _m18_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m19_pad[48];
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
    char _m0_pad[80];
    float IndirectLightingCache_DirectionalLightShadowing;
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients0;
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients1;
    float4 IndirectLightingCache_IndirectLightingSHCoefficients2;
};

struct type_Material
{
    spvUnsafeArray<float4, 6> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _173 = {};
constant float4 _175 = {};

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

fragment MainPS_out Main_00004374_330242a1(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _231 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _235 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _240 = (_235.xyz / float3(_235.w)) - View.View_PreViewTranslation;
    float4 _247 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 10.0), bias(View.View_MaterialTextureMipBias));
    float2 _250 = (_247.xy * float2(2.0)) - float2(1.0);
    float4 _263 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _266 = (_263.xy * float2(2.0)) - float2(1.0);
    float _300;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _300 = _231.w;
                break;
            }
            else
            {
                float _284 = _231.z;
                _300 = ((_284 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_284 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _304 = fast::min(fast::max((_300 - 24.0) * 0.00022222222469281405210494995117188, 0.0), 1.0);
    float3 _315 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((((float4(_250, sqrt(fast::clamp(1.0 - dot(_250, _250), 0.0, 1.0)), 1.0).xyz * float3(0.5, 0.5, 1.0)) + mix(float4(_266, sqrt(fast::clamp(1.0 - dot(_266, _266), 0.0, 1.0)), 1.0).xyz * float3(0.25, 0.25, 1.0), float3(0.0, 0.0, 1.0), float3(_304))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _327 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 5.0), bias(View.View_MaterialTextureMipBias));
    float _329 = mix(0.4000000059604644775390625, 1.0, _327.x);
    float _332 = mix(0.699999988079071044921875, 0.89999997615814208984375, _327.y);
    float4 _337 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _352 = fast::clamp(mix(Material.Material_VectorExpressions[4].xyz, Material.Material_VectorExpressions[5].xyz, float3(fast::min(fast::max(_337.y + _304, 0.0), 1.0))) * mix(_329, 1.0 - _329, _332), float3(0.0), float3(1.0));
    float _357 = (fast::clamp(_329 * _332, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _358 = in.in_var_PRIMITIVE_ID * 36u;
    uint _359 = _358 + 20u;
    float _407;
    float _408;
    float _409;
    float3 _410;
    float3 _411;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _359)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _377 = ((_231.xy / float2(_231.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _381 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _377, level(0.0));
        float4 _384 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _377, level(0.0));
        float4 _387 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _377, level(0.0));
        float _397 = _387.w;
        _407 = (_357 * _397) + _387.z;
        _408 = (0.5 * _397) + _387.y;
        _409 = _387.x;
        _410 = (_352 * _381.w) + _381.xyz;
        _411 = normalize((_315 * _384.w) + ((_384.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _407 = _357;
        _408 = 0.5;
        _409 = 0.0;
        _410 = _352;
        _411 = _315;
    }
    bool _421 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _427;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _358 + 18u)].w > 0.0) && _421)
    {
        _427 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _427 = 1.0;
    }
    float _474;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _359)].z > 0.0)
    {
        float3 _442 = fast::clamp((_240 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _453 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_442.x), int(_442.y), int(_442.z), 0).xyz), 0));
        _474 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_453.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_442 / float3(_453.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _474 = _427;
    }
    float3 _488 = ((_410 - (_410 * _409)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _495 = (mix(float3(0.07999999821186065673828125 * _408), _410, float3(_409)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _498 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _503;
    if (_498)
    {
        _503 = _488 + (_495 * 0.449999988079071044921875);
    }
    else
    {
        _503 = _488;
    }
    float3 _505 = select(_495, float3(0.0), bool3(_498));
    float3 _507 = float3(dot(_505, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _593;
    if (_421)
    {
        float4 _543 = _175;
        _543.y = (-0.48860299587249755859375) * _411.y;
        float4 _546 = _543;
        _546.z = 0.48860299587249755859375 * _411.z;
        float4 _549 = _546;
        _549.w = (-0.48860299587249755859375) * _411.x;
        float3 _550 = _411 * _411;
        float4 _553 = _173;
        _553.x = (1.09254801273345947265625 * _411.x) * _411.y;
        float4 _556 = _553;
        _556.y = ((-1.09254801273345947265625) * _411.y) * _411.z;
        float4 _561 = _556;
        _561.z = 0.3153919875621795654296875 * ((3.0 * _550.z) - 1.0);
        float4 _564 = _561;
        _564.w = ((-1.09254801273345947265625) * _411.x) * _411.z;
        float4 _568 = _549;
        _568.x = 0.886227548122406005859375;
        float3 _570 = _568.yzw * 2.094395160675048828125;
        float4 _571 = float4(_568.x, _570.x, _570.y, _570.z);
        float4 _572 = _564 * 0.785398185253143310546875;
        float _573 = (_550.x - _550.y) * 0.4290426075458526611328125;
        float3 _579 = float3(0.0);
        _579.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _571) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _572)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _573);
        float3 _585 = _579;
        _585.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _571) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _572)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _573);
        float3 _591 = _585;
        _591.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _571) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _572)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _573);
        _593 = fast::max(float3(0.0), _591);
    }
    else
    {
        _593 = float3(0.0);
    }
    float3 _596 = _593 * View.View_IndirectLightingColorScale;
    float3 _618 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _647;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _646;
        if (any(abs(_240 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _358 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _358 + 19u)].xyz + float3(1.0))))
        {
            _646 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_240, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _646 = _618;
        }
        _647 = _646;
    }
    else
    {
        _647 = _618;
    }
    float4 _654 = float4(((mix(float3(0.0), _503 + (_505 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_596 * _503) * fast::max(float3(1.0), ((((((_410 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_410 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_410 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _647) * 1.0, 0.0);
    float4 _661;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _660 = _654;
        _660.w = 0.0;
        _661 = _660;
    }
    else
    {
        _661 = _654;
    }
    float2 _665 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _673 = (_411 * 0.5) + float3(0.5);
    float4 _675 = float4(_673.x, _673.y, _673.z, float4(0.0).w);
    _675.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _359)].y;
    float4 _676 = float4(0.0);
    _676.x = _409;
    float4 _677 = _676;
    _677.y = _408;
    float4 _678 = _677;
    _678.z = _407;
    float4 _679 = _678;
    _679.w = 0.50588238239288330078125;
    float4 _691 = float4(_410.x, _410.y, _410.z, float4(0.0).w);
    _691.w = ((log2(((dot(_596, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_507 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_507 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_507 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_665.xyx * _665.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _661 * View.View_PreExposure;
    out.out_var_SV_Target1 = _675;
    out.out_var_SV_Target2 = _679;
    out.out_var_SV_Target3 = _691;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_474, 1.0, 1.0, 1.0);
    return out;
}

