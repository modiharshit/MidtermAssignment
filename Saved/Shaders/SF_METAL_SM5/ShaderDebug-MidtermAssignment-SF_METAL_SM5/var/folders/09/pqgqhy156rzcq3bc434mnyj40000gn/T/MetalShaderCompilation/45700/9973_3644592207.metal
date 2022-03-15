

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

constant float3x3 _70 = {};
constant float4x4 _71 = {};
constant uint _72 = {};
constant float4 _73 = {};

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
    uint in_var_ATTRIBUTE13 [[attribute(13)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

vertex VoxelizeVS_out Main_000026f5_d93c104f(VoxelizeVS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(6)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_VoxelizeVolumePass& VoxelizeVolumePass [[buffer(3)]], constant type_LocalVF& LocalVF [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    VoxelizeVS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[1];
    uint _88 = 2u * (uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex));
    float4 _93 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_88 + 1u)));
    float _94 = _93.w;
    float3 _95 = _93.xyz;
    float3 _97 = cross(_95, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_88)).xyz) * _94;
    float3x3 _100 = _70;
    _100[0] = cross(_97, _95) * _94;
    float3x3 _101 = _100;
    _101[1] = _97;
    float3x3 _102 = _101;
    _102[2] = _95;
    uint _103 = in.in_var_ATTRIBUTE13 * 36u;
    uint _106 = _103 + 1u;
    uint _109 = _103 + 2u;
    uint _112 = _103 + 4u;
    float3x3 _121 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _103)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _106)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _109)].xyz);
    _121[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _103)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _112)].x;
    float3x3 _124 = _121;
    _124[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _106)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _112)].y;
    float3x3 _127 = _124;
    _127[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _109)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _112)].z;
    float3x3 _128 = _127 * _102;
    float4 _137 = float4(_128[0], 0.0);
    float4 _141 = float4(_128[2], _94 * View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _112)].w);
    int _150 = int(VoxelizeVolumePass.VoxelizeVolumePass_VolumetricFog_GridSize.z);
    uint _151 = _103 + 5u;
    float4 _161 = View.View_TranslatedWorldToView * float4(View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _151)].xyz + View.View_PreViewTranslation, 1.0);
    float4x4 _173 = _71;
    _173[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _103)];
    float4x4 _175 = _173;
    _175[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _106)];
    float4x4 _177 = _175;
    _177[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _109)];
    float4x4 _179 = _177;
    _179[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _103 + 3u)];
    float _180 = _161.z;
    int _192 = int(log2(((_180 + View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _151)].w) * VoxelizeVolumePass.VoxelizeVolumePass_VolumetricFog_GridZParams.x) + VoxelizeVolumePass.VoxelizeVolumePass_VolumetricFog_GridZParams.y) * VoxelizeVolumePass.VoxelizeVolumePass_VolumetricFog_GridZParams.z);
    int _198 = int(log2(((_180 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _151)].w) * VoxelizeVolumePass.VoxelizeVolumePass_VolumetricFog_GridZParams.x) + VoxelizeVolumePass.VoxelizeVolumePass_VolumetricFog_GridZParams.y) * VoxelizeVolumePass.VoxelizeVolumePass_VolumetricFog_GridZParams.z);
    int _204 = int(uint(max(_198, 0)) + _Globals.VoxelizationPassIndex);
    float4 _294;
    float4 _295;
    uint _296;
    float4 _297;
    uint _298;
    if (((_198 < _150) && (_204 <= _192)) && (_192 >= 0))
    {
        float2 _216;
        float2 _219;
        _216 = float2(-10000000.0);
        _219 = float2(10000000.0);
        for (int _221 = 0; _221 < 8; )
        {
            float2 _250 = (View.View_TranslatedWorldToView * float4((_179 * float4(View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _103 + 23u)].xyz + ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _103 + 24u)].xyz - View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _103 + 23u)].xyz) * float3(float((_221 >> 0) & 1), float((_221 >> 1) & 1), float((_221 >> 2) & 1))), 1.0)).xyz + View.View_PreViewTranslation, 1.0)).xy;
            _216 = fast::max(_216, _250);
            _219 = fast::min(_219, _250);
            _221++;
            continue;
        }
        float4 _252;
        float4 _255;
        uint _257;
        float4 _259;
        uint _261;
        _252 = _137;
        _255 = _141;
        _257 = in.in_var_ATTRIBUTE13;
        _259 = _73;
        _261 = _72;
        float4 _253;
        float4 _256;
        uint _258;
        float4 _260;
        uint _262;
        for (int _263 = _204; _263 <= min(min(_192, (_150 - 1)), _204); _252 = _253, _255 = _256, _257 = _258, _259 = _260, _261 = _262, _263++)
        {
            float _275 = (exp2((float(_263) + VoxelizeVolumePass.VoxelizeVolumePass_FrameJitterOffset0.z) / VoxelizeVolumePass.VoxelizeVolumePass_VolumetricFog_GridZParams.z) - VoxelizeVolumePass.VoxelizeVolumePass_VolumetricFog_GridZParams.y) / VoxelizeVolumePass.VoxelizeVolumePass_VolumetricFog_GridZParams.x;
            bool _280 = (View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _151)].w == 0.0) || (abs(_275 - _180) <= View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _151)].w);
            if (_280)
            {
                _260 = VoxelizeVolumePass.VoxelizeVolumePass_ViewToVolumeClip * float4(_219 + ((_216 - _219) * float2(float((gl_VertexIndex - gl_BaseVertex) & 1u), float(((gl_VertexIndex - gl_BaseVertex) >> 1u) & 1u))), _275, 1.0);
                _262 = uint(_263);
            }
            else
            {
                _260 = _259;
                _262 = _261;
            }
            bool4 _293 = bool4(_280);
            _253 = select(_252, _137, _293);
            _256 = select(_255, _141, _293);
            _258 = _280 ? in.in_var_ATTRIBUTE13 : _257;
        }
        _294 = _252;
        _295 = _255;
        _296 = _257;
        _297 = _259;
        _298 = _261;
    }
    else
    {
        _294 = _137;
        _295 = _141;
        _296 = in.in_var_ATTRIBUTE13;
        _297 = _73;
        _298 = _72;
    }
    out.out_var_TEXCOORD10_centroid = _294;
    out.out_var_TEXCOORD11_centroid = _295;
    out.out_var_PRIMITIVE_ID = _296;
    out.gl_Position = _297;
    out.gl_Layer = _298;
    return out;
}

