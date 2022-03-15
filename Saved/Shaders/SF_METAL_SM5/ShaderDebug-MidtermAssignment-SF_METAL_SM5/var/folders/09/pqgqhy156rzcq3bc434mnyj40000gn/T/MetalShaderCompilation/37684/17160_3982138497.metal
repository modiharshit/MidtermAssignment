

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

constant float3x3 _97 = {};
constant float4 _98 = {};
constant float2 _99 = {};

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

vertex Main_out Main_00004308_ed5a9c81(Main_in in [[stage_in]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_SpriteVF& SpriteVF [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> CutoutGeometry [[texture(0)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(1)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD3 = {};
    float4 _154 = float4(in.in_var_ATTRIBUTE0.xyz, 1.0);
    float4 _157 = Primitive.Primitive_LocalToWorld * _154;
    float3 _163 = _157.xyz;
    float3 _167 = float3(SpriteVF.SpriteVF_RemoveHMDRoll);
    float3 _176 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _167), SpriteVF.SpriteVF_AxisLockRight.xyz, float3(SpriteVF.SpriteVF_AxisLockRight.w));
    float3 _184 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _167), SpriteVF.SpriteVF_AxisLockUp.xyz, float3(SpriteVF.SpriteVF_AxisLockUp.w));
    float3 _185 = View.View_WorldCameraOrigin - _163;
    float _186 = dot(_185, _185);
    float3 _189 = _185 * rsqrt(fast::max(_186, 9.9999999392252902907785028219223e-09));
    float3 _259;
    float3 _260;
    if (SpriteVF.SpriteVF_CameraFacingBlend[0] > 0.0)
    {
        float3 _248 = cross(_189, float3(0.0, 0.0, 1.0));
        float3 _252 = _248 * rsqrt(fast::max(dot(_248, _248), 9.9999999392252902907785028219223e-09));
        float3 _254 = float3(fast::clamp((_186 * SpriteVF.SpriteVF_CameraFacingBlend[1]) - SpriteVF.SpriteVF_CameraFacingBlend[2], 0.0, 1.0));
        _259 = normalize(mix(_176, _252, _254));
        _260 = normalize(mix(_184, cross(_189, _252), _254));
    }
    else
    {
        float3 _239;
        float3 _240;
        if (SpriteVF.SpriteVF_TangentSelector.y > 0.0)
        {
            float3 _228 = _163 - (Primitive.Primitive_LocalToWorld * float4(in.in_var_ATTRIBUTE1.xyz, 1.0)).xyz;
            float3 _232 = _228 * rsqrt(fast::max(dot(_228, _228), 9.9999999392252902907785028219223e-09));
            float3 _233 = cross(_189, _232);
            _239 = _233 * rsqrt(fast::max(dot(_233, _233), 9.9999999392252902907785028219223e-09));
            _240 = -_232;
        }
        else
        {
            float3 _226;
            float3 _227;
            if (SpriteVF.SpriteVF_TangentSelector.z > 0.0)
            {
                float3 _220 = cross(SpriteVF.SpriteVF_AxisLockRight.xyz, _189);
                _226 = SpriteVF.SpriteVF_AxisLockRight.xyz;
                _227 = -(_220 * rsqrt(fast::max(dot(_220, _220), 9.9999999392252902907785028219223e-09)));
            }
            else
            {
                float3 _218;
                float3 _219;
                if (SpriteVF.SpriteVF_TangentSelector.w > 0.0)
                {
                    float3 _212 = cross(_189, float3(0.0, 0.0, 1.0));
                    float3 _216 = _212 * rsqrt(fast::max(dot(_212, _212), 9.9999999392252902907785028219223e-09));
                    _218 = _216;
                    _219 = cross(_189, _216);
                }
                else
                {
                    _218 = _176;
                    _219 = _184;
                }
                _226 = _218;
                _227 = _219;
            }
            _239 = _226;
            _240 = _227;
        }
        _259 = _239;
        _260 = _240;
    }
    float _266 = in.in_var_ATTRIBUTE2.z * SpriteVF.SpriteVF_RotationScale;
    float _267 = _266 + SpriteVF.SpriteVF_RotationBias;
    float _268 = sin(_267);
    float _269 = cos(_267);
    float3 _270 = _260 * _268;
    float3 _271 = _259 * _269;
    float3 _272 = _270 + _271;
    float3 _273 = _260 * _269;
    float3 _274 = _259 * _268;
    float3 _275 = _273 - _274;
    float2 _279 = float2(int2(sign(in.in_var_ATTRIBUTE2.xy)));
    float2 _334;
    float2 _335;
    if (_Globals.NumCutoutVerticesPerFrame > 0u)
    {
        uint _301 = uint(mod(float((gl_VertexIndex - gl_BaseVertex)), float(_Globals.NumCutoutVerticesPerFrame)));
        float _310 = _279.x;
        float _311 = _279.y;
        uint _318;
        if ((_310 * _311) < 0.0)
        {
            _318 = (_Globals.NumCutoutVerticesPerFrame - 1u) - _301;
        }
        else
        {
            _318 = _301;
        }
        float4 _322 = CutoutGeometry.read(uint(((uint(mod(in.in_var_ATTRIBUTE2.w, SpriteVF.SpriteVF_SubImageSize.x * SpriteVF.SpriteVF_SubImageSize.y)) * _Globals.NumCutoutVerticesPerFrame) + _318)));
        float _325 = _322.x;
        float2 _328 = _99;
        _328.x = (_310 < 0.0) ? (1.0 - _325) : _325;
        float _330 = _322.y;
        float2 _333 = _328;
        _333.y = (_311 < 0.0) ? (1.0 - _330) : _330;
        _334 = _322.xy;
        _335 = _333;
    }
    else
    {
        float2 _291 = _99;
        _291.x = (_279.x < 0.0) ? (1.0 - in.in_var_ATTRIBUTE4.x) : in.in_var_ATTRIBUTE4.x;
        float2 _297 = _291;
        _297.y = (_279.y < 0.0) ? (1.0 - in.in_var_ATTRIBUTE4.y) : in.in_var_ATTRIBUTE4.y;
        _334 = _297;
        _335 = in.in_var_ATTRIBUTE4;
    }
    float3 _336 = _163 + View.View_PreViewTranslation;
    float _337 = _336.x;
    float _338 = _336.y;
    float _339 = _336.z;
    float4 _340 = float4(_337, _338, _339, 1.0);
    float2 _341 = abs(in.in_var_ATTRIBUTE2.xy);
    float _342 = _272.x;
    float _343 = _272.y;
    float _344 = _272.z;
    float4 _345 = float4(_342, _343, _344, 0.0);
    float _346 = _341.x;
    float _350 = _335.x + SpriteVF.SpriteVF_PivotOffset.x;
    float _351 = _346 * _350;
    float4 _352 = _345 * _351;
    float4 _353 = _340 + _352;
    float _354 = _275.x;
    float _355 = _275.y;
    float _356 = _275.z;
    float4 _357 = float4(_354, _355, _356, 0.0);
    float _358 = _341.y;
    float _362 = _335.y + SpriteVF.SpriteVF_PivotOffset.y;
    float _363 = _358 * _362;
    float4 _364 = _357 * _363;
    float4 _365 = _353 + _364;
    float _367 = fract(in.in_var_ATTRIBUTE2.w);
    float _368 = in.in_var_ATTRIBUTE2.w - _367;
    float2 _381 = (float2(mod(_368, SpriteVF.SpriteVF_SubImageSize.x), floor(_368 * SpriteVF.SpriteVF_SubImageSize.z)) + _334) * SpriteVF.SpriteVF_SubImageSize.zw;
    float3x3 _382 = _97;
    _382[0] = _272;
    float3x3 _383 = _382;
    _383[1] = _275;
    float3x3 _417;
    if (SpriteVF.SpriteVF_NormalsType < 0.5)
    {
        float3x3 _416 = _383;
        _416[2] = normalize(cross(_272, _275));
        _417 = _416;
    }
    else
    {
        float3x3 _413;
        if (SpriteVF.SpriteVF_NormalsType < 1.5)
        {
            float3x3 _412 = _383;
            _412[2] = normalize(_163 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz);
            _413 = _412;
        }
        else
        {
            float3x3 _406 = _383;
            _406[2] = normalize(_163 - (SpriteVF.SpriteVF_NormalsSphereCenter.xyz + (SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz * dot(SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz, _163 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz))));
            _413 = _406;
        }
        _417 = _413;
    }
    float _418 = _365.x;
    float _419 = _365.y;
    float _420 = _365.z;
    float4 _421 = float4(_418, _419, _420, 1.0);
    float4 _422 = float4(_421.x, _421.y, _421.z, _421.w);
    float4 _423 = View.View_TranslatedWorldToClip * _422;
    float4 _427 = float4(_417[0].x, _417[0].y, _417[0].z, float4(0.0).w);
    _427.w = _367;
    spvUnsafeArray<float4, 1> _437 = { float4(_381.x, _381.y, float4(0.0).z, float4(0.0).w) };
    float3 _438 = _421.xyz;
    float3 _439 = _438 - View.View_TranslatedWorldCameraOrigin;
    float _455 = fast::min(View.View_WorldCameraOrigin.z, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.z);
    float _458 = _439.z + (View.View_WorldCameraOrigin.z - _455);
    float3 _459 = _439;
    _459.z = _458;
    float _460 = dot(_459, _459);
    float _461 = rsqrt(_460);
    float _462 = _460 * _461;
    float _469 = fast::max(fast::max(View.View_VolumetricFogMaxDistance * (length(_439) / dot(_439, View.View_ViewForward)), 0.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.w);
    float _503;
    float _504;
    float _505;
    float _506;
    if (_469 > 0.0)
    {
        float _473 = _469 * _461;
        float _474 = _473 * _458;
        float _475 = _455 + _474;
        _503 = (1.0 - _473) * _462;
        _504 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.z * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * (_475 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.w)));
        _505 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.x * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * (_475 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.y)));
        _506 = _458 - _474;
    }
    else
    {
        _503 = _462;
        _504 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.x;
        _505 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.x;
        _506 = _458;
    }
    float _510 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * _506);
    float _524 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * _506);
    float _546 = ((TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w > 0.0) && (_462 > TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w)) ? 1.0 : fast::max(fast::clamp(exp2(-(((_505 * ((abs(_510) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_510)) / _510) : (0.693147182464599609375 - (0.2402265071868896484375 * _510)))) + (_504 * ((abs(_524) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_524)) / _524) : (0.693147182464599609375 - (0.2402265071868896484375 * _524))))) * _503)), 0.0, 1.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.w);
    float4 _547 = float4(0.0, 0.0, 0.0, _546);
    float4 _624;
    if (View.View_SkyAtmosphereApplyCameraAerialPerspectiveVolume > 0.0)
    {
        float3 _561 = (_438 * 9.9999997473787516355514526367188e-06) - (View.View_TranslatedWorldCameraOrigin * 9.9999997473787516355514526367188e-06);
        float _567 = sqrt((fast::max(0.0, length(_561) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
        float _568 = _567 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
        float _575;
        if (_568 < 0.707106769084930419921875)
        {
            _575 = fast::clamp((_568 * _568) * 2.0, 0.0, 1.0);
        }
        else
        {
            _575 = 1.0;
        }
        float2 _603;
        if (View.View_RealTimeReflectionCapture != 0.0)
        {
            float3 _578 = normalize(_561);
            float _579 = _578.z;
            float _582 = sqrt(1.0 - (_579 * _579));
            float2 _585 = _99;
            _585.y = (_579 * 0.5) + 0.5;
            float _590 = acos(_578.x / _582);
            float2 _595 = _585;
            _595.x = (((_578.y / _582) < 0.0) ? (6.283185482025146484375 - _590) : _590) * 0.15915493667125701904296875;
            _603 = (_595 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
        }
        else
        {
            _603 = ((_423.xy / _423.ww) * float2(0.5, -0.5)) + float2(0.5);
        }
        float4 _608 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_603, _567), level(0.0));
        float3 _620 = _547.xyz + (((_608.xyz * _575).xyz * View.View_OneOverPreExposure).xyz * _546);
        float4 _623 = float4(_620.x, _620.y, _620.z, _98.w);
        _623.w = _546 * (1.0 - (_575 * (1.0 - _608.w)));
        _624 = _623;
    }
    else
    {
        _624 = _547;
    }
    out.out_var_TEXCOORD10 = _427;
    out.out_var_TEXCOORD11 = float4(_417[2], float(int(sign(determinant(_417)))));
    out.out_var_TEXCOORD2 = in.in_var_ATTRIBUTE3;
    out_var_TEXCOORD3 = _437;
    out.out_var_TEXCOORD7 = _624;
    out.gl_Position = _423;
    out.out_var_TEXCOORD3_0 = out_var_TEXCOORD3[0];
    return out;
}

