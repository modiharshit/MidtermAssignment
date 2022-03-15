

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
    char _m0_pad[960];
    float3 View_ViewForward;
    char _m1_pad[96];
    float3 View_WorldCameraOrigin;
    char _m2_pad[1280];
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeMin;
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeInvSize;
};

struct type_DeferredLightUniforms
{
    char _m0_pad[48];
    packed_float3 DeferredLightUniforms_Position;
    float DeferredLightUniforms_InvRadius;
    float3 DeferredLightUniforms_Color;
    float3 DeferredLightUniforms_Direction;
    char _m4_pad[16];
    float2 DeferredLightUniforms_SpotAngles;
};

struct type_Globals
{
    spvUnsafeArray<float4x4, 6> ShadowViewProjectionMatrices;
    float InvShadowmapResolution;
    float4x4 WorldToShadowMatrix;
    float4 ShadowmapMinMax;
    float4 ShadowInjectParams;
    float4 DepthBiasParameters;
    uint bStaticallyShadowed;
    float4x4 WorldToStaticShadowMatrix;
    float4 StaticShadowBufferSize;
    uint VolumeCascadeIndex;
    float SpotlightMask;
};

constant float4 _103 = {};

struct InjectMainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
    float4 out_var_SV_Target1 [[color(1)]];
};

struct InjectMainPS_in
{
    float2 in_var_TEXCOORD0 [[user(locn0), center_no_perspective]];
};

