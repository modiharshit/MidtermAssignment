

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

struct type_Globals
{
    spvUnsafeArray<float4, 10> SplineParams;
};

constant float3x3 _171 = {};
constant float4 _172 = {};
constant float2 _174 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD0_0 [[user(locn2)]];
    float4 out_var_TEXCOORD7 [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    float2 in_var_ATTRIBUTE4 [[attribute(4)]];
};

vertex Main_out Main_00007654_75cc2eef(Main_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_Globals& _Globals [[buffer(2)]], texture2d<float> View_AtmosphereTransmittanceTexture [[texture(0)]], texture2d<float> View_AtmosphereIrradianceTexture [[texture(1)]], texture3d<float> View_AtmosphereInscatterTexture [[texture(2)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(3)]], sampler View_AtmosphereTransmittanceTextureSampler [[sampler(0)]], sampler View_AtmosphereIrradianceTextureSampler [[sampler(1)]], sampler View_AtmosphereInscatterTextureSampler [[sampler(2)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(3)]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    float _227 = dot(in.in_var_ATTRIBUTE0.xyz, _Globals.SplineParams[7].xyz);
    float _231 = _227 * _Globals.SplineParams[6].w;
    float _235 = _231 - _Globals.SplineParams[4].w;
    bool _239 = _Globals.SplineParams[3].w != 0.0;
    float _240 = smoothstep(0.0, 1.0, _235);
    float _241 = _239 ? _240 : _235;
    float3 _252 = _Globals.SplineParams[0].xyz * 6.0;
    float3 _253 = _Globals.SplineParams[1].xyz * 3.0;
    float3 _254 = _252 + _253;
    float3 _255 = _Globals.SplineParams[4].xyz * 3.0;
    float3 _256 = _254 + _255;
    float3 _257 = _Globals.SplineParams[3].xyz * 6.0;
    float3 _258 = _256 - _257;
    float3 _259 = _Globals.SplineParams[0].xyz * (-6.0);
    float3 _260 = _Globals.SplineParams[1].xyz * 4.0;
    float3 _261 = _259 - _260;
    float3 _262 = _Globals.SplineParams[4].xyz * 2.0;
    float3 _263 = _261 - _262;
    float3 _264 = _263 + _257;
    float _265 = _235 * _235;
    float3 _266 = _258 * _265;
    float3 _267 = _264 * _235;
    float3 _268 = _266 + _267;
    float3 _269 = _268 + _Globals.SplineParams[1].xyz;
    float3 _270 = normalize(_269);
    float3 _273 = cross(_Globals.SplineParams[6].xyz, _270);
    float3 _274 = normalize(_273);
    float3 _275 = cross(_270, _274);
    float3 _276 = normalize(_275);
    float _281 = mix(_Globals.SplineParams[0].w, _Globals.SplineParams[1].w, _241);
    float _282 = sin(_281);
    float _283 = cos(_281);
    float3 _284 = _274 * _283;
    float3 _285 = _276 * _282;
    float3 _286 = _284 - _285;
    float3 _287 = _276 * _283;
    float3 _288 = _274 * _282;
    float3 _289 = _287 + _288;
    float2 _296 = float2(_241);
    float2 _297 = mix(_Globals.SplineParams[2].xy, _Globals.SplineParams[5].xy, _296);
    float _298 = _297.x;
    float _303 = _297.y;
    float3x3 _314 = float3x3(_Globals.SplineParams[7].xyz, _Globals.SplineParams[8].xyz, _Globals.SplineParams[9].xyz);
    float3x3 _315 = transpose(_314);
    float3x3 _317 = float3x3(_270, _286 * float(int(sign(_298))), _289 * float(int(sign(_303)))) * _315;
    float3 _321 = (_317 * in.in_var_ATTRIBUTE2.xyz).xyz;
    float3 _323 = cross(_321, _317 * in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _326 = _171;
    _326[0] = cross(_323, _321) * in.in_var_ATTRIBUTE2.w;
    float3x3 _327 = _326;
    _327[1] = _323;
    float3x3 _328 = _327;
    _328[2] = _321;
    float3x3 _342 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _342[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _345 = _342;
    _345[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _348 = _345;
    _348[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _349 = _348 * _328;
    float _353 = _265 * _235;
    float _354 = 2.0 * _353;
    float _355 = 3.0 * _265;
    float _356 = _354 - _355;
    float _357 = _356 + 1.0;
    float3 _358 = _Globals.SplineParams[0].xyz * _357;
    float _359 = 2.0 * _265;
    float _360 = _353 - _359;
    float _361 = _360 + _235;
    float3 _362 = _Globals.SplineParams[1].xyz * _361;
    float3 _363 = _358 + _362;
    float _364 = _353 - _265;
    float3 _365 = _Globals.SplineParams[4].xyz * _364;
    float3 _366 = _363 + _365;
    float _367 = (-2.0) * _353;
    float _368 = _367 + _355;
    float3 _369 = _Globals.SplineParams[3].xyz * _368;
    float3 _370 = _366 + _369;
    float2 _373 = mix(_Globals.SplineParams[2].zw, _Globals.SplineParams[5].zw, _296);
    float _374 = _373.x;
    float3 _375 = _274 * _374;
    float3 _376 = _370 + _375;
    float _377 = _373.y;
    float3 _378 = _276 * _377;
    float3 _379 = _376 + _378;
    float3 _380 = _286 * _298;
    float3 _381 = _289 * _303;
    float3x3 _382 = float3x3(float3(0.0), _380, _381);
    float3x3 _383 = _382 * _315;
    float3 _384 = _383[0];
    float3 _385 = _383[1];
    float3 _386 = _383[2];
    float4x3 _387 = float4x3(_384, _385, _386, _379);
    float3 _388 = _387 * in.in_var_ATTRIBUTE0;
    float3 _389 = _388.xxx;
    float3 _390 = Primitive.Primitive_LocalToWorld[0].xyz * _389;
    float3 _391 = _388.yyy;
    float3 _392 = Primitive.Primitive_LocalToWorld[1].xyz * _391;
    float3 _393 = _390 + _392;
    float3 _394 = _388.zzz;
    float3 _395 = Primitive.Primitive_LocalToWorld[2].xyz * _394;
    float3 _396 = _393 + _395;
    float3 _399 = Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation;
    float3 _400 = _396 + _399;
    float _401 = _400.x;
    float _402 = _400.y;
    float _403 = _400.z;
    float4 _404 = float4(_401, _402, _403, 1.0);
    float4 _405 = float4(_404.x, _404.y, _404.z, _404.w);
    float4 _406 = View.View_TranslatedWorldToClip * _405;
    spvUnsafeArray<float4, 1> _418 = { float4(in.in_var_ATTRIBUTE4.x, in.in_var_ATTRIBUTE4.y, float4(0.0).z, float4(0.0).w) };
    float3 _419 = _404.xyz;
    float3 _420 = _419 - View.View_TranslatedWorldCameraOrigin;
    float _424 = 9.9999997473787516355514526367188e-06 * View.View_AtmosphericFogDistanceScale;
    float3 _432 = View.View_TranslatedWorldCameraOrigin;
    _432.z = (View.View_TranslatedWorldCameraOrigin.z - View.View_AtmosphericFogGroundOffset) * View.View_AtmosphericFogAltitudeScale;
    float3 _433 = _432 * _424;
    float3 _436 = _433;
    _436.z = _433.z + 6360.009765625;
    float _437 = length(_436);
    float3 _438 = normalize(_420);
    float _439 = dot(_436, _438);
    float _440 = _439 / _437;
    float _442 = (-_437) * _440;
    float _446 = (_437 * _437) * ((_440 * _440) - 1.0);
    float _451 = length(_420) * _424;
    float _455 = fast::max(0.0, _451 - View.View_AtmosphericFogStartDistance);
    float _458 = fast::min((_455 * 0.100000001490116119384765625) / View.View_AtmosphericFogStartDistance, 1.0);
    bool _459 = _451 < (100.0 * View.View_AtmosphericFogDistanceScale);
    float _469;
    float _470;
    if (_459)
    {
        _469 = _458 * View.View_AtmosphericFogPower;
        _470 = fast::max(_451 + View.View_AtmosphericFogDistanceOffset, 1.0);
    }
    else
    {
        _469 = 1.0;
        _470 = _442 - sqrt(_446 + 40449600.0);
    }
    float _476 = _442 - sqrt(_446 + 41344900.0);
    bool _477 = _476 > 0.0;
    float _485;
    float _486;
    float3 _487;
    if (_477)
    {
        _485 = (_439 + _476) * 0.00015552098921034485101699829101562;
        _486 = _470 - _476;
        _487 = _436 + (_438 * _476);
    }
    else
    {
        _485 = _440;
        _486 = _470;
        _487 = _436;
    }
    float _488 = _477 ? 6430.0 : _437;
    bool _489 = _488 < 6360.0146484375;
    float _498;
    float _499;
    float3 _500;
    if (_489)
    {
        float _492 = 6360.0146484375 - _488;
        float3 _494 = _487 - (_438 * _492);
        _498 = dot(_494, _438) * 0.0001572323380969464778900146484375;
        _499 = _486 - _492;
        _500 = _494;
    }
    else
    {
        _498 = _485;
        _499 = _486;
        _500 = _487;
    }
    float _501 = _489 ? 6360.0146484375 : _488;
    float3 _1001;
    float3 _1002;
    if ((_501 <= 6430.0) && (_455 > 0.0))
    {
        float3 _508 = _500 + (_438 * _499);
        float _509 = length(_508);
        float _510 = dot(_438, View.View_AtmosphereLightDirection[0].xyz);
        float _512 = dot(_500, View.View_AtmosphereLightDirection[0].xyz) / _501;
        float _513 = 6360.0 / _501;
        float _516 = sqrt(1.0 - (_513 * _513));
        float _525;
        if (_459)
        {
            _525 = fast::max(_498, 0.1550000011920928955078125 - _516);
        }
        else
        {
            _525 = fast::max(_498, 0.004999999888241291046142578125 - _516);
        }
        float3 _546;
        float _547;
        float _548;
        if (_459)
        {
            float _528 = _438.z;
            float _532 = fast::clamp(exp(-_528) - 0.5, 0.0, 1.0);
            float3 _544;
            float _545;
            if (_532 < 1.0)
            {
                float3 _537 = _438;
                _537.z = fast::max(_528, 0.1500000059604644775390625);
                float3 _538 = normalize(_537);
                float3 _540 = _500 + (_538 * _499);
                _544 = _538;
                _545 = dot(_540, _538) / length(_540);
            }
            else
            {
                _544 = _438;
                _545 = _525;
            }
            _546 = _544;
            _547 = _532;
            _548 = _545;
        }
        else
        {
            _546 = _438;
            _547 = 0.0;
            _548 = _525;
        }
        float _550 = 1.0 + (_510 * _510);
        float _561 = _501 * _501;
        float _563 = sqrt(_561 - 40449600.0);
        float _564 = _501 * _548;
        float _567 = ((_564 * _564) - _561) + 40449600.0;
        float4 _572 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_564 < 0.0) && (_567 > 0.0)));
        float _575 = float(View.View_AtmosphericFogInscatterAltitudeSampleNum);
        float _576 = 0.5 / _575;
        float _579 = 1.0 - (1.0 / _575);
        float _581 = _576 + ((_563 * 0.00105685577727854251861572265625) * _579);
        float _593 = _572.w + ((((_564 * _572.x) + sqrt(_567 + _572.y)) / (_563 + _572.z)) * 0.4921875);
        float _602 = (_510 + 1.0) * 3.5;
        float _603 = floor(_602);
        float _604 = _602 - _603;
        float _605 = _603 + (0.015625 + (((atan(fast::max(_512, -0.19750000536441802978515625) * 5.349621295928955078125) * 0.90909087657928466796875) + 0.7400000095367431640625) * 0.484375));
        float _606 = _605 * 0.125;
        float _610 = 1.0 - _604;
        float _613 = (_605 + 1.0) * 0.125;
        float4 _619 = fast::max((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_606, _593, _581), level(0.0)) * _610) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_613, _593, _581), level(0.0)) * _604), float4(0.0));
        float3 _985;
        float4 _986;
        if (_499 > 0.0)
        {
            float2 _630 = float2(_548, _548 + (_499 / _501));
            float2 _631 = _630 * sqrt((0.5 / View.View_AtmosphericFogHeightScaleRayleigh) * _501);
            float2 _634 = float2(int2(sign(_631)));
            float2 _635 = _631 * _631;
            float _651 = 2.0 * _501;
            float _653 = (_499 / _651) + _548;
            float _661 = 6360.0 - _501;
            float2 _671 = _630 * sqrt(0.4166666567325592041015625 * _501);
            float2 _674 = float2(int2(sign(_671)));
            float2 _675 = _671 * _671;
            float3 _704 = exp((float3(-0.0057999999262392520904541015625, -0.013500000350177288055419921875, -0.033100001513957977294921875) * ((sqrt((6.283100128173828125 * View.View_AtmosphericFogHeightScaleRayleigh) * _501) * exp(_661 / View.View_AtmosphericFogHeightScaleRayleigh)) * (((_634.y > _634.x) ? exp(_635.x) : 0.0) + dot((_634 / ((abs(_631) * 2.3192999362945556640625) + sqrt((_635 * 1.519999980926513671875) + float2(4.0)))) * float2(1.0, exp(((-_499) / View.View_AtmosphericFogHeightScaleRayleigh) * _653)), float2(1.0, -1.0))))) - (float3(0.00444444455206394195556640625) * ((sqrt(7.5397205352783203125 * _501) * exp(_661 * 0.833333313465118408203125)) * (((_674.y > _674.x) ? exp(_675.x) : 0.0) + dot((_674 / ((abs(_671) * 2.3192999362945556640625) + sqrt((_675 * 1.519999980926513671875) + float2(4.0)))) * float2(1.0, exp((_499 * (-0.833333313465118408203125)) * _653)), float2(1.0, -1.0))))));
            float _712;
            if (_459)
            {
                _712 = fast::max(_509, _501);
            }
            else
            {
                _712 = _509;
            }
            float4 _984;
            if (_712 > 6360.009765625)
            {
                float4 _983;
                if (_547 < 1.0)
                {
                    float4 _723 = _704.xyzx;
                    float _724 = _712 * _712;
                    float _726 = sqrt(_724 - 40449600.0);
                    float _727 = _712 * (dot(_508, _546) / _509);
                    float _730 = ((_727 * _727) - _724) + 40449600.0;
                    float4 _735 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_727 < 0.0) && (_730 > 0.0)));
                    float _738 = _576 + ((_726 * 0.00105685577727854251861572265625) * _579);
                    float _750 = _735.w + ((((_727 * _735.x) + sqrt(_730 + _735.y)) / (_726 + _735.z)) * 0.4921875);
                    float _758 = _603 + (0.015625 + (((atan(fast::max(dot(_508, View.View_AtmosphereLightDirection[0].xyz) / _509, -0.19750000536441802978515625) * 5.349621295928955078125) * 0.90909087657928466796875) + 0.7400000095367431640625) * 0.484375));
                    float _759 = _758 * 0.125;
                    float _765 = (_758 + 1.0) * 0.125;
                    float4 _773 = fast::max(_619 - (_723 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_759, _750, _738), level(0.0)) * _610) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_765, _750, _738), level(0.0)) * _604))), float4(0.0));
                    float4 _982;
                    if (!_459)
                    {
                        float _817 = _548 - (-_516);
                        float4 _981;
                        if (abs(_817) < 0.004999999888241291046142578125)
                        {
                            float _824 = (-0.004999999888241291046142578125) - _516;
                            float _826 = _561 + (_499 * _499);
                            float _827 = _651 * _499;
                            float _830 = sqrt(_826 + (_827 * _824));
                            float _831 = _501 * _824;
                            float _834 = 0.004999999888241291046142578125 - _516;
                            float _838 = ((_831 * _831) - _561) + 40449600.0;
                            float4 _843 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_831 < 0.0) && (_838 > 0.0)));
                            float _855 = _843.w + ((((_831 * _843.x) + sqrt(_838 + _843.y)) / (_563 + _843.z)) * 0.4921875);
                            float _865 = _830 * _830;
                            float _867 = sqrt(_865 - 40449600.0);
                            float _868 = _830 * fast::max(_834, (_831 + _499) / _830);
                            float _871 = ((_868 * _868) - _865) + 40449600.0;
                            float4 _876 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_868 < 0.0) && (_871 > 0.0)));
                            float _879 = _576 + ((_867 * 0.00105685577727854251861572265625) * _579);
                            float _891 = _876.w + ((((_868 * _876.x) + sqrt(_871 + _876.y)) / (_867 + _876.z)) * 0.4921875);
                            float _906 = sqrt(_826 + (_827 * _834));
                            float _907 = _501 * _834;
                            float _913 = ((_907 * _907) - _561) + 40449600.0;
                            float4 _918 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_907 < 0.0) && (_913 > 0.0)));
                            float _930 = _918.w + ((((_907 * _918.x) + sqrt(_913 + _918.y)) / (_563 + _918.z)) * 0.4921875);
                            float _940 = _906 * _906;
                            float _942 = sqrt(_940 - 40449600.0);
                            float _943 = _906 * fast::max(_834, (_907 + _499) / _906);
                            float _946 = ((_943 * _943) - _940) + 40449600.0;
                            float4 _951 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_943 < 0.0) && (_946 > 0.0)));
                            float _954 = _576 + ((_942 * 0.00105685577727854251861572265625) * _579);
                            float _966 = _951.w + ((((_943 * _951.x) + sqrt(_946 + _951.y)) / (_942 + _951.z)) * 0.4921875);
                            _981 = mix(fast::max(((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_606, _855, _581), level(0.0)) * _610) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_613, _855, _581), level(0.0)) * _604)) - (_723 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_759, _891, _879), level(0.0)) * _610) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_765, _891, _879), level(0.0)) * _604))), float4(0.0)), fast::max(((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_606, _930, _581), level(0.0)) * _610) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_613, _930, _581), level(0.0)) * _604)) - (_723 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_759, _966, _954), level(0.0)) * _610) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_765, _966, _954), level(0.0)) * _604))), float4(0.0)), float4((_817 + 0.004999999888241291046142578125) * 100.0));
                        }
                        else
                        {
                            _981 = _773;
                        }
                        _982 = _981;
                    }
                    else
                    {
                        float4 _816;
                        if (_547 > 0.0)
                        {
                            float _782 = _501 * _525;
                            float _785 = ((_782 * _782) - _561) + 40449600.0;
                            float4 _790 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_782 < 0.0) && (_785 > 0.0)));
                            float _802 = _790.w + ((((_782 * _790.x) + sqrt(_785 + _790.y)) / (_563 + _790.z)) * 0.4921875);
                            _816 = mix(_773, (float4(1.0) - _723) * fast::max((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_606, _802, _581), level(0.0)) * _610) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_613, _802, _581), level(0.0)) * _604), float4(0.0)), float4(_547));
                        }
                        else
                        {
                            _816 = _773;
                        }
                        _982 = _816;
                    }
                    _983 = _982;
                }
                else
                {
                    _983 = (float4(1.0) - _704.xyzx) * _619;
                }
                _984 = _983;
            }
            else
            {
                _984 = _619;
            }
            _985 = _704;
            _986 = _984;
        }
        else
        {
            _985 = float3(1.0);
            _986 = _619;
        }
        _1001 = _985;
        _1002 = fast::max((_986.xyz * (0.0596831031143665313720703125 * _550)) + ((((_986.xyz * (_986.w * smoothstep(0.0, 0.0199999995529651641845703125, _512))) / float3(fast::max(_986.x, 9.9999997473787516355514526367188e-05))) * float3(1.0, 0.429629623889923095703125, 0.17522656917572021484375)) * (((0.042971827089786529541015625 * pow(abs(1.6400001049041748046875 - (1.60000002384185791015625 * _510)), -1.5)) * _550) * 0.37878787517547607421875)), float3(0.0));
    }
    else
    {
        _1001 = float3(1.0);
        _1002 = float3(0.0);
    }
    float3 _1067;
    if ((View.View_AtmosphericFogRenderMask & 2u) == 0u)
    {
        float3 _1066;
        if (_470 > 0.0)
        {
            float3 _1013 = _436 + (_438 * _470);
            float _1014 = length(_1013);
            float3 _1016 = _1013 / float3(_1014);
            float _1017 = dot(_1016, View.View_AtmosphereLightDirection[0].xyz);
            float _1019 = (_1014 - 6360.0) * 0.014285714365541934967041015625;
            float3 _1032 = select(View_AtmosphereTransmittanceTexture.sample(View_AtmosphereTransmittanceTextureSampler, float2(atan((_1017 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt(_1019)), level(0.0)).xyz, float3(0.0), bool3(_459));
            float3 _1044 = ((_1032 * fast::max(_1017, 0.0)) + View_AtmosphereIrradianceTexture.sample(View_AtmosphereIrradianceTextureSampler, float2((_1017 + 0.20000000298023223876953125) * 0.833333313465118408203125, _1019), level(0.0)).xyz) * float3(0.0031830989755690097808837890625);
            float3 _1064;
            if ((!_459) && true)
            {
                float3 _1050 = normalize(View.View_AtmosphereLightDirection[0].xyz - _438);
                _1064 = _1044 + (_1032 * fast::max((0.0199999995529651641845703125 + (0.980000019073486328125 * pow(1.0 - dot(-_438, _1050), 5.0))) * pow(fast::max(dot(_1050, _1016), 0.0), 150.0), 0.0));
            }
            else
            {
                _1064 = _1044;
            }
            _1066 = _1001 * _1064;
        }
        else
        {
            _1066 = float3(0.0);
        }
        _1067 = _1066;
    }
    else
    {
        _1067 = float3(0.0);
    }
    float3 _1104;
    if ((View.View_AtmosphericFogRenderMask & 1u) == 0u)
    {
        float3 _1103;
        switch (0u)
        {
            default:
            {
                if (_470 > 0.0)
                {
                    _1103 = float3(0.0);
                    break;
                }
                else
                {
                    _1103 = (select(float3(1.0), View_AtmosphereTransmittanceTexture.sample(View_AtmosphereTransmittanceTextureSampler, float2(atan((_440 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt((_437 - 6360.0) * 0.014285714365541934967041015625)), level(0.0)).xyz, bool3(_437 <= 6430.0)) * step(View.View_AtmosphereLightDiscCosHalfApexAngle[0].x, dot(_438, View.View_AtmosphereLightDirection[0].xyz))) * View.View_AtmosphereLightDiscLuminance[0].xyz;
                    break;
                }
            }
        }
        _1104 = _1103;
    }
    else
    {
        _1104 = float3(0.0);
    }
    float _1124 = mix(fast::clamp((_1001.x * View.View_AtmosphericFogDensityScale) - View.View_AtmosphericFogDensityOffset, 0.0, 1.0), 1.0, 1.0 - _458);
    float4 _1128 = float4((View.View_AtmosphereLightColor[0].xyz * (View.View_AtmosphericFogSunPower * _469)) * ((_1104 + _1067) + _1002), _1124);
    float4 _1205;
    if (View.View_SkyAtmosphereApplyCameraAerialPerspectiveVolume > 0.0)
    {
        float3 _1142 = (_419 * 9.9999997473787516355514526367188e-06) - (View.View_TranslatedWorldCameraOrigin * 9.9999997473787516355514526367188e-06);
        float _1148 = sqrt((fast::max(0.0, length(_1142) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
        float _1149 = _1148 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
        float _1156;
        if (_1149 < 0.707106769084930419921875)
        {
            _1156 = fast::clamp((_1149 * _1149) * 2.0, 0.0, 1.0);
        }
        else
        {
            _1156 = 1.0;
        }
        float2 _1184;
        if (View.View_RealTimeReflectionCapture != 0.0)
        {
            float3 _1159 = normalize(_1142);
            float _1160 = _1159.z;
            float _1163 = sqrt(1.0 - (_1160 * _1160));
            float2 _1166 = _174;
            _1166.y = (_1160 * 0.5) + 0.5;
            float _1171 = acos(_1159.x / _1163);
            float2 _1176 = _1166;
            _1176.x = (((_1159.y / _1163) < 0.0) ? (6.283185482025146484375 - _1171) : _1171) * 0.15915493667125701904296875;
            _1184 = (_1176 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
        }
        else
        {
            _1184 = ((_406.xy / _406.ww) * float2(0.5, -0.5)) + float2(0.5);
        }
        float4 _1189 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_1184, _1148), level(0.0));
        float3 _1201 = _1128.xyz + (((_1189.xyz * _1156).xyz * View.View_OneOverPreExposure).xyz * _1124);
        float4 _1204 = float4(_1201.x, _1201.y, _1201.z, _172.w);
        _1204.w = _1124 * (1.0 - (_1156 * (1.0 - _1189.w)));
        _1205 = _1204;
    }
    else
    {
        _1205 = _1128;
    }
    out.out_var_TEXCOORD10_centroid = float4(_349[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_349[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _418;
    out.out_var_TEXCOORD7 = _1205;
    out.gl_Position = _406;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

