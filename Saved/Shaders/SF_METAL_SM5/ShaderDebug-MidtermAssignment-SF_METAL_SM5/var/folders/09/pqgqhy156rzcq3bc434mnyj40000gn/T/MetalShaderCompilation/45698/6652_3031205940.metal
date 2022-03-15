

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct type_View
{
    float4x4 View_TranslatedWorldToClip;
    char _m1_pad[1056];
    float3 View_PreViewTranslation;
};

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
    float4 Primitive_InvNonUniformScaleAndDeterminantSign;
};

struct type_Globals
{
    uint NumBoneInfluencesParam;
};

constant float3x3 _63 = {};
constant float4 _64 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    uint4 in_var_ATTRIBUTE3 [[attribute(3)]];
    float4 in_var_ATTRIBUTE4 [[attribute(4)]];
    float3 in_var_ATTRIBUTE9 [[attribute(9)]];
    float3 in_var_ATTRIBUTE10 [[attribute(10)]];
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
    uint4 in_var_ATTRIBUTE14 [[attribute(14)]];
    float4 in_var_ATTRIBUTE15 [[attribute(15)]];
};

vertex Main_out Main_000019fc_b4ac8834(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_Globals& _Globals [[buffer(3)]], texture_buffer<float> BoneMatrices [[texture(0)]])
{
    Main_out out = {};
    float4 _83 = float4(in.in_var_ATTRIBUTE4.x);
    int _86 = int(in.in_var_ATTRIBUTE3.x) * 3;
    float4 _100 = float4(in.in_var_ATTRIBUTE4.y);
    int _103 = int(in.in_var_ATTRIBUTE3.y) * 3;
    float4 _119 = float4(in.in_var_ATTRIBUTE4.z);
    int _122 = int(in.in_var_ATTRIBUTE3.z) * 3;
    float4 _138 = float4(in.in_var_ATTRIBUTE4.w);
    int _141 = int(in.in_var_ATTRIBUTE3.w) * 3;
    float4 _153 = (((_83 * BoneMatrices.read(uint(uint(_86)))) + (_100 * BoneMatrices.read(uint(uint(_103))))) + (_119 * BoneMatrices.read(uint(uint(_122))))) + (_138 * BoneMatrices.read(uint(uint(_141))));
    float4 _154 = (((_83 * BoneMatrices.read(uint(uint(_86 + 1)))) + (_100 * BoneMatrices.read(uint(uint(_103 + 1))))) + (_119 * BoneMatrices.read(uint(uint(_122 + 1))))) + (_138 * BoneMatrices.read(uint(uint(_141 + 1))));
    float4 _155 = (((_83 * BoneMatrices.read(uint(uint(_86 + 2)))) + (_100 * BoneMatrices.read(uint(uint(_103 + 2))))) + (_119 * BoneMatrices.read(uint(uint(_122 + 2))))) + (_138 * BoneMatrices.read(uint(uint(_141 + 2))));
    float3x4 _239;
    if (_Globals.NumBoneInfluencesParam > 4u)
    {
        float4 _163 = float4(in.in_var_ATTRIBUTE15.x);
        int _166 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _182 = float4(in.in_var_ATTRIBUTE15.y);
        int _185 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _201 = float4(in.in_var_ATTRIBUTE15.z);
        int _204 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _220 = float4(in.in_var_ATTRIBUTE15.w);
        int _223 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _239 = float3x4((((_153 + (_163 * BoneMatrices.read(uint(uint(_166))))) + (_182 * BoneMatrices.read(uint(uint(_185))))) + (_201 * BoneMatrices.read(uint(uint(_204))))) + (_220 * BoneMatrices.read(uint(uint(_223)))), (((_154 + (_163 * BoneMatrices.read(uint(uint(_166 + 1))))) + (_182 * BoneMatrices.read(uint(uint(_185 + 1))))) + (_201 * BoneMatrices.read(uint(uint(_204 + 1))))) + (_220 * BoneMatrices.read(uint(uint(_223 + 1)))), (((_155 + (_163 * BoneMatrices.read(uint(uint(_166 + 2))))) + (_182 * BoneMatrices.read(uint(uint(_185 + 2))))) + (_201 * BoneMatrices.read(uint(uint(_204 + 2))))) + (_220 * BoneMatrices.read(uint(uint(_223 + 2)))));
    }
    else
    {
        _239 = float3x4(_153, _154, _155);
    }
    float3 _242 = normalize(in.in_var_ATTRIBUTE2.xyz + in.in_var_ATTRIBUTE10);
    float3 _243 = _242.xyz;
    float3 _253 = normalize(float4(normalize(in.in_var_ATTRIBUTE1 - (_243 * dot(in.in_var_ATTRIBUTE1, _243))), 0.0) * _239);
    float3x3 _254 = _63;
    _254[0] = _253;
    float3 _260 = normalize(float4(_242, 0.0) * _239);
    float3x3 _261 = _254;
    _261[2] = _260;
    float3x3 _266 = _261;
    _266[1] = normalize(cross(_260, _253) * in.in_var_ATTRIBUTE2.w);
    float3 _267 = in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE9;
    float3 _268 = _267 + in.in_var_ATTRIBUTE11;
    float _269 = _268.x;
    float _270 = _268.y;
    float _271 = _268.z;
    float4 _272 = float4(_269, _270, _271, 1.0);
    float3 _273 = _272 * _239;
    float3 _274 = _273 + in.in_var_ATTRIBUTE12;
    float3 _279 = _274.xxx;
    float3 _280 = Primitive.Primitive_LocalToWorld[0u].xyz * _279;
    float3 _284 = _274.yyy;
    float3 _285 = Primitive.Primitive_LocalToWorld[1u].xyz * _284;
    float3 _286 = _280 + _285;
    float3 _290 = _274.zzz;
    float3 _291 = Primitive.Primitive_LocalToWorld[2u].xyz * _290;
    float3 _292 = _286 + _291;
    float3 _296 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _297 = _292 + _296;
    float _298 = _297.x;
    float _299 = _297.y;
    float _300 = _297.z;
    float4 _301 = float4(_298, _299, _300, 1.0);
    float4 _302 = float4(_301.x, _301.y, _301.z, _301.w);
    float4 _303 = View.View_TranslatedWorldToClip * _302;
    float4 _304 = _64;
    _304.w = 0.0;
    float3x3 _317 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _317[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _320 = _317;
    _320[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _323 = _320;
    _323[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _324 = _323 * _266;
    float3 _325 = _324[0];
    out.out_var_TEXCOORD10_centroid = float4(_325.x, _325.y, _325.z, _304.w);
    out.out_var_TEXCOORD11_centroid = float4(_324[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.gl_Position = _303;
    return out;
}

