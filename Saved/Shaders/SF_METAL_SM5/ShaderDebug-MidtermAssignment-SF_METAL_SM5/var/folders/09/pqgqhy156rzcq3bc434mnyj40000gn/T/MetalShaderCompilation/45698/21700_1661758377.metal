

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

constant float3x3 _120 = {};
constant float4x4 _121 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_COLOR0 [[user(locn2)]];
    float4 out_var_TEXCOORD0_0 [[user(locn3)]];
    float4 out_var_TEXCOORD4 [[user(locn4)]];
    uint out_var_PRIMITIVE_ID [[user(locn5)]];
    uint out_var_LIGHTMAP_ID [[user(locn6)]];
    float3 out_var_TEXCOORD9 [[user(locn7)]];
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

vertex Main_out Main_000054c4_630c6ba9(Main_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(8)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(3)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(4)]], constant type_View& View [[buffer(5)]], constant type_LocalVF& LocalVF [[buffer(6)]], constant type_Material& Material [[buffer(7)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(0)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(1)]], texture_buffer<float> LocalVF_VertexFetch_ColorComponentsBuffer [[texture(2)]], texture2d<float> Material_Texture2D_2 [[texture(3)]], sampler Material_Texture2D_2Sampler [[sampler(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[3];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[4];
    uint _133 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w);
    uint _134 = _133 + (gl_VertexIndex - gl_BaseVertex);
    uint _142 = 2u * _134;
    float4 _147 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_142 + 1u)));
    float _148 = _147.w;
    float3 _149 = _147.xyz;
    float3 _151 = cross(_149, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_142)).xyz) * _148;
    float3x3 _154 = _120;
    _154[0] = cross(_151, _149) * _148;
    float3x3 _155 = _154;
    _155[1] = _151;
    float3x3 _156 = _155;
    _156[2] = _149;
    uint _157 = in.in_var_ATTRIBUTE13 * 36u;
    uint _160 = _157 + 1u;
    uint _163 = _157 + 2u;
    uint _166 = _157 + 3u;
    uint _172 = _157 + 4u;
    float3x3 _177 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _157)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _160)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _163)].xyz);
    _177[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _157)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _172)].x;
    float3x3 _180 = _177;
    _180[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _160)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _172)].y;
    float3x3 _183 = _180;
    _183[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _163)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _172)].z;
    float3x3 _184 = spvFMulMatrixMatrix(_183, _156);
    float3 _196 = spvFMul(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _160)].xyz, in.in_var_ATTRIBUTE0.yyy);
    float3 _197 = fma(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _157)].xyz, in.in_var_ATTRIBUTE0.xxx, _196);
    float3 _200 = fma(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _163)].xyz, in.in_var_ATTRIBUTE0.zzz, _197);
    float3 _202 = spvFAdd(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _166)].xyz, View.View_PreViewTranslation);
    float3 _203 = spvFAdd(_200, _202);
    float _204 = _203.x;
    float _205 = _203.y;
    float _206 = _203.z;
    float4 _207 = float4(_204, _205, _206, 1.0);
    float3 _208 = _207.xyz;
    uint _211 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    uint _212 = _211 - 1u;
    uint _214 = _211 * _134;
    float4 _217 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_214 + min(0u, _212))));
    uint _218 = min(1u, _212);
    uint _219 = _214 + _218;
    float4 _220 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(_219));
    uint _221 = min(2u, _212);
    uint _222 = _214 + _221;
    float4 _223 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(_222));
    float _226 = Material.Material_ScalarExpressions[0].y - 9.9999999747524270787835121154785e-07;
    float _227 = abs(_226);
    bool _228 = _227 > 9.9999997473787516355514526367188e-06;
    bool _229 = Material.Material_ScalarExpressions[0].y >= 9.9999999747524270787835121154785e-07;
    bool4 _232 = bool4(_229);
    float4 _233 = select(float4(1.0, 0.0, 0.0, 1.0), Material.Material_VectorExpressions[5], _232);
    bool4 _234 = bool4(_228);
    float4 _235 = select(float4(1.0, 0.0, 0.0, 1.0), _233, _234);
    float4x4 _237 = _121;
    _237[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _157)];
    float4x4 _239 = _237;
    _239[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _160)];
    float4x4 _241 = _239;
    _241[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _163)];
    float4x4 _243 = _241;
    _243[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _166)];
    float4 _244 = spvFMulMatrixVector(_243, float4(0.0, 0.0, 0.0, 1.0));
    float3 _245 = _244.xyz;
    float3 _246 = _208 - View.View_PreViewTranslation;
    float3 _247 = _246 - _245;
    float3 _250 = _247 * Material.Material_ScalarExpressions[0].w;
    float3 _253 = _245 * Material.Material_ScalarExpressions[1].x;
    float3 _254 = spvFAdd(_250, _253);
    float _259 = spvFMul(View.View_GameTime, Material.Material_ScalarExpressions[1].y);
    float _262 = _223.y;
    float _263 = spvFMul(Material.Material_ScalarExpressions[1].z, _262);
    float _264 = _259 - _263;
    float3 _265 = float3(1.0, 0.0, 0.0) * _264;
    float3 _266 = spvFAdd(_254, _265);
    float2 _269 = _266.xy;
    float4 _271 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _269, level(-1.0));
    float3 _272 = _271.xyz;
    float3 _273 = spvFAdd(_272, float3(-0.25, -0.5, -0.5));
    float3 _274 = _273 * 2.0;
    float _277 = _274.x;
    float _278 = spvFMul(Material.Material_ScalarExpressions[1].w, _277);
    float3 _279 = _235.xyz;
    float3 _280 = _279 * _278;
    float _281 = _274.y;
    float _284 = spvFMul(_281, Material.Material_ScalarExpressions[2].x);
    float3 _285 = float3(0.0, 0.0, 1.0) * _284;
    float3 _286 = spvFAdd(_280, _285);
    float3 _287 = _286 * _262;
    float3 _288 = spvFAdd(_246, _287);
    float _289 = _220.y;
    float3 _290 = float3(_289);
    float3 _291 = spvFMul(_290, float3(0.0625, 1.0, 16.0));
    float3 _292 = fract(_291);
    float3 _293 = spvFAdd(float3(-0.5), _292);
    float3 _294 = _293 * 2.0;
    float3x3 _301 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _157)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _160)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _163)].xyz);
    float3 _302 = spvFMulMatrixVector(_301, _294);
    float _305 = _223.x;
    float _306 = spvFMul(Material.Material_ScalarExpressions[2].y, _305);
    float3 _307 = _302 * _306;
    float3 _308 = float3(1.0) - _307;
    float3 _309 = _288 - _308;
    float _310 = dot(_309, _309);
    float _311 = sqrt(_310);
    float _312 = dot(_302, _302);
    float _313 = sqrt(_312);
    float3 _314 = float3(_313);
    float3 _315 = _302 / _314;
    float _316 = dot(_279, _315);
    float _317 = spvFMul(_316, _316);
    float3 _318 = float3(0.0, 0.0, 1.0) * _317;
    float3 _319 = spvFAdd(_279, _318);
    float _320 = dot(_319, _319);
    float _321 = sqrt(_320);
    float3 _322 = float3(_321);
    float3 _323 = _319 / _322;
    float _324 = _220.x;
    float _325 = spvFMul(_324, 256.0);
    float _326 = spvFMul(_324, 7.111111164093017578125);
    float _327 = floor(_326);
    float _328 = spvFMul(_327, 36.0);
    float _329 = _325 - _328;
    float _330 = spvFMul(_329, 0.16666667163372039794921875);
    float _331 = floor(_330);
    float _332 = spvFMul(_331, 6.0);
    float _333 = _329 - _332;
    float3 _334 = float3(_333, _331, _327);
    float3 _335 = spvFMul(_334, float3(0.20000000298023223876953125, 0.20000000298023223876953125, 0.16666667163372039794921875));
    uint _336 = _157 + 19u;
    float3 _340 = spvFMul(_335, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _336)].xyz);
    float3 _343 = _340 * Material.Material_ScalarExpressions[2].z;
    float3 _344 = spvFAdd(_343, float3(1.0));
    float _345 = dot(_253, _253);
    float _346 = fract(_345);
    float _349 = fma(View.View_GameTime, Material.Material_ScalarExpressions[2].w, _346);
    float _352 = spvFMul(Material.Material_ScalarExpressions[3].x, _305);
    float _353 = _349 - _352;
    float3 _354 = float3(-1.0, 0.0, 0.0) * _353;
    float3 _355 = spvFAdd(_344, _354);
    float2 _356 = _355.xy;
    float4 _358 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _356, level(-1.0));
    float3 _359 = _358.xyz;
    float3 _360 = spvFAdd(float3(-0.5), _359);
    float3 _361 = _360 * 2.0;
    float _362 = _361.z;
    float _363 = spvFAdd(_362, 1.0);
    float _366 = spvFMul(Material.Material_ScalarExpressions[3].y, _363);
    float3 _367 = _323 * _366;
    float _368 = _361.x;
    float3 _369 = _323 * _368;
    float _373 = _361.y;
    float3 _374 = Material.Material_VectorExpressions[6].xyz * _373;
    float3 _375 = spvFAdd(_369, _374);
    float3 _378 = _375 * Material.Material_ScalarExpressions[3].w;
    float3 _379 = spvFAdd(_367, _378);
    float3 _380 = _379 * _305;
    float3 _381 = spvFAdd(_309, _380);
    float _382 = dot(_381, _381);
    float _383 = sqrt(_382);
    float3 _384 = float3(_383);
    float3 _385 = _381 / _384;
    float _386 = _382 - 9.9999999747524270787835121154785e-07;
    float _387 = abs(_386);
    bool _388 = _387 > 9.9999997473787516355514526367188e-06;
    bool _389 = _382 >= 9.9999999747524270787835121154785e-07;
    float _390 = _385.x;
    float _391 = _385.y;
    float _392 = _385.z;
    float4 _393 = float4(_390, _391, _392, 0.0);
    bool4 _394 = bool4(_389);
    float4 _395 = select(float4(0.0, 0.0, 0.0, 1.0), _393, _394);
    bool4 _396 = bool4(_388);
    float4 _397 = select(float4(0.0, 0.0, 0.0, 1.0), _395, _396);
    float3 _398 = _397.xyz;
    float3 _399 = _398 * _311;
    float3 _400 = spvFAdd(_399, _308);
    float3 _401 = _400 - _245;
    float _402 = dot(_401, _401);
    float _403 = sqrt(_402);
    float _406 = spvFMul(View.View_GameTime, Material.Material_ScalarExpressions[4].x);
    float _407 = _246.x;
    float _408 = _246.y;
    float _409 = _246.z;
    float4 _410 = float4(_407, _408, _409, 1.0);
    float4x4 _414 = _121;
    _414[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _157 + 6u)];
    float4x4 _418 = _414;
    _418[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _157 + 7u)];
    float4x4 _422 = _418;
    _422[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _157 + 8u)];
    float4x4 _426 = _422;
    _426[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _157 + 9u)];
    float4 _427 = spvFMulMatrixVector(_426, _410);
    float3 _428 = _427.xyz;
    uint _429 = _157 + 23u;
    float3 _433 = _428 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _429)].xyz;
    uint _434 = _157 + 24u;
    float3 _438 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _434)].xyz - View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _429)].xyz;
    float3 _439 = _433 / _438;
    float _440 = _439.z;
    float _443 = _440 - Material.Material_ScalarExpressions[4].y;
    float _446 = _443 / Material.Material_ScalarExpressions[4].z;
    float _447 = fast::max(_446, 0.0);
    float _448 = fast::min(_447, 1.0);
    float _449 = spvFMul(_448, _448);
    float _452 = spvFMul(Material.Material_ScalarExpressions[4].w, _449);
    float _453 = _406 - _452;
    float3 _454 = float3(-1.0, 0.0, 0.0) * _453;
    float3 _455 = spvFAdd(_253, _454);
    float2 _456 = _455.xy;
    float4 _458 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _456, level(-1.0));
    float3 _459 = _458.xyz;
    float3 _460 = spvFAdd(float3(-0.5), _459);
    float3 _461 = _460 * 2.0;
    float _462 = _461.z;
    float _463 = spvFAdd(_462, 1.0);
    float _466 = spvFMul(Material.Material_ScalarExpressions[5].x, _463);
    float3 _467 = _279 * _466;
    float _468 = _461.x;
    float3 _469 = _279 * _468;
    float3 _470 = cross(_279, float3(0.0, 0.0, 1.0));
    float3 _473 = _470 * Material.Material_ScalarExpressions[5].y;
    float _474 = _461.y;
    float3 _475 = _473 * _474;
    float3 _476 = spvFAdd(_469, _475);
    float3 _479 = _476 * Material.Material_ScalarExpressions[5].z;
    float3 _480 = spvFAdd(_467, _479);
    float3 _481 = _480 * _449;
    float3 _482 = spvFAdd(_401, _481);
    float _483 = dot(_482, _482);
    float _484 = sqrt(_483);
    float3 _485 = float3(_484);
    float3 _486 = _482 / _485;
    float _487 = _483 - 9.9999999747524270787835121154785e-07;
    float _488 = abs(_487);
    bool _489 = _488 > 9.9999997473787516355514526367188e-06;
    bool _490 = _483 >= 9.9999999747524270787835121154785e-07;
    float _491 = _486.x;
    float _492 = _486.y;
    float _493 = _486.z;
    float4 _494 = float4(_491, _492, _493, 0.0);
    bool4 _495 = bool4(_490);
    float4 _496 = select(float4(0.0, 0.0, 0.0, 1.0), _494, _495);
    bool4 _497 = bool4(_489);
    float4 _498 = select(float4(0.0, 0.0, 0.0, 1.0), _496, _497);
    float3 _499 = _498.xyz;
    float3 _500 = _499 * _403;
    float3 _501 = spvFAdd(_500, _245);
    float3 _502 = _501 - _246;
    float3x3 _509 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _157)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _160)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _163)].xyz);
    float3 _510 = spvFMulMatrixVector(_509, float3(1.0, 0.0, 0.0));
    float3 _511 = -_510;
    float _512 = dot(_511, _511);
    float _513 = sqrt(_512);
    float3x3 _520 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _157)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _160)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _163)].xyz);
    float3 _521 = spvFMulMatrixVector(_520, float3(0.0, 1.0, 0.0));
    float3 _522 = -_521;
    float _523 = dot(_522, _522);
    float _524 = sqrt(_523);
    float3x3 _531 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _157)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _160)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _163)].xyz);
    float3 _532 = spvFMulMatrixVector(_531, float3(0.0, 0.0, 1.0));
    float3 _533 = -_532;
    float _534 = dot(_533, _533);
    float _535 = sqrt(_534);
    float3 _536 = float3(_513, _524, _535);
    float3 _537 = fma(_502, _536, _208);
    float4 _538 = float4(_537.x, _537.y, _537.z, _207.w);
    float4 _539 = spvFMulMatrixVector(View.View_TranslatedWorldToClip, _538);
    float2 _546 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_214 + uint(LocalVF.LocalVF_VertexFetch_Parameters.z)))).xy;
    uint _552 = as_type<uint>(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _434)].w) + LocalVF.LocalVF_LODLightmapDataIndex;
    uint _553 = _552 * 15u;
    uint _554 = _553 + 2u;
    float2 _559 = fma(_546, View_LightmapSceneData._m0[spvStorageBufferCoords(4, spvBufferSizeConstants, float4, _554)].xy, View_LightmapSceneData._m0[spvStorageBufferCoords(4, spvBufferSizeConstants, float4, _554)].zw);
    uint _560 = _553 + 3u;
    float2 _565 = fma(_546, View_LightmapSceneData._m0[spvStorageBufferCoords(4, spvBufferSizeConstants, float4, _560)].xy, View_LightmapSceneData._m0[spvStorageBufferCoords(4, spvBufferSizeConstants, float4, _560)].zw);
    spvUnsafeArray<float4, 1> _577 = { float4(_217.x, _217.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_184[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_184[2], spvFMul(_148, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _172)].w));
    out.out_var_COLOR0 = LocalVF_VertexFetch_ColorComponentsBuffer.read(uint((_134 & uint(LocalVF.LocalVF_VertexFetch_Parameters.x)))).zyxw;
    out_var_TEXCOORD0 = _577;
    out.out_var_TEXCOORD4 = float4(_559.x, _559.y, _565.x, _565.y);
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    out.out_var_LIGHTMAP_ID = _552;
    out.out_var_TEXCOORD9 = _208;
    out.gl_Position = _539;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

