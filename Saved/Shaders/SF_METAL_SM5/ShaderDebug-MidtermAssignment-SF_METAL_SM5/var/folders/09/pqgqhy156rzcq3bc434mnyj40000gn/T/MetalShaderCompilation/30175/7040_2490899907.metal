

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct type_View
{
    char _m0_pad[1120];
    float3 View_PreViewTranslation;
};

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
    float4 Primitive_InvNonUniformScaleAndDeterminantSign;
};

struct type_ShadowDepthPass
{
    char _m0_pad[304];
    float4x4 ShadowDepthPass_ProjectionMatrix;
    float4x4 ShadowDepthPass_ViewMatrix;
    float4 ShadowDepthPass_ShadowParams;
    float ShadowDepthPass_bClampToNearPlane;
};

struct type_Globals
{
    uint NumBoneInfluencesParam;
};

constant float3x3 _71 = {};
constant float _72 = {};

struct Main_out
{
    float out_var_TEXCOORD6 [[user(locn0)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
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

vertex Main_out Main_00001b80_94781dc3(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]], texture_buffer<float> BoneMatrices [[texture(0)]])
{
    Main_out out = {};
    float4 _89 = float4(in.in_var_ATTRIBUTE4.x);
    int _92 = int(in.in_var_ATTRIBUTE3.x) * 3;
    float4 _106 = float4(in.in_var_ATTRIBUTE4.y);
    int _109 = int(in.in_var_ATTRIBUTE3.y) * 3;
    float4 _125 = float4(in.in_var_ATTRIBUTE4.z);
    int _128 = int(in.in_var_ATTRIBUTE3.z) * 3;
    float4 _144 = float4(in.in_var_ATTRIBUTE4.w);
    int _147 = int(in.in_var_ATTRIBUTE3.w) * 3;
    float4 _159 = (((_89 * BoneMatrices.read(uint(uint(_92)))) + (_106 * BoneMatrices.read(uint(uint(_109))))) + (_125 * BoneMatrices.read(uint(uint(_128))))) + (_144 * BoneMatrices.read(uint(uint(_147))));
    float4 _160 = (((_89 * BoneMatrices.read(uint(uint(_92 + 1)))) + (_106 * BoneMatrices.read(uint(uint(_109 + 1))))) + (_125 * BoneMatrices.read(uint(uint(_128 + 1))))) + (_144 * BoneMatrices.read(uint(uint(_147 + 1))));
    float4 _161 = (((_89 * BoneMatrices.read(uint(uint(_92 + 2)))) + (_106 * BoneMatrices.read(uint(uint(_109 + 2))))) + (_125 * BoneMatrices.read(uint(uint(_128 + 2))))) + (_144 * BoneMatrices.read(uint(uint(_147 + 2))));
    float3x4 _245;
    if (_Globals.NumBoneInfluencesParam > 4u)
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
    float3 _248 = normalize(in.in_var_ATTRIBUTE2.xyz + in.in_var_ATTRIBUTE10);
    float3 _249 = _248.xyz;
    float3 _259 = normalize(float4(normalize(in.in_var_ATTRIBUTE1 - (_249 * dot(in.in_var_ATTRIBUTE1, _249))), 0.0) * _245);
    float3x3 _260 = _71;
    _260[0] = _259;
    float3 _266 = normalize(float4(_248, 0.0) * _245);
    float3x3 _267 = _260;
    _267[2] = _266;
    float3x3 _272 = _267;
    _272[1] = normalize(cross(_266, _259) * in.in_var_ATTRIBUTE2.w);
    float3 _280 = (float4((in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE9) + in.in_var_ATTRIBUTE11, 1.0) * _245) + in.in_var_ATTRIBUTE12;
    float4 _307 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _280.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _280.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _280.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
    float3x3 _320 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _320[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _323 = _320;
    _323[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _326 = _323;
    _326[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float4 _339 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_307.x, _307.y, _307.z, _307.w);
    float4 _350;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_339.z < 0.0))
    {
        float4 _348 = _339;
        _348.z = 9.9999999747524270787835121154785e-07;
        float4 _349 = _348;
        _349.w = 1.0;
        _350 = _349;
    }
    else
    {
        _350 = _339;
    }
    float _356 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), float4((_326 * _272)[2], _72).xyz));
    float4 _381 = _350;
    _381.z = ((_350.z * ShadowDepthPass.ShadowDepthPass_ShadowParams.w) + ((ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_356) > 0.0) ? (sqrt(fast::clamp(1.0 - (_356 * _356), 0.0, 1.0)) / _356) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x)) * _350.w;
    out.out_var_TEXCOORD6 = 0.0;
    out.gl_Position = _381;
    return out;
}

