

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
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
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

fragment MainPS_out Main_00002e99_d019c47d(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _179 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _127, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _184 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _189 = (_184.xyz / float3(_184.w)) - View.View_PreViewTranslation;
    float3 _197 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    uint _206 = in.in_var_PRIMITIVE_ID * 36u;
    uint _207 = _206 + 20u;
    float _252;
    float _253;
    float _254;
    float3 _255;
    float3 _256;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _207)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _225 = ((_179.xy / float2(_179.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _232 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _225, level(0.0));
        float4 _235 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _225, level(0.0));
        float _244 = _235.w;
        _252 = (View.View_RoughnessOverrideParameter.x * _244) + _235.z;
        _253 = (0.5 * _244) + _235.y;
        _254 = _235.x;
        _255 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _225, level(0.0)).xyz;
        _256 = normalize((_197 * _232.w) + ((_232.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _252 = View.View_RoughnessOverrideParameter.x;
        _253 = 0.5;
        _254 = 0.0;
        _255 = float3(0.0);
        _256 = _197;
    }
    float _305;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _207)].z > 0.0)
    {
        float3 _273 = fast::clamp((_189 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
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
    float4 _340 = float4(_256, 1.0);
    float3 _344 = _128;
    _344.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _340);
    float3 _348 = _344;
    _348.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _340);
    float3 _352 = _348;
    _352.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _340);
    float4 _355 = _340.xyzz * _340.yzzx;
    float3 _359 = _128;
    _359.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _355);
    float3 _363 = _359;
    _363.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _355);
    float3 _367 = _363;
    _367.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _355);
    float3 _401 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _430;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _429;
        if (any(abs(_189 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _206 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _206 + 19u)].xyz + float3(1.0))))
        {
            _429 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_189, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _429 = _401;
        }
        _430 = _429;
    }
    else
    {
        _430 = _401;
    }
    float4 _437 = float4(((mix(float3(0.0), _334 + (select(_326, float3(0.0), bool3(_329)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((((fast::max(float3(0.0), (_352 + _367) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_256.x * _256.x) - (_256.y * _256.y)))) * View.View_SkyLightColor.xyz) * 1.0) * _334) * fast::max(float3(1.0), ((((((_255 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_255 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_255 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _430) * 1.0, 0.0);
    float4 _444;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _443 = _437;
        _443.w = 0.0;
        _444 = _443;
    }
    else
    {
        _444 = _437;
    }
    float2 _448 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _456 = (_256 * 0.5) + float3(0.5);
    float4 _458 = float4(_456.x, _456.y, _456.z, float4(0.0).w);
    _458.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _207)].y;
    float4 _459 = float4(0.0);
    _459.x = _254;
    float4 _460 = _459;
    _460.y = _253;
    float4 _461 = _460;
    _461.z = _252;
    float4 _462 = _461;
    _462.w = 0.50588238239288330078125;
    float4 _465 = float4(_255.x, _255.y, _255.z, float4(0.0).w);
    _465.w = (fract(dot(_448.xyx * _448.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _444 * View.View_PreExposure;
    out.out_var_SV_Target1 = _458;
    out.out_var_SV_Target2 = _462;
    out.out_var_SV_Target3 = _465;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_305, 1.0, 1.0, 1.0);
    return out;
}

