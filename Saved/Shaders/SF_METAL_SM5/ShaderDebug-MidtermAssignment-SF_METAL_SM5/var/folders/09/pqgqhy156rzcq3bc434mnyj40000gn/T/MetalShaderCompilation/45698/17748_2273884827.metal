

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
};

constant float3x3 _121 = {};
constant float4 _122 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_COLOR0 [[user(locn2)]];
    float4 out_var_COLOR1 [[user(locn3)]];
    float4 out_var_TEXCOORD0_0 [[user(locn4)]];
    float4 out_var_HIT_PROXY_ID [[user(locn5)]];
    float4 out_var_TEXCOORD6 [[user(locn6)]];
    float3 out_var_TEXCOORD7 [[user(locn7)]];
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

vertex Main_out Main_00004554_8788ba9b(Main_in in [[stage_in]], constant type_View& View [[buffer(5)]], constant type_Primitive& Primitive [[buffer(6)]], constant type_LocalVF& LocalVF [[buffer(7)]], constant type_Material& Material [[buffer(8)]], constant type_Globals& _Globals [[buffer(9)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceOriginBuffer [[texture(0)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceTransformBuffer [[texture(1)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(2)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(3)]], texture_buffer<float> LocalVF_VertexFetch_ColorComponentsBuffer [[texture(4)]], texture2d<float> Material_Texture2D_2 [[texture(5)]], sampler Material_Texture2D_2Sampler [[sampler(0)]], uint gl_InstanceIndex [[instance_id]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    uint _134 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _144 = (gl_InstanceIndex - gl_BaseInstance) + _Globals.InstanceOffset;
    uint _145 = 3u * _144;
    float4 _147 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_145));
    uint _148 = _145 + 1u;
    float4 _149 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_148));
    uint _150 = _145 + 2u;
    float4 _151 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_150));
    float4 _153 = InstanceVF_VertexFetch_InstanceOriginBuffer.read(uint(_144));
    uint _154 = 2u * _134;
    float4 _159 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_154 + 1u)));
    float _160 = _159.w;
    float3 _161 = _159.xyz;
    float3 _163 = cross(_161, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_154)).xyz) * _160;
    float3x3 _166 = _121;
    _166[0] = cross(_163, _161) * _160;
    float3x3 _167 = _166;
    _167[1] = _163;
    float3x3 _168 = _167;
    _168[2] = _161;
    float3x3 _182 = spvFMulMatrixMatrix(float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz), float3x3(_147.xyz, _149.xyz, _151.xyz));
    float3x3 _185 = _182;
    _185[0] = normalize(_182[0]);
    float3x3 _188 = _185;
    _188[1] = normalize(_182[1]);
    float3x3 _191 = _188;
    _191[2] = normalize(_182[2]);
    float3x3 _192 = spvFMulMatrixMatrix(_191, _168);
    float _196 = _147.w;
    float _197 = spvFMul(_196, 0.00390625);
    float _198 = trunc(_197);
    float _199 = _153.w;
    float4 _200 = _122;
    _200.x = _199;
    float3 _201 = _153.xyz;
    float3 _205 = spvFAdd(_201, _Globals.InstancingOffset.xyz);
    float3 _206 = _205.xxx;
    float3 _207 = _205.yyy;
    float3 _208 = spvFMul(Primitive.Primitive_LocalToWorld[1].xyz, _207);
    float3 _209 = fma(Primitive.Primitive_LocalToWorld[0].xyz, _206, _208);
    float3 _210 = _205.zzz;
    float3 _211 = fma(Primitive.Primitive_LocalToWorld[2].xyz, _210, _209);
    float3 _214 = spvFAdd(_211, Primitive.Primitive_LocalToWorld[3].xyz);
    float4 _225 = _200;
    _225.y = 1.0 - fast::clamp(spvFMul(length(spvFAdd(_214, View.View_PreViewTranslation)) - _Globals.InstancingFadeOutParams.x, _Globals.InstancingFadeOutParams.y), 0.0, 1.0);
    float _230 = 1.0 - _198;
    float _231 = spvFMul(_Globals.InstancingFadeOutParams.w, _230);
    float _232 = fma(_Globals.InstancingFadeOutParams.z, _198, _231);
    float3 _239 = _214 - _Globals.InstancingWorldViewOriginZero.xyz;
    float _240 = length(_239);
    float _241 = fma(_Globals.InstancingViewZCompareZero.w, _199, _240);
    float3 _245 = _214 - _Globals.InstancingWorldViewOriginOne.xyz;
    float _246 = length(_245);
    float _247 = fma(_Globals.InstancingViewZCompareZero.w, _199, _246);
    float3 _248 = float3(_241);
    bool3 _251 = _248 > _Globals.InstancingViewZCompareZero.xyz;
    float3 _252 = select(float3(0.0), float3(1.0), _251);
    float _256 = dot(_252, _Globals.InstancingViewZConstant.xyz);
    float3 _259 = float3(_247);
    bool3 _263 = _259 > _Globals.InstancingViewZCompareOne.xyz;
    float3 _264 = select(float3(0.0), float3(1.0), _263);
    float _265 = dot(_264, _Globals.InstancingViewZConstant.xyz);
    float _268 = spvFMul(_265, _Globals.InstancingWorldViewOriginOne.w);
    float _269 = fma(_256, _Globals.InstancingWorldViewOriginZero.w, _268);
    float4 _270 = _225;
    _270.w = _269;
    float _271 = abs(_269);
    bool _272 = _271 < 0.999000012874603271484375;
    float _273 = float(_272);
    float _274 = spvFMul(_232, _273);
    float4 _275 = _270;
    _275.z = _274;
    float _276 = _147.x;
    float _277 = _147.y;
    float _278 = _147.z;
    float4 _279 = float4(_276, _277, _278, 0.0);
    float _280 = _149.x;
    float _281 = _149.y;
    float _282 = _149.z;
    float4 _283 = float4(_280, _281, _282, 0.0);
    float _284 = _151.x;
    float _285 = _151.y;
    float _286 = _151.z;
    float4 _287 = float4(_284, _285, _286, 0.0);
    float _288 = _153.x;
    float _289 = _153.y;
    float _290 = _153.z;
    float4 _291 = float4(_288, _289, _290, 1.0);
    float4x4 _292 = float4x4(_279, _283, _287, _291);
    float4 _293 = spvFMulMatrixVector(_292, in.in_var_ATTRIBUTE0);
    float3 _294 = _293.xxx;
    float3 _295 = _293.yyy;
    float3 _296 = spvFMul(Primitive.Primitive_LocalToWorld[1].xyz, _295);
    float3 _297 = fma(Primitive.Primitive_LocalToWorld[0].xyz, _294, _296);
    float3 _298 = _293.zzz;
    float3 _299 = fma(Primitive.Primitive_LocalToWorld[2].xyz, _298, _297);
    float3 _300 = spvFAdd(Primitive.Primitive_LocalToWorld[3].xyz, View.View_PreViewTranslation);
    float3 _301 = spvFAdd(_299, _300);
    float _302 = _301.x;
    float _303 = _301.y;
    float _304 = _301.z;
    float4 _305 = float4(_302, _303, _304, 1.0);
    float4 _306 = _305 * _274;
    float3 _307 = _306.xyz;
    float4x4 _308 = spvFMulMatrixMatrix(Primitive.Primitive_LocalToWorld, _292);
    uint _311 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    uint _312 = _311 - 1u;
    uint _314 = _311 * _134;
    float4 _317 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_314 + min(0u, _312))));
    float4 _320 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_314 + min(1u, _312))));
    float4 _323 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_314 + min(2u, _312))));
    float3 _594;
    switch (0u)
    {
        default:
        {
            if (_274 < 1.0)
            {
                _594 = float3(0.0);
                break;
            }
            float3 _342 = spvFMulMatrixVector(_308, float4(0.0, 0.0, 0.0, 1.0)).xyz;
            float3 _343 = _307 - View.View_PreViewTranslation;
            float3 _350 = _342 * Material.Material_ScalarExpressions[1].x;
            float _359 = _323.y;
            float3 _371 = spvFAdd(Material_Texture2D_2.sample(Material_Texture2D_2Sampler, spvFAdd(spvFAdd((_343 - _342) * Material.Material_ScalarExpressions[0].w, _350), float3(1.0, 0.0, 0.0) * (spvFMul(View.View_GameTime, Material.Material_ScalarExpressions[1].y) - spvFMul(Material.Material_ScalarExpressions[1].z, _359))).xy, level(-1.0)).xyz, float3(-0.25, -0.5, -0.5)) * 2.0;
            float3 _376 = select(float4(1.0, 0.0, 0.0, 1.0), select(float4(1.0, 0.0, 0.0, 1.0), Material.Material_VectorExpressions[5], bool4(Material.Material_ScalarExpressions[0].y >= 9.9999999747524270787835121154785e-07)), bool4(abs(Material.Material_ScalarExpressions[0].y - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz;
            float3x3 _398 = float3x3(_308[0].xyz, _308[1].xyz, _308[2].xyz);
            float3 _399 = spvFMulMatrixVector(_398, spvFAdd(float3(-0.5), fract(spvFMul(float3(_320.y), float3(0.0625, 1.0, 16.0)))) * 2.0);
            float _402 = _323.x;
            float3 _405 = float3(1.0) - (_399 * spvFMul(Material.Material_ScalarExpressions[2].y, _402));
            float3 _406 = spvFAdd(_343, spvFAdd(_376 * spvFMul(Material.Material_ScalarExpressions[1].w, _371.x), float3(0.0, 0.0, 1.0) * spvFMul(_371.y, Material.Material_ScalarExpressions[2].x)) * _359) - _405;
            float _413 = dot(_376, _399 / float3(sqrt(dot(_399, _399))));
            float3 _416 = spvFAdd(_376, float3(0.0, 0.0, 1.0) * spvFMul(_413, _413));
            float3 _420 = _416 / float3(sqrt(dot(_416, _416)));
            float _421 = _320.x;
            float _424 = floor(spvFMul(_421, 7.111111164093017578125));
            float _426 = spvFMul(_421, 256.0) - spvFMul(_424, 36.0);
            float _428 = floor(spvFMul(_426, 0.16666667163372039794921875));
            float3 _456 = spvFAdd(float3(-0.5), Material_Texture2D_2.sample(Material_Texture2D_2Sampler, spvFAdd(spvFAdd(spvFMul(spvFMul(float3(_426 - spvFMul(_428, 6.0), _428, _424), float3(0.20000000298023223876953125, 0.20000000298023223876953125, 0.16666667163372039794921875)), Primitive.Primitive_ObjectBounds) * Material.Material_ScalarExpressions[2].z, float3(1.0)), float3(-1.0, 0.0, 0.0) * (fma(View.View_GameTime, Material.Material_ScalarExpressions[2].w, fract(dot(_350, _350))) - spvFMul(Material.Material_ScalarExpressions[3].x, _402))).xy, level(-1.0)).xyz) * 2.0;
            float3 _476 = spvFAdd(_406, spvFAdd(_420 * spvFMul(Material.Material_ScalarExpressions[3].y, spvFAdd(_456.z, 1.0)), spvFAdd(_420 * _456.x, Material.Material_VectorExpressions[6].xyz * _456.y) * Material.Material_ScalarExpressions[3].w) * _402);
            float _477 = dot(_476, _476);
            float3 _496 = spvFAdd(select(float4(0.0, 0.0, 0.0, 1.0), select(float4(0.0, 0.0, 0.0, 1.0), float4(_476 / float3(sqrt(_477)), 0.0), bool4(_477 >= 9.9999999747524270787835121154785e-07)), bool4(abs(_477 - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz * sqrt(dot(_406, _406)), _405) - _342;
            float _525 = fast::min(fast::max((((spvFMulMatrixVector(Primitive.Primitive_WorldToLocal, float4(_343, 1.0)).xyz - Primitive.Primitive_LocalObjectBoundsMin) / (Primitive.Primitive_LocalObjectBoundsMax - Primitive.Primitive_LocalObjectBoundsMin)).z - Material.Material_ScalarExpressions[4].y) / Material.Material_ScalarExpressions[4].z, 0.0), 1.0);
            float _526 = spvFMul(_525, _525);
            float3 _538 = spvFAdd(float3(-0.5), Material_Texture2D_2.sample(Material_Texture2D_2Sampler, spvFAdd(_350, float3(-1.0, 0.0, 0.0) * (spvFMul(View.View_GameTime, Material.Material_ScalarExpressions[4].x) - spvFMul(Material.Material_ScalarExpressions[4].w, _526))).xy, level(-1.0)).xyz) * 2.0;
            float3 _559 = spvFAdd(_496, spvFAdd(_376 * spvFMul(Material.Material_ScalarExpressions[5].x, spvFAdd(_538.z, 1.0)), spvFAdd(_376 * _538.x, (cross(_376, float3(0.0, 0.0, 1.0)) * Material.Material_ScalarExpressions[5].y) * _538.y) * Material.Material_ScalarExpressions[5].z) * _526);
            float _560 = dot(_559, _559);
            float3 _581 = -spvFMulMatrixVector(_398, float3(1.0, 0.0, 0.0));
            float3 _585 = -spvFMulMatrixVector(_398, float3(0.0, 1.0, 0.0));
            float3 _589 = -spvFMulMatrixVector(_398, float3(0.0, 0.0, 1.0));
            _594 = spvFMul(spvFAdd(select(float4(0.0, 0.0, 0.0, 1.0), select(float4(0.0, 0.0, 0.0, 1.0), float4(_559 / float3(sqrt(_560)), 0.0), bool4(_560 >= 9.9999999747524270787835121154785e-07)), bool4(abs(_560 - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz * sqrt(dot(_496, _496)), _342) - _343, float3(sqrt(dot(_581, _581)), sqrt(dot(_585, _585)), sqrt(dot(_589, _589))));
            break;
        }
    }
    float3 _595 = spvFAdd(_307, _594);
    float4 _596 = float4(_595.x, _595.y, _595.z, _306.w);
    float4 _607 = spvFMulMatrixVector(View.View_TranslatedWorldToClip, _596);
    spvUnsafeArray<float4, 1> _619 = { float4(_317.x, _317.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_192[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_192[2], spvFMul(_160, Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w));
    out.out_var_COLOR0 = LocalVF_VertexFetch_ColorComponentsBuffer.read(uint((_134 & uint(LocalVF.LocalVF_VertexFetch_Parameters.x)))).zyxw;
    out.out_var_COLOR1 = _275;
    out_var_TEXCOORD0 = _619;
    out.out_var_HIT_PROXY_ID = float4(spvFMul(_196 - spvFMul(256.0, _198), 0.0039215688593685626983642578125), spvFMul(_149.w, 0.0039215688593685626983642578125), spvFMul(_151.w, 0.0039215688593685626983642578125), 0.0);
    out.out_var_TEXCOORD6 = _596;
    out.out_var_TEXCOORD7 = _307;
    out.gl_Position = _607;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

