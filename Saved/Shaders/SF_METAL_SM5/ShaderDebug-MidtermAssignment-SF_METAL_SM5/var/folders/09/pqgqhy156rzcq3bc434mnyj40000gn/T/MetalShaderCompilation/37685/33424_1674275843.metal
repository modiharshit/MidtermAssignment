

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
    char _m5_pad[32];
    float3 View_WorldCameraOrigin;
    float3 View_TranslatedWorldCameraOrigin;
    char _m7_pad[16];
    float3 View_PreViewTranslation;
    char _m8_pad[1032];
    float View_OneOverPreExposure;
    char _m9_pad[352];
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

struct type_SpriteVF
{
    float4 SpriteVF_AxisLockRight;
    float4 SpriteVF_AxisLockUp;
    float4 SpriteVF_TangentSelector;
    float4 SpriteVF_NormalsSphereCenter;
    float4 SpriteVF_NormalsCylinderUnitDirection;
    float4 SpriteVF_SubImageSize;
    packed_float3 SpriteVF_CameraFacingBlend;
    float SpriteVF_RemoveHMDRoll;
    char _m8_pad[16];
    float SpriteVF_RotationScale;
    float SpriteVF_RotationBias;
    float SpriteVF_NormalsType;
    float2 SpriteVF_PivotOffset;
};

struct type_Globals
{
    uint NumCutoutVerticesPerFrame;
};

constant float3x3 _171 = {};
constant float4 _172 = {};
constant float2 _174 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10 [[user(locn0)]];
    float4 out_var_TEXCOORD11 [[user(locn1)]];
    float4 out_var_TEXCOORD2 [[user(locn2)]];
    float4 out_var_PARTICLE_SUBUVS [[user(locn3)]];
    float4 out_var_TEXCOORD7 [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float4 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    float4 in_var_ATTRIBUTE3 [[attribute(3)]];
    float2 in_var_ATTRIBUTE4 [[attribute(4)]];
};

// Implementation of the GLSL mod() function, which is slightly different than Metal fmod()
template<typename Tx, typename Ty>
inline Tx mod(Tx x, Ty y)
{
    return x - y * floor(x / y);
}

