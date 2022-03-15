

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

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float _129 = {};

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

fragment MainPS_out Main_00002fd7_403c2e3b(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _184 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _129, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _189 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _194 = (_189.xyz / float3(_189.w)) - View.View_PreViewTranslation;
    float4 _200 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _203 = (_200.xy * float2(2.0)) - float2(1.0);
    float3 _219 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_203, sqrt(fast::clamp(1.0 - dot(_203, _203), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _231 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _236 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _241 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _245 = (_231.x + 0.5) * ((_236.x + 0.5) * (_241.x + 0.5));
    float4 _251 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _257 = fast::clamp(mix(float3(0.800000011920928955078125), float3(1.0), float3(_245)) * _251.xyz, float3(0.0), float3(1.0));
    float _262 = (fast::clamp(mix(0.800000011920928955078125, 0.5, _245 * _251.w), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _263 = in.in_var_PRIMITIVE_ID * 36u;
    uint _264 = _263 + 20u;
    float _312;
    float _313;
    float _314;
    float3 _315;
    float3 _316;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _264)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _282 = ((_184.xy / float2(_184.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _286 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _282, level(0.0));
        float4 _289 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _282, level(0.0));
        float4 _292 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _282, level(0.0));
        float _302 = _292.w;
        _312 = (_262 * _302) + _292.z;
        _313 = (0.5 * _302) + _292.y;
        _314 = _292.x;
        _315 = (_257 * _286.w) + _286.xyz;
        _316 = normalize((_219 * _289.w) + ((_289.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _312 = _262;
        _313 = 0.5;
        _314 = 0.0;
        _315 = _257;
        _316 = _219;
    }
    float _365;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _264)].z > 0.0)
    {
        float3 _333 = fast::clamp((_194 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _344 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_333.x), int(_333.y), int(_333.z), 0).xyz), 0));
        _365 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_344.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_333 / float3(_344.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _365 = 1.0;
    }
    float3 _379 = ((_315 - (_315 * _314)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _386 = (mix(float3(0.07999999821186065673828125 * _313), _315, float3(_314)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _389 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _394;
    if (_389)
    {
        _394 = _379 + (_386 * 0.449999988079071044921875);
    }
    else
    {
        _394 = _379;
    }
    float3 _403 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _432;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _431;
        if (any(abs(_194 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _263 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _263 + 19u)].xyz + float3(1.0))))
        {
            _431 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_194, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _431 = _403;
        }
        _432 = _431;
    }
    else
    {
        _432 = _403;
    }
    float4 _438 = float4((mix(float3(0.0), _394 + (select(_386, float3(0.0), bool3(_389)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + _432) * 1.0, 0.0);
    float4 _445;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _444 = _438;
        _444.w = 0.0;
        _445 = _444;
    }
    else
    {
        _445 = _438;
    }
    float2 _449 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _457 = (_316 * 0.5) + float3(0.5);
    float4 _459 = float4(_457.x, _457.y, _457.z, float4(0.0).w);
    _459.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _264)].y;
    float4 _460 = float4(0.0);
    _460.x = _314;
    float4 _461 = _460;
    _461.y = _313;
    float4 _462 = _461;
    _462.z = _312;
    float4 _463 = _462;
    _463.w = 0.50588238239288330078125;
    float4 _466 = float4(_315.x, _315.y, _315.z, float4(0.0).w);
    _466.w = (fract(dot(_449.xyx * _449.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _445 * View.View_PreExposure;
    out.out_var_SV_Target1 = _459;
    out.out_var_SV_Target2 = _463;
    out.out_var_SV_Target3 = _466;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_365, 1.0, 1.0, 1.0);
    return out;
}

