

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

struct MainVertexShader_out
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

vertex MainVertexShader_out Main_000047f1_6db87d6f(MainVertexShader_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(6)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_LocalVF& LocalVF [[buffer(4)]], constant type_Material& Material [[buffer(5)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(0)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(1)]], texture2d<float> Material_Texture2D_2 [[texture(2)]], sampler Material_Texture2D_2Sampler [[sampler(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    uint _118 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _119 = 2u * _118;
    float4 _124 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_119 + 1u)));
    float _125 = _124.w;
    float3 _126 = _124.xyz;
    float3 _128 = cross(_126, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_119)).xyz) * _125;
    float3x3 _131 = _103;
    _131[0] = cross(_128, _126) * _125;
    float3x3 _132 = _131;
    _132[1] = _128;
    float3x3 _133 = _132;
    _133[2] = _126;
    uint _134 = in.in_var_ATTRIBUTE13 * 36u;
    uint _137 = _134 + 1u;
    uint _140 = _134 + 2u;
    uint _143 = _134 + 3u;
    uint _149 = _134 + 4u;
    float3x3 _154 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _134)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _137)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _140)].xyz);
    _154[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _134)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _149)].x;
    float3x3 _157 = _154;
    _157[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _137)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _149)].y;
    float3x3 _160 = _157;
    _160[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _140)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _149)].z;
    float3x3 _161 = spvFMulMatrixMatrix(_160, _133);
    float3 _173 = spvFMul(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _137)].xyz, in.in_var_ATTRIBUTE0.yyy);
    float3 _174 = fma(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _134)].xyz, in.in_var_ATTRIBUTE0.xxx, _173);
    float3 _177 = fma(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _140)].xyz, in.in_var_ATTRIBUTE0.zzz, _174);
    float3 _179 = spvFAdd(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _143)].xyz, View.View_PreViewTranslation);
    float3 _180 = spvFAdd(_177, _179);
    float _181 = _180.x;
    float _182 = _180.y;
    float _183 = _180.z;
    float4 _184 = float4(_181, _182, _183, 1.0);
    float3 _185 = _184.xyz;
    uint _188 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    float4 _194 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(((_188 * _118) + min(0u, (_188 - 1u)))));
    float4x4 _196 = _104;
    _196[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _134)];
    float4x4 _198 = _196;
    _198[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _137)];
    float4x4 _200 = _198;
    _200[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _140)];
    float4x4 _202 = _200;
    _202[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _143)];
    float4 _203 = spvFMulMatrixVector(_202, float4(0.0, 0.0, 0.0, 1.0));
    float3 _204 = _203.xyz;
    float3 _205 = _204 - View.View_WorldCameraOrigin;
    float _206 = dot(_205, _205);
    float _207 = sqrt(_206);
    float3 _208 = float3(_207);
    float3 _209 = _205 / _208;
    uint _210 = _134 + 21u;
    float _214 = dot(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _210)].xyz, _209);
    float3 _217 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _210)].xyz * _214;
    float3 _218 = _209 - _217;
    float _219 = dot(_218, _218);
    float _220 = sqrt(_219);
    float3 _221 = float3(_220);
    float3 _222 = _218 / _221;
    float3 _223 = _161[2];
    float _224 = dot(_222, _223);
    float _225 = spvFMul(_224, _224);
    float _228 = spvFMul(_225, Material.Material_ScalarExpressions[0].z);
    uint _229 = _134 + 6u;
    uint _232 = _134 + 7u;
    uint _235 = _134 + 8u;
    float3x3 _243 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _229)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _232)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _235)].xyz);
    float3 _244 = spvFMulMatrixVector(_243, _223);
    float _245 = spvFMul(_214, _214);
    float _246 = spvFMul(_245, _245);
    float _247 = spvFMul(_246, _246);
    float _248 = _244.z;
    float _249 = mix(_228, _248, _247);
    float _250 = spvFAdd(_249, 0.0199999995529651641845703125);
    float _251 = fast::clamp(_250, 0.0, 1.0);
    float3 _252 = _185 - View.View_PreViewTranslation;
    float3 _253 = _252 - _204;
    float _254 = dot(_253, _253);
    float _255 = sqrt(_254);
    float _258 = Material.Material_ScalarExpressions[0].w - 9.9999999747524270787835121154785e-07;
    float _259 = abs(_258);
    bool _260 = _259 > 9.9999997473787516355514526367188e-06;
    bool _261 = Material.Material_ScalarExpressions[0].w >= 9.9999999747524270787835121154785e-07;
    bool4 _264 = bool4(_261);
    float4 _265 = select(float4(1.0, 0.0, 0.0, 1.0), Material.Material_VectorExpressions[5], _264);
    bool4 _266 = bool4(_260);
    float4 _267 = select(float4(1.0, 0.0, 0.0, 1.0), _265, _266);
    float3 _270 = _204 * Material.Material_ScalarExpressions[1].y;
    float _275 = spvFMul(View.View_GameTime, Material.Material_ScalarExpressions[1].z);
    float _276 = _252.x;
    float _277 = _252.y;
    float _278 = _252.z;
    float4 _279 = float4(_276, _277, _278, 1.0);
    float4x4 _281 = _104;
    _281[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _229)];
    float4x4 _283 = _281;
    _283[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _232)];
    float4x4 _285 = _283;
    _285[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _235)];
    float4x4 _287 = _285;
    _287[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _134 + 9u)];
    float4 _288 = spvFMulMatrixVector(_287, _279);
    float3 _289 = _288.xyz;
    uint _290 = _134 + 23u;
    float3 _294 = _289 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _290)].xyz;
    uint _295 = _134 + 24u;
    float3 _299 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _295)].xyz - View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _290)].xyz;
    float3 _300 = _294 / _299;
    float _301 = _300.z;
    float _304 = _301 - Material.Material_ScalarExpressions[1].w;
    float _307 = _304 / Material.Material_ScalarExpressions[2].x;
    float _308 = fast::max(_307, 0.0);
    float _309 = fast::min(_308, 1.0);
    float _310 = spvFMul(_309, _309);
    float _313 = spvFMul(Material.Material_ScalarExpressions[2].y, _310);
    float _314 = _275 - _313;
    float3 _315 = float3(-1.0, 0.0, 0.0) * _314;
    float3 _316 = spvFAdd(_270, _315);
    float2 _319 = _316.xy;
    float4 _321 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _319, level(-1.0));
    float3 _322 = _321.xyz;
    float3 _323 = spvFAdd(float3(-0.5), _322);
    float3 _324 = _323 * 2.0;
    float _325 = _324.z;
    float _326 = spvFAdd(_325, 1.0);
    float _329 = spvFMul(Material.Material_ScalarExpressions[2].z, _326);
    float3 _330 = _267.xyz;
    float3 _331 = _330 * _329;
    float _332 = _324.x;
    float3 _333 = _330 * _332;
    float3 _334 = cross(_330, float3(0.0, 0.0, 1.0));
    float3 _337 = _334 * Material.Material_ScalarExpressions[2].w;
    float _338 = _324.y;
    float3 _339 = _337 * _338;
    float3 _340 = spvFAdd(_333, _339);
    float3 _343 = _340 * Material.Material_ScalarExpressions[3].x;
    float3 _344 = spvFAdd(_331, _343);
    float3 _345 = _344 * _310;
    float3 _346 = spvFAdd(_253, _345);
    float _347 = dot(_346, _346);
    float _348 = sqrt(_347);
    float3 _349 = float3(_348);
    float3 _350 = _346 / _349;
    float _351 = _347 - 9.9999999747524270787835121154785e-07;
    float _352 = abs(_351);
    bool _353 = _352 > 9.9999997473787516355514526367188e-06;
    bool _354 = _347 >= 9.9999999747524270787835121154785e-07;
    float _355 = _350.x;
    float _356 = _350.y;
    float _357 = _350.z;
    float4 _358 = float4(_355, _356, _357, 0.0);
    bool4 _359 = bool4(_354);
    float4 _360 = select(float4(0.0, 0.0, 0.0, 1.0), _358, _359);
    bool4 _361 = bool4(_353);
    float4 _362 = select(float4(0.0, 0.0, 0.0, 1.0), _360, _361);
    float3 _363 = _362.xyz;
    float3 _364 = _363 * _255;
    float3 _365 = spvFAdd(_364, _204);
    float3 _366 = _365 - _252;
    float3x3 _373 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _134)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _137)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _140)].xyz);
    float3 _374 = spvFMulMatrixVector(_373, float3(1.0, 0.0, 0.0));
    float3 _375 = -_374;
    float _376 = dot(_375, _375);
    float _377 = sqrt(_376);
    float3x3 _384 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _134)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _137)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _140)].xyz);
    float3 _385 = spvFMulMatrixVector(_384, float3(0.0, 1.0, 0.0));
    float3 _386 = -_385;
    float _387 = dot(_386, _386);
    float _388 = sqrt(_387);
    float3x3 _395 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _134)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _137)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _140)].xyz);
    float3 _396 = spvFMulMatrixVector(_395, float3(0.0, 0.0, 1.0));
    float3 _397 = -_396;
    float _398 = dot(_397, _397);
    float _399 = sqrt(_398);
    float3 _400 = float3(_377, _388, _399);
    float3 _401 = spvFMul(_366, _400);
    float3 _402 = _252 * (-1.0);
    bool _403 = _251 >= 0.100000001490116119384765625;
    bool3 _404 = bool3(_403);
    float3 _405 = select(_402, _401, _404);
    float3 _406 = spvFAdd(_185, _405);
    float4 _407 = float4(_406.x, _406.y, _406.z, _184.w);
    float4 _408 = spvFMulMatrixVector(View.View_TranslatedWorldToClip, _407);
    float4x4 _410 = _104;
    _410[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _134)];
    float4x4 _412 = _410;
    _412[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _137)];
    float4x4 _414 = _412;
    _414[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _140)];
    float4x4 _416 = _414;
    _416[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _143)];
    float3 _419 = spvFMulMatrixVector(_416, float4(0.0, 0.0, 0.0, 1.0)).xyz - View.View_WorldCameraOrigin;
    float3 _423 = _419 / float3(sqrt(dot(_419, _419)));
    float _426 = dot(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _210)].xyz, _423);
    float3 _430 = _423 - (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _210)].xyz * _426);
    float _435 = dot(_430 / float3(sqrt(dot(_430, _430))), _223);
    float _446 = spvFMul(_426, _426);
    float _447 = spvFMul(_446, _446);
    float2 _453 = float2(fast::clamp(spvFAdd(mix(spvFMul(spvFMul(_435, _435), Material.Material_ScalarExpressions[0].z), spvFMulMatrixVector(float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _229)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _232)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _235)].xyz), _223).z, spvFMul(_447, _447)), 0.0199999995529651641845703125), 0.0, 1.0));
    float4 _463 = float4(_223, spvFMul(_125, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _149)].w));
    spvUnsafeArray<float4, 1> _464 = { float4(_194.x, _194.y, _453.x, _453.y) };
    out.out_var_TEXCOORD10_centroid = float4(_161[0], 0.0);
    out.out_var_TEXCOORD11_centroid = _463;
    out.out_var_TEXCOORD15 = _463;
    out_var_TEXCOORD0 = _464;
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    out.out_var_TEXCOORD6 = _407;
    out.out_var_TEXCOORD7 = _185;
    out.gl_Position = _408;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

