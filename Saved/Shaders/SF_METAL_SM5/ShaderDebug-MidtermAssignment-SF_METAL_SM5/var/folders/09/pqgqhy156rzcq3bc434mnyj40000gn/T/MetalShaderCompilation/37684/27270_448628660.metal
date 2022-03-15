

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
    char _m1_pad[1008];
    float3 View_WorldCameraOrigin;
    float3 View_TranslatedWorldCameraOrigin;
    char _m3_pad[16];
    float3 View_PreViewTranslation;
    char _m4_pad[1032];
    float View_OneOverPreExposure;
    char _m5_pad[352];
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
    char _m17_pad[32];
    spvUnsafeArray<float4, 2> View_AtmosphereLightDiscLuminance;
    spvUnsafeArray<float4, 2> View_AtmosphereLightDiscCosHalfApexAngle;
    char _m19_pad[144];
    float4 View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize;
    float View_SkyAtmosphereAerialPerspectiveStartDepthKm;
    float View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
    float View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv;
    char _m23_pad[4];
    float View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv;
    float View_SkyAtmosphereApplyCameraAerialPerspectiveVolume;
    uint View_AtmosphericFogRenderMask;
    uint View_AtmosphericFogInscatterAltitudeSampleNum;
    char _m27_pad[16];
    float View_RealTimeReflectionCapture;
};

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
};

struct type_BeamTrailVF
{
    float4 BeamTrailVF_CameraRight;
    float4 BeamTrailVF_CameraUp;
    float4 BeamTrailVF_ScreenAlignment;
};

constant float4 _159 = {};
constant float2 _161 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD2 [[user(locn2)]];
    float4 out_var_TEXCOORD3 [[user(locn3)]];
    float4 out_var_TEXCOORD7 [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    float4 in_var_ATTRIBUTE3 [[attribute(3)]];
    float4 in_var_ATTRIBUTE4 [[attribute(4)]];
};

