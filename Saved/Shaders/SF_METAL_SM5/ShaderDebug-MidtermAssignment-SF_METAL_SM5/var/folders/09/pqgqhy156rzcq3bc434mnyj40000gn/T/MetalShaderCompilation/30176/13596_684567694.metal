

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

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
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
    float4 LightFunctionParameters;
    float4x4 LightFunctionWorldToLight;
    float SpotlightMask;
};

constant spvUnsafeArray<float2, 1> _110 = spvUnsafeArray<float2, 1>({ float2(0.0) });

constant float4 _120 = {};

struct InjectMainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
    float4 out_var_SV_Target1 [[color(1)]];
};

struct InjectMainPS_in
{
    float2 in_var_TEXCOORD0 [[user(locn0), center_no_perspective]];
};

fragment InjectMainPS_out Main_0000351c_28cdac8e(InjectMainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_DeferredLightUniforms& DeferredLightUniforms [[buffer(1)]], constant type_Material& Material [[buffer(2)]], constant type_Globals& _Globals [[buffer(3)]], texture2d<float> Material_Texture2D_0 [[texture(0)]], texture2d<float> ShadowDepthTexture [[texture(1)]], depthcube<float> ShadowDepthCubeTexture [[texture(2)]], texture2d<float> StaticShadowDepthTexture [[texture(3)]], sampler Material_Texture2D_0Sampler [[sampler(0)]], sampler ShadowDepthTextureSampler [[sampler(1)]], sampler ShadowDepthCubeTextureSampler [[sampler(2)]], sampler StaticShadowDepthTextureSampler [[sampler(3)]], uint gl_Layer [[render_target_array_index]])
{
    InjectMainPS_out out = {};
    float _132 = float(gl_Layer) + 0.5;
    float _144 = 0.5 * View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].w;
    float3 _149 = float3((View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].xy + (in.in_var_TEXCOORD0 / View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].xy)) - float2(_144), View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].z + (_132 * View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].w));
    float3 _158 = float3(DeferredLightUniforms.DeferredLightUniforms_Position) - _149;
    if (((1.0 / (DeferredLightUniforms.DeferredLightUniforms_InvRadius * DeferredLightUniforms.DeferredLightUniforms_InvRadius)) - dot(_158, _158)) < 0.0)
    {
        discard_fragment();
    }
    float3 _168 = normalize(_158);
    float3 _174 = _149 + float3(dot(abs(_168 * float3(_144)), float3(1.0)));
    float3 _175 = float3(DeferredLightUniforms.DeferredLightUniforms_Position) - _174;
    float _176 = dot(_175, _175);
    float _180 = (_176 * DeferredLightUniforms.DeferredLightUniforms_InvRadius) * DeferredLightUniforms.DeferredLightUniforms_InvRadius;
    float _183 = fast::clamp(1.0 - (_180 * _180), 0.0, 1.0);
    float _196 = fast::clamp((dot(normalize(_175), DeferredLightUniforms.DeferredLightUniforms_Direction) - DeferredLightUniforms.DeferredLightUniforms_SpotAngles.x) * DeferredLightUniforms.DeferredLightUniforms_SpotAngles.y, 0.0, 1.0);
    float _198 = (_196 * _196) * ((1.0 / (_176 + 1.0)) * (_183 * _183));
    bool _201 = _Globals.SpotlightMask < 1.0;
    float _306;
    if (_Globals.bStaticallyShadowed != 0u)
    {
        float _305;
        if (_201)
        {
            float3 _282 = _174 - float3(DeferredLightUniforms.DeferredLightUniforms_Position);
            float _283 = length(_282);
            float3 _285 = _282 / float3(_283);
            float _289 = atan2(_285.y, _285.x) * 0.15915493667125701904296875;
            _305 = float((_283 * DeferredLightUniforms.DeferredLightUniforms_InvRadius) < StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, float2((_289 > 0.0) ? _289 : (1.0 + _289), acos(_285.z) * 0.3183098733425140380859375), level(0.0)).x);
        }
        else
        {
            float4 _217 = _Globals.WorldToStaticShadowMatrix * float4(_174, 1.0);
            float2 _221 = _217.xy / float2(_217.w);
            bool2 _222 = _221 >= float2(0.0);
            bool2 _223 = _221 <= float2(1.0);
            float _281;
            if (all(bool2(_222.x && _223.x, _222.y && _223.y)))
            {
                float2 _235 = (_221 * _Globals.StaticShadowBufferSize.xy) - float2(0.5);
                float2 _236 = fract(_235);
                float2 _237 = floor(_235);
                float4 _245 = _120;
                _245.x = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_237 + float2(0.5, 1.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _251 = _245;
                _251.y = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_237 + float2(1.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _257 = _251;
                _257.z = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_237 + float2(1.5, 0.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _262 = _257;
                _262.w = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_237 + float2(0.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _272 = fast::clamp(fast::clamp((_262 * 40.0) - float4((_217.z * 40.0) - 1.0), float4(0.0), float4(1.0)) + select(float4(0.0), float4(1.0), _262 > float4(0.9900000095367431640625)), float4(0.0), float4(1.0));
                float2 _276 = mix(_272.wx, _272.zy, _236.xx);
                _281 = mix(_276.x, _276.y, _236.y);
            }
            else
            {
                _281 = 1.0;
            }
            _305 = _281;
        }
        _306 = _305;
    }
    else
    {
        _306 = 1.0;
    }
    float _394;
    if (_201)
    {
        float _393;
        if ((length(_175) * DeferredLightUniforms.DeferredLightUniforms_InvRadius) < 1.0)
        {
            float3 _352 = abs(_175);
            float _353 = _352.x;
            float _354 = _352.y;
            float _355 = _352.z;
            float _357 = fast::max(_353, fast::max(_354, _355));
            int _376;
            if (_357 == _353)
            {
                _376 = (_353 == _175.x) ? 0 : 1;
            }
            else
            {
                int _372;
                if (_357 == _354)
                {
                    _372 = (_354 == _175.y) ? 2 : 3;
                }
                else
                {
                    _372 = (_355 == _175.z) ? 4 : 5;
                }
                _376 = _372;
            }
            float4 _384 = _Globals.ShadowViewProjectionMatrices[_376] * float4(-_175, 1.0);
            float _386 = _384.w;
            _393 = ShadowDepthCubeTexture.sample_compare(ShadowDepthCubeTextureSampler, _175, (_384.z / _386) + ((_Globals.InvShadowmapResolution * (-15.35999965667724609375)) / _386), level(0.0));
        }
        else
        {
            _393 = 1.0;
        }
        _394 = _393;
    }
    else
    {
        float4 _316 = _Globals.WorldToShadowMatrix * float4(_174, 1.0);
        float2 _320 = _316.xy / float2(_316.w);
        bool2 _324 = _320 >= _Globals.ShadowmapMinMax.xy;
        bool2 _326 = _320 <= _Globals.ShadowmapMinMax.zw;
        float _342;
        if (all(bool2(_324.x && _326.x, _324.y && _326.y)))
        {
            _342 = float(_316.z < (ShadowDepthTexture.sample(ShadowDepthTextureSampler, _320, level(0.0)).x - _Globals.DepthBiasParameters.x));
        }
        else
        {
            _342 = 1.0;
        }
        _394 = _342;
    }
    float _415;
    if ((!_201) && (!(_Globals.SpotlightMask >= 1.0)))
    {
        float _412 = fast::clamp((dot(_174 - View.View_WorldCameraOrigin, View.View_ViewForward) * _Globals.ShadowInjectParams.z) + _Globals.ShadowInjectParams.w, 0.0, 1.0);
        _415 = mix(_394, 1.0, _412 * _412);
    }
    else
    {
        _415 = _394;
    }
    float4 _423 = _Globals.LightFunctionWorldToLight * float4(_174, 1.0);
    float3 _427 = _423.xyz / float3(_423.w);
    float2 _429 = _427.zy;
    float2 _460;
    if (_Globals.LightFunctionParameters.z > 0.0)
    {
        _460 = ((_429 / float2(_427.x * _Globals.LightFunctionParameters.x)) * 0.5) + float2(0.5);
    }
    else
    {
        float2 _451;
        if (_Globals.LightFunctionParameters.w > 0.0)
        {
            float3 _441 = normalize(_427.zyx);
            _451 = float2((atan2(_441.y, _441.x) + 3.1415927410125732421875) * 0.15915493667125701904296875, acos(_441.z) * 0.3183098733425140380859375);
        }
        else
        {
            _451 = _429;
        }
        _460 = _451;
    }
    spvUnsafeArray<float2, 1> _123 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _462 = 0; _462 < 1; )
    {
        _123[_462] = _460;
        _462++;
        continue;
    }
    float4 _474 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (_123[0] * 4.0));
    float _487 = fast::min(_306, _415) * dot(fast::max(mix(float4(_474.x).xyz, Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0)), float3(0.33329999446868896484375));
    float _509;
    float _510;
    if (_Globals.VolumeCascadeIndex == 1u)
    {
        float3 _501 = fast::clamp((float3(0.5) - abs(((float3(in.in_var_TEXCOORD0, _132 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w) * (1.0 + (4.0 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w))) - float3(2.0 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w)) - float3(0.5))) * 10.0, float3(0.0), float3(1.0));
        float _506 = (_501.x * _501.y) * _501.z;
        _509 = mix(0.0, _487, _506);
        _510 = mix(0.0, _198, _506);
    }
    else
    {
        _509 = _487;
        _510 = _198;
    }
    float3 _515 = ((DeferredLightUniforms.DeferredLightUniforms_Color * float3(0.3183098733425140380859375)) * _510) * _509;
    float4 _516 = _120;
    _516.x = 0.2820949852466583251953125;
    float4 _519 = _516;
    _519.y = (-0.48860299587249755859375) * _168.y;
    float4 _522 = _519;
    _522.z = 0.48860299587249755859375 * _168.z;
    float4 _525 = _522;
    _525.w = (-0.48860299587249755859375) * _168.x;
    float4 _527 = _525 * _515.x;
    float4 _529 = _525 * _515.y;
    float4 _531 = _525 * _515.z;
    out.out_var_SV_Target0 = float4(_527.x, _529.x, _531.x, 0.0) * 1.0;
    out.out_var_SV_Target1 = float4(dot(float3(_527.y, _529.y, _531.y), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), dot(float3(_527.z, _529.z, _531.z), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), dot(float3(_527.w, _529.w, _531.w), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), 0.0) * 1.0;
    return out;
}

