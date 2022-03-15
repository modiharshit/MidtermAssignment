

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
    char _m0_pad[192];
    float4x4 View_TranslatedWorldToView;
    char _m1_pad[864];
    float3 View_PreViewTranslation;
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_VoxelizeVolumePass
{
    char _m0_pad[112];
    float4x4 VoxelizeVolumePass_ViewToVolumeClip;
    float4 VoxelizeVolumePass_FrameJitterOffset0;
    char _m2_pad[16];
    float3 VoxelizeVolumePass_VolumetricFog_GridSize;
    float3 VoxelizeVolumePass_VolumetricFog_GridZParams;
};

struct type_LocalVF
{
    int4 LocalVF_VertexFetch_Parameters;
};

struct type_Globals
{
    uint VoxelizationPassIndex;
};

constant float3x3 _63 = {};
constant uint _64 = {};
constant float4 _65 = {};

struct VoxelizeVS_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    uint out_var_PRIMITIVE_ID [[user(locn2)]];
    float4 gl_Position [[position, invariant]];
    uint gl_Layer [[render_target_array_index]];
};

struct VoxelizeVS_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    uint in_var_ATTRIBUTE13 [[attribute(13)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

vertex VoxelizeVS_out Main_000024fc_8bf78c54(VoxelizeVS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(6)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_VoxelizeVolumePass& VoxelizeVolumePass [[buffer(3)]], constant type_LocalVF& LocalVF [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    VoxelizeVS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[1];
    uint _81 = 2u * (uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex));
    float4 _86 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_81 + 1u)));
    float _87 = _86.w;
    float3 _88 = _86.xyz;
    float3 _90 = cross(_88, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_81)).xyz) * _87;
    float3x3 _93 = _63;
    _93[0] = cross(_90, _88) * _87;
    float3x3 _94 = _93;
    _94[1] = _90;
    float3x3 _95 = _94;
    _95[2] = _88;
    uint _96 = in.in_var_ATTRIBUTE13 * 36u;
    uint _99 = _96 + 1u;
    uint _102 = _96 + 2u;
    uint _105 = _96 + 4u;
    float3x3 _114 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _96)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _99)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _102)].xyz);
    _114[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _96)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _105)].x;
    float3x3 _117 = _114;
    _117[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _99)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _105)].y;
    float3x3 _120 = _117;
    _120[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _102)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _105)].z;
    float3x3 _121 = _120 * _95;
    float4 _154 = float4(_121[0], 0.0);
    float4 _158 = float4(_121[2], _87 * View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _105)].w);
    int _163 = int(VoxelizeVolumePass.VoxelizeVolumePass_VolumetricFog_GridSize.z);
    uint _164 = _96 + 5u;
    float4 _174 = View.View_TranslatedWorldToView * float4(View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _164)].xyz + View.View_PreViewTranslation, 1.0);
    float _175 = _174.z;
    int _187 = int(log2(((_175 + View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _164)].w) * VoxelizeVolumePass.VoxelizeVolumePass_VolumetricFog_GridZParams.x) + VoxelizeVolumePass.VoxelizeVolumePass_VolumetricFog_GridZParams.y) * VoxelizeVolumePass.VoxelizeVolumePass_VolumetricFog_GridZParams.z);
    int _193 = int(log2(((_175 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _164)].w) * VoxelizeVolumePass.VoxelizeVolumePass_VolumetricFog_GridZParams.x) + VoxelizeVolumePass.VoxelizeVolumePass_VolumetricFog_GridZParams.y) * VoxelizeVolumePass.VoxelizeVolumePass_VolumetricFog_GridZParams.z);
    int _199 = int(uint(max(_193, 0)) + _Globals.VoxelizationPassIndex);
    float4 _261;
    float4 _262;
    uint _263;
    float4 _264;
    uint _265;
    if (((_193 < _163) && (_199 <= _187)) && (_187 >= 0))
    {
        float2 _211 = _174.xy;
        float4 _215;
        float4 _218;
        uint _220;
        float4 _222;
        uint _224;
        _215 = _154;
        _218 = _158;
        _220 = in.in_var_ATTRIBUTE13;
        _222 = _65;
        _224 = _64;
        float4 _216;
        float4 _219;
        uint _221;
        float4 _223;
        uint _225;
        for (int _226 = _199; _226 <= min(min(_187, (_163 - 1)), _199); _215 = _216, _218 = _219, _220 = _221, _222 = _223, _224 = _225, _226++)
        {
            float _238 = (exp2((float(_226) + VoxelizeVolumePass.VoxelizeVolumePass_FrameJitterOffset0.z) / VoxelizeVolumePass.VoxelizeVolumePass_VolumetricFog_GridZParams.z) - VoxelizeVolumePass.VoxelizeVolumePass_VolumetricFog_GridZParams.y) / VoxelizeVolumePass.VoxelizeVolumePass_VolumetricFog_GridZParams.x;
            float _240 = abs(_238 - _175);
            bool _243 = (View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _164)].w == 0.0) || (_240 <= View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _164)].w);
            if (_243)
            {
                _223 = VoxelizeVolumePass.VoxelizeVolumePass_ViewToVolumeClip * float4(_211 + ((((View.View_TranslatedWorldToView * float4((((View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _96)].xyz * in.in_var_ATTRIBUTE0.xxx) + (View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _99)].xyz * in.in_var_ATTRIBUTE0.yyy)) + (View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _102)].xyz * in.in_var_ATTRIBUTE0.zzz)) + (View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _96 + 3u)].xyz + View.View_PreViewTranslation), 1.0)).xy - _211) * (1.0 / View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _164)].w)) * sqrt(fast::max((View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _164)].w * View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _164)].w) - (_240 * _240), 0.0))), _238, 1.0);
                _225 = uint(_226);
            }
            else
            {
                _223 = _222;
                _225 = _224;
            }
            bool4 _260 = bool4(_243);
            _216 = select(_215, _154, _260);
            _219 = select(_218, _158, _260);
            _221 = _243 ? in.in_var_ATTRIBUTE13 : _220;
        }
        _261 = _215;
        _262 = _218;
        _263 = _220;
        _264 = _222;
        _265 = _224;
    }
    else
    {
        _261 = _154;
        _262 = _158;
        _263 = in.in_var_ATTRIBUTE13;
        _264 = _65;
        _265 = _64;
    }
    out.out_var_TEXCOORD10_centroid = _261;
    out.out_var_TEXCOORD11_centroid = _262;
    out.out_var_PRIMITIVE_ID = _263;
    out.gl_Position = _264;
    out.gl_Layer = _265;
    return out;
}

