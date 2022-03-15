

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

constant float3x3 _199 = {};
constant float4 _200 = {};
constant float2 _202 = {};

struct Main_out
{
    float4 out_var_TEXCOORD0_0 [[user(locn0)]];
    float4 out_var_PARTICLE_SUBUVS [[user(locn1)]];
    float3 out_var_TEXCOORD4 [[user(locn2)]];
    float4 out_var_TEXCOORD5 [[user(locn3)]];
    float3 out_var_PARTICLE_LIGHTING_OFFSET [[user(locn4)]];
    float4 out_var_TANGENTX [[user(locn5)]];
    float4 out_var_TANGENTZ [[user(locn6)]];
    float4 out_var_TEXCOORD7 [[user(locn7)]];
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

vertex Main_out Main_00008cba_163342ad(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_EmitterDynamicUniforms& EmitterDynamicUniforms [[buffer(3)]], constant type_EmitterUniforms& EmitterUniforms [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> ParticleIndices [[texture(0)]], texture2d<float> View_AtmosphereTransmittanceTexture [[texture(1)]], texture2d<float> View_AtmosphereIrradianceTexture [[texture(2)]], texture3d<float> View_AtmosphereInscatterTexture [[texture(3)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(4)]], texture2d<float> PositionTexture [[texture(5)]], texture2d<float> VelocityTexture [[texture(6)]], texture2d<float> AttributesTexture [[texture(7)]], texture2d<float> CurveTexture [[texture(8)]], sampler View_AtmosphereTransmittanceTextureSampler [[sampler(0)]], sampler View_AtmosphereIrradianceTextureSampler [[sampler(1)]], sampler View_AtmosphereInscatterTextureSampler [[sampler(2)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(3)]], sampler PositionTextureSampler [[sampler(4)]], sampler VelocityTextureSampler [[sampler(5)]], sampler AttributesTextureSampler [[sampler(6)]], sampler CurveTextureSampler [[sampler(7)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    uint _261 = (gl_InstanceIndex - gl_BaseInstance) * 16u;
    uint _262 = (gl_VertexIndex - gl_BaseVertex) / 4u;
    uint _263 = _261 + _262;
    uint _266 = _Globals.ParticleIndicesOffset + _263;
    float4 _268 = ParticleIndices.read(uint(_266));
    float2 _269 = _268.xy;
    float4 _273 = PositionTexture.sample(PositionTextureSampler, _269, level(0.0));
    float4 _277 = VelocityTexture.sample(VelocityTextureSampler, _269, level(0.0));
    float4 _281 = AttributesTexture.sample(AttributesTextureSampler, _269, level(0.0));
    float _282 = _273.w;
    float _283 = step(_282, 1.0);
    float3 _284 = _277.xyz;
    float3x3 _293 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    float3 _294 = _293 * _284;
    float3 _296 = normalize(_294 + float3(0.0, 0.0, 9.9999997473787516355514526367188e-05));
    float _297 = length(_294);
    float2 _321 = EmitterUniforms.EmitterUniforms_MiscCurve.zw * _282;
    float2 _322 = EmitterUniforms.EmitterUniforms_MiscCurve.xy + _321;
    float4 _324 = CurveTexture.sample(CurveTextureSampler, _322, level(0.0));
    float4 _327 = _324 * EmitterUniforms.EmitterUniforms_MiscScale;
    float4 _330 = _327 + EmitterUniforms.EmitterUniforms_MiscBias;
    float _331 = _281.x;
    bool _332 = _331 < 0.5;
    float _333 = _332 ? 0.0 : (-0.5);
    float _334 = _281.y;
    bool _335 = _334 < 0.5;
    float _336 = _335 ? 0.0 : (-0.5);
    float2 _337 = float2(_333, _336);
    float2 _338 = _281.xy;
    float2 _339 = _338 + _337;
    float2 _340 = _339 * float2(2.0);
    float2 _341 = _330.xy;
    float2 _344 = _341 * EmitterDynamicUniforms.EmitterDynamicUniforms_LocalToWorldScale;
    float2 _348 = EmitterUniforms.EmitterUniforms_SizeBySpeed.xy * _297;
    float2 _349 = fast::max(_348, float2(1.0));
    float2 _351 = fast::min(_349, EmitterUniforms.EmitterUniforms_SizeBySpeed.zw);
    float2 _352 = _340 * _344;
    float2 _353 = _352 * _351;
    float2 _354 = float2(_283);
    float2 _355 = _353 * _354;
    float2 _360 = _202;
    _360.x = (_333 == 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.x) : in.in_var_ATTRIBUTE0.x;
    float2 _365 = _360;
    _365.y = (_336 == 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.y) : in.in_var_ATTRIBUTE0.y;
    float _366 = _330.z;
    float _367 = fract(_366);
    float _368 = _366 - _367;
    float _369 = _368 + 1.0;
    float2 _385 = (float2(mod(_368, EmitterUniforms.EmitterUniforms_SubImageSize.x), floor(_368 * EmitterUniforms.EmitterUniforms_SubImageSize.z)) + _365) * EmitterUniforms.EmitterUniforms_SubImageSize.zw;
    float2 _388 = (float2(mod(_369, EmitterUniforms.EmitterUniforms_SubImageSize.x), floor(_369 * EmitterUniforms.EmitterUniforms_SubImageSize.z)) + _365) * EmitterUniforms.EmitterUniforms_SubImageSize.zw;
    float _389 = _281.w;
    float _392 = _389 * EmitterUniforms.EmitterUniforms_RotationRateScale;
    float _393 = _281.z;
    float _394 = _392 * _282;
    float _395 = _393 + _394;
    float _396 = _395 * 6.283185482025146484375;
    float3 _400 = _273.xxx;
    float3 _401 = Primitive.Primitive_LocalToWorld[0u].xyz * _400;
    float3 _405 = _273.yyy;
    float3 _406 = Primitive.Primitive_LocalToWorld[1u].xyz * _405;
    float3 _407 = _401 + _406;
    float3 _411 = _273.zzz;
    float3 _412 = Primitive.Primitive_LocalToWorld[2u].xyz * _411;
    float3 _413 = _407 + _412;
    float3 _417 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _418 = _413 + _417;
    float _419 = _418.x;
    float _420 = _418.y;
    float _421 = _418.z;
    float4 _422 = float4(_419, _420, _421, 1.0);
    float3 _423 = _422.xyz;
    float3 _426 = float3(EmitterUniforms.EmitterUniforms_RemoveHMDRoll);
    float3 _435 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _426), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.w));
    float3 _443 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _426), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.w));
    float3 _444 = View.View_TranslatedWorldCameraOrigin - _423;
    float _445 = dot(_444, _444);
    float3 _449 = _444 / float3(sqrt(fast::max(_445, 0.00999999977648258209228515625)));
    float3 _519;
    float3 _520;
    if (EmitterUniforms.EmitterUniforms_CameraFacingBlend[0] > 0.0)
    {
        float3 _507 = cross(_449, float3(0.0, 0.0, 1.0));
        float3 _512 = _507 / float3(sqrt(fast::max(dot(_507, _507), 0.00999999977648258209228515625)));
        float3 _514 = float3(fast::clamp((_445 * EmitterUniforms.EmitterUniforms_CameraFacingBlend[1]) - EmitterUniforms.EmitterUniforms_CameraFacingBlend[2], 0.0, 1.0));
        _519 = normalize(mix(_435, _512, _514));
        _520 = normalize(mix(_443, cross(_449, _512), _514));
    }
    else
    {
        float3 _498;
        float3 _499;
        if (EmitterUniforms.EmitterUniforms_TangentSelector.y > 0.0)
        {
            float3 _491 = cross(_449, _296);
            _498 = _491 / float3(sqrt(fast::max(dot(_491, _491), 0.00999999977648258209228515625)));
            _499 = -_296;
        }
        else
        {
            float3 _489;
            float3 _490;
            if (EmitterUniforms.EmitterUniforms_TangentSelector.z > 0.0)
            {
                float3 _482 = cross(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, _449);
                _489 = EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz;
                _490 = -(_482 / float3(sqrt(fast::max(dot(_482, _482), 0.00999999977648258209228515625))));
            }
            else
            {
                float3 _480;
                float3 _481;
                if (EmitterUniforms.EmitterUniforms_TangentSelector.w > 0.0)
                {
                    float3 _473 = cross(_449, float3(0.0, 0.0, 1.0));
                    float3 _478 = _473 / float3(sqrt(fast::max(dot(_473, _473), 0.00999999977648258209228515625)));
                    _480 = _478;
                    _481 = cross(_449, _478);
                }
                else
                {
                    _480 = _435;
                    _481 = _443;
                }
                _489 = _480;
                _490 = _481;
            }
            _498 = _489;
            _499 = _490;
        }
        _519 = _498;
        _520 = _499;
    }
    float _523 = _396 + EmitterUniforms.EmitterUniforms_RotationBias;
    float _524 = sin(_523);
    float _525 = cos(_523);
    float3 _526 = _520 * _524;
    float3 _527 = _519 * _525;
    float3 _528 = _526 + _527;
    float3 _529 = _520 * _525;
    float3 _530 = _519 * _524;
    float3 _531 = _529 - _530;
    float _532 = _355.x;
    float _535 = in.in_var_ATTRIBUTE0.x + EmitterUniforms.EmitterUniforms_PivotOffset.x;
    float _536 = _532 * _535;
    float3 _537 = _528 * _536;
    float _538 = _355.y;
    float _541 = in.in_var_ATTRIBUTE0.y + EmitterUniforms.EmitterUniforms_PivotOffset.y;
    float _542 = _538 * _541;
    float3 _543 = _531 * _542;
    float3 _544 = _537 + _543;
    float3 _545 = _423 + _544;
    float _559 = _545.x;
    float _560 = _545.y;
    float _561 = _545.z;
    float4 _562 = float4(_559, _560, _561, 1.0);
    float4 _563 = float4(_562.x, _562.y, _562.z, _562.w);
    float4 _564 = View.View_TranslatedWorldToClip * _563;
    float3 _567 = float3(0.0);
    _567.x = _367;
    float3 _568 = _567;
    _568.y = _282;
    float3 _569 = _568;
    _569.z = 0.0;
    float3x3 _570 = _199;
    _570[0] = _528;
    float3x3 _571 = _570;
    _571[1] = _531;
    float3 _573 = normalize(cross(_528, _531));
    float3x3 _574 = _571;
    _574[2] = _573;
    spvUnsafeArray<float4, 1> _587 = { float4(_385.x, _385.y, float4(0.0).z, float4(0.0).w) };
    float3 _588 = _562.xyz;
    float3 _589 = _588 - View.View_TranslatedWorldCameraOrigin;
    float _593 = 9.9999997473787516355514526367188e-06 * View.View_AtmosphericFogDistanceScale;
    float3 _601 = View.View_TranslatedWorldCameraOrigin;
    _601.z = (View.View_TranslatedWorldCameraOrigin.z - View.View_AtmosphericFogGroundOffset) * View.View_AtmosphericFogAltitudeScale;
    float3 _602 = _601 * _593;
    float3 _605 = _602;
    _605.z = _602.z + 6360.009765625;
    float _606 = length(_605);
    float3 _607 = normalize(_589);
    float _608 = dot(_605, _607);
    float _609 = _608 / _606;
    float _611 = (-_606) * _609;
    float _615 = (_606 * _606) * ((_609 * _609) - 1.0);
    float _620 = length(_589) * _593;
    float _624 = fast::max(0.0, _620 - View.View_AtmosphericFogStartDistance);
    float _627 = fast::min((_624 * 0.100000001490116119384765625) / View.View_AtmosphericFogStartDistance, 1.0);
    bool _628 = _620 < (100.0 * View.View_AtmosphericFogDistanceScale);
    float _638;
    float _639;
    if (_628)
    {
        _638 = _627 * View.View_AtmosphericFogPower;
        _639 = fast::max(_620 + View.View_AtmosphericFogDistanceOffset, 1.0);
    }
    else
    {
        _638 = 1.0;
        _639 = _611 - sqrt(_615 + 40449600.0);
    }
    float _645 = _611 - sqrt(_615 + 41344900.0);
    bool _646 = _645 > 0.0;
    float _654;
    float _655;
    float3 _656;
    if (_646)
    {
        _654 = (_608 + _645) * 0.00015552098921034485101699829101562;
        _655 = _639 - _645;
        _656 = _605 + (_607 * _645);
    }
    else
    {
        _654 = _609;
        _655 = _639;
        _656 = _605;
    }
    float _657 = _646 ? 6430.0 : _606;
    bool _658 = _657 < 6360.0146484375;
    float _667;
    float _668;
    float3 _669;
    if (_658)
    {
        float _661 = 6360.0146484375 - _657;
        float3 _663 = _656 - (_607 * _661);
        _667 = dot(_663, _607) * 0.0001572323380969464778900146484375;
        _668 = _655 - _661;
        _669 = _663;
    }
    else
    {
        _667 = _654;
        _668 = _655;
        _669 = _656;
    }
    float _670 = _658 ? 6360.0146484375 : _657;
    float3 _1170;
    float3 _1171;
    if ((_670 <= 6430.0) && (_624 > 0.0))
    {
        float3 _677 = _669 + (_607 * _668);
        float _678 = length(_677);
        float _679 = dot(_607, View.View_AtmosphereLightDirection[0].xyz);
        float _681 = dot(_669, View.View_AtmosphereLightDirection[0].xyz) / _670;
        float _682 = 6360.0 / _670;
        float _685 = sqrt(1.0 - (_682 * _682));
        float _694;
        if (_628)
        {
            _694 = fast::max(_667, 0.1550000011920928955078125 - _685);
        }
        else
        {
            _694 = fast::max(_667, 0.004999999888241291046142578125 - _685);
        }
        float3 _715;
        float _716;
        float _717;
        if (_628)
        {
            float _697 = _607.z;
            float _701 = fast::clamp(exp(-_697) - 0.5, 0.0, 1.0);
            float3 _713;
            float _714;
            if (_701 < 1.0)
            {
                float3 _706 = _607;
                _706.z = fast::max(_697, 0.1500000059604644775390625);
                float3 _707 = normalize(_706);
                float3 _709 = _669 + (_707 * _668);
                _713 = _707;
                _714 = dot(_709, _707) / length(_709);
            }
            else
            {
                _713 = _607;
                _714 = _694;
            }
            _715 = _713;
            _716 = _701;
            _717 = _714;
        }
        else
        {
            _715 = _607;
            _716 = 0.0;
            _717 = _694;
        }
        float _719 = 1.0 + (_679 * _679);
        float _730 = _670 * _670;
        float _732 = sqrt(_730 - 40449600.0);
        float _733 = _670 * _717;
        float _736 = ((_733 * _733) - _730) + 40449600.0;
        float4 _741 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_733 < 0.0) && (_736 > 0.0)));
        float _744 = float(View.View_AtmosphericFogInscatterAltitudeSampleNum);
        float _745 = 0.5 / _744;
        float _748 = 1.0 - (1.0 / _744);
        float _750 = _745 + ((_732 * 0.00105685577727854251861572265625) * _748);
        float _762 = _741.w + ((((_733 * _741.x) + sqrt(_736 + _741.y)) / (_732 + _741.z)) * 0.4921875);
        float _771 = (_679 + 1.0) * 3.5;
        float _772 = floor(_771);
        float _773 = _771 - _772;
        float _774 = _772 + (0.015625 + (((atan(fast::max(_681, -0.19750000536441802978515625) * 5.349621295928955078125) * 0.90909087657928466796875) + 0.7400000095367431640625) * 0.484375));
        float _775 = _774 * 0.125;
        float _779 = 1.0 - _773;
        float _782 = (_774 + 1.0) * 0.125;
        float4 _788 = fast::max((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_775, _762, _750), level(0.0)) * _779) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_782, _762, _750), level(0.0)) * _773), float4(0.0));
        float3 _1154;
        float4 _1155;
        if (_668 > 0.0)
        {
            float2 _799 = float2(_717, _717 + (_668 / _670));
            float2 _800 = _799 * sqrt((0.5 / View.View_AtmosphericFogHeightScaleRayleigh) * _670);
            float2 _803 = float2(int2(sign(_800)));
            float2 _804 = _800 * _800;
            float _820 = 2.0 * _670;
            float _822 = (_668 / _820) + _717;
            float _830 = 6360.0 - _670;
            float2 _840 = _799 * sqrt(0.4166666567325592041015625 * _670);
            float2 _843 = float2(int2(sign(_840)));
            float2 _844 = _840 * _840;
            float3 _873 = exp((float3(-0.0057999999262392520904541015625, -0.013500000350177288055419921875, -0.033100001513957977294921875) * ((sqrt((6.283100128173828125 * View.View_AtmosphericFogHeightScaleRayleigh) * _670) * exp(_830 / View.View_AtmosphericFogHeightScaleRayleigh)) * (((_803.y > _803.x) ? exp(_804.x) : 0.0) + dot((_803 / ((abs(_800) * 2.3192999362945556640625) + sqrt((_804 * 1.519999980926513671875) + float2(4.0)))) * float2(1.0, exp(((-_668) / View.View_AtmosphericFogHeightScaleRayleigh) * _822)), float2(1.0, -1.0))))) - (float3(0.00444444455206394195556640625) * ((sqrt(7.5397205352783203125 * _670) * exp(_830 * 0.833333313465118408203125)) * (((_843.y > _843.x) ? exp(_844.x) : 0.0) + dot((_843 / ((abs(_840) * 2.3192999362945556640625) + sqrt((_844 * 1.519999980926513671875) + float2(4.0)))) * float2(1.0, exp((_668 * (-0.833333313465118408203125)) * _822)), float2(1.0, -1.0))))));
            float _881;
            if (_628)
            {
                _881 = fast::max(_678, _670);
            }
            else
            {
                _881 = _678;
            }
            float4 _1153;
            if (_881 > 6360.009765625)
            {
                float4 _1152;
                if (_716 < 1.0)
                {
                    float4 _892 = _873.xyzx;
                    float _893 = _881 * _881;
                    float _895 = sqrt(_893 - 40449600.0);
                    float _896 = _881 * (dot(_677, _715) / _678);
                    float _899 = ((_896 * _896) - _893) + 40449600.0;
                    float4 _904 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_896 < 0.0) && (_899 > 0.0)));
                    float _907 = _745 + ((_895 * 0.00105685577727854251861572265625) * _748);
                    float _919 = _904.w + ((((_896 * _904.x) + sqrt(_899 + _904.y)) / (_895 + _904.z)) * 0.4921875);
                    float _927 = _772 + (0.015625 + (((atan(fast::max(dot(_677, View.View_AtmosphereLightDirection[0].xyz) / _678, -0.19750000536441802978515625) * 5.349621295928955078125) * 0.90909087657928466796875) + 0.7400000095367431640625) * 0.484375));
                    float _928 = _927 * 0.125;
                    float _934 = (_927 + 1.0) * 0.125;
                    float4 _942 = fast::max(_788 - (_892 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_928, _919, _907), level(0.0)) * _779) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_934, _919, _907), level(0.0)) * _773))), float4(0.0));
                    float4 _1151;
                    if (!_628)
                    {
                        float _986 = _717 - (-_685);
                        float4 _1150;
                        if (abs(_986) < 0.004999999888241291046142578125)
                        {
                            float _993 = (-0.004999999888241291046142578125) - _685;
                            float _995 = _730 + (_668 * _668);
                            float _996 = _820 * _668;
                            float _999 = sqrt(_995 + (_996 * _993));
                            float _1000 = _670 * _993;
                            float _1003 = 0.004999999888241291046142578125 - _685;
                            float _1007 = ((_1000 * _1000) - _730) + 40449600.0;
                            float4 _1012 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_1000 < 0.0) && (_1007 > 0.0)));
                            float _1024 = _1012.w + ((((_1000 * _1012.x) + sqrt(_1007 + _1012.y)) / (_732 + _1012.z)) * 0.4921875);
                            float _1034 = _999 * _999;
                            float _1036 = sqrt(_1034 - 40449600.0);
                            float _1037 = _999 * fast::max(_1003, (_1000 + _668) / _999);
                            float _1040 = ((_1037 * _1037) - _1034) + 40449600.0;
                            float4 _1045 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_1037 < 0.0) && (_1040 > 0.0)));
                            float _1048 = _745 + ((_1036 * 0.00105685577727854251861572265625) * _748);
                            float _1060 = _1045.w + ((((_1037 * _1045.x) + sqrt(_1040 + _1045.y)) / (_1036 + _1045.z)) * 0.4921875);
                            float _1075 = sqrt(_995 + (_996 * _1003));
                            float _1076 = _670 * _1003;
                            float _1082 = ((_1076 * _1076) - _730) + 40449600.0;
                            float4 _1087 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_1076 < 0.0) && (_1082 > 0.0)));
                            float _1099 = _1087.w + ((((_1076 * _1087.x) + sqrt(_1082 + _1087.y)) / (_732 + _1087.z)) * 0.4921875);
                            float _1109 = _1075 * _1075;
                            float _1111 = sqrt(_1109 - 40449600.0);
                            float _1112 = _1075 * fast::max(_1003, (_1076 + _668) / _1075);
                            float _1115 = ((_1112 * _1112) - _1109) + 40449600.0;
                            float4 _1120 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_1112 < 0.0) && (_1115 > 0.0)));
                            float _1123 = _745 + ((_1111 * 0.00105685577727854251861572265625) * _748);
                            float _1135 = _1120.w + ((((_1112 * _1120.x) + sqrt(_1115 + _1120.y)) / (_1111 + _1120.z)) * 0.4921875);
                            _1150 = mix(fast::max(((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_775, _1024, _750), level(0.0)) * _779) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_782, _1024, _750), level(0.0)) * _773)) - (_892 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_928, _1060, _1048), level(0.0)) * _779) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_934, _1060, _1048), level(0.0)) * _773))), float4(0.0)), fast::max(((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_775, _1099, _750), level(0.0)) * _779) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_782, _1099, _750), level(0.0)) * _773)) - (_892 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_928, _1135, _1123), level(0.0)) * _779) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_934, _1135, _1123), level(0.0)) * _773))), float4(0.0)), float4((_986 + 0.004999999888241291046142578125) * 100.0));
                        }
                        else
                        {
                            _1150 = _942;
                        }
                        _1151 = _1150;
                    }
                    else
                    {
                        float4 _985;
                        if (_716 > 0.0)
                        {
                            float _951 = _670 * _694;
                            float _954 = ((_951 * _951) - _730) + 40449600.0;
                            float4 _959 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_951 < 0.0) && (_954 > 0.0)));
                            float _971 = _959.w + ((((_951 * _959.x) + sqrt(_954 + _959.y)) / (_732 + _959.z)) * 0.4921875);
                            _985 = mix(_942, (float4(1.0) - _892) * fast::max((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_775, _971, _750), level(0.0)) * _779) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_782, _971, _750), level(0.0)) * _773), float4(0.0)), float4(_716));
                        }
                        else
                        {
                            _985 = _942;
                        }
                        _1151 = _985;
                    }
                    _1152 = _1151;
                }
                else
                {
                    _1152 = (float4(1.0) - _873.xyzx) * _788;
                }
                _1153 = _1152;
            }
            else
            {
                _1153 = _788;
            }
            _1154 = _873;
            _1155 = _1153;
        }
        else
        {
            _1154 = float3(1.0);
            _1155 = _788;
        }
        _1170 = _1154;
        _1171 = fast::max((_1155.xyz * (0.0596831031143665313720703125 * _719)) + ((((_1155.xyz * (_1155.w * smoothstep(0.0, 0.0199999995529651641845703125, _681))) / float3(fast::max(_1155.x, 9.9999997473787516355514526367188e-05))) * float3(1.0, 0.429629623889923095703125, 0.17522656917572021484375)) * (((0.042971827089786529541015625 * pow(abs(1.6400001049041748046875 - (1.60000002384185791015625 * _679)), -1.5)) * _719) * 0.37878787517547607421875)), float3(0.0));
    }
    else
    {
        _1170 = float3(1.0);
        _1171 = float3(0.0);
    }
    float3 _1236;
    if ((View.View_AtmosphericFogRenderMask & 2u) == 0u)
    {
        float3 _1235;
        if (_639 > 0.0)
        {
            float3 _1182 = _605 + (_607 * _639);
            float _1183 = length(_1182);
            float3 _1185 = _1182 / float3(_1183);
            float _1186 = dot(_1185, View.View_AtmosphereLightDirection[0].xyz);
            float _1188 = (_1183 - 6360.0) * 0.014285714365541934967041015625;
            float3 _1201 = select(View_AtmosphereTransmittanceTexture.sample(View_AtmosphereTransmittanceTextureSampler, float2(atan((_1186 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt(_1188)), level(0.0)).xyz, float3(0.0), bool3(_628));
            float3 _1213 = ((_1201 * fast::max(_1186, 0.0)) + View_AtmosphereIrradianceTexture.sample(View_AtmosphereIrradianceTextureSampler, float2((_1186 + 0.20000000298023223876953125) * 0.833333313465118408203125, _1188), level(0.0)).xyz) * float3(0.0031830989755690097808837890625);
            float3 _1233;
            if ((!_628) && true)
            {
                float3 _1219 = normalize(View.View_AtmosphereLightDirection[0].xyz - _607);
                _1233 = _1213 + (_1201 * fast::max((0.0199999995529651641845703125 + (0.980000019073486328125 * pow(1.0 - dot(-_607, _1219), 5.0))) * pow(fast::max(dot(_1219, _1185), 0.0), 150.0), 0.0));
            }
            else
            {
                _1233 = _1213;
            }
            _1235 = _1170 * _1233;
        }
        else
        {
            _1235 = float3(0.0);
        }
        _1236 = _1235;
    }
    else
    {
        _1236 = float3(0.0);
    }
    float3 _1273;
    if ((View.View_AtmosphericFogRenderMask & 1u) == 0u)
    {
        float3 _1272;
        switch (0u)
        {
            default:
            {
                if (_639 > 0.0)
                {
                    _1272 = float3(0.0);
                    break;
                }
                else
                {
                    _1272 = (select(float3(1.0), View_AtmosphereTransmittanceTexture.sample(View_AtmosphereTransmittanceTextureSampler, float2(atan((_609 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt((_606 - 6360.0) * 0.014285714365541934967041015625)), level(0.0)).xyz, bool3(_606 <= 6430.0)) * step(View.View_AtmosphereLightDiscCosHalfApexAngle[0].x, dot(_607, View.View_AtmosphereLightDirection[0].xyz))) * View.View_AtmosphereLightDiscLuminance[0].xyz;
                    break;
                }
            }
        }
        _1273 = _1272;
    }
    else
    {
        _1273 = float3(0.0);
    }
    float _1293 = mix(fast::clamp((_1170.x * View.View_AtmosphericFogDensityScale) - View.View_AtmosphericFogDensityOffset, 0.0, 1.0), 1.0, 1.0 - _627);
    float4 _1297 = float4((View.View_AtmosphereLightColor[0].xyz * (View.View_AtmosphericFogSunPower * _638)) * ((_1273 + _1236) + _1171), _1293);
    float4 _1374;
    if (View.View_SkyAtmosphereApplyCameraAerialPerspectiveVolume > 0.0)
    {
        float3 _1311 = (_588 * 9.9999997473787516355514526367188e-06) - (View.View_TranslatedWorldCameraOrigin * 9.9999997473787516355514526367188e-06);
        float _1317 = sqrt((fast::max(0.0, length(_1311) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
        float _1318 = _1317 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
        float _1325;
        if (_1318 < 0.707106769084930419921875)
        {
            _1325 = fast::clamp((_1318 * _1318) * 2.0, 0.0, 1.0);
        }
        else
        {
            _1325 = 1.0;
        }
        float2 _1353;
        if (View.View_RealTimeReflectionCapture != 0.0)
        {
            float3 _1328 = normalize(_1311);
            float _1329 = _1328.z;
            float _1332 = sqrt(1.0 - (_1329 * _1329));
            float2 _1335 = _202;
            _1335.y = (_1329 * 0.5) + 0.5;
            float _1340 = acos(_1328.x / _1332);
            float2 _1345 = _1335;
            _1345.x = (((_1328.y / _1332) < 0.0) ? (6.283185482025146484375 - _1340) : _1340) * 0.15915493667125701904296875;
            _1353 = (_1345 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
        }
        else
        {
            _1353 = ((_564.xy / _564.ww) * float2(0.5, -0.5)) + float2(0.5);
        }
        float4 _1358 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_1353, _1317), level(0.0));
        float3 _1370 = _1297.xyz + (((_1358.xyz * _1325).xyz * View.View_OneOverPreExposure).xyz * _1293);
        float4 _1373 = float4(_1370.x, _1370.y, _1370.z, _200.w);
        _1373.w = _1293 * (1.0 - (_1325 * (1.0 - _1358.w)));
        _1374 = _1373;
    }
    else
    {
        _1374 = _1297;
    }
    out_var_TEXCOORD0 = _587;
    out.out_var_PARTICLE_SUBUVS = float4(_385.x, _385.y, _388.x, _388.y);
    out.out_var_TEXCOORD4 = _569;
    out.out_var_TEXCOORD5 = ((CurveTexture.sample(CurveTextureSampler, (EmitterUniforms.EmitterUniforms_ColorCurve.xy + (EmitterUniforms.EmitterUniforms_ColorCurve.zw * _282)), level(0.0)) * EmitterUniforms.EmitterUniforms_ColorScale) + EmitterUniforms.EmitterUniforms_ColorBias) * EmitterDynamicUniforms.EmitterDynamicUniforms_DynamicColor;
    out.out_var_PARTICLE_LIGHTING_OFFSET = ((fract(float3(1341.456298828125, 2633.577880859375, 5623.98291015625) * ((_268.x + 10.0) * (_268.y + 10.0))) * 2.0) - float3(1.0)) * (0.5 * View.View_TranslucencyLightingVolumeInvSize[0].w);
    out.out_var_TANGENTX = float4(_528, 0.0);
    out.out_var_TANGENTZ = float4(_573, float(int(sign(determinant(_574)))));
    out.out_var_TEXCOORD7 = _1374;
    out.gl_Position = _564;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

