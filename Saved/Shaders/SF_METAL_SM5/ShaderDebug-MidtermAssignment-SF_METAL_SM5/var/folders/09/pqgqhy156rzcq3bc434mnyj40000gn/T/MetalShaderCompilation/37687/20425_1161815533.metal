

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

constant float3x3 _111 = {};
constant float4 _112 = {};
constant float2 _113 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10 [[user(locn0)]];
    float4 out_var_TEXCOORD11 [[user(locn1)]];
    float4 out_var_TEXCOORD2 [[user(locn2)]];
    float4 out_var_PARTICLE_SUBUVS [[user(locn3)]];
    float3 out_var_PARTICLE_LIGHTING_OFFSET [[user(locn4)]];
    float4 out_var_TEXCOORD7 [[user(locn5)]];
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

vertex Main_out Main_00004fc9_453fe5ed(Main_in in [[stage_in]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_SpriteVF& SpriteVF [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> CutoutGeometry [[texture(0)]], texturecube<float> TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap [[texture(1)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(2)]], sampler TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler [[sampler(0)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(1)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    float4 _170 = float4(in.in_var_ATTRIBUTE0.xyz, 1.0);
    float4 _173 = Primitive.Primitive_LocalToWorld * _170;
    float3 _179 = _173.xyz;
    float3 _183 = float3(SpriteVF.SpriteVF_RemoveHMDRoll);
    float3 _192 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _183), SpriteVF.SpriteVF_AxisLockRight.xyz, float3(SpriteVF.SpriteVF_AxisLockRight.w));
    float3 _200 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _183), SpriteVF.SpriteVF_AxisLockUp.xyz, float3(SpriteVF.SpriteVF_AxisLockUp.w));
    float3 _201 = View.View_WorldCameraOrigin - _179;
    float _202 = dot(_201, _201);
    float3 _205 = _201 * rsqrt(fast::max(_202, 9.9999999392252902907785028219223e-09));
    float3 _275;
    float3 _276;
    if (SpriteVF.SpriteVF_CameraFacingBlend[0] > 0.0)
    {
        float3 _221 = cross(_205, float3(0.0, 0.0, 1.0));
        float3 _225 = _221 * rsqrt(fast::max(dot(_221, _221), 9.9999999392252902907785028219223e-09));
        float3 _227 = float3(fast::clamp((_202 * SpriteVF.SpriteVF_CameraFacingBlend[1]) - SpriteVF.SpriteVF_CameraFacingBlend[2], 0.0, 1.0));
        _275 = normalize(mix(_192, _225, _227));
        _276 = normalize(mix(_200, cross(_205, _225), _227));
    }
    else
    {
        float3 _273;
        float3 _274;
        if (SpriteVF.SpriteVF_TangentSelector.y > 0.0)
        {
            float3 _237 = _179 - (Primitive.Primitive_LocalToWorld * float4(in.in_var_ATTRIBUTE1.xyz, 1.0)).xyz;
            float3 _241 = _237 * rsqrt(fast::max(dot(_237, _237), 9.9999999392252902907785028219223e-09));
            float3 _242 = cross(_205, _241);
            _273 = _242 * rsqrt(fast::max(dot(_242, _242), 9.9999999392252902907785028219223e-09));
            _274 = -_241;
        }
        else
        {
            float3 _271;
            float3 _272;
            if (SpriteVF.SpriteVF_TangentSelector.z > 0.0)
            {
                float3 _253 = cross(SpriteVF.SpriteVF_AxisLockRight.xyz, _205);
                _271 = SpriteVF.SpriteVF_AxisLockRight.xyz;
                _272 = -(_253 * rsqrt(fast::max(dot(_253, _253), 9.9999999392252902907785028219223e-09)));
            }
            else
            {
                float3 _269;
                float3 _270;
                if (SpriteVF.SpriteVF_TangentSelector.w > 0.0)
                {
                    float3 _263 = cross(_205, float3(0.0, 0.0, 1.0));
                    float3 _267 = _263 * rsqrt(fast::max(dot(_263, _263), 9.9999999392252902907785028219223e-09));
                    _269 = _267;
                    _270 = cross(_205, _267);
                }
                else
                {
                    _269 = _192;
                    _270 = _200;
                }
                _271 = _269;
                _272 = _270;
            }
            _273 = _271;
            _274 = _272;
        }
        _275 = _273;
        _276 = _274;
    }
    float _282 = in.in_var_ATTRIBUTE2.z * SpriteVF.SpriteVF_RotationScale;
    float _283 = _282 + SpriteVF.SpriteVF_RotationBias;
    float _284 = sin(_283);
    float _285 = cos(_283);
    float3 _286 = _276 * _284;
    float3 _287 = _275 * _285;
    float3 _288 = _286 + _287;
    float3 _289 = _276 * _285;
    float3 _290 = _275 * _284;
    float3 _291 = _289 - _290;
    float2 _295 = float2(int2(sign(in.in_var_ATTRIBUTE2.xy)));
    float2 _350;
    float2 _351;
    if (_Globals.NumCutoutVerticesPerFrame > 0u)
    {
        uint _305 = uint(mod(float((gl_VertexIndex - gl_BaseVertex)), float(_Globals.NumCutoutVerticesPerFrame)));
        float _314 = _295.x;
        float _315 = _295.y;
        uint _322;
        if ((_314 * _315) < 0.0)
        {
            _322 = (_Globals.NumCutoutVerticesPerFrame - 1u) - _305;
        }
        else
        {
            _322 = _305;
        }
        float4 _326 = CutoutGeometry.read(uint(((uint(mod(in.in_var_ATTRIBUTE2.w, SpriteVF.SpriteVF_SubImageSize.x * SpriteVF.SpriteVF_SubImageSize.y)) * _Globals.NumCutoutVerticesPerFrame) + _322)));
        float _329 = _326.x;
        float2 _332 = _113;
        _332.x = (_314 < 0.0) ? (1.0 - _329) : _329;
        float _334 = _326.y;
        float2 _337 = _332;
        _337.y = (_315 < 0.0) ? (1.0 - _334) : _334;
        _350 = _326.xy;
        _351 = _337;
    }
    else
    {
        float2 _343 = _113;
        _343.x = (_295.x < 0.0) ? (1.0 - in.in_var_ATTRIBUTE4.x) : in.in_var_ATTRIBUTE4.x;
        float2 _349 = _343;
        _349.y = (_295.y < 0.0) ? (1.0 - in.in_var_ATTRIBUTE4.y) : in.in_var_ATTRIBUTE4.y;
        _350 = _349;
        _351 = in.in_var_ATTRIBUTE4;
    }
    float3 _352 = _179 + View.View_PreViewTranslation;
    float _353 = _352.x;
    float _354 = _352.y;
    float _355 = _352.z;
    float4 _356 = float4(_353, _354, _355, 1.0);
    float2 _357 = abs(in.in_var_ATTRIBUTE2.xy);
    float _358 = _288.x;
    float _359 = _288.y;
    float _360 = _288.z;
    float4 _361 = float4(_358, _359, _360, 0.0);
    float _362 = _357.x;
    float _366 = _351.x + SpriteVF.SpriteVF_PivotOffset.x;
    float _367 = _362 * _366;
    float4 _368 = _361 * _367;
    float4 _369 = _356 + _368;
    float _370 = _291.x;
    float _371 = _291.y;
    float _372 = _291.z;
    float4 _373 = float4(_370, _371, _372, 0.0);
    float _374 = _357.y;
    float _378 = _351.y + SpriteVF.SpriteVF_PivotOffset.y;
    float _379 = _374 * _378;
    float4 _380 = _373 * _379;
    float4 _381 = _369 + _380;
    float _383 = fract(in.in_var_ATTRIBUTE2.w);
    float _384 = in.in_var_ATTRIBUTE2.w - _383;
    float _385 = _384 + 1.0;
    float2 _401 = (float2(mod(_384, SpriteVF.SpriteVF_SubImageSize.x), floor(_384 * SpriteVF.SpriteVF_SubImageSize.z)) + _350) * SpriteVF.SpriteVF_SubImageSize.zw;
    float2 _404 = (float2(mod(_385, SpriteVF.SpriteVF_SubImageSize.x), floor(_385 * SpriteVF.SpriteVF_SubImageSize.z)) + _350) * SpriteVF.SpriteVF_SubImageSize.zw;
    float3x3 _405 = _111;
    _405[0] = _288;
    float3x3 _406 = _405;
    _406[1] = _291;
    float3x3 _440;
    if (SpriteVF.SpriteVF_NormalsType < 0.5)
    {
        float3x3 _415 = _406;
        _415[2] = normalize(cross(_288, _291));
        _440 = _415;
    }
    else
    {
        float3x3 _439;
        if (SpriteVF.SpriteVF_NormalsType < 1.5)
        {
            float3x3 _425 = _406;
            _425[2] = normalize(_179 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz);
            _439 = _425;
        }
        else
        {
            float3x3 _438 = _406;
            _438[2] = normalize(_179 - (SpriteVF.SpriteVF_NormalsSphereCenter.xyz + (SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz * dot(SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz, _179 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz))));
            _439 = _438;
        }
        _440 = _439;
    }
    float _442 = in.in_var_ATTRIBUTE1.w + 10.0;
    float _452 = _381.x;
    float _453 = _381.y;
    float _454 = _381.z;
    float4 _455 = float4(_452, _453, _454, 1.0);
    float4 _456 = float4(_455.x, _455.y, _455.z, _455.w);
    float4 _457 = View.View_TranslatedWorldToClip * _456;
    float4 _461 = float4(_440[0].x, _440[0].y, _440[0].z, float4(0.0).w);
    _461.w = _383;
    float3 _471 = _455.xyz;
    float3 _472 = _471 - View.View_TranslatedWorldCameraOrigin;
    float _489 = fast::min(View.View_WorldCameraOrigin.z, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.z);
    float _492 = _472.z + (View.View_WorldCameraOrigin.z - _489);
    float3 _493 = _472;
    _493.z = _492;
    float _494 = dot(_493, _493);
    float _495 = rsqrt(_494);
    float _496 = _494 * _495;
    float _504 = fast::max(fast::max(View.View_VolumetricFogMaxDistance * (length(_472) / dot(_472, View.View_ViewForward)), 0.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.w);
    float _538;
    float _539;
    float _540;
    float _541;
    if (_504 > 0.0)
    {
        float _508 = _504 * _495;
        float _509 = _508 * _492;
        float _510 = _489 + _509;
        _538 = (1.0 - _508) * _496;
        _539 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.z * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * (_510 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.w)));
        _540 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.x * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * (_510 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.y)));
        _541 = _492 - _509;
    }
    else
    {
        _538 = _496;
        _539 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.x;
        _540 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.x;
        _541 = _492;
    }
    float _545 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * _541);
    float _559 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * _541);
    float _570 = (_540 * ((abs(_545) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_545)) / _545) : (0.693147182464599609375 - (0.2402265071868896484375 * _545)))) + (_539 * ((abs(_559) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_559)) / _559) : (0.693147182464599609375 - (0.2402265071868896484375 * _559))));
    float3 _612;
    if (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.z > 0.0)
    {
        float2 _597 = float2(dot(_493.xy, float2(TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation.y, -TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation.x)), dot(_493.xy, TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation));
        float3 _598 = float3(_597.x, _597.y, _493.z);
        _612 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.xyz * mix(TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap.sample(TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler, _598, level(TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.z)).xyz, TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap.sample(TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler, _598, level(0.0)).xyz, float3(fast::clamp((_496 * TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.x) + TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.y, 0.0, 1.0)));
    }
    else
    {
        _612 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.xyz;
    }
    float3 _640;
    if ((TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.w >= 0.0) && (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.z == 0.0))
    {
        _640 = (TranslucentBasePass.TranslucentBasePass_Shared_Fog_DirectionalInscatteringColor.xyz * pow(fast::clamp(dot(_493 * _495, TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.xyz), 0.0, 1.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_DirectionalInscatteringColor.w)) * (1.0 - fast::clamp(exp2(-(_570 * fast::max(_538 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.w, 0.0))), 0.0, 1.0));
    }
    else
    {
        _640 = float3(0.0);
    }
    bool _649 = (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w > 0.0) && (_496 > TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w);
    float _652 = _649 ? 1.0 : fast::max(fast::clamp(exp2(-(_570 * _538)), 0.0, 1.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.w);
    float4 _659 = float4((_612 * (1.0 - _652)) + select(_640, float3(0.0), bool3(_649)), _652);
    float4 _736;
    if (View.View_SkyAtmosphereApplyCameraAerialPerspectiveVolume > 0.0)
    {
        float3 _673 = (_471 * 9.9999997473787516355514526367188e-06) - (View.View_TranslatedWorldCameraOrigin * 9.9999997473787516355514526367188e-06);
        float _679 = sqrt((fast::max(0.0, length(_673) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
        float _680 = _679 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
        float _687;
        if (_680 < 0.707106769084930419921875)
        {
            _687 = fast::clamp((_680 * _680) * 2.0, 0.0, 1.0);
        }
        else
        {
            _687 = 1.0;
        }
        float2 _715;
        if (View.View_RealTimeReflectionCapture != 0.0)
        {
            float3 _690 = normalize(_673);
            float _691 = _690.z;
            float _694 = sqrt(1.0 - (_691 * _691));
            float2 _697 = _113;
            _697.y = (_691 * 0.5) + 0.5;
            float _702 = acos(_690.x / _694);
            float2 _707 = _697;
            _707.x = (((_690.y / _694) < 0.0) ? (6.283185482025146484375 - _702) : _702) * 0.15915493667125701904296875;
            _715 = (_707 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
        }
        else
        {
            _715 = ((_457.xy / _457.ww) * float2(0.5, -0.5)) + float2(0.5);
        }
        float4 _720 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_715, _679), level(0.0));
        float3 _732 = _659.xyz + (((_720.xyz * _687).xyz * View.View_OneOverPreExposure).xyz * _652);
        float4 _735 = float4(_732.x, _732.y, _732.z, _112.w);
        _735.w = _652 * (1.0 - (_687 * (1.0 - _720.w)));
        _736 = _735;
    }
    else
    {
        _736 = _659;
    }
    out.out_var_TEXCOORD10 = _461;
    out.out_var_TEXCOORD11 = float4(_440[2], float(int(sign(determinant(_440)))));
    out.out_var_TEXCOORD2 = in.in_var_ATTRIBUTE3;
    out.out_var_PARTICLE_SUBUVS = float4(_401.x, _401.y, _404.x, _404.y);
    out.out_var_PARTICLE_LIGHTING_OFFSET = ((fract(float3(1361.456298828125, 2333.577880859375, 3623.98291015625) * (_442 * _442)) * 2.0) - float3(1.0)) * (0.5 * View.View_TranslucencyLightingVolumeInvSize[0].w);
    out.out_var_TEXCOORD7 = _736;
    out.gl_Position = _457;
    return out;
}

