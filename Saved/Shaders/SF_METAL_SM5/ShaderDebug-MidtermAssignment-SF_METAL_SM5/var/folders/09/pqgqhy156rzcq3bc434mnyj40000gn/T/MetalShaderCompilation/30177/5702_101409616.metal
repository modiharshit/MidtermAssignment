

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
    uint InputWeightIndexSize;
};

constant float3x3 _69 = {};
constant float _73 = {};

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
    uint in_var_ATTRIBUTE3 [[attribute(3)]];
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
};

vertex Main_out Main_00001646_060b6350(Main_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<uint> InputWeightStream [[texture(0)]], texture_buffer<float> BoneMatrices [[texture(1)]])
{
    Main_out out = {};
    int _85 = int(in.in_var_ATTRIBUTE3 & 255u);
    uint _88 = uint(int(in.in_var_ATTRIBUTE3 >> 8u));
    int _94 = int(_88 + (_Globals.InputWeightIndexSize * uint(_85)));
    float3x4 _96;
    _96 = float3x4(float4(0.0), float4(0.0), float4(0.0));
    float3x4 _97;
    for (int _99 = 0; _99 < _85; _96 = _97, _99++)
    {
        int _107 = int(_88 + (_Globals.InputWeightIndexSize * uint(_99)));
        int _112 = int(InputWeightStream.read(uint(uint(_107))).x);
        if (_Globals.InputWeightIndexSize > 1u)
        {
            float4 _131 = float4(float(InputWeightStream.read(uint(uint(_94 + _99))).x) * 0.0039215688593685626983642578125);
            int _132 = int((InputWeightStream.read(uint(uint(_107 + 1))).x << 8u) | uint(_112)) * 3;
            _97 = float3x4(_96[0] + (_131 * BoneMatrices.read(uint(uint(_132)))), _96[1] + (_131 * BoneMatrices.read(uint(uint(_132 + 1)))), _96[2] + (_131 * BoneMatrices.read(uint(uint(_132 + 2)))));
        }
        else
        {
            float4 _158 = float4(float(InputWeightStream.read(uint(uint(_94 + _99))).x) * 0.0039215688593685626983642578125);
            int _159 = _112 * 3;
            _97 = float3x4(_96[0] + (_158 * BoneMatrices.read(uint(uint(_159)))), _96[1] + (_158 * BoneMatrices.read(uint(uint(_159 + 1)))), _96[2] + (_158 * BoneMatrices.read(uint(uint(_159 + 2)))));
        }
    }
    float3 _184 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _96);
    float3x3 _185 = _69;
    _185[0] = _184;
    float3 _191 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _96);
    float3x3 _192 = _185;
    _192[2] = _191;
    float3x3 _197 = _192;
    _197[1] = normalize(cross(_191, _184) * in.in_var_ATTRIBUTE2.w);
    float3 _204 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _96) + in.in_var_ATTRIBUTE12;
    float4 _231 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _204.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _204.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _204.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
    float3x3 _244 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _244[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _247 = _244;
    _247[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _250 = _247;
    _250[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float4 _263 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_231.x, _231.y, _231.z, _231.w);
    float4 _274;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_263.z < 0.0))
    {
        float4 _272 = _263;
        _272.z = 9.9999999747524270787835121154785e-07;
        float4 _273 = _272;
        _273.w = 1.0;
        _274 = _273;
    }
    else
    {
        _274 = _263;
    }
    float _280 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), float4((_250 * _197)[2], _73).xyz));
    float4 _305 = _274;
    _305.z = ((_274.z * ShadowDepthPass.ShadowDepthPass_ShadowParams.w) + ((ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_280) > 0.0) ? (sqrt(fast::clamp(1.0 - (_280 * _280), 0.0, 1.0)) / _280) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x)) * _274.w;
    out.out_var_TEXCOORD6 = 0.0;
    out.gl_Position = _305;
    return out;
}

