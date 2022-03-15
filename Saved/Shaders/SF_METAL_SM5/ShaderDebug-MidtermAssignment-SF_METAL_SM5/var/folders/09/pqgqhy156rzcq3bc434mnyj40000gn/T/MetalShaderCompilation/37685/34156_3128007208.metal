

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

constant float3x3 _182 = {};
constant float4 _183 = {};
constant float2 _185 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10 [[user(locn0)]];
    float4 out_var_TEXCOORD11 [[user(locn1)]];
    float4 out_var_TEXCOORD2 [[user(locn2)]];
    float4 out_var_TEXCOORD3_0 [[user(locn3)]];
    float4 out_var_PARTICLE_SUBUVS [[user(locn4)]];
    float3 out_var_PARTICLE_LIGHTING_OFFSET [[user(locn5)]];
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
};

// Implementation of the GLSL mod() function, which is slightly different than Metal fmod()
template<typename Tx, typename Ty>
inline Tx mod(Tx x, Ty y)
{
    return x - y * floor(x / y);
}

vertex Main_out Main_0000856c_ba719a28(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_SpriteVF& SpriteVF [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]], texture_buffer<float> CutoutGeometry [[texture(0)]], texture2d<float> View_AtmosphereTransmittanceTexture [[texture(1)]], texture2d<float> View_AtmosphereIrradianceTexture [[texture(2)]], texture3d<float> View_AtmosphereInscatterTexture [[texture(3)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(4)]], sampler View_AtmosphereTransmittanceTextureSampler [[sampler(0)]], sampler View_AtmosphereIrradianceTextureSampler [[sampler(1)]], sampler View_AtmosphereInscatterTextureSampler [[sampler(2)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD3 = {};
    float4 _254 = float4(in.in_var_ATTRIBUTE0.xyz, 1.0);
    float4 _257 = Primitive.Primitive_LocalToWorld * _254;
    float3 _263 = _257.xyz;
    float3 _267 = float3(SpriteVF.SpriteVF_RemoveHMDRoll);
    float3 _276 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _267), SpriteVF.SpriteVF_AxisLockRight.xyz, float3(SpriteVF.SpriteVF_AxisLockRight.w));
    float3 _284 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _267), SpriteVF.SpriteVF_AxisLockUp.xyz, float3(SpriteVF.SpriteVF_AxisLockUp.w));
    float3 _285 = View.View_WorldCameraOrigin - _263;
    float _286 = dot(_285, _285);
    float3 _289 = _285 * rsqrt(fast::max(_286, 9.9999999392252902907785028219223e-09));
    float3 _359;
    float3 _360;
    if (SpriteVF.SpriteVF_CameraFacingBlend[0] > 0.0)
    {
        float3 _348 = cross(_289, float3(0.0, 0.0, 1.0));
        float3 _352 = _348 * rsqrt(fast::max(dot(_348, _348), 9.9999999392252902907785028219223e-09));
        float3 _354 = float3(fast::clamp((_286 * SpriteVF.SpriteVF_CameraFacingBlend[1]) - SpriteVF.SpriteVF_CameraFacingBlend[2], 0.0, 1.0));
        _359 = normalize(mix(_276, _352, _354));
        _360 = normalize(mix(_284, cross(_289, _352), _354));
    }
    else
    {
        float3 _339;
        float3 _340;
        if (SpriteVF.SpriteVF_TangentSelector.y > 0.0)
        {
            float3 _328 = _263 - (Primitive.Primitive_LocalToWorld * float4(in.in_var_ATTRIBUTE1.xyz, 1.0)).xyz;
            float3 _332 = _328 * rsqrt(fast::max(dot(_328, _328), 9.9999999392252902907785028219223e-09));
            float3 _333 = cross(_289, _332);
            _339 = _333 * rsqrt(fast::max(dot(_333, _333), 9.9999999392252902907785028219223e-09));
            _340 = -_332;
        }
        else
        {
            float3 _326;
            float3 _327;
            if (SpriteVF.SpriteVF_TangentSelector.z > 0.0)
            {
                float3 _320 = cross(SpriteVF.SpriteVF_AxisLockRight.xyz, _289);
                _326 = SpriteVF.SpriteVF_AxisLockRight.xyz;
                _327 = -(_320 * rsqrt(fast::max(dot(_320, _320), 9.9999999392252902907785028219223e-09)));
            }
            else
            {
                float3 _318;
                float3 _319;
                if (SpriteVF.SpriteVF_TangentSelector.w > 0.0)
                {
                    float3 _312 = cross(_289, float3(0.0, 0.0, 1.0));
                    float3 _316 = _312 * rsqrt(fast::max(dot(_312, _312), 9.9999999392252902907785028219223e-09));
                    _318 = _316;
                    _319 = cross(_289, _316);
                }
                else
                {
                    _318 = _276;
                    _319 = _284;
                }
                _326 = _318;
                _327 = _319;
            }
            _339 = _326;
            _340 = _327;
        }
        _359 = _339;
        _360 = _340;
    }
    float _366 = in.in_var_ATTRIBUTE2.z * SpriteVF.SpriteVF_RotationScale;
    float _367 = _366 + SpriteVF.SpriteVF_RotationBias;
    float _368 = sin(_367);
    float _369 = cos(_367);
    float3 _370 = _360 * _368;
    float3 _371 = _359 * _369;
    float3 _372 = _370 + _371;
    float3 _373 = _360 * _369;
    float3 _374 = _359 * _368;
    float3 _375 = _373 - _374;
    float2 _379 = float2(int2(sign(in.in_var_ATTRIBUTE2.xy)));
    float2 _434;
    float2 _435;
    if (_Globals.NumCutoutVerticesPerFrame > 0u)
    {
        uint _401 = uint(mod(float((gl_VertexIndex - gl_BaseVertex)), float(_Globals.NumCutoutVerticesPerFrame)));
        float _410 = _379.x;
        float _411 = _379.y;
        uint _418;
        if ((_410 * _411) < 0.0)
        {
            _418 = (_Globals.NumCutoutVerticesPerFrame - 1u) - _401;
        }
        else
        {
            _418 = _401;
        }
        float4 _422 = CutoutGeometry.read(uint(((uint(mod(in.in_var_ATTRIBUTE2.w, SpriteVF.SpriteVF_SubImageSize.x * SpriteVF.SpriteVF_SubImageSize.y)) * _Globals.NumCutoutVerticesPerFrame) + _418)));
        float _425 = _422.x;
        float2 _428 = _185;
        _428.x = (_410 < 0.0) ? (1.0 - _425) : _425;
        float _430 = _422.y;
        float2 _433 = _428;
        _433.y = (_411 < 0.0) ? (1.0 - _430) : _430;
        _434 = _422.xy;
        _435 = _433;
    }
    else
    {
        float2 _391 = _185;
        _391.x = (_379.x < 0.0) ? (1.0 - in.in_var_ATTRIBUTE4.x) : in.in_var_ATTRIBUTE4.x;
        float2 _397 = _391;
        _397.y = (_379.y < 0.0) ? (1.0 - in.in_var_ATTRIBUTE4.y) : in.in_var_ATTRIBUTE4.y;
        _434 = _397;
        _435 = in.in_var_ATTRIBUTE4;
    }
    float3 _436 = _263 + View.View_PreViewTranslation;
    float _437 = _436.x;
    float _438 = _436.y;
    float _439 = _436.z;
    float4 _440 = float4(_437, _438, _439, 1.0);
    float2 _441 = abs(in.in_var_ATTRIBUTE2.xy);
    float _442 = _372.x;
    float _443 = _372.y;
    float _444 = _372.z;
    float4 _445 = float4(_442, _443, _444, 0.0);
    float _446 = _441.x;
    float _450 = _435.x + SpriteVF.SpriteVF_PivotOffset.x;
    float _451 = _446 * _450;
    float4 _452 = _445 * _451;
    float4 _453 = _440 + _452;
    float _454 = _375.x;
    float _455 = _375.y;
    float _456 = _375.z;
    float4 _457 = float4(_454, _455, _456, 0.0);
    float _458 = _441.y;
    float _462 = _435.y + SpriteVF.SpriteVF_PivotOffset.y;
    float _463 = _458 * _462;
    float4 _464 = _457 * _463;
    float4 _465 = _453 + _464;
    float _467 = fract(in.in_var_ATTRIBUTE2.w);
    float _468 = in.in_var_ATTRIBUTE2.w - _467;
    float _469 = _468 + 1.0;
    float2 _485 = (float2(mod(_468, SpriteVF.SpriteVF_SubImageSize.x), floor(_468 * SpriteVF.SpriteVF_SubImageSize.z)) + _434) * SpriteVF.SpriteVF_SubImageSize.zw;
    float2 _488 = (float2(mod(_469, SpriteVF.SpriteVF_SubImageSize.x), floor(_469 * SpriteVF.SpriteVF_SubImageSize.z)) + _434) * SpriteVF.SpriteVF_SubImageSize.zw;
    float3x3 _489 = _182;
    _489[0] = _372;
    float3x3 _490 = _489;
    _490[1] = _375;
    float3x3 _524;
    if (SpriteVF.SpriteVF_NormalsType < 0.5)
    {
        float3x3 _523 = _490;
        _523[2] = normalize(cross(_372, _375));
        _524 = _523;
    }
    else
    {
        float3x3 _520;
        if (SpriteVF.SpriteVF_NormalsType < 1.5)
        {
            float3x3 _519 = _490;
            _519[2] = normalize(_263 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz);
            _520 = _519;
        }
        else
        {
            float3x3 _513 = _490;
            _513[2] = normalize(_263 - (SpriteVF.SpriteVF_NormalsSphereCenter.xyz + (SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz * dot(SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz, _263 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz))));
            _520 = _513;
        }
        _524 = _520;
    }
    float _526 = in.in_var_ATTRIBUTE1.w + 10.0;
    float _536 = _465.x;
    float _537 = _465.y;
    float _538 = _465.z;
    float4 _539 = float4(_536, _537, _538, 1.0);
    float4 _540 = float4(_539.x, _539.y, _539.z, _539.w);
    float4 _541 = View.View_TranslatedWorldToClip * _540;
    float4 _546 = float4(_524[0].x, _524[0].y, _524[0].z, float4(0.0).w);
    _546.w = _467;
    spvUnsafeArray<float4, 1> _556 = { float4(_485.x, _485.y, float4(0.0).z, float4(0.0).w) };
    float3 _557 = _539.xyz;
    float3 _558 = _557 - View.View_TranslatedWorldCameraOrigin;
    float _562 = 9.9999997473787516355514526367188e-06 * View.View_AtmosphericFogDistanceScale;
    float3 _570 = View.View_TranslatedWorldCameraOrigin;
    _570.z = (View.View_TranslatedWorldCameraOrigin.z - View.View_AtmosphericFogGroundOffset) * View.View_AtmosphericFogAltitudeScale;
    float3 _571 = _570 * _562;
    float3 _574 = _571;
    _574.z = _571.z + 6360.009765625;
    float _575 = length(_574);
    float3 _576 = normalize(_558);
    float _577 = dot(_574, _576);
    float _578 = _577 / _575;
    float _580 = (-_575) * _578;
    float _584 = (_575 * _575) * ((_578 * _578) - 1.0);
    float _589 = length(_558) * _562;
    float _593 = fast::max(0.0, _589 - View.View_AtmosphericFogStartDistance);
    float _596 = fast::min((_593 * 0.100000001490116119384765625) / View.View_AtmosphericFogStartDistance, 1.0);
    bool _597 = _589 < (100.0 * View.View_AtmosphericFogDistanceScale);
    float _607;
    float _608;
    if (_597)
    {
        _607 = _596 * View.View_AtmosphericFogPower;
        _608 = fast::max(_589 + View.View_AtmosphericFogDistanceOffset, 1.0);
    }
    else
    {
        _607 = 1.0;
        _608 = _580 - sqrt(_584 + 40449600.0);
    }
    float _614 = _580 - sqrt(_584 + 41344900.0);
    bool _615 = _614 > 0.0;
    float _623;
    float _624;
    float3 _625;
    if (_615)
    {
        _623 = (_577 + _614) * 0.00015552098921034485101699829101562;
        _624 = _608 - _614;
        _625 = _574 + (_576 * _614);
    }
    else
    {
        _623 = _578;
        _624 = _608;
        _625 = _574;
    }
    float _626 = _615 ? 6430.0 : _575;
    bool _627 = _626 < 6360.0146484375;
    float _636;
    float _637;
    float3 _638;
    if (_627)
    {
        float _630 = 6360.0146484375 - _626;
        float3 _632 = _625 - (_576 * _630);
        _636 = dot(_632, _576) * 0.0001572323380969464778900146484375;
        _637 = _624 - _630;
        _638 = _632;
    }
    else
    {
        _636 = _623;
        _637 = _624;
        _638 = _625;
    }
    float _639 = _627 ? 6360.0146484375 : _626;
    float3 _1139;
    float3 _1140;
    if ((_639 <= 6430.0) && (_593 > 0.0))
    {
        float3 _646 = _638 + (_576 * _637);
        float _647 = length(_646);
        float _648 = dot(_576, View.View_AtmosphereLightDirection[0].xyz);
        float _650 = dot(_638, View.View_AtmosphereLightDirection[0].xyz) / _639;
        float _651 = 6360.0 / _639;
        float _654 = sqrt(1.0 - (_651 * _651));
        float _663;
        if (_597)
        {
            _663 = fast::max(_636, 0.1550000011920928955078125 - _654);
        }
        else
        {
            _663 = fast::max(_636, 0.004999999888241291046142578125 - _654);
        }
        float3 _684;
        float _685;
        float _686;
        if (_597)
        {
            float _666 = _576.z;
            float _670 = fast::clamp(exp(-_666) - 0.5, 0.0, 1.0);
            float3 _682;
            float _683;
            if (_670 < 1.0)
            {
                float3 _675 = _576;
                _675.z = fast::max(_666, 0.1500000059604644775390625);
                float3 _676 = normalize(_675);
                float3 _678 = _638 + (_676 * _637);
                _682 = _676;
                _683 = dot(_678, _676) / length(_678);
            }
            else
            {
                _682 = _576;
                _683 = _663;
            }
            _684 = _682;
            _685 = _670;
            _686 = _683;
        }
        else
        {
            _684 = _576;
            _685 = 0.0;
            _686 = _663;
        }
        float _688 = 1.0 + (_648 * _648);
        float _699 = _639 * _639;
        float _701 = sqrt(_699 - 40449600.0);
        float _702 = _639 * _686;
        float _705 = ((_702 * _702) - _699) + 40449600.0;
        float4 _710 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_702 < 0.0) && (_705 > 0.0)));
        float _713 = float(View.View_AtmosphericFogInscatterAltitudeSampleNum);
        float _714 = 0.5 / _713;
        float _717 = 1.0 - (1.0 / _713);
        float _719 = _714 + ((_701 * 0.00105685577727854251861572265625) * _717);
        float _731 = _710.w + ((((_702 * _710.x) + sqrt(_705 + _710.y)) / (_701 + _710.z)) * 0.4921875);
        float _740 = (_648 + 1.0) * 3.5;
        float _741 = floor(_740);
        float _742 = _740 - _741;
        float _743 = _741 + (0.015625 + (((atan(fast::max(_650, -0.19750000536441802978515625) * 5.349621295928955078125) * 0.90909087657928466796875) + 0.7400000095367431640625) * 0.484375));
        float _744 = _743 * 0.125;
        float _748 = 1.0 - _742;
        float _751 = (_743 + 1.0) * 0.125;
        float4 _757 = fast::max((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_744, _731, _719), level(0.0)) * _748) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_751, _731, _719), level(0.0)) * _742), float4(0.0));
        float3 _1123;
        float4 _1124;
        if (_637 > 0.0)
        {
            float2 _768 = float2(_686, _686 + (_637 / _639));
            float2 _769 = _768 * sqrt((0.5 / View.View_AtmosphericFogHeightScaleRayleigh) * _639);
            float2 _772 = float2(int2(sign(_769)));
            float2 _773 = _769 * _769;
            float _789 = 2.0 * _639;
            float _791 = (_637 / _789) + _686;
            float _799 = 6360.0 - _639;
            float2 _809 = _768 * sqrt(0.4166666567325592041015625 * _639);
            float2 _812 = float2(int2(sign(_809)));
            float2 _813 = _809 * _809;
            float3 _842 = exp((float3(-0.0057999999262392520904541015625, -0.013500000350177288055419921875, -0.033100001513957977294921875) * ((sqrt((6.283100128173828125 * View.View_AtmosphericFogHeightScaleRayleigh) * _639) * exp(_799 / View.View_AtmosphericFogHeightScaleRayleigh)) * (((_772.y > _772.x) ? exp(_773.x) : 0.0) + dot((_772 / ((abs(_769) * 2.3192999362945556640625) + sqrt((_773 * 1.519999980926513671875) + float2(4.0)))) * float2(1.0, exp(((-_637) / View.View_AtmosphericFogHeightScaleRayleigh) * _791)), float2(1.0, -1.0))))) - (float3(0.00444444455206394195556640625) * ((sqrt(7.5397205352783203125 * _639) * exp(_799 * 0.833333313465118408203125)) * (((_812.y > _812.x) ? exp(_813.x) : 0.0) + dot((_812 / ((abs(_809) * 2.3192999362945556640625) + sqrt((_813 * 1.519999980926513671875) + float2(4.0)))) * float2(1.0, exp((_637 * (-0.833333313465118408203125)) * _791)), float2(1.0, -1.0))))));
            float _850;
            if (_597)
            {
                _850 = fast::max(_647, _639);
            }
            else
            {
                _850 = _647;
            }
            float4 _1122;
            if (_850 > 6360.009765625)
            {
                float4 _1121;
                if (_685 < 1.0)
                {
                    float4 _861 = _842.xyzx;
                    float _862 = _850 * _850;
                    float _864 = sqrt(_862 - 40449600.0);
                    float _865 = _850 * (dot(_646, _684) / _647);
                    float _868 = ((_865 * _865) - _862) + 40449600.0;
                    float4 _873 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_865 < 0.0) && (_868 > 0.0)));
                    float _876 = _714 + ((_864 * 0.00105685577727854251861572265625) * _717);
                    float _888 = _873.w + ((((_865 * _873.x) + sqrt(_868 + _873.y)) / (_864 + _873.z)) * 0.4921875);
                    float _896 = _741 + (0.015625 + (((atan(fast::max(dot(_646, View.View_AtmosphereLightDirection[0].xyz) / _647, -0.19750000536441802978515625) * 5.349621295928955078125) * 0.90909087657928466796875) + 0.7400000095367431640625) * 0.484375));
                    float _897 = _896 * 0.125;
                    float _903 = (_896 + 1.0) * 0.125;
                    float4 _911 = fast::max(_757 - (_861 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_897, _888, _876), level(0.0)) * _748) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_903, _888, _876), level(0.0)) * _742))), float4(0.0));
                    float4 _1120;
                    if (!_597)
                    {
                        float _955 = _686 - (-_654);
                        float4 _1119;
                        if (abs(_955) < 0.004999999888241291046142578125)
                        {
                            float _962 = (-0.004999999888241291046142578125) - _654;
                            float _964 = _699 + (_637 * _637);
                            float _965 = _789 * _637;
                            float _968 = sqrt(_964 + (_965 * _962));
                            float _969 = _639 * _962;
                            float _972 = 0.004999999888241291046142578125 - _654;
                            float _976 = ((_969 * _969) - _699) + 40449600.0;
                            float4 _981 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_969 < 0.0) && (_976 > 0.0)));
                            float _993 = _981.w + ((((_969 * _981.x) + sqrt(_976 + _981.y)) / (_701 + _981.z)) * 0.4921875);
                            float _1003 = _968 * _968;
                            float _1005 = sqrt(_1003 - 40449600.0);
                            float _1006 = _968 * fast::max(_972, (_969 + _637) / _968);
                            float _1009 = ((_1006 * _1006) - _1003) + 40449600.0;
                            float4 _1014 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_1006 < 0.0) && (_1009 > 0.0)));
                            float _1017 = _714 + ((_1005 * 0.00105685577727854251861572265625) * _717);
                            float _1029 = _1014.w + ((((_1006 * _1014.x) + sqrt(_1009 + _1014.y)) / (_1005 + _1014.z)) * 0.4921875);
                            float _1044 = sqrt(_964 + (_965 * _972));
                            float _1045 = _639 * _972;
                            float _1051 = ((_1045 * _1045) - _699) + 40449600.0;
                            float4 _1056 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_1045 < 0.0) && (_1051 > 0.0)));
                            float _1068 = _1056.w + ((((_1045 * _1056.x) + sqrt(_1051 + _1056.y)) / (_701 + _1056.z)) * 0.4921875);
                            float _1078 = _1044 * _1044;
                            float _1080 = sqrt(_1078 - 40449600.0);
                            float _1081 = _1044 * fast::max(_972, (_1045 + _637) / _1044);
                            float _1084 = ((_1081 * _1081) - _1078) + 40449600.0;
                            float4 _1089 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_1081 < 0.0) && (_1084 > 0.0)));
                            float _1092 = _714 + ((_1080 * 0.00105685577727854251861572265625) * _717);
                            float _1104 = _1089.w + ((((_1081 * _1089.x) + sqrt(_1084 + _1089.y)) / (_1080 + _1089.z)) * 0.4921875);
                            _1119 = mix(fast::max(((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_744, _993, _719), level(0.0)) * _748) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_751, _993, _719), level(0.0)) * _742)) - (_861 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_897, _1029, _1017), level(0.0)) * _748) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_903, _1029, _1017), level(0.0)) * _742))), float4(0.0)), fast::max(((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_744, _1068, _719), level(0.0)) * _748) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_751, _1068, _719), level(0.0)) * _742)) - (_861 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_897, _1104, _1092), level(0.0)) * _748) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_903, _1104, _1092), level(0.0)) * _742))), float4(0.0)), float4((_955 + 0.004999999888241291046142578125) * 100.0));
                        }
                        else
                        {
                            _1119 = _911;
                        }
                        _1120 = _1119;
                    }
                    else
                    {
                        float4 _954;
                        if (_685 > 0.0)
                        {
                            float _920 = _639 * _663;
                            float _923 = ((_920 * _920) - _699) + 40449600.0;
                            float4 _928 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_920 < 0.0) && (_923 > 0.0)));
                            float _940 = _928.w + ((((_920 * _928.x) + sqrt(_923 + _928.y)) / (_701 + _928.z)) * 0.4921875);
                            _954 = mix(_911, (float4(1.0) - _861) * fast::max((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_744, _940, _719), level(0.0)) * _748) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_751, _940, _719), level(0.0)) * _742), float4(0.0)), float4(_685));
                        }
                        else
                        {
                            _954 = _911;
                        }
                        _1120 = _954;
                    }
                    _1121 = _1120;
                }
                else
                {
                    _1121 = (float4(1.0) - _842.xyzx) * _757;
                }
                _1122 = _1121;
            }
            else
            {
                _1122 = _757;
            }
            _1123 = _842;
            _1124 = _1122;
        }
        else
        {
            _1123 = float3(1.0);
            _1124 = _757;
        }
        _1139 = _1123;
        _1140 = fast::max((_1124.xyz * (0.0596831031143665313720703125 * _688)) + ((((_1124.xyz * (_1124.w * smoothstep(0.0, 0.0199999995529651641845703125, _650))) / float3(fast::max(_1124.x, 9.9999997473787516355514526367188e-05))) * float3(1.0, 0.429629623889923095703125, 0.17522656917572021484375)) * (((0.042971827089786529541015625 * pow(abs(1.6400001049041748046875 - (1.60000002384185791015625 * _648)), -1.5)) * _688) * 0.37878787517547607421875)), float3(0.0));
    }
    else
    {
        _1139 = float3(1.0);
        _1140 = float3(0.0);
    }
    float3 _1205;
    if ((View.View_AtmosphericFogRenderMask & 2u) == 0u)
    {
        float3 _1204;
        if (_608 > 0.0)
        {
            float3 _1151 = _574 + (_576 * _608);
            float _1152 = length(_1151);
            float3 _1154 = _1151 / float3(_1152);
            float _1155 = dot(_1154, View.View_AtmosphereLightDirection[0].xyz);
            float _1157 = (_1152 - 6360.0) * 0.014285714365541934967041015625;
            float3 _1170 = select(View_AtmosphereTransmittanceTexture.sample(View_AtmosphereTransmittanceTextureSampler, float2(atan((_1155 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt(_1157)), level(0.0)).xyz, float3(0.0), bool3(_597));
            float3 _1182 = ((_1170 * fast::max(_1155, 0.0)) + View_AtmosphereIrradianceTexture.sample(View_AtmosphereIrradianceTextureSampler, float2((_1155 + 0.20000000298023223876953125) * 0.833333313465118408203125, _1157), level(0.0)).xyz) * float3(0.0031830989755690097808837890625);
            float3 _1202;
            if ((!_597) && true)
            {
                float3 _1188 = normalize(View.View_AtmosphereLightDirection[0].xyz - _576);
                _1202 = _1182 + (_1170 * fast::max((0.0199999995529651641845703125 + (0.980000019073486328125 * pow(1.0 - dot(-_576, _1188), 5.0))) * pow(fast::max(dot(_1188, _1154), 0.0), 150.0), 0.0));
            }
            else
            {
                _1202 = _1182;
            }
            _1204 = _1139 * _1202;
        }
        else
        {
            _1204 = float3(0.0);
        }
        _1205 = _1204;
    }
    else
    {
        _1205 = float3(0.0);
    }
    float3 _1242;
    if ((View.View_AtmosphericFogRenderMask & 1u) == 0u)
    {
        float3 _1241;
        switch (0u)
        {
            default:
            {
                if (_608 > 0.0)
                {
                    _1241 = float3(0.0);
                    break;
                }
                else
                {
                    _1241 = (select(float3(1.0), View_AtmosphereTransmittanceTexture.sample(View_AtmosphereTransmittanceTextureSampler, float2(atan((_578 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt((_575 - 6360.0) * 0.014285714365541934967041015625)), level(0.0)).xyz, bool3(_575 <= 6430.0)) * step(View.View_AtmosphereLightDiscCosHalfApexAngle[0].x, dot(_576, View.View_AtmosphereLightDirection[0].xyz))) * View.View_AtmosphereLightDiscLuminance[0].xyz;
                    break;
                }
            }
        }
        _1242 = _1241;
    }
    else
    {
        _1242 = float3(0.0);
    }
    float _1262 = mix(fast::clamp((_1139.x * View.View_AtmosphericFogDensityScale) - View.View_AtmosphericFogDensityOffset, 0.0, 1.0), 1.0, 1.0 - _596);
    float4 _1266 = float4((View.View_AtmosphereLightColor[0].xyz * (View.View_AtmosphericFogSunPower * _607)) * ((_1242 + _1205) + _1140), _1262);
    float4 _1343;
    if (View.View_SkyAtmosphereApplyCameraAerialPerspectiveVolume > 0.0)
    {
        float3 _1280 = (_557 * 9.9999997473787516355514526367188e-06) - (View.View_TranslatedWorldCameraOrigin * 9.9999997473787516355514526367188e-06);
        float _1286 = sqrt((fast::max(0.0, length(_1280) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
        float _1287 = _1286 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
        float _1294;
        if (_1287 < 0.707106769084930419921875)
        {
            _1294 = fast::clamp((_1287 * _1287) * 2.0, 0.0, 1.0);
        }
        else
        {
            _1294 = 1.0;
        }
        float2 _1322;
        if (View.View_RealTimeReflectionCapture != 0.0)
        {
            float3 _1297 = normalize(_1280);
            float _1298 = _1297.z;
            float _1301 = sqrt(1.0 - (_1298 * _1298));
            float2 _1304 = _185;
            _1304.y = (_1298 * 0.5) + 0.5;
            float _1309 = acos(_1297.x / _1301);
            float2 _1314 = _1304;
            _1314.x = (((_1297.y / _1301) < 0.0) ? (6.283185482025146484375 - _1309) : _1309) * 0.15915493667125701904296875;
            _1322 = (_1314 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
        }
        else
        {
            _1322 = ((_541.xy / _541.ww) * float2(0.5, -0.5)) + float2(0.5);
        }
        float4 _1327 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_1322, _1286), level(0.0));
        float3 _1339 = _1266.xyz + (((_1327.xyz * _1294).xyz * View.View_OneOverPreExposure).xyz * _1262);
        float4 _1342 = float4(_1339.x, _1339.y, _1339.z, _183.w);
        _1342.w = _1262 * (1.0 - (_1294 * (1.0 - _1327.w)));
        _1343 = _1342;
    }
    else
    {
        _1343 = _1266;
    }
    out.out_var_TEXCOORD10 = _546;
    out.out_var_TEXCOORD11 = float4(_524[2], float(int(sign(determinant(_524)))));
    out.out_var_TEXCOORD2 = in.in_var_ATTRIBUTE3;
    out_var_TEXCOORD3 = _556;
    out.out_var_PARTICLE_SUBUVS = float4(_485.x, _485.y, _488.x, _488.y);
    out.out_var_PARTICLE_LIGHTING_OFFSET = ((fract(float3(1361.456298828125, 2333.577880859375, 3623.98291015625) * (_526 * _526)) * 2.0) - float3(1.0)) * (0.5 * View.View_TranslucencyLightingVolumeInvSize[0].w);
    out.out_var_TEXCOORD7 = _1343;
    out.gl_Position = _541;
    out.out_var_TEXCOORD3_0 = out_var_TEXCOORD3[0];
    return out;
}

