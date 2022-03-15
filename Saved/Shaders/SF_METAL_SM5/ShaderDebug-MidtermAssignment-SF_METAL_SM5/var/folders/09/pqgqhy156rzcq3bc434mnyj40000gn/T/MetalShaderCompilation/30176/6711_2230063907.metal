

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

constant float _69 = {};
constant float3x3 _70 = {};

struct Main_out
{
    float out_var_TEXCOORD6 [[user(locn0)]];
    float out_var_TEXCOORD8 [[user(locn1)]];
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

vertex Main_out Main_00001a37_84ec1323(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]], texture_buffer<float> BoneMatrices [[texture(0)]])
{
    Main_out out = {};
    float4 _85 = float4(in.in_var_ATTRIBUTE4.x);
    int _88 = int(in.in_var_ATTRIBUTE3.x) * 3;
    float4 _102 = float4(in.in_var_ATTRIBUTE4.y);
    int _105 = int(in.in_var_ATTRIBUTE3.y) * 3;
    float4 _121 = float4(in.in_var_ATTRIBUTE4.z);
    int _124 = int(in.in_var_ATTRIBUTE3.z) * 3;
    float4 _140 = float4(in.in_var_ATTRIBUTE4.w);
    int _143 = int(in.in_var_ATTRIBUTE3.w) * 3;
    float4 _155 = (((_85 * BoneMatrices.read(uint(uint(_88)))) + (_102 * BoneMatrices.read(uint(uint(_105))))) + (_121 * BoneMatrices.read(uint(uint(_124))))) + (_140 * BoneMatrices.read(uint(uint(_143))));
    float4 _156 = (((_85 * BoneMatrices.read(uint(uint(_88 + 1)))) + (_102 * BoneMatrices.read(uint(uint(_105 + 1))))) + (_121 * BoneMatrices.read(uint(uint(_124 + 1))))) + (_140 * BoneMatrices.read(uint(uint(_143 + 1))));
    float4 _157 = (((_85 * BoneMatrices.read(uint(uint(_88 + 2)))) + (_102 * BoneMatrices.read(uint(uint(_105 + 2))))) + (_121 * BoneMatrices.read(uint(uint(_124 + 2))))) + (_140 * BoneMatrices.read(uint(uint(_143 + 2))));
    float3x4 _241;
    if (_Globals.NumBoneInfluencesParam > 4u)
    {
        float4 _165 = float4(in.in_var_ATTRIBUTE15.x);
        int _168 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _184 = float4(in.in_var_ATTRIBUTE15.y);
        int _187 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _203 = float4(in.in_var_ATTRIBUTE15.z);
        int _206 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _222 = float4(in.in_var_ATTRIBUTE15.w);
        int _225 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _241 = float3x4((((_155 + (_165 * BoneMatrices.read(uint(uint(_168))))) + (_184 * BoneMatrices.read(uint(uint(_187))))) + (_203 * BoneMatrices.read(uint(uint(_206))))) + (_222 * BoneMatrices.read(uint(uint(_225)))), (((_156 + (_165 * BoneMatrices.read(uint(uint(_168 + 1))))) + (_184 * BoneMatrices.read(uint(uint(_187 + 1))))) + (_203 * BoneMatrices.read(uint(uint(_206 + 1))))) + (_222 * BoneMatrices.read(uint(uint(_225 + 1)))), (((_157 + (_165 * BoneMatrices.read(uint(uint(_168 + 2))))) + (_184 * BoneMatrices.read(uint(uint(_187 + 2))))) + (_203 * BoneMatrices.read(uint(uint(_206 + 2))))) + (_222 * BoneMatrices.read(uint(uint(_225 + 2)))));
    }
    else
    {
        _241 = float3x4(_155, _156, _157);
    }
    float3 _247 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _241);
    float3x3 _248 = _70;
    _248[0] = _247;
    float3 _254 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _241);
    float3x3 _255 = _248;
    _255[2] = _254;
    float3x3 _260 = _255;
    _260[1] = normalize(cross(_254, _247) * in.in_var_ATTRIBUTE2.w);
    float3 _267 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _241) + in.in_var_ATTRIBUTE12;
    float4 _294 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _267.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _267.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _267.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
    float3x3 _307 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _307[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _310 = _307;
    _310[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _313 = _310;
    _313[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float4 _326 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_294.x, _294.y, _294.z, _294.w);
    float4 _337;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_326.z < 0.0))
    {
        float4 _335 = _326;
        _335.z = 9.9999999747524270787835121154785e-07;
        float4 _336 = _335;
        _336.w = 1.0;
        _337 = _336;
    }
    else
    {
        _337 = _326;
    }
    float _343 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), float4((_313 * _260)[2], _69).xyz));
    out.out_var_TEXCOORD6 = _337.z;
    out.out_var_TEXCOORD8 = (ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_343) > 0.0) ? (sqrt(fast::clamp(1.0 - (_343 * _343), 0.0, 1.0)) / _343) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x;
    out.gl_Position = _337;
    return out;
}

