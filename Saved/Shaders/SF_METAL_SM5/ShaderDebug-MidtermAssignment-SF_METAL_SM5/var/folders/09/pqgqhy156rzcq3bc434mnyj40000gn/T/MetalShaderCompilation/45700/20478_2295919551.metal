

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

constant float3x3 _116 = {};
constant float4x4 _117 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_COLOR0 [[user(locn2)]];
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

vertex Main_out Main_00004ffe_88d8f3bf(Main_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(7)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(3)]], constant type_View& View [[buffer(4)]], constant type_LocalVF& LocalVF [[buffer(5)]], constant type_Material& Material [[buffer(6)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(0)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(1)]], texture_buffer<float> LocalVF_VertexFetch_ColorComponentsBuffer [[texture(2)]], texture2d<float> Material_Texture2D_2 [[texture(3)]], sampler Material_Texture2D_2Sampler [[sampler(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[3];
    uint _127 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w);
    uint _128 = _127 + (gl_VertexIndex - gl_BaseVertex);
    uint _136 = 2u * _128;
    float4 _141 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_136 + 1u)));
    float _142 = _141.w;
    float3 _143 = _141.xyz;
    float3 _145 = cross(_143, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_136)).xyz) * _142;
    float3x3 _148 = _116;
    _148[0] = cross(_145, _143) * _142;
    float3x3 _149 = _148;
    _149[1] = _145;
    float3x3 _150 = _149;
    _150[2] = _143;
    uint _151 = in.in_var_ATTRIBUTE13 * 36u;
    uint _154 = _151 + 1u;
    uint _157 = _151 + 2u;
    uint _160 = _151 + 3u;
    uint _166 = _151 + 4u;
    float3x3 _171 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _151)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _154)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _157)].xyz);
    _171[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _151)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _166)].x;
    float3x3 _174 = _171;
    _174[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _154)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _166)].y;
    float3x3 _177 = _174;
    _177[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _157)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _166)].z;
    float3x3 _178 = spvFMulMatrixMatrix(_177, _150);
    float3 _190 = spvFMul(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _154)].xyz, in.in_var_ATTRIBUTE0.yyy);
    float3 _191 = fma(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _151)].xyz, in.in_var_ATTRIBUTE0.xxx, _190);
    float3 _194 = fma(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _157)].xyz, in.in_var_ATTRIBUTE0.zzz, _191);
    float3 _196 = spvFAdd(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _160)].xyz, View.View_PreViewTranslation);
    float3 _197 = spvFAdd(_194, _196);
    float _198 = _197.x;
    float _199 = _197.y;
    float _200 = _197.z;
    float4 _201 = float4(_198, _199, _200, 1.0);
    float3 _202 = _201.xyz;
    uint _205 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    uint _206 = _205 - 1u;
    uint _208 = _205 * _128;
    float4 _211 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_208 + min(0u, _206))));
    uint _212 = min(1u, _206);
    uint _213 = _208 + _212;
    float4 _214 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(_213));
    uint _215 = min(2u, _206);
    uint _216 = _208 + _215;
    float4 _217 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(_216));
    float _220 = Material.Material_ScalarExpressions[0].y - 9.9999999747524270787835121154785e-07;
    float _221 = abs(_220);
    bool _222 = _221 > 9.9999997473787516355514526367188e-06;
    bool _223 = Material.Material_ScalarExpressions[0].y >= 9.9999999747524270787835121154785e-07;
    bool4 _226 = bool4(_223);
    float4 _227 = select(float4(1.0, 0.0, 0.0, 1.0), Material.Material_VectorExpressions[5], _226);
    bool4 _228 = bool4(_222);
    float4 _229 = select(float4(1.0, 0.0, 0.0, 1.0), _227, _228);
    float4x4 _231 = _117;
    _231[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _151)];
    float4x4 _233 = _231;
    _233[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _154)];
    float4x4 _235 = _233;
    _235[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _157)];
    float4x4 _237 = _235;
    _237[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _160)];
    float4 _238 = spvFMulMatrixVector(_237, float4(0.0, 0.0, 0.0, 1.0));
    float3 _239 = _238.xyz;
    float3 _240 = _202 - View.View_PreViewTranslation;
    float3 _241 = _240 - _239;
    float3 _244 = _241 * Material.Material_ScalarExpressions[0].w;
    float3 _247 = _239 * Material.Material_ScalarExpressions[1].x;
    float3 _248 = spvFAdd(_244, _247);
    float _253 = spvFMul(View.View_GameTime, Material.Material_ScalarExpressions[1].y);
    float _256 = _217.y;
    float _257 = spvFMul(Material.Material_ScalarExpressions[1].z, _256);
    float _258 = _253 - _257;
    float3 _259 = float3(1.0, 0.0, 0.0) * _258;
    float3 _260 = spvFAdd(_248, _259);
    float2 _263 = _260.xy;
    float4 _265 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _263, level(-1.0));
    float3 _266 = _265.xyz;
    float3 _267 = spvFAdd(_266, float3(-0.25, -0.5, -0.5));
    float3 _268 = _267 * 2.0;
    float _271 = _268.x;
    float _272 = spvFMul(Material.Material_ScalarExpressions[1].w, _271);
    float3 _273 = _229.xyz;
    float3 _274 = _273 * _272;
    float _275 = _268.y;
    float _278 = spvFMul(_275, Material.Material_ScalarExpressions[2].x);
    float3 _279 = float3(0.0, 0.0, 1.0) * _278;
    float3 _280 = spvFAdd(_274, _279);
    float3 _281 = _280 * _256;
    float3 _282 = spvFAdd(_240, _281);
    float _283 = _214.y;
    float3 _284 = float3(_283);
    float3 _285 = spvFMul(_284, float3(0.0625, 1.0, 16.0));
    float3 _286 = fract(_285);
    float3 _287 = spvFAdd(float3(-0.5), _286);
    float3 _288 = _287 * 2.0;
    float3x3 _295 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _151)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _154)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _157)].xyz);
    float3 _296 = spvFMulMatrixVector(_295, _288);
    float _299 = _217.x;
    float _300 = spvFMul(Material.Material_ScalarExpressions[2].y, _299);
    float3 _301 = _296 * _300;
    float3 _302 = float3(1.0) - _301;
    float3 _303 = _282 - _302;
    float _304 = dot(_303, _303);
    float _305 = sqrt(_304);
    float _306 = dot(_296, _296);
    float _307 = sqrt(_306);
    float3 _308 = float3(_307);
    float3 _309 = _296 / _308;
    float _310 = dot(_273, _309);
    float _311 = spvFMul(_310, _310);
    float3 _312 = float3(0.0, 0.0, 1.0) * _311;
    float3 _313 = spvFAdd(_273, _312);
    float _314 = dot(_313, _313);
    float _315 = sqrt(_314);
    float3 _316 = float3(_315);
    float3 _317 = _313 / _316;
    float _318 = _214.x;
    float _319 = spvFMul(_318, 256.0);
    float _320 = spvFMul(_318, 7.111111164093017578125);
    float _321 = floor(_320);
    float _322 = spvFMul(_321, 36.0);
    float _323 = _319 - _322;
    float _324 = spvFMul(_323, 0.16666667163372039794921875);
    float _325 = floor(_324);
    float _326 = spvFMul(_325, 6.0);
    float _327 = _323 - _326;
    float3 _328 = float3(_327, _325, _321);
    float3 _329 = spvFMul(_328, float3(0.20000000298023223876953125, 0.20000000298023223876953125, 0.16666667163372039794921875));
    uint _330 = _151 + 19u;
    float3 _334 = spvFMul(_329, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _330)].xyz);
    float3 _337 = _334 * Material.Material_ScalarExpressions[2].z;
    float3 _338 = spvFAdd(_337, float3(1.0));
    float _339 = dot(_247, _247);
    float _340 = fract(_339);
    float _343 = fma(View.View_GameTime, Material.Material_ScalarExpressions[2].w, _340);
    float _346 = spvFMul(Material.Material_ScalarExpressions[3].x, _299);
    float _347 = _343 - _346;
    float3 _348 = float3(-1.0, 0.0, 0.0) * _347;
    float3 _349 = spvFAdd(_338, _348);
    float2 _350 = _349.xy;
    float4 _352 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _350, level(-1.0));
    float3 _353 = _352.xyz;
    float3 _354 = spvFAdd(float3(-0.5), _353);
    float3 _355 = _354 * 2.0;
    float _356 = _355.z;
    float _357 = spvFAdd(_356, 1.0);
    float _360 = spvFMul(Material.Material_ScalarExpressions[3].y, _357);
    float3 _361 = _317 * _360;
    float _362 = _355.x;
    float3 _363 = _317 * _362;
    float _367 = _355.y;
    float3 _368 = Material.Material_VectorExpressions[6].xyz * _367;
    float3 _369 = spvFAdd(_363, _368);
    float3 _372 = _369 * Material.Material_ScalarExpressions[3].w;
    float3 _373 = spvFAdd(_361, _372);
    float3 _374 = _373 * _299;
    float3 _375 = spvFAdd(_303, _374);
    float _376 = dot(_375, _375);
    float _377 = sqrt(_376);
    float3 _378 = float3(_377);
    float3 _379 = _375 / _378;
    float _380 = _376 - 9.9999999747524270787835121154785e-07;
    float _381 = abs(_380);
    bool _382 = _381 > 9.9999997473787516355514526367188e-06;
    bool _383 = _376 >= 9.9999999747524270787835121154785e-07;
    float _384 = _379.x;
    float _385 = _379.y;
    float _386 = _379.z;
    float4 _387 = float4(_384, _385, _386, 0.0);
    bool4 _388 = bool4(_383);
    float4 _389 = select(float4(0.0, 0.0, 0.0, 1.0), _387, _388);
    bool4 _390 = bool4(_382);
    float4 _391 = select(float4(0.0, 0.0, 0.0, 1.0), _389, _390);
    float3 _392 = _391.xyz;
    float3 _393 = _392 * _305;
    float3 _394 = spvFAdd(_393, _302);
    float3 _395 = _394 - _239;
    float _396 = dot(_395, _395);
    float _397 = sqrt(_396);
    float _400 = spvFMul(View.View_GameTime, Material.Material_ScalarExpressions[4].x);
    float _401 = _240.x;
    float _402 = _240.y;
    float _403 = _240.z;
    float4 _404 = float4(_401, _402, _403, 1.0);
    float4x4 _408 = _117;
    _408[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _151 + 6u)];
    float4x4 _412 = _408;
    _412[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _151 + 7u)];
    float4x4 _416 = _412;
    _416[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _151 + 8u)];
    float4x4 _420 = _416;
    _420[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _151 + 9u)];
    float4 _421 = spvFMulMatrixVector(_420, _404);
    float3 _422 = _421.xyz;
    uint _423 = _151 + 23u;
    float3 _427 = _422 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _423)].xyz;
    uint _428 = _151 + 24u;
    float3 _432 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _428)].xyz - View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _423)].xyz;
    float3 _433 = _427 / _432;
    float _434 = _433.z;
    float _437 = _434 - Material.Material_ScalarExpressions[4].y;
    float _440 = _437 / Material.Material_ScalarExpressions[4].z;
    float _441 = fast::max(_440, 0.0);
    float _442 = fast::min(_441, 1.0);
    float _443 = spvFMul(_442, _442);
    float _446 = spvFMul(Material.Material_ScalarExpressions[4].w, _443);
    float _447 = _400 - _446;
    float3 _448 = float3(-1.0, 0.0, 0.0) * _447;
    float3 _449 = spvFAdd(_247, _448);
    float2 _450 = _449.xy;
    float4 _452 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _450, level(-1.0));
    float3 _453 = _452.xyz;
    float3 _454 = spvFAdd(float3(-0.5), _453);
    float3 _455 = _454 * 2.0;
    float _456 = _455.z;
    float _457 = spvFAdd(_456, 1.0);
    float _460 = spvFMul(Material.Material_ScalarExpressions[5].x, _457);
    float3 _461 = _273 * _460;
    float _462 = _455.x;
    float3 _463 = _273 * _462;
    float3 _464 = cross(_273, float3(0.0, 0.0, 1.0));
    float3 _467 = _464 * Material.Material_ScalarExpressions[5].y;
    float _468 = _455.y;
    float3 _469 = _467 * _468;
    float3 _470 = spvFAdd(_463, _469);
    float3 _473 = _470 * Material.Material_ScalarExpressions[5].z;
    float3 _474 = spvFAdd(_461, _473);
    float3 _475 = _474 * _443;
    float3 _476 = spvFAdd(_395, _475);
    float _477 = dot(_476, _476);
    float _478 = sqrt(_477);
    float3 _479 = float3(_478);
    float3 _480 = _476 / _479;
    float _481 = _477 - 9.9999999747524270787835121154785e-07;
    float _482 = abs(_481);
    bool _483 = _482 > 9.9999997473787516355514526367188e-06;
    bool _484 = _477 >= 9.9999999747524270787835121154785e-07;
    float _485 = _480.x;
    float _486 = _480.y;
    float _487 = _480.z;
    float4 _488 = float4(_485, _486, _487, 0.0);
    bool4 _489 = bool4(_484);
    float4 _490 = select(float4(0.0, 0.0, 0.0, 1.0), _488, _489);
    bool4 _491 = bool4(_483);
    float4 _492 = select(float4(0.0, 0.0, 0.0, 1.0), _490, _491);
    float3 _493 = _492.xyz;
    float3 _494 = _493 * _397;
    float3 _495 = spvFAdd(_494, _239);
    float3 _496 = _495 - _240;
    float3x3 _503 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _151)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _154)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _157)].xyz);
    float3 _504 = spvFMulMatrixVector(_503, float3(1.0, 0.0, 0.0));
    float3 _505 = -_504;
    float _506 = dot(_505, _505);
    float _507 = sqrt(_506);
    float3x3 _514 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _151)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _154)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _157)].xyz);
    float3 _515 = spvFMulMatrixVector(_514, float3(0.0, 1.0, 0.0));
    float3 _516 = -_515;
    float _517 = dot(_516, _516);
    float _518 = sqrt(_517);
    float3x3 _525 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _151)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _154)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _157)].xyz);
    float3 _526 = spvFMulMatrixVector(_525, float3(0.0, 0.0, 1.0));
    float3 _527 = -_526;
    float _528 = dot(_527, _527);
    float _529 = sqrt(_528);
    float3 _530 = float3(_507, _518, _529);
    float3 _531 = fma(_496, _530, _202);
    float4 _532 = float4(_531.x, _531.y, _531.z, _201.w);
    float4 _535 = spvFMulMatrixVector(View.View_TranslatedWorldToClip, _532);
    spvUnsafeArray<float4, 1> _547 = { float4(_211.x, _211.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_178[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_178[2], spvFMul(_142, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _166)].w));
    out.out_var_COLOR0 = LocalVF_VertexFetch_ColorComponentsBuffer.read(uint((_128 & uint(LocalVF.LocalVF_VertexFetch_Parameters.x)))).zyxw;
    out_var_TEXCOORD0 = _547;
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    out.out_var_TEXCOORD6 = _532;
    out.out_var_TEXCOORD7 = _202;
    out.gl_Position = _535;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

