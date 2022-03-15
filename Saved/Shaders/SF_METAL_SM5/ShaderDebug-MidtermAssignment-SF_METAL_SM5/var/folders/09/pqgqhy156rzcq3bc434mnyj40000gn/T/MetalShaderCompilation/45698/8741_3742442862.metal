

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
    char _m0_pad[256];
    float4x4 View_ViewToTranslatedWorld;
    char _m1_pad[384];
    float4x4 View_SVPositionToTranslatedWorld;
    char _m2_pad[304];
    float3 View_WorldCameraOrigin;
    char _m3_pad[32];
    float3 View_PreViewTranslation;
    char _m4_pad[1028];
    float View_PreExposure;
    char _m5_pad[72];
    float View_OutOfBoundsMask;
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_Material
{
    spvUnsafeArray<float4, 14> Material_VectorExpressions;
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

fragment MainPS_out Main_00002225_df11256e(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<float> Material_VolumeTexture_0 [[texture(0)]], sampler Material_VolumeTexture_0Sampler [[sampler(0)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _105 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _110 = (_105.xyz / float3(_105.w)) - View.View_PreViewTranslation;
    float3 _111 = _110 - View.View_WorldCameraOrigin;
    float3 _115 = _111 / float3(sqrt(dot(_111, _111)));
    float4 _263;
    switch (0u)
    {
        default:
        {
            float3x3 _165 = float3x3(float3(Material.Material_VectorExpressions[10].xyz), float3(Material.Material_VectorExpressions[11].xyz), float3(Material.Material_VectorExpressions[12].xyz));
            float3 _169 = (View.View_WorldCameraOrigin * _165) + Material.Material_VectorExpressions[9].xyz;
            float3 _170 = _115 * _165;
            float3 _171 = float3(1.0) / _170;
            float _173 = _169.x;
            float _175 = _171.x;
            float _176 = (Material.Material_VectorExpressions[7].x - _173) * _175;
            float _179 = (Material.Material_VectorExpressions[8].x - _173) * _175;
            float _181 = _169.y;
            float _183 = _171.y;
            float _184 = (Material.Material_VectorExpressions[7].y - _181) * _183;
            float _187 = (Material.Material_VectorExpressions[8].y - _181) * _183;
            float _189 = _169.z;
            float _191 = _171.z;
            float _192 = (Material.Material_VectorExpressions[7].z - _189) * _191;
            float _195 = (Material.Material_VectorExpressions[8].z - _189) * _191;
            float _200 = fast::max(fast::max(fast::min(_176, _179), fast::min(_184, _187)), fast::min(_192, _195));
            float _205 = fast::min(fast::min(fast::max(_176, _179), fast::max(_184, _187)), fast::max(_192, _195));
            if (_205 < 0.0)
            {
                _263 = float4(0.0);
                break;
            }
            if (_200 > _205)
            {
                _263 = float4(0.0);
                break;
            }
            if (Material.Material_ScalarExpressions[1].x > 0.001000000047497451305389404296875)
            {
                _263 = float4(1.0);
                break;
            }
            float3 _223;
            _223 = _169 + (_170 * _200);
            float _221;
            float3 _224;
            float4 _262;
            float _220 = _200;
            int _225 = 0;
            for (;;)
            {
                if (float(_225) < 30.0)
                {
                    float3 _232 = (_223 - Material.Material_VectorExpressions[7].xyz) / (Material.Material_VectorExpressions[8].xyz - Material.Material_VectorExpressions[7].xyz);
                    float _233 = _232.x;
                    float _237 = _232.y;
                    float _242 = _232.z;
                    float _259;
                    if ((((((_233 > 9.9999999392252902907785028219223e-09) && (_233 < 1.0)) && (_237 > 9.9999999392252902907785028219223e-09)) && (_237 < 1.0)) && (_242 > 9.9999999392252902907785028219223e-09)) && (_242 < 1.0))
                    {
                        float4 _250 = Material_VolumeTexture_0.sample(Material_VolumeTexture_0Sampler, _232);
                        float _252 = _250.w - Material.Material_ScalarExpressions[0].y;
                        if ((abs(_252) < (Material.Material_ScalarExpressions[0].z * Material.Material_ScalarExpressions[0].x)) && (_220 < (1000000.0 / dot(_115, float3x3(View.View_ViewToTranslatedWorld[0].xyz, View.View_ViewToTranslatedWorld[1].xyz, View.View_ViewToTranslatedWorld[2].xyz) * float3(0.0, 0.0, 1.0)))))
                        {
                            _262 = _250;
                            break;
                        }
                        _259 = _252;
                    }
                    else
                    {
                        _259 = Material.Material_ScalarExpressions[0].z;
                    }
                    _221 = _220 + (_259 * Material.Material_ScalarExpressions[0].w);
                    _224 = _169 + (_170 * _221);
                    _220 = _221;
                    _223 = _224;
                    _225++;
                    continue;
                }
                else
                {
                    _262 = float4(0.0);
                    break;
                }
            }
            _263 = _262;
            break;
        }
    }
    float3 _272 = fast::max(mix(_263.xyz, Material.Material_VectorExpressions[13].xyz, float3(Material.Material_ScalarExpressions[1].y)), float3(0.0));
    float3 _302;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _278 = in.in_var_PRIMITIVE_ID * 36u;
        float3 _301;
        if (any(abs(_110 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _278 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _278 + 19u)].xyz + float3(1.0))))
        {
            _301 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_110, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _301 = _272;
        }
        _302 = _301;
    }
    else
    {
        _302 = _272;
    }
    float4 _306 = float4(_302, 0.0);
    float4 _307 = float4(0.0);
    _307.w = 0.0;
    float3 _311 = _306.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_311.x, _311.y, _311.z, _306.w);
    out.out_var_SV_Target1 = float4(0.0);
    out.out_var_SV_Target2 = _307;
    out.out_var_SV_Target3 = float4(0.0);
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

