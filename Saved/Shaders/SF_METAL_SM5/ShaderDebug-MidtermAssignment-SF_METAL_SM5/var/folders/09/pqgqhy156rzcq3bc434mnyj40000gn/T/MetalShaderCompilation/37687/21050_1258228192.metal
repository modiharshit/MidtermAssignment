

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

struct type_TranslucentBasePass
{
    char _m0_pad[1712];
    float4 TranslucentBasePass_Shared_Fog_ExponentialFogParameters;
    float4 TranslucentBasePass_Shared_Fog_ExponentialFogParameters2;
    float4 TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter;
    float4 TranslucentBasePass_Shared_Fog_ExponentialFogParameters3;
    float4 TranslucentBasePass_Shared_Fog_InscatteringLightDirection;
    float4 TranslucentBasePass_Shared_Fog_DirectionalInscatteringColor;
    float2 TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation;
    float3 TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters;
};

struct type_View
{
    float4x4 View_TranslatedWorldToClip;
    char _m1_pad[896];
    float3 View_ViewForward;
    float3 View_ViewUp;
    float3 View_ViewRight;
    float3 View_HMDViewNoRollUp;
    float3 View_HMDViewNoRollRight;
    char _m6_pad[32];
    float3 View_WorldCameraOrigin;
    float3 View_TranslatedWorldCameraOrigin;
    char _m8_pad[16];
    float3 View_PreViewTranslation;
    char _m9_pad[1032];
    float View_OneOverPreExposure;
    char _m10_pad[704];
    float4 View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize;
    float View_SkyAtmosphereAerialPerspectiveStartDepthKm;
    float View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
    float View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv;
    char _m14_pad[4];
    float View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv;
    float View_SkyAtmosphereApplyCameraAerialPerspectiveVolume;
    char _m16_pad[24];
    float View_RealTimeReflectionCapture;
    char _m17_pad[420];
    float View_VolumetricFogMaxDistance;
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

constant float3x3 _112 = {};
constant float4 _113 = {};
constant float2 _114 = {};

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

vertex Main_out Main_0000523a_4aff09e0(Main_in in [[stage_in]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_EmitterDynamicUniforms& EmitterDynamicUniforms [[buffer(4)]], constant type_EmitterUniforms& EmitterUniforms [[buffer(5)]], constant type_Globals& _Globals [[buffer(6)]], texture_buffer<float> ParticleIndices [[texture(0)]], texturecube<float> TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap [[texture(1)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(2)]], texture2d<float> PositionTexture [[texture(3)]], texture2d<float> VelocityTexture [[texture(4)]], texture2d<float> AttributesTexture [[texture(5)]], texture2d<float> CurveTexture [[texture(6)]], sampler TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler [[sampler(0)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(1)]], sampler PositionTextureSampler [[sampler(2)]], sampler VelocityTextureSampler [[sampler(3)]], sampler AttributesTextureSampler [[sampler(4)]], sampler CurveTextureSampler [[sampler(5)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    uint _160 = (gl_InstanceIndex - gl_BaseInstance) * 16u;
    uint _161 = (gl_VertexIndex - gl_BaseVertex) / 4u;
    uint _162 = _160 + _161;
    uint _165 = _Globals.ParticleIndicesOffset + _162;
    float4 _167 = ParticleIndices.read(uint(_165));
    float2 _168 = _167.xy;
    float4 _172 = PositionTexture.sample(PositionTextureSampler, _168, level(0.0));
    float4 _176 = VelocityTexture.sample(VelocityTextureSampler, _168, level(0.0));
    float4 _180 = AttributesTexture.sample(AttributesTextureSampler, _168, level(0.0));
    float _181 = _172.w;
    float _182 = step(_181, 1.0);
    float3 _183 = _176.xyz;
    float3x3 _192 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    float3 _193 = _192 * _183;
    float3 _195 = normalize(_193 + float3(0.0, 0.0, 9.9999997473787516355514526367188e-05));
    float _196 = length(_193);
    float2 _201 = EmitterUniforms.EmitterUniforms_MiscCurve.zw * _181;
    float2 _202 = EmitterUniforms.EmitterUniforms_MiscCurve.xy + _201;
    float4 _206 = CurveTexture.sample(CurveTextureSampler, _202, level(0.0));
    float4 _209 = _206 * EmitterUniforms.EmitterUniforms_MiscScale;
    float4 _212 = _209 + EmitterUniforms.EmitterUniforms_MiscBias;
    float _213 = _180.x;
    bool _214 = _213 < 0.5;
    float _215 = _214 ? 0.0 : (-0.5);
    float _216 = _180.y;
    bool _217 = _216 < 0.5;
    float _218 = _217 ? 0.0 : (-0.5);
    float2 _219 = float2(_215, _218);
    float2 _220 = _180.xy;
    float2 _221 = _220 + _219;
    float2 _222 = _221 * float2(2.0);
    float2 _223 = _212.xy;
    float2 _226 = _223 * EmitterDynamicUniforms.EmitterDynamicUniforms_LocalToWorldScale;
    float2 _230 = EmitterUniforms.EmitterUniforms_SizeBySpeed.xy * _196;
    float2 _231 = fast::max(_230, float2(1.0));
    float2 _233 = fast::min(_231, EmitterUniforms.EmitterUniforms_SizeBySpeed.zw);
    float2 _234 = _222 * _226;
    float2 _235 = _234 * _233;
    float2 _236 = float2(_182);
    float2 _237 = _235 * _236;
    float2 _242 = _114;
    _242.x = (_215 == 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.x) : in.in_var_ATTRIBUTE0.x;
    float2 _247 = _242;
    _247.y = (_218 == 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.y) : in.in_var_ATTRIBUTE0.y;
    float _248 = _212.z;
    float _250 = _248 - fract(_248);
    float2 _263 = (float2(mod(_250, EmitterUniforms.EmitterUniforms_SubImageSize.x), floor(_250 * EmitterUniforms.EmitterUniforms_SubImageSize.z)) + _247) * EmitterUniforms.EmitterUniforms_SubImageSize.zw;
    float _264 = _180.w;
    float _267 = _264 * EmitterUniforms.EmitterUniforms_RotationRateScale;
    float _268 = _180.z;
    float _269 = _267 * _181;
    float _270 = _268 + _269;
    float _271 = _270 * 6.283185482025146484375;
    float3 _275 = _172.xxx;
    float3 _276 = Primitive.Primitive_LocalToWorld[0u].xyz * _275;
    float3 _280 = _172.yyy;
    float3 _281 = Primitive.Primitive_LocalToWorld[1u].xyz * _280;
    float3 _282 = _276 + _281;
    float3 _286 = _172.zzz;
    float3 _287 = Primitive.Primitive_LocalToWorld[2u].xyz * _286;
    float3 _288 = _282 + _287;
    float3 _292 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _293 = _288 + _292;
    float _294 = _293.x;
    float _295 = _293.y;
    float _296 = _293.z;
    float4 _297 = float4(_294, _295, _296, 1.0);
    float3 _298 = _297.xyz;
    float3 _301 = float3(EmitterUniforms.EmitterUniforms_RemoveHMDRoll);
    float3 _310 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _301), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.w));
    float3 _318 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _301), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.w));
    float3 _319 = View.View_TranslatedWorldCameraOrigin - _298;
    float _320 = dot(_319, _319);
    float3 _324 = _319 / float3(sqrt(fast::max(_320, 0.00999999977648258209228515625)));
    float3 _394;
    float3 _395;
    if (EmitterUniforms.EmitterUniforms_CameraFacingBlend[0] > 0.0)
    {
        float3 _382 = cross(_324, float3(0.0, 0.0, 1.0));
        float3 _387 = _382 / float3(sqrt(fast::max(dot(_382, _382), 0.00999999977648258209228515625)));
        float3 _389 = float3(fast::clamp((_320 * EmitterUniforms.EmitterUniforms_CameraFacingBlend[1]) - EmitterUniforms.EmitterUniforms_CameraFacingBlend[2], 0.0, 1.0));
        _394 = normalize(mix(_310, _387, _389));
        _395 = normalize(mix(_318, cross(_324, _387), _389));
    }
    else
    {
        float3 _373;
        float3 _374;
        if (EmitterUniforms.EmitterUniforms_TangentSelector.y > 0.0)
        {
            float3 _366 = cross(_324, _195);
            _373 = _366 / float3(sqrt(fast::max(dot(_366, _366), 0.00999999977648258209228515625)));
            _374 = -_195;
        }
        else
        {
            float3 _364;
            float3 _365;
            if (EmitterUniforms.EmitterUniforms_TangentSelector.z > 0.0)
            {
                float3 _357 = cross(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, _324);
                _364 = EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz;
                _365 = -(_357 / float3(sqrt(fast::max(dot(_357, _357), 0.00999999977648258209228515625))));
            }
            else
            {
                float3 _355;
                float3 _356;
                if (EmitterUniforms.EmitterUniforms_TangentSelector.w > 0.0)
                {
                    float3 _348 = cross(_324, float3(0.0, 0.0, 1.0));
                    float3 _353 = _348 / float3(sqrt(fast::max(dot(_348, _348), 0.00999999977648258209228515625)));
                    _355 = _353;
                    _356 = cross(_324, _353);
                }
                else
                {
                    _355 = _310;
                    _356 = _318;
                }
                _364 = _355;
                _365 = _356;
            }
            _373 = _364;
            _374 = _365;
        }
        _394 = _373;
        _395 = _374;
    }
    float _398 = _271 + EmitterUniforms.EmitterUniforms_RotationBias;
    float _399 = sin(_398);
    float _400 = cos(_398);
    float3 _401 = _395 * _399;
    float3 _402 = _394 * _400;
    float3 _403 = _401 + _402;
    float3 _404 = _395 * _400;
    float3 _405 = _394 * _399;
    float3 _406 = _404 - _405;
    float _407 = _237.x;
    float _410 = in.in_var_ATTRIBUTE0.x + EmitterUniforms.EmitterUniforms_PivotOffset.x;
    float _411 = _407 * _410;
    float3 _412 = _403 * _411;
    float _413 = _237.y;
    float _416 = in.in_var_ATTRIBUTE0.y + EmitterUniforms.EmitterUniforms_PivotOffset.y;
    float _417 = _413 * _416;
    float3 _418 = _406 * _417;
    float3 _419 = _412 + _418;
    float3 _420 = _298 + _419;
    float _421 = _420.x;
    float _422 = _420.y;
    float _423 = _420.z;
    float4 _424 = float4(_421, _422, _423, 1.0);
    float4 _425 = float4(_424.x, _424.y, _424.z, _424.w);
    float4 _426 = View.View_TranslatedWorldToClip * _425;
    float3x3 _428 = _112;
    _428[0] = _403;
    float3x3 _429 = _428;
    _429[1] = _406;
    float3 _431 = normalize(cross(_403, _406));
    float3x3 _432 = _429;
    _432[2] = _431;
    spvUnsafeArray<float4, 1> _445 = { float4(_263.x, _263.y, float4(0.0).z, float4(0.0).w) };
    float3 _446 = _424.xyz;
    float3 _447 = _446 - View.View_TranslatedWorldCameraOrigin;
    float _464 = fast::min(View.View_WorldCameraOrigin.z, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.z);
    float _467 = _447.z + (View.View_WorldCameraOrigin.z - _464);
    float3 _468 = _447;
    _468.z = _467;
    float _469 = dot(_468, _468);
    float _470 = rsqrt(_469);
    float _471 = _469 * _470;
    float _479 = fast::max(fast::max(View.View_VolumetricFogMaxDistance * (length(_447) / dot(_447, View.View_ViewForward)), 0.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.w);
    float _513;
    float _514;
    float _515;
    float _516;
    if (_479 > 0.0)
    {
        float _483 = _479 * _470;
        float _484 = _483 * _467;
        float _485 = _464 + _484;
        _513 = (1.0 - _483) * _471;
        _514 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.z * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * (_485 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.w)));
        _515 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.x * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * (_485 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.y)));
        _516 = _467 - _484;
    }
    else
    {
        _513 = _471;
        _514 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.x;
        _515 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.x;
        _516 = _467;
    }
    float _520 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * _516);
    float _534 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * _516);
    float _545 = (_515 * ((abs(_520) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_520)) / _520) : (0.693147182464599609375 - (0.2402265071868896484375 * _520)))) + (_514 * ((abs(_534) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_534)) / _534) : (0.693147182464599609375 - (0.2402265071868896484375 * _534))));
    float3 _587;
    if (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.z > 0.0)
    {
        float2 _572 = float2(dot(_468.xy, float2(TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation.y, -TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation.x)), dot(_468.xy, TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation));
        float3 _573 = float3(_572.x, _572.y, _468.z);
        _587 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.xyz * mix(TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap.sample(TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler, _573, level(TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.z)).xyz, TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap.sample(TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler, _573, level(0.0)).xyz, float3(fast::clamp((_471 * TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.x) + TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.y, 0.0, 1.0)));
    }
    else
    {
        _587 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.xyz;
    }
    float3 _615;
    if ((TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.w >= 0.0) && (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.z == 0.0))
    {
        _615 = (TranslucentBasePass.TranslucentBasePass_Shared_Fog_DirectionalInscatteringColor.xyz * pow(fast::clamp(dot(_468 * _470, TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.xyz), 0.0, 1.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_DirectionalInscatteringColor.w)) * (1.0 - fast::clamp(exp2(-(_545 * fast::max(_513 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.w, 0.0))), 0.0, 1.0));
    }
    else
    {
        _615 = float3(0.0);
    }
    bool _624 = (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w > 0.0) && (_471 > TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w);
    float _627 = _624 ? 1.0 : fast::max(fast::clamp(exp2(-(_545 * _513)), 0.0, 1.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.w);
    float4 _634 = float4((_587 * (1.0 - _627)) + select(_615, float3(0.0), bool3(_624)), _627);
    float4 _711;
    if (View.View_SkyAtmosphereApplyCameraAerialPerspectiveVolume > 0.0)
    {
        float3 _648 = (_446 * 9.9999997473787516355514526367188e-06) - (View.View_TranslatedWorldCameraOrigin * 9.9999997473787516355514526367188e-06);
        float _654 = sqrt((fast::max(0.0, length(_648) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
        float _655 = _654 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
        float _662;
        if (_655 < 0.707106769084930419921875)
        {
            _662 = fast::clamp((_655 * _655) * 2.0, 0.0, 1.0);
        }
        else
        {
            _662 = 1.0;
        }
        float2 _690;
        if (View.View_RealTimeReflectionCapture != 0.0)
        {
            float3 _665 = normalize(_648);
            float _666 = _665.z;
            float _669 = sqrt(1.0 - (_666 * _666));
            float2 _672 = _114;
            _672.y = (_666 * 0.5) + 0.5;
            float _677 = acos(_665.x / _669);
            float2 _682 = _672;
            _682.x = (((_665.y / _669) < 0.0) ? (6.283185482025146484375 - _677) : _677) * 0.15915493667125701904296875;
            _690 = (_682 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
        }
        else
        {
            _690 = ((_426.xy / _426.ww) * float2(0.5, -0.5)) + float2(0.5);
        }
        float4 _695 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_690, _654), level(0.0));
        float3 _707 = _634.xyz + (((_695.xyz * _662).xyz * View.View_OneOverPreExposure).xyz * _627);
        float4 _710 = float4(_707.x, _707.y, _707.z, _113.w);
        _710.w = _627 * (1.0 - (_662 * (1.0 - _695.w)));
        _711 = _710;
    }
    else
    {
        _711 = _634;
    }
    out_var_TEXCOORD0 = _445;
    out.out_var_TANGENTX = float4(_403, 0.0);
    out.out_var_TANGENTZ = float4(_431, float(int(sign(determinant(_432)))));
    out.out_var_TEXCOORD7 = _711;
    out.gl_Position = _426;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

