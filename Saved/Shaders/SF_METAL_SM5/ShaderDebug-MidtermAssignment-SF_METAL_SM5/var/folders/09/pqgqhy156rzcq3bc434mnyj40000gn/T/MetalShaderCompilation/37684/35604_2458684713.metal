

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

constant float3x3 _193 = {};
constant float4 _194 = {};
constant float2 _196 = {};

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

vertex Main_out Main_00008b14_928c8d29(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_EmitterDynamicUniforms& EmitterDynamicUniforms [[buffer(3)]], constant type_EmitterUniforms& EmitterUniforms [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> ParticleIndices [[texture(0)]], texture2d<float> View_AtmosphereTransmittanceTexture [[texture(1)]], texture2d<float> View_AtmosphereIrradianceTexture [[texture(2)]], texture3d<float> View_AtmosphereInscatterTexture [[texture(3)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(4)]], texture2d<float> PositionTexture [[texture(5)]], texture2d<float> VelocityTexture [[texture(6)]], texture2d<float> AttributesTexture [[texture(7)]], texture2d<float> CurveTexture [[texture(8)]], sampler View_AtmosphereTransmittanceTextureSampler [[sampler(0)]], sampler View_AtmosphereIrradianceTextureSampler [[sampler(1)]], sampler View_AtmosphereInscatterTextureSampler [[sampler(2)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(3)]], sampler PositionTextureSampler [[sampler(4)]], sampler VelocityTextureSampler [[sampler(5)]], sampler AttributesTextureSampler [[sampler(6)]], sampler CurveTextureSampler [[sampler(7)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    uint _254 = (gl_InstanceIndex - gl_BaseInstance) * 16u;
    uint _255 = (gl_VertexIndex - gl_BaseVertex) / 4u;
    uint _256 = _254 + _255;
    uint _259 = _Globals.ParticleIndicesOffset + _256;
    float4 _261 = ParticleIndices.read(uint(_259));
    float2 _262 = _261.xy;
    float4 _266 = PositionTexture.sample(PositionTextureSampler, _262, level(0.0));
    float4 _270 = VelocityTexture.sample(VelocityTextureSampler, _262, level(0.0));
    float4 _274 = AttributesTexture.sample(AttributesTextureSampler, _262, level(0.0));
    float _275 = _266.w;
    float _276 = step(_275, 1.0);
    float3 _277 = _270.xyz;
    float3x3 _286 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    float3 _287 = _286 * _277;
    float3 _289 = normalize(_287 + float3(0.0, 0.0, 9.9999997473787516355514526367188e-05));
    float _290 = length(_287);
    float2 _314 = EmitterUniforms.EmitterUniforms_MiscCurve.zw * _275;
    float2 _315 = EmitterUniforms.EmitterUniforms_MiscCurve.xy + _314;
    float4 _317 = CurveTexture.sample(CurveTextureSampler, _315, level(0.0));
    float4 _320 = _317 * EmitterUniforms.EmitterUniforms_MiscScale;
    float4 _323 = _320 + EmitterUniforms.EmitterUniforms_MiscBias;
    float _324 = _274.x;
    bool _325 = _324 < 0.5;
    float _326 = _325 ? 0.0 : (-0.5);
    float _327 = _274.y;
    bool _328 = _327 < 0.5;
    float _329 = _328 ? 0.0 : (-0.5);
    float2 _330 = float2(_326, _329);
    float2 _331 = _274.xy;
    float2 _332 = _331 + _330;
    float2 _333 = _332 * float2(2.0);
    float2 _334 = _323.xy;
    float2 _337 = _334 * EmitterDynamicUniforms.EmitterDynamicUniforms_LocalToWorldScale;
    float2 _341 = EmitterUniforms.EmitterUniforms_SizeBySpeed.xy * _290;
    float2 _342 = fast::max(_341, float2(1.0));
    float2 _344 = fast::min(_342, EmitterUniforms.EmitterUniforms_SizeBySpeed.zw);
    float2 _345 = _333 * _337;
    float2 _346 = _345 * _344;
    float2 _347 = float2(_276);
    float2 _348 = _346 * _347;
    float2 _353 = _196;
    _353.x = (_326 == 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.x) : in.in_var_ATTRIBUTE0.x;
    float2 _358 = _353;
    _358.y = (_329 == 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.y) : in.in_var_ATTRIBUTE0.y;
    float _359 = _323.z;
    float _360 = fract(_359);
    float _361 = _359 - _360;
    float _362 = _361 + 1.0;
    float2 _378 = (float2(mod(_361, EmitterUniforms.EmitterUniforms_SubImageSize.x), floor(_361 * EmitterUniforms.EmitterUniforms_SubImageSize.z)) + _358) * EmitterUniforms.EmitterUniforms_SubImageSize.zw;
    float2 _381 = (float2(mod(_362, EmitterUniforms.EmitterUniforms_SubImageSize.x), floor(_362 * EmitterUniforms.EmitterUniforms_SubImageSize.z)) + _358) * EmitterUniforms.EmitterUniforms_SubImageSize.zw;
    float _382 = _274.w;
    float _385 = _382 * EmitterUniforms.EmitterUniforms_RotationRateScale;
    float _386 = _274.z;
    float _387 = _385 * _275;
    float _388 = _386 + _387;
    float _389 = _388 * 6.283185482025146484375;
    float3 _393 = _266.xxx;
    float3 _394 = Primitive.Primitive_LocalToWorld[0u].xyz * _393;
    float3 _398 = _266.yyy;
    float3 _399 = Primitive.Primitive_LocalToWorld[1u].xyz * _398;
    float3 _400 = _394 + _399;
    float3 _404 = _266.zzz;
    float3 _405 = Primitive.Primitive_LocalToWorld[2u].xyz * _404;
    float3 _406 = _400 + _405;
    float3 _410 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _411 = _406 + _410;
    float _412 = _411.x;
    float _413 = _411.y;
    float _414 = _411.z;
    float4 _415 = float4(_412, _413, _414, 1.0);
    float3 _416 = _415.xyz;
    float3 _419 = float3(EmitterUniforms.EmitterUniforms_RemoveHMDRoll);
    float3 _428 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _419), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.w));
    float3 _436 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _419), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.w));
    float3 _437 = View.View_TranslatedWorldCameraOrigin - _416;
    float _438 = dot(_437, _437);
    float3 _442 = _437 / float3(sqrt(fast::max(_438, 0.00999999977648258209228515625)));
    float3 _512;
    float3 _513;
    if (EmitterUniforms.EmitterUniforms_CameraFacingBlend[0] > 0.0)
    {
        float3 _500 = cross(_442, float3(0.0, 0.0, 1.0));
        float3 _505 = _500 / float3(sqrt(fast::max(dot(_500, _500), 0.00999999977648258209228515625)));
        float3 _507 = float3(fast::clamp((_438 * EmitterUniforms.EmitterUniforms_CameraFacingBlend[1]) - EmitterUniforms.EmitterUniforms_CameraFacingBlend[2], 0.0, 1.0));
        _512 = normalize(mix(_428, _505, _507));
        _513 = normalize(mix(_436, cross(_442, _505), _507));
    }
    else
    {
        float3 _491;
        float3 _492;
        if (EmitterUniforms.EmitterUniforms_TangentSelector.y > 0.0)
        {
            float3 _484 = cross(_442, _289);
            _491 = _484 / float3(sqrt(fast::max(dot(_484, _484), 0.00999999977648258209228515625)));
            _492 = -_289;
        }
        else
        {
            float3 _482;
            float3 _483;
            if (EmitterUniforms.EmitterUniforms_TangentSelector.z > 0.0)
            {
                float3 _475 = cross(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, _442);
                _482 = EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz;
                _483 = -(_475 / float3(sqrt(fast::max(dot(_475, _475), 0.00999999977648258209228515625))));
            }
            else
            {
                float3 _473;
                float3 _474;
                if (EmitterUniforms.EmitterUniforms_TangentSelector.w > 0.0)
                {
                    float3 _466 = cross(_442, float3(0.0, 0.0, 1.0));
                    float3 _471 = _466 / float3(sqrt(fast::max(dot(_466, _466), 0.00999999977648258209228515625)));
                    _473 = _471;
                    _474 = cross(_442, _471);
                }
                else
                {
                    _473 = _428;
                    _474 = _436;
                }
                _482 = _473;
                _483 = _474;
            }
            _491 = _482;
            _492 = _483;
        }
        _512 = _491;
        _513 = _492;
    }
    float _516 = _389 + EmitterUniforms.EmitterUniforms_RotationBias;
    float _517 = sin(_516);
    float _518 = cos(_516);
    float3 _519 = _513 * _517;
    float3 _520 = _512 * _518;
    float3 _521 = _519 + _520;
    float3 _522 = _513 * _518;
    float3 _523 = _512 * _517;
    float3 _524 = _522 - _523;
    float _525 = _348.x;
    float _528 = in.in_var_ATTRIBUTE0.x + EmitterUniforms.EmitterUniforms_PivotOffset.x;
    float _529 = _525 * _528;
    float3 _530 = _521 * _529;
    float _531 = _348.y;
    float _534 = in.in_var_ATTRIBUTE0.y + EmitterUniforms.EmitterUniforms_PivotOffset.y;
    float _535 = _531 * _534;
    float3 _536 = _524 * _535;
    float3 _537 = _530 + _536;
    float3 _538 = _416 + _537;
    float _539 = _538.x;
    float _540 = _538.y;
    float _541 = _538.z;
    float4 _542 = float4(_539, _540, _541, 1.0);
    float4 _543 = float4(_542.x, _542.y, _542.z, _542.w);
    float4 _544 = View.View_TranslatedWorldToClip * _543;
    float3 _547 = float3(0.0);
    _547.x = _360;
    float3 _548 = _547;
    _548.y = _275;
    float3 _549 = _548;
    _549.z = 0.0;
    float3x3 _550 = _193;
    _550[0] = _521;
    float3x3 _551 = _550;
    _551[1] = _524;
    float3 _553 = normalize(cross(_521, _524));
    float3x3 _554 = _551;
    _554[2] = _553;
    spvUnsafeArray<float4, 1> _567 = { float4(_378.x, _378.y, float4(0.0).z, float4(0.0).w) };
    float3 _568 = _542.xyz;
    float3 _569 = _568 - View.View_TranslatedWorldCameraOrigin;
    float _573 = 9.9999997473787516355514526367188e-06 * View.View_AtmosphericFogDistanceScale;
    float3 _581 = View.View_TranslatedWorldCameraOrigin;
    _581.z = (View.View_TranslatedWorldCameraOrigin.z - View.View_AtmosphericFogGroundOffset) * View.View_AtmosphericFogAltitudeScale;
    float3 _582 = _581 * _573;
    float3 _585 = _582;
    _585.z = _582.z + 6360.009765625;
    float _586 = length(_585);
    float3 _587 = normalize(_569);
    float _588 = dot(_585, _587);
    float _589 = _588 / _586;
    float _591 = (-_586) * _589;
    float _595 = (_586 * _586) * ((_589 * _589) - 1.0);
    float _600 = length(_569) * _573;
    float _604 = fast::max(0.0, _600 - View.View_AtmosphericFogStartDistance);
    float _607 = fast::min((_604 * 0.100000001490116119384765625) / View.View_AtmosphericFogStartDistance, 1.0);
    bool _608 = _600 < (100.0 * View.View_AtmosphericFogDistanceScale);
    float _618;
    float _619;
    if (_608)
    {
        _618 = _607 * View.View_AtmosphericFogPower;
        _619 = fast::max(_600 + View.View_AtmosphericFogDistanceOffset, 1.0);
    }
    else
    {
        _618 = 1.0;
        _619 = _591 - sqrt(_595 + 40449600.0);
    }
    float _625 = _591 - sqrt(_595 + 41344900.0);
    bool _626 = _625 > 0.0;
    float _634;
    float _635;
    float3 _636;
    if (_626)
    {
        _634 = (_588 + _625) * 0.00015552098921034485101699829101562;
        _635 = _619 - _625;
        _636 = _585 + (_587 * _625);
    }
    else
    {
        _634 = _589;
        _635 = _619;
        _636 = _585;
    }
    float _637 = _626 ? 6430.0 : _586;
    bool _638 = _637 < 6360.0146484375;
    float _647;
    float _648;
    float3 _649;
    if (_638)
    {
        float _641 = 6360.0146484375 - _637;
        float3 _643 = _636 - (_587 * _641);
        _647 = dot(_643, _587) * 0.0001572323380969464778900146484375;
        _648 = _635 - _641;
        _649 = _643;
    }
    else
    {
        _647 = _634;
        _648 = _635;
        _649 = _636;
    }
    float _650 = _638 ? 6360.0146484375 : _637;
    float3 _1150;
    float3 _1151;
    if ((_650 <= 6430.0) && (_604 > 0.0))
    {
        float3 _657 = _649 + (_587 * _648);
        float _658 = length(_657);
        float _659 = dot(_587, View.View_AtmosphereLightDirection[0].xyz);
        float _661 = dot(_649, View.View_AtmosphereLightDirection[0].xyz) / _650;
        float _662 = 6360.0 / _650;
        float _665 = sqrt(1.0 - (_662 * _662));
        float _674;
        if (_608)
        {
            _674 = fast::max(_647, 0.1550000011920928955078125 - _665);
        }
        else
        {
            _674 = fast::max(_647, 0.004999999888241291046142578125 - _665);
        }
        float3 _695;
        float _696;
        float _697;
        if (_608)
        {
            float _677 = _587.z;
            float _681 = fast::clamp(exp(-_677) - 0.5, 0.0, 1.0);
            float3 _693;
            float _694;
            if (_681 < 1.0)
            {
                float3 _686 = _587;
                _686.z = fast::max(_677, 0.1500000059604644775390625);
                float3 _687 = normalize(_686);
                float3 _689 = _649 + (_687 * _648);
                _693 = _687;
                _694 = dot(_689, _687) / length(_689);
            }
            else
            {
                _693 = _587;
                _694 = _674;
            }
            _695 = _693;
            _696 = _681;
            _697 = _694;
        }
        else
        {
            _695 = _587;
            _696 = 0.0;
            _697 = _674;
        }
        float _699 = 1.0 + (_659 * _659);
        float _710 = _650 * _650;
        float _712 = sqrt(_710 - 40449600.0);
        float _713 = _650 * _697;
        float _716 = ((_713 * _713) - _710) + 40449600.0;
        float4 _721 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_713 < 0.0) && (_716 > 0.0)));
        float _724 = float(View.View_AtmosphericFogInscatterAltitudeSampleNum);
        float _725 = 0.5 / _724;
        float _728 = 1.0 - (1.0 / _724);
        float _730 = _725 + ((_712 * 0.00105685577727854251861572265625) * _728);
        float _742 = _721.w + ((((_713 * _721.x) + sqrt(_716 + _721.y)) / (_712 + _721.z)) * 0.4921875);
        float _751 = (_659 + 1.0) * 3.5;
        float _752 = floor(_751);
        float _753 = _751 - _752;
        float _754 = _752 + (0.015625 + (((atan(fast::max(_661, -0.19750000536441802978515625) * 5.349621295928955078125) * 0.90909087657928466796875) + 0.7400000095367431640625) * 0.484375));
        float _755 = _754 * 0.125;
        float _759 = 1.0 - _753;
        float _762 = (_754 + 1.0) * 0.125;
        float4 _768 = fast::max((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_755, _742, _730), level(0.0)) * _759) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_762, _742, _730), level(0.0)) * _753), float4(0.0));
        float3 _1134;
        float4 _1135;
        if (_648 > 0.0)
        {
            float2 _779 = float2(_697, _697 + (_648 / _650));
            float2 _780 = _779 * sqrt((0.5 / View.View_AtmosphericFogHeightScaleRayleigh) * _650);
            float2 _783 = float2(int2(sign(_780)));
            float2 _784 = _780 * _780;
            float _800 = 2.0 * _650;
            float _802 = (_648 / _800) + _697;
            float _810 = 6360.0 - _650;
            float2 _820 = _779 * sqrt(0.4166666567325592041015625 * _650);
            float2 _823 = float2(int2(sign(_820)));
            float2 _824 = _820 * _820;
            float3 _853 = exp((float3(-0.0057999999262392520904541015625, -0.013500000350177288055419921875, -0.033100001513957977294921875) * ((sqrt((6.283100128173828125 * View.View_AtmosphericFogHeightScaleRayleigh) * _650) * exp(_810 / View.View_AtmosphericFogHeightScaleRayleigh)) * (((_783.y > _783.x) ? exp(_784.x) : 0.0) + dot((_783 / ((abs(_780) * 2.3192999362945556640625) + sqrt((_784 * 1.519999980926513671875) + float2(4.0)))) * float2(1.0, exp(((-_648) / View.View_AtmosphericFogHeightScaleRayleigh) * _802)), float2(1.0, -1.0))))) - (float3(0.00444444455206394195556640625) * ((sqrt(7.5397205352783203125 * _650) * exp(_810 * 0.833333313465118408203125)) * (((_823.y > _823.x) ? exp(_824.x) : 0.0) + dot((_823 / ((abs(_820) * 2.3192999362945556640625) + sqrt((_824 * 1.519999980926513671875) + float2(4.0)))) * float2(1.0, exp((_648 * (-0.833333313465118408203125)) * _802)), float2(1.0, -1.0))))));
            float _861;
            if (_608)
            {
                _861 = fast::max(_658, _650);
            }
            else
            {
                _861 = _658;
            }
            float4 _1133;
            if (_861 > 6360.009765625)
            {
                float4 _1132;
                if (_696 < 1.0)
                {
                    float4 _872 = _853.xyzx;
                    float _873 = _861 * _861;
                    float _875 = sqrt(_873 - 40449600.0);
                    float _876 = _861 * (dot(_657, _695) / _658);
                    float _879 = ((_876 * _876) - _873) + 40449600.0;
                    float4 _884 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_876 < 0.0) && (_879 > 0.0)));
                    float _887 = _725 + ((_875 * 0.00105685577727854251861572265625) * _728);
                    float _899 = _884.w + ((((_876 * _884.x) + sqrt(_879 + _884.y)) / (_875 + _884.z)) * 0.4921875);
                    float _907 = _752 + (0.015625 + (((atan(fast::max(dot(_657, View.View_AtmosphereLightDirection[0].xyz) / _658, -0.19750000536441802978515625) * 5.349621295928955078125) * 0.90909087657928466796875) + 0.7400000095367431640625) * 0.484375));
                    float _908 = _907 * 0.125;
                    float _914 = (_907 + 1.0) * 0.125;
                    float4 _922 = fast::max(_768 - (_872 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_908, _899, _887), level(0.0)) * _759) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_914, _899, _887), level(0.0)) * _753))), float4(0.0));
                    float4 _1131;
                    if (!_608)
                    {
                        float _966 = _697 - (-_665);
                        float4 _1130;
                        if (abs(_966) < 0.004999999888241291046142578125)
                        {
                            float _973 = (-0.004999999888241291046142578125) - _665;
                            float _975 = _710 + (_648 * _648);
                            float _976 = _800 * _648;
                            float _979 = sqrt(_975 + (_976 * _973));
                            float _980 = _650 * _973;
                            float _983 = 0.004999999888241291046142578125 - _665;
                            float _987 = ((_980 * _980) - _710) + 40449600.0;
                            float4 _992 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_980 < 0.0) && (_987 > 0.0)));
                            float _1004 = _992.w + ((((_980 * _992.x) + sqrt(_987 + _992.y)) / (_712 + _992.z)) * 0.4921875);
                            float _1014 = _979 * _979;
                            float _1016 = sqrt(_1014 - 40449600.0);
                            float _1017 = _979 * fast::max(_983, (_980 + _648) / _979);
                            float _1020 = ((_1017 * _1017) - _1014) + 40449600.0;
                            float4 _1025 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_1017 < 0.0) && (_1020 > 0.0)));
                            float _1028 = _725 + ((_1016 * 0.00105685577727854251861572265625) * _728);
                            float _1040 = _1025.w + ((((_1017 * _1025.x) + sqrt(_1020 + _1025.y)) / (_1016 + _1025.z)) * 0.4921875);
                            float _1055 = sqrt(_975 + (_976 * _983));
                            float _1056 = _650 * _983;
                            float _1062 = ((_1056 * _1056) - _710) + 40449600.0;
                            float4 _1067 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_1056 < 0.0) && (_1062 > 0.0)));
                            float _1079 = _1067.w + ((((_1056 * _1067.x) + sqrt(_1062 + _1067.y)) / (_712 + _1067.z)) * 0.4921875);
                            float _1089 = _1055 * _1055;
                            float _1091 = sqrt(_1089 - 40449600.0);
                            float _1092 = _1055 * fast::max(_983, (_1056 + _648) / _1055);
                            float _1095 = ((_1092 * _1092) - _1089) + 40449600.0;
                            float4 _1100 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_1092 < 0.0) && (_1095 > 0.0)));
                            float _1103 = _725 + ((_1091 * 0.00105685577727854251861572265625) * _728);
                            float _1115 = _1100.w + ((((_1092 * _1100.x) + sqrt(_1095 + _1100.y)) / (_1091 + _1100.z)) * 0.4921875);
                            _1130 = mix(fast::max(((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_755, _1004, _730), level(0.0)) * _759) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_762, _1004, _730), level(0.0)) * _753)) - (_872 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_908, _1040, _1028), level(0.0)) * _759) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_914, _1040, _1028), level(0.0)) * _753))), float4(0.0)), fast::max(((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_755, _1079, _730), level(0.0)) * _759) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_762, _1079, _730), level(0.0)) * _753)) - (_872 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_908, _1115, _1103), level(0.0)) * _759) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_914, _1115, _1103), level(0.0)) * _753))), float4(0.0)), float4((_966 + 0.004999999888241291046142578125) * 100.0));
                        }
                        else
                        {
                            _1130 = _922;
                        }
                        _1131 = _1130;
                    }
                    else
                    {
                        float4 _965;
                        if (_696 > 0.0)
                        {
                            float _931 = _650 * _674;
                            float _934 = ((_931 * _931) - _710) + 40449600.0;
                            float4 _939 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_931 < 0.0) && (_934 > 0.0)));
                            float _951 = _939.w + ((((_931 * _939.x) + sqrt(_934 + _939.y)) / (_712 + _939.z)) * 0.4921875);
                            _965 = mix(_922, (float4(1.0) - _872) * fast::max((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_755, _951, _730), level(0.0)) * _759) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_762, _951, _730), level(0.0)) * _753), float4(0.0)), float4(_696));
                        }
                        else
                        {
                            _965 = _922;
                        }
                        _1131 = _965;
                    }
                    _1132 = _1131;
                }
                else
                {
                    _1132 = (float4(1.0) - _853.xyzx) * _768;
                }
                _1133 = _1132;
            }
            else
            {
                _1133 = _768;
            }
            _1134 = _853;
            _1135 = _1133;
        }
        else
        {
            _1134 = float3(1.0);
            _1135 = _768;
        }
        _1150 = _1134;
        _1151 = fast::max((_1135.xyz * (0.0596831031143665313720703125 * _699)) + ((((_1135.xyz * (_1135.w * smoothstep(0.0, 0.0199999995529651641845703125, _661))) / float3(fast::max(_1135.x, 9.9999997473787516355514526367188e-05))) * float3(1.0, 0.429629623889923095703125, 0.17522656917572021484375)) * (((0.042971827089786529541015625 * pow(abs(1.6400001049041748046875 - (1.60000002384185791015625 * _659)), -1.5)) * _699) * 0.37878787517547607421875)), float3(0.0));
    }
    else
    {
        _1150 = float3(1.0);
        _1151 = float3(0.0);
    }
    float3 _1216;
    if ((View.View_AtmosphericFogRenderMask & 2u) == 0u)
    {
        float3 _1215;
        if (_619 > 0.0)
        {
            float3 _1162 = _585 + (_587 * _619);
            float _1163 = length(_1162);
            float3 _1165 = _1162 / float3(_1163);
            float _1166 = dot(_1165, View.View_AtmosphereLightDirection[0].xyz);
            float _1168 = (_1163 - 6360.0) * 0.014285714365541934967041015625;
            float3 _1181 = select(View_AtmosphereTransmittanceTexture.sample(View_AtmosphereTransmittanceTextureSampler, float2(atan((_1166 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt(_1168)), level(0.0)).xyz, float3(0.0), bool3(_608));
            float3 _1193 = ((_1181 * fast::max(_1166, 0.0)) + View_AtmosphereIrradianceTexture.sample(View_AtmosphereIrradianceTextureSampler, float2((_1166 + 0.20000000298023223876953125) * 0.833333313465118408203125, _1168), level(0.0)).xyz) * float3(0.0031830989755690097808837890625);
            float3 _1213;
            if ((!_608) && true)
            {
                float3 _1199 = normalize(View.View_AtmosphereLightDirection[0].xyz - _587);
                _1213 = _1193 + (_1181 * fast::max((0.0199999995529651641845703125 + (0.980000019073486328125 * pow(1.0 - dot(-_587, _1199), 5.0))) * pow(fast::max(dot(_1199, _1165), 0.0), 150.0), 0.0));
            }
            else
            {
                _1213 = _1193;
            }
            _1215 = _1150 * _1213;
        }
        else
        {
            _1215 = float3(0.0);
        }
        _1216 = _1215;
    }
    else
    {
        _1216 = float3(0.0);
    }
    float3 _1253;
    if ((View.View_AtmosphericFogRenderMask & 1u) == 0u)
    {
        float3 _1252;
        switch (0u)
        {
            default:
            {
                if (_619 > 0.0)
                {
                    _1252 = float3(0.0);
                    break;
                }
                else
                {
                    _1252 = (select(float3(1.0), View_AtmosphereTransmittanceTexture.sample(View_AtmosphereTransmittanceTextureSampler, float2(atan((_589 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt((_586 - 6360.0) * 0.014285714365541934967041015625)), level(0.0)).xyz, bool3(_586 <= 6430.0)) * step(View.View_AtmosphereLightDiscCosHalfApexAngle[0].x, dot(_587, View.View_AtmosphereLightDirection[0].xyz))) * View.View_AtmosphereLightDiscLuminance[0].xyz;
                    break;
                }
            }
        }
        _1253 = _1252;
    }
    else
    {
        _1253 = float3(0.0);
    }
    float _1273 = mix(fast::clamp((_1150.x * View.View_AtmosphericFogDensityScale) - View.View_AtmosphericFogDensityOffset, 0.0, 1.0), 1.0, 1.0 - _607);
    float4 _1277 = float4((View.View_AtmosphereLightColor[0].xyz * (View.View_AtmosphericFogSunPower * _618)) * ((_1253 + _1216) + _1151), _1273);
    float4 _1354;
    if (View.View_SkyAtmosphereApplyCameraAerialPerspectiveVolume > 0.0)
    {
        float3 _1291 = (_568 * 9.9999997473787516355514526367188e-06) - (View.View_TranslatedWorldCameraOrigin * 9.9999997473787516355514526367188e-06);
        float _1297 = sqrt((fast::max(0.0, length(_1291) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
        float _1298 = _1297 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
        float _1305;
        if (_1298 < 0.707106769084930419921875)
        {
            _1305 = fast::clamp((_1298 * _1298) * 2.0, 0.0, 1.0);
        }
        else
        {
            _1305 = 1.0;
        }
        float2 _1333;
        if (View.View_RealTimeReflectionCapture != 0.0)
        {
            float3 _1308 = normalize(_1291);
            float _1309 = _1308.z;
            float _1312 = sqrt(1.0 - (_1309 * _1309));
            float2 _1315 = _196;
            _1315.y = (_1309 * 0.5) + 0.5;
            float _1320 = acos(_1308.x / _1312);
            float2 _1325 = _1315;
            _1325.x = (((_1308.y / _1312) < 0.0) ? (6.283185482025146484375 - _1320) : _1320) * 0.15915493667125701904296875;
            _1333 = (_1325 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
        }
        else
        {
            _1333 = ((_544.xy / _544.ww) * float2(0.5, -0.5)) + float2(0.5);
        }
        float4 _1338 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_1333, _1297), level(0.0));
        float3 _1350 = _1277.xyz + (((_1338.xyz * _1305).xyz * View.View_OneOverPreExposure).xyz * _1273);
        float4 _1353 = float4(_1350.x, _1350.y, _1350.z, _194.w);
        _1353.w = _1273 * (1.0 - (_1305 * (1.0 - _1338.w)));
        _1354 = _1353;
    }
    else
    {
        _1354 = _1277;
    }
    out_var_TEXCOORD0 = _567;
    out.out_var_PARTICLE_SUBUVS = float4(_378.x, _378.y, _381.x, _381.y);
    out.out_var_TEXCOORD4 = _549;
    out.out_var_TEXCOORD5 = ((CurveTexture.sample(CurveTextureSampler, (EmitterUniforms.EmitterUniforms_ColorCurve.xy + (EmitterUniforms.EmitterUniforms_ColorCurve.zw * _275)), level(0.0)) * EmitterUniforms.EmitterUniforms_ColorScale) + EmitterUniforms.EmitterUniforms_ColorBias) * EmitterDynamicUniforms.EmitterDynamicUniforms_DynamicColor;
    out.out_var_TANGENTX = float4(_521, 0.0);
    out.out_var_TANGENTZ = float4(_553, float(int(sign(determinant(_554)))));
    out.out_var_TEXCOORD7 = _1354;
    out.gl_Position = _544;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

