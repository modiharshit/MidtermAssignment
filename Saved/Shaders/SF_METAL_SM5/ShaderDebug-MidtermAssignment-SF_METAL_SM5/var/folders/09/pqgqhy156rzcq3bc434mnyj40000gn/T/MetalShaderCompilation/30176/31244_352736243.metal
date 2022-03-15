

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
    char _m1_pad[1024];
    float3 View_TranslatedWorldCameraOrigin;
    char _m2_pad[16];
    float3 View_PreViewTranslation;
    char _m3_pad[1032];
    float View_OneOverPreExposure;
    char _m4_pad[352];
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
    char _m16_pad[32];
    spvUnsafeArray<float4, 2> View_AtmosphereLightDiscLuminance;
    spvUnsafeArray<float4, 2> View_AtmosphereLightDiscCosHalfApexAngle;
    char _m18_pad[144];
    float4 View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize;
    float View_SkyAtmosphereAerialPerspectiveStartDepthKm;
    float View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
    float View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv;
    char _m22_pad[4];
    float View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv;
    float View_SkyAtmosphereApplyCameraAerialPerspectiveVolume;
    uint View_AtmosphericFogRenderMask;
    uint View_AtmosphericFogInscatterAltitudeSampleNum;
    char _m26_pad[16];
    float View_RealTimeReflectionCapture;
};

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
    float4 Primitive_InvNonUniformScaleAndDeterminantSign;
};

struct type_PrecomputedLightingBuffer
{
    char _m0_pad[32];
    float4 PrecomputedLightingBuffer_LightMapCoordinateScaleBias;
    float4 PrecomputedLightingBuffer_ShadowMapCoordinateScaleBias;
};

struct type_Globals
{
    spvUnsafeArray<float4, 10> SplineParams;
};

constant float3x3 _177 = {};
constant float4 _178 = {};
constant float2 _180 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD0_0 [[user(locn2)]];
    float4 out_var_TEXCOORD4 [[user(locn3)]];
    float4 out_var_TEXCOORD7 [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    float2 in_var_ATTRIBUTE4 [[attribute(4)]];
    float2 in_var_ATTRIBUTE15 [[attribute(15)]];
};

