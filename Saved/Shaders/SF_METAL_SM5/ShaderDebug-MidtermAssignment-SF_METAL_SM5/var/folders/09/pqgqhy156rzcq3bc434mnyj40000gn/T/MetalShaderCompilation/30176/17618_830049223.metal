

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
    char _m2_pad[96];
    float3 View_WorldCameraOrigin;
    float3 View_TranslatedWorldCameraOrigin;
    char _m4_pad[16];
    float3 View_PreViewTranslation;
    char _m5_pad[1032];
    float View_OneOverPreExposure;
    char _m6_pad[704];
    float4 View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize;
    float View_SkyAtmosphereAerialPerspectiveStartDepthKm;
    float View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
    float View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv;
    char _m10_pad[4];
    float View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv;
    float View_SkyAtmosphereApplyCameraAerialPerspectiveVolume;
    char _m12_pad[24];
    float View_RealTimeReflectionCapture;
    char _m13_pad[420];
    float View_VolumetricFogMaxDistance;
};

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
    float4 Primitive_InvNonUniformScaleAndDeterminantSign;
};

struct type_PrecomputedLightingBuffer
{
    char _m0_pad[32];
    float4 PrecomputedLightingBuffer_LightMapCoordinateScaleBias;
};

struct type_Globals
{
    spvUnsafeArray<float4, 10> SplineParams;
};

constant float3x3 _107 = {};
constant float4 _108 = {};
constant float2 _109 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD0_0 [[user(locn2)]];
    float4 out_var_TEXCOORD4 [[user(locn3)]];
    float4 out_var_TEXCOORD7 [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    float2 in_var_ATTRIBUTE4 [[attribute(4)]];
    float2 in_var_ATTRIBUTE15 [[attribute(15)]];
};

