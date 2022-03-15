

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

constant float _141 = {};

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

fragment MainPS_out Main_0000349f_7ca92699(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> Material_Texture2D_0 [[texture(4)]], texture2d<float> Material_Texture2D_1 [[texture(5)]], texture2d<float> Material_Texture2D_2 [[texture(6)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    float4 _194 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _141, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _199 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _204 = (_199.xyz / float3(_199.w)) - View.View_PreViewTranslation;
    float4 _210 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _213 = (_210.xy * float2(2.0)) - float2(1.0);
    float3 _229 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_213, sqrt(fast::clamp(1.0 - dot(_213, _213), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _241 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _246 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _251 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _255 = (_241.x + 0.5) * ((_246.x + 0.5) * (_251.x + 0.5));
    float4 _261 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _267 = fast::clamp(mix(float3(0.5), float3(1.0), float3(_255)) * _261.xyz, float3(0.0), float3(1.0));
    float _272 = (fast::clamp(mix(0.5, 0.300000011920928955078125, _255 * _261.w), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _273 = in.in_var_PRIMITIVE_ID * 36u;
    uint _274 = _273 + 20u;
    float _323;
    float _324;
    float _325;
    float3 _326;
    float3 _327;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _274)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _292 = ((_194.xy / float2(_194.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _296 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _292, level(0.0));
        float4 _299 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _292, level(0.0));
        float4 _302 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _292, level(0.0));
        float _312 = _302.w;
        _323 = (_272 * _312) + _302.z;
        _324 = (0.5 * _312) + _302.y;
        _325 = _312 + _302.x;
        _326 = (_267 * _296.w) + _296.xyz;
        _327 = normalize((_229 * _299.w) + ((_299.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _323 = _272;
        _324 = 0.5;
        _325 = 1.0;
        _326 = _267;
        _327 = _229;
    }
    float3 _342 = ((_326 - (_326 * _325)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _349 = (mix(float3(0.07999999821186065673828125 * _324), _326, float3(_325)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _352 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _357;
    if (_352)
    {
        _357 = _342 + (_349 * 0.449999988079071044921875);
    }
    else
    {
        _357 = _342;
    }
    float3 _359 = select(_349, float3(0.0), bool3(_352));
    float3 _361 = float3(dot(_359, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _376 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _381 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _376);
    float4 _383 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_376 + float2(0.0, 0.5)));
    uint _389 = in.in_var_LIGHTMAP_ID * 15u;
    uint _390 = _389 + 4u;
    uint _395 = _389 + 6u;
    float3 _400 = _381.xyz;
    float3 _428 = ((((_400 * _400) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _390)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _395)].xyz) * ((exp2(((_381.w + ((_383.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _390)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _395)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_383 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _389 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _389 + 7u)], float4(_327.yzx, 1.0))))) * View.View_IndirectLightingColorScale;
    float3 _450 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _479;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _478;
        if (any(abs(_204 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _273 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _273 + 19u)].xyz + float3(1.0))))
        {
            _478 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_204, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _478 = _450;
        }
        _479 = _478;
    }
    else
    {
        _479 = _450;
    }
    float4 _486 = float4(((mix(float3(0.0), _357 + (_359 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_428 * _357) * fast::max(float3(1.0), ((((((_326 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_326 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_326 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _479) * 1.0, 0.0);
    float4 _493;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _492 = _486;
        _492.w = 0.0;
        _493 = _492;
    }
    else
    {
        _493 = _486;
    }
    float2 _497 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _505 = (_327 * 0.5) + float3(0.5);
    float4 _507 = float4(_505.x, _505.y, _505.z, float4(0.0).w);
    _507.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _274)].y;
    float4 _508 = float4(0.0);
    _508.x = _325;
    float4 _509 = _508;
    _509.y = _324;
    float4 _510 = _509;
    _510.z = _323;
    float4 _511 = _510;
    _511.w = 0.75686275959014892578125;
    float4 _523 = float4(_326.x, _326.y, _326.z, float4(0.0).w);
    _523.w = ((log2(((dot(_428, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_361 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_361 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_361 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_497.xyx * _497.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _493 * View.View_PreExposure;
    out.out_var_SV_Target1 = _507;
    out.out_var_SV_Target2 = _511;
    out.out_var_SV_Target3 = _523;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

