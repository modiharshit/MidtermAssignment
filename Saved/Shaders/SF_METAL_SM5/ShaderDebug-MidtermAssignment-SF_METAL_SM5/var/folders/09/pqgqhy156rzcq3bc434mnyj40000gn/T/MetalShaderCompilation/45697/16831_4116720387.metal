

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
    char _m0_pad[1072];
    float3 View_WorldCameraOrigin;
    char _m1_pad[32];
    float3 View_PreViewTranslation;
    char _m2_pad[1144];
    float View_GameTime;
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_ShadowDepthPass
{
    char _m0_pad[304];
    float4x4 ShadowDepthPass_ProjectionMatrix;
    float4x4 ShadowDepthPass_ViewMatrix;
    float4 ShadowDepthPass_ShadowParams;
    float ShadowDepthPass_bClampToNearPlane;
};

struct type_LocalVF
{
    int4 LocalVF_VertexFetch_Parameters;
};

struct type_Material
{
    spvUnsafeArray<float4, 6> Material_VectorExpressions;
    spvUnsafeArray<float4, 4> Material_ScalarExpressions;
};

constant float3x3 _109 = {};
constant float4x4 _110 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD15 [[user(locn2)]];
    float4 out_var_TEXCOORD0_0 [[user(locn3)]];
    uint out_var_PRIMITIVE_ID [[user(locn4)]];
    float out_var_TEXCOORD6 [[user(locn5)]];
    float out_var_TEXCOORD8 [[user(locn6)]];
    float3 out_var_TEXCOORD7 [[user(locn7)]];
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

