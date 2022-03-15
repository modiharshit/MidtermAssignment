

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

constant float3x3 _62 = {};
constant float4 _63 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_COLOR0 [[user(locn2)]];
    float4 out_var_TEXCOORD6 [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    uint4 in_var_ATTRIBUTE3 [[attribute(3)]];
    float4 in_var_ATTRIBUTE4 [[attribute(4)]];
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
    float4 in_var_ATTRIBUTE13 [[attribute(13)]];
    uint4 in_var_ATTRIBUTE14 [[attribute(14)]];
    float4 in_var_ATTRIBUTE15 [[attribute(15)]];
};

vertex Main_out Main_0000197d_1d4e2fad(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_Globals& _Globals [[buffer(3)]], texture_buffer<float> BoneMatrices [[texture(0)]])
{
    Main_out out = {};
    float4 _79 = float4(in.in_var_ATTRIBUTE4.x);
    int _82 = int(in.in_var_ATTRIBUTE3.x) * 3;
    float4 _96 = float4(in.in_var_ATTRIBUTE4.y);
    int _99 = int(in.in_var_ATTRIBUTE3.y) * 3;
    float4 _115 = float4(in.in_var_ATTRIBUTE4.z);
    int _118 = int(in.in_var_ATTRIBUTE3.z) * 3;
    float4 _134 = float4(in.in_var_ATTRIBUTE4.w);
    int _137 = int(in.in_var_ATTRIBUTE3.w) * 3;
    float4 _149 = (((_79 * BoneMatrices.read(uint(uint(_82)))) + (_96 * BoneMatrices.read(uint(uint(_99))))) + (_115 * BoneMatrices.read(uint(uint(_118))))) + (_134 * BoneMatrices.read(uint(uint(_137))));
    float4 _150 = (((_79 * BoneMatrices.read(uint(uint(_82 + 1)))) + (_96 * BoneMatrices.read(uint(uint(_99 + 1))))) + (_115 * BoneMatrices.read(uint(uint(_118 + 1))))) + (_134 * BoneMatrices.read(uint(uint(_137 + 1))));
    float4 _151 = (((_79 * BoneMatrices.read(uint(uint(_82 + 2)))) + (_96 * BoneMatrices.read(uint(uint(_99 + 2))))) + (_115 * BoneMatrices.read(uint(uint(_118 + 2))))) + (_134 * BoneMatrices.read(uint(uint(_137 + 2))));
    float3x4 _235;
    if (_Globals.NumBoneInfluencesParam > 4u)
    {
        float4 _159 = float4(in.in_var_ATTRIBUTE15.x);
        int _162 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _178 = float4(in.in_var_ATTRIBUTE15.y);
        int _181 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _197 = float4(in.in_var_ATTRIBUTE15.z);
        int _200 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _216 = float4(in.in_var_ATTRIBUTE15.w);
        int _219 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _235 = float3x4((((_149 + (_159 * BoneMatrices.read(uint(uint(_162))))) + (_178 * BoneMatrices.read(uint(uint(_181))))) + (_197 * BoneMatrices.read(uint(uint(_200))))) + (_216 * BoneMatrices.read(uint(uint(_219)))), (((_150 + (_159 * BoneMatrices.read(uint(uint(_162 + 1))))) + (_178 * BoneMatrices.read(uint(uint(_181 + 1))))) + (_197 * BoneMatrices.read(uint(uint(_200 + 1))))) + (_216 * BoneMatrices.read(uint(uint(_219 + 1)))), (((_151 + (_159 * BoneMatrices.read(uint(uint(_162 + 2))))) + (_178 * BoneMatrices.read(uint(uint(_181 + 2))))) + (_197 * BoneMatrices.read(uint(uint(_200 + 2))))) + (_216 * BoneMatrices.read(uint(uint(_219 + 2)))));
    }
    else
    {
        _235 = float3x4(_149, _150, _151);
    }
    float3 _241 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _235);
    float3x3 _242 = _62;
    _242[0] = _241;
    float3 _248 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _235);
    float3x3 _249 = _242;
    _249[2] = _248;
    float3x3 _254 = _249;
    _254[1] = normalize(cross(_248, _241) * in.in_var_ATTRIBUTE2.w);
    float3 _255 = in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11;
    float _256 = _255.x;
    float _257 = _255.y;
    float _258 = _255.z;
    float4 _259 = float4(_256, _257, _258, 1.0);
    float3 _260 = _259 * _235;
    float3 _261 = _260 + in.in_var_ATTRIBUTE12;
    float3 _266 = _261.xxx;
    float3 _267 = Primitive.Primitive_LocalToWorld[0u].xyz * _266;
    float3 _271 = _261.yyy;
    float3 _272 = Primitive.Primitive_LocalToWorld[1u].xyz * _271;
    float3 _273 = _267 + _272;
    float3 _277 = _261.zzz;
    float3 _278 = Primitive.Primitive_LocalToWorld[2u].xyz * _277;
    float3 _279 = _273 + _278;
    float3 _283 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _284 = _279 + _283;
    float _285 = _284.x;
    float _286 = _284.y;
    float _287 = _284.z;
    float4 _288 = float4(_285, _286, _287, 1.0);
    float4 _289 = float4(_288.x, _288.y, _288.z, _288.w);
    float4 _292 = View.View_TranslatedWorldToClip * _289;
    float4 _293 = _63;
    _293.w = 0.0;
    float3x3 _306 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _306[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _309 = _306;
    _309[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _312 = _309;
    _312[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _313 = _312 * _254;
    float3 _314 = _313[0];
    out.out_var_TEXCOORD10_centroid = float4(_314.x, _314.y, _314.z, _293.w);
    out.out_var_TEXCOORD11_centroid = float4(_313[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_COLOR0 = in.in_var_ATTRIBUTE13;
    out.out_var_TEXCOORD6 = _289;
    out.gl_Position = _292;
    return out;
}

