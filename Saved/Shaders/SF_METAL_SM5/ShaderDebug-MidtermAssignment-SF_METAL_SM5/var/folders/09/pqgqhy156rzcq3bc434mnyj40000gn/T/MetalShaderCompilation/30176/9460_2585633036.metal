

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
    char _m3_pad[320];
    float4x4 View_PrevTranslatedWorldToClip;
    char _m4_pad[256];
    float3 View_PrevWorldCameraOrigin;
    char _m5_pad[16];
    float3 View_PrevPreViewTranslation;
    char _m6_pad[336];
    int View_NumSceneColorMSAASamples;
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_LocalVF
{
    int4 LocalVF_VertexFetch_Parameters;
};

constant float3x3 _60 = {};
constant float4x4 _61 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float4 out_var_TEXCOORD7 [[user(locn1)]];
    float4 out_var_TEXCOORD10_centroid [[user(locn2)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn3)]];
    uint out_var_PRIMITIVE_ID [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVertexShader_in
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

vertex MainVertexShader_out Main_000024f4_9a1da10c(MainVertexShader_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_LocalVF& LocalVF [[buffer(3)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    MainVertexShader_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[1];
    uint _87 = 2u * (uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex));
    float4 _92 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_87 + 1u)));
    float _93 = _92.w;
    float3 _94 = _92.xyz;
    float3 _96 = cross(_94, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_87)).xyz) * _93;
    float3x3 _99 = _60;
    _99[0] = cross(_96, _94) * _93;
    float3x3 _100 = _99;
    _100[1] = _96;
    float3x3 _101 = _100;
    _101[2] = _94;
    uint _102 = in.in_var_ATTRIBUTE13 * 36u;
    uint _105 = _102 + 1u;
    uint _108 = _102 + 2u;
    uint _111 = _102 + 4u;
    float3x3 _120 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _102)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _105)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _108)].xyz);
    _120[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _102)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _111)].x;
    float3x3 _123 = _120;
    _123[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _105)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _111)].y;
    float3x3 _126 = _123;
    _126[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _108)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _111)].z;
    float3x3 _127 = spvFMulMatrixMatrix(_126, _101);
    float3 _153 = float4(spvFAdd(fma(View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _108)].xyz, in.in_var_ATTRIBUTE0.zzz, fma(View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _102)].xyz, in.in_var_ATTRIBUTE0.xxx, spvFMul(View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _105)].xyz, in.in_var_ATTRIBUTE0.yyy))), spvFAdd(View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _102 + 3u)].xyz, View.View_PreViewTranslation)), 1.0).xyz;
    uint _160 = _102 + 13u;
    float3 _163 = View.View_WorldCameraOrigin - (_153 - View.View_PreViewTranslation);
    float _165 = sqrt(dot(_163, _163));
    float4x4 _183 = _61;
    _183[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _102 + 10u)];
    float4x4 _185 = _183;
    _185[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _102 + 11u)];
    float4x4 _187 = _185;
    _187[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _102 + 12u)];
    float4x4 _189 = _187;
    _189[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _160)];
    float4x4 _193 = _189;
    _193[3].x = spvFAdd(View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _160)].x, View.View_PrevPreViewTranslation.x);
    float4x4 _197 = _193;
    _197[3].y = spvFAdd(View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _160)].y, View.View_PrevPreViewTranslation.y);
    float4x4 _201 = _197;
    _201[3].z = spvFAdd(View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _160)].z, View.View_PrevPreViewTranslation.z);
    float3 _203 = spvFMulMatrixVector(_201, in.in_var_ATTRIBUTE0).xyz;
    float3 _205 = View.View_PrevWorldCameraOrigin - (_203 - View.View_PrevPreViewTranslation);
    float _207 = sqrt(dot(_205, _205));
    float4 _223 = spvFMulMatrixVector(View.View_TranslatedWorldToClip, float4(spvFAdd(_153, (_163 / float3(_165)) * fast::min(999999988484154753734934528.0, _165 - 20.0)), 1.0));
    float4 _230 = _223;
    _230.z = spvFAdd(_223.z, (View.View_NumSceneColorMSAASamples > 1) ? spvFMul(0.001000000047497451305389404296875, _223.w) : 0.0);
    out.gl_Position = _230;
    out.out_var_TEXCOORD6 = _223;
    out.out_var_TEXCOORD7 = spvFMulMatrixVector(View.View_PrevTranslatedWorldToClip, float4(spvFAdd(_203, (_205 / float3(_207)) * fast::min(999999988484154753734934528.0, _207 - 20.0)), 1.0));
    out.out_var_TEXCOORD10_centroid = float4(_127[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_127[2], spvFMul(_93, View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _111)].w));
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    return out;
}

