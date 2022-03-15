

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

constant float3 _153 = {};

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

fragment MainPS_out Main_00004089_315fe51c(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _209 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _213 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _218 = (_213.xyz / float3(_213.w)) - View.View_PreViewTranslation;
    float4 _226 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _229 = (_226.xy * float2(2.0)) - float2(1.0);
    float3 _246 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize(((float4(_229, sqrt(fast::clamp(1.0 - dot(_229, _229), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _258 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 20.0), bias(View.View_MaterialTextureMipBias));
    float _260 = mix(0.4000000059604644775390625, 1.0, _258.x);
    float4 _264 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _289;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _289 = _209.w;
                break;
            }
            else
            {
                float _273 = _209.z;
                _289 = ((_273 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_273 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _293 = fast::min(fast::max((_289 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _294 = _264.y;
    float4 _298 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _300 = _298.y;
    float3 _313 = fast::clamp(float3(mix(_260, 1.0 - _260, mix(_294, 1.0, _293)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_300 + mix(_294, 0.0, _293), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _318 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _300) + mix(mix(0.699999988079071044921875, 1.0, _294), 1.0, _293), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _319 = in.in_var_PRIMITIVE_ID * 36u;
    uint _320 = _319 + 20u;
    float _368;
    float _369;
    float _370;
    float3 _371;
    float3 _372;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _320)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _338 = ((_209.xy / float2(_209.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _342 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _338, level(0.0));
        float4 _345 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _338, level(0.0));
        float4 _348 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _338, level(0.0));
        float _358 = _348.w;
        _368 = (_318 * _358) + _348.z;
        _369 = (0.5 * _358) + _348.y;
        _370 = _348.x;
        _371 = (_313 * _342.w) + _342.xyz;
        _372 = normalize((_246 * _345.w) + ((_345.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _368 = _318;
        _369 = 0.5;
        _370 = 0.0;
        _371 = _313;
        _372 = _246;
    }
    float3 _387 = ((_371 - (_371 * _370)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _394 = (mix(float3(0.07999999821186065673828125 * _369), _371, float3(_370)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _397 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _402;
    if (_397)
    {
        _402 = _387 + (_394 * 0.449999988079071044921875);
    }
    else
    {
        _402 = _387;
    }
    float3 _404 = select(_394, float3(0.0), bool3(_397));
    float3 _406 = float3(dot(_404, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _421 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _426 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _421);
    float4 _428 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_421 + float2(0.0, 0.5)));
    uint _434 = in.in_var_LIGHTMAP_ID * 15u;
    uint _435 = _434 + 4u;
    uint _440 = _434 + 6u;
    float3 _445 = _426.xyz;
    float _497;
    float _498;
    float3 _499;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _481 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _485 = _481.w;
        float _486 = _485 * _485;
        float3 _488 = normalize(((_481.xyz * 2.0) - float3(1.0)).xyz);
        float _489 = 1.0 - _486;
        float _491 = 1.0 - (_489 * _489);
        _497 = mix(fast::clamp(dot(_488, _372), 0.0, 1.0), 1.0, _491);
        _498 = _486;
        _499 = mix(_488, _372, float3(_491));
    }
    else
    {
        _497 = 1.0;
        _498 = 1.0;
        _499 = _372;
    }
    float4 _503 = float4(_499, 1.0);
    float3 _507 = _153;
    _507.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _503);
    float3 _511 = _507;
    _511.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _503);
    float3 _515 = _511;
    _515.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _503);
    float4 _518 = _503.xyzz * _503.yzzx;
    float3 _522 = _153;
    _522.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _518);
    float3 _526 = _522;
    _526.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _518);
    float3 _530 = _526;
    _530.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _518);
    float3 _545 = (((((_445 * _445) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _435)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _440)].xyz) * ((exp2(((_426.w + ((_428.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _435)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _440)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_428 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _434 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _434 + 7u)], float4(_372.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_515 + _530) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_499.x * _499.x) - (_499.y * _499.y)))) * View.View_SkyLightColor.xyz) * (_498 * _497));
    float3 _567 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _596;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _595;
        if (any(abs(_218 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _319 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _319 + 19u)].xyz + float3(1.0))))
        {
            _595 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_218, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _595 = _567;
        }
        _596 = _595;
    }
    else
    {
        _596 = _567;
    }
    float4 _603 = float4(((mix(float3(0.0), _402 + (_404 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_545 * _402) * fast::max(float3(1.0), ((((((_371 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_371 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_371 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _596) * 1.0, 0.0);
    float4 _610;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _609 = _603;
        _609.w = 0.0;
        _610 = _609;
    }
    else
    {
        _610 = _603;
    }
    float2 _614 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _622 = (_372 * 0.5) + float3(0.5);
    float4 _624 = float4(_622.x, _622.y, _622.z, float4(0.0).w);
    _624.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _320)].y;
    float4 _625 = float4(0.0);
    _625.x = _370;
    float4 _626 = _625;
    _626.y = _369;
    float4 _627 = _626;
    _627.z = _368;
    float4 _628 = _627;
    _628.w = 0.75686275959014892578125;
    float4 _640 = float4(_371.x, _371.y, _371.z, float4(0.0).w);
    _640.w = ((log2(((dot(_545, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_406 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_406 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_406 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_614.xyx * _614.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _610 * View.View_PreExposure;
    out.out_var_SV_Target1 = _624;
    out.out_var_SV_Target2 = _628;
    out.out_var_SV_Target3 = _640;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

