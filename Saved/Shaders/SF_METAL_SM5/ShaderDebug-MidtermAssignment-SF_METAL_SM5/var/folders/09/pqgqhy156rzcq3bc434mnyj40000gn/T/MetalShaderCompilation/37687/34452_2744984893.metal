

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
    char _m5_pad[48];
    float3 View_TranslatedWorldCameraOrigin;
    char _m6_pad[16];
    float3 View_PreViewTranslation;
    char _m7_pad[1032];
    float View_OneOverPreExposure;
    char _m8_pad[352];
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
    char _m20_pad[32];
    spvUnsafeArray<float4, 2> View_AtmosphereLightDiscLuminance;
    spvUnsafeArray<float4, 2> View_AtmosphereLightDiscCosHalfApexAngle;
    char _m22_pad[144];
    float4 View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize;
    float View_SkyAtmosphereAerialPerspectiveStartDepthKm;
    float View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
    float View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv;
    char _m26_pad[4];
    float View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv;
    float View_SkyAtmosphereApplyCameraAerialPerspectiveVolume;
    uint View_AtmosphericFogRenderMask;
    uint View_AtmosphericFogInscatterAltitudeSampleNum;
    char _m30_pad[16];
    float View_RealTimeReflectionCapture;
};

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
};

struct type_EmitterDynamicUniforms
{
    float2 EmitterDynamicUniforms_LocalToWorldScale;
    float4 EmitterDynamicUniforms_AxisLockRight;
    float4 EmitterDynamicUniforms_AxisLockUp;
};

struct type_EmitterUniforms
{
    char _m0_pad[48];
    float4 EmitterUniforms_MiscCurve;
    float4 EmitterUniforms_MiscScale;
    float4 EmitterUniforms_MiscBias;
    float4 EmitterUniforms_SizeBySpeed;
    float4 EmitterUniforms_SubImageSize;
    float4 EmitterUniforms_TangentSelector;
    packed_float3 EmitterUniforms_CameraFacingBlend;
    float EmitterUniforms_RemoveHMDRoll;
    float EmitterUniforms_RotationRateScale;
    float EmitterUniforms_RotationBias;
    char _m10_pad[8];
    float2 EmitterUniforms_PivotOffset;
};

struct type_Globals
{
    uint ParticleIndicesOffset;
};

constant float3x3 _180 = {};
constant float4 _181 = {};
constant float2 _183 = {};

