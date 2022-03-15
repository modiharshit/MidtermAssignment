

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

vertex Main_out Main_000089ff_644b8af7(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_EmitterDynamicUniforms& EmitterDynamicUniforms [[buffer(3)]], constant type_EmitterUniforms& EmitterUniforms [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> ParticleIndices [[texture(0)]], texture2d<float> View_AtmosphereTransmittanceTexture [[texture(1)]], texture2d<float> View_AtmosphereIrradianceTexture [[texture(2)]], texture3d<float> View_AtmosphereInscatterTexture [[texture(3)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(4)]], texture2d<float> PositionTexture [[texture(5)]], texture2d<float> VelocityTexture [[texture(6)]], texture2d<float> AttributesTexture [[texture(7)]], texture2d<float> CurveTexture [[texture(8)]], sampler View_AtmosphereTransmittanceTextureSampler [[sampler(0)]], sampler View_AtmosphereIrradianceTextureSampler [[sampler(1)]], sampler View_AtmosphereInscatterTextureSampler [[sampler(2)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(3)]], sampler PositionTextureSampler [[sampler(4)]], sampler VelocityTextureSampler [[sampler(5)]], sampler AttributesTextureSampler [[sampler(6)]], sampler CurveTextureSampler [[sampler(7)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
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
    float _357 = fract(_356);
    float _358 = _356 - _357;
    float _359 = _358 + 1.0;
    float2 _375 = (float2(mod(_358, EmitterUniforms.EmitterUniforms_SubImageSize.x), floor(_358 * EmitterUniforms.EmitterUniforms_SubImageSize.z)) + _355) * EmitterUniforms.EmitterUniforms_SubImageSize.zw;
    float2 _378 = (float2(mod(_359, EmitterUniforms.EmitterUniforms_SubImageSize.x), floor(_359 * EmitterUniforms.EmitterUniforms_SubImageSize.z)) + _355) * EmitterUniforms.EmitterUniforms_SubImageSize.zw;
    float _379 = _271.w;
    float _382 = _379 * EmitterUniforms.EmitterUniforms_RotationRateScale;
    float _383 = _271.z;
    float _384 = _382 * _272;
    float _385 = _383 + _384;
    float _386 = _385 * 6.283185482025146484375;
    float3 _390 = _263.xxx;
    float3 _391 = Primitive.Primitive_LocalToWorld[0u].xyz * _390;
    float3 _395 = _263.yyy;
    float3 _396 = Primitive.Primitive_LocalToWorld[1u].xyz * _395;
    float3 _397 = _391 + _396;
    float3 _401 = _263.zzz;
    float3 _402 = Primitive.Primitive_LocalToWorld[2u].xyz * _401;
    float3 _403 = _397 + _402;
    float3 _407 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _408 = _403 + _407;
    float _409 = _408.x;
    float _410 = _408.y;
    float _411 = _408.z;
    float4 _412 = float4(_409, _410, _411, 1.0);
    float3 _413 = _412.xyz;
    float3 _416 = float3(EmitterUniforms.EmitterUniforms_RemoveHMDRoll);
    float3 _425 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _416), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.w));
    float3 _433 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _416), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.w));
    float3 _434 = View.View_TranslatedWorldCameraOrigin - _413;
    float _435 = dot(_434, _434);
    float3 _439 = _434 / float3(sqrt(fast::max(_435, 0.00999999977648258209228515625)));
    float3 _509;
    float3 _510;
    if (EmitterUniforms.EmitterUniforms_CameraFacingBlend[0] > 0.0)
    {
        float3 _497 = cross(_439, float3(0.0, 0.0, 1.0));
        float3 _502 = _497 / float3(sqrt(fast::max(dot(_497, _497), 0.00999999977648258209228515625)));
        float3 _504 = float3(fast::clamp((_435 * EmitterUniforms.EmitterUniforms_CameraFacingBlend[1]) - EmitterUniforms.EmitterUniforms_CameraFacingBlend[2], 0.0, 1.0));
        _509 = normalize(mix(_425, _502, _504));
        _510 = normalize(mix(_433, cross(_439, _502), _504));
    }
    else
    {
        float3 _488;
        float3 _489;
        if (EmitterUniforms.EmitterUniforms_TangentSelector.y > 0.0)
        {
            float3 _481 = cross(_439, _286);
            _488 = _481 / float3(sqrt(fast::max(dot(_481, _481), 0.00999999977648258209228515625)));
            _489 = -_286;
        }
        else
        {
            float3 _479;
            float3 _480;
            if (EmitterUniforms.EmitterUniforms_TangentSelector.z > 0.0)
            {
                float3 _472 = cross(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, _439);
                _479 = EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz;
                _480 = -(_472 / float3(sqrt(fast::max(dot(_472, _472), 0.00999999977648258209228515625))));
            }
            else
            {
                float3 _470;
                float3 _471;
                if (EmitterUniforms.EmitterUniforms_TangentSelector.w > 0.0)
                {
                    float3 _463 = cross(_439, float3(0.0, 0.0, 1.0));
                    float3 _468 = _463 / float3(sqrt(fast::max(dot(_463, _463), 0.00999999977648258209228515625)));
                    _470 = _468;
                    _471 = cross(_439, _468);
                }
                else
                {
                    _470 = _425;
                    _471 = _433;
                }
                _479 = _470;
                _480 = _471;
            }
            _488 = _479;
            _489 = _480;
        }
        _509 = _488;
        _510 = _489;
    }
    float _513 = _386 + EmitterUniforms.EmitterUniforms_RotationBias;
    float _514 = sin(_513);
    float _515 = cos(_513);
    float3 _516 = _510 * _514;
    float3 _517 = _509 * _515;
    float3 _518 = _516 + _517;
    float3 _519 = _510 * _515;
    float3 _520 = _509 * _514;
    float3 _521 = _519 - _520;
    float _522 = _345.x;
    float _525 = in.in_var_ATTRIBUTE0.x + EmitterUniforms.EmitterUniforms_PivotOffset.x;
    float _526 = _522 * _525;
    float3 _527 = _518 * _526;
    float _528 = _345.y;
    float _531 = in.in_var_ATTRIBUTE0.y + EmitterUniforms.EmitterUniforms_PivotOffset.y;
    float _532 = _528 * _531;
    float3 _533 = _521 * _532;
    float3 _534 = _527 + _533;
    float3 _535 = _413 + _534;
    float _536 = _535.x;
    float _537 = _535.y;
    float _538 = _535.z;
    float4 _539 = float4(_536, _537, _538, 1.0);
    float4 _540 = float4(_539.x, _539.y, _539.z, _539.w);
    float4 _541 = View.View_TranslatedWorldToClip * _540;
    float3 _543 = float3(0.0);
    _543.x = _357;
    float3 _544 = _543;
    _544.y = _272;
    float3 _545 = _544;
    _545.z = 0.0;
    float3x3 _546 = _190;
    _546[0] = _518;
    float3x3 _547 = _546;
    _547[1] = _521;
    float3 _549 = normalize(cross(_518, _521));
    float3x3 _550 = _547;
    _550[2] = _549;
    float3 _563 = _539.xyz;
    float3 _564 = _563 - View.View_TranslatedWorldCameraOrigin;
    float _568 = 9.9999997473787516355514526367188e-06 * View.View_AtmosphericFogDistanceScale;
    float3 _576 = View.View_TranslatedWorldCameraOrigin;
    _576.z = (View.View_TranslatedWorldCameraOrigin.z - View.View_AtmosphericFogGroundOffset) * View.View_AtmosphericFogAltitudeScale;
    float3 _577 = _576 * _568;
    float3 _580 = _577;
    _580.z = _577.z + 6360.009765625;
    float _581 = length(_580);
    float3 _582 = normalize(_564);
    float _583 = dot(_580, _582);
    float _584 = _583 / _581;
    float _586 = (-_581) * _584;
    float _590 = (_581 * _581) * ((_584 * _584) - 1.0);
    float _595 = length(_564) * _568;
    float _599 = fast::max(0.0, _595 - View.View_AtmosphericFogStartDistance);
    float _602 = fast::min((_599 * 0.100000001490116119384765625) / View.View_AtmosphericFogStartDistance, 1.0);
    bool _603 = _595 < (100.0 * View.View_AtmosphericFogDistanceScale);
    float _613;
    float _614;
    if (_603)
    {
        _613 = _602 * View.View_AtmosphericFogPower;
        _614 = fast::max(_595 + View.View_AtmosphericFogDistanceOffset, 1.0);
    }
    else
    {
        _613 = 1.0;
        _614 = _586 - sqrt(_590 + 40449600.0);
    }
    float _620 = _586 - sqrt(_590 + 41344900.0);
    bool _621 = _620 > 0.0;
    float _629;
    float _630;
    float3 _631;
    if (_621)
    {
        _629 = (_583 + _620) * 0.00015552098921034485101699829101562;
        _630 = _614 - _620;
        _631 = _580 + (_582 * _620);
    }
    else
    {
        _629 = _584;
        _630 = _614;
        _631 = _580;
    }
    float _632 = _621 ? 6430.0 : _581;
    bool _633 = _632 < 6360.0146484375;
    float _642;
    float _643;
    float3 _644;
    if (_633)
    {
        float _636 = 6360.0146484375 - _632;
        float3 _638 = _631 - (_582 * _636);
        _642 = dot(_638, _582) * 0.0001572323380969464778900146484375;
        _643 = _630 - _636;
        _644 = _638;
    }
    else
    {
        _642 = _629;
        _643 = _630;
        _644 = _631;
    }
    float _645 = _633 ? 6360.0146484375 : _632;
    float3 _1145;
    float3 _1146;
    if ((_645 <= 6430.0) && (_599 > 0.0))
    {
        float3 _652 = _644 + (_582 * _643);
        float _653 = length(_652);
        float _654 = dot(_582, View.View_AtmosphereLightDirection[0].xyz);
        float _656 = dot(_644, View.View_AtmosphereLightDirection[0].xyz) / _645;
        float _657 = 6360.0 / _645;
        float _660 = sqrt(1.0 - (_657 * _657));
        float _669;
        if (_603)
        {
            _669 = fast::max(_642, 0.1550000011920928955078125 - _660);
        }
        else
        {
            _669 = fast::max(_642, 0.004999999888241291046142578125 - _660);
        }
        float3 _690;
        float _691;
        float _692;
        if (_603)
        {
            float _672 = _582.z;
            float _676 = fast::clamp(exp(-_672) - 0.5, 0.0, 1.0);
            float3 _688;
            float _689;
            if (_676 < 1.0)
            {
                float3 _681 = _582;
                _681.z = fast::max(_672, 0.1500000059604644775390625);
                float3 _682 = normalize(_681);
                float3 _684 = _644 + (_682 * _643);
                _688 = _682;
                _689 = dot(_684, _682) / length(_684);
            }
            else
            {
                _688 = _582;
                _689 = _669;
            }
            _690 = _688;
            _691 = _676;
            _692 = _689;
        }
        else
        {
            _690 = _582;
            _691 = 0.0;
            _692 = _669;
        }
        float _694 = 1.0 + (_654 * _654);
        float _705 = _645 * _645;
        float _707 = sqrt(_705 - 40449600.0);
        float _708 = _645 * _692;
        float _711 = ((_708 * _708) - _705) + 40449600.0;
        float4 _716 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_708 < 0.0) && (_711 > 0.0)));
        float _719 = float(View.View_AtmosphericFogInscatterAltitudeSampleNum);
        float _720 = 0.5 / _719;
        float _723 = 1.0 - (1.0 / _719);
        float _725 = _720 + ((_707 * 0.00105685577727854251861572265625) * _723);
        float _737 = _716.w + ((((_708 * _716.x) + sqrt(_711 + _716.y)) / (_707 + _716.z)) * 0.4921875);
        float _746 = (_654 + 1.0) * 3.5;
        float _747 = floor(_746);
        float _748 = _746 - _747;
        float _749 = _747 + (0.015625 + (((atan(fast::max(_656, -0.19750000536441802978515625) * 5.349621295928955078125) * 0.90909087657928466796875) + 0.7400000095367431640625) * 0.484375));
        float _750 = _749 * 0.125;
        float _754 = 1.0 - _748;
        float _757 = (_749 + 1.0) * 0.125;
        float4 _763 = fast::max((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_750, _737, _725), level(0.0)) * _754) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_757, _737, _725), level(0.0)) * _748), float4(0.0));
        float3 _1129;
        float4 _1130;
        if (_643 > 0.0)
        {
            float2 _774 = float2(_692, _692 + (_643 / _645));
            float2 _775 = _774 * sqrt((0.5 / View.View_AtmosphericFogHeightScaleRayleigh) * _645);
            float2 _778 = float2(int2(sign(_775)));
            float2 _779 = _775 * _775;
            float _795 = 2.0 * _645;
            float _797 = (_643 / _795) + _692;
            float _805 = 6360.0 - _645;
            float2 _815 = _774 * sqrt(0.4166666567325592041015625 * _645);
            float2 _818 = float2(int2(sign(_815)));
            float2 _819 = _815 * _815;
            float3 _848 = exp((float3(-0.0057999999262392520904541015625, -0.013500000350177288055419921875, -0.033100001513957977294921875) * ((sqrt((6.283100128173828125 * View.View_AtmosphericFogHeightScaleRayleigh) * _645) * exp(_805 / View.View_AtmosphericFogHeightScaleRayleigh)) * (((_778.y > _778.x) ? exp(_779.x) : 0.0) + dot((_778 / ((abs(_775) * 2.3192999362945556640625) + sqrt((_779 * 1.519999980926513671875) + float2(4.0)))) * float2(1.0, exp(((-_643) / View.View_AtmosphericFogHeightScaleRayleigh) * _797)), float2(1.0, -1.0))))) - (float3(0.00444444455206394195556640625) * ((sqrt(7.5397205352783203125 * _645) * exp(_805 * 0.833333313465118408203125)) * (((_818.y > _818.x) ? exp(_819.x) : 0.0) + dot((_818 / ((abs(_815) * 2.3192999362945556640625) + sqrt((_819 * 1.519999980926513671875) + float2(4.0)))) * float2(1.0, exp((_643 * (-0.833333313465118408203125)) * _797)), float2(1.0, -1.0))))));
            float _856;
            if (_603)
            {
                _856 = fast::max(_653, _645);
            }
            else
            {
                _856 = _653;
            }
            float4 _1128;
            if (_856 > 6360.009765625)
            {
                float4 _1127;
                if (_691 < 1.0)
                {
                    float4 _867 = _848.xyzx;
                    float _868 = _856 * _856;
                    float _870 = sqrt(_868 - 40449600.0);
                    float _871 = _856 * (dot(_652, _690) / _653);
                    float _874 = ((_871 * _871) - _868) + 40449600.0;
                    float4 _879 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_871 < 0.0) && (_874 > 0.0)));
                    float _882 = _720 + ((_870 * 0.00105685577727854251861572265625) * _723);
                    float _894 = _879.w + ((((_871 * _879.x) + sqrt(_874 + _879.y)) / (_870 + _879.z)) * 0.4921875);
                    float _902 = _747 + (0.015625 + (((atan(fast::max(dot(_652, View.View_AtmosphereLightDirection[0].xyz) / _653, -0.19750000536441802978515625) * 5.349621295928955078125) * 0.90909087657928466796875) + 0.7400000095367431640625) * 0.484375));
                    float _903 = _902 * 0.125;
                    float _909 = (_902 + 1.0) * 0.125;
                    float4 _917 = fast::max(_763 - (_867 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_903, _894, _882), level(0.0)) * _754) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_909, _894, _882), level(0.0)) * _748))), float4(0.0));
                    float4 _1126;
                    if (!_603)
                    {
                        float _961 = _692 - (-_660);
                        float4 _1125;
                        if (abs(_961) < 0.004999999888241291046142578125)
                        {
                            float _968 = (-0.004999999888241291046142578125) - _660;
                            float _970 = _705 + (_643 * _643);
                            float _971 = _795 * _643;
                            float _974 = sqrt(_970 + (_971 * _968));
                            float _975 = _645 * _968;
                            float _978 = 0.004999999888241291046142578125 - _660;
                            float _982 = ((_975 * _975) - _705) + 40449600.0;
                            float4 _987 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_975 < 0.0) && (_982 > 0.0)));
                            float _999 = _987.w + ((((_975 * _987.x) + sqrt(_982 + _987.y)) / (_707 + _987.z)) * 0.4921875);
                            float _1009 = _974 * _974;
                            float _1011 = sqrt(_1009 - 40449600.0);
                            float _1012 = _974 * fast::max(_978, (_975 + _643) / _974);
                            float _1015 = ((_1012 * _1012) - _1009) + 40449600.0;
                            float4 _1020 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_1012 < 0.0) && (_1015 > 0.0)));
                            float _1023 = _720 + ((_1011 * 0.00105685577727854251861572265625) * _723);
                            float _1035 = _1020.w + ((((_1012 * _1020.x) + sqrt(_1015 + _1020.y)) / (_1011 + _1020.z)) * 0.4921875);
                            float _1050 = sqrt(_970 + (_971 * _978));
                            float _1051 = _645 * _978;
                            float _1057 = ((_1051 * _1051) - _705) + 40449600.0;
                            float4 _1062 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_1051 < 0.0) && (_1057 > 0.0)));
                            float _1074 = _1062.w + ((((_1051 * _1062.x) + sqrt(_1057 + _1062.y)) / (_707 + _1062.z)) * 0.4921875);
                            float _1084 = _1050 * _1050;
                            float _1086 = sqrt(_1084 - 40449600.0);
                            float _1087 = _1050 * fast::max(_978, (_1051 + _643) / _1050);
                            float _1090 = ((_1087 * _1087) - _1084) + 40449600.0;
                            float4 _1095 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_1087 < 0.0) && (_1090 > 0.0)));
                            float _1098 = _720 + ((_1086 * 0.00105685577727854251861572265625) * _723);
                            float _1110 = _1095.w + ((((_1087 * _1095.x) + sqrt(_1090 + _1095.y)) / (_1086 + _1095.z)) * 0.4921875);
                            _1125 = mix(fast::max(((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_750, _999, _725), level(0.0)) * _754) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_757, _999, _725), level(0.0)) * _748)) - (_867 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_903, _1035, _1023), level(0.0)) * _754) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_909, _1035, _1023), level(0.0)) * _748))), float4(0.0)), fast::max(((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_750, _1074, _725), level(0.0)) * _754) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_757, _1074, _725), level(0.0)) * _748)) - (_867 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_903, _1110, _1098), level(0.0)) * _754) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_909, _1110, _1098), level(0.0)) * _748))), float4(0.0)), float4((_961 + 0.004999999888241291046142578125) * 100.0));
                        }
                        else
                        {
                            _1125 = _917;
                        }
                        _1126 = _1125;
                    }
                    else
                    {
                        float4 _960;
                        if (_691 > 0.0)
                        {
                            float _926 = _645 * _669;
                            float _929 = ((_926 * _926) - _705) + 40449600.0;
                            float4 _934 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_926 < 0.0) && (_929 > 0.0)));
                            float _946 = _934.w + ((((_926 * _934.x) + sqrt(_929 + _934.y)) / (_707 + _934.z)) * 0.4921875);
                            _960 = mix(_917, (float4(1.0) - _867) * fast::max((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_750, _946, _725), level(0.0)) * _754) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_757, _946, _725), level(0.0)) * _748), float4(0.0)), float4(_691));
                        }
                        else
                        {
                            _960 = _917;
                        }
                        _1126 = _960;
                    }
                    _1127 = _1126;
                }
                else
                {
                    _1127 = (float4(1.0) - _848.xyzx) * _763;
                }
                _1128 = _1127;
            }
            else
            {
                _1128 = _763;
            }
            _1129 = _848;
            _1130 = _1128;
        }
        else
        {
            _1129 = float3(1.0);
            _1130 = _763;
        }
        _1145 = _1129;
        _1146 = fast::max((_1130.xyz * (0.0596831031143665313720703125 * _694)) + ((((_1130.xyz * (_1130.w * smoothstep(0.0, 0.0199999995529651641845703125, _656))) / float3(fast::max(_1130.x, 9.9999997473787516355514526367188e-05))) * float3(1.0, 0.429629623889923095703125, 0.17522656917572021484375)) * (((0.042971827089786529541015625 * pow(abs(1.6400001049041748046875 - (1.60000002384185791015625 * _654)), -1.5)) * _694) * 0.37878787517547607421875)), float3(0.0));
    }
    else
    {
        _1145 = float3(1.0);
        _1146 = float3(0.0);
    }
    float3 _1211;
    if ((View.View_AtmosphericFogRenderMask & 2u) == 0u)
    {
        float3 _1210;
        if (_614 > 0.0)
        {
            float3 _1157 = _580 + (_582 * _614);
            float _1158 = length(_1157);
            float3 _1160 = _1157 / float3(_1158);
            float _1161 = dot(_1160, View.View_AtmosphereLightDirection[0].xyz);
            float _1163 = (_1158 - 6360.0) * 0.014285714365541934967041015625;
            float3 _1176 = select(View_AtmosphereTransmittanceTexture.sample(View_AtmosphereTransmittanceTextureSampler, float2(atan((_1161 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt(_1163)), level(0.0)).xyz, float3(0.0), bool3(_603));
            float3 _1188 = ((_1176 * fast::max(_1161, 0.0)) + View_AtmosphereIrradianceTexture.sample(View_AtmosphereIrradianceTextureSampler, float2((_1161 + 0.20000000298023223876953125) * 0.833333313465118408203125, _1163), level(0.0)).xyz) * float3(0.0031830989755690097808837890625);
            float3 _1208;
            if ((!_603) && true)
            {
                float3 _1194 = normalize(View.View_AtmosphereLightDirection[0].xyz - _582);
                _1208 = _1188 + (_1176 * fast::max((0.0199999995529651641845703125 + (0.980000019073486328125 * pow(1.0 - dot(-_582, _1194), 5.0))) * pow(fast::max(dot(_1194, _1160), 0.0), 150.0), 0.0));
            }
            else
            {
                _1208 = _1188;
            }
            _1210 = _1145 * _1208;
        }
        else
        {
            _1210 = float3(0.0);
        }
        _1211 = _1210;
    }
    else
    {
        _1211 = float3(0.0);
    }
    float3 _1248;
    if ((View.View_AtmosphericFogRenderMask & 1u) == 0u)
    {
        float3 _1247;
        switch (0u)
        {
            default:
            {
                if (_614 > 0.0)
                {
                    _1247 = float3(0.0);
                    break;
                }
                else
                {
                    _1247 = (select(float3(1.0), View_AtmosphereTransmittanceTexture.sample(View_AtmosphereTransmittanceTextureSampler, float2(atan((_584 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt((_581 - 6360.0) * 0.014285714365541934967041015625)), level(0.0)).xyz, bool3(_581 <= 6430.0)) * step(View.View_AtmosphereLightDiscCosHalfApexAngle[0].x, dot(_582, View.View_AtmosphereLightDirection[0].xyz))) * View.View_AtmosphereLightDiscLuminance[0].xyz;
                    break;
                }
            }
        }
        _1248 = _1247;
    }
    else
    {
        _1248 = float3(0.0);
    }
    float _1268 = mix(fast::clamp((_1145.x * View.View_AtmosphericFogDensityScale) - View.View_AtmosphericFogDensityOffset, 0.0, 1.0), 1.0, 1.0 - _602);
    float4 _1272 = float4((View.View_AtmosphereLightColor[0].xyz * (View.View_AtmosphericFogSunPower * _613)) * ((_1248 + _1211) + _1146), _1268);
    float4 _1349;
    if (View.View_SkyAtmosphereApplyCameraAerialPerspectiveVolume > 0.0)
    {
        float3 _1286 = (_563 * 9.9999997473787516355514526367188e-06) - (View.View_TranslatedWorldCameraOrigin * 9.9999997473787516355514526367188e-06);
        float _1292 = sqrt((fast::max(0.0, length(_1286) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
        float _1293 = _1292 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
        float _1300;
        if (_1293 < 0.707106769084930419921875)
        {
            _1300 = fast::clamp((_1293 * _1293) * 2.0, 0.0, 1.0);
        }
        else
        {
            _1300 = 1.0;
        }
        float2 _1328;
        if (View.View_RealTimeReflectionCapture != 0.0)
        {
            float3 _1303 = normalize(_1286);
            float _1304 = _1303.z;
            float _1307 = sqrt(1.0 - (_1304 * _1304));
            float2 _1310 = _193;
            _1310.y = (_1304 * 0.5) + 0.5;
            float _1315 = acos(_1303.x / _1307);
            float2 _1320 = _1310;
            _1320.x = (((_1303.y / _1307) < 0.0) ? (6.283185482025146484375 - _1315) : _1315) * 0.15915493667125701904296875;
            _1328 = (_1320 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
        }
        else
        {
            _1328 = ((_541.xy / _541.ww) * float2(0.5, -0.5)) + float2(0.5);
        }
        float4 _1333 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_1328, _1292), level(0.0));
        float3 _1345 = _1272.xyz + (((_1333.xyz * _1300).xyz * View.View_OneOverPreExposure).xyz * _1268);
        float4 _1348 = float4(_1345.x, _1345.y, _1345.z, _191.w);
        _1348.w = _1268 * (1.0 - (_1300 * (1.0 - _1333.w)));
        _1349 = _1348;
    }
    else
    {
        _1349 = _1272;
    }
    out.out_var_PARTICLE_SUBUVS = float4(_375.x, _375.y, _378.x, _378.y);
    out.out_var_TEXCOORD4 = _545;
    out.out_var_TEXCOORD5 = ((CurveTexture.sample(CurveTextureSampler, (EmitterUniforms.EmitterUniforms_ColorCurve.xy + (EmitterUniforms.EmitterUniforms_ColorCurve.zw * _272)), level(0.0)) * EmitterUniforms.EmitterUniforms_ColorScale) + EmitterUniforms.EmitterUniforms_ColorBias) * EmitterDynamicUniforms.EmitterDynamicUniforms_DynamicColor;
    out.out_var_TANGENTX = float4(_518, 0.0);
    out.out_var_TANGENTZ = float4(_549, float(int(sign(determinant(_550)))));
    out.out_var_TEXCOORD7 = _1349;
    out.gl_Position = _541;
    return out;
}

