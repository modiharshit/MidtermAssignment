

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

vertex Main_out Main_00005007_fe22a953(Main_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(7)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(3)]], constant type_View& View [[buffer(4)]], constant type_LocalVF& LocalVF [[buffer(5)]], constant type_Material& Material [[buffer(6)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(0)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(1)]], texture_buffer<float> LocalVF_VertexFetch_ColorComponentsBuffer [[texture(2)]], texture2d<float> Material_Texture2D_2 [[texture(3)]], sampler Material_Texture2D_2Sampler [[sampler(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[3];
    uint _129 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w);
    uint _130 = _129 + (gl_VertexIndex - gl_BaseVertex);
    uint _138 = 2u * _130;
    float4 _143 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_138 + 1u)));
    float _144 = _143.w;
    float3 _145 = _143.xyz;
    float3 _147 = cross(_145, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_138)).xyz) * _144;
    float3x3 _150 = _116;
    _150[0] = cross(_147, _145) * _144;
    float3x3 _151 = _150;
    _151[1] = _147;
    float3x3 _152 = _151;
    _152[2] = _145;
    uint _153 = in.in_var_ATTRIBUTE13 * 36u;
    uint _156 = _153 + 1u;
    uint _159 = _153 + 2u;
    uint _162 = _153 + 3u;
    uint _168 = _153 + 4u;
    float3x3 _173 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _153)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _156)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _159)].xyz);
    _173[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _153)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _168)].x;
    float3x3 _176 = _173;
    _176[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _156)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _168)].y;
    float3x3 _179 = _176;
    _179[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _159)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _168)].z;
    float3x3 _180 = spvFMulMatrixMatrix(_179, _152);
    float3 _192 = spvFMul(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _156)].xyz, in.in_var_ATTRIBUTE0.yyy);
    float3 _193 = fma(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _153)].xyz, in.in_var_ATTRIBUTE0.xxx, _192);
    float3 _196 = fma(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _159)].xyz, in.in_var_ATTRIBUTE0.zzz, _193);
    float3 _198 = spvFAdd(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _162)].xyz, View.View_PreViewTranslation);
    float3 _199 = spvFAdd(_196, _198);
    float _200 = _199.x;
    float _201 = _199.y;
    float _202 = _199.z;
    float4 _203 = float4(_200, _201, _202, 1.0);
    float3 _204 = _203.xyz;
    uint _207 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    uint _208 = _207 - 1u;
    uint _210 = _207 * _130;
    float4 _213 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_210 + min(0u, _208))));
    uint _214 = min(1u, _208);
    uint _215 = _210 + _214;
    float4 _216 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(_215));
    uint _217 = min(2u, _208);
    uint _218 = _210 + _217;
    float4 _219 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(_218));
    float _222 = Material.Material_ScalarExpressions[0].y - 9.9999999747524270787835121154785e-07;
    float _223 = abs(_222);
    bool _224 = _223 > 9.9999997473787516355514526367188e-06;
    bool _225 = Material.Material_ScalarExpressions[0].y >= 9.9999999747524270787835121154785e-07;
    bool4 _228 = bool4(_225);
    float4 _229 = select(float4(1.0, 0.0, 0.0, 1.0), Material.Material_VectorExpressions[5], _228);
    bool4 _230 = bool4(_224);
    float4 _231 = select(float4(1.0, 0.0, 0.0, 1.0), _229, _230);
    float4x4 _233 = _117;
    _233[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _153)];
    float4x4 _235 = _233;
    _235[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _156)];
    float4x4 _237 = _235;
    _237[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _159)];
    float4x4 _239 = _237;
    _239[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _162)];
    float4 _240 = spvFMulMatrixVector(_239, float4(0.0, 0.0, 0.0, 1.0));
    float3 _241 = _240.xyz;
    float3 _242 = _204 - View.View_PreViewTranslation;
    float3 _243 = _242 - _241;
    float3 _246 = _243 * Material.Material_ScalarExpressions[0].w;
    float3 _249 = _241 * Material.Material_ScalarExpressions[1].x;
    float3 _250 = spvFAdd(_246, _249);
    float _255 = spvFMul(View.View_GameTime, Material.Material_ScalarExpressions[1].y);
    float _258 = _219.y;
    float _259 = spvFMul(Material.Material_ScalarExpressions[1].z, _258);
    float _260 = _255 - _259;
    float3 _261 = float3(1.0, 0.0, 0.0) * _260;
    float3 _262 = spvFAdd(_250, _261);
    float2 _265 = _262.xy;
    float4 _267 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _265, level(-1.0));
    float3 _268 = _267.xyz;
    float3 _269 = spvFAdd(_268, float3(-0.25, -0.5, -0.5));
    float3 _270 = _269 * 2.0;
    float _273 = _270.x;
    float _274 = spvFMul(Material.Material_ScalarExpressions[1].w, _273);
    float3 _275 = _231.xyz;
    float3 _276 = _275 * _274;
    float _277 = _270.y;
    float _280 = spvFMul(_277, Material.Material_ScalarExpressions[2].x);
    float3 _281 = float3(0.0, 0.0, 1.0) * _280;
    float3 _282 = spvFAdd(_276, _281);
    float3 _283 = _282 * _258;
    float3 _284 = spvFAdd(_242, _283);
    float _285 = _216.y;
    float3 _286 = float3(_285);
    float3 _287 = spvFMul(_286, float3(0.0625, 1.0, 16.0));
    float3 _288 = fract(_287);
    float3 _289 = spvFAdd(float3(-0.5), _288);
    float3 _290 = _289 * 2.0;
    float3x3 _297 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _153)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _156)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _159)].xyz);
    float3 _298 = spvFMulMatrixVector(_297, _290);
    float _301 = _219.x;
    float _302 = spvFMul(Material.Material_ScalarExpressions[2].y, _301);
    float3 _303 = _298 * _302;
    float3 _304 = float3(1.0) - _303;
    float3 _305 = _284 - _304;
    float _306 = dot(_305, _305);
    float _307 = sqrt(_306);
    float _308 = dot(_298, _298);
    float _309 = sqrt(_308);
    float3 _310 = float3(_309);
    float3 _311 = _298 / _310;
    float _312 = dot(_275, _311);
    float _313 = spvFMul(_312, _312);
    float3 _314 = float3(0.0, 0.0, 1.0) * _313;
    float3 _315 = spvFAdd(_275, _314);
    float _316 = dot(_315, _315);
    float _317 = sqrt(_316);
    float3 _318 = float3(_317);
    float3 _319 = _315 / _318;
    float _320 = _216.x;
    float _321 = spvFMul(_320, 256.0);
    float _322 = spvFMul(_320, 7.111111164093017578125);
    float _323 = floor(_322);
    float _324 = spvFMul(_323, 36.0);
    float _325 = _321 - _324;
    float _326 = spvFMul(_325, 0.16666667163372039794921875);
    float _327 = floor(_326);
    float _328 = spvFMul(_327, 6.0);
    float _329 = _325 - _328;
    float3 _330 = float3(_329, _327, _323);
    float3 _331 = spvFMul(_330, float3(0.20000000298023223876953125, 0.20000000298023223876953125, 0.16666667163372039794921875));
    uint _332 = _153 + 19u;
    float3 _336 = spvFMul(_331, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _332)].xyz);
    float3 _339 = _336 * Material.Material_ScalarExpressions[2].z;
    float3 _340 = spvFAdd(_339, float3(1.0));
    float _341 = dot(_249, _249);
    float _342 = fract(_341);
    float _345 = fma(View.View_GameTime, Material.Material_ScalarExpressions[2].w, _342);
    float _348 = spvFMul(Material.Material_ScalarExpressions[3].x, _301);
    float _349 = _345 - _348;
    float3 _350 = float3(-1.0, 0.0, 0.0) * _349;
    float3 _351 = spvFAdd(_340, _350);
    float2 _352 = _351.xy;
    float4 _354 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _352, level(-1.0));
    float3 _355 = _354.xyz;
    float3 _356 = spvFAdd(float3(-0.5), _355);
    float3 _357 = _356 * 2.0;
    float _358 = _357.z;
    float _359 = spvFAdd(_358, 1.0);
    float _362 = spvFMul(Material.Material_ScalarExpressions[3].y, _359);
    float3 _363 = _319 * _362;
    float _364 = _357.x;
    float3 _365 = _319 * _364;
    float _369 = _357.y;
    float3 _370 = Material.Material_VectorExpressions[6].xyz * _369;
    float3 _371 = spvFAdd(_365, _370);
    float3 _374 = _371 * Material.Material_ScalarExpressions[3].w;
    float3 _375 = spvFAdd(_363, _374);
    float3 _376 = _375 * _301;
    float3 _377 = spvFAdd(_305, _376);
    float _378 = dot(_377, _377);
    float _379 = sqrt(_378);
    float3 _380 = float3(_379);
    float3 _381 = _377 / _380;
    float _382 = _378 - 9.9999999747524270787835121154785e-07;
    float _383 = abs(_382);
    bool _384 = _383 > 9.9999997473787516355514526367188e-06;
    bool _385 = _378 >= 9.9999999747524270787835121154785e-07;
    float _386 = _381.x;
    float _387 = _381.y;
    float _388 = _381.z;
    float4 _389 = float4(_386, _387, _388, 0.0);
    bool4 _390 = bool4(_385);
    float4 _391 = select(float4(0.0, 0.0, 0.0, 1.0), _389, _390);
    bool4 _392 = bool4(_384);
    float4 _393 = select(float4(0.0, 0.0, 0.0, 1.0), _391, _392);
    float3 _394 = _393.xyz;
    float3 _395 = _394 * _307;
    float3 _396 = spvFAdd(_395, _304);
    float3 _397 = _396 - _241;
    float _398 = dot(_397, _397);
    float _399 = sqrt(_398);
    float _402 = spvFMul(View.View_GameTime, Material.Material_ScalarExpressions[4].x);
    float _403 = _242.x;
    float _404 = _242.y;
    float _405 = _242.z;
    float4 _406 = float4(_403, _404, _405, 1.0);
    float4x4 _410 = _117;
    _410[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _153 + 6u)];
    float4x4 _414 = _410;
    _414[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _153 + 7u)];
    float4x4 _418 = _414;
    _418[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _153 + 8u)];
    float4x4 _422 = _418;
    _422[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _153 + 9u)];
    float4 _423 = spvFMulMatrixVector(_422, _406);
    float3 _424 = _423.xyz;
    uint _425 = _153 + 23u;
    float3 _429 = _424 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _425)].xyz;
    uint _430 = _153 + 24u;
    float3 _434 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _430)].xyz - View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _425)].xyz;
    float3 _435 = _429 / _434;
    float _436 = _435.z;
    float _439 = _436 - Material.Material_ScalarExpressions[4].y;
    float _442 = _439 / Material.Material_ScalarExpressions[4].z;
    float _443 = fast::max(_442, 0.0);
    float _444 = fast::min(_443, 1.0);
    float _445 = spvFMul(_444, _444);
    float _448 = spvFMul(Material.Material_ScalarExpressions[4].w, _445);
    float _449 = _402 - _448;
    float3 _450 = float3(-1.0, 0.0, 0.0) * _449;
    float3 _451 = spvFAdd(_249, _450);
    float2 _452 = _451.xy;
    float4 _454 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _452, level(-1.0));
    float3 _455 = _454.xyz;
    float3 _456 = spvFAdd(float3(-0.5), _455);
    float3 _457 = _456 * 2.0;
    float _458 = _457.z;
    float _459 = spvFAdd(_458, 1.0);
    float _462 = spvFMul(Material.Material_ScalarExpressions[5].x, _459);
    float3 _463 = _275 * _462;
    float _464 = _457.x;
    float3 _465 = _275 * _464;
    float3 _466 = cross(_275, float3(0.0, 0.0, 1.0));
    float3 _469 = _466 * Material.Material_ScalarExpressions[5].y;
    float _470 = _457.y;
    float3 _471 = _469 * _470;
    float3 _472 = spvFAdd(_465, _471);
    float3 _475 = _472 * Material.Material_ScalarExpressions[5].z;
    float3 _476 = spvFAdd(_463, _475);
    float3 _477 = _476 * _445;
    float3 _478 = spvFAdd(_397, _477);
    float _479 = dot(_478, _478);
    float _480 = sqrt(_479);
    float3 _481 = float3(_480);
    float3 _482 = _478 / _481;
    float _483 = _479 - 9.9999999747524270787835121154785e-07;
    float _484 = abs(_483);
    bool _485 = _484 > 9.9999997473787516355514526367188e-06;
    bool _486 = _479 >= 9.9999999747524270787835121154785e-07;
    float _487 = _482.x;
    float _488 = _482.y;
    float _489 = _482.z;
    float4 _490 = float4(_487, _488, _489, 0.0);
    bool4 _491 = bool4(_486);
    float4 _492 = select(float4(0.0, 0.0, 0.0, 1.0), _490, _491);
    bool4 _493 = bool4(_485);
    float4 _494 = select(float4(0.0, 0.0, 0.0, 1.0), _492, _493);
    float3 _495 = _494.xyz;
    float3 _496 = _495 * _399;
    float3 _497 = spvFAdd(_496, _241);
    float3 _498 = _497 - _242;
    float3x3 _505 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _153)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _156)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _159)].xyz);
    float3 _506 = spvFMulMatrixVector(_505, float3(1.0, 0.0, 0.0));
    float3 _507 = -_506;
    float _508 = dot(_507, _507);
    float _509 = sqrt(_508);
    float3x3 _516 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _153)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _156)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _159)].xyz);
    float3 _517 = spvFMulMatrixVector(_516, float3(0.0, 1.0, 0.0));
    float3 _518 = -_517;
    float _519 = dot(_518, _518);
    float _520 = sqrt(_519);
    float3x3 _527 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _153)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _156)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _159)].xyz);
    float3 _528 = spvFMulMatrixVector(_527, float3(0.0, 0.0, 1.0));
    float3 _529 = -_528;
    float _530 = dot(_529, _529);
    float _531 = sqrt(_530);
    float3 _532 = float3(_509, _520, _531);
    float3 _533 = fma(_498, _532, _204);
    float4 _534 = float4(_533.x, _533.y, _533.z, _203.w);
    float4 _535 = spvFMulMatrixVector(View.View_TranslatedWorldToClip, _534);
    spvUnsafeArray<float4, 1> _547 = { float4(_213.x, _213.y, float4(0.0).z, float4(0.0).w) };
    out.gl_Position = _535;
    out.out_var_TEXCOORD10_centroid = float4(_180[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_180[2], spvFMul(_144, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _168)].w));
    out.out_var_COLOR0 = LocalVF_VertexFetch_ColorComponentsBuffer.read(uint((_130 & uint(LocalVF.LocalVF_VertexFetch_Parameters.x)))).zyxw;
    out_var_TEXCOORD0 = _547;
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    out.out_var_TEXCOORD6 = _534;
    out.out_var_TEXCOORD7 = _204;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

