

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
    spvUnsafeArray<float4, 4> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float _109 = {};

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
};

fragment MainPS_out Main_000026d3_075c73c8(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    float4 _161 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _109, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _166 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _171 = (_166.xyz / float3(_166.w)) - View.View_PreViewTranslation;
    float3 _179 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _194 = fast::clamp(Material.Material_VectorExpressions[3].xyz, float3(0.0), float3(1.0));
    float _195 = fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0);
    float _200 = (fast::clamp(Material.Material_ScalarExpressions[0].z, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _249;
    float _250;
    float _251;
    float3 _252;
    float3 _253;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _217 = ((_161.xy / float2(_161.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _221 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _217, level(0.0));
        float4 _224 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _217, level(0.0));
        float4 _227 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _217, level(0.0));
        float _237 = _227.w;
        _249 = (_200 * _237) + _227.z;
        _250 = (0.5 * _237) + _227.y;
        _251 = (_195 * _237) + _227.x;
        _252 = (_194 * _221.w) + _221.xyz;
        _253 = normalize((_179 * _224.w) + ((_224.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _249 = _200;
        _250 = 0.5;
        _251 = _195;
        _252 = _194;
        _253 = _179;
    }
    float _302;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _270 = fast::clamp((_171 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _281 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_270.x), int(_270.y), int(_270.z), 0).xyz), 0));
        _302 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_281.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_270 / float3(_281.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _302 = 1.0;
    }
    float3 _316 = ((_252 - (_252 * _251)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _323 = (mix(float3(0.07999999821186065673828125 * _250), _252, float3(_251)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _326 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _331;
    if (_326)
    {
        _331 = _316 + (_323 * 0.449999988079071044921875);
    }
    else
    {
        _331 = _316;
    }
    float3 _340 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _366;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _365;
        if (any(abs(_171 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _365 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_171, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _365 = _340;
        }
        _366 = _365;
    }
    else
    {
        _366 = _340;
    }
    float4 _372 = float4((mix(float3(0.0), _331 + (select(_323, float3(0.0), bool3(_326)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + _366) * 1.0, 0.0);
    float4 _379;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _378 = _372;
        _378.w = 0.0;
        _379 = _378;
    }
    else
    {
        _379 = _372;
    }
    float2 _383 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _391 = (_253 * 0.5) + float3(0.5);
    float4 _393 = float4(_391.x, _391.y, _391.z, float4(0.0).w);
    _393.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _394 = float4(0.0);
    _394.x = _251;
    float4 _395 = _394;
    _395.y = _250;
    float4 _396 = _395;
    _396.z = _249;
    float4 _397 = _396;
    _397.w = 0.50588238239288330078125;
    float4 _400 = float4(_252.x, _252.y, _252.z, float4(0.0).w);
    _400.w = (fract(dot(_383.xyx * _383.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _379 * View.View_PreExposure;
    out.out_var_SV_Target1 = _393;
    out.out_var_SV_Target2 = _397;
    out.out_var_SV_Target3 = _400;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_302, 1.0, 1.0, 1.0);
    return out;
}

