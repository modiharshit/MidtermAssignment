

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

constant float _115 = {};

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

fragment MainPS_out Main_000028d3_64dc06c0(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _167 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _115, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _172 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _177 = (_172.xyz / float3(_172.w)) - View.View_PreViewTranslation;
    float3 _185 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _200 = fast::clamp(Material.Material_VectorExpressions[3].xyz, float3(0.0), float3(1.0));
    float _201 = fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0);
    float _206 = (fast::clamp(Material.Material_ScalarExpressions[0].z, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _207 = in.in_var_PRIMITIVE_ID * 36u;
    uint _208 = _207 + 20u;
    float _256;
    float _257;
    float _258;
    float3 _259;
    float3 _260;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _208)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _226 = ((_167.xy / float2(_167.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _230 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _226, level(0.0));
        float4 _233 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _226, level(0.0));
        float4 _236 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _226, level(0.0));
        float _246 = _236.w;
        _256 = (_206 * _246) + _236.z;
        _257 = (_201 * _246) + _236.y;
        _258 = _236.x;
        _259 = (_200 * _230.w) + _230.xyz;
        _260 = normalize((_185 * _233.w) + ((_233.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _256 = _206;
        _257 = _201;
        _258 = 0.0;
        _259 = _200;
        _260 = _185;
    }
    float _309;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _208)].z > 0.0)
    {
        float3 _277 = fast::clamp((_177 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _288 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_277.x), int(_277.y), int(_277.z), 0).xyz), 0));
        _309 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_288.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_277 / float3(_288.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _309 = 1.0;
    }
    float3 _323 = ((_259 - (_259 * _258)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _330 = (mix(float3(0.07999999821186065673828125 * _257), _259, float3(_258)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _333 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _338;
    if (_333)
    {
        _338 = _323 + (_330 * 0.449999988079071044921875);
    }
    else
    {
        _338 = _323;
    }
    float3 _347 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _376;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _375;
        if (any(abs(_177 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _207 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _207 + 19u)].xyz + float3(1.0))))
        {
            _375 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_177, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _375 = _347;
        }
        _376 = _375;
    }
    else
    {
        _376 = _347;
    }
    float4 _382 = float4((mix(float3(0.0), _338 + (select(_330, float3(0.0), bool3(_333)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + _376) * 1.0, 0.0);
    float4 _389;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _388 = _382;
        _388.w = 0.0;
        _389 = _388;
    }
    else
    {
        _389 = _382;
    }
    float2 _393 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _401 = (_260 * 0.5) + float3(0.5);
    float4 _403 = float4(_401.x, _401.y, _401.z, float4(0.0).w);
    _403.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _208)].y;
    float4 _404 = float4(0.0);
    _404.x = _258;
    float4 _405 = _404;
    _405.y = _257;
    float4 _406 = _405;
    _406.z = _256;
    float4 _407 = _406;
    _407.w = 0.50588238239288330078125;
    float4 _410 = float4(_259.x, _259.y, _259.z, float4(0.0).w);
    _410.w = (fract(dot(_393.xyx * _393.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _389 * View.View_PreExposure;
    out.out_var_SV_Target1 = _403;
    out.out_var_SV_Target2 = _407;
    out.out_var_SV_Target3 = _410;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_309, 1.0, 1.0, 1.0);
    return out;
}

