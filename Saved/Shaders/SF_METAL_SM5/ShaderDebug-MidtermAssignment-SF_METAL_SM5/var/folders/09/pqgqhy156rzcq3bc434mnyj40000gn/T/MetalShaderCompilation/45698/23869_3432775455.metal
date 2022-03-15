

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
    char _m2_pad[320];
    float4x4 View_PrevTranslatedWorldToClip;
    char _m3_pad[288];
    float3 View_PrevPreViewTranslation;
    char _m4_pad[336];
    int View_NumSceneColorMSAASamples;
    char _m5_pad[68];
    float View_PrevFrameGameTime;
    char _m6_pad[44];
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

constant float3x3 _124 = {};
constant float4x4 _125 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float4 out_var_TEXCOORD7 [[user(locn1)]];
    float4 out_var_TEXCOORD10_centroid [[user(locn2)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn3)]];
    float4 out_var_COLOR0 [[user(locn4)]];
    float4 out_var_TEXCOORD0_0 [[user(locn5)]];
    uint out_var_PRIMITIVE_ID [[user(locn6)]];
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

vertex MainVertexShader_out Main_00005d3d_cc9bff1f(MainVertexShader_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(7)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(3)]], constant type_View& View [[buffer(4)]], constant type_LocalVF& LocalVF [[buffer(5)]], constant type_Material& Material [[buffer(6)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(0)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(1)]], texture_buffer<float> LocalVF_VertexFetch_ColorComponentsBuffer [[texture(2)]], texture2d<float> Material_Texture2D_2 [[texture(3)]], sampler Material_Texture2D_2Sampler [[sampler(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[3];
    uint _143 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _151 = 2u * _143;
    float4 _156 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_151 + 1u)));
    float _157 = _156.w;
    float3 _158 = _156.xyz;
    float3 _160 = cross(_158, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_151)).xyz) * _157;
    float3x3 _163 = _124;
    _163[0] = cross(_160, _158) * _157;
    float3x3 _164 = _163;
    _164[1] = _160;
    float3x3 _165 = _164;
    _165[2] = _158;
    uint _166 = in.in_var_ATTRIBUTE13 * 36u;
    uint _169 = _166 + 1u;
    uint _172 = _166 + 2u;
    uint _175 = _166 + 3u;
    uint _181 = _166 + 4u;
    float3x3 _186 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _166)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _169)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _172)].xyz);
    _186[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _166)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _181)].x;
    float3x3 _189 = _186;
    _189[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _169)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _181)].y;
    float3x3 _192 = _189;
    _192[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _172)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _181)].z;
    float3x3 _193 = spvFMulMatrixMatrix(_192, _165);
    float3 _217 = float4(spvFAdd(fma(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _172)].xyz, in.in_var_ATTRIBUTE0.zzz, fma(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _166)].xyz, in.in_var_ATTRIBUTE0.xxx, spvFMul(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _169)].xyz, in.in_var_ATTRIBUTE0.yyy))), spvFAdd(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _175)].xyz, View.View_PreViewTranslation)), 1.0).xyz;
    uint _220 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    uint _221 = _220 - 1u;
    uint _223 = _220 * _143;
    float4 _226 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_223 + min(0u, _221))));
    uint _228 = _223 + min(1u, _221);
    float4 _229 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(_228));
    uint _231 = _223 + min(2u, _221);
    float4 _232 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(_231));
    float4x4 _246 = _125;
    _246[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _166)];
    float4x4 _248 = _246;
    _248[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _169)];
    float4x4 _250 = _248;
    _250[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _172)];
    float4x4 _252 = _250;
    _252[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _175)];
    float3 _254 = spvFMulMatrixVector(_252, float4(0.0, 0.0, 0.0, 1.0)).xyz;
    float3 _255 = _217 - View.View_PreViewTranslation;
    float3 _262 = _254 * Material.Material_ScalarExpressions[1].x;
    float _271 = _232.y;
    float3 _283 = spvFAdd(Material_Texture2D_2.sample(Material_Texture2D_2Sampler, spvFAdd(spvFAdd((_255 - _254) * Material.Material_ScalarExpressions[0].w, _262), float3(1.0, 0.0, 0.0) * (spvFMul(View.View_GameTime, Material.Material_ScalarExpressions[1].y) - spvFMul(Material.Material_ScalarExpressions[1].z, _271))).xy, level(-1.0)).xyz, float3(-0.25, -0.5, -0.5)) * 2.0;
    float3 _288 = select(float4(1.0, 0.0, 0.0, 1.0), select(float4(1.0, 0.0, 0.0, 1.0), Material.Material_VectorExpressions[5], bool4(Material.Material_ScalarExpressions[0].y >= 9.9999999747524270787835121154785e-07)), bool4(abs(Material.Material_ScalarExpressions[0].y - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz;
    float3 _311 = spvFMulMatrixVector(float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _166)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _169)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _172)].xyz), spvFAdd(float3(-0.5), fract(spvFMul(float3(_229.y), float3(0.0625, 1.0, 16.0)))) * 2.0);
    float _314 = _232.x;
    float3 _317 = float3(1.0) - (_311 * spvFMul(Material.Material_ScalarExpressions[2].y, _314));
    float3 _318 = spvFAdd(_255, spvFAdd(_288 * spvFMul(Material.Material_ScalarExpressions[1].w, _283.x), float3(0.0, 0.0, 1.0) * spvFMul(_283.y, Material.Material_ScalarExpressions[2].x)) * _271) - _317;
    float _325 = dot(_288, _311 / float3(sqrt(dot(_311, _311))));
    float3 _328 = spvFAdd(_288, float3(0.0, 0.0, 1.0) * spvFMul(_325, _325));
    float3 _332 = _328 / float3(sqrt(dot(_328, _328)));
    float _333 = _229.x;
    float _336 = floor(spvFMul(_333, 7.111111164093017578125));
    float _338 = spvFMul(_333, 256.0) - spvFMul(_336, 36.0);
    float _340 = floor(spvFMul(_338, 0.16666667163372039794921875));
    uint _345 = _166 + 19u;
    float3 _370 = spvFAdd(float3(-0.5), Material_Texture2D_2.sample(Material_Texture2D_2Sampler, spvFAdd(spvFAdd(spvFMul(spvFMul(float3(_338 - spvFMul(_340, 6.0), _340, _336), float3(0.20000000298023223876953125, 0.20000000298023223876953125, 0.16666667163372039794921875)), View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _345)].xyz) * Material.Material_ScalarExpressions[2].z, float3(1.0)), float3(-1.0, 0.0, 0.0) * (fma(View.View_GameTime, Material.Material_ScalarExpressions[2].w, fract(dot(_262, _262))) - spvFMul(Material.Material_ScalarExpressions[3].x, _314))).xy, level(-1.0)).xyz) * 2.0;
    float3 _390 = spvFAdd(_318, spvFAdd(_332 * spvFMul(Material.Material_ScalarExpressions[3].y, spvFAdd(_370.z, 1.0)), spvFAdd(_332 * _370.x, Material.Material_VectorExpressions[6].xyz * _370.y) * Material.Material_ScalarExpressions[3].w) * _314);
    float _391 = dot(_390, _390);
    float3 _410 = spvFAdd(select(float4(0.0, 0.0, 0.0, 1.0), select(float4(0.0, 0.0, 0.0, 1.0), float4(_390 / float3(sqrt(_391)), 0.0), bool4(_391 >= 9.9999999747524270787835121154785e-07)), bool4(abs(_391 - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz * sqrt(dot(_318, _318)), _317) - _254;
    float4x4 _423 = _125;
    _423[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _166 + 6u)];
    float4x4 _427 = _423;
    _427[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _166 + 7u)];
    float4x4 _431 = _427;
    _431[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _166 + 8u)];
    float4x4 _435 = _431;
    _435[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _166 + 9u)];
    uint _438 = _166 + 23u;
    uint _443 = _166 + 24u;
    float _457 = fast::min(fast::max((((spvFMulMatrixVector(_435, float4(_255, 1.0)).xyz - View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _438)].xyz) / (View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _443)].xyz - View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _438)].xyz)).z - Material.Material_ScalarExpressions[4].y) / Material.Material_ScalarExpressions[4].z, 0.0), 1.0);
    float _458 = spvFMul(_457, _457);
    float3 _470 = spvFAdd(float3(-0.5), Material_Texture2D_2.sample(Material_Texture2D_2Sampler, spvFAdd(_262, float3(-1.0, 0.0, 0.0) * (spvFMul(View.View_GameTime, Material.Material_ScalarExpressions[4].x) - spvFMul(Material.Material_ScalarExpressions[4].w, _458))).xy, level(-1.0)).xyz) * 2.0;
    float3 _482 = cross(_288, float3(0.0, 0.0, 1.0)) * Material.Material_ScalarExpressions[5].y;
    float3 _491 = spvFAdd(_410, spvFAdd(_288 * spvFMul(Material.Material_ScalarExpressions[5].x, spvFAdd(_470.z, 1.0)), spvFAdd(_288 * _470.x, _482 * _470.y) * Material.Material_ScalarExpressions[5].z) * _458);
    float _492 = dot(_491, _491);
    float3 _520 = -spvFMulMatrixVector(float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _166)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _169)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _172)].xyz), float3(1.0, 0.0, 0.0));
    float3 _531 = -spvFMulMatrixVector(float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _166)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _169)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _172)].xyz), float3(0.0, 1.0, 0.0));
    float3 _542 = -spvFMulMatrixVector(float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _166)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _169)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _172)].xyz), float3(0.0, 0.0, 1.0));
    spvUnsafeArray<float4, 1> _558 = { float4(_226.x, _226.y, float4(0.0).z, float4(0.0).w) };
    uint _559 = _166 + 10u;
    float4x4 _562 = _125;
    _562[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _559)];
    uint _563 = _166 + 11u;
    float4x4 _566 = _562;
    _566[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _563)];
    uint _567 = _166 + 12u;
    float4x4 _570 = _566;
    _570[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _567)];
    uint _571 = _166 + 13u;
    float4x4 _574 = _570;
    _574[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _571)];
    float4x4 _578 = _574;
    _578[3].x = spvFAdd(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _571)].x, View.View_PrevPreViewTranslation.x);
    float4x4 _582 = _578;
    _582[3].y = spvFAdd(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _571)].y, View.View_PrevPreViewTranslation.y);
    float4x4 _586 = _582;
    _586[3].z = spvFAdd(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _571)].z, View.View_PrevPreViewTranslation.z);
    float3 _588 = spvFMulMatrixVector(_586, in.in_var_ATTRIBUTE0).xyz;
    float4x4 _590 = _125;
    _590[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _559)];
    float4x4 _592 = _590;
    _592[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _563)];
    float4x4 _594 = _592;
    _594[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _567)];
    float4x4 _596 = _594;
    _596[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _571)];
    float4 _597 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(_228));
    float4 _598 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(_231));
    float _599 = _598.y;
    float _607 = _598.x;
    float _609 = _597.x;
    float _612 = floor(spvFMul(_609, 7.111111164093017578125));
    float _614 = spvFMul(_609, 256.0) - spvFMul(_612, 36.0);
    float _616 = floor(spvFMul(_614, 0.16666667163372039794921875));
    float3 _633 = spvFMulMatrixVector(_596, float4(0.0, 0.0, 0.0, 1.0)).xyz;
    float3 _634 = _588 - View.View_PrevPreViewTranslation;
    float3 _637 = _633 * Material.Material_ScalarExpressions[1].x;
    float3 _650 = spvFAdd(Material_Texture2D_2.sample(Material_Texture2D_2Sampler, spvFAdd(spvFAdd((_634 - _633) * Material.Material_ScalarExpressions[0].w, _637), float3(1.0, 0.0, 0.0) * (spvFMul(View.View_PrevFrameGameTime, Material.Material_ScalarExpressions[1].y) - spvFMul(Material.Material_ScalarExpressions[1].z, _599))).xy, level(-1.0)).xyz, float3(-0.25, -0.5, -0.5)) * 2.0;
    float3x3 _663 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _559)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _563)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _567)].xyz);
    float3 _664 = spvFMulMatrixVector(_663, spvFAdd(float3(-0.5), fract(spvFMul(float3(_597.y), float3(0.0625, 1.0, 16.0)))) * 2.0);
    float3 _666 = float3(1.0) - (_664 * spvFMul(Material.Material_ScalarExpressions[2].y, _607));
    float3 _667 = spvFAdd(_634, spvFAdd(_288 * spvFMul(Material.Material_ScalarExpressions[1].w, _650.x), float3(0.0, 0.0, 1.0) * spvFMul(_650.y, Material.Material_ScalarExpressions[2].x)) * _599) - _666;
    float _674 = dot(_288, _664 / float3(sqrt(dot(_664, _664))));
    float3 _677 = spvFAdd(_288, float3(0.0, 0.0, 1.0) * spvFMul(_674, _674));
    float3 _681 = _677 / float3(sqrt(dot(_677, _677)));
    float3 _693 = spvFAdd(float3(-0.5), Material_Texture2D_2.sample(Material_Texture2D_2Sampler, spvFAdd(spvFAdd(spvFMul(spvFMul(float3(_614 - spvFMul(_616, 6.0), _616, _612), float3(0.20000000298023223876953125, 0.20000000298023223876953125, 0.16666667163372039794921875)), View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _345)].xyz) * Material.Material_ScalarExpressions[2].z, float3(1.0)), float3(-1.0, 0.0, 0.0) * (fma(View.View_PrevFrameGameTime, Material.Material_ScalarExpressions[2].w, fract(dot(_637, _637))) - spvFMul(Material.Material_ScalarExpressions[3].x, _607))).xy, level(-1.0)).xyz) * 2.0;
    float3 _706 = spvFAdd(_667, spvFAdd(_681 * spvFMul(Material.Material_ScalarExpressions[3].y, spvFAdd(_693.z, 1.0)), spvFAdd(_681 * _693.x, Material.Material_VectorExpressions[6].xyz * _693.y) * Material.Material_ScalarExpressions[3].w) * _607);
    float _707 = dot(_706, _706);
    float3 _726 = spvFAdd(select(float4(0.0, 0.0, 0.0, 1.0), select(float4(0.0, 0.0, 0.0, 1.0), float4(_706 / float3(sqrt(_707)), 0.0), bool4(_707 >= 9.9999999747524270787835121154785e-07)), bool4(abs(_707 - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz * sqrt(dot(_667, _667)), _666) - _633;
    float4x4 _737 = _125;
    _737[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _166 + 14u)];
    float4x4 _741 = _737;
    _741[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _166 + 15u)];
    float4x4 _745 = _741;
    _745[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _166 + 16u)];
    float4x4 _749 = _745;
    _749[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _166 + 17u)];
    float _758 = fast::min(fast::max((((spvFMulMatrixVector(_749, float4(_634, 1.0)).xyz - View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _438)].xyz) / (View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _443)].xyz - View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _438)].xyz)).z - Material.Material_ScalarExpressions[4].y) / Material.Material_ScalarExpressions[4].z, 0.0), 1.0);
    float _759 = spvFMul(_758, _758);
    float3 _769 = spvFAdd(float3(-0.5), Material_Texture2D_2.sample(Material_Texture2D_2Sampler, spvFAdd(_637, float3(-1.0, 0.0, 0.0) * (spvFMul(View.View_PrevFrameGameTime, Material.Material_ScalarExpressions[4].x) - spvFMul(Material.Material_ScalarExpressions[4].w, _759))).xy, level(-1.0)).xyz) * 2.0;
    float3 _782 = spvFAdd(_726, spvFAdd(_288 * spvFMul(Material.Material_ScalarExpressions[5].x, spvFAdd(_769.z, 1.0)), spvFAdd(_288 * _769.x, _482 * _769.y) * Material.Material_ScalarExpressions[5].z) * _759);
    float _783 = dot(_782, _782);
    float3 _804 = -spvFMulMatrixVector(_663, float3(1.0, 0.0, 0.0));
    float3 _808 = -spvFMulMatrixVector(_663, float3(0.0, 1.0, 0.0));
    float3 _812 = -spvFMulMatrixVector(_663, float3(0.0, 0.0, 1.0));
    float4 _826 = spvFMulMatrixVector(View.View_TranslatedWorldToClip, float4(fma(spvFAdd(select(float4(0.0, 0.0, 0.0, 1.0), select(float4(0.0, 0.0, 0.0, 1.0), float4(_491 / float3(sqrt(_492)), 0.0), bool4(_492 >= 9.9999999747524270787835121154785e-07)), bool4(abs(_492 - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz * sqrt(dot(_410, _410)), _254) - _255, float3(sqrt(dot(_520, _520)), sqrt(dot(_531, _531)), sqrt(dot(_542, _542))), _217), 1.0));
    float4 _835 = _826;
    _835.z = spvFAdd(_826.z, (View.View_NumSceneColorMSAASamples > 1) ? spvFMul(0.001000000047497451305389404296875, _826.w) : 0.0);
    out.gl_Position = _835;
    out.out_var_TEXCOORD6 = _826;
    out.out_var_TEXCOORD7 = spvFMulMatrixVector(View.View_PrevTranslatedWorldToClip, float4(fma(spvFAdd(select(float4(0.0, 0.0, 0.0, 1.0), select(float4(0.0, 0.0, 0.0, 1.0), float4(_782 / float3(sqrt(_783)), 0.0), bool4(_783 >= 9.9999999747524270787835121154785e-07)), bool4(abs(_783 - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz * sqrt(dot(_726, _726)), _633) - _634, float3(sqrt(dot(_804, _804)), sqrt(dot(_808, _808)), sqrt(dot(_812, _812))), _588), 1.0));
    out.out_var_TEXCOORD10_centroid = float4(_193[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_193[2], spvFMul(_157, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _181)].w));
    out.out_var_COLOR0 = LocalVF_VertexFetch_ColorComponentsBuffer.read(uint((_143 & uint(LocalVF.LocalVF_VertexFetch_Parameters.x)))).zyxw;
    out_var_TEXCOORD0 = _558;
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

