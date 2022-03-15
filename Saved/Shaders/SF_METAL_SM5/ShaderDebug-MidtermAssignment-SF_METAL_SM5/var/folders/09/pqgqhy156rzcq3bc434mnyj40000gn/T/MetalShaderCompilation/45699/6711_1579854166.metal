

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

constant float3x3 _64 = {};
constant float4 _65 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD6 [[user(locn2)]];
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

vertex Main_out Main_00001a37_5e2aa956(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_Globals& _Globals [[buffer(3)]], texture_buffer<float> BoneMatrices [[texture(0)]])
{
    Main_out out = {};
    float4 _82 = float4(in.in_var_ATTRIBUTE4.x);
    int _85 = int(in.in_var_ATTRIBUTE3.x) * 3;
    float4 _99 = float4(in.in_var_ATTRIBUTE4.y);
    int _102 = int(in.in_var_ATTRIBUTE3.y) * 3;
    float4 _118 = float4(in.in_var_ATTRIBUTE4.z);
    int _121 = int(in.in_var_ATTRIBUTE3.z) * 3;
    float4 _137 = float4(in.in_var_ATTRIBUTE4.w);
    int _140 = int(in.in_var_ATTRIBUTE3.w) * 3;
    float4 _152 = (((_82 * BoneMatrices.read(uint(uint(_85)))) + (_99 * BoneMatrices.read(uint(uint(_102))))) + (_118 * BoneMatrices.read(uint(uint(_121))))) + (_137 * BoneMatrices.read(uint(uint(_140))));
    float4 _153 = (((_82 * BoneMatrices.read(uint(uint(_85 + 1)))) + (_99 * BoneMatrices.read(uint(uint(_102 + 1))))) + (_118 * BoneMatrices.read(uint(uint(_121 + 1))))) + (_137 * BoneMatrices.read(uint(uint(_140 + 1))));
    float4 _154 = (((_82 * BoneMatrices.read(uint(uint(_85 + 2)))) + (_99 * BoneMatrices.read(uint(uint(_102 + 2))))) + (_118 * BoneMatrices.read(uint(uint(_121 + 2))))) + (_137 * BoneMatrices.read(uint(uint(_140 + 2))));
    float3x4 _238;
    if (_Globals.NumBoneInfluencesParam > 4u)
    {
        float4 _162 = float4(in.in_var_ATTRIBUTE15.x);
        int _165 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _181 = float4(in.in_var_ATTRIBUTE15.y);
        int _184 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _200 = float4(in.in_var_ATTRIBUTE15.z);
        int _203 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _219 = float4(in.in_var_ATTRIBUTE15.w);
        int _222 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _238 = float3x4((((_152 + (_162 * BoneMatrices.read(uint(uint(_165))))) + (_181 * BoneMatrices.read(uint(uint(_184))))) + (_200 * BoneMatrices.read(uint(uint(_203))))) + (_219 * BoneMatrices.read(uint(uint(_222)))), (((_153 + (_162 * BoneMatrices.read(uint(uint(_165 + 1))))) + (_181 * BoneMatrices.read(uint(uint(_184 + 1))))) + (_200 * BoneMatrices.read(uint(uint(_203 + 1))))) + (_219 * BoneMatrices.read(uint(uint(_222 + 1)))), (((_154 + (_162 * BoneMatrices.read(uint(uint(_165 + 2))))) + (_181 * BoneMatrices.read(uint(uint(_184 + 2))))) + (_200 * BoneMatrices.read(uint(uint(_203 + 2))))) + (_219 * BoneMatrices.read(uint(uint(_222 + 2)))));
    }
    else
    {
        _238 = float3x4(_152, _153, _154);
    }
    float3 _241 = normalize(in.in_var_ATTRIBUTE2.xyz + in.in_var_ATTRIBUTE10);
    float3 _242 = _241.xyz;
    float3 _252 = normalize(float4(normalize(in.in_var_ATTRIBUTE1 - (_242 * dot(in.in_var_ATTRIBUTE1, _242))), 0.0) * _238);
    float3x3 _253 = _64;
    _253[0] = _252;
    float3 _259 = normalize(float4(_241, 0.0) * _238);
    float3x3 _260 = _253;
    _260[2] = _259;
    float3x3 _265 = _260;
    _265[1] = normalize(cross(_259, _252) * in.in_var_ATTRIBUTE2.w);
    float3 _266 = in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE9;
    float3 _267 = _266 + in.in_var_ATTRIBUTE11;
    float _268 = _267.x;
    float _269 = _267.y;
    float _270 = _267.z;
    float4 _271 = float4(_268, _269, _270, 1.0);
    float3 _272 = _271 * _238;
    float3 _273 = _272 + in.in_var_ATTRIBUTE12;
    float3 _278 = _273.xxx;
    float3 _279 = Primitive.Primitive_LocalToWorld[0u].xyz * _278;
    float3 _283 = _273.yyy;
    float3 _284 = Primitive.Primitive_LocalToWorld[1u].xyz * _283;
    float3 _285 = _279 + _284;
    float3 _289 = _273.zzz;
    float3 _290 = Primitive.Primitive_LocalToWorld[2u].xyz * _289;
    float3 _291 = _285 + _290;
    float3 _295 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _296 = _291 + _295;
    float _297 = _296.x;
    float _298 = _296.y;
    float _299 = _296.z;
    float4 _300 = float4(_297, _298, _299, 1.0);
    float4 _301 = float4(_300.x, _300.y, _300.z, _300.w);
    float4 _304 = View.View_TranslatedWorldToClip * _301;
    float4 _305 = _65;
    _305.w = 0.0;
    float3x3 _318 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _318[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _321 = _318;
    _321[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _324 = _321;
    _324[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _325 = _324 * _265;
    float3 _326 = _325[0];
    out.out_var_TEXCOORD10_centroid = float4(_326.x, _326.y, _326.z, _305.w);
    out.out_var_TEXCOORD11_centroid = float4(_325[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_TEXCOORD6 = _301;
    out.gl_Position = _304;
    return out;
}

