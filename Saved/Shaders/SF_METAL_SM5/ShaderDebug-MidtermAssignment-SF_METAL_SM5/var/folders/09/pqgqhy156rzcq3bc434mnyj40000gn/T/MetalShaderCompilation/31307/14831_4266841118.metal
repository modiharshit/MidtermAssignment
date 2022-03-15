

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
    char _m11_pad[36];
    float View_GameTime;
    char _m12_pad[8];
    float View_MaterialTextureMipBias;
    char _m13_pad[28];
    float View_UnlitViewmodeMask;
    char _m14_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m15_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m16_pad[48];
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
    spvUnsafeArray<float4, 6> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float3 _149 = {};
constant float _150 = {};

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

fragment MainPS_out Main_000039ef_fe52d41e(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> Material_Texture2D_0 [[texture(4)]], texture2d<float> Material_Texture2D_1 [[texture(5)]], texture2d<float> Material_Texture2D_2 [[texture(6)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float3x3 _194 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _205 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _150, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _210 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _214 = _210.xyz / float3(_210.w);
    float3 _215 = _214 - View.View_PreViewTranslation;
    float4 _224 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _230 = ((normalize(-_214) * _194).xy * ((0.0500000007450580596923828125 * _224.z) + (-0.02500000037252902984619140625))) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _234 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _230, bias(View.View_MaterialTextureMipBias));
    float2 _237 = (_234.xy * float2(2.0)) - float2(1.0);
    float3 _253 = normalize(_194 * normalize((float4(_237, sqrt(fast::clamp(1.0 - dot(_237, _237), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _255 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _230, bias(View.View_MaterialTextureMipBias));
    float _268 = _255.y;
    float4 _280 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _288 = fast::clamp(float3(mix(0.25, 0.4000000059604644775390625, _280.x) * 0.25), float3(0.0), float3(1.0));
    float _293 = (fast::clamp(fast::min(fast::max(0.25 + _268, 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _294 = in.in_var_PRIMITIVE_ID * 36u;
    uint _295 = _294 + 20u;
    float _343;
    float _344;
    float _345;
    float3 _346;
    float3 _347;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _295)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _313 = ((_205.xy / float2(_205.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _317 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _313, level(0.0));
        float4 _320 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _313, level(0.0));
        float4 _323 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _313, level(0.0));
        float _333 = _323.w;
        _343 = (_293 * _333) + _323.z;
        _344 = (0.5 * _333) + _323.y;
        _345 = _323.x;
        _346 = (_288 * _317.w) + _317.xyz;
        _347 = normalize((_253 * _320.w) + ((_320.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _343 = _293;
        _344 = 0.5;
        _345 = 0.0;
        _346 = _288;
        _347 = _253;
    }
    float3 _362 = ((_346 - (_346 * _345)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _369 = (mix(float3(0.07999999821186065673828125 * _344), _346, float3(_345)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _372 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _377;
    if (_372)
    {
        _377 = _362 + (_369 * 0.449999988079071044921875);
    }
    else
    {
        _377 = _362;
    }
    float3 _379 = select(_369, float3(0.0), bool3(_372));
    float3 _381 = float3(dot(_379, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _396 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _401 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _396);
    float4 _403 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_396 + float2(0.0, 0.5)));
    uint _405 = in.in_var_LIGHTMAP_ID * 15u;
    float3 _415 = (_401.xyz * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _405 + 4u)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _405 + 6u)].xyz;
    float _416 = dot(_415, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float _435 = (exp2((_416 * 16.0) - 8.0) - 0.00390625) * fast::max(0.0, dot((_403 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _405 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _405 + 7u)], float4(_347.yzx, 1.0)));
    float4 _446 = float4(_347, 1.0);
    float3 _450 = _149;
    _450.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _446);
    float3 _454 = _450;
    _454.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _446);
    float3 _458 = _454;
    _458.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _446);
    float4 _461 = _446.xyzz * _446.yzzx;
    float3 _465 = _149;
    _465.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _461);
    float3 _469 = _465;
    _469.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _461);
    float3 _473 = _469;
    _473.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _461);
    float3 _487 = (float4(_415 * (_435 / _416), _435).xyz * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_458 + _473) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_347.x * _347.x) - (_347.y * _347.y)))) * View.View_SkyLightColor.xyz) * 1.0);
    float3 _509 = fast::max(mix(mix(Material.Material_VectorExpressions[3].xyz, Material.Material_VectorExpressions[4].xyz, float3(sin(View.View_GameTime * 1.57079637050628662109375))) * _268, Material.Material_VectorExpressions[5].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _538;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _537;
        if (any(abs(_215 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _294 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _294 + 19u)].xyz + float3(1.0))))
        {
            _537 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_215, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _537 = _509;
        }
        _538 = _537;
    }
    else
    {
        _538 = _509;
    }
    float4 _545 = float4(((mix(float3(0.0), _377 + (_379 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_487 * _377) * fast::max(float3(1.0), ((((((_346 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_346 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_346 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _538) * 1.0, 0.0);
    float4 _552;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _551 = _545;
        _551.w = 0.0;
        _552 = _551;
    }
    else
    {
        _552 = _545;
    }
    float2 _556 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _564 = (_347 * 0.5) + float3(0.5);
    float4 _566 = float4(_564.x, _564.y, _564.z, float4(0.0).w);
    _566.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _295)].y;
    float4 _567 = float4(0.0);
    _567.x = _345;
    float4 _568 = _567;
    _568.y = _344;
    float4 _569 = _568;
    _569.z = _343;
    float4 _570 = _569;
    _570.w = 0.75686275959014892578125;
    float4 _582 = float4(_346.x, _346.y, _346.z, float4(0.0).w);
    _582.w = ((log2(((dot(_487, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_381 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_381 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_381 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_556.xyx * _556.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _552 * View.View_PreExposure;
    out.out_var_SV_Target1 = _566;
    out.out_var_SV_Target2 = _570;
    out.out_var_SV_Target3 = _582;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

