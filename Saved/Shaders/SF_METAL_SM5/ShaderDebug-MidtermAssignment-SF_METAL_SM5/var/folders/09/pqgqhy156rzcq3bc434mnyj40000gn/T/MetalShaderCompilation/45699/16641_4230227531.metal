

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
    char _m0_pad[1072];
    float3 View_WorldCameraOrigin;
    char _m1_pad[32];
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
    char _m3_pad[176];
    float4 Primitive_ObjectOrientation;
    char _m4_pad[16];
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
    uint LayerId;
};

constant float3x3 _116 = {};
constant float4 _117 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD15 [[user(locn2)]];
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

vertex Main_out Main_00004101_fc24264b(Main_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(6)]], constant type_LocalVF& LocalVF [[buffer(7)]], constant type_Material& Material [[buffer(8)]], constant type_Globals& _Globals [[buffer(9)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceOriginBuffer [[texture(0)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceTransformBuffer [[texture(1)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(2)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(3)]], texture2d<float> Material_Texture2D_2 [[texture(4)]], sampler Material_Texture2D_2Sampler [[sampler(0)]], uint gl_InstanceIndex [[instance_id]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    uint _129 = (gl_InstanceIndex - gl_BaseInstance) + _Globals.InstanceOffset;
    uint _130 = 3u * _129;
    float4 _132 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_130));
    uint _133 = _130 + 1u;
    float4 _134 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_133));
    uint _135 = _130 + 2u;
    float4 _136 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_135));
    float4 _138 = InstanceVF_VertexFetch_InstanceOriginBuffer.read(uint(_129));
    uint _142 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _143 = 2u * _142;
    float4 _148 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_143 + 1u)));
    float _149 = _148.w;
    float3 _150 = _148.xyz;
    float3 _152 = cross(_150, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_143)).xyz) * _149;
    float3x3 _155 = _116;
    _155[0] = cross(_152, _150) * _149;
    float3x3 _156 = _155;
    _156[1] = _152;
    float3x3 _157 = _156;
    _157[2] = _150;
    float3x3 _171 = spvFMulMatrixMatrix(float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz), float3x3(_132.xyz, _134.xyz, _136.xyz));
    float3x3 _174 = _171;
    _174[0] = normalize(_171[0]);
    float3x3 _177 = _174;
    _177[1] = normalize(_171[1]);
    float3x3 _180 = _177;
    _180[2] = normalize(_171[2]);
    float3x3 _181 = spvFMulMatrixMatrix(_180, _157);
    float _185 = _132.w;
    float _186 = spvFMul(_185, 0.00390625);
    float _187 = trunc(_186);
    float _188 = _138.w;
    float4 _189 = _117;
    _189.x = _188;
    float3 _190 = _138.xyz;
    float3 _194 = spvFAdd(_190, _Globals.InstancingOffset.xyz);
    float3 _195 = _194.xxx;
    float3 _196 = _194.yyy;
    float3 _197 = spvFMul(Primitive.Primitive_LocalToWorld[1].xyz, _196);
    float3 _198 = fma(Primitive.Primitive_LocalToWorld[0].xyz, _195, _197);
    float3 _199 = _194.zzz;
    float3 _200 = fma(Primitive.Primitive_LocalToWorld[2].xyz, _199, _198);
    float3 _203 = spvFAdd(_200, Primitive.Primitive_LocalToWorld[3].xyz);
    float4 _214 = _189;
    _214.y = 1.0 - fast::clamp(spvFMul(length(spvFAdd(_203, View.View_PreViewTranslation)) - _Globals.InstancingFadeOutParams.x, _Globals.InstancingFadeOutParams.y), 0.0, 1.0);
    float _219 = 1.0 - _187;
    float _220 = spvFMul(_Globals.InstancingFadeOutParams.w, _219);
    float _221 = fma(_Globals.InstancingFadeOutParams.z, _187, _220);
    float3 _228 = _203 - _Globals.InstancingWorldViewOriginZero.xyz;
    float _229 = length(_228);
    float _230 = fma(_Globals.InstancingViewZCompareZero.w, _188, _229);
    float3 _234 = _203 - _Globals.InstancingWorldViewOriginOne.xyz;
    float _235 = length(_234);
    float _236 = fma(_Globals.InstancingViewZCompareZero.w, _188, _235);
    float3 _237 = float3(_230);
    bool3 _240 = _237 > _Globals.InstancingViewZCompareZero.xyz;
    float3 _241 = select(float3(0.0), float3(1.0), _240);
    float _245 = dot(_241, _Globals.InstancingViewZConstant.xyz);
    float3 _248 = float3(_236);
    bool3 _252 = _248 > _Globals.InstancingViewZCompareOne.xyz;
    float3 _253 = select(float3(0.0), float3(1.0), _252);
    float _254 = dot(_253, _Globals.InstancingViewZConstant.xyz);
    float _257 = spvFMul(_254, _Globals.InstancingWorldViewOriginOne.w);
    float _258 = fma(_245, _Globals.InstancingWorldViewOriginZero.w, _257);
    float4 _259 = _214;
    _259.w = _258;
    float _260 = abs(_258);
    bool _261 = _260 < 0.999000012874603271484375;
    float _262 = float(_261);
    float _263 = spvFMul(_221, _262);
    float4 _264 = _259;
    _264.z = _263;
    float _265 = _132.x;
    float _266 = _132.y;
    float _267 = _132.z;
    float4 _268 = float4(_265, _266, _267, 0.0);
    float _269 = _134.x;
    float _270 = _134.y;
    float _271 = _134.z;
    float4 _272 = float4(_269, _270, _271, 0.0);
    float _273 = _136.x;
    float _274 = _136.y;
    float _275 = _136.z;
    float4 _276 = float4(_273, _274, _275, 0.0);
    float _277 = _138.x;
    float _278 = _138.y;
    float _279 = _138.z;
    float4 _280 = float4(_277, _278, _279, 1.0);
    float4x4 _281 = float4x4(_268, _272, _276, _280);
    float4 _282 = spvFMulMatrixVector(_281, in.in_var_ATTRIBUTE0);
    float3 _283 = _282.xxx;
    float3 _284 = _282.yyy;
    float3 _285 = spvFMul(Primitive.Primitive_LocalToWorld[1].xyz, _284);
    float3 _286 = fma(Primitive.Primitive_LocalToWorld[0].xyz, _283, _285);
    float3 _287 = _282.zzz;
    float3 _288 = fma(Primitive.Primitive_LocalToWorld[2].xyz, _287, _286);
    float3 _289 = spvFAdd(Primitive.Primitive_LocalToWorld[3].xyz, View.View_PreViewTranslation);
    float3 _290 = spvFAdd(_288, _289);
    float _291 = _290.x;
    float _292 = _290.y;
    float _293 = _290.z;
    float4 _294 = float4(_291, _292, _293, 1.0);
    float4 _295 = _294 * _263;
    float3 _296 = _295.xyz;
    float4x4 _297 = spvFMulMatrixMatrix(Primitive.Primitive_LocalToWorld, _281);
    uint _300 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    float4 _306 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(((_300 * _142) + min(0u, (_300 - 1u)))));
    float3 _307 = _181[2];
    float3 _480;
    switch (0u)
    {
        default:
        {
            if (_263 < 1.0)
            {
                _480 = float3(0.0);
                break;
            }
            float3 _314 = spvFMulMatrixVector(_297, float4(0.0, 0.0, 0.0, 1.0)).xyz;
            float3 _315 = _314 - View.View_WorldCameraOrigin;
            float3 _319 = _315 / float3(sqrt(dot(_315, _315)));
            float _323 = dot(Primitive.Primitive_ObjectOrientation.xyz, _319);
            float3 _325 = _319 - (Primitive.Primitive_ObjectOrientation.xyz * _323);
            float _330 = dot(_325 / float3(sqrt(dot(_325, _325))), _307);
            float _345 = spvFMul(_323, _323);
            float _346 = spvFMul(_345, _345);
            float3 _352 = _296 - View.View_PreViewTranslation;
            float3 _353 = _352 - _314;
            float _397 = fast::min(fast::max((((spvFMulMatrixVector(Primitive.Primitive_WorldToLocal, float4(_352, 1.0)).xyz - Primitive.Primitive_LocalObjectBoundsMin) / (Primitive.Primitive_LocalObjectBoundsMax - Primitive.Primitive_LocalObjectBoundsMin)).z - Material.Material_ScalarExpressions[1].w) / Material.Material_ScalarExpressions[2].x, 0.0), 1.0);
            float _398 = spvFMul(_397, _397);
            float3 _412 = spvFAdd(float3(-0.5), Material_Texture2D_2.sample(Material_Texture2D_2Sampler, spvFAdd(_314 * Material.Material_ScalarExpressions[1].y, float3(-1.0, 0.0, 0.0) * (spvFMul(View.View_GameTime, Material.Material_ScalarExpressions[1].z) - spvFMul(Material.Material_ScalarExpressions[2].y, _398))).xy, level(-1.0)).xyz) * 2.0;
            float3 _418 = select(float4(1.0, 0.0, 0.0, 1.0), select(float4(1.0, 0.0, 0.0, 1.0), Material.Material_VectorExpressions[5], bool4(Material.Material_ScalarExpressions[0].w >= 9.9999999747524270787835121154785e-07)), bool4(abs(Material.Material_ScalarExpressions[0].w - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz;
            float3 _434 = spvFAdd(_353, spvFAdd(_418 * spvFMul(Material.Material_ScalarExpressions[2].z, spvFAdd(_412.z, 1.0)), spvFAdd(_418 * _412.x, (cross(_418, float3(0.0, 0.0, 1.0)) * Material.Material_ScalarExpressions[2].w) * _412.y) * Material.Material_ScalarExpressions[3].x) * _398);
            float _435 = dot(_434, _434);
            float3x3 _461 = float3x3(_297[0].xyz, _297[1].xyz, _297[2].xyz);
            float3 _463 = -spvFMulMatrixVector(_461, float3(1.0, 0.0, 0.0));
            float3 _467 = -spvFMulMatrixVector(_461, float3(0.0, 1.0, 0.0));
            float3 _471 = -spvFMulMatrixVector(_461, float3(0.0, 0.0, 1.0));
            _480 = select(_352 * (-1.0), spvFMul(spvFAdd(select(float4(0.0, 0.0, 0.0, 1.0), select(float4(0.0, 0.0, 0.0, 1.0), float4(_434 / float3(sqrt(_435)), 0.0), bool4(_435 >= 9.9999999747524270787835121154785e-07)), bool4(abs(_435 - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz * sqrt(dot(_353, _353)), _314) - _352, float3(sqrt(dot(_463, _463)), sqrt(dot(_467, _467)), sqrt(dot(_471, _471)))), bool3(fast::clamp(spvFAdd(mix(spvFMul(spvFMul(_330, _330), Material.Material_ScalarExpressions[0].z), spvFMulMatrixVector(float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz), _307).z, spvFMul(_346, _346)), 0.0199999995529651641845703125), 0.0, 1.0) >= 0.100000001490116119384765625));
            break;
        }
    }
    float3 _481 = spvFAdd(_296, _480);
    float4 _482 = float4(_481.x, _481.y, _481.z, _295.w);
    float3 _485 = spvFMulMatrixVector(_297, float4(0.0, 0.0, 0.0, 1.0)).xyz - View.View_WorldCameraOrigin;
    float3 _489 = _485 / float3(sqrt(dot(_485, _485)));
    float _493 = dot(Primitive.Primitive_ObjectOrientation.xyz, _489);
    float3 _495 = _489 - (Primitive.Primitive_ObjectOrientation.xyz * _493);
    float _500 = dot(_495 / float3(sqrt(dot(_495, _495))), _307);
    float _515 = spvFMul(_493, _493);
    float _516 = spvFMul(_515, _515);
    float2 _522 = float2(fast::clamp(spvFAdd(mix(spvFMul(spvFMul(_500, _500), Material.Material_ScalarExpressions[0].z), spvFMulMatrixVector(float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz), _307).z, spvFMul(_516, _516)), 0.0199999995529651641845703125), 0.0, 1.0));
    float4 _532 = float4(_307, spvFMul(_149, Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w));
    spvUnsafeArray<float4, 1> _533 = { float4(_306.x, _306.y, _522.x, _522.y) };
    float4 _539 = spvFMulMatrixVector(ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId], _482);
    out.out_var_TEXCOORD10_centroid = float4(_181[0], 0.0);
    out.out_var_TEXCOORD11_centroid = _532;
    out.out_var_TEXCOORD15 = _532;
    out.out_var_COLOR1 = _264;
    out_var_TEXCOORD0 = _533;
    out.out_var_TEXCOORD7 = _481.xyz;
    out.out_var_TEXCOORD6 = _539;
    out.out_var_TEXCOORD8 = _307;
    out.gl_Layer = _Globals.LayerId;
    out.gl_Position = _539;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