fragment InjectMainPS_out Main_00002e0e_255bd640(InjectMainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_DeferredLightUniforms& DeferredLightUniforms [[buffer(1)]], constant type_Globals& _Globals [[buffer(2)]], texture2d<float> ShadowDepthTexture [[texture(0)]], depthcube<float> ShadowDepthCubeTexture [[texture(1)]], texture2d<float> StaticShadowDepthTexture [[texture(2)]], sampler ShadowDepthTextureSampler [[sampler(0)]], sampler ShadowDepthCubeTextureSampler [[sampler(1)]], sampler StaticShadowDepthTextureSampler [[sampler(2)]], uint gl_Layer [[render_target_array_index]])
{
    InjectMainPS_out out = {};
    float _114 = float(gl_Layer) + 0.5;
    float _126 = 0.5 * View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].w;
    float3 _131 = float3((View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].xy + (in.in_var_TEXCOORD0 / View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].xy)) - float2(_126), View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].z + (_114 * View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].w));
    float3 _140 = float3(DeferredLightUniforms.DeferredLightUniforms_Position) - _131;
    if (((1.0 / (DeferredLightUniforms.DeferredLightUniforms_InvRadius * DeferredLightUniforms.DeferredLightUniforms_InvRadius)) - dot(_140, _140)) < 0.0)
    {
        discard_fragment();
    }
    float3 _150 = normalize(_140);
    float3 _156 = _131 + float3(dot(abs(_150 * float3(_126)), float3(1.0)));
    float3 _157 = float3(DeferredLightUniforms.DeferredLightUniforms_Position) - _156;
    float _158 = dot(_157, _157);
    float _162 = (_158 * DeferredLightUniforms.DeferredLightUniforms_InvRadius) * DeferredLightUniforms.DeferredLightUniforms_InvRadius;
    float _165 = fast::clamp(1.0 - (_162 * _162), 0.0, 1.0);
    float _178 = fast::clamp((dot(normalize(_157), DeferredLightUniforms.DeferredLightUniforms_Direction) - DeferredLightUniforms.DeferredLightUniforms_SpotAngles.x) * DeferredLightUniforms.DeferredLightUniforms_SpotAngles.y, 0.0, 1.0);
    float _180 = (_178 * _178) * ((1.0 / (_158 + 1.0)) * (_165 * _165));
    bool _183 = _Globals.SpotlightMask < 1.0;
    float _288;
    if (_Globals.bStaticallyShadowed != 0u)
    {
        float _287;
        if (_183)
        {
            float3 _264 = _156 - float3(DeferredLightUniforms.DeferredLightUniforms_Position);
            float _265 = length(_264);
            float3 _267 = _264 / float3(_265);
            float _271 = atan2(_267.y, _267.x) * 0.15915493667125701904296875;
            _287 = float((_265 * DeferredLightUniforms.DeferredLightUniforms_InvRadius) < StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, float2((_271 > 0.0) ? _271 : (1.0 + _271), acos(_267.z) * 0.3183098733425140380859375), level(0.0)).x);
        }
        else
        {
            float4 _199 = _Globals.WorldToStaticShadowMatrix * float4(_156, 1.0);
            float2 _203 = _199.xy / float2(_199.w);
            bool2 _204 = _203 >= float2(0.0);
            bool2 _205 = _203 <= float2(1.0);
            float _263;
            if (all(bool2(_204.x && _205.x, _204.y && _205.y)))
            {
                float2 _217 = (_203 * _Globals.StaticShadowBufferSize.xy) - float2(0.5);
                float2 _218 = fract(_217);
                float2 _219 = floor(_217);
                float4 _227 = _103;
                _227.x = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_219 + float2(0.5, 1.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _233 = _227;
                _233.y = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_219 + float2(1.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _239 = _233;
                _239.z = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_219 + float2(1.5, 0.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _244 = _239;
                _244.w = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_219 + float2(0.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _254 = fast::clamp(fast::clamp((_244 * 40.0) - float4((_199.z * 40.0) - 1.0), float4(0.0), float4(1.0)) + select(float4(0.0), float4(1.0), _244 > float4(0.9900000095367431640625)), float4(0.0), float4(1.0));
                float2 _258 = mix(_254.wx, _254.zy, _218.xx);
                _263 = mix(_258.x, _258.y, _218.y);
            }
            else
            {
                _263 = 1.0;
            }
            _287 = _263;
        }
        _288 = _287;
    }
    else
    {
        _288 = 1.0;
    }
    float _376;
    if (_183)
    {
        float _375;
        if ((length(_157) * DeferredLightUniforms.DeferredLightUniforms_InvRadius) < 1.0)
        {
            float3 _334 = abs(_157);
            float _335 = _334.x;
            float _336 = _334.y;
            float _337 = _334.z;
            float _339 = fast::max(_335, fast::max(_336, _337));
            int _358;
            if (_339 == _335)
            {
                _358 = (_335 == _157.x) ? 0 : 1;
            }
            else
            {
                int _354;
                if (_339 == _336)
                {
                    _354 = (_336 == _157.y) ? 2 : 3;
                }
                else
                {
                    _354 = (_337 == _157.z) ? 4 : 5;
                }
                _358 = _354;
            }
            float4 _366 = _Globals.ShadowViewProjectionMatrices[_358] * float4(-_157, 1.0);
            float _368 = _366.w;
            _375 = ShadowDepthCubeTexture.sample_compare(ShadowDepthCubeTextureSampler, _157, (_366.z / _368) + ((_Globals.InvShadowmapResolution * (-15.35999965667724609375)) / _368), level(0.0));
        }
        else
        {
            _375 = 1.0;
        }
        _376 = _375;
    }
    else
    {
        float4 _298 = _Globals.WorldToShadowMatrix * float4(_156, 1.0);
        float2 _302 = _298.xy / float2(_298.w);
        bool2 _306 = _302 >= _Globals.ShadowmapMinMax.xy;
        bool2 _308 = _302 <= _Globals.ShadowmapMinMax.zw;
        float _324;
        if (all(bool2(_306.x && _308.x, _306.y && _308.y)))
        {
            _324 = float(_298.z < (ShadowDepthTexture.sample(ShadowDepthTextureSampler, _302, level(0.0)).x - _Globals.DepthBiasParameters.x));
        }
        else
        {
            _324 = 1.0;
        }
        _376 = _324;
    }
    float _397;
    if ((!_183) && (!(_Globals.SpotlightMask >= 1.0)))
    {
        float _394 = fast::clamp((dot(_156 - View.View_WorldCameraOrigin, View.View_ViewForward) * _Globals.ShadowInjectParams.z) + _Globals.ShadowInjectParams.w, 0.0, 1.0);
        _397 = mix(_376, 1.0, _394 * _394);
    }
    else
    {
        _397 = _376;
    }
    float _398 = fast::min(_288, _397);
    float _420;
    float _421;
    if (_Globals.VolumeCascadeIndex == 1u)
    {
        float3 _412 = fast::clamp((float3(0.5) - abs(((float3(in.in_var_TEXCOORD0, _114 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w) * (1.0 + (4.0 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w))) - float3(2.0 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w)) - float3(0.5))) * 10.0, float3(0.0), float3(1.0));
        float _417 = (_412.x * _412.y) * _412.z;
        _420 = mix(0.0, _398, _417);
        _421 = mix(0.0, _180, _417);
    }
    else
    {
        _420 = _398;
        _421 = _180;
    }
    float3 _426 = ((DeferredLightUniforms.DeferredLightUniforms_Color * float3(0.3183098733425140380859375)) * _421) * _420;
    float4 _427 = _103;
    _427.x = 0.2820949852466583251953125;
    float4 _430 = _427;
    _430.y = (-0.48860299587249755859375) * _150.y;
    float4 _433 = _430;
    _433.z = 0.48860299587249755859375 * _150.z;
    float4 _436 = _433;
    _436.w = (-0.48860299587249755859375) * _150.x;
    float4 _438 = _436 * _426.x;
    float4 _440 = _436 * _426.y;
    float4 _442 = _436 * _426.z;
    out.out_var_SV_Target0 = float4(_438.x, _440.x, _442.x, 0.0) * 1.0;
    out.out_var_SV_Target1 = float4(dot(float3(_438.y, _440.y, _442.y), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), dot(float3(_438.z, _440.z, _442.z), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), dot(float3(_438.w, _440.w, _442.w), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), 0.0) * 1.0;
    return out;
}

