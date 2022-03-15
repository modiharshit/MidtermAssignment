

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
    char _m1_pad[1056];
    float3 View_PreViewTranslation;
    char _m2_pad[1144];
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
    spvUnsafeArray<float4, 7> Material_VectorExpressions;
    spvUnsafeArray<float4, 6> Material_ScalarExpressions;
};

constant float3x3 _115 = {};
constant float4x4 _116 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_COLOR0 [[user(locn2)]];
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

vertex Main_out Main_00004fbf_c4182055(Main_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(7)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(3)]], constant type_View& View [[buffer(4)]], constant type_LocalVF& LocalVF [[buffer(5)]], constant type_Material& Material [[buffer(6)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(0)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(1)]], texture_buffer<float> LocalVF_VertexFetch_ColorComponentsBuffer [[texture(2)]], texture2d<float> Material_Texture2D_2 [[texture(3)]], sampler Material_Texture2D_2Sampler [[sampler(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[3];
    uint _128 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w);
    uint _129 = _128 + (gl_VertexIndex - gl_BaseVertex);
    uint _137 = 2u * _129;
    float4 _142 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_137 + 1u)));
    float _143 = _142.w;
    float3 _144 = _142.xyz;
    float3 _146 = cross(_144, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_137)).xyz) * _143;
    float3x3 _149 = _115;
    _149[0] = cross(_146, _144) * _143;
    float3x3 _150 = _149;
    _150[1] = _146;
    float3x3 _151 = _150;
    _151[2] = _144;
    uint _152 = in.in_var_ATTRIBUTE13 * 36u;
    uint _155 = _152 + 1u;
    uint _158 = _152 + 2u;
    uint _161 = _152 + 3u;
    uint _167 = _152 + 4u;
    float3x3 _172 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _152)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _155)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _158)].xyz);
    _172[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _152)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _167)].x;
    float3x3 _175 = _172;
    _175[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _155)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _167)].y;
    float3x3 _178 = _175;
    _178[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _158)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _167)].z;
    float3x3 _179 = spvFMulMatrixMatrix(_178, _151);
    float3 _191 = spvFMul(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _155)].xyz, in.in_var_ATTRIBUTE0.yyy);
    float3 _192 = fma(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _152)].xyz, in.in_var_ATTRIBUTE0.xxx, _191);
    float3 _195 = fma(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _158)].xyz, in.in_var_ATTRIBUTE0.zzz, _192);
    float3 _197 = spvFAdd(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _161)].xyz, View.View_PreViewTranslation);
    float3 _198 = spvFAdd(_195, _197);
    float _199 = _198.x;
    float _200 = _198.y;
    float _201 = _198.z;
    float4 _202 = float4(_199, _200, _201, 1.0);
    float3 _203 = _202.xyz;
    uint _206 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    uint _207 = _206 - 1u;
    uint _209 = _206 * _129;
    float4 _212 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_209 + min(0u, _207))));
    uint _213 = min(1u, _207);
    uint _214 = _209 + _213;
    float4 _215 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(_214));
    uint _216 = min(2u, _207);
    uint _217 = _209 + _216;
    float4 _218 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(_217));
    float _221 = Material.Material_ScalarExpressions[0].y - 9.9999999747524270787835121154785e-07;
    float _222 = abs(_221);
    bool _223 = _222 > 9.9999997473787516355514526367188e-06;
    bool _224 = Material.Material_ScalarExpressions[0].y >= 9.9999999747524270787835121154785e-07;
    bool4 _227 = bool4(_224);
    float4 _228 = select(float4(1.0, 0.0, 0.0, 1.0), Material.Material_VectorExpressions[5], _227);
    bool4 _229 = bool4(_223);
    float4 _230 = select(float4(1.0, 0.0, 0.0, 1.0), _228, _229);
    float4x4 _232 = _116;
    _232[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _152)];
    float4x4 _234 = _232;
    _234[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _155)];
    float4x4 _236 = _234;
    _236[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _158)];
    float4x4 _238 = _236;
    _238[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _161)];
    float4 _239 = spvFMulMatrixVector(_238, float4(0.0, 0.0, 0.0, 1.0));
    float3 _240 = _239.xyz;
    float3 _241 = _203 - View.View_PreViewTranslation;
    float3 _242 = _241 - _240;
    float3 _245 = _242 * Material.Material_ScalarExpressions[0].w;
    float3 _248 = _240 * Material.Material_ScalarExpressions[1].x;
    float3 _249 = spvFAdd(_245, _248);
    float _254 = spvFMul(View.View_GameTime, Material.Material_ScalarExpressions[1].y);
    float _257 = _218.y;
    float _258 = spvFMul(Material.Material_ScalarExpressions[1].z, _257);
    float _259 = _254 - _258;
    float3 _260 = float3(1.0, 0.0, 0.0) * _259;
    float3 _261 = spvFAdd(_249, _260);
    float2 _264 = _261.xy;
    float4 _266 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _264, level(-1.0));
    float3 _267 = _266.xyz;
    float3 _268 = spvFAdd(_267, float3(-0.25, -0.5, -0.5));
    float3 _269 = _268 * 2.0;
    float _272 = _269.x;
    float _273 = spvFMul(Material.Material_ScalarExpressions[1].w, _272);
    float3 _274 = _230.xyz;
    float3 _275 = _274 * _273;
    float _276 = _269.y;
    float _279 = spvFMul(_276, Material.Material_ScalarExpressions[2].x);
    float3 _280 = float3(0.0, 0.0, 1.0) * _279;
    float3 _281 = spvFAdd(_275, _280);
    float3 _282 = _281 * _257;
    float3 _283 = spvFAdd(_241, _282);
    float _284 = _215.y;
    float3 _285 = float3(_284);
    float3 _286 = spvFMul(_285, float3(0.0625, 1.0, 16.0));
    float3 _287 = fract(_286);
    float3 _288 = spvFAdd(float3(-0.5), _287);
    float3 _289 = _288 * 2.0;
    float3x3 _296 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _152)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _155)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _158)].xyz);
    float3 _297 = spvFMulMatrixVector(_296, _289);
    float _300 = _218.x;
    float _301 = spvFMul(Material.Material_ScalarExpressions[2].y, _300);
    float3 _302 = _297 * _301;
    float3 _303 = float3(1.0) - _302;
    float3 _304 = _283 - _303;
    float _305 = dot(_304, _304);
    float _306 = sqrt(_305);
    float _307 = dot(_297, _297);
    float _308 = sqrt(_307);
    float3 _309 = float3(_308);
    float3 _310 = _297 / _309;
    float _311 = dot(_274, _310);
    float _312 = spvFMul(_311, _311);
    float3 _313 = float3(0.0, 0.0, 1.0) * _312;
    float3 _314 = spvFAdd(_274, _313);
    float _315 = dot(_314, _314);
    float _316 = sqrt(_315);
    float3 _317 = float3(_316);
    float3 _318 = _314 / _317;
    float _319 = _215.x;
    float _320 = spvFMul(_319, 256.0);
    float _321 = spvFMul(_319, 7.111111164093017578125);
    float _322 = floor(_321);
    float _323 = spvFMul(_322, 36.0);
    float _324 = _320 - _323;
    float _325 = spvFMul(_324, 0.16666667163372039794921875);
    float _326 = floor(_325);
    float _327 = spvFMul(_326, 6.0);
    float _328 = _324 - _327;
    float3 _329 = float3(_328, _326, _322);
    float3 _330 = spvFMul(_329, float3(0.20000000298023223876953125, 0.20000000298023223876953125, 0.16666667163372039794921875));
    uint _331 = _152 + 19u;
    float3 _335 = spvFMul(_330, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _331)].xyz);
    float3 _338 = _335 * Material.Material_ScalarExpressions[2].z;
    float3 _339 = spvFAdd(_338, float3(1.0));
    float _340 = dot(_248, _248);
    float _341 = fract(_340);
    float _344 = fma(View.View_GameTime, Material.Material_ScalarExpressions[2].w, _341);
    float _347 = spvFMul(Material.Material_ScalarExpressions[3].x, _300);
    float _348 = _344 - _347;
    float3 _349 = float3(-1.0, 0.0, 0.0) * _348;
    float3 _350 = spvFAdd(_339, _349);
    float2 _351 = _350.xy;
    float4 _353 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _351, level(-1.0));
    float3 _354 = _353.xyz;
    float3 _355 = spvFAdd(float3(-0.5), _354);
    float3 _356 = _355 * 2.0;
    float _357 = _356.z;
    float _358 = spvFAdd(_357, 1.0);
    float _361 = spvFMul(Material.Material_ScalarExpressions[3].y, _358);
    float3 _362 = _318 * _361;
    float _363 = _356.x;
    float3 _364 = _318 * _363;
    float _368 = _356.y;
    float3 _369 = Material.Material_VectorExpressions[6].xyz * _368;
    float3 _370 = spvFAdd(_364, _369);
    float3 _373 = _370 * Material.Material_ScalarExpressions[3].w;
    float3 _374 = spvFAdd(_362, _373);
    float3 _375 = _374 * _300;
    float3 _376 = spvFAdd(_304, _375);
    float _377 = dot(_376, _376);
    float _378 = sqrt(_377);
    float3 _379 = float3(_378);
    float3 _380 = _376 / _379;
    float _381 = _377 - 9.9999999747524270787835121154785e-07;
    float _382 = abs(_381);
    bool _383 = _382 > 9.9999997473787516355514526367188e-06;
    bool _384 = _377 >= 9.9999999747524270787835121154785e-07;
    float _385 = _380.x;
    float _386 = _380.y;
    float _387 = _380.z;
    float4 _388 = float4(_385, _386, _387, 0.0);
    bool4 _389 = bool4(_384);
    float4 _390 = select(float4(0.0, 0.0, 0.0, 1.0), _388, _389);
    bool4 _391 = bool4(_383);
    float4 _392 = select(float4(0.0, 0.0, 0.0, 1.0), _390, _391);
    float3 _393 = _392.xyz;
    float3 _394 = _393 * _306;
    float3 _395 = spvFAdd(_394, _303);
    float3 _396 = _395 - _240;
    float _397 = dot(_396, _396);
    float _398 = sqrt(_397);
    float _401 = spvFMul(View.View_GameTime, Material.Material_ScalarExpressions[4].x);
    float _402 = _241.x;
    float _403 = _241.y;
    float _404 = _241.z;
    float4 _405 = float4(_402, _403, _404, 1.0);
    float4x4 _409 = _116;
    _409[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _152 + 6u)];
    float4x4 _413 = _409;
    _413[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _152 + 7u)];
    float4x4 _417 = _413;
    _417[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _152 + 8u)];
    float4x4 _421 = _417;
    _421[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _152 + 9u)];
    float4 _422 = spvFMulMatrixVector(_421, _405);
    float3 _423 = _422.xyz;
    uint _424 = _152 + 23u;
    float3 _428 = _423 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _424)].xyz;
    uint _429 = _152 + 24u;
    float3 _433 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _429)].xyz - View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _424)].xyz;
    float3 _434 = _428 / _433;
    float _435 = _434.z;
    float _438 = _435 - Material.Material_ScalarExpressions[4].y;
    float _441 = _438 / Material.Material_ScalarExpressions[4].z;
    float _442 = fast::max(_441, 0.0);
    float _443 = fast::min(_442, 1.0);
    float _444 = spvFMul(_443, _443);
    float _447 = spvFMul(Material.Material_ScalarExpressions[4].w, _444);
    float _448 = _401 - _447;
    float3 _449 = float3(-1.0, 0.0, 0.0) * _448;
    float3 _450 = spvFAdd(_248, _449);
    float2 _451 = _450.xy;
    float4 _453 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _451, level(-1.0));
    float3 _454 = _453.xyz;
    float3 _455 = spvFAdd(float3(-0.5), _454);
    float3 _456 = _455 * 2.0;
    float _457 = _456.z;
    float _458 = spvFAdd(_457, 1.0);
    float _461 = spvFMul(Material.Material_ScalarExpressions[5].x, _458);
    float3 _462 = _274 * _461;
    float _463 = _456.x;
    float3 _464 = _274 * _463;
    float3 _465 = cross(_274, float3(0.0, 0.0, 1.0));
    float3 _468 = _465 * Material.Material_ScalarExpressions[5].y;
    float _469 = _456.y;
    float3 _470 = _468 * _469;
    float3 _471 = spvFAdd(_464, _470);
    float3 _474 = _471 * Material.Material_ScalarExpressions[5].z;
    float3 _475 = spvFAdd(_462, _474);
    float3 _476 = _475 * _444;
    float3 _477 = spvFAdd(_396, _476);
    float _478 = dot(_477, _477);
    float _479 = sqrt(_478);
    float3 _480 = float3(_479);
    float3 _481 = _477 / _480;
    float _482 = _478 - 9.9999999747524270787835121154785e-07;
    float _483 = abs(_482);
    bool _484 = _483 > 9.9999997473787516355514526367188e-06;
    bool _485 = _478 >= 9.9999999747524270787835121154785e-07;
    float _486 = _481.x;
    float _487 = _481.y;
    float _488 = _481.z;
    float4 _489 = float4(_486, _487, _488, 0.0);
    bool4 _490 = bool4(_485);
    float4 _491 = select(float4(0.0, 0.0, 0.0, 1.0), _489, _490);
    bool4 _492 = bool4(_484);
    float4 _493 = select(float4(0.0, 0.0, 0.0, 1.0), _491, _492);
    float3 _494 = _493.xyz;
    float3 _495 = _494 * _398;
    float3 _496 = spvFAdd(_495, _240);
    float3 _497 = _496 - _241;
    float3x3 _504 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _152)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _155)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _158)].xyz);
    float3 _505 = spvFMulMatrixVector(_504, float3(1.0, 0.0, 0.0));
    float3 _506 = -_505;
    float _507 = dot(_506, _506);
    float _508 = sqrt(_507);
    float3x3 _515 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _152)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _155)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _158)].xyz);
    float3 _516 = spvFMulMatrixVector(_515, float3(0.0, 1.0, 0.0));
    float3 _517 = -_516;
    float _518 = dot(_517, _517);
    float _519 = sqrt(_518);
    float3x3 _526 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _152)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _155)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _158)].xyz);
    float3 _527 = spvFMulMatrixVector(_526, float3(0.0, 0.0, 1.0));
    float3 _528 = -_527;
    float _529 = dot(_528, _528);
    float _530 = sqrt(_529);
    float3 _531 = float3(_508, _519, _530);
    float3 _532 = fma(_497, _531, _203);
    float4 _533 = float4(_532.x, _532.y, _532.z, _202.w);
    float4 _534 = spvFMulMatrixVector(View.View_TranslatedWorldToClip, _533);
    spvUnsafeArray<float4, 1> _546 = { float4(_212.x, _212.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_179[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_179[2], spvFMul(_143, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _167)].w));
    out.out_var_COLOR0 = LocalVF_VertexFetch_ColorComponentsBuffer.read(uint((_129 & uint(LocalVF.LocalVF_VertexFetch_Parameters.x)))).zyxw;
    out_var_TEXCOORD0 = _546;
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    out.out_var_TEXCOORD9 = _203;
    out.gl_Position = _534;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

