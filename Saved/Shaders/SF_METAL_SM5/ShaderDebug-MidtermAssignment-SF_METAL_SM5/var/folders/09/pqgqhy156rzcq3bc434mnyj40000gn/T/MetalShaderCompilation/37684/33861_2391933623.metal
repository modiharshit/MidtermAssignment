

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

constant float3x3 _176 = {};
constant float4 _177 = {};
constant float2 _179 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10 [[user(locn0)]];
    float4 out_var_TEXCOORD11 [[user(locn1)]];
    float4 out_var_TEXCOORD1 [[user(locn2)]];
    float4 out_var_TEXCOORD2 [[user(locn3)]];
    float4 out_var_TEXCOORD3_0 [[user(locn4)]];
    float4 out_var_PARTICLE_SUBUVS [[user(locn5)]];
    float4 out_var_TEXCOORD7 [[user(locn6)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float4 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    float4 in_var_ATTRIBUTE3 [[attribute(3)]];
    float2 in_var_ATTRIBUTE4 [[attribute(4)]];
    float4 in_var_ATTRIBUTE5 [[attribute(5)]];
};

// Implementation of the GLSL mod() function, which is slightly different than Metal fmod()
template<typename Tx, typename Ty>
inline Tx mod(Tx x, Ty y)
{
    return x - y * floor(x / y);
}

vertex Main_out Main_00008445_8e9202b7(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_SpriteVF& SpriteVF [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]], texture_buffer<float> CutoutGeometry [[texture(0)]], texture2d<float> View_AtmosphereTransmittanceTexture [[texture(1)]], texture2d<float> View_AtmosphereIrradianceTexture [[texture(2)]], texture3d<float> View_AtmosphereInscatterTexture [[texture(3)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(4)]], sampler View_AtmosphereTransmittanceTextureSampler [[sampler(0)]], sampler View_AtmosphereIrradianceTextureSampler [[sampler(1)]], sampler View_AtmosphereInscatterTextureSampler [[sampler(2)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD3 = {};
    float4 _249 = float4(in.in_var_ATTRIBUTE0.xyz, 1.0);
    float4 _252 = Primitive.Primitive_LocalToWorld * _249;
    float3 _258 = _252.xyz;
    float3 _262 = float3(SpriteVF.SpriteVF_RemoveHMDRoll);
    float3 _271 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _262), SpriteVF.SpriteVF_AxisLockRight.xyz, float3(SpriteVF.SpriteVF_AxisLockRight.w));
    float3 _279 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _262), SpriteVF.SpriteVF_AxisLockUp.xyz, float3(SpriteVF.SpriteVF_AxisLockUp.w));
    float3 _280 = View.View_WorldCameraOrigin - _258;
    float _281 = dot(_280, _280);
    float3 _284 = _280 * rsqrt(fast::max(_281, 9.9999999392252902907785028219223e-09));
    float3 _354;
    float3 _355;
    if (SpriteVF.SpriteVF_CameraFacingBlend[0] > 0.0)
    {
        float3 _343 = cross(_284, float3(0.0, 0.0, 1.0));
        float3 _347 = _343 * rsqrt(fast::max(dot(_343, _343), 9.9999999392252902907785028219223e-09));
        float3 _349 = float3(fast::clamp((_281 * SpriteVF.SpriteVF_CameraFacingBlend[1]) - SpriteVF.SpriteVF_CameraFacingBlend[2], 0.0, 1.0));
        _354 = normalize(mix(_271, _347, _349));
        _355 = normalize(mix(_279, cross(_284, _347), _349));
    }
    else
    {
        float3 _334;
        float3 _335;
        if (SpriteVF.SpriteVF_TangentSelector.y > 0.0)
        {
            float3 _323 = _258 - (Primitive.Primitive_LocalToWorld * float4(in.in_var_ATTRIBUTE1.xyz, 1.0)).xyz;
            float3 _327 = _323 * rsqrt(fast::max(dot(_323, _323), 9.9999999392252902907785028219223e-09));
            float3 _328 = cross(_284, _327);
            _334 = _328 * rsqrt(fast::max(dot(_328, _328), 9.9999999392252902907785028219223e-09));
            _335 = -_327;
        }
        else
        {
            float3 _321;
            float3 _322;
            if (SpriteVF.SpriteVF_TangentSelector.z > 0.0)
            {
                float3 _315 = cross(SpriteVF.SpriteVF_AxisLockRight.xyz, _284);
                _321 = SpriteVF.SpriteVF_AxisLockRight.xyz;
                _322 = -(_315 * rsqrt(fast::max(dot(_315, _315), 9.9999999392252902907785028219223e-09)));
            }
            else
            {
                float3 _313;
                float3 _314;
                if (SpriteVF.SpriteVF_TangentSelector.w > 0.0)
                {
                    float3 _307 = cross(_284, float3(0.0, 0.0, 1.0));
                    float3 _311 = _307 * rsqrt(fast::max(dot(_307, _307), 9.9999999392252902907785028219223e-09));
                    _313 = _311;
                    _314 = cross(_284, _311);
                }
                else
                {
                    _313 = _271;
                    _314 = _279;
                }
                _321 = _313;
                _322 = _314;
            }
            _334 = _321;
            _335 = _322;
        }
        _354 = _334;
        _355 = _335;
    }
    float _361 = in.in_var_ATTRIBUTE2.z * SpriteVF.SpriteVF_RotationScale;
    float _362 = _361 + SpriteVF.SpriteVF_RotationBias;
    float _363 = sin(_362);
    float _364 = cos(_362);
    float3 _365 = _355 * _363;
    float3 _366 = _354 * _364;
    float3 _367 = _365 + _366;
    float3 _368 = _355 * _364;
    float3 _369 = _354 * _363;
    float3 _370 = _368 - _369;
    float2 _374 = float2(int2(sign(in.in_var_ATTRIBUTE2.xy)));
    float2 _429;
    float2 _430;
    if (_Globals.NumCutoutVerticesPerFrame > 0u)
    {
        uint _396 = uint(mod(float((gl_VertexIndex - gl_BaseVertex)), float(_Globals.NumCutoutVerticesPerFrame)));
        float _405 = _374.x;
        float _406 = _374.y;
        uint _413;
        if ((_405 * _406) < 0.0)
        {
            _413 = (_Globals.NumCutoutVerticesPerFrame - 1u) - _396;
        }
        else
        {
            _413 = _396;
        }
        float4 _417 = CutoutGeometry.read(uint(((uint(mod(in.in_var_ATTRIBUTE2.w, SpriteVF.SpriteVF_SubImageSize.x * SpriteVF.SpriteVF_SubImageSize.y)) * _Globals.NumCutoutVerticesPerFrame) + _413)));
        float _420 = _417.x;
        float2 _423 = _179;
        _423.x = (_405 < 0.0) ? (1.0 - _420) : _420;
        float _425 = _417.y;
        float2 _428 = _423;
        _428.y = (_406 < 0.0) ? (1.0 - _425) : _425;
        _429 = _417.xy;
        _430 = _428;
    }
    else
    {
        float2 _386 = _179;
        _386.x = (_374.x < 0.0) ? (1.0 - in.in_var_ATTRIBUTE4.x) : in.in_var_ATTRIBUTE4.x;
        float2 _392 = _386;
        _392.y = (_374.y < 0.0) ? (1.0 - in.in_var_ATTRIBUTE4.y) : in.in_var_ATTRIBUTE4.y;
        _429 = _392;
        _430 = in.in_var_ATTRIBUTE4;
    }
    float3 _431 = _258 + View.View_PreViewTranslation;
    float _432 = _431.x;
    float _433 = _431.y;
    float _434 = _431.z;
    float4 _435 = float4(_432, _433, _434, 1.0);
    float2 _436 = abs(in.in_var_ATTRIBUTE2.xy);
    float _437 = _367.x;
    float _438 = _367.y;
    float _439 = _367.z;
    float4 _440 = float4(_437, _438, _439, 0.0);
    float _441 = _436.x;
    float _445 = _430.x + SpriteVF.SpriteVF_PivotOffset.x;
    float _446 = _441 * _445;
    float4 _447 = _440 * _446;
    float4 _448 = _435 + _447;
    float _449 = _370.x;
    float _450 = _370.y;
    float _451 = _370.z;
    float4 _452 = float4(_449, _450, _451, 0.0);
    float _453 = _436.y;
    float _457 = _430.y + SpriteVF.SpriteVF_PivotOffset.y;
    float _458 = _453 * _457;
    float4 _459 = _452 * _458;
    float4 _460 = _448 + _459;
    float _462 = fract(in.in_var_ATTRIBUTE2.w);
    float _463 = in.in_var_ATTRIBUTE2.w - _462;
    float _464 = _463 + 1.0;
    float2 _480 = (float2(mod(_463, SpriteVF.SpriteVF_SubImageSize.x), floor(_463 * SpriteVF.SpriteVF_SubImageSize.z)) + _429) * SpriteVF.SpriteVF_SubImageSize.zw;
    float2 _483 = (float2(mod(_464, SpriteVF.SpriteVF_SubImageSize.x), floor(_464 * SpriteVF.SpriteVF_SubImageSize.z)) + _429) * SpriteVF.SpriteVF_SubImageSize.zw;
    float3x3 _484 = _176;
    _484[0] = _367;
    float3x3 _485 = _484;
    _485[1] = _370;
    float3x3 _519;
    if (SpriteVF.SpriteVF_NormalsType < 0.5)
    {
        float3x3 _518 = _485;
        _518[2] = normalize(cross(_367, _370));
        _519 = _518;
    }
    else
    {
        float3x3 _515;
        if (SpriteVF.SpriteVF_NormalsType < 1.5)
        {
            float3x3 _514 = _485;
            _514[2] = normalize(_258 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz);
            _515 = _514;
        }
        else
        {
            float3x3 _508 = _485;
            _508[2] = normalize(_258 - (SpriteVF.SpriteVF_NormalsSphereCenter.xyz + (SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz * dot(SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz, _258 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz))));
            _515 = _508;
        }
        _519 = _515;
    }
    float _520 = _460.x;
    float _521 = _460.y;
    float _522 = _460.z;
    float4 _523 = float4(_520, _521, _522, 1.0);
    float4 _524 = float4(_523.x, _523.y, _523.z, _523.w);
    float4 _525 = View.View_TranslatedWorldToClip * _524;
    float4 _530 = float4(_519[0].x, _519[0].y, _519[0].z, float4(0.0).w);
    _530.w = _462;
    spvUnsafeArray<float4, 1> _540 = { float4(_480.x, _480.y, float4(0.0).z, float4(0.0).w) };
    float3 _541 = _523.xyz;
    float3 _542 = _541 - View.View_TranslatedWorldCameraOrigin;
    float _546 = 9.9999997473787516355514526367188e-06 * View.View_AtmosphericFogDistanceScale;
    float3 _554 = View.View_TranslatedWorldCameraOrigin;
    _554.z = (View.View_TranslatedWorldCameraOrigin.z - View.View_AtmosphericFogGroundOffset) * View.View_AtmosphericFogAltitudeScale;
    float3 _555 = _554 * _546;
    float3 _558 = _555;
    _558.z = _555.z + 6360.009765625;
    float _559 = length(_558);
    float3 _560 = normalize(_542);
    float _561 = dot(_558, _560);
    float _562 = _561 / _559;
    float _564 = (-_559) * _562;
    float _568 = (_559 * _559) * ((_562 * _562) - 1.0);
    float _573 = length(_542) * _546;
    float _577 = fast::max(0.0, _573 - View.View_AtmosphericFogStartDistance);
    float _580 = fast::min((_577 * 0.100000001490116119384765625) / View.View_AtmosphericFogStartDistance, 1.0);
    bool _581 = _573 < (100.0 * View.View_AtmosphericFogDistanceScale);
    float _591;
    float _592;
    if (_581)
    {
        _591 = _580 * View.View_AtmosphericFogPower;
        _592 = fast::max(_573 + View.View_AtmosphericFogDistanceOffset, 1.0);
    }
    else
    {
        _591 = 1.0;
        _592 = _564 - sqrt(_568 + 40449600.0);
    }
    float _598 = _564 - sqrt(_568 + 41344900.0);
    bool _599 = _598 > 0.0;
    float _607;
    float _608;
    float3 _609;
    if (_599)
    {
        _607 = (_561 + _598) * 0.00015552098921034485101699829101562;
        _608 = _592 - _598;
        _609 = _558 + (_560 * _598);
    }
    else
    {
        _607 = _562;
        _608 = _592;
        _609 = _558;
    }
    float _610 = _599 ? 6430.0 : _559;
    bool _611 = _610 < 6360.0146484375;
    float _620;
    float _621;
    float3 _622;
    if (_611)
    {
        float _614 = 6360.0146484375 - _610;
        float3 _616 = _609 - (_560 * _614);
        _620 = dot(_616, _560) * 0.0001572323380969464778900146484375;
        _621 = _608 - _614;
        _622 = _616;
    }
    else
    {
        _620 = _607;
        _621 = _608;
        _622 = _609;
    }
    float _623 = _611 ? 6360.0146484375 : _610;
    float3 _1123;
    float3 _1124;
    if ((_623 <= 6430.0) && (_577 > 0.0))
    {
        float3 _630 = _622 + (_560 * _621);
        float _631 = length(_630);
        float _632 = dot(_560, View.View_AtmosphereLightDirection[0].xyz);
        float _634 = dot(_622, View.View_AtmosphereLightDirection[0].xyz) / _623;
        float _635 = 6360.0 / _623;
        float _638 = sqrt(1.0 - (_635 * _635));
        float _647;
        if (_581)
        {
            _647 = fast::max(_620, 0.1550000011920928955078125 - _638);
        }
        else
        {
            _647 = fast::max(_620, 0.004999999888241291046142578125 - _638);
        }
        float3 _668;
        float _669;
        float _670;
        if (_581)
        {
            float _650 = _560.z;
            float _654 = fast::clamp(exp(-_650) - 0.5, 0.0, 1.0);
            float3 _666;
            float _667;
            if (_654 < 1.0)
            {
                float3 _659 = _560;
                _659.z = fast::max(_650, 0.1500000059604644775390625);
                float3 _660 = normalize(_659);
                float3 _662 = _622 + (_660 * _621);
                _666 = _660;
                _667 = dot(_662, _660) / length(_662);
            }
            else
            {
                _666 = _560;
                _667 = _647;
            }
            _668 = _666;
            _669 = _654;
            _670 = _667;
        }
        else
        {
            _668 = _560;
            _669 = 0.0;
            _670 = _647;
        }
        float _672 = 1.0 + (_632 * _632);
        float _683 = _623 * _623;
        float _685 = sqrt(_683 - 40449600.0);
        float _686 = _623 * _670;
        float _689 = ((_686 * _686) - _683) + 40449600.0;
        float4 _694 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_686 < 0.0) && (_689 > 0.0)));
        float _697 = float(View.View_AtmosphericFogInscatterAltitudeSampleNum);
        float _698 = 0.5 / _697;
        float _701 = 1.0 - (1.0 / _697);
        float _703 = _698 + ((_685 * 0.00105685577727854251861572265625) * _701);
        float _715 = _694.w + ((((_686 * _694.x) + sqrt(_689 + _694.y)) / (_685 + _694.z)) * 0.4921875);
        float _724 = (_632 + 1.0) * 3.5;
        float _725 = floor(_724);
        float _726 = _724 - _725;
        float _727 = _725 + (0.015625 + (((atan(fast::max(_634, -0.19750000536441802978515625) * 5.349621295928955078125) * 0.90909087657928466796875) + 0.7400000095367431640625) * 0.484375));
        float _728 = _727 * 0.125;
        float _732 = 1.0 - _726;
        float _735 = (_727 + 1.0) * 0.125;
        float4 _741 = fast::max((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_728, _715, _703), level(0.0)) * _732) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_735, _715, _703), level(0.0)) * _726), float4(0.0));
        float3 _1107;
        float4 _1108;
        if (_621 > 0.0)
        {
            float2 _752 = float2(_670, _670 + (_621 / _623));
            float2 _753 = _752 * sqrt((0.5 / View.View_AtmosphericFogHeightScaleRayleigh) * _623);
            float2 _756 = float2(int2(sign(_753)));
            float2 _757 = _753 * _753;
            float _773 = 2.0 * _623;
            float _775 = (_621 / _773) + _670;
            float _783 = 6360.0 - _623;
            float2 _793 = _752 * sqrt(0.4166666567325592041015625 * _623);
            float2 _796 = float2(int2(sign(_793)));
            float2 _797 = _793 * _793;
            float3 _826 = exp((float3(-0.0057999999262392520904541015625, -0.013500000350177288055419921875, -0.033100001513957977294921875) * ((sqrt((6.283100128173828125 * View.View_AtmosphericFogHeightScaleRayleigh) * _623) * exp(_783 / View.View_AtmosphericFogHeightScaleRayleigh)) * (((_756.y > _756.x) ? exp(_757.x) : 0.0) + dot((_756 / ((abs(_753) * 2.3192999362945556640625) + sqrt((_757 * 1.519999980926513671875) + float2(4.0)))) * float2(1.0, exp(((-_621) / View.View_AtmosphericFogHeightScaleRayleigh) * _775)), float2(1.0, -1.0))))) - (float3(0.00444444455206394195556640625) * ((sqrt(7.5397205352783203125 * _623) * exp(_783 * 0.833333313465118408203125)) * (((_796.y > _796.x) ? exp(_797.x) : 0.0) + dot((_796 / ((abs(_793) * 2.3192999362945556640625) + sqrt((_797 * 1.519999980926513671875) + float2(4.0)))) * float2(1.0, exp((_621 * (-0.833333313465118408203125)) * _775)), float2(1.0, -1.0))))));
            float _834;
            if (_581)
            {
                _834 = fast::max(_631, _623);
            }
            else
            {
                _834 = _631;
            }
            float4 _1106;
            if (_834 > 6360.009765625)
            {
                float4 _1105;
                if (_669 < 1.0)
                {
                    float4 _845 = _826.xyzx;
                    float _846 = _834 * _834;
                    float _848 = sqrt(_846 - 40449600.0);
                    float _849 = _834 * (dot(_630, _668) / _631);
                    float _852 = ((_849 * _849) - _846) + 40449600.0;
                    float4 _857 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_849 < 0.0) && (_852 > 0.0)));
                    float _860 = _698 + ((_848 * 0.00105685577727854251861572265625) * _701);
                    float _872 = _857.w + ((((_849 * _857.x) + sqrt(_852 + _857.y)) / (_848 + _857.z)) * 0.4921875);
                    float _880 = _725 + (0.015625 + (((atan(fast::max(dot(_630, View.View_AtmosphereLightDirection[0].xyz) / _631, -0.19750000536441802978515625) * 5.349621295928955078125) * 0.90909087657928466796875) + 0.7400000095367431640625) * 0.484375));
                    float _881 = _880 * 0.125;
                    float _887 = (_880 + 1.0) * 0.125;
                    float4 _895 = fast::max(_741 - (_845 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_881, _872, _860), level(0.0)) * _732) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_887, _872, _860), level(0.0)) * _726))), float4(0.0));
                    float4 _1104;
                    if (!_581)
                    {
                        float _939 = _670 - (-_638);
                        float4 _1103;
                        if (abs(_939) < 0.004999999888241291046142578125)
                        {
                            float _946 = (-0.004999999888241291046142578125) - _638;
                            float _948 = _683 + (_621 * _621);
                            float _949 = _773 * _621;
                            float _952 = sqrt(_948 + (_949 * _946));
                            float _953 = _623 * _946;
                            float _956 = 0.004999999888241291046142578125 - _638;
                            float _960 = ((_953 * _953) - _683) + 40449600.0;
                            float4 _965 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_953 < 0.0) && (_960 > 0.0)));
                            float _977 = _965.w + ((((_953 * _965.x) + sqrt(_960 + _965.y)) / (_685 + _965.z)) * 0.4921875);
                            float _987 = _952 * _952;
                            float _989 = sqrt(_987 - 40449600.0);
                            float _990 = _952 * fast::max(_956, (_953 + _621) / _952);
                            float _993 = ((_990 * _990) - _987) + 40449600.0;
                            float4 _998 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_990 < 0.0) && (_993 > 0.0)));
                            float _1001 = _698 + ((_989 * 0.00105685577727854251861572265625) * _701);
                            float _1013 = _998.w + ((((_990 * _998.x) + sqrt(_993 + _998.y)) / (_989 + _998.z)) * 0.4921875);
                            float _1028 = sqrt(_948 + (_949 * _956));
                            float _1029 = _623 * _956;
                            float _1035 = ((_1029 * _1029) - _683) + 40449600.0;
                            float4 _1040 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_1029 < 0.0) && (_1035 > 0.0)));
                            float _1052 = _1040.w + ((((_1029 * _1040.x) + sqrt(_1035 + _1040.y)) / (_685 + _1040.z)) * 0.4921875);
                            float _1062 = _1028 * _1028;
                            float _1064 = sqrt(_1062 - 40449600.0);
                            float _1065 = _1028 * fast::max(_956, (_1029 + _621) / _1028);
                            float _1068 = ((_1065 * _1065) - _1062) + 40449600.0;
                            float4 _1073 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_1065 < 0.0) && (_1068 > 0.0)));
                            float _1076 = _698 + ((_1064 * 0.00105685577727854251861572265625) * _701);
                            float _1088 = _1073.w + ((((_1065 * _1073.x) + sqrt(_1068 + _1073.y)) / (_1064 + _1073.z)) * 0.4921875);
                            _1103 = mix(fast::max(((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_728, _977, _703), level(0.0)) * _732) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_735, _977, _703), level(0.0)) * _726)) - (_845 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_881, _1013, _1001), level(0.0)) * _732) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_887, _1013, _1001), level(0.0)) * _726))), float4(0.0)), fast::max(((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_728, _1052, _703), level(0.0)) * _732) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_735, _1052, _703), level(0.0)) * _726)) - (_845 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_881, _1088, _1076), level(0.0)) * _732) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_887, _1088, _1076), level(0.0)) * _726))), float4(0.0)), float4((_939 + 0.004999999888241291046142578125) * 100.0));
                        }
                        else
                        {
                            _1103 = _895;
                        }
                        _1104 = _1103;
                    }
                    else
                    {
                        float4 _938;
                        if (_669 > 0.0)
                        {
                            float _904 = _623 * _647;
                            float _907 = ((_904 * _904) - _683) + 40449600.0;
                            float4 _912 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_904 < 0.0) && (_907 > 0.0)));
                            float _924 = _912.w + ((((_904 * _912.x) + sqrt(_907 + _912.y)) / (_685 + _912.z)) * 0.4921875);
                            _938 = mix(_895, (float4(1.0) - _845) * fast::max((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_728, _924, _703), level(0.0)) * _732) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_735, _924, _703), level(0.0)) * _726), float4(0.0)), float4(_669));
                        }
                        else
                        {
                            _938 = _895;
                        }
                        _1104 = _938;
                    }
                    _1105 = _1104;
                }
                else
                {
                    _1105 = (float4(1.0) - _826.xyzx) * _741;
                }
                _1106 = _1105;
            }
            else
            {
                _1106 = _741;
            }
            _1107 = _826;
            _1108 = _1106;
        }
        else
        {
            _1107 = float3(1.0);
            _1108 = _741;
        }
        _1123 = _1107;
        _1124 = fast::max((_1108.xyz * (0.0596831031143665313720703125 * _672)) + ((((_1108.xyz * (_1108.w * smoothstep(0.0, 0.0199999995529651641845703125, _634))) / float3(fast::max(_1108.x, 9.9999997473787516355514526367188e-05))) * float3(1.0, 0.429629623889923095703125, 0.17522656917572021484375)) * (((0.042971827089786529541015625 * pow(abs(1.6400001049041748046875 - (1.60000002384185791015625 * _632)), -1.5)) * _672) * 0.37878787517547607421875)), float3(0.0));
    }
    else
    {
        _1123 = float3(1.0);
        _1124 = float3(0.0);
    }
    float3 _1189;
    if ((View.View_AtmosphericFogRenderMask & 2u) == 0u)
    {
        float3 _1188;
        if (_592 > 0.0)
        {
            float3 _1135 = _558 + (_560 * _592);
            float _1136 = length(_1135);
            float3 _1138 = _1135 / float3(_1136);
            float _1139 = dot(_1138, View.View_AtmosphereLightDirection[0].xyz);
            float _1141 = (_1136 - 6360.0) * 0.014285714365541934967041015625;
            float3 _1154 = select(View_AtmosphereTransmittanceTexture.sample(View_AtmosphereTransmittanceTextureSampler, float2(atan((_1139 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt(_1141)), level(0.0)).xyz, float3(0.0), bool3(_581));
            float3 _1166 = ((_1154 * fast::max(_1139, 0.0)) + View_AtmosphereIrradianceTexture.sample(View_AtmosphereIrradianceTextureSampler, float2((_1139 + 0.20000000298023223876953125) * 0.833333313465118408203125, _1141), level(0.0)).xyz) * float3(0.0031830989755690097808837890625);
            float3 _1186;
            if ((!_581) && true)
            {
                float3 _1172 = normalize(View.View_AtmosphereLightDirection[0].xyz - _560);
                _1186 = _1166 + (_1154 * fast::max((0.0199999995529651641845703125 + (0.980000019073486328125 * pow(1.0 - dot(-_560, _1172), 5.0))) * pow(fast::max(dot(_1172, _1138), 0.0), 150.0), 0.0));
            }
            else
            {
                _1186 = _1166;
            }
            _1188 = _1123 * _1186;
        }
        else
        {
            _1188 = float3(0.0);
        }
        _1189 = _1188;
    }
    else
    {
        _1189 = float3(0.0);
    }
    float3 _1226;
    if ((View.View_AtmosphericFogRenderMask & 1u) == 0u)
    {
        float3 _1225;
        switch (0u)
        {
            default:
            {
                if (_592 > 0.0)
                {
                    _1225 = float3(0.0);
                    break;
                }
                else
                {
                    _1225 = (select(float3(1.0), View_AtmosphereTransmittanceTexture.sample(View_AtmosphereTransmittanceTextureSampler, float2(atan((_562 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt((_559 - 6360.0) * 0.014285714365541934967041015625)), level(0.0)).xyz, bool3(_559 <= 6430.0)) * step(View.View_AtmosphereLightDiscCosHalfApexAngle[0].x, dot(_560, View.View_AtmosphereLightDirection[0].xyz))) * View.View_AtmosphereLightDiscLuminance[0].xyz;
                    break;
                }
            }
        }
        _1226 = _1225;
    }
    else
    {
        _1226 = float3(0.0);
    }
    float _1246 = mix(fast::clamp((_1123.x * View.View_AtmosphericFogDensityScale) - View.View_AtmosphericFogDensityOffset, 0.0, 1.0), 1.0, 1.0 - _580);
    float4 _1250 = float4((View.View_AtmosphereLightColor[0].xyz * (View.View_AtmosphericFogSunPower * _591)) * ((_1226 + _1189) + _1124), _1246);
    float4 _1327;
    if (View.View_SkyAtmosphereApplyCameraAerialPerspectiveVolume > 0.0)
    {
        float3 _1264 = (_541 * 9.9999997473787516355514526367188e-06) - (View.View_TranslatedWorldCameraOrigin * 9.9999997473787516355514526367188e-06);
        float _1270 = sqrt((fast::max(0.0, length(_1264) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
        float _1271 = _1270 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
        float _1278;
        if (_1271 < 0.707106769084930419921875)
        {
            _1278 = fast::clamp((_1271 * _1271) * 2.0, 0.0, 1.0);
        }
        else
        {
            _1278 = 1.0;
        }
        float2 _1306;
        if (View.View_RealTimeReflectionCapture != 0.0)
        {
            float3 _1281 = normalize(_1264);
            float _1282 = _1281.z;
            float _1285 = sqrt(1.0 - (_1282 * _1282));
            float2 _1288 = _179;
            _1288.y = (_1282 * 0.5) + 0.5;
            float _1293 = acos(_1281.x / _1285);
            float2 _1298 = _1288;
            _1298.x = (((_1281.y / _1285) < 0.0) ? (6.283185482025146484375 - _1293) : _1293) * 0.15915493667125701904296875;
            _1306 = (_1298 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
        }
        else
        {
            _1306 = ((_525.xy / _525.ww) * float2(0.5, -0.5)) + float2(0.5);
        }
        float4 _1311 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_1306, _1270), level(0.0));
        float3 _1323 = _1250.xyz + (((_1311.xyz * _1278).xyz * View.View_OneOverPreExposure).xyz * _1246);
        float4 _1326 = float4(_1323.x, _1323.y, _1323.z, _177.w);
        _1326.w = _1246 * (1.0 - (_1278 * (1.0 - _1311.w)));
        _1327 = _1326;
    }
    else
    {
        _1327 = _1250;
    }
    out.out_var_TEXCOORD10 = _530;
    out.out_var_TEXCOORD11 = float4(_519[2], float(int(sign(determinant(_519)))));
    out.out_var_TEXCOORD1 = in.in_var_ATTRIBUTE5;
    out.out_var_TEXCOORD2 = in.in_var_ATTRIBUTE3;
    out_var_TEXCOORD3 = _540;
    out.out_var_PARTICLE_SUBUVS = float4(_480.x, _480.y, _483.x, _483.y);
    out.out_var_TEXCOORD7 = _1327;
    out.gl_Position = _525;
    out.out_var_TEXCOORD3_0 = out_var_TEXCOORD3[0];
    return out;
}

