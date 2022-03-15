

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

constant float3 _163 = {};

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

fragment MainPS_out Main_000047da_a780e5b8(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], texture2d<float> LightmapResourceCluster_StaticShadowTexture [[texture(5)]], texture2d<float> Material_Texture2D_0 [[texture(6)]], texture2d<float> Material_Texture2D_1 [[texture(7)]], texture2d<float> Material_Texture2D_2 [[texture(8)]], texture2d<float> Material_Texture2D_3 [[texture(9)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _219 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _223 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _228 = (_223.xyz / float3(_223.w)) - View.View_PreViewTranslation;
    float2 _229 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.25;
    float4 _235 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _229, bias(View.View_MaterialTextureMipBias));
    float2 _238 = (_235.xy * float2(2.0)) - float2(1.0);
    float2 _246 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.3499999940395355224609375;
    float4 _248 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _246, bias(View.View_MaterialTextureMipBias));
    float2 _251 = (_248.xy * float2(2.0)) - float2(1.0);
    float4 _263 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _268 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _273 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _277 = (_263.x + 0.5) * ((_268.x + 0.5) * (_273.x + 0.5));
    float _280 = fast::min(fast::max(mix(-2.0, 0.699999988079071044921875, _277), 0.0), 1.0);
    float3 _283 = float3(_280);
    float4 _289 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _316;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _316 = _219.w;
                break;
            }
            else
            {
                float _300 = _219.z;
                _316 = ((_300 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_300 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _331 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(mix(float4(_238, sqrt(fast::clamp(1.0 - dot(_238, _238), 0.0, 1.0)), 1.0).xyz, float4(_251, sqrt(fast::clamp(1.0 - dot(_251, _251), 0.0, 1.0)), 1.0).xyz, _283), float3(0.0, 0.0, 1.0), float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _289.x) + _316) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _344 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _229, bias(View.View_MaterialTextureMipBias));
    float4 _346 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _246, bias(View.View_MaterialTextureMipBias));
    float3 _356 = fast::clamp(mix(float3(0.6349999904632568359375), float3(1.0), float3(_277)) * mix(_344.xyz, _346.xyz, _283), float3(0.0), float3(1.0));
    float _361 = (fast::clamp(mix(0.800000011920928955078125, 0.300000011920928955078125, _277 * mix(_344.w, _346.w, _280)), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _362 = in.in_var_PRIMITIVE_ID * 36u;
    uint _363 = _362 + 20u;
    float _411;
    float _412;
    float _413;
    float3 _414;
    float3 _415;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _363)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _381 = ((_219.xy / float2(_219.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _385 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _381, level(0.0));
        float4 _388 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _381, level(0.0));
        float4 _391 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _381, level(0.0));
        float _401 = _391.w;
        _411 = (_361 * _401) + _391.z;
        _412 = (0.5 * _401) + _391.y;
        _413 = _391.x;
        _414 = (_356 * _385.w) + _385.xyz;
        _415 = normalize((_331 * _388.w) + ((_388.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _411 = _361;
        _412 = 0.5;
        _413 = 0.0;
        _414 = _356;
        _415 = _331;
    }
    float4 _422 = LightmapResourceCluster_StaticShadowTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.zw);
    uint _423 = in.in_var_LIGHTMAP_ID * 15u;
    uint _424 = _423 + 1u;
    float4 _431 = fast::clamp((_422 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _424)]) + ((View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _424)] * (-0.5)) + float4(0.5)), float4(0.0), float4(1.0));
    float3 _448 = ((_414 - (_414 * _413)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _455 = (mix(float3(0.07999999821186065673828125 * _412), _414, float3(_413)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _458 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _463;
    if (_458)
    {
        _463 = _448 + (_455 * 0.449999988079071044921875);
    }
    else
    {
        _463 = _448;
    }
    float3 _465 = select(_455, float3(0.0), bool3(_458));
    float3 _467 = float3(dot(_465, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _482 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _486 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _482);
    float4 _488 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_482 + float2(0.0, 0.5)));
    uint _494 = _423 + 4u;
    uint _499 = _423 + 6u;
    float3 _504 = _486.xyz;
    float _556;
    float _557;
    float3 _558;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _540 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _544 = _540.w;
        float _545 = _544 * _544;
        float3 _547 = normalize(((_540.xyz * 2.0) - float3(1.0)).xyz);
        float _548 = 1.0 - _545;
        float _550 = 1.0 - (_548 * _548);
        _556 = mix(fast::clamp(dot(_547, _415), 0.0, 1.0), 1.0, _550);
        _557 = _545;
        _558 = mix(_547, _415, float3(_550));
    }
    else
    {
        _556 = 1.0;
        _557 = 1.0;
        _558 = _415;
    }
    float4 _562 = float4(_558, 1.0);
    float3 _566 = _163;
    _566.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _562);
    float3 _570 = _566;
    _570.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _562);
    float3 _574 = _570;
    _574.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _562);
    float4 _577 = _562.xyzz * _562.yzzx;
    float3 _581 = _163;
    _581.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _577);
    float3 _585 = _581;
    _585.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _577);
    float3 _589 = _585;
    _589.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _577);
    float3 _604 = (((((_504 * _504) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _494)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _499)].xyz) * ((exp2(((_486.w + ((_488.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _494)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _499)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_488 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _423 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _423 + 7u)], float4(_415.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_574 + _589) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_558.x * _558.x) - (_558.y * _558.y)))) * View.View_SkyLightColor.xyz) * (_557 * _556));
    float3 _626 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _655;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _654;
        if (any(abs(_228 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _362 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _362 + 19u)].xyz + float3(1.0))))
        {
            _654 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_228, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _654 = _626;
        }
        _655 = _654;
    }
    else
    {
        _655 = _626;
    }
    float4 _662 = float4(((mix(float3(0.0), _463 + (_465 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_604 * _463) * fast::max(float3(1.0), ((((((_414 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_414 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_414 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _655) * 1.0, 0.0);
    float4 _669;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _668 = _662;
        _668.w = 0.0;
        _669 = _668;
    }
    else
    {
        _669 = _662;
    }
    float2 _673 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _681 = (_415 * 0.5) + float3(0.5);
    float4 _683 = float4(_681.x, _681.y, _681.z, float4(0.0).w);
    _683.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _363)].y;
    float4 _684 = float4(0.0);
    _684.x = _413;
    float4 _685 = _684;
    _685.y = _412;
    float4 _686 = _685;
    _686.z = _411;
    float4 _687 = _686;
    _687.w = 0.50588238239288330078125;
    float4 _699 = float4(_414.x, _414.y, _414.z, float4(0.0).w);
    _699.w = ((log2(((dot(_604, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_467 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_467 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_467 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_673.xyx * _673.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _669 * View.View_PreExposure;
    out.out_var_SV_Target1 = _683;
    out.out_var_SV_Target2 = _687;
    out.out_var_SV_Target3 = _699;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = (View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _423)] * _431) * _431;
    return out;
}

