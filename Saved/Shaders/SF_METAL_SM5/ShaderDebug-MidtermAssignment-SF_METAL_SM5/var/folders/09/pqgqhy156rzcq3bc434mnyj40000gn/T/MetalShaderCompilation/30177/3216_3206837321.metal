

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
    uint in_var_ATTRIBUTE1 [[attribute(1)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

vertex Main_out Main_00000c90_bf247449(Main_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(2)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]])
{
    Main_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    uint _41 = in.in_var_ATTRIBUTE1 * 36u;
    uint _44 = _41 + 1u;
    uint _47 = _41 + 2u;
    uint _50 = _41 + 3u;
    float3 _55 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _41)].xyz * in.in_var_ATTRIBUTE0.xxx;
    float3 _58 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _44)].xyz * in.in_var_ATTRIBUTE0.yyy;
    float3 _59 = _55 + _58;
    float3 _62 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _47)].xyz * in.in_var_ATTRIBUTE0.zzz;
    float3 _63 = _59 + _62;
    float3 _65 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _50)].xyz + View.View_PreViewTranslation;
    float3 _66 = _63 + _65;
    float _67 = _66.x;
    float _68 = _66.y;
    float _69 = _66.z;
    float4 _70 = float4(_67, _68, _69, 1.0);
    float4 _71 = View.View_TranslatedWorldToClip * _70;
    out.gl_Position = _71;
    return out;
}

