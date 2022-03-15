

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

constant float _145 = {};

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

fragment MainPS_out Main_0000374e_a7b8f312(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_StaticShadowTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    float4 _198 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _145, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _203 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _208 = (_203.xyz / float3(_203.w)) - View.View_PreViewTranslation;
    float4 _214 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _217 = (_214.xy * float2(2.0)) - float2(1.0);
    float3 _233 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_217, sqrt(fast::clamp(1.0 - dot(_217, _217), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _245 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _250 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _255 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _259 = (_245.x + 0.5) * ((_250.x + 0.5) * (_255.x + 0.5));
    float4 _265 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _271 = fast::clamp(mix(float3(0.5), float3(1.0), float3(_259)) * _265.xyz, float3(0.0), float3(1.0));
    float _276 = (fast::clamp(mix(0.5, 0.300000011920928955078125, _259 * _265.w), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _277 = in.in_var_PRIMITIVE_ID * 36u;
    uint _278 = _277 + 20u;
    float _327;
    float _328;
    float _329;
    float3 _330;
    float3 _331;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _278)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _296 = ((_198.xy / float2(_198.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _300 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _296, level(0.0));
        float4 _303 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _296, level(0.0));
        float4 _306 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _296, level(0.0));
        float _316 = _306.w;
        _327 = (_276 * _316) + _306.z;
        _328 = (0.5 * _316) + _306.y;
        _329 = _316 + _306.x;
        _330 = (_271 * _300.w) + _300.xyz;
        _331 = normalize((_233 * _303.w) + ((_303.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _327 = _276;
        _328 = 0.5;
        _329 = 1.0;
        _330 = _271;
        _331 = _233;
    }
    float4 _338 = LightmapResourceCluster_StaticShadowTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.zw);
    uint _339 = in.in_var_LIGHTMAP_ID * 15u;
    uint _340 = _339 + 1u;
    float4 _347 = fast::clamp((_338 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _340)]) + ((View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _340)] * (-0.5)) + float4(0.5)), float4(0.0), float4(1.0));
    float3 _364 = ((_330 - (_330 * _329)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _371 = (mix(float3(0.07999999821186065673828125 * _328), _330, float3(_329)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _374 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _379;
    if (_374)
    {
        _379 = _364 + (_371 * 0.449999988079071044921875);
    }
    else
    {
        _379 = _364;
    }
    float3 _381 = select(_371, float3(0.0), bool3(_374));
    float3 _383 = float3(dot(_381, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _398 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _402 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _398);
    float4 _404 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_398 + float2(0.0, 0.5)));
    uint _410 = _339 + 4u;
    uint _415 = _339 + 6u;
    float3 _420 = _402.xyz;
    float3 _448 = ((((_420 * _420) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _410)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _415)].xyz) * ((exp2(((_402.w + ((_404.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _410)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _415)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_404 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _339 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _339 + 7u)], float4(_331.yzx, 1.0))))) * View.View_IndirectLightingColorScale;
    float3 _470 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _499;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _498;
        if (any(abs(_208 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _277 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _277 + 19u)].xyz + float3(1.0))))
        {
            _498 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_208, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _498 = _470;
        }
        _499 = _498;
    }
    else
    {
        _499 = _470;
    }
    float4 _506 = float4(((mix(float3(0.0), _379 + (_381 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_448 * _379) * fast::max(float3(1.0), ((((((_330 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_330 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_330 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _499) * 1.0, 0.0);
    float4 _513;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _512 = _506;
        _512.w = 0.0;
        _513 = _512;
    }
    else
    {
        _513 = _506;
    }
    float2 _517 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _525 = (_331 * 0.5) + float3(0.5);
    float4 _527 = float4(_525.x, _525.y, _525.z, float4(0.0).w);
    _527.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _278)].y;
    float4 _528 = float4(0.0);
    _528.x = _329;
    float4 _529 = _528;
    _529.y = _328;
    float4 _530 = _529;
    _530.z = _327;
    float4 _531 = _530;
    _531.w = 0.50588238239288330078125;
    float4 _543 = float4(_330.x, _330.y, _330.z, float4(0.0).w);
    _543.w = ((log2(((dot(_448, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_383 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_383 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_383 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_517.xyx * _517.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _513 * View.View_PreExposure;
    out.out_var_SV_Target1 = _527;
    out.out_var_SV_Target2 = _531;
    out.out_var_SV_Target3 = _543;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = (View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _339)] * _347) * _347;
    return out;
}