vertex Main_out Main_000041bf_f5602b03(Main_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(7)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(4)]], constant type_LocalVF& LocalVF [[buffer(5)]], constant type_Material& Material [[buffer(6)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(0)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(1)]], texture2d<float> Material_Texture2D_2 [[texture(2)]], sampler Material_Texture2D_2Sampler [[sampler(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    uint _122 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _123 = 2u * _122;
    float4 _128 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_123 + 1u)));
    float _129 = _128.w;
    float3 _130 = _128.xyz;
    float3 _132 = cross(_130, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_123)).xyz) * _129;
    float3x3 _135 = _109;
    _135[0] = cross(_132, _130) * _129;
    float3x3 _136 = _135;
    _136[1] = _132;
    float3x3 _137 = _136;
    _137[2] = _130;
    uint _138 = in.in_var_ATTRIBUTE13 * 36u;
    uint _141 = _138 + 1u;
    uint _144 = _138 + 2u;
    uint _147 = _138 + 3u;
    uint _153 = _138 + 4u;
    float3x3 _158 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _138)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _141)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _144)].xyz);
    _158[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _138)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _153)].x;
    float3x3 _161 = _158;
    _161[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _141)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _153)].y;
    float3x3 _164 = _161;
    _164[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _144)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _153)].z;
    float3x3 _165 = spvFMulMatrixMatrix(_164, _137);
    float4 _188 = float4(spvFAdd(fma(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _144)].xyz, in.in_var_ATTRIBUTE0.zzz, fma(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _138)].xyz, in.in_var_ATTRIBUTE0.xxx, spvFMul(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _141)].xyz, in.in_var_ATTRIBUTE0.yyy))), spvFAdd(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _147)].xyz, View.View_PreViewTranslation)), 1.0);
    float3 _189 = _188.xyz;
    uint _192 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    float4 _198 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(((_192 * _122) + min(0u, (_192 - 1u)))));
    float3 _199 = _165[2];
    float4x4 _201 = _110;
    _201[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _138)];
    float4x4 _203 = _201;
    _203[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _141)];
    float4x4 _205 = _203;
    _205[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _144)];
    float4x4 _207 = _205;
    _207[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _147)];
    float3 _209 = spvFMulMatrixVector(_207, float4(0.0, 0.0, 0.0, 1.0)).xyz;
    float3 _210 = _209 - View.View_WorldCameraOrigin;
    float3 _214 = _210 / float3(sqrt(dot(_210, _210)));
    uint _215 = _138 + 21u;
    float _219 = dot(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _215)].xyz, _214);
    float3 _223 = _214 - (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _215)].xyz * _219);
    float _228 = dot(_223 / float3(sqrt(dot(_223, _223))), _199);
    uint _233 = _138 + 6u;
    uint _236 = _138 + 7u;
    uint _239 = _138 + 8u;
    float _249 = spvFMul(_219, _219);
    float _250 = spvFMul(_249, _249);
    float3 _256 = _189 - View.View_PreViewTranslation;
    float3 _257 = _256 - _209;
    float4x4 _285 = _110;
    _285[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _233)];
    float4x4 _287 = _285;
    _287[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _236)];
    float4x4 _289 = _287;
    _289[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _239)];
    float4x4 _291 = _289;
    _291[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _138 + 9u)];
    float _313 = fast::min(fast::max((((spvFMulMatrixVector(_291, float4(_256, 1.0)).xyz - View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _138 + 23u)].xyz) / (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _138 + 24u)].xyz - View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _138 + 23u)].xyz)).z - Material.Material_ScalarExpressions[1].w) / Material.Material_ScalarExpressions[2].x, 0.0), 1.0);
    float _314 = spvFMul(_313, _313);
    float3 _328 = spvFAdd(float3(-0.5), Material_Texture2D_2.sample(Material_Texture2D_2Sampler, spvFAdd(_209 * Material.Material_ScalarExpressions[1].y, float3(-1.0, 0.0, 0.0) * (spvFMul(View.View_GameTime, Material.Material_ScalarExpressions[1].z) - spvFMul(Material.Material_ScalarExpressions[2].y, _314))).xy, level(-1.0)).xyz) * 2.0;
    float3 _334 = select(float4(1.0, 0.0, 0.0, 1.0), select(float4(1.0, 0.0, 0.0, 1.0), Material.Material_VectorExpressions[5], bool4(Material.Material_ScalarExpressions[0].w >= 9.9999999747524270787835121154785e-07)), bool4(abs(Material.Material_ScalarExpressions[0].w - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz;
    float3 _350 = spvFAdd(_257, spvFAdd(_334 * spvFMul(Material.Material_ScalarExpressions[2].z, spvFAdd(_328.z, 1.0)), spvFAdd(_334 * _328.x, (cross(_334, float3(0.0, 0.0, 1.0)) * Material.Material_ScalarExpressions[2].w) * _328.y) * Material.Material_ScalarExpressions[3].x) * _314);
    float _351 = dot(_350, _350);
    float3 _379 = -spvFMulMatrixVector(float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _138)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _141)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _144)].xyz), float3(1.0, 0.0, 0.0));
    float3 _390 = -spvFMulMatrixVector(float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _138)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _141)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _144)].xyz), float3(0.0, 1.0, 0.0));
    float3 _401 = -spvFMulMatrixVector(float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _138)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _141)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _144)].xyz), float3(0.0, 0.0, 1.0));
    float3 _410 = spvFAdd(_189, select(_256 * (-1.0), spvFMul(spvFAdd(select(float4(0.0, 0.0, 0.0, 1.0), select(float4(0.0, 0.0, 0.0, 1.0), float4(_350 / float3(sqrt(_351)), 0.0), bool4(_351 >= 9.9999999747524270787835121154785e-07)), bool4(abs(_351 - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz * sqrt(dot(_257, _257)), _209) - _256, float3(sqrt(dot(_379, _379)), sqrt(dot(_390, _390)), sqrt(dot(_401, _401)))), bool3(fast::clamp(spvFAdd(mix(spvFMul(spvFMul(_228, _228), Material.Material_ScalarExpressions[0].z), spvFMulMatrixVector(float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _233)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _236)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _239)].xyz), _199).z, spvFMul(_250, _250)), 0.0199999995529651641845703125), 0.0, 1.0) >= 0.100000001490116119384765625)));
    float4 _416 = spvFMulMatrixVector(ShadowDepthPass.ShadowDepthPass_ProjectionMatrix, float4(_410.x, _410.y, _410.z, _188.w));
    float4 _427;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_416.z < 0.0))
    {
        float4 _425 = _416;
        _425.z = 9.9999999747524270787835121154785e-07;
        float4 _426 = _425;
        _426.w = 1.0;
        _427 = _426;
    }
    else
    {
        _427 = _416;
    }
    float _433 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), _199));
    float4x4 _452 = _110;
    _452[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _138)];
    float4x4 _454 = _452;
    _454[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _141)];
    float4x4 _456 = _454;
    _456[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _144)];
    float4x4 _458 = _456;
    _458[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _147)];
    float3 _461 = spvFMulMatrixVector(_458, float4(0.0, 0.0, 0.0, 1.0)).xyz - View.View_WorldCameraOrigin;
    float3 _465 = _461 / float3(sqrt(dot(_461, _461)));
    float _468 = dot(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _215)].xyz, _465);
    float3 _472 = _465 - (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _215)].xyz * _468);
    float _477 = dot(_472 / float3(sqrt(dot(_472, _472))), _199);
    float _488 = spvFMul(_468, _468);
    float _489 = spvFMul(_488, _488);
    float2 _495 = float2(fast::clamp(spvFAdd(mix(spvFMul(spvFMul(_477, _477), Material.Material_ScalarExpressions[0].z), spvFMulMatrixVector(float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _233)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _236)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _239)].xyz), _199).z, spvFMul(_489, _489)), 0.0199999995529651641845703125), 0.0, 1.0));
    float4 _505 = float4(_199, spvFMul(_129, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _153)].w));
    spvUnsafeArray<float4, 1> _506 = { float4(_198.x, _198.y, _495.x, _495.y) };
    out.out_var_TEXCOORD10_centroid = float4(_165[0], 0.0);
    out.out_var_TEXCOORD11_centroid = _505;
    out.out_var_TEXCOORD15 = _505;
    out_var_TEXCOORD0 = _506;
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    out.out_var_TEXCOORD6 = _427.z;
    out.out_var_TEXCOORD8 = fma(ShadowDepthPass.ShadowDepthPass_ShadowParams.y, fast::clamp((abs(_433) > 0.0) ? (sqrt(fast::clamp(1.0 - spvFMul(_433, _433), 0.0, 1.0)) / _433) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z), ShadowDepthPass.ShadowDepthPass_ShadowParams.x);
    out.out_var_TEXCOORD7 = _410.xyz;
    out.gl_Position = _427;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

