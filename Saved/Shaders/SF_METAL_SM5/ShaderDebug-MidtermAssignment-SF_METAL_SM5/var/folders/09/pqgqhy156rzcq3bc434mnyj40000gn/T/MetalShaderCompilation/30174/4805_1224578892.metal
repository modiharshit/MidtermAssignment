

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
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
    uint4 in_var_ATTRIBUTE14 [[attribute(14)]];
    float4 in_var_ATTRIBUTE15 [[attribute(15)]];
};

vertex Main_out Main_000012c5_48fd974c(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_Globals& _Globals [[buffer(3)]], texture_buffer<float> BoneMatrices [[texture(0)]])
{
    Main_out out = {};
    float4 _73 = float4(in.in_var_ATTRIBUTE4.x);
    int _76 = int(in.in_var_ATTRIBUTE3.x) * 3;
    float4 _90 = float4(in.in_var_ATTRIBUTE4.y);
    int _93 = int(in.in_var_ATTRIBUTE3.y) * 3;
    float4 _109 = float4(in.in_var_ATTRIBUTE4.z);
    int _112 = int(in.in_var_ATTRIBUTE3.z) * 3;
    float4 _128 = float4(in.in_var_ATTRIBUTE4.w);
    int _131 = int(in.in_var_ATTRIBUTE3.w) * 3;
    float4 _143 = (((_73 * BoneMatrices.read(uint(uint(_76)))) + (_90 * BoneMatrices.read(uint(uint(_93))))) + (_109 * BoneMatrices.read(uint(uint(_112))))) + (_128 * BoneMatrices.read(uint(uint(_131))));
    float4 _144 = (((_73 * BoneMatrices.read(uint(uint(_76 + 1)))) + (_90 * BoneMatrices.read(uint(uint(_93 + 1))))) + (_109 * BoneMatrices.read(uint(uint(_112 + 1))))) + (_128 * BoneMatrices.read(uint(uint(_131 + 1))));
    float4 _145 = (((_73 * BoneMatrices.read(uint(uint(_76 + 2)))) + (_90 * BoneMatrices.read(uint(uint(_93 + 2))))) + (_109 * BoneMatrices.read(uint(uint(_112 + 2))))) + (_128 * BoneMatrices.read(uint(uint(_131 + 2))));
    float3x4 _229;
    if (_Globals.NumBoneInfluencesParam > 4u)
    {
        float4 _153 = float4(in.in_var_ATTRIBUTE15.x);
        int _156 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _172 = float4(in.in_var_ATTRIBUTE15.y);
        int _175 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _191 = float4(in.in_var_ATTRIBUTE15.z);
        int _194 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _210 = float4(in.in_var_ATTRIBUTE15.w);
        int _213 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _229 = float3x4((((_143 + (_153 * BoneMatrices.read(uint(uint(_156))))) + (_172 * BoneMatrices.read(uint(uint(_175))))) + (_191 * BoneMatrices.read(uint(uint(_194))))) + (_210 * BoneMatrices.read(uint(uint(_213)))), (((_144 + (_153 * BoneMatrices.read(uint(uint(_156 + 1))))) + (_172 * BoneMatrices.read(uint(uint(_175 + 1))))) + (_191 * BoneMatrices.read(uint(uint(_194 + 1))))) + (_210 * BoneMatrices.read(uint(uint(_213 + 1)))), (((_145 + (_153 * BoneMatrices.read(uint(uint(_156 + 2))))) + (_172 * BoneMatrices.read(uint(uint(_175 + 2))))) + (_191 * BoneMatrices.read(uint(uint(_194 + 2))))) + (_210 * BoneMatrices.read(uint(uint(_213 + 2)))));
    }
    else
    {
        _229 = float3x4(_143, _144, _145);
    }
    float3 _230 = in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11;
    float _231 = _230.x;
    float _232 = _230.y;
    float _233 = _230.z;
    float4 _234 = float4(_231, _232, _233, 1.0);
    float3 _235 = _234 * _229;
    float3 _236 = _235 + in.in_var_ATTRIBUTE12;
    float3 _240 = _236.xxx;
    float3 _241 = Primitive.Primitive_LocalToWorld[0u].xyz * _240;
    float3 _245 = _236.yyy;
    float3 _246 = Primitive.Primitive_LocalToWorld[1u].xyz * _245;
    float3 _247 = _241 + _246;
    float3 _251 = _236.zzz;
    float3 _252 = Primitive.Primitive_LocalToWorld[2u].xyz * _251;
    float3 _253 = _247 + _252;
    float3 _257 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _258 = _253 + _257;
    float _259 = _258.x;
    float _260 = _258.y;
    float _261 = _258.z;
    float4 _262 = float4(_259, _260, _261, 1.0);
    float4 _263 = float4(_262.x, _262.y, _262.z, _262.w);
    float4 _264 = View.View_TranslatedWorldToClip * _263;
    out.gl_Position = _264;
    return out;
}

