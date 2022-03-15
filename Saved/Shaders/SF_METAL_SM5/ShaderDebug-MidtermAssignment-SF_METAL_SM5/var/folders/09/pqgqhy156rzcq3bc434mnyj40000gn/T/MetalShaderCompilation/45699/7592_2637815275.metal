

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

constant float _72 = {};
constant float3x3 _73 = {};
constant float4 _74 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float out_var_TEXCOORD6 [[user(locn2)]];
    float out_var_TEXCOORD8 [[user(locn3)]];
    float3 out_var_TEXCOORD7 [[user(locn4)]];
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

vertex Main_out Main_00001da8_9d39ddeb(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]], texture_buffer<float> BoneMatrices [[texture(0)]])
{
    Main_out out = {};
    float4 _91 = float4(in.in_var_ATTRIBUTE4.x);
    int _94 = int(in.in_var_ATTRIBUTE3.x) * 3;
    float4 _108 = float4(in.in_var_ATTRIBUTE4.y);
    int _111 = int(in.in_var_ATTRIBUTE3.y) * 3;
    float4 _127 = float4(in.in_var_ATTRIBUTE4.z);
    int _130 = int(in.in_var_ATTRIBUTE3.z) * 3;
    float4 _146 = float4(in.in_var_ATTRIBUTE4.w);
    int _149 = int(in.in_var_ATTRIBUTE3.w) * 3;
    float4 _161 = (((_91 * BoneMatrices.read(uint(uint(_94)))) + (_108 * BoneMatrices.read(uint(uint(_111))))) + (_127 * BoneMatrices.read(uint(uint(_130))))) + (_146 * BoneMatrices.read(uint(uint(_149))));
    float4 _162 = (((_91 * BoneMatrices.read(uint(uint(_94 + 1)))) + (_108 * BoneMatrices.read(uint(uint(_111 + 1))))) + (_127 * BoneMatrices.read(uint(uint(_130 + 1))))) + (_146 * BoneMatrices.read(uint(uint(_149 + 1))));
    float4 _163 = (((_91 * BoneMatrices.read(uint(uint(_94 + 2)))) + (_108 * BoneMatrices.read(uint(uint(_111 + 2))))) + (_127 * BoneMatrices.read(uint(uint(_130 + 2))))) + (_146 * BoneMatrices.read(uint(uint(_149 + 2))));
    float3x4 _247;
    if (_Globals.NumBoneInfluencesParam > 4u)
    {
        float4 _171 = float4(in.in_var_ATTRIBUTE15.x);
        int _174 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _190 = float4(in.in_var_ATTRIBUTE15.y);
        int _193 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _209 = float4(in.in_var_ATTRIBUTE15.z);
        int _212 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _228 = float4(in.in_var_ATTRIBUTE15.w);
        int _231 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _247 = float3x4((((_161 + (_171 * BoneMatrices.read(uint(uint(_174))))) + (_190 * BoneMatrices.read(uint(uint(_193))))) + (_209 * BoneMatrices.read(uint(uint(_212))))) + (_228 * BoneMatrices.read(uint(uint(_231)))), (((_162 + (_171 * BoneMatrices.read(uint(uint(_174 + 1))))) + (_190 * BoneMatrices.read(uint(uint(_193 + 1))))) + (_209 * BoneMatrices.read(uint(uint(_212 + 1))))) + (_228 * BoneMatrices.read(uint(uint(_231 + 1)))), (((_163 + (_171 * BoneMatrices.read(uint(uint(_174 + 2))))) + (_190 * BoneMatrices.read(uint(uint(_193 + 2))))) + (_209 * BoneMatrices.read(uint(uint(_212 + 2))))) + (_228 * BoneMatrices.read(uint(uint(_231 + 2)))));
    }
    else
    {
        _247 = float3x4(_161, _162, _163);
    }
    float3 _250 = normalize(in.in_var_ATTRIBUTE2.xyz + in.in_var_ATTRIBUTE10);
    float3 _251 = _250.xyz;
    float3 _261 = normalize(float4(normalize(in.in_var_ATTRIBUTE1 - (_251 * dot(in.in_var_ATTRIBUTE1, _251))), 0.0) * _247);
    float3x3 _262 = _73;
    _262[0] = _261;
    float3 _268 = normalize(float4(_250, 0.0) * _247);
    float3x3 _269 = _262;
    _269[2] = _268;
    float3x3 _274 = _269;
    _274[1] = normalize(cross(_268, _261) * in.in_var_ATTRIBUTE2.w);
    float3 _282 = (float4((in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE9) + in.in_var_ATTRIBUTE11, 1.0) * _247) + in.in_var_ATTRIBUTE12;
    float4 _309 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _282.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _282.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _282.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
    float3x3 _322 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _322[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _325 = _322;
    _325[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _328 = _325;
    _328[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _329 = _328 * _274;
    float3 _330 = _329[2];
    float _331 = _330.x;
    float4 _341 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_309.x, _309.y, _309.z, _309.w);
    float4 _352;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_341.z < 0.0))
    {
        float4 _350 = _341;
        _350.z = 9.9999999747524270787835121154785e-07;
        float4 _351 = _350;
        _351.w = 1.0;
        _352 = _351;
    }
    else
    {
        _352 = _341;
    }
    float _358 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), float4(_331, _330.yz, _72).xyz));
    float4 _377 = _74;
    _377.w = 0.0;
    float3 _378 = _329[0];
    out.out_var_TEXCOORD10_centroid = float4(_378.x, _378.y, _378.z, _377.w);
    out.out_var_TEXCOORD11_centroid = float4(_331, _330.yz, in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_TEXCOORD6 = _352.z;
    out.out_var_TEXCOORD8 = (ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_358) > 0.0) ? (sqrt(fast::clamp(1.0 - (_358 * _358), 0.0, 1.0)) / _358) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x;
    out.out_var_TEXCOORD7 = _309.xyz;
    out.gl_Position = _352;
    return out;
}

