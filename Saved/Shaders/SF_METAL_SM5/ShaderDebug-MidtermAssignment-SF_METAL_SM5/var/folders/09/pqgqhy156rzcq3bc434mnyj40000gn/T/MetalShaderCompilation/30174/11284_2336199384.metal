

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
    uint NumBoneInfluencesParam;
};

constant spvUnsafeArray<float2, 1> _75 = spvUnsafeArray<float2, 1>({ float2(0.0) });

constant float3x3 _76 = {};
constant float4 _77 = {};

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
    uint4 in_var_ATTRIBUTE3 [[attribute(3)]];
    float4 in_var_ATTRIBUTE4 [[attribute(4)]];
    float2 in_var_ATTRIBUTE5_0 [[attribute(5)]];
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
    uint4 in_var_ATTRIBUTE14 [[attribute(14)]];
    float4 in_var_ATTRIBUTE15 [[attribute(15)]];
};

vertex MainVertexShader_out Main_00002c14_8b3f92d8(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]], texture_buffer<float> BoneMatrices [[texture(0)]], texture_buffer<float> PreviousBoneMatrices [[texture(1)]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    spvUnsafeArray<float2, 1> in_var_ATTRIBUTE5 = {};
    in_var_ATTRIBUTE5[0] = in.in_var_ATTRIBUTE5_0;
    float4 _101 = float4(in.in_var_ATTRIBUTE4.x);
    int _104 = int(in.in_var_ATTRIBUTE3.x) * 3;
    uint _105 = uint(_104);
    uint _109 = uint(_104 + 1);
    uint _112 = uint(_104 + 2);
    float4 _118 = float4(in.in_var_ATTRIBUTE4.y);
    int _121 = int(in.in_var_ATTRIBUTE3.y) * 3;
    uint _122 = uint(_121);
    uint _125 = uint(_121 + 1);
    uint _128 = uint(_121 + 2);
    float4 _137 = float4(in.in_var_ATTRIBUTE4.z);
    int _140 = int(in.in_var_ATTRIBUTE3.z) * 3;
    uint _141 = uint(_140);
    uint _144 = uint(_140 + 1);
    uint _147 = uint(_140 + 2);
    float4 _156 = float4(in.in_var_ATTRIBUTE4.w);
    int _159 = int(in.in_var_ATTRIBUTE3.w) * 3;
    uint _160 = uint(_159);
    uint _163 = uint(_159 + 1);
    uint _166 = uint(_159 + 2);
    float4 _171 = (((_101 * BoneMatrices.read(uint(_105))) + (_118 * BoneMatrices.read(uint(_122)))) + (_137 * BoneMatrices.read(uint(_141)))) + (_156 * BoneMatrices.read(uint(_160)));
    float4 _172 = (((_101 * BoneMatrices.read(uint(_109))) + (_118 * BoneMatrices.read(uint(_125)))) + (_137 * BoneMatrices.read(uint(_144)))) + (_156 * BoneMatrices.read(uint(_163)));
    float4 _173 = (((_101 * BoneMatrices.read(uint(_112))) + (_118 * BoneMatrices.read(uint(_128)))) + (_137 * BoneMatrices.read(uint(_147)))) + (_156 * BoneMatrices.read(uint(_166)));
    bool _177 = _Globals.NumBoneInfluencesParam > 4u;
    float3x4 _257;
    if (_177)
    {
        float4 _181 = float4(in.in_var_ATTRIBUTE15.x);
        int _184 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _200 = float4(in.in_var_ATTRIBUTE15.y);
        int _203 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _219 = float4(in.in_var_ATTRIBUTE15.z);
        int _222 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _238 = float4(in.in_var_ATTRIBUTE15.w);
        int _241 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _257 = float3x4((((_171 + (_181 * BoneMatrices.read(uint(uint(_184))))) + (_200 * BoneMatrices.read(uint(uint(_203))))) + (_219 * BoneMatrices.read(uint(uint(_222))))) + (_238 * BoneMatrices.read(uint(uint(_241)))), (((_172 + (_181 * BoneMatrices.read(uint(uint(_184 + 1))))) + (_200 * BoneMatrices.read(uint(uint(_203 + 1))))) + (_219 * BoneMatrices.read(uint(uint(_222 + 1))))) + (_238 * BoneMatrices.read(uint(uint(_241 + 1)))), (((_173 + (_181 * BoneMatrices.read(uint(uint(_184 + 2))))) + (_200 * BoneMatrices.read(uint(uint(_203 + 2))))) + (_219 * BoneMatrices.read(uint(uint(_222 + 2))))) + (_238 * BoneMatrices.read(uint(uint(_241 + 2)))));
    }
    else
    {
        _257 = float3x4(_171, _172, _173);
    }
    float3 _263 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _257);
    float3x3 _264 = _76;
    _264[0] = _263;
    float3 _270 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _257);
    float3x3 _271 = _264;
    _271[2] = _270;
    float3x3 _276 = _271;
    _276[1] = normalize(cross(_270, _263) * in.in_var_ATTRIBUTE2.w);
    float4 _281 = float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0);
    float3 _283 = (_281 * _257) + in.in_var_ATTRIBUTE12;
    spvUnsafeArray<float2, 1> _79;
    _79 = in_var_ATTRIBUTE5;
    spvUnsafeArray<float2, 1> _80 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _311 = 0; _311 < 1; )
    {
        _80[_311] = _79[_311];
        _311++;
        continue;
    }
    float4 _322 = _77;
    _322.w = 0.0;
    float3x3 _335 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _335[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _338 = _335;
    _338[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _341 = _338;
    _341[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _342 = _341 * _276;
    float3 _343 = _342[0];
    spvUnsafeArray<float4, 1> _353 = { float4(_80[0].x, _80[0].y, float4(0.0).z, float4(0.0).w) };
    float4x4 _359 = Primitive.Primitive_PreviousLocalToWorld;
    _359[3].x = Primitive.Primitive_PreviousLocalToWorld[3].x + View.View_PrevPreViewTranslation.x;
    float4x4 _363 = _359;
    _363[3].y = Primitive.Primitive_PreviousLocalToWorld[3].y + View.View_PrevPreViewTranslation.y;
    float4x4 _367 = _363;
    _367[3].z = Primitive.Primitive_PreviousLocalToWorld[3].z + View.View_PrevPreViewTranslation.z;
    float3x4 _488;
    if (_Globals.PerBoneMotionBlur != 0u)
    {
        float4 _404 = (((_101 * PreviousBoneMatrices.read(uint(_105))) + (_118 * PreviousBoneMatrices.read(uint(_122)))) + (_137 * PreviousBoneMatrices.read(uint(_141)))) + (_156 * PreviousBoneMatrices.read(uint(_160)));
        float4 _405 = (((_101 * PreviousBoneMatrices.read(uint(_109))) + (_118 * PreviousBoneMatrices.read(uint(_125)))) + (_137 * PreviousBoneMatrices.read(uint(_144)))) + (_156 * PreviousBoneMatrices.read(uint(_163)));
        float4 _406 = (((_101 * PreviousBoneMatrices.read(uint(_112))) + (_118 * PreviousBoneMatrices.read(uint(_128)))) + (_137 * PreviousBoneMatrices.read(uint(_147)))) + (_156 * PreviousBoneMatrices.read(uint(_166)));
        float3x4 _487;
        if (_177)
        {
            float4 _411 = float4(in.in_var_ATTRIBUTE15.x);
            int _414 = int(in.in_var_ATTRIBUTE14.x) * 3;
            float4 _430 = float4(in.in_var_ATTRIBUTE15.y);
            int _433 = int(in.in_var_ATTRIBUTE14.y) * 3;
            float4 _449 = float4(in.in_var_ATTRIBUTE15.z);
            int _452 = int(in.in_var_ATTRIBUTE14.z) * 3;
            float4 _468 = float4(in.in_var_ATTRIBUTE15.w);
            int _471 = int(in.in_var_ATTRIBUTE14.w) * 3;
            _487 = float3x4((((_404 + (_411 * PreviousBoneMatrices.read(uint(uint(_414))))) + (_430 * PreviousBoneMatrices.read(uint(uint(_433))))) + (_449 * PreviousBoneMatrices.read(uint(uint(_452))))) + (_468 * PreviousBoneMatrices.read(uint(uint(_471)))), (((_405 + (_411 * PreviousBoneMatrices.read(uint(uint(_414 + 1))))) + (_430 * PreviousBoneMatrices.read(uint(uint(_433 + 1))))) + (_449 * PreviousBoneMatrices.read(uint(uint(_452 + 1))))) + (_468 * PreviousBoneMatrices.read(uint(uint(_471 + 1)))), (((_406 + (_411 * PreviousBoneMatrices.read(uint(uint(_414 + 2))))) + (_430 * PreviousBoneMatrices.read(uint(uint(_433 + 2))))) + (_449 * PreviousBoneMatrices.read(uint(uint(_452 + 2))))) + (_468 * PreviousBoneMatrices.read(uint(uint(_471 + 2)))));
        }
        else
        {
            _487 = float3x4(_404, _405, _406);
        }
        _488 = _487;
    }
    else
    {
        _488 = _257;
    }
    float4 _502 = View.View_TranslatedWorldToClip * float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _283.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _283.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _283.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
    float4 _511 = _502;
    _511.z = _502.z + ((View.View_NumSceneColorMSAASamples > 1) ? (0.001000000047497451305389404296875 * _502.w) : 0.0);
    out.gl_Position = _511;
    out.out_var_TEXCOORD6 = _502;
    out.out_var_TEXCOORD7 = View.View_PrevTranslatedWorldToClip * float4((_367 * float4((_281 * _488) + in.in_var_ATTRIBUTE12, 1.0)).xyz, 1.0);
    out.out_var_TEXCOORD10_centroid = float4(_343.x, _343.y, _343.z, _322.w);
    out.out_var_TEXCOORD11_centroid = float4(_342[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _353;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

