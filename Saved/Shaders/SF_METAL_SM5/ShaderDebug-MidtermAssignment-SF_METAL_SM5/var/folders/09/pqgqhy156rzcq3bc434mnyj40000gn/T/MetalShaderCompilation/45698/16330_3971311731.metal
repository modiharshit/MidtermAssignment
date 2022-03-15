

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

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
    float4 Primitive_InvNonUniformScaleAndDeterminantSign;
    char _m2_pad[16];
    float4x4 Primitive_WorldToLocal;
    char _m3_pad[176];
    float4 Primitive_ObjectOrientation;
    char _m4_pad[16];
    float3 Primitive_LocalObjectBoundsMin;
    float3 Primitive_LocalObjectBoundsMax;
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

constant float3x3 _107 = {};
constant float4 _108 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD15 [[user(locn2)]];
    float4 out_var_COLOR1 [[user(locn3)]];
    float4 out_var_TEXCOORD0_0 [[user(locn4)]];
    float4 out_var_TEXCOORD6 [[user(locn5)]];
    float3 out_var_TEXCOORD7 [[user(locn6)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVertexShader_in
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

vertex MainVertexShader_out Main_00003fca_ecb56873(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_LocalVF& LocalVF [[buffer(6)]], constant type_Material& Material [[buffer(7)]], constant type_Globals& _Globals [[buffer(8)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceOriginBuffer [[texture(0)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceTransformBuffer [[texture(1)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(2)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(3)]], texture2d<float> Material_Texture2D_2 [[texture(4)]], sampler Material_Texture2D_2Sampler [[sampler(0)]], uint gl_InstanceIndex [[instance_id]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    uint _122 = (gl_InstanceIndex - gl_BaseInstance) + _Globals.InstanceOffset;
    uint _123 = 3u * _122;
    float4 _125 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_123));
    uint _126 = _123 + 1u;
    float4 _127 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_126));
    uint _128 = _123 + 2u;
    float4 _129 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_128));
    float4 _131 = InstanceVF_VertexFetch_InstanceOriginBuffer.read(uint(_122));
    uint _135 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _136 = 2u * _135;
    float4 _141 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_136 + 1u)));
    float _142 = _141.w;
    float3 _143 = _141.xyz;
    float3 _145 = cross(_143, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_136)).xyz) * _142;
    float3x3 _148 = _107;
    _148[0] = cross(_145, _143) * _142;
    float3x3 _149 = _148;
    _149[1] = _145;
    float3x3 _150 = _149;
    _150[2] = _143;
    float3x3 _164 = spvFMulMatrixMatrix(float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz), float3x3(_125.xyz, _127.xyz, _129.xyz));
    float3x3 _167 = _164;
    _167[0] = normalize(_164[0]);
    float3x3 _170 = _167;
    _170[1] = normalize(_164[1]);
    float3x3 _173 = _170;
    _173[2] = normalize(_164[2]);
    float3x3 _174 = spvFMulMatrixMatrix(_173, _150);
    float _178 = _125.w;
    float _179 = spvFMul(_178, 0.00390625);
    float _180 = trunc(_179);
    float _181 = _131.w;
    float4 _182 = _108;
    _182.x = _181;
    float3 _183 = _131.xyz;
    float3 _187 = spvFAdd(_183, _Globals.InstancingOffset.xyz);
    float3 _188 = _187.xxx;
    float3 _189 = _187.yyy;
    float3 _190 = spvFMul(Primitive.Primitive_LocalToWorld[1].xyz, _189);
    float3 _191 = fma(Primitive.Primitive_LocalToWorld[0].xyz, _188, _190);
    float3 _192 = _187.zzz;
    float3 _193 = fma(Primitive.Primitive_LocalToWorld[2].xyz, _192, _191);
    float3 _196 = spvFAdd(_193, Primitive.Primitive_LocalToWorld[3].xyz);
    float4 _207 = _182;
    _207.y = 1.0 - fast::clamp(spvFMul(length(spvFAdd(_196, View.View_PreViewTranslation)) - _Globals.InstancingFadeOutParams.x, _Globals.InstancingFadeOutParams.y), 0.0, 1.0);
    float _212 = 1.0 - _180;
    float _213 = spvFMul(_Globals.InstancingFadeOutParams.w, _212);
    float _214 = fma(_Globals.InstancingFadeOutParams.z, _180, _213);
    float3 _221 = _196 - _Globals.InstancingWorldViewOriginZero.xyz;
    float _222 = length(_221);
    float _223 = fma(_Globals.InstancingViewZCompareZero.w, _181, _222);
    float3 _227 = _196 - _Globals.InstancingWorldViewOriginOne.xyz;
    float _228 = length(_227);
    float _229 = fma(_Globals.InstancingViewZCompareZero.w, _181, _228);
    float3 _230 = float3(_223);
    bool3 _233 = _230 > _Globals.InstancingViewZCompareZero.xyz;
    float3 _234 = select(float3(0.0), float3(1.0), _233);
    float _238 = dot(_234, _Globals.InstancingViewZConstant.xyz);
    float3 _241 = float3(_229);
    bool3 _245 = _241 > _Globals.InstancingViewZCompareOne.xyz;
    float3 _246 = select(float3(0.0), float3(1.0), _245);
    float _247 = dot(_246, _Globals.InstancingViewZConstant.xyz);
    float _250 = spvFMul(_247, _Globals.InstancingWorldViewOriginOne.w);
    float _251 = fma(_238, _Globals.InstancingWorldViewOriginZero.w, _250);
    float4 _252 = _207;
    _252.w = _251;
    float _253 = abs(_251);
    bool _254 = _253 < 0.999000012874603271484375;
    float _255 = float(_254);
    float _256 = spvFMul(_214, _255);
    float4 _257 = _252;
    _257.z = _256;
    float _258 = _125.x;
    float _259 = _125.y;
    float _260 = _125.z;
    float4 _261 = float4(_258, _259, _260, 0.0);
    float _262 = _127.x;
    float _263 = _127.y;
    float _264 = _127.z;
    float4 _265 = float4(_262, _263, _264, 0.0);
    float _266 = _129.x;
    float _267 = _129.y;
    float _268 = _129.z;
    float4 _269 = float4(_266, _267, _268, 0.0);
    float _270 = _131.x;
    float _271 = _131.y;
    float _272 = _131.z;
    float4 _273 = float4(_270, _271, _272, 1.0);
    float4x4 _274 = float4x4(_261, _265, _269, _273);
    float4 _275 = spvFMulMatrixVector(_274, in.in_var_ATTRIBUTE0);
    float3 _276 = _275.xxx;
    float3 _277 = _275.yyy;
    float3 _278 = spvFMul(Primitive.Primitive_LocalToWorld[1].xyz, _277);
    float3 _279 = fma(Primitive.Primitive_LocalToWorld[0].xyz, _276, _278);
    float3 _280 = _275.zzz;
    float3 _281 = fma(Primitive.Primitive_LocalToWorld[2].xyz, _280, _279);
    float3 _282 = spvFAdd(Primitive.Primitive_LocalToWorld[3].xyz, View.View_PreViewTranslation);
    float3 _283 = spvFAdd(_281, _282);
    float _284 = _283.x;
    float _285 = _283.y;
    float _286 = _283.z;
    float4 _287 = float4(_284, _285, _286, 1.0);
    float4 _288 = _287 * _256;
    float3 _289 = _288.xyz;
    float4x4 _290 = spvFMulMatrixMatrix(Primitive.Primitive_LocalToWorld, _274);
    uint _293 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    float4 _299 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(((_293 * _135) + min(0u, (_293 - 1u)))));
    float3 _473;
    switch (0u)
    {
        default:
        {
            if (_256 < 1.0)
            {
                _473 = float3(0.0);
                break;
            }
            float3 _306 = spvFMulMatrixVector(_290, float4(0.0, 0.0, 0.0, 1.0)).xyz;
            float3 _307 = _306 - View.View_WorldCameraOrigin;
            float3 _311 = _307 / float3(sqrt(dot(_307, _307)));
            float _315 = dot(Primitive.Primitive_ObjectOrientation.xyz, _311);
            float3 _317 = _311 - (Primitive.Primitive_ObjectOrientation.xyz * _315);
            float3 _322 = _174[2];
            float _323 = dot(_317 / float3(sqrt(dot(_317, _317))), _322);
            float _338 = spvFMul(_315, _315);
            float _339 = spvFMul(_338, _338);
            float3 _345 = _289 - View.View_PreViewTranslation;
            float3 _346 = _345 - _306;
            float _390 = fast::min(fast::max((((spvFMulMatrixVector(Primitive.Primitive_WorldToLocal, float4(_345, 1.0)).xyz - Primitive.Primitive_LocalObjectBoundsMin) / (Primitive.Primitive_LocalObjectBoundsMax - Primitive.Primitive_LocalObjectBoundsMin)).z - Material.Material_ScalarExpressions[1].w) / Material.Material_ScalarExpressions[2].x, 0.0), 1.0);
            float _391 = spvFMul(_390, _390);
            float3 _405 = spvFAdd(float3(-0.5), Material_Texture2D_2.sample(Material_Texture2D_2Sampler, spvFAdd(_306 * Material.Material_ScalarExpressions[1].y, float3(-1.0, 0.0, 0.0) * (spvFMul(View.View_GameTime, Material.Material_ScalarExpressions[1].z) - spvFMul(Material.Material_ScalarExpressions[2].y, _391))).xy, level(-1.0)).xyz) * 2.0;
            float3 _411 = select(float4(1.0, 0.0, 0.0, 1.0), select(float4(1.0, 0.0, 0.0, 1.0), Material.Material_VectorExpressions[5], bool4(Material.Material_ScalarExpressions[0].w >= 9.9999999747524270787835121154785e-07)), bool4(abs(Material.Material_ScalarExpressions[0].w - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz;
            float3 _427 = spvFAdd(_346, spvFAdd(_411 * spvFMul(Material.Material_ScalarExpressions[2].z, spvFAdd(_405.z, 1.0)), spvFAdd(_411 * _405.x, (cross(_411, float3(0.0, 0.0, 1.0)) * Material.Material_ScalarExpressions[2].w) * _405.y) * Material.Material_ScalarExpressions[3].x) * _391);
            float _428 = dot(_427, _427);
            float3x3 _454 = float3x3(_290[0].xyz, _290[1].xyz, _290[2].xyz);
            float3 _456 = -spvFMulMatrixVector(_454, float3(1.0, 0.0, 0.0));
            float3 _460 = -spvFMulMatrixVector(_454, float3(0.0, 1.0, 0.0));
            float3 _464 = -spvFMulMatrixVector(_454, float3(0.0, 0.0, 1.0));
            _473 = select(_345 * (-1.0), spvFMul(spvFAdd(select(float4(0.0, 0.0, 0.0, 1.0), select(float4(0.0, 0.0, 0.0, 1.0), float4(_427 / float3(sqrt(_428)), 0.0), bool4(_428 >= 9.9999999747524270787835121154785e-07)), bool4(abs(_428 - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz * sqrt(dot(_346, _346)), _306) - _345, float3(sqrt(dot(_456, _456)), sqrt(dot(_460, _460)), sqrt(dot(_464, _464)))), bool3(fast::clamp(spvFAdd(mix(spvFMul(spvFMul(_323, _323), Material.Material_ScalarExpressions[0].z), spvFMulMatrixVector(float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz), _322).z, spvFMul(_339, _339)), 0.0199999995529651641845703125), 0.0, 1.0) >= 0.100000001490116119384765625));
            break;
        }
    }
    float3 _474 = spvFAdd(_289, _473);
    float4 _475 = float4(_474.x, _474.y, _474.z, _288.w);
    float4 _476 = spvFMulMatrixVector(View.View_TranslatedWorldToClip, _475);
    float3 _479 = spvFMulMatrixVector(_290, float4(0.0, 0.0, 0.0, 1.0)).xyz - View.View_WorldCameraOrigin;
    float3 _483 = _479 / float3(sqrt(dot(_479, _479)));
    float _487 = dot(Primitive.Primitive_ObjectOrientation.xyz, _483);
    float3 _489 = _483 - (Primitive.Primitive_ObjectOrientation.xyz * _487);
    float3 _494 = _174[2];
    float _495 = dot(_489 / float3(sqrt(dot(_489, _489))), _494);
    float _510 = spvFMul(_487, _487);
    float _511 = spvFMul(_510, _510);
    float2 _517 = float2(fast::clamp(spvFAdd(mix(spvFMul(spvFMul(_495, _495), Material.Material_ScalarExpressions[0].z), spvFMulMatrixVector(float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz), _494).z, spvFMul(_511, _511)), 0.0199999995529651641845703125), 0.0, 1.0));
    float4 _527 = float4(_494, spvFMul(_142, Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w));
    spvUnsafeArray<float4, 1> _528 = { float4(_299.x, _299.y, _517.x, _517.y) };
    out.out_var_TEXCOORD10_centroid = float4(_174[0], 0.0);
    out.out_var_TEXCOORD11_centroid = _527;
    out.out_var_TEXCOORD15 = _527;
    out.out_var_COLOR1 = _257;
    out_var_TEXCOORD0 = _528;
    out.out_var_TEXCOORD6 = _475;
    out.out_var_TEXCOORD7 = _289;
    out.gl_Position = _476;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

