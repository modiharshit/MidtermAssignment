

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

struct type_PrecomputedLightingBuffer
{
    char _m0_pad[32];
    float4 PrecomputedLightingBuffer_LightMapCoordinateScaleBias;
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

constant float3x3 _126 = {};
constant float4 _127 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_COLOR0 [[user(locn2)]];
    float4 out_var_COLOR1 [[user(locn3)]];
    float4 out_var_TEXCOORD0_0 [[user(locn4)]];
    float4 out_var_TEXCOORD4 [[user(locn5)]];
    float4 out_var_TEXCOORD6 [[user(locn6)]];
    float3 out_var_TEXCOORD7 [[user(locn7)]];
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

vertex MainVertexShader_out Main_000047cb_c4149ba9(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(6)]], constant type_Primitive& Primitive [[buffer(7)]], constant type_LocalVF& LocalVF [[buffer(8)]], constant type_PrecomputedLightingBuffer& PrecomputedLightingBuffer [[buffer(9)]], constant type_Material& Material [[buffer(10)]], constant type_Globals& _Globals [[buffer(11)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceOriginBuffer [[texture(0)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceTransformBuffer [[texture(1)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceLightmapBuffer [[texture(2)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(3)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(4)]], texture_buffer<float> LocalVF_VertexFetch_ColorComponentsBuffer [[texture(5)]], texture2d<float> Material_Texture2D_2 [[texture(6)]], sampler Material_Texture2D_2Sampler [[sampler(0)]], uint gl_InstanceIndex [[instance_id]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    MainVertexShader_out out = {};
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
    uint _162 = 2u * _140;
    float4 _167 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_162 + 1u)));
    float _168 = _167.w;
    float3 _169 = _167.xyz;
    float3 _171 = cross(_169, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_162)).xyz) * _168;
    float3x3 _174 = _126;
    _174[0] = cross(_171, _169) * _168;
    float3x3 _175 = _174;
    _175[1] = _171;
    float3x3 _176 = _175;
    _176[2] = _169;
    float3x3 _190 = spvFMulMatrixMatrix(float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz), float3x3(_153.xyz, _155.xyz, _157.xyz));
    float3x3 _193 = _190;
    _193[0] = normalize(_190[0]);
    float3x3 _196 = _193;
    _196[1] = normalize(_190[1]);
    float3x3 _199 = _196;
    _199[2] = normalize(_190[2]);
    float3x3 _200 = spvFMulMatrixMatrix(_199, _176);
    float _204 = _153.w;
    float _205 = spvFMul(_204, 0.00390625);
    float _206 = trunc(_205);
    float _207 = _159.w;
    float4 _208 = _127;
    _208.x = _207;
    float3 _209 = _159.xyz;
    float3 _213 = spvFAdd(_209, _Globals.InstancingOffset.xyz);
    float3 _214 = _213.xxx;
    float3 _215 = _213.yyy;
    float3 _216 = spvFMul(Primitive.Primitive_LocalToWorld[1].xyz, _215);
    float3 _217 = fma(Primitive.Primitive_LocalToWorld[0].xyz, _214, _216);
    float3 _218 = _213.zzz;
    float3 _219 = fma(Primitive.Primitive_LocalToWorld[2].xyz, _218, _217);
    float3 _222 = spvFAdd(_219, Primitive.Primitive_LocalToWorld[3].xyz);
    float4 _233 = _208;
    _233.y = 1.0 - fast::clamp(spvFMul(length(spvFAdd(_222, View.View_PreViewTranslation)) - _Globals.InstancingFadeOutParams.x, _Globals.InstancingFadeOutParams.y), 0.0, 1.0);
    float _238 = 1.0 - _206;
    float _239 = spvFMul(_Globals.InstancingFadeOutParams.w, _238);
    float _240 = fma(_Globals.InstancingFadeOutParams.z, _206, _239);
    float3 _247 = _222 - _Globals.InstancingWorldViewOriginZero.xyz;
    float _248 = length(_247);
    float _249 = fma(_Globals.InstancingViewZCompareZero.w, _207, _248);
    float3 _253 = _222 - _Globals.InstancingWorldViewOriginOne.xyz;
    float _254 = length(_253);
    float _255 = fma(_Globals.InstancingViewZCompareZero.w, _207, _254);
    float3 _256 = float3(_249);
    bool3 _259 = _256 > _Globals.InstancingViewZCompareZero.xyz;
    float3 _260 = select(float3(0.0), float3(1.0), _259);
    float _264 = dot(_260, _Globals.InstancingViewZConstant.xyz);
    float3 _267 = float3(_255);
    bool3 _271 = _267 > _Globals.InstancingViewZCompareOne.xyz;
    float3 _272 = select(float3(0.0), float3(1.0), _271);
    float _273 = dot(_272, _Globals.InstancingViewZConstant.xyz);
    float _276 = spvFMul(_273, _Globals.InstancingWorldViewOriginOne.w);
    float _277 = fma(_264, _Globals.InstancingWorldViewOriginZero.w, _276);
    float4 _278 = _233;
    _278.w = _277;
    float _279 = abs(_277);
    bool _280 = _279 < 0.999000012874603271484375;
    float _281 = float(_280);
    float _282 = spvFMul(_240, _281);
    float4 _283 = _278;
    _283.z = _282;
    float _284 = _153.x;
    float _285 = _153.y;
    float _286 = _153.z;
    float4 _287 = float4(_284, _285, _286, 0.0);
    float _288 = _155.x;
    float _289 = _155.y;
    float _290 = _155.z;
    float4 _291 = float4(_288, _289, _290, 0.0);
    float _292 = _157.x;
    float _293 = _157.y;
    float _294 = _157.z;
    float4 _295 = float4(_292, _293, _294, 0.0);
    float _296 = _159.x;
    float _297 = _159.y;
    float _298 = _159.z;
    float4 _299 = float4(_296, _297, _298, 1.0);
    float4x4 _300 = float4x4(_287, _291, _295, _299);
    float4 _301 = spvFMulMatrixVector(_300, in.in_var_ATTRIBUTE0);
    float3 _302 = _301.xxx;
    float3 _303 = _301.yyy;
    float3 _304 = spvFMul(Primitive.Primitive_LocalToWorld[1].xyz, _303);
    float3 _305 = fma(Primitive.Primitive_LocalToWorld[0].xyz, _302, _304);
    float3 _306 = _301.zzz;
    float3 _307 = fma(Primitive.Primitive_LocalToWorld[2].xyz, _306, _305);
    float3 _308 = spvFAdd(Primitive.Primitive_LocalToWorld[3].xyz, View.View_PreViewTranslation);
    float3 _309 = spvFAdd(_307, _308);
    float _310 = _309.x;
    float _311 = _309.y;
    float _312 = _309.z;
    float4 _313 = float4(_310, _311, _312, 1.0);
    float4 _314 = _313 * _282;
    float3 _315 = _314.xyz;
    float4x4 _316 = spvFMulMatrixMatrix(Primitive.Primitive_LocalToWorld, _300);
    uint _319 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    uint _320 = _319 - 1u;
    uint _322 = _319 * _140;
    float4 _325 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_322 + min(0u, _320))));
    float4 _328 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_322 + min(1u, _320))));
    float4 _331 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_322 + min(2u, _320))));
    float3 _602;
    switch (0u)
    {
        default:
        {
            if (_282 < 1.0)
            {
                _602 = float3(0.0);
                break;
            }
            float3 _350 = spvFMulMatrixVector(_316, float4(0.0, 0.0, 0.0, 1.0)).xyz;
            float3 _351 = _315 - View.View_PreViewTranslation;
            float3 _358 = _350 * Material.Material_ScalarExpressions[1].x;
            float _367 = _331.y;
            float3 _379 = spvFAdd(Material_Texture2D_2.sample(Material_Texture2D_2Sampler, spvFAdd(spvFAdd((_351 - _350) * Material.Material_ScalarExpressions[0].w, _358), float3(1.0, 0.0, 0.0) * (spvFMul(View.View_GameTime, Material.Material_ScalarExpressions[1].y) - spvFMul(Material.Material_ScalarExpressions[1].z, _367))).xy, level(-1.0)).xyz, float3(-0.25, -0.5, -0.5)) * 2.0;
            float3 _384 = select(float4(1.0, 0.0, 0.0, 1.0), select(float4(1.0, 0.0, 0.0, 1.0), Material.Material_VectorExpressions[5], bool4(Material.Material_ScalarExpressions[0].y >= 9.9999999747524270787835121154785e-07)), bool4(abs(Material.Material_ScalarExpressions[0].y - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz;
            float3x3 _406 = float3x3(_316[0].xyz, _316[1].xyz, _316[2].xyz);
            float3 _407 = spvFMulMatrixVector(_406, spvFAdd(float3(-0.5), fract(spvFMul(float3(_328.y), float3(0.0625, 1.0, 16.0)))) * 2.0);
            float _410 = _331.x;
            float3 _413 = float3(1.0) - (_407 * spvFMul(Material.Material_ScalarExpressions[2].y, _410));
            float3 _414 = spvFAdd(_351, spvFAdd(_384 * spvFMul(Material.Material_ScalarExpressions[1].w, _379.x), float3(0.0, 0.0, 1.0) * spvFMul(_379.y, Material.Material_ScalarExpressions[2].x)) * _367) - _413;
            float _421 = dot(_384, _407 / float3(sqrt(dot(_407, _407))));
            float3 _424 = spvFAdd(_384, float3(0.0, 0.0, 1.0) * spvFMul(_421, _421));
            float3 _428 = _424 / float3(sqrt(dot(_424, _424)));
            float _429 = _328.x;
            float _432 = floor(spvFMul(_429, 7.111111164093017578125));
            float _434 = spvFMul(_429, 256.0) - spvFMul(_432, 36.0);
            float _436 = floor(spvFMul(_434, 0.16666667163372039794921875));
            float3 _464 = spvFAdd(float3(-0.5), Material_Texture2D_2.sample(Material_Texture2D_2Sampler, spvFAdd(spvFAdd(spvFMul(spvFMul(float3(_434 - spvFMul(_436, 6.0), _436, _432), float3(0.20000000298023223876953125, 0.20000000298023223876953125, 0.16666667163372039794921875)), Primitive.Primitive_ObjectBounds) * Material.Material_ScalarExpressions[2].z, float3(1.0)), float3(-1.0, 0.0, 0.0) * (fma(View.View_GameTime, Material.Material_ScalarExpressions[2].w, fract(dot(_358, _358))) - spvFMul(Material.Material_ScalarExpressions[3].x, _410))).xy, level(-1.0)).xyz) * 2.0;
            float3 _484 = spvFAdd(_414, spvFAdd(_428 * spvFMul(Material.Material_ScalarExpressions[3].y, spvFAdd(_464.z, 1.0)), spvFAdd(_428 * _464.x, Material.Material_VectorExpressions[6].xyz * _464.y) * Material.Material_ScalarExpressions[3].w) * _410);
            float _485 = dot(_484, _484);
            float3 _504 = spvFAdd(select(float4(0.0, 0.0, 0.0, 1.0), select(float4(0.0, 0.0, 0.0, 1.0), float4(_484 / float3(sqrt(_485)), 0.0), bool4(_485 >= 9.9999999747524270787835121154785e-07)), bool4(abs(_485 - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz * sqrt(dot(_414, _414)), _413) - _350;
            float _533 = fast::min(fast::max((((spvFMulMatrixVector(Primitive.Primitive_WorldToLocal, float4(_351, 1.0)).xyz - Primitive.Primitive_LocalObjectBoundsMin) / (Primitive.Primitive_LocalObjectBoundsMax - Primitive.Primitive_LocalObjectBoundsMin)).z - Material.Material_ScalarExpressions[4].y) / Material.Material_ScalarExpressions[4].z, 0.0), 1.0);
            float _534 = spvFMul(_533, _533);
            float3 _546 = spvFAdd(float3(-0.5), Material_Texture2D_2.sample(Material_Texture2D_2Sampler, spvFAdd(_358, float3(-1.0, 0.0, 0.0) * (spvFMul(View.View_GameTime, Material.Material_ScalarExpressions[4].x) - spvFMul(Material.Material_ScalarExpressions[4].w, _534))).xy, level(-1.0)).xyz) * 2.0;
            float3 _567 = spvFAdd(_504, spvFAdd(_384 * spvFMul(Material.Material_ScalarExpressions[5].x, spvFAdd(_546.z, 1.0)), spvFAdd(_384 * _546.x, (cross(_384, float3(0.0, 0.0, 1.0)) * Material.Material_ScalarExpressions[5].y) * _546.y) * Material.Material_ScalarExpressions[5].z) * _534);
            float _568 = dot(_567, _567);
            float3 _589 = -spvFMulMatrixVector(_406, float3(1.0, 0.0, 0.0));
            float3 _593 = -spvFMulMatrixVector(_406, float3(0.0, 1.0, 0.0));
            float3 _597 = -spvFMulMatrixVector(_406, float3(0.0, 0.0, 1.0));
            _602 = spvFMul(spvFAdd(select(float4(0.0, 0.0, 0.0, 1.0), select(float4(0.0, 0.0, 0.0, 1.0), float4(_567 / float3(sqrt(_568)), 0.0), bool4(_568 >= 9.9999999747524270787835121154785e-07)), bool4(abs(_568 - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz * sqrt(dot(_504, _504)), _350) - _351, float3(sqrt(dot(_589, _589)), sqrt(dot(_593, _593)), sqrt(dot(_597, _597))));
            break;
        }
    }
    float3 _603 = spvFAdd(_315, _602);
    float4 _604 = float4(_603.x, _603.y, _603.z, _314.w);
    float4 _605 = spvFMulMatrixVector(View.View_TranslatedWorldToClip, _604);
    float2 _617 = fma(LocalVF_VertexFetch_TexCoordBuffer.read(uint((_322 + uint(LocalVF.LocalVF_VertexFetch_Parameters.z)))).xy, PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapCoordinateScaleBias.xy, InstanceVF_VertexFetch_InstanceLightmapBuffer.read(uint(_150)).xy);
    spvUnsafeArray<float4, 1> _629 = { float4(_325.x, _325.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_200[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_200[2], spvFMul(_168, Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w));
    out.out_var_COLOR0 = LocalVF_VertexFetch_ColorComponentsBuffer.read(uint((_140 & uint(LocalVF.LocalVF_VertexFetch_Parameters.x)))).zyxw;
    out.out_var_COLOR1 = _283;
    out_var_TEXCOORD0 = _629;
    out.out_var_TEXCOORD4 = float4(_617.x, _617.y, float2(0.0).x, float2(0.0).y);
    out.out_var_TEXCOORD6 = _604;
    out.out_var_TEXCOORD7 = _315;
    out.gl_Position = _605;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

