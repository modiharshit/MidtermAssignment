

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

constant float3x3 _105 = {};
constant float4 _106 = {};
constant float2 _107 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10 [[user(locn0)]];
    float4 out_var_TEXCOORD11 [[user(locn1)]];
    float4 out_var_TEXCOORD1 [[user(locn2)]];
    float4 out_var_TEXCOORD3_0 [[user(locn3)]];
    float4 out_var_TEXCOORD7 [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float4 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    float2 in_var_ATTRIBUTE4 [[attribute(4)]];
    float4 in_var_ATTRIBUTE5 [[attribute(5)]];
};

// Implementation of the GLSL mod() function, which is slightly different than Metal fmod()
template<typename Tx, typename Ty>
inline Tx mod(Tx x, Ty y)
{
    return x - y * floor(x / y);
}

vertex Main_out Main_00004df9_2fdcf611(Main_in in [[stage_in]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_SpriteVF& SpriteVF [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> CutoutGeometry [[texture(0)]], texturecube<float> TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap [[texture(1)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(2)]], sampler TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler [[sampler(0)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(1)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD3 = {};
    float4 _163 = float4(in.in_var_ATTRIBUTE0.xyz, 1.0);
    float4 _166 = Primitive.Primitive_LocalToWorld * _163;
    float3 _172 = _166.xyz;
    float3 _176 = float3(SpriteVF.SpriteVF_RemoveHMDRoll);
    float3 _185 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _176), SpriteVF.SpriteVF_AxisLockRight.xyz, float3(SpriteVF.SpriteVF_AxisLockRight.w));
    float3 _193 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _176), SpriteVF.SpriteVF_AxisLockUp.xyz, float3(SpriteVF.SpriteVF_AxisLockUp.w));
    float3 _194 = View.View_WorldCameraOrigin - _172;
    float _195 = dot(_194, _194);
    float3 _198 = _194 * rsqrt(fast::max(_195, 9.9999999392252902907785028219223e-09));
    float3 _268;
    float3 _269;
    if (SpriteVF.SpriteVF_CameraFacingBlend[0] > 0.0)
    {
        float3 _257 = cross(_198, float3(0.0, 0.0, 1.0));
        float3 _261 = _257 * rsqrt(fast::max(dot(_257, _257), 9.9999999392252902907785028219223e-09));
        float3 _263 = float3(fast::clamp((_195 * SpriteVF.SpriteVF_CameraFacingBlend[1]) - SpriteVF.SpriteVF_CameraFacingBlend[2], 0.0, 1.0));
        _268 = normalize(mix(_185, _261, _263));
        _269 = normalize(mix(_193, cross(_198, _261), _263));
    }
    else
    {
        float3 _248;
        float3 _249;
        if (SpriteVF.SpriteVF_TangentSelector.y > 0.0)
        {
            float3 _237 = _172 - (Primitive.Primitive_LocalToWorld * float4(in.in_var_ATTRIBUTE1.xyz, 1.0)).xyz;
            float3 _241 = _237 * rsqrt(fast::max(dot(_237, _237), 9.9999999392252902907785028219223e-09));
            float3 _242 = cross(_198, _241);
            _248 = _242 * rsqrt(fast::max(dot(_242, _242), 9.9999999392252902907785028219223e-09));
            _249 = -_241;
        }
        else
        {
            float3 _235;
            float3 _236;
            if (SpriteVF.SpriteVF_TangentSelector.z > 0.0)
            {
                float3 _229 = cross(SpriteVF.SpriteVF_AxisLockRight.xyz, _198);
                _235 = SpriteVF.SpriteVF_AxisLockRight.xyz;
                _236 = -(_229 * rsqrt(fast::max(dot(_229, _229), 9.9999999392252902907785028219223e-09)));
            }
            else
            {
                float3 _227;
                float3 _228;
                if (SpriteVF.SpriteVF_TangentSelector.w > 0.0)
                {
                    float3 _221 = cross(_198, float3(0.0, 0.0, 1.0));
                    float3 _225 = _221 * rsqrt(fast::max(dot(_221, _221), 9.9999999392252902907785028219223e-09));
                    _227 = _225;
                    _228 = cross(_198, _225);
                }
                else
                {
                    _227 = _185;
                    _228 = _193;
                }
                _235 = _227;
                _236 = _228;
            }
            _248 = _235;
            _249 = _236;
        }
        _268 = _248;
        _269 = _249;
    }
    float _275 = in.in_var_ATTRIBUTE2.z * SpriteVF.SpriteVF_RotationScale;
    float _276 = _275 + SpriteVF.SpriteVF_RotationBias;
    float _277 = sin(_276);
    float _278 = cos(_276);
    float3 _279 = _269 * _277;
    float3 _280 = _268 * _278;
    float3 _281 = _279 + _280;
    float3 _282 = _269 * _278;
    float3 _283 = _268 * _277;
    float3 _284 = _282 - _283;
    float2 _288 = float2(int2(sign(in.in_var_ATTRIBUTE2.xy)));
    float2 _343;
    float2 _344;
    if (_Globals.NumCutoutVerticesPerFrame > 0u)
    {
        uint _310 = uint(mod(float((gl_VertexIndex - gl_BaseVertex)), float(_Globals.NumCutoutVerticesPerFrame)));
        float _319 = _288.x;
        float _320 = _288.y;
        uint _327;
        if ((_319 * _320) < 0.0)
        {
            _327 = (_Globals.NumCutoutVerticesPerFrame - 1u) - _310;
        }
        else
        {
            _327 = _310;
        }
        float4 _331 = CutoutGeometry.read(uint(((uint(mod(in.in_var_ATTRIBUTE2.w, SpriteVF.SpriteVF_SubImageSize.x * SpriteVF.SpriteVF_SubImageSize.y)) * _Globals.NumCutoutVerticesPerFrame) + _327)));
        float _334 = _331.x;
        float2 _337 = _107;
        _337.x = (_319 < 0.0) ? (1.0 - _334) : _334;
        float _339 = _331.y;
        float2 _342 = _337;
        _342.y = (_320 < 0.0) ? (1.0 - _339) : _339;
        _343 = _331.xy;
        _344 = _342;
    }
    else
    {
        float2 _300 = _107;
        _300.x = (_288.x < 0.0) ? (1.0 - in.in_var_ATTRIBUTE4.x) : in.in_var_ATTRIBUTE4.x;
        float2 _306 = _300;
        _306.y = (_288.y < 0.0) ? (1.0 - in.in_var_ATTRIBUTE4.y) : in.in_var_ATTRIBUTE4.y;
        _343 = _306;
        _344 = in.in_var_ATTRIBUTE4;
    }
    float3 _345 = _172 + View.View_PreViewTranslation;
    float _346 = _345.x;
    float _347 = _345.y;
    float _348 = _345.z;
    float4 _349 = float4(_346, _347, _348, 1.0);
    float2 _350 = abs(in.in_var_ATTRIBUTE2.xy);
    float _351 = _281.x;
    float _352 = _281.y;
    float _353 = _281.z;
    float4 _354 = float4(_351, _352, _353, 0.0);
    float _355 = _350.x;
    float _359 = _344.x + SpriteVF.SpriteVF_PivotOffset.x;
    float _360 = _355 * _359;
    float4 _361 = _354 * _360;
    float4 _362 = _349 + _361;
    float _363 = _284.x;
    float _364 = _284.y;
    float _365 = _284.z;
    float4 _366 = float4(_363, _364, _365, 0.0);
    float _367 = _350.y;
    float _371 = _344.y + SpriteVF.SpriteVF_PivotOffset.y;
    float _372 = _367 * _371;
    float4 _373 = _366 * _372;
    float4 _374 = _362 + _373;
    float _376 = fract(in.in_var_ATTRIBUTE2.w);
    float _377 = in.in_var_ATTRIBUTE2.w - _376;
    float2 _390 = (float2(mod(_377, SpriteVF.SpriteVF_SubImageSize.x), floor(_377 * SpriteVF.SpriteVF_SubImageSize.z)) + _343) * SpriteVF.SpriteVF_SubImageSize.zw;
    float3x3 _391 = _105;
    _391[0] = _281;
    float3x3 _392 = _391;
    _392[1] = _284;
    float3x3 _426;
    if (SpriteVF.SpriteVF_NormalsType < 0.5)
    {
        float3x3 _425 = _392;
        _425[2] = normalize(cross(_281, _284));
        _426 = _425;
    }
    else
    {
        float3x3 _422;
        if (SpriteVF.SpriteVF_NormalsType < 1.5)
        {
            float3x3 _421 = _392;
            _421[2] = normalize(_172 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz);
            _422 = _421;
        }
        else
        {
            float3x3 _415 = _392;
            _415[2] = normalize(_172 - (SpriteVF.SpriteVF_NormalsSphereCenter.xyz + (SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz * dot(SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz, _172 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz))));
            _422 = _415;
        }
        _426 = _422;
    }
    float _427 = _374.x;
    float _428 = _374.y;
    float _429 = _374.z;
    float4 _430 = float4(_427, _428, _429, 1.0);
    float4 _431 = float4(_430.x, _430.y, _430.z, _430.w);
    float4 _432 = View.View_TranslatedWorldToClip * _431;
    float4 _436 = float4(_426[0].x, _426[0].y, _426[0].z, float4(0.0).w);
    _436.w = _376;
    spvUnsafeArray<float4, 1> _446 = { float4(_390.x, _390.y, float4(0.0).z, float4(0.0).w) };
    float3 _447 = _430.xyz;
    float3 _448 = _447 - View.View_TranslatedWorldCameraOrigin;
    float _465 = fast::min(View.View_WorldCameraOrigin.z, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.z);
    float _468 = _448.z + (View.View_WorldCameraOrigin.z - _465);
    float3 _469 = _448;
    _469.z = _468;
    float _470 = dot(_469, _469);
    float _471 = rsqrt(_470);
    float _472 = _470 * _471;
    float _480 = fast::max(fast::max(View.View_VolumetricFogMaxDistance * (length(_448) / dot(_448, View.View_ViewForward)), 0.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.w);
    float _514;
    float _515;
    float _516;
    float _517;
    if (_480 > 0.0)
    {
        float _484 = _480 * _471;
        float _485 = _484 * _468;
        float _486 = _465 + _485;
        _514 = (1.0 - _484) * _472;
        _515 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.z * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * (_486 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.w)));
        _516 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.x * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * (_486 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.y)));
        _517 = _468 - _485;
    }
    else
    {
        _514 = _472;
        _515 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.x;
        _516 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.x;
        _517 = _468;
    }
    float _521 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * _517);
    float _535 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * _517);
    float _546 = (_516 * ((abs(_521) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_521)) / _521) : (0.693147182464599609375 - (0.2402265071868896484375 * _521)))) + (_515 * ((abs(_535) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_535)) / _535) : (0.693147182464599609375 - (0.2402265071868896484375 * _535))));
    float3 _588;
    if (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.z > 0.0)
    {
        float2 _573 = float2(dot(_469.xy, float2(TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation.y, -TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation.x)), dot(_469.xy, TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation));
        float3 _574 = float3(_573.x, _573.y, _469.z);
        _588 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.xyz * mix(TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap.sample(TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler, _574, level(TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.z)).xyz, TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap.sample(TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler, _574, level(0.0)).xyz, float3(fast::clamp((_472 * TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.x) + TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.y, 0.0, 1.0)));
    }
    else
    {
        _588 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.xyz;
    }
    float3 _616;
    if ((TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.w >= 0.0) && (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.z == 0.0))
    {
        _616 = (TranslucentBasePass.TranslucentBasePass_Shared_Fog_DirectionalInscatteringColor.xyz * pow(fast::clamp(dot(_469 * _471, TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.xyz), 0.0, 1.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_DirectionalInscatteringColor.w)) * (1.0 - fast::clamp(exp2(-(_546 * fast::max(_514 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.w, 0.0))), 0.0, 1.0));
    }
    else
    {
        _616 = float3(0.0);
    }
    bool _625 = (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w > 0.0) && (_472 > TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w);
    float _628 = _625 ? 1.0 : fast::max(fast::clamp(exp2(-(_546 * _514)), 0.0, 1.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.w);
    float4 _635 = float4((_588 * (1.0 - _628)) + select(_616, float3(0.0), bool3(_625)), _628);
    float4 _712;
    if (View.View_SkyAtmosphereApplyCameraAerialPerspectiveVolume > 0.0)
    {
        float3 _649 = (_447 * 9.9999997473787516355514526367188e-06) - (View.View_TranslatedWorldCameraOrigin * 9.9999997473787516355514526367188e-06);
        float _655 = sqrt((fast::max(0.0, length(_649) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
        float _656 = _655 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
        float _663;
        if (_656 < 0.707106769084930419921875)
        {
            _663 = fast::clamp((_656 * _656) * 2.0, 0.0, 1.0);
        }
        else
        {
            _663 = 1.0;
        }
        float2 _691;
        if (View.View_RealTimeReflectionCapture != 0.0)
        {
            float3 _666 = normalize(_649);
            float _667 = _666.z;
            float _670 = sqrt(1.0 - (_667 * _667));
            float2 _673 = _107;
            _673.y = (_667 * 0.5) + 0.5;
            float _678 = acos(_666.x / _670);
            float2 _683 = _673;
            _683.x = (((_666.y / _670) < 0.0) ? (6.283185482025146484375 - _678) : _678) * 0.15915493667125701904296875;
            _691 = (_683 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
        }
        else
        {
            _691 = ((_432.xy / _432.ww) * float2(0.5, -0.5)) + float2(0.5);
        }
        float4 _696 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_691, _655), level(0.0));
        float3 _708 = _635.xyz + (((_696.xyz * _663).xyz * View.View_OneOverPreExposure).xyz * _628);
        float4 _711 = float4(_708.x, _708.y, _708.z, _106.w);
        _711.w = _628 * (1.0 - (_663 * (1.0 - _696.w)));
        _712 = _711;
    }
    else
    {
        _712 = _635;
    }
    out.out_var_TEXCOORD10 = _436;
    out.out_var_TEXCOORD11 = float4(_426[2], float(int(sign(determinant(_426)))));
    out.out_var_TEXCOORD1 = in.in_var_ATTRIBUTE5;
    out_var_TEXCOORD3 = _446;
    out.out_var_TEXCOORD7 = _712;
    out.gl_Position = _432;
    out.out_var_TEXCOORD3_0 = out_var_TEXCOORD3[0];
    return out;
}

