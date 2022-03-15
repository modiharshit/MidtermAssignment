

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
    char _m8_pad[224];
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeInvSize;
    char _m9_pad[92];
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
    char _m21_pad[32];
    spvUnsafeArray<float4, 2> View_AtmosphereLightDiscLuminance;
    spvUnsafeArray<float4, 2> View_AtmosphereLightDiscCosHalfApexAngle;
    char _m23_pad[144];
    float4 View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize;
    float View_SkyAtmosphereAerialPerspectiveStartDepthKm;
    float View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
    float View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv;
    char _m27_pad[4];
    float View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv;
    float View_SkyAtmosphereApplyCameraAerialPerspectiveVolume;
    uint View_AtmosphericFogRenderMask;
    uint View_AtmosphericFogInscatterAltitudeSampleNum;
    char _m31_pad[16];
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

constant float3x3 _196 = {};
constant float4 _197 = {};
constant float2 _199 = {};

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

vertex Main_out Main_00008b9d_3122eae3(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_EmitterDynamicUniforms& EmitterDynamicUniforms [[buffer(3)]], constant type_EmitterUniforms& EmitterUniforms [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> ParticleIndices [[texture(0)]], texture2d<float> View_AtmosphereTransmittanceTexture [[texture(1)]], texture2d<float> View_AtmosphereIrradianceTexture [[texture(2)]], texture3d<float> View_AtmosphereInscatterTexture [[texture(3)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(4)]], texture2d<float> PositionTexture [[texture(5)]], texture2d<float> VelocityTexture [[texture(6)]], texture2d<float> AttributesTexture [[texture(7)]], texture2d<float> CurveTexture [[texture(8)]], sampler View_AtmosphereTransmittanceTextureSampler [[sampler(0)]], sampler View_AtmosphereIrradianceTextureSampler [[sampler(1)]], sampler View_AtmosphereInscatterTextureSampler [[sampler(2)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(3)]], sampler PositionTextureSampler [[sampler(4)]], sampler VelocityTextureSampler [[sampler(5)]], sampler AttributesTextureSampler [[sampler(6)]], sampler CurveTextureSampler [[sampler(7)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    uint _258 = (gl_InstanceIndex - gl_BaseInstance) * 16u;
    uint _259 = (gl_VertexIndex - gl_BaseVertex) / 4u;
    uint _260 = _258 + _259;
    uint _263 = _Globals.ParticleIndicesOffset + _260;
    float4 _265 = ParticleIndices.read(uint(_263));
    float2 _266 = _265.xy;
    float4 _270 = PositionTexture.sample(PositionTextureSampler, _266, level(0.0));
    float4 _274 = VelocityTexture.sample(VelocityTextureSampler, _266, level(0.0));
    float4 _278 = AttributesTexture.sample(AttributesTextureSampler, _266, level(0.0));
    float _279 = _270.w;
    float _280 = step(_279, 1.0);
    float3 _281 = _274.xyz;
    float3x3 _290 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    float3 _291 = _290 * _281;
    float3 _293 = normalize(_291 + float3(0.0, 0.0, 9.9999997473787516355514526367188e-05));
    float _294 = length(_291);
    float2 _318 = EmitterUniforms.EmitterUniforms_MiscCurve.zw * _279;
    float2 _319 = EmitterUniforms.EmitterUniforms_MiscCurve.xy + _318;
    float4 _321 = CurveTexture.sample(CurveTextureSampler, _319, level(0.0));
    float4 _324 = _321 * EmitterUniforms.EmitterUniforms_MiscScale;
    float4 _327 = _324 + EmitterUniforms.EmitterUniforms_MiscBias;
    float _328 = _278.x;
    bool _329 = _328 < 0.5;
    float _330 = _329 ? 0.0 : (-0.5);
    float _331 = _278.y;
    bool _332 = _331 < 0.5;
    float _333 = _332 ? 0.0 : (-0.5);
    float2 _334 = float2(_330, _333);
    float2 _335 = _278.xy;
    float2 _336 = _335 + _334;
    float2 _337 = _336 * float2(2.0);
    float2 _338 = _327.xy;
    float2 _341 = _338 * EmitterDynamicUniforms.EmitterDynamicUniforms_LocalToWorldScale;
    float2 _345 = EmitterUniforms.EmitterUniforms_SizeBySpeed.xy * _294;
    float2 _346 = fast::max(_345, float2(1.0));
    float2 _348 = fast::min(_346, EmitterUniforms.EmitterUniforms_SizeBySpeed.zw);
    float2 _349 = _337 * _341;
    float2 _350 = _349 * _348;
    float2 _351 = float2(_280);
    float2 _352 = _350 * _351;
    float2 _357 = _199;
    _357.x = (_330 == 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.x) : in.in_var_ATTRIBUTE0.x;
    float2 _362 = _357;
    _362.y = (_333 == 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.y) : in.in_var_ATTRIBUTE0.y;
    float _363 = _327.z;
    float _364 = fract(_363);
    float _365 = _363 - _364;
    float _366 = _365 + 1.0;
    float2 _382 = (float2(mod(_365, EmitterUniforms.EmitterUniforms_SubImageSize.x), floor(_365 * EmitterUniforms.EmitterUniforms_SubImageSize.z)) + _362) * EmitterUniforms.EmitterUniforms_SubImageSize.zw;
    float2 _385 = (float2(mod(_366, EmitterUniforms.EmitterUniforms_SubImageSize.x), floor(_366 * EmitterUniforms.EmitterUniforms_SubImageSize.z)) + _362) * EmitterUniforms.EmitterUniforms_SubImageSize.zw;
    float _386 = _278.w;
    float _389 = _386 * EmitterUniforms.EmitterUniforms_RotationRateScale;
    float _390 = _278.z;
    float _391 = _389 * _279;
    float _392 = _390 + _391;
    float _393 = _392 * 6.283185482025146484375;
    float3 _397 = _270.xxx;
    float3 _398 = Primitive.Primitive_LocalToWorld[0u].xyz * _397;
    float3 _402 = _270.yyy;
    float3 _403 = Primitive.Primitive_LocalToWorld[1u].xyz * _402;
    float3 _404 = _398 + _403;
    float3 _408 = _270.zzz;
    float3 _409 = Primitive.Primitive_LocalToWorld[2u].xyz * _408;
    float3 _410 = _404 + _409;
    float3 _414 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _415 = _410 + _414;
    float _416 = _415.x;
    float _417 = _415.y;
    float _418 = _415.z;
    float4 _419 = float4(_416, _417, _418, 1.0);
    float3 _420 = _419.xyz;
    float3 _423 = float3(EmitterUniforms.EmitterUniforms_RemoveHMDRoll);
    float3 _432 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _423), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.w));
    float3 _440 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _423), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.w));
    float3 _441 = View.View_TranslatedWorldCameraOrigin - _420;
    float _442 = dot(_441, _441);
    float3 _446 = _441 / float3(sqrt(fast::max(_442, 0.00999999977648258209228515625)));
    float3 _516;
    float3 _517;
    if (EmitterUniforms.EmitterUniforms_CameraFacingBlend[0] > 0.0)
    {
        float3 _504 = cross(_446, float3(0.0, 0.0, 1.0));
        float3 _509 = _504 / float3(sqrt(fast::max(dot(_504, _504), 0.00999999977648258209228515625)));
        float3 _511 = float3(fast::clamp((_442 * EmitterUniforms.EmitterUniforms_CameraFacingBlend[1]) - EmitterUniforms.EmitterUniforms_CameraFacingBlend[2], 0.0, 1.0));
        _516 = normalize(mix(_432, _509, _511));
        _517 = normalize(mix(_440, cross(_446, _509), _511));
    }
    else
    {
        float3 _495;
        float3 _496;
        if (EmitterUniforms.EmitterUniforms_TangentSelector.y > 0.0)
        {
            float3 _488 = cross(_446, _293);
            _495 = _488 / float3(sqrt(fast::max(dot(_488, _488), 0.00999999977648258209228515625)));
            _496 = -_293;
        }
        else
        {
            float3 _486;
            float3 _487;
            if (EmitterUniforms.EmitterUniforms_TangentSelector.z > 0.0)
            {
                float3 _479 = cross(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, _446);
                _486 = EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz;
                _487 = -(_479 / float3(sqrt(fast::max(dot(_479, _479), 0.00999999977648258209228515625))));
            }
            else
            {
                float3 _477;
                float3 _478;
                if (EmitterUniforms.EmitterUniforms_TangentSelector.w > 0.0)
                {
                    float3 _470 = cross(_446, float3(0.0, 0.0, 1.0));
                    float3 _475 = _470 / float3(sqrt(fast::max(dot(_470, _470), 0.00999999977648258209228515625)));
                    _477 = _475;
                    _478 = cross(_446, _475);
                }
                else
                {
                    _477 = _432;
                    _478 = _440;
                }
                _486 = _477;
                _487 = _478;
            }
            _495 = _486;
            _496 = _487;
        }
        _516 = _495;
        _517 = _496;
    }
    float _520 = _393 + EmitterUniforms.EmitterUniforms_RotationBias;
    float _521 = sin(_520);
    float _522 = cos(_520);
    float3 _523 = _517 * _521;
    float3 _524 = _516 * _522;
    float3 _525 = _523 + _524;
    float3 _526 = _517 * _522;
    float3 _527 = _516 * _521;
    float3 _528 = _526 - _527;
    float _529 = _352.x;
    float _532 = in.in_var_ATTRIBUTE0.x + EmitterUniforms.EmitterUniforms_PivotOffset.x;
    float _533 = _529 * _532;
    float3 _534 = _525 * _533;
    float _535 = _352.y;
    float _538 = in.in_var_ATTRIBUTE0.y + EmitterUniforms.EmitterUniforms_PivotOffset.y;
    float _539 = _535 * _538;
    float3 _540 = _528 * _539;
    float3 _541 = _534 + _540;
    float3 _542 = _420 + _541;
    float _556 = _542.x;
    float _557 = _542.y;
    float _558 = _542.z;
    float4 _559 = float4(_556, _557, _558, 1.0);
    float4 _560 = float4(_559.x, _559.y, _559.z, _559.w);
    float4 _561 = View.View_TranslatedWorldToClip * _560;
    float3 _563 = float3(0.0);
    _563.x = _364;
    float3 _564 = _563;
    _564.y = _279;
    float3 _565 = _564;
    _565.z = 0.0;
    float3x3 _566 = _196;
    _566[0] = _525;
    float3x3 _567 = _566;
    _567[1] = _528;
    float3 _569 = normalize(cross(_525, _528));
    float3x3 _570 = _567;
    _570[2] = _569;
    float3 _583 = _559.xyz;
    float3 _584 = _583 - View.View_TranslatedWorldCameraOrigin;
    float _588 = 9.9999997473787516355514526367188e-06 * View.View_AtmosphericFogDistanceScale;
    float3 _596 = View.View_TranslatedWorldCameraOrigin;
    _596.z = (View.View_TranslatedWorldCameraOrigin.z - View.View_AtmosphericFogGroundOffset) * View.View_AtmosphericFogAltitudeScale;
    float3 _597 = _596 * _588;
    float3 _600 = _597;
    _600.z = _597.z + 6360.009765625;
    float _601 = length(_600);
    float3 _602 = normalize(_584);
    float _603 = dot(_600, _602);
    float _604 = _603 / _601;
    float _606 = (-_601) * _604;
    float _610 = (_601 * _601) * ((_604 * _604) - 1.0);
    float _615 = length(_584) * _588;
    float _619 = fast::max(0.0, _615 - View.View_AtmosphericFogStartDistance);
    float _622 = fast::min((_619 * 0.100000001490116119384765625) / View.View_AtmosphericFogStartDistance, 1.0);
    bool _623 = _615 < (100.0 * View.View_AtmosphericFogDistanceScale);
    float _633;
    float _634;
    if (_623)
    {
        _633 = _622 * View.View_AtmosphericFogPower;
        _634 = fast::max(_615 + View.View_AtmosphericFogDistanceOffset, 1.0);
    }
    else
    {
        _633 = 1.0;
        _634 = _606 - sqrt(_610 + 40449600.0);
    }
    float _640 = _606 - sqrt(_610 + 41344900.0);
    bool _641 = _640 > 0.0;
    float _649;
    float _650;
    float3 _651;
    if (_641)
    {
        _649 = (_603 + _640) * 0.00015552098921034485101699829101562;
        _650 = _634 - _640;
        _651 = _600 + (_602 * _640);
    }
    else
    {
        _649 = _604;
        _650 = _634;
        _651 = _600;
    }
    float _652 = _641 ? 6430.0 : _601;
    bool _653 = _652 < 6360.0146484375;
    float _662;
    float _663;
    float3 _664;
    if (_653)
    {
        float _656 = 6360.0146484375 - _652;
        float3 _658 = _651 - (_602 * _656);
        _662 = dot(_658, _602) * 0.0001572323380969464778900146484375;
        _663 = _650 - _656;
        _664 = _658;
    }
    else
    {
        _662 = _649;
        _663 = _650;
        _664 = _651;
    }
    float _665 = _653 ? 6360.0146484375 : _652;
    float3 _1165;
    float3 _1166;
    if ((_665 <= 6430.0) && (_619 > 0.0))
    {
        float3 _672 = _664 + (_602 * _663);
        float _673 = length(_672);
        float _674 = dot(_602, View.View_AtmosphereLightDirection[0].xyz);
        float _676 = dot(_664, View.View_AtmosphereLightDirection[0].xyz) / _665;
        float _677 = 6360.0 / _665;
        float _680 = sqrt(1.0 - (_677 * _677));
        float _689;
        if (_623)
        {
            _689 = fast::max(_662, 0.1550000011920928955078125 - _680);
        }
        else
        {
            _689 = fast::max(_662, 0.004999999888241291046142578125 - _680);
        }
        float3 _710;
        float _711;
        float _712;
        if (_623)
        {
            float _692 = _602.z;
            float _696 = fast::clamp(exp(-_692) - 0.5, 0.0, 1.0);
            float3 _708;
            float _709;
            if (_696 < 1.0)
            {
                float3 _701 = _602;
                _701.z = fast::max(_692, 0.1500000059604644775390625);
                float3 _702 = normalize(_701);
                float3 _704 = _664 + (_702 * _663);
                _708 = _702;
                _709 = dot(_704, _702) / length(_704);
            }
            else
            {
                _708 = _602;
                _709 = _689;
            }
            _710 = _708;
            _711 = _696;
            _712 = _709;
        }
        else
        {
            _710 = _602;
            _711 = 0.0;
            _712 = _689;
        }
        float _714 = 1.0 + (_674 * _674);
        float _725 = _665 * _665;
        float _727 = sqrt(_725 - 40449600.0);
        float _728 = _665 * _712;
        float _731 = ((_728 * _728) - _725) + 40449600.0;
        float4 _736 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_728 < 0.0) && (_731 > 0.0)));
        float _739 = float(View.View_AtmosphericFogInscatterAltitudeSampleNum);
        float _740 = 0.5 / _739;
        float _743 = 1.0 - (1.0 / _739);
        float _745 = _740 + ((_727 * 0.00105685577727854251861572265625) * _743);
        float _757 = _736.w + ((((_728 * _736.x) + sqrt(_731 + _736.y)) / (_727 + _736.z)) * 0.4921875);
        float _766 = (_674 + 1.0) * 3.5;
        float _767 = floor(_766);
        float _768 = _766 - _767;
        float _769 = _767 + (0.015625 + (((atan(fast::max(_676, -0.19750000536441802978515625) * 5.349621295928955078125) * 0.90909087657928466796875) + 0.7400000095367431640625) * 0.484375));
        float _770 = _769 * 0.125;
        float _774 = 1.0 - _768;
        float _777 = (_769 + 1.0) * 0.125;
        float4 _783 = fast::max((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_770, _757, _745), level(0.0)) * _774) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_777, _757, _745), level(0.0)) * _768), float4(0.0));
        float3 _1149;
        float4 _1150;
        if (_663 > 0.0)
        {
            float2 _794 = float2(_712, _712 + (_663 / _665));
            float2 _795 = _794 * sqrt((0.5 / View.View_AtmosphericFogHeightScaleRayleigh) * _665);
            float2 _798 = float2(int2(sign(_795)));
            float2 _799 = _795 * _795;
            float _815 = 2.0 * _665;
            float _817 = (_663 / _815) + _712;
            float _825 = 6360.0 - _665;
            float2 _835 = _794 * sqrt(0.4166666567325592041015625 * _665);
            float2 _838 = float2(int2(sign(_835)));
            float2 _839 = _835 * _835;
            float3 _868 = exp((float3(-0.0057999999262392520904541015625, -0.013500000350177288055419921875, -0.033100001513957977294921875) * ((sqrt((6.283100128173828125 * View.View_AtmosphericFogHeightScaleRayleigh) * _665) * exp(_825 / View.View_AtmosphericFogHeightScaleRayleigh)) * (((_798.y > _798.x) ? exp(_799.x) : 0.0) + dot((_798 / ((abs(_795) * 2.3192999362945556640625) + sqrt((_799 * 1.519999980926513671875) + float2(4.0)))) * float2(1.0, exp(((-_663) / View.View_AtmosphericFogHeightScaleRayleigh) * _817)), float2(1.0, -1.0))))) - (float3(0.00444444455206394195556640625) * ((sqrt(7.5397205352783203125 * _665) * exp(_825 * 0.833333313465118408203125)) * (((_838.y > _838.x) ? exp(_839.x) : 0.0) + dot((_838 / ((abs(_835) * 2.3192999362945556640625) + sqrt((_839 * 1.519999980926513671875) + float2(4.0)))) * float2(1.0, exp((_663 * (-0.833333313465118408203125)) * _817)), float2(1.0, -1.0))))));
            float _876;
            if (_623)
            {
                _876 = fast::max(_673, _665);
            }
            else
            {
                _876 = _673;
            }
            float4 _1148;
            if (_876 > 6360.009765625)
            {
                float4 _1147;
                if (_711 < 1.0)
                {
                    float4 _887 = _868.xyzx;
                    float _888 = _876 * _876;
                    float _890 = sqrt(_888 - 40449600.0);
                    float _891 = _876 * (dot(_672, _710) / _673);
                    float _894 = ((_891 * _891) - _888) + 40449600.0;
                    float4 _899 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_891 < 0.0) && (_894 > 0.0)));
                    float _902 = _740 + ((_890 * 0.00105685577727854251861572265625) * _743);
                    float _914 = _899.w + ((((_891 * _899.x) + sqrt(_894 + _899.y)) / (_890 + _899.z)) * 0.4921875);
                    float _922 = _767 + (0.015625 + (((atan(fast::max(dot(_672, View.View_AtmosphereLightDirection[0].xyz) / _673, -0.19750000536441802978515625) * 5.349621295928955078125) * 0.90909087657928466796875) + 0.7400000095367431640625) * 0.484375));
                    float _923 = _922 * 0.125;
                    float _929 = (_922 + 1.0) * 0.125;
                    float4 _937 = fast::max(_783 - (_887 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_923, _914, _902), level(0.0)) * _774) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_929, _914, _902), level(0.0)) * _768))), float4(0.0));
                    float4 _1146;
                    if (!_623)
                    {
                        float _981 = _712 - (-_680);
                        float4 _1145;
                        if (abs(_981) < 0.004999999888241291046142578125)
                        {
                            float _988 = (-0.004999999888241291046142578125) - _680;
                            float _990 = _725 + (_663 * _663);
                            float _991 = _815 * _663;
                            float _994 = sqrt(_990 + (_991 * _988));
                            float _995 = _665 * _988;
                            float _998 = 0.004999999888241291046142578125 - _680;
                            float _1002 = ((_995 * _995) - _725) + 40449600.0;
                            float4 _1007 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_995 < 0.0) && (_1002 > 0.0)));
                            float _1019 = _1007.w + ((((_995 * _1007.x) + sqrt(_1002 + _1007.y)) / (_727 + _1007.z)) * 0.4921875);
                            float _1029 = _994 * _994;
                            float _1031 = sqrt(_1029 - 40449600.0);
                            float _1032 = _994 * fast::max(_998, (_995 + _663) / _994);
                            float _1035 = ((_1032 * _1032) - _1029) + 40449600.0;
                            float4 _1040 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_1032 < 0.0) && (_1035 > 0.0)));
                            float _1043 = _740 + ((_1031 * 0.00105685577727854251861572265625) * _743);
                            float _1055 = _1040.w + ((((_1032 * _1040.x) + sqrt(_1035 + _1040.y)) / (_1031 + _1040.z)) * 0.4921875);
                            float _1070 = sqrt(_990 + (_991 * _998));
                            float _1071 = _665 * _998;
                            float _1077 = ((_1071 * _1071) - _725) + 40449600.0;
                            float4 _1082 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_1071 < 0.0) && (_1077 > 0.0)));
                            float _1094 = _1082.w + ((((_1071 * _1082.x) + sqrt(_1077 + _1082.y)) / (_727 + _1082.z)) * 0.4921875);
                            float _1104 = _1070 * _1070;
                            float _1106 = sqrt(_1104 - 40449600.0);
                            float _1107 = _1070 * fast::max(_998, (_1071 + _663) / _1070);
                            float _1110 = ((_1107 * _1107) - _1104) + 40449600.0;
                            float4 _1115 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_1107 < 0.0) && (_1110 > 0.0)));
                            float _1118 = _740 + ((_1106 * 0.00105685577727854251861572265625) * _743);
                            float _1130 = _1115.w + ((((_1107 * _1115.x) + sqrt(_1110 + _1115.y)) / (_1106 + _1115.z)) * 0.4921875);
                            _1145 = mix(fast::max(((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_770, _1019, _745), level(0.0)) * _774) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_777, _1019, _745), level(0.0)) * _768)) - (_887 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_923, _1055, _1043), level(0.0)) * _774) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_929, _1055, _1043), level(0.0)) * _768))), float4(0.0)), fast::max(((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_770, _1094, _745), level(0.0)) * _774) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_777, _1094, _745), level(0.0)) * _768)) - (_887 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_923, _1130, _1118), level(0.0)) * _774) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_929, _1130, _1118), level(0.0)) * _768))), float4(0.0)), float4((_981 + 0.004999999888241291046142578125) * 100.0));
                        }
                        else
                        {
                            _1145 = _937;
                        }
                        _1146 = _1145;
                    }
                    else
                    {
                        float4 _980;
                        if (_711 > 0.0)
                        {
                            float _946 = _665 * _689;
                            float _949 = ((_946 * _946) - _725) + 40449600.0;
                            float4 _954 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_946 < 0.0) && (_949 > 0.0)));
                            float _966 = _954.w + ((((_946 * _954.x) + sqrt(_949 + _954.y)) / (_727 + _954.z)) * 0.4921875);
                            _980 = mix(_937, (float4(1.0) - _887) * fast::max((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_770, _966, _745), level(0.0)) * _774) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_777, _966, _745), level(0.0)) * _768), float4(0.0)), float4(_711));
                        }
                        else
                        {
                            _980 = _937;
                        }
                        _1146 = _980;
                    }
                    _1147 = _1146;
                }
                else
                {
                    _1147 = (float4(1.0) - _868.xyzx) * _783;
                }
                _1148 = _1147;
            }
            else
            {
                _1148 = _783;
            }
            _1149 = _868;
            _1150 = _1148;
        }
        else
        {
            _1149 = float3(1.0);
            _1150 = _783;
        }
        _1165 = _1149;
        _1166 = fast::max((_1150.xyz * (0.0596831031143665313720703125 * _714)) + ((((_1150.xyz * (_1150.w * smoothstep(0.0, 0.0199999995529651641845703125, _676))) / float3(fast::max(_1150.x, 9.9999997473787516355514526367188e-05))) * float3(1.0, 0.429629623889923095703125, 0.17522656917572021484375)) * (((0.042971827089786529541015625 * pow(abs(1.6400001049041748046875 - (1.60000002384185791015625 * _674)), -1.5)) * _714) * 0.37878787517547607421875)), float3(0.0));
    }
    else
    {
        _1165 = float3(1.0);
        _1166 = float3(0.0);
    }
    float3 _1231;
    if ((View.View_AtmosphericFogRenderMask & 2u) == 0u)
    {
        float3 _1230;
        if (_634 > 0.0)
        {
            float3 _1177 = _600 + (_602 * _634);
            float _1178 = length(_1177);
            float3 _1180 = _1177 / float3(_1178);
            float _1181 = dot(_1180, View.View_AtmosphereLightDirection[0].xyz);
            float _1183 = (_1178 - 6360.0) * 0.014285714365541934967041015625;
            float3 _1196 = select(View_AtmosphereTransmittanceTexture.sample(View_AtmosphereTransmittanceTextureSampler, float2(atan((_1181 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt(_1183)), level(0.0)).xyz, float3(0.0), bool3(_623));
            float3 _1208 = ((_1196 * fast::max(_1181, 0.0)) + View_AtmosphereIrradianceTexture.sample(View_AtmosphereIrradianceTextureSampler, float2((_1181 + 0.20000000298023223876953125) * 0.833333313465118408203125, _1183), level(0.0)).xyz) * float3(0.0031830989755690097808837890625);
            float3 _1228;
            if ((!_623) && true)
            {
                float3 _1214 = normalize(View.View_AtmosphereLightDirection[0].xyz - _602);
                _1228 = _1208 + (_1196 * fast::max((0.0199999995529651641845703125 + (0.980000019073486328125 * pow(1.0 - dot(-_602, _1214), 5.0))) * pow(fast::max(dot(_1214, _1180), 0.0), 150.0), 0.0));
            }
            else
            {
                _1228 = _1208;
            }
            _1230 = _1165 * _1228;
        }
        else
        {
            _1230 = float3(0.0);
        }
        _1231 = _1230;
    }
    else
    {
        _1231 = float3(0.0);
    }
    float3 _1268;
    if ((View.View_AtmosphericFogRenderMask & 1u) == 0u)
    {
        float3 _1267;
        switch (0u)
        {
            default:
            {
                if (_634 > 0.0)
                {
                    _1267 = float3(0.0);
                    break;
                }
                else
                {
                    _1267 = (select(float3(1.0), View_AtmosphereTransmittanceTexture.sample(View_AtmosphereTransmittanceTextureSampler, float2(atan((_604 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt((_601 - 6360.0) * 0.014285714365541934967041015625)), level(0.0)).xyz, bool3(_601 <= 6430.0)) * step(View.View_AtmosphereLightDiscCosHalfApexAngle[0].x, dot(_602, View.View_AtmosphereLightDirection[0].xyz))) * View.View_AtmosphereLightDiscLuminance[0].xyz;
                    break;
                }
            }
        }
        _1268 = _1267;
    }
    else
    {
        _1268 = float3(0.0);
    }
    float _1288 = mix(fast::clamp((_1165.x * View.View_AtmosphericFogDensityScale) - View.View_AtmosphericFogDensityOffset, 0.0, 1.0), 1.0, 1.0 - _622);
    float4 _1292 = float4((View.View_AtmosphereLightColor[0].xyz * (View.View_AtmosphericFogSunPower * _633)) * ((_1268 + _1231) + _1166), _1288);
    float4 _1369;
    if (View.View_SkyAtmosphereApplyCameraAerialPerspectiveVolume > 0.0)
    {
        float3 _1306 = (_583 * 9.9999997473787516355514526367188e-06) - (View.View_TranslatedWorldCameraOrigin * 9.9999997473787516355514526367188e-06);
        float _1312 = sqrt((fast::max(0.0, length(_1306) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
        float _1313 = _1312 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
        float _1320;
        if (_1313 < 0.707106769084930419921875)
        {
            _1320 = fast::clamp((_1313 * _1313) * 2.0, 0.0, 1.0);
        }
        else
        {
            _1320 = 1.0;
        }
        float2 _1348;
        if (View.View_RealTimeReflectionCapture != 0.0)
        {
            float3 _1323 = normalize(_1306);
            float _1324 = _1323.z;
            float _1327 = sqrt(1.0 - (_1324 * _1324));
            float2 _1330 = _199;
            _1330.y = (_1324 * 0.5) + 0.5;
            float _1335 = acos(_1323.x / _1327);
            float2 _1340 = _1330;
            _1340.x = (((_1323.y / _1327) < 0.0) ? (6.283185482025146484375 - _1335) : _1335) * 0.15915493667125701904296875;
            _1348 = (_1340 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
        }
        else
        {
            _1348 = ((_561.xy / _561.ww) * float2(0.5, -0.5)) + float2(0.5);
        }
        float4 _1353 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_1348, _1312), level(0.0));
        float3 _1365 = _1292.xyz + (((_1353.xyz * _1320).xyz * View.View_OneOverPreExposure).xyz * _1288);
        float4 _1368 = float4(_1365.x, _1365.y, _1365.z, _197.w);
        _1368.w = _1288 * (1.0 - (_1320 * (1.0 - _1353.w)));
        _1369 = _1368;
    }
    else
    {
        _1369 = _1292;
    }
    out.out_var_PARTICLE_SUBUVS = float4(_382.x, _382.y, _385.x, _385.y);
    out.out_var_TEXCOORD4 = _565;
    out.out_var_TEXCOORD5 = ((CurveTexture.sample(CurveTextureSampler, (EmitterUniforms.EmitterUniforms_ColorCurve.xy + (EmitterUniforms.EmitterUniforms_ColorCurve.zw * _279)), level(0.0)) * EmitterUniforms.EmitterUniforms_ColorScale) + EmitterUniforms.EmitterUniforms_ColorBias) * EmitterDynamicUniforms.EmitterDynamicUniforms_DynamicColor;
    out.out_var_PARTICLE_LIGHTING_OFFSET = ((fract(float3(1341.456298828125, 2633.577880859375, 5623.98291015625) * ((_265.x + 10.0) * (_265.y + 10.0))) * 2.0) - float3(1.0)) * (0.5 * View.View_TranslucencyLightingVolumeInvSize[0].w);
    out.out_var_TANGENTX = float4(_525, 0.0);
    out.out_var_TANGENTZ = float4(_569, float(int(sign(determinant(_570)))));
    out.out_var_TEXCOORD7 = _1369;
    out.gl_Position = _561;
    return out;
}

