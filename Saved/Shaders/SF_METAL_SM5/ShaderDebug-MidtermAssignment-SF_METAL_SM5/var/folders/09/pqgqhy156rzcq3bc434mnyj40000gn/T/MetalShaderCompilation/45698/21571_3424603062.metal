

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
    char _m1_pad[4];
    uint LocalVF_LODLightmapDataIndex;
};

struct type_Material
{
    spvUnsafeArray<float4, 7> Material_VectorExpressions;
    spvUnsafeArray<float4, 6> Material_ScalarExpressions;
};

constant float3x3 _122 = {};
constant float4x4 _123 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_COLOR0 [[user(locn2)]];
    float4 out_var_TEXCOORD0_0 [[user(locn3)]];
    float4 out_var_TEXCOORD4 [[user(locn4)]];
    uint out_var_PRIMITIVE_ID [[user(locn5)]];
    uint out_var_LIGHTMAP_ID [[user(locn6)]];
    float4 out_var_TEXCOORD6 [[user(locn7)]];
    float3 out_var_TEXCOORD7 [[user(locn8)]];
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

vertex MainVertexShader_out Main_00005443_cc1f4bb6(MainVertexShader_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(8)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(3)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(4)]], constant type_View& View [[buffer(5)]], constant type_LocalVF& LocalVF [[buffer(6)]], constant type_Material& Material [[buffer(7)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(0)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(1)]], texture_buffer<float> LocalVF_VertexFetch_ColorComponentsBuffer [[texture(2)]], texture2d<float> Material_Texture2D_2 [[texture(3)]], sampler Material_Texture2D_2Sampler [[sampler(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[3];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[4];
    uint _135 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w);
    uint _136 = _135 + (gl_VertexIndex - gl_BaseVertex);
    uint _144 = 2u * _136;
    float4 _149 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_144 + 1u)));
    float _150 = _149.w;
    float3 _151 = _149.xyz;
    float3 _153 = cross(_151, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_144)).xyz) * _150;
    float3x3 _156 = _122;
    _156[0] = cross(_153, _151) * _150;
    float3x3 _157 = _156;
    _157[1] = _153;
    float3x3 _158 = _157;
    _158[2] = _151;
    uint _159 = in.in_var_ATTRIBUTE13 * 36u;
    uint _162 = _159 + 1u;
    uint _165 = _159 + 2u;
    uint _168 = _159 + 3u;
    uint _174 = _159 + 4u;
    float3x3 _179 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _159)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _162)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _165)].xyz);
    _179[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _159)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _174)].x;
    float3x3 _182 = _179;
    _182[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _162)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _174)].y;
    float3x3 _185 = _182;
    _185[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _165)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _174)].z;
    float3x3 _186 = spvFMulMatrixMatrix(_185, _158);
    float3 _198 = spvFMul(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _162)].xyz, in.in_var_ATTRIBUTE0.yyy);
    float3 _199 = fma(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _159)].xyz, in.in_var_ATTRIBUTE0.xxx, _198);
    float3 _202 = fma(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _165)].xyz, in.in_var_ATTRIBUTE0.zzz, _199);
    float3 _204 = spvFAdd(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _168)].xyz, View.View_PreViewTranslation);
    float3 _205 = spvFAdd(_202, _204);
    float _206 = _205.x;
    float _207 = _205.y;
    float _208 = _205.z;
    float4 _209 = float4(_206, _207, _208, 1.0);
    float3 _210 = _209.xyz;
    uint _213 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    uint _214 = _213 - 1u;
    uint _216 = _213 * _136;
    float4 _219 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_216 + min(0u, _214))));
    uint _220 = min(1u, _214);
    uint _221 = _216 + _220;
    float4 _222 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(_221));
    uint _223 = min(2u, _214);
    uint _224 = _216 + _223;
    float4 _225 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(_224));
    float _228 = Material.Material_ScalarExpressions[0].y - 9.9999999747524270787835121154785e-07;
    float _229 = abs(_228);
    bool _230 = _229 > 9.9999997473787516355514526367188e-06;
    bool _231 = Material.Material_ScalarExpressions[0].y >= 9.9999999747524270787835121154785e-07;
    bool4 _234 = bool4(_231);
    float4 _235 = select(float4(1.0, 0.0, 0.0, 1.0), Material.Material_VectorExpressions[5], _234);
    bool4 _236 = bool4(_230);
    float4 _237 = select(float4(1.0, 0.0, 0.0, 1.0), _235, _236);
    float4x4 _239 = _123;
    _239[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _159)];
    float4x4 _241 = _239;
    _241[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _162)];
    float4x4 _243 = _241;
    _243[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _165)];
    float4x4 _245 = _243;
    _245[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _168)];
    float4 _246 = spvFMulMatrixVector(_245, float4(0.0, 0.0, 0.0, 1.0));
    float3 _247 = _246.xyz;
    float3 _248 = _210 - View.View_PreViewTranslation;
    float3 _249 = _248 - _247;
    float3 _252 = _249 * Material.Material_ScalarExpressions[0].w;
    float3 _255 = _247 * Material.Material_ScalarExpressions[1].x;
    float3 _256 = spvFAdd(_252, _255);
    float _261 = spvFMul(View.View_GameTime, Material.Material_ScalarExpressions[1].y);
    float _264 = _225.y;
    float _265 = spvFMul(Material.Material_ScalarExpressions[1].z, _264);
    float _266 = _261 - _265;
    float3 _267 = float3(1.0, 0.0, 0.0) * _266;
    float3 _268 = spvFAdd(_256, _267);
    float2 _271 = _268.xy;
    float4 _273 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _271, level(-1.0));
    float3 _274 = _273.xyz;
    float3 _275 = spvFAdd(_274, float3(-0.25, -0.5, -0.5));
    float3 _276 = _275 * 2.0;
    float _279 = _276.x;
    float _280 = spvFMul(Material.Material_ScalarExpressions[1].w, _279);
    float3 _281 = _237.xyz;
    float3 _282 = _281 * _280;
    float _283 = _276.y;
    float _286 = spvFMul(_283, Material.Material_ScalarExpressions[2].x);
    float3 _287 = float3(0.0, 0.0, 1.0) * _286;
    float3 _288 = spvFAdd(_282, _287);
    float3 _289 = _288 * _264;
    float3 _290 = spvFAdd(_248, _289);
    float _291 = _222.y;
    float3 _292 = float3(_291);
    float3 _293 = spvFMul(_292, float3(0.0625, 1.0, 16.0));
    float3 _294 = fract(_293);
    float3 _295 = spvFAdd(float3(-0.5), _294);
    float3 _296 = _295 * 2.0;
    float3x3 _303 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _159)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _162)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _165)].xyz);
    float3 _304 = spvFMulMatrixVector(_303, _296);
    float _307 = _225.x;
    float _308 = spvFMul(Material.Material_ScalarExpressions[2].y, _307);
    float3 _309 = _304 * _308;
    float3 _310 = float3(1.0) - _309;
    float3 _311 = _290 - _310;
    float _312 = dot(_311, _311);
    float _313 = sqrt(_312);
    float _314 = dot(_304, _304);
    float _315 = sqrt(_314);
    float3 _316 = float3(_315);
    float3 _317 = _304 / _316;
    float _318 = dot(_281, _317);
    float _319 = spvFMul(_318, _318);
    float3 _320 = float3(0.0, 0.0, 1.0) * _319;
    float3 _321 = spvFAdd(_281, _320);
    float _322 = dot(_321, _321);
    float _323 = sqrt(_322);
    float3 _324 = float3(_323);
    float3 _325 = _321 / _324;
    float _326 = _222.x;
    float _327 = spvFMul(_326, 256.0);
    float _328 = spvFMul(_326, 7.111111164093017578125);
    float _329 = floor(_328);
    float _330 = spvFMul(_329, 36.0);
    float _331 = _327 - _330;
    float _332 = spvFMul(_331, 0.16666667163372039794921875);
    float _333 = floor(_332);
    float _334 = spvFMul(_333, 6.0);
    float _335 = _331 - _334;
    float3 _336 = float3(_335, _333, _329);
    float3 _337 = spvFMul(_336, float3(0.20000000298023223876953125, 0.20000000298023223876953125, 0.16666667163372039794921875));
    uint _338 = _159 + 19u;
    float3 _342 = spvFMul(_337, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _338)].xyz);
    float3 _345 = _342 * Material.Material_ScalarExpressions[2].z;
    float3 _346 = spvFAdd(_345, float3(1.0));
    float _347 = dot(_255, _255);
    float _348 = fract(_347);
    float _351 = fma(View.View_GameTime, Material.Material_ScalarExpressions[2].w, _348);
    float _354 = spvFMul(Material.Material_ScalarExpressions[3].x, _307);
    float _355 = _351 - _354;
    float3 _356 = float3(-1.0, 0.0, 0.0) * _355;
    float3 _357 = spvFAdd(_346, _356);
    float2 _358 = _357.xy;
    float4 _360 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _358, level(-1.0));
    float3 _361 = _360.xyz;
    float3 _362 = spvFAdd(float3(-0.5), _361);
    float3 _363 = _362 * 2.0;
    float _364 = _363.z;
    float _365 = spvFAdd(_364, 1.0);
    float _368 = spvFMul(Material.Material_ScalarExpressions[3].y, _365);
    float3 _369 = _325 * _368;
    float _370 = _363.x;
    float3 _371 = _325 * _370;
    float _375 = _363.y;
    float3 _376 = Material.Material_VectorExpressions[6].xyz * _375;
    float3 _377 = spvFAdd(_371, _376);
    float3 _380 = _377 * Material.Material_ScalarExpressions[3].w;
    float3 _381 = spvFAdd(_369, _380);
    float3 _382 = _381 * _307;
    float3 _383 = spvFAdd(_311, _382);
    float _384 = dot(_383, _383);
    float _385 = sqrt(_384);
    float3 _386 = float3(_385);
    float3 _387 = _383 / _386;
    float _388 = _384 - 9.9999999747524270787835121154785e-07;
    float _389 = abs(_388);
    bool _390 = _389 > 9.9999997473787516355514526367188e-06;
    bool _391 = _384 >= 9.9999999747524270787835121154785e-07;
    float _392 = _387.x;
    float _393 = _387.y;
    float _394 = _387.z;
    float4 _395 = float4(_392, _393, _394, 0.0);
    bool4 _396 = bool4(_391);
    float4 _397 = select(float4(0.0, 0.0, 0.0, 1.0), _395, _396);
    bool4 _398 = bool4(_390);
    float4 _399 = select(float4(0.0, 0.0, 0.0, 1.0), _397, _398);
    float3 _400 = _399.xyz;
    float3 _401 = _400 * _313;
    float3 _402 = spvFAdd(_401, _310);
    float3 _403 = _402 - _247;
    float _404 = dot(_403, _403);
    float _405 = sqrt(_404);
    float _408 = spvFMul(View.View_GameTime, Material.Material_ScalarExpressions[4].x);
    float _409 = _248.x;
    float _410 = _248.y;
    float _411 = _248.z;
    float4 _412 = float4(_409, _410, _411, 1.0);
    float4x4 _416 = _123;
    _416[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _159 + 6u)];
    float4x4 _420 = _416;
    _420[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _159 + 7u)];
    float4x4 _424 = _420;
    _424[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _159 + 8u)];
    float4x4 _428 = _424;
    _428[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _159 + 9u)];
    float4 _429 = spvFMulMatrixVector(_428, _412);
    float3 _430 = _429.xyz;
    uint _431 = _159 + 23u;
    float3 _435 = _430 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _431)].xyz;
    uint _436 = _159 + 24u;
    float3 _440 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _436)].xyz - View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _431)].xyz;
    float3 _441 = _435 / _440;
    float _442 = _441.z;
    float _445 = _442 - Material.Material_ScalarExpressions[4].y;
    float _448 = _445 / Material.Material_ScalarExpressions[4].z;
    float _449 = fast::max(_448, 0.0);
    float _450 = fast::min(_449, 1.0);
    float _451 = spvFMul(_450, _450);
    float _454 = spvFMul(Material.Material_ScalarExpressions[4].w, _451);
    float _455 = _408 - _454;
    float3 _456 = float3(-1.0, 0.0, 0.0) * _455;
    float3 _457 = spvFAdd(_255, _456);
    float2 _458 = _457.xy;
    float4 _460 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _458, level(-1.0));
    float3 _461 = _460.xyz;
    float3 _462 = spvFAdd(float3(-0.5), _461);
    float3 _463 = _462 * 2.0;
    float _464 = _463.z;
    float _465 = spvFAdd(_464, 1.0);
    float _468 = spvFMul(Material.Material_ScalarExpressions[5].x, _465);
    float3 _469 = _281 * _468;
    float _470 = _463.x;
    float3 _471 = _281 * _470;
    float3 _472 = cross(_281, float3(0.0, 0.0, 1.0));
    float3 _475 = _472 * Material.Material_ScalarExpressions[5].y;
    float _476 = _463.y;
    float3 _477 = _475 * _476;
    float3 _478 = spvFAdd(_471, _477);
    float3 _481 = _478 * Material.Material_ScalarExpressions[5].z;
    float3 _482 = spvFAdd(_469, _481);
    float3 _483 = _482 * _451;
    float3 _484 = spvFAdd(_403, _483);
    float _485 = dot(_484, _484);
    float _486 = sqrt(_485);
    float3 _487 = float3(_486);
    float3 _488 = _484 / _487;
    float _489 = _485 - 9.9999999747524270787835121154785e-07;
    float _490 = abs(_489);
    bool _491 = _490 > 9.9999997473787516355514526367188e-06;
    bool _492 = _485 >= 9.9999999747524270787835121154785e-07;
    float _493 = _488.x;
    float _494 = _488.y;
    float _495 = _488.z;
    float4 _496 = float4(_493, _494, _495, 0.0);
    bool4 _497 = bool4(_492);
    float4 _498 = select(float4(0.0, 0.0, 0.0, 1.0), _496, _497);
    bool4 _499 = bool4(_491);
    float4 _500 = select(float4(0.0, 0.0, 0.0, 1.0), _498, _499);
    float3 _501 = _500.xyz;
    float3 _502 = _501 * _405;
    float3 _503 = spvFAdd(_502, _247);
    float3 _504 = _503 - _248;
    float3x3 _511 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _159)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _162)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _165)].xyz);
    float3 _512 = spvFMulMatrixVector(_511, float3(1.0, 0.0, 0.0));
    float3 _513 = -_512;
    float _514 = dot(_513, _513);
    float _515 = sqrt(_514);
    float3x3 _522 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _159)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _162)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _165)].xyz);
    float3 _523 = spvFMulMatrixVector(_522, float3(0.0, 1.0, 0.0));
    float3 _524 = -_523;
    float _525 = dot(_524, _524);
    float _526 = sqrt(_525);
    float3x3 _533 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _159)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _162)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _165)].xyz);
    float3 _534 = spvFMulMatrixVector(_533, float3(0.0, 0.0, 1.0));
    float3 _535 = -_534;
    float _536 = dot(_535, _535);
    float _537 = sqrt(_536);
    float3 _538 = float3(_515, _526, _537);
    float3 _539 = fma(_504, _538, _210);
    float4 _540 = float4(_539.x, _539.y, _539.z, _209.w);
    float4 _541 = spvFMulMatrixVector(View.View_TranslatedWorldToClip, _540);
    uint _554 = as_type<uint>(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _436)].w) + LocalVF.LocalVF_LODLightmapDataIndex;
    uint _556 = (_554 * 15u) + 2u;
    float2 _561 = fma(LocalVF_VertexFetch_TexCoordBuffer.read(uint((_216 + uint(LocalVF.LocalVF_VertexFetch_Parameters.z)))).xy, View_LightmapSceneData._m0[spvStorageBufferCoords(4, spvBufferSizeConstants, float4, _556)].xy, View_LightmapSceneData._m0[spvStorageBufferCoords(4, spvBufferSizeConstants, float4, _556)].zw);
    spvUnsafeArray<float4, 1> _573 = { float4(_219.x, _219.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_186[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_186[2], spvFMul(_150, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _174)].w));
    out.out_var_COLOR0 = LocalVF_VertexFetch_ColorComponentsBuffer.read(uint((_136 & uint(LocalVF.LocalVF_VertexFetch_Parameters.x)))).zyxw;
    out_var_TEXCOORD0 = _573;
    out.out_var_TEXCOORD4 = float4(_561.x, _561.y, float2(0.0).x, float2(0.0).y);
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    out.out_var_LIGHTMAP_ID = _554;
    out.out_var_TEXCOORD6 = _540;
    out.out_var_TEXCOORD7 = _210;
    out.gl_Position = _541;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

