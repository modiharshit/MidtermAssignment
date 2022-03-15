

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
    char _m9_pad[224];
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeInvSize;
    char _m10_pad[92];
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
    char _m22_pad[32];
    spvUnsafeArray<float4, 2> View_AtmosphereLightDiscLuminance;
    spvUnsafeArray<float4, 2> View_AtmosphereLightDiscCosHalfApexAngle;
    char _m24_pad[144];
    float4 View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize;
    float View_SkyAtmosphereAerialPerspectiveStartDepthKm;
    float View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
    float View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv;
    char _m28_pad[4];
    float View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv;
    float View_SkyAtmosphereApplyCameraAerialPerspectiveVolume;
    uint View_AtmosphericFogRenderMask;
    uint View_AtmosphericFogInscatterAltitudeSampleNum;
    char _m32_pad[16];
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

constant float3x3 _179 = {};
constant float4 _180 = {};
constant float2 _182 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10 [[user(locn0)]];
    float4 out_var_TEXCOORD11 [[user(locn1)]];
    float4 out_var_TEXCOORD2 [[user(locn2)]];
    float4 out_var_PARTICLE_SUBUVS [[user(locn3)]];
    float3 out_var_PARTICLE_LIGHTING_OFFSET [[user(locn4)]];
    float4 out_var_TEXCOORD7 [[user(locn5)]];
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

