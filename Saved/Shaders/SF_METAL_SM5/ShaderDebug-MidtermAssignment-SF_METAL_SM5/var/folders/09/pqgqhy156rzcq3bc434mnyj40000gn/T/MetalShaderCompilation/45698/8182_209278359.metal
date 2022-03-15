

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

fragment VoxelizePS_out Main_00001ff6_0c795597(VoxelizePS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_VoxelizeVolumePass& VoxelizeVolumePass [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> Material_Texture2D_0 [[texture(0)]], texture2d<float> Material_Texture2D_1 [[texture(1)]], texture3d<float> Material_VolumeTexture_0 [[texture(2)]], texture3d<float> Material_VolumeTexture_1 [[texture(3)]], sampler Material_Texture2D_0Sampler [[sampler(0)]], sampler Material_Texture2D_1Sampler [[sampler(1)]], sampler Material_VolumeTexture_0Sampler [[sampler(2)]], sampler Material_VolumeTexture_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    VoxelizePS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float _110 = VoxelizeVolumePass.VoxelizeVolumePass_RenderVolumetricCloudParametersBottomRadiusKm * 100000.0;
    float4 _118 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _123 = (_118.xyz / float3(_118.w)) - View.View_PreViewTranslation;
    float _128 = fast::clamp((length(_123 - (VoxelizeVolumePass.VoxelizeVolumePass_RenderVolumetricCloudParametersCloudLayerCenterKm * 100000.0)) - _110) * (1.0 / ((VoxelizeVolumePass.VoxelizeVolumePass_RenderVolumetricCloudParametersTopRadiusKm * 100000.0) - _110)), 0.0, 1.0);
    float4 _138 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (((_123 + float3(500000.0, 500000.0, 0.0)).xy * Material.Material_ScalarExpressions[5].y) * Material.Material_ScalarExpressions[5].y), level(-1.0));
    float _139 = _138.y;
    float3 _162 = Material.Material_VectorExpressions[2].xyz * View.View_GameTime;
    float3 _166 = _123 * Material.Material_ScalarExpressions[0].x;
    float4 _174 = Material_VolumeTexture_0.sample(Material_VolumeTexture_0Sampler, (((_162 * 0.1500000059604644775390625) + _166) * Material.Material_ScalarExpressions[0].y), level(-1.0));
    float _177 = _174.x;
    float _181 = _174.y;
    float _185 = _174.z;
    float3 _191 = float3(((_128 < 0.0500000007450580596923828125) || (_128 > 0.949999988079071044921875)) ? 0.0 : (_138.x * Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2((_139 <= 0.0) ? 0.0 : pow(_139, 0.25), 1.0 - _128), level(-1.0)).x)) * fast::clamp(float3((_177 <= 0.0) ? 0.0 : pow(_177, Material.Material_ScalarExpressions[0].z), (_181 <= 0.0) ? 0.0 : pow(_181, Material.Material_ScalarExpressions[0].z), (_185 <= 0.0) ? 0.0 : pow(_185, Material.Material_ScalarExpressions[0].z)), float3(0.0), float3(1.0));
    float4 _200 = Material_VolumeTexture_1.sample(Material_VolumeTexture_1Sampler, ((_166 + (_162 * (-0.100000001490116119384765625))) * Material.Material_ScalarExpressions[0].w), level(-1.0));
    float _201 = _200.x;
    float _209 = ((_201 <= 0.0) ? 0.0 : pow(_201, Material.Material_ScalarExpressions[1].x)) * Material.Material_ScalarExpressions[1].y;
    float _227 = fast::clamp(_128 * Material.Material_ScalarExpressions[2].x, 0.0, 1.0);
    float3 _236 = mix(_191, float3((float3(Material.Material_ScalarExpressions[1].w) + (fast::clamp((_191 - float3(_209)) / float3(Material.Material_ScalarExpressions[1].z - _209), float3(0.0), float3(1.0)) * (Material.Material_ScalarExpressions[1].z - Material.Material_ScalarExpressions[1].w))).x), float3((_227 <= 0.0) ? 0.0 : pow(_227, Material.Material_ScalarExpressions[2].y)));
    float3 _244 = fast::clamp((Material.Material_VectorExpressions[3].xyz * _236) * Material.Material_ScalarExpressions[2].z, float3(0.0), float3(1.0));
    float _247 = _244.x;
    float _251 = _244.y;
    float _255 = _244.z;
    float _273 = fast::clamp((Material.Material_VectorExpressions[6].xyz * _236).x, 0.0, 65000.0);
    float3 _274 = ((fast::clamp(float3((_247 <= 0.0) ? 0.0 : pow(_247, Material.Material_ScalarExpressions[2].w), (_251 <= 0.0) ? 0.0 : pow(_251, Material.Material_ScalarExpressions[2].w), (_255 <= 0.0) ? 0.0 : pow(_255, Material.Material_ScalarExpressions[2].w)), float3(0.0), float3(1.0)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz) * _273;
    float _284 = 1.0 - fast::clamp((((1.0 / gl_FragCoord.w) / VoxelizeVolumePass.VoxelizeVolumePass_VolumetricFog_MaxDistance) - 0.60000002384185791015625) * 2.5000002384185791015625, 0.0, 1.0);
    uint _289 = (in.in_var_PRIMITIVE_ID * 36u) + 5u;
    float3 _301 = (float4(View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _289)].xyz + View.View_PreViewTranslation, View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _289)].w).xyz - View.View_PreViewTranslation) - _123;
    float _306 = (((0.00999999977648258209228515625 * _284) * _284) * _284) * ((dot(_301, _301) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _289)].w * View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _289)].w)) ? 0.0 : 1.0);
    out.out_var_SV_Target0 = float4(_274 * _306, fast::max(_273 - dot(_274, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), 0.0) * _306);
    out.out_var_SV_Target1 = float4(0.0);
    return out;
}

