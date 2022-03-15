

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

constant float3x3 _175 = {};
constant float4 _176 = {};
constant float2 _178 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10 [[user(locn0)]];
    float4 out_var_TEXCOORD11 [[user(locn1)]];
    float4 out_var_TEXCOORD1 [[user(locn2)]];
    float4 out_var_TEXCOORD2 [[user(locn3)]];
    float4 out_var_TEXCOORD3_0 [[user(locn4)]];
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
    float4 in_var_ATTRIBUTE5 [[attribute(5)]];
};

// Implementation of the GLSL mod() function, which is slightly different than Metal fmod()
template<typename Tx, typename Ty>
inline Tx mod(Tx x, Ty y)
{
    return x - y * floor(x / y);
}

vertex Main_out Main_000082fe_e6400a57(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_SpriteVF& SpriteVF [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]], texture_buffer<float> CutoutGeometry [[texture(0)]], texture2d<float> View_AtmosphereTransmittanceTexture [[texture(1)]], texture2d<float> View_AtmosphereIrradianceTexture [[texture(2)]], texture3d<float> View_AtmosphereInscatterTexture [[texture(3)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(4)]], sampler View_AtmosphereTransmittanceTextureSampler [[sampler(0)]], sampler View_AtmosphereIrradianceTextureSampler [[sampler(1)]], sampler View_AtmosphereInscatterTextureSampler [[sampler(2)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD3 = {};
    float4 _248 = float4(in.in_var_ATTRIBUTE0.xyz, 1.0);
    float4 _251 = Primitive.Primitive_LocalToWorld * _248;
    float3 _257 = _251.xyz;
    float3 _261 = float3(SpriteVF.SpriteVF_RemoveHMDRoll);
    float3 _270 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _261), SpriteVF.SpriteVF_AxisLockRight.xyz, float3(SpriteVF.SpriteVF_AxisLockRight.w));
    float3 _278 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _261), SpriteVF.SpriteVF_AxisLockUp.xyz, float3(SpriteVF.SpriteVF_AxisLockUp.w));
    float3 _279 = View.View_WorldCameraOrigin - _257;
    float _280 = dot(_279, _279);
    float3 _283 = _279 * rsqrt(fast::max(_280, 9.9999999392252902907785028219223e-09));
    float3 _353;
    float3 _354;
    if (SpriteVF.SpriteVF_CameraFacingBlend[0] > 0.0)
    {
        float3 _342 = cross(_283, float3(0.0, 0.0, 1.0));
        float3 _346 = _342 * rsqrt(fast::max(dot(_342, _342), 9.9999999392252902907785028219223e-09));
        float3 _348 = float3(fast::clamp((_280 * SpriteVF.SpriteVF_CameraFacingBlend[1]) - SpriteVF.SpriteVF_CameraFacingBlend[2], 0.0, 1.0));
        _353 = normalize(mix(_270, _346, _348));
        _354 = normalize(mix(_278, cross(_283, _346), _348));
    }
    else
    {
        float3 _333;
        float3 _334;
        if (SpriteVF.SpriteVF_TangentSelector.y > 0.0)
        {
            float3 _322 = _257 - (Primitive.Primitive_LocalToWorld * float4(in.in_var_ATTRIBUTE1.xyz, 1.0)).xyz;
            float3 _326 = _322 * rsqrt(fast::max(dot(_322, _322), 9.9999999392252902907785028219223e-09));
            float3 _327 = cross(_283, _326);
            _333 = _327 * rsqrt(fast::max(dot(_327, _327), 9.9999999392252902907785028219223e-09));
            _334 = -_326;
        }
        else
        {
            float3 _320;
            float3 _321;
            if (SpriteVF.SpriteVF_TangentSelector.z > 0.0)
            {
                float3 _314 = cross(SpriteVF.SpriteVF_AxisLockRight.xyz, _283);
                _320 = SpriteVF.SpriteVF_AxisLockRight.xyz;
                _321 = -(_314 * rsqrt(fast::max(dot(_314, _314), 9.9999999392252902907785028219223e-09)));
            }
            else
            {
                float3 _312;
                float3 _313;
                if (SpriteVF.SpriteVF_TangentSelector.w > 0.0)
                {
                    float3 _306 = cross(_283, float3(0.0, 0.0, 1.0));
                    float3 _310 = _306 * rsqrt(fast::max(dot(_306, _306), 9.9999999392252902907785028219223e-09));
                    _312 = _310;
                    _313 = cross(_283, _310);
                }
                else
                {
                    _312 = _270;
                    _313 = _278;
                }
                _320 = _312;
                _321 = _313;
            }
            _333 = _320;
            _334 = _321;
        }
        _353 = _333;
        _354 = _334;
    }
    float _360 = in.in_var_ATTRIBUTE2.z * SpriteVF.SpriteVF_RotationScale;
    float _361 = _360 + SpriteVF.SpriteVF_RotationBias;
    float _362 = sin(_361);
    float _363 = cos(_361);
    float3 _364 = _354 * _362;
    float3 _365 = _353 * _363;
    float3 _366 = _364 + _365;
    float3 _367 = _354 * _363;
    float3 _368 = _353 * _362;
    float3 _369 = _367 - _368;
    float2 _373 = float2(int2(sign(in.in_var_ATTRIBUTE2.xy)));
    float2 _428;
    float2 _429;
    if (_Globals.NumCutoutVerticesPerFrame > 0u)
    {
        uint _395 = uint(mod(float((gl_VertexIndex - gl_BaseVertex)), float(_Globals.NumCutoutVerticesPerFrame)));
        float _404 = _373.x;
        float _405 = _373.y;
        uint _412;
        if ((_404 * _405) < 0.0)
        {
            _412 = (_Globals.NumCutoutVerticesPerFrame - 1u) - _395;
        }
        else
        {
            _412 = _395;
        }
        float4 _416 = CutoutGeometry.read(uint(((uint(mod(in.in_var_ATTRIBUTE2.w, SpriteVF.SpriteVF_SubImageSize.x * SpriteVF.SpriteVF_SubImageSize.y)) * _Globals.NumCutoutVerticesPerFrame) + _412)));
        float _419 = _416.x;
        float2 _422 = _178;
        _422.x = (_404 < 0.0) ? (1.0 - _419) : _419;
        float _424 = _416.y;
        float2 _427 = _422;
        _427.y = (_405 < 0.0) ? (1.0 - _424) : _424;
        _428 = _416.xy;
        _429 = _427;
    }
    else
    {
        float2 _385 = _178;
        _385.x = (_373.x < 0.0) ? (1.0 - in.in_var_ATTRIBUTE4.x) : in.in_var_ATTRIBUTE4.x;
        float2 _391 = _385;
        _391.y = (_373.y < 0.0) ? (1.0 - in.in_var_ATTRIBUTE4.y) : in.in_var_ATTRIBUTE4.y;
        _428 = _391;
        _429 = in.in_var_ATTRIBUTE4;
    }
    float3 _430 = _257 + View.View_PreViewTranslation;
    float _431 = _430.x;
    float _432 = _430.y;
    float _433 = _430.z;
    float4 _434 = float4(_431, _432, _433, 1.0);
    float2 _435 = abs(in.in_var_ATTRIBUTE2.xy);
    float _436 = _366.x;
    float _437 = _366.y;
    float _438 = _366.z;
    float4 _439 = float4(_436, _437, _438, 0.0);
    float _440 = _435.x;
    float _444 = _429.x + SpriteVF.SpriteVF_PivotOffset.x;
    float _445 = _440 * _444;
    float4 _446 = _439 * _445;
    float4 _447 = _434 + _446;
    float _448 = _369.x;
    float _449 = _369.y;
    float _450 = _369.z;
    float4 _451 = float4(_448, _449, _450, 0.0);
    float _452 = _435.y;
    float _456 = _429.y + SpriteVF.SpriteVF_PivotOffset.y;
    float _457 = _452 * _456;
    float4 _458 = _451 * _457;
    float4 _459 = _447 + _458;
    float _461 = fract(in.in_var_ATTRIBUTE2.w);
    float _462 = in.in_var_ATTRIBUTE2.w - _461;
    float2 _475 = (float2(mod(_462, SpriteVF.SpriteVF_SubImageSize.x), floor(_462 * SpriteVF.SpriteVF_SubImageSize.z)) + _428) * SpriteVF.SpriteVF_SubImageSize.zw;
    float3x3 _476 = _175;
    _476[0] = _366;
    float3x3 _477 = _476;
    _477[1] = _369;
    float3x3 _511;
    if (SpriteVF.SpriteVF_NormalsType < 0.5)
    {
        float3x3 _510 = _477;
        _510[2] = normalize(cross(_366, _369));
        _511 = _510;
    }
    else
    {
        float3x3 _507;
        if (SpriteVF.SpriteVF_NormalsType < 1.5)
        {
            float3x3 _506 = _477;
            _506[2] = normalize(_257 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz);
            _507 = _506;
        }
        else
        {
            float3x3 _500 = _477;
            _500[2] = normalize(_257 - (SpriteVF.SpriteVF_NormalsSphereCenter.xyz + (SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz * dot(SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz, _257 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz))));
            _507 = _500;
        }
        _511 = _507;
    }
    float _512 = _459.x;
    float _513 = _459.y;
    float _514 = _459.z;
    float4 _515 = float4(_512, _513, _514, 1.0);
    float4 _516 = float4(_515.x, _515.y, _515.z, _515.w);
    float4 _517 = View.View_TranslatedWorldToClip * _516;
    float4 _521 = float4(_511[0].x, _511[0].y, _511[0].z, float4(0.0).w);
    _521.w = _461;
    spvUnsafeArray<float4, 1> _531 = { float4(_475.x, _475.y, float4(0.0).z, float4(0.0).w) };
    float3 _532 = _515.xyz;
    float3 _533 = _532 - View.View_TranslatedWorldCameraOrigin;
    float _537 = 9.9999997473787516355514526367188e-06 * View.View_AtmosphericFogDistanceScale;
    float3 _545 = View.View_TranslatedWorldCameraOrigin;
    _545.z = (View.View_TranslatedWorldCameraOrigin.z - View.View_AtmosphericFogGroundOffset) * View.View_AtmosphericFogAltitudeScale;
    float3 _546 = _545 * _537;
    float3 _549 = _546;
    _549.z = _546.z + 6360.009765625;
    float _550 = length(_549);
    float3 _551 = normalize(_533);
    float _552 = dot(_549, _551);
    float _553 = _552 / _550;
    float _555 = (-_550) * _553;
    float _559 = (_550 * _550) * ((_553 * _553) - 1.0);
    float _564 = length(_533) * _537;
    float _568 = fast::max(0.0, _564 - View.View_AtmosphericFogStartDistance);
    float _571 = fast::min((_568 * 0.100000001490116119384765625) / View.View_AtmosphericFogStartDistance, 1.0);
    bool _572 = _564 < (100.0 * View.View_AtmosphericFogDistanceScale);
    float _582;
    float _583;
    if (_572)
    {
        _582 = _571 * View.View_AtmosphericFogPower;
        _583 = fast::max(_564 + View.View_AtmosphericFogDistanceOffset, 1.0);
    }
    else
    {
        _582 = 1.0;
        _583 = _555 - sqrt(_559 + 40449600.0);
    }
    float _589 = _555 - sqrt(_559 + 41344900.0);
    bool _590 = _589 > 0.0;
    float _598;
    float _599;
    float3 _600;
    if (_590)
    {
        _598 = (_552 + _589) * 0.00015552098921034485101699829101562;
        _599 = _583 - _589;
        _600 = _549 + (_551 * _589);
    }
    else
    {
        _598 = _553;
        _599 = _583;
        _600 = _549;
    }
    float _601 = _590 ? 6430.0 : _550;
    bool _602 = _601 < 6360.0146484375;
    float _611;
    float _612;
    float3 _613;
    if (_602)
    {
        float _605 = 6360.0146484375 - _601;
        float3 _607 = _600 - (_551 * _605);
        _611 = dot(_607, _551) * 0.0001572323380969464778900146484375;
        _612 = _599 - _605;
        _613 = _607;
    }
    else
    {
        _611 = _598;
        _612 = _599;
        _613 = _600;
    }
    float _614 = _602 ? 6360.0146484375 : _601;
    float3 _1114;
    float3 _1115;
    if ((_614 <= 6430.0) && (_568 > 0.0))
    {
        float3 _621 = _613 + (_551 * _612);
        float _622 = length(_621);
        float _623 = dot(_551, View.View_AtmosphereLightDirection[0].xyz);
        float _625 = dot(_613, View.View_AtmosphereLightDirection[0].xyz) / _614;
        float _626 = 6360.0 / _614;
        float _629 = sqrt(1.0 - (_626 * _626));
        float _638;
        if (_572)
        {
            _638 = fast::max(_611, 0.1550000011920928955078125 - _629);
        }
        else
        {
            _638 = fast::max(_611, 0.004999999888241291046142578125 - _629);
        }
        float3 _659;
        float _660;
        float _661;
        if (_572)
        {
            float _641 = _551.z;
            float _645 = fast::clamp(exp(-_641) - 0.5, 0.0, 1.0);
            float3 _657;
            float _658;
            if (_645 < 1.0)
            {
                float3 _650 = _551;
                _650.z = fast::max(_641, 0.1500000059604644775390625);
                float3 _651 = normalize(_650);
                float3 _653 = _613 + (_651 * _612);
                _657 = _651;
                _658 = dot(_653, _651) / length(_653);
            }
            else
            {
                _657 = _551;
                _658 = _638;
            }
            _659 = _657;
            _660 = _645;
            _661 = _658;
        }
        else
        {
            _659 = _551;
            _660 = 0.0;
            _661 = _638;
        }
        float _663 = 1.0 + (_623 * _623);
        float _674 = _614 * _614;
        float _676 = sqrt(_674 - 40449600.0);
        float _677 = _614 * _661;
        float _680 = ((_677 * _677) - _674) + 40449600.0;
        float4 _685 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_677 < 0.0) && (_680 > 0.0)));
        float _688 = float(View.View_AtmosphericFogInscatterAltitudeSampleNum);
        float _689 = 0.5 / _688;
        float _692 = 1.0 - (1.0 / _688);
        float _694 = _689 + ((_676 * 0.00105685577727854251861572265625) * _692);
        float _706 = _685.w + ((((_677 * _685.x) + sqrt(_680 + _685.y)) / (_676 + _685.z)) * 0.4921875);
        float _715 = (_623 + 1.0) * 3.5;
        float _716 = floor(_715);
        float _717 = _715 - _716;
        float _718 = _716 + (0.015625 + (((atan(fast::max(_625, -0.19750000536441802978515625) * 5.349621295928955078125) * 0.90909087657928466796875) + 0.7400000095367431640625) * 0.484375));
        float _719 = _718 * 0.125;
        float _723 = 1.0 - _717;
        float _726 = (_718 + 1.0) * 0.125;
        float4 _732 = fast::max((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_719, _706, _694), level(0.0)) * _723) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_726, _706, _694), level(0.0)) * _717), float4(0.0));
        float3 _1098;
        float4 _1099;
        if (_612 > 0.0)
        {
            float2 _743 = float2(_661, _661 + (_612 / _614));
            float2 _744 = _743 * sqrt((0.5 / View.View_AtmosphericFogHeightScaleRayleigh) * _614);
            float2 _747 = float2(int2(sign(_744)));
            float2 _748 = _744 * _744;
            float _764 = 2.0 * _614;
            float _766 = (_612 / _764) + _661;
            float _774 = 6360.0 - _614;
            float2 _784 = _743 * sqrt(0.4166666567325592041015625 * _614);
            float2 _787 = float2(int2(sign(_784)));
            float2 _788 = _784 * _784;
            float3 _817 = exp((float3(-0.0057999999262392520904541015625, -0.013500000350177288055419921875, -0.033100001513957977294921875) * ((sqrt((6.283100128173828125 * View.View_AtmosphericFogHeightScaleRayleigh) * _614) * exp(_774 / View.View_AtmosphericFogHeightScaleRayleigh)) * (((_747.y > _747.x) ? exp(_748.x) : 0.0) + dot((_747 / ((abs(_744) * 2.3192999362945556640625) + sqrt((_748 * 1.519999980926513671875) + float2(4.0)))) * float2(1.0, exp(((-_612) / View.View_AtmosphericFogHeightScaleRayleigh) * _766)), float2(1.0, -1.0))))) - (float3(0.00444444455206394195556640625) * ((sqrt(7.5397205352783203125 * _614) * exp(_774 * 0.833333313465118408203125)) * (((_787.y > _787.x) ? exp(_788.x) : 0.0) + dot((_787 / ((abs(_784) * 2.3192999362945556640625) + sqrt((_788 * 1.519999980926513671875) + float2(4.0)))) * float2(1.0, exp((_612 * (-0.833333313465118408203125)) * _766)), float2(1.0, -1.0))))));
            float _825;
            if (_572)
            {
                _825 = fast::max(_622, _614);
            }
            else
            {
                _825 = _622;
            }
            float4 _1097;
            if (_825 > 6360.009765625)
            {
                float4 _1096;
                if (_660 < 1.0)
                {
                    float4 _836 = _817.xyzx;
                    float _837 = _825 * _825;
                    float _839 = sqrt(_837 - 40449600.0);
                    float _840 = _825 * (dot(_621, _659) / _622);
                    float _843 = ((_840 * _840) - _837) + 40449600.0;
                    float4 _848 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_840 < 0.0) && (_843 > 0.0)));
                    float _851 = _689 + ((_839 * 0.00105685577727854251861572265625) * _692);
                    float _863 = _848.w + ((((_840 * _848.x) + sqrt(_843 + _848.y)) / (_839 + _848.z)) * 0.4921875);
                    float _871 = _716 + (0.015625 + (((atan(fast::max(dot(_621, View.View_AtmosphereLightDirection[0].xyz) / _622, -0.19750000536441802978515625) * 5.349621295928955078125) * 0.90909087657928466796875) + 0.7400000095367431640625) * 0.484375));
                    float _872 = _871 * 0.125;
                    float _878 = (_871 + 1.0) * 0.125;
                    float4 _886 = fast::max(_732 - (_836 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_872, _863, _851), level(0.0)) * _723) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_878, _863, _851), level(0.0)) * _717))), float4(0.0));
                    float4 _1095;
                    if (!_572)
                    {
                        float _930 = _661 - (-_629);
                        float4 _1094;
                        if (abs(_930) < 0.004999999888241291046142578125)
                        {
                            float _937 = (-0.004999999888241291046142578125) - _629;
                            float _939 = _674 + (_612 * _612);
                            float _940 = _764 * _612;
                            float _943 = sqrt(_939 + (_940 * _937));
                            float _944 = _614 * _937;
                            float _947 = 0.004999999888241291046142578125 - _629;
                            float _951 = ((_944 * _944) - _674) + 40449600.0;
                            float4 _956 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_944 < 0.0) && (_951 > 0.0)));
                            float _968 = _956.w + ((((_944 * _956.x) + sqrt(_951 + _956.y)) / (_676 + _956.z)) * 0.4921875);
                            float _978 = _943 * _943;
                            float _980 = sqrt(_978 - 40449600.0);
                            float _981 = _943 * fast::max(_947, (_944 + _612) / _943);
                            float _984 = ((_981 * _981) - _978) + 40449600.0;
                            float4 _989 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_981 < 0.0) && (_984 > 0.0)));
                            float _992 = _689 + ((_980 * 0.00105685577727854251861572265625) * _692);
                            float _1004 = _989.w + ((((_981 * _989.x) + sqrt(_984 + _989.y)) / (_980 + _989.z)) * 0.4921875);
                            float _1019 = sqrt(_939 + (_940 * _947));
                            float _1020 = _614 * _947;
                            float _1026 = ((_1020 * _1020) - _674) + 40449600.0;
                            float4 _1031 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_1020 < 0.0) && (_1026 > 0.0)));
                            float _1043 = _1031.w + ((((_1020 * _1031.x) + sqrt(_1026 + _1031.y)) / (_676 + _1031.z)) * 0.4921875);
                            float _1053 = _1019 * _1019;
                            float _1055 = sqrt(_1053 - 40449600.0);
                            float _1056 = _1019 * fast::max(_947, (_1020 + _612) / _1019);
                            float _1059 = ((_1056 * _1056) - _1053) + 40449600.0;
                            float4 _1064 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_1056 < 0.0) && (_1059 > 0.0)));
                            float _1067 = _689 + ((_1055 * 0.00105685577727854251861572265625) * _692);
                            float _1079 = _1064.w + ((((_1056 * _1064.x) + sqrt(_1059 + _1064.y)) / (_1055 + _1064.z)) * 0.4921875);
                            _1094 = mix(fast::max(((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_719, _968, _694), level(0.0)) * _723) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_726, _968, _694), level(0.0)) * _717)) - (_836 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_872, _1004, _992), level(0.0)) * _723) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_878, _1004, _992), level(0.0)) * _717))), float4(0.0)), fast::max(((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_719, _1043, _694), level(0.0)) * _723) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_726, _1043, _694), level(0.0)) * _717)) - (_836 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_872, _1079, _1067), level(0.0)) * _723) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_878, _1079, _1067), level(0.0)) * _717))), float4(0.0)), float4((_930 + 0.004999999888241291046142578125) * 100.0));
                        }
                        else
                        {
                            _1094 = _886;
                        }
                        _1095 = _1094;
                    }
                    else
                    {
                        float4 _929;
                        if (_660 > 0.0)
                        {
                            float _895 = _614 * _638;
                            float _898 = ((_895 * _895) - _674) + 40449600.0;
                            float4 _903 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_895 < 0.0) && (_898 > 0.0)));
                            float _915 = _903.w + ((((_895 * _903.x) + sqrt(_898 + _903.y)) / (_676 + _903.z)) * 0.4921875);
                            _929 = mix(_886, (float4(1.0) - _836) * fast::max((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_719, _915, _694), level(0.0)) * _723) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_726, _915, _694), level(0.0)) * _717), float4(0.0)), float4(_660));
                        }
                        else
                        {
                            _929 = _886;
                        }
                        _1095 = _929;
                    }
                    _1096 = _1095;
                }
                else
                {
                    _1096 = (float4(1.0) - _817.xyzx) * _732;
                }
                _1097 = _1096;
            }
            else
            {
                _1097 = _732;
            }
            _1098 = _817;
            _1099 = _1097;
        }
        else
        {
            _1098 = float3(1.0);
            _1099 = _732;
        }
        _1114 = _1098;
        _1115 = fast::max((_1099.xyz * (0.0596831031143665313720703125 * _663)) + ((((_1099.xyz * (_1099.w * smoothstep(0.0, 0.0199999995529651641845703125, _625))) / float3(fast::max(_1099.x, 9.9999997473787516355514526367188e-05))) * float3(1.0, 0.429629623889923095703125, 0.17522656917572021484375)) * (((0.042971827089786529541015625 * pow(abs(1.6400001049041748046875 - (1.60000002384185791015625 * _623)), -1.5)) * _663) * 0.37878787517547607421875)), float3(0.0));
    }
    else
    {
        _1114 = float3(1.0);
        _1115 = float3(0.0);
    }
    float3 _1180;
    if ((View.View_AtmosphericFogRenderMask & 2u) == 0u)
    {
        float3 _1179;
        if (_583 > 0.0)
        {
            float3 _1126 = _549 + (_551 * _583);
            float _1127 = length(_1126);
            float3 _1129 = _1126 / float3(_1127);
            float _1130 = dot(_1129, View.View_AtmosphereLightDirection[0].xyz);
            float _1132 = (_1127 - 6360.0) * 0.014285714365541934967041015625;
            float3 _1145 = select(View_AtmosphereTransmittanceTexture.sample(View_AtmosphereTransmittanceTextureSampler, float2(atan((_1130 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt(_1132)), level(0.0)).xyz, float3(0.0), bool3(_572));
            float3 _1157 = ((_1145 * fast::max(_1130, 0.0)) + View_AtmosphereIrradianceTexture.sample(View_AtmosphereIrradianceTextureSampler, float2((_1130 + 0.20000000298023223876953125) * 0.833333313465118408203125, _1132), level(0.0)).xyz) * float3(0.0031830989755690097808837890625);
            float3 _1177;
            if ((!_572) && true)
            {
                float3 _1163 = normalize(View.View_AtmosphereLightDirection[0].xyz - _551);
                _1177 = _1157 + (_1145 * fast::max((0.0199999995529651641845703125 + (0.980000019073486328125 * pow(1.0 - dot(-_551, _1163), 5.0))) * pow(fast::max(dot(_1163, _1129), 0.0), 150.0), 0.0));
            }
            else
            {
                _1177 = _1157;
            }
            _1179 = _1114 * _1177;
        }
        else
        {
            _1179 = float3(0.0);
        }
        _1180 = _1179;
    }
    else
    {
        _1180 = float3(0.0);
    }
    float3 _1217;
    if ((View.View_AtmosphericFogRenderMask & 1u) == 0u)
    {
        float3 _1216;
        switch (0u)
        {
            default:
            {
                if (_583 > 0.0)
                {
                    _1216 = float3(0.0);
                    break;
                }
                else
                {
                    _1216 = (select(float3(1.0), View_AtmosphereTransmittanceTexture.sample(View_AtmosphereTransmittanceTextureSampler, float2(atan((_553 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt((_550 - 6360.0) * 0.014285714365541934967041015625)), level(0.0)).xyz, bool3(_550 <= 6430.0)) * step(View.View_AtmosphereLightDiscCosHalfApexAngle[0].x, dot(_551, View.View_AtmosphereLightDirection[0].xyz))) * View.View_AtmosphereLightDiscLuminance[0].xyz;
                    break;
                }
            }
        }
        _1217 = _1216;
    }
    else
    {
        _1217 = float3(0.0);
    }
    float _1237 = mix(fast::clamp((_1114.x * View.View_AtmosphericFogDensityScale) - View.View_AtmosphericFogDensityOffset, 0.0, 1.0), 1.0, 1.0 - _571);
    float4 _1241 = float4((View.View_AtmosphereLightColor[0].xyz * (View.View_AtmosphericFogSunPower * _582)) * ((_1217 + _1180) + _1115), _1237);
    float4 _1318;
    if (View.View_SkyAtmosphereApplyCameraAerialPerspectiveVolume > 0.0)
    {
        float3 _1255 = (_532 * 9.9999997473787516355514526367188e-06) - (View.View_TranslatedWorldCameraOrigin * 9.9999997473787516355514526367188e-06);
        float _1261 = sqrt((fast::max(0.0, length(_1255) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
        float _1262 = _1261 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
        float _1269;
        if (_1262 < 0.707106769084930419921875)
        {
            _1269 = fast::clamp((_1262 * _1262) * 2.0, 0.0, 1.0);
        }
        else
        {
            _1269 = 1.0;
        }
        float2 _1297;
        if (View.View_RealTimeReflectionCapture != 0.0)
        {
            float3 _1272 = normalize(_1255);
            float _1273 = _1272.z;
            float _1276 = sqrt(1.0 - (_1273 * _1273));
            float2 _1279 = _178;
            _1279.y = (_1273 * 0.5) + 0.5;
            float _1284 = acos(_1272.x / _1276);
            float2 _1289 = _1279;
            _1289.x = (((_1272.y / _1276) < 0.0) ? (6.283185482025146484375 - _1284) : _1284) * 0.15915493667125701904296875;
            _1297 = (_1289 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
        }
        else
        {
            _1297 = ((_517.xy / _517.ww) * float2(0.5, -0.5)) + float2(0.5);
        }
        float4 _1302 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_1297, _1261), level(0.0));
        float3 _1314 = _1241.xyz + (((_1302.xyz * _1269).xyz * View.View_OneOverPreExposure).xyz * _1237);
        float4 _1317 = float4(_1314.x, _1314.y, _1314.z, _176.w);
        _1317.w = _1237 * (1.0 - (_1269 * (1.0 - _1302.w)));
        _1318 = _1317;
    }
    else
    {
        _1318 = _1241;
    }
    out.out_var_TEXCOORD10 = _521;
    out.out_var_TEXCOORD11 = float4(_511[2], float(int(sign(determinant(_511)))));
    out.out_var_TEXCOORD1 = in.in_var_ATTRIBUTE5;
    out.out_var_TEXCOORD2 = in.in_var_ATTRIBUTE3;
    out_var_TEXCOORD3 = _531;
    out.out_var_TEXCOORD7 = _1318;
    out.gl_Position = _517;
    out.out_var_TEXCOORD3_0 = out_var_TEXCOORD3[0];
    return out;
}

