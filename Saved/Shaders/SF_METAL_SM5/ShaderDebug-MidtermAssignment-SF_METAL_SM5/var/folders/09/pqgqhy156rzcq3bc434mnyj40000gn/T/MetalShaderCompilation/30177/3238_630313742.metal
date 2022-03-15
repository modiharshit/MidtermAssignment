

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
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct Main_out
{
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    uint in_var_ATTRIBUTE13 [[attribute(13)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

vertex Main_out Main_00000ca6_2591d30e(Main_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(2)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]])
{
    Main_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    uint _42 = in.in_var_ATTRIBUTE13 * 36u;
    uint _45 = _42 + 1u;
    uint _48 = _42 + 2u;
    uint _51 = _42 + 3u;
    float3 _56 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _42)].xyz * in.in_var_ATTRIBUTE0.xxx;
    float3 _59 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _45)].xyz * in.in_var_ATTRIBUTE0.yyy;
    float3 _60 = _56 + _59;
    float3 _63 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _48)].xyz * in.in_var_ATTRIBUTE0.zzz;
    float3 _64 = _60 + _63;
    float3 _66 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _51)].xyz + View.View_PreViewTranslation;
    float3 _67 = _64 + _66;
    float _68 = _67.x;
    float _69 = _67.y;
    float _70 = _67.z;
    float4 _71 = float4(_68, _69, _70, 1.0);
    float4 _72 = float4(_71.x, _71.y, _71.z, _71.w);
    float4 _73 = View.View_TranslatedWorldToClip * _72;
    out.gl_Position = _73;
    return out;
}

