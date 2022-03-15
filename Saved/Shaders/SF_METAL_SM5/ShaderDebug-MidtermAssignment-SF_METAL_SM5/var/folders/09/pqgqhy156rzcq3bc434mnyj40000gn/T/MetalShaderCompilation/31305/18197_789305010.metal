

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

constant float3 _161 = {};

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

fragment MainPS_out Main_00004715_2f0bd6b2(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], texture2d<float> LightmapResourceCluster_StaticShadowTexture [[texture(5)]], texture2d<float> Material_Texture2D_0 [[texture(6)]], texture2d<float> Material_Texture2D_1 [[texture(7)]], texture2d<float> Material_Texture2D_2 [[texture(8)]], texture2d<float> Material_Texture2D_3 [[texture(9)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _217 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _221 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _225 = _221.xyz / float3(_221.w);
    float3 _226 = _225 - View.View_PreViewTranslation;
    float4 _234 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _237 = (_234.xy * float2(2.0)) - float2(1.0);
    float4 _249 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _276;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _276 = _217.w;
                break;
            }
            else
            {
                float _260 = _217.z;
                _276 = ((_260 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_260 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _292 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(float4(_237, sqrt(fast::clamp(1.0 - dot(_237, _237), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _249.x) + _276) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _304 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _309 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _314 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _318 = (_304.x + 0.5) * ((_309.x + 0.5) * (_314.x + 0.5));
    float4 _322 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _324 = _322.xyz * _318;
    float _326 = _324.x;
    float _330 = _324.y;
    float _334 = _324.z;
    float _343 = fast::max(abs(1.0 - fast::max(0.0, dot(in.in_var_TEXCOORD11_centroid.xyz, normalize(-_225)))), 9.9999997473787516355514526367188e-05);
    float3 _352 = fast::clamp(mix(_324 * 0.5, float3((_326 <= 0.0) ? 0.0 : pow(_326, 0.4000000059604644775390625), (_330 <= 0.0) ? 0.0 : pow(_330, 0.4000000059604644775390625), (_334 <= 0.0) ? 0.0 : pow(_334, 0.4000000059604644775390625)), float3((_343 <= 0.0) ? 0.0 : pow(_343, 3.0))), float3(0.0), float3(1.0));
    float _357 = (fast::clamp(mix(0.89999997615814208984375, 0.5, _318 * _322.w), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _358 = in.in_var_PRIMITIVE_ID * 36u;
    uint _359 = _358 + 20u;
    float _407;
    float _408;
    float _409;
    float3 _410;
    float3 _411;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _359)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _377 = ((_217.xy / float2(_217.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _381 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _377, level(0.0));
        float4 _384 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _377, level(0.0));
        float4 _387 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _377, level(0.0));
        float _397 = _387.w;
        _407 = (_357 * _397) + _387.z;
        _408 = (0.5 * _397) + _387.y;
        _409 = _387.x;
        _410 = (_352 * _381.w) + _381.xyz;
        _411 = normalize((_292 * _384.w) + ((_384.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _407 = _357;
        _408 = 0.5;
        _409 = 0.0;
        _410 = _352;
        _411 = _292;
    }
    float4 _418 = LightmapResourceCluster_StaticShadowTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.zw);
    uint _419 = in.in_var_LIGHTMAP_ID * 15u;
    uint _420 = _419 + 1u;
    float4 _427 = fast::clamp((_418 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _420)]) + ((View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _420)] * (-0.5)) + float4(0.5)), float4(0.0), float4(1.0));
    float3 _444 = ((_410 - (_410 * _409)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _451 = (mix(float3(0.07999999821186065673828125 * _408), _410, float3(_409)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _454 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _459;
    if (_454)
    {
        _459 = _444 + (_451 * 0.449999988079071044921875);
    }
    else
    {
        _459 = _444;
    }
    float3 _461 = select(_451, float3(0.0), bool3(_454));
    float3 _463 = float3(dot(_461, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _478 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _482 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _478);
    float4 _484 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_478 + float2(0.0, 0.5)));
    uint _490 = _419 + 4u;
    uint _495 = _419 + 6u;
    float3 _500 = _482.xyz;
    float _552;
    float _553;
    float3 _554;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _536 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _540 = _536.w;
        float _541 = _540 * _540;
        float3 _543 = normalize(((_536.xyz * 2.0) - float3(1.0)).xyz);
        float _544 = 1.0 - _541;
        float _546 = 1.0 - (_544 * _544);
        _552 = mix(fast::clamp(dot(_543, _411), 0.0, 1.0), 1.0, _546);
        _553 = _541;
        _554 = mix(_543, _411, float3(_546));
    }
    else
    {
        _552 = 1.0;
        _553 = 1.0;
        _554 = _411;
    }
    float4 _558 = float4(_554, 1.0);
    float3 _562 = _161;
    _562.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _558);
    float3 _566 = _562;
    _566.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _558);
    float3 _570 = _566;
    _570.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _558);
    float4 _573 = _558.xyzz * _558.yzzx;
    float3 _577 = _161;
    _577.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _573);
    float3 _581 = _577;
    _581.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _573);
    float3 _585 = _581;
    _585.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _573);
    float3 _600 = (((((_500 * _500) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _490)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _495)].xyz) * ((exp2(((_482.w + ((_484.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _490)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _495)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_484 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _419 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _419 + 7u)], float4(_411.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_570 + _585) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_554.x * _554.x) - (_554.y * _554.y)))) * View.View_SkyLightColor.xyz) * (_553 * _552));
    float3 _622 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _651;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _650;
        if (any(abs(_226 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _358 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _358 + 19u)].xyz + float3(1.0))))
        {
            _650 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_226, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _650 = _622;
        }
        _651 = _650;
    }
    else
    {
        _651 = _622;
    }
    float4 _658 = float4(((mix(float3(0.0), _459 + (_461 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_600 * _459) * fast::max(float3(1.0), ((((((_410 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_410 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_410 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _651) * 1.0, 0.0);
    float4 _665;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _664 = _658;
        _664.w = 0.0;
        _665 = _664;
    }
    else
    {
        _665 = _658;
    }
    float2 _669 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _677 = (_411 * 0.5) + float3(0.5);
    float4 _679 = float4(_677.x, _677.y, _677.z, float4(0.0).w);
    _679.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _359)].y;
    float4 _680 = float4(0.0);
    _680.x = _409;
    float4 _681 = _680;
    _681.y = _408;
    float4 _682 = _681;
    _682.z = _407;
    float4 _683 = _682;
    _683.w = 0.50588238239288330078125;
    float4 _695 = float4(_410.x, _410.y, _410.z, float4(0.0).w);
    _695.w = ((log2(((dot(_600, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_463 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_463 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_463 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_669.xyx * _669.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _665 * View.View_PreExposure;
    out.out_var_SV_Target1 = _679;
    out.out_var_SV_Target2 = _683;
    out.out_var_SV_Target3 = _695;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = (View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _419)] * _427) * _427;
    return out;
}

