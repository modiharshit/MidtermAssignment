

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
};

struct type_Globals
{
    uint InputWeightIndexSize;
};

struct Main_out
{
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    uint in_var_ATTRIBUTE3 [[attribute(3)]];
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
};

vertex Main_out Main_00000ec0_f0b73e17(Main_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]], texture_buffer<uint> InputWeightStream [[texture(0)]], texture_buffer<float> BoneMatrices [[texture(1)]])
{
    Main_out out = {};
    int _75 = int(in.in_var_ATTRIBUTE3 & 255u);
    uint _78 = uint(int(in.in_var_ATTRIBUTE3 >> 8u));
    int _84 = int(_78 + (_Globals.InputWeightIndexSize * uint(_75)));
    float3x4 _86;
    _86 = float3x4(float4(0.0), float4(0.0), float4(0.0));
    float3x4 _87;
    for (int _89 = 0; _89 < _75; _86 = _87, _89++)
    {
        int _97 = int(_78 + (_Globals.InputWeightIndexSize * uint(_89)));
        int _102 = int(InputWeightStream.read(uint(uint(_97))).x);
        if (_Globals.InputWeightIndexSize > 1u)
        {
            float4 _121 = float4(float(InputWeightStream.read(uint(uint(_84 + _89))).x) * 0.0039215688593685626983642578125);
            int _122 = int((InputWeightStream.read(uint(uint(_97 + 1))).x << 8u) | uint(_102)) * 3;
            _87 = float3x4(_86[0] + (_121 * BoneMatrices.read(uint(uint(_122)))), _86[1] + (_121 * BoneMatrices.read(uint(uint(_122 + 1)))), _86[2] + (_121 * BoneMatrices.read(uint(uint(_122 + 2)))));
        }
        else
        {
            float4 _148 = float4(float(InputWeightStream.read(uint(uint(_84 + _89))).x) * 0.0039215688593685626983642578125);
            int _149 = _102 * 3;
            _87 = float3x4(_86[0] + (_148 * BoneMatrices.read(uint(uint(_149)))), _86[1] + (_148 * BoneMatrices.read(uint(uint(_149 + 1)))), _86[2] + (_148 * BoneMatrices.read(uint(uint(_149 + 2)))));
        }
    }
    float3 _169 = in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11;
    float _170 = _169.x;
    float _171 = _169.y;
    float _172 = _169.z;
    float4 _173 = float4(_170, _171, _172, 1.0);
    float3 _174 = _173 * _86;
    float3 _175 = _174 + in.in_var_ATTRIBUTE12;
    float3 _179 = _175.xxx;
    float3 _180 = Primitive.Primitive_LocalToWorld[0u].xyz * _179;
    float3 _184 = _175.yyy;
    float3 _185 = Primitive.Primitive_LocalToWorld[1u].xyz * _184;
    float3 _186 = _180 + _185;
    float3 _190 = _175.zzz;
    float3 _191 = Primitive.Primitive_LocalToWorld[2u].xyz * _190;
    float3 _192 = _186 + _191;
    float3 _196 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _197 = _192 + _196;
    float _198 = _197.x;
    float _199 = _197.y;
    float _200 = _197.z;
    float4 _201 = float4(_198, _199, _200, 1.0);
    float4 _202 = float4(_201.x, _201.y, _201.z, _201.w);
    float4 _203 = View.View_TranslatedWorldToClip * _202;
    out.gl_Position = _203;
    return out;
}

