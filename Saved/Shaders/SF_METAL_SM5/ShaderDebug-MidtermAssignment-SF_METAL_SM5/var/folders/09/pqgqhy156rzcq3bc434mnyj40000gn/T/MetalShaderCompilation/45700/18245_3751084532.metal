

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

constant float3x3 _102 = {};
constant float4x4 _103 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD15 [[user(locn2)]];
    float4 out_var_TEXCOORD0_0 [[user(locn3)]];
    uint out_var_PRIMITIVE_ID [[user(locn4)]];
    float3 out_var_TEXCOORD9 [[user(locn5)]];
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

vertex Main_out Main_00004745_df9501f4(Main_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(6)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_LocalVF& LocalVF [[buffer(4)]], constant type_Material& Material [[buffer(5)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(0)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(1)]], texture2d<float> Material_Texture2D_2 [[texture(2)]], sampler Material_Texture2D_2Sampler [[sampler(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    uint _117 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _118 = 2u * _117;
    float4 _123 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_118 + 1u)));
    float _124 = _123.w;
    float3 _125 = _123.xyz;
    float3 _127 = cross(_125, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_118)).xyz) * _124;
    float3x3 _130 = _102;
    _130[0] = cross(_127, _125) * _124;
    float3x3 _131 = _130;
    _131[1] = _127;
    float3x3 _132 = _131;
    _132[2] = _125;
    uint _133 = in.in_var_ATTRIBUTE13 * 36u;
    uint _136 = _133 + 1u;
    uint _139 = _133 + 2u;
    uint _142 = _133 + 3u;
    uint _148 = _133 + 4u;
    float3x3 _153 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _133)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _136)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _139)].xyz);
    _153[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _133)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _148)].x;
    float3x3 _156 = _153;
    _156[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _136)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _148)].y;
    float3x3 _159 = _156;
    _159[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _139)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _148)].z;
    float3x3 _160 = spvFMulMatrixMatrix(_159, _132);
    float3 _172 = spvFMul(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _136)].xyz, in.in_var_ATTRIBUTE0.yyy);
    float3 _173 = fma(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _133)].xyz, in.in_var_ATTRIBUTE0.xxx, _172);
    float3 _176 = fma(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _139)].xyz, in.in_var_ATTRIBUTE0.zzz, _173);
    float3 _178 = spvFAdd(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _142)].xyz, View.View_PreViewTranslation);
    float3 _179 = spvFAdd(_176, _178);
    float _180 = _179.x;
    float _181 = _179.y;
    float _182 = _179.z;
    float4 _183 = float4(_180, _181, _182, 1.0);
    float3 _184 = _183.xyz;
    uint _187 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    float4 _193 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(((_187 * _117) + min(0u, (_187 - 1u)))));
    float4x4 _195 = _103;
    _195[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _133)];
    float4x4 _197 = _195;
    _197[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _136)];
    float4x4 _199 = _197;
    _199[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _139)];
    float4x4 _201 = _199;
    _201[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _142)];
    float4 _202 = spvFMulMatrixVector(_201, float4(0.0, 0.0, 0.0, 1.0));
    float3 _203 = _202.xyz;
    float3 _204 = _203 - View.View_WorldCameraOrigin;
    float _205 = dot(_204, _204);
    float _206 = sqrt(_205);
    float3 _207 = float3(_206);
    float3 _208 = _204 / _207;
    uint _209 = _133 + 21u;
    float _213 = dot(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _209)].xyz, _208);
    float3 _216 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _209)].xyz * _213;
    float3 _217 = _208 - _216;
    float _218 = dot(_217, _217);
    float _219 = sqrt(_218);
    float3 _220 = float3(_219);
    float3 _221 = _217 / _220;
    float3 _222 = _160[2];
    float _223 = dot(_221, _222);
    float _224 = spvFMul(_223, _223);
    float _227 = spvFMul(_224, Material.Material_ScalarExpressions[0].z);
    uint _228 = _133 + 6u;
    uint _231 = _133 + 7u;
    uint _234 = _133 + 8u;
    float3x3 _242 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _228)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _231)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _234)].xyz);
    float3 _243 = spvFMulMatrixVector(_242, _222);
    float _244 = spvFMul(_213, _213);
    float _245 = spvFMul(_244, _244);
    float _246 = spvFMul(_245, _245);
    float _247 = _243.z;
    float _248 = mix(_227, _247, _246);
    float _249 = spvFAdd(_248, 0.0199999995529651641845703125);
    float _250 = fast::clamp(_249, 0.0, 1.0);
    float3 _251 = _184 - View.View_PreViewTranslation;
    float3 _252 = _251 - _203;
    float _253 = dot(_252, _252);
    float _254 = sqrt(_253);
    float _257 = Material.Material_ScalarExpressions[0].w - 9.9999999747524270787835121154785e-07;
    float _258 = abs(_257);
    bool _259 = _258 > 9.9999997473787516355514526367188e-06;
    bool _260 = Material.Material_ScalarExpressions[0].w >= 9.9999999747524270787835121154785e-07;
    bool4 _263 = bool4(_260);
    float4 _264 = select(float4(1.0, 0.0, 0.0, 1.0), Material.Material_VectorExpressions[5], _263);
    bool4 _265 = bool4(_259);
    float4 _266 = select(float4(1.0, 0.0, 0.0, 1.0), _264, _265);
    float3 _269 = _203 * Material.Material_ScalarExpressions[1].y;
    float _274 = spvFMul(View.View_GameTime, Material.Material_ScalarExpressions[1].z);
    float _275 = _251.x;
    float _276 = _251.y;
    float _277 = _251.z;
    float4 _278 = float4(_275, _276, _277, 1.0);
    float4x4 _280 = _103;
    _280[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _228)];
    float4x4 _282 = _280;
    _282[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _231)];
    float4x4 _284 = _282;
    _284[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _234)];
    float4x4 _286 = _284;
    _286[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _133 + 9u)];
    float4 _287 = spvFMulMatrixVector(_286, _278);
    float3 _288 = _287.xyz;
    uint _289 = _133 + 23u;
    float3 _293 = _288 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _289)].xyz;
    uint _294 = _133 + 24u;
    float3 _298 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _294)].xyz - View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _289)].xyz;
    float3 _299 = _293 / _298;
    float _300 = _299.z;
    float _303 = _300 - Material.Material_ScalarExpressions[1].w;
    float _306 = _303 / Material.Material_ScalarExpressions[2].x;
    float _307 = fast::max(_306, 0.0);
    float _308 = fast::min(_307, 1.0);
    float _309 = spvFMul(_308, _308);
    float _312 = spvFMul(Material.Material_ScalarExpressions[2].y, _309);
    float _313 = _274 - _312;
    float3 _314 = float3(-1.0, 0.0, 0.0) * _313;
    float3 _315 = spvFAdd(_269, _314);
    float2 _318 = _315.xy;
    float4 _320 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _318, level(-1.0));
    float3 _321 = _320.xyz;
    float3 _322 = spvFAdd(float3(-0.5), _321);
    float3 _323 = _322 * 2.0;
    float _324 = _323.z;
    float _325 = spvFAdd(_324, 1.0);
    float _328 = spvFMul(Material.Material_ScalarExpressions[2].z, _325);
    float3 _329 = _266.xyz;
    float3 _330 = _329 * _328;
    float _331 = _323.x;
    float3 _332 = _329 * _331;
    float3 _333 = cross(_329, float3(0.0, 0.0, 1.0));
    float3 _336 = _333 * Material.Material_ScalarExpressions[2].w;
    float _337 = _323.y;
    float3 _338 = _336 * _337;
    float3 _339 = spvFAdd(_332, _338);
    float3 _342 = _339 * Material.Material_ScalarExpressions[3].x;
    float3 _343 = spvFAdd(_330, _342);
    float3 _344 = _343 * _309;
    float3 _345 = spvFAdd(_252, _344);
    float _346 = dot(_345, _345);
    float _347 = sqrt(_346);
    float3 _348 = float3(_347);
    float3 _349 = _345 / _348;
    float _350 = _346 - 9.9999999747524270787835121154785e-07;
    float _351 = abs(_350);
    bool _352 = _351 > 9.9999997473787516355514526367188e-06;
    bool _353 = _346 >= 9.9999999747524270787835121154785e-07;
    float _354 = _349.x;
    float _355 = _349.y;
    float _356 = _349.z;
    float4 _357 = float4(_354, _355, _356, 0.0);
    bool4 _358 = bool4(_353);
    float4 _359 = select(float4(0.0, 0.0, 0.0, 1.0), _357, _358);
    bool4 _360 = bool4(_352);
    float4 _361 = select(float4(0.0, 0.0, 0.0, 1.0), _359, _360);
    float3 _362 = _361.xyz;
    float3 _363 = _362 * _254;
    float3 _364 = spvFAdd(_363, _203);
    float3 _365 = _364 - _251;
    float3x3 _372 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _133)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _136)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _139)].xyz);
    float3 _373 = spvFMulMatrixVector(_372, float3(1.0, 0.0, 0.0));
    float3 _374 = -_373;
    float _375 = dot(_374, _374);
    float _376 = sqrt(_375);
    float3x3 _383 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _133)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _136)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _139)].xyz);
    float3 _384 = spvFMulMatrixVector(_383, float3(0.0, 1.0, 0.0));
    float3 _385 = -_384;
    float _386 = dot(_385, _385);
    float _387 = sqrt(_386);
    float3x3 _394 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _133)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _136)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _139)].xyz);
    float3 _395 = spvFMulMatrixVector(_394, float3(0.0, 0.0, 1.0));
    float3 _396 = -_395;
    float _397 = dot(_396, _396);
    float _398 = sqrt(_397);
    float3 _399 = float3(_376, _387, _398);
    float3 _400 = spvFMul(_365, _399);
    float3 _401 = _251 * (-1.0);
    bool _402 = _250 >= 0.100000001490116119384765625;
    bool3 _403 = bool3(_402);
    float3 _404 = select(_401, _400, _403);
    float3 _405 = spvFAdd(_184, _404);
    float4 _406 = float4(_405.x, _405.y, _405.z, _183.w);
    float4 _407 = spvFMulMatrixVector(View.View_TranslatedWorldToClip, _406);
    float4x4 _409 = _103;
    _409[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _133)];
    float4x4 _411 = _409;
    _411[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _136)];
    float4x4 _413 = _411;
    _413[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _139)];
    float4x4 _415 = _413;
    _415[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _142)];
    float3 _418 = spvFMulMatrixVector(_415, float4(0.0, 0.0, 0.0, 1.0)).xyz - View.View_WorldCameraOrigin;
    float3 _422 = _418 / float3(sqrt(dot(_418, _418)));
    float _425 = dot(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _209)].xyz, _422);
    float3 _429 = _422 - (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _209)].xyz * _425);
    float _434 = dot(_429 / float3(sqrt(dot(_429, _429))), _222);
    float _445 = spvFMul(_425, _425);
    float _446 = spvFMul(_445, _445);
    float2 _452 = float2(fast::clamp(spvFAdd(mix(spvFMul(spvFMul(_434, _434), Material.Material_ScalarExpressions[0].z), spvFMulMatrixVector(float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _228)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _231)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _234)].xyz), _222).z, spvFMul(_446, _446)), 0.0199999995529651641845703125), 0.0, 1.0));
    float4 _462 = float4(_222, spvFMul(_124, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _148)].w));
    spvUnsafeArray<float4, 1> _463 = { float4(_193.x, _193.y, _452.x, _452.y) };
    out.out_var_TEXCOORD10_centroid = float4(_160[0], 0.0);
    out.out_var_TEXCOORD11_centroid = _462;
    out.out_var_TEXCOORD15 = _462;
    out_var_TEXCOORD0 = _463;
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    out.out_var_TEXCOORD9 = _184;
    out.gl_Position = _407;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

