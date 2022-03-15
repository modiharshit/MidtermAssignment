

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
    float4x4 View_TranslatedWorldToClip;
    char _m1_pad[912];
    float3 View_ViewUp;
    float3 View_ViewRight;
    float3 View_HMDViewNoRollUp;
    float3 View_HMDViewNoRollRight;
    char _m5_pad[48];
    float3 View_TranslatedWorldCameraOrigin;
    char _m6_pad[16];
    float3 View_PreViewTranslation;
    char _m7_pad[1032];
    float View_OneOverPreExposure;
    char _m8_pad[352];
    float View_AtmosphericFogSunPower;
    float View_AtmosphericFogPower;
    float View_AtmosphericFogDensityScale;
    float View_AtmosphericFogDensityOffset;
    float View_AtmosphericFogGroundOffset;
    float View_AtmosphericFogDistanceScale;
    float View_AtmosphericFogAltitudeScale;
    float View_AtmosphericFogHeightScaleRayleigh;
    float View_AtmosphericFogStartDistance;
    float View_AtmosphericFogDistanceOffset;
    spvUnsafeArray<float4, 2> View_AtmosphereLightDirection;
    spvUnsafeArray<float4, 2> View_AtmosphereLightColor;
    char _m20_pad[32];
    spvUnsafeArray<float4, 2> View_AtmosphereLightDiscLuminance;
    spvUnsafeArray<float4, 2> View_AtmosphereLightDiscCosHalfApexAngle;
    char _m22_pad[144];
    float4 View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize;
    float View_SkyAtmosphereAerialPerspectiveStartDepthKm;
    float View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
    float View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv;
    char _m26_pad[4];
    float View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv;
    float View_SkyAtmosphereApplyCameraAerialPerspectiveVolume;
    uint View_AtmosphericFogRenderMask;
    uint View_AtmosphericFogInscatterAltitudeSampleNum;
    char _m30_pad[16];
    float View_RealTimeReflectionCapture;
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

constant float3x3 _190 = {};
constant float4 _191 = {};
constant float2 _193 = {};

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

