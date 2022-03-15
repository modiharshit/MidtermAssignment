

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

fragment MainPS_out Main_00003e67_3b0475b6(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_StaticShadowTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    float4 _215 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _219 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _224 = (_219.xyz / float3(_219.w)) - View.View_PreViewTranslation;
    float2 _225 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.25;
    float4 _231 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _225, bias(View.View_MaterialTextureMipBias));
    float2 _234 = (_231.xy * float2(2.0)) - float2(1.0);
    float2 _242 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.3499999940395355224609375;
    float4 _244 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _242, bias(View.View_MaterialTextureMipBias));
    float2 _247 = (_244.xy * float2(2.0)) - float2(1.0);
    float4 _259 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _264 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _269 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _273 = (_259.x + 0.5) * ((_264.x + 0.5) * (_269.x + 0.5));
    float _276 = fast::min(fast::max(mix(-2.0, 0.699999988079071044921875, _273), 0.0), 1.0);
    float3 _279 = float3(_276);
    float4 _285 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _312;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _312 = _215.w;
                break;
            }
            else
            {
                float _296 = _215.z;
                _312 = ((_296 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_296 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _327 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(mix(float4(_234, sqrt(fast::clamp(1.0 - dot(_234, _234), 0.0, 1.0)), 1.0).xyz, float4(_247, sqrt(fast::clamp(1.0 - dot(_247, _247), 0.0, 1.0)), 1.0).xyz, _279), float3(0.0, 0.0, 1.0), float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _285.x) + _312) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _340 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _225, bias(View.View_MaterialTextureMipBias));
    float4 _342 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _242, bias(View.View_MaterialTextureMipBias));
    float3 _351 = fast::clamp(mix(float3(0.6349999904632568359375), float3(1.0), float3(_273)) * mix(_340.xyz, _342.xyz, _279), float3(0.0), float3(1.0));
    float _356 = (fast::clamp(mix(0.800000011920928955078125, 0.20000000298023223876953125, mix(_340.w, _342.w, _276)), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _357 = in.in_var_PRIMITIVE_ID * 36u;
    uint _358 = _357 + 20u;
    float _406;
    float _407;
    float _408;
    float3 _409;
    float3 _410;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _358)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _376 = ((_215.xy / float2(_215.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _380 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _376, level(0.0));
        float4 _383 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _376, level(0.0));
        float4 _386 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _376, level(0.0));
        float _396 = _386.w;
        _406 = (_356 * _396) + _386.z;
        _407 = (0.5 * _396) + _386.y;
        _408 = _386.x;
        _409 = (_351 * _380.w) + _380.xyz;
        _410 = normalize((_327 * _383.w) + ((_383.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _406 = _356;
        _407 = 0.5;
        _408 = 0.0;
        _409 = _351;
        _410 = _327;
    }
    float4 _417 = LightmapResourceCluster_StaticShadowTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.zw);
    uint _418 = in.in_var_LIGHTMAP_ID * 15u;
    uint _419 = _418 + 1u;
    float4 _426 = fast::clamp((_417 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _419)]) + ((View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _419)] * (-0.5)) + float4(0.5)), float4(0.0), float4(1.0));
    float3 _443 = ((_409 - (_409 * _408)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _450 = (mix(float3(0.07999999821186065673828125 * _407), _409, float3(_408)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _453 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _458;
    if (_453)
    {
        _458 = _443 + (_450 * 0.449999988079071044921875);
    }
    else
    {
        _458 = _443;
    }
    float3 _460 = select(_450, float3(0.0), bool3(_453));
    float3 _462 = float3(dot(_460, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _477 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _481 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _477);
    float4 _483 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_477 + float2(0.0, 0.5)));
    uint _489 = _418 + 4u;
    uint _494 = _418 + 6u;
    float3 _499 = _481.xyz;
    float3 _527 = ((((_499 * _499) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _489)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _494)].xyz) * ((exp2(((_481.w + ((_483.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _489)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _494)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_483 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _418 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _418 + 7u)], float4(_410.yzx, 1.0))))) * View.View_IndirectLightingColorScale;
    float3 _549 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _578;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _577;
        if (any(abs(_224 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _357 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _357 + 19u)].xyz + float3(1.0))))
        {
            _577 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_224, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _577 = _549;
        }
        _578 = _577;
    }
    else
    {
        _578 = _549;
    }
    float4 _585 = float4(((mix(float3(0.0), _458 + (_460 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_527 * _458) * fast::max(float3(1.0), ((((((_409 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_409 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_409 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _578) * 1.0, 0.0);
    float4 _592;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _591 = _585;
        _591.w = 0.0;
        _592 = _591;
    }
    else
    {
        _592 = _585;
    }
    float2 _596 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _604 = (_410 * 0.5) + float3(0.5);
    float4 _606 = float4(_604.x, _604.y, _604.z, float4(0.0).w);
    _606.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _358)].y;
    float4 _607 = float4(0.0);
    _607.x = _408;
    float4 _608 = _607;
    _608.y = _407;
    float4 _609 = _608;
    _609.z = _406;
    float4 _610 = _609;
    _610.w = 0.50588238239288330078125;
    float4 _622 = float4(_409.x, _409.y, _409.z, float4(0.0).w);
    _622.w = ((log2(((dot(_527, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_462 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_462 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_462 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_596.xyx * _596.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _592 * View.View_PreExposure;
    out.out_var_SV_Target1 = _606;
    out.out_var_SV_Target2 = _610;
    out.out_var_SV_Target3 = _622;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = (View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _418)] * _426) * _426;
    return out;
}

