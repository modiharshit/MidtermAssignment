

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
    char _m10_pad[224];
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeInvSize;
    char _m11_pad[448];
    float4 View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize;
    float View_SkyAtmosphereAerialPerspectiveStartDepthKm;
    float View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
    float View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv;
    char _m15_pad[4];
    float View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv;
    float View_SkyAtmosphereApplyCameraAerialPerspectiveVolume;
    char _m17_pad[24];
    float View_RealTimeReflectionCapture;
    char _m18_pad[420];
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
    float4 EmitterDynamicUniforms_DynamicColor;
};

struct type_EmitterUniforms
{
    float4 EmitterUniforms_ColorCurve;
    float4 EmitterUniforms_ColorScale;
    float4 EmitterUniforms_ColorBias;
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
    char _m13_pad[8];
    float2 EmitterUniforms_PivotOffset;
};

struct type_Globals
{
    uint ParticleIndicesOffset;
};

constant float3x3 _133 = {};
constant float4 _134 = {};
constant float2 _135 = {};

struct Main_out
{
    float4 out_var_TEXCOORD0_0 [[user(locn0)]];
    float4 out_var_PARTICLE_SUBUVS [[user(locn1)]];
    float3 out_var_TEXCOORD4 [[user(locn2)]];
    float4 out_var_TEXCOORD5 [[user(locn3)]];
    float3 out_var_PARTICLE_LIGHTING_OFFSET [[user(locn4)]];
    float4 out_var_TANGENTX [[user(locn5)]];
    float4 out_var_TANGENTZ [[user(locn6)]];
    float4 out_var_TEXCOORD7 [[user(locn7)]];
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

vertex Main_out Main_00005836_02ee4ada(Main_in in [[stage_in]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_EmitterDynamicUniforms& EmitterDynamicUniforms [[buffer(4)]], constant type_EmitterUniforms& EmitterUniforms [[buffer(5)]], constant type_Globals& _Globals [[buffer(6)]], texture_buffer<float> ParticleIndices [[texture(0)]], texturecube<float> TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap [[texture(1)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(2)]], texture2d<float> PositionTexture [[texture(3)]], texture2d<float> VelocityTexture [[texture(4)]], texture2d<float> AttributesTexture [[texture(5)]], texture2d<float> CurveTexture [[texture(6)]], sampler TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler [[sampler(0)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(1)]], sampler PositionTextureSampler [[sampler(2)]], sampler VelocityTextureSampler [[sampler(3)]], sampler AttributesTextureSampler [[sampler(4)]], sampler CurveTextureSampler [[sampler(5)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    uint _182 = (gl_InstanceIndex - gl_BaseInstance) * 16u;
    uint _183 = (gl_VertexIndex - gl_BaseVertex) / 4u;
    uint _184 = _182 + _183;
    uint _187 = _Globals.ParticleIndicesOffset + _184;
    float4 _189 = ParticleIndices.read(uint(_187));
    float2 _190 = _189.xy;
    float4 _194 = PositionTexture.sample(PositionTextureSampler, _190, level(0.0));
    float4 _198 = VelocityTexture.sample(VelocityTextureSampler, _190, level(0.0));
    float4 _202 = AttributesTexture.sample(AttributesTextureSampler, _190, level(0.0));
    float _203 = _194.w;
    float _204 = step(_203, 1.0);
    float3 _205 = _198.xyz;
    float3x3 _214 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    float3 _215 = _214 * _205;
    float3 _217 = normalize(_215 + float3(0.0, 0.0, 9.9999997473787516355514526367188e-05));
    float _218 = length(_215);
    float2 _242 = EmitterUniforms.EmitterUniforms_MiscCurve.zw * _203;
    float2 _243 = EmitterUniforms.EmitterUniforms_MiscCurve.xy + _242;
    float4 _245 = CurveTexture.sample(CurveTextureSampler, _243, level(0.0));
    float4 _248 = _245 * EmitterUniforms.EmitterUniforms_MiscScale;
    float4 _251 = _248 + EmitterUniforms.EmitterUniforms_MiscBias;
    float _252 = _202.x;
    bool _253 = _252 < 0.5;
    float _254 = _253 ? 0.0 : (-0.5);
    float _255 = _202.y;
    bool _256 = _255 < 0.5;
    float _257 = _256 ? 0.0 : (-0.5);
    float2 _258 = float2(_254, _257);
    float2 _259 = _202.xy;
    float2 _260 = _259 + _258;
    float2 _261 = _260 * float2(2.0);
    float2 _262 = _251.xy;
    float2 _265 = _262 * EmitterDynamicUniforms.EmitterDynamicUniforms_LocalToWorldScale;
    float2 _269 = EmitterUniforms.EmitterUniforms_SizeBySpeed.xy * _218;
    float2 _270 = fast::max(_269, float2(1.0));
    float2 _272 = fast::min(_270, EmitterUniforms.EmitterUniforms_SizeBySpeed.zw);
    float2 _273 = _261 * _265;
    float2 _274 = _273 * _272;
    float2 _275 = float2(_204);
    float2 _276 = _274 * _275;
    float2 _281 = _135;
    _281.x = (_254 == 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.x) : in.in_var_ATTRIBUTE0.x;
    float2 _286 = _281;
    _286.y = (_257 == 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.y) : in.in_var_ATTRIBUTE0.y;
    float _287 = _251.z;
    float _288 = fract(_287);
    float _289 = _287 - _288;
    float _290 = _289 + 1.0;
    float2 _306 = (float2(mod(_289, EmitterUniforms.EmitterUniforms_SubImageSize.x), floor(_289 * EmitterUniforms.EmitterUniforms_SubImageSize.z)) + _286) * EmitterUniforms.EmitterUniforms_SubImageSize.zw;
    float2 _309 = (float2(mod(_290, EmitterUniforms.EmitterUniforms_SubImageSize.x), floor(_290 * EmitterUniforms.EmitterUniforms_SubImageSize.z)) + _286) * EmitterUniforms.EmitterUniforms_SubImageSize.zw;
    float _310 = _202.w;
    float _313 = _310 * EmitterUniforms.EmitterUniforms_RotationRateScale;
    float _314 = _202.z;
    float _315 = _313 * _203;
    float _316 = _314 + _315;
    float _317 = _316 * 6.283185482025146484375;
    float3 _321 = _194.xxx;
    float3 _322 = Primitive.Primitive_LocalToWorld[0u].xyz * _321;
    float3 _326 = _194.yyy;
    float3 _327 = Primitive.Primitive_LocalToWorld[1u].xyz * _326;
    float3 _328 = _322 + _327;
    float3 _332 = _194.zzz;
    float3 _333 = Primitive.Primitive_LocalToWorld[2u].xyz * _332;
    float3 _334 = _328 + _333;
    float3 _338 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _339 = _334 + _338;
    float _340 = _339.x;
    float _341 = _339.y;
    float _342 = _339.z;
    float4 _343 = float4(_340, _341, _342, 1.0);
    float3 _344 = _343.xyz;
    float3 _347 = float3(EmitterUniforms.EmitterUniforms_RemoveHMDRoll);
    float3 _356 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _347), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.w));
    float3 _364 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _347), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.w));
    float3 _365 = View.View_TranslatedWorldCameraOrigin - _344;
    float _366 = dot(_365, _365);
    float3 _370 = _365 / float3(sqrt(fast::max(_366, 0.00999999977648258209228515625)));
    float3 _440;
    float3 _441;
    if (EmitterUniforms.EmitterUniforms_CameraFacingBlend[0] > 0.0)
    {
        float3 _428 = cross(_370, float3(0.0, 0.0, 1.0));
        float3 _433 = _428 / float3(sqrt(fast::max(dot(_428, _428), 0.00999999977648258209228515625)));
        float3 _435 = float3(fast::clamp((_366 * EmitterUniforms.EmitterUniforms_CameraFacingBlend[1]) - EmitterUniforms.EmitterUniforms_CameraFacingBlend[2], 0.0, 1.0));
        _440 = normalize(mix(_356, _433, _435));
        _441 = normalize(mix(_364, cross(_370, _433), _435));
    }
    else
    {
        float3 _419;
        float3 _420;
        if (EmitterUniforms.EmitterUniforms_TangentSelector.y > 0.0)
        {
            float3 _412 = cross(_370, _217);
            _419 = _412 / float3(sqrt(fast::max(dot(_412, _412), 0.00999999977648258209228515625)));
            _420 = -_217;
        }
        else
        {
            float3 _410;
            float3 _411;
            if (EmitterUniforms.EmitterUniforms_TangentSelector.z > 0.0)
            {
                float3 _403 = cross(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, _370);
                _410 = EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz;
                _411 = -(_403 / float3(sqrt(fast::max(dot(_403, _403), 0.00999999977648258209228515625))));
            }
            else
            {
                float3 _401;
                float3 _402;
                if (EmitterUniforms.EmitterUniforms_TangentSelector.w > 0.0)
                {
                    float3 _394 = cross(_370, float3(0.0, 0.0, 1.0));
                    float3 _399 = _394 / float3(sqrt(fast::max(dot(_394, _394), 0.00999999977648258209228515625)));
                    _401 = _399;
                    _402 = cross(_370, _399);
                }
                else
                {
                    _401 = _356;
                    _402 = _364;
                }
                _410 = _401;
                _411 = _402;
            }
            _419 = _410;
            _420 = _411;
        }
        _440 = _419;
        _441 = _420;
    }
    float _444 = _317 + EmitterUniforms.EmitterUniforms_RotationBias;
    float _445 = sin(_444);
    float _446 = cos(_444);
    float3 _447 = _441 * _445;
    float3 _448 = _440 * _446;
    float3 _449 = _447 + _448;
    float3 _450 = _441 * _446;
    float3 _451 = _440 * _445;
    float3 _452 = _450 - _451;
    float _453 = _276.x;
    float _456 = in.in_var_ATTRIBUTE0.x + EmitterUniforms.EmitterUniforms_PivotOffset.x;
    float _457 = _453 * _456;
    float3 _458 = _449 * _457;
    float _459 = _276.y;
    float _462 = in.in_var_ATTRIBUTE0.y + EmitterUniforms.EmitterUniforms_PivotOffset.y;
    float _463 = _459 * _462;
    float3 _464 = _452 * _463;
    float3 _465 = _458 + _464;
    float3 _466 = _344 + _465;
    float _480 = _466.x;
    float _481 = _466.y;
    float _482 = _466.z;
    float4 _483 = float4(_480, _481, _482, 1.0);
    float4 _484 = float4(_483.x, _483.y, _483.z, _483.w);
    float4 _485 = View.View_TranslatedWorldToClip * _484;
    float3 _488 = float3(0.0);
    _488.x = _288;
    float3 _489 = _488;
    _489.y = _203;
    float3 _490 = _489;
    _490.z = 0.0;
    float3x3 _491 = _133;
    _491[0] = _449;
    float3x3 _492 = _491;
    _492[1] = _452;
    float3 _494 = normalize(cross(_449, _452));
    float3x3 _495 = _492;
    _495[2] = _494;
    spvUnsafeArray<float4, 1> _508 = { float4(_306.x, _306.y, float4(0.0).z, float4(0.0).w) };
    float3 _509 = _483.xyz;
    float3 _510 = _509 - View.View_TranslatedWorldCameraOrigin;
    float _527 = fast::min(View.View_WorldCameraOrigin.z, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.z);
    float _530 = _510.z + (View.View_WorldCameraOrigin.z - _527);
    float3 _531 = _510;
    _531.z = _530;
    float _532 = dot(_531, _531);
    float _533 = rsqrt(_532);
    float _534 = _532 * _533;
    float _542 = fast::max(fast::max(View.View_VolumetricFogMaxDistance * (length(_510) / dot(_510, View.View_ViewForward)), 0.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.w);
    float _576;
    float _577;
    float _578;
    float _579;
    if (_542 > 0.0)
    {
        float _546 = _542 * _533;
        float _547 = _546 * _530;
        float _548 = _527 + _547;
        _576 = (1.0 - _546) * _534;
        _577 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.z * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * (_548 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.w)));
        _578 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.x * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * (_548 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.y)));
        _579 = _530 - _547;
    }
    else
    {
        _576 = _534;
        _577 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.x;
        _578 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.x;
        _579 = _530;
    }
    float _583 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * _579);
    float _597 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * _579);
    float _608 = (_578 * ((abs(_583) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_583)) / _583) : (0.693147182464599609375 - (0.2402265071868896484375 * _583)))) + (_577 * ((abs(_597) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_597)) / _597) : (0.693147182464599609375 - (0.2402265071868896484375 * _597))));
    float3 _650;
    if (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.z > 0.0)
    {
        float2 _635 = float2(dot(_531.xy, float2(TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation.y, -TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation.x)), dot(_531.xy, TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation));
        float3 _636 = float3(_635.x, _635.y, _531.z);
        _650 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.xyz * mix(TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap.sample(TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler, _636, level(TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.z)).xyz, TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap.sample(TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler, _636, level(0.0)).xyz, float3(fast::clamp((_534 * TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.x) + TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.y, 0.0, 1.0)));
    }
    else
    {
        _650 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.xyz;
    }
    float3 _678;
    if ((TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.w >= 0.0) && (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.z == 0.0))
    {
        _678 = (TranslucentBasePass.TranslucentBasePass_Shared_Fog_DirectionalInscatteringColor.xyz * pow(fast::clamp(dot(_531 * _533, TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.xyz), 0.0, 1.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_DirectionalInscatteringColor.w)) * (1.0 - fast::clamp(exp2(-(_608 * fast::max(_576 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.w, 0.0))), 0.0, 1.0));
    }
    else
    {
        _678 = float3(0.0);
    }
    bool _687 = (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w > 0.0) && (_534 > TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w);
    float _690 = _687 ? 1.0 : fast::max(fast::clamp(exp2(-(_608 * _576)), 0.0, 1.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.w);
    float4 _697 = float4((_650 * (1.0 - _690)) + select(_678, float3(0.0), bool3(_687)), _690);
    float4 _774;
    if (View.View_SkyAtmosphereApplyCameraAerialPerspectiveVolume > 0.0)
    {
        float3 _711 = (_509 * 9.9999997473787516355514526367188e-06) - (View.View_TranslatedWorldCameraOrigin * 9.9999997473787516355514526367188e-06);
        float _717 = sqrt((fast::max(0.0, length(_711) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
        float _718 = _717 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
        float _725;
        if (_718 < 0.707106769084930419921875)
        {
            _725 = fast::clamp((_718 * _718) * 2.0, 0.0, 1.0);
        }
        else
        {
            _725 = 1.0;
        }
        float2 _753;
        if (View.View_RealTimeReflectionCapture != 0.0)
        {
            float3 _728 = normalize(_711);
            float _729 = _728.z;
            float _732 = sqrt(1.0 - (_729 * _729));
            float2 _735 = _135;
            _735.y = (_729 * 0.5) + 0.5;
            float _740 = acos(_728.x / _732);
            float2 _745 = _735;
            _745.x = (((_728.y / _732) < 0.0) ? (6.283185482025146484375 - _740) : _740) * 0.15915493667125701904296875;
            _753 = (_745 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
        }
        else
        {
            _753 = ((_485.xy / _485.ww) * float2(0.5, -0.5)) + float2(0.5);
        }
        float4 _758 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_753, _717), level(0.0));
        float3 _770 = _697.xyz + (((_758.xyz * _725).xyz * View.View_OneOverPreExposure).xyz * _690);
        float4 _773 = float4(_770.x, _770.y, _770.z, _134.w);
        _773.w = _690 * (1.0 - (_725 * (1.0 - _758.w)));
        _774 = _773;
    }
    else
    {
        _774 = _697;
    }
    out_var_TEXCOORD0 = _508;
    out.out_var_PARTICLE_SUBUVS = float4(_306.x, _306.y, _309.x, _309.y);
    out.out_var_TEXCOORD4 = _490;
    out.out_var_TEXCOORD5 = ((CurveTexture.sample(CurveTextureSampler, (EmitterUniforms.EmitterUniforms_ColorCurve.xy + (EmitterUniforms.EmitterUniforms_ColorCurve.zw * _203)), level(0.0)) * EmitterUniforms.EmitterUniforms_ColorScale) + EmitterUniforms.EmitterUniforms_ColorBias) * EmitterDynamicUniforms.EmitterDynamicUniforms_DynamicColor;
    out.out_var_PARTICLE_LIGHTING_OFFSET = ((fract(float3(1341.456298828125, 2633.577880859375, 5623.98291015625) * ((_189.x + 10.0) * (_189.y + 10.0))) * 2.0) - float3(1.0)) * (0.5 * View.View_TranslucencyLightingVolumeInvSize[0].w);
    out.out_var_TANGENTX = float4(_449, 0.0);
    out.out_var_TANGENTZ = float4(_494, float(int(sign(determinant(_495)))));
    out.out_var_TEXCOORD7 = _774;
    out.gl_Position = _485;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

