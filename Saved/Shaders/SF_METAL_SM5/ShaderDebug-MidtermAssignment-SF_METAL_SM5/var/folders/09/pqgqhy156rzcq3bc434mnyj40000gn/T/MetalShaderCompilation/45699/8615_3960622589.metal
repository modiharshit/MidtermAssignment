

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
    char _m2_pad[1040];
    float4 View_DiffuseOverrideParameter;
    char _m3_pad[88];
    float View_GameTime;
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_VoxelizeVolumePass
{
    char _m0_pad[256];
    float VoxelizeVolumePass_VolumetricFog_MaxDistance;
    char _m1_pad[32];
    float3 VoxelizeVolumePass_RenderVolumetricCloudParametersCloudLayerCenterKm;
    float VoxelizeVolumePass_RenderVolumetricCloudParametersBottomRadiusKm;
    float VoxelizeVolumePass_RenderVolumetricCloudParametersTopRadiusKm;
};

struct type_Material
{
    spvUnsafeArray<float4, 7> Material_VectorExpressions;
    spvUnsafeArray<float4, 6> Material_ScalarExpressions;
};

constant float4x4 _95 = {};

struct VoxelizePS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
    float4 out_var_SV_Target1 [[color(1)]];
};

struct VoxelizePS_in
{
    uint in_var_PRIMITIVE_ID [[user(locn2)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment VoxelizePS_out Main_000021a7_ec124dfd(VoxelizePS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_VoxelizeVolumePass& VoxelizeVolumePass [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> Material_Texture2D_0 [[texture(0)]], texture2d<float> Material_Texture2D_1 [[texture(1)]], texture3d<float> Material_VolumeTexture_0 [[texture(2)]], texture3d<float> Material_VolumeTexture_1 [[texture(3)]], sampler Material_Texture2D_0Sampler [[sampler(0)]], sampler Material_Texture2D_1Sampler [[sampler(1)]], sampler Material_VolumeTexture_0Sampler [[sampler(2)]], sampler Material_VolumeTexture_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    VoxelizePS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float _115 = VoxelizeVolumePass.VoxelizeVolumePass_RenderVolumetricCloudParametersBottomRadiusKm * 100000.0;
    float4 _123 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _128 = (_123.xyz / float3(_123.w)) - View.View_PreViewTranslation;
    float _133 = fast::clamp((length(_128 - (VoxelizeVolumePass.VoxelizeVolumePass_RenderVolumetricCloudParametersCloudLayerCenterKm * 100000.0)) - _115) * (1.0 / ((VoxelizeVolumePass.VoxelizeVolumePass_RenderVolumetricCloudParametersTopRadiusKm * 100000.0) - _115)), 0.0, 1.0);
    float4 _143 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (((_128 + float3(500000.0, 500000.0, 0.0)).xy * Material.Material_ScalarExpressions[5].y) * Material.Material_ScalarExpressions[5].y), level(-1.0));
    float _144 = _143.y;
    float3 _167 = Material.Material_VectorExpressions[2].xyz * View.View_GameTime;
    float3 _171 = _128 * Material.Material_ScalarExpressions[0].x;
    float4 _179 = Material_VolumeTexture_0.sample(Material_VolumeTexture_0Sampler, (((_167 * 0.1500000059604644775390625) + _171) * Material.Material_ScalarExpressions[0].y), level(-1.0));
    float _182 = _179.x;
    float _186 = _179.y;
    float _190 = _179.z;
    float3 _196 = float3(((_133 < 0.0500000007450580596923828125) || (_133 > 0.949999988079071044921875)) ? 0.0 : (_143.x * Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2((_144 <= 0.0) ? 0.0 : pow(_144, 0.25), 1.0 - _133), level(-1.0)).x)) * fast::clamp(float3((_182 <= 0.0) ? 0.0 : pow(_182, Material.Material_ScalarExpressions[0].z), (_186 <= 0.0) ? 0.0 : pow(_186, Material.Material_ScalarExpressions[0].z), (_190 <= 0.0) ? 0.0 : pow(_190, Material.Material_ScalarExpressions[0].z)), float3(0.0), float3(1.0));
    float4 _205 = Material_VolumeTexture_1.sample(Material_VolumeTexture_1Sampler, ((_171 + (_167 * (-0.100000001490116119384765625))) * Material.Material_ScalarExpressions[0].w), level(-1.0));
    float _206 = _205.x;
    float _214 = ((_206 <= 0.0) ? 0.0 : pow(_206, Material.Material_ScalarExpressions[1].x)) * Material.Material_ScalarExpressions[1].y;
    float _232 = fast::clamp(_133 * Material.Material_ScalarExpressions[2].x, 0.0, 1.0);
    float3 _241 = mix(_196, float3((float3(Material.Material_ScalarExpressions[1].w) + (fast::clamp((_196 - float3(_214)) / float3(Material.Material_ScalarExpressions[1].z - _214), float3(0.0), float3(1.0)) * (Material.Material_ScalarExpressions[1].z - Material.Material_ScalarExpressions[1].w))).x), float3((_232 <= 0.0) ? 0.0 : pow(_232, Material.Material_ScalarExpressions[2].y)));
    float3 _249 = fast::clamp((Material.Material_VectorExpressions[3].xyz * _241) * Material.Material_ScalarExpressions[2].z, float3(0.0), float3(1.0));
    float _252 = _249.x;
    float _256 = _249.y;
    float _260 = _249.z;
    float _278 = fast::clamp((Material.Material_VectorExpressions[6].xyz * _241).x, 0.0, 65000.0);
    float3 _279 = ((fast::clamp(float3((_252 <= 0.0) ? 0.0 : pow(_252, Material.Material_ScalarExpressions[2].w), (_256 <= 0.0) ? 0.0 : pow(_256, Material.Material_ScalarExpressions[2].w), (_260 <= 0.0) ? 0.0 : pow(_260, Material.Material_ScalarExpressions[2].w)), float3(0.0), float3(1.0)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz) * _278;
    float _289 = 1.0 - fast::clamp((((1.0 / gl_FragCoord.w) / VoxelizeVolumePass.VoxelizeVolumePass_VolumetricFog_MaxDistance) - 0.60000002384185791015625) * 2.5000002384185791015625, 0.0, 1.0);
    uint _293 = in.in_var_PRIMITIVE_ID * 36u;
    float4x4 _309 = _95;
    _309[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _293 + 6u)];
    float4x4 _313 = _309;
    _313[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _293 + 7u)];
    float4x4 _317 = _313;
    _317[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _293 + 8u)];
    float4x4 _321 = _317;
    _321[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _293 + 9u)];
    float3 _323 = (_321 * float4(_128, 1.0)).xyz;
    bool3 _324 = _323 < View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _293 + 23u)].xyz;
    bool3 _325 = _323 > View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _293 + 24u)].xyz;
    float _329 = (((0.00999999977648258209228515625 * _289) * _289) * _289) * (any(bool3(_324.x || _325.x, _324.y || _325.y, _324.z || _325.z)) ? 0.0 : 1.0);
    out.out_var_SV_Target0 = float4(_279 * _329, fast::max(_278 - dot(_279, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), 0.0) * _329);
    out.out_var_SV_Target1 = float4(0.0);
    return out;
}

