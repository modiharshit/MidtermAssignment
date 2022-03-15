

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

vertex Main_out Main_00001a44_d1bf62b6(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_Globals& _Globals [[buffer(3)]], texture_buffer<float> BoneMatrices [[texture(0)]])
{
    Main_out out = {};
    float4 _84 = float4(in.in_var_ATTRIBUTE4.x);
    int _87 = int(in.in_var_ATTRIBUTE3.x) * 3;
    float4 _101 = float4(in.in_var_ATTRIBUTE4.y);
    int _104 = int(in.in_var_ATTRIBUTE3.y) * 3;
    float4 _120 = float4(in.in_var_ATTRIBUTE4.z);
    int _123 = int(in.in_var_ATTRIBUTE3.z) * 3;
    float4 _139 = float4(in.in_var_ATTRIBUTE4.w);
    int _142 = int(in.in_var_ATTRIBUTE3.w) * 3;
    float4 _154 = (((_84 * BoneMatrices.read(uint(uint(_87)))) + (_101 * BoneMatrices.read(uint(uint(_104))))) + (_120 * BoneMatrices.read(uint(uint(_123))))) + (_139 * BoneMatrices.read(uint(uint(_142))));
    float4 _155 = (((_84 * BoneMatrices.read(uint(uint(_87 + 1)))) + (_101 * BoneMatrices.read(uint(uint(_104 + 1))))) + (_120 * BoneMatrices.read(uint(uint(_123 + 1))))) + (_139 * BoneMatrices.read(uint(uint(_142 + 1))));
    float4 _156 = (((_84 * BoneMatrices.read(uint(uint(_87 + 2)))) + (_101 * BoneMatrices.read(uint(uint(_104 + 2))))) + (_120 * BoneMatrices.read(uint(uint(_123 + 2))))) + (_139 * BoneMatrices.read(uint(uint(_142 + 2))));
    float3x4 _240;
    if (_Globals.NumBoneInfluencesParam > 4u)
    {
        float4 _164 = float4(in.in_var_ATTRIBUTE15.x);
        int _167 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _183 = float4(in.in_var_ATTRIBUTE15.y);
        int _186 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _202 = float4(in.in_var_ATTRIBUTE15.z);
        int _205 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _221 = float4(in.in_var_ATTRIBUTE15.w);
        int _224 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _240 = float3x4((((_154 + (_164 * BoneMatrices.read(uint(uint(_167))))) + (_183 * BoneMatrices.read(uint(uint(_186))))) + (_202 * BoneMatrices.read(uint(uint(_205))))) + (_221 * BoneMatrices.read(uint(uint(_224)))), (((_155 + (_164 * BoneMatrices.read(uint(uint(_167 + 1))))) + (_183 * BoneMatrices.read(uint(uint(_186 + 1))))) + (_202 * BoneMatrices.read(uint(uint(_205 + 1))))) + (_221 * BoneMatrices.read(uint(uint(_224 + 1)))), (((_156 + (_164 * BoneMatrices.read(uint(uint(_167 + 2))))) + (_183 * BoneMatrices.read(uint(uint(_186 + 2))))) + (_202 * BoneMatrices.read(uint(uint(_205 + 2))))) + (_221 * BoneMatrices.read(uint(uint(_224 + 2)))));
    }
    else
    {
        _240 = float3x4(_154, _155, _156);
    }
    float3 _243 = normalize(in.in_var_ATTRIBUTE2.xyz + in.in_var_ATTRIBUTE10);
    float3 _244 = _243.xyz;
    float3 _254 = normalize(float4(normalize(in.in_var_ATTRIBUTE1 - (_244 * dot(in.in_var_ATTRIBUTE1, _244))), 0.0) * _240);
    float3x3 _255 = _64;
    _255[0] = _254;
    float3 _261 = normalize(float4(_243, 0.0) * _240);
    float3x3 _262 = _255;
    _262[2] = _261;
    float3x3 _267 = _262;
    _267[1] = normalize(cross(_261, _254) * in.in_var_ATTRIBUTE2.w);
    float3 _268 = in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE9;
    float3 _269 = _268 + in.in_var_ATTRIBUTE11;
    float _270 = _269.x;
    float _271 = _269.y;
    float _272 = _269.z;
    float4 _273 = float4(_270, _271, _272, 1.0);
    float3 _274 = _273 * _240;
    float3 _275 = _274 + in.in_var_ATTRIBUTE12;
    float3 _280 = _275.xxx;
    float3 _281 = Primitive.Primitive_LocalToWorld[0u].xyz * _280;
    float3 _285 = _275.yyy;
    float3 _286 = Primitive.Primitive_LocalToWorld[1u].xyz * _285;
    float3 _287 = _281 + _286;
    float3 _291 = _275.zzz;
    float3 _292 = Primitive.Primitive_LocalToWorld[2u].xyz * _291;
    float3 _293 = _287 + _292;
    float3 _297 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _298 = _293 + _297;
    float _299 = _298.x;
    float _300 = _298.y;
    float _301 = _298.z;
    float4 _302 = float4(_299, _300, _301, 1.0);
    float4 _303 = float4(_302.x, _302.y, _302.z, _302.w);
    float4 _304 = View.View_TranslatedWorldToClip * _303;
    float4 _305 = _65;
    _305.w = 0.0;
    float3x3 _318 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _318[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _321 = _318;
    _321[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _324 = _321;
    _324[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _325 = _324 * _267;
    float3 _326 = _325[0];
    out.gl_Position = _304;
    out.out_var_TEXCOORD10_centroid = float4(_326.x, _326.y, _326.z, _305.w);
    out.out_var_TEXCOORD11_centroid = float4(_325[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_TEXCOORD6 = _303;
    return out;
}

