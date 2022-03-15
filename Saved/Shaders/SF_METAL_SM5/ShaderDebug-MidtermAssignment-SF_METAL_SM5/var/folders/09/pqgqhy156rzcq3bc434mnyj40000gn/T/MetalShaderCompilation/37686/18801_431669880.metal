

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

constant float3x3 _116 = {};
constant float4 _117 = {};
constant float2 _118 = {};

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

vertex Main_out Main_00004971_19bac278(Main_in in [[stage_in]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_EmitterDynamicUniforms& EmitterDynamicUniforms [[buffer(4)]], constant type_EmitterUniforms& EmitterUniforms [[buffer(5)]], constant type_Globals& _Globals [[buffer(6)]], texture_buffer<float> ParticleIndices [[texture(0)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(1)]], texture2d<float> PositionTexture [[texture(2)]], texture2d<float> VelocityTexture [[texture(3)]], texture2d<float> AttributesTexture [[texture(4)]], texture2d<float> CurveTexture [[texture(5)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(0)]], sampler PositionTextureSampler [[sampler(1)]], sampler VelocityTextureSampler [[sampler(2)]], sampler AttributesTextureSampler [[sampler(3)]], sampler CurveTextureSampler [[sampler(4)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    uint _163 = (gl_InstanceIndex - gl_BaseInstance) * 16u;
    uint _164 = (gl_VertexIndex - gl_BaseVertex) / 4u;
    uint _165 = _163 + _164;
    uint _168 = _Globals.ParticleIndicesOffset + _165;
    float4 _170 = ParticleIndices.read(uint(_168));
    float2 _171 = _170.xy;
    float4 _175 = PositionTexture.sample(PositionTextureSampler, _171, level(0.0));
    float4 _179 = VelocityTexture.sample(VelocityTextureSampler, _171, level(0.0));
    float4 _183 = AttributesTexture.sample(AttributesTextureSampler, _171, level(0.0));
    float _184 = _175.w;
    float _185 = step(_184, 1.0);
    float3 _186 = _179.xyz;
    float3x3 _195 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    float3 _196 = _195 * _186;
    float3 _198 = normalize(_196 + float3(0.0, 0.0, 9.9999997473787516355514526367188e-05));
    float _199 = length(_196);
    float2 _223 = EmitterUniforms.EmitterUniforms_MiscCurve.zw * _184;
    float2 _224 = EmitterUniforms.EmitterUniforms_MiscCurve.xy + _223;
    float4 _226 = CurveTexture.sample(CurveTextureSampler, _224, level(0.0));
    float4 _229 = _226 * EmitterUniforms.EmitterUniforms_MiscScale;
    float4 _232 = _229 + EmitterUniforms.EmitterUniforms_MiscBias;
    float _233 = _183.x;
    bool _234 = _233 < 0.5;
    float _235 = _234 ? 0.0 : (-0.5);
    float _236 = _183.y;
    bool _237 = _236 < 0.5;
    float _238 = _237 ? 0.0 : (-0.5);
    float2 _239 = float2(_235, _238);
    float2 _240 = _183.xy;
    float2 _241 = _240 + _239;
    float2 _242 = _241 * float2(2.0);
    float2 _243 = _232.xy;
    float2 _246 = _243 * EmitterDynamicUniforms.EmitterDynamicUniforms_LocalToWorldScale;
    float2 _250 = EmitterUniforms.EmitterUniforms_SizeBySpeed.xy * _199;
    float2 _251 = fast::max(_250, float2(1.0));
    float2 _253 = fast::min(_251, EmitterUniforms.EmitterUniforms_SizeBySpeed.zw);
    float2 _254 = _242 * _246;
    float2 _255 = _254 * _253;
    float2 _256 = float2(_185);
    float2 _257 = _255 * _256;
    float2 _262 = _118;
    _262.x = (_235 == 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.x) : in.in_var_ATTRIBUTE0.x;
    float2 _267 = _262;
    _267.y = (_238 == 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.y) : in.in_var_ATTRIBUTE0.y;
    float _268 = _232.z;
    float _270 = _268 - fract(_268);
    float2 _283 = (float2(mod(_270, EmitterUniforms.EmitterUniforms_SubImageSize.x), floor(_270 * EmitterUniforms.EmitterUniforms_SubImageSize.z)) + _267) * EmitterUniforms.EmitterUniforms_SubImageSize.zw;
    float _284 = _183.w;
    float _287 = _284 * EmitterUniforms.EmitterUniforms_RotationRateScale;
    float _288 = _183.z;
    float _289 = _287 * _184;
    float _290 = _288 + _289;
    float _291 = _290 * 6.283185482025146484375;
    float3 _295 = _175.xxx;
    float3 _296 = Primitive.Primitive_LocalToWorld[0u].xyz * _295;
    float3 _300 = _175.yyy;
    float3 _301 = Primitive.Primitive_LocalToWorld[1u].xyz * _300;
    float3 _302 = _296 + _301;
    float3 _306 = _175.zzz;
    float3 _307 = Primitive.Primitive_LocalToWorld[2u].xyz * _306;
    float3 _308 = _302 + _307;
    float3 _312 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _313 = _308 + _312;
    float _314 = _313.x;
    float _315 = _313.y;
    float _316 = _313.z;
    float4 _317 = float4(_314, _315, _316, 1.0);
    float3 _318 = _317.xyz;
    float3 _321 = float3(EmitterUniforms.EmitterUniforms_RemoveHMDRoll);
    float3 _330 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _321), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.w));
    float3 _338 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _321), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.w));
    float3 _339 = View.View_TranslatedWorldCameraOrigin - _318;
    float _340 = dot(_339, _339);
    float3 _344 = _339 / float3(sqrt(fast::max(_340, 0.00999999977648258209228515625)));
    float3 _414;
    float3 _415;
    if (EmitterUniforms.EmitterUniforms_CameraFacingBlend[0] > 0.0)
    {
        float3 _402 = cross(_344, float3(0.0, 0.0, 1.0));
        float3 _407 = _402 / float3(sqrt(fast::max(dot(_402, _402), 0.00999999977648258209228515625)));
        float3 _409 = float3(fast::clamp((_340 * EmitterUniforms.EmitterUniforms_CameraFacingBlend[1]) - EmitterUniforms.EmitterUniforms_CameraFacingBlend[2], 0.0, 1.0));
        _414 = normalize(mix(_330, _407, _409));
        _415 = normalize(mix(_338, cross(_344, _407), _409));
    }
    else
    {
        float3 _393;
        float3 _394;
        if (EmitterUniforms.EmitterUniforms_TangentSelector.y > 0.0)
        {
            float3 _386 = cross(_344, _198);
            _393 = _386 / float3(sqrt(fast::max(dot(_386, _386), 0.00999999977648258209228515625)));
            _394 = -_198;
        }
        else
        {
            float3 _384;
            float3 _385;
            if (EmitterUniforms.EmitterUniforms_TangentSelector.z > 0.0)
            {
                float3 _377 = cross(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, _344);
                _384 = EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz;
                _385 = -(_377 / float3(sqrt(fast::max(dot(_377, _377), 0.00999999977648258209228515625))));
            }
            else
            {
                float3 _375;
                float3 _376;
                if (EmitterUniforms.EmitterUniforms_TangentSelector.w > 0.0)
                {
                    float3 _368 = cross(_344, float3(0.0, 0.0, 1.0));
                    float3 _373 = _368 / float3(sqrt(fast::max(dot(_368, _368), 0.00999999977648258209228515625)));
                    _375 = _373;
                    _376 = cross(_344, _373);
                }
                else
                {
                    _375 = _330;
                    _376 = _338;
                }
                _384 = _375;
                _385 = _376;
            }
            _393 = _384;
            _394 = _385;
        }
        _414 = _393;
        _415 = _394;
    }
    float _418 = _291 + EmitterUniforms.EmitterUniforms_RotationBias;
    float _419 = sin(_418);
    float _420 = cos(_418);
    float3 _421 = _415 * _419;
    float3 _422 = _414 * _420;
    float3 _423 = _421 + _422;
    float3 _424 = _415 * _420;
    float3 _425 = _414 * _419;
    float3 _426 = _424 - _425;
    float _427 = _257.x;
    float _430 = in.in_var_ATTRIBUTE0.x + EmitterUniforms.EmitterUniforms_PivotOffset.x;
    float _431 = _427 * _430;
    float3 _432 = _423 * _431;
    float _433 = _257.y;
    float _436 = in.in_var_ATTRIBUTE0.y + EmitterUniforms.EmitterUniforms_PivotOffset.y;
    float _437 = _433 * _436;
    float3 _438 = _426 * _437;
    float3 _439 = _432 + _438;
    float3 _440 = _318 + _439;
    float _441 = _440.x;
    float _442 = _440.y;
    float _443 = _440.z;
    float4 _444 = float4(_441, _442, _443, 1.0);
    float4 _445 = float4(_444.x, _444.y, _444.z, _444.w);
    float4 _446 = View.View_TranslatedWorldToClip * _445;
    float3x3 _448 = _116;
    _448[0] = _423;
    float3x3 _449 = _448;
    _449[1] = _426;
    float3 _451 = normalize(cross(_423, _426));
    float3x3 _452 = _449;
    _452[2] = _451;
    spvUnsafeArray<float4, 1> _465 = { float4(_283.x, _283.y, float4(0.0).z, float4(0.0).w) };
    float3 _466 = _444.xyz;
    float3 _467 = _466 - View.View_TranslatedWorldCameraOrigin;
    float _483 = fast::min(View.View_WorldCameraOrigin.z, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.z);
    float _486 = _467.z + (View.View_WorldCameraOrigin.z - _483);
    float3 _487 = _467;
    _487.z = _486;
    float _488 = dot(_487, _487);
    float _489 = rsqrt(_488);
    float _490 = _488 * _489;
    float _497 = fast::max(fast::max(View.View_VolumetricFogMaxDistance * (length(_467) / dot(_467, View.View_ViewForward)), 0.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.w);
    float _531;
    float _532;
    float _533;
    float _534;
    if (_497 > 0.0)
    {
        float _501 = _497 * _489;
        float _502 = _501 * _486;
        float _503 = _483 + _502;
        _531 = (1.0 - _501) * _490;
        _532 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.z * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * (_503 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.w)));
        _533 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.x * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * (_503 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.y)));
        _534 = _486 - _502;
    }
    else
    {
        _531 = _490;
        _532 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.x;
        _533 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.x;
        _534 = _486;
    }
    float _538 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * _534);
    float _552 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * _534);
    float _574 = ((TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w > 0.0) && (_490 > TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w)) ? 1.0 : fast::max(fast::clamp(exp2(-(((_533 * ((abs(_538) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_538)) / _538) : (0.693147182464599609375 - (0.2402265071868896484375 * _538)))) + (_532 * ((abs(_552) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_552)) / _552) : (0.693147182464599609375 - (0.2402265071868896484375 * _552))))) * _531)), 0.0, 1.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.w);
    float4 _575 = float4(0.0, 0.0, 0.0, _574);
    float4 _652;
    if (View.View_SkyAtmosphereApplyCameraAerialPerspectiveVolume > 0.0)
    {
        float3 _589 = (_466 * 9.9999997473787516355514526367188e-06) - (View.View_TranslatedWorldCameraOrigin * 9.9999997473787516355514526367188e-06);
        float _595 = sqrt((fast::max(0.0, length(_589) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
        float _596 = _595 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
        float _603;
        if (_596 < 0.707106769084930419921875)
        {
            _603 = fast::clamp((_596 * _596) * 2.0, 0.0, 1.0);
        }
        else
        {
            _603 = 1.0;
        }
        float2 _631;
        if (View.View_RealTimeReflectionCapture != 0.0)
        {
            float3 _606 = normalize(_589);
            float _607 = _606.z;
            float _610 = sqrt(1.0 - (_607 * _607));
            float2 _613 = _118;
            _613.y = (_607 * 0.5) + 0.5;
            float _618 = acos(_606.x / _610);
            float2 _623 = _613;
            _623.x = (((_606.y / _610) < 0.0) ? (6.283185482025146484375 - _618) : _618) * 0.15915493667125701904296875;
            _631 = (_623 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
        }
        else
        {
            _631 = ((_446.xy / _446.ww) * float2(0.5, -0.5)) + float2(0.5);
        }
        float4 _636 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_631, _595), level(0.0));
        float3 _648 = _575.xyz + (((_636.xyz * _603).xyz * View.View_OneOverPreExposure).xyz * _574);
        float4 _651 = float4(_648.x, _648.y, _648.z, _117.w);
        _651.w = _574 * (1.0 - (_603 * (1.0 - _636.w)));
        _652 = _651;
    }
    else
    {
        _652 = _575;
    }
    out_var_TEXCOORD0 = _465;
    out.out_var_TEXCOORD5 = ((CurveTexture.sample(CurveTextureSampler, (EmitterUniforms.EmitterUniforms_ColorCurve.xy + (EmitterUniforms.EmitterUniforms_ColorCurve.zw * _184)), level(0.0)) * EmitterUniforms.EmitterUniforms_ColorScale) + EmitterUniforms.EmitterUniforms_ColorBias) * EmitterDynamicUniforms.EmitterDynamicUniforms_DynamicColor;
    out.out_var_TANGENTX = float4(_423, 0.0);
    out.out_var_TANGENTZ = float4(_451, float(int(sign(determinant(_452)))));
    out.out_var_TEXCOORD7 = _652;
    out.gl_Position = _446;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

