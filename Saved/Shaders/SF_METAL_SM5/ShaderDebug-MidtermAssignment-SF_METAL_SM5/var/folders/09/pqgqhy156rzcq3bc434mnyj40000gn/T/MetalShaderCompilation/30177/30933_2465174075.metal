

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
};

struct type_Globals
{
    spvUnsafeArray<float4, 10> SplineParams;
};

constant float3x3 _178 = {};
constant float4 _179 = {};
constant float2 _181 = {};

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

vertex Main_out Main_000078d5_92ef923b(Main_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_PrecomputedLightingBuffer& PrecomputedLightingBuffer [[buffer(2)]], constant type_Globals& _Globals [[buffer(3)]], texture2d<float> View_AtmosphereTransmittanceTexture [[texture(0)]], texture2d<float> View_AtmosphereIrradianceTexture [[texture(1)]], texture3d<float> View_AtmosphereInscatterTexture [[texture(2)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(3)]], sampler View_AtmosphereTransmittanceTextureSampler [[sampler(0)]], sampler View_AtmosphereIrradianceTextureSampler [[sampler(1)]], sampler View_AtmosphereInscatterTextureSampler [[sampler(2)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(3)]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    float _234 = dot(in.in_var_ATTRIBUTE0.xyz, _Globals.SplineParams[7].xyz);
    float _238 = _234 * _Globals.SplineParams[6].w;
    float _242 = _238 - _Globals.SplineParams[4].w;
    bool _246 = _Globals.SplineParams[3].w != 0.0;
    float _247 = smoothstep(0.0, 1.0, _242);
    float _248 = _246 ? _247 : _242;
    float3 _259 = _Globals.SplineParams[0].xyz * 6.0;
    float3 _260 = _Globals.SplineParams[1].xyz * 3.0;
    float3 _261 = _259 + _260;
    float3 _262 = _Globals.SplineParams[4].xyz * 3.0;
    float3 _263 = _261 + _262;
    float3 _264 = _Globals.SplineParams[3].xyz * 6.0;
    float3 _265 = _263 - _264;
    float3 _266 = _Globals.SplineParams[0].xyz * (-6.0);
    float3 _267 = _Globals.SplineParams[1].xyz * 4.0;
    float3 _268 = _266 - _267;
    float3 _269 = _Globals.SplineParams[4].xyz * 2.0;
    float3 _270 = _268 - _269;
    float3 _271 = _270 + _264;
    float _272 = _242 * _242;
    float3 _273 = _265 * _272;
    float3 _274 = _271 * _242;
    float3 _275 = _273 + _274;
    float3 _276 = _275 + _Globals.SplineParams[1].xyz;
    float3 _277 = normalize(_276);
    float3 _280 = cross(_Globals.SplineParams[6].xyz, _277);
    float3 _281 = normalize(_280);
    float3 _282 = cross(_277, _281);
    float3 _283 = normalize(_282);
    float _288 = mix(_Globals.SplineParams[0].w, _Globals.SplineParams[1].w, _248);
    float _289 = sin(_288);
    float _290 = cos(_288);
    float3 _291 = _281 * _290;
    float3 _292 = _283 * _289;
    float3 _293 = _291 - _292;
    float3 _294 = _283 * _290;
    float3 _295 = _281 * _289;
    float3 _296 = _294 + _295;
    float2 _303 = float2(_248);
    float2 _304 = mix(_Globals.SplineParams[2].xy, _Globals.SplineParams[5].xy, _303);
    float _305 = _304.x;
    float _310 = _304.y;
    float3x3 _321 = float3x3(_Globals.SplineParams[7].xyz, _Globals.SplineParams[8].xyz, _Globals.SplineParams[9].xyz);
    float3x3 _322 = transpose(_321);
    float3x3 _324 = float3x3(_277, _293 * float(int(sign(_305))), _296 * float(int(sign(_310)))) * _322;
    float3 _328 = (_324 * in.in_var_ATTRIBUTE2.xyz).xyz;
    float3 _330 = cross(_328, _324 * in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _333 = _178;
    _333[0] = cross(_330, _328) * in.in_var_ATTRIBUTE2.w;
    float3x3 _334 = _333;
    _334[1] = _330;
    float3x3 _335 = _334;
    _335[2] = _328;
    float3x3 _349 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _349[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _352 = _349;
    _352[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _355 = _352;
    _355[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _356 = _355 * _335;
    float _360 = _272 * _242;
    float _361 = 2.0 * _360;
    float _362 = 3.0 * _272;
    float _363 = _361 - _362;
    float _364 = _363 + 1.0;
    float3 _365 = _Globals.SplineParams[0].xyz * _364;
    float _366 = 2.0 * _272;
    float _367 = _360 - _366;
    float _368 = _367 + _242;
    float3 _369 = _Globals.SplineParams[1].xyz * _368;
    float3 _370 = _365 + _369;
    float _371 = _360 - _272;
    float3 _372 = _Globals.SplineParams[4].xyz * _371;
    float3 _373 = _370 + _372;
    float _374 = (-2.0) * _360;
    float _375 = _374 + _362;
    float3 _376 = _Globals.SplineParams[3].xyz * _375;
    float3 _377 = _373 + _376;
    float2 _380 = mix(_Globals.SplineParams[2].zw, _Globals.SplineParams[5].zw, _303);
    float _381 = _380.x;
    float3 _382 = _281 * _381;
    float3 _383 = _377 + _382;
    float _384 = _380.y;
    float3 _385 = _283 * _384;
    float3 _386 = _383 + _385;
    float3 _387 = _293 * _305;
    float3 _388 = _296 * _310;
    float3x3 _389 = float3x3(float3(0.0), _387, _388);
    float3x3 _390 = _389 * _322;
    float3 _391 = _390[0];
    float3 _392 = _390[1];
    float3 _393 = _390[2];
    float4x3 _394 = float4x3(_391, _392, _393, _386);
    float3 _395 = _394 * in.in_var_ATTRIBUTE0;
    float3 _396 = _395.xxx;
    float3 _397 = Primitive.Primitive_LocalToWorld[0].xyz * _396;
    float3 _398 = _395.yyy;
    float3 _399 = Primitive.Primitive_LocalToWorld[1].xyz * _398;
    float3 _400 = _397 + _399;
    float3 _401 = _395.zzz;
    float3 _402 = Primitive.Primitive_LocalToWorld[2].xyz * _401;
    float3 _403 = _400 + _402;
    float3 _406 = Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation;
    float3 _407 = _403 + _406;
    float _408 = _407.x;
    float _409 = _407.y;
    float _410 = _407.z;
    float4 _411 = float4(_408, _409, _410, 1.0);
    float4 _412 = float4(_411.x, _411.y, _411.z, _411.w);
    float4 _413 = View.View_TranslatedWorldToClip * _412;
    float2 _420 = (in.in_var_ATTRIBUTE15 * PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapCoordinateScaleBias.xy) + PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapCoordinateScaleBias.zw;
    spvUnsafeArray<float4, 1> _432 = { float4(in.in_var_ATTRIBUTE4.x, in.in_var_ATTRIBUTE4.y, float4(0.0).z, float4(0.0).w) };
    float3 _433 = _411.xyz;
    float3 _434 = _433 - View.View_TranslatedWorldCameraOrigin;
    float _438 = 9.9999997473787516355514526367188e-06 * View.View_AtmosphericFogDistanceScale;
    float3 _446 = View.View_TranslatedWorldCameraOrigin;
    _446.z = (View.View_TranslatedWorldCameraOrigin.z - View.View_AtmosphericFogGroundOffset) * View.View_AtmosphericFogAltitudeScale;
    float3 _447 = _446 * _438;
    float3 _450 = _447;
    _450.z = _447.z + 6360.009765625;
    float _451 = length(_450);
    float3 _452 = normalize(_434);
    float _453 = dot(_450, _452);
    float _454 = _453 / _451;
    float _456 = (-_451) * _454;
    float _460 = (_451 * _451) * ((_454 * _454) - 1.0);
    float _465 = length(_434) * _438;
    float _469 = fast::max(0.0, _465 - View.View_AtmosphericFogStartDistance);
    float _472 = fast::min((_469 * 0.100000001490116119384765625) / View.View_AtmosphericFogStartDistance, 1.0);
    bool _473 = _465 < (100.0 * View.View_AtmosphericFogDistanceScale);
    float _483;
    float _484;
    if (_473)
    {
        _483 = _472 * View.View_AtmosphericFogPower;
        _484 = fast::max(_465 + View.View_AtmosphericFogDistanceOffset, 1.0);
    }
    else
    {
        _483 = 1.0;
        _484 = _456 - sqrt(_460 + 40449600.0);
    }
    float _490 = _456 - sqrt(_460 + 41344900.0);
    bool _491 = _490 > 0.0;
    float _499;
    float _500;
    float3 _501;
    if (_491)
    {
        _499 = (_453 + _490) * 0.00015552098921034485101699829101562;
        _500 = _484 - _490;
        _501 = _450 + (_452 * _490);
    }
    else
    {
        _499 = _454;
        _500 = _484;
        _501 = _450;
    }
    float _502 = _491 ? 6430.0 : _451;
    bool _503 = _502 < 6360.0146484375;
    float _512;
    float _513;
    float3 _514;
    if (_503)
    {
        float _506 = 6360.0146484375 - _502;
        float3 _508 = _501 - (_452 * _506);
        _512 = dot(_508, _452) * 0.0001572323380969464778900146484375;
        _513 = _500 - _506;
        _514 = _508;
    }
    else
    {
        _512 = _499;
        _513 = _500;
        _514 = _501;
    }
    float _515 = _503 ? 6360.0146484375 : _502;
    float3 _1015;
    float3 _1016;
    if ((_515 <= 6430.0) && (_469 > 0.0))
    {
        float3 _522 = _514 + (_452 * _513);
        float _523 = length(_522);
        float _524 = dot(_452, View.View_AtmosphereLightDirection[0].xyz);
        float _526 = dot(_514, View.View_AtmosphereLightDirection[0].xyz) / _515;
        float _527 = 6360.0 / _515;
        float _530 = sqrt(1.0 - (_527 * _527));
        float _539;
        if (_473)
        {
            _539 = fast::max(_512, 0.1550000011920928955078125 - _530);
        }
        else
        {
            _539 = fast::max(_512, 0.004999999888241291046142578125 - _530);
        }
        float3 _560;
        float _561;
        float _562;
        if (_473)
        {
            float _542 = _452.z;
            float _546 = fast::clamp(exp(-_542) - 0.5, 0.0, 1.0);
            float3 _558;
            float _559;
            if (_546 < 1.0)
            {
                float3 _551 = _452;
                _551.z = fast::max(_542, 0.1500000059604644775390625);
                float3 _552 = normalize(_551);
                float3 _554 = _514 + (_552 * _513);
                _558 = _552;
                _559 = dot(_554, _552) / length(_554);
            }
            else
            {
                _558 = _452;
                _559 = _539;
            }
            _560 = _558;
            _561 = _546;
            _562 = _559;
        }
        else
        {
            _560 = _452;
            _561 = 0.0;
            _562 = _539;
        }
        float _564 = 1.0 + (_524 * _524);
        float _575 = _515 * _515;
        float _577 = sqrt(_575 - 40449600.0);
        float _578 = _515 * _562;
        float _581 = ((_578 * _578) - _575) + 40449600.0;
        float4 _586 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_578 < 0.0) && (_581 > 0.0)));
        float _589 = float(View.View_AtmosphericFogInscatterAltitudeSampleNum);
        float _590 = 0.5 / _589;
        float _593 = 1.0 - (1.0 / _589);
        float _595 = _590 + ((_577 * 0.00105685577727854251861572265625) * _593);
        float _607 = _586.w + ((((_578 * _586.x) + sqrt(_581 + _586.y)) / (_577 + _586.z)) * 0.4921875);
        float _616 = (_524 + 1.0) * 3.5;
        float _617 = floor(_616);
        float _618 = _616 - _617;
        float _619 = _617 + (0.015625 + (((atan(fast::max(_526, -0.19750000536441802978515625) * 5.349621295928955078125) * 0.90909087657928466796875) + 0.7400000095367431640625) * 0.484375));
        float _620 = _619 * 0.125;
        float _624 = 1.0 - _618;
        float _627 = (_619 + 1.0) * 0.125;
        float4 _633 = fast::max((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_620, _607, _595), level(0.0)) * _624) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_627, _607, _595), level(0.0)) * _618), float4(0.0));
        float3 _999;
        float4 _1000;
        if (_513 > 0.0)
        {
            float2 _644 = float2(_562, _562 + (_513 / _515));
            float2 _645 = _644 * sqrt((0.5 / View.View_AtmosphericFogHeightScaleRayleigh) * _515);
            float2 _648 = float2(int2(sign(_645)));
            float2 _649 = _645 * _645;
            float _665 = 2.0 * _515;
            float _667 = (_513 / _665) + _562;
            float _675 = 6360.0 - _515;
            float2 _685 = _644 * sqrt(0.4166666567325592041015625 * _515);
            float2 _688 = float2(int2(sign(_685)));
            float2 _689 = _685 * _685;
            float3 _718 = exp((float3(-0.0057999999262392520904541015625, -0.013500000350177288055419921875, -0.033100001513957977294921875) * ((sqrt((6.283100128173828125 * View.View_AtmosphericFogHeightScaleRayleigh) * _515) * exp(_675 / View.View_AtmosphericFogHeightScaleRayleigh)) * (((_648.y > _648.x) ? exp(_649.x) : 0.0) + dot((_648 / ((abs(_645) * 2.3192999362945556640625) + sqrt((_649 * 1.519999980926513671875) + float2(4.0)))) * float2(1.0, exp(((-_513) / View.View_AtmosphericFogHeightScaleRayleigh) * _667)), float2(1.0, -1.0))))) - (float3(0.00444444455206394195556640625) * ((sqrt(7.5397205352783203125 * _515) * exp(_675 * 0.833333313465118408203125)) * (((_688.y > _688.x) ? exp(_689.x) : 0.0) + dot((_688 / ((abs(_685) * 2.3192999362945556640625) + sqrt((_689 * 1.519999980926513671875) + float2(4.0)))) * float2(1.0, exp((_513 * (-0.833333313465118408203125)) * _667)), float2(1.0, -1.0))))));
            float _726;
            if (_473)
            {
                _726 = fast::max(_523, _515);
            }
            else
            {
                _726 = _523;
            }
            float4 _998;
            if (_726 > 6360.009765625)
            {
                float4 _997;
                if (_561 < 1.0)
                {
                    float4 _737 = _718.xyzx;
                    float _738 = _726 * _726;
                    float _740 = sqrt(_738 - 40449600.0);
                    float _741 = _726 * (dot(_522, _560) / _523);
                    float _744 = ((_741 * _741) - _738) + 40449600.0;
                    float4 _749 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_741 < 0.0) && (_744 > 0.0)));
                    float _752 = _590 + ((_740 * 0.00105685577727854251861572265625) * _593);
                    float _764 = _749.w + ((((_741 * _749.x) + sqrt(_744 + _749.y)) / (_740 + _749.z)) * 0.4921875);
                    float _772 = _617 + (0.015625 + (((atan(fast::max(dot(_522, View.View_AtmosphereLightDirection[0].xyz) / _523, -0.19750000536441802978515625) * 5.349621295928955078125) * 0.90909087657928466796875) + 0.7400000095367431640625) * 0.484375));
                    float _773 = _772 * 0.125;
                    float _779 = (_772 + 1.0) * 0.125;
                    float4 _787 = fast::max(_633 - (_737 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_773, _764, _752), level(0.0)) * _624) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_779, _764, _752), level(0.0)) * _618))), float4(0.0));
                    float4 _996;
                    if (!_473)
                    {
                        float _831 = _562 - (-_530);
                        float4 _995;
                        if (abs(_831) < 0.004999999888241291046142578125)
                        {
                            float _838 = (-0.004999999888241291046142578125) - _530;
                            float _840 = _575 + (_513 * _513);
                            float _841 = _665 * _513;
                            float _844 = sqrt(_840 + (_841 * _838));
                            float _845 = _515 * _838;
                            float _848 = 0.004999999888241291046142578125 - _530;
                            float _852 = ((_845 * _845) - _575) + 40449600.0;
                            float4 _857 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_845 < 0.0) && (_852 > 0.0)));
                            float _869 = _857.w + ((((_845 * _857.x) + sqrt(_852 + _857.y)) / (_577 + _857.z)) * 0.4921875);
                            float _879 = _844 * _844;
                            float _881 = sqrt(_879 - 40449600.0);
                            float _882 = _844 * fast::max(_848, (_845 + _513) / _844);
                            float _885 = ((_882 * _882) - _879) + 40449600.0;
                            float4 _890 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_882 < 0.0) && (_885 > 0.0)));
                            float _893 = _590 + ((_881 * 0.00105685577727854251861572265625) * _593);
                            float _905 = _890.w + ((((_882 * _890.x) + sqrt(_885 + _890.y)) / (_881 + _890.z)) * 0.4921875);
                            float _920 = sqrt(_840 + (_841 * _848));
                            float _921 = _515 * _848;
                            float _927 = ((_921 * _921) - _575) + 40449600.0;
                            float4 _932 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_921 < 0.0) && (_927 > 0.0)));
                            float _944 = _932.w + ((((_921 * _932.x) + sqrt(_927 + _932.y)) / (_577 + _932.z)) * 0.4921875);
                            float _954 = _920 * _920;
                            float _956 = sqrt(_954 - 40449600.0);
                            float _957 = _920 * fast::max(_848, (_921 + _513) / _920);
                            float _960 = ((_957 * _957) - _954) + 40449600.0;
                            float4 _965 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_957 < 0.0) && (_960 > 0.0)));
                            float _968 = _590 + ((_956 * 0.00105685577727854251861572265625) * _593);
                            float _980 = _965.w + ((((_957 * _965.x) + sqrt(_960 + _965.y)) / (_956 + _965.z)) * 0.4921875);
                            _995 = mix(fast::max(((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_620, _869, _595), level(0.0)) * _624) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_627, _869, _595), level(0.0)) * _618)) - (_737 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_773, _905, _893), level(0.0)) * _624) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_779, _905, _893), level(0.0)) * _618))), float4(0.0)), fast::max(((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_620, _944, _595), level(0.0)) * _624) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_627, _944, _595), level(0.0)) * _618)) - (_737 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_773, _980, _968), level(0.0)) * _624) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_779, _980, _968), level(0.0)) * _618))), float4(0.0)), float4((_831 + 0.004999999888241291046142578125) * 100.0));
                        }
                        else
                        {
                            _995 = _787;
                        }
                        _996 = _995;
                    }
                    else
                    {
                        float4 _830;
                        if (_561 > 0.0)
                        {
                            float _796 = _515 * _539;
                            float _799 = ((_796 * _796) - _575) + 40449600.0;
                            float4 _804 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_796 < 0.0) && (_799 > 0.0)));
                            float _816 = _804.w + ((((_796 * _804.x) + sqrt(_799 + _804.y)) / (_577 + _804.z)) * 0.4921875);
                            _830 = mix(_787, (float4(1.0) - _737) * fast::max((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_620, _816, _595), level(0.0)) * _624) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_627, _816, _595), level(0.0)) * _618), float4(0.0)), float4(_561));
                        }
                        else
                        {
                            _830 = _787;
                        }
                        _996 = _830;
                    }
                    _997 = _996;
                }
                else
                {
                    _997 = (float4(1.0) - _718.xyzx) * _633;
                }
                _998 = _997;
            }
            else
            {
                _998 = _633;
            }
            _999 = _718;
            _1000 = _998;
        }
        else
        {
            _999 = float3(1.0);
            _1000 = _633;
        }
        _1015 = _999;
        _1016 = fast::max((_1000.xyz * (0.0596831031143665313720703125 * _564)) + ((((_1000.xyz * (_1000.w * smoothstep(0.0, 0.0199999995529651641845703125, _526))) / float3(fast::max(_1000.x, 9.9999997473787516355514526367188e-05))) * float3(1.0, 0.429629623889923095703125, 0.17522656917572021484375)) * (((0.042971827089786529541015625 * pow(abs(1.6400001049041748046875 - (1.60000002384185791015625 * _524)), -1.5)) * _564) * 0.37878787517547607421875)), float3(0.0));
    }
    else
    {
        _1015 = float3(1.0);
        _1016 = float3(0.0);
    }
    float3 _1081;
    if ((View.View_AtmosphericFogRenderMask & 2u) == 0u)
    {
        float3 _1080;
        if (_484 > 0.0)
        {
            float3 _1027 = _450 + (_452 * _484);
            float _1028 = length(_1027);
            float3 _1030 = _1027 / float3(_1028);
            float _1031 = dot(_1030, View.View_AtmosphereLightDirection[0].xyz);
            float _1033 = (_1028 - 6360.0) * 0.014285714365541934967041015625;
            float3 _1046 = select(View_AtmosphereTransmittanceTexture.sample(View_AtmosphereTransmittanceTextureSampler, float2(atan((_1031 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt(_1033)), level(0.0)).xyz, float3(0.0), bool3(_473));
            float3 _1058 = ((_1046 * fast::max(_1031, 0.0)) + View_AtmosphereIrradianceTexture.sample(View_AtmosphereIrradianceTextureSampler, float2((_1031 + 0.20000000298023223876953125) * 0.833333313465118408203125, _1033), level(0.0)).xyz) * float3(0.0031830989755690097808837890625);
            float3 _1078;
            if ((!_473) && true)
            {
                float3 _1064 = normalize(View.View_AtmosphereLightDirection[0].xyz - _452);
                _1078 = _1058 + (_1046 * fast::max((0.0199999995529651641845703125 + (0.980000019073486328125 * pow(1.0 - dot(-_452, _1064), 5.0))) * pow(fast::max(dot(_1064, _1030), 0.0), 150.0), 0.0));
            }
            else
            {
                _1078 = _1058;
            }
            _1080 = _1015 * _1078;
        }
        else
        {
            _1080 = float3(0.0);
        }
        _1081 = _1080;
    }
    else
    {
        _1081 = float3(0.0);
    }
    float3 _1118;
    if ((View.View_AtmosphericFogRenderMask & 1u) == 0u)
    {
        float3 _1117;
        switch (0u)
        {
            default:
            {
                if (_484 > 0.0)
                {
                    _1117 = float3(0.0);
                    break;
                }
                else
                {
                    _1117 = (select(float3(1.0), View_AtmosphereTransmittanceTexture.sample(View_AtmosphereTransmittanceTextureSampler, float2(atan((_454 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt((_451 - 6360.0) * 0.014285714365541934967041015625)), level(0.0)).xyz, bool3(_451 <= 6430.0)) * step(View.View_AtmosphereLightDiscCosHalfApexAngle[0].x, dot(_452, View.View_AtmosphereLightDirection[0].xyz))) * View.View_AtmosphereLightDiscLuminance[0].xyz;
                    break;
                }
            }
        }
        _1118 = _1117;
    }
    else
    {
        _1118 = float3(0.0);
    }
    float _1138 = mix(fast::clamp((_1015.x * View.View_AtmosphericFogDensityScale) - View.View_AtmosphericFogDensityOffset, 0.0, 1.0), 1.0, 1.0 - _472);
    float4 _1142 = float4((View.View_AtmosphereLightColor[0].xyz * (View.View_AtmosphericFogSunPower * _483)) * ((_1118 + _1081) + _1016), _1138);
    float4 _1219;
    if (View.View_SkyAtmosphereApplyCameraAerialPerspectiveVolume > 0.0)
    {
        float3 _1156 = (_433 * 9.9999997473787516355514526367188e-06) - (View.View_TranslatedWorldCameraOrigin * 9.9999997473787516355514526367188e-06);
        float _1162 = sqrt((fast::max(0.0, length(_1156) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
        float _1163 = _1162 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
        float _1170;
        if (_1163 < 0.707106769084930419921875)
        {
            _1170 = fast::clamp((_1163 * _1163) * 2.0, 0.0, 1.0);
        }
        else
        {
            _1170 = 1.0;
        }
        float2 _1198;
        if (View.View_RealTimeReflectionCapture != 0.0)
        {
            float3 _1173 = normalize(_1156);
            float _1174 = _1173.z;
            float _1177 = sqrt(1.0 - (_1174 * _1174));
            float2 _1180 = _181;
            _1180.y = (_1174 * 0.5) + 0.5;
            float _1185 = acos(_1173.x / _1177);
            float2 _1190 = _1180;
            _1190.x = (((_1173.y / _1177) < 0.0) ? (6.283185482025146484375 - _1185) : _1185) * 0.15915493667125701904296875;
            _1198 = (_1190 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
        }
        else
        {
            _1198 = ((_413.xy / _413.ww) * float2(0.5, -0.5)) + float2(0.5);
        }
        float4 _1203 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_1198, _1162), level(0.0));
        float3 _1215 = _1142.xyz + (((_1203.xyz * _1170).xyz * View.View_OneOverPreExposure).xyz * _1138);
        float4 _1218 = float4(_1215.x, _1215.y, _1215.z, _179.w);
        _1218.w = _1138 * (1.0 - (_1170 * (1.0 - _1203.w)));
        _1219 = _1218;
    }
    else
    {
        _1219 = _1142;
    }
    out.out_var_TEXCOORD10_centroid = float4(_356[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_356[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _432;
    out.out_var_TEXCOORD4 = float4(_420.x, _420.y, float2(0.0).x, float2(0.0).y);
    out.out_var_TEXCOORD7 = _1219;
    out.gl_Position = _413;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