vertex Main_out Main_000088b5_47e819db(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_EmitterDynamicUniforms& EmitterDynamicUniforms [[buffer(3)]], constant type_EmitterUniforms& EmitterUniforms [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> ParticleIndices [[texture(0)]], texture2d<float> View_AtmosphereTransmittanceTexture [[texture(1)]], texture2d<float> View_AtmosphereIrradianceTexture [[texture(2)]], texture3d<float> View_AtmosphereInscatterTexture [[texture(3)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(4)]], texture2d<float> PositionTexture [[texture(5)]], texture2d<float> VelocityTexture [[texture(6)]], texture2d<float> AttributesTexture [[texture(7)]], texture2d<float> CurveTexture [[texture(8)]], sampler View_AtmosphereTransmittanceTextureSampler [[sampler(0)]], sampler View_AtmosphereIrradianceTextureSampler [[sampler(1)]], sampler View_AtmosphereInscatterTextureSampler [[sampler(2)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(3)]], sampler PositionTextureSampler [[sampler(4)]], sampler VelocityTextureSampler [[sampler(5)]], sampler AttributesTextureSampler [[sampler(6)]], sampler CurveTextureSampler [[sampler(7)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    uint _251 = (gl_InstanceIndex - gl_BaseInstance) * 16u;
    uint _252 = (gl_VertexIndex - gl_BaseVertex) / 4u;
    uint _253 = _251 + _252;
    uint _256 = _Globals.ParticleIndicesOffset + _253;
    float4 _258 = ParticleIndices.read(uint(_256));
    float2 _259 = _258.xy;
    float4 _263 = PositionTexture.sample(PositionTextureSampler, _259, level(0.0));
    float4 _267 = VelocityTexture.sample(VelocityTextureSampler, _259, level(0.0));
    float4 _271 = AttributesTexture.sample(AttributesTextureSampler, _259, level(0.0));
    float _272 = _263.w;
    float _273 = step(_272, 1.0);
    float3 _274 = _267.xyz;
    float3x3 _283 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    float3 _284 = _283 * _274;
    float3 _286 = normalize(_284 + float3(0.0, 0.0, 9.9999997473787516355514526367188e-05));
    float _287 = length(_284);
    float2 _311 = EmitterUniforms.EmitterUniforms_MiscCurve.zw * _272;
    float2 _312 = EmitterUniforms.EmitterUniforms_MiscCurve.xy + _311;
    float4 _314 = CurveTexture.sample(CurveTextureSampler, _312, level(0.0));
    float4 _317 = _314 * EmitterUniforms.EmitterUniforms_MiscScale;
    float4 _320 = _317 + EmitterUniforms.EmitterUniforms_MiscBias;
    float _321 = _271.x;
    bool _322 = _321 < 0.5;
    float _323 = _322 ? 0.0 : (-0.5);
    float _324 = _271.y;
    bool _325 = _324 < 0.5;
    float _326 = _325 ? 0.0 : (-0.5);
    float2 _327 = float2(_323, _326);
    float2 _328 = _271.xy;
    float2 _329 = _328 + _327;
    float2 _330 = _329 * float2(2.0);
    float2 _331 = _320.xy;
    float2 _334 = _331 * EmitterDynamicUniforms.EmitterDynamicUniforms_LocalToWorldScale;
    float2 _338 = EmitterUniforms.EmitterUniforms_SizeBySpeed.xy * _287;
    float2 _339 = fast::max(_338, float2(1.0));
    float2 _341 = fast::min(_339, EmitterUniforms.EmitterUniforms_SizeBySpeed.zw);
    float2 _342 = _330 * _334;
    float2 _343 = _342 * _341;
    float2 _344 = float2(_273);
    float2 _345 = _343 * _344;
    float2 _350 = _193;
    _350.x = (_323 == 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.x) : in.in_var_ATTRIBUTE0.x;
    float2 _355 = _350;
    _355.y = (_326 == 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.y) : in.in_var_ATTRIBUTE0.y;
    float _356 = _320.z;
    float _358 = _356 - fract(_356);
    float2 _371 = (float2(mod(_358, EmitterUniforms.EmitterUniforms_SubImageSize.x), floor(_358 * EmitterUniforms.EmitterUniforms_SubImageSize.z)) + _355) * EmitterUniforms.EmitterUniforms_SubImageSize.zw;
    float _372 = _271.w;
    float _375 = _372 * EmitterUniforms.EmitterUniforms_RotationRateScale;
    float _376 = _271.z;
    float _377 = _375 * _272;
    float _378 = _376 + _377;
    float _379 = _378 * 6.283185482025146484375;
    float3 _383 = _263.xxx;
    float3 _384 = Primitive.Primitive_LocalToWorld[0u].xyz * _383;
    float3 _388 = _263.yyy;
    float3 _389 = Primitive.Primitive_LocalToWorld[1u].xyz * _388;
    float3 _390 = _384 + _389;
    float3 _394 = _263.zzz;
    float3 _395 = Primitive.Primitive_LocalToWorld[2u].xyz * _394;
    float3 _396 = _390 + _395;
    float3 _400 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _401 = _396 + _400;
    float _402 = _401.x;
    float _403 = _401.y;
    float _404 = _401.z;
    float4 _405 = float4(_402, _403, _404, 1.0);
    float3 _406 = _405.xyz;
    float3 _409 = float3(EmitterUniforms.EmitterUniforms_RemoveHMDRoll);
    float3 _418 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _409), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.w));
    float3 _426 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _409), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.w));
    float3 _427 = View.View_TranslatedWorldCameraOrigin - _406;
    float _428 = dot(_427, _427);
    float3 _432 = _427 / float3(sqrt(fast::max(_428, 0.00999999977648258209228515625)));
    float3 _502;
    float3 _503;
    if (EmitterUniforms.EmitterUniforms_CameraFacingBlend[0] > 0.0)
    {
        float3 _490 = cross(_432, float3(0.0, 0.0, 1.0));
        float3 _495 = _490 / float3(sqrt(fast::max(dot(_490, _490), 0.00999999977648258209228515625)));
        float3 _497 = float3(fast::clamp((_428 * EmitterUniforms.EmitterUniforms_CameraFacingBlend[1]) - EmitterUniforms.EmitterUniforms_CameraFacingBlend[2], 0.0, 1.0));
        _502 = normalize(mix(_418, _495, _497));
        _503 = normalize(mix(_426, cross(_432, _495), _497));
    }
    else
    {
        float3 _481;
        float3 _482;
        if (EmitterUniforms.EmitterUniforms_TangentSelector.y > 0.0)
        {
            float3 _474 = cross(_432, _286);
            _481 = _474 / float3(sqrt(fast::max(dot(_474, _474), 0.00999999977648258209228515625)));
            _482 = -_286;
        }
        else
        {
            float3 _472;
            float3 _473;
            if (EmitterUniforms.EmitterUniforms_TangentSelector.z > 0.0)
            {
                float3 _465 = cross(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, _432);
                _472 = EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz;
                _473 = -(_465 / float3(sqrt(fast::max(dot(_465, _465), 0.00999999977648258209228515625))));
            }
            else
            {
                float3 _463;
                float3 _464;
                if (EmitterUniforms.EmitterUniforms_TangentSelector.w > 0.0)
                {
                    float3 _456 = cross(_432, float3(0.0, 0.0, 1.0));
                    float3 _461 = _456 / float3(sqrt(fast::max(dot(_456, _456), 0.00999999977648258209228515625)));
                    _463 = _461;
                    _464 = cross(_432, _461);
                }
                else
                {
                    _463 = _418;
                    _464 = _426;
                }
                _472 = _463;
                _473 = _464;
            }
            _481 = _472;
            _482 = _473;
        }
        _502 = _481;
        _503 = _482;
    }
    float _506 = _379 + EmitterUniforms.EmitterUniforms_RotationBias;
    float _507 = sin(_506);
    float _508 = cos(_506);
    float3 _509 = _503 * _507;
    float3 _510 = _502 * _508;
    float3 _511 = _509 + _510;
    float3 _512 = _503 * _508;
    float3 _513 = _502 * _507;
    float3 _514 = _512 - _513;
    float _515 = _345.x;
    float _518 = in.in_var_ATTRIBUTE0.x + EmitterUniforms.EmitterUniforms_PivotOffset.x;
    float _519 = _515 * _518;
    float3 _520 = _511 * _519;
    float _521 = _345.y;
    float _524 = in.in_var_ATTRIBUTE0.y + EmitterUniforms.EmitterUniforms_PivotOffset.y;
    float _525 = _521 * _524;
    float3 _526 = _514 * _525;
    float3 _527 = _520 + _526;
    float3 _528 = _406 + _527;
    float _529 = _528.x;
    float _530 = _528.y;
    float _531 = _528.z;
    float4 _532 = float4(_529, _530, _531, 1.0);
    float4 _533 = float4(_532.x, _532.y, _532.z, _532.w);
    float4 _534 = View.View_TranslatedWorldToClip * _533;
    float3x3 _536 = _190;
    _536[0] = _511;
    float3x3 _537 = _536;
    _537[1] = _514;
    float3 _539 = normalize(cross(_511, _514));
    float3x3 _540 = _537;
    _540[2] = _539;
    spvUnsafeArray<float4, 1> _553 = { float4(_371.x, _371.y, float4(0.0).z, float4(0.0).w) };
    float3 _554 = _532.xyz;
    float3 _555 = _554 - View.View_TranslatedWorldCameraOrigin;
    float _559 = 9.9999997473787516355514526367188e-06 * View.View_AtmosphericFogDistanceScale;
    float3 _567 = View.View_TranslatedWorldCameraOrigin;
    _567.z = (View.View_TranslatedWorldCameraOrigin.z - View.View_AtmosphericFogGroundOffset) * View.View_AtmosphericFogAltitudeScale;
    float3 _568 = _567 * _559;
    float3 _571 = _568;
    _571.z = _568.z + 6360.009765625;
    float _572 = length(_571);
    float3 _573 = normalize(_555);
    float _574 = dot(_571, _573);
    float _575 = _574 / _572;
    float _577 = (-_572) * _575;
    float _581 = (_572 * _572) * ((_575 * _575) - 1.0);
    float _586 = length(_555) * _559;
    float _590 = fast::max(0.0, _586 - View.View_AtmosphericFogStartDistance);
    float _593 = fast::min((_590 * 0.100000001490116119384765625) / View.View_AtmosphericFogStartDistance, 1.0);
    bool _594 = _586 < (100.0 * View.View_AtmosphericFogDistanceScale);
    float _604;
    float _605;
    if (_594)
    {
        _604 = _593 * View.View_AtmosphericFogPower;
        _605 = fast::max(_586 + View.View_AtmosphericFogDistanceOffset, 1.0);
    }
    else
    {
        _604 = 1.0;
        _605 = _577 - sqrt(_581 + 40449600.0);
    }
    float _611 = _577 - sqrt(_581 + 41344900.0);
    bool _612 = _611 > 0.0;
    float _620;
    float _621;
    float3 _622;
    if (_612)
    {
        _620 = (_574 + _611) * 0.00015552098921034485101699829101562;
        _621 = _605 - _611;
        _622 = _571 + (_573 * _611);
    }
    else
    {
        _620 = _575;
        _621 = _605;
        _622 = _571;
    }
    float _623 = _612 ? 6430.0 : _572;
    bool _624 = _623 < 6360.0146484375;
    float _633;
    float _634;
    float3 _635;
    if (_624)
    {
        float _627 = 6360.0146484375 - _623;
        float3 _629 = _622 - (_573 * _627);
        _633 = dot(_629, _573) * 0.0001572323380969464778900146484375;
        _634 = _621 - _627;
        _635 = _629;
    }
    else
    {
        _633 = _620;
        _634 = _621;
        _635 = _622;
    }
    float _636 = _624 ? 6360.0146484375 : _623;
    float3 _1136;
    float3 _1137;
    if ((_636 <= 6430.0) && (_590 > 0.0))
    {
        float3 _643 = _635 + (_573 * _634);
        float _644 = length(_643);
        float _645 = dot(_573, View.View_AtmosphereLightDirection[0].xyz);
        float _647 = dot(_635, View.View_AtmosphereLightDirection[0].xyz) / _636;
        float _648 = 6360.0 / _636;
        float _651 = sqrt(1.0 - (_648 * _648));
        float _660;
        if (_594)
        {
            _660 = fast::max(_633, 0.1550000011920928955078125 - _651);
        }
        else
        {
            _660 = fast::max(_633, 0.004999999888241291046142578125 - _651);
        }
        float3 _681;
        float _682;
        float _683;
        if (_594)
        {
            float _663 = _573.z;
            float _667 = fast::clamp(exp(-_663) - 0.5, 0.0, 1.0);
            float3 _679;
            float _680;
            if (_667 < 1.0)
            {
                float3 _672 = _573;
                _672.z = fast::max(_663, 0.1500000059604644775390625);
                float3 _673 = normalize(_672);
                float3 _675 = _635 + (_673 * _634);
                _679 = _673;
                _680 = dot(_675, _673) / length(_675);
            }
            else
            {
                _679 = _573;
                _680 = _660;
            }
            _681 = _679;
            _682 = _667;
            _683 = _680;
        }
        else
        {
            _681 = _573;
            _682 = 0.0;
            _683 = _660;
        }
        float _685 = 1.0 + (_645 * _645);
        float _696 = _636 * _636;
        float _698 = sqrt(_696 - 40449600.0);
        float _699 = _636 * _683;
        float _702 = ((_699 * _699) - _696) + 40449600.0;
        float4 _707 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_699 < 0.0) && (_702 > 0.0)));
        float _710 = float(View.View_AtmosphericFogInscatterAltitudeSampleNum);
        float _711 = 0.5 / _710;
        float _714 = 1.0 - (1.0 / _710);
        float _716 = _711 + ((_698 * 0.00105685577727854251861572265625) * _714);
        float _728 = _707.w + ((((_699 * _707.x) + sqrt(_702 + _707.y)) / (_698 + _707.z)) * 0.4921875);
        float _737 = (_645 + 1.0) * 3.5;
        float _738 = floor(_737);
        float _739 = _737 - _738;
        float _740 = _738 + (0.015625 + (((atan(fast::max(_647, -0.19750000536441802978515625) * 5.349621295928955078125) * 0.90909087657928466796875) + 0.7400000095367431640625) * 0.484375));
        float _741 = _740 * 0.125;
        float _745 = 1.0 - _739;
        float _748 = (_740 + 1.0) * 0.125;
        float4 _754 = fast::max((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_741, _728, _716), level(0.0)) * _745) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_748, _728, _716), level(0.0)) * _739), float4(0.0));
        float3 _1120;
        float4 _1121;
        if (_634 > 0.0)
        {
            float2 _765 = float2(_683, _683 + (_634 / _636));
            float2 _766 = _765 * sqrt((0.5 / View.View_AtmosphericFogHeightScaleRayleigh) * _636);
            float2 _769 = float2(int2(sign(_766)));
            float2 _770 = _766 * _766;
            float _786 = 2.0 * _636;
            float _788 = (_634 / _786) + _683;
            float _796 = 6360.0 - _636;
            float2 _806 = _765 * sqrt(0.4166666567325592041015625 * _636);
            float2 _809 = float2(int2(sign(_806)));
            float2 _810 = _806 * _806;
            float3 _839 = exp((float3(-0.0057999999262392520904541015625, -0.013500000350177288055419921875, -0.033100001513957977294921875) * ((sqrt((6.283100128173828125 * View.View_AtmosphericFogHeightScaleRayleigh) * _636) * exp(_796 / View.View_AtmosphericFogHeightScaleRayleigh)) * (((_769.y > _769.x) ? exp(_770.x) : 0.0) + dot((_769 / ((abs(_766) * 2.3192999362945556640625) + sqrt((_770 * 1.519999980926513671875) + float2(4.0)))) * float2(1.0, exp(((-_634) / View.View_AtmosphericFogHeightScaleRayleigh) * _788)), float2(1.0, -1.0))))) - (float3(0.00444444455206394195556640625) * ((sqrt(7.5397205352783203125 * _636) * exp(_796 * 0.833333313465118408203125)) * (((_809.y > _809.x) ? exp(_810.x) : 0.0) + dot((_809 / ((abs(_806) * 2.3192999362945556640625) + sqrt((_810 * 1.519999980926513671875) + float2(4.0)))) * float2(1.0, exp((_634 * (-0.833333313465118408203125)) * _788)), float2(1.0, -1.0))))));
            float _847;
            if (_594)
            {
                _847 = fast::max(_644, _636);
            }
            else
            {
                _847 = _644;
            }
            float4 _1119;
            if (_847 > 6360.009765625)
            {
                float4 _1118;
                if (_682 < 1.0)
                {
                    float4 _858 = _839.xyzx;
                    float _859 = _847 * _847;
                    float _861 = sqrt(_859 - 40449600.0);
                    float _862 = _847 * (dot(_643, _681) / _644);
                    float _865 = ((_862 * _862) - _859) + 40449600.0;
                    float4 _870 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_862 < 0.0) && (_865 > 0.0)));
                    float _873 = _711 + ((_861 * 0.00105685577727854251861572265625) * _714);
                    float _885 = _870.w + ((((_862 * _870.x) + sqrt(_865 + _870.y)) / (_861 + _870.z)) * 0.4921875);
                    float _893 = _738 + (0.015625 + (((atan(fast::max(dot(_643, View.View_AtmosphereLightDirection[0].xyz) / _644, -0.19750000536441802978515625) * 5.349621295928955078125) * 0.90909087657928466796875) + 0.7400000095367431640625) * 0.484375));
                    float _894 = _893 * 0.125;
                    float _900 = (_893 + 1.0) * 0.125;
                    float4 _908 = fast::max(_754 - (_858 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_894, _885, _873), level(0.0)) * _745) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_900, _885, _873), level(0.0)) * _739))), float4(0.0));
                    float4 _1117;
                    if (!_594)
                    {
                        float _952 = _683 - (-_651);
                        float4 _1116;
                        if (abs(_952) < 0.004999999888241291046142578125)
                        {
                            float _959 = (-0.004999999888241291046142578125) - _651;
                            float _961 = _696 + (_634 * _634);
                            float _962 = _786 * _634;
                            float _965 = sqrt(_961 + (_962 * _959));
                            float _966 = _636 * _959;
                            float _969 = 0.004999999888241291046142578125 - _651;
                            float _973 = ((_966 * _966) - _696) + 40449600.0;
                            float4 _978 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_966 < 0.0) && (_973 > 0.0)));
                            float _990 = _978.w + ((((_966 * _978.x) + sqrt(_973 + _978.y)) / (_698 + _978.z)) * 0.4921875);
                            float _1000 = _965 * _965;
                            float _1002 = sqrt(_1000 - 40449600.0);
                            float _1003 = _965 * fast::max(_969, (_966 + _634) / _965);
                            float _1006 = ((_1003 * _1003) - _1000) + 40449600.0;
                            float4 _1011 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_1003 < 0.0) && (_1006 > 0.0)));
                            float _1014 = _711 + ((_1002 * 0.00105685577727854251861572265625) * _714);
                            float _1026 = _1011.w + ((((_1003 * _1011.x) + sqrt(_1006 + _1011.y)) / (_1002 + _1011.z)) * 0.4921875);
                            float _1041 = sqrt(_961 + (_962 * _969));
                            float _1042 = _636 * _969;
                            float _1048 = ((_1042 * _1042) - _696) + 40449600.0;
                            float4 _1053 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_1042 < 0.0) && (_1048 > 0.0)));
                            float _1065 = _1053.w + ((((_1042 * _1053.x) + sqrt(_1048 + _1053.y)) / (_698 + _1053.z)) * 0.4921875);
                            float _1075 = _1041 * _1041;
                            float _1077 = sqrt(_1075 - 40449600.0);
                            float _1078 = _1041 * fast::max(_969, (_1042 + _634) / _1041);
                            float _1081 = ((_1078 * _1078) - _1075) + 40449600.0;
                            float4 _1086 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_1078 < 0.0) && (_1081 > 0.0)));
                            float _1089 = _711 + ((_1077 * 0.00105685577727854251861572265625) * _714);
                            float _1101 = _1086.w + ((((_1078 * _1086.x) + sqrt(_1081 + _1086.y)) / (_1077 + _1086.z)) * 0.4921875);
                            _1116 = mix(fast::max(((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_741, _990, _716), level(0.0)) * _745) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_748, _990, _716), level(0.0)) * _739)) - (_858 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_894, _1026, _1014), level(0.0)) * _745) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_900, _1026, _1014), level(0.0)) * _739))), float4(0.0)), fast::max(((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_741, _1065, _716), level(0.0)) * _745) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_748, _1065, _716), level(0.0)) * _739)) - (_858 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_894, _1101, _1089), level(0.0)) * _745) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_900, _1101, _1089), level(0.0)) * _739))), float4(0.0)), float4((_952 + 0.004999999888241291046142578125) * 100.0));
                        }
                        else
                        {
                            _1116 = _908;
                        }
                        _1117 = _1116;
                    }
                    else
                    {
                        float4 _951;
                        if (_682 > 0.0)
                        {
                            float _917 = _636 * _660;
                            float _920 = ((_917 * _917) - _696) + 40449600.0;
                            float4 _925 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_917 < 0.0) && (_920 > 0.0)));
                            float _937 = _925.w + ((((_917 * _925.x) + sqrt(_920 + _925.y)) / (_698 + _925.z)) * 0.4921875);
                            _951 = mix(_908, (float4(1.0) - _858) * fast::max((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_741, _937, _716), level(0.0)) * _745) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_748, _937, _716), level(0.0)) * _739), float4(0.0)), float4(_682));
                        }
                        else
                        {
                            _951 = _908;
                        }
                        _1117 = _951;
                    }
                    _1118 = _1117;
                }
                else
                {
                    _1118 = (float4(1.0) - _839.xyzx) * _754;
                }
                _1119 = _1118;
            }
            else
            {
                _1119 = _754;
            }
            _1120 = _839;
            _1121 = _1119;
        }
        else
        {
            _1120 = float3(1.0);
            _1121 = _754;
        }
        _1136 = _1120;
        _1137 = fast::max((_1121.xyz * (0.0596831031143665313720703125 * _685)) + ((((_1121.xyz * (_1121.w * smoothstep(0.0, 0.0199999995529651641845703125, _647))) / float3(fast::max(_1121.x, 9.9999997473787516355514526367188e-05))) * float3(1.0, 0.429629623889923095703125, 0.17522656917572021484375)) * (((0.042971827089786529541015625 * pow(abs(1.6400001049041748046875 - (1.60000002384185791015625 * _645)), -1.5)) * _685) * 0.37878787517547607421875)), float3(0.0));
    }
    else
    {
        _1136 = float3(1.0);
        _1137 = float3(0.0);
    }
    float3 _1202;
    if ((View.View_AtmosphericFogRenderMask & 2u) == 0u)
    {
        float3 _1201;
        if (_605 > 0.0)
        {
            float3 _1148 = _571 + (_573 * _605);
            float _1149 = length(_1148);
            float3 _1151 = _1148 / float3(_1149);
            float _1152 = dot(_1151, View.View_AtmosphereLightDirection[0].xyz);
            float _1154 = (_1149 - 6360.0) * 0.014285714365541934967041015625;
            float3 _1167 = select(View_AtmosphereTransmittanceTexture.sample(View_AtmosphereTransmittanceTextureSampler, float2(atan((_1152 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt(_1154)), level(0.0)).xyz, float3(0.0), bool3(_594));
            float3 _1179 = ((_1167 * fast::max(_1152, 0.0)) + View_AtmosphereIrradianceTexture.sample(View_AtmosphereIrradianceTextureSampler, float2((_1152 + 0.20000000298023223876953125) * 0.833333313465118408203125, _1154), level(0.0)).xyz) * float3(0.0031830989755690097808837890625);
            float3 _1199;
            if ((!_594) && true)
            {
                float3 _1185 = normalize(View.View_AtmosphereLightDirection[0].xyz - _573);
                _1199 = _1179 + (_1167 * fast::max((0.0199999995529651641845703125 + (0.980000019073486328125 * pow(1.0 - dot(-_573, _1185), 5.0))) * pow(fast::max(dot(_1185, _1151), 0.0), 150.0), 0.0));
            }
            else
            {
                _1199 = _1179;
            }
            _1201 = _1136 * _1199;
        }
        else
        {
            _1201 = float3(0.0);
        }
        _1202 = _1201;
    }
    else
    {
        _1202 = float3(0.0);
    }
    float3 _1239;
    if ((View.View_AtmosphericFogRenderMask & 1u) == 0u)
    {
        float3 _1238;
        switch (0u)
        {
            default:
            {
                if (_605 > 0.0)
                {
                    _1238 = float3(0.0);
                    break;
                }
                else
                {
                    _1238 = (select(float3(1.0), View_AtmosphereTransmittanceTexture.sample(View_AtmosphereTransmittanceTextureSampler, float2(atan((_575 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt((_572 - 6360.0) * 0.014285714365541934967041015625)), level(0.0)).xyz, bool3(_572 <= 6430.0)) * step(View.View_AtmosphereLightDiscCosHalfApexAngle[0].x, dot(_573, View.View_AtmosphereLightDirection[0].xyz))) * View.View_AtmosphereLightDiscLuminance[0].xyz;
                    break;
                }
            }
        }
        _1239 = _1238;
    }
    else
    {
        _1239 = float3(0.0);
    }
    float _1259 = mix(fast::clamp((_1136.x * View.View_AtmosphericFogDensityScale) - View.View_AtmosphericFogDensityOffset, 0.0, 1.0), 1.0, 1.0 - _593);
    float4 _1263 = float4((View.View_AtmosphereLightColor[0].xyz * (View.View_AtmosphericFogSunPower * _604)) * ((_1239 + _1202) + _1137), _1259);
    float4 _1340;
    if (View.View_SkyAtmosphereApplyCameraAerialPerspectiveVolume > 0.0)
    {
        float3 _1277 = (_554 * 9.9999997473787516355514526367188e-06) - (View.View_TranslatedWorldCameraOrigin * 9.9999997473787516355514526367188e-06);
        float _1283 = sqrt((fast::max(0.0, length(_1277) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
        float _1284 = _1283 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
        float _1291;
        if (_1284 < 0.707106769084930419921875)
        {
            _1291 = fast::clamp((_1284 * _1284) * 2.0, 0.0, 1.0);
        }
        else
        {
            _1291 = 1.0;
        }
        float2 _1319;
        if (View.View_RealTimeReflectionCapture != 0.0)
        {
            float3 _1294 = normalize(_1277);
            float _1295 = _1294.z;
            float _1298 = sqrt(1.0 - (_1295 * _1295));
            float2 _1301 = _193;
            _1301.y = (_1295 * 0.5) + 0.5;
            float _1306 = acos(_1294.x / _1298);
            float2 _1311 = _1301;
            _1311.x = (((_1294.y / _1298) < 0.0) ? (6.283185482025146484375 - _1306) : _1306) * 0.15915493667125701904296875;
            _1319 = (_1311 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
        }
        else
        {
            _1319 = ((_534.xy / _534.ww) * float2(0.5, -0.5)) + float2(0.5);
        }
        float4 _1324 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_1319, _1283), level(0.0));
        float3 _1336 = _1263.xyz + (((_1324.xyz * _1291).xyz * View.View_OneOverPreExposure).xyz * _1259);
        float4 _1339 = float4(_1336.x, _1336.y, _1336.z, _191.w);
        _1339.w = _1259 * (1.0 - (_1291 * (1.0 - _1324.w)));
        _1340 = _1339;
    }
    else
    {
        _1340 = _1263;
    }
    out_var_TEXCOORD0 = _553;
    out.out_var_TEXCOORD5 = ((CurveTexture.sample(CurveTextureSampler, (EmitterUniforms.EmitterUniforms_ColorCurve.xy + (EmitterUniforms.EmitterUniforms_ColorCurve.zw * _272)), level(0.0)) * EmitterUniforms.EmitterUniforms_ColorScale) + EmitterUniforms.EmitterUniforms_ColorBias) * EmitterDynamicUniforms.EmitterDynamicUniforms_DynamicColor;
    out.out_var_TANGENTX = float4(_511, 0.0);
    out.out_var_TANGENTZ = float4(_539, float(int(sign(determinant(_540)))));
    out.out_var_TEXCOORD7 = _1340;
    out.gl_Position = _534;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

