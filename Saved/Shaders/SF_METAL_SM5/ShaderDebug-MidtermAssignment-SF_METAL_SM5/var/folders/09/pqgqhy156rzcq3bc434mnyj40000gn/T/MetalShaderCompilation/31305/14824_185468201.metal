

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
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
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

fragment MainPS_out Main_000039e8_0b0e0529(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_StaticShadowTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    float4 _206 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _210 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _215 = (_210.xyz / float3(_210.w)) - View.View_PreViewTranslation;
    float2 _216 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5;
    float4 _222 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _216, bias(View.View_MaterialTextureMipBias));
    float2 _225 = (_222.xy * float2(2.0)) - float2(1.0);
    float4 _237 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _264;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _264 = _206.w;
                break;
            }
            else
            {
                float _248 = _206.z;
                _264 = ((_248 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_248 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _269 = fast::min(fast::max(((mix(-2000.0, 2000.0, _237.x) + _264) - 500.0) * 0.0005000000237487256526947021484375, 0.0), 1.0);
    float3 _280 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(float4(_225, sqrt(fast::clamp(1.0 - dot(_225, _225), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), float3(_269)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _291 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _216, bias(View.View_MaterialTextureMipBias));
    float4 _295 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _216, bias(View.View_MaterialTextureMipBias));
    float3 _301 = fast::clamp(_291.xyz, float3(0.0), float3(1.0));
    float _302 = fast::clamp(_291.x, 0.0, 1.0);
    float _303 = fast::clamp(_295.w, 0.0, 1.0);
    float _308 = (fast::clamp(mix(_295.x, 0.300000011920928955078125, _269), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _309 = in.in_var_PRIMITIVE_ID * 36u;
    uint _310 = _309 + 20u;
    float _358;
    float _359;
    float _360;
    float3 _361;
    float3 _362;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _310)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _328 = ((_206.xy / float2(_206.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _332 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _328, level(0.0));
        float4 _335 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _328, level(0.0));
        float4 _338 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _328, level(0.0));
        float _348 = _338.w;
        _358 = (_308 * _348) + _338.z;
        _359 = (_302 * _348) + _338.y;
        _360 = _338.x;
        _361 = (_301 * _332.w) + _332.xyz;
        _362 = normalize((_280 * _335.w) + ((_335.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _358 = _308;
        _359 = _302;
        _360 = 0.0;
        _361 = _301;
        _362 = _280;
    }
    float4 _369 = LightmapResourceCluster_StaticShadowTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.zw);
    uint _370 = in.in_var_LIGHTMAP_ID * 15u;
    uint _371 = _370 + 1u;
    float4 _378 = fast::clamp((_369 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _371)]) + ((View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _371)] * (-0.5)) + float4(0.5)), float4(0.0), float4(1.0));
    float3 _395 = ((_361 - (_361 * _360)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _402 = (mix(float3(0.07999999821186065673828125 * _359), _361, float3(_360)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _405 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _410;
    if (_405)
    {
        _410 = _395 + (_402 * 0.449999988079071044921875);
    }
    else
    {
        _410 = _395;
    }
    float3 _412 = select(_402, float3(0.0), bool3(_405));
    float3 _414 = float3(dot(_412, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _421 = float3(_303);
    float2 _430 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _434 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _430);
    float4 _436 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_430 + float2(0.0, 0.5)));
    uint _442 = _370 + 4u;
    uint _447 = _370 + 6u;
    float3 _452 = _434.xyz;
    float3 _480 = ((((_452 * _452) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _442)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _447)].xyz) * ((exp2(((_434.w + ((_436.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _442)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _447)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_436 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _370 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _370 + 7u)], float4(_362.yzx, 1.0))))) * View.View_IndirectLightingColorScale;
    float3 _502 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _531;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _530;
        if (any(abs(_215 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _309 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _309 + 19u)].xyz + float3(1.0))))
        {
            _530 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_215, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _530 = _502;
        }
        _531 = _530;
    }
    else
    {
        _531 = _502;
    }
    float4 _538 = float4(((mix(float3(0.0), _410 + (_412 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_480 * _410) * fast::max(_421, ((((((_361 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _303) + ((_361 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _303) + ((_361 * 2.755199909210205078125) + float3(0.69029998779296875))) * _303))) + _531) * 1.0, 0.0);
    float4 _545;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _544 = _538;
        _544.w = 0.0;
        _545 = _544;
    }
    else
    {
        _545 = _538;
    }
    float2 _549 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _557 = (_362 * 0.5) + float3(0.5);
    float4 _559 = float4(_557.x, _557.y, _557.z, float4(0.0).w);
    _559.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _310)].y;
    float4 _560 = float4(0.0);
    _560.x = _360;
    float4 _561 = _560;
    _561.y = _359;
    float4 _562 = _561;
    _562.z = _358;
    float4 _563 = _562;
    _563.w = 0.50588238239288330078125;
    float4 _575 = float4(_361.x, _361.y, _361.z, float4(0.0).w);
    _575.w = ((log2(((dot(_480, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_421, ((((((_414 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _303) + ((_414 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _303) + ((_414 * 2.755199909210205078125) + float3(0.69029998779296875))) * _303).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_549.xyx * _549.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _545 * View.View_PreExposure;
    out.out_var_SV_Target1 = _559;
    out.out_var_SV_Target2 = _563;
    out.out_var_SV_Target3 = _575;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = (View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _370)] * _378) * _378;
    return out;
}

