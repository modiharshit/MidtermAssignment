

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
    char _m15_pad[188];
    float View_ShowDecalsMask;
    char _m16_pad[184];
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

fragment MainPS_out Main_000031f4_49ed11a9(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> Material_Texture2D_0 [[texture(4)]], texture2d<float> Material_Texture2D_1 [[texture(5)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    float4 _194 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _142, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _199 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _204 = (_199.xyz / float3(_199.w)) - View.View_PreViewTranslation;
    float4 _210 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _213 = (_210.xy * float2(2.0)) - float2(1.0);
    float3 _229 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_213, sqrt(fast::clamp(1.0 - dot(_213, _213), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _240 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _247 = _240.z;
    float _253 = _240.y;
    float3 _267 = fast::clamp(mix(mix(Material.Material_VectorExpressions[4].xyz, Material.Material_VectorExpressions[5].xyz, float3(_247)), Material.Material_VectorExpressions[7].xyz, float3(_253)) * _240.x, float3(0.0), float3(1.0));
    float _268 = fast::clamp(mix(0.0, 1.0, _253), 0.0, 1.0);
    float _273 = (fast::clamp(mix(mix(Material.Material_ScalarExpressions[0].y, Material.Material_ScalarExpressions[0].z, _247), Material.Material_ScalarExpressions[0].w, _253), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _274 = in.in_var_PRIMITIVE_ID * 36u;
    uint _275 = _274 + 20u;
    float _325;
    float _326;
    float _327;
    float3 _328;
    float3 _329;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _275)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _293 = ((_194.xy / float2(_194.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _297 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _293, level(0.0));
        float4 _300 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _293, level(0.0));
        float4 _303 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _293, level(0.0));
        float _313 = _303.w;
        _325 = (_273 * _313) + _303.z;
        _326 = (0.5 * _313) + _303.y;
        _327 = (_268 * _313) + _303.x;
        _328 = (_267 * _297.w) + _297.xyz;
        _329 = normalize((_229 * _300.w) + ((_300.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _325 = _273;
        _326 = 0.5;
        _327 = _268;
        _328 = _267;
        _329 = _229;
    }
    float3 _344 = ((_328 - (_328 * _327)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _351 = (mix(float3(0.07999999821186065673828125 * _326), _328, float3(_327)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _354 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _359;
    if (_354)
    {
        _359 = _344 + (_351 * 0.449999988079071044921875);
    }
    else
    {
        _359 = _344;
    }
    float3 _361 = select(_351, float3(0.0), bool3(_354));
    float3 _363 = float3(dot(_361, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _378 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _383 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _378);
    float4 _385 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_378 + float2(0.0, 0.5)));
    uint _387 = in.in_var_LIGHTMAP_ID * 15u;
    float3 _397 = (_383.xyz * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _387 + 4u)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _387 + 6u)].xyz;
    float _398 = dot(_397, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float _417 = (exp2((_398 * 16.0) - 8.0) - 0.00390625) * fast::max(0.0, dot((_385 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _387 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _387 + 7u)], float4(_329.yzx, 1.0)));
    float3 _427 = float4(_397 * (_417 / _398), _417).xyz * View.View_IndirectLightingColorScale;
    float3 _449 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _478;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _477;
        if (any(abs(_204 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _274 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _274 + 19u)].xyz + float3(1.0))))
        {
            _477 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_204, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _477 = _449;
        }
        _478 = _477;
    }
    else
    {
        _478 = _449;
    }
    float4 _485 = float4(((mix(float3(0.0), _359 + (_361 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_427 * _359) * fast::max(float3(1.0), ((((((_328 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_328 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_328 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _478) * 1.0, 0.0);
    float4 _492;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _491 = _485;
        _491.w = 0.0;
        _492 = _491;
    }
    else
    {
        _492 = _485;
    }
    float2 _496 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _504 = (_329 * 0.5) + float3(0.5);
    float4 _506 = float4(_504.x, _504.y, _504.z, float4(0.0).w);
    _506.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _275)].y;
    float4 _507 = float4(0.0);
    _507.x = _327;
    float4 _508 = _507;
    _508.y = _326;
    float4 _509 = _508;
    _509.z = _325;
    float4 _510 = _509;
    _510.w = 0.75686275959014892578125;
    float4 _522 = float4(_328.x, _328.y, _328.z, float4(0.0).w);
    _522.w = ((log2(((dot(_427, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_363 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_363 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_363 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_496.xyx * _496.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _492 * View.View_PreExposure;
    out.out_var_SV_Target1 = _506;
    out.out_var_SV_Target2 = _510;
    out.out_var_SV_Target3 = _522;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

