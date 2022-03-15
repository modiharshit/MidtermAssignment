

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
    char _m4_pad[36];
    float View_GameTime;
    char _m5_pad[8];
    float View_MaterialTextureMipBias;
    char _m6_pad[1024];
    float View_bCheckerboardSubsurfaceProfileRendering;
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_Material
{
    spvUnsafeArray<float4, 16> Material_VectorExpressions;
    spvUnsafeArray<float4, 4> Material_ScalarExpressions;
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
    float4 in_var_TEXCOORD0_0 [[user(locn2)]];
    uint in_var_PRIMITIVE_ID [[user(locn3)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00001eb5_f6e3d76e(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture2d<float> Material_Texture2D_0 [[texture(0)]], texture2d<float> Material_Texture2D_1 [[texture(1)]], texture2d<float> Material_Texture2D_2 [[texture(2)]], sampler Material_Texture2D_0Sampler [[sampler(0)]], sampler Material_Texture2D_1Sampler [[sampler(1)]], sampler Material_Texture2D_2Sampler [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _119 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _123 = _119.xyz / float3(_119.w);
    float3 _124 = _123 - View.View_PreViewTranslation;
    float3 _126 = normalize(-_123);
    float4 _133 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (in_var_TEXCOORD0[0].zw * 12.0), bias(View.View_MaterialTextureMipBias));
    float _147 = fast::min(fast::max(dot(_126, float3(0.0, 0.0, -1.0)), 0.0), 1.0);
    float _148 = 1.0 - _147;
    float _166 = abs(dot(_126, Material.Material_VectorExpressions[7].xyz) - 1.0);
    float _182 = View.View_GameTime * Material.Material_ScalarExpressions[2].y;
    float4 _189 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(_182 * 0.00019999999494757503271102905273438, 0.0) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y)), bias(View.View_MaterialTextureMipBias));
    float4 _196 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(_182 * 0.001000000047497451305389404296875, 0.0) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y)), bias(View.View_MaterialTextureMipBias));
    uint _200 = in.in_var_PRIMITIVE_ID * 36u;
    uint _201 = _200 + 5u;
    float _218 = mix(0.0, mix(_189.x, _196.x, _147), (1.0 - fast::min(fast::max(((_124 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _201)].xyz) / float3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _201)].w * (-0.100000001490116119384765625))).z, 0.0), 1.0)) * Material.Material_ScalarExpressions[2].z);
    float4 _221 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5), bias(View.View_MaterialTextureMipBias));
    float _230 = (_218 <= 0.0) ? 0.0 : pow(_218, mix(Material.Material_ScalarExpressions[2].w, Material.Material_ScalarExpressions[3].x, _221.x));
    float _238 = fast::min(fast::max(1.0 - (_166 * 0.769230782985687255859375), 0.0), 1.0);
    float _248 = _230 * _230;
    float3 _268 = fast::max(mix((mix(mix(Material.Material_VectorExpressions[2].xyz + ((_133.xyz * Material.Material_ScalarExpressions[0].x) * Material.Material_ScalarExpressions[0].y), Material.Material_VectorExpressions[4].xyz, float3(fast::min(fast::max((_148 <= 0.0) ? 0.0 : pow(_148, Material.Material_ScalarExpressions[0].z), 0.0), 1.0))) + (Material.Material_VectorExpressions[10].xyz * fast::min(fast::max(1.0 - (_166 * Material.Material_ScalarExpressions[1].w), 0.0), 1.0)), (Material.Material_VectorExpressions[12].xyz * _230) + ((Material.Material_VectorExpressions[9].xyz * fast::min(fast::max((_238 <= 0.0) ? 0.0 : pow(_238, 10.0), 0.0), 1.0)) * (_248 * 0.4000000059604644775390625)), float3(fast::min(fast::max(_248, 0.0), 1.0))) * Material.Material_VectorExpressions[14].xyz) * 1.5, Material.Material_VectorExpressions[15].xyz, float3(Material.Material_ScalarExpressions[3].y)), float3(0.0));
    float3 _295;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _294;
        if (any(abs(_124 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _201)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _200 + 19u)].xyz + float3(1.0))))
        {
            _294 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_124, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _294 = _268;
        }
        _295 = _294;
    }
    else
    {
        _295 = _268;
    }
    float4 _300 = float4(_295 * 1.0, 0.0);
    float4 _307;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _306 = _300;
        _306.w = 0.0;
        _307 = _306;
    }
    else
    {
        _307 = _300;
    }
    float4 _308 = float4(0.0);
    _308.w = 0.0;
    out.out_var_SV_Target0 = _307 * View.View_PreExposure;
    out.out_var_SV_Target1 = float4(0.0);
    out.out_var_SV_Target2 = _308;
    out.out_var_SV_Target3 = float4(0.0);
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

