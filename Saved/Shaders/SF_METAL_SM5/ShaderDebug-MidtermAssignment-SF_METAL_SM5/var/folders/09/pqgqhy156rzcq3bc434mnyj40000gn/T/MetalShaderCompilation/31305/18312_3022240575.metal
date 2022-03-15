

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

constant float3 _156 = {};

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

fragment MainPS_out Main_00004788_b423bb3f(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    bool _304;
    float4 _213 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _217 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _222 = (_217.xyz / float3(_217.w)) - View.View_PreViewTranslation;
    float4 _234 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(View.View_GameTime * (-0.100000001490116119384765625), View.View_GameTime * (-0.0500000007450580596923828125)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y)), bias(View.View_MaterialTextureMipBias));
    float2 _237 = (_234.xy * float2(2.0)) - float2(1.0);
    float _246 = View.View_GameTime * 0.0500000007450580596923828125;
    float4 _251 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(View.View_GameTime * 0.039999999105930328369140625, _246) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5)), bias(View.View_MaterialTextureMipBias));
    float2 _254 = (_251.xy * float2(2.0)) - float2(1.0);
    float _266 = View.View_GameTime * (-0.02999999932944774627685546875);
    float4 _271 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(_266, _246) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.300000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float2 _274 = (_271.xy * float2(2.0)) - float2(1.0);
    float4 _286 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(_246, 0.0) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.25)), bias(View.View_MaterialTextureMipBias));
    float2 _289 = (_286.xy * float2(2.0)) - float2(1.0);
    float _324;
    switch (0u)
    {
        default:
        {
            _304 = View.View_ViewToClip[3u].w < 1.0;
            if (_304)
            {
                _324 = _213.w;
                break;
            }
            else
            {
                float _308 = _213.z;
                _324 = ((_308 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_308 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float4 _336 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(_266, View.View_GameTime * (-0.0089999996125698089599609375)) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float2 _339 = (_336.xy * float2(2.0)) - float2(1.0);
    float4 _352 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(View.View_GameTime * 0.02999999932944774627685546875, 0.0) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(0.07999999821186065673828125, 0.039999999105930328369140625))), bias(View.View_MaterialTextureMipBias));
    float2 _355 = (_352.xy * float2(2.0)) - float2(1.0);
    float _388;
    switch (0u)
    {
        default:
        {
            if (_304)
            {
                _388 = _213.w;
                break;
            }
            else
            {
                float _372 = _213.z;
                _388 = ((_372 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_372 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _402 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(mix(float4(_237, sqrt(fast::clamp(1.0 - dot(_237, _237), 0.0, 1.0)), 1.0).xyz + (float4(_254, sqrt(fast::clamp(1.0 - dot(_254, _254), 0.0, 1.0)), 1.0).xyz * float3(-1.0, -1.0, 1.0)), float4(_274, sqrt(fast::clamp(1.0 - dot(_274, _274), 0.0, 1.0)), 1.0).xyz + float4(_289, sqrt(fast::clamp(1.0 - dot(_289, _289), 0.0, 1.0)), 1.0).xyz, float3(fast::min(fast::max((_324 - 300.0) * 0.0011111111380159854888916015625, 0.0), 1.0))), float4(_339, sqrt(fast::clamp(1.0 - dot(_339, _339), 0.0, 1.0)), 1.0).xyz + (float4(_355, sqrt(fast::clamp(1.0 - dot(_355, _355), 0.0, 1.0)), 1.0).xyz * float3(-1.0, -1.0, 1.0)), float3(fast::min(fast::max((_388 - 500.0) * 0.0005000000237487256526947021484375, 0.0), 1.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _413 = fast::clamp(Material.Material_VectorExpressions[4].xyz, float3(0.0), float3(1.0));
    float _417 = (0.300000011920928955078125 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _418 = in.in_var_PRIMITIVE_ID * 36u;
    uint _419 = _418 + 20u;
    float _468;
    float _469;
    float _470;
    float3 _471;
    float3 _472;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _419)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _437 = ((_213.xy / float2(_213.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _441 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _437, level(0.0));
        float4 _444 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _437, level(0.0));
        float4 _447 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _437, level(0.0));
        float _457 = _447.w;
        _468 = (_417 * _457) + _447.z;
        _469 = (0.5 * _457) + _447.y;
        _470 = _457 + _447.x;
        _471 = (_413 * _441.w) + _441.xyz;
        _472 = normalize((_402 * _444.w) + ((_444.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _468 = _417;
        _469 = 0.5;
        _470 = 1.0;
        _471 = _413;
        _472 = _402;
    }
    float3 _487 = ((_471 - (_471 * _470)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _494 = (mix(float3(0.07999999821186065673828125 * _469), _471, float3(_470)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _497 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _502;
    if (_497)
    {
        _502 = _487 + (_494 * 0.449999988079071044921875);
    }
    else
    {
        _502 = _487;
    }
    float3 _504 = select(_494, float3(0.0), bool3(_497));
    float3 _506 = float3(dot(_504, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _521 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _526 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _521);
    float4 _528 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_521 + float2(0.0, 0.5)));
    uint _534 = in.in_var_LIGHTMAP_ID * 15u;
    uint _535 = _534 + 4u;
    uint _540 = _534 + 6u;
    float3 _545 = _526.xyz;
    float _597;
    float _598;
    float3 _599;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _581 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _585 = _581.w;
        float _586 = _585 * _585;
        float3 _588 = normalize(((_581.xyz * 2.0) - float3(1.0)).xyz);
        float _589 = 1.0 - _586;
        float _591 = 1.0 - (_589 * _589);
        _597 = mix(fast::clamp(dot(_588, _472), 0.0, 1.0), 1.0, _591);
        _598 = _586;
        _599 = mix(_588, _472, float3(_591));
    }
    else
    {
        _597 = 1.0;
        _598 = 1.0;
        _599 = _472;
    }
    float4 _603 = float4(_599, 1.0);
    float3 _607 = _156;
    _607.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _603);
    float3 _611 = _607;
    _611.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _603);
    float3 _615 = _611;
    _615.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _603);
    float4 _618 = _603.xyzz * _603.yzzx;
    float3 _622 = _156;
    _622.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _618);
    float3 _626 = _622;
    _626.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _618);
    float3 _630 = _626;
    _630.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _618);
    float3 _645 = (((((_545 * _545) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _535)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _540)].xyz) * ((exp2(((_526.w + ((_528.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _535)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _540)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_528 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _534 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _534 + 7u)], float4(_472.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_615 + _630) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_599.x * _599.x) - (_599.y * _599.y)))) * View.View_SkyLightColor.xyz) * (_598 * _597));
    float3 _667 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _696;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _695;
        if (any(abs(_222 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _418 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _418 + 19u)].xyz + float3(1.0))))
        {
            _695 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_222, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _695 = _667;
        }
        _696 = _695;
    }
    else
    {
        _696 = _667;
    }
    float4 _703 = float4(((mix(float3(0.0), _502 + (_504 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_645 * _502) * fast::max(float3(1.0), ((((((_471 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_471 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_471 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _696) * 1.0, 0.0);
    float4 _710;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _709 = _703;
        _709.w = 0.0;
        _710 = _709;
    }
    else
    {
        _710 = _703;
    }
    float2 _714 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _722 = (_472 * 0.5) + float3(0.5);
    float4 _724 = float4(_722.x, _722.y, _722.z, float4(0.0).w);
    _724.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _419)].y;
    float4 _725 = float4(0.0);
    _725.x = _470;
    float4 _726 = _725;
    _726.y = _469;
    float4 _727 = _726;
    _727.z = _468;
    float4 _728 = _727;
    _728.w = 0.75686275959014892578125;
    float4 _740 = float4(_471.x, _471.y, _471.z, float4(0.0).w);
    _740.w = ((log2(((dot(_645, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_506 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_506 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_506 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_714.xyx * _714.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _710 * View.View_PreExposure;
    out.out_var_SV_Target1 = _724;
    out.out_var_SV_Target2 = _728;
    out.out_var_SV_Target3 = _740;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

