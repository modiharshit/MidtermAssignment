

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

fragment MainPS_out Main_00003443_c0495352(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> Material_Texture2D_0 [[texture(4)]], texture2d<float> Material_Texture2D_1 [[texture(5)]], texture2d<float> Material_Texture2D_2 [[texture(6)]], texture2d<float> Material_Texture2D_3 [[texture(7)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    float4 _195 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _142, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _200 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _205 = (_200.xyz / float3(_200.w)) - View.View_PreViewTranslation;
    float4 _211 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _214 = (_211.xy * float2(2.0)) - float2(1.0);
    float _221 = sqrt(fast::clamp(1.0 - dot(_214, _214), 0.0, 1.0)) + 1.0;
    float2 _222 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 2.0;
    float4 _226 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _222, bias(View.View_MaterialTextureMipBias));
    float2 _229 = (_226.xy * float2(2.0)) - float2(1.0);
    float _233 = sqrt(fast::clamp(1.0 - dot(_229, _229), 0.0, 1.0));
    float3 _239 = float3(_214, _221);
    float3 _242 = float3(float4(_229, _233, 1.0).xy * (-1.0), _233);
    float3 _254 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((((_239 * dot(_239, _242)) - (_242 * _221)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _265 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _222, bias(View.View_MaterialTextureMipBias));
    float4 _269 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _274 = fast::clamp(_265.xyz, float3(0.0), float3(1.0));
    float _275 = fast::clamp(_269.x, 0.0, 1.0);
    float _280 = (fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _281 = in.in_var_PRIMITIVE_ID * 36u;
    uint _282 = _281 + 20u;
    float _330;
    float _331;
    float _332;
    float3 _333;
    float3 _334;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _282)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _300 = ((_195.xy / float2(_195.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _304 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _300, level(0.0));
        float4 _307 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _300, level(0.0));
        float4 _310 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _300, level(0.0));
        float _320 = _310.w;
        _330 = (_280 * _320) + _310.z;
        _331 = (0.5 * _320) + _310.y;
        _332 = _310.x;
        _333 = (_274 * _304.w) + _304.xyz;
        _334 = normalize((_254 * _307.w) + ((_307.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _330 = _280;
        _331 = 0.5;
        _332 = 0.0;
        _333 = _274;
        _334 = _254;
    }
    float3 _349 = ((_333 - (_333 * _332)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _356 = (mix(float3(0.07999999821186065673828125 * _331), _333, float3(_332)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _359 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _364;
    if (_359)
    {
        _364 = _349 + (_356 * 0.449999988079071044921875);
    }
    else
    {
        _364 = _349;
    }
    float3 _366 = select(_356, float3(0.0), bool3(_359));
    float3 _368 = float3(dot(_366, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _375 = float3(_275);
    float2 _384 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _389 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _384);
    float4 _391 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_384 + float2(0.0, 0.5)));
    uint _393 = in.in_var_LIGHTMAP_ID * 15u;
    float3 _403 = (_389.xyz * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _393 + 4u)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _393 + 6u)].xyz;
    float _404 = dot(_403, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float _423 = (exp2((_404 * 16.0) - 8.0) - 0.00390625) * fast::max(0.0, dot((_391 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _393 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _393 + 7u)], float4(_334.yzx, 1.0)));
    float3 _433 = float4(_403 * (_423 / _404), _423).xyz * View.View_IndirectLightingColorScale;
    float3 _455 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _484;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _483;
        if (any(abs(_205 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _281 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _281 + 19u)].xyz + float3(1.0))))
        {
            _483 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_205, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _483 = _455;
        }
        _484 = _483;
    }
    else
    {
        _484 = _455;
    }
    float4 _491 = float4(((mix(float3(0.0), _364 + (_366 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_433 * _364) * fast::max(_375, ((((((_333 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _275) + ((_333 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _275) + ((_333 * 2.755199909210205078125) + float3(0.69029998779296875))) * _275))) + _484) * 1.0, 0.0);
    float4 _498;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _497 = _491;
        _497.w = 0.0;
        _498 = _497;
    }
    else
    {
        _498 = _491;
    }
    float2 _502 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _510 = (_334 * 0.5) + float3(0.5);
    float4 _512 = float4(_510.x, _510.y, _510.z, float4(0.0).w);
    _512.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _282)].y;
    float4 _513 = float4(0.0);
    _513.x = _332;
    float4 _514 = _513;
    _514.y = _331;
    float4 _515 = _514;
    _515.z = _330;
    float4 _516 = _515;
    _516.w = 0.75686275959014892578125;
    float4 _528 = float4(_333.x, _333.y, _333.z, float4(0.0).w);
    _528.w = ((log2(((dot(_433, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_375, ((((((_368 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _275) + ((_368 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _275) + ((_368 * 2.755199909210205078125) + float3(0.69029998779296875))) * _275).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_502.xyx * _502.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _498 * View.View_PreExposure;
    out.out_var_SV_Target1 = _512;
    out.out_var_SV_Target2 = _516;
    out.out_var_SV_Target3 = _528;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

