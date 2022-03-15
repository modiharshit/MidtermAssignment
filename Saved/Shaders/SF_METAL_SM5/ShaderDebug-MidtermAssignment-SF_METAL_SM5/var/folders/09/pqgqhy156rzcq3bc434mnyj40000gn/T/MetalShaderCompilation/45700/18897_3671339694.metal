

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
    char _m0_pad[464];
    spvUnsafeArray<float4x4, 6> ShadowDepthPass_ShadowViewProjectionMatrices;
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

struct type_Globals
{
    uint LayerId;
};

constant float3x3 _114 = {};
constant float4x4 _115 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD15 [[user(locn2)]];
    float4 out_var_TEXCOORD0_0 [[user(locn3)]];
    uint out_var_PRIMITIVE_ID [[user(locn4)]];
    float3 out_var_TEXCOORD7 [[user(locn5)]];
    float4 out_var_TEXCOORD6 [[user(locn6)]];
    float3 out_var_TEXCOORD8 [[user(locn7)]];
    uint gl_Layer [[render_target_array_index]];
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

vertex Main_out Main_000049d1_dad432ae(Main_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(8)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(4)]], constant type_LocalVF& LocalVF [[buffer(5)]], constant type_Material& Material [[buffer(6)]], constant type_Globals& _Globals [[buffer(7)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(0)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(1)]], texture2d<float> Material_Texture2D_2 [[texture(2)]], sampler Material_Texture2D_2Sampler [[sampler(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    uint _127 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _128 = 2u * _127;
    float4 _133 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_128 + 1u)));
    float _134 = _133.w;
    float3 _135 = _133.xyz;
    float3 _137 = cross(_135, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_128)).xyz) * _134;
    float3x3 _140 = _114;
    _140[0] = cross(_137, _135) * _134;
    float3x3 _141 = _140;
    _141[1] = _137;
    float3x3 _142 = _141;
    _142[2] = _135;
    uint _143 = in.in_var_ATTRIBUTE13 * 36u;
    uint _146 = _143 + 1u;
    uint _149 = _143 + 2u;
    uint _152 = _143 + 3u;
    uint _158 = _143 + 4u;
    float3x3 _163 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _143)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _146)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _149)].xyz);
    _163[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _143)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _158)].x;
    float3x3 _166 = _163;
    _166[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _146)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _158)].y;
    float3x3 _169 = _166;
    _169[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _149)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _158)].z;
    float3x3 _170 = spvFMulMatrixMatrix(_169, _142);
    float3 _182 = spvFMul(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _146)].xyz, in.in_var_ATTRIBUTE0.yyy);
    float3 _183 = fma(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _143)].xyz, in.in_var_ATTRIBUTE0.xxx, _182);
    float3 _186 = fma(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _149)].xyz, in.in_var_ATTRIBUTE0.zzz, _183);
    float3 _188 = spvFAdd(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _152)].xyz, View.View_PreViewTranslation);
    float3 _189 = spvFAdd(_186, _188);
    float _190 = _189.x;
    float _191 = _189.y;
    float _192 = _189.z;
    float4 _193 = float4(_190, _191, _192, 1.0);
    float3 _194 = _193.xyz;
    uint _197 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    float4 _203 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(((_197 * _127) + min(0u, (_197 - 1u)))));
    float3 _204 = _170[2];
    float4x4 _206 = _115;
    _206[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _143)];
    float4x4 _208 = _206;
    _208[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _146)];
    float4x4 _210 = _208;
    _210[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _149)];
    float4x4 _212 = _210;
    _212[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _152)];
    float4 _213 = spvFMulMatrixVector(_212, float4(0.0, 0.0, 0.0, 1.0));
    float3 _214 = _213.xyz;
    float3 _215 = _214 - View.View_WorldCameraOrigin;
    float _216 = dot(_215, _215);
    float _217 = sqrt(_216);
    float3 _218 = float3(_217);
    float3 _219 = _215 / _218;
    uint _220 = _143 + 21u;
    float _224 = dot(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _220)].xyz, _219);
    float3 _227 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _220)].xyz * _224;
    float3 _228 = _219 - _227;
    float _229 = dot(_228, _228);
    float _230 = sqrt(_229);
    float3 _231 = float3(_230);
    float3 _232 = _228 / _231;
    float _233 = dot(_232, _204);
    float _234 = spvFMul(_233, _233);
    float _237 = spvFMul(_234, Material.Material_ScalarExpressions[0].z);
    uint _238 = _143 + 6u;
    uint _241 = _143 + 7u;
    uint _244 = _143 + 8u;
    float3x3 _252 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _238)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _241)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _244)].xyz);
    float3 _253 = spvFMulMatrixVector(_252, _204);
    float _254 = spvFMul(_224, _224);
    float _255 = spvFMul(_254, _254);
    float _256 = spvFMul(_255, _255);
    float _257 = _253.z;
    float _258 = mix(_237, _257, _256);
    float _259 = spvFAdd(_258, 0.0199999995529651641845703125);
    float _260 = fast::clamp(_259, 0.0, 1.0);
    float3 _261 = _194 - View.View_PreViewTranslation;
    float3 _262 = _261 - _214;
    float _263 = dot(_262, _262);
    float _264 = sqrt(_263);
    float _267 = Material.Material_ScalarExpressions[0].w - 9.9999999747524270787835121154785e-07;
    float _268 = abs(_267);
    bool _269 = _268 > 9.9999997473787516355514526367188e-06;
    bool _270 = Material.Material_ScalarExpressions[0].w >= 9.9999999747524270787835121154785e-07;
    bool4 _273 = bool4(_270);
    float4 _274 = select(float4(1.0, 0.0, 0.0, 1.0), Material.Material_VectorExpressions[5], _273);
    bool4 _275 = bool4(_269);
    float4 _276 = select(float4(1.0, 0.0, 0.0, 1.0), _274, _275);
    float3 _279 = _214 * Material.Material_ScalarExpressions[1].y;
    float _284 = spvFMul(View.View_GameTime, Material.Material_ScalarExpressions[1].z);
    float _285 = _261.x;
    float _286 = _261.y;
    float _287 = _261.z;
    float4 _288 = float4(_285, _286, _287, 1.0);
    float4x4 _290 = _115;
    _290[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _238)];
    float4x4 _292 = _290;
    _292[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _241)];
    float4x4 _294 = _292;
    _294[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _244)];
    float4x4 _296 = _294;
    _296[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _143 + 9u)];
    float4 _297 = spvFMulMatrixVector(_296, _288);
    float3 _298 = _297.xyz;
    uint _299 = _143 + 23u;
    float3 _303 = _298 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _299)].xyz;
    uint _304 = _143 + 24u;
    float3 _308 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _304)].xyz - View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _299)].xyz;
    float3 _309 = _303 / _308;
    float _310 = _309.z;
    float _313 = _310 - Material.Material_ScalarExpressions[1].w;
    float _316 = _313 / Material.Material_ScalarExpressions[2].x;
    float _317 = fast::max(_316, 0.0);
    float _318 = fast::min(_317, 1.0);
    float _319 = spvFMul(_318, _318);
    float _322 = spvFMul(Material.Material_ScalarExpressions[2].y, _319);
    float _323 = _284 - _322;
    float3 _324 = float3(-1.0, 0.0, 0.0) * _323;
    float3 _325 = spvFAdd(_279, _324);
    float2 _328 = _325.xy;
    float4 _330 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _328, level(-1.0));
    float3 _331 = _330.xyz;
    float3 _332 = spvFAdd(float3(-0.5), _331);
    float3 _333 = _332 * 2.0;
    float _334 = _333.z;
    float _335 = spvFAdd(_334, 1.0);
    float _338 = spvFMul(Material.Material_ScalarExpressions[2].z, _335);
    float3 _339 = _276.xyz;
    float3 _340 = _339 * _338;
    float _341 = _333.x;
    float3 _342 = _339 * _341;
    float3 _343 = cross(_339, float3(0.0, 0.0, 1.0));
    float3 _346 = _343 * Material.Material_ScalarExpressions[2].w;
    float _347 = _333.y;
    float3 _348 = _346 * _347;
    float3 _349 = spvFAdd(_342, _348);
    float3 _352 = _349 * Material.Material_ScalarExpressions[3].x;
    float3 _353 = spvFAdd(_340, _352);
    float3 _354 = _353 * _319;
    float3 _355 = spvFAdd(_262, _354);
    float _356 = dot(_355, _355);
    float _357 = sqrt(_356);
    float3 _358 = float3(_357);
    float3 _359 = _355 / _358;
    float _360 = _356 - 9.9999999747524270787835121154785e-07;
    float _361 = abs(_360);
    bool _362 = _361 > 9.9999997473787516355514526367188e-06;
    bool _363 = _356 >= 9.9999999747524270787835121154785e-07;
    float _364 = _359.x;
    float _365 = _359.y;
    float _366 = _359.z;
    float4 _367 = float4(_364, _365, _366, 0.0);
    bool4 _368 = bool4(_363);
    float4 _369 = select(float4(0.0, 0.0, 0.0, 1.0), _367, _368);
    bool4 _370 = bool4(_362);
    float4 _371 = select(float4(0.0, 0.0, 0.0, 1.0), _369, _370);
    float3 _372 = _371.xyz;
    float3 _373 = _372 * _264;
    float3 _374 = spvFAdd(_373, _214);
    float3 _375 = _374 - _261;
    float3x3 _382 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _143)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _146)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _149)].xyz);
    float3 _383 = spvFMulMatrixVector(_382, float3(1.0, 0.0, 0.0));
    float3 _384 = -_383;
    float _385 = dot(_384, _384);
    float _386 = sqrt(_385);
    float3x3 _393 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _143)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _146)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _149)].xyz);
    float3 _394 = spvFMulMatrixVector(_393, float3(0.0, 1.0, 0.0));
    float3 _395 = -_394;
    float _396 = dot(_395, _395);
    float _397 = sqrt(_396);
    float3x3 _404 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _143)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _146)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _149)].xyz);
    float3 _405 = spvFMulMatrixVector(_404, float3(0.0, 0.0, 1.0));
    float3 _406 = -_405;
    float _407 = dot(_406, _406);
    float _408 = sqrt(_407);
    float3 _409 = float3(_386, _397, _408);
    float3 _410 = spvFMul(_375, _409);
    float3 _411 = _261 * (-1.0);
    bool _412 = _260 >= 0.100000001490116119384765625;
    bool3 _413 = bool3(_412);
    float3 _414 = select(_411, _410, _413);
    float3 _415 = spvFAdd(_194, _414);
    float4 _416 = float4(_415.x, _415.y, _415.z, _193.w);
    float4x4 _418 = _115;
    _418[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _143)];
    float4x4 _420 = _418;
    _420[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _146)];
    float4x4 _422 = _420;
    _422[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _149)];
    float4x4 _424 = _422;
    _424[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _152)];
    float3 _427 = spvFMulMatrixVector(_424, float4(0.0, 0.0, 0.0, 1.0)).xyz - View.View_WorldCameraOrigin;
    float3 _431 = _427 / float3(sqrt(dot(_427, _427)));
    float _434 = dot(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _220)].xyz, _431);
    float3 _438 = _431 - (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _220)].xyz * _434);
    float _443 = dot(_438 / float3(sqrt(dot(_438, _438))), _204);
    float _454 = spvFMul(_434, _434);
    float _455 = spvFMul(_454, _454);
    float2 _461 = float2(fast::clamp(spvFAdd(mix(spvFMul(spvFMul(_443, _443), Material.Material_ScalarExpressions[0].z), spvFMulMatrixVector(float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _238)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _241)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _244)].xyz), _204).z, spvFMul(_455, _455)), 0.0199999995529651641845703125), 0.0, 1.0));
    float4 _471 = float4(_204, spvFMul(_134, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _158)].w));
    spvUnsafeArray<float4, 1> _472 = { float4(_203.x, _203.y, _461.x, _461.y) };
    float4 _478 = spvFMulMatrixVector(ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId], _416);
    out.out_var_TEXCOORD10_centroid = float4(_170[0], 0.0);
    out.out_var_TEXCOORD11_centroid = _471;
    out.out_var_TEXCOORD15 = _471;
    out_var_TEXCOORD0 = _472;
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    out.out_var_TEXCOORD7 = _415.xyz;
    out.out_var_TEXCOORD6 = _478;
    out.out_var_TEXCOORD8 = _204;
    out.gl_Layer = _Globals.LayerId;
    out.gl_Position = _478;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

