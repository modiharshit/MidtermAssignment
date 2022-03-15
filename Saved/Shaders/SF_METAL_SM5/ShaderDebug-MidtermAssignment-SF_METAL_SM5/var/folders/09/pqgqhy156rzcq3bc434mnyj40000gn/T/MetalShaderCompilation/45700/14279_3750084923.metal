

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
    char _m0_pad[2280];
    float View_GameTime;
};

struct type_RenderVolumetricCloudParameters
{
    char _m0_pad[16];
    float3 RenderVolumetricCloudParameters_CloudLayerCenterKm;
    float RenderVolumetricCloudParameters_BottomRadiusKm;
    float RenderVolumetricCloudParameters_TopRadiusKm;
    char _m3_pad[64];
    spvUnsafeArray<float4, 2> RenderVolumetricCloudParameters_CloudShadowmapFarDepthKm;
    spvUnsafeArray<float4, 2> RenderVolumetricCloudParameters_CloudShadowmapStrength;
    spvUnsafeArray<float4, 2> RenderVolumetricCloudParameters_CloudShadowmapDepthBias;
    spvUnsafeArray<float4, 2> RenderVolumetricCloudParameters_CloudShadowmapSampleCount;
    spvUnsafeArray<float4, 2> RenderVolumetricCloudParameters_CloudShadowmapSizeInvSize;
    char _m8_pad[160];
    spvUnsafeArray<float4x4, 2> RenderVolumetricCloudParameters_CloudShadowmapWorldToLightClipMatrixInv;
    spvUnsafeArray<float4, 2> RenderVolumetricCloudParameters_CloudShadowmapTracingPixelScaleOffset;
    spvUnsafeArray<float4, 2> RenderVolumetricCloudParameters_CloudShadowmapLightDir;
    char _m11_pad[64];
    float RenderVolumetricCloudParameters_CloudSkyAOFarDepthKm;
    float RenderVolumetricCloudParameters_CloudSkyAOStrength;
    float RenderVolumetricCloudParameters_CloudSkyAOSampleCount;
    float4 RenderVolumetricCloudParameters_CloudSkyAOSizeInvSize;
    char _m15_pad[64];
    float4x4 RenderVolumetricCloudParameters_CloudSkyAOWorldToLightClipMatrixInv;
    float3 RenderVolumetricCloudParameters_CloudSkyAOTraceDir;
    char _m17_pad[908];
    uint RenderVolumetricCloudParameters_TraceShadowmap;
};

struct type_Material
{
    spvUnsafeArray<float4, 7> Material_VectorExpressions;
    spvUnsafeArray<float4, 6> Material_ScalarExpressions;
};

constant float _98 = {};

struct MainPS_out
{
    float3 out_var_SV_Target0 [[color(0)]];
};

