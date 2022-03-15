

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
    char _m3_pad[1144];
    float View_GameTime;
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
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

constant float3x3 _103 = {};
constant float4x4 _104 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD15 [[user(locn2)]];
    float4 out_var_TEXCOORD0_0 [[user(locn3)]];
    uint out_var_PRIMITIVE_ID [[user(locn4)]];
    float4 out_var_TEXCOORD6 [[user(locn5)]];
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

vertex Main_out Main_00004784_05972bbe(Main_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(6)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_LocalVF& LocalVF [[buffer(4)]], constant type_Material& Material [[buffer(5)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(0)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(1)]], texture2d<float> Material_Texture2D_2 [[texture(2)]], sampler Material_Texture2D_2Sampler [[sampler(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    uint _116 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _117 = 2u * _116;
    float4 _122 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_117 + 1u)));
    float _123 = _122.w;
    float3 _124 = _122.xyz;
    float3 _126 = cross(_124, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_117)).xyz) * _123;
    float3x3 _129 = _103;
    _129[0] = cross(_126, _124) * _123;
    float3x3 _130 = _129;
    _130[1] = _126;
    float3x3 _131 = _130;
    _131[2] = _124;
    uint _132 = in.in_var_ATTRIBUTE13 * 36u;
    uint _135 = _132 + 1u;
    uint _138 = _132 + 2u;
    uint _141 = _132 + 3u;
    uint _147 = _132 + 4u;
    float3x3 _152 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _132)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _135)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _138)].xyz);
    _152[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _132)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _147)].x;
    float3x3 _155 = _152;
    _155[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _135)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _147)].y;
    float3x3 _158 = _155;
    _158[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _138)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _147)].z;
    float3x3 _159 = spvFMulMatrixMatrix(_158, _131);
    float3 _171 = spvFMul(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _135)].xyz, in.in_var_ATTRIBUTE0.yyy);
    float3 _172 = fma(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _132)].xyz, in.in_var_ATTRIBUTE0.xxx, _171);
    float3 _175 = fma(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _138)].xyz, in.in_var_ATTRIBUTE0.zzz, _172);
    float3 _177 = spvFAdd(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _141)].xyz, View.View_PreViewTranslation);
    float3 _178 = spvFAdd(_175, _177);
    float _179 = _178.x;
    float _180 = _178.y;
    float _181 = _178.z;
    float4 _182 = float4(_179, _180, _181, 1.0);
    float3 _183 = _182.xyz;
    uint _186 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    float4 _192 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(((_186 * _116) + min(0u, (_186 - 1u)))));
    float4x4 _194 = _104;
    _194[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _132)];
    float4x4 _196 = _194;
    _196[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _135)];
    float4x4 _198 = _196;
    _198[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _138)];
    float4x4 _200 = _198;
    _200[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _141)];
    float4 _201 = spvFMulMatrixVector(_200, float4(0.0, 0.0, 0.0, 1.0));
    float3 _202 = _201.xyz;
    float3 _203 = _202 - View.View_WorldCameraOrigin;
    float _204 = dot(_203, _203);
    float _205 = sqrt(_204);
    float3 _206 = float3(_205);
    float3 _207 = _203 / _206;
    uint _208 = _132 + 21u;
    float _212 = dot(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _208)].xyz, _207);
    float3 _215 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _208)].xyz * _212;
    float3 _216 = _207 - _215;
    float _217 = dot(_216, _216);
    float _218 = sqrt(_217);
    float3 _219 = float3(_218);
    float3 _220 = _216 / _219;
    float3 _221 = _159[2];
    float _222 = dot(_220, _221);
    float _223 = spvFMul(_222, _222);
    float _226 = spvFMul(_223, Material.Material_ScalarExpressions[0].z);
    uint _227 = _132 + 6u;
    uint _230 = _132 + 7u;
    uint _233 = _132 + 8u;
    float3x3 _241 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _227)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _230)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _233)].xyz);
    float3 _242 = spvFMulMatrixVector(_241, _221);
    float _243 = spvFMul(_212, _212);
    float _244 = spvFMul(_243, _243);
    float _245 = spvFMul(_244, _244);
    float _246 = _242.z;
    float _247 = mix(_226, _246, _245);
    float _248 = spvFAdd(_247, 0.0199999995529651641845703125);
    float _249 = fast::clamp(_248, 0.0, 1.0);
    float3 _250 = _183 - View.View_PreViewTranslation;
    float3 _251 = _250 - _202;
    float _252 = dot(_251, _251);
    float _253 = sqrt(_252);
    float _256 = Material.Material_ScalarExpressions[0].w - 9.9999999747524270787835121154785e-07;
    float _257 = abs(_256);
    bool _258 = _257 > 9.9999997473787516355514526367188e-06;
    bool _259 = Material.Material_ScalarExpressions[0].w >= 9.9999999747524270787835121154785e-07;
    bool4 _262 = bool4(_259);
    float4 _263 = select(float4(1.0, 0.0, 0.0, 1.0), Material.Material_VectorExpressions[5], _262);
    bool4 _264 = bool4(_258);
    float4 _265 = select(float4(1.0, 0.0, 0.0, 1.0), _263, _264);
    float3 _268 = _202 * Material.Material_ScalarExpressions[1].y;
    float _273 = spvFMul(View.View_GameTime, Material.Material_ScalarExpressions[1].z);
    float _274 = _250.x;
    float _275 = _250.y;
    float _276 = _250.z;
    float4 _277 = float4(_274, _275, _276, 1.0);
    float4x4 _279 = _104;
    _279[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _227)];
    float4x4 _281 = _279;
    _281[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _230)];
    float4x4 _283 = _281;
    _283[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _233)];
    float4x4 _285 = _283;
    _285[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _132 + 9u)];
    float4 _286 = spvFMulMatrixVector(_285, _277);
    float3 _287 = _286.xyz;
    uint _288 = _132 + 23u;
    float3 _292 = _287 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _288)].xyz;
    uint _293 = _132 + 24u;
    float3 _297 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _293)].xyz - View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _288)].xyz;
    float3 _298 = _292 / _297;
    float _299 = _298.z;
    float _302 = _299 - Material.Material_ScalarExpressions[1].w;
    float _305 = _302 / Material.Material_ScalarExpressions[2].x;
    float _306 = fast::max(_305, 0.0);
    float _307 = fast::min(_306, 1.0);
    float _308 = spvFMul(_307, _307);
    float _311 = spvFMul(Material.Material_ScalarExpressions[2].y, _308);
    float _312 = _273 - _311;
    float3 _313 = float3(-1.0, 0.0, 0.0) * _312;
    float3 _314 = spvFAdd(_268, _313);
    float2 _317 = _314.xy;
    float4 _319 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _317, level(-1.0));
    float3 _320 = _319.xyz;
    float3 _321 = spvFAdd(float3(-0.5), _320);
    float3 _322 = _321 * 2.0;
    float _323 = _322.z;
    float _324 = spvFAdd(_323, 1.0);
    float _327 = spvFMul(Material.Material_ScalarExpressions[2].z, _324);
    float3 _328 = _265.xyz;
    float3 _329 = _328 * _327;
    float _330 = _322.x;
    float3 _331 = _328 * _330;
    float3 _332 = cross(_328, float3(0.0, 0.0, 1.0));
    float3 _335 = _332 * Material.Material_ScalarExpressions[2].w;
    float _336 = _322.y;
    float3 _337 = _335 * _336;
    float3 _338 = spvFAdd(_331, _337);
    float3 _341 = _338 * Material.Material_ScalarExpressions[3].x;
    float3 _342 = spvFAdd(_329, _341);
    float3 _343 = _342 * _308;
    float3 _344 = spvFAdd(_251, _343);
    float _345 = dot(_344, _344);
    float _346 = sqrt(_345);
    float3 _347 = float3(_346);
    float3 _348 = _344 / _347;
    float _349 = _345 - 9.9999999747524270787835121154785e-07;
    float _350 = abs(_349);
    bool _351 = _350 > 9.9999997473787516355514526367188e-06;
    bool _352 = _345 >= 9.9999999747524270787835121154785e-07;
    float _353 = _348.x;
    float _354 = _348.y;
    float _355 = _348.z;
    float4 _356 = float4(_353, _354, _355, 0.0);
    bool4 _357 = bool4(_352);
    float4 _358 = select(float4(0.0, 0.0, 0.0, 1.0), _356, _357);
    bool4 _359 = bool4(_351);
    float4 _360 = select(float4(0.0, 0.0, 0.0, 1.0), _358, _359);
    float3 _361 = _360.xyz;
    float3 _362 = _361 * _253;
    float3 _363 = spvFAdd(_362, _202);
    float3 _364 = _363 - _250;
    float3x3 _371 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _132)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _135)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _138)].xyz);
    float3 _372 = spvFMulMatrixVector(_371, float3(1.0, 0.0, 0.0));
    float3 _373 = -_372;
    float _374 = dot(_373, _373);
    float _375 = sqrt(_374);
    float3x3 _382 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _132)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _135)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _138)].xyz);
    float3 _383 = spvFMulMatrixVector(_382, float3(0.0, 1.0, 0.0));
    float3 _384 = -_383;
    float _385 = dot(_384, _384);
    float _386 = sqrt(_385);
    float3x3 _393 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _132)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _135)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _138)].xyz);
    float3 _394 = spvFMulMatrixVector(_393, float3(0.0, 0.0, 1.0));
    float3 _395 = -_394;
    float _396 = dot(_395, _395);
    float _397 = sqrt(_396);
    float3 _398 = float3(_375, _386, _397);
    float3 _399 = spvFMul(_364, _398);
    float3 _400 = _250 * (-1.0);
    bool _401 = _249 >= 0.100000001490116119384765625;
    bool3 _402 = bool3(_401);
    float3 _403 = select(_400, _399, _402);
    float3 _404 = spvFAdd(_183, _403);
    float4 _405 = float4(_404.x, _404.y, _404.z, _182.w);
    float4 _408 = spvFMulMatrixVector(View.View_TranslatedWorldToClip, _405);
    float4x4 _410 = _104;
    _410[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _132)];
    float4x4 _412 = _410;
    _412[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _135)];
    float4x4 _414 = _412;
    _414[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _138)];
    float4x4 _416 = _414;
    _416[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _141)];
    float3 _419 = spvFMulMatrixVector(_416, float4(0.0, 0.0, 0.0, 1.0)).xyz - View.View_WorldCameraOrigin;
    float3 _423 = _419 / float3(sqrt(dot(_419, _419)));
    float _426 = dot(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _208)].xyz, _423);
    float3 _430 = _423 - (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _208)].xyz * _426);
    float _435 = dot(_430 / float3(sqrt(dot(_430, _430))), _221);
    float _446 = spvFMul(_426, _426);
    float _447 = spvFMul(_446, _446);
    float2 _453 = float2(fast::clamp(spvFAdd(mix(spvFMul(spvFMul(_435, _435), Material.Material_ScalarExpressions[0].z), spvFMulMatrixVector(float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _227)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _230)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _233)].xyz), _221).z, spvFMul(_447, _447)), 0.0199999995529651641845703125), 0.0, 1.0));
    float4 _463 = float4(_221, spvFMul(_123, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _147)].w));
    spvUnsafeArray<float4, 1> _464 = { float4(_192.x, _192.y, _453.x, _453.y) };
    out.out_var_TEXCOORD10_centroid = float4(_159[0], 0.0);
    out.out_var_TEXCOORD11_centroid = _463;
    out.out_var_TEXCOORD15 = _463;
    out_var_TEXCOORD0 = _464;
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    out.out_var_TEXCOORD6 = _405;
    out.out_var_TEXCOORD7 = _183;
    out.gl_Position = _408;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

