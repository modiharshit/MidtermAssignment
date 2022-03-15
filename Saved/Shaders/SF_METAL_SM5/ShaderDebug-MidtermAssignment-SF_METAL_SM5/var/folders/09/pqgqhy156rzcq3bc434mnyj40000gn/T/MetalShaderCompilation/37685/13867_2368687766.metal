

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
    spvUnsafeArray<float4, 2> Material_ScalarExpressions;
};

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

fragment MainPS_out Main_0000362b_8d2f4e96(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_StaticShadowTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    float4 _198 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _146, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _203 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _208 = (_203.xyz / float3(_203.w)) - View.View_PreViewTranslation;
    float4 _214 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _217 = (_214.xy * float2(2.0)) - float2(1.0);
    float3 _233 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_217, sqrt(fast::clamp(1.0 - dot(_217, _217), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _244 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _251 = _244.y;
    float _257 = _244.z;
    float _260 = _244.x;
    float3 _278 = fast::clamp(mix(mix(Material.Material_VectorExpressions[4].xyz, Material.Material_VectorExpressions[5].xyz, float3(_251)), Material.Material_VectorExpressions[7].xyz, float3(_257)) * _260, float3(0.0), float3(1.0));
    float _279 = fast::clamp(mix(mix(Material.Material_ScalarExpressions[0].y, Material.Material_ScalarExpressions[0].z, _251), Material.Material_ScalarExpressions[0].w, _257), 0.0, 1.0);
    float _280 = fast::clamp(_260, 0.0, 1.0);
    float _285 = (fast::clamp(mix(mix(Material.Material_ScalarExpressions[1].x, Material.Material_ScalarExpressions[1].y, _251), Material.Material_ScalarExpressions[1].z, _257), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _286 = in.in_var_PRIMITIVE_ID * 36u;
    uint _287 = _286 + 20u;
    float _337;
    float _338;
    float _339;
    float3 _340;
    float3 _341;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _287)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _305 = ((_198.xy / float2(_198.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _309 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _305, level(0.0));
        float4 _312 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _305, level(0.0));
        float4 _315 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _305, level(0.0));
        float _325 = _315.w;
        _337 = (_285 * _325) + _315.z;
        _338 = (0.5 * _325) + _315.y;
        _339 = (_279 * _325) + _315.x;
        _340 = (_278 * _309.w) + _309.xyz;
        _341 = normalize((_233 * _312.w) + ((_312.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _337 = _285;
        _338 = 0.5;
        _339 = _279;
        _340 = _278;
        _341 = _233;
    }
    float4 _348 = LightmapResourceCluster_StaticShadowTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.zw);
    uint _349 = in.in_var_LIGHTMAP_ID * 15u;
    uint _350 = _349 + 1u;
    float4 _357 = fast::clamp((_348 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _350)]) + ((View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _350)] * (-0.5)) + float4(0.5)), float4(0.0), float4(1.0));
    float3 _374 = ((_340 - (_340 * _339)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _381 = (mix(float3(0.07999999821186065673828125 * _338), _340, float3(_339)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _384 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _389;
    if (_384)
    {
        _389 = _374 + (_381 * 0.449999988079071044921875);
    }
    else
    {
        _389 = _374;
    }
    float3 _391 = select(_381, float3(0.0), bool3(_384));
    float3 _393 = float3(dot(_391, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _400 = float3(_280);
    float2 _409 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _413 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _409);
    float4 _415 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_409 + float2(0.0, 0.5)));
    uint _421 = _349 + 4u;
    uint _426 = _349 + 6u;
    float3 _431 = _413.xyz;
    float3 _459 = ((((_431 * _431) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _421)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _426)].xyz) * ((exp2(((_413.w + ((_415.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _421)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _426)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_415 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _349 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _349 + 7u)], float4(_341.yzx, 1.0))))) * View.View_IndirectLightingColorScale;
    float3 _481 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _510;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _509;
        if (any(abs(_208 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _286 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _286 + 19u)].xyz + float3(1.0))))
        {
            _509 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_208, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _509 = _481;
        }
        _510 = _509;
    }
    else
    {
        _510 = _481;
    }
    float4 _517 = float4(((mix(float3(0.0), _389 + (_391 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_459 * _389) * fast::max(_400, ((((((_340 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _280) + ((_340 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _280) + ((_340 * 2.755199909210205078125) + float3(0.69029998779296875))) * _280))) + _510) * 1.0, 0.0);
    float4 _524;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _523 = _517;
        _523.w = 0.0;
        _524 = _523;
    }
    else
    {
        _524 = _517;
    }
    float2 _528 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _536 = (_341 * 0.5) + float3(0.5);
    float4 _538 = float4(_536.x, _536.y, _536.z, float4(0.0).w);
    _538.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _287)].y;
    float4 _539 = float4(0.0);
    _539.x = _339;
    float4 _540 = _539;
    _540.y = _338;
    float4 _541 = _540;
    _541.z = _337;
    float4 _542 = _541;
    _542.w = 0.50588238239288330078125;
    float4 _554 = float4(_340.x, _340.y, _340.z, float4(0.0).w);
    _554.w = ((log2(((dot(_459, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_400, ((((((_393 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _280) + ((_393 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _280) + ((_393 * 2.755199909210205078125) + float3(0.69029998779296875))) * _280).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_528.xyx * _528.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _524 * View.View_PreExposure;
    out.out_var_SV_Target1 = _538;
    out.out_var_SV_Target2 = _542;
    out.out_var_SV_Target3 = _554;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = (View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _349)] * _357) * _357;
    return out;
}

