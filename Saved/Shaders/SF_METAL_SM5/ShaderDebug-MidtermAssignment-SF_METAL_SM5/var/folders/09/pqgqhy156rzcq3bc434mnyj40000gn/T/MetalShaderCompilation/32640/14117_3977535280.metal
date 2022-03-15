

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
    char _m0_pad[704];
    float4x4 View_SVPositionToTranslatedWorld;
    char _m1_pad[288];
    float4 View_ScreenPositionScaleBias;
    char _m2_pad[48];
    float3 View_PreViewTranslation;
    char _m3_pad[928];
    float4 View_ViewRectMin;
    float4 View_ViewSizeAndInvSize;
    char _m5_pad[68];
    float View_PreExposure;
    float4 View_DiffuseOverrideParameter;
    float4 View_SpecularOverrideParameter;
    float4 View_NormalOverrideParameter;
    float2 View_RoughnessOverrideParameter;
    char _m10_pad[8];
    float View_OutOfBoundsMask;
    char _m11_pad[48];
    float View_MaterialTextureMipBias;
    char _m12_pad[28];
    float View_UnlitViewmodeMask;
    char _m13_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m14_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m15_pad[48];
    float4 View_SkyLightColor;
    char _m16_pad[124];
    float View_ShowDecalsMask;
    char _m17_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_Material
{
    spvUnsafeArray<float4, 4> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float3 _141 = {};
constant float _142 = {};

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

fragment MainPS_out Main_00003725_ed145f30(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> Material_Texture2D_0 [[texture(4)]], texture2d<float> Material_Texture2D_1 [[texture(5)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _196 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _142, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _201 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _206 = (_201.xyz / float3(_201.w)) - View.View_PreViewTranslation;
    float4 _212 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _215 = (_212.xy * float2(2.0)) - float2(1.0);
    float3 _231 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_215, sqrt(fast::clamp(1.0 - dot(_215, _215), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _242 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _246 = _242.x;
    float3 _255 = fast::clamp(Material.Material_VectorExpressions[3].xyz * _246, float3(0.0), float3(1.0));
    float _256 = fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0);
    float _261 = (fast::clamp(mix(Material.Material_ScalarExpressions[0].z, Material.Material_ScalarExpressions[0].w, _246), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _262 = in.in_var_PRIMITIVE_ID * 36u;
    uint _263 = _262 + 20u;
    float _313;
    float _314;
    float _315;
    float3 _316;
    float3 _317;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _263)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _281 = ((_196.xy / float2(_196.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _285 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _281, level(0.0));
        float4 _288 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _281, level(0.0));
        float4 _291 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _281, level(0.0));
        float _301 = _291.w;
        _313 = (_261 * _301) + _291.z;
        _314 = (0.5 * _301) + _291.y;
        _315 = (_256 * _301) + _291.x;
        _316 = (_255 * _285.w) + _285.xyz;
        _317 = normalize((_231 * _288.w) + ((_288.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _313 = _261;
        _314 = 0.5;
        _315 = _256;
        _316 = _255;
        _317 = _231;
    }
    float3 _332 = ((_316 - (_316 * _315)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _339 = (mix(float3(0.07999999821186065673828125 * _314), _316, float3(_315)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _342 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _347;
    if (_342)
    {
        _347 = _332 + (_339 * 0.449999988079071044921875);
    }
    else
    {
        _347 = _332;
    }
    float3 _349 = select(_339, float3(0.0), bool3(_342));
    float3 _351 = float3(dot(_349, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _366 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _371 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _366);
    float4 _373 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_366 + float2(0.0, 0.5)));
    uint _375 = in.in_var_LIGHTMAP_ID * 15u;
    float3 _385 = (_371.xyz * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _375 + 4u)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _375 + 6u)].xyz;
    float _386 = dot(_385, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float _405 = (exp2((_386 * 16.0) - 8.0) - 0.00390625) * fast::max(0.0, dot((_373 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _375 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _375 + 7u)], float4(_317.yzx, 1.0)));
    float4 _416 = float4(_317, 1.0);
    float3 _420 = _141;
    _420.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _416);
    float3 _424 = _420;
    _424.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _416);
    float3 _428 = _424;
    _428.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _416);
    float4 _431 = _416.xyzz * _416.yzzx;
    float3 _435 = _141;
    _435.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _431);
    float3 _439 = _435;
    _439.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _431);
    float3 _443 = _439;
    _443.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _431);
    float3 _457 = (float4(_385 * (_405 / _386), _405).xyz * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_428 + _443) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_317.x * _317.x) - (_317.y * _317.y)))) * View.View_SkyLightColor.xyz) * 1.0);
    float3 _479 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _508;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _507;
        if (any(abs(_206 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _262 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _262 + 19u)].xyz + float3(1.0))))
        {
            _507 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_206, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _507 = _479;
        }
        _508 = _507;
    }
    else
    {
        _508 = _479;
    }
    float4 _515 = float4(((mix(float3(0.0), _347 + (_349 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_457 * _347) * fast::max(float3(1.0), ((((((_316 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_316 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_316 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _508) * 1.0, 0.0);
    float4 _522;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _521 = _515;
        _521.w = 0.0;
        _522 = _521;
    }
    else
    {
        _522 = _515;
    }
    float2 _526 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _534 = (_317 * 0.5) + float3(0.5);
    float4 _536 = float4(_534.x, _534.y, _534.z, float4(0.0).w);
    _536.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _263)].y;
    float4 _537 = float4(0.0);
    _537.x = _315;
    float4 _538 = _537;
    _538.y = _314;
    float4 _539 = _538;
    _539.z = _313;
    float4 _540 = _539;
    _540.w = 0.75686275959014892578125;
    float4 _552 = float4(_316.x, _316.y, _316.z, float4(0.0).w);
    _552.w = ((log2(((dot(_457, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_351 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_351 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_351 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_526.xyx * _526.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _522 * View.View_PreExposure;
    out.out_var_SV_Target1 = _536;
    out.out_var_SV_Target2 = _540;
    out.out_var_SV_Target3 = _552;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

