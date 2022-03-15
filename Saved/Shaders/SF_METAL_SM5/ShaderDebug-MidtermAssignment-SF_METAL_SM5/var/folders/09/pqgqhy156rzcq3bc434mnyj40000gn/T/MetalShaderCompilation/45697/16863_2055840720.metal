

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

constant float3x3 _108 = {};
constant float4x4 _109 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD15 [[user(locn2)]];
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

vertex Main_out Main_000041df_7a89a3d0(Main_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(7)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(4)]], constant type_LocalVF& LocalVF [[buffer(5)]], constant type_Material& Material [[buffer(6)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(0)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(1)]], texture2d<float> Material_Texture2D_2 [[texture(2)]], sampler Material_Texture2D_2Sampler [[sampler(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    uint _121 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _122 = 2u * _121;
    float4 _127 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_122 + 1u)));
    float _128 = _127.w;
    float3 _129 = _127.xyz;
    float3 _131 = cross(_129, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_122)).xyz) * _128;
    float3x3 _134 = _108;
    _134[0] = cross(_131, _129) * _128;
    float3x3 _135 = _134;
    _135[1] = _131;
    float3x3 _136 = _135;
    _136[2] = _129;
    uint _137 = in.in_var_ATTRIBUTE13 * 36u;
    uint _140 = _137 + 1u;
    uint _143 = _137 + 2u;
    uint _146 = _137 + 3u;
    uint _152 = _137 + 4u;
    float3x3 _157 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _137)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _140)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _143)].xyz);
    _157[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _137)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _152)].x;
    float3x3 _160 = _157;
    _160[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _140)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _152)].y;
    float3x3 _163 = _160;
    _163[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _143)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _152)].z;
    float3x3 _164 = spvFMulMatrixMatrix(_163, _136);
    float4 _187 = float4(spvFAdd(fma(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _143)].xyz, in.in_var_ATTRIBUTE0.zzz, fma(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _137)].xyz, in.in_var_ATTRIBUTE0.xxx, spvFMul(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _140)].xyz, in.in_var_ATTRIBUTE0.yyy))), spvFAdd(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _146)].xyz, View.View_PreViewTranslation)), 1.0);
    float3 _188 = _187.xyz;
    uint _191 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    float4 _197 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(((_191 * _121) + min(0u, (_191 - 1u)))));
    float3 _198 = _164[2];
    float4x4 _200 = _109;
    _200[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _137)];
    float4x4 _202 = _200;
    _202[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _140)];
    float4x4 _204 = _202;
    _204[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _143)];
    float4x4 _206 = _204;
    _206[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _146)];
    float3 _208 = spvFMulMatrixVector(_206, float4(0.0, 0.0, 0.0, 1.0)).xyz;
    float3 _209 = _208 - View.View_WorldCameraOrigin;
    float3 _213 = _209 / float3(sqrt(dot(_209, _209)));
    uint _214 = _137 + 21u;
    float _218 = dot(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _214)].xyz, _213);
    float3 _222 = _213 - (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _214)].xyz * _218);
    float _227 = dot(_222 / float3(sqrt(dot(_222, _222))), _198);
    uint _232 = _137 + 6u;
    uint _235 = _137 + 7u;
    uint _238 = _137 + 8u;
    float _248 = spvFMul(_218, _218);
    float _249 = spvFMul(_248, _248);
    float3 _255 = _188 - View.View_PreViewTranslation;
    float3 _256 = _255 - _208;
    float4x4 _284 = _109;
    _284[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _232)];
    float4x4 _286 = _284;
    _286[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _235)];
    float4x4 _288 = _286;
    _288[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _238)];
    float4x4 _290 = _288;
    _290[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _137 + 9u)];
    float _312 = fast::min(fast::max((((spvFMulMatrixVector(_290, float4(_255, 1.0)).xyz - View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _137 + 23u)].xyz) / (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _137 + 24u)].xyz - View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _137 + 23u)].xyz)).z - Material.Material_ScalarExpressions[1].w) / Material.Material_ScalarExpressions[2].x, 0.0), 1.0);
    float _313 = spvFMul(_312, _312);
    float3 _327 = spvFAdd(float3(-0.5), Material_Texture2D_2.sample(Material_Texture2D_2Sampler, spvFAdd(_208 * Material.Material_ScalarExpressions[1].y, float3(-1.0, 0.0, 0.0) * (spvFMul(View.View_GameTime, Material.Material_ScalarExpressions[1].z) - spvFMul(Material.Material_ScalarExpressions[2].y, _313))).xy, level(-1.0)).xyz) * 2.0;
    float3 _333 = select(float4(1.0, 0.0, 0.0, 1.0), select(float4(1.0, 0.0, 0.0, 1.0), Material.Material_VectorExpressions[5], bool4(Material.Material_ScalarExpressions[0].w >= 9.9999999747524270787835121154785e-07)), bool4(abs(Material.Material_ScalarExpressions[0].w - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz;
    float3 _349 = spvFAdd(_256, spvFAdd(_333 * spvFMul(Material.Material_ScalarExpressions[2].z, spvFAdd(_327.z, 1.0)), spvFAdd(_333 * _327.x, (cross(_333, float3(0.0, 0.0, 1.0)) * Material.Material_ScalarExpressions[2].w) * _327.y) * Material.Material_ScalarExpressions[3].x) * _313);
    float _350 = dot(_349, _349);
    float3 _378 = -spvFMulMatrixVector(float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _137)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _140)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _143)].xyz), float3(1.0, 0.0, 0.0));
    float3 _389 = -spvFMulMatrixVector(float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _137)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _140)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _143)].xyz), float3(0.0, 1.0, 0.0));
    float3 _400 = -spvFMulMatrixVector(float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _137)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _140)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _143)].xyz), float3(0.0, 0.0, 1.0));
    float3 _409 = spvFAdd(_188, select(_255 * (-1.0), spvFMul(spvFAdd(select(float4(0.0, 0.0, 0.0, 1.0), select(float4(0.0, 0.0, 0.0, 1.0), float4(_349 / float3(sqrt(_350)), 0.0), bool4(_350 >= 9.9999999747524270787835121154785e-07)), bool4(abs(_350 - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz * sqrt(dot(_256, _256)), _208) - _255, float3(sqrt(dot(_378, _378)), sqrt(dot(_389, _389)), sqrt(dot(_400, _400)))), bool3(fast::clamp(spvFAdd(mix(spvFMul(spvFMul(_227, _227), Material.Material_ScalarExpressions[0].z), spvFMulMatrixVector(float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _232)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _235)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _238)].xyz), _198).z, spvFMul(_249, _249)), 0.0199999995529651641845703125), 0.0, 1.0) >= 0.100000001490116119384765625)));
    float4 _415 = spvFMulMatrixVector(ShadowDepthPass.ShadowDepthPass_ProjectionMatrix, float4(_409.x, _409.y, _409.z, _187.w));
    float4 _426;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_415.z < 0.0))
    {
        float4 _424 = _415;
        _424.z = 9.9999999747524270787835121154785e-07;
        float4 _425 = _424;
        _425.w = 1.0;
        _426 = _425;
    }
    else
    {
        _426 = _415;
    }
    float _432 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), _198));
    float4 _455 = _426;
    _455.z = spvFMul(fma(_426.z, ShadowDepthPass.ShadowDepthPass_ShadowParams.w, fma(ShadowDepthPass.ShadowDepthPass_ShadowParams.y, fast::clamp((abs(_432) > 0.0) ? (sqrt(fast::clamp(1.0 - spvFMul(_432, _432), 0.0, 1.0)) / _432) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z), ShadowDepthPass.ShadowDepthPass_ShadowParams.x)), _426.w);
    float4x4 _457 = _109;
    _457[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _137)];
    float4x4 _459 = _457;
    _459[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _140)];
    float4x4 _461 = _459;
    _461[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _143)];
    float4x4 _463 = _461;
    _463[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _146)];
    float3 _466 = spvFMulMatrixVector(_463, float4(0.0, 0.0, 0.0, 1.0)).xyz - View.View_WorldCameraOrigin;
    float3 _470 = _466 / float3(sqrt(dot(_466, _466)));
    float _473 = dot(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _214)].xyz, _470);
    float3 _477 = _470 - (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _214)].xyz * _473);
    float _482 = dot(_477 / float3(sqrt(dot(_477, _477))), _198);
    float _493 = spvFMul(_473, _473);
    float _494 = spvFMul(_493, _493);
    float2 _500 = float2(fast::clamp(spvFAdd(mix(spvFMul(spvFMul(_482, _482), Material.Material_ScalarExpressions[0].z), spvFMulMatrixVector(float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _232)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _235)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _238)].xyz), _198).z, spvFMul(_494, _494)), 0.0199999995529651641845703125), 0.0, 1.0));
    float4 _510 = float4(_198, spvFMul(_128, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _152)].w));
    spvUnsafeArray<float4, 1> _511 = { float4(_197.x, _197.y, _500.x, _500.y) };
    out.out_var_TEXCOORD10_centroid = float4(_164[0], 0.0);
    out.out_var_TEXCOORD11_centroid = _510;
    out.out_var_TEXCOORD15 = _510;
    out_var_TEXCOORD0 = _511;
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    out.out_var_TEXCOORD6 = 0.0;
    out.out_var_TEXCOORD7 = _409.xyz;
    out.gl_Position = _455;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

