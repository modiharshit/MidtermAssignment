

#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

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
    float4 out_var_PARTICLE_SUBUVS [[user(locn0)]];
    float3 out_var_TEXCOORD4 [[user(locn1)]];
    float4 out_var_TEXCOORD5 [[user(locn2)]];
    float4 out_var_TANGENTX [[user(locn3)]];
    float4 out_var_TANGENTZ [[user(locn4)]];
    float4 out_var_TEXCOORD7 [[user(locn5)]];
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

vertex Main_out Main_0000473f_4383e41a(Main_in in [[stage_in]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_EmitterDynamicUniforms& EmitterDynamicUniforms [[buffer(4)]], constant type_EmitterUniforms& EmitterUniforms [[buffer(5)]], constant type_Globals& _Globals [[buffer(6)]], texture_buffer<float> ParticleIndices [[texture(0)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(1)]], texture2d<float> PositionTexture [[texture(2)]], texture2d<float> VelocityTexture [[texture(3)]], texture2d<float> AttributesTexture [[texture(4)]], texture2d<float> CurveTexture [[texture(5)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(0)]], sampler PositionTextureSampler [[sampler(1)]], sampler VelocityTextureSampler [[sampler(2)]], sampler AttributesTextureSampler [[sampler(3)]], sampler CurveTextureSampler [[sampler(4)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
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
    float _269 = fract(_268);
    float _270 = _268 - _269;
    float _271 = _270 + 1.0;
    float2 _287 = (float2(mod(_270, EmitterUniforms.EmitterUniforms_SubImageSize.x), floor(_270 * EmitterUniforms.EmitterUniforms_SubImageSize.z)) + _267) * EmitterUniforms.EmitterUniforms_SubImageSize.zw;
    float2 _290 = (float2(mod(_271, EmitterUniforms.EmitterUniforms_SubImageSize.x), floor(_271 * EmitterUniforms.EmitterUniforms_SubImageSize.z)) + _267) * EmitterUniforms.EmitterUniforms_SubImageSize.zw;
    float _291 = _183.w;
    float _294 = _291 * EmitterUniforms.EmitterUniforms_RotationRateScale;
    float _295 = _183.z;
    float _296 = _294 * _184;
    float _297 = _295 + _296;
    float _298 = _297 * 6.283185482025146484375;
    float3 _302 = _175.xxx;
    float3 _303 = Primitive.Primitive_LocalToWorld[0u].xyz * _302;
    float3 _307 = _175.yyy;
    float3 _308 = Primitive.Primitive_LocalToWorld[1u].xyz * _307;
    float3 _309 = _303 + _308;
    float3 _313 = _175.zzz;
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
        float3 _365 = cross(_351, float3(0.0, 0.0, 1.0));
        float3 _370 = _365 / float3(sqrt(fast::max(dot(_365, _365), 0.00999999977648258209228515625)));
        float3 _372 = float3(fast::clamp((_347 * EmitterUniforms.EmitterUniforms_CameraFacingBlend[1]) - EmitterUniforms.EmitterUniforms_CameraFacingBlend[2], 0.0, 1.0));
        _421 = normalize(mix(_337, _370, _372));
        _422 = normalize(mix(_345, cross(_351, _370), _372));
    }
    else
    {
        float3 _419;
        float3 _420;
        if (EmitterUniforms.EmitterUniforms_TangentSelector.y > 0.0)
        {
            float3 _383 = cross(_351, _198);
            _419 = _383 / float3(sqrt(fast::max(dot(_383, _383), 0.00999999977648258209228515625)));
            _420 = -_198;
        }
        else
        {
            float3 _417;
            float3 _418;
            if (EmitterUniforms.EmitterUniforms_TangentSelector.z > 0.0)
            {
                float3 _396 = cross(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, _351);
                _417 = EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz;
                _418 = -(_396 / float3(sqrt(fast::max(dot(_396, _396), 0.00999999977648258209228515625))));
            }
            else
            {
                float3 _415;
                float3 _416;
                if (EmitterUniforms.EmitterUniforms_TangentSelector.w > 0.0)
                {
                    float3 _408 = cross(_351, float3(0.0, 0.0, 1.0));
                    float3 _413 = _408 / float3(sqrt(fast::max(dot(_408, _408), 0.00999999977648258209228515625)));
                    _415 = _413;
                    _416 = cross(_351, _413);
                }
                else
                {
                    _415 = _337;
                    _416 = _345;
                }
                _417 = _415;
                _418 = _416;
            }
            _419 = _417;
            _420 = _418;
        }
        _421 = _419;
        _422 = _420;
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
    float _434 = _257.x;
    float _437 = in.in_var_ATTRIBUTE0.x + EmitterUniforms.EmitterUniforms_PivotOffset.x;
    float _438 = _434 * _437;
    float3 _439 = _430 * _438;
    float _440 = _257.y;
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
    float3 _455 = float3(0.0);
    _455.x = _269;
    float3 _456 = _455;
    _456.y = _184;
    float3 _457 = _456;
    _457.z = 0.0;
    float3x3 _458 = _116;
    _458[0] = _430;
    float3x3 _459 = _458;
    _459[1] = _433;
    float3 _461 = normalize(cross(_430, _433));
    float3x3 _462 = _459;
    _462[2] = _461;
    float3 _475 = _451.xyz;
    float3 _476 = _475 - View.View_TranslatedWorldCameraOrigin;
    float _492 = fast::min(View.View_WorldCameraOrigin.z, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.z);
    float _495 = _476.z + (View.View_WorldCameraOrigin.z - _492);
    float3 _496 = _476;
    _496.z = _495;
    float _497 = dot(_496, _496);
    float _498 = rsqrt(_497);
    float _499 = _497 * _498;
    float _506 = fast::max(fast::max(View.View_VolumetricFogMaxDistance * (length(_476) / dot(_476, View.View_ViewForward)), 0.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.w);
    float _540;
    float _541;
    float _542;
    float _543;
    if (_506 > 0.0)
    {
        float _510 = _506 * _498;
        float _511 = _510 * _495;
        float _512 = _492 + _511;
        _540 = (1.0 - _510) * _499;
        _541 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.z * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * (_512 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.w)));
        _542 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.x * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * (_512 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.y)));
        _543 = _495 - _511;
    }
    else
    {
        _540 = _499;
        _541 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.x;
        _542 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.x;
        _543 = _495;
    }
    float _547 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * _543);
    float _561 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * _543);
    float _583 = ((TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w > 0.0) && (_499 > TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w)) ? 1.0 : fast::max(fast::clamp(exp2(-(((_542 * ((abs(_547) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_547)) / _547) : (0.693147182464599609375 - (0.2402265071868896484375 * _547)))) + (_541 * ((abs(_561) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_561)) / _561) : (0.693147182464599609375 - (0.2402265071868896484375 * _561))))) * _540)), 0.0, 1.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.w);
    float4 _584 = float4(0.0, 0.0, 0.0, _583);
    float4 _661;
    if (View.View_SkyAtmosphereApplyCameraAerialPerspectiveVolume > 0.0)
    {
        float3 _598 = (_475 * 9.9999997473787516355514526367188e-06) - (View.View_TranslatedWorldCameraOrigin * 9.9999997473787516355514526367188e-06);
        float _604 = sqrt((fast::max(0.0, length(_598) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
        float _605 = _604 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
        float _612;
        if (_605 < 0.707106769084930419921875)
        {
            _612 = fast::clamp((_605 * _605) * 2.0, 0.0, 1.0);
        }
        else
        {
            _612 = 1.0;
        }
        float2 _640;
        if (View.View_RealTimeReflectionCapture != 0.0)
        {
            float3 _615 = normalize(_598);
            float _616 = _615.z;
            float _619 = sqrt(1.0 - (_616 * _616));
            float2 _622 = _118;
            _622.y = (_616 * 0.5) + 0.5;
            float _627 = acos(_615.x / _619);
            float2 _632 = _622;
            _632.x = (((_615.y / _619) < 0.0) ? (6.283185482025146484375 - _627) : _627) * 0.15915493667125701904296875;
            _640 = (_632 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
        }
        else
        {
            _640 = ((_453.xy / _453.ww) * float2(0.5, -0.5)) + float2(0.5);
        }
        float4 _645 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_640, _604), level(0.0));
        float3 _657 = _584.xyz + (((_645.xyz * _612).xyz * View.View_OneOverPreExposure).xyz * _583);
        float4 _660 = float4(_657.x, _657.y, _657.z, _117.w);
        _660.w = _583 * (1.0 - (_612 * (1.0 - _645.w)));
        _661 = _660;
    }
    else
    {
        _661 = _584;
    }
    out.out_var_PARTICLE_SUBUVS = float4(_287.x, _287.y, _290.x, _290.y);
    out.out_var_TEXCOORD4 = _457;
    out.out_var_TEXCOORD5 = ((CurveTexture.sample(CurveTextureSampler, (EmitterUniforms.EmitterUniforms_ColorCurve.xy + (EmitterUniforms.EmitterUniforms_ColorCurve.zw * _184)), level(0.0)) * EmitterUniforms.EmitterUniforms_ColorScale) + EmitterUniforms.EmitterUniforms_ColorBias) * EmitterDynamicUniforms.EmitterDynamicUniforms_DynamicColor;
    out.out_var_TANGENTX = float4(_430, 0.0);
    out.out_var_TANGENTZ = float4(_461, float(int(sign(determinant(_462)))));
    out.out_var_TEXCOORD7 = _661;
    out.gl_Position = _453;
    return out;
}

