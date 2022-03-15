

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

constant float3x3 _65 = {};
constant float4 _66 = {};

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
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
    uint4 in_var_ATTRIBUTE14 [[attribute(14)]];
    float4 in_var_ATTRIBUTE15 [[attribute(15)]];
};

vertex MainVertexShader_out Main_0000252f_8cefe15b(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]], texture_buffer<float> BoneMatrices [[texture(0)]], texture_buffer<float> PreviousBoneMatrices [[texture(1)]])
{
    MainVertexShader_out out = {};
    float4 _87 = float4(in.in_var_ATTRIBUTE4.x);
    int _90 = int(in.in_var_ATTRIBUTE3.x) * 3;
    uint _91 = uint(_90);
    uint _95 = uint(_90 + 1);
    uint _98 = uint(_90 + 2);
    float4 _104 = float4(in.in_var_ATTRIBUTE4.y);
    int _107 = int(in.in_var_ATTRIBUTE3.y) * 3;
    uint _108 = uint(_107);
    uint _111 = uint(_107 + 1);
    uint _114 = uint(_107 + 2);
    float4 _123 = float4(in.in_var_ATTRIBUTE4.z);
    int _126 = int(in.in_var_ATTRIBUTE3.z) * 3;
    uint _127 = uint(_126);
    uint _130 = uint(_126 + 1);
    uint _133 = uint(_126 + 2);
    float4 _142 = float4(in.in_var_ATTRIBUTE4.w);
    int _145 = int(in.in_var_ATTRIBUTE3.w) * 3;
    uint _146 = uint(_145);
    uint _149 = uint(_145 + 1);
    uint _152 = uint(_145 + 2);
    float4 _157 = (((_87 * BoneMatrices.read(uint(_91))) + (_104 * BoneMatrices.read(uint(_108)))) + (_123 * BoneMatrices.read(uint(_127)))) + (_142 * BoneMatrices.read(uint(_146)));
    float4 _158 = (((_87 * BoneMatrices.read(uint(_95))) + (_104 * BoneMatrices.read(uint(_111)))) + (_123 * BoneMatrices.read(uint(_130)))) + (_142 * BoneMatrices.read(uint(_149)));
    float4 _159 = (((_87 * BoneMatrices.read(uint(_98))) + (_104 * BoneMatrices.read(uint(_114)))) + (_123 * BoneMatrices.read(uint(_133)))) + (_142 * BoneMatrices.read(uint(_152)));
    bool _163 = _Globals.NumBoneInfluencesParam > 4u;
    float3x4 _243;
    if (_163)
    {
        float4 _167 = float4(in.in_var_ATTRIBUTE15.x);
        int _170 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _186 = float4(in.in_var_ATTRIBUTE15.y);
        int _189 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _205 = float4(in.in_var_ATTRIBUTE15.z);
        int _208 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _224 = float4(in.in_var_ATTRIBUTE15.w);
        int _227 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _243 = float3x4((((_157 + (_167 * BoneMatrices.read(uint(uint(_170))))) + (_186 * BoneMatrices.read(uint(uint(_189))))) + (_205 * BoneMatrices.read(uint(uint(_208))))) + (_224 * BoneMatrices.read(uint(uint(_227)))), (((_158 + (_167 * BoneMatrices.read(uint(uint(_170 + 1))))) + (_186 * BoneMatrices.read(uint(uint(_189 + 1))))) + (_205 * BoneMatrices.read(uint(uint(_208 + 1))))) + (_224 * BoneMatrices.read(uint(uint(_227 + 1)))), (((_159 + (_167 * BoneMatrices.read(uint(uint(_170 + 2))))) + (_186 * BoneMatrices.read(uint(uint(_189 + 2))))) + (_205 * BoneMatrices.read(uint(uint(_208 + 2))))) + (_224 * BoneMatrices.read(uint(uint(_227 + 2)))));
    }
    else
    {
        _243 = float3x4(_157, _158, _159);
    }
    float3 _249 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _243);
    float3x3 _250 = _65;
    _250[0] = _249;
    float3 _256 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _243);
    float3x3 _257 = _250;
    _257[2] = _256;
    float3x3 _262 = _257;
    _262[1] = normalize(cross(_256, _249) * in.in_var_ATTRIBUTE2.w);
    float4 _267 = float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0);
    float3 _269 = (_267 * _243) + in.in_var_ATTRIBUTE12;
    float4 _296 = _66;
    _296.w = 0.0;
    float3x3 _309 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _309[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _312 = _309;
    _312[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _315 = _312;
    _315[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _316 = _315 * _262;
    float3 _317 = _316[0];
    float4x4 _332 = Primitive.Primitive_PreviousLocalToWorld;
    _332[3].x = Primitive.Primitive_PreviousLocalToWorld[3].x + View.View_PrevPreViewTranslation.x;
    float4x4 _336 = _332;
    _336[3].y = Primitive.Primitive_PreviousLocalToWorld[3].y + View.View_PrevPreViewTranslation.y;
    float4x4 _340 = _336;
    _340[3].z = Primitive.Primitive_PreviousLocalToWorld[3].z + View.View_PrevPreViewTranslation.z;
    float3x4 _461;
    if (_Globals.PerBoneMotionBlur != 0u)
    {
        float4 _377 = (((_87 * PreviousBoneMatrices.read(uint(_91))) + (_104 * PreviousBoneMatrices.read(uint(_108)))) + (_123 * PreviousBoneMatrices.read(uint(_127)))) + (_142 * PreviousBoneMatrices.read(uint(_146)));
        float4 _378 = (((_87 * PreviousBoneMatrices.read(uint(_95))) + (_104 * PreviousBoneMatrices.read(uint(_111)))) + (_123 * PreviousBoneMatrices.read(uint(_130)))) + (_142 * PreviousBoneMatrices.read(uint(_149)));
        float4 _379 = (((_87 * PreviousBoneMatrices.read(uint(_98))) + (_104 * PreviousBoneMatrices.read(uint(_114)))) + (_123 * PreviousBoneMatrices.read(uint(_133)))) + (_142 * PreviousBoneMatrices.read(uint(_152)));
        float3x4 _460;
        if (_163)
        {
            float4 _384 = float4(in.in_var_ATTRIBUTE15.x);
            int _387 = int(in.in_var_ATTRIBUTE14.x) * 3;
            float4 _403 = float4(in.in_var_ATTRIBUTE15.y);
            int _406 = int(in.in_var_ATTRIBUTE14.y) * 3;
            float4 _422 = float4(in.in_var_ATTRIBUTE15.z);
            int _425 = int(in.in_var_ATTRIBUTE14.z) * 3;
            float4 _441 = float4(in.in_var_ATTRIBUTE15.w);
            int _444 = int(in.in_var_ATTRIBUTE14.w) * 3;
            _460 = float3x4((((_377 + (_384 * PreviousBoneMatrices.read(uint(uint(_387))))) + (_403 * PreviousBoneMatrices.read(uint(uint(_406))))) + (_422 * PreviousBoneMatrices.read(uint(uint(_425))))) + (_441 * PreviousBoneMatrices.read(uint(uint(_444)))), (((_378 + (_384 * PreviousBoneMatrices.read(uint(uint(_387 + 1))))) + (_403 * PreviousBoneMatrices.read(uint(uint(_406 + 1))))) + (_422 * PreviousBoneMatrices.read(uint(uint(_425 + 1))))) + (_441 * PreviousBoneMatrices.read(uint(uint(_444 + 1)))), (((_379 + (_384 * PreviousBoneMatrices.read(uint(uint(_387 + 2))))) + (_403 * PreviousBoneMatrices.read(uint(uint(_406 + 2))))) + (_422 * PreviousBoneMatrices.read(uint(uint(_425 + 2))))) + (_441 * PreviousBoneMatrices.read(uint(uint(_444 + 2)))));
        }
        else
        {
            _460 = float3x4(_377, _378, _379);
        }
        _461 = _460;
    }
    else
    {
        _461 = _243;
    }
    float4 _475 = View.View_TranslatedWorldToClip * float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _269.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _269.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _269.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
    float4 _484 = _475;
    _484.z = _475.z + ((View.View_NumSceneColorMSAASamples > 1) ? (0.001000000047497451305389404296875 * _475.w) : 0.0);
    out.gl_Position = _484;
    out.out_var_TEXCOORD6 = _475;
    out.out_var_TEXCOORD7 = View.View_PrevTranslatedWorldToClip * float4((_340 * float4((_267 * _461) + in.in_var_ATTRIBUTE12, 1.0)).xyz, 1.0);
    out.out_var_TEXCOORD10_centroid = float4(_317.x, _317.y, _317.z, _296.w);
    out.out_var_TEXCOORD11_centroid = float4(_316[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    return out;
}

