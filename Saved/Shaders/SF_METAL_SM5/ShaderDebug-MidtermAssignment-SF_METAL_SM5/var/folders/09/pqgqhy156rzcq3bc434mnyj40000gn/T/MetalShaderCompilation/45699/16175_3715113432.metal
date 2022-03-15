

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

constant float3x3 _106 = {};
constant float4 _107 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD15 [[user(locn2)]];
    float4 out_var_COLOR1 [[user(locn3)]];
    float4 out_var_TEXCOORD0_0 [[user(locn4)]];
    float3 out_var_TEXCOORD9 [[user(locn5)]];
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

vertex Main_out Main_00003f2f_dd7021d8(Main_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_LocalVF& LocalVF [[buffer(6)]], constant type_Material& Material [[buffer(7)]], constant type_Globals& _Globals [[buffer(8)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceOriginBuffer [[texture(0)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceTransformBuffer [[texture(1)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(2)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(3)]], texture2d<float> Material_Texture2D_2 [[texture(4)]], sampler Material_Texture2D_2Sampler [[sampler(0)]], uint gl_InstanceIndex [[instance_id]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    uint _121 = (gl_InstanceIndex - gl_BaseInstance) + _Globals.InstanceOffset;
    uint _122 = 3u * _121;
    float4 _124 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_122));
    uint _125 = _122 + 1u;
    float4 _126 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_125));
    uint _127 = _122 + 2u;
    float4 _128 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_127));
    float4 _130 = InstanceVF_VertexFetch_InstanceOriginBuffer.read(uint(_121));
    uint _134 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _135 = 2u * _134;
    float4 _140 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_135 + 1u)));
    float _141 = _140.w;
    float3 _142 = _140.xyz;
    float3 _144 = cross(_142, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_135)).xyz) * _141;
    float3x3 _147 = _106;
    _147[0] = cross(_144, _142) * _141;
    float3x3 _148 = _147;
    _148[1] = _144;
    float3x3 _149 = _148;
    _149[2] = _142;
    float3x3 _163 = spvFMulMatrixMatrix(float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz), float3x3(_124.xyz, _126.xyz, _128.xyz));
    float3x3 _166 = _163;
    _166[0] = normalize(_163[0]);
    float3x3 _169 = _166;
    _169[1] = normalize(_163[1]);
    float3x3 _172 = _169;
    _172[2] = normalize(_163[2]);
    float3x3 _173 = spvFMulMatrixMatrix(_172, _149);
    float _177 = _124.w;
    float _178 = spvFMul(_177, 0.00390625);
    float _179 = trunc(_178);
    float _180 = _130.w;
    float4 _181 = _107;
    _181.x = _180;
    float3 _182 = _130.xyz;
    float3 _186 = spvFAdd(_182, _Globals.InstancingOffset.xyz);
    float3 _187 = _186.xxx;
    float3 _188 = _186.yyy;
    float3 _189 = spvFMul(Primitive.Primitive_LocalToWorld[1].xyz, _188);
    float3 _190 = fma(Primitive.Primitive_LocalToWorld[0].xyz, _187, _189);
    float3 _191 = _186.zzz;
    float3 _192 = fma(Primitive.Primitive_LocalToWorld[2].xyz, _191, _190);
    float3 _195 = spvFAdd(_192, Primitive.Primitive_LocalToWorld[3].xyz);
    float4 _206 = _181;
    _206.y = 1.0 - fast::clamp(spvFMul(length(spvFAdd(_195, View.View_PreViewTranslation)) - _Globals.InstancingFadeOutParams.x, _Globals.InstancingFadeOutParams.y), 0.0, 1.0);
    float _211 = 1.0 - _179;
    float _212 = spvFMul(_Globals.InstancingFadeOutParams.w, _211);
    float _213 = fma(_Globals.InstancingFadeOutParams.z, _179, _212);
    float3 _220 = _195 - _Globals.InstancingWorldViewOriginZero.xyz;
    float _221 = length(_220);
    float _222 = fma(_Globals.InstancingViewZCompareZero.w, _180, _221);
    float3 _226 = _195 - _Globals.InstancingWorldViewOriginOne.xyz;
    float _227 = length(_226);
    float _228 = fma(_Globals.InstancingViewZCompareZero.w, _180, _227);
    float3 _229 = float3(_222);
    bool3 _232 = _229 > _Globals.InstancingViewZCompareZero.xyz;
    float3 _233 = select(float3(0.0), float3(1.0), _232);
    float _237 = dot(_233, _Globals.InstancingViewZConstant.xyz);
    float3 _240 = float3(_228);
    bool3 _244 = _240 > _Globals.InstancingViewZCompareOne.xyz;
    float3 _245 = select(float3(0.0), float3(1.0), _244);
    float _246 = dot(_245, _Globals.InstancingViewZConstant.xyz);
    float _249 = spvFMul(_246, _Globals.InstancingWorldViewOriginOne.w);
    float _250 = fma(_237, _Globals.InstancingWorldViewOriginZero.w, _249);
    float4 _251 = _206;
    _251.w = _250;
    float _252 = abs(_250);
    bool _253 = _252 < 0.999000012874603271484375;
    float _254 = float(_253);
    float _255 = spvFMul(_213, _254);
    float4 _256 = _251;
    _256.z = _255;
    float _257 = _124.x;
    float _258 = _124.y;
    float _259 = _124.z;
    float4 _260 = float4(_257, _258, _259, 0.0);
    float _261 = _126.x;
    float _262 = _126.y;
    float _263 = _126.z;
    float4 _264 = float4(_261, _262, _263, 0.0);
    float _265 = _128.x;
    float _266 = _128.y;
    float _267 = _128.z;
    float4 _268 = float4(_265, _266, _267, 0.0);
    float _269 = _130.x;
    float _270 = _130.y;
    float _271 = _130.z;
    float4 _272 = float4(_269, _270, _271, 1.0);
    float4x4 _273 = float4x4(_260, _264, _268, _272);
    float4 _274 = spvFMulMatrixVector(_273, in.in_var_ATTRIBUTE0);
    float3 _275 = _274.xxx;
    float3 _276 = _274.yyy;
    float3 _277 = spvFMul(Primitive.Primitive_LocalToWorld[1].xyz, _276);
    float3 _278 = fma(Primitive.Primitive_LocalToWorld[0].xyz, _275, _277);
    float3 _279 = _274.zzz;
    float3 _280 = fma(Primitive.Primitive_LocalToWorld[2].xyz, _279, _278);
    float3 _281 = spvFAdd(Primitive.Primitive_LocalToWorld[3].xyz, View.View_PreViewTranslation);
    float3 _282 = spvFAdd(_280, _281);
    float _283 = _282.x;
    float _284 = _282.y;
    float _285 = _282.z;
    float4 _286 = float4(_283, _284, _285, 1.0);
    float4 _287 = _286 * _255;
    float3 _288 = _287.xyz;
    float4x4 _289 = spvFMulMatrixMatrix(Primitive.Primitive_LocalToWorld, _273);
    uint _292 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    float4 _298 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(((_292 * _134) + min(0u, (_292 - 1u)))));
    float3 _472;
    switch (0u)
    {
        default:
        {
            if (_255 < 1.0)
            {
                _472 = float3(0.0);
                break;
            }
            float3 _305 = spvFMulMatrixVector(_289, float4(0.0, 0.0, 0.0, 1.0)).xyz;
            float3 _306 = _305 - View.View_WorldCameraOrigin;
            float3 _310 = _306 / float3(sqrt(dot(_306, _306)));
            float _314 = dot(Primitive.Primitive_ObjectOrientation.xyz, _310);
            float3 _316 = _310 - (Primitive.Primitive_ObjectOrientation.xyz * _314);
            float3 _321 = _173[2];
            float _322 = dot(_316 / float3(sqrt(dot(_316, _316))), _321);
            float _337 = spvFMul(_314, _314);
            float _338 = spvFMul(_337, _337);
            float3 _344 = _288 - View.View_PreViewTranslation;
            float3 _345 = _344 - _305;
            float _389 = fast::min(fast::max((((spvFMulMatrixVector(Primitive.Primitive_WorldToLocal, float4(_344, 1.0)).xyz - Primitive.Primitive_LocalObjectBoundsMin) / (Primitive.Primitive_LocalObjectBoundsMax - Primitive.Primitive_LocalObjectBoundsMin)).z - Material.Material_ScalarExpressions[1].w) / Material.Material_ScalarExpressions[2].x, 0.0), 1.0);
            float _390 = spvFMul(_389, _389);
            float3 _404 = spvFAdd(float3(-0.5), Material_Texture2D_2.sample(Material_Texture2D_2Sampler, spvFAdd(_305 * Material.Material_ScalarExpressions[1].y, float3(-1.0, 0.0, 0.0) * (spvFMul(View.View_GameTime, Material.Material_ScalarExpressions[1].z) - spvFMul(Material.Material_ScalarExpressions[2].y, _390))).xy, level(-1.0)).xyz) * 2.0;
            float3 _410 = select(float4(1.0, 0.0, 0.0, 1.0), select(float4(1.0, 0.0, 0.0, 1.0), Material.Material_VectorExpressions[5], bool4(Material.Material_ScalarExpressions[0].w >= 9.9999999747524270787835121154785e-07)), bool4(abs(Material.Material_ScalarExpressions[0].w - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz;
            float3 _426 = spvFAdd(_345, spvFAdd(_410 * spvFMul(Material.Material_ScalarExpressions[2].z, spvFAdd(_404.z, 1.0)), spvFAdd(_410 * _404.x, (cross(_410, float3(0.0, 0.0, 1.0)) * Material.Material_ScalarExpressions[2].w) * _404.y) * Material.Material_ScalarExpressions[3].x) * _390);
            float _427 = dot(_426, _426);
            float3x3 _453 = float3x3(_289[0].xyz, _289[1].xyz, _289[2].xyz);
            float3 _455 = -spvFMulMatrixVector(_453, float3(1.0, 0.0, 0.0));
            float3 _459 = -spvFMulMatrixVector(_453, float3(0.0, 1.0, 0.0));
            float3 _463 = -spvFMulMatrixVector(_453, float3(0.0, 0.0, 1.0));
            _472 = select(_344 * (-1.0), spvFMul(spvFAdd(select(float4(0.0, 0.0, 0.0, 1.0), select(float4(0.0, 0.0, 0.0, 1.0), float4(_426 / float3(sqrt(_427)), 0.0), bool4(_427 >= 9.9999999747524270787835121154785e-07)), bool4(abs(_427 - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz * sqrt(dot(_345, _345)), _305) - _344, float3(sqrt(dot(_455, _455)), sqrt(dot(_459, _459)), sqrt(dot(_463, _463)))), bool3(fast::clamp(spvFAdd(mix(spvFMul(spvFMul(_322, _322), Material.Material_ScalarExpressions[0].z), spvFMulMatrixVector(float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz), _321).z, spvFMul(_338, _338)), 0.0199999995529651641845703125), 0.0, 1.0) >= 0.100000001490116119384765625));
            break;
        }
    }
    float3 _473 = spvFAdd(_288, _472);
    float4 _474 = float4(_473.x, _473.y, _473.z, _287.w);
    float4 _475 = spvFMulMatrixVector(View.View_TranslatedWorldToClip, _474);
    float3 _478 = spvFMulMatrixVector(_289, float4(0.0, 0.0, 0.0, 1.0)).xyz - View.View_WorldCameraOrigin;
    float3 _482 = _478 / float3(sqrt(dot(_478, _478)));
    float _486 = dot(Primitive.Primitive_ObjectOrientation.xyz, _482);
    float3 _488 = _482 - (Primitive.Primitive_ObjectOrientation.xyz * _486);
    float3 _493 = _173[2];
    float _494 = dot(_488 / float3(sqrt(dot(_488, _488))), _493);
    float _509 = spvFMul(_486, _486);
    float _510 = spvFMul(_509, _509);
    float2 _516 = float2(fast::clamp(spvFAdd(mix(spvFMul(spvFMul(_494, _494), Material.Material_ScalarExpressions[0].z), spvFMulMatrixVector(float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz), _493).z, spvFMul(_510, _510)), 0.0199999995529651641845703125), 0.0, 1.0));
    float4 _526 = float4(_493, spvFMul(_141, Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w));
    spvUnsafeArray<float4, 1> _527 = { float4(_298.x, _298.y, _516.x, _516.y) };
    out.out_var_TEXCOORD10_centroid = float4(_173[0], 0.0);
    out.out_var_TEXCOORD11_centroid = _526;
    out.out_var_TEXCOORD15 = _526;
    out.out_var_COLOR1 = _256;
    out_var_TEXCOORD0 = _527;
    out.out_var_TEXCOORD9 = _288;
    out.gl_Position = _475;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

