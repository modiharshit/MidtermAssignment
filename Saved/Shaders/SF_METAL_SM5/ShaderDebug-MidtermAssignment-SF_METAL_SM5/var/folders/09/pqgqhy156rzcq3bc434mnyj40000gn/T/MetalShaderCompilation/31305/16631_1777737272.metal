

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
    char _m17_pad[48];
    float4 View_SkyLightColor;
    char _m18_pad[124];
    float View_ShowDecalsMask;
    char _m19_pad[184];
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

fragment MainPS_out Main_000040f7_69f61e38(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> Material_Texture2D_0 [[texture(4)]], texture2d<float> Material_Texture2D_1 [[texture(5)]], texture2d<float> Material_Texture2D_2 [[texture(6)]], texture2d<float> Material_Texture2D_3 [[texture(7)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _214 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _218 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _223 = (_218.xyz / float3(_218.w)) - View.View_PreViewTranslation;
    float2 _224 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.25;
    float4 _230 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _224, bias(View.View_MaterialTextureMipBias));
    float2 _233 = (_230.xy * float2(2.0)) - float2(1.0);
    float2 _241 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.3499999940395355224609375;
    float4 _243 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _241, bias(View.View_MaterialTextureMipBias));
    float2 _246 = (_243.xy * float2(2.0)) - float2(1.0);
    float4 _258 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _263 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _268 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _272 = (_258.x + 0.5) * ((_263.x + 0.5) * (_268.x + 0.5));
    float _275 = fast::min(fast::max(mix(-2.0, 0.699999988079071044921875, _272), 0.0), 1.0);
    float3 _278 = float3(_275);
    float4 _284 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _311;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _311 = _214.w;
                break;
            }
            else
            {
                float _295 = _214.z;
                _311 = ((_295 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_295 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _326 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(mix(float4(_233, sqrt(fast::clamp(1.0 - dot(_233, _233), 0.0, 1.0)), 1.0).xyz, float4(_246, sqrt(fast::clamp(1.0 - dot(_246, _246), 0.0, 1.0)), 1.0).xyz, _278), float3(0.0, 0.0, 1.0), float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _284.x) + _311) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _339 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _224, bias(View.View_MaterialTextureMipBias));
    float4 _341 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _241, bias(View.View_MaterialTextureMipBias));
    float3 _351 = fast::clamp(mix(float3(0.6349999904632568359375), float3(1.0), float3(_272)) * mix(_339.xyz, _341.xyz, _278), float3(0.0), float3(1.0));
    float _356 = (fast::clamp(mix(0.800000011920928955078125, 0.300000011920928955078125, _272 * mix(_339.w, _341.w, _275)), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _357 = in.in_var_PRIMITIVE_ID * 36u;
    uint _358 = _357 + 20u;
    float _406;
    float _407;
    float _408;
    float3 _409;
    float3 _410;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _358)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _376 = ((_214.xy / float2(_214.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _380 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _376, level(0.0));
        float4 _383 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _376, level(0.0));
        float4 _386 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _376, level(0.0));
        float _396 = _386.w;
        _406 = (_356 * _396) + _386.z;
        _407 = (0.5 * _396) + _386.y;
        _408 = _386.x;
        _409 = (_351 * _380.w) + _380.xyz;
        _410 = normalize((_326 * _383.w) + ((_383.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _406 = _356;
        _407 = 0.5;
        _408 = 0.0;
        _409 = _351;
        _410 = _326;
    }
    float3 _425 = ((_409 - (_409 * _408)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _432 = (mix(float3(0.07999999821186065673828125 * _407), _409, float3(_408)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _435 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _440;
    if (_435)
    {
        _440 = _425 + (_432 * 0.449999988079071044921875);
    }
    else
    {
        _440 = _425;
    }
    float3 _442 = select(_432, float3(0.0), bool3(_435));
    float3 _444 = float3(dot(_442, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _459 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _464 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _459);
    float4 _466 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_459 + float2(0.0, 0.5)));
    uint _468 = in.in_var_LIGHTMAP_ID * 15u;
    float3 _478 = (_464.xyz * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _468 + 4u)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _468 + 6u)].xyz;
    float _479 = dot(_478, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float _498 = (exp2((_479 * 16.0) - 8.0) - 0.00390625) * fast::max(0.0, dot((_466 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _468 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _468 + 7u)], float4(_410.yzx, 1.0)));
    float4 _509 = float4(_410, 1.0);
    float3 _513 = _158;
    _513.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _509);
    float3 _517 = _513;
    _517.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _509);
    float3 _521 = _517;
    _521.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _509);
    float4 _524 = _509.xyzz * _509.yzzx;
    float3 _528 = _158;
    _528.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _524);
    float3 _532 = _528;
    _532.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _524);
    float3 _536 = _532;
    _536.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _524);
    float3 _550 = (float4(_478 * (_498 / _479), _498).xyz * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_521 + _536) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_410.x * _410.x) - (_410.y * _410.y)))) * View.View_SkyLightColor.xyz) * 1.0);
    float3 _572 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _601;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _600;
        if (any(abs(_223 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _357 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _357 + 19u)].xyz + float3(1.0))))
        {
            _600 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_223, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _600 = _572;
        }
        _601 = _600;
    }
    else
    {
        _601 = _572;
    }
    float4 _608 = float4(((mix(float3(0.0), _440 + (_442 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_550 * _440) * fast::max(float3(1.0), ((((((_409 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_409 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_409 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _601) * 1.0, 0.0);
    float4 _615;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _614 = _608;
        _614.w = 0.0;
        _615 = _614;
    }
    else
    {
        _615 = _608;
    }
    float2 _619 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _627 = (_410 * 0.5) + float3(0.5);
    float4 _629 = float4(_627.x, _627.y, _627.z, float4(0.0).w);
    _629.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _358)].y;
    float4 _630 = float4(0.0);
    _630.x = _408;
    float4 _631 = _630;
    _631.y = _407;
    float4 _632 = _631;
    _632.z = _406;
    float4 _633 = _632;
    _633.w = 0.75686275959014892578125;
    float4 _645 = float4(_409.x, _409.y, _409.z, float4(0.0).w);
    _645.w = ((log2(((dot(_550, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_444 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_444 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_444 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_619.xyx * _619.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _615 * View.View_PreExposure;
    out.out_var_SV_Target1 = _629;
    out.out_var_SV_Target2 = _633;
    out.out_var_SV_Target3 = _645;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

