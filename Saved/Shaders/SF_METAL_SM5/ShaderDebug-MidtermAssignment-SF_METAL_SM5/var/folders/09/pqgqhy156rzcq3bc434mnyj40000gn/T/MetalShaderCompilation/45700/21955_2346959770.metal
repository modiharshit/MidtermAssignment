

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
    char _m3_pad[320];
    float4x4 View_PrevTranslatedWorldToClip;
    char _m4_pad[256];
    float3 View_PrevWorldCameraOrigin;
    char _m5_pad[16];
    float3 View_PrevPreViewTranslation;
    char _m6_pad[336];
    int View_NumSceneColorMSAASamples;
    char _m7_pad[68];
    float View_PrevFrameGameTime;
    char _m8_pad[44];
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

constant float3x3 _111 = {};
constant float4x4 _112 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float4 out_var_TEXCOORD7 [[user(locn1)]];
    float4 out_var_TEXCOORD10_centroid [[user(locn2)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn3)]];
    float4 out_var_TEXCOORD15 [[user(locn4)]];
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

vertex MainVertexShader_out Main_000055c3_8be3c39a(MainVertexShader_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(6)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_LocalVF& LocalVF [[buffer(4)]], constant type_Material& Material [[buffer(5)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(0)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(1)]], texture2d<float> Material_Texture2D_2 [[texture(2)]], sampler Material_Texture2D_2Sampler [[sampler(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    uint _133 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _134 = 2u * _133;
    float4 _139 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_134 + 1u)));
    float _140 = _139.w;
    float3 _141 = _139.xyz;
    float3 _143 = cross(_141, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_134)).xyz) * _140;
    float3x3 _146 = _111;
    _146[0] = cross(_143, _141) * _140;
    float3x3 _147 = _146;
    _147[1] = _143;
    float3x3 _148 = _147;
    _148[2] = _141;
    uint _149 = in.in_var_ATTRIBUTE13 * 36u;
    uint _152 = _149 + 1u;
    uint _155 = _149 + 2u;
    uint _158 = _149 + 3u;
    uint _164 = _149 + 4u;
    float3x3 _169 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _149)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _152)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _155)].xyz);
    _169[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _149)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _164)].x;
    float3x3 _172 = _169;
    _172[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _152)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _164)].y;
    float3x3 _175 = _172;
    _175[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _155)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _164)].z;
    float3x3 _176 = spvFMulMatrixMatrix(_175, _148);
    float3 _200 = float4(spvFAdd(fma(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _155)].xyz, in.in_var_ATTRIBUTE0.zzz, fma(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _149)].xyz, in.in_var_ATTRIBUTE0.xxx, spvFMul(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _152)].xyz, in.in_var_ATTRIBUTE0.yyy))), spvFAdd(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _158)].xyz, View.View_PreViewTranslation)), 1.0).xyz;
    uint _203 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    float4 _209 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(((_203 * _133) + min(0u, (_203 - 1u)))));
    float4x4 _211 = _112;
    _211[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _149)];
    float4x4 _213 = _211;
    _213[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _152)];
    float4x4 _215 = _213;
    _215[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _155)];
    float4x4 _217 = _215;
    _217[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _158)];
    float3 _219 = spvFMulMatrixVector(_217, float4(0.0, 0.0, 0.0, 1.0)).xyz;
    float3 _220 = _219 - View.View_WorldCameraOrigin;
    float3 _224 = _220 / float3(sqrt(dot(_220, _220)));
    uint _225 = _149 + 21u;
    float _229 = dot(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _225)].xyz, _224);
    float3 _233 = _224 - (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _225)].xyz * _229);
    float3 _238 = _176[2];
    float _239 = dot(_233 / float3(sqrt(dot(_233, _233))), _238);
    uint _244 = _149 + 6u;
    uint _247 = _149 + 7u;
    uint _250 = _149 + 8u;
    float _260 = spvFMul(_229, _229);
    float _261 = spvFMul(_260, _260);
    float3 _267 = _200 - View.View_PreViewTranslation;
    float3 _268 = _267 - _219;
    float4x4 _296 = _112;
    _296[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _244)];
    float4x4 _298 = _296;
    _298[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _247)];
    float4x4 _300 = _298;
    _300[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _250)];
    float4x4 _302 = _300;
    _302[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _149 + 9u)];
    uint _305 = _149 + 23u;
    uint _310 = _149 + 24u;
    float _324 = fast::min(fast::max((((spvFMulMatrixVector(_302, float4(_267, 1.0)).xyz - View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _305)].xyz) / (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _310)].xyz - View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _305)].xyz)).z - Material.Material_ScalarExpressions[1].w) / Material.Material_ScalarExpressions[2].x, 0.0), 1.0);
    float _325 = spvFMul(_324, _324);
    float3 _339 = spvFAdd(float3(-0.5), Material_Texture2D_2.sample(Material_Texture2D_2Sampler, spvFAdd(_219 * Material.Material_ScalarExpressions[1].y, float3(-1.0, 0.0, 0.0) * (spvFMul(View.View_GameTime, Material.Material_ScalarExpressions[1].z) - spvFMul(Material.Material_ScalarExpressions[2].y, _325))).xy, level(-1.0)).xyz) * 2.0;
    float3 _345 = select(float4(1.0, 0.0, 0.0, 1.0), select(float4(1.0, 0.0, 0.0, 1.0), Material.Material_VectorExpressions[5], bool4(Material.Material_ScalarExpressions[0].w >= 9.9999999747524270787835121154785e-07)), bool4(abs(Material.Material_ScalarExpressions[0].w - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz;
    float3 _352 = cross(_345, float3(0.0, 0.0, 1.0)) * Material.Material_ScalarExpressions[2].w;
    float3 _361 = spvFAdd(_268, spvFAdd(_345 * spvFMul(Material.Material_ScalarExpressions[2].z, spvFAdd(_339.z, 1.0)), spvFAdd(_345 * _339.x, _352 * _339.y) * Material.Material_ScalarExpressions[3].x) * _325);
    float _362 = dot(_361, _361);
    float3 _390 = -spvFMulMatrixVector(float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _149)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _152)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _155)].xyz), float3(1.0, 0.0, 0.0));
    float3 _401 = -spvFMulMatrixVector(float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _149)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _152)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _155)].xyz), float3(0.0, 1.0, 0.0));
    float3 _412 = -spvFMulMatrixVector(float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _149)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _152)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _155)].xyz), float3(0.0, 0.0, 1.0));
    float4x4 _423 = _112;
    _423[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _149)];
    float4x4 _425 = _423;
    _425[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _152)];
    float4x4 _427 = _425;
    _427[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _155)];
    float4x4 _429 = _427;
    _429[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _158)];
    float3 _432 = spvFMulMatrixVector(_429, float4(0.0, 0.0, 0.0, 1.0)).xyz - View.View_WorldCameraOrigin;
    float3 _436 = _432 / float3(sqrt(dot(_432, _432)));
    float _439 = dot(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _225)].xyz, _436);
    float3 _443 = _436 - (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _225)].xyz * _439);
    float _448 = dot(_443 / float3(sqrt(dot(_443, _443))), _238);
    float _459 = spvFMul(_439, _439);
    float _460 = spvFMul(_459, _459);
    float2 _466 = float2(fast::clamp(spvFAdd(mix(spvFMul(spvFMul(_448, _448), Material.Material_ScalarExpressions[0].z), spvFMulMatrixVector(float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _244)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _247)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _250)].xyz), _238).z, spvFMul(_460, _460)), 0.0199999995529651641845703125), 0.0, 1.0));
    float4 _476 = float4(_238, spvFMul(_140, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _164)].w));
    spvUnsafeArray<float4, 1> _477 = { float4(_209.x, _209.y, _466.x, _466.y) };
    uint _478 = _149 + 10u;
    float4x4 _481 = _112;
    _481[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _478)];
    uint _482 = _149 + 11u;
    float4x4 _485 = _481;
    _485[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _482)];
    uint _486 = _149 + 12u;
    float4x4 _489 = _485;
    _489[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _486)];
    uint _490 = _149 + 13u;
    float4x4 _493 = _489;
    _493[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _490)];
    float4x4 _497 = _493;
    _497[3].x = spvFAdd(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _490)].x, View.View_PrevPreViewTranslation.x);
    float4x4 _501 = _497;
    _501[3].y = spvFAdd(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _490)].y, View.View_PrevPreViewTranslation.y);
    float4x4 _505 = _501;
    _505[3].z = spvFAdd(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _490)].z, View.View_PrevPreViewTranslation.z);
    float3 _507 = spvFMulMatrixVector(_505, in.in_var_ATTRIBUTE0).xyz;
    float4x4 _509 = _112;
    _509[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _478)];
    float4x4 _511 = _509;
    _511[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _482)];
    float4x4 _513 = _511;
    _513[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _486)];
    float4x4 _515 = _513;
    _515[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _490)];
    float3 _522 = spvFMulMatrixVector(_515, float4(0.0, 0.0, 0.0, 1.0)).xyz;
    float3 _523 = _522 - View.View_PrevWorldCameraOrigin;
    float3 _527 = _523 / float3(sqrt(dot(_523, _523)));
    float _530 = dot(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _225)].xyz, _527);
    float3 _534 = _527 - (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _225)].xyz * _530);
    float _539 = dot(_534 / float3(sqrt(dot(_534, _534))), _238);
    uint _542 = _149 + 14u;
    uint _545 = _149 + 15u;
    uint _548 = _149 + 16u;
    float _558 = spvFMul(_530, _530);
    float _559 = spvFMul(_558, _558);
    float3 _565 = _507 - View.View_PrevPreViewTranslation;
    float3 _566 = _565 - _522;
    float4x4 _578 = _112;
    _578[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _542)];
    float4x4 _580 = _578;
    _580[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _545)];
    float4x4 _582 = _580;
    _582[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _548)];
    float4x4 _584 = _582;
    _584[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _149 + 17u)];
    float _593 = fast::min(fast::max((((spvFMulMatrixVector(_584, float4(_565, 1.0)).xyz - View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _305)].xyz) / (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _310)].xyz - View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _305)].xyz)).z - Material.Material_ScalarExpressions[1].w) / Material.Material_ScalarExpressions[2].x, 0.0), 1.0);
    float _594 = spvFMul(_593, _593);
    float3 _604 = spvFAdd(float3(-0.5), Material_Texture2D_2.sample(Material_Texture2D_2Sampler, spvFAdd(_522 * Material.Material_ScalarExpressions[1].y, float3(-1.0, 0.0, 0.0) * (spvFMul(View.View_PrevFrameGameTime, Material.Material_ScalarExpressions[1].z) - spvFMul(Material.Material_ScalarExpressions[2].y, _594))).xy, level(-1.0)).xyz) * 2.0;
    float3 _617 = spvFAdd(_566, spvFAdd(_345 * spvFMul(Material.Material_ScalarExpressions[2].z, spvFAdd(_604.z, 1.0)), spvFAdd(_345 * _604.x, _352 * _604.y) * Material.Material_ScalarExpressions[3].x) * _594);
    float _618 = dot(_617, _617);
    float3x3 _641 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _478)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _482)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _486)].xyz);
    float3 _643 = -spvFMulMatrixVector(_641, float3(1.0, 0.0, 0.0));
    float3 _647 = -spvFMulMatrixVector(_641, float3(0.0, 1.0, 0.0));
    float3 _651 = -spvFMulMatrixVector(_641, float3(0.0, 0.0, 1.0));
    float4 _670 = spvFMulMatrixVector(View.View_TranslatedWorldToClip, float4(spvFAdd(_200, select(_267 * (-1.0), spvFMul(spvFAdd(select(float4(0.0, 0.0, 0.0, 1.0), select(float4(0.0, 0.0, 0.0, 1.0), float4(_361 / float3(sqrt(_362)), 0.0), bool4(_362 >= 9.9999999747524270787835121154785e-07)), bool4(abs(_362 - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz * sqrt(dot(_268, _268)), _219) - _267, float3(sqrt(dot(_390, _390)), sqrt(dot(_401, _401)), sqrt(dot(_412, _412)))), bool3(fast::clamp(spvFAdd(mix(spvFMul(spvFMul(_239, _239), Material.Material_ScalarExpressions[0].z), spvFMulMatrixVector(float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _244)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _247)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _250)].xyz), _238).z, spvFMul(_261, _261)), 0.0199999995529651641845703125), 0.0, 1.0) >= 0.100000001490116119384765625))), 1.0));
    float4 _679 = _670;
    _679.z = spvFAdd(_670.z, (View.View_NumSceneColorMSAASamples > 1) ? spvFMul(0.001000000047497451305389404296875, _670.w) : 0.0);
    out.gl_Position = _679;
    out.out_var_TEXCOORD6 = _670;
    out.out_var_TEXCOORD7 = spvFMulMatrixVector(View.View_PrevTranslatedWorldToClip, float4(spvFAdd(_507, select(_565 * (-1.0), spvFMul(spvFAdd(select(float4(0.0, 0.0, 0.0, 1.0), select(float4(0.0, 0.0, 0.0, 1.0), float4(_617 / float3(sqrt(_618)), 0.0), bool4(_618 >= 9.9999999747524270787835121154785e-07)), bool4(abs(_618 - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz * sqrt(dot(_566, _566)), _522) - _565, float3(sqrt(dot(_643, _643)), sqrt(dot(_647, _647)), sqrt(dot(_651, _651)))), bool3(fast::clamp(spvFAdd(mix(spvFMul(spvFMul(_539, _539), Material.Material_ScalarExpressions[0].z), spvFMulMatrixVector(float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _542)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _545)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _548)].xyz), _238).z, spvFMul(_559, _559)), 0.0199999995529651641845703125), 0.0, 1.0) >= 0.100000001490116119384765625))), 1.0));
    out.out_var_TEXCOORD10_centroid = float4(_176[0], 0.0);
    out.out_var_TEXCOORD11_centroid = _476;
    out.out_var_TEXCOORD15 = _476;
    out_var_TEXCOORD0 = _477;
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

