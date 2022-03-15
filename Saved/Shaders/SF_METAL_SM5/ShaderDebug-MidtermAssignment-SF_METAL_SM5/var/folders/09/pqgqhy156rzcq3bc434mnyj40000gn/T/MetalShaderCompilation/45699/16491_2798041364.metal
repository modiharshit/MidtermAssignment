

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

constant float3x3 _110 = {};
constant float4 _111 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD15 [[user(locn2)]];
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

vertex Main_out Main_0000406b_a6c6b914(Main_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_LocalVF& LocalVF [[buffer(6)]], constant type_Material& Material [[buffer(7)]], constant type_Globals& _Globals [[buffer(8)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceOriginBuffer [[texture(0)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceTransformBuffer [[texture(1)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(2)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(3)]], texture2d<float> Material_Texture2D_2 [[texture(4)]], sampler Material_Texture2D_2Sampler [[sampler(0)]], uint gl_InstanceIndex [[instance_id]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    uint _123 = (gl_InstanceIndex - gl_BaseInstance) + _Globals.InstanceOffset;
    uint _124 = 3u * _123;
    float4 _126 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_124));
    uint _127 = _124 + 1u;
    float4 _128 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_127));
    uint _129 = _124 + 2u;
    float4 _130 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_129));
    float4 _132 = InstanceVF_VertexFetch_InstanceOriginBuffer.read(uint(_123));
    uint _136 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _137 = 2u * _136;
    float4 _142 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_137 + 1u)));
    float _143 = _142.w;
    float3 _144 = _142.xyz;
    float3 _146 = cross(_144, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_137)).xyz) * _143;
    float3x3 _149 = _110;
    _149[0] = cross(_146, _144) * _143;
    float3x3 _150 = _149;
    _150[1] = _146;
    float3x3 _151 = _150;
    _151[2] = _144;
    float3x3 _165 = spvFMulMatrixMatrix(float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz), float3x3(_126.xyz, _128.xyz, _130.xyz));
    float3x3 _168 = _165;
    _168[0] = normalize(_165[0]);
    float3x3 _171 = _168;
    _171[1] = normalize(_165[1]);
    float3x3 _174 = _171;
    _174[2] = normalize(_165[2]);
    float3x3 _175 = spvFMulMatrixMatrix(_174, _151);
    float _179 = _126.w;
    float _180 = spvFMul(_179, 0.00390625);
    float _181 = trunc(_180);
    float _182 = _132.w;
    float4 _183 = _111;
    _183.x = _182;
    float3 _184 = _132.xyz;
    float3 _188 = spvFAdd(_184, _Globals.InstancingOffset.xyz);
    float3 _189 = _188.xxx;
    float3 _190 = _188.yyy;
    float3 _191 = spvFMul(Primitive.Primitive_LocalToWorld[1].xyz, _190);
    float3 _192 = fma(Primitive.Primitive_LocalToWorld[0].xyz, _189, _191);
    float3 _193 = _188.zzz;
    float3 _194 = fma(Primitive.Primitive_LocalToWorld[2].xyz, _193, _192);
    float3 _197 = spvFAdd(_194, Primitive.Primitive_LocalToWorld[3].xyz);
    float4 _208 = _183;
    _208.y = 1.0 - fast::clamp(spvFMul(length(spvFAdd(_197, View.View_PreViewTranslation)) - _Globals.InstancingFadeOutParams.x, _Globals.InstancingFadeOutParams.y), 0.0, 1.0);
    float _213 = 1.0 - _181;
    float _214 = spvFMul(_Globals.InstancingFadeOutParams.w, _213);
    float _215 = fma(_Globals.InstancingFadeOutParams.z, _181, _214);
    float3 _222 = _197 - _Globals.InstancingWorldViewOriginZero.xyz;
    float _223 = length(_222);
    float _224 = fma(_Globals.InstancingViewZCompareZero.w, _182, _223);
    float3 _228 = _197 - _Globals.InstancingWorldViewOriginOne.xyz;
    float _229 = length(_228);
    float _230 = fma(_Globals.InstancingViewZCompareZero.w, _182, _229);
    float3 _231 = float3(_224);
    bool3 _234 = _231 > _Globals.InstancingViewZCompareZero.xyz;
    float3 _235 = select(float3(0.0), float3(1.0), _234);
    float _239 = dot(_235, _Globals.InstancingViewZConstant.xyz);
    float3 _242 = float3(_230);
    bool3 _246 = _242 > _Globals.InstancingViewZCompareOne.xyz;
    float3 _247 = select(float3(0.0), float3(1.0), _246);
    float _248 = dot(_247, _Globals.InstancingViewZConstant.xyz);
    float _251 = spvFMul(_248, _Globals.InstancingWorldViewOriginOne.w);
    float _252 = fma(_239, _Globals.InstancingWorldViewOriginZero.w, _251);
    float4 _253 = _208;
    _253.w = _252;
    float _254 = abs(_252);
    bool _255 = _254 < 0.999000012874603271484375;
    float _256 = float(_255);
    float _257 = spvFMul(_215, _256);
    float4 _258 = _253;
    _258.z = _257;
    float _259 = _126.x;
    float _260 = _126.y;
    float _261 = _126.z;
    float4 _262 = float4(_259, _260, _261, 0.0);
    float _263 = _128.x;
    float _264 = _128.y;
    float _265 = _128.z;
    float4 _266 = float4(_263, _264, _265, 0.0);
    float _267 = _130.x;
    float _268 = _130.y;
    float _269 = _130.z;
    float4 _270 = float4(_267, _268, _269, 0.0);
    float _271 = _132.x;
    float _272 = _132.y;
    float _273 = _132.z;
    float4 _274 = float4(_271, _272, _273, 1.0);
    float4x4 _275 = float4x4(_262, _266, _270, _274);
    float4 _276 = spvFMulMatrixVector(_275, in.in_var_ATTRIBUTE0);
    float3 _277 = _276.xxx;
    float3 _278 = _276.yyy;
    float3 _279 = spvFMul(Primitive.Primitive_LocalToWorld[1].xyz, _278);
    float3 _280 = fma(Primitive.Primitive_LocalToWorld[0].xyz, _277, _279);
    float3 _281 = _276.zzz;
    float3 _282 = fma(Primitive.Primitive_LocalToWorld[2].xyz, _281, _280);
    float3 _283 = spvFAdd(Primitive.Primitive_LocalToWorld[3].xyz, View.View_PreViewTranslation);
    float3 _284 = spvFAdd(_282, _283);
    float _285 = _284.x;
    float _286 = _284.y;
    float _287 = _284.z;
    float4 _288 = float4(_285, _286, _287, 1.0);
    float4 _289 = _288 * _257;
    float3 _290 = _289.xyz;
    float4x4 _291 = spvFMulMatrixMatrix(Primitive.Primitive_LocalToWorld, _275);
    uint _294 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    float4 _300 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(((_294 * _136) + min(0u, (_294 - 1u)))));
    float3 _474;
    switch (0u)
    {
        default:
        {
            if (_257 < 1.0)
            {
                _474 = float3(0.0);
                break;
            }
            float3 _307 = spvFMulMatrixVector(_291, float4(0.0, 0.0, 0.0, 1.0)).xyz;
            float3 _308 = _307 - View.View_WorldCameraOrigin;
            float3 _312 = _308 / float3(sqrt(dot(_308, _308)));
            float _316 = dot(Primitive.Primitive_ObjectOrientation.xyz, _312);
            float3 _318 = _312 - (Primitive.Primitive_ObjectOrientation.xyz * _316);
            float3 _323 = _175[2];
            float _324 = dot(_318 / float3(sqrt(dot(_318, _318))), _323);
            float _339 = spvFMul(_316, _316);
            float _340 = spvFMul(_339, _339);
            float3 _346 = _290 - View.View_PreViewTranslation;
            float3 _347 = _346 - _307;
            float _391 = fast::min(fast::max((((spvFMulMatrixVector(Primitive.Primitive_WorldToLocal, float4(_346, 1.0)).xyz - Primitive.Primitive_LocalObjectBoundsMin) / (Primitive.Primitive_LocalObjectBoundsMax - Primitive.Primitive_LocalObjectBoundsMin)).z - Material.Material_ScalarExpressions[1].w) / Material.Material_ScalarExpressions[2].x, 0.0), 1.0);
            float _392 = spvFMul(_391, _391);
            float3 _406 = spvFAdd(float3(-0.5), Material_Texture2D_2.sample(Material_Texture2D_2Sampler, spvFAdd(_307 * Material.Material_ScalarExpressions[1].y, float3(-1.0, 0.0, 0.0) * (spvFMul(View.View_GameTime, Material.Material_ScalarExpressions[1].z) - spvFMul(Material.Material_ScalarExpressions[2].y, _392))).xy, level(-1.0)).xyz) * 2.0;
            float3 _412 = select(float4(1.0, 0.0, 0.0, 1.0), select(float4(1.0, 0.0, 0.0, 1.0), Material.Material_VectorExpressions[5], bool4(Material.Material_ScalarExpressions[0].w >= 9.9999999747524270787835121154785e-07)), bool4(abs(Material.Material_ScalarExpressions[0].w - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz;
            float3 _428 = spvFAdd(_347, spvFAdd(_412 * spvFMul(Material.Material_ScalarExpressions[2].z, spvFAdd(_406.z, 1.0)), spvFAdd(_412 * _406.x, (cross(_412, float3(0.0, 0.0, 1.0)) * Material.Material_ScalarExpressions[2].w) * _406.y) * Material.Material_ScalarExpressions[3].x) * _392);
            float _429 = dot(_428, _428);
            float3x3 _455 = float3x3(_291[0].xyz, _291[1].xyz, _291[2].xyz);
            float3 _457 = -spvFMulMatrixVector(_455, float3(1.0, 0.0, 0.0));
            float3 _461 = -spvFMulMatrixVector(_455, float3(0.0, 1.0, 0.0));
            float3 _465 = -spvFMulMatrixVector(_455, float3(0.0, 0.0, 1.0));
            _474 = select(_346 * (-1.0), spvFMul(spvFAdd(select(float4(0.0, 0.0, 0.0, 1.0), select(float4(0.0, 0.0, 0.0, 1.0), float4(_428 / float3(sqrt(_429)), 0.0), bool4(_429 >= 9.9999999747524270787835121154785e-07)), bool4(abs(_429 - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz * sqrt(dot(_347, _347)), _307) - _346, float3(sqrt(dot(_457, _457)), sqrt(dot(_461, _461)), sqrt(dot(_465, _465)))), bool3(fast::clamp(spvFAdd(mix(spvFMul(spvFMul(_324, _324), Material.Material_ScalarExpressions[0].z), spvFMulMatrixVector(float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz), _323).z, spvFMul(_340, _340)), 0.0199999995529651641845703125), 0.0, 1.0) >= 0.100000001490116119384765625));
            break;
        }
    }
    float3 _475 = spvFAdd(_290, _474);
    float4 _476 = float4(_475.x, _475.y, _475.z, _289.w);
    float4 _487 = spvFMulMatrixVector(View.View_TranslatedWorldToClip, _476);
    float3 _490 = spvFMulMatrixVector(_291, float4(0.0, 0.0, 0.0, 1.0)).xyz - View.View_WorldCameraOrigin;
    float3 _494 = _490 / float3(sqrt(dot(_490, _490)));
    float _498 = dot(Primitive.Primitive_ObjectOrientation.xyz, _494);
    float3 _500 = _494 - (Primitive.Primitive_ObjectOrientation.xyz * _498);
    float3 _505 = _175[2];
    float _506 = dot(_500 / float3(sqrt(dot(_500, _500))), _505);
    float _521 = spvFMul(_498, _498);
    float _522 = spvFMul(_521, _521);
    float2 _528 = float2(fast::clamp(spvFAdd(mix(spvFMul(spvFMul(_506, _506), Material.Material_ScalarExpressions[0].z), spvFMulMatrixVector(float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz), _505).z, spvFMul(_522, _522)), 0.0199999995529651641845703125), 0.0, 1.0));
    float4 _538 = float4(_505, spvFMul(_143, Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w));
    spvUnsafeArray<float4, 1> _539 = { float4(_300.x, _300.y, _528.x, _528.y) };
    out.out_var_TEXCOORD10_centroid = float4(_175[0], 0.0);
    out.out_var_TEXCOORD11_centroid = _538;
    out.out_var_TEXCOORD15 = _538;
    out.out_var_COLOR1 = _258;
    out_var_TEXCOORD0 = _539;
    out.out_var_HIT_PROXY_ID = float4(spvFMul(_179 - spvFMul(256.0, _181), 0.0039215688593685626983642578125), spvFMul(_128.w, 0.0039215688593685626983642578125), spvFMul(_130.w, 0.0039215688593685626983642578125), 0.0);
    out.out_var_TEXCOORD6 = _476;
    out.out_var_TEXCOORD7 = _290;
    out.gl_Position = _487;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

