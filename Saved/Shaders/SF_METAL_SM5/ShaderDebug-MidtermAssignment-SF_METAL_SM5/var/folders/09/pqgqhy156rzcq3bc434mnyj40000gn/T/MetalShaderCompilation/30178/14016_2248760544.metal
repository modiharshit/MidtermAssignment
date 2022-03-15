

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
    char _m15_pad[612];
    float View_RenderingReflectionCaptureMask;
    char _m16_pad[48];
    float4 View_SkyLightColor;
    char _m17_pad[124];
    float View_ShowDecalsMask;
    char _m18_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m19_pad[48];
    float3 View_VolumetricLightmapWorldToUVScale;
    float3 View_VolumetricLightmapWorldToUVAdd;
    packed_float3 View_VolumetricLightmapIndirectionTextureSize;
    float View_VolumetricLightmapBrickSize;
    float3 View_VolumetricLightmapBrickTexelSize;
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_Primitive
{
    char _m0_pad[80];
    float4 Primitive_ObjectWorldPositionAndRadius;
    char _m1_pad[208];
    float3 Primitive_ObjectBounds;
    float Primitive_DecalReceiverMask;
    float Primitive_PerObjectGBufferData;
    float Primitive_UseVolumetricLightmapShadowFromStationaryLights;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float3 _147 = {};

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
    float2 in_var_TEXCOORD0 [[user(locn0)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_000036c0_86095ce0(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _195 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _199 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _204 = (_199.xyz / float3(_199.w)) - View.View_PreViewTranslation;
    float4 _212 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (in.in_var_TEXCOORD0 * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _215 = (_212.xy * float2(2.0)) - float2(1.0);
    float3 _232 = normalize(float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0)) * normalize(((float4(_215, sqrt(fast::clamp(1.0 - dot(_215, _215), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _244 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in.in_var_TEXCOORD0 * 20.0), bias(View.View_MaterialTextureMipBias));
    float _246 = mix(0.4000000059604644775390625, 1.0, _244.x);
    float4 _250 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in.in_var_TEXCOORD0 * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _275;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _275 = _195.w;
                break;
            }
            else
            {
                float _259 = _195.z;
                _275 = ((_259 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_259 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _279 = fast::min(fast::max((_275 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _280 = _250.y;
    float4 _284 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in.in_var_TEXCOORD0 * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _286 = _284.y;
    float3 _299 = fast::clamp(float3(mix(_246, 1.0 - _246, mix(_280, 1.0, _279)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_286 + mix(_280, 0.0, _279), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _304 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _286) + mix(mix(0.699999988079071044921875, 1.0, _280), 1.0, _279), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _351;
    float _352;
    float _353;
    float3 _354;
    float3 _355;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _321 = ((_195.xy / float2(_195.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _325 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _321, level(0.0));
        float4 _328 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _321, level(0.0));
        float4 _331 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _321, level(0.0));
        float _341 = _331.w;
        _351 = (_304 * _341) + _331.z;
        _352 = (0.5 * _341) + _331.y;
        _353 = _331.x;
        _354 = (_299 * _325.w) + _325.xyz;
        _355 = normalize((_232 * _328.w) + ((_328.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _351 = _304;
        _352 = 0.5;
        _353 = 0.0;
        _354 = _299;
        _355 = _232;
    }
    float _404;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _372 = fast::clamp((_204 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _383 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_372.x), int(_372.y), int(_372.z), 0).xyz), 0));
        _404 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_383.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_372 / float3(_383.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _404 = 1.0;
    }
    float3 _418 = ((_354 - (_354 * _353)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _425 = (mix(float3(0.07999999821186065673828125 * _352), _354, float3(_353)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _428 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _433;
    if (_428)
    {
        _433 = _418 + (_425 * 0.449999988079071044921875);
    }
    else
    {
        _433 = _418;
    }
    float4 _439 = float4(_355, 1.0);
    float3 _443 = _147;
    _443.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _439);
    float3 _447 = _443;
    _447.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _439);
    float3 _451 = _447;
    _451.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _439);
    float4 _454 = _439.xyzz * _439.yzzx;
    float3 _458 = _147;
    _458.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _454);
    float3 _462 = _458;
    _462.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _454);
    float3 _466 = _462;
    _466.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _454);
    float3 _500 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _526;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _525;
        if (any(abs(_204 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _525 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_204, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _525 = _500;
        }
        _526 = _525;
    }
    else
    {
        _526 = _500;
    }
    float4 _533 = float4(((mix(float3(0.0), _433 + (select(_425, float3(0.0), bool3(_428)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((((fast::max(float3(0.0), (_451 + _466) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_355.x * _355.x) - (_355.y * _355.y)))) * View.View_SkyLightColor.xyz) * 1.0) * _433) * fast::max(float3(1.0), ((((((_354 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_354 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_354 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _526) * 1.0, 0.0);
    float4 _540;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _539 = _533;
        _539.w = 0.0;
        _540 = _539;
    }
    else
    {
        _540 = _533;
    }
    float2 _544 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _552 = (_355 * 0.5) + float3(0.5);
    float4 _554 = float4(_552.x, _552.y, _552.z, float4(0.0).w);
    _554.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _555 = float4(0.0);
    _555.x = _353;
    float4 _556 = _555;
    _556.y = _352;
    float4 _557 = _556;
    _557.z = _351;
    float4 _558 = _557;
    _558.w = 0.50588238239288330078125;
    float4 _561 = float4(_354.x, _354.y, _354.z, float4(0.0).w);
    _561.w = (fract(dot(_544.xyx * _544.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _540 * View.View_PreExposure;
    out.out_var_SV_Target1 = _554;
    out.out_var_SV_Target2 = _558;
    out.out_var_SV_Target3 = _561;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_404, 1.0, 1.0, 1.0);
    return out;
}