fragment MainPS_out Main_000037c7_df85c13b(constant type_View& View [[buffer(0)]], constant type_RenderVolumetricCloudParameters& RenderVolumetricCloudParameters [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture2d<float> Material_Texture2D_0 [[texture(0)]], texture2d<float> Material_Texture2D_1 [[texture(1)]], texture3d<float> Material_VolumeTexture_0 [[texture(2)]], texture3d<float> Material_VolumeTexture_1 [[texture(3)]], sampler Material_Texture2D_0Sampler [[sampler(0)]], sampler Material_Texture2D_1Sampler [[sampler(1)]], sampler Material_VolumeTexture_0Sampler [[sampler(2)]], sampler Material_VolumeTexture_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    float3 _449;
    switch (0u)
    {
        default:
        {
            float _151;
            float _152;
            float _153;
            float _154;
            float3 _155;
            float4x4 _156;
            float4 _157;
            float4 _158;
            if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TraceShadowmap >= 1u)
            {
                uint _133 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TraceShadowmap - 1u;
                _151 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudShadowmapDepthBias[_133].x;
                _152 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudShadowmapStrength[_133].x;
                _153 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudShadowmapSampleCount[_133].x;
                _154 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudShadowmapFarDepthKm[_133].x;
                _155 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudShadowmapLightDir[_133].xyz;
                _156 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudShadowmapWorldToLightClipMatrixInv[_133];
                _157 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudShadowmapSizeInvSize[_133];
                _158 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudShadowmapTracingPixelScaleOffset[_133];
            }
            else
            {
                _151 = 0.0;
                _152 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudSkyAOStrength;
                _153 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudSkyAOSampleCount;
                _154 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudSkyAOFarDepthKm;
                _155 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudSkyAOTraceDir;
                _156 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudSkyAOWorldToLightClipMatrixInv;
                _157 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudSkyAOSizeInvSize;
                _158 = float4(1.0, 1.0, 0.0, 0.0);
            }
            float _196;
            float _202;
            float _166 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_BottomRadiusKm * 100000.0;
            float4 _182 = _156 * float4(((((gl_FragCoord.xy * _158.xy) + _158.zw) * _157.zw) * float2(2.0, -2.0)) + float2(-1.0, 1.0), 1.0, 1.0);
            float3 _185 = _182.xyz / _182.www;
            float3 _186 = _185 * 9.9999997473787516355514526367188e-06;
            float2 _216;
            bool _217;
            switch (0u)
            {
                default:
                {
                    float3 _194 = _186 - float4(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudLayerCenterKm, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm).xyz;
                    _196 = dot(_155, _155);
                    float _197 = dot(_155, _194);
                    float _198 = 2.0 * _197;
                    _202 = 4.0 * _196;
                    float _204 = (_198 * _198) - (_202 * (dot(_194, _194) - (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm)));
                    if (_204 >= 0.0)
                    {
                        _216 = (float2(_197 * (-2.0)) + (float2(-1.0, 1.0) * sqrt(_204))) / float2(2.0 * _196);
                        _217 = true;
                        break;
                    }
                    _216 = float2(0.0);
                    _217 = false;
                    break;
                }
            }
            float _268;
            float _269;
            if (_217)
            {
                float2 _246;
                bool _247;
                switch (0u)
                {
                    default:
                    {
                        float3 _226 = _186 - float4(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudLayerCenterKm, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_BottomRadiusKm).xyz;
                        float _228 = dot(_155, _226);
                        float _229 = 2.0 * _228;
                        float _234 = (_229 * _229) - (_202 * (dot(_226, _226) - (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_BottomRadiusKm * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_BottomRadiusKm)));
                        if (_234 >= 0.0)
                        {
                            _246 = (float2(_228 * (-2.0)) + (float2(-1.0, 1.0) * sqrt(_234))) / float2(2.0 * _196);
                            _247 = true;
                            break;
                        }
                        _246 = float2(0.0);
                        _247 = false;
                        break;
                    }
                }
                if (_247)
                {
                    bool _254 = all(_246 > float2(0.0));
                    float _259 = _254 ? fast::min(_246.x, _246.y) : fast::max(_246.x, _246.y);
                    if (!_254)
                    {
                        _449 = float3(0.0);
                        break;
                    }
                    float _265 = fast::max(0.0, fast::min(_216.x, _216.y));
                    _268 = fast::max(_259, _265);
                    _269 = fast::min(_259, _265);
                }
                else
                {
                    _268 = _216.y;
                    _269 = _216.x;
                }
            }
            else
            {
                _449 = float3(_154, 0.0, 0.0);
                break;
            }
            float _271 = fast::max(0.0, _269) * 100000.0;
            float _272 = fast::max(0.0, _268);
            float _276 = _154 * 100000.0;
            float _277 = (_272 * 100000.0) - _271;
            float _282;
            float3 _285;
            float _287;
            float3 _289;
            _282 = _276;
            _285 = float3(0.0);
            _287 = 0.0;
            _289 = float3(0.0);
            float _283;
            float3 _286;
            float _288;
            float3 _290;
            for (float _291 = 0.5; _291 < _153; _282 = _283, _285 = _286, _287 = _288, _289 = _290, _291 += 1.0)
            {
                float _297 = _277 * (_291 * (1.0 / _153));
                float3 _299 = (_185 + (_155 * _271)) + (_155 * _297);
                float _304 = fast::clamp((length(_299 - (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudLayerCenterKm * 100000.0)) - _166) * (1.0 / ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm * 100000.0) - _166)), 0.0, 1.0);
                float4 _314 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (((_299 + float3(500000.0, 500000.0, 0.0)).xy * Material.Material_ScalarExpressions[5].y) * Material.Material_ScalarExpressions[5].y), level(-1.0));
                float _315 = _314.y;
                float _331 = ((_304 < 0.0500000007450580596923828125) || (_304 > 0.949999988079071044921875)) ? 0.0 : (_314.x * Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2((_315 <= 0.0) ? 0.0 : pow(_315, 0.25), 1.0 - _304), level(-1.0)).x);
                if (_331 <= 0.0)
                {
                    _283 = _282;
                    _286 = _285;
                    _288 = _287;
                    _290 = _289;
                    continue;
                }
                float3 _341 = Material.Material_VectorExpressions[2].xyz * View.View_GameTime;
                float3 _345 = _299 * Material.Material_ScalarExpressions[0].x;
                float4 _353 = Material_VolumeTexture_0.sample(Material_VolumeTexture_0Sampler, (((_341 * 0.1500000059604644775390625) + _345) * Material.Material_ScalarExpressions[0].y), level(-1.0));
                float _356 = _353.x;
                float _360 = _353.y;
                float _364 = _353.z;
                float3 _370 = float3(_331) * fast::clamp(float3((_356 <= 0.0) ? 0.0 : pow(_356, Material.Material_ScalarExpressions[0].z), (_360 <= 0.0) ? 0.0 : pow(_360, Material.Material_ScalarExpressions[0].z), (_364 <= 0.0) ? 0.0 : pow(_364, Material.Material_ScalarExpressions[0].z)), float3(0.0), float3(1.0));
                float4 _379 = Material_VolumeTexture_1.sample(Material_VolumeTexture_1Sampler, ((_345 + (_341 * (-0.100000001490116119384765625))) * Material.Material_ScalarExpressions[0].w), level(-1.0));
                float _380 = _379.x;
                float _388 = ((_380 <= 0.0) ? 0.0 : pow(_380, Material.Material_ScalarExpressions[1].x)) * Material.Material_ScalarExpressions[1].y;
                float _406 = fast::clamp(_304 * Material.Material_ScalarExpressions[2].x, 0.0, 1.0);
                float3 _425 = fast::clamp(float4(Material.Material_VectorExpressions[6].xyz * mix(_370, float3((float3(Material.Material_ScalarExpressions[1].w) + (fast::clamp((_370 - float3(_388)) / float3(Material.Material_ScalarExpressions[1].z - _388), float3(0.0), float3(1.0)) * (Material.Material_ScalarExpressions[1].z - Material.Material_ScalarExpressions[1].w))).x), float3((_406 <= 0.0) ? 0.0 : pow(_406, Material.Material_ScalarExpressions[2].y))), _98).xyz, float3(0.0), float3(65000.0));
                bool _427 = any(_425 > float3(0.0));
                _283 = _427 ? fast::min(_282, _297) : _282;
                _286 = _285 + (_425 * ((_277 * 0.00999999977648258209228515625) / _153));
                _288 = _287 + float(_427);
                _290 = _289 + _425;
            }
            _449 = float3(fast::max(0.0, ((_282 == _276) ? _272 : ((_271 + _282) * 9.9999997473787516355514526367188e-06)) + _151), _152 * dot(_289 / float3(fast::max(1.0, _287)), float3(0.3333333432674407958984375)), _152 * dot(_285, float3(0.3333333432674407958984375)));
            break;
        }
    }
    out.out_var_SV_Target0 = _449;
    return out;
}

