

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

fragment InjectMainPS_out Main_0000350d_8f5e7f21(InjectMainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_DeferredLightUniforms& DeferredLightUniforms [[buffer(1)]], constant type_Material& Material [[buffer(2)]], constant type_Globals& _Globals [[buffer(3)]], texture2d<float> Material_Texture2D_0 [[texture(0)]], texture2d<float> ShadowDepthTexture [[texture(1)]], depthcube<float> ShadowDepthCubeTexture [[texture(2)]], texture2d<float> StaticShadowDepthTexture [[texture(3)]], sampler Material_Texture2D_0Sampler [[sampler(0)]], sampler ShadowDepthTextureSampler [[sampler(1)]], sampler ShadowDepthCubeTextureSampler [[sampler(2)]], sampler StaticShadowDepthTextureSampler [[sampler(3)]], uint gl_Layer [[render_target_array_index]])
{
    InjectMainPS_out out = {};
    float _133 = float(gl_Layer) + 0.5;
    float _145 = 0.5 * View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].w;
    float3 _150 = float3((View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].xy + (in.in_var_TEXCOORD0 / View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].xy)) - float2(_145), View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].z + (_133 * View.View_TranslucencyLightingVolumeInvSize[_Globals.VolumeCascadeIndex].w));
    float3 _159 = float3(DeferredLightUniforms.DeferredLightUniforms_Position) - _150;
    if (((1.0 / (DeferredLightUniforms.DeferredLightUniforms_InvRadius * DeferredLightUniforms.DeferredLightUniforms_InvRadius)) - dot(_159, _159)) < 0.0)
    {
        discard_fragment();
    }
    float3 _169 = normalize(_159);
    float3 _175 = _150 + float3(dot(abs(_169 * float3(_145)), float3(1.0)));
    float3 _176 = float3(DeferredLightUniforms.DeferredLightUniforms_Position) - _175;
    float3 _177 = _176 * DeferredLightUniforms.DeferredLightUniforms_InvRadius;
    float _194 = fast::clamp((dot(normalize(_176), DeferredLightUniforms.DeferredLightUniforms_Direction) - DeferredLightUniforms.DeferredLightUniforms_SpotAngles.x) * DeferredLightUniforms.DeferredLightUniforms_SpotAngles.y, 0.0, 1.0);
    float _196 = (_194 * _194) * pow(1.0 - fast::clamp(dot(_177, _177), 0.0, 1.0), DeferredLightUniforms.DeferredLightUniforms_FalloffExponent);
    bool _199 = _Globals.SpotlightMask < 1.0;
    float _304;
    if (_Globals.bStaticallyShadowed != 0u)
    {
        float _303;
        if (_199)
        {
            float3 _280 = _175 - float3(DeferredLightUniforms.DeferredLightUniforms_Position);
            float _281 = length(_280);
            float3 _283 = _280 / float3(_281);
            float _287 = atan2(_283.y, _283.x) * 0.15915493667125701904296875;
            _303 = float((_281 * DeferredLightUniforms.DeferredLightUniforms_InvRadius) < StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, float2((_287 > 0.0) ? _287 : (1.0 + _287), acos(_283.z) * 0.3183098733425140380859375), level(0.0)).x);
        }
        else
        {
            float4 _215 = _Globals.WorldToStaticShadowMatrix * float4(_175, 1.0);
            float2 _219 = _215.xy / float2(_215.w);
            bool2 _220 = _219 >= float2(0.0);
            bool2 _221 = _219 <= float2(1.0);
            float _279;
            if (all(bool2(_220.x && _221.x, _220.y && _221.y)))
            {
                float2 _233 = (_219 * _Globals.StaticShadowBufferSize.xy) - float2(0.5);
                float2 _234 = fract(_233);
                float2 _235 = floor(_233);
                float4 _243 = _120;
                _243.x = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_235 + float2(0.5, 1.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _249 = _243;
                _249.y = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_235 + float2(1.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _255 = _249;
                _255.z = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_235 + float2(1.5, 0.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _260 = _255;
                _260.w = StaticShadowDepthTexture.sample(StaticShadowDepthTextureSampler, ((_235 + float2(0.5)) * _Globals.StaticShadowBufferSize.zw), level(0.0)).x;
                float4 _270 = fast::clamp(fast::clamp((_260 * 40.0) - float4((_215.z * 40.0) - 1.0), float4(0.0), float4(1.0)) + select(float4(0.0), float4(1.0), _260 > float4(0.9900000095367431640625)), float4(0.0), float4(1.0));
                float2 _274 = mix(_270.wx, _270.zy, _234.xx);
                _279 = mix(_274.x, _274.y, _234.y);
            }
            else
            {
                _279 = 1.0;
            }
            _303 = _279;
        }
        _304 = _303;
    }
    else
    {
        _304 = 1.0;
    }
    float _392;
    if (_199)
    {
        float _391;
        if ((length(_176) * DeferredLightUniforms.DeferredLightUniforms_InvRadius) < 1.0)
        {
            float3 _350 = abs(_176);
            float _351 = _350.x;
            float _352 = _350.y;
            float _353 = _350.z;
            float _355 = fast::max(_351, fast::max(_352, _353));
            int _374;
            if (_355 == _351)
            {
                _374 = (_351 == _176.x) ? 0 : 1;
            }
            else
            {
                int _370;
                if (_355 == _352)
                {
                    _370 = (_352 == _176.y) ? 2 : 3;
                }
                else
                {
                    _370 = (_353 == _176.z) ? 4 : 5;
                }
                _374 = _370;
            }
            float4 _382 = _Globals.ShadowViewProjectionMatrices[_374] * float4(-_176, 1.0);
            float _384 = _382.w;
            _391 = ShadowDepthCubeTexture.sample_compare(ShadowDepthCubeTextureSampler, _176, (_382.z / _384) + ((_Globals.InvShadowmapResolution * (-15.35999965667724609375)) / _384), level(0.0));
        }
        else
        {
            _391 = 1.0;
        }
        _392 = _391;
    }
    else
    {
        float4 _314 = _Globals.WorldToShadowMatrix * float4(_175, 1.0);
        float2 _318 = _314.xy / float2(_314.w);
        bool2 _322 = _318 >= _Globals.ShadowmapMinMax.xy;
        bool2 _324 = _318 <= _Globals.ShadowmapMinMax.zw;
        float _340;
        if (all(bool2(_322.x && _324.x, _322.y && _324.y)))
        {
            _340 = float(_314.z < (ShadowDepthTexture.sample(ShadowDepthTextureSampler, _318, level(0.0)).x - _Globals.DepthBiasParameters.x));
        }
        else
        {
            _340 = 1.0;
        }
        _392 = _340;
    }
    float _413;
    if ((!_199) && (!(_Globals.SpotlightMask >= 1.0)))
    {
        float _410 = fast::clamp((dot(_175 - View.View_WorldCameraOrigin, View.View_ViewForward) * _Globals.ShadowInjectParams.z) + _Globals.ShadowInjectParams.w, 0.0, 1.0);
        _413 = mix(_392, 1.0, _410 * _410);
    }
    else
    {
        _413 = _392;
    }
    float4 _421 = _Globals.LightFunctionWorldToLight * float4(_175, 1.0);
    float3 _425 = _421.xyz / float3(_421.w);
    float2 _427 = _425.zy;
    float2 _458;
    if (_Globals.LightFunctionParameters.z > 0.0)
    {
        _458 = ((_427 / float2(_425.x * _Globals.LightFunctionParameters.x)) * 0.5) + float2(0.5);
    }
    else
    {
        float2 _449;
        if (_Globals.LightFunctionParameters.w > 0.0)
        {
            float3 _439 = normalize(_425.zyx);
            _449 = float2((atan2(_439.y, _439.x) + 3.1415927410125732421875) * 0.15915493667125701904296875, acos(_439.z) * 0.3183098733425140380859375);
        }
        else
        {
            _449 = _427;
        }
        _458 = _449;
    }
    spvUnsafeArray<float2, 1> _124 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _460 = 0; _460 < 1; )
    {
        _124[_460] = _458;
        _460++;
        continue;
    }
    float4 _472 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (_124[0] * 4.0));
    float _485 = fast::min(_304, _413) * dot(fast::max(mix(float4(_472.x).xyz, Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0)), float3(0.33329999446868896484375));
    float _507;
    float _508;
    if (_Globals.VolumeCascadeIndex == 1u)
    {
        float3 _499 = fast::clamp((float3(0.5) - abs(((float3(in.in_var_TEXCOORD0, _133 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w) * (1.0 + (4.0 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w))) - float3(2.0 * View.View_TranslucencyLightingVolumeMin[_Globals.VolumeCascadeIndex].w)) - float3(0.5))) * 10.0, float3(0.0), float3(1.0));
        float _504 = (_499.x * _499.y) * _499.z;
        _507 = mix(0.0, _485, _504);
        _508 = mix(0.0, _196, _504);
    }
    else
    {
        _507 = _485;
        _508 = _196;
    }
    float3 _513 = ((float3(DeferredLightUniforms.DeferredLightUniforms_Color) * float3(0.3183098733425140380859375)) * _508) * _507;
    float4 _514 = _120;
    _514.x = 0.2820949852466583251953125;
    float4 _517 = _514;
    _517.y = (-0.48860299587249755859375) * _169.y;
    float4 _520 = _517;
    _520.z = 0.48860299587249755859375 * _169.z;
    float4 _523 = _520;
    _523.w = (-0.48860299587249755859375) * _169.x;
    float4 _525 = _523 * _513.x;
    float4 _527 = _523 * _513.y;
    float4 _529 = _523 * _513.z;
    out.out_var_SV_Target0 = float4(_525.x, _527.x, _529.x, 0.0) * 1.0;
    out.out_var_SV_Target1 = float4(dot(float3(_525.y, _527.y, _529.y), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), dot(float3(_525.z, _527.z, _529.z), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), dot(float3(_525.w, _527.w, _529.w), float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), 0.0) * 1.0;
    return out;
}

