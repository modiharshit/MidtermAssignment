

#pragma clang diagnostic ignored "-Wmissing-prototypes"
#pragma clang diagnostic ignored "-Wmissing-braces"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

template<typename T, size_t Num>
struct spvUnsafeArray
{
    T elements[Num ? Num : 1];
    
    thread T& operator [] (size_t pos) thread
    {
        return elements[pos];
    }
    constexpr const thread T& operator [] (size_t pos) const thread
    {
        return elements[pos];
    }
    
    device T& operator [] (size_t pos) device
    {
        return elements[pos];
    }
    constexpr const device T& operator [] (size_t pos) const device
    {
        return elements[pos];
    }
    
    constexpr const constant T& operator [] (size_t pos) const constant
    {
        return elements[pos];
    }
    
    threadgroup T& operator [] (size_t pos) threadgroup
    {
        return elements[pos];
    }
    constexpr const threadgroup T& operator [] (size_t pos) const threadgroup
    {
        return elements[pos];
    }
};

struct type_View
{
    float4x4 View_TranslatedWorldToClip;
    char _m1_pad[1056];
    float3 View_PreViewTranslation;
    char _m2_pad[320];
    float4x4 View_PrevTranslatedWorldToClip;
    char _m3_pad[288];
    float3 View_PrevPreViewTranslation;
    char _m4_pad[336];
    int View_NumSceneColorMSAASamples;
};

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
    float4 Primitive_InvNonUniformScaleAndDeterminantSign;
    char _m2_pad[80];
    float4x4 Primitive_PreviousLocalToWorld;
};

struct type_Globals
{
    uint PerBoneMotionBlur;
    uint InputWeightIndexSize;
};

constant spvUnsafeArray<float2, 1> _77 = spvUnsafeArray<float2, 1>({ float2(0.0) });

constant float3x3 _81 = {};
constant float4 _82 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float4 out_var_TEXCOORD7 [[user(locn1)]];
    float4 out_var_TEXCOORD10_centroid [[user(locn2)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn3)]];
    float4 out_var_TEXCOORD0_0 [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVertexShader_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    uint in_var_ATTRIBUTE3 [[attribute(3)]];
    float2 in_var_ATTRIBUTE5_0 [[attribute(5)]];
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
};

