

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
    char _m2_pad[1028];
    float View_PreExposure;
    char _m3_pad[32];
    float4 View_NormalOverrideParameter;
    char _m4_pad[16];
    float View_OutOfBoundsMask;
    char _m5_pad[1076];
    float View_bCheckerboardSubsurfaceProfileRendering;
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
};

struct MainPS_in
{
    float4 in_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 in_var_TEXCOORD11_centroid [[user(locn1)]];
    uint in_var_PRIMITIVE_ID [[user(locn2)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00001490_332f12b6(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _93 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _97 = _93.xyz / float3(_93.w);
    float3 _98 = _97 - View.View_PreViewTranslation;
    float _113 = fast::max(abs(1.0 - fast::max(0.0, dot(normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0, normalize(-_97)))), 9.9999997473787516355514526367188e-05);
    float3 _130 = fast::max(mix(Material.Material_VectorExpressions[2].xyz * mix(0.5, 1.0, 1.0 - ((_113 <= 0.0) ? 0.0 : pow(_113, 1.0))), Material.Material_VectorExpressions[3].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _160;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _136 = in.in_var_PRIMITIVE_ID * 36u;
        float3 _159;
        if (any(abs(_98 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _136 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _136 + 19u)].xyz + float3(1.0))))
        {
            _159 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_98, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _159 = _130;
        }
        _160 = _159;
    }
    else
    {
        _160 = _130;
    }
    float4 _165 = float4(_160 * 1.0, 0.0);
    float4 _172;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _171 = _165;
        _171.w = 0.0;
        _172 = _171;
    }
    else
    {
        _172 = _165;
    }
    float4 _173 = float4(0.0);
    _173.w = 0.0;
    out.out_var_SV_Target0 = _172 * View.View_PreExposure;
    out.out_var_SV_Target1 = float4(0.0);
    out.out_var_SV_Target2 = _173;
    out.out_var_SV_Target3 = float4(0.0);
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

