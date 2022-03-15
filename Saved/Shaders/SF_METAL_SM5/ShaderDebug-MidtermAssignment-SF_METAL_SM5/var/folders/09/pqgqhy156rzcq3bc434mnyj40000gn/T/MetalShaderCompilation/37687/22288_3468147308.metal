

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
    char _m10_pad[224];
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeInvSize;
    char _m11_pad[448];
    float4 View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize;
    float View_SkyAtmosphereAerialPerspectiveStartDepthKm;
    float View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
    float View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv;
    char _m15_pad[4];
    float View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv;
    float View_SkyAtmosphereApplyCameraAerialPerspectiveVolume;
    char _m17_pad[24];
    float View_RealTimeReflectionCapture;
    char _m18_pad[420];
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

constant float3x3 _130 = {};
constant float4 _131 = {};
constant float2 _132 = {};

struct Main_out
{
    float4 out_var_PARTICLE_SUBUVS [[user(locn0)]];
    float3 out_var_TEXCOORD4 [[user(locn1)]];
    float4 out_var_TEXCOORD5 [[user(locn2)]];
    float3 out_var_PARTICLE_LIGHTING_OFFSET [[user(locn3)]];
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

vertex Main_out Main_00005710_ceb7ba6c(Main_in in [[stage_in]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_EmitterDynamicUniforms& EmitterDynamicUniforms [[buffer(4)]], constant type_EmitterUniforms& EmitterUniforms [[buffer(5)]], constant type_Globals& _Globals [[buffer(6)]], texture_buffer<float> ParticleIndices [[texture(0)]], texturecube<float> TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap [[texture(1)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(2)]], texture2d<float> PositionTexture [[texture(3)]], texture2d<float> VelocityTexture [[texture(4)]], texture2d<float> AttributesTexture [[texture(5)]], texture2d<float> CurveTexture [[texture(6)]], sampler TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler [[sampler(0)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(1)]], sampler PositionTextureSampler [[sampler(2)]], sampler VelocityTextureSampler [[sampler(3)]], sampler AttributesTextureSampler [[sampler(4)]], sampler CurveTextureSampler [[sampler(5)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    uint _179 = (gl_InstanceIndex - gl_BaseInstance) * 16u;
    uint _180 = (gl_VertexIndex - gl_BaseVertex) / 4u;
    uint _181 = _179 + _180;
    uint _184 = _Globals.ParticleIndicesOffset + _181;
    float4 _186 = ParticleIndices.read(uint(_184));
    float2 _187 = _186.xy;
    float4 _191 = PositionTexture.sample(PositionTextureSampler, _187, level(0.0));
    float4 _195 = VelocityTexture.sample(VelocityTextureSampler, _187, level(0.0));
    float4 _199 = AttributesTexture.sample(AttributesTextureSampler, _187, level(0.0));
    float _200 = _191.w;
    float _201 = step(_200, 1.0);
    float3 _202 = _195.xyz;
    float3x3 _211 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    float3 _212 = _211 * _202;
    float3 _214 = normalize(_212 + float3(0.0, 0.0, 9.9999997473787516355514526367188e-05));
    float _215 = length(_212);
    float2 _239 = EmitterUniforms.EmitterUniforms_MiscCurve.zw * _200;
    float2 _240 = EmitterUniforms.EmitterUniforms_MiscCurve.xy + _239;
    float4 _242 = CurveTexture.sample(CurveTextureSampler, _240, level(0.0));
    float4 _245 = _242 * EmitterUniforms.EmitterUniforms_MiscScale;
    float4 _248 = _245 + EmitterUniforms.EmitterUniforms_MiscBias;
    float _249 = _199.x;
    bool _250 = _249 < 0.5;
    float _251 = _250 ? 0.0 : (-0.5);
    float _252 = _199.y;
    bool _253 = _252 < 0.5;
    float _254 = _253 ? 0.0 : (-0.5);
    float2 _255 = float2(_251, _254);
    float2 _256 = _199.xy;
    float2 _257 = _256 + _255;
    float2 _258 = _257 * float2(2.0);
    float2 _259 = _248.xy;
    float2 _262 = _259 * EmitterDynamicUniforms.EmitterDynamicUniforms_LocalToWorldScale;
    float2 _266 = EmitterUniforms.EmitterUniforms_SizeBySpeed.xy * _215;
    float2 _267 = fast::max(_266, float2(1.0));
    float2 _269 = fast::min(_267, EmitterUniforms.EmitterUniforms_SizeBySpeed.zw);
    float2 _270 = _258 * _262;
    float2 _271 = _270 * _269;
    float2 _272 = float2(_201);
    float2 _273 = _271 * _272;
    float2 _278 = _132;
    _278.x = (_251 == 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.x) : in.in_var_ATTRIBUTE0.x;
    float2 _283 = _278;
    _283.y = (_254 == 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.y) : in.in_var_ATTRIBUTE0.y;
    float _284 = _248.z;
    float _285 = fract(_284);
    float _286 = _284 - _285;
    float _287 = _286 + 1.0;
    float2 _303 = (float2(mod(_286, EmitterUniforms.EmitterUniforms_SubImageSize.x), floor(_286 * EmitterUniforms.EmitterUniforms_SubImageSize.z)) + _283) * EmitterUniforms.EmitterUniforms_SubImageSize.zw;
    float2 _306 = (float2(mod(_287, EmitterUniforms.EmitterUniforms_SubImageSize.x), floor(_287 * EmitterUniforms.EmitterUniforms_SubImageSize.z)) + _283) * EmitterUniforms.EmitterUniforms_SubImageSize.zw;
    float _307 = _199.w;
    float _310 = _307 * EmitterUniforms.EmitterUniforms_RotationRateScale;
    float _311 = _199.z;
    float _312 = _310 * _200;
    float _313 = _311 + _312;
    float _314 = _313 * 6.283185482025146484375;
    float3 _318 = _191.xxx;
    float3 _319 = Primitive.Primitive_LocalToWorld[0u].xyz * _318;
    float3 _323 = _191.yyy;
    float3 _324 = Primitive.Primitive_LocalToWorld[1u].xyz * _323;
    float3 _325 = _319 + _324;
    float3 _329 = _191.zzz;
    float3 _330 = Primitive.Primitive_LocalToWorld[2u].xyz * _329;
    float3 _331 = _325 + _330;
    float3 _335 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _336 = _331 + _335;
    float _337 = _336.x;
    float _338 = _336.y;
    float _339 = _336.z;
    float4 _340 = float4(_337, _338, _339, 1.0);
    float3 _341 = _340.xyz;
    float3 _344 = float3(EmitterUniforms.EmitterUniforms_RemoveHMDRoll);
    float3 _353 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _344), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.w));
    float3 _361 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _344), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.w));
    float3 _362 = View.View_TranslatedWorldCameraOrigin - _341;
    float _363 = dot(_362, _362);
    float3 _367 = _362 / float3(sqrt(fast::max(_363, 0.00999999977648258209228515625)));
    float3 _437;
    float3 _438;
    if (EmitterUniforms.EmitterUniforms_CameraFacingBlend[0] > 0.0)
    {
        float3 _381 = cross(_367, float3(0.0, 0.0, 1.0));
        float3 _386 = _381 / float3(sqrt(fast::max(dot(_381, _381), 0.00999999977648258209228515625)));
        float3 _388 = float3(fast::clamp((_363 * EmitterUniforms.EmitterUniforms_CameraFacingBlend[1]) - EmitterUniforms.EmitterUniforms_CameraFacingBlend[2], 0.0, 1.0));
        _437 = normalize(mix(_353, _386, _388));
        _438 = normalize(mix(_361, cross(_367, _386), _388));
    }
    else
    {
        float3 _435;
        float3 _436;
        if (EmitterUniforms.EmitterUniforms_TangentSelector.y > 0.0)
        {
            float3 _399 = cross(_367, _214);
            _435 = _399 / float3(sqrt(fast::max(dot(_399, _399), 0.00999999977648258209228515625)));
            _436 = -_214;
        }
        else
        {
            float3 _433;
            float3 _434;
            if (EmitterUniforms.EmitterUniforms_TangentSelector.z > 0.0)
            {
                float3 _412 = cross(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, _367);
                _433 = EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz;
                _434 = -(_412 / float3(sqrt(fast::max(dot(_412, _412), 0.00999999977648258209228515625))));
            }
            else
            {
                float3 _431;
                float3 _432;
                if (EmitterUniforms.EmitterUniforms_TangentSelector.w > 0.0)
                {
                    float3 _424 = cross(_367, float3(0.0, 0.0, 1.0));
                    float3 _429 = _424 / float3(sqrt(fast::max(dot(_424, _424), 0.00999999977648258209228515625)));
                    _431 = _429;
                    _432 = cross(_367, _429);
                }
                else
                {
                    _431 = _353;
                    _432 = _361;
                }
                _433 = _431;
                _434 = _432;
            }
            _435 = _433;
            _436 = _434;
        }
        _437 = _435;
        _438 = _436;
    }
    float _441 = _314 + EmitterUniforms.EmitterUniforms_RotationBias;
    float _442 = sin(_441);
    float _443 = cos(_441);
    float3 _444 = _438 * _442;
    float3 _445 = _437 * _443;
    float3 _446 = _444 + _445;
    float3 _447 = _438 * _443;
    float3 _448 = _437 * _442;
    float3 _449 = _447 - _448;
    float _450 = _273.x;
    float _453 = in.in_var_ATTRIBUTE0.x + EmitterUniforms.EmitterUniforms_PivotOffset.x;
    float _454 = _450 * _453;
    float3 _455 = _446 * _454;
    float _456 = _273.y;
    float _459 = in.in_var_ATTRIBUTE0.y + EmitterUniforms.EmitterUniforms_PivotOffset.y;
    float _460 = _456 * _459;
    float3 _461 = _449 * _460;
    float3 _462 = _455 + _461;
    float3 _463 = _341 + _462;
    float _477 = _463.x;
    float _478 = _463.y;
    float _479 = _463.z;
    float4 _480 = float4(_477, _478, _479, 1.0);
    float4 _481 = float4(_480.x, _480.y, _480.z, _480.w);
    float4 _482 = View.View_TranslatedWorldToClip * _481;
    float3 _484 = float3(0.0);
    _484.x = _285;
    float3 _485 = _484;
    _485.y = _200;
    float3 _486 = _485;
    _486.z = 0.0;
    float3x3 _487 = _130;
    _487[0] = _446;
    float3x3 _488 = _487;
    _488[1] = _449;
    float3 _490 = normalize(cross(_446, _449));
    float3x3 _491 = _488;
    _491[2] = _490;
    float3 _504 = _480.xyz;
    float3 _505 = _504 - View.View_TranslatedWorldCameraOrigin;
    float _522 = fast::min(View.View_WorldCameraOrigin.z, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.z);
    float _525 = _505.z + (View.View_WorldCameraOrigin.z - _522);
    float3 _526 = _505;
    _526.z = _525;
    float _527 = dot(_526, _526);
    float _528 = rsqrt(_527);
    float _529 = _527 * _528;
    float _537 = fast::max(fast::max(View.View_VolumetricFogMaxDistance * (length(_505) / dot(_505, View.View_ViewForward)), 0.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.w);
    float _571;
    float _572;
    float _573;
    float _574;
    if (_537 > 0.0)
    {
        float _541 = _537 * _528;
        float _542 = _541 * _525;
        float _543 = _522 + _542;
        _571 = (1.0 - _541) * _529;
        _572 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.z * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * (_543 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.w)));
        _573 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.x * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * (_543 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.y)));
        _574 = _525 - _542;
    }
    else
    {
        _571 = _529;
        _572 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.x;
        _573 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.x;
        _574 = _525;
    }
    float _578 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * _574);
    float _592 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * _574);
    float _603 = (_573 * ((abs(_578) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_578)) / _578) : (0.693147182464599609375 - (0.2402265071868896484375 * _578)))) + (_572 * ((abs(_592) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_592)) / _592) : (0.693147182464599609375 - (0.2402265071868896484375 * _592))));
    float3 _645;
    if (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.z > 0.0)
    {
        float2 _630 = float2(dot(_526.xy, float2(TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation.y, -TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation.x)), dot(_526.xy, TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation));
        float3 _631 = float3(_630.x, _630.y, _526.z);
        _645 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.xyz * mix(TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap.sample(TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler, _631, level(TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.z)).xyz, TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap.sample(TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler, _631, level(0.0)).xyz, float3(fast::clamp((_529 * TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.x) + TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.y, 0.0, 1.0)));
    }
    else
    {
        _645 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.xyz;
    }
    float3 _673;
    if ((TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.w >= 0.0) && (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.z == 0.0))
    {
        _673 = (TranslucentBasePass.TranslucentBasePass_Shared_Fog_DirectionalInscatteringColor.xyz * pow(fast::clamp(dot(_526 * _528, TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.xyz), 0.0, 1.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_DirectionalInscatteringColor.w)) * (1.0 - fast::clamp(exp2(-(_603 * fast::max(_571 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.w, 0.0))), 0.0, 1.0));
    }
    else
    {
        _673 = float3(0.0);
    }
    bool _682 = (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w > 0.0) && (_529 > TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w);
    float _685 = _682 ? 1.0 : fast::max(fast::clamp(exp2(-(_603 * _571)), 0.0, 1.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.w);
    float4 _692 = float4((_645 * (1.0 - _685)) + select(_673, float3(0.0), bool3(_682)), _685);
    float4 _769;
    if (View.View_SkyAtmosphereApplyCameraAerialPerspectiveVolume > 0.0)
    {
        float3 _706 = (_504 * 9.9999997473787516355514526367188e-06) - (View.View_TranslatedWorldCameraOrigin * 9.9999997473787516355514526367188e-06);
        float _712 = sqrt((fast::max(0.0, length(_706) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
        float _713 = _712 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
        float _720;
        if (_713 < 0.707106769084930419921875)
        {
            _720 = fast::clamp((_713 * _713) * 2.0, 0.0, 1.0);
        }
        else
        {
            _720 = 1.0;
        }
        float2 _748;
        if (View.View_RealTimeReflectionCapture != 0.0)
        {
            float3 _723 = normalize(_706);
            float _724 = _723.z;
            float _727 = sqrt(1.0 - (_724 * _724));
            float2 _730 = _132;
            _730.y = (_724 * 0.5) + 0.5;
            float _735 = acos(_723.x / _727);
            float2 _740 = _730;
            _740.x = (((_723.y / _727) < 0.0) ? (6.283185482025146484375 - _735) : _735) * 0.15915493667125701904296875;
            _748 = (_740 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
        }
        else
        {
            _748 = ((_482.xy / _482.ww) * float2(0.5, -0.5)) + float2(0.5);
        }
        float4 _753 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_748, _712), level(0.0));
        float3 _765 = _692.xyz + (((_753.xyz * _720).xyz * View.View_OneOverPreExposure).xyz * _685);
        float4 _768 = float4(_765.x, _765.y, _765.z, _131.w);
        _768.w = _685 * (1.0 - (_720 * (1.0 - _753.w)));
        _769 = _768;
    }
    else
    {
        _769 = _692;
    }
    out.out_var_PARTICLE_SUBUVS = float4(_303.x, _303.y, _306.x, _306.y);
    out.out_var_TEXCOORD4 = _486;
    out.out_var_TEXCOORD5 = ((CurveTexture.sample(CurveTextureSampler, (EmitterUniforms.EmitterUniforms_ColorCurve.xy + (EmitterUniforms.EmitterUniforms_ColorCurve.zw * _200)), level(0.0)) * EmitterUniforms.EmitterUniforms_ColorScale) + EmitterUniforms.EmitterUniforms_ColorBias) * EmitterDynamicUniforms.EmitterDynamicUniforms_DynamicColor;
    out.out_var_PARTICLE_LIGHTING_OFFSET = ((fract(float3(1341.456298828125, 2633.577880859375, 5623.98291015625) * ((_186.x + 10.0) * (_186.y + 10.0))) * 2.0) - float3(1.0)) * (0.5 * View.View_TranslucencyLightingVolumeInvSize[0].w);
    out.out_var_TANGENTX = float4(_446, 0.0);
    out.out_var_TANGENTZ = float4(_490, float(int(sign(determinant(_491)))));
    out.out_var_TEXCOORD7 = _769;
    out.gl_Position = _482;
    return out;
}

