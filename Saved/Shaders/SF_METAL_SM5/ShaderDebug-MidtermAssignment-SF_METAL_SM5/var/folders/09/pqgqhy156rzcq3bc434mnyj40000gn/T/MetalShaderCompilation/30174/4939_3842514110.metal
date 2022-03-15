

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
    uint NumBoneInfluencesParam;
};

struct Main_out
{
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    uint4 in_var_ATTRIBUTE3 [[attribute(3)]];
    float4 in_var_ATTRIBUTE4 [[attribute(4)]];
    float3 in_var_ATTRIBUTE9 [[attribute(9)]];
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
    uint4 in_var_ATTRIBUTE14 [[attribute(14)]];
    float4 in_var_ATTRIBUTE15 [[attribute(15)]];
};

vertex Main_out Main_0000134b_e5081cbe(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_Globals& _Globals [[buffer(3)]], texture_buffer<float> BoneMatrices [[texture(0)]])
{
    Main_out out = {};
    float4 _76 = float4(in.in_var_ATTRIBUTE4.x);
    int _79 = int(in.in_var_ATTRIBUTE3.x) * 3;
    float4 _93 = float4(in.in_var_ATTRIBUTE4.y);
    int _96 = int(in.in_var_ATTRIBUTE3.y) * 3;
    float4 _112 = float4(in.in_var_ATTRIBUTE4.z);
    int _115 = int(in.in_var_ATTRIBUTE3.z) * 3;
    float4 _131 = float4(in.in_var_ATTRIBUTE4.w);
    int _134 = int(in.in_var_ATTRIBUTE3.w) * 3;
    float4 _146 = (((_76 * BoneMatrices.read(uint(uint(_79)))) + (_93 * BoneMatrices.read(uint(uint(_96))))) + (_112 * BoneMatrices.read(uint(uint(_115))))) + (_131 * BoneMatrices.read(uint(uint(_134))));
    float4 _147 = (((_76 * BoneMatrices.read(uint(uint(_79 + 1)))) + (_93 * BoneMatrices.read(uint(uint(_96 + 1))))) + (_112 * BoneMatrices.read(uint(uint(_115 + 1))))) + (_131 * BoneMatrices.read(uint(uint(_134 + 1))));
    float4 _148 = (((_76 * BoneMatrices.read(uint(uint(_79 + 2)))) + (_93 * BoneMatrices.read(uint(uint(_96 + 2))))) + (_112 * BoneMatrices.read(uint(uint(_115 + 2))))) + (_131 * BoneMatrices.read(uint(uint(_134 + 2))));
    float3x4 _232;
    if (_Globals.NumBoneInfluencesParam > 4u)
    {
        float4 _156 = float4(in.in_var_ATTRIBUTE15.x);
        int _159 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _175 = float4(in.in_var_ATTRIBUTE15.y);
        int _178 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _194 = float4(in.in_var_ATTRIBUTE15.z);
        int _197 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _213 = float4(in.in_var_ATTRIBUTE15.w);
        int _216 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _232 = float3x4((((_146 + (_156 * BoneMatrices.read(uint(uint(_159))))) + (_175 * BoneMatrices.read(uint(uint(_178))))) + (_194 * BoneMatrices.read(uint(uint(_197))))) + (_213 * BoneMatrices.read(uint(uint(_216)))), (((_147 + (_156 * BoneMatrices.read(uint(uint(_159 + 1))))) + (_175 * BoneMatrices.read(uint(uint(_178 + 1))))) + (_194 * BoneMatrices.read(uint(uint(_197 + 1))))) + (_213 * BoneMatrices.read(uint(uint(_216 + 1)))), (((_148 + (_156 * BoneMatrices.read(uint(uint(_159 + 2))))) + (_175 * BoneMatrices.read(uint(uint(_178 + 2))))) + (_194 * BoneMatrices.read(uint(uint(_197 + 2))))) + (_213 * BoneMatrices.read(uint(uint(_216 + 2)))));
    }
    else
    {
        _232 = float3x4(_146, _147, _148);
    }
    float3 _233 = in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE9;
    float3 _234 = _233 + in.in_var_ATTRIBUTE11;
    float _235 = _234.x;
    float _236 = _234.y;
    float _237 = _234.z;
    float4 _238 = float4(_235, _236, _237, 1.0);
    float3 _239 = _238 * _232;
    float3 _240 = _239 + in.in_var_ATTRIBUTE12;
    float3 _244 = _240.xxx;
    float3 _245 = Primitive.Primitive_LocalToWorld[0u].xyz * _244;
    float3 _249 = _240.yyy;
    float3 _250 = Primitive.Primitive_LocalToWorld[1u].xyz * _249;
    float3 _251 = _245 + _250;
    float3 _255 = _240.zzz;
    float3 _256 = Primitive.Primitive_LocalToWorld[2u].xyz * _255;
    float3 _257 = _251 + _256;
    float3 _261 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _262 = _257 + _261;
    float _263 = _262.x;
    float _264 = _262.y;
    float _265 = _262.z;
    float4 _266 = float4(_263, _264, _265, 1.0);
    float4 _267 = float4(_266.x, _266.y, _266.z, _266.w);
    float4 _268 = View.View_TranslatedWorldToClip * _267;
    out.gl_Position = _268;
    return out;
}

