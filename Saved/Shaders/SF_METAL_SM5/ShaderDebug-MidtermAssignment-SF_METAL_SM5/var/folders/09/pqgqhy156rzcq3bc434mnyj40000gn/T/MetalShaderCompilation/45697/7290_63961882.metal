

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

constant float _70 = {};
constant float3x3 _71 = {};
constant float4 _72 = {};

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
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
    uint4 in_var_ATTRIBUTE14 [[attribute(14)]];
    float4 in_var_ATTRIBUTE15 [[attribute(15)]];
};

vertex Main_out Main_00001c7a_03cffb1a(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]], texture_buffer<float> BoneMatrices [[texture(0)]])
{
    Main_out out = {};
    float4 _87 = float4(in.in_var_ATTRIBUTE4.x);
    int _90 = int(in.in_var_ATTRIBUTE3.x) * 3;
    float4 _104 = float4(in.in_var_ATTRIBUTE4.y);
    int _107 = int(in.in_var_ATTRIBUTE3.y) * 3;
    float4 _123 = float4(in.in_var_ATTRIBUTE4.z);
    int _126 = int(in.in_var_ATTRIBUTE3.z) * 3;
    float4 _142 = float4(in.in_var_ATTRIBUTE4.w);
    int _145 = int(in.in_var_ATTRIBUTE3.w) * 3;
    float4 _157 = (((_87 * BoneMatrices.read(uint(uint(_90)))) + (_104 * BoneMatrices.read(uint(uint(_107))))) + (_123 * BoneMatrices.read(uint(uint(_126))))) + (_142 * BoneMatrices.read(uint(uint(_145))));
    float4 _158 = (((_87 * BoneMatrices.read(uint(uint(_90 + 1)))) + (_104 * BoneMatrices.read(uint(uint(_107 + 1))))) + (_123 * BoneMatrices.read(uint(uint(_126 + 1))))) + (_142 * BoneMatrices.read(uint(uint(_145 + 1))));
    float4 _159 = (((_87 * BoneMatrices.read(uint(uint(_90 + 2)))) + (_104 * BoneMatrices.read(uint(uint(_107 + 2))))) + (_123 * BoneMatrices.read(uint(uint(_126 + 2))))) + (_142 * BoneMatrices.read(uint(uint(_145 + 2))));
    float3x4 _243;
    if (_Globals.NumBoneInfluencesParam > 4u)
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
    float3x3 _250 = _71;
    _250[0] = _249;
    float3 _256 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _243);
    float3x3 _257 = _250;
    _257[2] = _256;
    float3x3 _262 = _257;
    _262[1] = normalize(cross(_256, _249) * in.in_var_ATTRIBUTE2.w);
    float3 _269 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _243) + in.in_var_ATTRIBUTE12;
    float4 _296 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _269.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _269.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _269.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
    float3x3 _309 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _309[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _312 = _309;
    _312[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _315 = _312;
    _315[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _316 = _315 * _262;
    float3 _317 = _316[2];
    float _318 = _317.x;
    float4 _328 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_296.x, _296.y, _296.z, _296.w);
    float4 _339;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_328.z < 0.0))
    {
        float4 _337 = _328;
        _337.z = 9.9999999747524270787835121154785e-07;
        float4 _338 = _337;
        _338.w = 1.0;
        _339 = _338;
    }
    else
    {
        _339 = _328;
    }
    float _345 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), float4(_318, _317.yz, _70).xyz));
    float4 _364 = _72;
    _364.w = 0.0;
    float3 _365 = _316[0];
    out.out_var_TEXCOORD10_centroid = float4(_365.x, _365.y, _365.z, _364.w);
    out.out_var_TEXCOORD11_centroid = float4(_318, _317.yz, in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_TEXCOORD6 = _339.z;
    out.out_var_TEXCOORD8 = (ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_345) > 0.0) ? (sqrt(fast::clamp(1.0 - (_345 * _345), 0.0, 1.0)) / _345) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x;
    out.out_var_TEXCOORD7 = _296.xyz;
    out.gl_Position = _339;
    return out;
}

