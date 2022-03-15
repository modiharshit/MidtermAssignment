

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
    spvUnsafeArray<float4, 4> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float _114 = {};

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
    uint in_var_PRIMITIVE_ID [[user(locn2)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_0000288a_1d3dade9(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _166 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _114, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _171 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _176 = (_171.xyz / float3(_171.w)) - View.View_PreViewTranslation;
    float3 _184 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _197 = fast::clamp(Material.Material_VectorExpressions[3].xyz, float3(0.0), float3(1.0));
    float _202 = (fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _203 = in.in_var_PRIMITIVE_ID * 36u;
    uint _204 = _203 + 20u;
    float _252;
    float _253;
    float _254;
    float3 _255;
    float3 _256;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _204)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _222 = ((_166.xy / float2(_166.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _226 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _222, level(0.0));
        float4 _229 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _222, level(0.0));
        float4 _232 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _222, level(0.0));
        float _242 = _232.w;
        _252 = (_202 * _242) + _232.z;
        _253 = (0.5 * _242) + _232.y;
        _254 = _232.x;
        _255 = (_197 * _226.w) + _226.xyz;
        _256 = normalize((_184 * _229.w) + ((_229.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _252 = _202;
        _253 = 0.5;
        _254 = 0.0;
        _255 = _197;
        _256 = _184;
    }
    float _305;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _204)].z > 0.0)
    {
        float3 _273 = fast::clamp((_176 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _284 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_273.x), int(_273.y), int(_273.z), 0).xyz), 0));
        _305 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_284.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_273 / float3(_284.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _305 = 1.0;
    }
    float3 _319 = ((_255 - (_255 * _254)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _326 = (mix(float3(0.07999999821186065673828125 * _253), _255, float3(_254)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _329 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _334;
    if (_329)
    {
        _334 = _319 + (_326 * 0.449999988079071044921875);
    }
    else
    {
        _334 = _319;
    }
    float3 _343 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _372;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _371;
        if (any(abs(_176 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _203 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _203 + 19u)].xyz + float3(1.0))))
        {
            _371 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_176, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _371 = _343;
        }
        _372 = _371;
    }
    else
    {
        _372 = _343;
    }
    float4 _378 = float4((mix(float3(0.0), _334 + (select(_326, float3(0.0), bool3(_329)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + _372) * 1.0, 0.0);
    float4 _385;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _384 = _378;
        _384.w = 0.0;
        _385 = _384;
    }
    else
    {
        _385 = _378;
    }
    float2 _389 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _397 = (_256 * 0.5) + float3(0.5);
    float4 _399 = float4(_397.x, _397.y, _397.z, float4(0.0).w);
    _399.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _204)].y;
    float4 _400 = float4(0.0);
    _400.x = _254;
    float4 _401 = _400;
    _401.y = _253;
    float4 _402 = _401;
    _402.z = _252;
    float4 _403 = _402;
    _403.w = 0.50588238239288330078125;
    float4 _406 = float4(_255.x, _255.y, _255.z, float4(0.0).w);
    _406.w = (fract(dot(_389.xyx * _389.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _385 * View.View_PreExposure;
    out.out_var_SV_Target1 = _399;
    out.out_var_SV_Target2 = _403;
    out.out_var_SV_Target3 = _406;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_305, 1.0, 1.0, 1.0);
    return out;
}

