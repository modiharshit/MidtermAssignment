

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
    uint InputWeightIndexSize;
};

constant float3x3 _73 = {};
constant float4 _74 = {};

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
    uint in_var_ATTRIBUTE3 [[attribute(3)]];
    float3 in_var_ATTRIBUTE9 [[attribute(9)]];
    float3 in_var_ATTRIBUTE10 [[attribute(10)]];
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
};

vertex MainVertexShader_out Main_00001eaa_726bdc2c(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<uint> InputWeightStream [[texture(0)]], texture_buffer<float> BoneMatrices [[texture(1)]], texture_buffer<float> PreviousBoneMatrices [[texture(2)]])
{
    MainVertexShader_out out = {};
    int _94 = int(in.in_var_ATTRIBUTE3 & 255u);
    uint _97 = uint(int(in.in_var_ATTRIBUTE3 >> 8u));
    int _103 = int(_97 + (_Globals.InputWeightIndexSize * uint(_94)));
    float3x4 _105;
    _105 = float3x4(float4(0.0), float4(0.0), float4(0.0));
    float3x4 _106;
    for (int _108 = 0; _108 < _94; _105 = _106, _108++)
    {
        int _116 = int(_97 + (_Globals.InputWeightIndexSize * uint(_108)));
        int _121 = int(InputWeightStream.read(uint(uint(_116))).x);
        if (_Globals.InputWeightIndexSize > 1u)
        {
            float4 _140 = float4(float(InputWeightStream.read(uint(uint(_103 + _108))).x) * 0.0039215688593685626983642578125);
            int _141 = int((InputWeightStream.read(uint(uint(_116 + 1))).x << 8u) | uint(_121)) * 3;
            _106 = float3x4(_105[0] + (_140 * BoneMatrices.read(uint(uint(_141)))), _105[1] + (_140 * BoneMatrices.read(uint(uint(_141 + 1)))), _105[2] + (_140 * BoneMatrices.read(uint(uint(_141 + 2)))));
        }
        else
        {
            float4 _167 = float4(float(InputWeightStream.read(uint(uint(_103 + _108))).x) * 0.0039215688593685626983642578125);
            int _168 = _121 * 3;
            _106 = float3x4(_105[0] + (_167 * BoneMatrices.read(uint(uint(_168)))), _105[1] + (_167 * BoneMatrices.read(uint(uint(_168 + 1)))), _105[2] + (_167 * BoneMatrices.read(uint(uint(_168 + 2)))));
        }
    }
    float3 _190 = normalize(in.in_var_ATTRIBUTE2.xyz + in.in_var_ATTRIBUTE10);
    float3 _191 = _190.xyz;
    float3 _201 = normalize(float4(normalize(in.in_var_ATTRIBUTE1 - (_191 * dot(in.in_var_ATTRIBUTE1, _191))), 0.0) * _105);
    float3x3 _202 = _73;
    _202[0] = _201;
    float3 _208 = normalize(float4(_190, 0.0) * _105);
    float3x3 _209 = _202;
    _209[2] = _208;
    float3x3 _214 = _209;
    _214[1] = normalize(cross(_208, _201) * in.in_var_ATTRIBUTE2.w);
    float4 _220 = float4((in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE9) + in.in_var_ATTRIBUTE11, 1.0);
    float3 _222 = (_220 * _105) + in.in_var_ATTRIBUTE12;
    float4 _249 = _74;
    _249.w = 0.0;
    float3x3 _262 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _262[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _265 = _262;
    _265[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _268 = _265;
    _268[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _269 = _268 * _214;
    float3 _270 = _269[0];
    float4x4 _285 = Primitive.Primitive_PreviousLocalToWorld;
    _285[3].x = Primitive.Primitive_PreviousLocalToWorld[3].x + View.View_PrevPreViewTranslation.x;
    float4x4 _289 = _285;
    _289[3].y = Primitive.Primitive_PreviousLocalToWorld[3].y + View.View_PrevPreViewTranslation.y;
    float4x4 _293 = _289;
    _293[3].z = Primitive.Primitive_PreviousLocalToWorld[3].z + View.View_PrevPreViewTranslation.z;
    float3x4 _383;
    if (_Globals.PerBoneMotionBlur != 0u)
    {
        float3x4 _300;
        _300 = float3x4(float4(0.0), float4(0.0), float4(0.0));
        float3x4 _301;
        for (int _303 = 0; _303 < _94; _300 = _301, _303++)
        {
            int _311 = int(_97 + (_Globals.InputWeightIndexSize * uint(_303)));
            int _316 = int(InputWeightStream.read(uint(uint(_311))).x);
            if (_Globals.InputWeightIndexSize > 1u)
            {
                float4 _335 = float4(float(InputWeightStream.read(uint(uint(_103 + _303))).x) * 0.0039215688593685626983642578125);
                int _336 = int((InputWeightStream.read(uint(uint(_311 + 1))).x << 8u) | uint(_316)) * 3;
                _301 = float3x4(_300[0] + (_335 * PreviousBoneMatrices.read(uint(uint(_336)))), _300[1] + (_335 * PreviousBoneMatrices.read(uint(uint(_336 + 1)))), _300[2] + (_335 * PreviousBoneMatrices.read(uint(uint(_336 + 2)))));
            }
            else
            {
                float4 _362 = float4(float(InputWeightStream.read(uint(uint(_103 + _303))).x) * 0.0039215688593685626983642578125);
                int _363 = _316 * 3;
                _301 = float3x4(_300[0] + (_362 * PreviousBoneMatrices.read(uint(uint(_363)))), _300[1] + (_362 * PreviousBoneMatrices.read(uint(uint(_363 + 1)))), _300[2] + (_362 * PreviousBoneMatrices.read(uint(uint(_363 + 2)))));
            }
        }
        _383 = _300;
    }
    else
    {
        _383 = _105;
    }
    float4 _397 = View.View_TranslatedWorldToClip * float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _222.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _222.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _222.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
    float4 _406 = _397;
    _406.z = _397.z + ((View.View_NumSceneColorMSAASamples > 1) ? (0.001000000047497451305389404296875 * _397.w) : 0.0);
    out.gl_Position = _406;
    out.out_var_TEXCOORD6 = _397;
    out.out_var_TEXCOORD7 = View.View_PrevTranslatedWorldToClip * float4((_293 * float4((_220 * _383) + in.in_var_ATTRIBUTE12, 1.0)).xyz, 1.0);
    out.out_var_TEXCOORD10_centroid = float4(_270.x, _270.y, _270.z, _249.w);
    out.out_var_TEXCOORD11_centroid = float4(_269[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    return out;
}

