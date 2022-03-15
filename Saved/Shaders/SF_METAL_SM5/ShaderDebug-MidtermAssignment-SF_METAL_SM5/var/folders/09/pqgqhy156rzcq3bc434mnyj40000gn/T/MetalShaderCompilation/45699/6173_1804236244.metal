

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
    char _m0_pad[704];
    float4x4 View_SVPositionToTranslatedWorld;
    char _m1_pad[352];
    float3 View_PreViewTranslation;
    char _m2_pad[1024];
    int View_NumSceneColorMSAASamples;
    float View_PreExposure;
    char _m4_pad[32];
    float4 View_NormalOverrideParameter;
    char _m5_pad[16];
    float View_OutOfBoundsMask;
    char _m6_pad[36];
    float View_GameTime;
    char _m7_pad[8];
    float View_MaterialTextureMipBias;
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_Material
{
    spvUnsafeArray<float4, 4> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
    float4 out_var_SV_Target1 [[color(1)]];
    float4 out_var_SV_Target2 [[color(2)]];
    float4 out_var_SV_Target3 [[color(3)]];
    float4 out_var_SV_Target4 [[color(4)]];
    float4 out_var_SV_Target5 [[color(5)]];
    uint gl_SampleMask [[sample_mask]];
};

struct MainPS_in
{
    float4 in_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 in_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 in_var_TEXCOORD0_0 [[user(locn2)]];
    uint in_var_PRIMITIVE_ID [[user(locn3)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_0000181d_6b8a75d4(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture2d<float> Material_Texture2D_0 [[texture(0)]], sampler Material_Texture2D_0Sampler [[sampler(0)]], float4 gl_FragCoord [[position]], uint gl_SampleMaskIn [[sample_mask]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _127 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _132 = (_127.xyz / float3(_127.w)) - View.View_PreViewTranslation;
    float4 _152 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(0.0, View.View_GameTime * (-0.20000000298023223876953125)) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(1.0, 0.0))), bias(View.View_MaterialTextureMipBias));
    float3 _172 = fast::max(mix((((_152.xyz * 0.100000001490116119384765625) * Material.Material_VectorExpressions[2].xyz) + Material.Material_VectorExpressions[2].xyz) * (((1.0 + dot(float3(-0.2857142984867095947265625, -0.4285714328289031982421875, 0.857142865657806396484375), normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0)) * 0.5) + 0.20000000298023223876953125), Material.Material_VectorExpressions[3].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _202;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _178 = in.in_var_PRIMITIVE_ID * 36u;
        float3 _201;
        if (any(abs(_132 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _178 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _178 + 19u)].xyz + float3(1.0))))
        {
            _201 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_132, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _201 = _172;
        }
        _202 = _201;
    }
    else
    {
        _202 = _172;
    }
    float4 _208 = float4(0.0);
    _208.w = 0.0;
    float4 _209 = float4(_202 * 1.0, 0.0);
    _209.w = 1.0;
    float4 _220;
    uint _221;
    if (View.View_NumSceneColorMSAASamples > 1)
    {
        _220 = _209 * (float(View.View_NumSceneColorMSAASamples) * 0.25);
        _221 = gl_SampleMaskIn & 15u;
    }
    else
    {
        _220 = _209;
        _221 = gl_SampleMaskIn;
    }
    out.out_var_SV_Target0 = _220 * View.View_PreExposure;
    out.out_var_SV_Target1 = float4(0.0);
    out.out_var_SV_Target2 = _208;
    out.out_var_SV_Target3 = float4(0.0);
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    out.gl_SampleMask = _221;
    return out;
}

