

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
    char _m4_pad[72];
    float View_OutOfBoundsMask;
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
    float4 in_var_TEXCOORD11_centroid [[user(locn1)]];
    uint in_var_PRIMITIVE_ID [[user(locn2)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_0000136e_c4edf48a(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], float4 gl_FragCoord [[position]], uint gl_SampleMaskIn [[sample_mask]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _93 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _97 = _93.xyz / float3(_93.w);
    float3 _98 = _97 - View.View_PreViewTranslation;
    float _103 = fast::min(fast::max(dot(in.in_var_TEXCOORD11_centroid.xyz, normalize(-_97)), 0.0), 1.0);
    float3 _121 = fast::max(mix(Material.Material_VectorExpressions[2].xyz * ((((_103 <= 0.0) ? 0.0 : pow(_103, 20.0)) * 0.5) + mix(0.5, 1.0, _103)), Material.Material_VectorExpressions[3].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _151;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _127 = in.in_var_PRIMITIVE_ID * 36u;
        float3 _150;
        if (any(abs(_98 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _127 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _127 + 19u)].xyz + float3(1.0))))
        {
            _150 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_98, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _150 = _121;
        }
        _151 = _150;
    }
    else
    {
        _151 = _121;
    }
    float4 _157 = float4(0.0);
    _157.w = 0.0;
    float4 _158 = float4(_151 * 1.0, 0.0);
    _158.w = 1.0;
    float4 _169;
    uint _170;
    if (View.View_NumSceneColorMSAASamples > 1)
    {
        _169 = _158 * (float(View.View_NumSceneColorMSAASamples) * 0.25);
        _170 = gl_SampleMaskIn & 15u;
    }
    else
    {
        _169 = _158;
        _170 = gl_SampleMaskIn;
    }
    out.out_var_SV_Target0 = _169 * View.View_PreExposure;
    out.out_var_SV_Target1 = float4(0.0);
    out.out_var_SV_Target2 = _157;
    out.out_var_SV_Target3 = float4(0.0);
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    out.gl_SampleMask = _170;
    return out;
}

