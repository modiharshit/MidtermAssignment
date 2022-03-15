

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

constant float3x3 _173 = {};
constant float4 _174 = {};
constant float2 _176 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10 [[user(locn0)]];
    float4 out_var_TEXCOORD11 [[user(locn1)]];
    float4 out_var_TEXCOORD2 [[user(locn2)]];
    float4 out_var_TEXCOORD3_0 [[user(locn3)]];
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

vertex Main_out Main_00008261_92c78ecf(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_SpriteVF& SpriteVF [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]], texture_buffer<float> CutoutGeometry [[texture(0)]], texture2d<float> View_AtmosphereTransmittanceTexture [[texture(1)]], texture2d<float> View_AtmosphereIrradianceTexture [[texture(2)]], texture3d<float> View_AtmosphereInscatterTexture [[texture(3)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(4)]], sampler View_AtmosphereTransmittanceTextureSampler [[sampler(0)]], sampler View_AtmosphereIrradianceTextureSampler [[sampler(1)]], sampler View_AtmosphereInscatterTextureSampler [[sampler(2)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD3 = {};
    float4 _245 = float4(in.in_var_ATTRIBUTE0.xyz, 1.0);
    float4 _248 = Primitive.Primitive_LocalToWorld * _245;
    float3 _254 = _248.xyz;
    float3 _258 = float3(SpriteVF.SpriteVF_RemoveHMDRoll);
    float3 _267 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _258), SpriteVF.SpriteVF_AxisLockRight.xyz, float3(SpriteVF.SpriteVF_AxisLockRight.w));
    float3 _275 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _258), SpriteVF.SpriteVF_AxisLockUp.xyz, float3(SpriteVF.SpriteVF_AxisLockUp.w));
    float3 _276 = View.View_WorldCameraOrigin - _254;
    float _277 = dot(_276, _276);
    float3 _280 = _276 * rsqrt(fast::max(_277, 9.9999999392252902907785028219223e-09));
    float3 _350;
    float3 _351;
    if (SpriteVF.SpriteVF_CameraFacingBlend[0] > 0.0)
    {
        float3 _339 = cross(_280, float3(0.0, 0.0, 1.0));
        float3 _343 = _339 * rsqrt(fast::max(dot(_339, _339), 9.9999999392252902907785028219223e-09));
        float3 _345 = float3(fast::clamp((_277 * SpriteVF.SpriteVF_CameraFacingBlend[1]) - SpriteVF.SpriteVF_CameraFacingBlend[2], 0.0, 1.0));
        _350 = normalize(mix(_267, _343, _345));
        _351 = normalize(mix(_275, cross(_280, _343), _345));
    }
    else
    {
        float3 _330;
        float3 _331;
        if (SpriteVF.SpriteVF_TangentSelector.y > 0.0)
        {
            float3 _319 = _254 - (Primitive.Primitive_LocalToWorld * float4(in.in_var_ATTRIBUTE1.xyz, 1.0)).xyz;
            float3 _323 = _319 * rsqrt(fast::max(dot(_319, _319), 9.9999999392252902907785028219223e-09));
            float3 _324 = cross(_280, _323);
            _330 = _324 * rsqrt(fast::max(dot(_324, _324), 9.9999999392252902907785028219223e-09));
            _331 = -_323;
        }
        else
        {
            float3 _317;
            float3 _318;
            if (SpriteVF.SpriteVF_TangentSelector.z > 0.0)
            {
                float3 _311 = cross(SpriteVF.SpriteVF_AxisLockRight.xyz, _280);
                _317 = SpriteVF.SpriteVF_AxisLockRight.xyz;
                _318 = -(_311 * rsqrt(fast::max(dot(_311, _311), 9.9999999392252902907785028219223e-09)));
            }
            else
            {
                float3 _309;
                float3 _310;
                if (SpriteVF.SpriteVF_TangentSelector.w > 0.0)
                {
                    float3 _303 = cross(_280, float3(0.0, 0.0, 1.0));
                    float3 _307 = _303 * rsqrt(fast::max(dot(_303, _303), 9.9999999392252902907785028219223e-09));
                    _309 = _307;
                    _310 = cross(_280, _307);
                }
                else
                {
                    _309 = _267;
                    _310 = _275;
                }
                _317 = _309;
                _318 = _310;
            }
            _330 = _317;
            _331 = _318;
        }
        _350 = _330;
        _351 = _331;
    }
    float _357 = in.in_var_ATTRIBUTE2.z * SpriteVF.SpriteVF_RotationScale;
    float _358 = _357 + SpriteVF.SpriteVF_RotationBias;
    float _359 = sin(_358);
    float _360 = cos(_358);
    float3 _361 = _351 * _359;
    float3 _362 = _350 * _360;
    float3 _363 = _361 + _362;
    float3 _364 = _351 * _360;
    float3 _365 = _350 * _359;
    float3 _366 = _364 - _365;
    float2 _370 = float2(int2(sign(in.in_var_ATTRIBUTE2.xy)));
    float2 _425;
    float2 _426;
    if (_Globals.NumCutoutVerticesPerFrame > 0u)
    {
        uint _392 = uint(mod(float((gl_VertexIndex - gl_BaseVertex)), float(_Globals.NumCutoutVerticesPerFrame)));
        float _401 = _370.x;
        float _402 = _370.y;
        uint _409;
        if ((_401 * _402) < 0.0)
        {
            _409 = (_Globals.NumCutoutVerticesPerFrame - 1u) - _392;
        }
        else
        {
            _409 = _392;
        }
        float4 _413 = CutoutGeometry.read(uint(((uint(mod(in.in_var_ATTRIBUTE2.w, SpriteVF.SpriteVF_SubImageSize.x * SpriteVF.SpriteVF_SubImageSize.y)) * _Globals.NumCutoutVerticesPerFrame) + _409)));
        float _416 = _413.x;
        float2 _419 = _176;
        _419.x = (_401 < 0.0) ? (1.0 - _416) : _416;
        float _421 = _413.y;
        float2 _424 = _419;
        _424.y = (_402 < 0.0) ? (1.0 - _421) : _421;
        _425 = _413.xy;
        _426 = _424;
    }
    else
    {
        float2 _382 = _176;
        _382.x = (_370.x < 0.0) ? (1.0 - in.in_var_ATTRIBUTE4.x) : in.in_var_ATTRIBUTE4.x;
        float2 _388 = _382;
        _388.y = (_370.y < 0.0) ? (1.0 - in.in_var_ATTRIBUTE4.y) : in.in_var_ATTRIBUTE4.y;
        _425 = _388;
        _426 = in.in_var_ATTRIBUTE4;
    }
    float3 _427 = _254 + View.View_PreViewTranslation;
    float _428 = _427.x;
    float _429 = _427.y;
    float _430 = _427.z;
    float4 _431 = float4(_428, _429, _430, 1.0);
    float2 _432 = abs(in.in_var_ATTRIBUTE2.xy);
    float _433 = _363.x;
    float _434 = _363.y;
    float _435 = _363.z;
    float4 _436 = float4(_433, _434, _435, 0.0);
    float _437 = _432.x;
    float _441 = _426.x + SpriteVF.SpriteVF_PivotOffset.x;
    float _442 = _437 * _441;
    float4 _443 = _436 * _442;
    float4 _444 = _431 + _443;
    float _445 = _366.x;
    float _446 = _366.y;
    float _447 = _366.z;
    float4 _448 = float4(_445, _446, _447, 0.0);
    float _449 = _432.y;
    float _453 = _426.y + SpriteVF.SpriteVF_PivotOffset.y;
    float _454 = _449 * _453;
    float4 _455 = _448 * _454;
    float4 _456 = _444 + _455;
    float _458 = fract(in.in_var_ATTRIBUTE2.w);
    float _459 = in.in_var_ATTRIBUTE2.w - _458;
    float2 _472 = (float2(mod(_459, SpriteVF.SpriteVF_SubImageSize.x), floor(_459 * SpriteVF.SpriteVF_SubImageSize.z)) + _425) * SpriteVF.SpriteVF_SubImageSize.zw;
    float3x3 _473 = _173;
    _473[0] = _363;
    float3x3 _474 = _473;
    _474[1] = _366;
    float3x3 _508;
    if (SpriteVF.SpriteVF_NormalsType < 0.5)
    {
        float3x3 _507 = _474;
        _507[2] = normalize(cross(_363, _366));
        _508 = _507;
    }
    else
    {
        float3x3 _504;
        if (SpriteVF.SpriteVF_NormalsType < 1.5)
        {
            float3x3 _503 = _474;
            _503[2] = normalize(_254 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz);
            _504 = _503;
        }
        else
        {
            float3x3 _497 = _474;
            _497[2] = normalize(_254 - (SpriteVF.SpriteVF_NormalsSphereCenter.xyz + (SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz * dot(SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz, _254 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz))));
            _504 = _497;
        }
        _508 = _504;
    }
    float _509 = _456.x;
    float _510 = _456.y;
    float _511 = _456.z;
    float4 _512 = float4(_509, _510, _511, 1.0);
    float4 _513 = float4(_512.x, _512.y, _512.z, _512.w);
    float4 _514 = View.View_TranslatedWorldToClip * _513;
    float4 _518 = float4(_508[0].x, _508[0].y, _508[0].z, float4(0.0).w);
    _518.w = _458;
    spvUnsafeArray<float4, 1> _528 = { float4(_472.x, _472.y, float4(0.0).z, float4(0.0).w) };
    float3 _529 = _512.xyz;
    float3 _530 = _529 - View.View_TranslatedWorldCameraOrigin;
    float _534 = 9.9999997473787516355514526367188e-06 * View.View_AtmosphericFogDistanceScale;
    float3 _542 = View.View_TranslatedWorldCameraOrigin;
    _542.z = (View.View_TranslatedWorldCameraOrigin.z - View.View_AtmosphericFogGroundOffset) * View.View_AtmosphericFogAltitudeScale;
    float3 _543 = _542 * _534;
    float3 _546 = _543;
    _546.z = _543.z + 6360.009765625;
    float _547 = length(_546);
    float3 _548 = normalize(_530);
    float _549 = dot(_546, _548);
    float _550 = _549 / _547;
    float _552 = (-_547) * _550;
    float _556 = (_547 * _547) * ((_550 * _550) - 1.0);
    float _561 = length(_530) * _534;
    float _565 = fast::max(0.0, _561 - View.View_AtmosphericFogStartDistance);
    float _568 = fast::min((_565 * 0.100000001490116119384765625) / View.View_AtmosphericFogStartDistance, 1.0);
    bool _569 = _561 < (100.0 * View.View_AtmosphericFogDistanceScale);
    float _579;
    float _580;
    if (_569)
    {
        _579 = _568 * View.View_AtmosphericFogPower;
        _580 = fast::max(_561 + View.View_AtmosphericFogDistanceOffset, 1.0);
    }
    else
    {
        _579 = 1.0;
        _580 = _552 - sqrt(_556 + 40449600.0);
    }
    float _586 = _552 - sqrt(_556 + 41344900.0);
    bool _587 = _586 > 0.0;
    float _595;
    float _596;
    float3 _597;
    if (_587)
    {
        _595 = (_549 + _586) * 0.00015552098921034485101699829101562;
        _596 = _580 - _586;
        _597 = _546 + (_548 * _586);
    }
    else
    {
        _595 = _550;
        _596 = _580;
        _597 = _546;
    }
    float _598 = _587 ? 6430.0 : _547;
    bool _599 = _598 < 6360.0146484375;
    float _608;
    float _609;
    float3 _610;
    if (_599)
    {
        float _602 = 6360.0146484375 - _598;
        float3 _604 = _597 - (_548 * _602);
        _608 = dot(_604, _548) * 0.0001572323380969464778900146484375;
        _609 = _596 - _602;
        _610 = _604;
    }
    else
    {
        _608 = _595;
        _609 = _596;
        _610 = _597;
    }
    float _611 = _599 ? 6360.0146484375 : _598;
    float3 _1111;
    float3 _1112;
    if ((_611 <= 6430.0) && (_565 > 0.0))
    {
        float3 _618 = _610 + (_548 * _609);
        float _619 = length(_618);
        float _620 = dot(_548, View.View_AtmosphereLightDirection[0].xyz);
        float _622 = dot(_610, View.View_AtmosphereLightDirection[0].xyz) / _611;
        float _623 = 6360.0 / _611;
        float _626 = sqrt(1.0 - (_623 * _623));
        float _635;
        if (_569)
        {
            _635 = fast::max(_608, 0.1550000011920928955078125 - _626);
        }
        else
        {
            _635 = fast::max(_608, 0.004999999888241291046142578125 - _626);
        }
        float3 _656;
        float _657;
        float _658;
        if (_569)
        {
            float _638 = _548.z;
            float _642 = fast::clamp(exp(-_638) - 0.5, 0.0, 1.0);
            float3 _654;
            float _655;
            if (_642 < 1.0)
            {
                float3 _647 = _548;
                _647.z = fast::max(_638, 0.1500000059604644775390625);
                float3 _648 = normalize(_647);
                float3 _650 = _610 + (_648 * _609);
                _654 = _648;
                _655 = dot(_650, _648) / length(_650);
            }
            else
            {
                _654 = _548;
                _655 = _635;
            }
            _656 = _654;
            _657 = _642;
            _658 = _655;
        }
        else
        {
            _656 = _548;
            _657 = 0.0;
            _658 = _635;
        }
        float _660 = 1.0 + (_620 * _620);
        float _671 = _611 * _611;
        float _673 = sqrt(_671 - 40449600.0);
        float _674 = _611 * _658;
        float _677 = ((_674 * _674) - _671) + 40449600.0;
        float4 _682 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_674 < 0.0) && (_677 > 0.0)));
        float _685 = float(View.View_AtmosphericFogInscatterAltitudeSampleNum);
        float _686 = 0.5 / _685;
        float _689 = 1.0 - (1.0 / _685);
        float _691 = _686 + ((_673 * 0.00105685577727854251861572265625) * _689);
        float _703 = _682.w + ((((_674 * _682.x) + sqrt(_677 + _682.y)) / (_673 + _682.z)) * 0.4921875);
        float _712 = (_620 + 1.0) * 3.5;
        float _713 = floor(_712);
        float _714 = _712 - _713;
        float _715 = _713 + (0.015625 + (((atan(fast::max(_622, -0.19750000536441802978515625) * 5.349621295928955078125) * 0.90909087657928466796875) + 0.7400000095367431640625) * 0.484375));
        float _716 = _715 * 0.125;
        float _720 = 1.0 - _714;
        float _723 = (_715 + 1.0) * 0.125;
        float4 _729 = fast::max((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_716, _703, _691), level(0.0)) * _720) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_723, _703, _691), level(0.0)) * _714), float4(0.0));
        float3 _1095;
        float4 _1096;
        if (_609 > 0.0)
        {
            float2 _740 = float2(_658, _658 + (_609 / _611));
            float2 _741 = _740 * sqrt((0.5 / View.View_AtmosphericFogHeightScaleRayleigh) * _611);
            float2 _744 = float2(int2(sign(_741)));
            float2 _745 = _741 * _741;
            float _761 = 2.0 * _611;
            float _763 = (_609 / _761) + _658;
            float _771 = 6360.0 - _611;
            float2 _781 = _740 * sqrt(0.4166666567325592041015625 * _611);
            float2 _784 = float2(int2(sign(_781)));
            float2 _785 = _781 * _781;
            float3 _814 = exp((float3(-0.0057999999262392520904541015625, -0.013500000350177288055419921875, -0.033100001513957977294921875) * ((sqrt((6.283100128173828125 * View.View_AtmosphericFogHeightScaleRayleigh) * _611) * exp(_771 / View.View_AtmosphericFogHeightScaleRayleigh)) * (((_744.y > _744.x) ? exp(_745.x) : 0.0) + dot((_744 / ((abs(_741) * 2.3192999362945556640625) + sqrt((_745 * 1.519999980926513671875) + float2(4.0)))) * float2(1.0, exp(((-_609) / View.View_AtmosphericFogHeightScaleRayleigh) * _763)), float2(1.0, -1.0))))) - (float3(0.00444444455206394195556640625) * ((sqrt(7.5397205352783203125 * _611) * exp(_771 * 0.833333313465118408203125)) * (((_784.y > _784.x) ? exp(_785.x) : 0.0) + dot((_784 / ((abs(_781) * 2.3192999362945556640625) + sqrt((_785 * 1.519999980926513671875) + float2(4.0)))) * float2(1.0, exp((_609 * (-0.833333313465118408203125)) * _763)), float2(1.0, -1.0))))));
            float _822;
            if (_569)
            {
                _822 = fast::max(_619, _611);
            }
            else
            {
                _822 = _619;
            }
            float4 _1094;
            if (_822 > 6360.009765625)
            {
                float4 _1093;
                if (_657 < 1.0)
                {
                    float4 _833 = _814.xyzx;
                    float _834 = _822 * _822;
                    float _836 = sqrt(_834 - 40449600.0);
                    float _837 = _822 * (dot(_618, _656) / _619);
                    float _840 = ((_837 * _837) - _834) + 40449600.0;
                    float4 _845 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_837 < 0.0) && (_840 > 0.0)));
                    float _848 = _686 + ((_836 * 0.00105685577727854251861572265625) * _689);
                    float _860 = _845.w + ((((_837 * _845.x) + sqrt(_840 + _845.y)) / (_836 + _845.z)) * 0.4921875);
                    float _868 = _713 + (0.015625 + (((atan(fast::max(dot(_618, View.View_AtmosphereLightDirection[0].xyz) / _619, -0.19750000536441802978515625) * 5.349621295928955078125) * 0.90909087657928466796875) + 0.7400000095367431640625) * 0.484375));
                    float _869 = _868 * 0.125;
                    float _875 = (_868 + 1.0) * 0.125;
                    float4 _883 = fast::max(_729 - (_833 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_869, _860, _848), level(0.0)) * _720) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_875, _860, _848), level(0.0)) * _714))), float4(0.0));
                    float4 _1092;
                    if (!_569)
                    {
                        float _927 = _658 - (-_626);
                        float4 _1091;
                        if (abs(_927) < 0.004999999888241291046142578125)
                        {
                            float _934 = (-0.004999999888241291046142578125) - _626;
                            float _936 = _671 + (_609 * _609);
                            float _937 = _761 * _609;
                            float _940 = sqrt(_936 + (_937 * _934));
                            float _941 = _611 * _934;
                            float _944 = 0.004999999888241291046142578125 - _626;
                            float _948 = ((_941 * _941) - _671) + 40449600.0;
                            float4 _953 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_941 < 0.0) && (_948 > 0.0)));
                            float _965 = _953.w + ((((_941 * _953.x) + sqrt(_948 + _953.y)) / (_673 + _953.z)) * 0.4921875);
                            float _975 = _940 * _940;
                            float _977 = sqrt(_975 - 40449600.0);
                            float _978 = _940 * fast::max(_944, (_941 + _609) / _940);
                            float _981 = ((_978 * _978) - _975) + 40449600.0;
                            float4 _986 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_978 < 0.0) && (_981 > 0.0)));
                            float _989 = _686 + ((_977 * 0.00105685577727854251861572265625) * _689);
                            float _1001 = _986.w + ((((_978 * _986.x) + sqrt(_981 + _986.y)) / (_977 + _986.z)) * 0.4921875);
                            float _1016 = sqrt(_936 + (_937 * _944));
                            float _1017 = _611 * _944;
                            float _1023 = ((_1017 * _1017) - _671) + 40449600.0;
                            float4 _1028 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_1017 < 0.0) && (_1023 > 0.0)));
                            float _1040 = _1028.w + ((((_1017 * _1028.x) + sqrt(_1023 + _1028.y)) / (_673 + _1028.z)) * 0.4921875);
                            float _1050 = _1016 * _1016;
                            float _1052 = sqrt(_1050 - 40449600.0);
                            float _1053 = _1016 * fast::max(_944, (_1017 + _609) / _1016);
                            float _1056 = ((_1053 * _1053) - _1050) + 40449600.0;
                            float4 _1061 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_1053 < 0.0) && (_1056 > 0.0)));
                            float _1064 = _686 + ((_1052 * 0.00105685577727854251861572265625) * _689);
                            float _1076 = _1061.w + ((((_1053 * _1061.x) + sqrt(_1056 + _1061.y)) / (_1052 + _1061.z)) * 0.4921875);
                            _1091 = mix(fast::max(((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_716, _965, _691), level(0.0)) * _720) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_723, _965, _691), level(0.0)) * _714)) - (_833 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_869, _1001, _989), level(0.0)) * _720) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_875, _1001, _989), level(0.0)) * _714))), float4(0.0)), fast::max(((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_716, _1040, _691), level(0.0)) * _720) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_723, _1040, _691), level(0.0)) * _714)) - (_833 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_869, _1076, _1064), level(0.0)) * _720) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_875, _1076, _1064), level(0.0)) * _714))), float4(0.0)), float4((_927 + 0.004999999888241291046142578125) * 100.0));
                        }
                        else
                        {
                            _1091 = _883;
                        }
                        _1092 = _1091;
                    }
                    else
                    {
                        float4 _926;
                        if (_657 > 0.0)
                        {
                            float _892 = _611 * _635;
                            float _895 = ((_892 * _892) - _671) + 40449600.0;
                            float4 _900 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_892 < 0.0) && (_895 > 0.0)));
                            float _912 = _900.w + ((((_892 * _900.x) + sqrt(_895 + _900.y)) / (_673 + _900.z)) * 0.4921875);
                            _926 = mix(_883, (float4(1.0) - _833) * fast::max((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_716, _912, _691), level(0.0)) * _720) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_723, _912, _691), level(0.0)) * _714), float4(0.0)), float4(_657));
                        }
                        else
                        {
                            _926 = _883;
                        }
                        _1092 = _926;
                    }
                    _1093 = _1092;
                }
                else
                {
                    _1093 = (float4(1.0) - _814.xyzx) * _729;
                }
                _1094 = _1093;
            }
            else
            {
                _1094 = _729;
            }
            _1095 = _814;
            _1096 = _1094;
        }
        else
        {
            _1095 = float3(1.0);
            _1096 = _729;
        }
        _1111 = _1095;
        _1112 = fast::max((_1096.xyz * (0.0596831031143665313720703125 * _660)) + ((((_1096.xyz * (_1096.w * smoothstep(0.0, 0.0199999995529651641845703125, _622))) / float3(fast::max(_1096.x, 9.9999997473787516355514526367188e-05))) * float3(1.0, 0.429629623889923095703125, 0.17522656917572021484375)) * (((0.042971827089786529541015625 * pow(abs(1.6400001049041748046875 - (1.60000002384185791015625 * _620)), -1.5)) * _660) * 0.37878787517547607421875)), float3(0.0));
    }
    else
    {
        _1111 = float3(1.0);
        _1112 = float3(0.0);
    }
    float3 _1177;
    if ((View.View_AtmosphericFogRenderMask & 2u) == 0u)
    {
        float3 _1176;
        if (_580 > 0.0)
        {
            float3 _1123 = _546 + (_548 * _580);
            float _1124 = length(_1123);
            float3 _1126 = _1123 / float3(_1124);
            float _1127 = dot(_1126, View.View_AtmosphereLightDirection[0].xyz);
            float _1129 = (_1124 - 6360.0) * 0.014285714365541934967041015625;
            float3 _1142 = select(View_AtmosphereTransmittanceTexture.sample(View_AtmosphereTransmittanceTextureSampler, float2(atan((_1127 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt(_1129)), level(0.0)).xyz, float3(0.0), bool3(_569));
            float3 _1154 = ((_1142 * fast::max(_1127, 0.0)) + View_AtmosphereIrradianceTexture.sample(View_AtmosphereIrradianceTextureSampler, float2((_1127 + 0.20000000298023223876953125) * 0.833333313465118408203125, _1129), level(0.0)).xyz) * float3(0.0031830989755690097808837890625);
            float3 _1174;
            if ((!_569) && true)
            {
                float3 _1160 = normalize(View.View_AtmosphereLightDirection[0].xyz - _548);
                _1174 = _1154 + (_1142 * fast::max((0.0199999995529651641845703125 + (0.980000019073486328125 * pow(1.0 - dot(-_548, _1160), 5.0))) * pow(fast::max(dot(_1160, _1126), 0.0), 150.0), 0.0));
            }
            else
            {
                _1174 = _1154;
            }
            _1176 = _1111 * _1174;
        }
        else
        {
            _1176 = float3(0.0);
        }
        _1177 = _1176;
    }
    else
    {
        _1177 = float3(0.0);
    }
    float3 _1214;
    if ((View.View_AtmosphericFogRenderMask & 1u) == 0u)
    {
        float3 _1213;
        switch (0u)
        {
            default:
            {
                if (_580 > 0.0)
                {
                    _1213 = float3(0.0);
                    break;
                }
                else
                {
                    _1213 = (select(float3(1.0), View_AtmosphereTransmittanceTexture.sample(View_AtmosphereTransmittanceTextureSampler, float2(atan((_550 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt((_547 - 6360.0) * 0.014285714365541934967041015625)), level(0.0)).xyz, bool3(_547 <= 6430.0)) * step(View.View_AtmosphereLightDiscCosHalfApexAngle[0].x, dot(_548, View.View_AtmosphereLightDirection[0].xyz))) * View.View_AtmosphereLightDiscLuminance[0].xyz;
                    break;
                }
            }
        }
        _1214 = _1213;
    }
    else
    {
        _1214 = float3(0.0);
    }
    float _1234 = mix(fast::clamp((_1111.x * View.View_AtmosphericFogDensityScale) - View.View_AtmosphericFogDensityOffset, 0.0, 1.0), 1.0, 1.0 - _568);
    float4 _1238 = float4((View.View_AtmosphereLightColor[0].xyz * (View.View_AtmosphericFogSunPower * _579)) * ((_1214 + _1177) + _1112), _1234);
    float4 _1315;
    if (View.View_SkyAtmosphereApplyCameraAerialPerspectiveVolume > 0.0)
    {
        float3 _1252 = (_529 * 9.9999997473787516355514526367188e-06) - (View.View_TranslatedWorldCameraOrigin * 9.9999997473787516355514526367188e-06);
        float _1258 = sqrt((fast::max(0.0, length(_1252) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
        float _1259 = _1258 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
        float _1266;
        if (_1259 < 0.707106769084930419921875)
        {
            _1266 = fast::clamp((_1259 * _1259) * 2.0, 0.0, 1.0);
        }
        else
        {
            _1266 = 1.0;
        }
        float2 _1294;
        if (View.View_RealTimeReflectionCapture != 0.0)
        {
            float3 _1269 = normalize(_1252);
            float _1270 = _1269.z;
            float _1273 = sqrt(1.0 - (_1270 * _1270));
            float2 _1276 = _176;
            _1276.y = (_1270 * 0.5) + 0.5;
            float _1281 = acos(_1269.x / _1273);
            float2 _1286 = _1276;
            _1286.x = (((_1269.y / _1273) < 0.0) ? (6.283185482025146484375 - _1281) : _1281) * 0.15915493667125701904296875;
            _1294 = (_1286 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
        }
        else
        {
            _1294 = ((_514.xy / _514.ww) * float2(0.5, -0.5)) + float2(0.5);
        }
        float4 _1299 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_1294, _1258), level(0.0));
        float3 _1311 = _1238.xyz + (((_1299.xyz * _1266).xyz * View.View_OneOverPreExposure).xyz * _1234);
        float4 _1314 = float4(_1311.x, _1311.y, _1311.z, _174.w);
        _1314.w = _1234 * (1.0 - (_1266 * (1.0 - _1299.w)));
        _1315 = _1314;
    }
    else
    {
        _1315 = _1238;
    }
    out.out_var_TEXCOORD10 = _518;
    out.out_var_TEXCOORD11 = float4(_508[2], float(int(sign(determinant(_508)))));
    out.out_var_TEXCOORD2 = in.in_var_ATTRIBUTE3;
    out_var_TEXCOORD3 = _528;
    out.out_var_TEXCOORD7 = _1315;
    out.gl_Position = _514;
    out.out_var_TEXCOORD3_0 = out_var_TEXCOORD3[0];
    return out;
}