struct Main_out
{
    float4 out_var_TEXCOORD0_0 [[user(locn0)]];
    float4 out_var_TANGENTX [[user(locn1)]];
    float4 out_var_TANGENTZ [[user(locn2)]];
    float4 out_var_TEXCOORD7 [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float2 in_var_ATTRIBUTE0 [[attribute(0)]];
};

// Implementation of the GLSL mod() function, which is slightly different than Metal fmod()
template<typename Tx, typename Ty>
inline Tx mod(Tx x, Ty y)
{
    return x - y * floor(x / y);
}

vertex Main_out Main_00008694_a39d253d(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_EmitterDynamicUniforms& EmitterDynamicUniforms [[buffer(3)]], constant type_EmitterUniforms& EmitterUniforms [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> ParticleIndices [[texture(0)]], texture2d<float> View_AtmosphereTransmittanceTexture [[texture(1)]], texture2d<float> View_AtmosphereIrradianceTexture [[texture(2)]], texture3d<float> View_AtmosphereInscatterTexture [[texture(3)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(4)]], texture2d<float> PositionTexture [[texture(5)]], texture2d<float> VelocityTexture [[texture(6)]], texture2d<float> AttributesTexture [[texture(7)]], texture2d<float> CurveTexture [[texture(8)]], sampler View_AtmosphereTransmittanceTextureSampler [[sampler(0)]], sampler View_AtmosphereIrradianceTextureSampler [[sampler(1)]], sampler View_AtmosphereInscatterTextureSampler [[sampler(2)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(3)]], sampler PositionTextureSampler [[sampler(4)]], sampler VelocityTextureSampler [[sampler(5)]], sampler AttributesTextureSampler [[sampler(6)]], sampler CurveTextureSampler [[sampler(7)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    uint _241 = (gl_InstanceIndex - gl_BaseInstance) * 16u;
    uint _242 = (gl_VertexIndex - gl_BaseVertex) / 4u;
    uint _243 = _241 + _242;
    uint _246 = _Globals.ParticleIndicesOffset + _243;
    float4 _248 = ParticleIndices.read(uint(_246));
    float2 _249 = _248.xy;
    float4 _253 = PositionTexture.sample(PositionTextureSampler, _249, level(0.0));
    float4 _257 = VelocityTexture.sample(VelocityTextureSampler, _249, level(0.0));
    float4 _261 = AttributesTexture.sample(AttributesTextureSampler, _249, level(0.0));
    float _262 = _253.w;
    float _263 = step(_262, 1.0);
    float3 _264 = _257.xyz;
    float3x3 _273 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    float3 _274 = _273 * _264;
    float3 _276 = normalize(_274 + float3(0.0, 0.0, 9.9999997473787516355514526367188e-05));
    float _277 = length(_274);
    float2 _282 = EmitterUniforms.EmitterUniforms_MiscCurve.zw * _262;
    float2 _283 = EmitterUniforms.EmitterUniforms_MiscCurve.xy + _282;
    float4 _287 = CurveTexture.sample(CurveTextureSampler, _283, level(0.0));
    float4 _290 = _287 * EmitterUniforms.EmitterUniforms_MiscScale;
    float4 _293 = _290 + EmitterUniforms.EmitterUniforms_MiscBias;
    float _294 = _261.x;
    bool _295 = _294 < 0.5;
    float _296 = _295 ? 0.0 : (-0.5);
    float _297 = _261.y;
    bool _298 = _297 < 0.5;
    float _299 = _298 ? 0.0 : (-0.5);
    float2 _300 = float2(_296, _299);
    float2 _301 = _261.xy;
    float2 _302 = _301 + _300;
    float2 _303 = _302 * float2(2.0);
    float2 _304 = _293.xy;
    float2 _307 = _304 * EmitterDynamicUniforms.EmitterDynamicUniforms_LocalToWorldScale;
    float2 _311 = EmitterUniforms.EmitterUniforms_SizeBySpeed.xy * _277;
    float2 _312 = fast::max(_311, float2(1.0));
    float2 _314 = fast::min(_312, EmitterUniforms.EmitterUniforms_SizeBySpeed.zw);
    float2 _315 = _303 * _307;
    float2 _316 = _315 * _314;
    float2 _317 = float2(_263);
    float2 _318 = _316 * _317;
    float2 _323 = _183;
    _323.x = (_296 == 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.x) : in.in_var_ATTRIBUTE0.x;
    float2 _328 = _323;
    _328.y = (_299 == 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.y) : in.in_var_ATTRIBUTE0.y;
    float _329 = _293.z;
    float _331 = _329 - fract(_329);
    float2 _344 = (float2(mod(_331, EmitterUniforms.EmitterUniforms_SubImageSize.x), floor(_331 * EmitterUniforms.EmitterUniforms_SubImageSize.z)) + _328) * EmitterUniforms.EmitterUniforms_SubImageSize.zw;
    float _345 = _261.w;
    float _348 = _345 * EmitterUniforms.EmitterUniforms_RotationRateScale;
    float _349 = _261.z;
    float _350 = _348 * _262;
    float _351 = _349 + _350;
    float _352 = _351 * 6.283185482025146484375;
    float3 _356 = _253.xxx;
    float3 _357 = Primitive.Primitive_LocalToWorld[0u].xyz * _356;
    float3 _361 = _253.yyy;
    float3 _362 = Primitive.Primitive_LocalToWorld[1u].xyz * _361;
    float3 _363 = _357 + _362;
    float3 _367 = _253.zzz;
    float3 _368 = Primitive.Primitive_LocalToWorld[2u].xyz * _367;
    float3 _369 = _363 + _368;
    float3 _373 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _374 = _369 + _373;
    float _375 = _374.x;
    float _376 = _374.y;
    float _377 = _374.z;
    float4 _378 = float4(_375, _376, _377, 1.0);
    float3 _379 = _378.xyz;
    float3 _382 = float3(EmitterUniforms.EmitterUniforms_RemoveHMDRoll);
    float3 _391 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _382), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.w));
    float3 _399 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _382), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.w));
    float3 _400 = View.View_TranslatedWorldCameraOrigin - _379;
    float _401 = dot(_400, _400);
    float3 _405 = _400 / float3(sqrt(fast::max(_401, 0.00999999977648258209228515625)));
    float3 _475;
    float3 _476;
    if (EmitterUniforms.EmitterUniforms_CameraFacingBlend[0] > 0.0)
    {
        float3 _463 = cross(_405, float3(0.0, 0.0, 1.0));
        float3 _468 = _463 / float3(sqrt(fast::max(dot(_463, _463), 0.00999999977648258209228515625)));
        float3 _470 = float3(fast::clamp((_401 * EmitterUniforms.EmitterUniforms_CameraFacingBlend[1]) - EmitterUniforms.EmitterUniforms_CameraFacingBlend[2], 0.0, 1.0));
        _475 = normalize(mix(_391, _468, _470));
        _476 = normalize(mix(_399, cross(_405, _468), _470));
    }
    else
    {
        float3 _454;
        float3 _455;
        if (EmitterUniforms.EmitterUniforms_TangentSelector.y > 0.0)
        {
            float3 _447 = cross(_405, _276);
            _454 = _447 / float3(sqrt(fast::max(dot(_447, _447), 0.00999999977648258209228515625)));
            _455 = -_276;
        }
        else
        {
            float3 _445;
            float3 _446;
            if (EmitterUniforms.EmitterUniforms_TangentSelector.z > 0.0)
            {
                float3 _438 = cross(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, _405);
                _445 = EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz;
                _446 = -(_438 / float3(sqrt(fast::max(dot(_438, _438), 0.00999999977648258209228515625))));
            }
            else
            {
                float3 _436;
                float3 _437;
                if (EmitterUniforms.EmitterUniforms_TangentSelector.w > 0.0)
                {
                    float3 _429 = cross(_405, float3(0.0, 0.0, 1.0));
                    float3 _434 = _429 / float3(sqrt(fast::max(dot(_429, _429), 0.00999999977648258209228515625)));
                    _436 = _434;
                    _437 = cross(_405, _434);
                }
                else
                {
                    _436 = _391;
                    _437 = _399;
                }
                _445 = _436;
                _446 = _437;
            }
            _454 = _445;
            _455 = _446;
        }
        _475 = _454;
        _476 = _455;
    }
    float _479 = _352 + EmitterUniforms.EmitterUniforms_RotationBias;
    float _480 = sin(_479);
    float _481 = cos(_479);
    float3 _482 = _476 * _480;
    float3 _483 = _475 * _481;
    float3 _484 = _482 + _483;
    float3 _485 = _476 * _481;
    float3 _486 = _475 * _480;
    float3 _487 = _485 - _486;
    float _488 = _318.x;
    float _491 = in.in_var_ATTRIBUTE0.x + EmitterUniforms.EmitterUniforms_PivotOffset.x;
    float _492 = _488 * _491;
    float3 _493 = _484 * _492;
    float _494 = _318.y;
    float _497 = in.in_var_ATTRIBUTE0.y + EmitterUniforms.EmitterUniforms_PivotOffset.y;
    float _498 = _494 * _497;
    float3 _499 = _487 * _498;
    float3 _500 = _493 + _499;
    float3 _501 = _379 + _500;
    float _502 = _501.x;
    float _503 = _501.y;
    float _504 = _501.z;
    float4 _505 = float4(_502, _503, _504, 1.0);
    float4 _506 = float4(_505.x, _505.y, _505.z, _505.w);
    float4 _507 = View.View_TranslatedWorldToClip * _506;
    float3x3 _509 = _180;
    _509[0] = _484;
    float3x3 _510 = _509;
    _510[1] = _487;
    float3 _512 = normalize(cross(_484, _487));
    float3x3 _513 = _510;
    _513[2] = _512;
    spvUnsafeArray<float4, 1> _526 = { float4(_344.x, _344.y, float4(0.0).z, float4(0.0).w) };
    float3 _527 = _505.xyz;
    float3 _528 = _527 - View.View_TranslatedWorldCameraOrigin;
    float _532 = 9.9999997473787516355514526367188e-06 * View.View_AtmosphericFogDistanceScale;
    float3 _540 = View.View_TranslatedWorldCameraOrigin;
    _540.z = (View.View_TranslatedWorldCameraOrigin.z - View.View_AtmosphericFogGroundOffset) * View.View_AtmosphericFogAltitudeScale;
    float3 _541 = _540 * _532;
    float3 _544 = _541;
    _544.z = _541.z + 6360.009765625;
    float _545 = length(_544);
    float3 _546 = normalize(_528);
    float _547 = dot(_544, _546);
    float _548 = _547 / _545;
    float _550 = (-_545) * _548;
    float _554 = (_545 * _545) * ((_548 * _548) - 1.0);
    float _559 = length(_528) * _532;
    float _563 = fast::max(0.0, _559 - View.View_AtmosphericFogStartDistance);
    float _566 = fast::min((_563 * 0.100000001490116119384765625) / View.View_AtmosphericFogStartDistance, 1.0);
    bool _567 = _559 < (100.0 * View.View_AtmosphericFogDistanceScale);
    float _577;
    float _578;
    if (_567)
    {
        _577 = _566 * View.View_AtmosphericFogPower;
        _578 = fast::max(_559 + View.View_AtmosphericFogDistanceOffset, 1.0);
    }
    else
    {
        _577 = 1.0;
        _578 = _550 - sqrt(_554 + 40449600.0);
    }
    float _584 = _550 - sqrt(_554 + 41344900.0);
    bool _585 = _584 > 0.0;
    float _593;
    float _594;
    float3 _595;
    if (_585)
    {
        _593 = (_547 + _584) * 0.00015552098921034485101699829101562;
        _594 = _578 - _584;
        _595 = _544 + (_546 * _584);
    }
    else
    {
        _593 = _548;
        _594 = _578;
        _595 = _544;
    }
    float _596 = _585 ? 6430.0 : _545;
    bool _597 = _596 < 6360.0146484375;
    float _606;
    float _607;
    float3 _608;
    if (_597)
    {
        float _600 = 6360.0146484375 - _596;
        float3 _602 = _595 - (_546 * _600);
        _606 = dot(_602, _546) * 0.0001572323380969464778900146484375;
        _607 = _594 - _600;
        _608 = _602;
    }
    else
    {
        _606 = _593;
        _607 = _594;
        _608 = _595;
    }
    float _609 = _597 ? 6360.0146484375 : _596;
    float3 _1109;
    float3 _1110;
    if ((_609 <= 6430.0) && (_563 > 0.0))
    {
        float3 _616 = _608 + (_546 * _607);
        float _617 = length(_616);
        float _618 = dot(_546, View.View_AtmosphereLightDirection[0].xyz);
        float _620 = dot(_608, View.View_AtmosphereLightDirection[0].xyz) / _609;
        float _621 = 6360.0 / _609;
        float _624 = sqrt(1.0 - (_621 * _621));
        float _633;
        if (_567)
        {
            _633 = fast::max(_606, 0.1550000011920928955078125 - _624);
        }
        else
        {
            _633 = fast::max(_606, 0.004999999888241291046142578125 - _624);
        }
        float3 _654;
        float _655;
        float _656;
        if (_567)
        {
            float _636 = _546.z;
            float _640 = fast::clamp(exp(-_636) - 0.5, 0.0, 1.0);
            float3 _652;
            float _653;
            if (_640 < 1.0)
            {
                float3 _645 = _546;
                _645.z = fast::max(_636, 0.1500000059604644775390625);
                float3 _646 = normalize(_645);
                float3 _648 = _608 + (_646 * _607);
                _652 = _646;
                _653 = dot(_648, _646) / length(_648);
            }
            else
            {
                _652 = _546;
                _653 = _633;
            }
            _654 = _652;
            _655 = _640;
            _656 = _653;
        }
        else
        {
            _654 = _546;
            _655 = 0.0;
            _656 = _633;
        }
        float _658 = 1.0 + (_618 * _618);
        float _669 = _609 * _609;
        float _671 = sqrt(_669 - 40449600.0);
        float _672 = _609 * _656;
        float _675 = ((_672 * _672) - _669) + 40449600.0;
        float4 _680 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_672 < 0.0) && (_675 > 0.0)));
        float _683 = float(View.View_AtmosphericFogInscatterAltitudeSampleNum);
        float _684 = 0.5 / _683;
        float _687 = 1.0 - (1.0 / _683);
        float _689 = _684 + ((_671 * 0.00105685577727854251861572265625) * _687);
        float _701 = _680.w + ((((_672 * _680.x) + sqrt(_675 + _680.y)) / (_671 + _680.z)) * 0.4921875);
        float _710 = (_618 + 1.0) * 3.5;
        float _711 = floor(_710);
        float _712 = _710 - _711;
        float _713 = _711 + (0.015625 + (((atan(fast::max(_620, -0.19750000536441802978515625) * 5.349621295928955078125) * 0.90909087657928466796875) + 0.7400000095367431640625) * 0.484375));
        float _714 = _713 * 0.125;
        float _718 = 1.0 - _712;
        float _721 = (_713 + 1.0) * 0.125;
        float4 _727 = fast::max((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_714, _701, _689), level(0.0)) * _718) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_721, _701, _689), level(0.0)) * _712), float4(0.0));
        float3 _1093;
        float4 _1094;
        if (_607 > 0.0)
        {
            float2 _738 = float2(_656, _656 + (_607 / _609));
            float2 _739 = _738 * sqrt((0.5 / View.View_AtmosphericFogHeightScaleRayleigh) * _609);
            float2 _742 = float2(int2(sign(_739)));
            float2 _743 = _739 * _739;
            float _759 = 2.0 * _609;
            float _761 = (_607 / _759) + _656;
            float _769 = 6360.0 - _609;
            float2 _779 = _738 * sqrt(0.4166666567325592041015625 * _609);
            float2 _782 = float2(int2(sign(_779)));
            float2 _783 = _779 * _779;
            float3 _812 = exp((float3(-0.0057999999262392520904541015625, -0.013500000350177288055419921875, -0.033100001513957977294921875) * ((sqrt((6.283100128173828125 * View.View_AtmosphericFogHeightScaleRayleigh) * _609) * exp(_769 / View.View_AtmosphericFogHeightScaleRayleigh)) * (((_742.y > _742.x) ? exp(_743.x) : 0.0) + dot((_742 / ((abs(_739) * 2.3192999362945556640625) + sqrt((_743 * 1.519999980926513671875) + float2(4.0)))) * float2(1.0, exp(((-_607) / View.View_AtmosphericFogHeightScaleRayleigh) * _761)), float2(1.0, -1.0))))) - (float3(0.00444444455206394195556640625) * ((sqrt(7.5397205352783203125 * _609) * exp(_769 * 0.833333313465118408203125)) * (((_782.y > _782.x) ? exp(_783.x) : 0.0) + dot((_782 / ((abs(_779) * 2.3192999362945556640625) + sqrt((_783 * 1.519999980926513671875) + float2(4.0)))) * float2(1.0, exp((_607 * (-0.833333313465118408203125)) * _761)), float2(1.0, -1.0))))));
            float _820;
            if (_567)
            {
                _820 = fast::max(_617, _609);
            }
            else
            {
                _820 = _617;
            }
            float4 _1092;
            if (_820 > 6360.009765625)
            {
                float4 _1091;
                if (_655 < 1.0)
                {
                    float4 _831 = _812.xyzx;
                    float _832 = _820 * _820;
                    float _834 = sqrt(_832 - 40449600.0);
                    float _835 = _820 * (dot(_616, _654) / _617);
                    float _838 = ((_835 * _835) - _832) + 40449600.0;
                    float4 _843 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_835 < 0.0) && (_838 > 0.0)));
                    float _846 = _684 + ((_834 * 0.00105685577727854251861572265625) * _687);
                    float _858 = _843.w + ((((_835 * _843.x) + sqrt(_838 + _843.y)) / (_834 + _843.z)) * 0.4921875);
                    float _866 = _711 + (0.015625 + (((atan(fast::max(dot(_616, View.View_AtmosphereLightDirection[0].xyz) / _617, -0.19750000536441802978515625) * 5.349621295928955078125) * 0.90909087657928466796875) + 0.7400000095367431640625) * 0.484375));
                    float _867 = _866 * 0.125;
                    float _873 = (_866 + 1.0) * 0.125;
                    float4 _881 = fast::max(_727 - (_831 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_867, _858, _846), level(0.0)) * _718) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_873, _858, _846), level(0.0)) * _712))), float4(0.0));
                    float4 _1090;
                    if (!_567)
                    {
                        float _925 = _656 - (-_624);
                        float4 _1089;
                        if (abs(_925) < 0.004999999888241291046142578125)
                        {
                            float _932 = (-0.004999999888241291046142578125) - _624;
                            float _934 = _669 + (_607 * _607);
                            float _935 = _759 * _607;
                            float _938 = sqrt(_934 + (_935 * _932));
                            float _939 = _609 * _932;
                            float _942 = 0.004999999888241291046142578125 - _624;
                            float _946 = ((_939 * _939) - _669) + 40449600.0;
                            float4 _951 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_939 < 0.0) && (_946 > 0.0)));
                            float _963 = _951.w + ((((_939 * _951.x) + sqrt(_946 + _951.y)) / (_671 + _951.z)) * 0.4921875);
                            float _973 = _938 * _938;
                            float _975 = sqrt(_973 - 40449600.0);
                            float _976 = _938 * fast::max(_942, (_939 + _607) / _938);
                            float _979 = ((_976 * _976) - _973) + 40449600.0;
                            float4 _984 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_976 < 0.0) && (_979 > 0.0)));
                            float _987 = _684 + ((_975 * 0.00105685577727854251861572265625) * _687);
                            float _999 = _984.w + ((((_976 * _984.x) + sqrt(_979 + _984.y)) / (_975 + _984.z)) * 0.4921875);
                            float _1014 = sqrt(_934 + (_935 * _942));
                            float _1015 = _609 * _942;
                            float _1021 = ((_1015 * _1015) - _669) + 40449600.0;
                            float4 _1026 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_1015 < 0.0) && (_1021 > 0.0)));
                            float _1038 = _1026.w + ((((_1015 * _1026.x) + sqrt(_1021 + _1026.y)) / (_671 + _1026.z)) * 0.4921875);
                            float _1048 = _1014 * _1014;
                            float _1050 = sqrt(_1048 - 40449600.0);
                            float _1051 = _1014 * fast::max(_942, (_1015 + _607) / _1014);
                            float _1054 = ((_1051 * _1051) - _1048) + 40449600.0;
                            float4 _1059 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_1051 < 0.0) && (_1054 > 0.0)));
                            float _1062 = _684 + ((_1050 * 0.00105685577727854251861572265625) * _687);
                            float _1074 = _1059.w + ((((_1051 * _1059.x) + sqrt(_1054 + _1059.y)) / (_1050 + _1059.z)) * 0.4921875);
                            _1089 = mix(fast::max(((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_714, _963, _689), level(0.0)) * _718) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_721, _963, _689), level(0.0)) * _712)) - (_831 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_867, _999, _987), level(0.0)) * _718) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_873, _999, _987), level(0.0)) * _712))), float4(0.0)), fast::max(((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_714, _1038, _689), level(0.0)) * _718) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_721, _1038, _689), level(0.0)) * _712)) - (_831 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_867, _1074, _1062), level(0.0)) * _718) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_873, _1074, _1062), level(0.0)) * _712))), float4(0.0)), float4((_925 + 0.004999999888241291046142578125) * 100.0));
                        }
                        else
                        {
                            _1089 = _881;
                        }
                        _1090 = _1089;
                    }
                    else
                    {
                        float4 _924;
                        if (_655 > 0.0)
                        {
                            float _890 = _609 * _633;
                            float _893 = ((_890 * _890) - _669) + 40449600.0;
                            float4 _898 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_890 < 0.0) && (_893 > 0.0)));
                            float _910 = _898.w + ((((_890 * _898.x) + sqrt(_893 + _898.y)) / (_671 + _898.z)) * 0.4921875);
                            _924 = mix(_881, (float4(1.0) - _831) * fast::max((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_714, _910, _689), level(0.0)) * _718) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_721, _910, _689), level(0.0)) * _712), float4(0.0)), float4(_655));
                        }
                        else
                        {
                            _924 = _881;
                        }
                        _1090 = _924;
                    }
                    _1091 = _1090;
                }
                else
                {
                    _1091 = (float4(1.0) - _812.xyzx) * _727;
                }
                _1092 = _1091;
            }
            else
            {
                _1092 = _727;
            }
            _1093 = _812;
            _1094 = _1092;
        }
        else
        {
            _1093 = float3(1.0);
            _1094 = _727;
        }
        _1109 = _1093;
        _1110 = fast::max((_1094.xyz * (0.0596831031143665313720703125 * _658)) + ((((_1094.xyz * (_1094.w * smoothstep(0.0, 0.0199999995529651641845703125, _620))) / float3(fast::max(_1094.x, 9.9999997473787516355514526367188e-05))) * float3(1.0, 0.429629623889923095703125, 0.17522656917572021484375)) * (((0.042971827089786529541015625 * pow(abs(1.6400001049041748046875 - (1.60000002384185791015625 * _618)), -1.5)) * _658) * 0.37878787517547607421875)), float3(0.0));
    }
    else
    {
        _1109 = float3(1.0);
        _1110 = float3(0.0);
    }
    float3 _1175;
    if ((View.View_AtmosphericFogRenderMask & 2u) == 0u)
    {
        float3 _1174;
        if (_578 > 0.0)
        {
            float3 _1121 = _544 + (_546 * _578);
            float _1122 = length(_1121);
            float3 _1124 = _1121 / float3(_1122);
            float _1125 = dot(_1124, View.View_AtmosphereLightDirection[0].xyz);
            float _1127 = (_1122 - 6360.0) * 0.014285714365541934967041015625;
            float3 _1140 = select(View_AtmosphereTransmittanceTexture.sample(View_AtmosphereTransmittanceTextureSampler, float2(atan((_1125 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt(_1127)), level(0.0)).xyz, float3(0.0), bool3(_567));
            float3 _1152 = ((_1140 * fast::max(_1125, 0.0)) + View_AtmosphereIrradianceTexture.sample(View_AtmosphereIrradianceTextureSampler, float2((_1125 + 0.20000000298023223876953125) * 0.833333313465118408203125, _1127), level(0.0)).xyz) * float3(0.0031830989755690097808837890625);
            float3 _1172;
            if ((!_567) && true)
            {
                float3 _1158 = normalize(View.View_AtmosphereLightDirection[0].xyz - _546);
                _1172 = _1152 + (_1140 * fast::max((0.0199999995529651641845703125 + (0.980000019073486328125 * pow(1.0 - dot(-_546, _1158), 5.0))) * pow(fast::max(dot(_1158, _1124), 0.0), 150.0), 0.0));
            }
            else
            {
                _1172 = _1152;
            }
            _1174 = _1109 * _1172;
        }
        else
        {
            _1174 = float3(0.0);
        }
        _1175 = _1174;
    }
    else
    {
        _1175 = float3(0.0);
    }
    float3 _1212;
    if ((View.View_AtmosphericFogRenderMask & 1u) == 0u)
    {
        float3 _1211;
        switch (0u)
        {
            default:
            {
                if (_578 > 0.0)
                {
                    _1211 = float3(0.0);
                    break;
                }
                else
                {
                    _1211 = (select(float3(1.0), View_AtmosphereTransmittanceTexture.sample(View_AtmosphereTransmittanceTextureSampler, float2(atan((_548 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt((_545 - 6360.0) * 0.014285714365541934967041015625)), level(0.0)).xyz, bool3(_545 <= 6430.0)) * step(View.View_AtmosphereLightDiscCosHalfApexAngle[0].x, dot(_546, View.View_AtmosphereLightDirection[0].xyz))) * View.View_AtmosphereLightDiscLuminance[0].xyz;
                    break;
                }
            }
        }
        _1212 = _1211;
    }
    else
    {
        _1212 = float3(0.0);
    }
    float _1232 = mix(fast::clamp((_1109.x * View.View_AtmosphericFogDensityScale) - View.View_AtmosphericFogDensityOffset, 0.0, 1.0), 1.0, 1.0 - _566);
    float4 _1236 = float4((View.View_AtmosphereLightColor[0].xyz * (View.View_AtmosphericFogSunPower * _577)) * ((_1212 + _1175) + _1110), _1232);
    float4 _1313;
    if (View.View_SkyAtmosphereApplyCameraAerialPerspectiveVolume > 0.0)
    {
        float3 _1250 = (_527 * 9.9999997473787516355514526367188e-06) - (View.View_TranslatedWorldCameraOrigin * 9.9999997473787516355514526367188e-06);
        float _1256 = sqrt((fast::max(0.0, length(_1250) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
        float _1257 = _1256 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
        float _1264;
        if (_1257 < 0.707106769084930419921875)
        {
            _1264 = fast::clamp((_1257 * _1257) * 2.0, 0.0, 1.0);
        }
        else
        {
            _1264 = 1.0;
        }
        float2 _1292;
        if (View.View_RealTimeReflectionCapture != 0.0)
        {
            float3 _1267 = normalize(_1250);
            float _1268 = _1267.z;
            float _1271 = sqrt(1.0 - (_1268 * _1268));
            float2 _1274 = _183;
            _1274.y = (_1268 * 0.5) + 0.5;
            float _1279 = acos(_1267.x / _1271);
            float2 _1284 = _1274;
            _1284.x = (((_1267.y / _1271) < 0.0) ? (6.283185482025146484375 - _1279) : _1279) * 0.15915493667125701904296875;
            _1292 = (_1284 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
        }
        else
        {
            _1292 = ((_507.xy / _507.ww) * float2(0.5, -0.5)) + float2(0.5);
        }
        float4 _1297 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_1292, _1256), level(0.0));
        float3 _1309 = _1236.xyz + (((_1297.xyz * _1264).xyz * View.View_OneOverPreExposure).xyz * _1232);
        float4 _1312 = float4(_1309.x, _1309.y, _1309.z, _181.w);
        _1312.w = _1232 * (1.0 - (_1264 * (1.0 - _1297.w)));
        _1313 = _1312;
    }
    else
    {
        _1313 = _1236;
    }
    out_var_TEXCOORD0 = _526;
    out.out_var_TANGENTX = float4(_484, 0.0);
    out.out_var_TANGENTZ = float4(_512, float(int(sign(determinant(_513)))));
    out.out_var_TEXCOORD7 = _1313;
    out.gl_Position = _507;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

