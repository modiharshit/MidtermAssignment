

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
    char _m13_pad[36];
    float View_GameTime;
    char _m14_pad[8];
    float View_MaterialTextureMipBias;
    char _m15_pad[28];
    float View_UnlitViewmodeMask;
    char _m16_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m17_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m18_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m20_pad[124];
    float View_ShowDecalsMask;
    char _m21_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_Material
{
    spvUnsafeArray<float4, 5> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float3 _160 = {};

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
    float4 in_var_TEXCOORD4 [[user(locn3)]];
    uint in_var_PRIMITIVE_ID [[user(locn4)]];
    uint in_var_LIGHTMAP_ID [[user(locn5)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00004a37_419cda69(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], texture2d<float> LightmapResourceCluster_StaticShadowTexture [[texture(5)]], texture2d<float> Material_Texture2D_0 [[texture(6)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    bool _308;
    float4 _217 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _221 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _226 = (_221.xyz / float3(_221.w)) - View.View_PreViewTranslation;
    float4 _238 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(View.View_GameTime * (-0.100000001490116119384765625), View.View_GameTime * (-0.0500000007450580596923828125)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y)), bias(View.View_MaterialTextureMipBias));
    float2 _241 = (_238.xy * float2(2.0)) - float2(1.0);
    float _250 = View.View_GameTime * 0.0500000007450580596923828125;
    float4 _255 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(View.View_GameTime * 0.039999999105930328369140625, _250) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5)), bias(View.View_MaterialTextureMipBias));
    float2 _258 = (_255.xy * float2(2.0)) - float2(1.0);
    float _270 = View.View_GameTime * (-0.02999999932944774627685546875);
    float4 _275 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(_270, _250) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.300000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float2 _278 = (_275.xy * float2(2.0)) - float2(1.0);
    float4 _290 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(_250, 0.0) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.25)), bias(View.View_MaterialTextureMipBias));
    float2 _293 = (_290.xy * float2(2.0)) - float2(1.0);
    float _328;
    switch (0u)
    {
        default:
        {
            _308 = View.View_ViewToClip[3u].w < 1.0;
            if (_308)
            {
                _328 = _217.w;
                break;
            }
            else
            {
                float _312 = _217.z;
                _328 = ((_312 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_312 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float4 _340 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(_270, View.View_GameTime * (-0.0089999996125698089599609375)) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float2 _343 = (_340.xy * float2(2.0)) - float2(1.0);
    float4 _356 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(View.View_GameTime * 0.02999999932944774627685546875, 0.0) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(0.07999999821186065673828125, 0.039999999105930328369140625))), bias(View.View_MaterialTextureMipBias));
    float2 _359 = (_356.xy * float2(2.0)) - float2(1.0);
    float _392;
    switch (0u)
    {
        default:
        {
            if (_308)
            {
                _392 = _217.w;
                break;
            }
            else
            {
                float _376 = _217.z;
                _392 = ((_376 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_376 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _406 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(mix(float4(_241, sqrt(fast::clamp(1.0 - dot(_241, _241), 0.0, 1.0)), 1.0).xyz + (float4(_258, sqrt(fast::clamp(1.0 - dot(_258, _258), 0.0, 1.0)), 1.0).xyz * float3(-1.0, -1.0, 1.0)), float4(_278, sqrt(fast::clamp(1.0 - dot(_278, _278), 0.0, 1.0)), 1.0).xyz + float4(_293, sqrt(fast::clamp(1.0 - dot(_293, _293), 0.0, 1.0)), 1.0).xyz, float3(fast::min(fast::max((_328 - 300.0) * 0.0011111111380159854888916015625, 0.0), 1.0))), float4(_343, sqrt(fast::clamp(1.0 - dot(_343, _343), 0.0, 1.0)), 1.0).xyz + (float4(_359, sqrt(fast::clamp(1.0 - dot(_359, _359), 0.0, 1.0)), 1.0).xyz * float3(-1.0, -1.0, 1.0)), float3(fast::min(fast::max((_392 - 500.0) * 0.0005000000237487256526947021484375, 0.0), 1.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _417 = fast::clamp(Material.Material_VectorExpressions[4].xyz, float3(0.0), float3(1.0));
    float _421 = (0.300000011920928955078125 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _422 = in.in_var_PRIMITIVE_ID * 36u;
    uint _423 = _422 + 20u;
    float _472;
    float _473;
    float _474;
    float3 _475;
    float3 _476;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _423)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _441 = ((_217.xy / float2(_217.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _445 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _441, level(0.0));
        float4 _448 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _441, level(0.0));
        float4 _451 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _441, level(0.0));
        float _461 = _451.w;
        _472 = (_421 * _461) + _451.z;
        _473 = (0.5 * _461) + _451.y;
        _474 = _461 + _451.x;
        _475 = (_417 * _445.w) + _445.xyz;
        _476 = normalize((_406 * _448.w) + ((_448.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _472 = _421;
        _473 = 0.5;
        _474 = 1.0;
        _475 = _417;
        _476 = _406;
    }
    float4 _483 = LightmapResourceCluster_StaticShadowTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.zw);
    uint _484 = in.in_var_LIGHTMAP_ID * 15u;
    uint _485 = _484 + 1u;
    float4 _492 = fast::clamp((_483 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _485)]) + ((View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _485)] * (-0.5)) + float4(0.5)), float4(0.0), float4(1.0));
    float3 _509 = ((_475 - (_475 * _474)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _516 = (mix(float3(0.07999999821186065673828125 * _473), _475, float3(_474)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _519 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _524;
    if (_519)
    {
        _524 = _509 + (_516 * 0.449999988079071044921875);
    }
    else
    {
        _524 = _509;
    }
    float3 _526 = select(_516, float3(0.0), bool3(_519));
    float3 _528 = float3(dot(_526, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _543 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _547 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _543);
    float4 _549 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_543 + float2(0.0, 0.5)));
    uint _555 = _484 + 4u;
    uint _560 = _484 + 6u;
    float3 _565 = _547.xyz;
    float _617;
    float _618;
    float3 _619;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _601 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _605 = _601.w;
        float _606 = _605 * _605;
        float3 _608 = normalize(((_601.xyz * 2.0) - float3(1.0)).xyz);
        float _609 = 1.0 - _606;
        float _611 = 1.0 - (_609 * _609);
        _617 = mix(fast::clamp(dot(_608, _476), 0.0, 1.0), 1.0, _611);
        _618 = _606;
        _619 = mix(_608, _476, float3(_611));
    }
    else
    {
        _617 = 1.0;
        _618 = 1.0;
        _619 = _476;
    }
    float4 _623 = float4(_619, 1.0);
    float3 _627 = _160;
    _627.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _623);
    float3 _631 = _627;
    _631.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _623);
    float3 _635 = _631;
    _635.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _623);
    float4 _638 = _623.xyzz * _623.yzzx;
    float3 _642 = _160;
    _642.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _638);
    float3 _646 = _642;
    _646.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _638);
    float3 _650 = _646;
    _650.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _638);
    float3 _665 = (((((_565 * _565) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _555)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _560)].xyz) * ((exp2(((_547.w + ((_549.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _555)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _560)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_549 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _484 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _484 + 7u)], float4(_476.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_635 + _650) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_619.x * _619.x) - (_619.y * _619.y)))) * View.View_SkyLightColor.xyz) * (_618 * _617));
    float3 _687 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _716;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _715;
        if (any(abs(_226 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _422 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _422 + 19u)].xyz + float3(1.0))))
        {
            _715 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_226, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _715 = _687;
        }
        _716 = _715;
    }
    else
    {
        _716 = _687;
    }
    float4 _723 = float4(((mix(float3(0.0), _524 + (_526 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_665 * _524) * fast::max(float3(1.0), ((((((_475 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_475 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_475 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _716) * 1.0, 0.0);
    float4 _730;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _729 = _723;
        _729.w = 0.0;
        _730 = _729;
    }
    else
    {
        _730 = _723;
    }
    float2 _734 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _742 = (_476 * 0.5) + float3(0.5);
    float4 _744 = float4(_742.x, _742.y, _742.z, float4(0.0).w);
    _744.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _423)].y;
    float4 _745 = float4(0.0);
    _745.x = _474;
    float4 _746 = _745;
    _746.y = _473;
    float4 _747 = _746;
    _747.z = _472;
    float4 _748 = _747;
    _748.w = 0.50588238239288330078125;
    float4 _760 = float4(_475.x, _475.y, _475.z, float4(0.0).w);
    _760.w = ((log2(((dot(_665, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_528 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_528 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_528 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_734.xyx * _734.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _730 * View.View_PreExposure;
    out.out_var_SV_Target1 = _744;
    out.out_var_SV_Target2 = _748;
    out.out_var_SV_Target3 = _760;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = (View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _484)] * _492) * _492;
    return out;
}

