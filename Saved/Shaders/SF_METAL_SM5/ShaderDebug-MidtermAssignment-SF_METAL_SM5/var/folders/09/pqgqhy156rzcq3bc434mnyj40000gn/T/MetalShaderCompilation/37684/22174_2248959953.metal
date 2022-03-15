

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

constant float3x3 _125 = {};
constant float4 _126 = {};
constant float2 _127 = {};

struct Main_out
{
    float4 out_var_TEXCOORD0_0 [[user(locn0)]];
    float4 out_var_PARTICLE_SUBUVS [[user(locn1)]];
    float3 out_var_TEXCOORD4 [[user(locn2)]];
    float4 out_var_TEXCOORD5 [[user(locn3)]];
    float4 out_var_TANGENTX [[user(locn4)]];
    float4 out_var_TANGENTZ [[user(locn5)]];
    float4 out_var_TEXCOORD7 [[user(locn6)]];
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

vertex Main_out Main_0000569e_860c67d1(Main_in in [[stage_in]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_EmitterDynamicUniforms& EmitterDynamicUniforms [[buffer(4)]], constant type_EmitterUniforms& EmitterUniforms [[buffer(5)]], constant type_Globals& _Globals [[buffer(6)]], texture_buffer<float> ParticleIndices [[texture(0)]], texturecube<float> TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap [[texture(1)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(2)]], texture2d<float> PositionTexture [[texture(3)]], texture2d<float> VelocityTexture [[texture(4)]], texture2d<float> AttributesTexture [[texture(5)]], texture2d<float> CurveTexture [[texture(6)]], sampler TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler [[sampler(0)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(1)]], sampler PositionTextureSampler [[sampler(2)]], sampler VelocityTextureSampler [[sampler(3)]], sampler AttributesTextureSampler [[sampler(4)]], sampler CurveTextureSampler [[sampler(5)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    uint _173 = (gl_InstanceIndex - gl_BaseInstance) * 16u;
    uint _174 = (gl_VertexIndex - gl_BaseVertex) / 4u;
    uint _175 = _173 + _174;
    uint _178 = _Globals.ParticleIndicesOffset + _175;
    float4 _180 = ParticleIndices.read(uint(_178));
    float2 _181 = _180.xy;
    float4 _185 = PositionTexture.sample(PositionTextureSampler, _181, level(0.0));
    float4 _189 = VelocityTexture.sample(VelocityTextureSampler, _181, level(0.0));
    float4 _193 = AttributesTexture.sample(AttributesTextureSampler, _181, level(0.0));
    float _194 = _185.w;
    float _195 = step(_194, 1.0);
    float3 _196 = _189.xyz;
    float3x3 _205 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    float3 _206 = _205 * _196;
    float3 _208 = normalize(_206 + float3(0.0, 0.0, 9.9999997473787516355514526367188e-05));
    float _209 = length(_206);
    float2 _233 = EmitterUniforms.EmitterUniforms_MiscCurve.zw * _194;
    float2 _234 = EmitterUniforms.EmitterUniforms_MiscCurve.xy + _233;
    float4 _236 = CurveTexture.sample(CurveTextureSampler, _234, level(0.0));
    float4 _239 = _236 * EmitterUniforms.EmitterUniforms_MiscScale;
    float4 _242 = _239 + EmitterUniforms.EmitterUniforms_MiscBias;
    float _243 = _193.x;
    bool _244 = _243 < 0.5;
    float _245 = _244 ? 0.0 : (-0.5);
    float _246 = _193.y;
    bool _247 = _246 < 0.5;
    float _248 = _247 ? 0.0 : (-0.5);
    float2 _249 = float2(_245, _248);
    float2 _250 = _193.xy;
    float2 _251 = _250 + _249;
    float2 _252 = _251 * float2(2.0);
    float2 _253 = _242.xy;
    float2 _256 = _253 * EmitterDynamicUniforms.EmitterDynamicUniforms_LocalToWorldScale;
    float2 _260 = EmitterUniforms.EmitterUniforms_SizeBySpeed.xy * _209;
    float2 _261 = fast::max(_260, float2(1.0));
    float2 _263 = fast::min(_261, EmitterUniforms.EmitterUniforms_SizeBySpeed.zw);
    float2 _264 = _252 * _256;
    float2 _265 = _264 * _263;
    float2 _266 = float2(_195);
    float2 _267 = _265 * _266;
    float2 _272 = _127;
    _272.x = (_245 == 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.x) : in.in_var_ATTRIBUTE0.x;
    float2 _277 = _272;
    _277.y = (_248 == 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.y) : in.in_var_ATTRIBUTE0.y;
    float _278 = _242.z;
    float _279 = fract(_278);
    float _280 = _278 - _279;
    float _281 = _280 + 1.0;
    float2 _297 = (float2(mod(_280, EmitterUniforms.EmitterUniforms_SubImageSize.x), floor(_280 * EmitterUniforms.EmitterUniforms_SubImageSize.z)) + _277) * EmitterUniforms.EmitterUniforms_SubImageSize.zw;
    float2 _300 = (float2(mod(_281, EmitterUniforms.EmitterUniforms_SubImageSize.x), floor(_281 * EmitterUniforms.EmitterUniforms_SubImageSize.z)) + _277) * EmitterUniforms.EmitterUniforms_SubImageSize.zw;
    float _301 = _193.w;
    float _304 = _301 * EmitterUniforms.EmitterUniforms_RotationRateScale;
    float _305 = _193.z;
    float _306 = _304 * _194;
    float _307 = _305 + _306;
    float _308 = _307 * 6.283185482025146484375;
    float3 _312 = _185.xxx;
    float3 _313 = Primitive.Primitive_LocalToWorld[0u].xyz * _312;
    float3 _317 = _185.yyy;
    float3 _318 = Primitive.Primitive_LocalToWorld[1u].xyz * _317;
    float3 _319 = _313 + _318;
    float3 _323 = _185.zzz;
    float3 _324 = Primitive.Primitive_LocalToWorld[2u].xyz * _323;
    float3 _325 = _319 + _324;
    float3 _329 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _330 = _325 + _329;
    float _331 = _330.x;
    float _332 = _330.y;
    float _333 = _330.z;
    float4 _334 = float4(_331, _332, _333, 1.0);
    float3 _335 = _334.xyz;
    float3 _338 = float3(EmitterUniforms.EmitterUniforms_RemoveHMDRoll);
    float3 _347 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _338), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.w));
    float3 _355 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _338), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.w));
    float3 _356 = View.View_TranslatedWorldCameraOrigin - _335;
    float _357 = dot(_356, _356);
    float3 _361 = _356 / float3(sqrt(fast::max(_357, 0.00999999977648258209228515625)));
    float3 _431;
    float3 _432;
    if (EmitterUniforms.EmitterUniforms_CameraFacingBlend[0] > 0.0)
    {
        float3 _419 = cross(_361, float3(0.0, 0.0, 1.0));
        float3 _424 = _419 / float3(sqrt(fast::max(dot(_419, _419), 0.00999999977648258209228515625)));
        float3 _426 = float3(fast::clamp((_357 * EmitterUniforms.EmitterUniforms_CameraFacingBlend[1]) - EmitterUniforms.EmitterUniforms_CameraFacingBlend[2], 0.0, 1.0));
        _431 = normalize(mix(_347, _424, _426));
        _432 = normalize(mix(_355, cross(_361, _424), _426));
    }
    else
    {
        float3 _410;
        float3 _411;
        if (EmitterUniforms.EmitterUniforms_TangentSelector.y > 0.0)
        {
            float3 _403 = cross(_361, _208);
            _410 = _403 / float3(sqrt(fast::max(dot(_403, _403), 0.00999999977648258209228515625)));
            _411 = -_208;
        }
        else
        {
            float3 _401;
            float3 _402;
            if (EmitterUniforms.EmitterUniforms_TangentSelector.z > 0.0)
            {
                float3 _394 = cross(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, _361);
                _401 = EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz;
                _402 = -(_394 / float3(sqrt(fast::max(dot(_394, _394), 0.00999999977648258209228515625))));
            }
            else
            {
                float3 _392;
                float3 _393;
                if (EmitterUniforms.EmitterUniforms_TangentSelector.w > 0.0)
                {
                    float3 _385 = cross(_361, float3(0.0, 0.0, 1.0));
                    float3 _390 = _385 / float3(sqrt(fast::max(dot(_385, _385), 0.00999999977648258209228515625)));
                    _392 = _390;
                    _393 = cross(_361, _390);
                }
                else
                {
                    _392 = _347;
                    _393 = _355;
                }
                _401 = _392;
                _402 = _393;
            }
            _410 = _401;
            _411 = _402;
        }
        _431 = _410;
        _432 = _411;
    }
    float _435 = _308 + EmitterUniforms.EmitterUniforms_RotationBias;
    float _436 = sin(_435);
    float _437 = cos(_435);
    float3 _438 = _432 * _436;
    float3 _439 = _431 * _437;
    float3 _440 = _438 + _439;
    float3 _441 = _432 * _437;
    float3 _442 = _431 * _436;
    float3 _443 = _441 - _442;
    float _444 = _267.x;
    float _447 = in.in_var_ATTRIBUTE0.x + EmitterUniforms.EmitterUniforms_PivotOffset.x;
    float _448 = _444 * _447;
    float3 _449 = _440 * _448;
    float _450 = _267.y;
    float _453 = in.in_var_ATTRIBUTE0.y + EmitterUniforms.EmitterUniforms_PivotOffset.y;
    float _454 = _450 * _453;
    float3 _455 = _443 * _454;
    float3 _456 = _449 + _455;
    float3 _457 = _335 + _456;
    float _458 = _457.x;
    float _459 = _457.y;
    float _460 = _457.z;
    float4 _461 = float4(_458, _459, _460, 1.0);
    float4 _462 = float4(_461.x, _461.y, _461.z, _461.w);
    float4 _463 = View.View_TranslatedWorldToClip * _462;
    float3 _466 = float3(0.0);
    _466.x = _279;
    float3 _467 = _466;
    _467.y = _194;
    float3 _468 = _467;
    _468.z = 0.0;
    float3x3 _469 = _125;
    _469[0] = _440;
    float3x3 _470 = _469;
    _470[1] = _443;
    float3 _472 = normalize(cross(_440, _443));
    float3x3 _473 = _470;
    _473[2] = _472;
    spvUnsafeArray<float4, 1> _486 = { float4(_297.x, _297.y, float4(0.0).z, float4(0.0).w) };
    float3 _487 = _461.xyz;
    float3 _488 = _487 - View.View_TranslatedWorldCameraOrigin;
    float _505 = fast::min(View.View_WorldCameraOrigin.z, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.z);
    float _508 = _488.z + (View.View_WorldCameraOrigin.z - _505);
    float3 _509 = _488;
    _509.z = _508;
    float _510 = dot(_509, _509);
    float _511 = rsqrt(_510);
    float _512 = _510 * _511;
    float _520 = fast::max(fast::max(View.View_VolumetricFogMaxDistance * (length(_488) / dot(_488, View.View_ViewForward)), 0.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.w);
    float _554;
    float _555;
    float _556;
    float _557;
    if (_520 > 0.0)
    {
        float _524 = _520 * _511;
        float _525 = _524 * _508;
        float _526 = _505 + _525;
        _554 = (1.0 - _524) * _512;
        _555 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.z * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * (_526 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.w)));
        _556 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.x * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * (_526 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.y)));
        _557 = _508 - _525;
    }
    else
    {
        _554 = _512;
        _555 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.x;
        _556 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.x;
        _557 = _508;
    }
    float _561 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * _557);
    float _575 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * _557);
    float _586 = (_556 * ((abs(_561) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_561)) / _561) : (0.693147182464599609375 - (0.2402265071868896484375 * _561)))) + (_555 * ((abs(_575) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_575)) / _575) : (0.693147182464599609375 - (0.2402265071868896484375 * _575))));
    float3 _628;
    if (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.z > 0.0)
    {
        float2 _613 = float2(dot(_509.xy, float2(TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation.y, -TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation.x)), dot(_509.xy, TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation));
        float3 _614 = float3(_613.x, _613.y, _509.z);
        _628 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.xyz * mix(TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap.sample(TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler, _614, level(TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.z)).xyz, TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap.sample(TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler, _614, level(0.0)).xyz, float3(fast::clamp((_512 * TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.x) + TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.y, 0.0, 1.0)));
    }
    else
    {
        _628 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.xyz;
    }
    float3 _656;
    if ((TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.w >= 0.0) && (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.z == 0.0))
    {
        _656 = (TranslucentBasePass.TranslucentBasePass_Shared_Fog_DirectionalInscatteringColor.xyz * pow(fast::clamp(dot(_509 * _511, TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.xyz), 0.0, 1.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_DirectionalInscatteringColor.w)) * (1.0 - fast::clamp(exp2(-(_586 * fast::max(_554 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.w, 0.0))), 0.0, 1.0));
    }
    else
    {
        _656 = float3(0.0);
    }
    bool _665 = (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w > 0.0) && (_512 > TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w);
    float _668 = _665 ? 1.0 : fast::max(fast::clamp(exp2(-(_586 * _554)), 0.0, 1.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.w);
    float4 _675 = float4((_628 * (1.0 - _668)) + select(_656, float3(0.0), bool3(_665)), _668);
    float4 _752;
    if (View.View_SkyAtmosphereApplyCameraAerialPerspectiveVolume > 0.0)
    {
        float3 _689 = (_487 * 9.9999997473787516355514526367188e-06) - (View.View_TranslatedWorldCameraOrigin * 9.9999997473787516355514526367188e-06);
        float _695 = sqrt((fast::max(0.0, length(_689) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
        float _696 = _695 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
        float _703;
        if (_696 < 0.707106769084930419921875)
        {
            _703 = fast::clamp((_696 * _696) * 2.0, 0.0, 1.0);
        }
        else
        {
            _703 = 1.0;
        }
        float2 _731;
        if (View.View_RealTimeReflectionCapture != 0.0)
        {
            float3 _706 = normalize(_689);
            float _707 = _706.z;
            float _710 = sqrt(1.0 - (_707 * _707));
            float2 _713 = _127;
            _713.y = (_707 * 0.5) + 0.5;
            float _718 = acos(_706.x / _710);
            float2 _723 = _713;
            _723.x = (((_706.y / _710) < 0.0) ? (6.283185482025146484375 - _718) : _718) * 0.15915493667125701904296875;
            _731 = (_723 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
        }
        else
        {
            _731 = ((_463.xy / _463.ww) * float2(0.5, -0.5)) + float2(0.5);
        }
        float4 _736 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_731, _695), level(0.0));
        float3 _748 = _675.xyz + (((_736.xyz * _703).xyz * View.View_OneOverPreExposure).xyz * _668);
        float4 _751 = float4(_748.x, _748.y, _748.z, _126.w);
        _751.w = _668 * (1.0 - (_703 * (1.0 - _736.w)));
        _752 = _751;
    }
    else
    {
        _752 = _675;
    }
    out_var_TEXCOORD0 = _486;
    out.out_var_PARTICLE_SUBUVS = float4(_297.x, _297.y, _300.x, _300.y);
    out.out_var_TEXCOORD4 = _468;
    out.out_var_TEXCOORD5 = ((CurveTexture.sample(CurveTextureSampler, (EmitterUniforms.EmitterUniforms_ColorCurve.xy + (EmitterUniforms.EmitterUniforms_ColorCurve.zw * _194)), level(0.0)) * EmitterUniforms.EmitterUniforms_ColorScale) + EmitterUniforms.EmitterUniforms_ColorBias) * EmitterDynamicUniforms.EmitterDynamicUniforms_DynamicColor;
    out.out_var_TANGENTX = float4(_440, 0.0);
    out.out_var_TANGENTZ = float4(_472, float(int(sign(determinant(_473)))));
    out.out_var_TEXCOORD7 = _752;
    out.gl_Position = _463;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