vertex Main_out Main_00008290_63cb6c03(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_SpriteVF& SpriteVF [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]], texture_buffer<float> CutoutGeometry [[texture(0)]], texture2d<float> View_AtmosphereTransmittanceTexture [[texture(1)]], texture2d<float> View_AtmosphereIrradianceTexture [[texture(2)]], texture3d<float> View_AtmosphereInscatterTexture [[texture(3)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(4)]], sampler View_AtmosphereTransmittanceTextureSampler [[sampler(0)]], sampler View_AtmosphereIrradianceTextureSampler [[sampler(1)]], sampler View_AtmosphereInscatterTextureSampler [[sampler(2)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    float4 _243 = float4(in.in_var_ATTRIBUTE0.xyz, 1.0);
    float4 _246 = Primitive.Primitive_LocalToWorld * _243;
    float3 _252 = _246.xyz;
    float3 _256 = float3(SpriteVF.SpriteVF_RemoveHMDRoll);
    float3 _265 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _256), SpriteVF.SpriteVF_AxisLockRight.xyz, float3(SpriteVF.SpriteVF_AxisLockRight.w));
    float3 _273 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _256), SpriteVF.SpriteVF_AxisLockUp.xyz, float3(SpriteVF.SpriteVF_AxisLockUp.w));
    float3 _274 = View.View_WorldCameraOrigin - _252;
    float _275 = dot(_274, _274);
    float3 _278 = _274 * rsqrt(fast::max(_275, 9.9999999392252902907785028219223e-09));
    float3 _348;
    float3 _349;
    if (SpriteVF.SpriteVF_CameraFacingBlend[0] > 0.0)
    {
        float3 _337 = cross(_278, float3(0.0, 0.0, 1.0));
        float3 _341 = _337 * rsqrt(fast::max(dot(_337, _337), 9.9999999392252902907785028219223e-09));
        float3 _343 = float3(fast::clamp((_275 * SpriteVF.SpriteVF_CameraFacingBlend[1]) - SpriteVF.SpriteVF_CameraFacingBlend[2], 0.0, 1.0));
        _348 = normalize(mix(_265, _341, _343));
        _349 = normalize(mix(_273, cross(_278, _341), _343));
    }
    else
    {
        float3 _328;
        float3 _329;
        if (SpriteVF.SpriteVF_TangentSelector.y > 0.0)
        {
            float3 _317 = _252 - (Primitive.Primitive_LocalToWorld * float4(in.in_var_ATTRIBUTE1.xyz, 1.0)).xyz;
            float3 _321 = _317 * rsqrt(fast::max(dot(_317, _317), 9.9999999392252902907785028219223e-09));
            float3 _322 = cross(_278, _321);
            _328 = _322 * rsqrt(fast::max(dot(_322, _322), 9.9999999392252902907785028219223e-09));
            _329 = -_321;
        }
        else
        {
            float3 _315;
            float3 _316;
            if (SpriteVF.SpriteVF_TangentSelector.z > 0.0)
            {
                float3 _309 = cross(SpriteVF.SpriteVF_AxisLockRight.xyz, _278);
                _315 = SpriteVF.SpriteVF_AxisLockRight.xyz;
                _316 = -(_309 * rsqrt(fast::max(dot(_309, _309), 9.9999999392252902907785028219223e-09)));
            }
            else
            {
                float3 _307;
                float3 _308;
                if (SpriteVF.SpriteVF_TangentSelector.w > 0.0)
                {
                    float3 _301 = cross(_278, float3(0.0, 0.0, 1.0));
                    float3 _305 = _301 * rsqrt(fast::max(dot(_301, _301), 9.9999999392252902907785028219223e-09));
                    _307 = _305;
                    _308 = cross(_278, _305);
                }
                else
                {
                    _307 = _265;
                    _308 = _273;
                }
                _315 = _307;
                _316 = _308;
            }
            _328 = _315;
            _329 = _316;
        }
        _348 = _328;
        _349 = _329;
    }
    float _355 = in.in_var_ATTRIBUTE2.z * SpriteVF.SpriteVF_RotationScale;
    float _356 = _355 + SpriteVF.SpriteVF_RotationBias;
    float _357 = sin(_356);
    float _358 = cos(_356);
    float3 _359 = _349 * _357;
    float3 _360 = _348 * _358;
    float3 _361 = _359 + _360;
    float3 _362 = _349 * _358;
    float3 _363 = _348 * _357;
    float3 _364 = _362 - _363;
    float2 _368 = float2(int2(sign(in.in_var_ATTRIBUTE2.xy)));
    float2 _423;
    float2 _424;
    if (_Globals.NumCutoutVerticesPerFrame > 0u)
    {
        uint _390 = uint(mod(float((gl_VertexIndex - gl_BaseVertex)), float(_Globals.NumCutoutVerticesPerFrame)));
        float _399 = _368.x;
        float _400 = _368.y;
        uint _407;
        if ((_399 * _400) < 0.0)
        {
            _407 = (_Globals.NumCutoutVerticesPerFrame - 1u) - _390;
        }
        else
        {
            _407 = _390;
        }
        float4 _411 = CutoutGeometry.read(uint(((uint(mod(in.in_var_ATTRIBUTE2.w, SpriteVF.SpriteVF_SubImageSize.x * SpriteVF.SpriteVF_SubImageSize.y)) * _Globals.NumCutoutVerticesPerFrame) + _407)));
        float _414 = _411.x;
        float2 _417 = _174;
        _417.x = (_399 < 0.0) ? (1.0 - _414) : _414;
        float _419 = _411.y;
        float2 _422 = _417;
        _422.y = (_400 < 0.0) ? (1.0 - _419) : _419;
        _423 = _411.xy;
        _424 = _422;
    }
    else
    {
        float2 _380 = _174;
        _380.x = (_368.x < 0.0) ? (1.0 - in.in_var_ATTRIBUTE4.x) : in.in_var_ATTRIBUTE4.x;
        float2 _386 = _380;
        _386.y = (_368.y < 0.0) ? (1.0 - in.in_var_ATTRIBUTE4.y) : in.in_var_ATTRIBUTE4.y;
        _423 = _386;
        _424 = in.in_var_ATTRIBUTE4;
    }
    float3 _425 = _252 + View.View_PreViewTranslation;
    float _426 = _425.x;
    float _427 = _425.y;
    float _428 = _425.z;
    float4 _429 = float4(_426, _427, _428, 1.0);
    float2 _430 = abs(in.in_var_ATTRIBUTE2.xy);
    float _431 = _361.x;
    float _432 = _361.y;
    float _433 = _361.z;
    float4 _434 = float4(_431, _432, _433, 0.0);
    float _435 = _430.x;
    float _439 = _424.x + SpriteVF.SpriteVF_PivotOffset.x;
    float _440 = _435 * _439;
    float4 _441 = _434 * _440;
    float4 _442 = _429 + _441;
    float _443 = _364.x;
    float _444 = _364.y;
    float _445 = _364.z;
    float4 _446 = float4(_443, _444, _445, 0.0);
    float _447 = _430.y;
    float _451 = _424.y + SpriteVF.SpriteVF_PivotOffset.y;
    float _452 = _447 * _451;
    float4 _453 = _446 * _452;
    float4 _454 = _442 + _453;
    float _456 = fract(in.in_var_ATTRIBUTE2.w);
    float _457 = in.in_var_ATTRIBUTE2.w - _456;
    float _458 = _457 + 1.0;
    float2 _474 = (float2(mod(_457, SpriteVF.SpriteVF_SubImageSize.x), floor(_457 * SpriteVF.SpriteVF_SubImageSize.z)) + _423) * SpriteVF.SpriteVF_SubImageSize.zw;
    float2 _477 = (float2(mod(_458, SpriteVF.SpriteVF_SubImageSize.x), floor(_458 * SpriteVF.SpriteVF_SubImageSize.z)) + _423) * SpriteVF.SpriteVF_SubImageSize.zw;
    float3x3 _478 = _171;
    _478[0] = _361;
    float3x3 _479 = _478;
    _479[1] = _364;
    float3x3 _513;
    if (SpriteVF.SpriteVF_NormalsType < 0.5)
    {
        float3x3 _512 = _479;
        _512[2] = normalize(cross(_361, _364));
        _513 = _512;
    }
    else
    {
        float3x3 _509;
        if (SpriteVF.SpriteVF_NormalsType < 1.5)
        {
            float3x3 _508 = _479;
            _508[2] = normalize(_252 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz);
            _509 = _508;
        }
        else
        {
            float3x3 _502 = _479;
            _502[2] = normalize(_252 - (SpriteVF.SpriteVF_NormalsSphereCenter.xyz + (SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz * dot(SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz, _252 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz))));
            _509 = _502;
        }
        _513 = _509;
    }
    float _514 = _454.x;
    float _515 = _454.y;
    float _516 = _454.z;
    float4 _517 = float4(_514, _515, _516, 1.0);
    float4 _518 = float4(_517.x, _517.y, _517.z, _517.w);
    float4 _519 = View.View_TranslatedWorldToClip * _518;
    float4 _523 = float4(_513[0].x, _513[0].y, _513[0].z, float4(0.0).w);
    _523.w = _456;
    float3 _533 = _517.xyz;
    float3 _534 = _533 - View.View_TranslatedWorldCameraOrigin;
    float _538 = 9.9999997473787516355514526367188e-06 * View.View_AtmosphericFogDistanceScale;
    float3 _546 = View.View_TranslatedWorldCameraOrigin;
    _546.z = (View.View_TranslatedWorldCameraOrigin.z - View.View_AtmosphericFogGroundOffset) * View.View_AtmosphericFogAltitudeScale;
    float3 _547 = _546 * _538;
    float3 _550 = _547;
    _550.z = _547.z + 6360.009765625;
    float _551 = length(_550);
    float3 _552 = normalize(_534);
    float _553 = dot(_550, _552);
    float _554 = _553 / _551;
    float _556 = (-_551) * _554;
    float _560 = (_551 * _551) * ((_554 * _554) - 1.0);
    float _565 = length(_534) * _538;
    float _569 = fast::max(0.0, _565 - View.View_AtmosphericFogStartDistance);
    float _572 = fast::min((_569 * 0.100000001490116119384765625) / View.View_AtmosphericFogStartDistance, 1.0);
    bool _573 = _565 < (100.0 * View.View_AtmosphericFogDistanceScale);
    float _583;
    float _584;
    if (_573)
    {
        _583 = _572 * View.View_AtmosphericFogPower;
        _584 = fast::max(_565 + View.View_AtmosphericFogDistanceOffset, 1.0);
    }
    else
    {
        _583 = 1.0;
        _584 = _556 - sqrt(_560 + 40449600.0);
    }
    float _590 = _556 - sqrt(_560 + 41344900.0);
    bool _591 = _590 > 0.0;
    float _599;
    float _600;
    float3 _601;
    if (_591)
    {
        _599 = (_553 + _590) * 0.00015552098921034485101699829101562;
        _600 = _584 - _590;
        _601 = _550 + (_552 * _590);
    }
    else
    {
        _599 = _554;
        _600 = _584;
        _601 = _550;
    }
    float _602 = _591 ? 6430.0 : _551;
    bool _603 = _602 < 6360.0146484375;
    float _612;
    float _613;
    float3 _614;
    if (_603)
    {
        float _606 = 6360.0146484375 - _602;
        float3 _608 = _601 - (_552 * _606);
        _612 = dot(_608, _552) * 0.0001572323380969464778900146484375;
        _613 = _600 - _606;
        _614 = _608;
    }
    else
    {
        _612 = _599;
        _613 = _600;
        _614 = _601;
    }
    float _615 = _603 ? 6360.0146484375 : _602;
    float3 _1115;
    float3 _1116;
    if ((_615 <= 6430.0) && (_569 > 0.0))
    {
        float3 _622 = _614 + (_552 * _613);
        float _623 = length(_622);
        float _624 = dot(_552, View.View_AtmosphereLightDirection[0].xyz);
        float _626 = dot(_614, View.View_AtmosphereLightDirection[0].xyz) / _615;
        float _627 = 6360.0 / _615;
        float _630 = sqrt(1.0 - (_627 * _627));
        float _639;
        if (_573)
        {
            _639 = fast::max(_612, 0.1550000011920928955078125 - _630);
        }
        else
        {
            _639 = fast::max(_612, 0.004999999888241291046142578125 - _630);
        }
        float3 _660;
        float _661;
        float _662;
        if (_573)
        {
            float _642 = _552.z;
            float _646 = fast::clamp(exp(-_642) - 0.5, 0.0, 1.0);
            float3 _658;
            float _659;
            if (_646 < 1.0)
            {
                float3 _651 = _552;
                _651.z = fast::max(_642, 0.1500000059604644775390625);
                float3 _652 = normalize(_651);
                float3 _654 = _614 + (_652 * _613);
                _658 = _652;
                _659 = dot(_654, _652) / length(_654);
            }
            else
            {
                _658 = _552;
                _659 = _639;
            }
            _660 = _658;
            _661 = _646;
            _662 = _659;
        }
        else
        {
            _660 = _552;
            _661 = 0.0;
            _662 = _639;
        }
        float _664 = 1.0 + (_624 * _624);
        float _675 = _615 * _615;
        float _677 = sqrt(_675 - 40449600.0);
        float _678 = _615 * _662;
        float _681 = ((_678 * _678) - _675) + 40449600.0;
        float4 _686 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_678 < 0.0) && (_681 > 0.0)));
        float _689 = float(View.View_AtmosphericFogInscatterAltitudeSampleNum);
        float _690 = 0.5 / _689;
        float _693 = 1.0 - (1.0 / _689);
        float _695 = _690 + ((_677 * 0.00105685577727854251861572265625) * _693);
        float _707 = _686.w + ((((_678 * _686.x) + sqrt(_681 + _686.y)) / (_677 + _686.z)) * 0.4921875);
        float _716 = (_624 + 1.0) * 3.5;
        float _717 = floor(_716);
        float _718 = _716 - _717;
        float _719 = _717 + (0.015625 + (((atan(fast::max(_626, -0.19750000536441802978515625) * 5.349621295928955078125) * 0.90909087657928466796875) + 0.7400000095367431640625) * 0.484375));
        float _720 = _719 * 0.125;
        float _724 = 1.0 - _718;
        float _727 = (_719 + 1.0) * 0.125;
        float4 _733 = fast::max((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_720, _707, _695), level(0.0)) * _724) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_727, _707, _695), level(0.0)) * _718), float4(0.0));
        float3 _1099;
        float4 _1100;
        if (_613 > 0.0)
        {
            float2 _744 = float2(_662, _662 + (_613 / _615));
            float2 _745 = _744 * sqrt((0.5 / View.View_AtmosphericFogHeightScaleRayleigh) * _615);
            float2 _748 = float2(int2(sign(_745)));
            float2 _749 = _745 * _745;
            float _765 = 2.0 * _615;
            float _767 = (_613 / _765) + _662;
            float _775 = 6360.0 - _615;
            float2 _785 = _744 * sqrt(0.4166666567325592041015625 * _615);
            float2 _788 = float2(int2(sign(_785)));
            float2 _789 = _785 * _785;
            float3 _818 = exp((float3(-0.0057999999262392520904541015625, -0.013500000350177288055419921875, -0.033100001513957977294921875) * ((sqrt((6.283100128173828125 * View.View_AtmosphericFogHeightScaleRayleigh) * _615) * exp(_775 / View.View_AtmosphericFogHeightScaleRayleigh)) * (((_748.y > _748.x) ? exp(_749.x) : 0.0) + dot((_748 / ((abs(_745) * 2.3192999362945556640625) + sqrt((_749 * 1.519999980926513671875) + float2(4.0)))) * float2(1.0, exp(((-_613) / View.View_AtmosphericFogHeightScaleRayleigh) * _767)), float2(1.0, -1.0))))) - (float3(0.00444444455206394195556640625) * ((sqrt(7.5397205352783203125 * _615) * exp(_775 * 0.833333313465118408203125)) * (((_788.y > _788.x) ? exp(_789.x) : 0.0) + dot((_788 / ((abs(_785) * 2.3192999362945556640625) + sqrt((_789 * 1.519999980926513671875) + float2(4.0)))) * float2(1.0, exp((_613 * (-0.833333313465118408203125)) * _767)), float2(1.0, -1.0))))));
            float _826;
            if (_573)
            {
                _826 = fast::max(_623, _615);
            }
            else
            {
                _826 = _623;
            }
            float4 _1098;
            if (_826 > 6360.009765625)
            {
                float4 _1097;
                if (_661 < 1.0)
                {
                    float4 _837 = _818.xyzx;
                    float _838 = _826 * _826;
                    float _840 = sqrt(_838 - 40449600.0);
                    float _841 = _826 * (dot(_622, _660) / _623);
                    float _844 = ((_841 * _841) - _838) + 40449600.0;
                    float4 _849 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_841 < 0.0) && (_844 > 0.0)));
                    float _852 = _690 + ((_840 * 0.00105685577727854251861572265625) * _693);
                    float _864 = _849.w + ((((_841 * _849.x) + sqrt(_844 + _849.y)) / (_840 + _849.z)) * 0.4921875);
                    float _872 = _717 + (0.015625 + (((atan(fast::max(dot(_622, View.View_AtmosphereLightDirection[0].xyz) / _623, -0.19750000536441802978515625) * 5.349621295928955078125) * 0.90909087657928466796875) + 0.7400000095367431640625) * 0.484375));
                    float _873 = _872 * 0.125;
                    float _879 = (_872 + 1.0) * 0.125;
                    float4 _887 = fast::max(_733 - (_837 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_873, _864, _852), level(0.0)) * _724) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_879, _864, _852), level(0.0)) * _718))), float4(0.0));
                    float4 _1096;
                    if (!_573)
                    {
                        float _931 = _662 - (-_630);
                        float4 _1095;
                        if (abs(_931) < 0.004999999888241291046142578125)
                        {
                            float _938 = (-0.004999999888241291046142578125) - _630;
                            float _940 = _675 + (_613 * _613);
                            float _941 = _765 * _613;
                            float _944 = sqrt(_940 + (_941 * _938));
                            float _945 = _615 * _938;
                            float _948 = 0.004999999888241291046142578125 - _630;
                            float _952 = ((_945 * _945) - _675) + 40449600.0;
                            float4 _957 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_945 < 0.0) && (_952 > 0.0)));
                            float _969 = _957.w + ((((_945 * _957.x) + sqrt(_952 + _957.y)) / (_677 + _957.z)) * 0.4921875);
                            float _979 = _944 * _944;
                            float _981 = sqrt(_979 - 40449600.0);
                            float _982 = _944 * fast::max(_948, (_945 + _613) / _944);
                            float _985 = ((_982 * _982) - _979) + 40449600.0;
                            float4 _990 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_982 < 0.0) && (_985 > 0.0)));
                            float _993 = _690 + ((_981 * 0.00105685577727854251861572265625) * _693);
                            float _1005 = _990.w + ((((_982 * _990.x) + sqrt(_985 + _990.y)) / (_981 + _990.z)) * 0.4921875);
                            float _1020 = sqrt(_940 + (_941 * _948));
                            float _1021 = _615 * _948;
                            float _1027 = ((_1021 * _1021) - _675) + 40449600.0;
                            float4 _1032 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_1021 < 0.0) && (_1027 > 0.0)));
                            float _1044 = _1032.w + ((((_1021 * _1032.x) + sqrt(_1027 + _1032.y)) / (_677 + _1032.z)) * 0.4921875);
                            float _1054 = _1020 * _1020;
                            float _1056 = sqrt(_1054 - 40449600.0);
                            float _1057 = _1020 * fast::max(_948, (_1021 + _613) / _1020);
                            float _1060 = ((_1057 * _1057) - _1054) + 40449600.0;
                            float4 _1065 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_1057 < 0.0) && (_1060 > 0.0)));
                            float _1068 = _690 + ((_1056 * 0.00105685577727854251861572265625) * _693);
                            float _1080 = _1065.w + ((((_1057 * _1065.x) + sqrt(_1060 + _1065.y)) / (_1056 + _1065.z)) * 0.4921875);
                            _1095 = mix(fast::max(((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_720, _969, _695), level(0.0)) * _724) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_727, _969, _695), level(0.0)) * _718)) - (_837 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_873, _1005, _993), level(0.0)) * _724) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_879, _1005, _993), level(0.0)) * _718))), float4(0.0)), fast::max(((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_720, _1044, _695), level(0.0)) * _724) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_727, _1044, _695), level(0.0)) * _718)) - (_837 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_873, _1080, _1068), level(0.0)) * _724) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_879, _1080, _1068), level(0.0)) * _718))), float4(0.0)), float4((_931 + 0.004999999888241291046142578125) * 100.0));
                        }
                        else
                        {
                            _1095 = _887;
                        }
                        _1096 = _1095;
                    }
                    else
                    {
                        float4 _930;
                        if (_661 > 0.0)
                        {
                            float _896 = _615 * _639;
                            float _899 = ((_896 * _896) - _675) + 40449600.0;
                            float4 _904 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_896 < 0.0) && (_899 > 0.0)));
                            float _916 = _904.w + ((((_896 * _904.x) + sqrt(_899 + _904.y)) / (_677 + _904.z)) * 0.4921875);
                            _930 = mix(_887, (float4(1.0) - _837) * fast::max((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_720, _916, _695), level(0.0)) * _724) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_727, _916, _695), level(0.0)) * _718), float4(0.0)), float4(_661));
                        }
                        else
                        {
                            _930 = _887;
                        }
                        _1096 = _930;
                    }
                    _1097 = _1096;
                }
                else
                {
                    _1097 = (float4(1.0) - _818.xyzx) * _733;
                }
                _1098 = _1097;
            }
            else
            {
                _1098 = _733;
            }
            _1099 = _818;
            _1100 = _1098;
        }
        else
        {
            _1099 = float3(1.0);
            _1100 = _733;
        }
        _1115 = _1099;
        _1116 = fast::max((_1100.xyz * (0.0596831031143665313720703125 * _664)) + ((((_1100.xyz * (_1100.w * smoothstep(0.0, 0.0199999995529651641845703125, _626))) / float3(fast::max(_1100.x, 9.9999997473787516355514526367188e-05))) * float3(1.0, 0.429629623889923095703125, 0.17522656917572021484375)) * (((0.042971827089786529541015625 * pow(abs(1.6400001049041748046875 - (1.60000002384185791015625 * _624)), -1.5)) * _664) * 0.37878787517547607421875)), float3(0.0));
    }
    else
    {
        _1115 = float3(1.0);
        _1116 = float3(0.0);
    }
    float3 _1181;
    if ((View.View_AtmosphericFogRenderMask & 2u) == 0u)
    {
        float3 _1180;
        if (_584 > 0.0)
        {
            float3 _1127 = _550 + (_552 * _584);
            float _1128 = length(_1127);
            float3 _1130 = _1127 / float3(_1128);
            float _1131 = dot(_1130, View.View_AtmosphereLightDirection[0].xyz);
            float _1133 = (_1128 - 6360.0) * 0.014285714365541934967041015625;
            float3 _1146 = select(View_AtmosphereTransmittanceTexture.sample(View_AtmosphereTransmittanceTextureSampler, float2(atan((_1131 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt(_1133)), level(0.0)).xyz, float3(0.0), bool3(_573));
            float3 _1158 = ((_1146 * fast::max(_1131, 0.0)) + View_AtmosphereIrradianceTexture.sample(View_AtmosphereIrradianceTextureSampler, float2((_1131 + 0.20000000298023223876953125) * 0.833333313465118408203125, _1133), level(0.0)).xyz) * float3(0.0031830989755690097808837890625);
            float3 _1178;
            if ((!_573) && true)
            {
                float3 _1164 = normalize(View.View_AtmosphereLightDirection[0].xyz - _552);
                _1178 = _1158 + (_1146 * fast::max((0.0199999995529651641845703125 + (0.980000019073486328125 * pow(1.0 - dot(-_552, _1164), 5.0))) * pow(fast::max(dot(_1164, _1130), 0.0), 150.0), 0.0));
            }
            else
            {
                _1178 = _1158;
            }
            _1180 = _1115 * _1178;
        }
        else
        {
            _1180 = float3(0.0);
        }
        _1181 = _1180;
    }
    else
    {
        _1181 = float3(0.0);
    }
    float3 _1218;
    if ((View.View_AtmosphericFogRenderMask & 1u) == 0u)
    {
        float3 _1217;
        switch (0u)
        {
            default:
            {
                if (_584 > 0.0)
                {
                    _1217 = float3(0.0);
                    break;
                }
                else
                {
                    _1217 = (select(float3(1.0), View_AtmosphereTransmittanceTexture.sample(View_AtmosphereTransmittanceTextureSampler, float2(atan((_554 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt((_551 - 6360.0) * 0.014285714365541934967041015625)), level(0.0)).xyz, bool3(_551 <= 6430.0)) * step(View.View_AtmosphereLightDiscCosHalfApexAngle[0].x, dot(_552, View.View_AtmosphereLightDirection[0].xyz))) * View.View_AtmosphereLightDiscLuminance[0].xyz;
                    break;
                }
            }
        }
        _1218 = _1217;
    }
    else
    {
        _1218 = float3(0.0);
    }
    float _1238 = mix(fast::clamp((_1115.x * View.View_AtmosphericFogDensityScale) - View.View_AtmosphericFogDensityOffset, 0.0, 1.0), 1.0, 1.0 - _572);
    float4 _1242 = float4((View.View_AtmosphereLightColor[0].xyz * (View.View_AtmosphericFogSunPower * _583)) * ((_1218 + _1181) + _1116), _1238);
    float4 _1319;
    if (View.View_SkyAtmosphereApplyCameraAerialPerspectiveVolume > 0.0)
    {
        float3 _1256 = (_533 * 9.9999997473787516355514526367188e-06) - (View.View_TranslatedWorldCameraOrigin * 9.9999997473787516355514526367188e-06);
        float _1262 = sqrt((fast::max(0.0, length(_1256) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
        float _1263 = _1262 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
        float _1270;
        if (_1263 < 0.707106769084930419921875)
        {
            _1270 = fast::clamp((_1263 * _1263) * 2.0, 0.0, 1.0);
        }
        else
        {
            _1270 = 1.0;
        }
        float2 _1298;
        if (View.View_RealTimeReflectionCapture != 0.0)
        {
            float3 _1273 = normalize(_1256);
            float _1274 = _1273.z;
            float _1277 = sqrt(1.0 - (_1274 * _1274));
            float2 _1280 = _174;
            _1280.y = (_1274 * 0.5) + 0.5;
            float _1285 = acos(_1273.x / _1277);
            float2 _1290 = _1280;
            _1290.x = (((_1273.y / _1277) < 0.0) ? (6.283185482025146484375 - _1285) : _1285) * 0.15915493667125701904296875;
            _1298 = (_1290 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
        }
        else
        {
            _1298 = ((_519.xy / _519.ww) * float2(0.5, -0.5)) + float2(0.5);
        }
        float4 _1303 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_1298, _1262), level(0.0));
        float3 _1315 = _1242.xyz + (((_1303.xyz * _1270).xyz * View.View_OneOverPreExposure).xyz * _1238);
        float4 _1318 = float4(_1315.x, _1315.y, _1315.z, _172.w);
        _1318.w = _1238 * (1.0 - (_1270 * (1.0 - _1303.w)));
        _1319 = _1318;
    }
    else
    {
        _1319 = _1242;
    }
    out.out_var_TEXCOORD10 = _523;
    out.out_var_TEXCOORD11 = float4(_513[2], float(int(sign(determinant(_513)))));
    out.out_var_TEXCOORD2 = in.in_var_ATTRIBUTE3;
    out.out_var_PARTICLE_SUBUVS = float4(_474.x, _474.y, _477.x, _477.y);
    out.out_var_TEXCOORD7 = _1319;
    out.gl_Position = _519;
    return out;
}

