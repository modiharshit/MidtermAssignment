

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

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
};

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
    float4 Primitive_InvNonUniformScaleAndDeterminantSign;
    char _m2_pad[80];
    float4x4 Primitive_PreviousLocalToWorld;
};

struct type_Globals
{
    uint PerBoneMotionBlur;
    uint NumBoneInfluencesParam;
};

constant float3x3 _68 = {};
constant float4 _69 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float4 out_var_TEXCOORD7 [[user(locn1)]];
    float4 out_var_TEXCOORD10_centroid [[user(locn2)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVertexShader_in
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

vertex MainVertexShader_out Main_00002663_9a60de69(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]], texture_buffer<float> BoneMatrices [[texture(0)]], texture_buffer<float> PreviousBoneMatrices [[texture(1)]])
{
    MainVertexShader_out out = {};
    float4 _92 = float4(in.in_var_ATTRIBUTE4.x);
    int _95 = int(in.in_var_ATTRIBUTE3.x) * 3;
    uint _96 = uint(_95);
    uint _100 = uint(_95 + 1);
    uint _103 = uint(_95 + 2);
    float4 _109 = float4(in.in_var_ATTRIBUTE4.y);
    int _112 = int(in.in_var_ATTRIBUTE3.y) * 3;
    uint _113 = uint(_112);
    uint _116 = uint(_112 + 1);
    uint _119 = uint(_112 + 2);
    float4 _128 = float4(in.in_var_ATTRIBUTE4.z);
    int _131 = int(in.in_var_ATTRIBUTE3.z) * 3;
    uint _132 = uint(_131);
    uint _135 = uint(_131 + 1);
    uint _138 = uint(_131 + 2);
    float4 _147 = float4(in.in_var_ATTRIBUTE4.w);
    int _150 = int(in.in_var_ATTRIBUTE3.w) * 3;
    uint _151 = uint(_150);
    uint _154 = uint(_150 + 1);
    uint _157 = uint(_150 + 2);
    float4 _162 = (((_92 * BoneMatrices.read(uint(_96))) + (_109 * BoneMatrices.read(uint(_113)))) + (_128 * BoneMatrices.read(uint(_132)))) + (_147 * BoneMatrices.read(uint(_151)));
    float4 _163 = (((_92 * BoneMatrices.read(uint(_100))) + (_109 * BoneMatrices.read(uint(_116)))) + (_128 * BoneMatrices.read(uint(_135)))) + (_147 * BoneMatrices.read(uint(_154)));
    float4 _164 = (((_92 * BoneMatrices.read(uint(_103))) + (_109 * BoneMatrices.read(uint(_119)))) + (_128 * BoneMatrices.read(uint(_138)))) + (_147 * BoneMatrices.read(uint(_157)));
    bool _168 = _Globals.NumBoneInfluencesParam > 4u;
    float3x4 _248;
    if (_168)
    {
        float4 _172 = float4(in.in_var_ATTRIBUTE15.x);
        int _175 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _191 = float4(in.in_var_ATTRIBUTE15.y);
        int _194 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _210 = float4(in.in_var_ATTRIBUTE15.z);
        int _213 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _229 = float4(in.in_var_ATTRIBUTE15.w);
        int _232 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _248 = float3x4((((_162 + (_172 * BoneMatrices.read(uint(uint(_175))))) + (_191 * BoneMatrices.read(uint(uint(_194))))) + (_210 * BoneMatrices.read(uint(uint(_213))))) + (_229 * BoneMatrices.read(uint(uint(_232)))), (((_163 + (_172 * BoneMatrices.read(uint(uint(_175 + 1))))) + (_191 * BoneMatrices.read(uint(uint(_194 + 1))))) + (_210 * BoneMatrices.read(uint(uint(_213 + 1))))) + (_229 * BoneMatrices.read(uint(uint(_232 + 1)))), (((_164 + (_172 * BoneMatrices.read(uint(uint(_175 + 2))))) + (_191 * BoneMatrices.read(uint(uint(_194 + 2))))) + (_210 * BoneMatrices.read(uint(uint(_213 + 2))))) + (_229 * BoneMatrices.read(uint(uint(_232 + 2)))));
    }
    else
    {
        _248 = float3x4(_162, _163, _164);
    }
    float3 _251 = normalize(in.in_var_ATTRIBUTE2.xyz + in.in_var_ATTRIBUTE10);
    float3 _252 = _251.xyz;
    float3 _262 = normalize(float4(normalize(in.in_var_ATTRIBUTE1 - (_252 * dot(in.in_var_ATTRIBUTE1, _252))), 0.0) * _248);
    float3x3 _263 = _68;
    _263[0] = _262;
    float3 _269 = normalize(float4(_251, 0.0) * _248);
    float3x3 _270 = _263;
    _270[2] = _269;
    float3x3 _275 = _270;
    _275[1] = normalize(cross(_269, _262) * in.in_var_ATTRIBUTE2.w);
    float4 _281 = float4((in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE9) + in.in_var_ATTRIBUTE11, 1.0);
    float3 _283 = (_281 * _248) + in.in_var_ATTRIBUTE12;
    float4 _310 = _69;
    _310.w = 0.0;
    float3x3 _323 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _323[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _326 = _323;
    _326[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _329 = _326;
    _329[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _330 = _329 * _275;
    float3 _331 = _330[0];
    float4x4 _346 = Primitive.Primitive_PreviousLocalToWorld;
    _346[3].x = Primitive.Primitive_PreviousLocalToWorld[3].x + View.View_PrevPreViewTranslation.x;
    float4x4 _350 = _346;
    _350[3].y = Primitive.Primitive_PreviousLocalToWorld[3].y + View.View_PrevPreViewTranslation.y;
    float4x4 _354 = _350;
    _354[3].z = Primitive.Primitive_PreviousLocalToWorld[3].z + View.View_PrevPreViewTranslation.z;
    float3x4 _475;
    if (_Globals.PerBoneMotionBlur != 0u)
    {
        float4 _391 = (((_92 * PreviousBoneMatrices.read(uint(_96))) + (_109 * PreviousBoneMatrices.read(uint(_113)))) + (_128 * PreviousBoneMatrices.read(uint(_132)))) + (_147 * PreviousBoneMatrices.read(uint(_151)));
        float4 _392 = (((_92 * PreviousBoneMatrices.read(uint(_100))) + (_109 * PreviousBoneMatrices.read(uint(_116)))) + (_128 * PreviousBoneMatrices.read(uint(_135)))) + (_147 * PreviousBoneMatrices.read(uint(_154)));
        float4 _393 = (((_92 * PreviousBoneMatrices.read(uint(_103))) + (_109 * PreviousBoneMatrices.read(uint(_119)))) + (_128 * PreviousBoneMatrices.read(uint(_138)))) + (_147 * PreviousBoneMatrices.read(uint(_157)));
        float3x4 _474;
        if (_168)
        {
            float4 _398 = float4(in.in_var_ATTRIBUTE15.x);
            int _401 = int(in.in_var_ATTRIBUTE14.x) * 3;
            float4 _417 = float4(in.in_var_ATTRIBUTE15.y);
            int _420 = int(in.in_var_ATTRIBUTE14.y) * 3;
            float4 _436 = float4(in.in_var_ATTRIBUTE15.z);
            int _439 = int(in.in_var_ATTRIBUTE14.z) * 3;
            float4 _455 = float4(in.in_var_ATTRIBUTE15.w);
            int _458 = int(in.in_var_ATTRIBUTE14.w) * 3;
            _474 = float3x4((((_391 + (_398 * PreviousBoneMatrices.read(uint(uint(_401))))) + (_417 * PreviousBoneMatrices.read(uint(uint(_420))))) + (_436 * PreviousBoneMatrices.read(uint(uint(_439))))) + (_455 * PreviousBoneMatrices.read(uint(uint(_458)))), (((_392 + (_398 * PreviousBoneMatrices.read(uint(uint(_401 + 1))))) + (_417 * PreviousBoneMatrices.read(uint(uint(_420 + 1))))) + (_436 * PreviousBoneMatrices.read(uint(uint(_439 + 1))))) + (_455 * PreviousBoneMatrices.read(uint(uint(_458 + 1)))), (((_393 + (_398 * PreviousBoneMatrices.read(uint(uint(_401 + 2))))) + (_417 * PreviousBoneMatrices.read(uint(uint(_420 + 2))))) + (_436 * PreviousBoneMatrices.read(uint(uint(_439 + 2))))) + (_455 * PreviousBoneMatrices.read(uint(uint(_458 + 2)))));
        }
        else
        {
            _474 = float3x4(_391, _392, _393);
        }
        _475 = _474;
    }
    else
    {
        _475 = _248;
    }
    float4 _489 = View.View_TranslatedWorldToClip * float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _283.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _283.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _283.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
    float4 _498 = _489;
    _498.z = _489.z + ((View.View_NumSceneColorMSAASamples > 1) ? (0.001000000047497451305389404296875 * _489.w) : 0.0);
    out.gl_Position = _498;
    out.out_var_TEXCOORD6 = _489;
    out.out_var_TEXCOORD7 = View.View_PrevTranslatedWorldToClip * float4((_354 * float4((_281 * _475) + in.in_var_ATTRIBUTE12, 1.0)).xyz, 1.0);
    out.out_var_TEXCOORD10_centroid = float4(_331.x, _331.y, _331.z, _310.w);
    out.out_var_TEXCOORD11_centroid = float4(_330[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    return out;
}

