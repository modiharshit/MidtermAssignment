

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
    char _m0_pad[1120];
    float3 View_PreViewTranslation;
    char _m1_pad[1144];
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
    spvUnsafeArray<float4, 7> Material_VectorExpressions;
    spvUnsafeArray<float4, 6> Material_ScalarExpressions;
};

constant float3x3 _122 = {};
constant float4x4 _123 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_COLOR0 [[user(locn2)]];
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

vertex Main_out Main_00004353_d25006d3(Main_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(8)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(3)]], constant type_View& View [[buffer(4)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(5)]], constant type_LocalVF& LocalVF [[buffer(6)]], constant type_Material& Material [[buffer(7)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(0)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(1)]], texture_buffer<float> LocalVF_VertexFetch_ColorComponentsBuffer [[texture(2)]], texture2d<float> Material_Texture2D_2 [[texture(3)]], sampler Material_Texture2D_2Sampler [[sampler(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[3];
    uint _133 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _141 = 2u * _133;
    float4 _146 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_141 + 1u)));
    float _147 = _146.w;
    float3 _148 = _146.xyz;
    float3 _150 = cross(_148, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_141)).xyz) * _147;
    float3x3 _153 = _122;
    _153[0] = cross(_150, _148) * _147;
    float3x3 _154 = _153;
    _154[1] = _150;
    float3x3 _155 = _154;
    _155[2] = _148;
    uint _156 = in.in_var_ATTRIBUTE13 * 36u;
    uint _159 = _156 + 1u;
    uint _162 = _156 + 2u;
    uint _165 = _156 + 3u;
    uint _171 = _156 + 4u;
    float3x3 _176 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _156)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _159)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _162)].xyz);
    _176[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _156)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _171)].x;
    float3x3 _179 = _176;
    _179[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _159)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _171)].y;
    float3x3 _182 = _179;
    _182[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _162)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _171)].z;
    float3x3 _183 = spvFMulMatrixMatrix(_182, _155);
    float4 _206 = float4(spvFAdd(fma(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _162)].xyz, in.in_var_ATTRIBUTE0.zzz, fma(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _156)].xyz, in.in_var_ATTRIBUTE0.xxx, spvFMul(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _159)].xyz, in.in_var_ATTRIBUTE0.yyy))), spvFAdd(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _165)].xyz, View.View_PreViewTranslation)), 1.0);
    float3 _207 = _206.xyz;
    uint _210 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    uint _211 = _210 - 1u;
    uint _213 = _210 * _133;
    float4 _216 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_213 + min(0u, _211))));
    float4 _219 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_213 + min(1u, _211))));
    float4 _222 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_213 + min(2u, _211))));
    float3 _223 = _183[2];
    float4x4 _237 = _123;
    _237[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _156)];
    float4x4 _239 = _237;
    _239[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _159)];
    float4x4 _241 = _239;
    _241[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _162)];
    float4x4 _243 = _241;
    _243[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _165)];
    float3 _245 = spvFMulMatrixVector(_243, float4(0.0, 0.0, 0.0, 1.0)).xyz;
    float3 _246 = _207 - View.View_PreViewTranslation;
    float3 _253 = _245 * Material.Material_ScalarExpressions[1].x;
    float _262 = _222.y;
    float3 _274 = spvFAdd(Material_Texture2D_2.sample(Material_Texture2D_2Sampler, spvFAdd(spvFAdd((_246 - _245) * Material.Material_ScalarExpressions[0].w, _253), float3(1.0, 0.0, 0.0) * (spvFMul(View.View_GameTime, Material.Material_ScalarExpressions[1].y) - spvFMul(Material.Material_ScalarExpressions[1].z, _262))).xy, level(-1.0)).xyz, float3(-0.25, -0.5, -0.5)) * 2.0;
    float3 _279 = select(float4(1.0, 0.0, 0.0, 1.0), select(float4(1.0, 0.0, 0.0, 1.0), Material.Material_VectorExpressions[5], bool4(Material.Material_ScalarExpressions[0].y >= 9.9999999747524270787835121154785e-07)), bool4(abs(Material.Material_ScalarExpressions[0].y - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz;
    float3 _302 = spvFMulMatrixVector(float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _156)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _159)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _162)].xyz), spvFAdd(float3(-0.5), fract(spvFMul(float3(_219.y), float3(0.0625, 1.0, 16.0)))) * 2.0);
    float _305 = _222.x;
    float3 _308 = float3(1.0) - (_302 * spvFMul(Material.Material_ScalarExpressions[2].y, _305));
    float3 _309 = spvFAdd(_246, spvFAdd(_279 * spvFMul(Material.Material_ScalarExpressions[1].w, _274.x), float3(0.0, 0.0, 1.0) * spvFMul(_274.y, Material.Material_ScalarExpressions[2].x)) * _262) - _308;
    float _316 = dot(_279, _302 / float3(sqrt(dot(_302, _302))));
    float3 _319 = spvFAdd(_279, float3(0.0, 0.0, 1.0) * spvFMul(_316, _316));
    float3 _323 = _319 / float3(sqrt(dot(_319, _319)));
    float _324 = _219.x;
    float _327 = floor(spvFMul(_324, 7.111111164093017578125));
    float _329 = spvFMul(_324, 256.0) - spvFMul(_327, 36.0);
    float _331 = floor(spvFMul(_329, 0.16666667163372039794921875));
    float3 _361 = spvFAdd(float3(-0.5), Material_Texture2D_2.sample(Material_Texture2D_2Sampler, spvFAdd(spvFAdd(spvFMul(spvFMul(float3(_329 - spvFMul(_331, 6.0), _331, _327), float3(0.20000000298023223876953125, 0.20000000298023223876953125, 0.16666667163372039794921875)), View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _156 + 19u)].xyz) * Material.Material_ScalarExpressions[2].z, float3(1.0)), float3(-1.0, 0.0, 0.0) * (fma(View.View_GameTime, Material.Material_ScalarExpressions[2].w, fract(dot(_253, _253))) - spvFMul(Material.Material_ScalarExpressions[3].x, _305))).xy, level(-1.0)).xyz) * 2.0;
    float3 _381 = spvFAdd(_309, spvFAdd(_323 * spvFMul(Material.Material_ScalarExpressions[3].y, spvFAdd(_361.z, 1.0)), spvFAdd(_323 * _361.x, Material.Material_VectorExpressions[6].xyz * _361.y) * Material.Material_ScalarExpressions[3].w) * _305);
    float _382 = dot(_381, _381);
    float3 _401 = spvFAdd(select(float4(0.0, 0.0, 0.0, 1.0), select(float4(0.0, 0.0, 0.0, 1.0), float4(_381 / float3(sqrt(_382)), 0.0), bool4(_382 >= 9.9999999747524270787835121154785e-07)), bool4(abs(_382 - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz * sqrt(dot(_309, _309)), _308) - _245;
    float4x4 _414 = _123;
    _414[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _156 + 6u)];
    float4x4 _418 = _414;
    _418[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _156 + 7u)];
    float4x4 _422 = _418;
    _422[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _156 + 8u)];
    float4x4 _426 = _422;
    _426[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _156 + 9u)];
    float _448 = fast::min(fast::max((((spvFMulMatrixVector(_426, float4(_246, 1.0)).xyz - View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _156 + 23u)].xyz) / (View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _156 + 24u)].xyz - View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _156 + 23u)].xyz)).z - Material.Material_ScalarExpressions[4].y) / Material.Material_ScalarExpressions[4].z, 0.0), 1.0);
    float _449 = spvFMul(_448, _448);
    float3 _461 = spvFAdd(float3(-0.5), Material_Texture2D_2.sample(Material_Texture2D_2Sampler, spvFAdd(_253, float3(-1.0, 0.0, 0.0) * (spvFMul(View.View_GameTime, Material.Material_ScalarExpressions[4].x) - spvFMul(Material.Material_ScalarExpressions[4].w, _449))).xy, level(-1.0)).xyz) * 2.0;
    float3 _482 = spvFAdd(_401, spvFAdd(_279 * spvFMul(Material.Material_ScalarExpressions[5].x, spvFAdd(_461.z, 1.0)), spvFAdd(_279 * _461.x, (cross(_279, float3(0.0, 0.0, 1.0)) * Material.Material_ScalarExpressions[5].y) * _461.y) * Material.Material_ScalarExpressions[5].z) * _449);
    float _483 = dot(_482, _482);
    float3 _511 = -spvFMulMatrixVector(float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _156)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _159)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _162)].xyz), float3(1.0, 0.0, 0.0));
    float3 _522 = -spvFMulMatrixVector(float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _156)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _159)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _162)].xyz), float3(0.0, 1.0, 0.0));
    float3 _533 = -spvFMulMatrixVector(float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _156)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _159)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _162)].xyz), float3(0.0, 0.0, 1.0));
    float3 _537 = fma(spvFAdd(select(float4(0.0, 0.0, 0.0, 1.0), select(float4(0.0, 0.0, 0.0, 1.0), float4(_482 / float3(sqrt(_483)), 0.0), bool4(_483 >= 9.9999999747524270787835121154785e-07)), bool4(abs(_483 - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz * sqrt(dot(_401, _401)), _245) - _246, float3(sqrt(dot(_511, _511)), sqrt(dot(_522, _522)), sqrt(dot(_533, _533))), _207);
    float4 _543 = spvFMulMatrixVector(ShadowDepthPass.ShadowDepthPass_ProjectionMatrix, float4(_537.x, _537.y, _537.z, _206.w));
    float4 _554;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_543.z < 0.0))
    {
        float4 _552 = _543;
        _552.z = 9.9999999747524270787835121154785e-07;
        float4 _553 = _552;
        _553.w = 1.0;
        _554 = _553;
    }
    else
    {
        _554 = _543;
    }
    float _560 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), _223));
    spvUnsafeArray<float4, 1> _588 = { float4(_216.x, _216.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_183[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_223, spvFMul(_147, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _171)].w));
    out.out_var_COLOR0 = LocalVF_VertexFetch_ColorComponentsBuffer.read(uint((_133 & uint(LocalVF.LocalVF_VertexFetch_Parameters.x)))).zyxw;
    out_var_TEXCOORD0 = _588;
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    out.out_var_TEXCOORD6 = _554.z;
    out.out_var_TEXCOORD8 = fma(ShadowDepthPass.ShadowDepthPass_ShadowParams.y, fast::clamp((abs(_560) > 0.0) ? (sqrt(fast::clamp(1.0 - spvFMul(_560, _560), 0.0, 1.0)) / _560) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z), ShadowDepthPass.ShadowDepthPass_ShadowParams.x);
    out.out_var_TEXCOORD7 = _537.xyz;
    out.gl_Position = _554;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

