

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

struct type_TranslucentBasePass
{
    char _m0_pad[1712];
    float4 TranslucentBasePass_Shared_Fog_ExponentialFogParameters;
    float4 TranslucentBasePass_Shared_Fog_ExponentialFogParameters2;
    float4 TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter;
    float4 TranslucentBasePass_Shared_Fog_ExponentialFogParameters3;
    float4 TranslucentBasePass_Shared_Fog_InscatteringLightDirection;
    float4 TranslucentBasePass_Shared_Fog_DirectionalInscatteringColor;
    float2 TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation;
    float3 TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters;
};

struct type_View
{
    float4x4 View_TranslatedWorldToClip;
    char _m1_pad[896];
    float3 View_ViewForward;
    float3 View_ViewUp;
    float3 View_ViewRight;
    float3 View_HMDViewNoRollUp;
    float3 View_HMDViewNoRollRight;
    char _m6_pad[32];
    float3 View_WorldCameraOrigin;
    float3 View_TranslatedWorldCameraOrigin;
    char _m8_pad[16];
    float3 View_PreViewTranslation;
    char _m9_pad[1032];
    float View_OneOverPreExposure;
    char _m10_pad[704];
    float4 View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize;
    float View_SkyAtmosphereAerialPerspectiveStartDepthKm;
    float View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
    float View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv;
    char _m14_pad[4];
    float View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv;
    float View_SkyAtmosphereApplyCameraAerialPerspectiveVolume;
    char _m16_pad[24];
    float View_RealTimeReflectionCapture;
    char _m17_pad[420];
    float View_VolumetricFogMaxDistance;
};

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
};

struct type_EmitterDynamicUniforms
{
    float2 EmitterDynamicUniforms_LocalToWorldScale;
    float4 EmitterDynamicUniforms_AxisLockRight;
    float4 EmitterDynamicUniforms_AxisLockUp;
    float4 EmitterDynamicUniforms_DynamicColor;
};

struct type_EmitterUniforms
{
    float4 EmitterUniforms_ColorCurve;
    float4 EmitterUniforms_ColorScale;
    float4 EmitterUniforms_ColorBias;
    float4 EmitterUniforms_MiscCurve;
    float4 EmitterUniforms_MiscScale;
    float4 EmitterUniforms_MiscBias;
    float4 EmitterUniforms_SizeBySpeed;
    float4 EmitterUniforms_SubImageSize;
    float4 EmitterUniforms_TangentSelector;
    packed_float3 EmitterUniforms_CameraFacingBlend;
    float EmitterUniforms_RemoveHMDRoll;
    float EmitterUniforms_RotationRateScale;
    float EmitterUniforms_RotationBias;
    char _m13_pad[8];
    float2 EmitterUniforms_PivotOffset;
};

struct type_Globals
{
    uint ParticleIndicesOffset;
};

constant float3x3 _122 = {};
constant float4 _123 = {};
constant float2 _124 = {};

