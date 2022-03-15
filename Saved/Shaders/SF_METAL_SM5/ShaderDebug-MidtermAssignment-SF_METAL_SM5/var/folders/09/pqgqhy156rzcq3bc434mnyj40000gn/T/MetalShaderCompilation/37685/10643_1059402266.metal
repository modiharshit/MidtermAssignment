

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
    char _m11_pad[80];
    float View_UnlitViewmodeMask;
    char _m12_pad[612];
    float View_RenderingReflectionCaptureMask;
    char _m13_pad[188];
    float View_ShowDecalsMask;
    char _m14_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m15_pad[48];
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

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float _126 = {};

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
    uint in_var_PRIMITIVE_ID [[user(locn3)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00002993_3f25321a(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _180 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _126, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _185 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _190 = (_185.xyz / float3(_185.w)) - View.View_PreViewTranslation;
    float3 _198 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _212 = fast::clamp(mix(float3(0.25), float3(0.569999992847442626953125, 0.3332314789295196533203125, 0.0342000015079975128173828125), float3(fast::min(fast::max(mix(-20.0, 20.0, in_var_TEXCOORD0[0].y), 0.0), 1.0))), float3(0.0), float3(1.0));
    float _216 = (0.20000000298023223876953125 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _217 = in.in_var_PRIMITIVE_ID * 36u;
    uint _218 = _217 + 20u;
    float _266;
    float _267;
    float _268;
    float3 _269;
    float3 _270;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _218)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _236 = ((_180.xy / float2(_180.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _240 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _236, level(0.0));
        float4 _243 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _236, level(0.0));
        float4 _246 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _236, level(0.0));
        float _256 = _246.w;
        _266 = (_216 * _256) + _246.z;
        _267 = (0.5 * _256) + _246.y;
        _268 = _246.x;
        _269 = (_212 * _240.w) + _240.xyz;
        _270 = normalize((_198 * _243.w) + ((_243.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _266 = _216;
        _267 = 0.5;
        _268 = 0.0;
        _269 = _212;
        _270 = _198;
    }
    float _319;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _218)].z > 0.0)
    {
        float3 _287 = fast::clamp((_190 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _298 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_287.x), int(_287.y), int(_287.z), 0).xyz), 0));
        _319 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_298.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_287 / float3(_298.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _319 = 1.0;
    }
    float3 _333 = ((_269 - (_269 * _268)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _340 = (mix(float3(0.07999999821186065673828125 * _267), _269, float3(_268)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _343 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _348;
    if (_343)
    {
        _348 = _333 + (_340 * 0.449999988079071044921875);
    }
    else
    {
        _348 = _333;
    }
    float3 _357 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _386;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _385;
        if (any(abs(_190 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _217 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _217 + 19u)].xyz + float3(1.0))))
        {
            _385 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_190, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _385 = _357;
        }
        _386 = _385;
    }
    else
    {
        _386 = _357;
    }
    float4 _392 = float4((mix(float3(0.0), _348 + (select(_340, float3(0.0), bool3(_343)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + _386) * 1.0, 0.0);
    float4 _399;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _398 = _392;
        _398.w = 0.0;
        _399 = _398;
    }
    else
    {
        _399 = _392;
    }
    float2 _403 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _411 = (_270 * 0.5) + float3(0.5);
    float4 _413 = float4(_411.x, _411.y, _411.z, float4(0.0).w);
    _413.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _218)].y;
    float4 _414 = float4(0.0);
    _414.x = _268;
    float4 _415 = _414;
    _415.y = _267;
    float4 _416 = _415;
    _416.z = _266;
    float4 _417 = _416;
    _417.w = 0.50588238239288330078125;
    float4 _420 = float4(_269.x, _269.y, _269.z, float4(0.0).w);
    _420.w = (fract(dot(_403.xyx * _403.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _399 * View.View_PreExposure;
    out.out_var_SV_Target1 = _413;
    out.out_var_SV_Target2 = _417;
    out.out_var_SV_Target3 = _420;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_319, 1.0, 1.0, 1.0);
    return out;
}