vertex Main_out Main_00008454_a1764896(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_SpriteVF& SpriteVF [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]], texture_buffer<float> CutoutGeometry [[texture(0)]], texture2d<float> View_AtmosphereTransmittanceTexture [[texture(1)]], texture2d<float> View_AtmosphereIrradianceTexture [[texture(2)]], texture3d<float> View_AtmosphereInscatterTexture [[texture(3)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(4)]], sampler View_AtmosphereTransmittanceTextureSampler [[sampler(0)]], sampler View_AtmosphereIrradianceTextureSampler [[sampler(1)]], sampler View_AtmosphereInscatterTextureSampler [[sampler(2)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    float4 _251 = float4(in.in_var_ATTRIBUTE0.xyz, 1.0);
    float4 _254 = Primitive.Primitive_LocalToWorld * _251;
    float3 _260 = _254.xyz;
    float3 _264 = float3(SpriteVF.SpriteVF_RemoveHMDRoll);
    float3 _273 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _264), SpriteVF.SpriteVF_AxisLockRight.xyz, float3(SpriteVF.SpriteVF_AxisLockRight.w));
    float3 _281 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _264), SpriteVF.SpriteVF_AxisLockUp.xyz, float3(SpriteVF.SpriteVF_AxisLockUp.w));
    float3 _282 = View.View_WorldCameraOrigin - _260;
    float _283 = dot(_282, _282);
    float3 _286 = _282 * rsqrt(fast::max(_283, 9.9999999392252902907785028219223e-09));
    float3 _356;
    float3 _357;
    if (SpriteVF.SpriteVF_CameraFacingBlend[0] > 0.0)
    {
        float3 _345 = cross(_286, float3(0.0, 0.0, 1.0));
        float3 _349 = _345 * rsqrt(fast::max(dot(_345, _345), 9.9999999392252902907785028219223e-09));
        float3 _351 = float3(fast::clamp((_283 * SpriteVF.SpriteVF_CameraFacingBlend[1]) - SpriteVF.SpriteVF_CameraFacingBlend[2], 0.0, 1.0));
        _356 = normalize(mix(_273, _349, _351));
        _357 = normalize(mix(_281, cross(_286, _349), _351));
    }
    else
    {
        float3 _336;
        float3 _337;
        if (SpriteVF.SpriteVF_TangentSelector.y > 0.0)
        {
            float3 _325 = _260 - (Primitive.Primitive_LocalToWorld * float4(in.in_var_ATTRIBUTE1.xyz, 1.0)).xyz;
            float3 _329 = _325 * rsqrt(fast::max(dot(_325, _325), 9.9999999392252902907785028219223e-09));
            float3 _330 = cross(_286, _329);
            _336 = _330 * rsqrt(fast::max(dot(_330, _330), 9.9999999392252902907785028219223e-09));
            _337 = -_329;
        }
        else
        {
            float3 _323;
            float3 _324;
            if (SpriteVF.SpriteVF_TangentSelector.z > 0.0)
            {
                float3 _317 = cross(SpriteVF.SpriteVF_AxisLockRight.xyz, _286);
                _323 = SpriteVF.SpriteVF_AxisLockRight.xyz;
                _324 = -(_317 * rsqrt(fast::max(dot(_317, _317), 9.9999999392252902907785028219223e-09)));
            }
            else
            {
                float3 _315;
                float3 _316;
                if (SpriteVF.SpriteVF_TangentSelector.w > 0.0)
                {
                    float3 _309 = cross(_286, float3(0.0, 0.0, 1.0));
                    float3 _313 = _309 * rsqrt(fast::max(dot(_309, _309), 9.9999999392252902907785028219223e-09));
                    _315 = _313;
                    _316 = cross(_286, _313);
                }
                else
                {
                    _315 = _273;
                    _316 = _281;
                }
                _323 = _315;
                _324 = _316;
            }
            _336 = _323;
            _337 = _324;
        }
        _356 = _336;
        _357 = _337;
    }
    float _363 = in.in_var_ATTRIBUTE2.z * SpriteVF.SpriteVF_RotationScale;
    float _364 = _363 + SpriteVF.SpriteVF_RotationBias;
    float _365 = sin(_364);
    float _366 = cos(_364);
    float3 _367 = _357 * _365;
    float3 _368 = _356 * _366;
    float3 _369 = _367 + _368;
    float3 _370 = _357 * _366;
    float3 _371 = _356 * _365;
    float3 _372 = _370 - _371;
    float2 _376 = float2(int2(sign(in.in_var_ATTRIBUTE2.xy)));
    float2 _431;
    float2 _432;
    if (_Globals.NumCutoutVerticesPerFrame > 0u)
    {
        uint _398 = uint(mod(float((gl_VertexIndex - gl_BaseVertex)), float(_Globals.NumCutoutVerticesPerFrame)));
        float _407 = _376.x;
        float _408 = _376.y;
        uint _415;
        if ((_407 * _408) < 0.0)
        {
            _415 = (_Globals.NumCutoutVerticesPerFrame - 1u) - _398;
        }
        else
        {
            _415 = _398;
        }
        float4 _419 = CutoutGeometry.read(uint(((uint(mod(in.in_var_ATTRIBUTE2.w, SpriteVF.SpriteVF_SubImageSize.x * SpriteVF.SpriteVF_SubImageSize.y)) * _Globals.NumCutoutVerticesPerFrame) + _415)));
        float _422 = _419.x;
        float2 _425 = _182;
        _425.x = (_407 < 0.0) ? (1.0 - _422) : _422;
        float _427 = _419.y;
        float2 _430 = _425;
        _430.y = (_408 < 0.0) ? (1.0 - _427) : _427;
        _431 = _419.xy;
        _432 = _430;
    }
    else
    {
        float2 _388 = _182;
        _388.x = (_376.x < 0.0) ? (1.0 - in.in_var_ATTRIBUTE4.x) : in.in_var_ATTRIBUTE4.x;
        float2 _394 = _388;
        _394.y = (_376.y < 0.0) ? (1.0 - in.in_var_ATTRIBUTE4.y) : in.in_var_ATTRIBUTE4.y;
        _431 = _394;
        _432 = in.in_var_ATTRIBUTE4;
    }
    float3 _433 = _260 + View.View_PreViewTranslation;
    float _434 = _433.x;
    float _435 = _433.y;
    float _436 = _433.z;
    float4 _437 = float4(_434, _435, _436, 1.0);
    float2 _438 = abs(in.in_var_ATTRIBUTE2.xy);
    float _439 = _369.x;
    float _440 = _369.y;
    float _441 = _369.z;
    float4 _442 = float4(_439, _440, _441, 0.0);
    float _443 = _438.x;
    float _447 = _432.x + SpriteVF.SpriteVF_PivotOffset.x;
    float _448 = _443 * _447;
    float4 _449 = _442 * _448;
    float4 _450 = _437 + _449;
    float _451 = _372.x;
    float _452 = _372.y;
    float _453 = _372.z;
    float4 _454 = float4(_451, _452, _453, 0.0);
    float _455 = _438.y;
    float _459 = _432.y + SpriteVF.SpriteVF_PivotOffset.y;
    float _460 = _455 * _459;
    float4 _461 = _454 * _460;
    float4 _462 = _450 + _461;
    float _464 = fract(in.in_var_ATTRIBUTE2.w);
    float _465 = in.in_var_ATTRIBUTE2.w - _464;
    float _466 = _465 + 1.0;
    float2 _482 = (float2(mod(_465, SpriteVF.SpriteVF_SubImageSize.x), floor(_465 * SpriteVF.SpriteVF_SubImageSize.z)) + _431) * SpriteVF.SpriteVF_SubImageSize.zw;
    float2 _485 = (float2(mod(_466, SpriteVF.SpriteVF_SubImageSize.x), floor(_466 * SpriteVF.SpriteVF_SubImageSize.z)) + _431) * SpriteVF.SpriteVF_SubImageSize.zw;
    float3x3 _486 = _179;
    _486[0] = _369;
    float3x3 _487 = _486;
    _487[1] = _372;
    float3x3 _521;
    if (SpriteVF.SpriteVF_NormalsType < 0.5)
    {
        float3x3 _520 = _487;
        _520[2] = normalize(cross(_369, _372));
        _521 = _520;
    }
    else
    {
        float3x3 _517;
        if (SpriteVF.SpriteVF_NormalsType < 1.5)
        {
            float3x3 _516 = _487;
            _516[2] = normalize(_260 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz);
            _517 = _516;
        }
        else
        {
            float3x3 _510 = _487;
            _510[2] = normalize(_260 - (SpriteVF.SpriteVF_NormalsSphereCenter.xyz + (SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz * dot(SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz, _260 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz))));
            _517 = _510;
        }
        _521 = _517;
    }
    float _523 = in.in_var_ATTRIBUTE1.w + 10.0;
    float _533 = _462.x;
    float _534 = _462.y;
    float _535 = _462.z;
    float4 _536 = float4(_533, _534, _535, 1.0);
    float4 _537 = float4(_536.x, _536.y, _536.z, _536.w);
    float4 _538 = View.View_TranslatedWorldToClip * _537;
    float4 _542 = float4(_521[0].x, _521[0].y, _521[0].z, float4(0.0).w);
    _542.w = _464;
    float3 _552 = _536.xyz;
    float3 _553 = _552 - View.View_TranslatedWorldCameraOrigin;
    float _557 = 9.9999997473787516355514526367188e-06 * View.View_AtmosphericFogDistanceScale;
    float3 _565 = View.View_TranslatedWorldCameraOrigin;
    _565.z = (View.View_TranslatedWorldCameraOrigin.z - View.View_AtmosphericFogGroundOffset) * View.View_AtmosphericFogAltitudeScale;
    float3 _566 = _565 * _557;
    float3 _569 = _566;
    _569.z = _566.z + 6360.009765625;
    float _570 = length(_569);
    float3 _571 = normalize(_553);
    float _572 = dot(_569, _571);
    float _573 = _572 / _570;
    float _575 = (-_570) * _573;
    float _579 = (_570 * _570) * ((_573 * _573) - 1.0);
    float _584 = length(_553) * _557;
    float _588 = fast::max(0.0, _584 - View.View_AtmosphericFogStartDistance);
    float _591 = fast::min((_588 * 0.100000001490116119384765625) / View.View_AtmosphericFogStartDistance, 1.0);
    bool _592 = _584 < (100.0 * View.View_AtmosphericFogDistanceScale);
    float _602;
    float _603;
    if (_592)
    {
        _602 = _591 * View.View_AtmosphericFogPower;
        _603 = fast::max(_584 + View.View_AtmosphericFogDistanceOffset, 1.0);
    }
    else
    {
        _602 = 1.0;
        _603 = _575 - sqrt(_579 + 40449600.0);
    }
    float _609 = _575 - sqrt(_579 + 41344900.0);
    bool _610 = _609 > 0.0;
    float _618;
    float _619;
    float3 _620;
    if (_610)
    {
        _618 = (_572 + _609) * 0.00015552098921034485101699829101562;
        _619 = _603 - _609;
        _620 = _569 + (_571 * _609);
    }
    else
    {
        _618 = _573;
        _619 = _603;
        _620 = _569;
    }
    float _621 = _610 ? 6430.0 : _570;
    bool _622 = _621 < 6360.0146484375;
    float _631;
    float _632;
    float3 _633;
    if (_622)
    {
        float _625 = 6360.0146484375 - _621;
        float3 _627 = _620 - (_571 * _625);
        _631 = dot(_627, _571) * 0.0001572323380969464778900146484375;
        _632 = _619 - _625;
        _633 = _627;
    }
    else
    {
        _631 = _618;
        _632 = _619;
        _633 = _620;
    }
    float _634 = _622 ? 6360.0146484375 : _621;
    float3 _1134;
    float3 _1135;
    if ((_634 <= 6430.0) && (_588 > 0.0))
    {
        float3 _641 = _633 + (_571 * _632);
        float _642 = length(_641);
        float _643 = dot(_571, View.View_AtmosphereLightDirection[0].xyz);
        float _645 = dot(_633, View.View_AtmosphereLightDirection[0].xyz) / _634;
        float _646 = 6360.0 / _634;
        float _649 = sqrt(1.0 - (_646 * _646));
        float _658;
        if (_592)
        {
            _658 = fast::max(_631, 0.1550000011920928955078125 - _649);
        }
        else
        {
            _658 = fast::max(_631, 0.004999999888241291046142578125 - _649);
        }
        float3 _679;
        float _680;
        float _681;
        if (_592)
        {
            float _661 = _571.z;
            float _665 = fast::clamp(exp(-_661) - 0.5, 0.0, 1.0);
            float3 _677;
            float _678;
            if (_665 < 1.0)
            {
                float3 _670 = _571;
                _670.z = fast::max(_661, 0.1500000059604644775390625);
                float3 _671 = normalize(_670);
                float3 _673 = _633 + (_671 * _632);
                _677 = _671;
                _678 = dot(_673, _671) / length(_673);
            }
            else
            {
                _677 = _571;
                _678 = _658;
            }
            _679 = _677;
            _680 = _665;
            _681 = _678;
        }
        else
        {
            _679 = _571;
            _680 = 0.0;
            _681 = _658;
        }
        float _683 = 1.0 + (_643 * _643);
        float _694 = _634 * _634;
        float _696 = sqrt(_694 - 40449600.0);
        float _697 = _634 * _681;
        float _700 = ((_697 * _697) - _694) + 40449600.0;
        float4 _705 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_697 < 0.0) && (_700 > 0.0)));
        float _708 = float(View.View_AtmosphericFogInscatterAltitudeSampleNum);
        float _709 = 0.5 / _708;
        float _712 = 1.0 - (1.0 / _708);
        float _714 = _709 + ((_696 * 0.00105685577727854251861572265625) * _712);
        float _726 = _705.w + ((((_697 * _705.x) + sqrt(_700 + _705.y)) / (_696 + _705.z)) * 0.4921875);
        float _735 = (_643 + 1.0) * 3.5;
        float _736 = floor(_735);
        float _737 = _735 - _736;
        float _738 = _736 + (0.015625 + (((atan(fast::max(_645, -0.19750000536441802978515625) * 5.349621295928955078125) * 0.90909087657928466796875) + 0.7400000095367431640625) * 0.484375));
        float _739 = _738 * 0.125;
        float _743 = 1.0 - _737;
        float _746 = (_738 + 1.0) * 0.125;
        float4 _752 = fast::max((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_739, _726, _714), level(0.0)) * _743) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_746, _726, _714), level(0.0)) * _737), float4(0.0));
        float3 _1118;
        float4 _1119;
        if (_632 > 0.0)
        {
            float2 _763 = float2(_681, _681 + (_632 / _634));
            float2 _764 = _763 * sqrt((0.5 / View.View_AtmosphericFogHeightScaleRayleigh) * _634);
            float2 _767 = float2(int2(sign(_764)));
            float2 _768 = _764 * _764;
            float _784 = 2.0 * _634;
            float _786 = (_632 / _784) + _681;
            float _794 = 6360.0 - _634;
            float2 _804 = _763 * sqrt(0.4166666567325592041015625 * _634);
            float2 _807 = float2(int2(sign(_804)));
            float2 _808 = _804 * _804;
            float3 _837 = exp((float3(-0.0057999999262392520904541015625, -0.013500000350177288055419921875, -0.033100001513957977294921875) * ((sqrt((6.283100128173828125 * View.View_AtmosphericFogHeightScaleRayleigh) * _634) * exp(_794 / View.View_AtmosphericFogHeightScaleRayleigh)) * (((_767.y > _767.x) ? exp(_768.x) : 0.0) + dot((_767 / ((abs(_764) * 2.3192999362945556640625) + sqrt((_768 * 1.519999980926513671875) + float2(4.0)))) * float2(1.0, exp(((-_632) / View.View_AtmosphericFogHeightScaleRayleigh) * _786)), float2(1.0, -1.0))))) - (float3(0.00444444455206394195556640625) * ((sqrt(7.5397205352783203125 * _634) * exp(_794 * 0.833333313465118408203125)) * (((_807.y > _807.x) ? exp(_808.x) : 0.0) + dot((_807 / ((abs(_804) * 2.3192999362945556640625) + sqrt((_808 * 1.519999980926513671875) + float2(4.0)))) * float2(1.0, exp((_632 * (-0.833333313465118408203125)) * _786)), float2(1.0, -1.0))))));
            float _845;
            if (_592)
            {
                _845 = fast::max(_642, _634);
            }
            else
            {
                _845 = _642;
            }
            float4 _1117;
            if (_845 > 6360.009765625)
            {
                float4 _1116;
                if (_680 < 1.0)
                {
                    float4 _856 = _837.xyzx;
                    float _857 = _845 * _845;
                    float _859 = sqrt(_857 - 40449600.0);
                    float _860 = _845 * (dot(_641, _679) / _642);
                    float _863 = ((_860 * _860) - _857) + 40449600.0;
                    float4 _868 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_860 < 0.0) && (_863 > 0.0)));
                    float _871 = _709 + ((_859 * 0.00105685577727854251861572265625) * _712);
                    float _883 = _868.w + ((((_860 * _868.x) + sqrt(_863 + _868.y)) / (_859 + _868.z)) * 0.4921875);
                    float _891 = _736 + (0.015625 + (((atan(fast::max(dot(_641, View.View_AtmosphereLightDirection[0].xyz) / _642, -0.19750000536441802978515625) * 5.349621295928955078125) * 0.90909087657928466796875) + 0.7400000095367431640625) * 0.484375));
                    float _892 = _891 * 0.125;
                    float _898 = (_891 + 1.0) * 0.125;
                    float4 _906 = fast::max(_752 - (_856 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_892, _883, _871), level(0.0)) * _743) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_898, _883, _871), level(0.0)) * _737))), float4(0.0));
                    float4 _1115;
                    if (!_592)
                    {
                        float _950 = _681 - (-_649);
                        float4 _1114;
                        if (abs(_950) < 0.004999999888241291046142578125)
                        {
                            float _957 = (-0.004999999888241291046142578125) - _649;
                            float _959 = _694 + (_632 * _632);
                            float _960 = _784 * _632;
                            float _963 = sqrt(_959 + (_960 * _957));
                            float _964 = _634 * _957;
                            float _967 = 0.004999999888241291046142578125 - _649;
                            float _971 = ((_964 * _964) - _694) + 40449600.0;
                            float4 _976 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_964 < 0.0) && (_971 > 0.0)));
                            float _988 = _976.w + ((((_964 * _976.x) + sqrt(_971 + _976.y)) / (_696 + _976.z)) * 0.4921875);
                            float _998 = _963 * _963;
                            float _1000 = sqrt(_998 - 40449600.0);
                            float _1001 = _963 * fast::max(_967, (_964 + _632) / _963);
                            float _1004 = ((_1001 * _1001) - _998) + 40449600.0;
                            float4 _1009 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_1001 < 0.0) && (_1004 > 0.0)));
                            float _1012 = _709 + ((_1000 * 0.00105685577727854251861572265625) * _712);
                            float _1024 = _1009.w + ((((_1001 * _1009.x) + sqrt(_1004 + _1009.y)) / (_1000 + _1009.z)) * 0.4921875);
                            float _1039 = sqrt(_959 + (_960 * _967));
                            float _1040 = _634 * _967;
                            float _1046 = ((_1040 * _1040) - _694) + 40449600.0;
                            float4 _1051 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_1040 < 0.0) && (_1046 > 0.0)));
                            float _1063 = _1051.w + ((((_1040 * _1051.x) + sqrt(_1046 + _1051.y)) / (_696 + _1051.z)) * 0.4921875);
                            float _1073 = _1039 * _1039;
                            float _1075 = sqrt(_1073 - 40449600.0);
                            float _1076 = _1039 * fast::max(_967, (_1040 + _632) / _1039);
                            float _1079 = ((_1076 * _1076) - _1073) + 40449600.0;
                            float4 _1084 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_1076 < 0.0) && (_1079 > 0.0)));
                            float _1087 = _709 + ((_1075 * 0.00105685577727854251861572265625) * _712);
                            float _1099 = _1084.w + ((((_1076 * _1084.x) + sqrt(_1079 + _1084.y)) / (_1075 + _1084.z)) * 0.4921875);
                            _1114 = mix(fast::max(((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_739, _988, _714), level(0.0)) * _743) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_746, _988, _714), level(0.0)) * _737)) - (_856 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_892, _1024, _1012), level(0.0)) * _743) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_898, _1024, _1012), level(0.0)) * _737))), float4(0.0)), fast::max(((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_739, _1063, _714), level(0.0)) * _743) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_746, _1063, _714), level(0.0)) * _737)) - (_856 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_892, _1099, _1087), level(0.0)) * _743) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_898, _1099, _1087), level(0.0)) * _737))), float4(0.0)), float4((_950 + 0.004999999888241291046142578125) * 100.0));
                        }
                        else
                        {
                            _1114 = _906;
                        }
                        _1115 = _1114;
                    }
                    else
                    {
                        float4 _949;
                        if (_680 > 0.0)
                        {
                            float _915 = _634 * _658;
                            float _918 = ((_915 * _915) - _694) + 40449600.0;
                            float4 _923 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_915 < 0.0) && (_918 > 0.0)));
                            float _935 = _923.w + ((((_915 * _923.x) + sqrt(_918 + _923.y)) / (_696 + _923.z)) * 0.4921875);
                            _949 = mix(_906, (float4(1.0) - _856) * fast::max((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_739, _935, _714), level(0.0)) * _743) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_746, _935, _714), level(0.0)) * _737), float4(0.0)), float4(_680));
                        }
                        else
                        {
                            _949 = _906;
                        }
                        _1115 = _949;
                    }
                    _1116 = _1115;
                }
                else
                {
                    _1116 = (float4(1.0) - _837.xyzx) * _752;
                }
                _1117 = _1116;
            }
            else
            {
                _1117 = _752;
            }
            _1118 = _837;
            _1119 = _1117;
        }
        else
        {
            _1118 = float3(1.0);
            _1119 = _752;
        }
        _1134 = _1118;
        _1135 = fast::max((_1119.xyz * (0.0596831031143665313720703125 * _683)) + ((((_1119.xyz * (_1119.w * smoothstep(0.0, 0.0199999995529651641845703125, _645))) / float3(fast::max(_1119.x, 9.9999997473787516355514526367188e-05))) * float3(1.0, 0.429629623889923095703125, 0.17522656917572021484375)) * (((0.042971827089786529541015625 * pow(abs(1.6400001049041748046875 - (1.60000002384185791015625 * _643)), -1.5)) * _683) * 0.37878787517547607421875)), float3(0.0));
    }
    else
    {
        _1134 = float3(1.0);
        _1135 = float3(0.0);
    }
    float3 _1200;
    if ((View.View_AtmosphericFogRenderMask & 2u) == 0u)
    {
        float3 _1199;
        if (_603 > 0.0)
        {
            float3 _1146 = _569 + (_571 * _603);
            float _1147 = length(_1146);
            float3 _1149 = _1146 / float3(_1147);
            float _1150 = dot(_1149, View.View_AtmosphereLightDirection[0].xyz);
            float _1152 = (_1147 - 6360.0) * 0.014285714365541934967041015625;
            float3 _1165 = select(View_AtmosphereTransmittanceTexture.sample(View_AtmosphereTransmittanceTextureSampler, float2(atan((_1150 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt(_1152)), level(0.0)).xyz, float3(0.0), bool3(_592));
            float3 _1177 = ((_1165 * fast::max(_1150, 0.0)) + View_AtmosphereIrradianceTexture.sample(View_AtmosphereIrradianceTextureSampler, float2((_1150 + 0.20000000298023223876953125) * 0.833333313465118408203125, _1152), level(0.0)).xyz) * float3(0.0031830989755690097808837890625);
            float3 _1197;
            if ((!_592) && true)
            {
                float3 _1183 = normalize(View.View_AtmosphereLightDirection[0].xyz - _571);
                _1197 = _1177 + (_1165 * fast::max((0.0199999995529651641845703125 + (0.980000019073486328125 * pow(1.0 - dot(-_571, _1183), 5.0))) * pow(fast::max(dot(_1183, _1149), 0.0), 150.0), 0.0));
            }
            else
            {
                _1197 = _1177;
            }
            _1199 = _1134 * _1197;
        }
        else
        {
            _1199 = float3(0.0);
        }
        _1200 = _1199;
    }
    else
    {
        _1200 = float3(0.0);
    }
    float3 _1237;
    if ((View.View_AtmosphericFogRenderMask & 1u) == 0u)
    {
        float3 _1236;
        switch (0u)
        {
            default:
            {
                if (_603 > 0.0)
                {
                    _1236 = float3(0.0);
                    break;
                }
                else
                {
                    _1236 = (select(float3(1.0), View_AtmosphereTransmittanceTexture.sample(View_AtmosphereTransmittanceTextureSampler, float2(atan((_573 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt((_570 - 6360.0) * 0.014285714365541934967041015625)), level(0.0)).xyz, bool3(_570 <= 6430.0)) * step(View.View_AtmosphereLightDiscCosHalfApexAngle[0].x, dot(_571, View.View_AtmosphereLightDirection[0].xyz))) * View.View_AtmosphereLightDiscLuminance[0].xyz;
                    break;
                }
            }
        }
        _1237 = _1236;
    }
    else
    {
        _1237 = float3(0.0);
    }
    float _1257 = mix(fast::clamp((_1134.x * View.View_AtmosphericFogDensityScale) - View.View_AtmosphericFogDensityOffset, 0.0, 1.0), 1.0, 1.0 - _591);
    float4 _1261 = float4((View.View_AtmosphereLightColor[0].xyz * (View.View_AtmosphericFogSunPower * _602)) * ((_1237 + _1200) + _1135), _1257);
    float4 _1338;
    if (View.View_SkyAtmosphereApplyCameraAerialPerspectiveVolume > 0.0)
    {
        float3 _1275 = (_552 * 9.9999997473787516355514526367188e-06) - (View.View_TranslatedWorldCameraOrigin * 9.9999997473787516355514526367188e-06);
        float _1281 = sqrt((fast::max(0.0, length(_1275) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
        float _1282 = _1281 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
        float _1289;
        if (_1282 < 0.707106769084930419921875)
        {
            _1289 = fast::clamp((_1282 * _1282) * 2.0, 0.0, 1.0);
        }
        else
        {
            _1289 = 1.0;
        }
        float2 _1317;
        if (View.View_RealTimeReflectionCapture != 0.0)
        {
            float3 _1292 = normalize(_1275);
            float _1293 = _1292.z;
            float _1296 = sqrt(1.0 - (_1293 * _1293));
            float2 _1299 = _182;
            _1299.y = (_1293 * 0.5) + 0.5;
            float _1304 = acos(_1292.x / _1296);
            float2 _1309 = _1299;
            _1309.x = (((_1292.y / _1296) < 0.0) ? (6.283185482025146484375 - _1304) : _1304) * 0.15915493667125701904296875;
            _1317 = (_1309 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
        }
        else
        {
            _1317 = ((_538.xy / _538.ww) * float2(0.5, -0.5)) + float2(0.5);
        }
        float4 _1322 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_1317, _1281), level(0.0));
        float3 _1334 = _1261.xyz + (((_1322.xyz * _1289).xyz * View.View_OneOverPreExposure).xyz * _1257);
        float4 _1337 = float4(_1334.x, _1334.y, _1334.z, _180.w);
        _1337.w = _1257 * (1.0 - (_1289 * (1.0 - _1322.w)));
        _1338 = _1337;
    }
    else
    {
        _1338 = _1261;
    }
    out.out_var_TEXCOORD10 = _542;
    out.out_var_TEXCOORD11 = float4(_521[2], float(int(sign(determinant(_521)))));
    out.out_var_TEXCOORD2 = in.in_var_ATTRIBUTE3;
    out.out_var_PARTICLE_SUBUVS = float4(_482.x, _482.y, _485.x, _485.y);
    out.out_var_PARTICLE_LIGHTING_OFFSET = ((fract(float3(1361.456298828125, 2333.577880859375, 3623.98291015625) * (_523 * _523)) * 2.0) - float3(1.0)) * (0.5 * View.View_TranslucencyLightingVolumeInvSize[0].w);
    out.out_var_TEXCOORD7 = _1338;
    out.gl_Position = _538;
    return out;
}

