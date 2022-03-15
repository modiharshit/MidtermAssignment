

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

constant spvUnsafeArray<float2, 1> _77 = spvUnsafeArray<float2, 1>({ float2(0.0) });

constant float3x3 _78 = {};
constant float4 _79 = {};

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
    float3 in_var_ATTRIBUTE9 [[attribute(9)]];
    float3 in_var_ATTRIBUTE10 [[attribute(10)]];
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
    uint4 in_var_ATTRIBUTE14 [[attribute(14)]];
    float4 in_var_ATTRIBUTE15 [[attribute(15)]];
};

vertex MainVertexShader_out Main_00002d42_1140419e(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]], texture_buffer<float> BoneMatrices [[texture(0)]], texture_buffer<float> PreviousBoneMatrices [[texture(1)]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    spvUnsafeArray<float2, 1> in_var_ATTRIBUTE5 = {};
    in_var_ATTRIBUTE5[0] = in.in_var_ATTRIBUTE5_0;
    float4 _105 = float4(in.in_var_ATTRIBUTE4.x);
    int _108 = int(in.in_var_ATTRIBUTE3.x) * 3;
    uint _109 = uint(_108);
    uint _113 = uint(_108 + 1);
    uint _116 = uint(_108 + 2);
    float4 _122 = float4(in.in_var_ATTRIBUTE4.y);
    int _125 = int(in.in_var_ATTRIBUTE3.y) * 3;
    uint _126 = uint(_125);
    uint _129 = uint(_125 + 1);
    uint _132 = uint(_125 + 2);
    float4 _141 = float4(in.in_var_ATTRIBUTE4.z);
    int _144 = int(in.in_var_ATTRIBUTE3.z) * 3;
    uint _145 = uint(_144);
    uint _148 = uint(_144 + 1);
    uint _151 = uint(_144 + 2);
    float4 _160 = float4(in.in_var_ATTRIBUTE4.w);
    int _163 = int(in.in_var_ATTRIBUTE3.w) * 3;
    uint _164 = uint(_163);
    uint _167 = uint(_163 + 1);
    uint _170 = uint(_163 + 2);
    float4 _175 = (((_105 * BoneMatrices.read(uint(_109))) + (_122 * BoneMatrices.read(uint(_126)))) + (_141 * BoneMatrices.read(uint(_145)))) + (_160 * BoneMatrices.read(uint(_164)));
    float4 _176 = (((_105 * BoneMatrices.read(uint(_113))) + (_122 * BoneMatrices.read(uint(_129)))) + (_141 * BoneMatrices.read(uint(_148)))) + (_160 * BoneMatrices.read(uint(_167)));
    float4 _177 = (((_105 * BoneMatrices.read(uint(_116))) + (_122 * BoneMatrices.read(uint(_132)))) + (_141 * BoneMatrices.read(uint(_151)))) + (_160 * BoneMatrices.read(uint(_170)));
    bool _181 = _Globals.NumBoneInfluencesParam > 4u;
    float3x4 _261;
    if (_181)
    {
        float4 _185 = float4(in.in_var_ATTRIBUTE15.x);
        int _188 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _204 = float4(in.in_var_ATTRIBUTE15.y);
        int _207 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _223 = float4(in.in_var_ATTRIBUTE15.z);
        int _226 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _242 = float4(in.in_var_ATTRIBUTE15.w);
        int _245 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _261 = float3x4((((_175 + (_185 * BoneMatrices.read(uint(uint(_188))))) + (_204 * BoneMatrices.read(uint(uint(_207))))) + (_223 * BoneMatrices.read(uint(uint(_226))))) + (_242 * BoneMatrices.read(uint(uint(_245)))), (((_176 + (_185 * BoneMatrices.read(uint(uint(_188 + 1))))) + (_204 * BoneMatrices.read(uint(uint(_207 + 1))))) + (_223 * BoneMatrices.read(uint(uint(_226 + 1))))) + (_242 * BoneMatrices.read(uint(uint(_245 + 1)))), (((_177 + (_185 * BoneMatrices.read(uint(uint(_188 + 2))))) + (_204 * BoneMatrices.read(uint(uint(_207 + 2))))) + (_223 * BoneMatrices.read(uint(uint(_226 + 2))))) + (_242 * BoneMatrices.read(uint(uint(_245 + 2)))));
    }
    else
    {
        _261 = float3x4(_175, _176, _177);
    }
    float3 _264 = normalize(in.in_var_ATTRIBUTE2.xyz + in.in_var_ATTRIBUTE10);
    float3 _265 = _264.xyz;
    float3 _275 = normalize(float4(normalize(in.in_var_ATTRIBUTE1 - (_265 * dot(in.in_var_ATTRIBUTE1, _265))), 0.0) * _261);
    float3x3 _276 = _78;
    _276[0] = _275;
    float3 _282 = normalize(float4(_264, 0.0) * _261);
    float3x3 _283 = _276;
    _283[2] = _282;
    float3x3 _288 = _283;
    _288[1] = normalize(cross(_282, _275) * in.in_var_ATTRIBUTE2.w);
    float4 _294 = float4((in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE9) + in.in_var_ATTRIBUTE11, 1.0);
    float3 _296 = (_294 * _261) + in.in_var_ATTRIBUTE12;
    spvUnsafeArray<float2, 1> _81;
    _81 = in_var_ATTRIBUTE5;
    spvUnsafeArray<float2, 1> _82 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _324 = 0; _324 < 1; )
    {
        _82[_324] = _81[_324];
        _324++;
        continue;
    }
    float4 _335 = _79;
    _335.w = 0.0;
    float3x3 _348 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _348[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _351 = _348;
    _351[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _354 = _351;
    _354[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _355 = _354 * _288;
    float3 _356 = _355[0];
    spvUnsafeArray<float4, 1> _366 = { float4(_82[0].x, _82[0].y, float4(0.0).z, float4(0.0).w) };
    float4x4 _372 = Primitive.Primitive_PreviousLocalToWorld;
    _372[3].x = Primitive.Primitive_PreviousLocalToWorld[3].x + View.View_PrevPreViewTranslation.x;
    float4x4 _376 = _372;
    _376[3].y = Primitive.Primitive_PreviousLocalToWorld[3].y + View.View_PrevPreViewTranslation.y;
    float4x4 _380 = _376;
    _380[3].z = Primitive.Primitive_PreviousLocalToWorld[3].z + View.View_PrevPreViewTranslation.z;
    float3x4 _501;
    if (_Globals.PerBoneMotionBlur != 0u)
    {
        float4 _417 = (((_105 * PreviousBoneMatrices.read(uint(_109))) + (_122 * PreviousBoneMatrices.read(uint(_126)))) + (_141 * PreviousBoneMatrices.read(uint(_145)))) + (_160 * PreviousBoneMatrices.read(uint(_164)));
        float4 _418 = (((_105 * PreviousBoneMatrices.read(uint(_113))) + (_122 * PreviousBoneMatrices.read(uint(_129)))) + (_141 * PreviousBoneMatrices.read(uint(_148)))) + (_160 * PreviousBoneMatrices.read(uint(_167)));
        float4 _419 = (((_105 * PreviousBoneMatrices.read(uint(_116))) + (_122 * PreviousBoneMatrices.read(uint(_132)))) + (_141 * PreviousBoneMatrices.read(uint(_151)))) + (_160 * PreviousBoneMatrices.read(uint(_170)));
        float3x4 _500;
        if (_181)
        {
            float4 _424 = float4(in.in_var_ATTRIBUTE15.x);
            int _427 = int(in.in_var_ATTRIBUTE14.x) * 3;
            float4 _443 = float4(in.in_var_ATTRIBUTE15.y);
            int _446 = int(in.in_var_ATTRIBUTE14.y) * 3;
            float4 _462 = float4(in.in_var_ATTRIBUTE15.z);
            int _465 = int(in.in_var_ATTRIBUTE14.z) * 3;
            float4 _481 = float4(in.in_var_ATTRIBUTE15.w);
            int _484 = int(in.in_var_ATTRIBUTE14.w) * 3;
            _500 = float3x4((((_417 + (_424 * PreviousBoneMatrices.read(uint(uint(_427))))) + (_443 * PreviousBoneMatrices.read(uint(uint(_446))))) + (_462 * PreviousBoneMatrices.read(uint(uint(_465))))) + (_481 * PreviousBoneMatrices.read(uint(uint(_484)))), (((_418 + (_424 * PreviousBoneMatrices.read(uint(uint(_427 + 1))))) + (_443 * PreviousBoneMatrices.read(uint(uint(_446 + 1))))) + (_462 * PreviousBoneMatrices.read(uint(uint(_465 + 1))))) + (_481 * PreviousBoneMatrices.read(uint(uint(_484 + 1)))), (((_419 + (_424 * PreviousBoneMatrices.read(uint(uint(_427 + 2))))) + (_443 * PreviousBoneMatrices.read(uint(uint(_446 + 2))))) + (_462 * PreviousBoneMatrices.read(uint(uint(_465 + 2))))) + (_481 * PreviousBoneMatrices.read(uint(uint(_484 + 2)))));
        }
        else
        {
            _500 = float3x4(_417, _418, _419);
        }
        _501 = _500;
    }
    else
    {
        _501 = _261;
    }
    float4 _515 = View.View_TranslatedWorldToClip * float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _296.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _296.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _296.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
    float4 _524 = _515;
    _524.z = _515.z + ((View.View_NumSceneColorMSAASamples > 1) ? (0.001000000047497451305389404296875 * _515.w) : 0.0);
    out.gl_Position = _524;
    out.out_var_TEXCOORD6 = _515;
    out.out_var_TEXCOORD7 = View.View_PrevTranslatedWorldToClip * float4((_380 * float4((_294 * _501) + in.in_var_ATTRIBUTE12, 1.0)).xyz, 1.0);
    out.out_var_TEXCOORD10_centroid = float4(_356.x, _356.y, _356.z, _335.w);
    out.out_var_TEXCOORD11_centroid = float4(_355[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _366;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

