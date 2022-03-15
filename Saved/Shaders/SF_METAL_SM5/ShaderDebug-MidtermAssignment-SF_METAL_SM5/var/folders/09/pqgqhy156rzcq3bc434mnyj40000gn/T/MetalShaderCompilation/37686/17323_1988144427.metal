

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

constant float3x3 _99 = {};
constant float4 _100 = {};
constant float2 _101 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10 [[user(locn0)]];
    float4 out_var_TEXCOORD11 [[user(locn1)]];
    float4 out_var_TEXCOORD1 [[user(locn2)]];
    float4 out_var_TEXCOORD2 [[user(locn3)]];
    float4 out_var_TEXCOORD3_0 [[user(locn4)]];
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
    float4 in_var_ATTRIBUTE5 [[attribute(5)]];
};

// Implementation of the GLSL mod() function, which is slightly different than Metal fmod()
template<typename Tx, typename Ty>
inline Tx mod(Tx x, Ty y)
{
    return x - y * floor(x / y);
}

vertex Main_out Main_000043ab_7680ad2b(Main_in in [[stage_in]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_SpriteVF& SpriteVF [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> CutoutGeometry [[texture(0)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(1)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD3 = {};
    float4 _157 = float4(in.in_var_ATTRIBUTE0.xyz, 1.0);
    float4 _160 = Primitive.Primitive_LocalToWorld * _157;
    float3 _166 = _160.xyz;
    float3 _170 = float3(SpriteVF.SpriteVF_RemoveHMDRoll);
    float3 _179 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _170), SpriteVF.SpriteVF_AxisLockRight.xyz, float3(SpriteVF.SpriteVF_AxisLockRight.w));
    float3 _187 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _170), SpriteVF.SpriteVF_AxisLockUp.xyz, float3(SpriteVF.SpriteVF_AxisLockUp.w));
    float3 _188 = View.View_WorldCameraOrigin - _166;
    float _189 = dot(_188, _188);
    float3 _192 = _188 * rsqrt(fast::max(_189, 9.9999999392252902907785028219223e-09));
    float3 _262;
    float3 _263;
    if (SpriteVF.SpriteVF_CameraFacingBlend[0] > 0.0)
    {
        float3 _251 = cross(_192, float3(0.0, 0.0, 1.0));
        float3 _255 = _251 * rsqrt(fast::max(dot(_251, _251), 9.9999999392252902907785028219223e-09));
        float3 _257 = float3(fast::clamp((_189 * SpriteVF.SpriteVF_CameraFacingBlend[1]) - SpriteVF.SpriteVF_CameraFacingBlend[2], 0.0, 1.0));
        _262 = normalize(mix(_179, _255, _257));
        _263 = normalize(mix(_187, cross(_192, _255), _257));
    }
    else
    {
        float3 _242;
        float3 _243;
        if (SpriteVF.SpriteVF_TangentSelector.y > 0.0)
        {
            float3 _231 = _166 - (Primitive.Primitive_LocalToWorld * float4(in.in_var_ATTRIBUTE1.xyz, 1.0)).xyz;
            float3 _235 = _231 * rsqrt(fast::max(dot(_231, _231), 9.9999999392252902907785028219223e-09));
            float3 _236 = cross(_192, _235);
            _242 = _236 * rsqrt(fast::max(dot(_236, _236), 9.9999999392252902907785028219223e-09));
            _243 = -_235;
        }
        else
        {
            float3 _229;
            float3 _230;
            if (SpriteVF.SpriteVF_TangentSelector.z > 0.0)
            {
                float3 _223 = cross(SpriteVF.SpriteVF_AxisLockRight.xyz, _192);
                _229 = SpriteVF.SpriteVF_AxisLockRight.xyz;
                _230 = -(_223 * rsqrt(fast::max(dot(_223, _223), 9.9999999392252902907785028219223e-09)));
            }
            else
            {
                float3 _221;
                float3 _222;
                if (SpriteVF.SpriteVF_TangentSelector.w > 0.0)
                {
                    float3 _215 = cross(_192, float3(0.0, 0.0, 1.0));
                    float3 _219 = _215 * rsqrt(fast::max(dot(_215, _215), 9.9999999392252902907785028219223e-09));
                    _221 = _219;
                    _222 = cross(_192, _219);
                }
                else
                {
                    _221 = _179;
                    _222 = _187;
                }
                _229 = _221;
                _230 = _222;
            }
            _242 = _229;
            _243 = _230;
        }
        _262 = _242;
        _263 = _243;
    }
    float _269 = in.in_var_ATTRIBUTE2.z * SpriteVF.SpriteVF_RotationScale;
    float _270 = _269 + SpriteVF.SpriteVF_RotationBias;
    float _271 = sin(_270);
    float _272 = cos(_270);
    float3 _273 = _263 * _271;
    float3 _274 = _262 * _272;
    float3 _275 = _273 + _274;
    float3 _276 = _263 * _272;
    float3 _277 = _262 * _271;
    float3 _278 = _276 - _277;
    float2 _282 = float2(int2(sign(in.in_var_ATTRIBUTE2.xy)));
    float2 _337;
    float2 _338;
    if (_Globals.NumCutoutVerticesPerFrame > 0u)
    {
        uint _304 = uint(mod(float((gl_VertexIndex - gl_BaseVertex)), float(_Globals.NumCutoutVerticesPerFrame)));
        float _313 = _282.x;
        float _314 = _282.y;
        uint _321;
        if ((_313 * _314) < 0.0)
        {
            _321 = (_Globals.NumCutoutVerticesPerFrame - 1u) - _304;
        }
        else
        {
            _321 = _304;
        }
        float4 _325 = CutoutGeometry.read(uint(((uint(mod(in.in_var_ATTRIBUTE2.w, SpriteVF.SpriteVF_SubImageSize.x * SpriteVF.SpriteVF_SubImageSize.y)) * _Globals.NumCutoutVerticesPerFrame) + _321)));
        float _328 = _325.x;
        float2 _331 = _101;
        _331.x = (_313 < 0.0) ? (1.0 - _328) : _328;
        float _333 = _325.y;
        float2 _336 = _331;
        _336.y = (_314 < 0.0) ? (1.0 - _333) : _333;
        _337 = _325.xy;
        _338 = _336;
    }
    else
    {
        float2 _294 = _101;
        _294.x = (_282.x < 0.0) ? (1.0 - in.in_var_ATTRIBUTE4.x) : in.in_var_ATTRIBUTE4.x;
        float2 _300 = _294;
        _300.y = (_282.y < 0.0) ? (1.0 - in.in_var_ATTRIBUTE4.y) : in.in_var_ATTRIBUTE4.y;
        _337 = _300;
        _338 = in.in_var_ATTRIBUTE4;
    }
    float3 _339 = _166 + View.View_PreViewTranslation;
    float _340 = _339.x;
    float _341 = _339.y;
    float _342 = _339.z;
    float4 _343 = float4(_340, _341, _342, 1.0);
    float2 _344 = abs(in.in_var_ATTRIBUTE2.xy);
    float _345 = _275.x;
    float _346 = _275.y;
    float _347 = _275.z;
    float4 _348 = float4(_345, _346, _347, 0.0);
    float _349 = _344.x;
    float _353 = _338.x + SpriteVF.SpriteVF_PivotOffset.x;
    float _354 = _349 * _353;
    float4 _355 = _348 * _354;
    float4 _356 = _343 + _355;
    float _357 = _278.x;
    float _358 = _278.y;
    float _359 = _278.z;
    float4 _360 = float4(_357, _358, _359, 0.0);
    float _361 = _344.y;
    float _365 = _338.y + SpriteVF.SpriteVF_PivotOffset.y;
    float _366 = _361 * _365;
    float4 _367 = _360 * _366;
    float4 _368 = _356 + _367;
    float _370 = fract(in.in_var_ATTRIBUTE2.w);
    float _371 = in.in_var_ATTRIBUTE2.w - _370;
    float2 _384 = (float2(mod(_371, SpriteVF.SpriteVF_SubImageSize.x), floor(_371 * SpriteVF.SpriteVF_SubImageSize.z)) + _337) * SpriteVF.SpriteVF_SubImageSize.zw;
    float3x3 _385 = _99;
    _385[0] = _275;
    float3x3 _386 = _385;
    _386[1] = _278;
    float3x3 _420;
    if (SpriteVF.SpriteVF_NormalsType < 0.5)
    {
        float3x3 _419 = _386;
        _419[2] = normalize(cross(_275, _278));
        _420 = _419;
    }
    else
    {
        float3x3 _416;
        if (SpriteVF.SpriteVF_NormalsType < 1.5)
        {
            float3x3 _415 = _386;
            _415[2] = normalize(_166 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz);
            _416 = _415;
        }
        else
        {
            float3x3 _409 = _386;
            _409[2] = normalize(_166 - (SpriteVF.SpriteVF_NormalsSphereCenter.xyz + (SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz * dot(SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz, _166 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz))));
            _416 = _409;
        }
        _420 = _416;
    }
    float _421 = _368.x;
    float _422 = _368.y;
    float _423 = _368.z;
    float4 _424 = float4(_421, _422, _423, 1.0);
    float4 _425 = float4(_424.x, _424.y, _424.z, _424.w);
    float4 _426 = View.View_TranslatedWorldToClip * _425;
    float4 _430 = float4(_420[0].x, _420[0].y, _420[0].z, float4(0.0).w);
    _430.w = _370;
    spvUnsafeArray<float4, 1> _440 = { float4(_384.x, _384.y, float4(0.0).z, float4(0.0).w) };
    float3 _441 = _424.xyz;
    float3 _442 = _441 - View.View_TranslatedWorldCameraOrigin;
    float _458 = fast::min(View.View_WorldCameraOrigin.z, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.z);
    float _461 = _442.z + (View.View_WorldCameraOrigin.z - _458);
    float3 _462 = _442;
    _462.z = _461;
    float _463 = dot(_462, _462);
    float _464 = rsqrt(_463);
    float _465 = _463 * _464;
    float _472 = fast::max(fast::max(View.View_VolumetricFogMaxDistance * (length(_442) / dot(_442, View.View_ViewForward)), 0.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.w);
    float _506;
    float _507;
    float _508;
    float _509;
    if (_472 > 0.0)
    {
        float _476 = _472 * _464;
        float _477 = _476 * _461;
        float _478 = _458 + _477;
        _506 = (1.0 - _476) * _465;
        _507 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.z * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * (_478 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.w)));
        _508 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.x * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * (_478 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.y)));
        _509 = _461 - _477;
    }
    else
    {
        _506 = _465;
        _507 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.x;
        _508 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.x;
        _509 = _461;
    }
    float _513 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * _509);
    float _527 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * _509);
    float _549 = ((TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w > 0.0) && (_465 > TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w)) ? 1.0 : fast::max(fast::clamp(exp2(-(((_508 * ((abs(_513) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_513)) / _513) : (0.693147182464599609375 - (0.2402265071868896484375 * _513)))) + (_507 * ((abs(_527) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_527)) / _527) : (0.693147182464599609375 - (0.2402265071868896484375 * _527))))) * _506)), 0.0, 1.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.w);
    float4 _550 = float4(0.0, 0.0, 0.0, _549);
    float4 _627;
    if (View.View_SkyAtmosphereApplyCameraAerialPerspectiveVolume > 0.0)
    {
        float3 _564 = (_441 * 9.9999997473787516355514526367188e-06) - (View.View_TranslatedWorldCameraOrigin * 9.9999997473787516355514526367188e-06);
        float _570 = sqrt((fast::max(0.0, length(_564) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
        float _571 = _570 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
        float _578;
        if (_571 < 0.707106769084930419921875)
        {
            _578 = fast::clamp((_571 * _571) * 2.0, 0.0, 1.0);
        }
        else
        {
            _578 = 1.0;
        }
        float2 _606;
        if (View.View_RealTimeReflectionCapture != 0.0)
        {
            float3 _581 = normalize(_564);
            float _582 = _581.z;
            float _585 = sqrt(1.0 - (_582 * _582));
            float2 _588 = _101;
            _588.y = (_582 * 0.5) + 0.5;
            float _593 = acos(_581.x / _585);
            float2 _598 = _588;
            _598.x = (((_581.y / _585) < 0.0) ? (6.283185482025146484375 - _593) : _593) * 0.15915493667125701904296875;
            _606 = (_598 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
        }
        else
        {
            _606 = ((_426.xy / _426.ww) * float2(0.5, -0.5)) + float2(0.5);
        }
        float4 _611 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_606, _570), level(0.0));
        float3 _623 = _550.xyz + (((_611.xyz * _578).xyz * View.View_OneOverPreExposure).xyz * _549);
        float4 _626 = float4(_623.x, _623.y, _623.z, _100.w);
        _626.w = _549 * (1.0 - (_578 * (1.0 - _611.w)));
        _627 = _626;
    }
    else
    {
        _627 = _550;
    }
    out.out_var_TEXCOORD10 = _430;
    out.out_var_TEXCOORD11 = float4(_420[2], float(int(sign(determinant(_420)))));
    out.out_var_TEXCOORD1 = in.in_var_ATTRIBUTE5;
    out.out_var_TEXCOORD2 = in.in_var_ATTRIBUTE3;
    out_var_TEXCOORD3 = _440;
    out.out_var_TEXCOORD7 = _627;
    out.gl_Position = _426;
    out.out_var_TEXCOORD3_0 = out_var_TEXCOORD3[0];
    return out;
}

