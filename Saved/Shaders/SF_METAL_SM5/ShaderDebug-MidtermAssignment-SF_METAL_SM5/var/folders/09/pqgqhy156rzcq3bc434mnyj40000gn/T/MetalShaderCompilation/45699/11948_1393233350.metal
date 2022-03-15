

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

struct type_PrimitiveDither
{
    float PrimitiveDither_LODFactor;
};

struct type_Material
{
    spvUnsafeArray<float4, 7> Material_VectorExpressions;
    spvUnsafeArray<float4, 2> Material_ScalarExpressions;
};

constant float _132 = {};

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

fragment MainPS_out Main_00002eac_530b0dc6(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_PrimitiveDither& PrimitiveDither [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], sampler View_MaterialTextureBilinearClampedSampler [[sampler(0)]], sampler View_SharedBilinearClampedSampler [[sampler(1)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _187 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _132, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _192 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _197 = (_192.xyz / float3(_192.w)) - View.View_PreViewTranslation;
    float4 _201 = Material_Texture2D_0.sample(View_MaterialTextureBilinearClampedSampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y));
    float2 _204 = (_201.xy * float2(2.0)) - float2(1.0);
    float3 _220 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_204, sqrt(fast::clamp(1.0 - dot(_204, _204), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    if (PrimitiveDither.PrimitiveDither_LODFactor != 0.0)
    {
        if (abs(PrimitiveDither.PrimitiveDither_LODFactor) > 0.001000000047497451305389404296875)
        {
            float _253 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
            if ((float((PrimitiveDither.PrimitiveDither_LODFactor < 0.0) ? ((PrimitiveDither.PrimitiveDither_LODFactor + 1.0) > _253) : (PrimitiveDither.PrimitiveDither_LODFactor < _253)) - 0.001000000047497451305389404296875) < 0.0)
            {
                discard_fragment();
            }
        }
    }
    float3 _264 = fast::clamp(Material.Material_VectorExpressions[6].xyz, float3(0.0), float3(1.0));
    float _265 = fast::clamp(Material.Material_ScalarExpressions[0].z, 0.0, 1.0);
    float _266 = fast::clamp(Material.Material_ScalarExpressions[0].w, 0.0, 1.0);
    float _271 = (fast::clamp(Material.Material_ScalarExpressions[1].x, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _272 = in.in_var_PRIMITIVE_ID * 36u;
    uint _273 = _272 + 20u;
    float _323;
    float _324;
    float _325;
    float3 _326;
    float3 _327;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _273)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _291 = ((_187.xy / float2(_187.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _295 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _291, level(0.0));
        float4 _298 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _291, level(0.0));
        float4 _301 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _291, level(0.0));
        float _311 = _301.w;
        _323 = (_271 * _311) + _301.z;
        _324 = (_266 * _311) + _301.y;
        _325 = (_265 * _311) + _301.x;
        _326 = (_264 * _295.w) + _295.xyz;
        _327 = normalize((_220 * _298.w) + ((_298.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _323 = _271;
        _324 = _266;
        _325 = _265;
        _326 = _264;
        _327 = _220;
    }
    float _376;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _273)].z > 0.0)
    {
        float3 _344 = fast::clamp((_197 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _355 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_344.x), int(_344.y), int(_344.z), 0).xyz), 0));
        _376 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_355.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_344 / float3(_355.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _376 = 1.0;
    }
    float3 _390 = ((_326 - (_326 * _325)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _397 = (mix(float3(0.07999999821186065673828125 * _324), _326, float3(_325)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _400 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _405;
    if (_400)
    {
        _405 = _390 + (_397 * 0.449999988079071044921875);
    }
    else
    {
        _405 = _390;
    }
    float3 _414 = fast::max(mix(Material.Material_VectorExpressions[3].xyz, Material.Material_VectorExpressions[4].xyz, float3(Material.Material_ScalarExpressions[0].y)), float3(0.0));
    float3 _443;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _442;
        if (any(abs(_197 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _272 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _272 + 19u)].xyz + float3(1.0))))
        {
            _442 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_197, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _442 = _414;
        }
        _443 = _442;
    }
    else
    {
        _443 = _414;
    }
    float4 _449 = float4((mix(float3(0.0), _405 + (select(_397, float3(0.0), bool3(_400)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + _443) * 1.0, 0.0);
    float4 _456;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _455 = _449;
        _455.w = 0.0;
        _456 = _455;
    }
    else
    {
        _456 = _449;
    }
    float2 _460 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _468 = (_327 * 0.5) + float3(0.5);
    float4 _470 = float4(_468.x, _468.y, _468.z, float4(0.0).w);
    _470.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _273)].y;
    float4 _471 = float4(0.0);
    _471.x = _325;
    float4 _472 = _471;
    _472.y = _324;
    float4 _473 = _472;
    _473.z = _323;
    float4 _474 = _473;
    _474.w = 0.50588238239288330078125;
    float4 _477 = float4(_326.x, _326.y, _326.z, float4(0.0).w);
    _477.w = (fract(dot(_460.xyx * _460.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _456 * View.View_PreExposure;
    out.out_var_SV_Target1 = _470;
    out.out_var_SV_Target2 = _474;
    out.out_var_SV_Target3 = _477;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_376, 1.0, 1.0, 1.0);
    return out;
}

