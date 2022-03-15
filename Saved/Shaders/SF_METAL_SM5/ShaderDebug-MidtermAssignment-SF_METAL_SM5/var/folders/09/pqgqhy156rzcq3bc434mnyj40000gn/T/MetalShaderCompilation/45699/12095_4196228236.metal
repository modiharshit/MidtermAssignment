

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
    char _m13_pad[48];
    float4 View_SkyLightColor;
    char _m14_pad[124];
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
    spvUnsafeArray<float4, 4> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float _127 = {};
constant float3 _128 = {};

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

fragment MainPS_out Main_00002f3f_fa1d5c8c(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _179 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _127, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _184 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _189 = (_184.xyz / float3(_184.w)) - View.View_PreViewTranslation;
    float3 _197 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _208 = fast::clamp(Material.Material_VectorExpressions[3].xyz, float3(0.0), float3(1.0));
    float _212 = (0.5 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _213 = in.in_var_PRIMITIVE_ID * 36u;
    uint _214 = _213 + 20u;
    float _262;
    float _263;
    float _264;
    float3 _265;
    float3 _266;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _214)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _232 = ((_179.xy / float2(_179.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _236 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _232, level(0.0));
        float4 _239 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _232, level(0.0));
        float4 _242 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _232, level(0.0));
        float _252 = _242.w;
        _262 = (_212 * _252) + _242.z;
        _263 = (0.5 * _252) + _242.y;
        _264 = _242.x;
        _265 = (_208 * _236.w) + _236.xyz;
        _266 = normalize((_197 * _239.w) + ((_239.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _262 = _212;
        _263 = 0.5;
        _264 = 0.0;
        _265 = _208;
        _266 = _197;
    }
    float _315;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _214)].z > 0.0)
    {
        float3 _283 = fast::clamp((_189 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _294 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_283.x), int(_283.y), int(_283.z), 0).xyz), 0));
        _315 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_294.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_283 / float3(_294.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _315 = 1.0;
    }
    float3 _329 = ((_265 - (_265 * _264)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _336 = (mix(float3(0.07999999821186065673828125 * _263), _265, float3(_264)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _339 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _344;
    if (_339)
    {
        _344 = _329 + (_336 * 0.449999988079071044921875);
    }
    else
    {
        _344 = _329;
    }
    float4 _350 = float4(_266, 1.0);
    float3 _354 = _128;
    _354.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _350);
    float3 _358 = _354;
    _358.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _350);
    float3 _362 = _358;
    _362.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _350);
    float4 _365 = _350.xyzz * _350.yzzx;
    float3 _369 = _128;
    _369.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _365);
    float3 _373 = _369;
    _373.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _365);
    float3 _377 = _373;
    _377.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _365);
    float3 _411 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _440;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _439;
        if (any(abs(_189 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _213 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _213 + 19u)].xyz + float3(1.0))))
        {
            _439 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_189, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _439 = _411;
        }
        _440 = _439;
    }
    else
    {
        _440 = _411;
    }
    float4 _447 = float4(((mix(float3(0.0), _344 + (select(_336, float3(0.0), bool3(_339)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((((fast::max(float3(0.0), (_362 + _377) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_266.x * _266.x) - (_266.y * _266.y)))) * View.View_SkyLightColor.xyz) * 1.0) * _344) * fast::max(float3(1.0), ((((((_265 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_265 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_265 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _440) * 1.0, 0.0);
    float4 _454;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _453 = _447;
        _453.w = 0.0;
        _454 = _453;
    }
    else
    {
        _454 = _447;
    }
    float2 _458 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _466 = (_266 * 0.5) + float3(0.5);
    float4 _468 = float4(_466.x, _466.y, _466.z, float4(0.0).w);
    _468.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _214)].y;
    float4 _469 = float4(0.0);
    _469.x = _264;
    float4 _470 = _469;
    _470.y = _263;
    float4 _471 = _470;
    _471.z = _262;
    float4 _472 = _471;
    _472.w = 0.50588238239288330078125;
    float4 _475 = float4(_265.x, _265.y, _265.z, float4(0.0).w);
    _475.w = (fract(dot(_458.xyx * _458.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _454 * View.View_PreExposure;
    out.out_var_SV_Target1 = _468;
    out.out_var_SV_Target2 = _472;
    out.out_var_SV_Target3 = _475;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_315, 1.0, 1.0, 1.0);
    return out;
}

