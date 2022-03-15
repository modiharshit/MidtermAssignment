

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
    char _m13_pad[612];
    float View_RenderingReflectionCaptureMask;
    char _m14_pad[188];
    float View_ShowDecalsMask;
    char _m15_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m16_pad[48];
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
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float _117 = {};

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
    float4 in_var_COLOR1 [[user(locn2)]];
};

fragment MainPS_out Main_00002975_c9b5d9f6(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    float2 _165 = (gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw;
    float4 _171 = float4((_165 - float2(0.5)) * float2(2.0, -2.0), _117, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _176 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _181 = (_176.xyz / float3(_176.w)) - View.View_PreViewTranslation;
    float3 _189 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _196 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (_165 * 4.0), bias(View.View_MaterialTextureMipBias));
    float3 _197 = _196.xyz;
    if (abs(in.in_var_COLOR1.w) > 0.001000000047497451305389404296875)
    {
        float _214 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
        if ((float((in.in_var_COLOR1.w < 0.0) ? ((in.in_var_COLOR1.w + 1.0) > _214) : (in.in_var_COLOR1.w < _214)) - 0.001000000047497451305389404296875) < 0.0)
        {
            discard_fragment();
        }
    }
    float3 _225 = fast::clamp(_197, float3(0.0), float3(1.0));
    float _229 = (0.5 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _276;
    float _277;
    float _278;
    float3 _279;
    float3 _280;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _246 = ((_171.xy / float2(_171.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _250 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _246, level(0.0));
        float4 _253 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _246, level(0.0));
        float4 _256 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _246, level(0.0));
        float _266 = _256.w;
        _276 = (_229 * _266) + _256.z;
        _277 = (0.5 * _266) + _256.y;
        _278 = _256.x;
        _279 = (_225 * _250.w) + _250.xyz;
        _280 = normalize((_189 * _253.w) + ((_253.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _276 = _229;
        _277 = 0.5;
        _278 = 0.0;
        _279 = _225;
        _280 = _189;
    }
    float _329;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _297 = fast::clamp((_181 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _308 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_297.x), int(_297.y), int(_297.z), 0).xyz), 0));
        _329 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_308.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_297 / float3(_308.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _329 = 1.0;
    }
    float3 _343 = ((_279 - (_279 * _278)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _350 = (mix(float3(0.07999999821186065673828125 * _277), _279, float3(_278)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _353 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _358;
    if (_353)
    {
        _358 = _343 + (_350 * 0.449999988079071044921875);
    }
    else
    {
        _358 = _343;
    }
    float3 _367 = fast::max(mix(_197, Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _393;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _392;
        if (any(abs(_181 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _392 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_181, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _392 = _367;
        }
        _393 = _392;
    }
    else
    {
        _393 = _367;
    }
    float4 _399 = float4((mix(float3(0.0), _358 + (select(_350, float3(0.0), bool3(_353)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + _393) * 1.0, 0.0);
    float4 _406;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _405 = _399;
        _405.w = 0.0;
        _406 = _405;
    }
    else
    {
        _406 = _399;
    }
    float2 _410 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _418 = (_280 * 0.5) + float3(0.5);
    float4 _420 = float4(_418.x, _418.y, _418.z, float4(0.0).w);
    _420.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _421 = float4(0.0);
    _421.x = _278;
    float4 _422 = _421;
    _422.y = _277;
    float4 _423 = _422;
    _423.z = _276;
    float4 _424 = _423;
    _424.w = 0.50588238239288330078125;
    float4 _427 = float4(_279.x, _279.y, _279.z, float4(0.0).w);
    _427.w = (fract(dot(_410.xyx * _410.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _406 * View.View_PreExposure;
    out.out_var_SV_Target1 = _420;
    out.out_var_SV_Target2 = _424;
    out.out_var_SV_Target3 = _427;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_329, 1.0, 1.0, 1.0);
    return out;
}