vertex Main_out Main_00006a86_1abd87b4(Main_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_BeamTrailVF& BeamTrailVF [[buffer(2)]], texture2d<float> View_AtmosphereTransmittanceTexture [[texture(0)]], texture2d<float> View_AtmosphereIrradianceTexture [[texture(1)]], texture3d<float> View_AtmosphereInscatterTexture [[texture(2)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(3)]], sampler View_AtmosphereTransmittanceTextureSampler [[sampler(0)]], sampler View_AtmosphereIrradianceTextureSampler [[sampler(1)]], sampler View_AtmosphereInscatterTextureSampler [[sampler(2)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(3)]])
{
    Main_out out = {};
    float3 _218 = Primitive.Primitive_LocalToWorld[0u].xyz * in.in_var_ATTRIBUTE0.xxx;
    float3 _223 = Primitive.Primitive_LocalToWorld[1u].xyz * in.in_var_ATTRIBUTE0.yyy;
    float3 _224 = _218 + _223;
    float3 _229 = Primitive.Primitive_LocalToWorld[2u].xyz * in.in_var_ATTRIBUTE0.zzz;
    float3 _230 = _224 + _229;
    float3 _234 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _235 = _230 + _234;
    float _236 = _235.x;
    float _237 = _235.y;
    float _238 = _235.z;
    float4 _239 = float4(_236, _237, _238, 1.0);
    float4 _240 = float4(_239.x, _239.y, _239.z, _239.w);
    float4 _241 = View.View_TranslatedWorldToClip * _240;
    float3 _255 = _239.xyz;
    float3 _256 = View.View_WorldCameraOrigin - _255;
    float3 _263 = _255 - float4((((Primitive.Primitive_LocalToWorld[0u].xyz * in.in_var_ATTRIBUTE1.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * in.in_var_ATTRIBUTE1.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * in.in_var_ATTRIBUTE1.zzz)) + _234, 1.0).xyz;
    float _274 = cos(in.in_var_ATTRIBUTE2.z);
    float _277 = sin(in.in_var_ATTRIBUTE2.z);
    float3 _283 = cross(_256 / float3(sqrt(fast::max(dot(_256, _256), 0.00999999977648258209228515625))), _263 / float3(sqrt(fast::max(dot(_263, _263), 0.00999999977648258209228515625))));
    bool4 _296 = bool4(BeamTrailVF.BeamTrailVF_ScreenAlignment.x > 1.5);
    float3 _299 = select((BeamTrailVF.BeamTrailVF_CameraUp * ((-1.0) * _274)) + (BeamTrailVF.BeamTrailVF_CameraRight * _277), float4(_283 / float3(sqrt(fast::max(dot(_283, _283), 0.00999999977648258209228515625))), 0.0), _296).xyz;
    float3 _300 = select((BeamTrailVF.BeamTrailVF_CameraUp * _277) + (BeamTrailVF.BeamTrailVF_CameraRight * _274), float4(0.0), _296).xyz;
    float3x3 _304 = float3x3(_299, _300, -normalize(cross(_299, _300)));
    float3x3 _313 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz) * _304;
    float3 _314 = _313[0];
    float4 _316 = float4(_314.x, _314.y, _314.z, _159.w);
    _316.w = 0.0;
    float3 _326 = _239.xyz;
    float3 _327 = _326 - View.View_TranslatedWorldCameraOrigin;
    float _331 = 9.9999997473787516355514526367188e-06 * View.View_AtmosphericFogDistanceScale;
    float3 _339 = View.View_TranslatedWorldCameraOrigin;
    _339.z = (View.View_TranslatedWorldCameraOrigin.z - View.View_AtmosphericFogGroundOffset) * View.View_AtmosphericFogAltitudeScale;
    float3 _340 = _339 * _331;
    float3 _343 = _340;
    _343.z = _340.z + 6360.009765625;
    float _344 = length(_343);
    float3 _345 = normalize(_327);
    float _346 = dot(_343, _345);
    float _347 = _346 / _344;
    float _349 = (-_344) * _347;
    float _353 = (_344 * _344) * ((_347 * _347) - 1.0);
    float _358 = length(_327) * _331;
    float _362 = fast::max(0.0, _358 - View.View_AtmosphericFogStartDistance);
    float _365 = fast::min((_362 * 0.100000001490116119384765625) / View.View_AtmosphericFogStartDistance, 1.0);
    bool _366 = _358 < (100.0 * View.View_AtmosphericFogDistanceScale);
    float _376;
    float _377;
    if (_366)
    {
        _376 = _365 * View.View_AtmosphericFogPower;
        _377 = fast::max(_358 + View.View_AtmosphericFogDistanceOffset, 1.0);
    }
    else
    {
        _376 = 1.0;
        _377 = _349 - sqrt(_353 + 40449600.0);
    }
    float _383 = _349 - sqrt(_353 + 41344900.0);
    bool _384 = _383 > 0.0;
    float _392;
    float _393;
    float3 _394;
    if (_384)
    {
        _392 = (_346 + _383) * 0.00015552098921034485101699829101562;
        _393 = _377 - _383;
        _394 = _343 + (_345 * _383);
    }
    else
    {
        _392 = _347;
        _393 = _377;
        _394 = _343;
    }
    float _395 = _384 ? 6430.0 : _344;
    bool _396 = _395 < 6360.0146484375;
    float _405;
    float _406;
    float3 _407;
    if (_396)
    {
        float _399 = 6360.0146484375 - _395;
        float3 _401 = _394 - (_345 * _399);
        _405 = dot(_401, _345) * 0.0001572323380969464778900146484375;
        _406 = _393 - _399;
        _407 = _401;
    }
    else
    {
        _405 = _392;
        _406 = _393;
        _407 = _394;
    }
    float _408 = _396 ? 6360.0146484375 : _395;
    float3 _908;
    float3 _909;
    if ((_408 <= 6430.0) && (_362 > 0.0))
    {
        float3 _415 = _407 + (_345 * _406);
        float _416 = length(_415);
        float _417 = dot(_345, View.View_AtmosphereLightDirection[0].xyz);
        float _419 = dot(_407, View.View_AtmosphereLightDirection[0].xyz) / _408;
        float _420 = 6360.0 / _408;
        float _423 = sqrt(1.0 - (_420 * _420));
        float _432;
        if (_366)
        {
            _432 = fast::max(_405, 0.1550000011920928955078125 - _423);
        }
        else
        {
            _432 = fast::max(_405, 0.004999999888241291046142578125 - _423);
        }
        float3 _453;
        float _454;
        float _455;
        if (_366)
        {
            float _435 = _345.z;
            float _439 = fast::clamp(exp(-_435) - 0.5, 0.0, 1.0);
            float3 _451;
            float _452;
            if (_439 < 1.0)
            {
                float3 _444 = _345;
                _444.z = fast::max(_435, 0.1500000059604644775390625);
                float3 _445 = normalize(_444);
                float3 _447 = _407 + (_445 * _406);
                _451 = _445;
                _452 = dot(_447, _445) / length(_447);
            }
            else
            {
                _451 = _345;
                _452 = _432;
            }
            _453 = _451;
            _454 = _439;
            _455 = _452;
        }
        else
        {
            _453 = _345;
            _454 = 0.0;
            _455 = _432;
        }
        float _457 = 1.0 + (_417 * _417);
        float _468 = _408 * _408;
        float _470 = sqrt(_468 - 40449600.0);
        float _471 = _408 * _455;
        float _474 = ((_471 * _471) - _468) + 40449600.0;
        float4 _479 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_471 < 0.0) && (_474 > 0.0)));
        float _482 = float(View.View_AtmosphericFogInscatterAltitudeSampleNum);
        float _483 = 0.5 / _482;
        float _486 = 1.0 - (1.0 / _482);
        float _488 = _483 + ((_470 * 0.00105685577727854251861572265625) * _486);
        float _500 = _479.w + ((((_471 * _479.x) + sqrt(_474 + _479.y)) / (_470 + _479.z)) * 0.4921875);
        float _509 = (_417 + 1.0) * 3.5;
        float _510 = floor(_509);
        float _511 = _509 - _510;
        float _512 = _510 + (0.015625 + (((atan(fast::max(_419, -0.19750000536441802978515625) * 5.349621295928955078125) * 0.90909087657928466796875) + 0.7400000095367431640625) * 0.484375));
        float _513 = _512 * 0.125;
        float _517 = 1.0 - _511;
        float _520 = (_512 + 1.0) * 0.125;
        float4 _526 = fast::max((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_513, _500, _488), level(0.0)) * _517) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_520, _500, _488), level(0.0)) * _511), float4(0.0));
        float3 _892;
        float4 _893;
        if (_406 > 0.0)
        {
            float2 _537 = float2(_455, _455 + (_406 / _408));
            float2 _538 = _537 * sqrt((0.5 / View.View_AtmosphericFogHeightScaleRayleigh) * _408);
            float2 _541 = float2(int2(sign(_538)));
            float2 _542 = _538 * _538;
            float _558 = 2.0 * _408;
            float _560 = (_406 / _558) + _455;
            float _568 = 6360.0 - _408;
            float2 _578 = _537 * sqrt(0.4166666567325592041015625 * _408);
            float2 _581 = float2(int2(sign(_578)));
            float2 _582 = _578 * _578;
            float3 _611 = exp((float3(-0.0057999999262392520904541015625, -0.013500000350177288055419921875, -0.033100001513957977294921875) * ((sqrt((6.283100128173828125 * View.View_AtmosphericFogHeightScaleRayleigh) * _408) * exp(_568 / View.View_AtmosphericFogHeightScaleRayleigh)) * (((_541.y > _541.x) ? exp(_542.x) : 0.0) + dot((_541 / ((abs(_538) * 2.3192999362945556640625) + sqrt((_542 * 1.519999980926513671875) + float2(4.0)))) * float2(1.0, exp(((-_406) / View.View_AtmosphericFogHeightScaleRayleigh) * _560)), float2(1.0, -1.0))))) - (float3(0.00444444455206394195556640625) * ((sqrt(7.5397205352783203125 * _408) * exp(_568 * 0.833333313465118408203125)) * (((_581.y > _581.x) ? exp(_582.x) : 0.0) + dot((_581 / ((abs(_578) * 2.3192999362945556640625) + sqrt((_582 * 1.519999980926513671875) + float2(4.0)))) * float2(1.0, exp((_406 * (-0.833333313465118408203125)) * _560)), float2(1.0, -1.0))))));
            float _619;
            if (_366)
            {
                _619 = fast::max(_416, _408);
            }
            else
            {
                _619 = _416;
            }
            float4 _891;
            if (_619 > 6360.009765625)
            {
                float4 _890;
                if (_454 < 1.0)
                {
                    float4 _630 = _611.xyzx;
                    float _631 = _619 * _619;
                    float _633 = sqrt(_631 - 40449600.0);
                    float _634 = _619 * (dot(_415, _453) / _416);
                    float _637 = ((_634 * _634) - _631) + 40449600.0;
                    float4 _642 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_634 < 0.0) && (_637 > 0.0)));
                    float _645 = _483 + ((_633 * 0.00105685577727854251861572265625) * _486);
                    float _657 = _642.w + ((((_634 * _642.x) + sqrt(_637 + _642.y)) / (_633 + _642.z)) * 0.4921875);
                    float _665 = _510 + (0.015625 + (((atan(fast::max(dot(_415, View.View_AtmosphereLightDirection[0].xyz) / _416, -0.19750000536441802978515625) * 5.349621295928955078125) * 0.90909087657928466796875) + 0.7400000095367431640625) * 0.484375));
                    float _666 = _665 * 0.125;
                    float _672 = (_665 + 1.0) * 0.125;
                    float4 _680 = fast::max(_526 - (_630 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_666, _657, _645), level(0.0)) * _517) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_672, _657, _645), level(0.0)) * _511))), float4(0.0));
                    float4 _889;
                    if (!_366)
                    {
                        float _724 = _455 - (-_423);
                        float4 _888;
                        if (abs(_724) < 0.004999999888241291046142578125)
                        {
                            float _731 = (-0.004999999888241291046142578125) - _423;
                            float _733 = _468 + (_406 * _406);
                            float _734 = _558 * _406;
                            float _737 = sqrt(_733 + (_734 * _731));
                            float _738 = _408 * _731;
                            float _741 = 0.004999999888241291046142578125 - _423;
                            float _745 = ((_738 * _738) - _468) + 40449600.0;
                            float4 _750 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_738 < 0.0) && (_745 > 0.0)));
                            float _762 = _750.w + ((((_738 * _750.x) + sqrt(_745 + _750.y)) / (_470 + _750.z)) * 0.4921875);
                            float _772 = _737 * _737;
                            float _774 = sqrt(_772 - 40449600.0);
                            float _775 = _737 * fast::max(_741, (_738 + _406) / _737);
                            float _778 = ((_775 * _775) - _772) + 40449600.0;
                            float4 _783 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_775 < 0.0) && (_778 > 0.0)));
                            float _786 = _483 + ((_774 * 0.00105685577727854251861572265625) * _486);
                            float _798 = _783.w + ((((_775 * _783.x) + sqrt(_778 + _783.y)) / (_774 + _783.z)) * 0.4921875);
                            float _813 = sqrt(_733 + (_734 * _741));
                            float _814 = _408 * _741;
                            float _820 = ((_814 * _814) - _468) + 40449600.0;
                            float4 _825 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_814 < 0.0) && (_820 > 0.0)));
                            float _837 = _825.w + ((((_814 * _825.x) + sqrt(_820 + _825.y)) / (_470 + _825.z)) * 0.4921875);
                            float _847 = _813 * _813;
                            float _849 = sqrt(_847 - 40449600.0);
                            float _850 = _813 * fast::max(_741, (_814 + _406) / _813);
                            float _853 = ((_850 * _850) - _847) + 40449600.0;
                            float4 _858 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_850 < 0.0) && (_853 > 0.0)));
                            float _861 = _483 + ((_849 * 0.00105685577727854251861572265625) * _486);
                            float _873 = _858.w + ((((_850 * _858.x) + sqrt(_853 + _858.y)) / (_849 + _858.z)) * 0.4921875);
                            _888 = mix(fast::max(((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_513, _762, _488), level(0.0)) * _517) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_520, _762, _488), level(0.0)) * _511)) - (_630 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_666, _798, _786), level(0.0)) * _517) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_672, _798, _786), level(0.0)) * _511))), float4(0.0)), fast::max(((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_513, _837, _488), level(0.0)) * _517) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_520, _837, _488), level(0.0)) * _511)) - (_630 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_666, _873, _861), level(0.0)) * _517) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_672, _873, _861), level(0.0)) * _511))), float4(0.0)), float4((_724 + 0.004999999888241291046142578125) * 100.0));
                        }
                        else
                        {
                            _888 = _680;
                        }
                        _889 = _888;
                    }
                    else
                    {
                        float4 _723;
                        if (_454 > 0.0)
                        {
                            float _689 = _408 * _432;
                            float _692 = ((_689 * _689) - _468) + 40449600.0;
                            float4 _697 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_689 < 0.0) && (_692 > 0.0)));
                            float _709 = _697.w + ((((_689 * _697.x) + sqrt(_692 + _697.y)) / (_470 + _697.z)) * 0.4921875);
                            _723 = mix(_680, (float4(1.0) - _630) * fast::max((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_513, _709, _488), level(0.0)) * _517) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_520, _709, _488), level(0.0)) * _511), float4(0.0)), float4(_454));
                        }
                        else
                        {
                            _723 = _680;
                        }
                        _889 = _723;
                    }
                    _890 = _889;
                }
                else
                {
                    _890 = (float4(1.0) - _611.xyzx) * _526;
                }
                _891 = _890;
            }
            else
            {
                _891 = _526;
            }
            _892 = _611;
            _893 = _891;
        }
        else
        {
            _892 = float3(1.0);
            _893 = _526;
        }
        _908 = _892;
        _909 = fast::max((_893.xyz * (0.0596831031143665313720703125 * _457)) + ((((_893.xyz * (_893.w * smoothstep(0.0, 0.0199999995529651641845703125, _419))) / float3(fast::max(_893.x, 9.9999997473787516355514526367188e-05))) * float3(1.0, 0.429629623889923095703125, 0.17522656917572021484375)) * (((0.042971827089786529541015625 * pow(abs(1.6400001049041748046875 - (1.60000002384185791015625 * _417)), -1.5)) * _457) * 0.37878787517547607421875)), float3(0.0));
    }
    else
    {
        _908 = float3(1.0);
        _909 = float3(0.0);
    }
    float3 _974;
    if ((View.View_AtmosphericFogRenderMask & 2u) == 0u)
    {
        float3 _973;
        if (_377 > 0.0)
        {
            float3 _920 = _343 + (_345 * _377);
            float _921 = length(_920);
            float3 _923 = _920 / float3(_921);
            float _924 = dot(_923, View.View_AtmosphereLightDirection[0].xyz);
            float _926 = (_921 - 6360.0) * 0.014285714365541934967041015625;
            float3 _939 = select(View_AtmosphereTransmittanceTexture.sample(View_AtmosphereTransmittanceTextureSampler, float2(atan((_924 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt(_926)), level(0.0)).xyz, float3(0.0), bool3(_366));
            float3 _951 = ((_939 * fast::max(_924, 0.0)) + View_AtmosphereIrradianceTexture.sample(View_AtmosphereIrradianceTextureSampler, float2((_924 + 0.20000000298023223876953125) * 0.833333313465118408203125, _926), level(0.0)).xyz) * float3(0.0031830989755690097808837890625);
            float3 _971;
            if ((!_366) && true)
            {
                float3 _957 = normalize(View.View_AtmosphereLightDirection[0].xyz - _345);
                _971 = _951 + (_939 * fast::max((0.0199999995529651641845703125 + (0.980000019073486328125 * pow(1.0 - dot(-_345, _957), 5.0))) * pow(fast::max(dot(_957, _923), 0.0), 150.0), 0.0));
            }
            else
            {
                _971 = _951;
            }
            _973 = _908 * _971;
        }
        else
        {
            _973 = float3(0.0);
        }
        _974 = _973;
    }
    else
    {
        _974 = float3(0.0);
    }
    float3 _1011;
    if ((View.View_AtmosphericFogRenderMask & 1u) == 0u)
    {
        float3 _1010;
        switch (0u)
        {
            default:
            {
                if (_377 > 0.0)
                {
                    _1010 = float3(0.0);
                    break;
                }
                else
                {
                    _1010 = (select(float3(1.0), View_AtmosphereTransmittanceTexture.sample(View_AtmosphereTransmittanceTextureSampler, float2(atan((_347 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt((_344 - 6360.0) * 0.014285714365541934967041015625)), level(0.0)).xyz, bool3(_344 <= 6430.0)) * step(View.View_AtmosphereLightDiscCosHalfApexAngle[0].x, dot(_345, View.View_AtmosphereLightDirection[0].xyz))) * View.View_AtmosphereLightDiscLuminance[0].xyz;
                    break;
                }
            }
        }
        _1011 = _1010;
    }
    else
    {
        _1011 = float3(0.0);
    }
    float _1031 = mix(fast::clamp((_908.x * View.View_AtmosphericFogDensityScale) - View.View_AtmosphericFogDensityOffset, 0.0, 1.0), 1.0, 1.0 - _365);
    float4 _1035 = float4((View.View_AtmosphereLightColor[0].xyz * (View.View_AtmosphericFogSunPower * _376)) * ((_1011 + _974) + _909), _1031);
    float4 _1112;
    if (View.View_SkyAtmosphereApplyCameraAerialPerspectiveVolume > 0.0)
    {
        float3 _1049 = (_326 * 9.9999997473787516355514526367188e-06) - (View.View_TranslatedWorldCameraOrigin * 9.9999997473787516355514526367188e-06);
        float _1055 = sqrt((fast::max(0.0, length(_1049) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
        float _1056 = _1055 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
        float _1063;
        if (_1056 < 0.707106769084930419921875)
        {
            _1063 = fast::clamp((_1056 * _1056) * 2.0, 0.0, 1.0);
        }
        else
        {
            _1063 = 1.0;
        }
        float2 _1091;
        if (View.View_RealTimeReflectionCapture != 0.0)
        {
            float3 _1066 = normalize(_1049);
            float _1067 = _1066.z;
            float _1070 = sqrt(1.0 - (_1067 * _1067));
            float2 _1073 = _161;
            _1073.y = (_1067 * 0.5) + 0.5;
            float _1078 = acos(_1066.x / _1070);
            float2 _1083 = _1073;
            _1083.x = (((_1066.y / _1070) < 0.0) ? (6.283185482025146484375 - _1078) : _1078) * 0.15915493667125701904296875;
            _1091 = (_1083 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
        }
        else
        {
            _1091 = ((_241.xy / _241.ww) * float2(0.5, -0.5)) + float2(0.5);
        }
        float4 _1096 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_1091, _1055), level(0.0));
        float3 _1108 = _1035.xyz + (((_1096.xyz * _1063).xyz * View.View_OneOverPreExposure).xyz * _1031);
        float4 _1111 = float4(_1108.x, _1108.y, _1108.z, _159.w);
        _1111.w = _1031 * (1.0 - (_1063 * (1.0 - _1096.w)));
        _1112 = _1111;
    }
    else
    {
        _1112 = _1035;
    }
    out.out_var_TEXCOORD10_centroid = _316;
    out.out_var_TEXCOORD11_centroid = float4(_313[2], float(int(sign(determinant(_304)))));
    out.out_var_TEXCOORD2 = in.in_var_ATTRIBUTE3;
    out.out_var_TEXCOORD3 = in.in_var_ATTRIBUTE4;
    out.out_var_TEXCOORD7 = _1112;
    out.gl_Position = _241;
    return out;
}

