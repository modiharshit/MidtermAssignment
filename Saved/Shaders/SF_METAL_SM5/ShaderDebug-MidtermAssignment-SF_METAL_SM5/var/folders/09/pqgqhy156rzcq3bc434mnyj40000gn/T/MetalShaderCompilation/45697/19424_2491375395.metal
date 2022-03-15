

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
    char _m1_pad[4];
    uint LocalVF_LODLightmapDataIndex;
};

struct type_Material
{
    spvUnsafeArray<float4, 6> Material_VectorExpressions;
    spvUnsafeArray<float4, 4> Material_ScalarExpressions;
};

constant float3x3 _109 = {};
constant float4x4 _110 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD15 [[user(locn2)]];
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

vertex MainVertexShader_out Main_00004be0_947f5f23(MainVertexShader_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(7)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(3)]], constant type_View& View [[buffer(4)]], constant type_LocalVF& LocalVF [[buffer(5)]], constant type_Material& Material [[buffer(6)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(0)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(1)]], texture2d<float> Material_Texture2D_2 [[texture(2)]], sampler Material_Texture2D_2Sampler [[sampler(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[3];
    uint _124 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _125 = 2u * _124;
    float4 _130 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_125 + 1u)));
    float _131 = _130.w;
    float3 _132 = _130.xyz;
    float3 _134 = cross(_132, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_125)).xyz) * _131;
    float3x3 _137 = _109;
    _137[0] = cross(_134, _132) * _131;
    float3x3 _138 = _137;
    _138[1] = _134;
    float3x3 _139 = _138;
    _139[2] = _132;
    uint _140 = in.in_var_ATTRIBUTE13 * 36u;
    uint _143 = _140 + 1u;
    uint _146 = _140 + 2u;
    uint _149 = _140 + 3u;
    uint _155 = _140 + 4u;
    float3x3 _160 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _140)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _143)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _146)].xyz);
    _160[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _140)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _155)].x;
    float3x3 _163 = _160;
    _163[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _143)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _155)].y;
    float3x3 _166 = _163;
    _166[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _146)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _155)].z;
    float3x3 _167 = spvFMulMatrixMatrix(_166, _139);
    float3 _179 = spvFMul(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _143)].xyz, in.in_var_ATTRIBUTE0.yyy);
    float3 _180 = fma(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _140)].xyz, in.in_var_ATTRIBUTE0.xxx, _179);
    float3 _183 = fma(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _146)].xyz, in.in_var_ATTRIBUTE0.zzz, _180);
    float3 _185 = spvFAdd(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _149)].xyz, View.View_PreViewTranslation);
    float3 _186 = spvFAdd(_183, _185);
    float _187 = _186.x;
    float _188 = _186.y;
    float _189 = _186.z;
    float4 _190 = float4(_187, _188, _189, 1.0);
    float3 _191 = _190.xyz;
    uint _194 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    uint _197 = _194 * _124;
    float4 _200 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_197 + min(0u, (_194 - 1u)))));
    float4x4 _202 = _110;
    _202[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _140)];
    float4x4 _204 = _202;
    _204[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _143)];
    float4x4 _206 = _204;
    _206[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _146)];
    float4x4 _208 = _206;
    _208[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _149)];
    float4 _209 = spvFMulMatrixVector(_208, float4(0.0, 0.0, 0.0, 1.0));
    float3 _210 = _209.xyz;
    float3 _211 = _210 - View.View_WorldCameraOrigin;
    float _212 = dot(_211, _211);
    float _213 = sqrt(_212);
    float3 _214 = float3(_213);
    float3 _215 = _211 / _214;
    uint _216 = _140 + 21u;
    float _220 = dot(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _216)].xyz, _215);
    float3 _223 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _216)].xyz * _220;
    float3 _224 = _215 - _223;
    float _225 = dot(_224, _224);
    float _226 = sqrt(_225);
    float3 _227 = float3(_226);
    float3 _228 = _224 / _227;
    float3 _229 = _167[2];
    float _230 = dot(_228, _229);
    float _231 = spvFMul(_230, _230);
    float _234 = spvFMul(_231, Material.Material_ScalarExpressions[0].z);
    uint _235 = _140 + 6u;
    uint _238 = _140 + 7u;
    uint _241 = _140 + 8u;
    float3x3 _249 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _235)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _238)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _241)].xyz);
    float3 _250 = spvFMulMatrixVector(_249, _229);
    float _251 = spvFMul(_220, _220);
    float _252 = spvFMul(_251, _251);
    float _253 = spvFMul(_252, _252);
    float _254 = _250.z;
    float _255 = mix(_234, _254, _253);
    float _256 = spvFAdd(_255, 0.0199999995529651641845703125);
    float _257 = fast::clamp(_256, 0.0, 1.0);
    float3 _258 = _191 - View.View_PreViewTranslation;
    float3 _259 = _258 - _210;
    float _260 = dot(_259, _259);
    float _261 = sqrt(_260);
    float _264 = Material.Material_ScalarExpressions[0].w - 9.9999999747524270787835121154785e-07;
    float _265 = abs(_264);
    bool _266 = _265 > 9.9999997473787516355514526367188e-06;
    bool _267 = Material.Material_ScalarExpressions[0].w >= 9.9999999747524270787835121154785e-07;
    bool4 _270 = bool4(_267);
    float4 _271 = select(float4(1.0, 0.0, 0.0, 1.0), Material.Material_VectorExpressions[5], _270);
    bool4 _272 = bool4(_266);
    float4 _273 = select(float4(1.0, 0.0, 0.0, 1.0), _271, _272);
    float3 _276 = _210 * Material.Material_ScalarExpressions[1].y;
    float _281 = spvFMul(View.View_GameTime, Material.Material_ScalarExpressions[1].z);
    float _282 = _258.x;
    float _283 = _258.y;
    float _284 = _258.z;
    float4 _285 = float4(_282, _283, _284, 1.0);
    float4x4 _287 = _110;
    _287[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _235)];
    float4x4 _289 = _287;
    _289[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _238)];
    float4x4 _291 = _289;
    _291[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _241)];
    float4x4 _293 = _291;
    _293[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _140 + 9u)];
    float4 _294 = spvFMulMatrixVector(_293, _285);
    float3 _295 = _294.xyz;
    uint _296 = _140 + 23u;
    float3 _300 = _295 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _296)].xyz;
    uint _301 = _140 + 24u;
    float3 _305 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _301)].xyz - View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _296)].xyz;
    float3 _306 = _300 / _305;
    float _307 = _306.z;
    float _310 = _307 - Material.Material_ScalarExpressions[1].w;
    float _313 = _310 / Material.Material_ScalarExpressions[2].x;
    float _314 = fast::max(_313, 0.0);
    float _315 = fast::min(_314, 1.0);
    float _316 = spvFMul(_315, _315);
    float _319 = spvFMul(Material.Material_ScalarExpressions[2].y, _316);
    float _320 = _281 - _319;
    float3 _321 = float3(-1.0, 0.0, 0.0) * _320;
    float3 _322 = spvFAdd(_276, _321);
    float2 _325 = _322.xy;
    float4 _327 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _325, level(-1.0));
    float3 _328 = _327.xyz;
    float3 _329 = spvFAdd(float3(-0.5), _328);
    float3 _330 = _329 * 2.0;
    float _331 = _330.z;
    float _332 = spvFAdd(_331, 1.0);
    float _335 = spvFMul(Material.Material_ScalarExpressions[2].z, _332);
    float3 _336 = _273.xyz;
    float3 _337 = _336 * _335;
    float _338 = _330.x;
    float3 _339 = _336 * _338;
    float3 _340 = cross(_336, float3(0.0, 0.0, 1.0));
    float3 _343 = _340 * Material.Material_ScalarExpressions[2].w;
    float _344 = _330.y;
    float3 _345 = _343 * _344;
    float3 _346 = spvFAdd(_339, _345);
    float3 _349 = _346 * Material.Material_ScalarExpressions[3].x;
    float3 _350 = spvFAdd(_337, _349);
    float3 _351 = _350 * _316;
    float3 _352 = spvFAdd(_259, _351);
    float _353 = dot(_352, _352);
    float _354 = sqrt(_353);
    float3 _355 = float3(_354);
    float3 _356 = _352 / _355;
    float _357 = _353 - 9.9999999747524270787835121154785e-07;
    float _358 = abs(_357);
    bool _359 = _358 > 9.9999997473787516355514526367188e-06;
    bool _360 = _353 >= 9.9999999747524270787835121154785e-07;
    float _361 = _356.x;
    float _362 = _356.y;
    float _363 = _356.z;
    float4 _364 = float4(_361, _362, _363, 0.0);
    bool4 _365 = bool4(_360);
    float4 _366 = select(float4(0.0, 0.0, 0.0, 1.0), _364, _365);
    bool4 _367 = bool4(_359);
    float4 _368 = select(float4(0.0, 0.0, 0.0, 1.0), _366, _367);
    float3 _369 = _368.xyz;
    float3 _370 = _369 * _261;
    float3 _371 = spvFAdd(_370, _210);
    float3 _372 = _371 - _258;
    float3x3 _379 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _140)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _143)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _146)].xyz);
    float3 _380 = spvFMulMatrixVector(_379, float3(1.0, 0.0, 0.0));
    float3 _381 = -_380;
    float _382 = dot(_381, _381);
    float _383 = sqrt(_382);
    float3x3 _390 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _140)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _143)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _146)].xyz);
    float3 _391 = spvFMulMatrixVector(_390, float3(0.0, 1.0, 0.0));
    float3 _392 = -_391;
    float _393 = dot(_392, _392);
    float _394 = sqrt(_393);
    float3x3 _401 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _140)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _143)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _146)].xyz);
    float3 _402 = spvFMulMatrixVector(_401, float3(0.0, 0.0, 1.0));
    float3 _403 = -_402;
    float _404 = dot(_403, _403);
    float _405 = sqrt(_404);
    float3 _406 = float3(_383, _394, _405);
    float3 _407 = spvFMul(_372, _406);
    float3 _408 = _258 * (-1.0);
    bool _409 = _257 >= 0.100000001490116119384765625;
    bool3 _410 = bool3(_409);
    float3 _411 = select(_408, _407, _410);
    float3 _412 = spvFAdd(_191, _411);
    float4 _413 = float4(_412.x, _412.y, _412.z, _190.w);
    float4 _414 = spvFMulMatrixVector(View.View_TranslatedWorldToClip, _413);
    float4x4 _416 = _110;
    _416[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _140)];
    float4x4 _418 = _416;
    _418[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _143)];
    float4x4 _420 = _418;
    _420[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _146)];
    float4x4 _422 = _420;
    _422[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _149)];
    float3 _425 = spvFMulMatrixVector(_422, float4(0.0, 0.0, 0.0, 1.0)).xyz - View.View_WorldCameraOrigin;
    float3 _429 = _425 / float3(sqrt(dot(_425, _425)));
    float _432 = dot(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _216)].xyz, _429);
    float3 _436 = _429 - (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _216)].xyz * _432);
    float _441 = dot(_436 / float3(sqrt(dot(_436, _436))), _229);
    float _452 = spvFMul(_432, _432);
    float _453 = spvFMul(_452, _452);
    float2 _459 = float2(fast::clamp(spvFAdd(mix(spvFMul(spvFMul(_441, _441), Material.Material_ScalarExpressions[0].z), spvFMulMatrixVector(float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _235)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _238)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _241)].xyz), _229).z, spvFMul(_453, _453)), 0.0199999995529651641845703125), 0.0, 1.0));
    uint _472 = as_type<uint>(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _301)].w) + LocalVF.LocalVF_LODLightmapDataIndex;
    uint _474 = (_472 * 15u) + 2u;
    float2 _479 = fma(LocalVF_VertexFetch_TexCoordBuffer.read(uint((_197 + uint(LocalVF.LocalVF_VertexFetch_Parameters.z)))).xy, View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _474)].xy, View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _474)].zw);
    float4 _489 = float4(_229, spvFMul(_131, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _155)].w));
    spvUnsafeArray<float4, 1> _490 = { float4(_200.x, _200.y, _459.x, _459.y) };
    out.out_var_TEXCOORD10_centroid = float4(_167[0], 0.0);
    out.out_var_TEXCOORD11_centroid = _489;
    out.out_var_TEXCOORD15 = _489;
    out_var_TEXCOORD0 = _490;
    out.out_var_TEXCOORD4 = float4(_479.x, _479.y, float2(0.0).x, float2(0.0).y);
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    out.out_var_LIGHTMAP_ID = _472;
    out.out_var_TEXCOORD6 = _413;
    out.out_var_TEXCOORD7 = _191;
    out.gl_Position = _414;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

