

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

constant float3x3 _66 = {};
constant float4 _67 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float4 out_var_TEXCOORD7 [[user(locn1)]];
    float4 out_var_TEXCOORD10_centroid [[user(locn2)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn3)]];
    float4 out_var_COLOR0 [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVertexShader_in
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

vertex MainVertexShader_out Main_000025c0_d1ac2714(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]], texture_buffer<float> BoneMatrices [[texture(0)]], texture_buffer<float> PreviousBoneMatrices [[texture(1)]])
{
    MainVertexShader_out out = {};
    float4 _89 = float4(in.in_var_ATTRIBUTE4.x);
    int _92 = int(in.in_var_ATTRIBUTE3.x) * 3;
    uint _93 = uint(_92);
    uint _97 = uint(_92 + 1);
    uint _100 = uint(_92 + 2);
    float4 _106 = float4(in.in_var_ATTRIBUTE4.y);
    int _109 = int(in.in_var_ATTRIBUTE3.y) * 3;
    uint _110 = uint(_109);
    uint _113 = uint(_109 + 1);
    uint _116 = uint(_109 + 2);
    float4 _125 = float4(in.in_var_ATTRIBUTE4.z);
    int _128 = int(in.in_var_ATTRIBUTE3.z) * 3;
    uint _129 = uint(_128);
    uint _132 = uint(_128 + 1);
    uint _135 = uint(_128 + 2);
    float4 _144 = float4(in.in_var_ATTRIBUTE4.w);
    int _147 = int(in.in_var_ATTRIBUTE3.w) * 3;
    uint _148 = uint(_147);
    uint _151 = uint(_147 + 1);
    uint _154 = uint(_147 + 2);
    float4 _159 = (((_89 * BoneMatrices.read(uint(_93))) + (_106 * BoneMatrices.read(uint(_110)))) + (_125 * BoneMatrices.read(uint(_129)))) + (_144 * BoneMatrices.read(uint(_148)));
    float4 _160 = (((_89 * BoneMatrices.read(uint(_97))) + (_106 * BoneMatrices.read(uint(_113)))) + (_125 * BoneMatrices.read(uint(_132)))) + (_144 * BoneMatrices.read(uint(_151)));
    float4 _161 = (((_89 * BoneMatrices.read(uint(_100))) + (_106 * BoneMatrices.read(uint(_116)))) + (_125 * BoneMatrices.read(uint(_135)))) + (_144 * BoneMatrices.read(uint(_154)));
    bool _165 = _Globals.NumBoneInfluencesParam > 4u;
    float3x4 _245;
    if (_165)
    {
        float4 _169 = float4(in.in_var_ATTRIBUTE15.x);
        int _172 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _188 = float4(in.in_var_ATTRIBUTE15.y);
        int _191 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _207 = float4(in.in_var_ATTRIBUTE15.z);
        int _210 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _226 = float4(in.in_var_ATTRIBUTE15.w);
        int _229 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _245 = float3x4((((_159 + (_169 * BoneMatrices.read(uint(uint(_172))))) + (_188 * BoneMatrices.read(uint(uint(_191))))) + (_207 * BoneMatrices.read(uint(uint(_210))))) + (_226 * BoneMatrices.read(uint(uint(_229)))), (((_160 + (_169 * BoneMatrices.read(uint(uint(_172 + 1))))) + (_188 * BoneMatrices.read(uint(uint(_191 + 1))))) + (_207 * BoneMatrices.read(uint(uint(_210 + 1))))) + (_226 * BoneMatrices.read(uint(uint(_229 + 1)))), (((_161 + (_169 * BoneMatrices.read(uint(uint(_172 + 2))))) + (_188 * BoneMatrices.read(uint(uint(_191 + 2))))) + (_207 * BoneMatrices.read(uint(uint(_210 + 2))))) + (_226 * BoneMatrices.read(uint(uint(_229 + 2)))));
    }
    else
    {
        _245 = float3x4(_159, _160, _161);
    }
    float3 _251 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _245);
    float3x3 _252 = _66;
    _252[0] = _251;
    float3 _258 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _245);
    float3x3 _259 = _252;
    _259[2] = _258;
    float3x3 _264 = _259;
    _264[1] = normalize(cross(_258, _251) * in.in_var_ATTRIBUTE2.w);
    float4 _269 = float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0);
    float3 _271 = (_269 * _245) + in.in_var_ATTRIBUTE12;
    float4 _298 = _67;
    _298.w = 0.0;
    float3x3 _311 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _311[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _314 = _311;
    _314[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _317 = _314;
    _317[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _318 = _317 * _264;
    float3 _319 = _318[0];
    float4x4 _334 = Primitive.Primitive_PreviousLocalToWorld;
    _334[3].x = Primitive.Primitive_PreviousLocalToWorld[3].x + View.View_PrevPreViewTranslation.x;
    float4x4 _338 = _334;
    _338[3].y = Primitive.Primitive_PreviousLocalToWorld[3].y + View.View_PrevPreViewTranslation.y;
    float4x4 _342 = _338;
    _342[3].z = Primitive.Primitive_PreviousLocalToWorld[3].z + View.View_PrevPreViewTranslation.z;
    float3x4 _463;
    if (_Globals.PerBoneMotionBlur != 0u)
    {
        float4 _379 = (((_89 * PreviousBoneMatrices.read(uint(_93))) + (_106 * PreviousBoneMatrices.read(uint(_110)))) + (_125 * PreviousBoneMatrices.read(uint(_129)))) + (_144 * PreviousBoneMatrices.read(uint(_148)));
        float4 _380 = (((_89 * PreviousBoneMatrices.read(uint(_97))) + (_106 * PreviousBoneMatrices.read(uint(_113)))) + (_125 * PreviousBoneMatrices.read(uint(_132)))) + (_144 * PreviousBoneMatrices.read(uint(_151)));
        float4 _381 = (((_89 * PreviousBoneMatrices.read(uint(_100))) + (_106 * PreviousBoneMatrices.read(uint(_116)))) + (_125 * PreviousBoneMatrices.read(uint(_135)))) + (_144 * PreviousBoneMatrices.read(uint(_154)));
        float3x4 _462;
        if (_165)
        {
            float4 _386 = float4(in.in_var_ATTRIBUTE15.x);
            int _389 = int(in.in_var_ATTRIBUTE14.x) * 3;
            float4 _405 = float4(in.in_var_ATTRIBUTE15.y);
            int _408 = int(in.in_var_ATTRIBUTE14.y) * 3;
            float4 _424 = float4(in.in_var_ATTRIBUTE15.z);
            int _427 = int(in.in_var_ATTRIBUTE14.z) * 3;
            float4 _443 = float4(in.in_var_ATTRIBUTE15.w);
            int _446 = int(in.in_var_ATTRIBUTE14.w) * 3;
            _462 = float3x4((((_379 + (_386 * PreviousBoneMatrices.read(uint(uint(_389))))) + (_405 * PreviousBoneMatrices.read(uint(uint(_408))))) + (_424 * PreviousBoneMatrices.read(uint(uint(_427))))) + (_443 * PreviousBoneMatrices.read(uint(uint(_446)))), (((_380 + (_386 * PreviousBoneMatrices.read(uint(uint(_389 + 1))))) + (_405 * PreviousBoneMatrices.read(uint(uint(_408 + 1))))) + (_424 * PreviousBoneMatrices.read(uint(uint(_427 + 1))))) + (_443 * PreviousBoneMatrices.read(uint(uint(_446 + 1)))), (((_381 + (_386 * PreviousBoneMatrices.read(uint(uint(_389 + 2))))) + (_405 * PreviousBoneMatrices.read(uint(uint(_408 + 2))))) + (_424 * PreviousBoneMatrices.read(uint(uint(_427 + 2))))) + (_443 * PreviousBoneMatrices.read(uint(uint(_446 + 2)))));
        }
        else
        {
            _462 = float3x4(_379, _380, _381);
        }
        _463 = _462;
    }
    else
    {
        _463 = _245;
    }
    float4 _477 = View.View_TranslatedWorldToClip * float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _271.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _271.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _271.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
    float4 _486 = _477;
    _486.z = _477.z + ((View.View_NumSceneColorMSAASamples > 1) ? (0.001000000047497451305389404296875 * _477.w) : 0.0);
    out.gl_Position = _486;
    out.out_var_TEXCOORD6 = _477;
    out.out_var_TEXCOORD7 = View.View_PrevTranslatedWorldToClip * float4((_342 * float4((_269 * _463) + in.in_var_ATTRIBUTE12, 1.0)).xyz, 1.0);
    out.out_var_TEXCOORD10_centroid = float4(_319.x, _319.y, _319.z, _298.w);
    out.out_var_TEXCOORD11_centroid = float4(_318[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_COLOR0 = in.in_var_ATTRIBUTE13;
    return out;
}

