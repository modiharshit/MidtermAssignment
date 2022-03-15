

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
    char _m17_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m19_pad[124];
    float View_ShowDecalsMask;
    char _m20_pad[184];
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

constant float3 _158 = {};

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

fragment MainPS_out Main_0000420c_1d387772(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _214 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _218 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _223 = (_218.xyz / float3(_218.w)) - View.View_PreViewTranslation;
    float4 _230 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 10.0), bias(View.View_MaterialTextureMipBias));
    float2 _233 = (_230.xy * float2(2.0)) - float2(1.0);
    float4 _246 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _249 = (_246.xy * float2(2.0)) - float2(1.0);
    float _283;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _283 = _214.w;
                break;
            }
            else
            {
                float _267 = _214.z;
                _283 = ((_267 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_267 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _287 = fast::min(fast::max((_283 - 24.0) * 0.00022222222469281405210494995117188, 0.0), 1.0);
    float3 _298 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((((float4(_233, sqrt(fast::clamp(1.0 - dot(_233, _233), 0.0, 1.0)), 1.0).xyz * float3(0.5, 0.5, 1.0)) + mix(float4(_249, sqrt(fast::clamp(1.0 - dot(_249, _249), 0.0, 1.0)), 1.0).xyz * float3(0.25, 0.25, 1.0), float3(0.0, 0.0, 1.0), float3(_287))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _310 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 5.0), bias(View.View_MaterialTextureMipBias));
    float _312 = mix(0.4000000059604644775390625, 1.0, _310.x);
    float _315 = mix(0.699999988079071044921875, 0.89999997615814208984375, _310.y);
    float4 _320 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _335 = fast::clamp(mix(Material.Material_VectorExpressions[4].xyz, Material.Material_VectorExpressions[5].xyz, float3(fast::min(fast::max(_320.y + _287, 0.0), 1.0))) * mix(_312, 1.0 - _312, _315), float3(0.0), float3(1.0));
    float _340 = (fast::clamp(_312 * _315, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _341 = in.in_var_PRIMITIVE_ID * 36u;
    uint _342 = _341 + 20u;
    float _390;
    float _391;
    float _392;
    float3 _393;
    float3 _394;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _342)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _360 = ((_214.xy / float2(_214.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _364 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _360, level(0.0));
        float4 _367 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _360, level(0.0));
        float4 _370 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _360, level(0.0));
        float _380 = _370.w;
        _390 = (_340 * _380) + _370.z;
        _391 = (0.5 * _380) + _370.y;
        _392 = _370.x;
        _393 = (_335 * _364.w) + _364.xyz;
        _394 = normalize((_298 * _367.w) + ((_367.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _390 = _340;
        _391 = 0.5;
        _392 = 0.0;
        _393 = _335;
        _394 = _298;
    }
    float3 _409 = ((_393 - (_393 * _392)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _416 = (mix(float3(0.07999999821186065673828125 * _391), _393, float3(_392)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _419 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _424;
    if (_419)
    {
        _424 = _409 + (_416 * 0.449999988079071044921875);
    }
    else
    {
        _424 = _409;
    }
    float3 _426 = select(_416, float3(0.0), bool3(_419));
    float3 _428 = float3(dot(_426, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _443 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _448 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _443);
    float4 _450 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_443 + float2(0.0, 0.5)));
    uint _456 = in.in_var_LIGHTMAP_ID * 15u;
    uint _457 = _456 + 4u;
    uint _462 = _456 + 6u;
    float3 _467 = _448.xyz;
    float _519;
    float _520;
    float3 _521;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _503 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _507 = _503.w;
        float _508 = _507 * _507;
        float3 _510 = normalize(((_503.xyz * 2.0) - float3(1.0)).xyz);
        float _511 = 1.0 - _508;
        float _513 = 1.0 - (_511 * _511);
        _519 = mix(fast::clamp(dot(_510, _394), 0.0, 1.0), 1.0, _513);
        _520 = _508;
        _521 = mix(_510, _394, float3(_513));
    }
    else
    {
        _519 = 1.0;
        _520 = 1.0;
        _521 = _394;
    }
    float4 _525 = float4(_521, 1.0);
    float3 _529 = _158;
    _529.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _525);
    float3 _533 = _529;
    _533.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _525);
    float3 _537 = _533;
    _537.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _525);
    float4 _540 = _525.xyzz * _525.yzzx;
    float3 _544 = _158;
    _544.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _540);
    float3 _548 = _544;
    _548.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _540);
    float3 _552 = _548;
    _552.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _540);
    float3 _567 = (((((_467 * _467) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _457)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _462)].xyz) * ((exp2(((_448.w + ((_450.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _457)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _462)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_450 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _456 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _456 + 7u)], float4(_394.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_537 + _552) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_521.x * _521.x) - (_521.y * _521.y)))) * View.View_SkyLightColor.xyz) * (_520 * _519));
    float3 _589 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _618;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _617;
        if (any(abs(_223 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _341 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _341 + 19u)].xyz + float3(1.0))))
        {
            _617 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_223, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _617 = _589;
        }
        _618 = _617;
    }
    else
    {
        _618 = _589;
    }
    float4 _625 = float4(((mix(float3(0.0), _424 + (_426 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_567 * _424) * fast::max(float3(1.0), ((((((_393 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_393 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_393 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _618) * 1.0, 0.0);
    float4 _632;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _631 = _625;
        _631.w = 0.0;
        _632 = _631;
    }
    else
    {
        _632 = _625;
    }
    float2 _636 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _644 = (_394 * 0.5) + float3(0.5);
    float4 _646 = float4(_644.x, _644.y, _644.z, float4(0.0).w);
    _646.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _342)].y;
    float4 _647 = float4(0.0);
    _647.x = _392;
    float4 _648 = _647;
    _648.y = _391;
    float4 _649 = _648;
    _649.z = _390;
    float4 _650 = _649;
    _650.w = 0.75686275959014892578125;
    float4 _662 = float4(_393.x, _393.y, _393.z, float4(0.0).w);
    _662.w = ((log2(((dot(_567, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_428 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_428 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_428 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_636.xyx * _636.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _632 * View.View_PreExposure;
    out.out_var_SV_Target1 = _646;
    out.out_var_SV_Target2 = _650;
    out.out_var_SV_Target3 = _662;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

