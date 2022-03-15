

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

constant float3x3 _121 = {};
constant float4x4 _122 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_COLOR0 [[user(locn2)]];
    float4 out_var_TEXCOORD0_0 [[user(locn3)]];
    uint out_var_PRIMITIVE_ID [[user(locn4)]];
    float out_var_TEXCOORD6 [[user(locn5)]];
    float3 out_var_TEXCOORD7 [[user(locn6)]];
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

vertex Main_out Main_00004373_c66bf8e9(Main_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(8)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(3)]], constant type_View& View [[buffer(4)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(5)]], constant type_LocalVF& LocalVF [[buffer(6)]], constant type_Material& Material [[buffer(7)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(0)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(1)]], texture_buffer<float> LocalVF_VertexFetch_ColorComponentsBuffer [[texture(2)]], texture2d<float> Material_Texture2D_2 [[texture(3)]], sampler Material_Texture2D_2Sampler [[sampler(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[3];
    uint _132 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _140 = 2u * _132;
    float4 _145 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_140 + 1u)));
    float _146 = _145.w;
    float3 _147 = _145.xyz;
    float3 _149 = cross(_147, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_140)).xyz) * _146;
    float3x3 _152 = _121;
    _152[0] = cross(_149, _147) * _146;
    float3x3 _153 = _152;
    _153[1] = _149;
    float3x3 _154 = _153;
    _154[2] = _147;
    uint _155 = in.in_var_ATTRIBUTE13 * 36u;
    uint _158 = _155 + 1u;
    uint _161 = _155 + 2u;
    uint _164 = _155 + 3u;
    uint _170 = _155 + 4u;
    float3x3 _175 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _155)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _158)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _161)].xyz);
    _175[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _155)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _170)].x;
    float3x3 _178 = _175;
    _178[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _158)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _170)].y;
    float3x3 _181 = _178;
    _181[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _161)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _170)].z;
    float3x3 _182 = spvFMulMatrixMatrix(_181, _154);
    float4 _205 = float4(spvFAdd(fma(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _161)].xyz, in.in_var_ATTRIBUTE0.zzz, fma(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _155)].xyz, in.in_var_ATTRIBUTE0.xxx, spvFMul(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _158)].xyz, in.in_var_ATTRIBUTE0.yyy))), spvFAdd(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _164)].xyz, View.View_PreViewTranslation)), 1.0);
    float3 _206 = _205.xyz;
    uint _209 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    uint _210 = _209 - 1u;
    uint _212 = _209 * _132;
    float4 _215 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_212 + min(0u, _210))));
    float4 _218 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_212 + min(1u, _210))));
    float4 _221 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_212 + min(2u, _210))));
    float3 _222 = _182[2];
    float4x4 _236 = _122;
    _236[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _155)];
    float4x4 _238 = _236;
    _238[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _158)];
    float4x4 _240 = _238;
    _240[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _161)];
    float4x4 _242 = _240;
    _242[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _164)];
    float3 _244 = spvFMulMatrixVector(_242, float4(0.0, 0.0, 0.0, 1.0)).xyz;
    float3 _245 = _206 - View.View_PreViewTranslation;
    float3 _252 = _244 * Material.Material_ScalarExpressions[1].x;
    float _261 = _221.y;
    float3 _273 = spvFAdd(Material_Texture2D_2.sample(Material_Texture2D_2Sampler, spvFAdd(spvFAdd((_245 - _244) * Material.Material_ScalarExpressions[0].w, _252), float3(1.0, 0.0, 0.0) * (spvFMul(View.View_GameTime, Material.Material_ScalarExpressions[1].y) - spvFMul(Material.Material_ScalarExpressions[1].z, _261))).xy, level(-1.0)).xyz, float3(-0.25, -0.5, -0.5)) * 2.0;
    float3 _278 = select(float4(1.0, 0.0, 0.0, 1.0), select(float4(1.0, 0.0, 0.0, 1.0), Material.Material_VectorExpressions[5], bool4(Material.Material_ScalarExpressions[0].y >= 9.9999999747524270787835121154785e-07)), bool4(abs(Material.Material_ScalarExpressions[0].y - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz;
    float3 _301 = spvFMulMatrixVector(float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _155)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _158)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _161)].xyz), spvFAdd(float3(-0.5), fract(spvFMul(float3(_218.y), float3(0.0625, 1.0, 16.0)))) * 2.0);
    float _304 = _221.x;
    float3 _307 = float3(1.0) - (_301 * spvFMul(Material.Material_ScalarExpressions[2].y, _304));
    float3 _308 = spvFAdd(_245, spvFAdd(_278 * spvFMul(Material.Material_ScalarExpressions[1].w, _273.x), float3(0.0, 0.0, 1.0) * spvFMul(_273.y, Material.Material_ScalarExpressions[2].x)) * _261) - _307;
    float _315 = dot(_278, _301 / float3(sqrt(dot(_301, _301))));
    float3 _318 = spvFAdd(_278, float3(0.0, 0.0, 1.0) * spvFMul(_315, _315));
    float3 _322 = _318 / float3(sqrt(dot(_318, _318)));
    float _323 = _218.x;
    float _326 = floor(spvFMul(_323, 7.111111164093017578125));
    float _328 = spvFMul(_323, 256.0) - spvFMul(_326, 36.0);
    float _330 = floor(spvFMul(_328, 0.16666667163372039794921875));
    float3 _360 = spvFAdd(float3(-0.5), Material_Texture2D_2.sample(Material_Texture2D_2Sampler, spvFAdd(spvFAdd(spvFMul(spvFMul(float3(_328 - spvFMul(_330, 6.0), _330, _326), float3(0.20000000298023223876953125, 0.20000000298023223876953125, 0.16666667163372039794921875)), View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _155 + 19u)].xyz) * Material.Material_ScalarExpressions[2].z, float3(1.0)), float3(-1.0, 0.0, 0.0) * (fma(View.View_GameTime, Material.Material_ScalarExpressions[2].w, fract(dot(_252, _252))) - spvFMul(Material.Material_ScalarExpressions[3].x, _304))).xy, level(-1.0)).xyz) * 2.0;
    float3 _380 = spvFAdd(_308, spvFAdd(_322 * spvFMul(Material.Material_ScalarExpressions[3].y, spvFAdd(_360.z, 1.0)), spvFAdd(_322 * _360.x, Material.Material_VectorExpressions[6].xyz * _360.y) * Material.Material_ScalarExpressions[3].w) * _304);
    float _381 = dot(_380, _380);
    float3 _400 = spvFAdd(select(float4(0.0, 0.0, 0.0, 1.0), select(float4(0.0, 0.0, 0.0, 1.0), float4(_380 / float3(sqrt(_381)), 0.0), bool4(_381 >= 9.9999999747524270787835121154785e-07)), bool4(abs(_381 - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz * sqrt(dot(_308, _308)), _307) - _244;
    float4x4 _413 = _122;
    _413[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _155 + 6u)];
    float4x4 _417 = _413;
    _417[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _155 + 7u)];
    float4x4 _421 = _417;
    _421[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _155 + 8u)];
    float4x4 _425 = _421;
    _425[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _155 + 9u)];
    float _447 = fast::min(fast::max((((spvFMulMatrixVector(_425, float4(_245, 1.0)).xyz - View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _155 + 23u)].xyz) / (View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _155 + 24u)].xyz - View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _155 + 23u)].xyz)).z - Material.Material_ScalarExpressions[4].y) / Material.Material_ScalarExpressions[4].z, 0.0), 1.0);
    float _448 = spvFMul(_447, _447);
    float3 _460 = spvFAdd(float3(-0.5), Material_Texture2D_2.sample(Material_Texture2D_2Sampler, spvFAdd(_252, float3(-1.0, 0.0, 0.0) * (spvFMul(View.View_GameTime, Material.Material_ScalarExpressions[4].x) - spvFMul(Material.Material_ScalarExpressions[4].w, _448))).xy, level(-1.0)).xyz) * 2.0;
    float3 _481 = spvFAdd(_400, spvFAdd(_278 * spvFMul(Material.Material_ScalarExpressions[5].x, spvFAdd(_460.z, 1.0)), spvFAdd(_278 * _460.x, (cross(_278, float3(0.0, 0.0, 1.0)) * Material.Material_ScalarExpressions[5].y) * _460.y) * Material.Material_ScalarExpressions[5].z) * _448);
    float _482 = dot(_481, _481);
    float3 _510 = -spvFMulMatrixVector(float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _155)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _158)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _161)].xyz), float3(1.0, 0.0, 0.0));
    float3 _521 = -spvFMulMatrixVector(float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _155)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _158)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _161)].xyz), float3(0.0, 1.0, 0.0));
    float3 _532 = -spvFMulMatrixVector(float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _155)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _158)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _161)].xyz), float3(0.0, 0.0, 1.0));
    float3 _536 = fma(spvFAdd(select(float4(0.0, 0.0, 0.0, 1.0), select(float4(0.0, 0.0, 0.0, 1.0), float4(_481 / float3(sqrt(_482)), 0.0), bool4(_482 >= 9.9999999747524270787835121154785e-07)), bool4(abs(_482 - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz * sqrt(dot(_400, _400)), _244) - _245, float3(sqrt(dot(_510, _510)), sqrt(dot(_521, _521)), sqrt(dot(_532, _532))), _206);
    float4 _542 = spvFMulMatrixVector(ShadowDepthPass.ShadowDepthPass_ProjectionMatrix, float4(_536.x, _536.y, _536.z, _205.w));
    float4 _553;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_542.z < 0.0))
    {
        float4 _551 = _542;
        _551.z = 9.9999999747524270787835121154785e-07;
        float4 _552 = _551;
        _552.w = 1.0;
        _553 = _552;
    }
    else
    {
        _553 = _542;
    }
    float _559 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), _222));
    float4 _582 = _553;
    _582.z = spvFMul(fma(_553.z, ShadowDepthPass.ShadowDepthPass_ShadowParams.w, fma(ShadowDepthPass.ShadowDepthPass_ShadowParams.y, fast::clamp((abs(_559) > 0.0) ? (sqrt(fast::clamp(1.0 - spvFMul(_559, _559), 0.0, 1.0)) / _559) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z), ShadowDepthPass.ShadowDepthPass_ShadowParams.x)), _553.w);
    spvUnsafeArray<float4, 1> _593 = { float4(_215.x, _215.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_182[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_222, spvFMul(_146, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _170)].w));
    out.out_var_COLOR0 = LocalVF_VertexFetch_ColorComponentsBuffer.read(uint((_132 & uint(LocalVF.LocalVF_VertexFetch_Parameters.x)))).zyxw;
    out_var_TEXCOORD0 = _593;
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    out.out_var_TEXCOORD6 = 0.0;
    out.out_var_TEXCOORD7 = _536.xyz;
    out.gl_Position = _582;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