struct Main_out
{
    float4 out_var_TEXCOORD0_0 [[user(locn0)]];
    float4 out_var_TEXCOORD5 [[user(locn1)]];
    float4 out_var_TANGENTX [[user(locn2)]];
    float4 out_var_TANGENTZ [[user(locn3)]];
    float4 out_var_TEXCOORD7 [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float2 in_var_ATTRIBUTE0 [[attribute(0)]];
};

// Implementation of the GLSL mod() function, which is slightly different than Metal fmod()
template<typename Tx, typename Ty>
inline Tx mod(Tx x, Ty y)
{
    return x - y * floor(x / y);
}

vertex Main_out Main_00005448_1680ff79(Main_in in [[stage_in]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_EmitterDynamicUniforms& EmitterDynamicUniforms [[buffer(4)]], constant type_EmitterUniforms& EmitterUniforms [[buffer(5)]], constant type_Globals& _Globals [[buffer(6)]], texture_buffer<float> ParticleIndices [[texture(0)]], texturecube<float> TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap [[texture(1)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(2)]], texture2d<float> PositionTexture [[texture(3)]], texture2d<float> VelocityTexture [[texture(4)]], texture2d<float> AttributesTexture [[texture(5)]], texture2d<float> CurveTexture [[texture(6)]], sampler TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler [[sampler(0)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(1)]], sampler PositionTextureSampler [[sampler(2)]], sampler VelocityTextureSampler [[sampler(3)]], sampler AttributesTextureSampler [[sampler(4)]], sampler CurveTextureSampler [[sampler(5)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    uint _170 = (gl_InstanceIndex - gl_BaseInstance) * 16u;
    uint _171 = (gl_VertexIndex - gl_BaseVertex) / 4u;
    uint _172 = _170 + _171;
    uint _175 = _Globals.ParticleIndicesOffset + _172;
    float4 _177 = ParticleIndices.read(uint(_175));
    float2 _178 = _177.xy;
    float4 _182 = PositionTexture.sample(PositionTextureSampler, _178, level(0.0));
    float4 _186 = VelocityTexture.sample(VelocityTextureSampler, _178, level(0.0));
    float4 _190 = AttributesTexture.sample(AttributesTextureSampler, _178, level(0.0));
    float _191 = _182.w;
    float _192 = step(_191, 1.0);
    float3 _193 = _186.xyz;
    float3x3 _202 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    float3 _203 = _202 * _193;
    float3 _205 = normalize(_203 + float3(0.0, 0.0, 9.9999997473787516355514526367188e-05));
    float _206 = length(_203);
    float2 _230 = EmitterUniforms.EmitterUniforms_MiscCurve.zw * _191;
    float2 _231 = EmitterUniforms.EmitterUniforms_MiscCurve.xy + _230;
    float4 _233 = CurveTexture.sample(CurveTextureSampler, _231, level(0.0));
    float4 _236 = _233 * EmitterUniforms.EmitterUniforms_MiscScale;
    float4 _239 = _236 + EmitterUniforms.EmitterUniforms_MiscBias;
    float _240 = _190.x;
    bool _241 = _240 < 0.5;
    float _242 = _241 ? 0.0 : (-0.5);
    float _243 = _190.y;
    bool _244 = _243 < 0.5;
    float _245 = _244 ? 0.0 : (-0.5);
    float2 _246 = float2(_242, _245);
    float2 _247 = _190.xy;
    float2 _248 = _247 + _246;
    float2 _249 = _248 * float2(2.0);
    float2 _250 = _239.xy;
    float2 _253 = _250 * EmitterDynamicUniforms.EmitterDynamicUniforms_LocalToWorldScale;
    float2 _257 = EmitterUniforms.EmitterUniforms_SizeBySpeed.xy * _206;
    float2 _258 = fast::max(_257, float2(1.0));
    float2 _260 = fast::min(_258, EmitterUniforms.EmitterUniforms_SizeBySpeed.zw);
    float2 _261 = _249 * _253;
    float2 _262 = _261 * _260;
    float2 _263 = float2(_192);
    float2 _264 = _262 * _263;
    float2 _269 = _124;
    _269.x = (_242 == 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.x) : in.in_var_ATTRIBUTE0.x;
    float2 _274 = _269;
    _274.y = (_245 == 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.y) : in.in_var_ATTRIBUTE0.y;
    float _275 = _239.z;
    float _277 = _275 - fract(_275);
    float2 _290 = (float2(mod(_277, EmitterUniforms.EmitterUniforms_SubImageSize.x), floor(_277 * EmitterUniforms.EmitterUniforms_SubImageSize.z)) + _274) * EmitterUniforms.EmitterUniforms_SubImageSize.zw;
    float _291 = _190.w;
    float _294 = _291 * EmitterUniforms.EmitterUniforms_RotationRateScale;
    float _295 = _190.z;
    float _296 = _294 * _191;
    float _297 = _295 + _296;
    float _298 = _297 * 6.283185482025146484375;
    float3 _302 = _182.xxx;
    float3 _303 = Primitive.Primitive_LocalToWorld[0u].xyz * _302;
    float3 _307 = _182.yyy;
    float3 _308 = Primitive.Primitive_LocalToWorld[1u].xyz * _307;
    float3 _309 = _303 + _308;
    float3 _313 = _182.zzz;
    float3 _314 = Primitive.Primitive_LocalToWorld[2u].xyz * _313;
    float3 _315 = _309 + _314;
    float3 _319 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _320 = _315 + _319;
    float _321 = _320.x;
    float _322 = _320.y;
    float _323 = _320.z;
    float4 _324 = float4(_321, _322, _323, 1.0);
    float3 _325 = _324.xyz;
    float3 _328 = float3(EmitterUniforms.EmitterUniforms_RemoveHMDRoll);
    float3 _337 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _328), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.w));
    float3 _345 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _328), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.w));
    float3 _346 = View.View_TranslatedWorldCameraOrigin - _325;
    float _347 = dot(_346, _346);
    float3 _351 = _346 / float3(sqrt(fast::max(_347, 0.00999999977648258209228515625)));
    float3 _421;
    float3 _422;
    if (EmitterUniforms.EmitterUniforms_CameraFacingBlend[0] > 0.0)
    {
        float3 _409 = cross(_351, float3(0.0, 0.0, 1.0));
        float3 _414 = _409 / float3(sqrt(fast::max(dot(_409, _409), 0.00999999977648258209228515625)));
        float3 _416 = float3(fast::clamp((_347 * EmitterUniforms.EmitterUniforms_CameraFacingBlend[1]) - EmitterUniforms.EmitterUniforms_CameraFacingBlend[2], 0.0, 1.0));
        _421 = normalize(mix(_337, _414, _416));
        _422 = normalize(mix(_345, cross(_351, _414), _416));
    }
    else
    {
        float3 _400;
        float3 _401;
        if (EmitterUniforms.EmitterUniforms_TangentSelector.y > 0.0)
        {
            float3 _393 = cross(_351, _205);
            _400 = _393 / float3(sqrt(fast::max(dot(_393, _393), 0.00999999977648258209228515625)));
            _401 = -_205;
        }
        else
        {
            float3 _391;
            float3 _392;
            if (EmitterUniforms.EmitterUniforms_TangentSelector.z > 0.0)
            {
                float3 _384 = cross(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, _351);
                _391 = EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz;
                _392 = -(_384 / float3(sqrt(fast::max(dot(_384, _384), 0.00999999977648258209228515625))));
            }
            else
            {
                float3 _382;
                float3 _383;
                if (EmitterUniforms.EmitterUniforms_TangentSelector.w > 0.0)
                {
                    float3 _375 = cross(_351, float3(0.0, 0.0, 1.0));
                    float3 _380 = _375 / float3(sqrt(fast::max(dot(_375, _375), 0.00999999977648258209228515625)));
                    _382 = _380;
                    _383 = cross(_351, _380);
                }
                else
                {
                    _382 = _337;
                    _383 = _345;
                }
                _391 = _382;
                _392 = _383;
            }
            _400 = _391;
            _401 = _392;
        }
        _421 = _400;
        _422 = _401;
    }
    float _425 = _298 + EmitterUniforms.EmitterUniforms_RotationBias;
    float _426 = sin(_425);
    float _427 = cos(_425);
    float3 _428 = _422 * _426;
    float3 _429 = _421 * _427;
    float3 _430 = _428 + _429;
    float3 _431 = _422 * _427;
    float3 _432 = _421 * _426;
    float3 _433 = _431 - _432;
    float _434 = _264.x;
    float _437 = in.in_var_ATTRIBUTE0.x + EmitterUniforms.EmitterUniforms_PivotOffset.x;
    float _438 = _434 * _437;
    float3 _439 = _430 * _438;
    float _440 = _264.y;
    float _443 = in.in_var_ATTRIBUTE0.y + EmitterUniforms.EmitterUniforms_PivotOffset.y;
    float _444 = _440 * _443;
    float3 _445 = _433 * _444;
    float3 _446 = _439 + _445;
    float3 _447 = _325 + _446;
    float _448 = _447.x;
    float _449 = _447.y;
    float _450 = _447.z;
    float4 _451 = float4(_448, _449, _450, 1.0);
    float4 _452 = float4(_451.x, _451.y, _451.z, _451.w);
    float4 _453 = View.View_TranslatedWorldToClip * _452;
    float3x3 _455 = _122;
    _455[0] = _430;
    float3x3 _456 = _455;
    _456[1] = _433;
    float3 _458 = normalize(cross(_430, _433));
    float3x3 _459 = _456;
    _459[2] = _458;
    spvUnsafeArray<float4, 1> _472 = { float4(_290.x, _290.y, float4(0.0).z, float4(0.0).w) };
    float3 _473 = _451.xyz;
    float3 _474 = _473 - View.View_TranslatedWorldCameraOrigin;
    float _491 = fast::min(View.View_WorldCameraOrigin.z, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.z);
    float _494 = _474.z + (View.View_WorldCameraOrigin.z - _491);
    float3 _495 = _474;
    _495.z = _494;
    float _496 = dot(_495, _495);
    float _497 = rsqrt(_496);
    float _498 = _496 * _497;
    float _506 = fast::max(fast::max(View.View_VolumetricFogMaxDistance * (length(_474) / dot(_474, View.View_ViewForward)), 0.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.w);
    float _540;
    float _541;
    float _542;
    float _543;
    if (_506 > 0.0)
    {
        float _510 = _506 * _497;
        float _511 = _510 * _494;
        float _512 = _491 + _511;
        _540 = (1.0 - _510) * _498;
        _541 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.z * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * (_512 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.w)));
        _542 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.x * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * (_512 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.y)));
        _543 = _494 - _511;
    }
    else
    {
        _540 = _498;
        _541 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.x;
        _542 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.x;
        _543 = _494;
    }
    float _547 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * _543);
    float _561 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * _543);
    float _572 = (_542 * ((abs(_547) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_547)) / _547) : (0.693147182464599609375 - (0.2402265071868896484375 * _547)))) + (_541 * ((abs(_561) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_561)) / _561) : (0.693147182464599609375 - (0.2402265071868896484375 * _561))));
    float3 _614;
    if (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.z > 0.0)
    {
        float2 _599 = float2(dot(_495.xy, float2(TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation.y, -TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation.x)), dot(_495.xy, TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation));
        float3 _600 = float3(_599.x, _599.y, _495.z);
        _614 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.xyz * mix(TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap.sample(TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler, _600, level(TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.z)).xyz, TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap.sample(TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler, _600, level(0.0)).xyz, float3(fast::clamp((_498 * TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.x) + TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.y, 0.0, 1.0)));
    }
    else
    {
        _614 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.xyz;
    }
    float3 _642;
    if ((TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.w >= 0.0) && (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.z == 0.0))
    {
        _642 = (TranslucentBasePass.TranslucentBasePass_Shared_Fog_DirectionalInscatteringColor.xyz * pow(fast::clamp(dot(_495 * _497, TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.xyz), 0.0, 1.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_DirectionalInscatteringColor.w)) * (1.0 - fast::clamp(exp2(-(_572 * fast::max(_540 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.w, 0.0))), 0.0, 1.0));
    }
    else
    {
        _642 = float3(0.0);
    }
    bool _651 = (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w > 0.0) && (_498 > TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w);
    float _654 = _651 ? 1.0 : fast::max(fast::clamp(exp2(-(_572 * _540)), 0.0, 1.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.w);
    float4 _661 = float4((_614 * (1.0 - _654)) + select(_642, float3(0.0), bool3(_651)), _654);
    float4 _738;
    if (View.View_SkyAtmosphereApplyCameraAerialPerspectiveVolume > 0.0)
    {
        float3 _675 = (_473 * 9.9999997473787516355514526367188e-06) - (View.View_TranslatedWorldCameraOrigin * 9.9999997473787516355514526367188e-06);
        float _681 = sqrt((fast::max(0.0, length(_675) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
        float _682 = _681 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
        float _689;
        if (_682 < 0.707106769084930419921875)
        {
            _689 = fast::clamp((_682 * _682) * 2.0, 0.0, 1.0);
        }
        else
        {
            _689 = 1.0;
        }
        float2 _717;
        if (View.View_RealTimeReflectionCapture != 0.0)
        {
            float3 _692 = normalize(_675);
            float _693 = _692.z;
            float _696 = sqrt(1.0 - (_693 * _693));
            float2 _699 = _124;
            _699.y = (_693 * 0.5) + 0.5;
            float _704 = acos(_692.x / _696);
            float2 _709 = _699;
            _709.x = (((_692.y / _696) < 0.0) ? (6.283185482025146484375 - _704) : _704) * 0.15915493667125701904296875;
            _717 = (_709 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
        }
        else
        {
            _717 = ((_453.xy / _453.ww) * float2(0.5, -0.5)) + float2(0.5);
        }
        float4 _722 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_717, _681), level(0.0));
        float3 _734 = _661.xyz + (((_722.xyz * _689).xyz * View.View_OneOverPreExposure).xyz * _654);
        float4 _737 = float4(_734.x, _734.y, _734.z, _123.w);
        _737.w = _654 * (1.0 - (_689 * (1.0 - _722.w)));
        _738 = _737;
    }
    else
    {
        _738 = _661;
    }
    out_var_TEXCOORD0 = _472;
    out.out_var_TEXCOORD5 = ((CurveTexture.sample(CurveTextureSampler, (EmitterUniforms.EmitterUniforms_ColorCurve.xy + (EmitterUniforms.EmitterUniforms_ColorCurve.zw * _191)), level(0.0)) * EmitterUniforms.EmitterUniforms_ColorScale) + EmitterUniforms.EmitterUniforms_ColorBias) * EmitterDynamicUniforms.EmitterDynamicUniforms_DynamicColor;
    out.out_var_TANGENTX = float4(_430, 0.0);
    out.out_var_TANGENTZ = float4(_458, float(int(sign(determinant(_459)))));
    out.out_var_TEXCOORD7 = _738;
    out.gl_Position = _453;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

