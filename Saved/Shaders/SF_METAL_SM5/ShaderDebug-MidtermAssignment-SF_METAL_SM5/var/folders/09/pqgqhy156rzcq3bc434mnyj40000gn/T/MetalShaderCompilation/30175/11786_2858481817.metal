

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
    packed_float3 DeferredLightUniforms_Color;
    float DeferredLightUniforms_FalloffExponent;
    float3 DeferredLightUniforms_Direction;
    char _m5_pad[16];
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

fragment InjectMainPS_out Main_00002e0a_aa60f899(InjectMainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_DeferredLightUniforms& DeferredLightUniforms [[buffer(1)]], constant type_Globals& _Globals [[buffer(2)]], texture2d<float> ShadowDepthTexture [[texture(0)]], depthcube<float> ShadowDepthCubeTexture [[texture(1)]], texture2d<float> StaticShadowDepthTexture [[texture(2)]], sampler ShadowDepthTextureSampler [[sampler(0)]], sampler ShadowDepthCubeTextureSampler [[sampler(1)]], sampler StaticShadowDepthTextureSampler [[sampler(2)]], uint gl_Layer [[render_target_array_index]])
{
    InjectMainPS_out out = {};
    float _115 = float(gl_Layer) + 0.5;
    float _127 = 0.5 * View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].w;
    float3 _132 = float3((View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].xy + (in.in_var_TEXCOORD0 / View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].xy)) - float2(_127), View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].z + (_115 * View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].w));
    float3 _141 = float3(DeferredLightUniforms.DeferredLightUniforms_Position) - _132;
    if (((1.0 / (DeferredLightUniforms.DeferredLightUniforms_InvRadius * DeferredLightUniforms.DeferredLightUniforms_InvRadius)) - dot(_141, _141)) < 0.0)
    {
        discard_fragment();
    }
    float3 _151 = normalize(_141);
    float3 _157 = _132 + float3(dot(abs(_151 * float3(_127)), float3(1.0)));
    float3 _158 = float3(DeferredLightUniforms.DeferredLightUniforms_Position) - _157;
    float3 _159 = _158 * DeferredLightUniforms.DeferredLightUniforms_InvRadius;
    float _176 = fast::clamp((dot(normalize(_158), DeferredLightUniforms.DeferredLightUniforms_Direction) - DeferredLightUniforms.DeferredLightUniforms_SpotAngles.x) * DeferredLightUniforms.DeferredLightUniforms_SpotAngles.y, 0.0, 1.0);
    float _178 = (_176 * _176) * pow(1.0 - fast::clamp(dot(_159, _159), 0.0, 1.0), DeferredLightUniforms.DeferredLightUniforms_FalloffExponent);
    bool _181 = _Globals.SpotlightMask < 1.0;
    float _286;
    if (_Globals.bStaticallyShadowed != 0u)
    {
        float _285;
        if (_181)
        {
            float3 _262 = _157 - float3(DeferredLightUniforms.DeferredLightUniforms_Position);
            float _263 = length(_262);
            float3 _265 = _262 / float3(_263);
            float _269 = atan2(_265.y, _265.x) * 0.15915493667125701904296875;
            _285 = float((_263 * DeferredLightUniforms.DeferredLightUniforms_InvRadius) < StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, float2((_269 > 0.0) ? _269 : (1.0 + _269), acos(_265.z) * 0.3183098733425140380859375), level(0.0)).x);
        }
        else
        {
            float4 _197 = _Globals.WorldToStaticShadowMatrix * float4(_157, 1.0);
            float2 _201 = _197.xy / float2(_197.w);
            bool2 _202 = _201 >= float2(0.0);
            bool2 _203 = _201 <= float2(1.0);
            float _261;
            if (all(bool2(_202.x && _203.x, _202.y && _203.y)))
            {
                float2 _215 = (_201 * _Globals.StaticShadowBufferSize.xy) - float2(0.5);
                float2 _216 = fract(_215);
                float2 _217 = floor(_215);
                float4 _225 = _103;
                _225.x = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_217 + float2(0.5, 1.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _231 = _225;
                _231.y = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_217 + float2(1.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _237 = _231;
                _237.z = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_217 + float2(1.5, 0.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _242 = _237;
                _242.w = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_217 + float2(0.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _252 = fast::clamp(fast::clamp((_242 * 40.0) - float4((_197.z * 40.0) - 1.0), float4(0.0), float4(1.0)) + select(float4(0.0), float4(1.0), _242 > float4(0.9900000095367431640625)), float4(0.0), float4(1.0));
                float2 _256 = mix(_252.wx, _252.zy, _216.xx);
                _261 = mix(_256.x, _256.y, _216.y);
            }
            else
            {
                _261 = 1.0;
            }
            _285 = _261;
        }
        _286 = _285;
    }
    else
    {
        _286 = 1.0;
    }
    float _374;
    if (_181)
    {
        float _373;
        if ((length(_158) * DeferredLightUniforms.DeferredLightUniforms_InvRadius) < 1.0)
        {
            float3 _332 = abs(_158);
            float _333 = _332.x;
            float _334 = _332.y;
            float _335 = _332.z;
            float _337 = fast::max(_333, fast::max(_334, _335));
            int _356;
            if (_337 == _333)
            {
                _356 = (_333 == _158.x) ? 0 : 1;
            }
            else
            {
                int _352;
                if (_337 == _334)
                {
                    _352 = (_334 == _158.y) ? 2 : 3;
                }
                else
                {
                    _352 = (_335 == _158.z) ? 4 : 5;
                }
                _356 = _352;
            }
            float4 _364 = _Globals.ShadowViewProjectionMatrices[_356] * float4(-_158, 1.0);
            float _366 = _364.w;
            _373 = ShadowDepthCubeTexture.sample_compare(ShadowDepthCubeTextureSampler, _158, (_364.z / _366) + ((_Globals.InvShadowmapResolution * (-15.35999965667724609375)) / _366), level(0.0));
        }
        else
        {
            _373 = 1.0;
        }
        _374 = _373;
    }
    else
    {
        float4 _296 = _Globals.WorldToShadowMatrix * float4(_157, 1.0);
        float2 _300 = _296.xy / float2(_296.w);
        bool2 _304 = _300 >= _Globals.ShadowmapMinMax.xy;
        bool2 _306 = _300 <= _Globals.ShadowmapMinMax.zw;
        float _322;
        if (all(bool2(_304.x && _306.x, _304.y && _306.y)))
        {
            _322 = float(_296.z < (ShadowDepthTexture.sample(ShadowDepthTextureSampler, _300, level(0.0)).x - _Globals.DepthBiasParameters.x));
        }
        else
        {
            _322 = 1.0;
        }
        _374 = _322;
    }
    float _395;
    if ((!_181) && (!(_Globals.SpotlightMask >= 1.0)))
    {
        float _392 = fast::clamp((dot(_157 - View.View_WorldCameraOrigin, View.View_ViewForward) * _Globals.ShadowInjectParams.z) + _Globals.ShadowInjectParams.w, 0.0, 1.0);
        _395 = mix(_374, 1.0, _392 * _392);
    }
    else
    {
        _395 = _374;
    }
    float _396 = fast::min(_286, _395);
    float _418;
    float _419;
    if (_Globals.VolumeCascadeIndex == 1u)
    {
        float3 _410 = fast::clamp((float3(0.5) - abs(((float3(in.in_var_TEXCOORD0, _115 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w) * (1.0 + (4.0 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w))) - float3(2.0 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w)) - float3(0.5))) * 10.0, float3(0.0), float3(1.0));
        float _415 = (_410.x * _410.y) * _410.z;
        _418 = mix(0.0, _396, _415);
        _419 = mix(0.0, _178, _415);
    }
    else
    {
        _418 = _396;
        _419 = _178;
    }
    float3 _424 = ((float3(DeferredLightUniforms.DeferredLightUniforms_Color) * float3(0.3183098733425140380859375)) * _419) * _418;
    float4 _425 = _103;
    _425.x = 0.2820949852466583251953125;
    float4 _428 = _425;
    _428.y = (-0.48860299587249755859375) * _151.y;
    float4 _431 = _428;
    _431.z = 0.48860299587249755859375 * _151.z;
    float4 _434 = _431;
    _434.w = (-0.48860299587249755859375) * _151.x;
    float4 _436 = _434 * _424.x;
    float4 _438 = _434 * _424.y;
    float4 _440 = _434 * _424.z;
    out.out_var_SV_Target0 = float4(_436.x, _438.x, _440.x, 0.0) * 1.0;
    out.out_var_SV_Target1 = float4(dot(float3(_436.y, _438.y, _440.y), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), dot(float3(_436.z, _438.z, _440.z), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), dot(float3(_436.w, _438.w, _440.w), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), 0.0) * 1.0;
    return out;
}

