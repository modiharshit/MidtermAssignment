

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

struct type_Globals
{
    spvUnsafeArray<float4, 10> SplineParams;
};

constant float3x3 _100 = {};
constant float4 _101 = {};
constant float2 _102 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD0_0 [[user(locn2)]];
    float4 out_var_TEXCOORD7 [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    float2 in_var_ATTRIBUTE4 [[attribute(4)]];
};

vertex Main_out Main_00004247_d8d5c5de(Main_in in [[stage_in]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_Globals& _Globals [[buffer(3)]], texturecube<float> TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap [[texture(0)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(1)]], sampler TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler [[sampler(0)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(1)]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    float _144 = dot(in.in_var_ATTRIBUTE0.xyz, _Globals.SplineParams[7].xyz);
    float _148 = _144 * _Globals.SplineParams[6].w;
    float _152 = _148 - _Globals.SplineParams[4].w;
    bool _156 = _Globals.SplineParams[3].w != 0.0;
    float _157 = smoothstep(0.0, 1.0, _152);
    float _158 = _156 ? _157 : _152;
    float3 _169 = _Globals.SplineParams[0].xyz * 6.0;
    float3 _170 = _Globals.SplineParams[1].xyz * 3.0;
    float3 _171 = _169 + _170;
    float3 _172 = _Globals.SplineParams[4].xyz * 3.0;
    float3 _173 = _171 + _172;
    float3 _174 = _Globals.SplineParams[3].xyz * 6.0;
    float3 _175 = _173 - _174;
    float3 _176 = _Globals.SplineParams[0].xyz * (-6.0);
    float3 _177 = _Globals.SplineParams[1].xyz * 4.0;
    float3 _178 = _176 - _177;
    float3 _179 = _Globals.SplineParams[4].xyz * 2.0;
    float3 _180 = _178 - _179;
    float3 _181 = _180 + _174;
    float _182 = _152 * _152;
    float3 _183 = _175 * _182;
    float3 _184 = _181 * _152;
    float3 _185 = _183 + _184;
    float3 _186 = _185 + _Globals.SplineParams[1].xyz;
    float3 _187 = normalize(_186);
    float3 _190 = cross(_Globals.SplineParams[6].xyz, _187);
    float3 _191 = normalize(_190);
    float3 _192 = cross(_187, _191);
    float3 _193 = normalize(_192);
    float _198 = mix(_Globals.SplineParams[0].w, _Globals.SplineParams[1].w, _158);
    float _199 = sin(_198);
    float _200 = cos(_198);
    float3 _201 = _191 * _200;
    float3 _202 = _193 * _199;
    float3 _203 = _201 - _202;
    float3 _204 = _193 * _200;
    float3 _205 = _191 * _199;
    float3 _206 = _204 + _205;
    float2 _213 = float2(_158);
    float2 _214 = mix(_Globals.SplineParams[2].xy, _Globals.SplineParams[5].xy, _213);
    float _215 = _214.x;
    float _220 = _214.y;
    float3x3 _231 = float3x3(_Globals.SplineParams[7].xyz, _Globals.SplineParams[8].xyz, _Globals.SplineParams[9].xyz);
    float3x3 _232 = transpose(_231);
    float3x3 _234 = float3x3(_187, _203 * float(int(sign(_215))), _206 * float(int(sign(_220)))) * _232;
    float3 _238 = (_234 * in.in_var_ATTRIBUTE2.xyz).xyz;
    float3 _240 = cross(_238, _234 * in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _243 = _100;
    _243[0] = cross(_240, _238) * in.in_var_ATTRIBUTE2.w;
    float3x3 _244 = _243;
    _244[1] = _240;
    float3x3 _245 = _244;
    _245[2] = _238;
    float3x3 _259 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _259[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _262 = _259;
    _262[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _265 = _262;
    _265[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _266 = _265 * _245;
    float _270 = _182 * _152;
    float _271 = 2.0 * _270;
    float _272 = 3.0 * _182;
    float _273 = _271 - _272;
    float _274 = _273 + 1.0;
    float3 _275 = _Globals.SplineParams[0].xyz * _274;
    float _276 = 2.0 * _182;
    float _277 = _270 - _276;
    float _278 = _277 + _152;
    float3 _279 = _Globals.SplineParams[1].xyz * _278;
    float3 _280 = _275 + _279;
    float _281 = _270 - _182;
    float3 _282 = _Globals.SplineParams[4].xyz * _281;
    float3 _283 = _280 + _282;
    float _284 = (-2.0) * _270;
    float _285 = _284 + _272;
    float3 _286 = _Globals.SplineParams[3].xyz * _285;
    float3 _287 = _283 + _286;
    float2 _290 = mix(_Globals.SplineParams[2].zw, _Globals.SplineParams[5].zw, _213);
    float _291 = _290.x;
    float3 _292 = _191 * _291;
    float3 _293 = _287 + _292;
    float _294 = _290.y;
    float3 _295 = _193 * _294;
    float3 _296 = _293 + _295;
    float3 _297 = _203 * _215;
    float3 _298 = _206 * _220;
    float3x3 _299 = float3x3(float3(0.0), _297, _298);
    float3x3 _300 = _299 * _232;
    float3 _301 = _300[0];
    float3 _302 = _300[1];
    float3 _303 = _300[2];
    float4x3 _304 = float4x3(_301, _302, _303, _296);
    float3 _305 = _304 * in.in_var_ATTRIBUTE0;
    float3 _306 = _305.xxx;
    float3 _307 = Primitive.Primitive_LocalToWorld[0].xyz * _306;
    float3 _308 = _305.yyy;
    float3 _309 = Primitive.Primitive_LocalToWorld[1].xyz * _308;
    float3 _310 = _307 + _309;
    float3 _311 = _305.zzz;
    float3 _312 = Primitive.Primitive_LocalToWorld[2].xyz * _311;
    float3 _313 = _310 + _312;
    float3 _316 = Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation;
    float3 _317 = _313 + _316;
    float _318 = _317.x;
    float _319 = _317.y;
    float _320 = _317.z;
    float4 _321 = float4(_318, _319, _320, 1.0);
    float4 _322 = float4(_321.x, _321.y, _321.z, _321.w);
    float4 _323 = View.View_TranslatedWorldToClip * _322;
    spvUnsafeArray<float4, 1> _335 = { float4(in.in_var_ATTRIBUTE4.x, in.in_var_ATTRIBUTE4.y, float4(0.0).z, float4(0.0).w) };
    float3 _336 = _321.xyz;
    float3 _337 = _336 - View.View_TranslatedWorldCameraOrigin;
    float _354 = fast::min(View.View_WorldCameraOrigin.z, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.z);
    float _357 = _337.z + (View.View_WorldCameraOrigin.z - _354);
    float3 _358 = _337;
    _358.z = _357;
    float _359 = dot(_358, _358);
    float _360 = rsqrt(_359);
    float _361 = _359 * _360;
    float _369 = fast::max(fast::max(View.View_VolumetricFogMaxDistance * (length(_337) / dot(_337, View.View_ViewForward)), 0.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.w);
    float _403;
    float _404;
    float _405;
    float _406;
    if (_369 > 0.0)
    {
        float _373 = _369 * _360;
        float _374 = _373 * _357;
        float _375 = _354 + _374;
        _403 = (1.0 - _373) * _361;
        _404 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.z * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * (_375 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.w)));
        _405 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.x * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * (_375 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.y)));
        _406 = _357 - _374;
    }
    else
    {
        _403 = _361;
        _404 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.x;
        _405 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.x;
        _406 = _357;
    }
    float _410 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * _406);
    float _424 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * _406);
    float _435 = (_405 * ((abs(_410) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_410)) / _410) : (0.693147182464599609375 - (0.2402265071868896484375 * _410)))) + (_404 * ((abs(_424) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_424)) / _424) : (0.693147182464599609375 - (0.2402265071868896484375 * _424))));
    float3 _477;
    if (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.z > 0.0)
    {
        float2 _462 = float2(dot(_358.xy, float2(TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation.y, -TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation.x)), dot(_358.xy, TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation));
        float3 _463 = float3(_462.x, _462.y, _358.z);
        _477 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.xyz * mix(TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap.sample(TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler, _463, level(TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.z)).xyz, TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap.sample(TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler, _463, level(0.0)).xyz, float3(fast::clamp((_361 * TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.x) + TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.y, 0.0, 1.0)));
    }
    else
    {
        _477 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.xyz;
    }
    float3 _505;
    if ((TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.w >= 0.0) && (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.z == 0.0))
    {
        _505 = (TranslucentBasePass.TranslucentBasePass_Shared_Fog_DirectionalInscatteringColor.xyz * pow(fast::clamp(dot(_358 * _360, TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.xyz), 0.0, 1.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_DirectionalInscatteringColor.w)) * (1.0 - fast::clamp(exp2(-(_435 * fast::max(_403 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.w, 0.0))), 0.0, 1.0));
    }
    else
    {
        _505 = float3(0.0);
    }
    bool _514 = (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w > 0.0) && (_361 > TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w);
    float _517 = _514 ? 1.0 : fast::max(fast::clamp(exp2(-(_435 * _403)), 0.0, 1.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.w);
    float4 _524 = float4((_477 * (1.0 - _517)) + select(_505, float3(0.0), bool3(_514)), _517);
    float4 _601;
    if (View.View_SkyAtmosphereApplyCameraAerialPerspectiveVolume > 0.0)
    {
        float3 _538 = (_336 * 9.9999997473787516355514526367188e-06) - (View.View_TranslatedWorldCameraOrigin * 9.9999997473787516355514526367188e-06);
        float _544 = sqrt((fast::max(0.0, length(_538) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
        float _545 = _544 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
        float _552;
        if (_545 < 0.707106769084930419921875)
        {
            _552 = fast::clamp((_545 * _545) * 2.0, 0.0, 1.0);
        }
        else
        {
            _552 = 1.0;
        }
        float2 _580;
        if (View.View_RealTimeReflectionCapture != 0.0)
        {
            float3 _555 = normalize(_538);
            float _556 = _555.z;
            float _559 = sqrt(1.0 - (_556 * _556));
            float2 _562 = _102;
            _562.y = (_556 * 0.5) + 0.5;
            float _567 = acos(_555.x / _559);
            float2 _572 = _562;
            _572.x = (((_555.y / _559) < 0.0) ? (6.283185482025146484375 - _567) : _567) * 0.15915493667125701904296875;
            _580 = (_572 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
        }
        else
        {
            _580 = ((_323.xy / _323.ww) * float2(0.5, -0.5)) + float2(0.5);
        }
        float4 _585 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_580, _544), level(0.0));
        float3 _597 = _524.xyz + (((_585.xyz * _552).xyz * View.View_OneOverPreExposure).xyz * _517);
        float4 _600 = float4(_597.x, _597.y, _597.z, _101.w);
        _600.w = _517 * (1.0 - (_552 * (1.0 - _585.w)));
        _601 = _600;
    }
    else
    {
        _601 = _524;
    }
    out.out_var_TEXCOORD10_centroid = float4(_266[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_266[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _335;
    out.out_var_TEXCOORD7 = _601;
    out.gl_Position = _323;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

