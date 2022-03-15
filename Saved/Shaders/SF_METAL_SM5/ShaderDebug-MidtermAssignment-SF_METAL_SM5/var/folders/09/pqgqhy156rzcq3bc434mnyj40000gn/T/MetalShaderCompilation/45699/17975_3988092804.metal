

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

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
    float4 Primitive_InvNonUniformScaleAndDeterminantSign;
    char _m2_pad[16];
    float4x4 Primitive_WorldToLocal;
    char _m3_pad[144];
    float3 Primitive_ObjectBounds;
    char _m4_pad[48];
    float3 Primitive_LocalObjectBoundsMin;
    float3 Primitive_LocalObjectBoundsMax;
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
    float4 InstancingViewZCompareZero;
    float4 InstancingViewZCompareOne;
    float4 InstancingViewZConstant;
    float4 InstancingWorldViewOriginZero;
    float4 InstancingWorldViewOriginOne;
    float4 InstancingOffset;
    float4 InstancingFadeOutParams;
    uint InstanceOffset;
    uint LayerId;
};

constant float3x3 _128 = {};
constant float4 _129 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_COLOR0 [[user(locn2)]];
    float4 out_var_COLOR1 [[user(locn3)]];
    float4 out_var_TEXCOORD0_0 [[user(locn4)]];
    float3 out_var_TEXCOORD7 [[user(locn5)]];
    float4 out_var_TEXCOORD6 [[user(locn6)]];
    float3 out_var_TEXCOORD8 [[user(locn7)]];
    uint gl_Layer [[render_target_array_index]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

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

vertex Main_out Main_00004637_edb57784(Main_in in [[stage_in]], constant type_View& View [[buffer(5)]], constant type_Primitive& Primitive [[buffer(6)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(7)]], constant type_LocalVF& LocalVF [[buffer(8)]], constant type_Material& Material [[buffer(9)]], constant type_Globals& _Globals [[buffer(10)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceOriginBuffer [[texture(0)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceTransformBuffer [[texture(1)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(2)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(3)]], texture_buffer<float> LocalVF_VertexFetch_ColorComponentsBuffer [[texture(4)]], texture2d<float> Material_Texture2D_2 [[texture(5)]], sampler Material_Texture2D_2Sampler [[sampler(0)]], uint gl_InstanceIndex [[instance_id]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    uint _140 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _150 = (gl_InstanceIndex - gl_BaseInstance) + _Globals.InstanceOffset;
    uint _151 = 3u * _150;
    float4 _153 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_151));
    uint _154 = _151 + 1u;
    float4 _155 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_154));
    uint _156 = _151 + 2u;
    float4 _157 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_156));
    float4 _159 = InstanceVF_VertexFetch_InstanceOriginBuffer.read(uint(_150));
    uint _160 = 2u * _140;
    float4 _165 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_160 + 1u)));
    float _166 = _165.w;
    float3 _167 = _165.xyz;
    float3 _169 = cross(_167, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_160)).xyz) * _166;
    float3x3 _172 = _128;
    _172[0] = cross(_169, _167) * _166;
    float3x3 _173 = _172;
    _173[1] = _169;
    float3x3 _174 = _173;
    _174[2] = _167;
    float3x3 _188 = spvFMulMatrixMatrix(float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz), float3x3(_153.xyz, _155.xyz, _157.xyz));
    float3x3 _191 = _188;
    _191[0] = normalize(_188[0]);
    float3x3 _194 = _191;
    _194[1] = normalize(_188[1]);
    float3x3 _197 = _194;
    _197[2] = normalize(_188[2]);
    float3x3 _198 = spvFMulMatrixMatrix(_197, _174);
    float _202 = _153.w;
    float _203 = spvFMul(_202, 0.00390625);
    float _204 = trunc(_203);
    float _205 = _159.w;
    float4 _206 = _129;
    _206.x = _205;
    float3 _207 = _159.xyz;
    float3 _211 = spvFAdd(_207, _Globals.InstancingOffset.xyz);
    float3 _212 = _211.xxx;
    float3 _213 = _211.yyy;
    float3 _214 = spvFMul(Primitive.Primitive_LocalToWorld[1].xyz, _213);
    float3 _215 = fma(Primitive.Primitive_LocalToWorld[0].xyz, _212, _214);
    float3 _216 = _211.zzz;
    float3 _217 = fma(Primitive.Primitive_LocalToWorld[2].xyz, _216, _215);
    float3 _220 = spvFAdd(_217, Primitive.Primitive_LocalToWorld[3].xyz);
    float4 _231 = _206;
    _231.y = 1.0 - fast::clamp(spvFMul(length(spvFAdd(_220, View.View_PreViewTranslation)) - _Globals.InstancingFadeOutParams.x, _Globals.InstancingFadeOutParams.y), 0.0, 1.0);
    float _236 = 1.0 - _204;
    float _237 = spvFMul(_Globals.InstancingFadeOutParams.w, _236);
    float _238 = fma(_Globals.InstancingFadeOutParams.z, _204, _237);
    float3 _245 = _220 - _Globals.InstancingWorldViewOriginZero.xyz;
    float _246 = length(_245);
    float _247 = fma(_Globals.InstancingViewZCompareZero.w, _205, _246);
    float3 _251 = _220 - _Globals.InstancingWorldViewOriginOne.xyz;
    float _252 = length(_251);
    float _253 = fma(_Globals.InstancingViewZCompareZero.w, _205, _252);
    float3 _254 = float3(_247);
    bool3 _257 = _254 > _Globals.InstancingViewZCompareZero.xyz;
    float3 _258 = select(float3(0.0), float3(1.0), _257);
    float _262 = dot(_258, _Globals.InstancingViewZConstant.xyz);
    float3 _265 = float3(_253);
    bool3 _269 = _265 > _Globals.InstancingViewZCompareOne.xyz;
    float3 _270 = select(float3(0.0), float3(1.0), _269);
    float _271 = dot(_270, _Globals.InstancingViewZConstant.xyz);
    float _274 = spvFMul(_271, _Globals.InstancingWorldViewOriginOne.w);
    float _275 = fma(_262, _Globals.InstancingWorldViewOriginZero.w, _274);
    float4 _276 = _231;
    _276.w = _275;
    float _277 = abs(_275);
    bool _278 = _277 < 0.999000012874603271484375;
    float _279 = float(_278);
    float _280 = spvFMul(_238, _279);
    float4 _281 = _276;
    _281.z = _280;
    float _282 = _153.x;
    float _283 = _153.y;
    float _284 = _153.z;
    float4 _285 = float4(_282, _283, _284, 0.0);
    float _286 = _155.x;
    float _287 = _155.y;
    float _288 = _155.z;
    float4 _289 = float4(_286, _287, _288, 0.0);
    float _290 = _157.x;
    float _291 = _157.y;
    float _292 = _157.z;
    float4 _293 = float4(_290, _291, _292, 0.0);
    float _294 = _159.x;
    float _295 = _159.y;
    float _296 = _159.z;
    float4 _297 = float4(_294, _295, _296, 1.0);
    float4x4 _298 = float4x4(_285, _289, _293, _297);
    float4 _299 = spvFMulMatrixVector(_298, in.in_var_ATTRIBUTE0);
    float3 _300 = _299.xxx;
    float3 _301 = _299.yyy;
    float3 _302 = spvFMul(Primitive.Primitive_LocalToWorld[1].xyz, _301);
    float3 _303 = fma(Primitive.Primitive_LocalToWorld[0].xyz, _300, _302);
    float3 _304 = _299.zzz;
    float3 _305 = fma(Primitive.Primitive_LocalToWorld[2].xyz, _304, _303);
    float3 _306 = spvFAdd(Primitive.Primitive_LocalToWorld[3].xyz, View.View_PreViewTranslation);
    float3 _307 = spvFAdd(_305, _306);
    float _308 = _307.x;
    float _309 = _307.y;
    float _310 = _307.z;
    float4 _311 = float4(_308, _309, _310, 1.0);
    float4 _312 = _311 * _280;
    float3 _313 = _312.xyz;
    float4x4 _314 = spvFMulMatrixMatrix(Primitive.Primitive_LocalToWorld, _298);
    uint _317 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    uint _318 = _317 - 1u;
    uint _320 = _317 * _140;
    float4 _323 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_320 + min(0u, _318))));
    float4 _326 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_320 + min(1u, _318))));
    float4 _329 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_320 + min(2u, _318))));
    float3 _330 = _198[2];
    float3 _601;
    switch (0u)
    {
        default:
        {
            if (_280 < 1.0)
            {
                _601 = float3(0.0);
                break;
            }
            float3 _349 = spvFMulMatrixVector(_314, float4(0.0, 0.0, 0.0, 1.0)).xyz;
            float3 _350 = _313 - View.View_PreViewTranslation;
            float3 _357 = _349 * Material.Material_ScalarExpressions[1].x;
            float _366 = _329.y;
            float3 _378 = spvFAdd(Material_Texture2D_2.sample(Material_Texture2D_2Sampler, spvFAdd(spvFAdd((_350 - _349) * Material.Material_ScalarExpressions[0].w, _357), float3(1.0, 0.0, 0.0) * (spvFMul(View.View_GameTime, Material.Material_ScalarExpressions[1].y) - spvFMul(Material.Material_ScalarExpressions[1].z, _366))).xy, level(-1.0)).xyz, float3(-0.25, -0.5, -0.5)) * 2.0;
            float3 _383 = select(float4(1.0, 0.0, 0.0, 1.0), select(float4(1.0, 0.0, 0.0, 1.0), Material.Material_VectorExpressions[5], bool4(Material.Material_ScalarExpressions[0].y >= 9.9999999747524270787835121154785e-07)), bool4(abs(Material.Material_ScalarExpressions[0].y - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz;
            float3x3 _405 = float3x3(_314[0].xyz, _314[1].xyz, _314[2].xyz);
            float3 _406 = spvFMulMatrixVector(_405, spvFAdd(float3(-0.5), fract(spvFMul(float3(_326.y), float3(0.0625, 1.0, 16.0)))) * 2.0);
            float _409 = _329.x;
            float3 _412 = float3(1.0) - (_406 * spvFMul(Material.Material_ScalarExpressions[2].y, _409));
            float3 _413 = spvFAdd(_350, spvFAdd(_383 * spvFMul(Material.Material_ScalarExpressions[1].w, _378.x), float3(0.0, 0.0, 1.0) * spvFMul(_378.y, Material.Material_ScalarExpressions[2].x)) * _366) - _412;
            float _420 = dot(_383, _406 / float3(sqrt(dot(_406, _406))));
            float3 _423 = spvFAdd(_383, float3(0.0, 0.0, 1.0) * spvFMul(_420, _420));
            float3 _427 = _423 / float3(sqrt(dot(_423, _423)));
            float _428 = _326.x;
            float _431 = floor(spvFMul(_428, 7.111111164093017578125));
            float _433 = spvFMul(_428, 256.0) - spvFMul(_431, 36.0);
            float _435 = floor(spvFMul(_433, 0.16666667163372039794921875));
            float3 _463 = spvFAdd(float3(-0.5), Material_Texture2D_2.sample(Material_Texture2D_2Sampler, spvFAdd(spvFAdd(spvFMul(spvFMul(float3(_433 - spvFMul(_435, 6.0), _435, _431), float3(0.20000000298023223876953125, 0.20000000298023223876953125, 0.16666667163372039794921875)), Primitive.Primitive_ObjectBounds) * Material.Material_ScalarExpressions[2].z, float3(1.0)), float3(-1.0, 0.0, 0.0) * (fma(View.View_GameTime, Material.Material_ScalarExpressions[2].w, fract(dot(_357, _357))) - spvFMul(Material.Material_ScalarExpressions[3].x, _409))).xy, level(-1.0)).xyz) * 2.0;
            float3 _483 = spvFAdd(_413, spvFAdd(_427 * spvFMul(Material.Material_ScalarExpressions[3].y, spvFAdd(_463.z, 1.0)), spvFAdd(_427 * _463.x, Material.Material_VectorExpressions[6].xyz * _463.y) * Material.Material_ScalarExpressions[3].w) * _409);
            float _484 = dot(_483, _483);
            float3 _503 = spvFAdd(select(float4(0.0, 0.0, 0.0, 1.0), select(float4(0.0, 0.0, 0.0, 1.0), float4(_483 / float3(sqrt(_484)), 0.0), bool4(_484 >= 9.9999999747524270787835121154785e-07)), bool4(abs(_484 - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz * sqrt(dot(_413, _413)), _412) - _349;
            float _532 = fast::min(fast::max((((spvFMulMatrixVector(Primitive.Primitive_WorldToLocal, float4(_350, 1.0)).xyz - Primitive.Primitive_LocalObjectBoundsMin) / (Primitive.Primitive_LocalObjectBoundsMax - Primitive.Primitive_LocalObjectBoundsMin)).z - Material.Material_ScalarExpressions[4].y) / Material.Material_ScalarExpressions[4].z, 0.0), 1.0);
            float _533 = spvFMul(_532, _532);
            float3 _545 = spvFAdd(float3(-0.5), Material_Texture2D_2.sample(Material_Texture2D_2Sampler, spvFAdd(_357, float3(-1.0, 0.0, 0.0) * (spvFMul(View.View_GameTime, Material.Material_ScalarExpressions[4].x) - spvFMul(Material.Material_ScalarExpressions[4].w, _533))).xy, level(-1.0)).xyz) * 2.0;
            float3 _566 = spvFAdd(_503, spvFAdd(_383 * spvFMul(Material.Material_ScalarExpressions[5].x, spvFAdd(_545.z, 1.0)), spvFAdd(_383 * _545.x, (cross(_383, float3(0.0, 0.0, 1.0)) * Material.Material_ScalarExpressions[5].y) * _545.y) * Material.Material_ScalarExpressions[5].z) * _533);
            float _567 = dot(_566, _566);
            float3 _588 = -spvFMulMatrixVector(_405, float3(1.0, 0.0, 0.0));
            float3 _592 = -spvFMulMatrixVector(_405, float3(0.0, 1.0, 0.0));
            float3 _596 = -spvFMulMatrixVector(_405, float3(0.0, 0.0, 1.0));
            _601 = spvFMul(spvFAdd(select(float4(0.0, 0.0, 0.0, 1.0), select(float4(0.0, 0.0, 0.0, 1.0), float4(_566 / float3(sqrt(_567)), 0.0), bool4(_567 >= 9.9999999747524270787835121154785e-07)), bool4(abs(_567 - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz * sqrt(dot(_503, _503)), _349) - _350, float3(sqrt(dot(_588, _588)), sqrt(dot(_592, _592)), sqrt(dot(_596, _596))));
            break;
        }
    }
    float3 _602 = spvFAdd(_313, _601);
    float4 _603 = float4(_602.x, _602.y, _602.z, _312.w);
    spvUnsafeArray<float4, 1> _614 = { float4(_323.x, _323.y, float4(0.0).z, float4(0.0).w) };
    float4 _620 = spvFMulMatrixVector(ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId], _603);
    out.out_var_TEXCOORD10_centroid = float4(_198[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_330, spvFMul(_166, Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w));
    out.out_var_COLOR0 = LocalVF_VertexFetch_ColorComponentsBuffer.read(uint((_140 & uint(LocalVF.LocalVF_VertexFetch_Parameters.x)))).zyxw;
    out.out_var_COLOR1 = _281;
    out_var_TEXCOORD0 = _614;
    out.out_var_TEXCOORD7 = _602.xyz;
    out.out_var_TEXCOORD6 = _620;
    out.out_var_TEXCOORD8 = _330;
    out.gl_Layer = _Globals.LayerId;
    out.gl_Position = _620;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

