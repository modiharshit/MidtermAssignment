

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

struct type_PrecomputedLightingBuffer
{
    char _m0_pad[32];
    float4 PrecomputedLightingBuffer_LightMapCoordinateScaleBias;
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

constant float3x3 _114 = {};
constant float4 _115 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD15 [[user(locn2)]];
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

vertex MainVertexShader_out Main_000042f7_3c7999f5(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(5)]], constant type_Primitive& Primitive [[buffer(6)]], constant type_LocalVF& LocalVF [[buffer(7)]], constant type_PrecomputedLightingBuffer& PrecomputedLightingBuffer [[buffer(8)]], constant type_Material& Material [[buffer(9)]], constant type_Globals& _Globals [[buffer(10)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceOriginBuffer [[texture(0)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceTransformBuffer [[texture(1)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceLightmapBuffer [[texture(2)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(3)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(4)]], texture2d<float> Material_Texture2D_2 [[texture(5)]], sampler Material_Texture2D_2Sampler [[sampler(0)]], uint gl_InstanceIndex [[instance_id]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    uint _128 = (gl_InstanceIndex - gl_BaseInstance) + _Globals.InstanceOffset;
    uint _129 = 3u * _128;
    float4 _131 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_129));
    uint _132 = _129 + 1u;
    float4 _133 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_132));
    uint _134 = _129 + 2u;
    float4 _135 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_134));
    float4 _137 = InstanceVF_VertexFetch_InstanceOriginBuffer.read(uint(_128));
    uint _143 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _144 = 2u * _143;
    float4 _149 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_144 + 1u)));
    float _150 = _149.w;
    float3 _151 = _149.xyz;
    float3 _153 = cross(_151, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_144)).xyz) * _150;
    float3x3 _156 = _114;
    _156[0] = cross(_153, _151) * _150;
    float3x3 _157 = _156;
    _157[1] = _153;
    float3x3 _158 = _157;
    _158[2] = _151;
    float3x3 _172 = spvFMulMatrixMatrix(float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz), float3x3(_131.xyz, _133.xyz, _135.xyz));
    float3x3 _175 = _172;
    _175[0] = normalize(_172[0]);
    float3x3 _178 = _175;
    _178[1] = normalize(_172[1]);
    float3x3 _181 = _178;
    _181[2] = normalize(_172[2]);
    float3x3 _182 = spvFMulMatrixMatrix(_181, _158);
    float _186 = _131.w;
    float _187 = spvFMul(_186, 0.00390625);
    float _188 = trunc(_187);
    float _189 = _137.w;
    float4 _190 = _115;
    _190.x = _189;
    float3 _191 = _137.xyz;
    float3 _195 = spvFAdd(_191, _Globals.InstancingOffset.xyz);
    float3 _196 = _195.xxx;
    float3 _197 = _195.yyy;
    float3 _198 = spvFMul(Primitive.Primitive_LocalToWorld[1].xyz, _197);
    float3 _199 = fma(Primitive.Primitive_LocalToWorld[0].xyz, _196, _198);
    float3 _200 = _195.zzz;
    float3 _201 = fma(Primitive.Primitive_LocalToWorld[2].xyz, _200, _199);
    float3 _204 = spvFAdd(_201, Primitive.Primitive_LocalToWorld[3].xyz);
    float4 _215 = _190;
    _215.y = 1.0 - fast::clamp(spvFMul(length(spvFAdd(_204, View.View_PreViewTranslation)) - _Globals.InstancingFadeOutParams.x, _Globals.InstancingFadeOutParams.y), 0.0, 1.0);
    float _220 = 1.0 - _188;
    float _221 = spvFMul(_Globals.InstancingFadeOutParams.w, _220);
    float _222 = fma(_Globals.InstancingFadeOutParams.z, _188, _221);
    float3 _229 = _204 - _Globals.InstancingWorldViewOriginZero.xyz;
    float _230 = length(_229);
    float _231 = fma(_Globals.InstancingViewZCompareZero.w, _189, _230);
    float3 _235 = _204 - _Globals.InstancingWorldViewOriginOne.xyz;
    float _236 = length(_235);
    float _237 = fma(_Globals.InstancingViewZCompareZero.w, _189, _236);
    float3 _238 = float3(_231);
    bool3 _241 = _238 > _Globals.InstancingViewZCompareZero.xyz;
    float3 _242 = select(float3(0.0), float3(1.0), _241);
    float _246 = dot(_242, _Globals.InstancingViewZConstant.xyz);
    float3 _249 = float3(_237);
    bool3 _253 = _249 > _Globals.InstancingViewZCompareOne.xyz;
    float3 _254 = select(float3(0.0), float3(1.0), _253);
    float _255 = dot(_254, _Globals.InstancingViewZConstant.xyz);
    float _258 = spvFMul(_255, _Globals.InstancingWorldViewOriginOne.w);
    float _259 = fma(_246, _Globals.InstancingWorldViewOriginZero.w, _258);
    float4 _260 = _215;
    _260.w = _259;
    float _261 = abs(_259);
    bool _262 = _261 < 0.999000012874603271484375;
    float _263 = float(_262);
    float _264 = spvFMul(_222, _263);
    float4 _265 = _260;
    _265.z = _264;
    float _266 = _131.x;
    float _267 = _131.y;
    float _268 = _131.z;
    float4 _269 = float4(_266, _267, _268, 0.0);
    float _270 = _133.x;
    float _271 = _133.y;
    float _272 = _133.z;
    float4 _273 = float4(_270, _271, _272, 0.0);
    float _274 = _135.x;
    float _275 = _135.y;
    float _276 = _135.z;
    float4 _277 = float4(_274, _275, _276, 0.0);
    float _278 = _137.x;
    float _279 = _137.y;
    float _280 = _137.z;
    float4 _281 = float4(_278, _279, _280, 1.0);
    float4x4 _282 = float4x4(_269, _273, _277, _281);
    float4 _283 = spvFMulMatrixVector(_282, in.in_var_ATTRIBUTE0);
    float3 _284 = _283.xxx;
    float3 _285 = _283.yyy;
    float3 _286 = spvFMul(Primitive.Primitive_LocalToWorld[1].xyz, _285);
    float3 _287 = fma(Primitive.Primitive_LocalToWorld[0].xyz, _284, _286);
    float3 _288 = _283.zzz;
    float3 _289 = fma(Primitive.Primitive_LocalToWorld[2].xyz, _288, _287);
    float3 _290 = spvFAdd(Primitive.Primitive_LocalToWorld[3].xyz, View.View_PreViewTranslation);
    float3 _291 = spvFAdd(_289, _290);
    float _292 = _291.x;
    float _293 = _291.y;
    float _294 = _291.z;
    float4 _295 = float4(_292, _293, _294, 1.0);
    float4 _296 = _295 * _264;
    float3 _297 = _296.xyz;
    float4x4 _298 = spvFMulMatrixMatrix(Primitive.Primitive_LocalToWorld, _282);
    uint _301 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    uint _304 = _301 * _143;
    float4 _307 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_304 + min(0u, (_301 - 1u)))));
    float3 _481;
    switch (0u)
    {
        default:
        {
            if (_264 < 1.0)
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
    float3 _482 = spvFAdd(_297, _481);
    float4 _483 = float4(_482.x, _482.y, _482.z, _296.w);
    float4 _484 = spvFMulMatrixVector(View.View_TranslatedWorldToClip, _483);
    float3 _487 = spvFMulMatrixVector(_298, float4(0.0, 0.0, 0.0, 1.0)).xyz - View.View_WorldCameraOrigin;
    float3 _491 = _487 / float3(sqrt(dot(_487, _487)));
    float _495 = dot(Primitive.Primitive_ObjectOrientation.xyz, _491);
    float3 _497 = _491 - (Primitive.Primitive_ObjectOrientation.xyz * _495);
    float3 _502 = _182[2];
    float _503 = dot(_497 / float3(sqrt(dot(_497, _497))), _502);
    float _518 = spvFMul(_495, _495);
    float _519 = spvFMul(_518, _518);
    float2 _525 = float2(fast::clamp(spvFAdd(mix(spvFMul(spvFMul(_503, _503), Material.Material_ScalarExpressions[0].z), spvFMulMatrixVector(float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz), _502).z, spvFMul(_519, _519)), 0.0199999995529651641845703125), 0.0, 1.0));
    float2 _537 = fma(LocalVF_VertexFetch_TexCoordBuffer.read(uint((_304 + uint(LocalVF.LocalVF_VertexFetch_Parameters.z)))).xy, PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapCoordinateScaleBias.xy, InstanceVF_VertexFetch_InstanceLightmapBuffer.read(uint(_128)).xy);
    float4 _547 = float4(_502, spvFMul(_150, Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w));
    spvUnsafeArray<float4, 1> _548 = { float4(_307.x, _307.y, _525.x, _525.y) };
    out.out_var_TEXCOORD10_centroid = float4(_182[0], 0.0);
    out.out_var_TEXCOORD11_centroid = _547;
    out.out_var_TEXCOORD15 = _547;
    out.out_var_COLOR1 = _265;
    out_var_TEXCOORD0 = _548;
    out.out_var_TEXCOORD4 = float4(_537.x, _537.y, float2(0.0).x, float2(0.0).y);
    out.out_var_TEXCOORD6 = _483;
    out.out_var_TEXCOORD7 = _297;
    out.gl_Position = _484;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

