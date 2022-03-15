

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

constant float3x3 _125 = {};
constant float4 _126 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_COLOR0 [[user(locn2)]];
    float4 out_var_COLOR1 [[user(locn3)]];
    float4 out_var_TEXCOORD0_0 [[user(locn4)]];
    float4 out_var_TEXCOORD4 [[user(locn5)]];
    float3 out_var_TEXCOORD9 [[user(locn6)]];
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

vertex Main_out Main_0000471f_5fa708c7(Main_in in [[stage_in]], constant type_View& View [[buffer(6)]], constant type_Primitive& Primitive [[buffer(7)]], constant type_LocalVF& LocalVF [[buffer(8)]], constant type_PrecomputedLightingBuffer& PrecomputedLightingBuffer [[buffer(9)]], constant type_Material& Material [[buffer(10)]], constant type_Globals& _Globals [[buffer(11)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceOriginBuffer [[texture(0)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceTransformBuffer [[texture(1)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceLightmapBuffer [[texture(2)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(3)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(4)]], texture_buffer<float> LocalVF_VertexFetch_ColorComponentsBuffer [[texture(5)]], texture2d<float> Material_Texture2D_2 [[texture(6)]], sampler Material_Texture2D_2Sampler [[sampler(0)]], uint gl_InstanceIndex [[instance_id]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    uint _139 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _149 = (gl_InstanceIndex - gl_BaseInstance) + _Globals.InstanceOffset;
    uint _150 = 3u * _149;
    float4 _152 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_150));
    uint _153 = _150 + 1u;
    float4 _154 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_153));
    uint _155 = _150 + 2u;
    float4 _156 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_155));
    float4 _158 = InstanceVF_VertexFetch_InstanceOriginBuffer.read(uint(_149));
    uint _161 = 2u * _139;
    float4 _166 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_161 + 1u)));
    float _167 = _166.w;
    float3 _168 = _166.xyz;
    float3 _170 = cross(_168, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_161)).xyz) * _167;
    float3x3 _173 = _125;
    _173[0] = cross(_170, _168) * _167;
    float3x3 _174 = _173;
    _174[1] = _170;
    float3x3 _175 = _174;
    _175[2] = _168;
    float3x3 _189 = spvFMulMatrixMatrix(float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz), float3x3(_152.xyz, _154.xyz, _156.xyz));
    float3x3 _192 = _189;
    _192[0] = normalize(_189[0]);
    float3x3 _195 = _192;
    _195[1] = normalize(_189[1]);
    float3x3 _198 = _195;
    _198[2] = normalize(_189[2]);
    float3x3 _199 = spvFMulMatrixMatrix(_198, _175);
    float _203 = _152.w;
    float _204 = spvFMul(_203, 0.00390625);
    float _205 = trunc(_204);
    float _206 = _158.w;
    float4 _207 = _126;
    _207.x = _206;
    float3 _208 = _158.xyz;
    float3 _212 = spvFAdd(_208, _Globals.InstancingOffset.xyz);
    float3 _213 = _212.xxx;
    float3 _214 = _212.yyy;
    float3 _215 = spvFMul(Primitive.Primitive_LocalToWorld[1].xyz, _214);
    float3 _216 = fma(Primitive.Primitive_LocalToWorld[0].xyz, _213, _215);
    float3 _217 = _212.zzz;
    float3 _218 = fma(Primitive.Primitive_LocalToWorld[2].xyz, _217, _216);
    float3 _221 = spvFAdd(_218, Primitive.Primitive_LocalToWorld[3].xyz);
    float4 _232 = _207;
    _232.y = 1.0 - fast::clamp(spvFMul(length(spvFAdd(_221, View.View_PreViewTranslation)) - _Globals.InstancingFadeOutParams.x, _Globals.InstancingFadeOutParams.y), 0.0, 1.0);
    float _237 = 1.0 - _205;
    float _238 = spvFMul(_Globals.InstancingFadeOutParams.w, _237);
    float _239 = fma(_Globals.InstancingFadeOutParams.z, _205, _238);
    float3 _246 = _221 - _Globals.InstancingWorldViewOriginZero.xyz;
    float _247 = length(_246);
    float _248 = fma(_Globals.InstancingViewZCompareZero.w, _206, _247);
    float3 _252 = _221 - _Globals.InstancingWorldViewOriginOne.xyz;
    float _253 = length(_252);
    float _254 = fma(_Globals.InstancingViewZCompareZero.w, _206, _253);
    float3 _255 = float3(_248);
    bool3 _258 = _255 > _Globals.InstancingViewZCompareZero.xyz;
    float3 _259 = select(float3(0.0), float3(1.0), _258);
    float _263 = dot(_259, _Globals.InstancingViewZConstant.xyz);
    float3 _266 = float3(_254);
    bool3 _270 = _266 > _Globals.InstancingViewZCompareOne.xyz;
    float3 _271 = select(float3(0.0), float3(1.0), _270);
    float _272 = dot(_271, _Globals.InstancingViewZConstant.xyz);
    float _275 = spvFMul(_272, _Globals.InstancingWorldViewOriginOne.w);
    float _276 = fma(_263, _Globals.InstancingWorldViewOriginZero.w, _275);
    float4 _277 = _232;
    _277.w = _276;
    float _278 = abs(_276);
    bool _279 = _278 < 0.999000012874603271484375;
    float _280 = float(_279);
    float _281 = spvFMul(_239, _280);
    float4 _282 = _277;
    _282.z = _281;
    float _283 = _152.x;
    float _284 = _152.y;
    float _285 = _152.z;
    float4 _286 = float4(_283, _284, _285, 0.0);
    float _287 = _154.x;
    float _288 = _154.y;
    float _289 = _154.z;
    float4 _290 = float4(_287, _288, _289, 0.0);
    float _291 = _156.x;
    float _292 = _156.y;
    float _293 = _156.z;
    float4 _294 = float4(_291, _292, _293, 0.0);
    float _295 = _158.x;
    float _296 = _158.y;
    float _297 = _158.z;
    float4 _298 = float4(_295, _296, _297, 1.0);
    float4x4 _299 = float4x4(_286, _290, _294, _298);
    float4 _300 = spvFMulMatrixVector(_299, in.in_var_ATTRIBUTE0);
    float3 _301 = _300.xxx;
    float3 _302 = _300.yyy;
    float3 _303 = spvFMul(Primitive.Primitive_LocalToWorld[1].xyz, _302);
    float3 _304 = fma(Primitive.Primitive_LocalToWorld[0].xyz, _301, _303);
    float3 _305 = _300.zzz;
    float3 _306 = fma(Primitive.Primitive_LocalToWorld[2].xyz, _305, _304);
    float3 _307 = spvFAdd(Primitive.Primitive_LocalToWorld[3].xyz, View.View_PreViewTranslation);
    float3 _308 = spvFAdd(_306, _307);
    float _309 = _308.x;
    float _310 = _308.y;
    float _311 = _308.z;
    float4 _312 = float4(_309, _310, _311, 1.0);
    float4 _313 = _312 * _281;
    float3 _314 = _313.xyz;
    float4x4 _315 = spvFMulMatrixMatrix(Primitive.Primitive_LocalToWorld, _299);
    uint _318 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    uint _319 = _318 - 1u;
    uint _321 = _318 * _139;
    float4 _324 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_321 + min(0u, _319))));
    float4 _327 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_321 + min(1u, _319))));
    float4 _330 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_321 + min(2u, _319))));
    float3 _601;
    switch (0u)
    {
        default:
        {
            if (_281 < 1.0)
            {
                _601 = float3(0.0);
                break;
            }
            float3 _349 = spvFMulMatrixVector(_315, float4(0.0, 0.0, 0.0, 1.0)).xyz;
            float3 _350 = _314 - View.View_PreViewTranslation;
            float3 _357 = _349 * Material.Material_ScalarExpressions[1].x;
            float _366 = _330.y;
            float3 _378 = spvFAdd(Material_Texture2D_2.sample(Material_Texture2D_2Sampler, spvFAdd(spvFAdd((_350 - _349) * Material.Material_ScalarExpressions[0].w, _357), float3(1.0, 0.0, 0.0) * (spvFMul(View.View_GameTime, Material.Material_ScalarExpressions[1].y) - spvFMul(Material.Material_ScalarExpressions[1].z, _366))).xy, level(-1.0)).xyz, float3(-0.25, -0.5, -0.5)) * 2.0;
            float3 _383 = select(float4(1.0, 0.0, 0.0, 1.0), select(float4(1.0, 0.0, 0.0, 1.0), Material.Material_VectorExpressions[5], bool4(Material.Material_ScalarExpressions[0].y >= 9.9999999747524270787835121154785e-07)), bool4(abs(Material.Material_ScalarExpressions[0].y - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz;
            float3x3 _405 = float3x3(_315[0].xyz, _315[1].xyz, _315[2].xyz);
            float3 _406 = spvFMulMatrixVector(_405, spvFAdd(float3(-0.5), fract(spvFMul(float3(_327.y), float3(0.0625, 1.0, 16.0)))) * 2.0);
            float _409 = _330.x;
            float3 _412 = float3(1.0) - (_406 * spvFMul(Material.Material_ScalarExpressions[2].y, _409));
            float3 _413 = spvFAdd(_350, spvFAdd(_383 * spvFMul(Material.Material_ScalarExpressions[1].w, _378.x), float3(0.0, 0.0, 1.0) * spvFMul(_378.y, Material.Material_ScalarExpressions[2].x)) * _366) - _412;
            float _420 = dot(_383, _406 / float3(sqrt(dot(_406, _406))));
            float3 _423 = spvFAdd(_383, float3(0.0, 0.0, 1.0) * spvFMul(_420, _420));
            float3 _427 = _423 / float3(sqrt(dot(_423, _423)));
            float _428 = _327.x;
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
    float3 _602 = spvFAdd(_314, _601);
    float4 _603 = float4(_602.x, _602.y, _602.z, _313.w);
    float4 _604 = spvFMulMatrixVector(View.View_TranslatedWorldToClip, _603);
    float2 _616 = fma(LocalVF_VertexFetch_TexCoordBuffer.read(uint((_321 + uint(LocalVF.LocalVF_VertexFetch_Parameters.z)))).xy, PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapCoordinateScaleBias.xy, InstanceVF_VertexFetch_InstanceLightmapBuffer.read(uint(_149)).xy);
    spvUnsafeArray<float4, 1> _628 = { float4(_324.x, _324.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_199[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_199[2], spvFMul(_167, Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w));
    out.out_var_COLOR0 = LocalVF_VertexFetch_ColorComponentsBuffer.read(uint((_139 & uint(LocalVF.LocalVF_VertexFetch_Parameters.x)))).zyxw;
    out.out_var_COLOR1 = _282;
    out_var_TEXCOORD0 = _628;
    out.out_var_TEXCOORD4 = float4(_616.x, _616.y, float2(0.0).x, float2(0.0).y);
    out.out_var_TEXCOORD9 = _314;
    out.gl_Position = _604;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

