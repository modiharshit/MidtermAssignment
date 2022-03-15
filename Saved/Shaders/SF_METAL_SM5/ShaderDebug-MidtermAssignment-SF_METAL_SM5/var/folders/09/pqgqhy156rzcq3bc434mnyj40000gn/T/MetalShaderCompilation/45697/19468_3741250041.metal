

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

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
    float4 Primitive_InvNonUniformScaleAndDeterminantSign;
    char _m2_pad[16];
    float4x4 Primitive_WorldToLocal;
    float4x4 Primitive_PreviousLocalToWorld;
    float4x4 Primitive_PreviousWorldToLocal;
    char _m5_pad[48];
    float4 Primitive_ObjectOrientation;
    char _m6_pad[16];
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

constant float3x3 _108 = {};
constant float4 _109 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float4 out_var_TEXCOORD7 [[user(locn1)]];
    float4 out_var_TEXCOORD10_centroid [[user(locn2)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn3)]];
    float4 out_var_TEXCOORD15 [[user(locn4)]];
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

vertex MainVertexShader_out Main_00004c0c_defef1f9(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_LocalVF& LocalVF [[buffer(6)]], constant type_Material& Material [[buffer(7)]], constant type_Globals& _Globals [[buffer(8)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceOriginBuffer [[texture(0)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceTransformBuffer [[texture(1)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(2)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(3)]], texture2d<float> Material_Texture2D_2 [[texture(4)]], sampler Material_Texture2D_2Sampler [[sampler(0)]], uint gl_InstanceIndex [[instance_id]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    bool _310;
    uint _130 = (gl_InstanceIndex - gl_BaseInstance) + _Globals.InstanceOffset;
    uint _131 = 3u * _130;
    float4 _133 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_131));
    float4 _135 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint((_131 + 1u)));
    float4 _137 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint((_131 + 2u)));
    float4 _139 = InstanceVF_VertexFetch_InstanceOriginBuffer.read(uint(_130));
    uint _143 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _144 = 2u * _143;
    float4 _149 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_144 + 1u)));
    float _150 = _149.w;
    float3 _151 = _149.xyz;
    float3 _153 = cross(_151, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_144)).xyz) * _150;
    float3x3 _156 = _108;
    _156[0] = cross(_153, _151) * _150;
    float3x3 _157 = _156;
    _157[1] = _153;
    float3x3 _158 = _157;
    _158[2] = _151;
    float3x3 _172 = spvFMulMatrixMatrix(float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz), float3x3(_133.xyz, _135.xyz, _137.xyz));
    float3x3 _175 = _172;
    _175[0] = normalize(_172[0]);
    float3x3 _178 = _175;
    _178[1] = normalize(_172[1]);
    float3x3 _181 = _178;
    _181[2] = normalize(_172[2]);
    float3x3 _182 = spvFMulMatrixMatrix(_181, _158);
    float _188 = trunc(spvFMul(_133.w, 0.00390625));
    float _189 = _139.w;
    float4 _190 = _109;
    _190.x = _189;
    float3 _195 = spvFAdd(_139.xyz, _Globals.InstancingOffset.xyz);
    float3 _204 = spvFAdd(fma(Primitive.Primitive_LocalToWorld[2].xyz, _195.zzz, fma(Primitive.Primitive_LocalToWorld[0].xyz, _195.xxx, spvFMul(Primitive.Primitive_LocalToWorld[1].xyz, _195.yyy))), Primitive.Primitive_LocalToWorld[3].xyz);
    float4 _215 = _190;
    _215.y = 1.0 - fast::clamp(spvFMul(length(spvFAdd(_204, View.View_PreViewTranslation)) - _Globals.InstancingFadeOutParams.x, _Globals.InstancingFadeOutParams.y), 0.0, 1.0);
    float _259 = fma(dot(select(float3(0.0), float3(1.0), float3(fma(_Globals.InstancingViewZCompareZero.w, _189, length(_204 - _Globals.InstancingWorldViewOriginZero.xyz))) > _Globals.InstancingViewZCompareZero.xyz), _Globals.InstancingViewZConstant.xyz), _Globals.InstancingWorldViewOriginZero.w, spvFMul(dot(select(float3(0.0), float3(1.0), float3(fma(_Globals.InstancingViewZCompareZero.w, _189, length(_204 - _Globals.InstancingWorldViewOriginOne.xyz))) > _Globals.InstancingViewZCompareOne.xyz), _Globals.InstancingViewZConstant.xyz), _Globals.InstancingWorldViewOriginOne.w));
    float4 _260 = _215;
    _260.w = _259;
    float _264 = spvFMul(fma(_Globals.InstancingFadeOutParams.z, _188, spvFMul(_Globals.InstancingFadeOutParams.w, 1.0 - _188)), float(abs(_259) < 0.999000012874603271484375));
    float4 _265 = _260;
    _265.z = _264;
    float4x4 _282 = float4x4(float4(_133.xyz, 0.0), float4(_135.xyz, 0.0), float4(_137.xyz, 0.0), float4(_139.xyz, 1.0));
    float4 _283 = spvFMulMatrixVector(_282, in.in_var_ATTRIBUTE0);
    float3 _297 = (float4(spvFAdd(fma(Primitive.Primitive_LocalToWorld[2].xyz, _283.zzz, fma(Primitive.Primitive_LocalToWorld[0].xyz, _283.xxx, spvFMul(Primitive.Primitive_LocalToWorld[1].xyz, _283.yyy))), spvFAdd(Primitive.Primitive_LocalToWorld[3].xyz, View.View_PreViewTranslation)), 1.0) * _264).xyz;
    float4x4 _298 = spvFMulMatrixMatrix(Primitive.Primitive_LocalToWorld, _282);
    uint _301 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    float4 _307 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(((_301 * _143) + min(0u, (_301 - 1u)))));
    float3 _481;
    switch (0u)
    {
        default:
        {
            _310 = _264 < 1.0;
            if (_310)
            {
                _481 = float3(0.0);
                break;
            }
            float3 _314 = spvFMulMatrixVector(_298, float4(0.0, 0.0, 0.0, 1.0)).xyz;
            float3 _315 = _314 - View.View_WorldCameraOrigin;
            float3 _319 = _315 / float3(sqrt(dot(_315, _315)));
            float _323 = dot(Primitive.Primitive_ObjectOrientation.xyz, _319);
            float3 _325 = _319 - (Primitive.Primitive_ObjectOrientation.xyz * _323);
            float3 _330 = _182[2];
            float _331 = dot(_325 / float3(sqrt(dot(_325, _325))), _330);
            float _346 = spvFMul(_323, _323);
            float _347 = spvFMul(_346, _346);
            float3 _353 = _297 - View.View_PreViewTranslation;
            float3 _354 = _353 - _314;
            float _398 = fast::min(fast::max((((spvFMulMatrixVector(Primitive.Primitive_WorldToLocal, float4(_353, 1.0)).xyz - Primitive.Primitive_LocalObjectBoundsMin) / (Primitive.Primitive_LocalObjectBoundsMax - Primitive.Primitive_LocalObjectBoundsMin)).z - Material.Material_ScalarExpressions[1].w) / Material.Material_ScalarExpressions[2].x, 0.0), 1.0);
            float _399 = spvFMul(_398, _398);
            float3 _413 = spvFAdd(float3(-0.5), Material_Texture2D_2.sample(Material_Texture2D_2Sampler, spvFAdd(_314 * Material.Material_ScalarExpressions[1].y, float3(-1.0, 0.0, 0.0) * (spvFMul(View.View_GameTime, Material.Material_ScalarExpressions[1].z) - spvFMul(Material.Material_ScalarExpressions[2].y, _399))).xy, level(-1.0)).xyz) * 2.0;
            float3 _419 = select(float4(1.0, 0.0, 0.0, 1.0), select(float4(1.0, 0.0, 0.0, 1.0), Material.Material_VectorExpressions[5], bool4(Material.Material_ScalarExpressions[0].w >= 9.9999999747524270787835121154785e-07)), bool4(abs(Material.Material_ScalarExpressions[0].w - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz;
            float3 _435 = spvFAdd(_354, spvFAdd(_419 * spvFMul(Material.Material_ScalarExpressions[2].z, spvFAdd(_413.z, 1.0)), spvFAdd(_419 * _413.x, (cross(_419, float3(0.0, 0.0, 1.0)) * Material.Material_ScalarExpressions[2].w) * _413.y) * Material.Material_ScalarExpressions[3].x) * _399);
            float _436 = dot(_435, _435);
            float3x3 _462 = float3x3(_298[0].xyz, _298[1].xyz, _298[2].xyz);
            float3 _464 = -spvFMulMatrixVector(_462, float3(1.0, 0.0, 0.0));
            float3 _468 = -spvFMulMatrixVector(_462, float3(0.0, 1.0, 0.0));
            float3 _472 = -spvFMulMatrixVector(_462, float3(0.0, 0.0, 1.0));
            _481 = select(_353 * (-1.0), spvFMul(spvFAdd(select(float4(0.0, 0.0, 0.0, 1.0), select(float4(0.0, 0.0, 0.0, 1.0), float4(_435 / float3(sqrt(_436)), 0.0), bool4(_436 >= 9.9999999747524270787835121154785e-07)), bool4(abs(_436 - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz * sqrt(dot(_354, _354)), _314) - _353, float3(sqrt(dot(_464, _464)), sqrt(dot(_468, _468)), sqrt(dot(_472, _472)))), bool3(fast::clamp(spvFAdd(mix(spvFMul(spvFMul(_331, _331), Material.Material_ScalarExpressions[0].z), spvFMulMatrixVector(float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz), _330).z, spvFMul(_347, _347)), 0.0199999995529651641845703125), 0.0, 1.0) >= 0.100000001490116119384765625));
            break;
        }
    }
    float3 _485 = spvFMulMatrixVector(_298, float4(0.0, 0.0, 0.0, 1.0)).xyz - View.View_WorldCameraOrigin;
    float3 _489 = _485 / float3(sqrt(dot(_485, _485)));
    float _493 = dot(Primitive.Primitive_ObjectOrientation.xyz, _489);
    float3 _495 = _489 - (Primitive.Primitive_ObjectOrientation.xyz * _493);
    float3 _500 = _182[2];
    float _501 = dot(_495 / float3(sqrt(dot(_495, _495))), _500);
    float _516 = spvFMul(_493, _493);
    float _517 = spvFMul(_516, _516);
    float2 _523 = float2(fast::clamp(spvFAdd(mix(spvFMul(spvFMul(_501, _501), Material.Material_ScalarExpressions[0].z), spvFMulMatrixVector(float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz), _500).z, spvFMul(_517, _517)), 0.0199999995529651641845703125), 0.0, 1.0));
    float4 _533 = float4(_500, spvFMul(_150, Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w));
    spvUnsafeArray<float4, 1> _534 = { float4(_307.x, _307.y, _523.x, _523.y) };
    float4x4 _540 = Primitive.Primitive_PreviousLocalToWorld;
    _540[3].x = spvFAdd(Primitive.Primitive_PreviousLocalToWorld[3].x, View.View_PrevPreViewTranslation.x);
    float4x4 _544 = _540;
    _544[3].y = spvFAdd(Primitive.Primitive_PreviousLocalToWorld[3].y, View.View_PrevPreViewTranslation.y);
    float4x4 _548 = _544;
    _548[3].z = spvFAdd(Primitive.Primitive_PreviousLocalToWorld[3].z, View.View_PrevPreViewTranslation.z);
    float3 _550 = spvFMulMatrixVector(_548, _283).xyz;
    float4x4 _551 = spvFMulMatrixMatrix(Primitive.Primitive_PreviousLocalToWorld, _282);
    float3 _718;
    switch (0u)
    {
        default:
        {
            if (_310)
            {
                _718 = float3(0.0);
                break;
            }
            float3 _573 = select(float4(1.0, 0.0, 0.0, 1.0), select(float4(1.0, 0.0, 0.0, 1.0), Material.Material_VectorExpressions[5], bool4(Material.Material_ScalarExpressions[0].w >= 9.9999999747524270787835121154785e-07)), bool4(abs(Material.Material_ScalarExpressions[0].w - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz;
            float3 _579 = spvFMulMatrixVector(_551, float4(0.0, 0.0, 0.0, 1.0)).xyz;
            float3 _580 = _579 - View.View_PrevWorldCameraOrigin;
            float3 _584 = _580 / float3(sqrt(dot(_580, _580)));
            float _585 = dot(Primitive.Primitive_ObjectOrientation.xyz, _584);
            float3 _587 = _584 - (Primitive.Primitive_ObjectOrientation.xyz * _585);
            float _592 = dot(_587 / float3(sqrt(dot(_587, _587))), _500);
            float _605 = spvFMul(_585, _585);
            float _606 = spvFMul(_605, _605);
            float3 _612 = _550 - View.View_PrevPreViewTranslation;
            float3 _613 = _612 - _579;
            float _640 = fast::min(fast::max((((spvFMulMatrixVector(Primitive.Primitive_PreviousWorldToLocal, float4(_612, 1.0)).xyz - Primitive.Primitive_LocalObjectBoundsMin) / (Primitive.Primitive_LocalObjectBoundsMax - Primitive.Primitive_LocalObjectBoundsMin)).z - Material.Material_ScalarExpressions[1].w) / Material.Material_ScalarExpressions[2].x, 0.0), 1.0);
            float _641 = spvFMul(_640, _640);
            float3 _655 = spvFAdd(float3(-0.5), Material_Texture2D_2.sample(Material_Texture2D_2Sampler, spvFAdd(_579 * Material.Material_ScalarExpressions[1].y, float3(-1.0, 0.0, 0.0) * (spvFMul(View.View_PrevFrameGameTime, Material.Material_ScalarExpressions[1].z) - spvFMul(Material.Material_ScalarExpressions[2].y, _641))).xy, level(-1.0)).xyz) * 2.0;
            float3 _672 = spvFAdd(_613, spvFAdd(_573 * spvFMul(Material.Material_ScalarExpressions[2].z, spvFAdd(_655.z, 1.0)), spvFAdd(_573 * _655.x, (cross(_573, float3(0.0, 0.0, 1.0)) * Material.Material_ScalarExpressions[2].w) * _655.y) * Material.Material_ScalarExpressions[3].x) * _641);
            float _673 = dot(_672, _672);
            float3x3 _699 = float3x3(_551[0].xyz, _551[1].xyz, _551[2].xyz);
            float3 _701 = -spvFMulMatrixVector(_699, float3(1.0, 0.0, 0.0));
            float3 _705 = -spvFMulMatrixVector(_699, float3(0.0, 1.0, 0.0));
            float3 _709 = -spvFMulMatrixVector(_699, float3(0.0, 0.0, 1.0));
            _718 = select(_612 * (-1.0), spvFMul(spvFAdd(select(float4(0.0, 0.0, 0.0, 1.0), select(float4(0.0, 0.0, 0.0, 1.0), float4(_672 / float3(sqrt(_673)), 0.0), bool4(_673 >= 9.9999999747524270787835121154785e-07)), bool4(abs(_673 - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz * sqrt(dot(_613, _613)), _579) - _612, float3(sqrt(dot(_701, _701)), sqrt(dot(_705, _705)), sqrt(dot(_709, _709)))), bool3(fast::clamp(spvFAdd(mix(spvFMul(spvFMul(_592, _592), Material.Material_ScalarExpressions[0].z), spvFMulMatrixVector(float3x3(Primitive.Primitive_PreviousWorldToLocal[0].xyz, Primitive.Primitive_PreviousWorldToLocal[1].xyz, Primitive.Primitive_PreviousWorldToLocal[2].xyz), _500).z, spvFMul(_606, _606)), 0.0199999995529651641845703125), 0.0, 1.0) >= 0.100000001490116119384765625));
            break;
        }
    }
    float4 _729 = spvFMulMatrixVector(View.View_TranslatedWorldToClip, float4(spvFAdd(_297, _481), 1.0));
    float4 _738 = _729;
    _738.z = spvFAdd(_729.z, (View.View_NumSceneColorMSAASamples > 1) ? spvFMul(0.001000000047497451305389404296875, _729.w) : 0.0);
    out.gl_Position = _738;
    out.out_var_TEXCOORD6 = _729;
    out.out_var_TEXCOORD7 = spvFMulMatrixVector(View.View_PrevTranslatedWorldToClip, float4(spvFAdd(_550, _718), 1.0));
    out.out_var_TEXCOORD10_centroid = float4(_182[0], 0.0);
    out.out_var_TEXCOORD11_centroid = _533;
    out.out_var_TEXCOORD15 = _533;
    out.out_var_COLOR1 = _265;
    out_var_TEXCOORD0 = _534;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

