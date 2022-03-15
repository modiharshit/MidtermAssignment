

#pragma clang diagnostic ignored "-Wmissing-prototypes"
#pragma clang diagnostic ignored "-Wmissing-braces"

#include <metal_stdlib>
#include <simd/simd.h>


template<typename T>
static inline __attribute__((always_inline))
T ue4_cross(T x, T y)
{
    metal::float3 fx = metal::float3(x);
    metal::float3 fy = metal::float3(y);
    return T(metal::fma(fx[1], fy[2], -metal::fma(fy[1], fx[2], 0.0)), metal::fma(fx[2], fy[0], -metal::fma(fy[2], fx[0], 0.0)), metal::fma(fx[0], fy[1], -metal::fma(fy[0], fx[1], 0.0)));
}
#define cross ue4_cross

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
    float4x4 View_TranslatedWorldToClip;
    char _m1_pad[1008];
    float3 View_WorldCameraOrigin;
    char _m2_pad[32];
    float3 View_PreViewTranslation;
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_LocalVF
{
    int4 LocalVF_VertexFetch_Parameters;
};

constant float3x3 _52 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    uint out_var_PRIMITIVE_ID [[user(locn2)]];
    float4 out_var_TEXCOORD6 [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    uint in_var_ATTRIBUTE13 [[attribute(13)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

template<typename T>
T spvFMul(T l, T r)
{
    return fma(l, r, T(0));
}

template<typename T, int Cols, int Rows>
vec<T, Cols> spvFMulVectorMatrix(vec<T, Rows> v, matrix<T, Cols, Rows> m)
{
    vec<T, Cols> res = vec<T, Cols>(0);
    for (uint i = Rows; i > 0; --i)
    {
        vec<T, Cols> tmp(0);
        for (uint j = 0; j < Cols; ++j)
        {
            tmp[j] = m[j][i - 1];
        }
        res = fma(tmp, vec<T, Cols>(v[i - 1]), res);
    }
    return res;
}

template<typename T, int Cols, int Rows>
vec<T, Rows> spvFMulMatrixVector(matrix<T, Cols, Rows> m, vec<T, Cols> v)
{
    vec<T, Rows> res = vec<T, Rows>(0);
    for (uint i = Cols; i > 0; --i)
    {
        res = fma(m[i - 1], vec<T, Rows>(v[i - 1]), res);
    }
    return res;
}

template<typename T, int LCols, int LRows, int RCols, int RRows>
matrix<T, RCols, LRows> spvFMulMatrixMatrix(matrix<T, LCols, LRows> l, matrix<T, RCols, RRows> r)
{
    matrix<T, RCols, LRows> res;
    for (uint i = 0; i < RCols; i++)
    {
        vec<T, RCols> tmp(0);
        for (uint j = 0; j < LCols; j++)
        {
            tmp = fma(vec<T, RCols>(r[i][j]), l[j], tmp);
        }
        res[i] = tmp;
    }
    return res;
}

template<typename T>
T spvFAdd(T l, T r)
{
    return fma(T(1), l, r);
}

vertex Main_out Main_00001e90_6d5e0915(Main_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_LocalVF& LocalVF [[buffer(3)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[1];
    uint _68 = 2u * (uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex));
    float4 _73 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_68 + 1u)));
    float _74 = _73.w;
    float3 _75 = _73.xyz;
    float3 _77 = cross(_75, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_68)).xyz) * _74;
    float3x3 _80 = _52;
    _80[0] = cross(_77, _75) * _74;
    float3x3 _81 = _80;
    _81[1] = _77;
    float3x3 _82 = _81;
    _82[2] = _75;
    uint _83 = in.in_var_ATTRIBUTE13 * 36u;
    uint _86 = _83 + 1u;
    uint _89 = _83 + 2u;
    uint _92 = _83 + 4u;
    float3x3 _101 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _83)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _86)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _89)].xyz);
    _101[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _83)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _92)].x;
    float3x3 _104 = _101;
    _104[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _86)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _92)].y;
    float3x3 _107 = _104;
    _107[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _89)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _92)].z;
    float3x3 _108 = spvFMulMatrixMatrix(_107, _82);
    uint _115 = _83 + 3u;
    float3 _122 = spvFMul(View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _86)].xyz, in.in_var_ATTRIBUTE0.yyy);
    float3 _123 = fma(View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _83)].xyz, in.in_var_ATTRIBUTE0.xxx, _122);
    float3 _126 = fma(View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _89)].xyz, in.in_var_ATTRIBUTE0.zzz, _123);
    float3 _128 = spvFAdd(View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _115)].xyz, View.View_PreViewTranslation);
    float3 _129 = spvFAdd(_126, _128);
    float _130 = _129.x;
    float _131 = _129.y;
    float _132 = _129.z;
    float4 _133 = float4(_130, _131, _132, 1.0);
    float3 _134 = _133.xyz;
    float3 _135 = _134 - View.View_PreViewTranslation;
    float3 _136 = View.View_WorldCameraOrigin - _135;
    float _137 = dot(_136, _136);
    float _138 = sqrt(_137);
    float3 _139 = float3(_138);
    float3 _140 = _136 / _139;
    float _141 = _138 - 20.0;
    float _142 = fast::min(999999988484154753734934528.0, _141);
    float3 _143 = _140 * _142;
    float3 _144 = spvFAdd(_134, _143);
    float4 _145 = float4(_144.x, _144.y, _144.z, _133.w);
    float4 _146 = spvFMulMatrixVector(View.View_TranslatedWorldToClip, _145);
    out.out_var_TEXCOORD10_centroid = float4(_108[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_108[2], spvFMul(_74, View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _92)].w));
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    out.out_var_TEXCOORD6 = _145;
    out.gl_Position = _146;
    return out;
}

