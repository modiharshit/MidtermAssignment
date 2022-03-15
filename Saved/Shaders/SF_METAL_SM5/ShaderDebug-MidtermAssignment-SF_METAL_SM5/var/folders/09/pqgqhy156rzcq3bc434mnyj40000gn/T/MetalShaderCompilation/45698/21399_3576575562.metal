

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

constant float3x3 _121 = {};
constant float4x4 _122 = {};

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

vertex Main_out Main_00005397_d52e364a(Main_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(8)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(3)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(4)]], constant type_View& View [[buffer(5)]], constant type_LocalVF& LocalVF [[buffer(6)]], constant type_Material& Material [[buffer(7)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(0)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(1)]], texture_buffer<float> LocalVF_VertexFetch_ColorComponentsBuffer [[texture(2)]], texture2d<float> Material_Texture2D_2 [[texture(3)]], sampler Material_Texture2D_2Sampler [[sampler(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[3];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[4];
    uint _134 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w);
    uint _135 = _134 + (gl_VertexIndex - gl_BaseVertex);
    uint _143 = 2u * _135;
    float4 _148 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_143 + 1u)));
    float _149 = _148.w;
    float3 _150 = _148.xyz;
    float3 _152 = cross(_150, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_143)).xyz) * _149;
    float3x3 _155 = _121;
    _155[0] = cross(_152, _150) * _149;
    float3x3 _156 = _155;
    _156[1] = _152;
    float3x3 _157 = _156;
    _157[2] = _150;
    uint _158 = in.in_var_ATTRIBUTE13 * 36u;
    uint _161 = _158 + 1u;
    uint _164 = _158 + 2u;
    uint _167 = _158 + 3u;
    uint _173 = _158 + 4u;
    float3x3 _178 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _158)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _161)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _164)].xyz);
    _178[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _158)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _173)].x;
    float3x3 _181 = _178;
    _181[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _161)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _173)].y;
    float3x3 _184 = _181;
    _184[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _164)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _173)].z;
    float3x3 _185 = spvFMulMatrixMatrix(_184, _157);
    float3 _197 = spvFMul(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _161)].xyz, in.in_var_ATTRIBUTE0.yyy);
    float3 _198 = fma(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _158)].xyz, in.in_var_ATTRIBUTE0.xxx, _197);
    float3 _201 = fma(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _164)].xyz, in.in_var_ATTRIBUTE0.zzz, _198);
    float3 _203 = spvFAdd(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _167)].xyz, View.View_PreViewTranslation);
    float3 _204 = spvFAdd(_201, _203);
    float _205 = _204.x;
    float _206 = _204.y;
    float _207 = _204.z;
    float4 _208 = float4(_205, _206, _207, 1.0);
    float3 _209 = _208.xyz;
    uint _212 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    uint _213 = _212 - 1u;
    uint _215 = _212 * _135;
    float4 _218 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_215 + min(0u, _213))));
    uint _219 = min(1u, _213);
    uint _220 = _215 + _219;
    float4 _221 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(_220));
    uint _222 = min(2u, _213);
    uint _223 = _215 + _222;
    float4 _224 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(_223));
    float _227 = Material.Material_ScalarExpressions[0].y - 9.9999999747524270787835121154785e-07;
    float _228 = abs(_227);
    bool _229 = _228 > 9.9999997473787516355514526367188e-06;
    bool _230 = Material.Material_ScalarExpressions[0].y >= 9.9999999747524270787835121154785e-07;
    bool4 _233 = bool4(_230);
    float4 _234 = select(float4(1.0, 0.0, 0.0, 1.0), Material.Material_VectorExpressions[5], _233);
    bool4 _235 = bool4(_229);
    float4 _236 = select(float4(1.0, 0.0, 0.0, 1.0), _234, _235);
    float4x4 _238 = _122;
    _238[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _158)];
    float4x4 _240 = _238;
    _240[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _161)];
    float4x4 _242 = _240;
    _242[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _164)];
    float4x4 _244 = _242;
    _244[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _167)];
    float4 _245 = spvFMulMatrixVector(_244, float4(0.0, 0.0, 0.0, 1.0));
    float3 _246 = _245.xyz;
    float3 _247 = _209 - View.View_PreViewTranslation;
    float3 _248 = _247 - _246;
    float3 _251 = _248 * Material.Material_ScalarExpressions[0].w;
    float3 _254 = _246 * Material.Material_ScalarExpressions[1].x;
    float3 _255 = spvFAdd(_251, _254);
    float _260 = spvFMul(View.View_GameTime, Material.Material_ScalarExpressions[1].y);
    float _263 = _224.y;
    float _264 = spvFMul(Material.Material_ScalarExpressions[1].z, _263);
    float _265 = _260 - _264;
    float3 _266 = float3(1.0, 0.0, 0.0) * _265;
    float3 _267 = spvFAdd(_255, _266);
    float2 _270 = _267.xy;
    float4 _272 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _270, level(-1.0));
    float3 _273 = _272.xyz;
    float3 _274 = spvFAdd(_273, float3(-0.25, -0.5, -0.5));
    float3 _275 = _274 * 2.0;
    float _278 = _275.x;
    float _279 = spvFMul(Material.Material_ScalarExpressions[1].w, _278);
    float3 _280 = _236.xyz;
    float3 _281 = _280 * _279;
    float _282 = _275.y;
    float _285 = spvFMul(_282, Material.Material_ScalarExpressions[2].x);
    float3 _286 = float3(0.0, 0.0, 1.0) * _285;
    float3 _287 = spvFAdd(_281, _286);
    float3 _288 = _287 * _263;
    float3 _289 = spvFAdd(_247, _288);
    float _290 = _221.y;
    float3 _291 = float3(_290);
    float3 _292 = spvFMul(_291, float3(0.0625, 1.0, 16.0));
    float3 _293 = fract(_292);
    float3 _294 = spvFAdd(float3(-0.5), _293);
    float3 _295 = _294 * 2.0;
    float3x3 _302 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _158)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _161)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _164)].xyz);
    float3 _303 = spvFMulMatrixVector(_302, _295);
    float _306 = _224.x;
    float _307 = spvFMul(Material.Material_ScalarExpressions[2].y, _306);
    float3 _308 = _303 * _307;
    float3 _309 = float3(1.0) - _308;
    float3 _310 = _289 - _309;
    float _311 = dot(_310, _310);
    float _312 = sqrt(_311);
    float _313 = dot(_303, _303);
    float _314 = sqrt(_313);
    float3 _315 = float3(_314);
    float3 _316 = _303 / _315;
    float _317 = dot(_280, _316);
    float _318 = spvFMul(_317, _317);
    float3 _319 = float3(0.0, 0.0, 1.0) * _318;
    float3 _320 = spvFAdd(_280, _319);
    float _321 = dot(_320, _320);
    float _322 = sqrt(_321);
    float3 _323 = float3(_322);
    float3 _324 = _320 / _323;
    float _325 = _221.x;
    float _326 = spvFMul(_325, 256.0);
    float _327 = spvFMul(_325, 7.111111164093017578125);
    float _328 = floor(_327);
    float _329 = spvFMul(_328, 36.0);
    float _330 = _326 - _329;
    float _331 = spvFMul(_330, 0.16666667163372039794921875);
    float _332 = floor(_331);
    float _333 = spvFMul(_332, 6.0);
    float _334 = _330 - _333;
    float3 _335 = float3(_334, _332, _328);
    float3 _336 = spvFMul(_335, float3(0.20000000298023223876953125, 0.20000000298023223876953125, 0.16666667163372039794921875));
    uint _337 = _158 + 19u;
    float3 _341 = spvFMul(_336, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _337)].xyz);
    float3 _344 = _341 * Material.Material_ScalarExpressions[2].z;
    float3 _345 = spvFAdd(_344, float3(1.0));
    float _346 = dot(_254, _254);
    float _347 = fract(_346);
    float _350 = fma(View.View_GameTime, Material.Material_ScalarExpressions[2].w, _347);
    float _353 = spvFMul(Material.Material_ScalarExpressions[3].x, _306);
    float _354 = _350 - _353;
    float3 _355 = float3(-1.0, 0.0, 0.0) * _354;
    float3 _356 = spvFAdd(_345, _355);
    float2 _357 = _356.xy;
    float4 _359 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _357, level(-1.0));
    float3 _360 = _359.xyz;
    float3 _361 = spvFAdd(float3(-0.5), _360);
    float3 _362 = _361 * 2.0;
    float _363 = _362.z;
    float _364 = spvFAdd(_363, 1.0);
    float _367 = spvFMul(Material.Material_ScalarExpressions[3].y, _364);
    float3 _368 = _324 * _367;
    float _369 = _362.x;
    float3 _370 = _324 * _369;
    float _374 = _362.y;
    float3 _375 = Material.Material_VectorExpressions[6].xyz * _374;
    float3 _376 = spvFAdd(_370, _375);
    float3 _379 = _376 * Material.Material_ScalarExpressions[3].w;
    float3 _380 = spvFAdd(_368, _379);
    float3 _381 = _380 * _306;
    float3 _382 = spvFAdd(_310, _381);
    float _383 = dot(_382, _382);
    float _384 = sqrt(_383);
    float3 _385 = float3(_384);
    float3 _386 = _382 / _385;
    float _387 = _383 - 9.9999999747524270787835121154785e-07;
    float _388 = abs(_387);
    bool _389 = _388 > 9.9999997473787516355514526367188e-06;
    bool _390 = _383 >= 9.9999999747524270787835121154785e-07;
    float _391 = _386.x;
    float _392 = _386.y;
    float _393 = _386.z;
    float4 _394 = float4(_391, _392, _393, 0.0);
    bool4 _395 = bool4(_390);
    float4 _396 = select(float4(0.0, 0.0, 0.0, 1.0), _394, _395);
    bool4 _397 = bool4(_389);
    float4 _398 = select(float4(0.0, 0.0, 0.0, 1.0), _396, _397);
    float3 _399 = _398.xyz;
    float3 _400 = _399 * _312;
    float3 _401 = spvFAdd(_400, _309);
    float3 _402 = _401 - _246;
    float _403 = dot(_402, _402);
    float _404 = sqrt(_403);
    float _407 = spvFMul(View.View_GameTime, Material.Material_ScalarExpressions[4].x);
    float _408 = _247.x;
    float _409 = _247.y;
    float _410 = _247.z;
    float4 _411 = float4(_408, _409, _410, 1.0);
    float4x4 _415 = _122;
    _415[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _158 + 6u)];
    float4x4 _419 = _415;
    _419[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _158 + 7u)];
    float4x4 _423 = _419;
    _423[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _158 + 8u)];
    float4x4 _427 = _423;
    _427[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _158 + 9u)];
    float4 _428 = spvFMulMatrixVector(_427, _411);
    float3 _429 = _428.xyz;
    uint _430 = _158 + 23u;
    float3 _434 = _429 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _430)].xyz;
    uint _435 = _158 + 24u;
    float3 _439 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _435)].xyz - View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _430)].xyz;
    float3 _440 = _434 / _439;
    float _441 = _440.z;
    float _444 = _441 - Material.Material_ScalarExpressions[4].y;
    float _447 = _444 / Material.Material_ScalarExpressions[4].z;
    float _448 = fast::max(_447, 0.0);
    float _449 = fast::min(_448, 1.0);
    float _450 = spvFMul(_449, _449);
    float _453 = spvFMul(Material.Material_ScalarExpressions[4].w, _450);
    float _454 = _407 - _453;
    float3 _455 = float3(-1.0, 0.0, 0.0) * _454;
    float3 _456 = spvFAdd(_254, _455);
    float2 _457 = _456.xy;
    float4 _459 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _457, level(-1.0));
    float3 _460 = _459.xyz;
    float3 _461 = spvFAdd(float3(-0.5), _460);
    float3 _462 = _461 * 2.0;
    float _463 = _462.z;
    float _464 = spvFAdd(_463, 1.0);
    float _467 = spvFMul(Material.Material_ScalarExpressions[5].x, _464);
    float3 _468 = _280 * _467;
    float _469 = _462.x;
    float3 _470 = _280 * _469;
    float3 _471 = cross(_280, float3(0.0, 0.0, 1.0));
    float3 _474 = _471 * Material.Material_ScalarExpressions[5].y;
    float _475 = _462.y;
    float3 _476 = _474 * _475;
    float3 _477 = spvFAdd(_470, _476);
    float3 _480 = _477 * Material.Material_ScalarExpressions[5].z;
    float3 _481 = spvFAdd(_468, _480);
    float3 _482 = _481 * _450;
    float3 _483 = spvFAdd(_402, _482);
    float _484 = dot(_483, _483);
    float _485 = sqrt(_484);
    float3 _486 = float3(_485);
    float3 _487 = _483 / _486;
    float _488 = _484 - 9.9999999747524270787835121154785e-07;
    float _489 = abs(_488);
    bool _490 = _489 > 9.9999997473787516355514526367188e-06;
    bool _491 = _484 >= 9.9999999747524270787835121154785e-07;
    float _492 = _487.x;
    float _493 = _487.y;
    float _494 = _487.z;
    float4 _495 = float4(_492, _493, _494, 0.0);
    bool4 _496 = bool4(_491);
    float4 _497 = select(float4(0.0, 0.0, 0.0, 1.0), _495, _496);
    bool4 _498 = bool4(_490);
    float4 _499 = select(float4(0.0, 0.0, 0.0, 1.0), _497, _498);
    float3 _500 = _499.xyz;
    float3 _501 = _500 * _404;
    float3 _502 = spvFAdd(_501, _246);
    float3 _503 = _502 - _247;
    float3x3 _510 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _158)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _161)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _164)].xyz);
    float3 _511 = spvFMulMatrixVector(_510, float3(1.0, 0.0, 0.0));
    float3 _512 = -_511;
    float _513 = dot(_512, _512);
    float _514 = sqrt(_513);
    float3x3 _521 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _158)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _161)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _164)].xyz);
    float3 _522 = spvFMulMatrixVector(_521, float3(0.0, 1.0, 0.0));
    float3 _523 = -_522;
    float _524 = dot(_523, _523);
    float _525 = sqrt(_524);
    float3x3 _532 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _158)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _161)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _164)].xyz);
    float3 _533 = spvFMulMatrixVector(_532, float3(0.0, 0.0, 1.0));
    float3 _534 = -_533;
    float _535 = dot(_534, _534);
    float _536 = sqrt(_535);
    float3 _537 = float3(_514, _525, _536);
    float3 _538 = fma(_503, _537, _209);
    float4 _539 = float4(_538.x, _538.y, _538.z, _208.w);
    float4 _540 = spvFMulMatrixVector(View.View_TranslatedWorldToClip, _539);
    uint _553 = as_type<uint>(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _435)].w) + LocalVF.LocalVF_LODLightmapDataIndex;
    uint _555 = (_553 * 15u) + 2u;
    float2 _560 = fma(LocalVF_VertexFetch_TexCoordBuffer.read(uint((_215 + uint(LocalVF.LocalVF_VertexFetch_Parameters.z)))).xy, View_LightmapSceneData._m0[spvStorageBufferCoords(4, spvBufferSizeConstants, float4, _555)].xy, View_LightmapSceneData._m0[spvStorageBufferCoords(4, spvBufferSizeConstants, float4, _555)].zw);
    spvUnsafeArray<float4, 1> _572 = { float4(_218.x, _218.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_185[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_185[2], spvFMul(_149, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _173)].w));
    out.out_var_COLOR0 = LocalVF_VertexFetch_ColorComponentsBuffer.read(uint((_135 & uint(LocalVF.LocalVF_VertexFetch_Parameters.x)))).zyxw;
    out_var_TEXCOORD0 = _572;
    out.out_var_TEXCOORD4 = float4(_560.x, _560.y, float2(0.0).x, float2(0.0).y);
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    out.out_var_LIGHTMAP_ID = _553;
    out.out_var_TEXCOORD9 = _209;
    out.gl_Position = _540;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

