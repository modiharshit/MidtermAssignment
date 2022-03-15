

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

constant float3x3 _104 = {};
constant float4 _105 = {};
constant float2 _106 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10 [[user(locn0)]];
    float4 out_var_TEXCOORD11 [[user(locn1)]];
    float4 out_var_TEXCOORD2 [[user(locn2)]];
    float4 out_var_TEXCOORD3_0 [[user(locn3)]];
    float4 out_var_TEXCOORD7 [[user(locn4)]];
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

vertex Main_out Main_00004de4_f0e89e65(Main_in in [[stage_in]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_SpriteVF& SpriteVF [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> CutoutGeometry [[texture(0)]], texturecube<float> TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap [[texture(1)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(2)]], sampler TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler [[sampler(0)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(1)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD3 = {};
    float4 _162 = float4(in.in_var_ATTRIBUTE0.xyz, 1.0);
    float4 _165 = Primitive.Primitive_LocalToWorld * _162;
    float3 _171 = _165.xyz;
    float3 _175 = float3(SpriteVF.SpriteVF_RemoveHMDRoll);
    float3 _184 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _175), SpriteVF.SpriteVF_AxisLockRight.xyz, float3(SpriteVF.SpriteVF_AxisLockRight.w));
    float3 _192 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _175), SpriteVF.SpriteVF_AxisLockUp.xyz, float3(SpriteVF.SpriteVF_AxisLockUp.w));
    float3 _193 = View.View_WorldCameraOrigin - _171;
    float _194 = dot(_193, _193);
    float3 _197 = _193 * rsqrt(fast::max(_194, 9.9999999392252902907785028219223e-09));
    float3 _267;
    float3 _268;
    if (SpriteVF.SpriteVF_CameraFacingBlend[0] > 0.0)
    {
        float3 _256 = cross(_197, float3(0.0, 0.0, 1.0));
        float3 _260 = _256 * rsqrt(fast::max(dot(_256, _256), 9.9999999392252902907785028219223e-09));
        float3 _262 = float3(fast::clamp((_194 * SpriteVF.SpriteVF_CameraFacingBlend[1]) - SpriteVF.SpriteVF_CameraFacingBlend[2], 0.0, 1.0));
        _267 = normalize(mix(_184, _260, _262));
        _268 = normalize(mix(_192, cross(_197, _260), _262));
    }
    else
    {
        float3 _247;
        float3 _248;
        if (SpriteVF.SpriteVF_TangentSelector.y > 0.0)
        {
            float3 _236 = _171 - (Primitive.Primitive_LocalToWorld * float4(in.in_var_ATTRIBUTE1.xyz, 1.0)).xyz;
            float3 _240 = _236 * rsqrt(fast::max(dot(_236, _236), 9.9999999392252902907785028219223e-09));
            float3 _241 = cross(_197, _240);
            _247 = _241 * rsqrt(fast::max(dot(_241, _241), 9.9999999392252902907785028219223e-09));
            _248 = -_240;
        }
        else
        {
            float3 _234;
            float3 _235;
            if (SpriteVF.SpriteVF_TangentSelector.z > 0.0)
            {
                float3 _228 = cross(SpriteVF.SpriteVF_AxisLockRight.xyz, _197);
                _234 = SpriteVF.SpriteVF_AxisLockRight.xyz;
                _235 = -(_228 * rsqrt(fast::max(dot(_228, _228), 9.9999999392252902907785028219223e-09)));
            }
            else
            {
                float3 _226;
                float3 _227;
                if (SpriteVF.SpriteVF_TangentSelector.w > 0.0)
                {
                    float3 _220 = cross(_197, float3(0.0, 0.0, 1.0));
                    float3 _224 = _220 * rsqrt(fast::max(dot(_220, _220), 9.9999999392252902907785028219223e-09));
                    _226 = _224;
                    _227 = cross(_197, _224);
                }
                else
                {
                    _226 = _184;
                    _227 = _192;
                }
                _234 = _226;
                _235 = _227;
            }
            _247 = _234;
            _248 = _235;
        }
        _267 = _247;
        _268 = _248;
    }
    float _274 = in.in_var_ATTRIBUTE2.z * SpriteVF.SpriteVF_RotationScale;
    float _275 = _274 + SpriteVF.SpriteVF_RotationBias;
    float _276 = sin(_275);
    float _277 = cos(_275);
    float3 _278 = _268 * _276;
    float3 _279 = _267 * _277;
    float3 _280 = _278 + _279;
    float3 _281 = _268 * _277;
    float3 _282 = _267 * _276;
    float3 _283 = _281 - _282;
    float2 _287 = float2(int2(sign(in.in_var_ATTRIBUTE2.xy)));
    float2 _342;
    float2 _343;
    if (_Globals.NumCutoutVerticesPerFrame > 0u)
    {
        uint _309 = uint(mod(float((gl_VertexIndex - gl_BaseVertex)), float(_Globals.NumCutoutVerticesPerFrame)));
        float _318 = _287.x;
        float _319 = _287.y;
        uint _326;
        if ((_318 * _319) < 0.0)
        {
            _326 = (_Globals.NumCutoutVerticesPerFrame - 1u) - _309;
        }
        else
        {
            _326 = _309;
        }
        float4 _330 = CutoutGeometry.read(uint(((uint(mod(in.in_var_ATTRIBUTE2.w, SpriteVF.SpriteVF_SubImageSize.x * SpriteVF.SpriteVF_SubImageSize.y)) * _Globals.NumCutoutVerticesPerFrame) + _326)));
        float _333 = _330.x;
        float2 _336 = _106;
        _336.x = (_318 < 0.0) ? (1.0 - _333) : _333;
        float _338 = _330.y;
        float2 _341 = _336;
        _341.y = (_319 < 0.0) ? (1.0 - _338) : _338;
        _342 = _330.xy;
        _343 = _341;
    }
    else
    {
        float2 _299 = _106;
        _299.x = (_287.x < 0.0) ? (1.0 - in.in_var_ATTRIBUTE4.x) : in.in_var_ATTRIBUTE4.x;
        float2 _305 = _299;
        _305.y = (_287.y < 0.0) ? (1.0 - in.in_var_ATTRIBUTE4.y) : in.in_var_ATTRIBUTE4.y;
        _342 = _305;
        _343 = in.in_var_ATTRIBUTE4;
    }
    float3 _344 = _171 + View.View_PreViewTranslation;
    float _345 = _344.x;
    float _346 = _344.y;
    float _347 = _344.z;
    float4 _348 = float4(_345, _346, _347, 1.0);
    float2 _349 = abs(in.in_var_ATTRIBUTE2.xy);
    float _350 = _280.x;
    float _351 = _280.y;
    float _352 = _280.z;
    float4 _353 = float4(_350, _351, _352, 0.0);
    float _354 = _349.x;
    float _358 = _343.x + SpriteVF.SpriteVF_PivotOffset.x;
    float _359 = _354 * _358;
    float4 _360 = _353 * _359;
    float4 _361 = _348 + _360;
    float _362 = _283.x;
    float _363 = _283.y;
    float _364 = _283.z;
    float4 _365 = float4(_362, _363, _364, 0.0);
    float _366 = _349.y;
    float _370 = _343.y + SpriteVF.SpriteVF_PivotOffset.y;
    float _371 = _366 * _370;
    float4 _372 = _365 * _371;
    float4 _373 = _361 + _372;
    float _375 = fract(in.in_var_ATTRIBUTE2.w);
    float _376 = in.in_var_ATTRIBUTE2.w - _375;
    float2 _389 = (float2(mod(_376, SpriteVF.SpriteVF_SubImageSize.x), floor(_376 * SpriteVF.SpriteVF_SubImageSize.z)) + _342) * SpriteVF.SpriteVF_SubImageSize.zw;
    float3x3 _390 = _104;
    _390[0] = _280;
    float3x3 _391 = _390;
    _391[1] = _283;
    float3x3 _425;
    if (SpriteVF.SpriteVF_NormalsType < 0.5)
    {
        float3x3 _424 = _391;
        _424[2] = normalize(cross(_280, _283));
        _425 = _424;
    }
    else
    {
        float3x3 _421;
        if (SpriteVF.SpriteVF_NormalsType < 1.5)
        {
            float3x3 _420 = _391;
            _420[2] = normalize(_171 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz);
            _421 = _420;
        }
        else
        {
            float3x3 _414 = _391;
            _414[2] = normalize(_171 - (SpriteVF.SpriteVF_NormalsSphereCenter.xyz + (SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz * dot(SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz, _171 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz))));
            _421 = _414;
        }
        _425 = _421;
    }
    float _426 = _373.x;
    float _427 = _373.y;
    float _428 = _373.z;
    float4 _429 = float4(_426, _427, _428, 1.0);
    float4 _430 = float4(_429.x, _429.y, _429.z, _429.w);
    float4 _431 = View.View_TranslatedWorldToClip * _430;
    float4 _435 = float4(_425[0].x, _425[0].y, _425[0].z, float4(0.0).w);
    _435.w = _375;
    spvUnsafeArray<float4, 1> _445 = { float4(_389.x, _389.y, float4(0.0).z, float4(0.0).w) };
    float3 _446 = _429.xyz;
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
            float2 _672 = _106;
            _672.y = (_666 * 0.5) + 0.5;
            float _677 = acos(_665.x / _669);
            float2 _682 = _672;
            _682.x = (((_665.y / _669) < 0.0) ? (6.283185482025146484375 - _677) : _677) * 0.15915493667125701904296875;
            _690 = (_682 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
        }
        else
        {
            _690 = ((_431.xy / _431.ww) * float2(0.5, -0.5)) + float2(0.5);
        }
        float4 _695 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_690, _654), level(0.0));
        float3 _707 = _634.xyz + (((_695.xyz * _662).xyz * View.View_OneOverPreExposure).xyz * _627);
        float4 _710 = float4(_707.x, _707.y, _707.z, _105.w);
        _710.w = _627 * (1.0 - (_662 * (1.0 - _695.w)));
        _711 = _710;
    }
    else
    {
        _711 = _634;
    }
    out.out_var_TEXCOORD10 = _435;
    out.out_var_TEXCOORD11 = float4(_425[2], float(int(sign(determinant(_425)))));
    out.out_var_TEXCOORD2 = in.in_var_ATTRIBUTE3;
    out_var_TEXCOORD3 = _445;
    out.out_var_TEXCOORD7 = _711;
    out.gl_Position = _431;
    out.out_var_TEXCOORD3_0 = out_var_TEXCOORD3[0];
    return out;
}