vertex Main_out Main_00007a0c_150653f3(Main_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_PrecomputedLightingBuffer& PrecomputedLightingBuffer [[buffer(2)]], constant type_Globals& _Globals [[buffer(3)]], texture2d<float> View_AtmosphereTransmittanceTexture [[texture(0)]], texture2d<float> View_AtmosphereIrradianceTexture [[texture(1)]], texture3d<float> View_AtmosphereInscatterTexture [[texture(2)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(3)]], sampler View_AtmosphereTransmittanceTextureSampler [[sampler(0)]], sampler View_AtmosphereIrradianceTextureSampler [[sampler(1)]], sampler View_AtmosphereInscatterTextureSampler [[sampler(2)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(3)]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    float _233 = dot(in.in_var_ATTRIBUTE0.xyz, _Globals.SplineParams[7].xyz);
    float _237 = _233 * _Globals.SplineParams[6].w;
    float _241 = _237 - _Globals.SplineParams[4].w;
    bool _245 = _Globals.SplineParams[3].w != 0.0;
    float _246 = smoothstep(0.0, 1.0, _241);
    float _247 = _245 ? _246 : _241;
    float3 _258 = _Globals.SplineParams[0].xyz * 6.0;
    float3 _259 = _Globals.SplineParams[1].xyz * 3.0;
    float3 _260 = _258 + _259;
    float3 _261 = _Globals.SplineParams[4].xyz * 3.0;
    float3 _262 = _260 + _261;
    float3 _263 = _Globals.SplineParams[3].xyz * 6.0;
    float3 _264 = _262 - _263;
    float3 _265 = _Globals.SplineParams[0].xyz * (-6.0);
    float3 _266 = _Globals.SplineParams[1].xyz * 4.0;
    float3 _267 = _265 - _266;
    float3 _268 = _Globals.SplineParams[4].xyz * 2.0;
    float3 _269 = _267 - _268;
    float3 _270 = _269 + _263;
    float _271 = _241 * _241;
    float3 _272 = _264 * _271;
    float3 _273 = _270 * _241;
    float3 _274 = _272 + _273;
    float3 _275 = _274 + _Globals.SplineParams[1].xyz;
    float3 _276 = normalize(_275);
    float3 _279 = cross(_Globals.SplineParams[6].xyz, _276);
    float3 _280 = normalize(_279);
    float3 _281 = cross(_276, _280);
    float3 _282 = normalize(_281);
    float _287 = mix(_Globals.SplineParams[0].w, _Globals.SplineParams[1].w, _247);
    float _288 = sin(_287);
    float _289 = cos(_287);
    float3 _290 = _280 * _289;
    float3 _291 = _282 * _288;
    float3 _292 = _290 - _291;
    float3 _293 = _282 * _289;
    float3 _294 = _280 * _288;
    float3 _295 = _293 + _294;
    float2 _302 = float2(_247);
    float2 _303 = mix(_Globals.SplineParams[2].xy, _Globals.SplineParams[5].xy, _302);
    float _304 = _303.x;
    float _309 = _303.y;
    float3x3 _320 = float3x3(_Globals.SplineParams[7].xyz, _Globals.SplineParams[8].xyz, _Globals.SplineParams[9].xyz);
    float3x3 _321 = transpose(_320);
    float3x3 _323 = float3x3(_276, _292 * float(int(sign(_304))), _295 * float(int(sign(_309)))) * _321;
    float3 _327 = (_323 * in.in_var_ATTRIBUTE2.xyz).xyz;
    float3 _329 = cross(_327, _323 * in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _332 = _177;
    _332[0] = cross(_329, _327) * in.in_var_ATTRIBUTE2.w;
    float3x3 _333 = _332;
    _333[1] = _329;
    float3x3 _334 = _333;
    _334[2] = _327;
    float3x3 _348 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _348[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _351 = _348;
    _351[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _354 = _351;
    _354[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _355 = _354 * _334;
    float _359 = _271 * _241;
    float _360 = 2.0 * _359;
    float _361 = 3.0 * _271;
    float _362 = _360 - _361;
    float _363 = _362 + 1.0;
    float3 _364 = _Globals.SplineParams[0].xyz * _363;
    float _365 = 2.0 * _271;
    float _366 = _359 - _365;
    float _367 = _366 + _241;
    float3 _368 = _Globals.SplineParams[1].xyz * _367;
    float3 _369 = _364 + _368;
    float _370 = _359 - _271;
    float3 _371 = _Globals.SplineParams[4].xyz * _370;
    float3 _372 = _369 + _371;
    float _373 = (-2.0) * _359;
    float _374 = _373 + _361;
    float3 _375 = _Globals.SplineParams[3].xyz * _374;
    float3 _376 = _372 + _375;
    float2 _379 = mix(_Globals.SplineParams[2].zw, _Globals.SplineParams[5].zw, _302);
    float _380 = _379.x;
    float3 _381 = _280 * _380;
    float3 _382 = _376 + _381;
    float _383 = _379.y;
    float3 _384 = _282 * _383;
    float3 _385 = _382 + _384;
    float3 _386 = _292 * _304;
    float3 _387 = _295 * _309;
    float3x3 _388 = float3x3(float3(0.0), _386, _387);
    float3x3 _389 = _388 * _321;
    float3 _390 = _389[0];
    float3 _391 = _389[1];
    float3 _392 = _389[2];
    float4x3 _393 = float4x3(_390, _391, _392, _385);
    float3 _394 = _393 * in.in_var_ATTRIBUTE0;
    float3 _395 = _394.xxx;
    float3 _396 = Primitive.Primitive_LocalToWorld[0].xyz * _395;
    float3 _397 = _394.yyy;
    float3 _398 = Primitive.Primitive_LocalToWorld[1].xyz * _397;
    float3 _399 = _396 + _398;
    float3 _400 = _394.zzz;
    float3 _401 = Primitive.Primitive_LocalToWorld[2].xyz * _400;
    float3 _402 = _399 + _401;
    float3 _405 = Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation;
    float3 _406 = _402 + _405;
    float _407 = _406.x;
    float _408 = _406.y;
    float _409 = _406.z;
    float4 _410 = float4(_407, _408, _409, 1.0);
    float4 _411 = float4(_410.x, _410.y, _410.z, _410.w);
    float4 _412 = View.View_TranslatedWorldToClip * _411;
    float2 _419 = (in.in_var_ATTRIBUTE15 * PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapCoordinateScaleBias.xy) + PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapCoordinateScaleBias.zw;
    float2 _425 = (in.in_var_ATTRIBUTE15 * PrecomputedLightingBuffer.PrecomputedLightingBuffer_ShadowMapCoordinateScaleBias.xy) + PrecomputedLightingBuffer.PrecomputedLightingBuffer_ShadowMapCoordinateScaleBias.zw;
    spvUnsafeArray<float4, 1> _437 = { float4(in.in_var_ATTRIBUTE4.x, in.in_var_ATTRIBUTE4.y, float4(0.0).z, float4(0.0).w) };
    float3 _438 = _410.xyz;
    float3 _439 = _438 - View.View_TranslatedWorldCameraOrigin;
    float _443 = 9.9999997473787516355514526367188e-06 * View.View_AtmosphericFogDistanceScale;
    float3 _451 = View.View_TranslatedWorldCameraOrigin;
    _451.z = (View.View_TranslatedWorldCameraOrigin.z - View.View_AtmosphericFogGroundOffset) * View.View_AtmosphericFogAltitudeScale;
    float3 _452 = _451 * _443;
    float3 _455 = _452;
    _455.z = _452.z + 6360.009765625;
    float _456 = length(_455);
    float3 _457 = normalize(_439);
    float _458 = dot(_455, _457);
    float _459 = _458 / _456;
    float _461 = (-_456) * _459;
    float _465 = (_456 * _456) * ((_459 * _459) - 1.0);
    float _470 = length(_439) * _443;
    float _474 = fast::max(0.0, _470 - View.View_AtmosphericFogStartDistance);
    float _477 = fast::min((_474 * 0.100000001490116119384765625) / View.View_AtmosphericFogStartDistance, 1.0);
    bool _478 = _470 < (100.0 * View.View_AtmosphericFogDistanceScale);
    float _488;
    float _489;
    if (_478)
    {
        _488 = _477 * View.View_AtmosphericFogPower;
        _489 = fast::max(_470 + View.View_AtmosphericFogDistanceOffset, 1.0);
    }
    else
    {
        _488 = 1.0;
        _489 = _461 - sqrt(_465 + 40449600.0);
    }
    float _495 = _461 - sqrt(_465 + 41344900.0);
    bool _496 = _495 > 0.0;
    float _504;
    float _505;
    float3 _506;
    if (_496)
    {
        _504 = (_458 + _495) * 0.00015552098921034485101699829101562;
        _505 = _489 - _495;
        _506 = _455 + (_457 * _495);
    }
    else
    {
        _504 = _459;
        _505 = _489;
        _506 = _455;
    }
    float _507 = _496 ? 6430.0 : _456;
    bool _508 = _507 < 6360.0146484375;
    float _517;
    float _518;
    float3 _519;
    if (_508)
    {
        float _511 = 6360.0146484375 - _507;
        float3 _513 = _506 - (_457 * _511);
        _517 = dot(_513, _457) * 0.0001572323380969464778900146484375;
        _518 = _505 - _511;
        _519 = _513;
    }
    else
    {
        _517 = _504;
        _518 = _505;
        _519 = _506;
    }
    float _520 = _508 ? 6360.0146484375 : _507;
    float3 _1020;
    float3 _1021;
    if ((_520 <= 6430.0) && (_474 > 0.0))
    {
        float3 _527 = _519 + (_457 * _518);
        float _528 = length(_527);
        float _529 = dot(_457, View.View_AtmosphereLightDirection[0].xyz);
        float _531 = dot(_519, View.View_AtmosphereLightDirection[0].xyz) / _520;
        float _532 = 6360.0 / _520;
        float _535 = sqrt(1.0 - (_532 * _532));
        float _544;
        if (_478)
        {
            _544 = fast::max(_517, 0.1550000011920928955078125 - _535);
        }
        else
        {
            _544 = fast::max(_517, 0.004999999888241291046142578125 - _535);
        }
        float3 _565;
        float _566;
        float _567;
        if (_478)
        {
            float _547 = _457.z;
            float _551 = fast::clamp(exp(-_547) - 0.5, 0.0, 1.0);
            float3 _563;
            float _564;
            if (_551 < 1.0)
            {
                float3 _556 = _457;
                _556.z = fast::max(_547, 0.1500000059604644775390625);
                float3 _557 = normalize(_556);
                float3 _559 = _519 + (_557 * _518);
                _563 = _557;
                _564 = dot(_559, _557) / length(_559);
            }
            else
            {
                _563 = _457;
                _564 = _544;
            }
            _565 = _563;
            _566 = _551;
            _567 = _564;
        }
        else
        {
            _565 = _457;
            _566 = 0.0;
            _567 = _544;
        }
        float _569 = 1.0 + (_529 * _529);
        float _580 = _520 * _520;
        float _582 = sqrt(_580 - 40449600.0);
        float _583 = _520 * _567;
        float _586 = ((_583 * _583) - _580) + 40449600.0;
        float4 _591 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_583 < 0.0) && (_586 > 0.0)));
        float _594 = float(View.View_AtmosphericFogInscatterAltitudeSampleNum);
        float _595 = 0.5 / _594;
        float _598 = 1.0 - (1.0 / _594);
        float _600 = _595 + ((_582 * 0.00105685577727854251861572265625) * _598);
        float _612 = _591.w + ((((_583 * _591.x) + sqrt(_586 + _591.y)) / (_582 + _591.z)) * 0.4921875);
        float _621 = (_529 + 1.0) * 3.5;
        float _622 = floor(_621);
        float _623 = _621 - _622;
        float _624 = _622 + (0.015625 + (((atan(fast::max(_531, -0.19750000536441802978515625) * 5.349621295928955078125) * 0.90909087657928466796875) + 0.7400000095367431640625) * 0.484375));
        float _625 = _624 * 0.125;
        float _629 = 1.0 - _623;
        float _632 = (_624 + 1.0) * 0.125;
        float4 _638 = fast::max((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_625, _612, _600), level(0.0)) * _629) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_632, _612, _600), level(0.0)) * _623), float4(0.0));
        float3 _1004;
        float4 _1005;
        if (_518 > 0.0)
        {
            float2 _649 = float2(_567, _567 + (_518 / _520));
            float2 _650 = _649 * sqrt((0.5 / View.View_AtmosphericFogHeightScaleRayleigh) * _520);
            float2 _653 = float2(int2(sign(_650)));
            float2 _654 = _650 * _650;
            float _670 = 2.0 * _520;
            float _672 = (_518 / _670) + _567;
            float _680 = 6360.0 - _520;
            float2 _690 = _649 * sqrt(0.4166666567325592041015625 * _520);
            float2 _693 = float2(int2(sign(_690)));
            float2 _694 = _690 * _690;
            float3 _723 = exp((float3(-0.0057999999262392520904541015625, -0.013500000350177288055419921875, -0.033100001513957977294921875) * ((sqrt((6.283100128173828125 * View.View_AtmosphericFogHeightScaleRayleigh) * _520) * exp(_680 / View.View_AtmosphericFogHeightScaleRayleigh)) * (((_653.y > _653.x) ? exp(_654.x) : 0.0) + dot((_653 / ((abs(_650) * 2.3192999362945556640625) + sqrt((_654 * 1.519999980926513671875) + float2(4.0)))) * float2(1.0, exp(((-_518) / View.View_AtmosphericFogHeightScaleRayleigh) * _672)), float2(1.0, -1.0))))) - (float3(0.00444444455206394195556640625) * ((sqrt(7.5397205352783203125 * _520) * exp(_680 * 0.833333313465118408203125)) * (((_693.y > _693.x) ? exp(_694.x) : 0.0) + dot((_693 / ((abs(_690) * 2.3192999362945556640625) + sqrt((_694 * 1.519999980926513671875) + float2(4.0)))) * float2(1.0, exp((_518 * (-0.833333313465118408203125)) * _672)), float2(1.0, -1.0))))));
            float _731;
            if (_478)
            {
                _731 = fast::max(_528, _520);
            }
            else
            {
                _731 = _528;
            }
            float4 _1003;
            if (_731 > 6360.009765625)
            {
                float4 _1002;
                if (_566 < 1.0)
                {
                    float4 _742 = _723.xyzx;
                    float _743 = _731 * _731;
                    float _745 = sqrt(_743 - 40449600.0);
                    float _746 = _731 * (dot(_527, _565) / _528);
                    float _749 = ((_746 * _746) - _743) + 40449600.0;
                    float4 _754 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_746 < 0.0) && (_749 > 0.0)));
                    float _757 = _595 + ((_745 * 0.00105685577727854251861572265625) * _598);
                    float _769 = _754.w + ((((_746 * _754.x) + sqrt(_749 + _754.y)) / (_745 + _754.z)) * 0.4921875);
                    float _777 = _622 + (0.015625 + (((atan(fast::max(dot(_527, View.View_AtmosphereLightDirection[0].xyz) / _528, -0.19750000536441802978515625) * 5.349621295928955078125) * 0.90909087657928466796875) + 0.7400000095367431640625) * 0.484375));
                    float _778 = _777 * 0.125;
                    float _784 = (_777 + 1.0) * 0.125;
                    float4 _792 = fast::max(_638 - (_742 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_778, _769, _757), level(0.0)) * _629) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_784, _769, _757), level(0.0)) * _623))), float4(0.0));
                    float4 _1001;
                    if (!_478)
                    {
                        float _836 = _567 - (-_535);
                        float4 _1000;
                        if (abs(_836) < 0.004999999888241291046142578125)
                        {
                            float _843 = (-0.004999999888241291046142578125) - _535;
                            float _845 = _580 + (_518 * _518);
                            float _846 = _670 * _518;
                            float _849 = sqrt(_845 + (_846 * _843));
                            float _850 = _520 * _843;
                            float _853 = 0.004999999888241291046142578125 - _535;
                            float _857 = ((_850 * _850) - _580) + 40449600.0;
                            float4 _862 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_850 < 0.0) && (_857 > 0.0)));
                            float _874 = _862.w + ((((_850 * _862.x) + sqrt(_857 + _862.y)) / (_582 + _862.z)) * 0.4921875);
                            float _884 = _849 * _849;
                            float _886 = sqrt(_884 - 40449600.0);
                            float _887 = _849 * fast::max(_853, (_850 + _518) / _849);
                            float _890 = ((_887 * _887) - _884) + 40449600.0;
                            float4 _895 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_887 < 0.0) && (_890 > 0.0)));
                            float _898 = _595 + ((_886 * 0.00105685577727854251861572265625) * _598);
                            float _910 = _895.w + ((((_887 * _895.x) + sqrt(_890 + _895.y)) / (_886 + _895.z)) * 0.4921875);
                            float _925 = sqrt(_845 + (_846 * _853));
                            float _926 = _520 * _853;
                            float _932 = ((_926 * _926) - _580) + 40449600.0;
                            float4 _937 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_926 < 0.0) && (_932 > 0.0)));
                            float _949 = _937.w + ((((_926 * _937.x) + sqrt(_932 + _937.y)) / (_582 + _937.z)) * 0.4921875);
                            float _959 = _925 * _925;
                            float _961 = sqrt(_959 - 40449600.0);
                            float _962 = _925 * fast::max(_853, (_926 + _518) / _925);
                            float _965 = ((_962 * _962) - _959) + 40449600.0;
                            float4 _970 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_962 < 0.0) && (_965 > 0.0)));
                            float _973 = _595 + ((_961 * 0.00105685577727854251861572265625) * _598);
                            float _985 = _970.w + ((((_962 * _970.x) + sqrt(_965 + _970.y)) / (_961 + _970.z)) * 0.4921875);
                            _1000 = mix(fast::max(((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_625, _874, _600), level(0.0)) * _629) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_632, _874, _600), level(0.0)) * _623)) - (_742 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_778, _910, _898), level(0.0)) * _629) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_784, _910, _898), level(0.0)) * _623))), float4(0.0)), fast::max(((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_625, _949, _600), level(0.0)) * _629) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_632, _949, _600), level(0.0)) * _623)) - (_742 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_778, _985, _973), level(0.0)) * _629) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_784, _985, _973), level(0.0)) * _623))), float4(0.0)), float4((_836 + 0.004999999888241291046142578125) * 100.0));
                        }
                        else
                        {
                            _1000 = _792;
                        }
                        _1001 = _1000;
                    }
                    else
                    {
                        float4 _835;
                        if (_566 > 0.0)
                        {
                            float _801 = _520 * _544;
                            float _804 = ((_801 * _801) - _580) + 40449600.0;
                            float4 _809 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_801 < 0.0) && (_804 > 0.0)));
                            float _821 = _809.w + ((((_801 * _809.x) + sqrt(_804 + _809.y)) / (_582 + _809.z)) * 0.4921875);
                            _835 = mix(_792, (float4(1.0) - _742) * fast::max((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_625, _821, _600), level(0.0)) * _629) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_632, _821, _600), level(0.0)) * _623), float4(0.0)), float4(_566));
                        }
                        else
                        {
                            _835 = _792;
                        }
                        _1001 = _835;
                    }
                    _1002 = _1001;
                }
                else
                {
                    _1002 = (float4(1.0) - _723.xyzx) * _638;
                }
                _1003 = _1002;
            }
            else
            {
                _1003 = _638;
            }
            _1004 = _723;
            _1005 = _1003;
        }
        else
        {
            _1004 = float3(1.0);
            _1005 = _638;
        }
        _1020 = _1004;
        _1021 = fast::max((_1005.xyz * (0.0596831031143665313720703125 * _569)) + ((((_1005.xyz * (_1005.w * smoothstep(0.0, 0.0199999995529651641845703125, _531))) / float3(fast::max(_1005.x, 9.9999997473787516355514526367188e-05))) * float3(1.0, 0.429629623889923095703125, 0.17522656917572021484375)) * (((0.042971827089786529541015625 * pow(abs(1.6400001049041748046875 - (1.60000002384185791015625 * _529)), -1.5)) * _569) * 0.37878787517547607421875)), float3(0.0));
    }
    else
    {
        _1020 = float3(1.0);
        _1021 = float3(0.0);
    }
    float3 _1086;
    if ((View.View_AtmosphericFogRenderMask & 2u) == 0u)
    {
        float3 _1085;
        if (_489 > 0.0)
        {
            float3 _1032 = _455 + (_457 * _489);
            float _1033 = length(_1032);
            float3 _1035 = _1032 / float3(_1033);
            float _1036 = dot(_1035, View.View_AtmosphereLightDirection[0].xyz);
            float _1038 = (_1033 - 6360.0) * 0.014285714365541934967041015625;
            float3 _1051 = select(View_AtmosphereTransmittanceTexture.sample(View_AtmosphereTransmittanceTextureSampler, float2(atan((_1036 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt(_1038)), level(0.0)).xyz, float3(0.0), bool3(_478));
            float3 _1063 = ((_1051 * fast::max(_1036, 0.0)) + View_AtmosphereIrradianceTexture.sample(View_AtmosphereIrradianceTextureSampler, float2((_1036 + 0.20000000298023223876953125) * 0.833333313465118408203125, _1038), level(0.0)).xyz) * float3(0.0031830989755690097808837890625);
            float3 _1083;
            if ((!_478) && true)
            {
                float3 _1069 = normalize(View.View_AtmosphereLightDirection[0].xyz - _457);
                _1083 = _1063 + (_1051 * fast::max((0.0199999995529651641845703125 + (0.980000019073486328125 * pow(1.0 - dot(-_457, _1069), 5.0))) * pow(fast::max(dot(_1069, _1035), 0.0), 150.0), 0.0));
            }
            else
            {
                _1083 = _1063;
            }
            _1085 = _1020 * _1083;
        }
        else
        {
            _1085 = float3(0.0);
        }
        _1086 = _1085;
    }
    else
    {
        _1086 = float3(0.0);
    }
    float3 _1123;
    if ((View.View_AtmosphericFogRenderMask & 1u) == 0u)
    {
        float3 _1122;
        switch (0u)
        {
            default:
            {
                if (_489 > 0.0)
                {
                    _1122 = float3(0.0);
                    break;
                }
                else
                {
                    _1122 = (select(float3(1.0), View_AtmosphereTransmittanceTexture.sample(View_AtmosphereTransmittanceTextureSampler, float2(atan((_459 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt((_456 - 6360.0) * 0.014285714365541934967041015625)), level(0.0)).xyz, bool3(_456 <= 6430.0)) * step(View.View_AtmosphereLightDiscCosHalfApexAngle[0].x, dot(_457, View.View_AtmosphereLightDirection[0].xyz))) * View.View_AtmosphereLightDiscLuminance[0].xyz;
                    break;
                }
            }
        }
        _1123 = _1122;
    }
    else
    {
        _1123 = float3(0.0);
    }
    float _1143 = mix(fast::clamp((_1020.x * View.View_AtmosphericFogDensityScale) - View.View_AtmosphericFogDensityOffset, 0.0, 1.0), 1.0, 1.0 - _477);
    float4 _1147 = float4((View.View_AtmosphereLightColor[0].xyz * (View.View_AtmosphericFogSunPower * _488)) * ((_1123 + _1086) + _1021), _1143);
    float4 _1224;
    if (View.View_SkyAtmosphereApplyCameraAerialPerspectiveVolume > 0.0)
    {
        float3 _1161 = (_438 * 9.9999997473787516355514526367188e-06) - (View.View_TranslatedWorldCameraOrigin * 9.9999997473787516355514526367188e-06);
        float _1167 = sqrt((fast::max(0.0, length(_1161) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
        float _1168 = _1167 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
        float _1175;
        if (_1168 < 0.707106769084930419921875)
        {
            _1175 = fast::clamp((_1168 * _1168) * 2.0, 0.0, 1.0);
        }
        else
        {
            _1175 = 1.0;
        }
        float2 _1203;
        if (View.View_RealTimeReflectionCapture != 0.0)
        {
            float3 _1178 = normalize(_1161);
            float _1179 = _1178.z;
            float _1182 = sqrt(1.0 - (_1179 * _1179));
            float2 _1185 = _180;
            _1185.y = (_1179 * 0.5) + 0.5;
            float _1190 = acos(_1178.x / _1182);
            float2 _1195 = _1185;
            _1195.x = (((_1178.y / _1182) < 0.0) ? (6.283185482025146484375 - _1190) : _1190) * 0.15915493667125701904296875;
            _1203 = (_1195 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
        }
        else
        {
            _1203 = ((_412.xy / _412.ww) * float2(0.5, -0.5)) + float2(0.5);
        }
        float4 _1208 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_1203, _1167), level(0.0));
        float3 _1220 = _1147.xyz + (((_1208.xyz * _1175).xyz * View.View_OneOverPreExposure).xyz * _1143);
        float4 _1223 = float4(_1220.x, _1220.y, _1220.z, _178.w);
        _1223.w = _1143 * (1.0 - (_1175 * (1.0 - _1208.w)));
        _1224 = _1223;
    }
    else
    {
        _1224 = _1147;
    }
    out.out_var_TEXCOORD10_centroid = float4(_355[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_355[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _437;
    out.out_var_TEXCOORD4 = float4(_419.x, _419.y, _425.x, _425.y);
    out.out_var_TEXCOORD7 = _1224;
    out.gl_Position = _412;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