vertex MainVertexShader_out Main_00002455_93d4470b(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<uint> InputWeightStream [[texture(0)]], texture_buffer<float> BoneMatrices [[texture(1)]], texture_buffer<float> PreviousBoneMatrices [[texture(2)]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    spvUnsafeArray<float2, 1> in_var_ATTRIBUTE5 = {};
    in_var_ATTRIBUTE5[0] = in.in_var_ATTRIBUTE5_0;
    int _103 = int(in.in_var_ATTRIBUTE3 & 255u);
    uint _106 = uint(int(in.in_var_ATTRIBUTE3 >> 8u));
    int _112 = int(_106 + (_Globals.InputWeightIndexSize * uint(_103)));
    float3x4 _114;
    _114 = float3x4(float4(0.0), float4(0.0), float4(0.0));
    float3x4 _115;
    for (int _117 = 0; _117 < _103; _114 = _115, _117++)
    {
        int _125 = int(_106 + (_Globals.InputWeightIndexSize * uint(_117)));
        int _130 = int(InputWeightStream.read(uint(uint(_125))).x);
        if (_Globals.InputWeightIndexSize > 1u)
        {
            float4 _176 = float4(float(InputWeightStream.read(uint(uint(_112 + _117))).x) * 0.0039215688593685626983642578125);
            int _177 = int((InputWeightStream.read(uint(uint(_125 + 1))).x << 8u) | uint(_130)) * 3;
            _115 = float3x4(_114[0] + (_176 * BoneMatrices.read(uint(uint(_177)))), _114[1] + (_176 * BoneMatrices.read(uint(uint(_177 + 1)))), _114[2] + (_176 * BoneMatrices.read(uint(uint(_177 + 2)))));
        }
        else
        {
            float4 _141 = float4(float(InputWeightStream.read(uint(uint(_112 + _117))).x) * 0.0039215688593685626983642578125);
            int _142 = _130 * 3;
            _115 = float3x4(_114[0] + (_141 * BoneMatrices.read(uint(uint(_142)))), _114[1] + (_141 * BoneMatrices.read(uint(uint(_142 + 1)))), _114[2] + (_141 * BoneMatrices.read(uint(uint(_142 + 2)))));
        }
    }
    float3 _202 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _114);
    float3x3 _203 = _81;
    _203[0] = _202;
    float3 _209 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _114);
    float3x3 _210 = _203;
    _210[2] = _209;
    float3x3 _215 = _210;
    _215[1] = normalize(cross(_209, _202) * in.in_var_ATTRIBUTE2.w);
    float4 _220 = float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0);
    float3 _222 = (_220 * _114) + in.in_var_ATTRIBUTE12;
    spvUnsafeArray<float2, 1> _84;
    _84 = in_var_ATTRIBUTE5;
    spvUnsafeArray<float2, 1> _85 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _250 = 0; _250 < 1; )
    {
        _85[_250] = _84[_250];
        _250++;
        continue;
    }
    float4 _261 = _82;
    _261.w = 0.0;
    float3x3 _274 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _274[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _277 = _274;
    _277[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _280 = _277;
    _280[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _281 = _280 * _215;
    float3 _282 = _281[0];
    spvUnsafeArray<float4, 1> _292 = { float4(_85[0].x, _85[0].y, float4(0.0).z, float4(0.0).w) };
    float4x4 _298 = Primitive.Primitive_PreviousLocalToWorld;
    _298[3].x = Primitive.Primitive_PreviousLocalToWorld[3].x + View.View_PrevPreViewTranslation.x;
    float4x4 _302 = _298;
    _302[3].y = Primitive.Primitive_PreviousLocalToWorld[3].y + View.View_PrevPreViewTranslation.y;
    float4x4 _306 = _302;
    _306[3].z = Primitive.Primitive_PreviousLocalToWorld[3].z + View.View_PrevPreViewTranslation.z;
    float3x4 _396;
    if (_Globals.PerBoneMotionBlur != 0u)
    {
        float3x4 _313;
        _313 = float3x4(float4(0.0), float4(0.0), float4(0.0));
        float3x4 _314;
        for (int _316 = 0; _316 < _103; _313 = _314, _316++)
        {
            int _324 = int(_106 + (_Globals.InputWeightIndexSize * uint(_316)));
            int _329 = int(InputWeightStream.read(uint(uint(_324))).x);
            if (_Globals.InputWeightIndexSize > 1u)
            {
                float4 _375 = float4(float(InputWeightStream.read(uint(uint(_112 + _316))).x) * 0.0039215688593685626983642578125);
                int _376 = int((InputWeightStream.read(uint(uint(_324 + 1))).x << 8u) | uint(_329)) * 3;
                _314 = float3x4(_313[0] + (_375 * PreviousBoneMatrices.read(uint(uint(_376)))), _313[1] + (_375 * PreviousBoneMatrices.read(uint(uint(_376 + 1)))), _313[2] + (_375 * PreviousBoneMatrices.read(uint(uint(_376 + 2)))));
            }
            else
            {
                float4 _340 = float4(float(InputWeightStream.read(uint(uint(_112 + _316))).x) * 0.0039215688593685626983642578125);
                int _341 = _329 * 3;
                _314 = float3x4(_313[0] + (_340 * PreviousBoneMatrices.read(uint(uint(_341)))), _313[1] + (_340 * PreviousBoneMatrices.read(uint(uint(_341 + 1)))), _313[2] + (_340 * PreviousBoneMatrices.read(uint(uint(_341 + 2)))));
            }
        }
        _396 = _313;
    }
    else
    {
        _396 = _114;
    }
    float4 _410 = View.View_TranslatedWorldToClip * float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _222.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _222.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _222.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
    float4 _419 = _410;
    _419.z = _410.z + ((View.View_NumSceneColorMSAASamples > 1) ? (0.001000000047497451305389404296875 * _410.w) : 0.0);
    out.gl_Position = _419;
    out.out_var_TEXCOORD6 = _410;
    out.out_var_TEXCOORD7 = View.View_PrevTranslatedWorldToClip * float4((_306 * float4((_220 * _396) + in.in_var_ATTRIBUTE12, 1.0)).xyz, 1.0);
    out.out_var_TEXCOORD10_centroid = float4(_282.x, _282.y, _282.z, _261.w);
    out.out_var_TEXCOORD11_centroid = float4(_281[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _292;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

