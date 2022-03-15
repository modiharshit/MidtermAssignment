

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
    char _m2_pad[272];
    float4 View_InvDeviceZToWorldZTransform;
    float4 View_ScreenPositionScaleBias;
    float3 View_WorldCameraOrigin;
    char _m5_pad[32];
    float3 View_PreViewTranslation;
    char _m6_pad[928];
    float4 View_ViewRectMin;
    float4 View_ViewSizeAndInvSize;
    char _m8_pad[16];
    float4 View_BufferSizeAndInvSize;
};

struct type_Material
{
    spvUnsafeArray<float4, 14> Material_VectorExpressions;
    spvUnsafeArray<float4, 2> Material_ScalarExpressions;
};

struct type_Globals
{
    float2 PostProcessInput_0_UVViewportMin;
    float2 PostProcessInput_0_UVViewportSize;
    char _m2_pad[64];
    uint2 PostProcessOutput_ViewportMin;
    float2 PostProcessOutput_ViewportSizeInverse;
};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

fragment MainPS_out Main_00002326_cb049adc(constant type_View& View [[buffer(0)]], constant type_Material& Material [[buffer(1)]], constant type_Globals& _Globals [[buffer(2)]], texture2d<float> SceneTexturesStruct_SceneDepthTexture [[texture(0)]], texture3d<float> Material_VolumeTexture_0 [[texture(1)]], texture2d<float> PostProcessInput_0_Texture [[texture(2)]], sampler SceneTexturesStruct_PointClampSampler [[sampler(0)]], sampler Material_VolumeTexture_0Sampler [[sampler(1)]], sampler PostProcessInput_0_Sampler [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    float2 _106 = (gl_FragCoord.xy - float2(_Globals.PostProcessOutput_ViewportMin)) * _Globals.PostProcessOutput_ViewportSizeInverse;
    float _124 = fast::max(SceneTexturesStruct_SceneDepthTexture.sample(SceneTexturesStruct_PointClampSampler, (((_106 * View.View_ViewSizeAndInvSize.xy) + View.View_ViewRectMin.xy) * View.View_BufferSizeAndInvSize.zw), level(0.0)).x, 1.0000000458137049657431332655433e-18);
    float4 _133 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _124, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _139 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xy, _124, 1.0);
    float4 _154 = PostProcessInput_0_Texture.sample(PostProcessInput_0_Sampler, ((_106 * _Globals.PostProcessInput_0_UVViewportSize) + _Globals.PostProcessInput_0_UVViewportMin));
    float3 _155 = ((_139.xyz / float3(_139.w)) - View.View_PreViewTranslation) - View.View_WorldCameraOrigin;
    float3 _159 = _155 / float3(sqrt(dot(_155, _155)));
    float4 _177 = SceneTexturesStruct_SceneDepthTexture.sample(SceneTexturesStruct_PointClampSampler, (((_133.xy / float2(_133.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz), level(0.0));
    float _178 = _177.x;
    float4 _333;
    switch (0u)
    {
        default:
        {
            float3x3 _234 = float3x3(float3(Material.Material_VectorExpressions[10].xyz), float3(Material.Material_VectorExpressions[11].xyz), float3(Material.Material_VectorExpressions[12].xyz));
            float3 _238 = (View.View_WorldCameraOrigin * _234) + Material.Material_VectorExpressions[9].xyz;
            float3 _239 = _159 * _234;
            float3 _240 = float3(1.0) / _239;
            float _242 = _238.x;
            float _244 = _240.x;
            float _245 = (Material.Material_VectorExpressions[7].x - _242) * _244;
            float _248 = (Material.Material_VectorExpressions[8].x - _242) * _244;
            float _250 = _238.y;
            float _252 = _240.y;
            float _253 = (Material.Material_VectorExpressions[7].y - _250) * _252;
            float _256 = (Material.Material_VectorExpressions[8].y - _250) * _252;
            float _258 = _238.z;
            float _260 = _240.z;
            float _261 = (Material.Material_VectorExpressions[7].z - _258) * _260;
            float _264 = (Material.Material_VectorExpressions[8].z - _258) * _260;
            float _269 = fast::max(fast::max(fast::min(_245, _248), fast::min(_253, _256)), fast::min(_261, _264));
            float _274 = fast::min(fast::min(fast::max(_245, _248), fast::max(_253, _256)), fast::max(_261, _264));
            if (_274 < 0.0)
            {
                _333 = float4(0.0);
                break;
            }
            if (_269 > _274)
            {
                _333 = float4(0.0);
                break;
            }
            if (Material.Material_ScalarExpressions[1].x > 0.001000000047497451305389404296875)
            {
                _333 = float4(1.0);
                break;
            }
            float3 _292;
            _292 = _238 + (_239 * _269);
            float _290;
            float3 _293;
            float4 _332;
            float _289 = _269;
            int _294 = 0;
            for (;;)
            {
                if (float(_294) < 30.0)
                {
                    float3 _301 = (_292 - Material.Material_VectorExpressions[7].xyz) / (Material.Material_VectorExpressions[8].xyz - Material.Material_VectorExpressions[7].xyz);
                    float _302 = _301.x;
                    float _306 = _301.y;
                    float _311 = _301.z;
                    float _329;
                    if ((((((_302 > 9.9999999392252902907785028219223e-09) && (_302 < 1.0)) && (_306 > 9.9999999392252902907785028219223e-09)) && (_306 < 1.0)) && (_311 > 9.9999999392252902907785028219223e-09)) && (_311 < 1.0))
                    {
                        float4 _319 = Material_VolumeTexture_0.sample(Material_VolumeTexture_0Sampler, _301);
                        float _321 = _319.w - Material.Material_ScalarExpressions[0].y;
                        if ((abs(_321) < (Material.Material_ScalarExpressions[0].z * Material.Material_ScalarExpressions[0].x)) && (_289 < ((((_178 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_178 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w))) / dot(_159, float3x3(View.View_ViewToTranslatedWorld[0].xyz, View.View_ViewToTranslatedWorld[1].xyz, View.View_ViewToTranslatedWorld[2].xyz) * float3(0.0, 0.0, 1.0)))))
                        {
                            float4 _328 = _319;
                            _328.w = 1.0;
                            _332 = _328;
                            break;
                        }
                        _329 = _321;
                    }
                    else
                    {
                        _329 = Material.Material_ScalarExpressions[0].z;
                    }
                    _290 = _289 + (_329 * Material.Material_ScalarExpressions[0].w);
                    _293 = _238 + (_239 * _290);
                    _289 = _290;
                    _292 = _293;
                    _294++;
                    continue;
                }
                else
                {
                    _332 = float4(0.0);
                    break;
                }
            }
            _333 = _332;
            break;
        }
    }
    out.out_var_SV_Target0 = float4(fast::max(mix((_154.xyz * (1.0 - _333.w)) + _333.xyz, Material.Material_VectorExpressions[13].xyz, float3(Material.Material_ScalarExpressions[1].y)), float3(0.0)), 1.0);
    return out;
}

