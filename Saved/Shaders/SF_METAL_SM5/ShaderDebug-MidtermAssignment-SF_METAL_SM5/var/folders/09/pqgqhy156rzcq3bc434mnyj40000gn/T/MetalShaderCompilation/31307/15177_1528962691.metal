

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
    char _m17_pad[188];
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

fragment MainPS_out Main_00003b49_5b221e83(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_StaticShadowTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    float4 _213 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _217 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _222 = (_217.xyz / float3(_217.w)) - View.View_PreViewTranslation;
    float4 _229 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 10.0), bias(View.View_MaterialTextureMipBias));
    float2 _232 = (_229.xy * float2(2.0)) - float2(1.0);
    float4 _245 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _248 = (_245.xy * float2(2.0)) - float2(1.0);
    float _282;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _282 = _213.w;
                break;
            }
            else
            {
                float _266 = _213.z;
                _282 = ((_266 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_266 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _286 = fast::min(fast::max((_282 - 24.0) * 0.00022222222469281405210494995117188, 0.0), 1.0);
    float3 _297 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((((float4(_232, sqrt(fast::clamp(1.0 - dot(_232, _232), 0.0, 1.0)), 1.0).xyz * float3(0.5, 0.5, 1.0)) + mix(float4(_248, sqrt(fast::clamp(1.0 - dot(_248, _248), 0.0, 1.0)), 1.0).xyz * float3(0.25, 0.25, 1.0), float3(0.0, 0.0, 1.0), float3(_286))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _309 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 5.0), bias(View.View_MaterialTextureMipBias));
    float _311 = mix(0.4000000059604644775390625, 1.0, _309.x);
    float _314 = mix(0.699999988079071044921875, 0.89999997615814208984375, _309.y);
    float4 _319 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _334 = fast::clamp(mix(Material.Material_VectorExpressions[4].xyz, Material.Material_VectorExpressions[5].xyz, float3(fast::min(fast::max(_319.y + _286, 0.0), 1.0))) * mix(_311, 1.0 - _311, _314), float3(0.0), float3(1.0));
    float _339 = (fast::clamp(_311 * _314, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _340 = in.in_var_PRIMITIVE_ID * 36u;
    uint _341 = _340 + 20u;
    float _389;
    float _390;
    float _391;
    float3 _392;
    float3 _393;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _341)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _359 = ((_213.xy / float2(_213.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _363 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _359, level(0.0));
        float4 _366 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _359, level(0.0));
        float4 _369 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _359, level(0.0));
        float _379 = _369.w;
        _389 = (_339 * _379) + _369.z;
        _390 = (0.5 * _379) + _369.y;
        _391 = _369.x;
        _392 = (_334 * _363.w) + _363.xyz;
        _393 = normalize((_297 * _366.w) + ((_366.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _389 = _339;
        _390 = 0.5;
        _391 = 0.0;
        _392 = _334;
        _393 = _297;
    }
    float4 _400 = LightmapResourceCluster_StaticShadowTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.zw);
    uint _401 = in.in_var_LIGHTMAP_ID * 15u;
    uint _402 = _401 + 1u;
    float4 _409 = fast::clamp((_400 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _402)]) + ((View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _402)] * (-0.5)) + float4(0.5)), float4(0.0), float4(1.0));
    float3 _426 = ((_392 - (_392 * _391)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _433 = (mix(float3(0.07999999821186065673828125 * _390), _392, float3(_391)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _436 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _441;
    if (_436)
    {
        _441 = _426 + (_433 * 0.449999988079071044921875);
    }
    else
    {
        _441 = _426;
    }
    float3 _443 = select(_433, float3(0.0), bool3(_436));
    float3 _445 = float3(dot(_443, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _460 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _464 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _460);
    float4 _466 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_460 + float2(0.0, 0.5)));
    uint _472 = _401 + 4u;
    uint _477 = _401 + 6u;
    float3 _482 = _464.xyz;
    float3 _510 = ((((_482 * _482) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _472)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _477)].xyz) * ((exp2(((_464.w + ((_466.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _472)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _477)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_466 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _401 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _401 + 7u)], float4(_393.yzx, 1.0))))) * View.View_IndirectLightingColorScale;
    float3 _532 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _561;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _560;
        if (any(abs(_222 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _340 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _340 + 19u)].xyz + float3(1.0))))
        {
            _560 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_222, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _560 = _532;
        }
        _561 = _560;
    }
    else
    {
        _561 = _532;
    }
    float4 _568 = float4(((mix(float3(0.0), _441 + (_443 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_510 * _441) * fast::max(float3(1.0), ((((((_392 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_392 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_392 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _561) * 1.0, 0.0);
    float4 _575;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _574 = _568;
        _574.w = 0.0;
        _575 = _574;
    }
    else
    {
        _575 = _568;
    }
    float2 _579 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _587 = (_393 * 0.5) + float3(0.5);
    float4 _589 = float4(_587.x, _587.y, _587.z, float4(0.0).w);
    _589.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _341)].y;
    float4 _590 = float4(0.0);
    _590.x = _391;
    float4 _591 = _590;
    _591.y = _390;
    float4 _592 = _591;
    _592.z = _389;
    float4 _593 = _592;
    _593.w = 0.50588238239288330078125;
    float4 _605 = float4(_392.x, _392.y, _392.z, float4(0.0).w);
    _605.w = ((log2(((dot(_510, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_445 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_445 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_445 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_579.xyx * _579.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _575 * View.View_PreExposure;
    out.out_var_SV_Target1 = _589;
    out.out_var_SV_Target2 = _593;
    out.out_var_SV_Target3 = _605;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = (View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _401)] * _409) * _409;
    return out;
}

