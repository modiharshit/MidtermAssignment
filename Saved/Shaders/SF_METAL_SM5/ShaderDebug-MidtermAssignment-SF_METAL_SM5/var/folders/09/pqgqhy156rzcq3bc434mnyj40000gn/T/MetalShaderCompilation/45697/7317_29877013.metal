

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
constant float4 _71 = {};

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
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
    uint4 in_var_ATTRIBUTE14 [[attribute(14)]];
    float4 in_var_ATTRIBUTE15 [[attribute(15)]];
};

vertex Main_out Main_00001c95_01c7e315(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]], texture_buffer<float> BoneMatrices [[texture(0)]])
{
    Main_out out = {};
    float4 _86 = float4(in.in_var_ATTRIBUTE4.x);
    int _89 = int(in.in_var_ATTRIBUTE3.x) * 3;
    float4 _103 = float4(in.in_var_ATTRIBUTE4.y);
    int _106 = int(in.in_var_ATTRIBUTE3.y) * 3;
    float4 _122 = float4(in.in_var_ATTRIBUTE4.z);
    int _125 = int(in.in_var_ATTRIBUTE3.z) * 3;
    float4 _141 = float4(in.in_var_ATTRIBUTE4.w);
    int _144 = int(in.in_var_ATTRIBUTE3.w) * 3;
    float4 _156 = (((_86 * BoneMatrices.read(uint(uint(_89)))) + (_103 * BoneMatrices.read(uint(uint(_106))))) + (_122 * BoneMatrices.read(uint(uint(_125))))) + (_141 * BoneMatrices.read(uint(uint(_144))));
    float4 _157 = (((_86 * BoneMatrices.read(uint(uint(_89 + 1)))) + (_103 * BoneMatrices.read(uint(uint(_106 + 1))))) + (_122 * BoneMatrices.read(uint(uint(_125 + 1))))) + (_141 * BoneMatrices.read(uint(uint(_144 + 1))));
    float4 _158 = (((_86 * BoneMatrices.read(uint(uint(_89 + 2)))) + (_103 * BoneMatrices.read(uint(uint(_106 + 2))))) + (_122 * BoneMatrices.read(uint(uint(_125 + 2))))) + (_141 * BoneMatrices.read(uint(uint(_144 + 2))));
    float3x4 _242;
    if (_Globals.NumBoneInfluencesParam > 4u)
    {
        float4 _166 = float4(in.in_var_ATTRIBUTE15.x);
        int _169 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _185 = float4(in.in_var_ATTRIBUTE15.y);
        int _188 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _204 = float4(in.in_var_ATTRIBUTE15.z);
        int _207 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _223 = float4(in.in_var_ATTRIBUTE15.w);
        int _226 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _242 = float3x4((((_156 + (_166 * BoneMatrices.read(uint(uint(_169))))) + (_185 * BoneMatrices.read(uint(uint(_188))))) + (_204 * BoneMatrices.read(uint(uint(_207))))) + (_223 * BoneMatrices.read(uint(uint(_226)))), (((_157 + (_166 * BoneMatrices.read(uint(uint(_169 + 1))))) + (_185 * BoneMatrices.read(uint(uint(_188 + 1))))) + (_204 * BoneMatrices.read(uint(uint(_207 + 1))))) + (_223 * BoneMatrices.read(uint(uint(_226 + 1)))), (((_158 + (_166 * BoneMatrices.read(uint(uint(_169 + 2))))) + (_185 * BoneMatrices.read(uint(uint(_188 + 2))))) + (_204 * BoneMatrices.read(uint(uint(_207 + 2))))) + (_223 * BoneMatrices.read(uint(uint(_226 + 2)))));
    }
    else
    {
        _242 = float3x4(_156, _157, _158);
    }
    float3 _248 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _242);
    float3x3 _249 = _70;
    _249[0] = _248;
    float3 _255 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _242);
    float3x3 _256 = _249;
    _256[2] = _255;
    float3x3 _261 = _256;
    _261[1] = normalize(cross(_255, _248) * in.in_var_ATTRIBUTE2.w);
    float3 _268 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _242) + in.in_var_ATTRIBUTE12;
    float4 _295 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _268.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _268.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _268.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
    float3x3 _308 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _308[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _311 = _308;
    _311[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _314 = _311;
    _314[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _315 = _314 * _261;
    float3 _316 = _315[2];
    float _317 = _316.x;
    float4 _327 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_295.x, _295.y, _295.z, _295.w);
    float4 _338;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_327.z < 0.0))
    {
        float4 _336 = _327;
        _336.z = 9.9999999747524270787835121154785e-07;
        float4 _337 = _336;
        _337.w = 1.0;
        _338 = _337;
    }
    else
    {
        _338 = _327;
    }
    float _344 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), float4(_317, _316.yz, _69).xyz));
    float4 _369 = _338;
    _369.z = ((_338.z * ShadowDepthPass.ShadowDepthPass_ShadowParams.w) + ((ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_344) > 0.0) ? (sqrt(fast::clamp(1.0 - (_344 * _344), 0.0, 1.0)) / _344) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x)) * _338.w;
    float4 _370 = _71;
    _370.w = 0.0;
    float3 _371 = _315[0];
    out.out_var_TEXCOORD10_centroid = float4(_371.x, _371.y, _371.z, _370.w);
    out.out_var_TEXCOORD11_centroid = float4(_317, _316.yz, in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_TEXCOORD6 = 0.0;
    out.out_var_TEXCOORD7 = _295.xyz;
    out.gl_Position = _369;
    return out;
}

