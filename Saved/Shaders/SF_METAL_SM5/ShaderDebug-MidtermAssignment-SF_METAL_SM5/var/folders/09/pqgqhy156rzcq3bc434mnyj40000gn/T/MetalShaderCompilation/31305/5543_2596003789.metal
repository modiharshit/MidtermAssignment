

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
    char _m3_pad[72];
    float View_OutOfBoundsMask;
    char _m4_pad[1076];
    float View_bCheckerboardSubsurfaceProfileRendering;
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_Material
{
    spvUnsafeArray<float4, 4> Material_VectorExpressions;
    spvUnsafeArray<float4, 2> Material_ScalarExpressions;
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
    uint in_var_PRIMITIVE_ID [[user(locn2)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_000015a7_9abbdfcd(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texturecube<float> Material_TextureCube_0 [[texture(0)]], sampler Material_TextureCube_0Sampler [[sampler(0)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _87 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _92 = (_87.xyz / float3(_87.w)) - View.View_PreViewTranslation;
    float3 _96 = float4(0.0, 0.0, 1.0, Material.Material_ScalarExpressions[0].y).xyz;
    float3 _98 = _96 * dot(_96, _92);
    float3 _99 = _92 - _98;
    float3 _106 = _98 + ((_99 * cos(Material.Material_ScalarExpressions[0].y)) + (cross(_96, _99) * sin(Material.Material_ScalarExpressions[0].y)));
    float4 _114 = Material_TextureCube_0.sample(Material_TextureCube_0Sampler, (_106 / float3(sqrt(dot(_106, _106)))));
    float _117 = _114.x;
    float _121 = _114.y;
    float _125 = _114.z;
    float3 _144 = fast::max(mix((float3((_117 <= 0.0) ? 0.0 : pow(_117, Material.Material_ScalarExpressions[0].z), (_121 <= 0.0) ? 0.0 : pow(_121, Material.Material_ScalarExpressions[0].z), (_125 <= 0.0) ? 0.0 : pow(_125, Material.Material_ScalarExpressions[0].z)) * Material.Material_ScalarExpressions[0].w) * Material.Material_VectorExpressions[2].xyz, Material.Material_VectorExpressions[3].xyz, float3(Material.Material_ScalarExpressions[1].x)), float3(0.0));
    float3 _174;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _150 = in.in_var_PRIMITIVE_ID * 36u;
        float3 _173;
        if (any(abs(_92 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _150 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _150 + 19u)].xyz + float3(1.0))))
        {
            _173 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_92, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _173 = _144;
        }
        _174 = _173;
    }
    else
    {
        _174 = _144;
    }
    float4 _179 = float4(_174 * 1.0, 0.0);
    float4 _186;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _185 = _179;
        _185.w = 0.0;
        _186 = _185;
    }
    else
    {
        _186 = _179;
    }
    float4 _187 = float4(0.0);
    _187.w = 0.0;
    out.out_var_SV_Target0 = _186 * View.View_PreExposure;
    out.out_var_SV_Target1 = float4(0.0);
    out.out_var_SV_Target2 = _187;
    out.out_var_SV_Target3 = float4(0.0);
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

