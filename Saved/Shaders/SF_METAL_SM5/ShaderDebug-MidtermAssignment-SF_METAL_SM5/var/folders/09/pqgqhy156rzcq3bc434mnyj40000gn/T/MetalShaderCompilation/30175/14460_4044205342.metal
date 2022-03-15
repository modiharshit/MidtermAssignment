

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
    float4 in_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 in_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 in_var_TEXCOORD0_0 [[user(locn2)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_0000387c_f10dad1e(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _205 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _209 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _214 = (_209.xyz / float3(_209.w)) - View.View_PreViewTranslation;
    float4 _222 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _225 = (_222.xy * float2(2.0)) - float2(1.0);
    float3 _242 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize(((float4(_225, sqrt(fast::clamp(1.0 - dot(_225, _225), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _254 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 20.0), bias(View.View_MaterialTextureMipBias));
    float _256 = mix(0.4000000059604644775390625, 1.0, _254.x);
    float4 _260 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _285;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _285 = _205.w;
                break;
            }
            else
            {
                float _269 = _205.z;
                _285 = ((_269 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_269 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _289 = fast::min(fast::max((_285 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _290 = _260.y;
    float4 _294 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _296 = _294.y;
    float3 _309 = fast::clamp(float3(mix(_256, 1.0 - _256, mix(_290, 1.0, _289)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_296 + mix(_290, 0.0, _289), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _314 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _296) + mix(mix(0.699999988079071044921875, 1.0, _290), 1.0, _289), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _361;
    float _362;
    float _363;
    float3 _364;
    float3 _365;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _331 = ((_205.xy / float2(_205.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _335 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _331, level(0.0));
        float4 _338 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _331, level(0.0));
        float4 _341 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _331, level(0.0));
        float _351 = _341.w;
        _361 = (_314 * _351) + _341.z;
        _362 = (0.5 * _351) + _341.y;
        _363 = _341.x;
        _364 = (_309 * _335.w) + _335.xyz;
        _365 = normalize((_242 * _338.w) + ((_338.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _361 = _314;
        _362 = 0.5;
        _363 = 0.0;
        _364 = _309;
        _365 = _242;
    }
    float _414;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _382 = fast::clamp((_214 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _393 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_382.x), int(_382.y), int(_382.z), 0).xyz), 0));
        _414 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_393.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_382 / float3(_393.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _414 = 1.0;
    }
    float3 _428 = ((_364 - (_364 * _363)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _435 = (mix(float3(0.07999999821186065673828125 * _362), _364, float3(_363)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _438 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _443;
    if (_438)
    {
        _443 = _428 + (_435 * 0.449999988079071044921875);
    }
    else
    {
        _443 = _428;
    }
    float4 _449 = float4(_365, 1.0);
    float3 _453 = _147;
    _453.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _449);
    float3 _457 = _453;
    _457.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _449);
    float3 _461 = _457;
    _461.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _449);
    float4 _464 = _449.xyzz * _449.yzzx;
    float3 _468 = _147;
    _468.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _464);
    float3 _472 = _468;
    _472.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _464);
    float3 _476 = _472;
    _476.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _464);
    float3 _510 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _536;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _535;
        if (any(abs(_214 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _535 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_214, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _535 = _510;
        }
        _536 = _535;
    }
    else
    {
        _536 = _510;
    }
    float4 _543 = float4(((mix(float3(0.0), _443 + (select(_435, float3(0.0), bool3(_438)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((((fast::max(float3(0.0), (_461 + _476) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_365.x * _365.x) - (_365.y * _365.y)))) * View.View_SkyLightColor.xyz) * 1.0) * _443) * fast::max(float3(1.0), ((((((_364 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_364 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_364 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _536) * 1.0, 0.0);
    float4 _550;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _549 = _543;
        _549.w = 0.0;
        _550 = _549;
    }
    else
    {
        _550 = _543;
    }
    float2 _554 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _562 = (_365 * 0.5) + float3(0.5);
    float4 _564 = float4(_562.x, _562.y, _562.z, float4(0.0).w);
    _564.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _565 = float4(0.0);
    _565.x = _363;
    float4 _566 = _565;
    _566.y = _362;
    float4 _567 = _566;
    _567.z = _361;
    float4 _568 = _567;
    _568.w = 0.50588238239288330078125;
    float4 _571 = float4(_364.x, _364.y, _364.z, float4(0.0).w);
    _571.w = (fract(dot(_554.xyx * _554.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _550 * View.View_PreExposure;
    out.out_var_SV_Target1 = _564;
    out.out_var_SV_Target2 = _568;
    out.out_var_SV_Target3 = _571;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_414, 1.0, 1.0, 1.0);
    return out;
}

