

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
    spvUnsafeArray<float4, 10> Material_VectorExpressions;
    spvUnsafeArray<float4, 2> Material_ScalarExpressions;
};

constant float3 _145 = {};
constant float _146 = {};

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

fragment MainPS_out Main_000038b0_7b20cd27(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> Material_Texture2D_0 [[texture(4)]], texture2d<float> Material_Texture2D_1 [[texture(5)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _199 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _146, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _204 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _209 = (_204.xyz / float3(_204.w)) - View.View_PreViewTranslation;
    float4 _215 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _218 = (_215.xy * float2(2.0)) - float2(1.0);
    float3 _234 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_218, sqrt(fast::clamp(1.0 - dot(_218, _218), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _238 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _242 = _238.z;
    float _265 = _238.y;
    float3 _286 = fast::clamp(mix(mix(Material.Material_VectorExpressions[6].xyz, Material.Material_VectorExpressions[7].xyz, float3(_242)), Material.Material_VectorExpressions[9].xyz, float3(_265)) * _238.x, float3(0.0), float3(1.0));
    float _287 = fast::clamp(mix(mix(Material.Material_ScalarExpressions[0].z, Material.Material_ScalarExpressions[0].w, _242), Material.Material_ScalarExpressions[1].x, _265), 0.0, 1.0);
    float _292 = (fast::clamp(mix(mix(Material.Material_ScalarExpressions[1].y, Material.Material_ScalarExpressions[1].z, _242), Material.Material_ScalarExpressions[1].w, _265), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _293 = in.in_var_PRIMITIVE_ID * 36u;
    uint _294 = _293 + 20u;
    float _344;
    float _345;
    float _346;
    float3 _347;
    float3 _348;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _294)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _312 = ((_199.xy / float2(_199.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _316 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _312, level(0.0));
        float4 _319 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _312, level(0.0));
        float4 _322 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _312, level(0.0));
        float _332 = _322.w;
        _344 = (_292 * _332) + _322.z;
        _345 = (0.5 * _332) + _322.y;
        _346 = (_287 * _332) + _322.x;
        _347 = (_286 * _316.w) + _316.xyz;
        _348 = normalize((_234 * _319.w) + ((_319.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _344 = _292;
        _345 = 0.5;
        _346 = _287;
        _347 = _286;
        _348 = _234;
    }
    float3 _363 = ((_347 - (_347 * _346)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _370 = (mix(float3(0.07999999821186065673828125 * _345), _347, float3(_346)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _373 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _378;
    if (_373)
    {
        _378 = _363 + (_370 * 0.449999988079071044921875);
    }
    else
    {
        _378 = _363;
    }
    float3 _380 = select(_370, float3(0.0), bool3(_373));
    float3 _382 = float3(dot(_380, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _397 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _402 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _397);
    float4 _404 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_397 + float2(0.0, 0.5)));
    uint _406 = in.in_var_LIGHTMAP_ID * 15u;
    float3 _416 = (_402.xyz * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _406 + 4u)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _406 + 6u)].xyz;
    float _417 = dot(_416, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float _436 = (exp2((_417 * 16.0) - 8.0) - 0.00390625) * fast::max(0.0, dot((_404 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _406 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _406 + 7u)], float4(_348.yzx, 1.0)));
    float4 _447 = float4(_348, 1.0);
    float3 _451 = _145;
    _451.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _447);
    float3 _455 = _451;
    _455.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _447);
    float3 _459 = _455;
    _459.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _447);
    float4 _462 = _447.xyzz * _447.yzzx;
    float3 _466 = _145;
    _466.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _462);
    float3 _470 = _466;
    _470.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _462);
    float3 _474 = _470;
    _474.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _462);
    float3 _488 = (float4(_416 * (_436 / _417), _436).xyz * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_459 + _474) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_348.x * _348.x) - (_348.y * _348.y)))) * View.View_SkyLightColor.xyz) * 1.0);
    float3 _510 = fast::max(mix((Material.Material_VectorExpressions[2].xyz * _242) * Material.Material_ScalarExpressions[0].x, Material.Material_VectorExpressions[3].xyz, float3(Material.Material_ScalarExpressions[0].y)), float3(0.0));
    float3 _539;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _538;
        if (any(abs(_209 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _293 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _293 + 19u)].xyz + float3(1.0))))
        {
            _538 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_209, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _538 = _510;
        }
        _539 = _538;
    }
    else
    {
        _539 = _510;
    }
    float4 _546 = float4(((mix(float3(0.0), _378 + (_380 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_488 * _378) * fast::max(float3(1.0), ((((((_347 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_347 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_347 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _539) * 1.0, 0.0);
    float4 _553;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _552 = _546;
        _552.w = 0.0;
        _553 = _552;
    }
    else
    {
        _553 = _546;
    }
    float2 _557 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _565 = (_348 * 0.5) + float3(0.5);
    float4 _567 = float4(_565.x, _565.y, _565.z, float4(0.0).w);
    _567.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _294)].y;
    float4 _568 = float4(0.0);
    _568.x = _346;
    float4 _569 = _568;
    _569.y = _345;
    float4 _570 = _569;
    _570.z = _344;
    float4 _571 = _570;
    _571.w = 0.75686275959014892578125;
    float4 _583 = float4(_347.x, _347.y, _347.z, float4(0.0).w);
    _583.w = ((log2(((dot(_488, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_382 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_382 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_382 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_557.xyx * _557.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _553 * View.View_PreExposure;
    out.out_var_SV_Target1 = _567;
    out.out_var_SV_Target2 = _571;
    out.out_var_SV_Target3 = _583;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

