

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

constant float3x3 _68 = {};
constant float _69 = {};

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
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
    uint4 in_var_ATTRIBUTE14 [[attribute(14)]];
    float4 in_var_ATTRIBUTE15 [[attribute(15)]];
};

vertex Main_out Main_00001a52_85c3ca1d(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]], texture_buffer<float> BoneMatrices [[texture(0)]])
{
    Main_out out = {};
    float4 _84 = float4(in.in_var_ATTRIBUTE4.x);
    int _87 = int(in.in_var_ATTRIBUTE3.x) * 3;
    float4 _101 = float4(in.in_var_ATTRIBUTE4.y);
    int _104 = int(in.in_var_ATTRIBUTE3.y) * 3;
    float4 _120 = float4(in.in_var_ATTRIBUTE4.z);
    int _123 = int(in.in_var_ATTRIBUTE3.z) * 3;
    float4 _139 = float4(in.in_var_ATTRIBUTE4.w);
    int _142 = int(in.in_var_ATTRIBUTE3.w) * 3;
    float4 _154 = (((_84 * BoneMatrices.read(uint(uint(_87)))) + (_101 * BoneMatrices.read(uint(uint(_104))))) + (_120 * BoneMatrices.read(uint(uint(_123))))) + (_139 * BoneMatrices.read(uint(uint(_142))));
    float4 _155 = (((_84 * BoneMatrices.read(uint(uint(_87 + 1)))) + (_101 * BoneMatrices.read(uint(uint(_104 + 1))))) + (_120 * BoneMatrices.read(uint(uint(_123 + 1))))) + (_139 * BoneMatrices.read(uint(uint(_142 + 1))));
    float4 _156 = (((_84 * BoneMatrices.read(uint(uint(_87 + 2)))) + (_101 * BoneMatrices.read(uint(uint(_104 + 2))))) + (_120 * BoneMatrices.read(uint(uint(_123 + 2))))) + (_139 * BoneMatrices.read(uint(uint(_142 + 2))));
    float3x4 _240;
    if (_Globals.NumBoneInfluencesParam > 4u)
    {
        float4 _164 = float4(in.in_var_ATTRIBUTE15.x);
        int _167 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _183 = float4(in.in_var_ATTRIBUTE15.y);
        int _186 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _202 = float4(in.in_var_ATTRIBUTE15.z);
        int _205 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _221 = float4(in.in_var_ATTRIBUTE15.w);
        int _224 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _240 = float3x4((((_154 + (_164 * BoneMatrices.read(uint(uint(_167))))) + (_183 * BoneMatrices.read(uint(uint(_186))))) + (_202 * BoneMatrices.read(uint(uint(_205))))) + (_221 * BoneMatrices.read(uint(uint(_224)))), (((_155 + (_164 * BoneMatrices.read(uint(uint(_167 + 1))))) + (_183 * BoneMatrices.read(uint(uint(_186 + 1))))) + (_202 * BoneMatrices.read(uint(uint(_205 + 1))))) + (_221 * BoneMatrices.read(uint(uint(_224 + 1)))), (((_156 + (_164 * BoneMatrices.read(uint(uint(_167 + 2))))) + (_183 * BoneMatrices.read(uint(uint(_186 + 2))))) + (_202 * BoneMatrices.read(uint(uint(_205 + 2))))) + (_221 * BoneMatrices.read(uint(uint(_224 + 2)))));
    }
    else
    {
        _240 = float3x4(_154, _155, _156);
    }
    float3 _246 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _240);
    float3x3 _247 = _68;
    _247[0] = _246;
    float3 _253 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _240);
    float3x3 _254 = _247;
    _254[2] = _253;
    float3x3 _259 = _254;
    _259[1] = normalize(cross(_253, _246) * in.in_var_ATTRIBUTE2.w);
    float3 _266 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _240) + in.in_var_ATTRIBUTE12;
    float4 _293 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _266.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _266.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _266.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
    float3x3 _306 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _306[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _309 = _306;
    _309[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _312 = _309;
    _312[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float4 _325 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_293.x, _293.y, _293.z, _293.w);
    float4 _336;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_325.z < 0.0))
    {
        float4 _334 = _325;
        _334.z = 9.9999999747524270787835121154785e-07;
        float4 _335 = _334;
        _335.w = 1.0;
        _336 = _335;
    }
    else
    {
        _336 = _325;
    }
    float _342 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), float4((_312 * _259)[2], _69).xyz));
    float4 _367 = _336;
    _367.z = ((_336.z * ShadowDepthPass.ShadowDepthPass_ShadowParams.w) + ((ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_342) > 0.0) ? (sqrt(fast::clamp(1.0 - (_342 * _342), 0.0, 1.0)) / _342) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x)) * _336.w;
    out.out_var_TEXCOORD6 = 0.0;
    out.gl_Position = _367;
    return out;
}

