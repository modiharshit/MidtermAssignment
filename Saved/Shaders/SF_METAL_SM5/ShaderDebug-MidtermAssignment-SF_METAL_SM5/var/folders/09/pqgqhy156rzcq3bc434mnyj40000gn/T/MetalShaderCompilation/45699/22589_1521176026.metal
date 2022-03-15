

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

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
    float4 Primitive_InvNonUniformScaleAndDeterminantSign;
    char _m2_pad[16];
    float4x4 Primitive_WorldToLocal;
    float4x4 Primitive_PreviousLocalToWorld;
    float4x4 Primitive_PreviousWorldToLocal;
    char _m5_pad[16];
    float3 Primitive_ObjectBounds;
    char _m6_pad[48];
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

constant float3x3 _119 = {};
constant float4 _120 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float4 out_var_TEXCOORD7 [[user(locn1)]];
    float4 out_var_TEXCOORD10_centroid [[user(locn2)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn3)]];
    float4 out_var_COLOR0 [[user(locn4)]];
    float4 out_var_COLOR1 [[user(locn5)]];
    float4 out_var_TEXCOORD0_0 [[user(locn6)]];
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

vertex MainVertexShader_out Main_0000583d_5aab4dda(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(5)]], constant type_Primitive& Primitive [[buffer(6)]], constant type_LocalVF& LocalVF [[buffer(7)]], constant type_Material& Material [[buffer(8)]], constant type_Globals& _Globals [[buffer(9)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceOriginBuffer [[texture(0)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceTransformBuffer [[texture(1)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(2)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(3)]], texture_buffer<float> LocalVF_VertexFetch_ColorComponentsBuffer [[texture(4)]], texture2d<float> Material_Texture2D_2 [[texture(5)]], sampler Material_Texture2D_2Sampler [[sampler(0)]], uint gl_InstanceIndex [[instance_id]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    bool _330;
    uint _138 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _148 = (gl_InstanceIndex - gl_BaseInstance) + _Globals.InstanceOffset;
    uint _149 = 3u * _148;
    float4 _151 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_149));
    float4 _153 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint((_149 + 1u)));
    float4 _155 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint((_149 + 2u)));
    float4 _157 = InstanceVF_VertexFetch_InstanceOriginBuffer.read(uint(_148));
    uint _158 = 2u * _138;
    float4 _163 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_158 + 1u)));
    float _164 = _163.w;
    float3 _165 = _163.xyz;
    float3 _167 = cross(_165, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_158)).xyz) * _164;
    float3x3 _170 = _119;
    _170[0] = cross(_167, _165) * _164;
    float3x3 _171 = _170;
    _171[1] = _167;
    float3x3 _172 = _171;
    _172[2] = _165;
    float3x3 _186 = spvFMulMatrixMatrix(float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz), float3x3(_151.xyz, _153.xyz, _155.xyz));
    float3x3 _189 = _186;
    _189[0] = normalize(_186[0]);
    float3x3 _192 = _189;
    _192[1] = normalize(_186[1]);
    float3x3 _195 = _192;
    _195[2] = normalize(_186[2]);
    float3x3 _196 = spvFMulMatrixMatrix(_195, _172);
    float _202 = trunc(spvFMul(_151.w, 0.00390625));
    float _203 = _157.w;
    float4 _204 = _120;
    _204.x = _203;
    float3 _209 = spvFAdd(_157.xyz, _Globals.InstancingOffset.xyz);
    float3 _218 = spvFAdd(fma(Primitive.Primitive_LocalToWorld[2].xyz, _209.zzz, fma(Primitive.Primitive_LocalToWorld[0].xyz, _209.xxx, spvFMul(Primitive.Primitive_LocalToWorld[1].xyz, _209.yyy))), Primitive.Primitive_LocalToWorld[3].xyz);
    float4 _229 = _204;
    _229.y = 1.0 - fast::clamp(spvFMul(length(spvFAdd(_218, View.View_PreViewTranslation)) - _Globals.InstancingFadeOutParams.x, _Globals.InstancingFadeOutParams.y), 0.0, 1.0);
    float _273 = fma(dot(select(float3(0.0), float3(1.0), float3(fma(_Globals.InstancingViewZCompareZero.w, _203, length(_218 - _Globals.InstancingWorldViewOriginZero.xyz))) > _Globals.InstancingViewZCompareZero.xyz), _Globals.InstancingViewZConstant.xyz), _Globals.InstancingWorldViewOriginZero.w, spvFMul(dot(select(float3(0.0), float3(1.0), float3(fma(_Globals.InstancingViewZCompareZero.w, _203, length(_218 - _Globals.InstancingWorldViewOriginOne.xyz))) > _Globals.InstancingViewZCompareOne.xyz), _Globals.InstancingViewZConstant.xyz), _Globals.InstancingWorldViewOriginOne.w));
    float4 _274 = _229;
    _274.w = _273;
    float _278 = spvFMul(fma(_Globals.InstancingFadeOutParams.z, _202, spvFMul(_Globals.InstancingFadeOutParams.w, 1.0 - _202)), float(abs(_273) < 0.999000012874603271484375));
    float4 _279 = _274;
    _279.z = _278;
    float4x4 _296 = float4x4(float4(_151.xyz, 0.0), float4(_153.xyz, 0.0), float4(_155.xyz, 0.0), float4(_157.xyz, 1.0));
    float4 _297 = spvFMulMatrixVector(_296, in.in_var_ATTRIBUTE0);
    float3 _311 = (float4(spvFAdd(fma(Primitive.Primitive_LocalToWorld[2].xyz, _297.zzz, fma(Primitive.Primitive_LocalToWorld[0].xyz, _297.xxx, spvFMul(Primitive.Primitive_LocalToWorld[1].xyz, _297.yyy))), spvFAdd(Primitive.Primitive_LocalToWorld[3].xyz, View.View_PreViewTranslation)), 1.0) * _278).xyz;
    float4x4 _312 = spvFMulMatrixMatrix(Primitive.Primitive_LocalToWorld, _296);
    uint _315 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    uint _316 = _315 - 1u;
    uint _318 = _315 * _138;
    float4 _321 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_318 + min(0u, _316))));
    uint _323 = _318 + min(1u, _316);
    float4 _324 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(_323));
    uint _326 = _318 + min(2u, _316);
    float4 _327 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(_326));
    float3 _598;
    switch (0u)
    {
        default:
        {
            _330 = _278 < 1.0;
            if (_330)
            {
                _598 = float3(0.0);
                break;
            }
            float3 _346 = spvFMulMatrixVector(_312, float4(0.0, 0.0, 0.0, 1.0)).xyz;
            float3 _347 = _311 - View.View_PreViewTranslation;
            float3 _354 = _346 * Material.Material_ScalarExpressions[1].x;
            float _363 = _327.y;
            float3 _375 = spvFAdd(Material_Texture2D_2.sample(Material_Texture2D_2Sampler, spvFAdd(spvFAdd((_347 - _346) * Material.Material_ScalarExpressions[0].w, _354), float3(1.0, 0.0, 0.0) * (spvFMul(View.View_GameTime, Material.Material_ScalarExpressions[1].y) - spvFMul(Material.Material_ScalarExpressions[1].z, _363))).xy, level(-1.0)).xyz, float3(-0.25, -0.5, -0.5)) * 2.0;
            float3 _380 = select(float4(1.0, 0.0, 0.0, 1.0), select(float4(1.0, 0.0, 0.0, 1.0), Material.Material_VectorExpressions[5], bool4(Material.Material_ScalarExpressions[0].y >= 9.9999999747524270787835121154785e-07)), bool4(abs(Material.Material_ScalarExpressions[0].y - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz;
            float3x3 _402 = float3x3(_312[0].xyz, _312[1].xyz, _312[2].xyz);
            float3 _403 = spvFMulMatrixVector(_402, spvFAdd(float3(-0.5), fract(spvFMul(float3(_324.y), float3(0.0625, 1.0, 16.0)))) * 2.0);
            float _406 = _327.x;
            float3 _409 = float3(1.0) - (_403 * spvFMul(Material.Material_ScalarExpressions[2].y, _406));
            float3 _410 = spvFAdd(_347, spvFAdd(_380 * spvFMul(Material.Material_ScalarExpressions[1].w, _375.x), float3(0.0, 0.0, 1.0) * spvFMul(_375.y, Material.Material_ScalarExpressions[2].x)) * _363) - _409;
            float _417 = dot(_380, _403 / float3(sqrt(dot(_403, _403))));
            float3 _420 = spvFAdd(_380, float3(0.0, 0.0, 1.0) * spvFMul(_417, _417));
            float3 _424 = _420 / float3(sqrt(dot(_420, _420)));
            float _425 = _324.x;
            float _428 = floor(spvFMul(_425, 7.111111164093017578125));
            float _430 = spvFMul(_425, 256.0) - spvFMul(_428, 36.0);
            float _432 = floor(spvFMul(_430, 0.16666667163372039794921875));
            float3 _460 = spvFAdd(float3(-0.5), Material_Texture2D_2.sample(Material_Texture2D_2Sampler, spvFAdd(spvFAdd(spvFMul(spvFMul(float3(_430 - spvFMul(_432, 6.0), _432, _428), float3(0.20000000298023223876953125, 0.20000000298023223876953125, 0.16666667163372039794921875)), Primitive.Primitive_ObjectBounds) * Material.Material_ScalarExpressions[2].z, float3(1.0)), float3(-1.0, 0.0, 0.0) * (fma(View.View_GameTime, Material.Material_ScalarExpressions[2].w, fract(dot(_354, _354))) - spvFMul(Material.Material_ScalarExpressions[3].x, _406))).xy, level(-1.0)).xyz) * 2.0;
            float3 _480 = spvFAdd(_410, spvFAdd(_424 * spvFMul(Material.Material_ScalarExpressions[3].y, spvFAdd(_460.z, 1.0)), spvFAdd(_424 * _460.x, Material.Material_VectorExpressions[6].xyz * _460.y) * Material.Material_ScalarExpressions[3].w) * _406);
            float _481 = dot(_480, _480);
            float3 _500 = spvFAdd(select(float4(0.0, 0.0, 0.0, 1.0), select(float4(0.0, 0.0, 0.0, 1.0), float4(_480 / float3(sqrt(_481)), 0.0), bool4(_481 >= 9.9999999747524270787835121154785e-07)), bool4(abs(_481 - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz * sqrt(dot(_410, _410)), _409) - _346;
            float _529 = fast::min(fast::max((((spvFMulMatrixVector(Primitive.Primitive_WorldToLocal, float4(_347, 1.0)).xyz - Primitive.Primitive_LocalObjectBoundsMin) / (Primitive.Primitive_LocalObjectBoundsMax - Primitive.Primitive_LocalObjectBoundsMin)).z - Material.Material_ScalarExpressions[4].y) / Material.Material_ScalarExpressions[4].z, 0.0), 1.0);
            float _530 = spvFMul(_529, _529);
            float3 _542 = spvFAdd(float3(-0.5), Material_Texture2D_2.sample(Material_Texture2D_2Sampler, spvFAdd(_354, float3(-1.0, 0.0, 0.0) * (spvFMul(View.View_GameTime, Material.Material_ScalarExpressions[4].x) - spvFMul(Material.Material_ScalarExpressions[4].w, _530))).xy, level(-1.0)).xyz) * 2.0;
            float3 _563 = spvFAdd(_500, spvFAdd(_380 * spvFMul(Material.Material_ScalarExpressions[5].x, spvFAdd(_542.z, 1.0)), spvFAdd(_380 * _542.x, (cross(_380, float3(0.0, 0.0, 1.0)) * Material.Material_ScalarExpressions[5].y) * _542.y) * Material.Material_ScalarExpressions[5].z) * _530);
            float _564 = dot(_563, _563);
            float3 _585 = -spvFMulMatrixVector(_402, float3(1.0, 0.0, 0.0));
            float3 _589 = -spvFMulMatrixVector(_402, float3(0.0, 1.0, 0.0));
            float3 _593 = -spvFMulMatrixVector(_402, float3(0.0, 0.0, 1.0));
            _598 = spvFMul(spvFAdd(select(float4(0.0, 0.0, 0.0, 1.0), select(float4(0.0, 0.0, 0.0, 1.0), float4(_563 / float3(sqrt(_564)), 0.0), bool4(_564 >= 9.9999999747524270787835121154785e-07)), bool4(abs(_564 - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz * sqrt(dot(_500, _500)), _346) - _347, float3(sqrt(dot(_585, _585)), sqrt(dot(_589, _589)), sqrt(dot(_593, _593))));
            break;
        }
    }
    spvUnsafeArray<float4, 1> _611 = { float4(_321.x, _321.y, float4(0.0).z, float4(0.0).w) };
    float4x4 _617 = Primitive.Primitive_PreviousLocalToWorld;
    _617[3].x = spvFAdd(Primitive.Primitive_PreviousLocalToWorld[3].x, View.View_PrevPreViewTranslation.x);
    float4x4 _621 = _617;
    _621[3].y = spvFAdd(Primitive.Primitive_PreviousLocalToWorld[3].y, View.View_PrevPreViewTranslation.y);
    float4x4 _625 = _621;
    _625[3].z = spvFAdd(Primitive.Primitive_PreviousLocalToWorld[3].z, View.View_PrevPreViewTranslation.z);
    float3 _627 = spvFMulMatrixVector(_625, _297).xyz;
    float4x4 _628 = spvFMulMatrixMatrix(Primitive.Primitive_PreviousLocalToWorld, _296);
    float4 _629 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(_323));
    float4 _630 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(_326));
    float3 _900;
    switch (0u)
    {
        default:
        {
            if (_330)
            {
                _900 = float3(0.0);
                break;
            }
            float _649 = _630.y;
            float _659 = _630.x;
            float _661 = _629.x;
            float _664 = floor(spvFMul(_661, 7.111111164093017578125));
            float _666 = spvFMul(_661, 256.0) - spvFMul(_664, 36.0);
            float _668 = floor(spvFMul(_666, 0.16666667163372039794921875));
            float3 _688 = select(float4(1.0, 0.0, 0.0, 1.0), select(float4(1.0, 0.0, 0.0, 1.0), Material.Material_VectorExpressions[5], bool4(Material.Material_ScalarExpressions[0].y >= 9.9999999747524270787835121154785e-07)), bool4(abs(Material.Material_ScalarExpressions[0].y - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz;
            float3 _694 = spvFMulMatrixVector(_628, float4(0.0, 0.0, 0.0, 1.0)).xyz;
            float3 _695 = _627 - View.View_PrevPreViewTranslation;
            float3 _702 = _694 * Material.Material_ScalarExpressions[1].x;
            float3 _719 = spvFAdd(Material_Texture2D_2.sample(Material_Texture2D_2Sampler, spvFAdd(spvFAdd((_695 - _694) * Material.Material_ScalarExpressions[0].w, _702), float3(1.0, 0.0, 0.0) * (spvFMul(View.View_PrevFrameGameTime, Material.Material_ScalarExpressions[1].y) - spvFMul(Material.Material_ScalarExpressions[1].z, _649))).xy, level(-1.0)).xyz, float3(-0.25, -0.5, -0.5)) * 2.0;
            float3x3 _739 = float3x3(_628[0].xyz, _628[1].xyz, _628[2].xyz);
            float3 _740 = spvFMulMatrixVector(_739, spvFAdd(float3(-0.5), fract(spvFMul(float3(_629.y), float3(0.0625, 1.0, 16.0)))) * 2.0);
            float3 _742 = float3(1.0) - (_740 * spvFMul(Material.Material_ScalarExpressions[2].y, _659));
            float3 _743 = spvFAdd(_695, spvFAdd(_688 * spvFMul(Material.Material_ScalarExpressions[1].w, _719.x), float3(0.0, 0.0, 1.0) * spvFMul(_719.y, Material.Material_ScalarExpressions[2].x)) * _649) - _742;
            float _750 = dot(_688, _740 / float3(sqrt(dot(_740, _740))));
            float3 _753 = spvFAdd(_688, float3(0.0, 0.0, 1.0) * spvFMul(_750, _750));
            float3 _757 = _753 / float3(sqrt(dot(_753, _753)));
            float3 _771 = spvFAdd(float3(-0.5), Material_Texture2D_2.sample(Material_Texture2D_2Sampler, spvFAdd(spvFAdd(spvFMul(spvFMul(float3(_666 - spvFMul(_668, 6.0), _668, _664), float3(0.20000000298023223876953125, 0.20000000298023223876953125, 0.16666667163372039794921875)), Primitive.Primitive_ObjectBounds) * Material.Material_ScalarExpressions[2].z, float3(1.0)), float3(-1.0, 0.0, 0.0) * (fma(View.View_PrevFrameGameTime, Material.Material_ScalarExpressions[2].w, fract(dot(_702, _702))) - spvFMul(Material.Material_ScalarExpressions[3].x, _659))).xy, level(-1.0)).xyz) * 2.0;
            float3 _791 = spvFAdd(_743, spvFAdd(_757 * spvFMul(Material.Material_ScalarExpressions[3].y, spvFAdd(_771.z, 1.0)), spvFAdd(_757 * _771.x, Material.Material_VectorExpressions[6].xyz * _771.y) * Material.Material_ScalarExpressions[3].w) * _659);
            float _792 = dot(_791, _791);
            float3 _811 = spvFAdd(select(float4(0.0, 0.0, 0.0, 1.0), select(float4(0.0, 0.0, 0.0, 1.0), float4(_791 / float3(sqrt(_792)), 0.0), bool4(_792 >= 9.9999999747524270787835121154785e-07)), bool4(abs(_792 - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz * sqrt(dot(_743, _743)), _742) - _694;
            float _835 = fast::min(fast::max((((spvFMulMatrixVector(Primitive.Primitive_PreviousWorldToLocal, float4(_695, 1.0)).xyz - Primitive.Primitive_LocalObjectBoundsMin) / (Primitive.Primitive_LocalObjectBoundsMax - Primitive.Primitive_LocalObjectBoundsMin)).z - Material.Material_ScalarExpressions[4].y) / Material.Material_ScalarExpressions[4].z, 0.0), 1.0);
            float _836 = spvFMul(_835, _835);
            float3 _848 = spvFAdd(float3(-0.5), Material_Texture2D_2.sample(Material_Texture2D_2Sampler, spvFAdd(_702, float3(-1.0, 0.0, 0.0) * (spvFMul(View.View_PrevFrameGameTime, Material.Material_ScalarExpressions[4].x) - spvFMul(Material.Material_ScalarExpressions[4].w, _836))).xy, level(-1.0)).xyz) * 2.0;
            float3 _865 = spvFAdd(_811, spvFAdd(_688 * spvFMul(Material.Material_ScalarExpressions[5].x, spvFAdd(_848.z, 1.0)), spvFAdd(_688 * _848.x, (cross(_688, float3(0.0, 0.0, 1.0)) * Material.Material_ScalarExpressions[5].y) * _848.y) * Material.Material_ScalarExpressions[5].z) * _836);
            float _866 = dot(_865, _865);
            float3 _887 = -spvFMulMatrixVector(_739, float3(1.0, 0.0, 0.0));
            float3 _891 = -spvFMulMatrixVector(_739, float3(0.0, 1.0, 0.0));
            float3 _895 = -spvFMulMatrixVector(_739, float3(0.0, 0.0, 1.0));
            _900 = spvFMul(spvFAdd(select(float4(0.0, 0.0, 0.0, 1.0), select(float4(0.0, 0.0, 0.0, 1.0), float4(_865 / float3(sqrt(_866)), 0.0), bool4(_866 >= 9.9999999747524270787835121154785e-07)), bool4(abs(_866 - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz * sqrt(dot(_811, _811)), _694) - _695, float3(sqrt(dot(_887, _887)), sqrt(dot(_891, _891)), sqrt(dot(_895, _895))));
            break;
        }
    }
    float4 _911 = spvFMulMatrixVector(View.View_TranslatedWorldToClip, float4(spvFAdd(_311, _598), 1.0));
    float4 _920 = _911;
    _920.z = spvFAdd(_911.z, (View.View_NumSceneColorMSAASamples > 1) ? spvFMul(0.001000000047497451305389404296875, _911.w) : 0.0);
    out.gl_Position = _920;
    out.out_var_TEXCOORD6 = _911;
    out.out_var_TEXCOORD7 = spvFMulMatrixVector(View.View_PrevTranslatedWorldToClip, float4(spvFAdd(_627, _900), 1.0));
    out.out_var_TEXCOORD10_centroid = float4(_196[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_196[2], spvFMul(_164, Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w));
    out.out_var_COLOR0 = LocalVF_VertexFetch_ColorComponentsBuffer.read(uint((_138 & uint(LocalVF.LocalVF_VertexFetch_Parameters.x)))).zyxw;
    out.out_var_COLOR1 = _279;
    out_var_TEXCOORD0 = _611;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