vertex Main_out Main_000044d2_31798bc7(Main_in in [[stage_in]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_PrecomputedLightingBuffer& PrecomputedLightingBuffer [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]], texturecube<float> TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap [[texture(0)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(1)]], sampler TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler [[sampler(0)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(1)]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    float _151 = dot(in.in_var_ATTRIBUTE0.xyz, _Globals.SplineParams[7].xyz);
    float _155 = _151 * _Globals.SplineParams[6].w;
    float _159 = _155 - _Globals.SplineParams[4].w;
    bool _163 = _Globals.SplineParams[3].w != 0.0;
    float _164 = smoothstep(0.0, 1.0, _159);
    float _165 = _163 ? _164 : _159;
    float3 _176 = _Globals.SplineParams[0].xyz * 6.0;
    float3 _177 = _Globals.SplineParams[1].xyz * 3.0;
    float3 _178 = _176 + _177;
    float3 _179 = _Globals.SplineParams[4].xyz * 3.0;
    float3 _180 = _178 + _179;
    float3 _181 = _Globals.SplineParams[3].xyz * 6.0;
    float3 _182 = _180 - _181;
    float3 _183 = _Globals.SplineParams[0].xyz * (-6.0);
    float3 _184 = _Globals.SplineParams[1].xyz * 4.0;
    float3 _185 = _183 - _184;
    float3 _186 = _Globals.SplineParams[4].xyz * 2.0;
    float3 _187 = _185 - _186;
    float3 _188 = _187 + _181;
    float _189 = _159 * _159;
    float3 _190 = _182 * _189;
    float3 _191 = _188 * _159;
    float3 _192 = _190 + _191;
    float3 _193 = _192 + _Globals.SplineParams[1].xyz;
    float3 _194 = normalize(_193);
    float3 _197 = cross(_Globals.SplineParams[6].xyz, _194);
    float3 _198 = normalize(_197);
    float3 _199 = cross(_194, _198);
    float3 _200 = normalize(_199);
    float _205 = mix(_Globals.SplineParams[0].w, _Globals.SplineParams[1].w, _165);
    float _206 = sin(_205);
    float _207 = cos(_205);
    float3 _208 = _198 * _207;
    float3 _209 = _200 * _206;
    float3 _210 = _208 - _209;
    float3 _211 = _200 * _207;
    float3 _212 = _198 * _206;
    float3 _213 = _211 + _212;
    float2 _220 = float2(_165);
    float2 _221 = mix(_Globals.SplineParams[2].xy, _Globals.SplineParams[5].xy, _220);
    float _222 = _221.x;
    float _227 = _221.y;
    float3x3 _238 = float3x3(_Globals.SplineParams[7].xyz, _Globals.SplineParams[8].xyz, _Globals.SplineParams[9].xyz);
    float3x3 _239 = transpose(_238);
    float3x3 _241 = float3x3(_194, _210 * float(int(sign(_222))), _213 * float(int(sign(_227)))) * _239;
    float3 _245 = (_241 * in.in_var_ATTRIBUTE2.xyz).xyz;
    float3 _247 = cross(_245, _241 * in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _250 = _107;
    _250[0] = cross(_247, _245) * in.in_var_ATTRIBUTE2.w;
    float3x3 _251 = _250;
    _251[1] = _247;
    float3x3 _252 = _251;
    _252[2] = _245;
    float3x3 _266 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _266[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _269 = _266;
    _269[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _272 = _269;
    _272[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _273 = _272 * _252;
    float _277 = _189 * _159;
    float _278 = 2.0 * _277;
    float _279 = 3.0 * _189;
    float _280 = _278 - _279;
    float _281 = _280 + 1.0;
    float3 _282 = _Globals.SplineParams[0].xyz * _281;
    float _283 = 2.0 * _189;
    float _284 = _277 - _283;
    float _285 = _284 + _159;
    float3 _286 = _Globals.SplineParams[1].xyz * _285;
    float3 _287 = _282 + _286;
    float _288 = _277 - _189;
    float3 _289 = _Globals.SplineParams[4].xyz * _288;
    float3 _290 = _287 + _289;
    float _291 = (-2.0) * _277;
    float _292 = _291 + _279;
    float3 _293 = _Globals.SplineParams[3].xyz * _292;
    float3 _294 = _290 + _293;
    float2 _297 = mix(_Globals.SplineParams[2].zw, _Globals.SplineParams[5].zw, _220);
    float _298 = _297.x;
    float3 _299 = _198 * _298;
    float3 _300 = _294 + _299;
    float _301 = _297.y;
    float3 _302 = _200 * _301;
    float3 _303 = _300 + _302;
    float3 _304 = _210 * _222;
    float3 _305 = _213 * _227;
    float3x3 _306 = float3x3(float3(0.0), _304, _305);
    float3x3 _307 = _306 * _239;
    float3 _308 = _307[0];
    float3 _309 = _307[1];
    float3 _310 = _307[2];
    float4x3 _311 = float4x3(_308, _309, _310, _303);
    float3 _312 = _311 * in.in_var_ATTRIBUTE0;
    float3 _313 = _312.xxx;
    float3 _314 = Primitive.Primitive_LocalToWorld[0].xyz * _313;
    float3 _315 = _312.yyy;
    float3 _316 = Primitive.Primitive_LocalToWorld[1].xyz * _315;
    float3 _317 = _314 + _316;
    float3 _318 = _312.zzz;
    float3 _319 = Primitive.Primitive_LocalToWorld[2].xyz * _318;
    float3 _320 = _317 + _319;
    float3 _323 = Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation;
    float3 _324 = _320 + _323;
    float _325 = _324.x;
    float _326 = _324.y;
    float _327 = _324.z;
    float4 _328 = float4(_325, _326, _327, 1.0);
    float4 _329 = float4(_328.x, _328.y, _328.z, _328.w);
    float4 _330 = View.View_TranslatedWorldToClip * _329;
    float2 _337 = (in.in_var_ATTRIBUTE15 * PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapCoordinateScaleBias.xy) + PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapCoordinateScaleBias.zw;
    spvUnsafeArray<float4, 1> _349 = { float4(in.in_var_ATTRIBUTE4.x, in.in_var_ATTRIBUTE4.y, float4(0.0).z, float4(0.0).w) };
    float3 _350 = _328.xyz;
    float3 _351 = _350 - View.View_TranslatedWorldCameraOrigin;
    float _368 = fast::min(View.View_WorldCameraOrigin.z, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.z);
    float _371 = _351.z + (View.View_WorldCameraOrigin.z - _368);
    float3 _372 = _351;
    _372.z = _371;
    float _373 = dot(_372, _372);
    float _374 = rsqrt(_373);
    float _375 = _373 * _374;
    float _383 = fast::max(fast::max(View.View_VolumetricFogMaxDistance * (length(_351) / dot(_351, View.View_ViewForward)), 0.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.w);
    float _417;
    float _418;
    float _419;
    float _420;
    if (_383 > 0.0)
    {
        float _387 = _383 * _374;
        float _388 = _387 * _371;
        float _389 = _368 + _388;
        _417 = (1.0 - _387) * _375;
        _418 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.z * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * (_389 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.w)));
        _419 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.x * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * (_389 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.y)));
        _420 = _371 - _388;
    }
    else
    {
        _417 = _375;
        _418 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.x;
        _419 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.x;
        _420 = _371;
    }
    float _424 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * _420);
    float _438 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * _420);
    float _449 = (_419 * ((abs(_424) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_424)) / _424) : (0.693147182464599609375 - (0.2402265071868896484375 * _424)))) + (_418 * ((abs(_438) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_438)) / _438) : (0.693147182464599609375 - (0.2402265071868896484375 * _438))));
    float3 _491;
    if (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.z > 0.0)
    {
        float2 _476 = float2(dot(_372.xy, float2(TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation.y, -TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation.x)), dot(_372.xy, TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation));
        float3 _477 = float3(_476.x, _476.y, _372.z);
        _491 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.xyz * mix(TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap.sample(TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler, _477, level(TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.z)).xyz, TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap.sample(TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler, _477, level(0.0)).xyz, float3(fast::clamp((_375 * TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.x) + TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.y, 0.0, 1.0)));
    }
    else
    {
        _491 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.xyz;
    }
    float3 _519;
    if ((TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.w >= 0.0) && (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.z == 0.0))
    {
        _519 = (TranslucentBasePass.TranslucentBasePass_Shared_Fog_DirectionalInscatteringColor.xyz * pow(fast::clamp(dot(_372 * _374, TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.xyz), 0.0, 1.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_DirectionalInscatteringColor.w)) * (1.0 - fast::clamp(exp2(-(_449 * fast::max(_417 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.w, 0.0))), 0.0, 1.0));
    }
    else
    {
        _519 = float3(0.0);
    }
    bool _528 = (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w > 0.0) && (_375 > TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w);
    float _531 = _528 ? 1.0 : fast::max(fast::clamp(exp2(-(_449 * _417)), 0.0, 1.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.w);
    float4 _538 = float4((_491 * (1.0 - _531)) + select(_519, float3(0.0), bool3(_528)), _531);
    float4 _615;
    if (View.View_SkyAtmosphereApplyCameraAerialPerspectiveVolume > 0.0)
    {
        float3 _552 = (_350 * 9.9999997473787516355514526367188e-06) - (View.View_TranslatedWorldCameraOrigin * 9.9999997473787516355514526367188e-06);
        float _558 = sqrt((fast::max(0.0, length(_552) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
        float _559 = _558 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
        float _566;
        if (_559 < 0.707106769084930419921875)
        {
            _566 = fast::clamp((_559 * _559) * 2.0, 0.0, 1.0);
        }
        else
        {
            _566 = 1.0;
        }
        float2 _594;
        if (View.View_RealTimeReflectionCapture != 0.0)
        {
            float3 _569 = normalize(_552);
            float _570 = _569.z;
            float _573 = sqrt(1.0 - (_570 * _570));
            float2 _576 = _109;
            _576.y = (_570 * 0.5) + 0.5;
            float _581 = acos(_569.x / _573);
            float2 _586 = _576;
            _586.x = (((_569.y / _573) < 0.0) ? (6.283185482025146484375 - _581) : _581) * 0.15915493667125701904296875;
            _594 = (_586 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
        }
        else
        {
            _594 = ((_330.xy / _330.ww) * float2(0.5, -0.5)) + float2(0.5);
        }
        float4 _599 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_594, _558), level(0.0));
        float3 _611 = _538.xyz + (((_599.xyz * _566).xyz * View.View_OneOverPreExposure).xyz * _531);
        float4 _614 = float4(_611.x, _611.y, _611.z, _108.w);
        _614.w = _531 * (1.0 - (_566 * (1.0 - _599.w)));
        _615 = _614;
    }
    else
    {
        _615 = _538;
    }
    out.out_var_TEXCOORD10_centroid = float4(_273[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_273[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _349;
    out.out_var_TEXCOORD4 = float4(_337.x, _337.y, float2(0.0).x, float2(0.0).y);
    out.out_var_TEXCOORD7 = _615;
    out.gl_Position = _330;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

