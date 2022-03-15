

#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct type_TranslucentBasePass
{
    char _m0_pad[1712];
    float4 TranslucentBasePass_Shared_Fog_ExponentialFogParameters;
    float4 TranslucentBasePass_Shared_Fog_ExponentialFogParameters2;
    float4 TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter;
    float4 TranslucentBasePass_Shared_Fog_ExponentialFogParameters3;
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

constant float3x3 _95 = {};
constant float4 _96 = {};
constant float2 _97 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10 [[user(locn0)]];
    float4 out_var_TEXCOORD11 [[user(locn1)]];
    float4 out_var_TEXCOORD2 [[user(locn2)]];
    float4 out_var_PARTICLE_SUBUVS [[user(locn3)]];
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

vertex Main_out Main_00003fbb_260180fa(Main_in in [[stage_in]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_SpriteVF& SpriteVF [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> CutoutGeometry [[texture(0)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(1)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    float4 _152 = float4(in.in_var_ATTRIBUTE0.xyz, 1.0);
    float4 _155 = Primitive.Primitive_LocalToWorld * _152;
    float3 _161 = _155.xyz;
    float3 _165 = float3(SpriteVF.SpriteVF_RemoveHMDRoll);
    float3 _174 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _165), SpriteVF.SpriteVF_AxisLockRight.xyz, float3(SpriteVF.SpriteVF_AxisLockRight.w));
    float3 _182 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _165), SpriteVF.SpriteVF_AxisLockUp.xyz, float3(SpriteVF.SpriteVF_AxisLockUp.w));
    float3 _183 = View.View_WorldCameraOrigin - _161;
    float _184 = dot(_183, _183);
    float3 _187 = _183 * rsqrt(fast::max(_184, 9.9999999392252902907785028219223e-09));
    float3 _257;
    float3 _258;
    if (SpriteVF.SpriteVF_CameraFacingBlend[0] > 0.0)
    {
        float3 _203 = cross(_187, float3(0.0, 0.0, 1.0));
        float3 _207 = _203 * rsqrt(fast::max(dot(_203, _203), 9.9999999392252902907785028219223e-09));
        float3 _209 = float3(fast::clamp((_184 * SpriteVF.SpriteVF_CameraFacingBlend[1]) - SpriteVF.SpriteVF_CameraFacingBlend[2], 0.0, 1.0));
        _257 = normalize(mix(_174, _207, _209));
        _258 = normalize(mix(_182, cross(_187, _207), _209));
    }
    else
    {
        float3 _255;
        float3 _256;
        if (SpriteVF.SpriteVF_TangentSelector.y > 0.0)
        {
            float3 _219 = _161 - (Primitive.Primitive_LocalToWorld * float4(in.in_var_ATTRIBUTE1.xyz, 1.0)).xyz;
            float3 _223 = _219 * rsqrt(fast::max(dot(_219, _219), 9.9999999392252902907785028219223e-09));
            float3 _224 = cross(_187, _223);
            _255 = _224 * rsqrt(fast::max(dot(_224, _224), 9.9999999392252902907785028219223e-09));
            _256 = -_223;
        }
        else
        {
            float3 _253;
            float3 _254;
            if (SpriteVF.SpriteVF_TangentSelector.z > 0.0)
            {
                float3 _235 = cross(SpriteVF.SpriteVF_AxisLockRight.xyz, _187);
                _253 = SpriteVF.SpriteVF_AxisLockRight.xyz;
                _254 = -(_235 * rsqrt(fast::max(dot(_235, _235), 9.9999999392252902907785028219223e-09)));
            }
            else
            {
                float3 _251;
                float3 _252;
                if (SpriteVF.SpriteVF_TangentSelector.w > 0.0)
                {
                    float3 _245 = cross(_187, float3(0.0, 0.0, 1.0));
                    float3 _249 = _245 * rsqrt(fast::max(dot(_245, _245), 9.9999999392252902907785028219223e-09));
                    _251 = _249;
                    _252 = cross(_187, _249);
                }
                else
                {
                    _251 = _174;
                    _252 = _182;
                }
                _253 = _251;
                _254 = _252;
            }
            _255 = _253;
            _256 = _254;
        }
        _257 = _255;
        _258 = _256;
    }
    float _264 = in.in_var_ATTRIBUTE2.z * SpriteVF.SpriteVF_RotationScale;
    float _265 = _264 + SpriteVF.SpriteVF_RotationBias;
    float _266 = sin(_265);
    float _267 = cos(_265);
    float3 _268 = _258 * _266;
    float3 _269 = _257 * _267;
    float3 _270 = _268 + _269;
    float3 _271 = _258 * _267;
    float3 _272 = _257 * _266;
    float3 _273 = _271 - _272;
    float2 _277 = float2(int2(sign(in.in_var_ATTRIBUTE2.xy)));
    float2 _332;
    float2 _333;
    if (_Globals.NumCutoutVerticesPerFrame > 0u)
    {
        uint _287 = uint(mod(float((gl_VertexIndex - gl_BaseVertex)), float(_Globals.NumCutoutVerticesPerFrame)));
        float _296 = _277.x;
        float _297 = _277.y;
        uint _304;
        if ((_296 * _297) < 0.0)
        {
            _304 = (_Globals.NumCutoutVerticesPerFrame - 1u) - _287;
        }
        else
        {
            _304 = _287;
        }
        float4 _308 = CutoutGeometry.read(uint(((uint(mod(in.in_var_ATTRIBUTE2.w, SpriteVF.SpriteVF_SubImageSize.x * SpriteVF.SpriteVF_SubImageSize.y)) * _Globals.NumCutoutVerticesPerFrame) + _304)));
        float _311 = _308.x;
        float2 _314 = _97;
        _314.x = (_296 < 0.0) ? (1.0 - _311) : _311;
        float _316 = _308.y;
        float2 _319 = _314;
        _319.y = (_297 < 0.0) ? (1.0 - _316) : _316;
        _332 = _308.xy;
        _333 = _319;
    }
    else
    {
        float2 _325 = _97;
        _325.x = (_277.x < 0.0) ? (1.0 - in.in_var_ATTRIBUTE4.x) : in.in_var_ATTRIBUTE4.x;
        float2 _331 = _325;
        _331.y = (_277.y < 0.0) ? (1.0 - in.in_var_ATTRIBUTE4.y) : in.in_var_ATTRIBUTE4.y;
        _332 = _331;
        _333 = in.in_var_ATTRIBUTE4;
    }
    float3 _334 = _161 + View.View_PreViewTranslation;
    float _335 = _334.x;
    float _336 = _334.y;
    float _337 = _334.z;
    float4 _338 = float4(_335, _336, _337, 1.0);
    float2 _339 = abs(in.in_var_ATTRIBUTE2.xy);
    float _340 = _270.x;
    float _341 = _270.y;
    float _342 = _270.z;
    float4 _343 = float4(_340, _341, _342, 0.0);
    float _344 = _339.x;
    float _348 = _333.x + SpriteVF.SpriteVF_PivotOffset.x;
    float _349 = _344 * _348;
    float4 _350 = _343 * _349;
    float4 _351 = _338 + _350;
    float _352 = _273.x;
    float _353 = _273.y;
    float _354 = _273.z;
    float4 _355 = float4(_352, _353, _354, 0.0);
    float _356 = _339.y;
    float _360 = _333.y + SpriteVF.SpriteVF_PivotOffset.y;
    float _361 = _356 * _360;
    float4 _362 = _355 * _361;
    float4 _363 = _351 + _362;
    float _365 = fract(in.in_var_ATTRIBUTE2.w);
    float _366 = in.in_var_ATTRIBUTE2.w - _365;
    float _367 = _366 + 1.0;
    float2 _383 = (float2(mod(_366, SpriteVF.SpriteVF_SubImageSize.x), floor(_366 * SpriteVF.SpriteVF_SubImageSize.z)) + _332) * SpriteVF.SpriteVF_SubImageSize.zw;
    float2 _386 = (float2(mod(_367, SpriteVF.SpriteVF_SubImageSize.x), floor(_367 * SpriteVF.SpriteVF_SubImageSize.z)) + _332) * SpriteVF.SpriteVF_SubImageSize.zw;
    float3x3 _387 = _95;
    _387[0] = _270;
    float3x3 _388 = _387;
    _388[1] = _273;
    float3x3 _422;
    if (SpriteVF.SpriteVF_NormalsType < 0.5)
    {
        float3x3 _397 = _388;
        _397[2] = normalize(cross(_270, _273));
        _422 = _397;
    }
    else
    {
        float3x3 _421;
        if (SpriteVF.SpriteVF_NormalsType < 1.5)
        {
            float3x3 _407 = _388;
            _407[2] = normalize(_161 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz);
            _421 = _407;
        }
        else
        {
            float3x3 _420 = _388;
            _420[2] = normalize(_161 - (SpriteVF.SpriteVF_NormalsSphereCenter.xyz + (SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz * dot(SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz, _161 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz))));
            _421 = _420;
        }
        _422 = _421;
    }
    float _423 = _363.x;
    float _424 = _363.y;
    float _425 = _363.z;
    float4 _426 = float4(_423, _424, _425, 1.0);
    float4 _427 = float4(_426.x, _426.y, _426.z, _426.w);
    float4 _428 = View.View_TranslatedWorldToClip * _427;
    float4 _432 = float4(_422[0].x, _422[0].y, _422[0].z, float4(0.0).w);
    _432.w = _365;
    float3 _442 = _426.xyz;
    float3 _443 = _442 - View.View_TranslatedWorldCameraOrigin;
    float _459 = fast::min(View.View_WorldCameraOrigin.z, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.z);
    float _462 = _443.z + (View.View_WorldCameraOrigin.z - _459);
    float3 _463 = _443;
    _463.z = _462;
    float _464 = dot(_463, _463);
    float _465 = rsqrt(_464);
    float _466 = _464 * _465;
    float _473 = fast::max(fast::max(View.View_VolumetricFogMaxDistance * (length(_443) / dot(_443, View.View_ViewForward)), 0.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.w);
    float _507;
    float _508;
    float _509;
    float _510;
    if (_473 > 0.0)
    {
        float _477 = _473 * _465;
        float _478 = _477 * _462;
        float _479 = _459 + _478;
        _507 = (1.0 - _477) * _466;
        _508 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.z * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * (_479 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.w)));
        _509 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.x * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * (_479 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.y)));
        _510 = _462 - _478;
    }
    else
    {
        _507 = _466;
        _508 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.x;
        _509 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.x;
        _510 = _462;
    }
    float _514 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * _510);
    float _528 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * _510);
    float _550 = ((TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w > 0.0) && (_466 > TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w)) ? 1.0 : fast::max(fast::clamp(exp2(-(((_509 * ((abs(_514) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_514)) / _514) : (0.693147182464599609375 - (0.2402265071868896484375 * _514)))) + (_508 * ((abs(_528) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_528)) / _528) : (0.693147182464599609375 - (0.2402265071868896484375 * _528))))) * _507)), 0.0, 1.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.w);
    float4 _551 = float4(0.0, 0.0, 0.0, _550);
    float4 _628;
    if (View.View_SkyAtmosphereApplyCameraAerialPerspectiveVolume > 0.0)
    {
        float3 _565 = (_442 * 9.9999997473787516355514526367188e-06) - (View.View_TranslatedWorldCameraOrigin * 9.9999997473787516355514526367188e-06);
        float _571 = sqrt((fast::max(0.0, length(_565) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
        float _572 = _571 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
        float _579;
        if (_572 < 0.707106769084930419921875)
        {
            _579 = fast::clamp((_572 * _572) * 2.0, 0.0, 1.0);
        }
        else
        {
            _579 = 1.0;
        }
        float2 _607;
        if (View.View_RealTimeReflectionCapture != 0.0)
        {
            float3 _582 = normalize(_565);
            float _583 = _582.z;
            float _586 = sqrt(1.0 - (_583 * _583));
            float2 _589 = _97;
            _589.y = (_583 * 0.5) + 0.5;
            float _594 = acos(_582.x / _586);
            float2 _599 = _589;
            _599.x = (((_582.y / _586) < 0.0) ? (6.283185482025146484375 - _594) : _594) * 0.15915493667125701904296875;
            _607 = (_599 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
        }
        else
        {
            _607 = ((_428.xy / _428.ww) * float2(0.5, -0.5)) + float2(0.5);
        }
        float4 _612 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_607, _571), level(0.0));
        float3 _624 = _551.xyz + (((_612.xyz * _579).xyz * View.View_OneOverPreExposure).xyz * _550);
        float4 _627 = float4(_624.x, _624.y, _624.z, _96.w);
        _627.w = _550 * (1.0 - (_579 * (1.0 - _612.w)));
        _628 = _627;
    }
    else
    {
        _628 = _551;
    }
    out.out_var_TEXCOORD10 = _432;
    out.out_var_TEXCOORD11 = float4(_422[2], float(int(sign(determinant(_422)))));
    out.out_var_TEXCOORD2 = in.in_var_ATTRIBUTE3;
    out.out_var_PARTICLE_SUBUVS = float4(_383.x, _383.y, _386.x, _386.y);
    out.out_var_TEXCOORD7 = _628;
    out.gl_Position = _428;
    return out;
}

