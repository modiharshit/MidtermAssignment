

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

constant float _71 = {};
constant float3x3 _72 = {};
constant float4 _73 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float out_var_TEXCOORD6 [[user(locn2)]];
    float3 out_var_TEXCOORD7 [[user(locn3)]];
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

vertex Main_out Main_00001dc3_fcd808cd(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]], texture_buffer<float> BoneMatrices [[texture(0)]])
{
    Main_out out = {};
    float4 _90 = float4(in.in_var_ATTRIBUTE4.x);
    int _93 = int(in.in_var_ATTRIBUTE3.x) * 3;
    float4 _107 = float4(in.in_var_ATTRIBUTE4.y);
    int _110 = int(in.in_var_ATTRIBUTE3.y) * 3;
    float4 _126 = float4(in.in_var_ATTRIBUTE4.z);
    int _129 = int(in.in_var_ATTRIBUTE3.z) * 3;
    float4 _145 = float4(in.in_var_ATTRIBUTE4.w);
    int _148 = int(in.in_var_ATTRIBUTE3.w) * 3;
    float4 _160 = (((_90 * BoneMatrices.read(uint(uint(_93)))) + (_107 * BoneMatrices.read(uint(uint(_110))))) + (_126 * BoneMatrices.read(uint(uint(_129))))) + (_145 * BoneMatrices.read(uint(uint(_148))));
    float4 _161 = (((_90 * BoneMatrices.read(uint(uint(_93 + 1)))) + (_107 * BoneMatrices.read(uint(uint(_110 + 1))))) + (_126 * BoneMatrices.read(uint(uint(_129 + 1))))) + (_145 * BoneMatrices.read(uint(uint(_148 + 1))));
    float4 _162 = (((_90 * BoneMatrices.read(uint(uint(_93 + 2)))) + (_107 * BoneMatrices.read(uint(uint(_110 + 2))))) + (_126 * BoneMatrices.read(uint(uint(_129 + 2))))) + (_145 * BoneMatrices.read(uint(uint(_148 + 2))));
    float3x4 _246;
    if (_Globals.NumBoneInfluencesParam > 4u)
    {
        float4 _170 = float4(in.in_var_ATTRIBUTE15.x);
        int _173 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _189 = float4(in.in_var_ATTRIBUTE15.y);
        int _192 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _208 = float4(in.in_var_ATTRIBUTE15.z);
        int _211 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _227 = float4(in.in_var_ATTRIBUTE15.w);
        int _230 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _246 = float3x4((((_160 + (_170 * BoneMatrices.read(uint(uint(_173))))) + (_189 * BoneMatrices.read(uint(uint(_192))))) + (_208 * BoneMatrices.read(uint(uint(_211))))) + (_227 * BoneMatrices.read(uint(uint(_230)))), (((_161 + (_170 * BoneMatrices.read(uint(uint(_173 + 1))))) + (_189 * BoneMatrices.read(uint(uint(_192 + 1))))) + (_208 * BoneMatrices.read(uint(uint(_211 + 1))))) + (_227 * BoneMatrices.read(uint(uint(_230 + 1)))), (((_162 + (_170 * BoneMatrices.read(uint(uint(_173 + 2))))) + (_189 * BoneMatrices.read(uint(uint(_192 + 2))))) + (_208 * BoneMatrices.read(uint(uint(_211 + 2))))) + (_227 * BoneMatrices.read(uint(uint(_230 + 2)))));
    }
    else
    {
        _246 = float3x4(_160, _161, _162);
    }
    float3 _249 = normalize(in.in_var_ATTRIBUTE2.xyz + in.in_var_ATTRIBUTE10);
    float3 _250 = _249.xyz;
    float3 _260 = normalize(float4(normalize(in.in_var_ATTRIBUTE1 - (_250 * dot(in.in_var_ATTRIBUTE1, _250))), 0.0) * _246);
    float3x3 _261 = _72;
    _261[0] = _260;
    float3 _267 = normalize(float4(_249, 0.0) * _246);
    float3x3 _268 = _261;
    _268[2] = _267;
    float3x3 _273 = _268;
    _273[1] = normalize(cross(_267, _260) * in.in_var_ATTRIBUTE2.w);
    float3 _281 = (float4((in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE9) + in.in_var_ATTRIBUTE11, 1.0) * _246) + in.in_var_ATTRIBUTE12;
    float4 _308 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _281.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _281.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _281.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
    float3x3 _321 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _321[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _324 = _321;
    _324[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _327 = _324;
    _327[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _328 = _327 * _273;
    float3 _329 = _328[2];
    float _330 = _329.x;
    float4 _340 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_308.x, _308.y, _308.z, _308.w);
    float4 _351;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_340.z < 0.0))
    {
        float4 _349 = _340;
        _349.z = 9.9999999747524270787835121154785e-07;
        float4 _350 = _349;
        _350.w = 1.0;
        _351 = _350;
    }
    else
    {
        _351 = _340;
    }
    float _357 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), float4(_330, _329.yz, _71).xyz));
    float4 _382 = _351;
    _382.z = ((_351.z * ShadowDepthPass.ShadowDepthPass_ShadowParams.w) + ((ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_357) > 0.0) ? (sqrt(fast::clamp(1.0 - (_357 * _357), 0.0, 1.0)) / _357) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x)) * _351.w;
    float4 _383 = _73;
    _383.w = 0.0;
    float3 _384 = _328[0];
    out.out_var_TEXCOORD10_centroid = float4(_384.x, _384.y, _384.z, _383.w);
    out.out_var_TEXCOORD11_centroid = float4(_330, _329.yz, in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_TEXCOORD6 = 0.0;
    out.out_var_TEXCOORD7 = _308.xyz;
    out.gl_Position = _382;
    return out;
}

