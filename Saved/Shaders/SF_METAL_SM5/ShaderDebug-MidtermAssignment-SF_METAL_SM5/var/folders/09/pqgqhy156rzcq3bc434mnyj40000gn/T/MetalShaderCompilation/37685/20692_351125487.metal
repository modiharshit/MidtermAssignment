

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

constant float3x3 _114 = {};
constant float4 _115 = {};
constant float2 _116 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10 [[user(locn0)]];
    float4 out_var_TEXCOORD11 [[user(locn1)]];
    float4 out_var_TEXCOORD2 [[user(locn2)]];
    float4 out_var_TEXCOORD3_0 [[user(locn3)]];
    float4 out_var_PARTICLE_SUBUVS [[user(locn4)]];
    float3 out_var_PARTICLE_LIGHTING_OFFSET [[user(locn5)]];
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
};

// Implementation of the GLSL mod() function, which is slightly different than Metal fmod()
template<typename Tx, typename Ty>
inline Tx mod(Tx x, Ty y)
{
    return x - y * floor(x / y);
}

vertex Main_out Main_000050d4_14edbfef(Main_in in [[stage_in]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_SpriteVF& SpriteVF [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> CutoutGeometry [[texture(0)]], texturecube<float> TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap [[texture(1)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(2)]], sampler TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler [[sampler(0)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(1)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD3 = {};
    float4 _173 = float4(in.in_var_ATTRIBUTE0.xyz, 1.0);
    float4 _176 = Primitive.Primitive_LocalToWorld * _173;
    float3 _182 = _176.xyz;
    float3 _186 = float3(SpriteVF.SpriteVF_RemoveHMDRoll);
    float3 _195 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _186), SpriteVF.SpriteVF_AxisLockRight.xyz, float3(SpriteVF.SpriteVF_AxisLockRight.w));
    float3 _203 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _186), SpriteVF.SpriteVF_AxisLockUp.xyz, float3(SpriteVF.SpriteVF_AxisLockUp.w));
    float3 _204 = View.View_WorldCameraOrigin - _182;
    float _205 = dot(_204, _204);
    float3 _208 = _204 * rsqrt(fast::max(_205, 9.9999999392252902907785028219223e-09));
    float3 _278;
    float3 _279;
    if (SpriteVF.SpriteVF_CameraFacingBlend[0] > 0.0)
    {
        float3 _267 = cross(_208, float3(0.0, 0.0, 1.0));
        float3 _271 = _267 * rsqrt(fast::max(dot(_267, _267), 9.9999999392252902907785028219223e-09));
        float3 _273 = float3(fast::clamp((_205 * SpriteVF.SpriteVF_CameraFacingBlend[1]) - SpriteVF.SpriteVF_CameraFacingBlend[2], 0.0, 1.0));
        _278 = normalize(mix(_195, _271, _273));
        _279 = normalize(mix(_203, cross(_208, _271), _273));
    }
    else
    {
        float3 _258;
        float3 _259;
        if (SpriteVF.SpriteVF_TangentSelector.y > 0.0)
        {
            float3 _247 = _182 - (Primitive.Primitive_LocalToWorld * float4(in.in_var_ATTRIBUTE1.xyz, 1.0)).xyz;
            float3 _251 = _247 * rsqrt(fast::max(dot(_247, _247), 9.9999999392252902907785028219223e-09));
            float3 _252 = cross(_208, _251);
            _258 = _252 * rsqrt(fast::max(dot(_252, _252), 9.9999999392252902907785028219223e-09));
            _259 = -_251;
        }
        else
        {
            float3 _245;
            float3 _246;
            if (SpriteVF.SpriteVF_TangentSelector.z > 0.0)
            {
                float3 _239 = cross(SpriteVF.SpriteVF_AxisLockRight.xyz, _208);
                _245 = SpriteVF.SpriteVF_AxisLockRight.xyz;
                _246 = -(_239 * rsqrt(fast::max(dot(_239, _239), 9.9999999392252902907785028219223e-09)));
            }
            else
            {
                float3 _237;
                float3 _238;
                if (SpriteVF.SpriteVF_TangentSelector.w > 0.0)
                {
                    float3 _231 = cross(_208, float3(0.0, 0.0, 1.0));
                    float3 _235 = _231 * rsqrt(fast::max(dot(_231, _231), 9.9999999392252902907785028219223e-09));
                    _237 = _235;
                    _238 = cross(_208, _235);
                }
                else
                {
                    _237 = _195;
                    _238 = _203;
                }
                _245 = _237;
                _246 = _238;
            }
            _258 = _245;
            _259 = _246;
        }
        _278 = _258;
        _279 = _259;
    }
    float _285 = in.in_var_ATTRIBUTE2.z * SpriteVF.SpriteVF_RotationScale;
    float _286 = _285 + SpriteVF.SpriteVF_RotationBias;
    float _287 = sin(_286);
    float _288 = cos(_286);
    float3 _289 = _279 * _287;
    float3 _290 = _278 * _288;
    float3 _291 = _289 + _290;
    float3 _292 = _279 * _288;
    float3 _293 = _278 * _287;
    float3 _294 = _292 - _293;
    float2 _298 = float2(int2(sign(in.in_var_ATTRIBUTE2.xy)));
    float2 _353;
    float2 _354;
    if (_Globals.NumCutoutVerticesPerFrame > 0u)
    {
        uint _320 = uint(mod(float((gl_VertexIndex - gl_BaseVertex)), float(_Globals.NumCutoutVerticesPerFrame)));
        float _329 = _298.x;
        float _330 = _298.y;
        uint _337;
        if ((_329 * _330) < 0.0)
        {
            _337 = (_Globals.NumCutoutVerticesPerFrame - 1u) - _320;
        }
        else
        {
            _337 = _320;
        }
        float4 _341 = CutoutGeometry.read(uint(((uint(mod(in.in_var_ATTRIBUTE2.w, SpriteVF.SpriteVF_SubImageSize.x * SpriteVF.SpriteVF_SubImageSize.y)) * _Globals.NumCutoutVerticesPerFrame) + _337)));
        float _344 = _341.x;
        float2 _347 = _116;
        _347.x = (_329 < 0.0) ? (1.0 - _344) : _344;
        float _349 = _341.y;
        float2 _352 = _347;
        _352.y = (_330 < 0.0) ? (1.0 - _349) : _349;
        _353 = _341.xy;
        _354 = _352;
    }
    else
    {
        float2 _310 = _116;
        _310.x = (_298.x < 0.0) ? (1.0 - in.in_var_ATTRIBUTE4.x) : in.in_var_ATTRIBUTE4.x;
        float2 _316 = _310;
        _316.y = (_298.y < 0.0) ? (1.0 - in.in_var_ATTRIBUTE4.y) : in.in_var_ATTRIBUTE4.y;
        _353 = _316;
        _354 = in.in_var_ATTRIBUTE4;
    }
    float3 _355 = _182 + View.View_PreViewTranslation;
    float _356 = _355.x;
    float _357 = _355.y;
    float _358 = _355.z;
    float4 _359 = float4(_356, _357, _358, 1.0);
    float2 _360 = abs(in.in_var_ATTRIBUTE2.xy);
    float _361 = _291.x;
    float _362 = _291.y;
    float _363 = _291.z;
    float4 _364 = float4(_361, _362, _363, 0.0);
    float _365 = _360.x;
    float _369 = _354.x + SpriteVF.SpriteVF_PivotOffset.x;
    float _370 = _365 * _369;
    float4 _371 = _364 * _370;
    float4 _372 = _359 + _371;
    float _373 = _294.x;
    float _374 = _294.y;
    float _375 = _294.z;
    float4 _376 = float4(_373, _374, _375, 0.0);
    float _377 = _360.y;
    float _381 = _354.y + SpriteVF.SpriteVF_PivotOffset.y;
    float _382 = _377 * _381;
    float4 _383 = _376 * _382;
    float4 _384 = _372 + _383;
    float _386 = fract(in.in_var_ATTRIBUTE2.w);
    float _387 = in.in_var_ATTRIBUTE2.w - _386;
    float _388 = _387 + 1.0;
    float2 _404 = (float2(mod(_387, SpriteVF.SpriteVF_SubImageSize.x), floor(_387 * SpriteVF.SpriteVF_SubImageSize.z)) + _353) * SpriteVF.SpriteVF_SubImageSize.zw;
    float2 _407 = (float2(mod(_388, SpriteVF.SpriteVF_SubImageSize.x), floor(_388 * SpriteVF.SpriteVF_SubImageSize.z)) + _353) * SpriteVF.SpriteVF_SubImageSize.zw;
    float3x3 _408 = _114;
    _408[0] = _291;
    float3x3 _409 = _408;
    _409[1] = _294;
    float3x3 _443;
    if (SpriteVF.SpriteVF_NormalsType < 0.5)
    {
        float3x3 _442 = _409;
        _442[2] = normalize(cross(_291, _294));
        _443 = _442;
    }
    else
    {
        float3x3 _439;
        if (SpriteVF.SpriteVF_NormalsType < 1.5)
        {
            float3x3 _438 = _409;
            _438[2] = normalize(_182 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz);
            _439 = _438;
        }
        else
        {
            float3x3 _432 = _409;
            _432[2] = normalize(_182 - (SpriteVF.SpriteVF_NormalsSphereCenter.xyz + (SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz * dot(SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz, _182 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz))));
            _439 = _432;
        }
        _443 = _439;
    }
    float _445 = in.in_var_ATTRIBUTE1.w + 10.0;
    float _455 = _384.x;
    float _456 = _384.y;
    float _457 = _384.z;
    float4 _458 = float4(_455, _456, _457, 1.0);
    float4 _459 = float4(_458.x, _458.y, _458.z, _458.w);
    float4 _460 = View.View_TranslatedWorldToClip * _459;
    float4 _465 = float4(_443[0].x, _443[0].y, _443[0].z, float4(0.0).w);
    _465.w = _386;
    spvUnsafeArray<float4, 1> _475 = { float4(_404.x, _404.y, float4(0.0).z, float4(0.0).w) };
    float3 _476 = _458.xyz;
    float3 _477 = _476 - View.View_TranslatedWorldCameraOrigin;
    float _494 = fast::min(View.View_WorldCameraOrigin.z, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.z);
    float _497 = _477.z + (View.View_WorldCameraOrigin.z - _494);
    float3 _498 = _477;
    _498.z = _497;
    float _499 = dot(_498, _498);
    float _500 = rsqrt(_499);
    float _501 = _499 * _500;
    float _509 = fast::max(fast::max(View.View_VolumetricFogMaxDistance * (length(_477) / dot(_477, View.View_ViewForward)), 0.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.w);
    float _543;
    float _544;
    float _545;
    float _546;
    if (_509 > 0.0)
    {
        float _513 = _509 * _500;
        float _514 = _513 * _497;
        float _515 = _494 + _514;
        _543 = (1.0 - _513) * _501;
        _544 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.z * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * (_515 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.w)));
        _545 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.x * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * (_515 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.y)));
        _546 = _497 - _514;
    }
    else
    {
        _543 = _501;
        _544 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.x;
        _545 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.x;
        _546 = _497;
    }
    float _550 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * _546);
    float _564 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * _546);
    float _575 = (_545 * ((abs(_550) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_550)) / _550) : (0.693147182464599609375 - (0.2402265071868896484375 * _550)))) + (_544 * ((abs(_564) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_564)) / _564) : (0.693147182464599609375 - (0.2402265071868896484375 * _564))));
    float3 _617;
    if (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.z > 0.0)
    {
        float2 _602 = float2(dot(_498.xy, float2(TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation.y, -TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation.x)), dot(_498.xy, TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation));
        float3 _603 = float3(_602.x, _602.y, _498.z);
        _617 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.xyz * mix(TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap.sample(TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler, _603, level(TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.z)).xyz, TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap.sample(TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler, _603, level(0.0)).xyz, float3(fast::clamp((_501 * TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.x) + TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.y, 0.0, 1.0)));
    }
    else
    {
        _617 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.xyz;
    }
    float3 _645;
    if ((TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.w >= 0.0) && (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.z == 0.0))
    {
        _645 = (TranslucentBasePass.TranslucentBasePass_Shared_Fog_DirectionalInscatteringColor.xyz * pow(fast::clamp(dot(_498 * _500, TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.xyz), 0.0, 1.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_DirectionalInscatteringColor.w)) * (1.0 - fast::clamp(exp2(-(_575 * fast::max(_543 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.w, 0.0))), 0.0, 1.0));
    }
    else
    {
        _645 = float3(0.0);
    }
    bool _654 = (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w > 0.0) && (_501 > TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w);
    float _657 = _654 ? 1.0 : fast::max(fast::clamp(exp2(-(_575 * _543)), 0.0, 1.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.w);
    float4 _664 = float4((_617 * (1.0 - _657)) + select(_645, float3(0.0), bool3(_654)), _657);
    float4 _741;
    if (View.View_SkyAtmosphereApplyCameraAerialPerspectiveVolume > 0.0)
    {
        float3 _678 = (_476 * 9.9999997473787516355514526367188e-06) - (View.View_TranslatedWorldCameraOrigin * 9.9999997473787516355514526367188e-06);
        float _684 = sqrt((fast::max(0.0, length(_678) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
        float _685 = _684 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
        float _692;
        if (_685 < 0.707106769084930419921875)
        {
            _692 = fast::clamp((_685 * _685) * 2.0, 0.0, 1.0);
        }
        else
        {
            _692 = 1.0;
        }
        float2 _720;
        if (View.View_RealTimeReflectionCapture != 0.0)
        {
            float3 _695 = normalize(_678);
            float _696 = _695.z;
            float _699 = sqrt(1.0 - (_696 * _696));
            float2 _702 = _116;
            _702.y = (_696 * 0.5) + 0.5;
            float _707 = acos(_695.x / _699);
            float2 _712 = _702;
            _712.x = (((_695.y / _699) < 0.0) ? (6.283185482025146484375 - _707) : _707) * 0.15915493667125701904296875;
            _720 = (_712 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
        }
        else
        {
            _720 = ((_460.xy / _460.ww) * float2(0.5, -0.5)) + float2(0.5);
        }
        float4 _725 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_720, _684), level(0.0));
        float3 _737 = _664.xyz + (((_725.xyz * _692).xyz * View.View_OneOverPreExposure).xyz * _657);
        float4 _740 = float4(_737.x, _737.y, _737.z, _115.w);
        _740.w = _657 * (1.0 - (_692 * (1.0 - _725.w)));
        _741 = _740;
    }
    else
    {
        _741 = _664;
    }
    out.out_var_TEXCOORD10 = _465;
    out.out_var_TEXCOORD11 = float4(_443[2], float(int(sign(determinant(_443)))));
    out.out_var_TEXCOORD2 = in.in_var_ATTRIBUTE3;
    out_var_TEXCOORD3 = _475;
    out.out_var_PARTICLE_SUBUVS = float4(_404.x, _404.y, _407.x, _407.y);
    out.out_var_PARTICLE_LIGHTING_OFFSET = ((fract(float3(1361.456298828125, 2333.577880859375, 3623.98291015625) * (_445 * _445)) * 2.0) - float3(1.0)) * (0.5 * View.View_TranslucencyLightingVolumeInvSize[0].w);
    out.out_var_TEXCOORD7 = _741;
    out.gl_Position = _460;
    out.out_var_TEXCOORD3_0 = out_var_TEXCOORD3[0];
    return out;
}

