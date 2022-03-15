

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

fragment MainPS_out Main_00003131_00e21057(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> Material_Texture2D_0 [[texture(2)]], texture2d<float> Material_Texture2D_1 [[texture(3)]], texture2d<float> Material_Texture2D_2 [[texture(4)]], texture2d<float> Material_Texture2D_3 [[texture(5)]], sampler View_MaterialTextureBilinearWrapedSampler [[sampler(0)]], sampler View_SharedBilinearClampedSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
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
    float4 _247 = Material_Texture2D_2.sample(View_MaterialTextureBilinearWrapedSampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 50.0));
    float3 _251 = float3(_229.x);
    float4 _256 = Material_Texture2D_3.sample(View_MaterialTextureBilinearWrapedSampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 8.0));
    float3 _260 = float3(_229.z);
    float3 _263 = float3(_229.w);
    float3 _278 = fast::clamp(mix(mix(mix(mix(Material.Material_VectorExpressions[3].xyz, Material.Material_VectorExpressions[3].xyz, float3(_229.y)), _247.xyz * float3(0.2249999940395355224609375), _251), _256.xyz * float3(0.25), _260), float3(0.0), _263), float3(0.0), float3(1.0));
    float _279 = fast::clamp(mix(mix(float3(0.0), float3(1.0), _260), float3(0.0), _263).x, 0.0, 1.0);
    uint _285 = in.in_var_PRIMITIVE_ID * 36u;
    uint _286 = _285 + 20u;
    float _336;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _286)].z > 0.0)
    {
        float3 _304 = fast::clamp((_188 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _315 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_304.x), int(_304.y), int(_304.z), 0).xyz), 0));
        _336 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_315.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_304 / float3(_315.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _336 = 1.0;
    }
    float3 _348 = ((_278 - (_278 * _279)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _355 = (mix(float3(0.039999999105930328369140625), _278, float3(_279)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _358 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _363;
    if (_358)
    {
        _363 = _348 + (_355 * 0.449999988079071044921875);
    }
    else
    {
        _363 = _348;
    }
    float _366 = _225.x;
    float _367 = _225.y;
    float4 _369 = float4(_366, _367, _225.z, 1.0);
    float3 _373 = _144;
    _373.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _369);
    float3 _377 = _373;
    _377.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _369);
    float3 _381 = _377;
    _381.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _369);
    float4 _384 = _369.xyzz * _369.yzzx;
    float3 _388 = _144;
    _388.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _384);
    float3 _392 = _388;
    _392.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _384);
    float3 _396 = _392;
    _396.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _384);
    float3 _430 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _459;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _458;
        if (any(abs(_188 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _285 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _285 + 19u)].xyz + float3(1.0))))
        {
            _458 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_188, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _458 = _430;
        }
        _459 = _458;
    }
    else
    {
        _459 = _430;
    }
    float4 _466 = float4(((mix(float3(0.0), _363 + (select(_355, float3(0.0), bool3(_358)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((((fast::max(float3(0.0), (_381 + _396) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_366 * _366) - (_367 * _367)))) * View.View_SkyLightColor.xyz) * 1.0) * _363) * fast::max(float3(1.0), ((((((_278 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_278 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_278 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _459) * 1.0, 0.0);
    float4 _473;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _472 = _466;
        _472.w = 0.0;
        _473 = _472;
    }
    else
    {
        _473 = _466;
    }
    float2 _478 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _486 = (_225 * 0.5) + float3(0.5);
    float4 _488 = float4(_486.x, _486.y, _486.z, float4(0.0).w);
    _488.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _286)].y;
    float4 _489 = float4(0.0);
    _489.x = _279;
    float4 _490 = _489;
    _490.y = 0.5;
    float4 _491 = _490;
    _491.z = (fast::clamp(mix(mix(mix(float3(0.100000001490116119384765625), float3(mix(0.550000011920928955078125, 0.75, _247.x)), _251), float3(mix(0.37999999523162841796875, 0.550000011920928955078125, _256.x)), _260), float3(0.100000001490116119384765625), _263).x, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float4 _492 = _491;
    _492.w = 0.50588238239288330078125;
    float4 _495 = float4(_278.x, _278.y, _278.z, float4(0.0).w);
    _495.w = (fract(dot(_478.xyx * _478.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _473 * View.View_PreExposure;
    out.out_var_SV_Target1 = _488;
    out.out_var_SV_Target2 = _492;
    out.out_var_SV_Target3 = _495;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_336, 1.0, 1.0, 1.0);
    return out;
}

