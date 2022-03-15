

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
    char _m1_pad[352];
    float3 View_PreViewTranslation;
    char _m2_pad[1028];
    float View_PreExposure;
    float4 View_DiffuseOverrideParameter;
    float4 View_SpecularOverrideParameter;
    float4 View_NormalOverrideParameter;
    float2 View_RoughnessOverrideParameter;
    char _m7_pad[8];
    float View_OutOfBoundsMask;
    char _m8_pad[48];
    float View_MaterialTextureMipBias;
    char _m9_pad[28];
    float View_UnlitViewmodeMask;
    char _m10_pad[612];
    float View_RenderingReflectionCaptureMask;
    char _m11_pad[48];
    float4 View_SkyLightColor;
    char _m12_pad[312];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m13_pad[48];
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

constant float3 _144 = {};

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

fragment MainPS_out Main_000030cb_7b884a07(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> Material_Texture2D_0 [[texture(2)]], texture2d<float> Material_Texture2D_1 [[texture(3)]], texture2d<float> Material_Texture2D_2 [[texture(4)]], texture2d<float> Material_Texture2D_3 [[texture(5)]], sampler View_MaterialTextureBilinearWrapedSampler [[sampler(0)]], sampler View_SharedBilinearClampedSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _183 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _188 = (_183.xyz / float3(_183.w)) - View.View_PreViewTranslation;
    float4 _194 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _197 = (_194.xy * float2(2.0)) - float2(1.0);
    float _201 = sqrt(fast::clamp(1.0 - dot(_197, _197), 0.0, 1.0));
    float3 _209 = float3(float4(_197, _201, 1.0).xy * (-1.0), _201);
    float3 _213 = (float3(0.0, 0.0, 2.0) * dot(float3(0.0, 0.0, 2.0), _209)) - (_209 * 2.0);
    float3 _225 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize(((_213 / float3(sqrt(dot(_213, _213)))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _229 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _247 = Material_Texture2D_2.sample(View_MaterialTextureBilinearWrapedSampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 8.0));
    float3 _251 = float3(_229.x);
    float4 _256 = Material_Texture2D_3.sample(View_MaterialTextureBilinearWrapedSampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 50.0));
    float3 _260 = float3(_229.z);
    float3 _274 = fast::clamp(mix(mix(mix(Material.Material_VectorExpressions[3].xyz, Material.Material_VectorExpressions[3].xyz, float3(_229.y)), _247.xyz * float3(0.25), _251), _256.xyz * float3(0.2249999940395355224609375), _260), float3(0.0), float3(1.0));
    float _275 = fast::clamp(mix(mix(float3(0.0), float3(1.0), _251), float3(0.0), _260).x, 0.0, 1.0);
    uint _281 = in.in_var_PRIMITIVE_ID * 36u;
    uint _282 = _281 + 20u;
    float _332;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _282)].z > 0.0)
    {
        float3 _300 = fast::clamp((_188 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _311 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_300.x), int(_300.y), int(_300.z), 0).xyz), 0));
        _332 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_311.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_300 / float3(_311.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _332 = 1.0;
    }
    float3 _344 = ((_274 - (_274 * _275)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _351 = (mix(float3(0.039999999105930328369140625), _274, float3(_275)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _354 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _359;
    if (_354)
    {
        _359 = _344 + (_351 * 0.449999988079071044921875);
    }
    else
    {
        _359 = _344;
    }
    float _362 = _225.x;
    float _363 = _225.y;
    float4 _365 = float4(_362, _363, _225.z, 1.0);
    float3 _369 = _144;
    _369.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _365);
    float3 _373 = _369;
    _373.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _365);
    float3 _377 = _373;
    _377.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _365);
    float4 _380 = _365.xyzz * _365.yzzx;
    float3 _384 = _144;
    _384.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _380);
    float3 _388 = _384;
    _388.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _380);
    float3 _392 = _388;
    _392.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _380);
    float3 _426 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _455;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _454;
        if (any(abs(_188 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _281 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _281 + 19u)].xyz + float3(1.0))))
        {
            _454 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_188, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _454 = _426;
        }
        _455 = _454;
    }
    else
    {
        _455 = _426;
    }
    float4 _462 = float4(((mix(float3(0.0), _359 + (select(_351, float3(0.0), bool3(_354)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((((fast::max(float3(0.0), (_377 + _392) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_362 * _362) - (_363 * _363)))) * View.View_SkyLightColor.xyz) * 1.0) * _359) * fast::max(float3(1.0), ((((((_274 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_274 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_274 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _455) * 1.0, 0.0);
    float4 _469;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _468 = _462;
        _468.w = 0.0;
        _469 = _468;
    }
    else
    {
        _469 = _462;
    }
    float2 _474 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _482 = (_225 * 0.5) + float3(0.5);
    float4 _484 = float4(_482.x, _482.y, _482.z, float4(0.0).w);
    _484.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _282)].y;
    float4 _485 = float4(0.0);
    _485.x = _275;
    float4 _486 = _485;
    _486.y = 0.5;
    float4 _487 = _486;
    _487.z = (fast::clamp(mix(mix(float3(0.100000001490116119384765625), float3(mix(0.37999999523162841796875, 0.550000011920928955078125, _247.x)), _251), float3(mix(0.550000011920928955078125, 0.75, _256.x)), _260).x, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float4 _488 = _487;
    _488.w = 0.50588238239288330078125;
    float4 _491 = float4(_274.x, _274.y, _274.z, float4(0.0).w);
    _491.w = (fract(dot(_474.xyx * _474.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _469 * View.View_PreExposure;
    out.out_var_SV_Target1 = _484;
    out.out_var_SV_Target2 = _488;
    out.out_var_SV_Target3 = _491;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_332, 1.0, 1.0, 1.0);
    return out;
}

