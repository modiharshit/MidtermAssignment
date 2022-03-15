

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

constant float _116 = {};

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

fragment MainPS_out Main_00002839_2f39b1af(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _168 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _116, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _173 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _178 = (_173.xyz / float3(_173.w)) - View.View_PreViewTranslation;
    float3 _186 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float _197 = (0.300000011920928955078125 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _198 = in.in_var_PRIMITIVE_ID * 36u;
    uint _199 = _198 + 20u;
    float _247;
    float _248;
    float _249;
    float3 _250;
    float3 _251;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _199)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _217 = ((_168.xy / float2(_168.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _221 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _217, level(0.0));
        float4 _224 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _217, level(0.0));
        float4 _227 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _217, level(0.0));
        float _237 = _227.w;
        _247 = (_197 * _237) + _227.z;
        _248 = (0.5 * _237) + _227.y;
        _249 = _227.x;
        _250 = (float3(0.300000011920928955078125) * _221.w) + _221.xyz;
        _251 = normalize((_186 * _224.w) + ((_224.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _247 = _197;
        _248 = 0.5;
        _249 = 0.0;
        _250 = float3(0.300000011920928955078125);
        _251 = _186;
    }
    float _300;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _199)].z > 0.0)
    {
        float3 _268 = fast::clamp((_178 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _279 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_268.x), int(_268.y), int(_268.z), 0).xyz), 0));
        _300 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_279.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_268 / float3(_279.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _300 = 1.0;
    }
    float3 _314 = ((_250 - (_250 * _249)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _321 = (mix(float3(0.07999999821186065673828125 * _248), _250, float3(_249)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _324 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _329;
    if (_324)
    {
        _329 = _314 + (_321 * 0.449999988079071044921875);
    }
    else
    {
        _329 = _314;
    }
    float3 _338 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _367;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _366;
        if (any(abs(_178 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _198 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _198 + 19u)].xyz + float3(1.0))))
        {
            _366 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_178, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _366 = _338;
        }
        _367 = _366;
    }
    else
    {
        _367 = _338;
    }
    float4 _373 = float4((mix(float3(0.0), _329 + (select(_321, float3(0.0), bool3(_324)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + _367) * 1.0, 0.0);
    float4 _380;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _379 = _373;
        _379.w = 0.0;
        _380 = _379;
    }
    else
    {
        _380 = _373;
    }
    float2 _384 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _392 = (_251 * 0.5) + float3(0.5);
    float4 _394 = float4(_392.x, _392.y, _392.z, float4(0.0).w);
    _394.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _199)].y;
    float4 _395 = float4(0.0);
    _395.x = _249;
    float4 _396 = _395;
    _396.y = _248;
    float4 _397 = _396;
    _397.z = _247;
    float4 _398 = _397;
    _398.w = 0.50588238239288330078125;
    float4 _401 = float4(_250.x, _250.y, _250.z, float4(0.0).w);
    _401.w = (fract(dot(_384.xyx * _384.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _380 * View.View_PreExposure;
    out.out_var_SV_Target1 = _394;
    out.out_var_SV_Target2 = _398;
    out.out_var_SV_Target3 = _401;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_300, 1.0, 1.0, 1.0);
    return out;
}

