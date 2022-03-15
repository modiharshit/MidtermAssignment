

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

constant float3x3 _107 = {};
constant float4 _108 = {};
constant float2 _109 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10 [[user(locn0)]];
    float4 out_var_TEXCOORD11 [[user(locn1)]];
    float4 out_var_TEXCOORD1 [[user(locn2)]];
    float4 out_var_TEXCOORD2 [[user(locn3)]];
    float4 out_var_TEXCOORD3_0 [[user(locn4)]];
    float4 out_var_PARTICLE_SUBUVS [[user(locn5)]];
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
    float4 in_var_ATTRIBUTE5 [[attribute(5)]];
};

// Implementation of the GLSL mod() function, which is slightly different than Metal fmod()
template<typename Tx, typename Ty>
inline Tx mod(Tx x, Ty y)
{
    return x - y * floor(x / y);
}

vertex Main_out Main_00004fc2_ed3e743a(Main_in in [[stage_in]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_SpriteVF& SpriteVF [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> CutoutGeometry [[texture(0)]], texturecube<float> TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap [[texture(1)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(2)]], sampler TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler [[sampler(0)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(1)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD3 = {};
    float4 _166 = float4(in.in_var_ATTRIBUTE0.xyz, 1.0);
    float4 _169 = Primitive.Primitive_LocalToWorld * _166;
    float3 _175 = _169.xyz;
    float3 _179 = float3(SpriteVF.SpriteVF_RemoveHMDRoll);
    float3 _188 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _179), SpriteVF.SpriteVF_AxisLockRight.xyz, float3(SpriteVF.SpriteVF_AxisLockRight.w));
    float3 _196 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _179), SpriteVF.SpriteVF_AxisLockUp.xyz, float3(SpriteVF.SpriteVF_AxisLockUp.w));
    float3 _197 = View.View_WorldCameraOrigin - _175;
    float _198 = dot(_197, _197);
    float3 _201 = _197 * rsqrt(fast::max(_198, 9.9999999392252902907785028219223e-09));
    float3 _271;
    float3 _272;
    if (SpriteVF.SpriteVF_CameraFacingBlend[0] > 0.0)
    {
        float3 _260 = cross(_201, float3(0.0, 0.0, 1.0));
        float3 _264 = _260 * rsqrt(fast::max(dot(_260, _260), 9.9999999392252902907785028219223e-09));
        float3 _266 = float3(fast::clamp((_198 * SpriteVF.SpriteVF_CameraFacingBlend[1]) - SpriteVF.SpriteVF_CameraFacingBlend[2], 0.0, 1.0));
        _271 = normalize(mix(_188, _264, _266));
        _272 = normalize(mix(_196, cross(_201, _264), _266));
    }
    else
    {
        float3 _251;
        float3 _252;
        if (SpriteVF.SpriteVF_TangentSelector.y > 0.0)
        {
            float3 _240 = _175 - (Primitive.Primitive_LocalToWorld * float4(in.in_var_ATTRIBUTE1.xyz, 1.0)).xyz;
            float3 _244 = _240 * rsqrt(fast::max(dot(_240, _240), 9.9999999392252902907785028219223e-09));
            float3 _245 = cross(_201, _244);
            _251 = _245 * rsqrt(fast::max(dot(_245, _245), 9.9999999392252902907785028219223e-09));
            _252 = -_244;
        }
        else
        {
            float3 _238;
            float3 _239;
            if (SpriteVF.SpriteVF_TangentSelector.z > 0.0)
            {
                float3 _232 = cross(SpriteVF.SpriteVF_AxisLockRight.xyz, _201);
                _238 = SpriteVF.SpriteVF_AxisLockRight.xyz;
                _239 = -(_232 * rsqrt(fast::max(dot(_232, _232), 9.9999999392252902907785028219223e-09)));
            }
            else
            {
                float3 _230;
                float3 _231;
                if (SpriteVF.SpriteVF_TangentSelector.w > 0.0)
                {
                    float3 _224 = cross(_201, float3(0.0, 0.0, 1.0));
                    float3 _228 = _224 * rsqrt(fast::max(dot(_224, _224), 9.9999999392252902907785028219223e-09));
                    _230 = _228;
                    _231 = cross(_201, _228);
                }
                else
                {
                    _230 = _188;
                    _231 = _196;
                }
                _238 = _230;
                _239 = _231;
            }
            _251 = _238;
            _252 = _239;
        }
        _271 = _251;
        _272 = _252;
    }
    float _278 = in.in_var_ATTRIBUTE2.z * SpriteVF.SpriteVF_RotationScale;
    float _279 = _278 + SpriteVF.SpriteVF_RotationBias;
    float _280 = sin(_279);
    float _281 = cos(_279);
    float3 _282 = _272 * _280;
    float3 _283 = _271 * _281;
    float3 _284 = _282 + _283;
    float3 _285 = _272 * _281;
    float3 _286 = _271 * _280;
    float3 _287 = _285 - _286;
    float2 _291 = float2(int2(sign(in.in_var_ATTRIBUTE2.xy)));
    float2 _346;
    float2 _347;
    if (_Globals.NumCutoutVerticesPerFrame > 0u)
    {
        uint _313 = uint(mod(float((gl_VertexIndex - gl_BaseVertex)), float(_Globals.NumCutoutVerticesPerFrame)));
        float _322 = _291.x;
        float _323 = _291.y;
        uint _330;
        if ((_322 * _323) < 0.0)
        {
            _330 = (_Globals.NumCutoutVerticesPerFrame - 1u) - _313;
        }
        else
        {
            _330 = _313;
        }
        float4 _334 = CutoutGeometry.read(uint(((uint(mod(in.in_var_ATTRIBUTE2.w, SpriteVF.SpriteVF_SubImageSize.x * SpriteVF.SpriteVF_SubImageSize.y)) * _Globals.NumCutoutVerticesPerFrame) + _330)));
        float _337 = _334.x;
        float2 _340 = _109;
        _340.x = (_322 < 0.0) ? (1.0 - _337) : _337;
        float _342 = _334.y;
        float2 _345 = _340;
        _345.y = (_323 < 0.0) ? (1.0 - _342) : _342;
        _346 = _334.xy;
        _347 = _345;
    }
    else
    {
        float2 _303 = _109;
        _303.x = (_291.x < 0.0) ? (1.0 - in.in_var_ATTRIBUTE4.x) : in.in_var_ATTRIBUTE4.x;
        float2 _309 = _303;
        _309.y = (_291.y < 0.0) ? (1.0 - in.in_var_ATTRIBUTE4.y) : in.in_var_ATTRIBUTE4.y;
        _346 = _309;
        _347 = in.in_var_ATTRIBUTE4;
    }
    float3 _348 = _175 + View.View_PreViewTranslation;
    float _349 = _348.x;
    float _350 = _348.y;
    float _351 = _348.z;
    float4 _352 = float4(_349, _350, _351, 1.0);
    float2 _353 = abs(in.in_var_ATTRIBUTE2.xy);
    float _354 = _284.x;
    float _355 = _284.y;
    float _356 = _284.z;
    float4 _357 = float4(_354, _355, _356, 0.0);
    float _358 = _353.x;
    float _362 = _347.x + SpriteVF.SpriteVF_PivotOffset.x;
    float _363 = _358 * _362;
    float4 _364 = _357 * _363;
    float4 _365 = _352 + _364;
    float _366 = _287.x;
    float _367 = _287.y;
    float _368 = _287.z;
    float4 _369 = float4(_366, _367, _368, 0.0);
    float _370 = _353.y;
    float _374 = _347.y + SpriteVF.SpriteVF_PivotOffset.y;
    float _375 = _370 * _374;
    float4 _376 = _369 * _375;
    float4 _377 = _365 + _376;
    float _379 = fract(in.in_var_ATTRIBUTE2.w);
    float _380 = in.in_var_ATTRIBUTE2.w - _379;
    float _381 = _380 + 1.0;
    float2 _397 = (float2(mod(_380, SpriteVF.SpriteVF_SubImageSize.x), floor(_380 * SpriteVF.SpriteVF_SubImageSize.z)) + _346) * SpriteVF.SpriteVF_SubImageSize.zw;
    float2 _400 = (float2(mod(_381, SpriteVF.SpriteVF_SubImageSize.x), floor(_381 * SpriteVF.SpriteVF_SubImageSize.z)) + _346) * SpriteVF.SpriteVF_SubImageSize.zw;
    float3x3 _401 = _107;
    _401[0] = _284;
    float3x3 _402 = _401;
    _402[1] = _287;
    float3x3 _436;
    if (SpriteVF.SpriteVF_NormalsType < 0.5)
    {
        float3x3 _435 = _402;
        _435[2] = normalize(cross(_284, _287));
        _436 = _435;
    }
    else
    {
        float3x3 _432;
        if (SpriteVF.SpriteVF_NormalsType < 1.5)
        {
            float3x3 _431 = _402;
            _431[2] = normalize(_175 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz);
            _432 = _431;
        }
        else
        {
            float3x3 _425 = _402;
            _425[2] = normalize(_175 - (SpriteVF.SpriteVF_NormalsSphereCenter.xyz + (SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz * dot(SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz, _175 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz))));
            _432 = _425;
        }
        _436 = _432;
    }
    float _437 = _377.x;
    float _438 = _377.y;
    float _439 = _377.z;
    float4 _440 = float4(_437, _438, _439, 1.0);
    float4 _441 = float4(_440.x, _440.y, _440.z, _440.w);
    float4 _442 = View.View_TranslatedWorldToClip * _441;
    float4 _447 = float4(_436[0].x, _436[0].y, _436[0].z, float4(0.0).w);
    _447.w = _379;
    spvUnsafeArray<float4, 1> _457 = { float4(_397.x, _397.y, float4(0.0).z, float4(0.0).w) };
    float3 _458 = _440.xyz;
    float3 _459 = _458 - View.View_TranslatedWorldCameraOrigin;
    float _476 = fast::min(View.View_WorldCameraOrigin.z, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.z);
    float _479 = _459.z + (View.View_WorldCameraOrigin.z - _476);
    float3 _480 = _459;
    _480.z = _479;
    float _481 = dot(_480, _480);
    float _482 = rsqrt(_481);
    float _483 = _481 * _482;
    float _491 = fast::max(fast::max(View.View_VolumetricFogMaxDistance * (length(_459) / dot(_459, View.View_ViewForward)), 0.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.w);
    float _525;
    float _526;
    float _527;
    float _528;
    if (_491 > 0.0)
    {
        float _495 = _491 * _482;
        float _496 = _495 * _479;
        float _497 = _476 + _496;
        _525 = (1.0 - _495) * _483;
        _526 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.z * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * (_497 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.w)));
        _527 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.x * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * (_497 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.y)));
        _528 = _479 - _496;
    }
    else
    {
        _525 = _483;
        _526 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.x;
        _527 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.x;
        _528 = _479;
    }
    float _532 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * _528);
    float _546 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * _528);
    float _557 = (_527 * ((abs(_532) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_532)) / _532) : (0.693147182464599609375 - (0.2402265071868896484375 * _532)))) + (_526 * ((abs(_546) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_546)) / _546) : (0.693147182464599609375 - (0.2402265071868896484375 * _546))));
    float3 _599;
    if (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.z > 0.0)
    {
        float2 _584 = float2(dot(_480.xy, float2(TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation.y, -TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation.x)), dot(_480.xy, TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation));
        float3 _585 = float3(_584.x, _584.y, _480.z);
        _599 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.xyz * mix(TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap.sample(TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler, _585, level(TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.z)).xyz, TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap.sample(TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler, _585, level(0.0)).xyz, float3(fast::clamp((_483 * TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.x) + TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.y, 0.0, 1.0)));
    }
    else
    {
        _599 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.xyz;
    }
    float3 _627;
    if ((TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.w >= 0.0) && (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.z == 0.0))
    {
        _627 = (TranslucentBasePass.TranslucentBasePass_Shared_Fog_DirectionalInscatteringColor.xyz * pow(fast::clamp(dot(_480 * _482, TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.xyz), 0.0, 1.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_DirectionalInscatteringColor.w)) * (1.0 - fast::clamp(exp2(-(_557 * fast::max(_525 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.w, 0.0))), 0.0, 1.0));
    }
    else
    {
        _627 = float3(0.0);
    }
    bool _636 = (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w > 0.0) && (_483 > TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w);
    float _639 = _636 ? 1.0 : fast::max(fast::clamp(exp2(-(_557 * _525)), 0.0, 1.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.w);
    float4 _646 = float4((_599 * (1.0 - _639)) + select(_627, float3(0.0), bool3(_636)), _639);
    float4 _723;
    if (View.View_SkyAtmosphereApplyCameraAerialPerspectiveVolume > 0.0)
    {
        float3 _660 = (_458 * 9.9999997473787516355514526367188e-06) - (View.View_TranslatedWorldCameraOrigin * 9.9999997473787516355514526367188e-06);
        float _666 = sqrt((fast::max(0.0, length(_660) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
        float _667 = _666 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
        float _674;
        if (_667 < 0.707106769084930419921875)
        {
            _674 = fast::clamp((_667 * _667) * 2.0, 0.0, 1.0);
        }
        else
        {
            _674 = 1.0;
        }
        float2 _702;
        if (View.View_RealTimeReflectionCapture != 0.0)
        {
            float3 _677 = normalize(_660);
            float _678 = _677.z;
            float _681 = sqrt(1.0 - (_678 * _678));
            float2 _684 = _109;
            _684.y = (_678 * 0.5) + 0.5;
            float _689 = acos(_677.x / _681);
            float2 _694 = _684;
            _694.x = (((_677.y / _681) < 0.0) ? (6.283185482025146484375 - _689) : _689) * 0.15915493667125701904296875;
            _702 = (_694 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
        }
        else
        {
            _702 = ((_442.xy / _442.ww) * float2(0.5, -0.5)) + float2(0.5);
        }
        float4 _707 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_702, _666), level(0.0));
        float3 _719 = _646.xyz + (((_707.xyz * _674).xyz * View.View_OneOverPreExposure).xyz * _639);
        float4 _722 = float4(_719.x, _719.y, _719.z, _108.w);
        _722.w = _639 * (1.0 - (_674 * (1.0 - _707.w)));
        _723 = _722;
    }
    else
    {
        _723 = _646;
    }
    out.out_var_TEXCOORD10 = _447;
    out.out_var_TEXCOORD11 = float4(_436[2], float(int(sign(determinant(_436)))));
    out.out_var_TEXCOORD1 = in.in_var_ATTRIBUTE5;
    out.out_var_TEXCOORD2 = in.in_var_ATTRIBUTE3;
    out_var_TEXCOORD3 = _457;
    out.out_var_PARTICLE_SUBUVS = float4(_397.x, _397.y, _400.x, _400.y);
    out.out_var_TEXCOORD7 = _723;
    out.gl_Position = _442;
    out.out_var_TEXCOORD3_0 = out_var_TEXCOORD3[0];
    return out;
}

