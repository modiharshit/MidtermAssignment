

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

constant float3x3 _118 = {};
constant float4 _119 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_COLOR0 [[user(locn2)]];
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

vertex Main_out Main_00004407_ea2c41ea(Main_in in [[stage_in]], constant type_View& View [[buffer(5)]], constant type_Primitive& Primitive [[buffer(6)]], constant type_LocalVF& LocalVF [[buffer(7)]], constant type_Material& Material [[buffer(8)]], constant type_Globals& _Globals [[buffer(9)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceOriginBuffer [[texture(0)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceTransformBuffer [[texture(1)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(2)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(3)]], texture_buffer<float> LocalVF_VertexFetch_ColorComponentsBuffer [[texture(4)]], texture2d<float> Material_Texture2D_2 [[texture(5)]], sampler Material_Texture2D_2Sampler [[sampler(0)]], uint gl_InstanceIndex [[instance_id]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    uint _133 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _143 = (gl_InstanceIndex - gl_BaseInstance) + _Globals.InstanceOffset;
    uint _144 = 3u * _143;
    float4 _146 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_144));
    uint _147 = _144 + 1u;
    float4 _148 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_147));
    uint _149 = _144 + 2u;
    float4 _150 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_149));
    float4 _152 = InstanceVF_VertexFetch_InstanceOriginBuffer.read(uint(_143));
    uint _153 = 2u * _133;
    float4 _158 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_153 + 1u)));
    float _159 = _158.w;
    float3 _160 = _158.xyz;
    float3 _162 = cross(_160, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_153)).xyz) * _159;
    float3x3 _165 = _118;
    _165[0] = cross(_162, _160) * _159;
    float3x3 _166 = _165;
    _166[1] = _162;
    float3x3 _167 = _166;
    _167[2] = _160;
    float3x3 _181 = spvFMulMatrixMatrix(float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz), float3x3(_146.xyz, _148.xyz, _150.xyz));
    float3x3 _184 = _181;
    _184[0] = normalize(_181[0]);
    float3x3 _187 = _184;
    _187[1] = normalize(_181[1]);
    float3x3 _190 = _187;
    _190[2] = normalize(_181[2]);
    float3x3 _191 = spvFMulMatrixMatrix(_190, _167);
    float _195 = _146.w;
    float _196 = spvFMul(_195, 0.00390625);
    float _197 = trunc(_196);
    float _198 = _152.w;
    float4 _199 = _119;
    _199.x = _198;
    float3 _200 = _152.xyz;
    float3 _204 = spvFAdd(_200, _Globals.InstancingOffset.xyz);
    float3 _205 = _204.xxx;
    float3 _206 = _204.yyy;
    float3 _207 = spvFMul(Primitive.Primitive_LocalToWorld[1].xyz, _206);
    float3 _208 = fma(Primitive.Primitive_LocalToWorld[0].xyz, _205, _207);
    float3 _209 = _204.zzz;
    float3 _210 = fma(Primitive.Primitive_LocalToWorld[2].xyz, _209, _208);
    float3 _213 = spvFAdd(_210, Primitive.Primitive_LocalToWorld[3].xyz);
    float4 _224 = _199;
    _224.y = 1.0 - fast::clamp(spvFMul(length(spvFAdd(_213, View.View_PreViewTranslation)) - _Globals.InstancingFadeOutParams.x, _Globals.InstancingFadeOutParams.y), 0.0, 1.0);
    float _229 = 1.0 - _197;
    float _230 = spvFMul(_Globals.InstancingFadeOutParams.w, _229);
    float _231 = fma(_Globals.InstancingFadeOutParams.z, _197, _230);
    float3 _238 = _213 - _Globals.InstancingWorldViewOriginZero.xyz;
    float _239 = length(_238);
    float _240 = fma(_Globals.InstancingViewZCompareZero.w, _198, _239);
    float3 _244 = _213 - _Globals.InstancingWorldViewOriginOne.xyz;
    float _245 = length(_244);
    float _246 = fma(_Globals.InstancingViewZCompareZero.w, _198, _245);
    float3 _247 = float3(_240);
    bool3 _250 = _247 > _Globals.InstancingViewZCompareZero.xyz;
    float3 _251 = select(float3(0.0), float3(1.0), _250);
    float _255 = dot(_251, _Globals.InstancingViewZConstant.xyz);
    float3 _258 = float3(_246);
    bool3 _262 = _258 > _Globals.InstancingViewZCompareOne.xyz;
    float3 _263 = select(float3(0.0), float3(1.0), _262);
    float _264 = dot(_263, _Globals.InstancingViewZConstant.xyz);
    float _267 = spvFMul(_264, _Globals.InstancingWorldViewOriginOne.w);
    float _268 = fma(_255, _Globals.InstancingWorldViewOriginZero.w, _267);
    float4 _269 = _224;
    _269.w = _268;
    float _270 = abs(_268);
    bool _271 = _270 < 0.999000012874603271484375;
    float _272 = float(_271);
    float _273 = spvFMul(_231, _272);
    float4 _274 = _269;
    _274.z = _273;
    float _275 = _146.x;
    float _276 = _146.y;
    float _277 = _146.z;
    float4 _278 = float4(_275, _276, _277, 0.0);
    float _279 = _148.x;
    float _280 = _148.y;
    float _281 = _148.z;
    float4 _282 = float4(_279, _280, _281, 0.0);
    float _283 = _150.x;
    float _284 = _150.y;
    float _285 = _150.z;
    float4 _286 = float4(_283, _284, _285, 0.0);
    float _287 = _152.x;
    float _288 = _152.y;
    float _289 = _152.z;
    float4 _290 = float4(_287, _288, _289, 1.0);
    float4x4 _291 = float4x4(_278, _282, _286, _290);
    float4 _292 = spvFMulMatrixVector(_291, in.in_var_ATTRIBUTE0);
    float3 _293 = _292.xxx;
    float3 _294 = _292.yyy;
    float3 _295 = spvFMul(Primitive.Primitive_LocalToWorld[1].xyz, _294);
    float3 _296 = fma(Primitive.Primitive_LocalToWorld[0].xyz, _293, _295);
    float3 _297 = _292.zzz;
    float3 _298 = fma(Primitive.Primitive_LocalToWorld[2].xyz, _297, _296);
    float3 _299 = spvFAdd(Primitive.Primitive_LocalToWorld[3].xyz, View.View_PreViewTranslation);
    float3 _300 = spvFAdd(_298, _299);
    float _301 = _300.x;
    float _302 = _300.y;
    float _303 = _300.z;
    float4 _304 = float4(_301, _302, _303, 1.0);
    float4 _305 = _304 * _273;
    float3 _306 = _305.xyz;
    float4x4 _307 = spvFMulMatrixMatrix(Primitive.Primitive_LocalToWorld, _291);
    uint _310 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    uint _311 = _310 - 1u;
    uint _313 = _310 * _133;
    float4 _316 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_313 + min(0u, _311))));
    float4 _319 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_313 + min(1u, _311))));
    float4 _322 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_313 + min(2u, _311))));
    float3 _593;
    switch (0u)
    {
        default:
        {
            if (_273 < 1.0)
            {
                _593 = float3(0.0);
                break;
            }
            float3 _341 = spvFMulMatrixVector(_307, float4(0.0, 0.0, 0.0, 1.0)).xyz;
            float3 _342 = _306 - View.View_PreViewTranslation;
            float3 _349 = _341 * Material.Material_ScalarExpressions[1].x;
            float _358 = _322.y;
            float3 _370 = spvFAdd(Material_Texture2D_2.sample(Material_Texture2D_2Sampler, spvFAdd(spvFAdd((_342 - _341) * Material.Material_ScalarExpressions[0].w, _349), float3(1.0, 0.0, 0.0) * (spvFMul(View.View_GameTime, Material.Material_ScalarExpressions[1].y) - spvFMul(Material.Material_ScalarExpressions[1].z, _358))).xy, level(-1.0)).xyz, float3(-0.25, -0.5, -0.5)) * 2.0;
            float3 _375 = select(float4(1.0, 0.0, 0.0, 1.0), select(float4(1.0, 0.0, 0.0, 1.0), Material.Material_VectorExpressions[5], bool4(Material.Material_ScalarExpressions[0].y >= 9.9999999747524270787835121154785e-07)), bool4(abs(Material.Material_ScalarExpressions[0].y - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz;
            float3x3 _397 = float3x3(_307[0].xyz, _307[1].xyz, _307[2].xyz);
            float3 _398 = spvFMulMatrixVector(_397, spvFAdd(float3(-0.5), fract(spvFMul(float3(_319.y), float3(0.0625, 1.0, 16.0)))) * 2.0);
            float _401 = _322.x;
            float3 _404 = float3(1.0) - (_398 * spvFMul(Material.Material_ScalarExpressions[2].y, _401));
            float3 _405 = spvFAdd(_342, spvFAdd(_375 * spvFMul(Material.Material_ScalarExpressions[1].w, _370.x), float3(0.0, 0.0, 1.0) * spvFMul(_370.y, Material.Material_ScalarExpressions[2].x)) * _358) - _404;
            float _412 = dot(_375, _398 / float3(sqrt(dot(_398, _398))));
            float3 _415 = spvFAdd(_375, float3(0.0, 0.0, 1.0) * spvFMul(_412, _412));
            float3 _419 = _415 / float3(sqrt(dot(_415, _415)));
            float _420 = _319.x;
            float _423 = floor(spvFMul(_420, 7.111111164093017578125));
            float _425 = spvFMul(_420, 256.0) - spvFMul(_423, 36.0);
            float _427 = floor(spvFMul(_425, 0.16666667163372039794921875));
            float3 _455 = spvFAdd(float3(-0.5), Material_Texture2D_2.sample(Material_Texture2D_2Sampler, spvFAdd(spvFAdd(spvFMul(spvFMul(float3(_425 - spvFMul(_427, 6.0), _427, _423), float3(0.20000000298023223876953125, 0.20000000298023223876953125, 0.16666667163372039794921875)), Primitive.Primitive_ObjectBounds) * Material.Material_ScalarExpressions[2].z, float3(1.0)), float3(-1.0, 0.0, 0.0) * (fma(View.View_GameTime, Material.Material_ScalarExpressions[2].w, fract(dot(_349, _349))) - spvFMul(Material.Material_ScalarExpressions[3].x, _401))).xy, level(-1.0)).xyz) * 2.0;
            float3 _475 = spvFAdd(_405, spvFAdd(_419 * spvFMul(Material.Material_ScalarExpressions[3].y, spvFAdd(_455.z, 1.0)), spvFAdd(_419 * _455.x, Material.Material_VectorExpressions[6].xyz * _455.y) * Material.Material_ScalarExpressions[3].w) * _401);
            float _476 = dot(_475, _475);
            float3 _495 = spvFAdd(select(float4(0.0, 0.0, 0.0, 1.0), select(float4(0.0, 0.0, 0.0, 1.0), float4(_475 / float3(sqrt(_476)), 0.0), bool4(_476 >= 9.9999999747524270787835121154785e-07)), bool4(abs(_476 - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz * sqrt(dot(_405, _405)), _404) - _341;
            float _524 = fast::min(fast::max((((spvFMulMatrixVector(Primitive.Primitive_WorldToLocal, float4(_342, 1.0)).xyz - Primitive.Primitive_LocalObjectBoundsMin) / (Primitive.Primitive_LocalObjectBoundsMax - Primitive.Primitive_LocalObjectBoundsMin)).z - Material.Material_ScalarExpressions[4].y) / Material.Material_ScalarExpressions[4].z, 0.0), 1.0);
            float _525 = spvFMul(_524, _524);
            float3 _537 = spvFAdd(float3(-0.5), Material_Texture2D_2.sample(Material_Texture2D_2Sampler, spvFAdd(_349, float3(-1.0, 0.0, 0.0) * (spvFMul(View.View_GameTime, Material.Material_ScalarExpressions[4].x) - spvFMul(Material.Material_ScalarExpressions[4].w, _525))).xy, level(-1.0)).xyz) * 2.0;
            float3 _558 = spvFAdd(_495, spvFAdd(_375 * spvFMul(Material.Material_ScalarExpressions[5].x, spvFAdd(_537.z, 1.0)), spvFAdd(_375 * _537.x, (cross(_375, float3(0.0, 0.0, 1.0)) * Material.Material_ScalarExpressions[5].y) * _537.y) * Material.Material_ScalarExpressions[5].z) * _525);
            float _559 = dot(_558, _558);
            float3 _580 = -spvFMulMatrixVector(_397, float3(1.0, 0.0, 0.0));
            float3 _584 = -spvFMulMatrixVector(_397, float3(0.0, 1.0, 0.0));
            float3 _588 = -spvFMulMatrixVector(_397, float3(0.0, 0.0, 1.0));
            _593 = spvFMul(spvFAdd(select(float4(0.0, 0.0, 0.0, 1.0), select(float4(0.0, 0.0, 0.0, 1.0), float4(_558 / float3(sqrt(_559)), 0.0), bool4(_559 >= 9.9999999747524270787835121154785e-07)), bool4(abs(_559 - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz * sqrt(dot(_495, _495)), _341) - _342, float3(sqrt(dot(_580, _580)), sqrt(dot(_584, _584)), sqrt(dot(_588, _588))));
            break;
        }
    }
    float3 _594 = spvFAdd(_306, _593);
    float4 _595 = float4(_594.x, _594.y, _594.z, _305.w);
    float4 _596 = spvFMulMatrixVector(View.View_TranslatedWorldToClip, _595);
    spvUnsafeArray<float4, 1> _608 = { float4(_316.x, _316.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_191[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_191[2], spvFMul(_159, Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w));
    out.out_var_COLOR0 = LocalVF_VertexFetch_ColorComponentsBuffer.read(uint((_133 & uint(LocalVF.LocalVF_VertexFetch_Parameters.x)))).zyxw;
    out.out_var_COLOR1 = _274;
    out_var_TEXCOORD0 = _608;
    out.out_var_TEXCOORD9 = _306;
    out.gl_Position = _596;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

