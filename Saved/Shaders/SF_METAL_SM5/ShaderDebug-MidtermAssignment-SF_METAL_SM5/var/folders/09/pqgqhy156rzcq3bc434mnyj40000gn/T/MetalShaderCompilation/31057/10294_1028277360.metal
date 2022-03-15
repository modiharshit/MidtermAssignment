

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
    uint in_var_PRIMITIVE_ID [[user(locn2)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00002836_3d4a4470(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _169 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _117, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _174 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _179 = (_174.xyz / float3(_174.w)) - View.View_PreViewTranslation;
    float3 _187 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float _198 = (0.699999988079071044921875 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _199 = in.in_var_PRIMITIVE_ID * 36u;
    uint _200 = _199 + 20u;
    float _248;
    float _249;
    float _250;
    float3 _251;
    float3 _252;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _200)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _218 = ((_169.xy / float2(_169.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _222 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _218, level(0.0));
        float4 _225 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _218, level(0.0));
        float4 _228 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _218, level(0.0));
        float _238 = _228.w;
        _248 = (_198 * _238) + _228.z;
        _249 = (0.5 * _238) + _228.y;
        _250 = _228.x;
        _251 = (float3(0.180000007152557373046875) * _222.w) + _222.xyz;
        _252 = normalize((_187 * _225.w) + ((_225.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _248 = _198;
        _249 = 0.5;
        _250 = 0.0;
        _251 = float3(0.180000007152557373046875);
        _252 = _187;
    }
    float _301;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _200)].z > 0.0)
    {
        float3 _269 = fast::clamp((_179 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _280 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_269.x), int(_269.y), int(_269.z), 0).xyz), 0));
        _301 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_280.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_269 / float3(_280.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _301 = 1.0;
    }
    float3 _315 = ((_251 - (_251 * _250)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _322 = (mix(float3(0.07999999821186065673828125 * _249), _251, float3(_250)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _325 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _330;
    if (_325)
    {
        _330 = _315 + (_322 * 0.449999988079071044921875);
    }
    else
    {
        _330 = _315;
    }
    float3 _339 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _368;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _367;
        if (any(abs(_179 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _199 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _199 + 19u)].xyz + float3(1.0))))
        {
            _367 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_179, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _367 = _339;
        }
        _368 = _367;
    }
    else
    {
        _368 = _339;
    }
    float4 _374 = float4((mix(float3(0.0), _330 + (select(_322, float3(0.0), bool3(_325)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + _368) * 1.0, 0.0);
    float4 _381;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _380 = _374;
        _380.w = 0.0;
        _381 = _380;
    }
    else
    {
        _381 = _374;
    }
    float2 _385 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _393 = (_252 * 0.5) + float3(0.5);
    float4 _395 = float4(_393.x, _393.y, _393.z, float4(0.0).w);
    _395.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _200)].y;
    float4 _396 = float4(0.0);
    _396.x = _250;
    float4 _397 = _396;
    _397.y = _249;
    float4 _398 = _397;
    _398.z = _248;
    float4 _399 = _398;
    _399.w = 0.50588238239288330078125;
    float4 _402 = float4(_251.x, _251.y, _251.z, float4(0.0).w);
    _402.w = (fract(dot(_385.xyx * _385.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _381 * View.View_PreExposure;
    out.out_var_SV_Target1 = _395;
    out.out_var_SV_Target2 = _399;
    out.out_var_SV_Target3 = _402;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_301, 1.0, 1.0, 1.0);
    return out;
}

