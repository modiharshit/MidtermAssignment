

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
    float3 in_var_ATTRIBUTE9 [[attribute(9)]];
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
};

vertex Main_out Main_00000f49_5391b75c(Main_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]], texture_buffer<uint> InputWeightStream [[texture(0)]], texture_buffer<float> BoneMatrices [[texture(1)]])
{
    Main_out out = {};
    int _78 = int(in.in_var_ATTRIBUTE3 & 255u);
    uint _81 = uint(int(in.in_var_ATTRIBUTE3 >> 8u));
    int _87 = int(_81 + (_Globals.InputWeightIndexSize * uint(_78)));
    float3x4 _89;
    _89 = float3x4(float4(0.0), float4(0.0), float4(0.0));
    float3x4 _90;
    for (int _92 = 0; _92 < _78; _89 = _90, _92++)
    {
        int _100 = int(_81 + (_Globals.InputWeightIndexSize * uint(_92)));
        int _105 = int(InputWeightStream.read(uint(uint(_100))).x);
        if (_Globals.InputWeightIndexSize > 1u)
        {
            float4 _124 = float4(float(InputWeightStream.read(uint(uint(_87 + _92))).x) * 0.0039215688593685626983642578125);
            int _125 = int((InputWeightStream.read(uint(uint(_100 + 1))).x << 8u) | uint(_105)) * 3;
            _90 = float3x4(_89[0] + (_124 * BoneMatrices.read(uint(uint(_125)))), _89[1] + (_124 * BoneMatrices.read(uint(uint(_125 + 1)))), _89[2] + (_124 * BoneMatrices.read(uint(uint(_125 + 2)))));
        }
        else
        {
            float4 _151 = float4(float(InputWeightStream.read(uint(uint(_87 + _92))).x) * 0.0039215688593685626983642578125);
            int _152 = _105 * 3;
            _90 = float3x4(_89[0] + (_151 * BoneMatrices.read(uint(uint(_152)))), _89[1] + (_151 * BoneMatrices.read(uint(uint(_152 + 1)))), _89[2] + (_151 * BoneMatrices.read(uint(uint(_152 + 2)))));
        }
    }
    float3 _172 = in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE9;
    float3 _173 = _172 + in.in_var_ATTRIBUTE11;
    float _174 = _173.x;
    float _175 = _173.y;
    float _176 = _173.z;
    float4 _177 = float4(_174, _175, _176, 1.0);
    float3 _178 = _177 * _89;
    float3 _179 = _178 + in.in_var_ATTRIBUTE12;
    float3 _183 = _179.xxx;
    float3 _184 = Primitive.Primitive_LocalToWorld[0u].xyz * _183;
    float3 _188 = _179.yyy;
    float3 _189 = Primitive.Primitive_LocalToWorld[1u].xyz * _188;
    float3 _190 = _184 + _189;
    float3 _194 = _179.zzz;
    float3 _195 = Primitive.Primitive_LocalToWorld[2u].xyz * _194;
    float3 _196 = _190 + _195;
    float3 _200 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _201 = _196 + _200;
    float _202 = _201.x;
    float _203 = _201.y;
    float _204 = _201.z;
    float4 _205 = float4(_202, _203, _204, 1.0);
    float4 _206 = float4(_205.x, _205.y, _205.z, _205.w);
    float4 _207 = View.View_TranslatedWorldToClip * _206;
    out.gl_Position = _207;
    return out;
}

