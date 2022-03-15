

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
    float4 PrecomputedLightingBuffer_ShadowMapCoordinateScaleBias;
};

struct type_Globals
{
    spvUnsafeArray<float4, 10> SplineParams;
};

constant float3x3 _106 = {};
constant float4 _107 = {};
constant float2 _108 = {};

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

vertex Main_out Main_000045f5_349b3dd7(Main_in in [[stage_in]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_PrecomputedLightingBuffer& PrecomputedLightingBuffer [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]], texturecube<float> TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap [[texture(0)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(1)]], sampler TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler [[sampler(0)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(1)]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    float _150 = dot(in.in_var_ATTRIBUTE0.xyz, _Globals.SplineParams[7].xyz);
    float _154 = _150 * _Globals.SplineParams[6].w;
    float _158 = _154 - _Globals.SplineParams[4].w;
    bool _162 = _Globals.SplineParams[3].w != 0.0;
    float _163 = smoothstep(0.0, 1.0, _158);
    float _164 = _162 ? _163 : _158;
    float3 _175 = _Globals.SplineParams[0].xyz * 6.0;
    float3 _176 = _Globals.SplineParams[1].xyz * 3.0;
    float3 _177 = _175 + _176;
    float3 _178 = _Globals.SplineParams[4].xyz * 3.0;
    float3 _179 = _177 + _178;
    float3 _180 = _Globals.SplineParams[3].xyz * 6.0;
    float3 _181 = _179 - _180;
    float3 _182 = _Globals.SplineParams[0].xyz * (-6.0);
    float3 _183 = _Globals.SplineParams[1].xyz * 4.0;
    float3 _184 = _182 - _183;
    float3 _185 = _Globals.SplineParams[4].xyz * 2.0;
    float3 _186 = _184 - _185;
    float3 _187 = _186 + _180;
    float _188 = _158 * _158;
    float3 _189 = _181 * _188;
    float3 _190 = _187 * _158;
    float3 _191 = _189 + _190;
    float3 _192 = _191 + _Globals.SplineParams[1].xyz;
    float3 _193 = normalize(_192);
    float3 _196 = cross(_Globals.SplineParams[6].xyz, _193);
    float3 _197 = normalize(_196);
    float3 _198 = cross(_193, _197);
    float3 _199 = normalize(_198);
    float _204 = mix(_Globals.SplineParams[0].w, _Globals.SplineParams[1].w, _164);
    float _205 = sin(_204);
    float _206 = cos(_204);
    float3 _207 = _197 * _206;
    float3 _208 = _199 * _205;
    float3 _209 = _207 - _208;
    float3 _210 = _199 * _206;
    float3 _211 = _197 * _205;
    float3 _212 = _210 + _211;
    float2 _219 = float2(_164);
    float2 _220 = mix(_Globals.SplineParams[2].xy, _Globals.SplineParams[5].xy, _219);
    float _221 = _220.x;
    float _226 = _220.y;
    float3x3 _237 = float3x3(_Globals.SplineParams[7].xyz, _Globals.SplineParams[8].xyz, _Globals.SplineParams[9].xyz);
    float3x3 _238 = transpose(_237);
    float3x3 _240 = float3x3(_193, _209 * float(int(sign(_221))), _212 * float(int(sign(_226)))) * _238;
    float3 _244 = (_240 * in.in_var_ATTRIBUTE2.xyz).xyz;
    float3 _246 = cross(_244, _240 * in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _249 = _106;
    _249[0] = cross(_246, _244) * in.in_var_ATTRIBUTE2.w;
    float3x3 _250 = _249;
    _250[1] = _246;
    float3x3 _251 = _250;
    _251[2] = _244;
    float3x3 _265 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _265[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _268 = _265;
    _268[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _271 = _268;
    _271[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _272 = _271 * _251;
    float _276 = _188 * _158;
    float _277 = 2.0 * _276;
    float _278 = 3.0 * _188;
    float _279 = _277 - _278;
    float _280 = _279 + 1.0;
    float3 _281 = _Globals.SplineParams[0].xyz * _280;
    float _282 = 2.0 * _188;
    float _283 = _276 - _282;
    float _284 = _283 + _158;
    float3 _285 = _Globals.SplineParams[1].xyz * _284;
    float3 _286 = _281 + _285;
    float _287 = _276 - _188;
    float3 _288 = _Globals.SplineParams[4].xyz * _287;
    float3 _289 = _286 + _288;
    float _290 = (-2.0) * _276;
    float _291 = _290 + _278;
    float3 _292 = _Globals.SplineParams[3].xyz * _291;
    float3 _293 = _289 + _292;
    float2 _296 = mix(_Globals.SplineParams[2].zw, _Globals.SplineParams[5].zw, _219);
    float _297 = _296.x;
    float3 _298 = _197 * _297;
    float3 _299 = _293 + _298;
    float _300 = _296.y;
    float3 _301 = _199 * _300;
    float3 _302 = _299 + _301;
    float3 _303 = _209 * _221;
    float3 _304 = _212 * _226;
    float3x3 _305 = float3x3(float3(0.0), _303, _304);
    float3x3 _306 = _305 * _238;
    float3 _307 = _306[0];
    float3 _308 = _306[1];
    float3 _309 = _306[2];
    float4x3 _310 = float4x3(_307, _308, _309, _302);
    float3 _311 = _310 * in.in_var_ATTRIBUTE0;
    float3 _312 = _311.xxx;
    float3 _313 = Primitive.Primitive_LocalToWorld[0].xyz * _312;
    float3 _314 = _311.yyy;
    float3 _315 = Primitive.Primitive_LocalToWorld[1].xyz * _314;
    float3 _316 = _313 + _315;
    float3 _317 = _311.zzz;
    float3 _318 = Primitive.Primitive_LocalToWorld[2].xyz * _317;
    float3 _319 = _316 + _318;
    float3 _322 = Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation;
    float3 _323 = _319 + _322;
    float _324 = _323.x;
    float _325 = _323.y;
    float _326 = _323.z;
    float4 _327 = float4(_324, _325, _326, 1.0);
    float4 _328 = float4(_327.x, _327.y, _327.z, _327.w);
    float4 _329 = View.View_TranslatedWorldToClip * _328;
    float2 _336 = (in.in_var_ATTRIBUTE15 * PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapCoordinateScaleBias.xy) + PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapCoordinateScaleBias.zw;
    float2 _342 = (in.in_var_ATTRIBUTE15 * PrecomputedLightingBuffer.PrecomputedLightingBuffer_ShadowMapCoordinateScaleBias.xy) + PrecomputedLightingBuffer.PrecomputedLightingBuffer_ShadowMapCoordinateScaleBias.zw;
    spvUnsafeArray<float4, 1> _354 = { float4(in.in_var_ATTRIBUTE4.x, in.in_var_ATTRIBUTE4.y, float4(0.0).z, float4(0.0).w) };
    float3 _355 = _327.xyz;
    float3 _356 = _355 - View.View_TranslatedWorldCameraOrigin;
    float _373 = fast::min(View.View_WorldCameraOrigin.z, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.z);
    float _376 = _356.z + (View.View_WorldCameraOrigin.z - _373);
    float3 _377 = _356;
    _377.z = _376;
    float _378 = dot(_377, _377);
    float _379 = rsqrt(_378);
    float _380 = _378 * _379;
    float _388 = fast::max(fast::max(View.View_VolumetricFogMaxDistance * (length(_356) / dot(_356, View.View_ViewForward)), 0.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.w);
    float _422;
    float _423;
    float _424;
    float _425;
    if (_388 > 0.0)
    {
        float _392 = _388 * _379;
        float _393 = _392 * _376;
        float _394 = _373 + _393;
        _422 = (1.0 - _392) * _380;
        _423 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.z * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * (_394 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.w)));
        _424 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.x * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * (_394 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.y)));
        _425 = _376 - _393;
    }
    else
    {
        _422 = _380;
        _423 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.x;
        _424 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.x;
        _425 = _376;
    }
    float _429 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * _425);
    float _443 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * _425);
    float _454 = (_424 * ((abs(_429) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_429)) / _429) : (0.693147182464599609375 - (0.2402265071868896484375 * _429)))) + (_423 * ((abs(_443) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_443)) / _443) : (0.693147182464599609375 - (0.2402265071868896484375 * _443))));
    float3 _496;
    if (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.z > 0.0)
    {
        float2 _481 = float2(dot(_377.xy, float2(TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation.y, -TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation.x)), dot(_377.xy, TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation));
        float3 _482 = float3(_481.x, _481.y, _377.z);
        _496 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.xyz * mix(TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap.sample(TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler, _482, level(TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.z)).xyz, TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap.sample(TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler, _482, level(0.0)).xyz, float3(fast::clamp((_380 * TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.x) + TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.y, 0.0, 1.0)));
    }
    else
    {
        _496 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.xyz;
    }
    float3 _524;
    if ((TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.w >= 0.0) && (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.z == 0.0))
    {
        _524 = (TranslucentBasePass.TranslucentBasePass_Shared_Fog_DirectionalInscatteringColor.xyz * pow(fast::clamp(dot(_377 * _379, TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.xyz), 0.0, 1.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_DirectionalInscatteringColor.w)) * (1.0 - fast::clamp(exp2(-(_454 * fast::max(_422 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.w, 0.0))), 0.0, 1.0));
    }
    else
    {
        _524 = float3(0.0);
    }
    bool _533 = (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w > 0.0) && (_380 > TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w);
    float _536 = _533 ? 1.0 : fast::max(fast::clamp(exp2(-(_454 * _422)), 0.0, 1.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.w);
    float4 _543 = float4((_496 * (1.0 - _536)) + select(_524, float3(0.0), bool3(_533)), _536);
    float4 _620;
    if (View.View_SkyAtmosphereApplyCameraAerialPerspectiveVolume > 0.0)
    {
        float3 _557 = (_355 * 9.9999997473787516355514526367188e-06) - (View.View_TranslatedWorldCameraOrigin * 9.9999997473787516355514526367188e-06);
        float _563 = sqrt((fast::max(0.0, length(_557) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
        float _564 = _563 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
        float _571;
        if (_564 < 0.707106769084930419921875)
        {
            _571 = fast::clamp((_564 * _564) * 2.0, 0.0, 1.0);
        }
        else
        {
            _571 = 1.0;
        }
        float2 _599;
        if (View.View_RealTimeReflectionCapture != 0.0)
        {
            float3 _574 = normalize(_557);
            float _575 = _574.z;
            float _578 = sqrt(1.0 - (_575 * _575));
            float2 _581 = _108;
            _581.y = (_575 * 0.5) + 0.5;
            float _586 = acos(_574.x / _578);
            float2 _591 = _581;
            _591.x = (((_574.y / _578) < 0.0) ? (6.283185482025146484375 - _586) : _586) * 0.15915493667125701904296875;
            _599 = (_591 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
        }
        else
        {
            _599 = ((_329.xy / _329.ww) * float2(0.5, -0.5)) + float2(0.5);
        }
        float4 _604 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_599, _563), level(0.0));
        float3 _616 = _543.xyz + (((_604.xyz * _571).xyz * View.View_OneOverPreExposure).xyz * _536);
        float4 _619 = float4(_616.x, _616.y, _616.z, _107.w);
        _619.w = _536 * (1.0 - (_571 * (1.0 - _604.w)));
        _620 = _619;
    }
    else
    {
        _620 = _543;
    }
    out.out_var_TEXCOORD10_centroid = float4(_272[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_272[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _354;
    out.out_var_TEXCOORD4 = float4(_336.x, _336.y, _342.x, _342.y);
    out.out_var_TEXCOORD7 = _620;
    out.gl_Position = _329;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

