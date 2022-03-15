

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

constant float3x3 _70 = {};
constant float4 _71 = {};

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
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
};

vertex MainVertexShader_out Main_00001d77_4368fa22(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<uint> InputWeightStream [[texture(0)]], texture_buffer<float> BoneMatrices [[texture(1)]], texture_buffer<float> PreviousBoneMatrices [[texture(2)]])
{
    MainVertexShader_out out = {};
    int _89 = int(in.in_var_ATTRIBUTE3 & 255u);
    uint _92 = uint(int(in.in_var_ATTRIBUTE3 >> 8u));
    int _98 = int(_92 + (_Globals.InputWeightIndexSize * uint(_89)));
    float3x4 _100;
    _100 = float3x4(float4(0.0), float4(0.0), float4(0.0));
    float3x4 _101;
    for (int _103 = 0; _103 < _89; _100 = _101, _103++)
    {
        int _111 = int(_92 + (_Globals.InputWeightIndexSize * uint(_103)));
        int _116 = int(InputWeightStream.read(uint(uint(_111))).x);
        if (_Globals.InputWeightIndexSize > 1u)
        {
            float4 _135 = float4(float(InputWeightStream.read(uint(uint(_98 + _103))).x) * 0.0039215688593685626983642578125);
            int _136 = int((InputWeightStream.read(uint(uint(_111 + 1))).x << 8u) | uint(_116)) * 3;
            _101 = float3x4(_100[0] + (_135 * BoneMatrices.read(uint(uint(_136)))), _100[1] + (_135 * BoneMatrices.read(uint(uint(_136 + 1)))), _100[2] + (_135 * BoneMatrices.read(uint(uint(_136 + 2)))));
        }
        else
        {
            float4 _162 = float4(float(InputWeightStream.read(uint(uint(_98 + _103))).x) * 0.0039215688593685626983642578125);
            int _163 = _116 * 3;
            _101 = float3x4(_100[0] + (_162 * BoneMatrices.read(uint(uint(_163)))), _100[1] + (_162 * BoneMatrices.read(uint(uint(_163 + 1)))), _100[2] + (_162 * BoneMatrices.read(uint(uint(_163 + 2)))));
        }
    }
    float3 _188 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _100);
    float3x3 _189 = _70;
    _189[0] = _188;
    float3 _195 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _100);
    float3x3 _196 = _189;
    _196[2] = _195;
    float3x3 _201 = _196;
    _201[1] = normalize(cross(_195, _188) * in.in_var_ATTRIBUTE2.w);
    float4 _206 = float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0);
    float3 _208 = (_206 * _100) + in.in_var_ATTRIBUTE12;
    float4 _235 = _71;
    _235.w = 0.0;
    float3x3 _248 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _248[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _251 = _248;
    _251[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _254 = _251;
    _254[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _255 = _254 * _201;
    float3 _256 = _255[0];
    float4x4 _271 = Primitive.Primitive_PreviousLocalToWorld;
    _271[3].x = Primitive.Primitive_PreviousLocalToWorld[3].x + View.View_PrevPreViewTranslation.x;
    float4x4 _275 = _271;
    _275[3].y = Primitive.Primitive_PreviousLocalToWorld[3].y + View.View_PrevPreViewTranslation.y;
    float4x4 _279 = _275;
    _279[3].z = Primitive.Primitive_PreviousLocalToWorld[3].z + View.View_PrevPreViewTranslation.z;
    float3x4 _369;
    if (_Globals.PerBoneMotionBlur != 0u)
    {
        float3x4 _286;
        _286 = float3x4(float4(0.0), float4(0.0), float4(0.0));
        float3x4 _287;
        for (int _289 = 0; _289 < _89; _286 = _287, _289++)
        {
            int _297 = int(_92 + (_Globals.InputWeightIndexSize * uint(_289)));
            int _302 = int(InputWeightStream.read(uint(uint(_297))).x);
            if (_Globals.InputWeightIndexSize > 1u)
            {
                float4 _321 = float4(float(InputWeightStream.read(uint(uint(_98 + _289))).x) * 0.0039215688593685626983642578125);
                int _322 = int((InputWeightStream.read(uint(uint(_297 + 1))).x << 8u) | uint(_302)) * 3;
                _287 = float3x4(_286[0] + (_321 * PreviousBoneMatrices.read(uint(uint(_322)))), _286[1] + (_321 * PreviousBoneMatrices.read(uint(uint(_322 + 1)))), _286[2] + (_321 * PreviousBoneMatrices.read(uint(uint(_322 + 2)))));
            }
            else
            {
                float4 _348 = float4(float(InputWeightStream.read(uint(uint(_98 + _289))).x) * 0.0039215688593685626983642578125);
                int _349 = _302 * 3;
                _287 = float3x4(_286[0] + (_348 * PreviousBoneMatrices.read(uint(uint(_349)))), _286[1] + (_348 * PreviousBoneMatrices.read(uint(uint(_349 + 1)))), _286[2] + (_348 * PreviousBoneMatrices.read(uint(uint(_349 + 2)))));
            }
        }
        _369 = _286;
    }
    else
    {
        _369 = _100;
    }
    float4 _383 = View.View_TranslatedWorldToClip * float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _208.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _208.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _208.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
    float4 _392 = _383;
    _392.z = _383.z + ((View.View_NumSceneColorMSAASamples > 1) ? (0.001000000047497451305389404296875 * _383.w) : 0.0);
    out.gl_Position = _392;
    out.out_var_TEXCOORD6 = _383;
    out.out_var_TEXCOORD7 = View.View_PrevTranslatedWorldToClip * float4((_279 * float4((_206 * _369) + in.in_var_ATTRIBUTE12, 1.0)).xyz, 1.0);
    out.out_var_TEXCOORD10_centroid = float4(_256.x, _256.y, _256.z, _235.w);
    out.out_var_TEXCOORD11_centroid = float4(_255[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    return out;
}

