

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

constant float3x3 _174 = {};
constant float4 _175 = {};
constant float2 _177 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10 [[user(locn0)]];
    float4 out_var_TEXCOORD11 [[user(locn1)]];
    float4 out_var_TEXCOORD1 [[user(locn2)]];
    float4 out_var_TEXCOORD3_0 [[user(locn3)]];
    float4 out_var_TEXCOORD7 [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float4 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    float2 in_var_ATTRIBUTE4 [[attribute(4)]];
    float4 in_var_ATTRIBUTE5 [[attribute(5)]];
};

// Implementation of the GLSL mod() function, which is slightly different than Metal fmod()
template<typename Tx, typename Ty>
inline Tx mod(Tx x, Ty y)
{
    return x - y * floor(x / y);
}

vertex Main_out Main_00008279_863d6ea2(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_SpriteVF& SpriteVF [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]], texture_buffer<float> CutoutGeometry [[texture(0)]], texture2d<float> View_AtmosphereTransmittanceTexture [[texture(1)]], texture2d<float> View_AtmosphereIrradianceTexture [[texture(2)]], texture3d<float> View_AtmosphereInscatterTexture [[texture(3)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(4)]], sampler View_AtmosphereTransmittanceTextureSampler [[sampler(0)]], sampler View_AtmosphereIrradianceTextureSampler [[sampler(1)]], sampler View_AtmosphereInscatterTextureSampler [[sampler(2)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD3 = {};
    float4 _246 = float4(in.in_var_ATTRIBUTE0.xyz, 1.0);
    float4 _249 = Primitive.Primitive_LocalToWorld * _246;
    float3 _255 = _249.xyz;
    float3 _259 = float3(SpriteVF.SpriteVF_RemoveHMDRoll);
    float3 _268 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _259), SpriteVF.SpriteVF_AxisLockRight.xyz, float3(SpriteVF.SpriteVF_AxisLockRight.w));
    float3 _276 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _259), SpriteVF.SpriteVF_AxisLockUp.xyz, float3(SpriteVF.SpriteVF_AxisLockUp.w));
    float3 _277 = View.View_WorldCameraOrigin - _255;
    float _278 = dot(_277, _277);
    float3 _281 = _277 * rsqrt(fast::max(_278, 9.9999999392252902907785028219223e-09));
    float3 _351;
    float3 _352;
    if (SpriteVF.SpriteVF_CameraFacingBlend[0] > 0.0)
    {
        float3 _340 = cross(_281, float3(0.0, 0.0, 1.0));
        float3 _344 = _340 * rsqrt(fast::max(dot(_340, _340), 9.9999999392252902907785028219223e-09));
        float3 _346 = float3(fast::clamp((_278 * SpriteVF.SpriteVF_CameraFacingBlend[1]) - SpriteVF.SpriteVF_CameraFacingBlend[2], 0.0, 1.0));
        _351 = normalize(mix(_268, _344, _346));
        _352 = normalize(mix(_276, cross(_281, _344), _346));
    }
    else
    {
        float3 _331;
        float3 _332;
        if (SpriteVF.SpriteVF_TangentSelector.y > 0.0)
        {
            float3 _320 = _255 - (Primitive.Primitive_LocalToWorld * float4(in.in_var_ATTRIBUTE1.xyz, 1.0)).xyz;
            float3 _324 = _320 * rsqrt(fast::max(dot(_320, _320), 9.9999999392252902907785028219223e-09));
            float3 _325 = cross(_281, _324);
            _331 = _325 * rsqrt(fast::max(dot(_325, _325), 9.9999999392252902907785028219223e-09));
            _332 = -_324;
        }
        else
        {
            float3 _318;
            float3 _319;
            if (SpriteVF.SpriteVF_TangentSelector.z > 0.0)
            {
                float3 _312 = cross(SpriteVF.SpriteVF_AxisLockRight.xyz, _281);
                _318 = SpriteVF.SpriteVF_AxisLockRight.xyz;
                _319 = -(_312 * rsqrt(fast::max(dot(_312, _312), 9.9999999392252902907785028219223e-09)));
            }
            else
            {
                float3 _310;
                float3 _311;
                if (SpriteVF.SpriteVF_TangentSelector.w > 0.0)
                {
                    float3 _304 = cross(_281, float3(0.0, 0.0, 1.0));
                    float3 _308 = _304 * rsqrt(fast::max(dot(_304, _304), 9.9999999392252902907785028219223e-09));
                    _310 = _308;
                    _311 = cross(_281, _308);
                }
                else
                {
                    _310 = _268;
                    _311 = _276;
                }
                _318 = _310;
                _319 = _311;
            }
            _331 = _318;
            _332 = _319;
        }
        _351 = _331;
        _352 = _332;
    }
    float _358 = in.in_var_ATTRIBUTE2.z * SpriteVF.SpriteVF_RotationScale;
    float _359 = _358 + SpriteVF.SpriteVF_RotationBias;
    float _360 = sin(_359);
    float _361 = cos(_359);
    float3 _362 = _352 * _360;
    float3 _363 = _351 * _361;
    float3 _364 = _362 + _363;
    float3 _365 = _352 * _361;
    float3 _366 = _351 * _360;
    float3 _367 = _365 - _366;
    float2 _371 = float2(int2(sign(in.in_var_ATTRIBUTE2.xy)));
    float2 _426;
    float2 _427;
    if (_Globals.NumCutoutVerticesPerFrame > 0u)
    {
        uint _393 = uint(mod(float((gl_VertexIndex - gl_BaseVertex)), float(_Globals.NumCutoutVerticesPerFrame)));
        float _402 = _371.x;
        float _403 = _371.y;
        uint _410;
        if ((_402 * _403) < 0.0)
        {
            _410 = (_Globals.NumCutoutVerticesPerFrame - 1u) - _393;
        }
        else
        {
            _410 = _393;
        }
        float4 _414 = CutoutGeometry.read(uint(((uint(mod(in.in_var_ATTRIBUTE2.w, SpriteVF.SpriteVF_SubImageSize.x * SpriteVF.SpriteVF_SubImageSize.y)) * _Globals.NumCutoutVerticesPerFrame) + _410)));
        float _417 = _414.x;
        float2 _420 = _177;
        _420.x = (_402 < 0.0) ? (1.0 - _417) : _417;
        float _422 = _414.y;
        float2 _425 = _420;
        _425.y = (_403 < 0.0) ? (1.0 - _422) : _422;
        _426 = _414.xy;
        _427 = _425;
    }
    else
    {
        float2 _383 = _177;
        _383.x = (_371.x < 0.0) ? (1.0 - in.in_var_ATTRIBUTE4.x) : in.in_var_ATTRIBUTE4.x;
        float2 _389 = _383;
        _389.y = (_371.y < 0.0) ? (1.0 - in.in_var_ATTRIBUTE4.y) : in.in_var_ATTRIBUTE4.y;
        _426 = _389;
        _427 = in.in_var_ATTRIBUTE4;
    }
    float3 _428 = _255 + View.View_PreViewTranslation;
    float _429 = _428.x;
    float _430 = _428.y;
    float _431 = _428.z;
    float4 _432 = float4(_429, _430, _431, 1.0);
    float2 _433 = abs(in.in_var_ATTRIBUTE2.xy);
    float _434 = _364.x;
    float _435 = _364.y;
    float _436 = _364.z;
    float4 _437 = float4(_434, _435, _436, 0.0);
    float _438 = _433.x;
    float _442 = _427.x + SpriteVF.SpriteVF_PivotOffset.x;
    float _443 = _438 * _442;
    float4 _444 = _437 * _443;
    float4 _445 = _432 + _444;
    float _446 = _367.x;
    float _447 = _367.y;
    float _448 = _367.z;
    float4 _449 = float4(_446, _447, _448, 0.0);
    float _450 = _433.y;
    float _454 = _427.y + SpriteVF.SpriteVF_PivotOffset.y;
    float _455 = _450 * _454;
    float4 _456 = _449 * _455;
    float4 _457 = _445 + _456;
    float _459 = fract(in.in_var_ATTRIBUTE2.w);
    float _460 = in.in_var_ATTRIBUTE2.w - _459;
    float2 _473 = (float2(mod(_460, SpriteVF.SpriteVF_SubImageSize.x), floor(_460 * SpriteVF.SpriteVF_SubImageSize.z)) + _426) * SpriteVF.SpriteVF_SubImageSize.zw;
    float3x3 _474 = _174;
    _474[0] = _364;
    float3x3 _475 = _474;
    _475[1] = _367;
    float3x3 _509;
    if (SpriteVF.SpriteVF_NormalsType < 0.5)
    {
        float3x3 _508 = _475;
        _508[2] = normalize(cross(_364, _367));
        _509 = _508;
    }
    else
    {
        float3x3 _505;
        if (SpriteVF.SpriteVF_NormalsType < 1.5)
        {
            float3x3 _504 = _475;
            _504[2] = normalize(_255 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz);
            _505 = _504;
        }
        else
        {
            float3x3 _498 = _475;
            _498[2] = normalize(_255 - (SpriteVF.SpriteVF_NormalsSphereCenter.xyz + (SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz * dot(SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz, _255 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz))));
            _505 = _498;
        }
        _509 = _505;
    }
    float _510 = _457.x;
    float _511 = _457.y;
    float _512 = _457.z;
    float4 _513 = float4(_510, _511, _512, 1.0);
    float4 _514 = float4(_513.x, _513.y, _513.z, _513.w);
    float4 _515 = View.View_TranslatedWorldToClip * _514;
    float4 _519 = float4(_509[0].x, _509[0].y, _509[0].z, float4(0.0).w);
    _519.w = _459;
    spvUnsafeArray<float4, 1> _529 = { float4(_473.x, _473.y, float4(0.0).z, float4(0.0).w) };
    float3 _530 = _513.xyz;
    float3 _531 = _530 - View.View_TranslatedWorldCameraOrigin;
    float _535 = 9.9999997473787516355514526367188e-06 * View.View_AtmosphericFogDistanceScale;
    float3 _543 = View.View_TranslatedWorldCameraOrigin;
    _543.z = (View.View_TranslatedWorldCameraOrigin.z - View.View_AtmosphericFogGroundOffset) * View.View_AtmosphericFogAltitudeScale;
    float3 _544 = _543 * _535;
    float3 _547 = _544;
    _547.z = _544.z + 6360.009765625;
    float _548 = length(_547);
    float3 _549 = normalize(_531);
    float _550 = dot(_547, _549);
    float _551 = _550 / _548;
    float _553 = (-_548) * _551;
    float _557 = (_548 * _548) * ((_551 * _551) - 1.0);
    float _562 = length(_531) * _535;
    float _566 = fast::max(0.0, _562 - View.View_AtmosphericFogStartDistance);
    float _569 = fast::min((_566 * 0.100000001490116119384765625) / View.View_AtmosphericFogStartDistance, 1.0);
    bool _570 = _562 < (100.0 * View.View_AtmosphericFogDistanceScale);
    float _580;
    float _581;
    if (_570)
    {
        _580 = _569 * View.View_AtmosphericFogPower;
        _581 = fast::max(_562 + View.View_AtmosphericFogDistanceOffset, 1.0);
    }
    else
    {
        _580 = 1.0;
        _581 = _553 - sqrt(_557 + 40449600.0);
    }
    float _587 = _553 - sqrt(_557 + 41344900.0);
    bool _588 = _587 > 0.0;
    float _596;
    float _597;
    float3 _598;
    if (_588)
    {
        _596 = (_550 + _587) * 0.00015552098921034485101699829101562;
        _597 = _581 - _587;
        _598 = _547 + (_549 * _587);
    }
    else
    {
        _596 = _551;
        _597 = _581;
        _598 = _547;
    }
    float _599 = _588 ? 6430.0 : _548;
    bool _600 = _599 < 6360.0146484375;
    float _609;
    float _610;
    float3 _611;
    if (_600)
    {
        float _603 = 6360.0146484375 - _599;
        float3 _605 = _598 - (_549 * _603);
        _609 = dot(_605, _549) * 0.0001572323380969464778900146484375;
        _610 = _597 - _603;
        _611 = _605;
    }
    else
    {
        _609 = _596;
        _610 = _597;
        _611 = _598;
    }
    float _612 = _600 ? 6360.0146484375 : _599;
    float3 _1112;
    float3 _1113;
    if ((_612 <= 6430.0) && (_566 > 0.0))
    {
        float3 _619 = _611 + (_549 * _610);
        float _620 = length(_619);
        float _621 = dot(_549, View.View_AtmosphereLightDirection[0].xyz);
        float _623 = dot(_611, View.View_AtmosphereLightDirection[0].xyz) / _612;
        float _624 = 6360.0 / _612;
        float _627 = sqrt(1.0 - (_624 * _624));
        float _636;
        if (_570)
        {
            _636 = fast::max(_609, 0.1550000011920928955078125 - _627);
        }
        else
        {
            _636 = fast::max(_609, 0.004999999888241291046142578125 - _627);
        }
        float3 _657;
        float _658;
        float _659;
        if (_570)
        {
            float _639 = _549.z;
            float _643 = fast::clamp(exp(-_639) - 0.5, 0.0, 1.0);
            float3 _655;
            float _656;
            if (_643 < 1.0)
            {
                float3 _648 = _549;
                _648.z = fast::max(_639, 0.1500000059604644775390625);
                float3 _649 = normalize(_648);
                float3 _651 = _611 + (_649 * _610);
                _655 = _649;
                _656 = dot(_651, _649) / length(_651);
            }
            else
            {
                _655 = _549;
                _656 = _636;
            }
            _657 = _655;
            _658 = _643;
            _659 = _656;
        }
        else
        {
            _657 = _549;
            _658 = 0.0;
            _659 = _636;
        }
        float _661 = 1.0 + (_621 * _621);
        float _672 = _612 * _612;
        float _674 = sqrt(_672 - 40449600.0);
        float _675 = _612 * _659;
        float _678 = ((_675 * _675) - _672) + 40449600.0;
        float4 _683 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_675 < 0.0) && (_678 > 0.0)));
        float _686 = float(View.View_AtmosphericFogInscatterAltitudeSampleNum);
        float _687 = 0.5 / _686;
        float _690 = 1.0 - (1.0 / _686);
        float _692 = _687 + ((_674 * 0.00105685577727854251861572265625) * _690);
        float _704 = _683.w + ((((_675 * _683.x) + sqrt(_678 + _683.y)) / (_674 + _683.z)) * 0.4921875);
        float _713 = (_621 + 1.0) * 3.5;
        float _714 = floor(_713);
        float _715 = _713 - _714;
        float _716 = _714 + (0.015625 + (((atan(fast::max(_623, -0.19750000536441802978515625) * 5.349621295928955078125) * 0.90909087657928466796875) + 0.7400000095367431640625) * 0.484375));
        float _717 = _716 * 0.125;
        float _721 = 1.0 - _715;
        float _724 = (_716 + 1.0) * 0.125;
        float4 _730 = fast::max((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_717, _704, _692), level(0.0)) * _721) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_724, _704, _692), level(0.0)) * _715), float4(0.0));
        float3 _1096;
        float4 _1097;
        if (_610 > 0.0)
        {
            float2 _741 = float2(_659, _659 + (_610 / _612));
            float2 _742 = _741 * sqrt((0.5 / View.View_AtmosphericFogHeightScaleRayleigh) * _612);
            float2 _745 = float2(int2(sign(_742)));
            float2 _746 = _742 * _742;
            float _762 = 2.0 * _612;
            float _764 = (_610 / _762) + _659;
            float _772 = 6360.0 - _612;
            float2 _782 = _741 * sqrt(0.4166666567325592041015625 * _612);
            float2 _785 = float2(int2(sign(_782)));
            float2 _786 = _782 * _782;
            float3 _815 = exp((float3(-0.0057999999262392520904541015625, -0.013500000350177288055419921875, -0.033100001513957977294921875) * ((sqrt((6.283100128173828125 * View.View_AtmosphericFogHeightScaleRayleigh) * _612) * exp(_772 / View.View_AtmosphericFogHeightScaleRayleigh)) * (((_745.y > _745.x) ? exp(_746.x) : 0.0) + dot((_745 / ((abs(_742) * 2.3192999362945556640625) + sqrt((_746 * 1.519999980926513671875) + float2(4.0)))) * float2(1.0, exp(((-_610) / View.View_AtmosphericFogHeightScaleRayleigh) * _764)), float2(1.0, -1.0))))) - (float3(0.00444444455206394195556640625) * ((sqrt(7.5397205352783203125 * _612) * exp(_772 * 0.833333313465118408203125)) * (((_785.y > _785.x) ? exp(_786.x) : 0.0) + dot((_785 / ((abs(_782) * 2.3192999362945556640625) + sqrt((_786 * 1.519999980926513671875) + float2(4.0)))) * float2(1.0, exp((_610 * (-0.833333313465118408203125)) * _764)), float2(1.0, -1.0))))));
            float _823;
            if (_570)
            {
                _823 = fast::max(_620, _612);
            }
            else
            {
                _823 = _620;
            }
            float4 _1095;
            if (_823 > 6360.009765625)
            {
                float4 _1094;
                if (_658 < 1.0)
                {
                    float4 _834 = _815.xyzx;
                    float _835 = _823 * _823;
                    float _837 = sqrt(_835 - 40449600.0);
                    float _838 = _823 * (dot(_619, _657) / _620);
                    float _841 = ((_838 * _838) - _835) + 40449600.0;
                    float4 _846 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_838 < 0.0) && (_841 > 0.0)));
                    float _849 = _687 + ((_837 * 0.00105685577727854251861572265625) * _690);
                    float _861 = _846.w + ((((_838 * _846.x) + sqrt(_841 + _846.y)) / (_837 + _846.z)) * 0.4921875);
                    float _869 = _714 + (0.015625 + (((atan(fast::max(dot(_619, View.View_AtmosphereLightDirection[0].xyz) / _620, -0.19750000536441802978515625) * 5.349621295928955078125) * 0.90909087657928466796875) + 0.7400000095367431640625) * 0.484375));
                    float _870 = _869 * 0.125;
                    float _876 = (_869 + 1.0) * 0.125;
                    float4 _884 = fast::max(_730 - (_834 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_870, _861, _849), level(0.0)) * _721) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_876, _861, _849), level(0.0)) * _715))), float4(0.0));
                    float4 _1093;
                    if (!_570)
                    {
                        float _928 = _659 - (-_627);
                        float4 _1092;
                        if (abs(_928) < 0.004999999888241291046142578125)
                        {
                            float _935 = (-0.004999999888241291046142578125) - _627;
                            float _937 = _672 + (_610 * _610);
                            float _938 = _762 * _610;
                            float _941 = sqrt(_937 + (_938 * _935));
                            float _942 = _612 * _935;
                            float _945 = 0.004999999888241291046142578125 - _627;
                            float _949 = ((_942 * _942) - _672) + 40449600.0;
                            float4 _954 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_942 < 0.0) && (_949 > 0.0)));
                            float _966 = _954.w + ((((_942 * _954.x) + sqrt(_949 + _954.y)) / (_674 + _954.z)) * 0.4921875);
                            float _976 = _941 * _941;
                            float _978 = sqrt(_976 - 40449600.0);
                            float _979 = _941 * fast::max(_945, (_942 + _610) / _941);
                            float _982 = ((_979 * _979) - _976) + 40449600.0;
                            float4 _987 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_979 < 0.0) && (_982 > 0.0)));
                            float _990 = _687 + ((_978 * 0.00105685577727854251861572265625) * _690);
                            float _1002 = _987.w + ((((_979 * _987.x) + sqrt(_982 + _987.y)) / (_978 + _987.z)) * 0.4921875);
                            float _1017 = sqrt(_937 + (_938 * _945));
                            float _1018 = _612 * _945;
                            float _1024 = ((_1018 * _1018) - _672) + 40449600.0;
                            float4 _1029 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_1018 < 0.0) && (_1024 > 0.0)));
                            float _1041 = _1029.w + ((((_1018 * _1029.x) + sqrt(_1024 + _1029.y)) / (_674 + _1029.z)) * 0.4921875);
                            float _1051 = _1017 * _1017;
                            float _1053 = sqrt(_1051 - 40449600.0);
                            float _1054 = _1017 * fast::max(_945, (_1018 + _610) / _1017);
                            float _1057 = ((_1054 * _1054) - _1051) + 40449600.0;
                            float4 _1062 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_1054 < 0.0) && (_1057 > 0.0)));
                            float _1065 = _687 + ((_1053 * 0.00105685577727854251861572265625) * _690);
                            float _1077 = _1062.w + ((((_1054 * _1062.x) + sqrt(_1057 + _1062.y)) / (_1053 + _1062.z)) * 0.4921875);
                            _1092 = mix(fast::max(((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_717, _966, _692), level(0.0)) * _721) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_724, _966, _692), level(0.0)) * _715)) - (_834 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_870, _1002, _990), level(0.0)) * _721) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_876, _1002, _990), level(0.0)) * _715))), float4(0.0)), fast::max(((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_717, _1041, _692), level(0.0)) * _721) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_724, _1041, _692), level(0.0)) * _715)) - (_834 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_870, _1077, _1065), level(0.0)) * _721) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_876, _1077, _1065), level(0.0)) * _715))), float4(0.0)), float4((_928 + 0.004999999888241291046142578125) * 100.0));
                        }
                        else
                        {
                            _1092 = _884;
                        }
                        _1093 = _1092;
                    }
                    else
                    {
                        float4 _927;
                        if (_658 > 0.0)
                        {
                            float _893 = _612 * _636;
                            float _896 = ((_893 * _893) - _672) + 40449600.0;
                            float4 _901 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_893 < 0.0) && (_896 > 0.0)));
                            float _913 = _901.w + ((((_893 * _901.x) + sqrt(_896 + _901.y)) / (_674 + _901.z)) * 0.4921875);
                            _927 = mix(_884, (float4(1.0) - _834) * fast::max((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_717, _913, _692), level(0.0)) * _721) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_724, _913, _692), level(0.0)) * _715), float4(0.0)), float4(_658));
                        }
                        else
                        {
                            _927 = _884;
                        }
                        _1093 = _927;
                    }
                    _1094 = _1093;
                }
                else
                {
                    _1094 = (float4(1.0) - _815.xyzx) * _730;
                }
                _1095 = _1094;
            }
            else
            {
                _1095 = _730;
            }
            _1096 = _815;
            _1097 = _1095;
        }
        else
        {
            _1096 = float3(1.0);
            _1097 = _730;
        }
        _1112 = _1096;
        _1113 = fast::max((_1097.xyz * (0.0596831031143665313720703125 * _661)) + ((((_1097.xyz * (_1097.w * smoothstep(0.0, 0.0199999995529651641845703125, _623))) / float3(fast::max(_1097.x, 9.9999997473787516355514526367188e-05))) * float3(1.0, 0.429629623889923095703125, 0.17522656917572021484375)) * (((0.042971827089786529541015625 * pow(abs(1.6400001049041748046875 - (1.60000002384185791015625 * _621)), -1.5)) * _661) * 0.37878787517547607421875)), float3(0.0));
    }
    else
    {
        _1112 = float3(1.0);
        _1113 = float3(0.0);
    }
    float3 _1178;
    if ((View.View_AtmosphericFogRenderMask & 2u) == 0u)
    {
        float3 _1177;
        if (_581 > 0.0)
        {
            float3 _1124 = _547 + (_549 * _581);
            float _1125 = length(_1124);
            float3 _1127 = _1124 / float3(_1125);
            float _1128 = dot(_1127, View.View_AtmosphereLightDirection[0].xyz);
            float _1130 = (_1125 - 6360.0) * 0.014285714365541934967041015625;
            float3 _1143 = select(View_AtmosphereTransmittanceTexture.sample(View_AtmosphereTransmittanceTextureSampler, float2(atan((_1128 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt(_1130)), level(0.0)).xyz, float3(0.0), bool3(_570));
            float3 _1155 = ((_1143 * fast::max(_1128, 0.0)) + View_AtmosphereIrradianceTexture.sample(View_AtmosphereIrradianceTextureSampler, float2((_1128 + 0.20000000298023223876953125) * 0.833333313465118408203125, _1130), level(0.0)).xyz) * float3(0.0031830989755690097808837890625);
            float3 _1175;
            if ((!_570) && true)
            {
                float3 _1161 = normalize(View.View_AtmosphereLightDirection[0].xyz - _549);
                _1175 = _1155 + (_1143 * fast::max((0.0199999995529651641845703125 + (0.980000019073486328125 * pow(1.0 - dot(-_549, _1161), 5.0))) * pow(fast::max(dot(_1161, _1127), 0.0), 150.0), 0.0));
            }
            else
            {
                _1175 = _1155;
            }
            _1177 = _1112 * _1175;
        }
        else
        {
            _1177 = float3(0.0);
        }
        _1178 = _1177;
    }
    else
    {
        _1178 = float3(0.0);
    }
    float3 _1215;
    if ((View.View_AtmosphericFogRenderMask & 1u) == 0u)
    {
        float3 _1214;
        switch (0u)
        {
            default:
            {
                if (_581 > 0.0)
                {
                    _1214 = float3(0.0);
                    break;
                }
                else
                {
                    _1214 = (select(float3(1.0), View_AtmosphereTransmittanceTexture.sample(View_AtmosphereTransmittanceTextureSampler, float2(atan((_551 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt((_548 - 6360.0) * 0.014285714365541934967041015625)), level(0.0)).xyz, bool3(_548 <= 6430.0)) * step(View.View_AtmosphereLightDiscCosHalfApexAngle[0].x, dot(_549, View.View_AtmosphereLightDirection[0].xyz))) * View.View_AtmosphereLightDiscLuminance[0].xyz;
                    break;
                }
            }
        }
        _1215 = _1214;
    }
    else
    {
        _1215 = float3(0.0);
    }
    float _1235 = mix(fast::clamp((_1112.x * View.View_AtmosphericFogDensityScale) - View.View_AtmosphericFogDensityOffset, 0.0, 1.0), 1.0, 1.0 - _569);
    float4 _1239 = float4((View.View_AtmosphereLightColor[0].xyz * (View.View_AtmosphericFogSunPower * _580)) * ((_1215 + _1178) + _1113), _1235);
    float4 _1316;
    if (View.View_SkyAtmosphereApplyCameraAerialPerspectiveVolume > 0.0)
    {
        float3 _1253 = (_530 * 9.9999997473787516355514526367188e-06) - (View.View_TranslatedWorldCameraOrigin * 9.9999997473787516355514526367188e-06);
        float _1259 = sqrt((fast::max(0.0, length(_1253) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
        float _1260 = _1259 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
        float _1267;
        if (_1260 < 0.707106769084930419921875)
        {
            _1267 = fast::clamp((_1260 * _1260) * 2.0, 0.0, 1.0);
        }
        else
        {
            _1267 = 1.0;
        }
        float2 _1295;
        if (View.View_RealTimeReflectionCapture != 0.0)
        {
            float3 _1270 = normalize(_1253);
            float _1271 = _1270.z;
            float _1274 = sqrt(1.0 - (_1271 * _1271));
            float2 _1277 = _177;
            _1277.y = (_1271 * 0.5) + 0.5;
            float _1282 = acos(_1270.x / _1274);
            float2 _1287 = _1277;
            _1287.x = (((_1270.y / _1274) < 0.0) ? (6.283185482025146484375 - _1282) : _1282) * 0.15915493667125701904296875;
            _1295 = (_1287 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
        }
        else
        {
            _1295 = ((_515.xy / _515.ww) * float2(0.5, -0.5)) + float2(0.5);
        }
        float4 _1300 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_1295, _1259), level(0.0));
        float3 _1312 = _1239.xyz + (((_1300.xyz * _1267).xyz * View.View_OneOverPreExposure).xyz * _1235);
        float4 _1315 = float4(_1312.x, _1312.y, _1312.z, _175.w);
        _1315.w = _1235 * (1.0 - (_1267 * (1.0 - _1300.w)));
        _1316 = _1315;
    }
    else
    {
        _1316 = _1239;
    }
    out.out_var_TEXCOORD10 = _519;
    out.out_var_TEXCOORD11 = float4(_509[2], float(int(sign(determinant(_509)))));
    out.out_var_TEXCOORD1 = in.in_var_ATTRIBUTE5;
    out_var_TEXCOORD3 = _529;
    out.out_var_TEXCOORD7 = _1316;
    out.gl_Position = _515;
    out.out_var_TEXCOORD3_0 = out_var_TEXCOORD3[0];
    return out;
}

