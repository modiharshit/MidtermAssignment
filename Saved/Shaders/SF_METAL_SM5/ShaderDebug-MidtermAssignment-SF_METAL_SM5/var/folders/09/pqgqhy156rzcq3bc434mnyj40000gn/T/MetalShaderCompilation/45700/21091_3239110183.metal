

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
    char _m0_pad[1120];
    float3 View_PreViewTranslation;
    char _m1_pad[1144];
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
    spvUnsafeArray<float4, 7> Material_VectorExpressions;
    spvUnsafeArray<float4, 6> Material_ScalarExpressions;
};

struct type_Globals
{
    uint LayerId;
};

constant float3x3 _127 = {};
constant float4x4 _128 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_COLOR0 [[user(locn2)]];
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

vertex Main_out Main_00005263_c110e627(Main_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(9)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(3)]], constant type_View& View [[buffer(4)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(5)]], constant type_LocalVF& LocalVF [[buffer(6)]], constant type_Material& Material [[buffer(7)]], constant type_Globals& _Globals [[buffer(8)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(0)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(1)]], texture_buffer<float> LocalVF_VertexFetch_ColorComponentsBuffer [[texture(2)]], texture2d<float> Material_Texture2D_2 [[texture(3)]], sampler Material_Texture2D_2Sampler [[sampler(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[3];
    uint _137 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w);
    uint _138 = _137 + (gl_VertexIndex - gl_BaseVertex);
    uint _146 = 2u * _138;
    float4 _151 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_146 + 1u)));
    float _152 = _151.w;
    float3 _153 = _151.xyz;
    float3 _155 = cross(_153, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_146)).xyz) * _152;
    float3x3 _158 = _127;
    _158[0] = cross(_155, _153) * _152;
    float3x3 _159 = _158;
    _159[1] = _155;
    float3x3 _160 = _159;
    _160[2] = _153;
    uint _161 = in.in_var_ATTRIBUTE13 * 36u;
    uint _164 = _161 + 1u;
    uint _167 = _161 + 2u;
    uint _170 = _161 + 3u;
    uint _176 = _161 + 4u;
    float3x3 _181 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _161)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _164)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _167)].xyz);
    _181[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _161)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _176)].x;
    float3x3 _184 = _181;
    _184[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _164)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _176)].y;
    float3x3 _187 = _184;
    _187[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _167)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _176)].z;
    float3x3 _188 = spvFMulMatrixMatrix(_187, _160);
    float3 _200 = spvFMul(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _164)].xyz, in.in_var_ATTRIBUTE0.yyy);
    float3 _201 = fma(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _161)].xyz, in.in_var_ATTRIBUTE0.xxx, _200);
    float3 _204 = fma(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _167)].xyz, in.in_var_ATTRIBUTE0.zzz, _201);
    float3 _206 = spvFAdd(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _170)].xyz, View.View_PreViewTranslation);
    float3 _207 = spvFAdd(_204, _206);
    float _208 = _207.x;
    float _209 = _207.y;
    float _210 = _207.z;
    float4 _211 = float4(_208, _209, _210, 1.0);
    float3 _212 = _211.xyz;
    uint _215 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    uint _216 = _215 - 1u;
    uint _218 = _215 * _138;
    float4 _221 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_218 + min(0u, _216))));
    uint _222 = min(1u, _216);
    uint _223 = _218 + _222;
    float4 _224 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(_223));
    uint _225 = min(2u, _216);
    uint _226 = _218 + _225;
    float4 _227 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(_226));
    float3 _228 = _188[2];
    float _231 = Material.Material_ScalarExpressions[0].y - 9.9999999747524270787835121154785e-07;
    float _232 = abs(_231);
    bool _233 = _232 > 9.9999997473787516355514526367188e-06;
    bool _234 = Material.Material_ScalarExpressions[0].y >= 9.9999999747524270787835121154785e-07;
    bool4 _237 = bool4(_234);
    float4 _238 = select(float4(1.0, 0.0, 0.0, 1.0), Material.Material_VectorExpressions[5], _237);
    bool4 _239 = bool4(_233);
    float4 _240 = select(float4(1.0, 0.0, 0.0, 1.0), _238, _239);
    float4x4 _242 = _128;
    _242[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _161)];
    float4x4 _244 = _242;
    _244[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _164)];
    float4x4 _246 = _244;
    _246[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _167)];
    float4x4 _248 = _246;
    _248[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _170)];
    float4 _249 = spvFMulMatrixVector(_248, float4(0.0, 0.0, 0.0, 1.0));
    float3 _250 = _249.xyz;
    float3 _251 = _212 - View.View_PreViewTranslation;
    float3 _252 = _251 - _250;
    float3 _255 = _252 * Material.Material_ScalarExpressions[0].w;
    float3 _258 = _250 * Material.Material_ScalarExpressions[1].x;
    float3 _259 = spvFAdd(_255, _258);
    float _264 = spvFMul(View.View_GameTime, Material.Material_ScalarExpressions[1].y);
    float _267 = _227.y;
    float _268 = spvFMul(Material.Material_ScalarExpressions[1].z, _267);
    float _269 = _264 - _268;
    float3 _270 = float3(1.0, 0.0, 0.0) * _269;
    float3 _271 = spvFAdd(_259, _270);
    float2 _274 = _271.xy;
    float4 _276 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _274, level(-1.0));
    float3 _277 = _276.xyz;
    float3 _278 = spvFAdd(_277, float3(-0.25, -0.5, -0.5));
    float3 _279 = _278 * 2.0;
    float _282 = _279.x;
    float _283 = spvFMul(Material.Material_ScalarExpressions[1].w, _282);
    float3 _284 = _240.xyz;
    float3 _285 = _284 * _283;
    float _286 = _279.y;
    float _289 = spvFMul(_286, Material.Material_ScalarExpressions[2].x);
    float3 _290 = float3(0.0, 0.0, 1.0) * _289;
    float3 _291 = spvFAdd(_285, _290);
    float3 _292 = _291 * _267;
    float3 _293 = spvFAdd(_251, _292);
    float _294 = _224.y;
    float3 _295 = float3(_294);
    float3 _296 = spvFMul(_295, float3(0.0625, 1.0, 16.0));
    float3 _297 = fract(_296);
    float3 _298 = spvFAdd(float3(-0.5), _297);
    float3 _299 = _298 * 2.0;
    float3x3 _306 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _161)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _164)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _167)].xyz);
    float3 _307 = spvFMulMatrixVector(_306, _299);
    float _310 = _227.x;
    float _311 = spvFMul(Material.Material_ScalarExpressions[2].y, _310);
    float3 _312 = _307 * _311;
    float3 _313 = float3(1.0) - _312;
    float3 _314 = _293 - _313;
    float _315 = dot(_314, _314);
    float _316 = sqrt(_315);
    float _317 = dot(_307, _307);
    float _318 = sqrt(_317);
    float3 _319 = float3(_318);
    float3 _320 = _307 / _319;
    float _321 = dot(_284, _320);
    float _322 = spvFMul(_321, _321);
    float3 _323 = float3(0.0, 0.0, 1.0) * _322;
    float3 _324 = spvFAdd(_284, _323);
    float _325 = dot(_324, _324);
    float _326 = sqrt(_325);
    float3 _327 = float3(_326);
    float3 _328 = _324 / _327;
    float _329 = _224.x;
    float _330 = spvFMul(_329, 256.0);
    float _331 = spvFMul(_329, 7.111111164093017578125);
    float _332 = floor(_331);
    float _333 = spvFMul(_332, 36.0);
    float _334 = _330 - _333;
    float _335 = spvFMul(_334, 0.16666667163372039794921875);
    float _336 = floor(_335);
    float _337 = spvFMul(_336, 6.0);
    float _338 = _334 - _337;
    float3 _339 = float3(_338, _336, _332);
    float3 _340 = spvFMul(_339, float3(0.20000000298023223876953125, 0.20000000298023223876953125, 0.16666667163372039794921875));
    uint _341 = _161 + 19u;
    float3 _345 = spvFMul(_340, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _341)].xyz);
    float3 _348 = _345 * Material.Material_ScalarExpressions[2].z;
    float3 _349 = spvFAdd(_348, float3(1.0));
    float _350 = dot(_258, _258);
    float _351 = fract(_350);
    float _354 = fma(View.View_GameTime, Material.Material_ScalarExpressions[2].w, _351);
    float _357 = spvFMul(Material.Material_ScalarExpressions[3].x, _310);
    float _358 = _354 - _357;
    float3 _359 = float3(-1.0, 0.0, 0.0) * _358;
    float3 _360 = spvFAdd(_349, _359);
    float2 _361 = _360.xy;
    float4 _363 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _361, level(-1.0));
    float3 _364 = _363.xyz;
    float3 _365 = spvFAdd(float3(-0.5), _364);
    float3 _366 = _365 * 2.0;
    float _367 = _366.z;
    float _368 = spvFAdd(_367, 1.0);
    float _371 = spvFMul(Material.Material_ScalarExpressions[3].y, _368);
    float3 _372 = _328 * _371;
    float _373 = _366.x;
    float3 _374 = _328 * _373;
    float _378 = _366.y;
    float3 _379 = Material.Material_VectorExpressions[6].xyz * _378;
    float3 _380 = spvFAdd(_374, _379);
    float3 _383 = _380 * Material.Material_ScalarExpressions[3].w;
    float3 _384 = spvFAdd(_372, _383);
    float3 _385 = _384 * _310;
    float3 _386 = spvFAdd(_314, _385);
    float _387 = dot(_386, _386);
    float _388 = sqrt(_387);
    float3 _389 = float3(_388);
    float3 _390 = _386 / _389;
    float _391 = _387 - 9.9999999747524270787835121154785e-07;
    float _392 = abs(_391);
    bool _393 = _392 > 9.9999997473787516355514526367188e-06;
    bool _394 = _387 >= 9.9999999747524270787835121154785e-07;
    float _395 = _390.x;
    float _396 = _390.y;
    float _397 = _390.z;
    float4 _398 = float4(_395, _396, _397, 0.0);
    bool4 _399 = bool4(_394);
    float4 _400 = select(float4(0.0, 0.0, 0.0, 1.0), _398, _399);
    bool4 _401 = bool4(_393);
    float4 _402 = select(float4(0.0, 0.0, 0.0, 1.0), _400, _401);
    float3 _403 = _402.xyz;
    float3 _404 = _403 * _316;
    float3 _405 = spvFAdd(_404, _313);
    float3 _406 = _405 - _250;
    float _407 = dot(_406, _406);
    float _408 = sqrt(_407);
    float _411 = spvFMul(View.View_GameTime, Material.Material_ScalarExpressions[4].x);
    float _412 = _251.x;
    float _413 = _251.y;
    float _414 = _251.z;
    float4 _415 = float4(_412, _413, _414, 1.0);
    float4x4 _419 = _128;
    _419[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _161 + 6u)];
    float4x4 _423 = _419;
    _423[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _161 + 7u)];
    float4x4 _427 = _423;
    _427[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _161 + 8u)];
    float4x4 _431 = _427;
    _431[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _161 + 9u)];
    float4 _432 = spvFMulMatrixVector(_431, _415);
    float3 _433 = _432.xyz;
    uint _434 = _161 + 23u;
    float3 _438 = _433 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _434)].xyz;
    uint _439 = _161 + 24u;
    float3 _443 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _439)].xyz - View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _434)].xyz;
    float3 _444 = _438 / _443;
    float _445 = _444.z;
    float _448 = _445 - Material.Material_ScalarExpressions[4].y;
    float _451 = _448 / Material.Material_ScalarExpressions[4].z;
    float _452 = fast::max(_451, 0.0);
    float _453 = fast::min(_452, 1.0);
    float _454 = spvFMul(_453, _453);
    float _457 = spvFMul(Material.Material_ScalarExpressions[4].w, _454);
    float _458 = _411 - _457;
    float3 _459 = float3(-1.0, 0.0, 0.0) * _458;
    float3 _460 = spvFAdd(_258, _459);
    float2 _461 = _460.xy;
    float4 _463 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _461, level(-1.0));
    float3 _464 = _463.xyz;
    float3 _465 = spvFAdd(float3(-0.5), _464);
    float3 _466 = _465 * 2.0;
    float _467 = _466.z;
    float _468 = spvFAdd(_467, 1.0);
    float _471 = spvFMul(Material.Material_ScalarExpressions[5].x, _468);
    float3 _472 = _284 * _471;
    float _473 = _466.x;
    float3 _474 = _284 * _473;
    float3 _475 = cross(_284, float3(0.0, 0.0, 1.0));
    float3 _478 = _475 * Material.Material_ScalarExpressions[5].y;
    float _479 = _466.y;
    float3 _480 = _478 * _479;
    float3 _481 = spvFAdd(_474, _480);
    float3 _484 = _481 * Material.Material_ScalarExpressions[5].z;
    float3 _485 = spvFAdd(_472, _484);
    float3 _486 = _485 * _454;
    float3 _487 = spvFAdd(_406, _486);
    float _488 = dot(_487, _487);
    float _489 = sqrt(_488);
    float3 _490 = float3(_489);
    float3 _491 = _487 / _490;
    float _492 = _488 - 9.9999999747524270787835121154785e-07;
    float _493 = abs(_492);
    bool _494 = _493 > 9.9999997473787516355514526367188e-06;
    bool _495 = _488 >= 9.9999999747524270787835121154785e-07;
    float _496 = _491.x;
    float _497 = _491.y;
    float _498 = _491.z;
    float4 _499 = float4(_496, _497, _498, 0.0);
    bool4 _500 = bool4(_495);
    float4 _501 = select(float4(0.0, 0.0, 0.0, 1.0), _499, _500);
    bool4 _502 = bool4(_494);
    float4 _503 = select(float4(0.0, 0.0, 0.0, 1.0), _501, _502);
    float3 _504 = _503.xyz;
    float3 _505 = _504 * _408;
    float3 _506 = spvFAdd(_505, _250);
    float3 _507 = _506 - _251;
    float3x3 _514 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _161)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _164)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _167)].xyz);
    float3 _515 = spvFMulMatrixVector(_514, float3(1.0, 0.0, 0.0));
    float3 _516 = -_515;
    float _517 = dot(_516, _516);
    float _518 = sqrt(_517);
    float3x3 _525 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _161)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _164)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _167)].xyz);
    float3 _526 = spvFMulMatrixVector(_525, float3(0.0, 1.0, 0.0));
    float3 _527 = -_526;
    float _528 = dot(_527, _527);
    float _529 = sqrt(_528);
    float3x3 _536 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _161)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _164)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _167)].xyz);
    float3 _537 = spvFMulMatrixVector(_536, float3(0.0, 0.0, 1.0));
    float3 _538 = -_537;
    float _539 = dot(_538, _538);
    float _540 = sqrt(_539);
    float3 _541 = float3(_518, _529, _540);
    float3 _542 = fma(_507, _541, _212);
    float4 _543 = float4(_542.x, _542.y, _542.z, _211.w);
    spvUnsafeArray<float4, 1> _554 = { float4(_221.x, _221.y, float4(0.0).z, float4(0.0).w) };
    float4 _560 = spvFMulMatrixVector(ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId], _543);
    out.out_var_TEXCOORD10_centroid = float4(_188[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_228, spvFMul(_152, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _176)].w));
    out.out_var_COLOR0 = LocalVF_VertexFetch_ColorComponentsBuffer.read(uint((_138 & uint(LocalVF.LocalVF_VertexFetch_Parameters.x)))).zyxw;
    out_var_TEXCOORD0 = _554;
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    out.out_var_TEXCOORD7 = _542.xyz;
    out.out_var_TEXCOORD6 = _560;
    out.out_var_TEXCOORD8 = _228;
    out.gl_Layer = _Globals.LayerId;
    out.gl_Position = _560;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

