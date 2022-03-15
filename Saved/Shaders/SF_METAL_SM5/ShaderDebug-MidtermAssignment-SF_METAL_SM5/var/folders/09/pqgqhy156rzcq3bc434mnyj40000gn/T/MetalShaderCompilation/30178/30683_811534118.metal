

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
    uint NumBoneInfluencesParam;
};

constant spvUnsafeArray<float2, 1> _129 = spvUnsafeArray<float2, 1>({ float2(0.0) });

constant float3x3 _175 = {};
constant float4 _176 = {};
constant float4 _178 = {};
constant float2 _179 = {};

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
    uint4 in_var_ATTRIBUTE3 [[attribute(3)]];
    float4 in_var_ATTRIBUTE4 [[attribute(4)]];
    float2 in_var_ATTRIBUTE5_0 [[attribute(5)]];
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
    uint4 in_var_ATTRIBUTE14 [[attribute(14)]];
    float4 in_var_ATTRIBUTE15 [[attribute(15)]];
};

vertex Main_out Main_000077db_305f0726(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_Globals& _Globals [[buffer(3)]], texture_buffer<float> BoneMatrices [[texture(0)]], texture2d<float> View_AtmosphereTransmittanceTexture [[texture(1)]], texture2d<float> View_AtmosphereIrradianceTexture [[texture(2)]], texture3d<float> View_AtmosphereInscatterTexture [[texture(3)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(4)]], sampler View_AtmosphereTransmittanceTextureSampler [[sampler(0)]], sampler View_AtmosphereIrradianceTextureSampler [[sampler(1)]], sampler View_AtmosphereInscatterTextureSampler [[sampler(2)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(3)]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    spvUnsafeArray<float2, 1> in_var_ATTRIBUTE5 = {};
    in_var_ATTRIBUTE5[0] = in.in_var_ATTRIBUTE5_0;
    float4 _237 = float4(in.in_var_ATTRIBUTE4.x);
    int _240 = int(in.in_var_ATTRIBUTE3.x) * 3;
    float4 _254 = float4(in.in_var_ATTRIBUTE4.y);
    int _257 = int(in.in_var_ATTRIBUTE3.y) * 3;
    float4 _273 = float4(in.in_var_ATTRIBUTE4.z);
    int _276 = int(in.in_var_ATTRIBUTE3.z) * 3;
    float4 _292 = float4(in.in_var_ATTRIBUTE4.w);
    int _295 = int(in.in_var_ATTRIBUTE3.w) * 3;
    float4 _307 = (((_237 * BoneMatrices.read(uint(uint(_240)))) + (_254 * BoneMatrices.read(uint(uint(_257))))) + (_273 * BoneMatrices.read(uint(uint(_276))))) + (_292 * BoneMatrices.read(uint(uint(_295))));
    float4 _308 = (((_237 * BoneMatrices.read(uint(uint(_240 + 1)))) + (_254 * BoneMatrices.read(uint(uint(_257 + 1))))) + (_273 * BoneMatrices.read(uint(uint(_276 + 1))))) + (_292 * BoneMatrices.read(uint(uint(_295 + 1))));
    float4 _309 = (((_237 * BoneMatrices.read(uint(uint(_240 + 2)))) + (_254 * BoneMatrices.read(uint(uint(_257 + 2))))) + (_273 * BoneMatrices.read(uint(uint(_276 + 2))))) + (_292 * BoneMatrices.read(uint(uint(_295 + 2))));
    float3x4 _393;
    if (_Globals.NumBoneInfluencesParam > 4u)
    {
        float4 _317 = float4(in.in_var_ATTRIBUTE15.x);
        int _320 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _336 = float4(in.in_var_ATTRIBUTE15.y);
        int _339 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _355 = float4(in.in_var_ATTRIBUTE15.z);
        int _358 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _374 = float4(in.in_var_ATTRIBUTE15.w);
        int _377 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _393 = float3x4((((_307 + (_317 * BoneMatrices.read(uint(uint(_320))))) + (_336 * BoneMatrices.read(uint(uint(_339))))) + (_355 * BoneMatrices.read(uint(uint(_358))))) + (_374 * BoneMatrices.read(uint(uint(_377)))), (((_308 + (_317 * BoneMatrices.read(uint(uint(_320 + 1))))) + (_336 * BoneMatrices.read(uint(uint(_339 + 1))))) + (_355 * BoneMatrices.read(uint(uint(_358 + 1))))) + (_374 * BoneMatrices.read(uint(uint(_377 + 1)))), (((_309 + (_317 * BoneMatrices.read(uint(uint(_320 + 2))))) + (_336 * BoneMatrices.read(uint(uint(_339 + 2))))) + (_355 * BoneMatrices.read(uint(uint(_358 + 2))))) + (_374 * BoneMatrices.read(uint(uint(_377 + 2)))));
    }
    else
    {
        _393 = float3x4(_307, _308, _309);
    }
    float3 _399 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _393);
    float3x3 _400 = _175;
    _400[0] = _399;
    float3 _406 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _393);
    float3x3 _407 = _400;
    _407[2] = _406;
    float3x3 _412 = _407;
    _412[1] = normalize(cross(_406, _399) * in.in_var_ATTRIBUTE2.w);
    float3 _413 = in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11;
    float _414 = _413.x;
    float _415 = _413.y;
    float _416 = _413.z;
    float4 _417 = float4(_414, _415, _416, 1.0);
    float3 _418 = _417 * _393;
    float3 _419 = _418 + in.in_var_ATTRIBUTE12;
    float3 _424 = _419.xxx;
    float3 _425 = Primitive.Primitive_LocalToWorld[0u].xyz * _424;
    float3 _429 = _419.yyy;
    float3 _430 = Primitive.Primitive_LocalToWorld[1u].xyz * _429;
    float3 _431 = _425 + _430;
    float3 _435 = _419.zzz;
    float3 _436 = Primitive.Primitive_LocalToWorld[2u].xyz * _435;
    float3 _437 = _431 + _436;
    float3 _441 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _442 = _437 + _441;
    float _443 = _442.x;
    float _444 = _442.y;
    float _445 = _442.z;
    float4 _446 = float4(_443, _444, _445, 1.0);
    spvUnsafeArray<float2, 1> _201;
    _201 = in_var_ATTRIBUTE5;
    spvUnsafeArray<float2, 1> _202 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _448 = 0; _448 < 1; )
    {
        _202[_448] = _201[_448];
        _448++;
        continue;
    }
    float4 _457 = float4(_446.x, _446.y, _446.z, _446.w);
    float4 _458 = View.View_TranslatedWorldToClip * _457;
    float4 _461 = _178;
    _461.w = 0.0;
    float3x3 _474 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _474[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _477 = _474;
    _477[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _480 = _477;
    _480[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _481 = _480 * _412;
    float3 _482 = _481[0];
    spvUnsafeArray<float4, 1> _492 = { float4(_202[0].x, _202[0].y, float4(0.0).z, float4(0.0).w) };
    float3 _493 = _446.xyz;
    float3 _494 = _493 - View.View_TranslatedWorldCameraOrigin;
    float _498 = 9.9999997473787516355514526367188e-06 * View.View_AtmosphericFogDistanceScale;
    float3 _506 = View.View_TranslatedWorldCameraOrigin;
    _506.z = (View.View_TranslatedWorldCameraOrigin.z - View.View_AtmosphericFogGroundOffset) * View.View_AtmosphericFogAltitudeScale;
    float3 _507 = _506 * _498;
    float3 _510 = _507;
    _510.z = _507.z + 6360.009765625;
    float _511 = length(_510);
    float3 _512 = normalize(_494);
    float _513 = dot(_510, _512);
    float _514 = _513 / _511;
    float _516 = (-_511) * _514;
    float _520 = (_511 * _511) * ((_514 * _514) - 1.0);
    float _525 = length(_494) * _498;
    float _529 = fast::max(0.0, _525 - View.View_AtmosphericFogStartDistance);
    float _532 = fast::min((_529 * 0.100000001490116119384765625) / View.View_AtmosphericFogStartDistance, 1.0);
    bool _533 = _525 < (100.0 * View.View_AtmosphericFogDistanceScale);
    float _543;
    float _544;
    if (_533)
    {
        _543 = _532 * View.View_AtmosphericFogPower;
        _544 = fast::max(_525 + View.View_AtmosphericFogDistanceOffset, 1.0);
    }
    else
    {
        _543 = 1.0;
        _544 = _516 - sqrt(_520 + 40449600.0);
    }
    float _550 = _516 - sqrt(_520 + 41344900.0);
    bool _551 = _550 > 0.0;
    float _559;
    float _560;
    float3 _561;
    if (_551)
    {
        _559 = (_513 + _550) * 0.00015552098921034485101699829101562;
        _560 = _544 - _550;
        _561 = _510 + (_512 * _550);
    }
    else
    {
        _559 = _514;
        _560 = _544;
        _561 = _510;
    }
    float _562 = _551 ? 6430.0 : _511;
    bool _563 = _562 < 6360.0146484375;
    float _572;
    float _573;
    float3 _574;
    if (_563)
    {
        float _566 = 6360.0146484375 - _562;
        float3 _568 = _561 - (_512 * _566);
        _572 = dot(_568, _512) * 0.0001572323380969464778900146484375;
        _573 = _560 - _566;
        _574 = _568;
    }
    else
    {
        _572 = _559;
        _573 = _560;
        _574 = _561;
    }
    float _575 = _563 ? 6360.0146484375 : _562;
    float3 _1075;
    float3 _1076;
    if ((_575 <= 6430.0) && (_529 > 0.0))
    {
        float3 _582 = _574 + (_512 * _573);
        float _583 = length(_582);
        float _584 = dot(_512, View.View_AtmosphereLightDirection[0].xyz);
        float _586 = dot(_574, View.View_AtmosphereLightDirection[0].xyz) / _575;
        float _587 = 6360.0 / _575;
        float _590 = sqrt(1.0 - (_587 * _587));
        float _599;
        if (_533)
        {
            _599 = fast::max(_572, 0.1550000011920928955078125 - _590);
        }
        else
        {
            _599 = fast::max(_572, 0.004999999888241291046142578125 - _590);
        }
        float3 _620;
        float _621;
        float _622;
        if (_533)
        {
            float _602 = _512.z;
            float _606 = fast::clamp(exp(-_602) - 0.5, 0.0, 1.0);
            float3 _618;
            float _619;
            if (_606 < 1.0)
            {
                float3 _611 = _512;
                _611.z = fast::max(_602, 0.1500000059604644775390625);
                float3 _612 = normalize(_611);
                float3 _614 = _574 + (_612 * _573);
                _618 = _612;
                _619 = dot(_614, _612) / length(_614);
            }
            else
            {
                _618 = _512;
                _619 = _599;
            }
            _620 = _618;
            _621 = _606;
            _622 = _619;
        }
        else
        {
            _620 = _512;
            _621 = 0.0;
            _622 = _599;
        }
        float _624 = 1.0 + (_584 * _584);
        float _635 = _575 * _575;
        float _637 = sqrt(_635 - 40449600.0);
        float _638 = _575 * _622;
        float _641 = ((_638 * _638) - _635) + 40449600.0;
        float4 _646 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_638 < 0.0) && (_641 > 0.0)));
        float _649 = float(View.View_AtmosphericFogInscatterAltitudeSampleNum);
        float _650 = 0.5 / _649;
        float _653 = 1.0 - (1.0 / _649);
        float _655 = _650 + ((_637 * 0.00105685577727854251861572265625) * _653);
        float _667 = _646.w + ((((_638 * _646.x) + sqrt(_641 + _646.y)) / (_637 + _646.z)) * 0.4921875);
        float _676 = (_584 + 1.0) * 3.5;
        float _677 = floor(_676);
        float _678 = _676 - _677;
        float _679 = _677 + (0.015625 + (((atan(fast::max(_586, -0.19750000536441802978515625) * 5.349621295928955078125) * 0.90909087657928466796875) + 0.7400000095367431640625) * 0.484375));
        float _680 = _679 * 0.125;
        float _684 = 1.0 - _678;
        float _687 = (_679 + 1.0) * 0.125;
        float4 _693 = fast::max((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_680, _667, _655), level(0.0)) * _684) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_687, _667, _655), level(0.0)) * _678), float4(0.0));
        float3 _1059;
        float4 _1060;
        if (_573 > 0.0)
        {
            float2 _704 = float2(_622, _622 + (_573 / _575));
            float2 _705 = _704 * sqrt((0.5 / View.View_AtmosphericFogHeightScaleRayleigh) * _575);
            float2 _708 = float2(int2(sign(_705)));
            float2 _709 = _705 * _705;
            float _725 = 2.0 * _575;
            float _727 = (_573 / _725) + _622;
            float _735 = 6360.0 - _575;
            float2 _745 = _704 * sqrt(0.4166666567325592041015625 * _575);
            float2 _748 = float2(int2(sign(_745)));
            float2 _749 = _745 * _745;
            float3 _778 = exp((float3(-0.0057999999262392520904541015625, -0.013500000350177288055419921875, -0.033100001513957977294921875) * ((sqrt((6.283100128173828125 * View.View_AtmosphericFogHeightScaleRayleigh) * _575) * exp(_735 / View.View_AtmosphericFogHeightScaleRayleigh)) * (((_708.y > _708.x) ? exp(_709.x) : 0.0) + dot((_708 / ((abs(_705) * 2.3192999362945556640625) + sqrt((_709 * 1.519999980926513671875) + float2(4.0)))) * float2(1.0, exp(((-_573) / View.View_AtmosphericFogHeightScaleRayleigh) * _727)), float2(1.0, -1.0))))) - (float3(0.00444444455206394195556640625) * ((sqrt(7.5397205352783203125 * _575) * exp(_735 * 0.833333313465118408203125)) * (((_748.y > _748.x) ? exp(_749.x) : 0.0) + dot((_748 / ((abs(_745) * 2.3192999362945556640625) + sqrt((_749 * 1.519999980926513671875) + float2(4.0)))) * float2(1.0, exp((_573 * (-0.833333313465118408203125)) * _727)), float2(1.0, -1.0))))));
            float _786;
            if (_533)
            {
                _786 = fast::max(_583, _575);
            }
            else
            {
                _786 = _583;
            }
            float4 _1058;
            if (_786 > 6360.009765625)
            {
                float4 _1057;
                if (_621 < 1.0)
                {
                    float4 _797 = _778.xyzx;
                    float _798 = _786 * _786;
                    float _800 = sqrt(_798 - 40449600.0);
                    float _801 = _786 * (dot(_582, _620) / _583);
                    float _804 = ((_801 * _801) - _798) + 40449600.0;
                    float4 _809 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_801 < 0.0) && (_804 > 0.0)));
                    float _812 = _650 + ((_800 * 0.00105685577727854251861572265625) * _653);
                    float _824 = _809.w + ((((_801 * _809.x) + sqrt(_804 + _809.y)) / (_800 + _809.z)) * 0.4921875);
                    float _832 = _677 + (0.015625 + (((atan(fast::max(dot(_582, View.View_AtmosphereLightDirection[0].xyz) / _583, -0.19750000536441802978515625) * 5.349621295928955078125) * 0.90909087657928466796875) + 0.7400000095367431640625) * 0.484375));
                    float _833 = _832 * 0.125;
                    float _839 = (_832 + 1.0) * 0.125;
                    float4 _847 = fast::max(_693 - (_797 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_833, _824, _812), level(0.0)) * _684) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_839, _824, _812), level(0.0)) * _678))), float4(0.0));
                    float4 _1056;
                    if (!_533)
                    {
                        float _891 = _622 - (-_590);
                        float4 _1055;
                        if (abs(_891) < 0.004999999888241291046142578125)
                        {
                            float _898 = (-0.004999999888241291046142578125) - _590;
                            float _900 = _635 + (_573 * _573);
                            float _901 = _725 * _573;
                            float _904 = sqrt(_900 + (_901 * _898));
                            float _905 = _575 * _898;
                            float _908 = 0.004999999888241291046142578125 - _590;
                            float _912 = ((_905 * _905) - _635) + 40449600.0;
                            float4 _917 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_905 < 0.0) && (_912 > 0.0)));
                            float _929 = _917.w + ((((_905 * _917.x) + sqrt(_912 + _917.y)) / (_637 + _917.z)) * 0.4921875);
                            float _939 = _904 * _904;
                            float _941 = sqrt(_939 - 40449600.0);
                            float _942 = _904 * fast::max(_908, (_905 + _573) / _904);
                            float _945 = ((_942 * _942) - _939) + 40449600.0;
                            float4 _950 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_942 < 0.0) && (_945 > 0.0)));
                            float _953 = _650 + ((_941 * 0.00105685577727854251861572265625) * _653);
                            float _965 = _950.w + ((((_942 * _950.x) + sqrt(_945 + _950.y)) / (_941 + _950.z)) * 0.4921875);
                            float _980 = sqrt(_900 + (_901 * _908));
                            float _981 = _575 * _908;
                            float _987 = ((_981 * _981) - _635) + 40449600.0;
                            float4 _992 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_981 < 0.0) && (_987 > 0.0)));
                            float _1004 = _992.w + ((((_981 * _992.x) + sqrt(_987 + _992.y)) / (_637 + _992.z)) * 0.4921875);
                            float _1014 = _980 * _980;
                            float _1016 = sqrt(_1014 - 40449600.0);
                            float _1017 = _980 * fast::max(_908, (_981 + _573) / _980);
                            float _1020 = ((_1017 * _1017) - _1014) + 40449600.0;
                            float4 _1025 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_1017 < 0.0) && (_1020 > 0.0)));
                            float _1028 = _650 + ((_1016 * 0.00105685577727854251861572265625) * _653);
                            float _1040 = _1025.w + ((((_1017 * _1025.x) + sqrt(_1020 + _1025.y)) / (_1016 + _1025.z)) * 0.4921875);
                            _1055 = mix(fast::max(((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_680, _929, _655), level(0.0)) * _684) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_687, _929, _655), level(0.0)) * _678)) - (_797 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_833, _965, _953), level(0.0)) * _684) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_839, _965, _953), level(0.0)) * _678))), float4(0.0)), fast::max(((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_680, _1004, _655), level(0.0)) * _684) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_687, _1004, _655), level(0.0)) * _678)) - (_797 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_833, _1040, _1028), level(0.0)) * _684) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_839, _1040, _1028), level(0.0)) * _678))), float4(0.0)), float4((_891 + 0.004999999888241291046142578125) * 100.0));
                        }
                        else
                        {
                            _1055 = _847;
                        }
                        _1056 = _1055;
                    }
                    else
                    {
                        float4 _890;
                        if (_621 > 0.0)
                        {
                            float _856 = _575 * _599;
                            float _859 = ((_856 * _856) - _635) + 40449600.0;
                            float4 _864 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_856 < 0.0) && (_859 > 0.0)));
                            float _876 = _864.w + ((((_856 * _864.x) + sqrt(_859 + _864.y)) / (_637 + _864.z)) * 0.4921875);
                            _890 = mix(_847, (float4(1.0) - _797) * fast::max((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_680, _876, _655), level(0.0)) * _684) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_687, _876, _655), level(0.0)) * _678), float4(0.0)), float4(_621));
                        }
                        else
                        {
                            _890 = _847;
                        }
                        _1056 = _890;
                    }
                    _1057 = _1056;
                }
                else
                {
                    _1057 = (float4(1.0) - _778.xyzx) * _693;
                }
                _1058 = _1057;
            }
            else
            {
                _1058 = _693;
            }
            _1059 = _778;
            _1060 = _1058;
        }
        else
        {
            _1059 = float3(1.0);
            _1060 = _693;
        }
        _1075 = _1059;
        _1076 = fast::max((_1060.xyz * (0.0596831031143665313720703125 * _624)) + ((((_1060.xyz * (_1060.w * smoothstep(0.0, 0.0199999995529651641845703125, _586))) / float3(fast::max(_1060.x, 9.9999997473787516355514526367188e-05))) * float3(1.0, 0.429629623889923095703125, 0.17522656917572021484375)) * (((0.042971827089786529541015625 * pow(abs(1.6400001049041748046875 - (1.60000002384185791015625 * _584)), -1.5)) * _624) * 0.37878787517547607421875)), float3(0.0));
    }
    else
    {
        _1075 = float3(1.0);
        _1076 = float3(0.0);
    }
    float3 _1141;
    if ((View.View_AtmosphericFogRenderMask & 2u) == 0u)
    {
        float3 _1140;
        if (_544 > 0.0)
        {
            float3 _1087 = _510 + (_512 * _544);
            float _1088 = length(_1087);
            float3 _1090 = _1087 / float3(_1088);
            float _1091 = dot(_1090, View.View_AtmosphereLightDirection[0].xyz);
            float _1093 = (_1088 - 6360.0) * 0.014285714365541934967041015625;
            float3 _1106 = select(View_AtmosphereTransmittanceTexture.sample(View_AtmosphereTransmittanceTextureSampler, float2(atan((_1091 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt(_1093)), level(0.0)).xyz, float3(0.0), bool3(_533));
            float3 _1118 = ((_1106 * fast::max(_1091, 0.0)) + View_AtmosphereIrradianceTexture.sample(View_AtmosphereIrradianceTextureSampler, float2((_1091 + 0.20000000298023223876953125) * 0.833333313465118408203125, _1093), level(0.0)).xyz) * float3(0.0031830989755690097808837890625);
            float3 _1138;
            if ((!_533) && true)
            {
                float3 _1124 = normalize(View.View_AtmosphereLightDirection[0].xyz - _512);
                _1138 = _1118 + (_1106 * fast::max((0.0199999995529651641845703125 + (0.980000019073486328125 * pow(1.0 - dot(-_512, _1124), 5.0))) * pow(fast::max(dot(_1124, _1090), 0.0), 150.0), 0.0));
            }
            else
            {
                _1138 = _1118;
            }
            _1140 = _1075 * _1138;
        }
        else
        {
            _1140 = float3(0.0);
        }
        _1141 = _1140;
    }
    else
    {
        _1141 = float3(0.0);
    }
    float3 _1178;
    if ((View.View_AtmosphericFogRenderMask & 1u) == 0u)
    {
        float3 _1177;
        switch (0u)
        {
            default:
            {
                if (_544 > 0.0)
                {
                    _1177 = float3(0.0);
                    break;
                }
                else
                {
                    _1177 = (select(float3(1.0), View_AtmosphereTransmittanceTexture.sample(View_AtmosphereTransmittanceTextureSampler, float2(atan((_514 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt((_511 - 6360.0) * 0.014285714365541934967041015625)), level(0.0)).xyz, bool3(_511 <= 6430.0)) * step(View.View_AtmosphereLightDiscCosHalfApexAngle[0].x, dot(_512, View.View_AtmosphereLightDirection[0].xyz))) * View.View_AtmosphereLightDiscLuminance[0].xyz;
                    break;
                }
            }
        }
        _1178 = _1177;
    }
    else
    {
        _1178 = float3(0.0);
    }
    float _1198 = mix(fast::clamp((_1075.x * View.View_AtmosphericFogDensityScale) - View.View_AtmosphericFogDensityOffset, 0.0, 1.0), 1.0, 1.0 - _532);
    float4 _1202 = float4((View.View_AtmosphereLightColor[0].xyz * (View.View_AtmosphericFogSunPower * _543)) * ((_1178 + _1141) + _1076), _1198);
    float4 _1279;
    if (View.View_SkyAtmosphereApplyCameraAerialPerspectiveVolume > 0.0)
    {
        float3 _1216 = (_493 * 9.9999997473787516355514526367188e-06) - (View.View_TranslatedWorldCameraOrigin * 9.9999997473787516355514526367188e-06);
        float _1222 = sqrt((fast::max(0.0, length(_1216) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
        float _1223 = _1222 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
        float _1230;
        if (_1223 < 0.707106769084930419921875)
        {
            _1230 = fast::clamp((_1223 * _1223) * 2.0, 0.0, 1.0);
        }
        else
        {
            _1230 = 1.0;
        }
        float2 _1258;
        if (View.View_RealTimeReflectionCapture != 0.0)
        {
            float3 _1233 = normalize(_1216);
            float _1234 = _1233.z;
            float _1237 = sqrt(1.0 - (_1234 * _1234));
            float2 _1240 = _179;
            _1240.y = (_1234 * 0.5) + 0.5;
            float _1245 = acos(_1233.x / _1237);
            float2 _1250 = _1240;
            _1250.x = (((_1233.y / _1237) < 0.0) ? (6.283185482025146484375 - _1245) : _1245) * 0.15915493667125701904296875;
            _1258 = (_1250 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
        }
        else
        {
            _1258 = ((_458.xy / _458.ww) * float2(0.5, -0.5)) + float2(0.5);
        }
        float4 _1263 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_1258, _1222), level(0.0));
        float3 _1275 = _1202.xyz + (((_1263.xyz * _1230).xyz * View.View_OneOverPreExposure).xyz * _1198);
        float4 _1278 = float4(_1275.x, _1275.y, _1275.z, _176.w);
        _1278.w = _1198 * (1.0 - (_1230 * (1.0 - _1263.w)));
        _1279 = _1278;
    }
    else
    {
        _1279 = _1202;
    }
    out.out_var_TEXCOORD10_centroid = float4(_482.x, _482.y, _482.z, _461.w);
    out.out_var_TEXCOORD11_centroid = float4(_481[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _492;
    out.out_var_TEXCOORD7 = _1279;
    out.gl_Position = _458;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

