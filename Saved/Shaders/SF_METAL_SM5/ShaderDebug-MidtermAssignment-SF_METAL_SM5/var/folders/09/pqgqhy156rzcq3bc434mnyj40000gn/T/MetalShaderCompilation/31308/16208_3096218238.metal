

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
    char _m11_pad[16];
    float View_OutOfBoundsMask;
    char _m12_pad[48];
    float View_MaterialTextureMipBias;
    char _m13_pad[28];
    float View_UnlitViewmodeMask;
    char _m14_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m15_pad[452];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m17_pad[124];
    float View_ShowDecalsMask;
    char _m18_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_Material
{
    spvUnsafeArray<float4, 8> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float3 _158 = {};

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

fragment MainPS_out Main_00003f50_b88c8a7e(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _211 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _215 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _220 = (_215.xyz / float3(_215.w)) - View.View_PreViewTranslation;
    float2 _221 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5;
    float4 _227 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _221, bias(View.View_MaterialTextureMipBias));
    float2 _230 = (_227.xy * float2(2.0)) - float2(1.0);
    float2 _238 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125;
    float4 _242 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _238, bias(View.View_MaterialTextureMipBias));
    float _269;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _269 = _211.w;
                break;
            }
            else
            {
                float _253 = _211.z;
                _269 = ((_253 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_253 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _276 = float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _242.x) + _269) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0));
    float3 _285 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(float4(_230, sqrt(fast::clamp(1.0 - dot(_230, _230), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), _276) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _296 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _221, bias(View.View_MaterialTextureMipBias));
    float4 _312 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.75) * 0.00999999977648258209228515625), bias(View.View_MaterialTextureMipBias));
    float3 _318 = mix(Material.Material_VectorExpressions[3].xyz * _296.y, _296.xyz * Material.Material_VectorExpressions[5].xyz, float3(fast::min(fast::max(mix(-0.25, 2.0, _312.x), 0.0), 1.0)));
    float4 _320 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _238, bias(View.View_MaterialTextureMipBias));
    float4 _328 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.004999999888241291046142578125), bias(View.View_MaterialTextureMipBias));
    float3 _333 = fast::clamp(mix(_318, mix(_318, mix(_320.xyz, Material.Material_VectorExpressions[7].xyz, float3(0.300000011920928955078125)), float3(_328.x)), _276), float3(0.0), float3(1.0));
    uint _334 = in.in_var_PRIMITIVE_ID * 36u;
    uint _335 = _334 + 20u;
    float _382;
    float _383;
    float _384;
    float3 _385;
    float3 _386;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _335)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _353 = ((_211.xy / float2(_211.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _357 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _353, level(0.0));
        float4 _360 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _353, level(0.0));
        float4 _363 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _353, level(0.0));
        float _373 = _363.w;
        _382 = _373 + _363.z;
        _383 = (0.5 * _373) + _363.y;
        _384 = _363.x;
        _385 = (_333 * _357.w) + _357.xyz;
        _386 = normalize((_285 * _360.w) + ((_360.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _382 = 1.0;
        _383 = 0.5;
        _384 = 0.0;
        _385 = _333;
        _386 = _285;
    }
    float3 _410 = (((_385 - (_385 * _384)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz) + (((mix(float3(0.07999999821186065673828125 * _383), _385, float3(_384)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz) * 0.449999988079071044921875);
    float2 _412 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _417 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _412);
    float4 _419 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_412 + float2(0.0, 0.5)));
    uint _425 = in.in_var_LIGHTMAP_ID * 15u;
    uint _426 = _425 + 4u;
    uint _431 = _425 + 6u;
    float3 _436 = _417.xyz;
    float _488;
    float _489;
    float3 _490;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _472 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _476 = _472.w;
        float _477 = _476 * _476;
        float3 _479 = normalize(((_472.xyz * 2.0) - float3(1.0)).xyz);
        float _480 = 1.0 - _477;
        float _482 = 1.0 - (_480 * _480);
        _488 = mix(fast::clamp(dot(_479, _386), 0.0, 1.0), 1.0, _482);
        _489 = _477;
        _490 = mix(_479, _386, float3(_482));
    }
    else
    {
        _488 = 1.0;
        _489 = 1.0;
        _490 = _386;
    }
    float4 _494 = float4(_490, 1.0);
    float3 _498 = _158;
    _498.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _494);
    float3 _502 = _498;
    _502.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _494);
    float3 _506 = _502;
    _506.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _494);
    float4 _509 = _494.xyzz * _494.yzzx;
    float3 _513 = _158;
    _513.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _509);
    float3 _517 = _513;
    _517.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _509);
    float3 _521 = _517;
    _521.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _509);
    float3 _536 = (((((_436 * _436) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _426)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _431)].xyz) * ((exp2(((_417.w + ((_419.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _426)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _431)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_419 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _425 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _425 + 7u)], float4(_386.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_506 + _521) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_490.x * _490.x) - (_490.y * _490.y)))) * View.View_SkyLightColor.xyz) * (_489 * _488));
    float3 _556 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _585;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _584;
        if (any(abs(_220 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _334 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _334 + 19u)].xyz + float3(1.0))))
        {
            _584 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_220, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _584 = _556;
        }
        _585 = _584;
    }
    else
    {
        _585 = _556;
    }
    float4 _592 = float4(((mix(float3(0.0), _410, float3(View.View_UnlitViewmodeMask)) + ((_536 * _410) * fast::max(float3(1.0), ((((((_385 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_385 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_385 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _585) * 1.0, 0.0);
    float4 _599;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _598 = _592;
        _598.w = 0.0;
        _599 = _598;
    }
    else
    {
        _599 = _592;
    }
    float2 _603 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _611 = (_386 * 0.5) + float3(0.5);
    float4 _613 = float4(_611.x, _611.y, _611.z, float4(0.0).w);
    _613.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _335)].y;
    float4 _614 = float4(0.0);
    _614.x = _384;
    float4 _615 = _614;
    _615.y = _383;
    float4 _616 = _615;
    _616.z = _382;
    float4 _617 = _616;
    _617.w = 0.75686275959014892578125;
    float4 _628 = float4(_385.x, _385.y, _385.z, float4(0.0).w);
    _628.w = ((log2((dot(_536, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_603.xyx * _603.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _599 * View.View_PreExposure;
    out.out_var_SV_Target1 = _613;
    out.out_var_SV_Target2 = _617;
    out.out_var_SV_Target3 = _628;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

