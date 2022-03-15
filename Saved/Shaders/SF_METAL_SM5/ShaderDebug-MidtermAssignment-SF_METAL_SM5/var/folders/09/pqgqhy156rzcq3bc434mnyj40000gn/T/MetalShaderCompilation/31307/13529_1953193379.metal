

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
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float _144 = {};

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

fragment MainPS_out Main_000034d9_746b5da3(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> Material_Texture2D_0 [[texture(4)]], texture2d<float> Material_Texture2D_1 [[texture(5)]], texture2d<float> Material_Texture2D_2 [[texture(6)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    float4 _197 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _144, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _202 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _207 = (_202.xyz / float3(_202.w)) - View.View_PreViewTranslation;
    float4 _213 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _216 = (_213.xy * float2(2.0)) - float2(1.0);
    float _223 = sqrt(fast::clamp(1.0 - dot(_216, _216), 0.0, 1.0)) + 1.0;
    float4 _226 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 2.0), bias(View.View_MaterialTextureMipBias));
    float2 _229 = (_226.xy * float2(2.0)) - float2(1.0);
    float3 _238 = float4(_229, sqrt(fast::clamp(1.0 - dot(_229, _229), 0.0, 1.0)), 1.0).xyz * float3(-1.0, -1.0, 1.0);
    float3 _241 = float3(_216, _223);
    float3 _245 = float3(_238.xy * (-1.0), _238.z);
    float3 _257 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((((_241 * dot(_241, _245)) - (_245 * _223)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _269 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _274 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.02999999932944774627685546875), bias(View.View_MaterialTextureMipBias));
    float4 _283 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _287 = fast::clamp(mix(float3(0.5), float3(1.0), float3((_269.x + 0.5) * (_274.x + 0.5))) * _283.xyz, float3(0.0), float3(1.0));
    float _288 = fast::clamp(_283.w, 0.0, 1.0);
    float _292 = (0.980000019073486328125 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _293 = in.in_var_PRIMITIVE_ID * 36u;
    uint _294 = _293 + 20u;
    float _342;
    float _343;
    float _344;
    float3 _345;
    float3 _346;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _294)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _312 = ((_197.xy / float2(_197.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _316 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _312, level(0.0));
        float4 _319 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _312, level(0.0));
        float4 _322 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _312, level(0.0));
        float _332 = _322.w;
        _342 = (_292 * _332) + _322.z;
        _343 = (_288 * _332) + _322.y;
        _344 = _322.x;
        _345 = (_287 * _316.w) + _316.xyz;
        _346 = normalize((_257 * _319.w) + ((_319.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _342 = _292;
        _343 = _288;
        _344 = 0.0;
        _345 = _287;
        _346 = _257;
    }
    float3 _361 = ((_345 - (_345 * _344)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _368 = (mix(float3(0.07999999821186065673828125 * _343), _345, float3(_344)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _371 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _376;
    if (_371)
    {
        _376 = _361 + (_368 * 0.449999988079071044921875);
    }
    else
    {
        _376 = _361;
    }
    float3 _378 = select(_368, float3(0.0), bool3(_371));
    float3 _380 = float3(dot(_378, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _395 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _400 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _395);
    float4 _402 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_395 + float2(0.0, 0.5)));
    uint _404 = in.in_var_LIGHTMAP_ID * 15u;
    float3 _414 = (_400.xyz * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _404 + 4u)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _404 + 6u)].xyz;
    float _415 = dot(_414, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float _434 = (exp2((_415 * 16.0) - 8.0) - 0.00390625) * fast::max(0.0, dot((_402 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _404 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _404 + 7u)], float4(_346.yzx, 1.0)));
    float3 _444 = float4(_414 * (_434 / _415), _434).xyz * View.View_IndirectLightingColorScale;
    float3 _466 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _495;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _494;
        if (any(abs(_207 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _293 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _293 + 19u)].xyz + float3(1.0))))
        {
            _494 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_207, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _494 = _466;
        }
        _495 = _494;
    }
    else
    {
        _495 = _466;
    }
    float4 _502 = float4(((mix(float3(0.0), _376 + (_378 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_444 * _376) * fast::max(float3(1.0), ((((((_345 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_345 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_345 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _495) * 1.0, 0.0);
    float4 _509;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _508 = _502;
        _508.w = 0.0;
        _509 = _508;
    }
    else
    {
        _509 = _502;
    }
    float2 _513 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _521 = (_346 * 0.5) + float3(0.5);
    float4 _523 = float4(_521.x, _521.y, _521.z, float4(0.0).w);
    _523.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _294)].y;
    float4 _524 = float4(0.0);
    _524.x = _344;
    float4 _525 = _524;
    _525.y = _343;
    float4 _526 = _525;
    _526.z = _342;
    float4 _527 = _526;
    _527.w = 0.75686275959014892578125;
    float4 _539 = float4(_345.x, _345.y, _345.z, float4(0.0).w);
    _539.w = ((log2(((dot(_444, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_380 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_380 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_380 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_513.xyx * _513.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _509 * View.View_PreExposure;
    out.out_var_SV_Target1 = _523;
    out.out_var_SV_Target2 = _527;
    out.out_var_SV_Target3 = _539;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

