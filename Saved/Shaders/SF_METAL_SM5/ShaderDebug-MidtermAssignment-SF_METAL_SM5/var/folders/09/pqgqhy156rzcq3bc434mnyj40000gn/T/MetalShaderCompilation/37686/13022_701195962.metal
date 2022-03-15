

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
};

struct type_BeamTrailVF
{
    float4 BeamTrailVF_CameraRight;
    float4 BeamTrailVF_CameraUp;
    float4 BeamTrailVF_ScreenAlignment;
};

constant float4 _91 = {};
constant float2 _92 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD2 [[user(locn2)]];
    float4 out_var_TEXCOORD3 [[user(locn3)]];
    float4 out_var_TEXCOORD7 [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    float4 in_var_ATTRIBUTE3 [[attribute(3)]];
    float4 in_var_ATTRIBUTE4 [[attribute(4)]];
};

vertex Main_out Main_000032de_29cb66ba(Main_in in [[stage_in]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_BeamTrailVF& BeamTrailVF [[buffer(3)]], texturecube<float> TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap [[texture(0)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(1)]], sampler TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler [[sampler(0)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(1)]])
{
    Main_out out = {};
    float3 _136 = Primitive.Primitive_LocalToWorld[0u].xyz * in.in_var_ATTRIBUTE0.xxx;
    float3 _141 = Primitive.Primitive_LocalToWorld[1u].xyz * in.in_var_ATTRIBUTE0.yyy;
    float3 _142 = _136 + _141;
    float3 _147 = Primitive.Primitive_LocalToWorld[2u].xyz * in.in_var_ATTRIBUTE0.zzz;
    float3 _148 = _142 + _147;
    float3 _152 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _153 = _148 + _152;
    float _154 = _153.x;
    float _155 = _153.y;
    float _156 = _153.z;
    float4 _157 = float4(_154, _155, _156, 1.0);
    float4 _158 = float4(_157.x, _157.y, _157.z, _157.w);
    float4 _159 = View.View_TranslatedWorldToClip * _158;
    float3 _173 = _157.xyz;
    float3 _174 = View.View_WorldCameraOrigin - _173;
    float3 _181 = _173 - float4((((Primitive.Primitive_LocalToWorld[0u].xyz * in.in_var_ATTRIBUTE1.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * in.in_var_ATTRIBUTE1.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * in.in_var_ATTRIBUTE1.zzz)) + _152, 1.0).xyz;
    float _192 = cos(in.in_var_ATTRIBUTE2.z);
    float _195 = sin(in.in_var_ATTRIBUTE2.z);
    float3 _201 = cross(_174 / float3(sqrt(fast::max(dot(_174, _174), 0.00999999977648258209228515625))), _181 / float3(sqrt(fast::max(dot(_181, _181), 0.00999999977648258209228515625))));
    bool4 _214 = bool4(BeamTrailVF.BeamTrailVF_ScreenAlignment.x > 1.5);
    float3 _217 = select((BeamTrailVF.BeamTrailVF_CameraUp * ((-1.0) * _192)) + (BeamTrailVF.BeamTrailVF_CameraRight * _195), float4(_201 / float3(sqrt(fast::max(dot(_201, _201), 0.00999999977648258209228515625))), 0.0), _214).xyz;
    float3 _218 = select((BeamTrailVF.BeamTrailVF_CameraUp * _195) + (BeamTrailVF.BeamTrailVF_CameraRight * _192), float4(0.0), _214).xyz;
    float3x3 _222 = float3x3(_217, _218, -normalize(cross(_217, _218)));
    float3x3 _231 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz) * _222;
    float3 _232 = _231[0];
    float4 _234 = float4(_232.x, _232.y, _232.z, _91.w);
    _234.w = 0.0;
    float3 _244 = _157.xyz;
    float3 _245 = _244 - View.View_TranslatedWorldCameraOrigin;
    float _262 = fast::min(View.View_WorldCameraOrigin.z, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.z);
    float _265 = _245.z + (View.View_WorldCameraOrigin.z - _262);
    float3 _266 = _245;
    _266.z = _265;
    float _267 = dot(_266, _266);
    float _268 = rsqrt(_267);
    float _269 = _267 * _268;
    float _277 = fast::max(fast::max(View.View_VolumetricFogMaxDistance * (length(_245) / dot(_245, View.View_ViewForward)), 0.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.w);
    float _311;
    float _312;
    float _313;
    float _314;
    if (_277 > 0.0)
    {
        float _281 = _277 * _268;
        float _282 = _281 * _265;
        float _283 = _262 + _282;
        _311 = (1.0 - _281) * _269;
        _312 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.z * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * (_283 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.w)));
        _313 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.x * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * (_283 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.y)));
        _314 = _265 - _282;
    }
    else
    {
        _311 = _269;
        _312 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.x;
        _313 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.x;
        _314 = _265;
    }
    float _318 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * _314);
    float _332 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * _314);
    float _343 = (_313 * ((abs(_318) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_318)) / _318) : (0.693147182464599609375 - (0.2402265071868896484375 * _318)))) + (_312 * ((abs(_332) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_332)) / _332) : (0.693147182464599609375 - (0.2402265071868896484375 * _332))));
    float3 _385;
    if (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.z > 0.0)
    {
        float2 _370 = float2(dot(_266.xy, float2(TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation.y, -TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation.x)), dot(_266.xy, TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation));
        float3 _371 = float3(_370.x, _370.y, _266.z);
        _385 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.xyz * mix(TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap.sample(TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler, _371, level(TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.z)).xyz, TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap.sample(TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler, _371, level(0.0)).xyz, float3(fast::clamp((_269 * TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.x) + TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.y, 0.0, 1.0)));
    }
    else
    {
        _385 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.xyz;
    }
    float3 _413;
    if ((TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.w >= 0.0) && (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.z == 0.0))
    {
        _413 = (TranslucentBasePass.TranslucentBasePass_Shared_Fog_DirectionalInscatteringColor.xyz * pow(fast::clamp(dot(_266 * _268, TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.xyz), 0.0, 1.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_DirectionalInscatteringColor.w)) * (1.0 - fast::clamp(exp2(-(_343 * fast::max(_311 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.w, 0.0))), 0.0, 1.0));
    }
    else
    {
        _413 = float3(0.0);
    }
    bool _422 = (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w > 0.0) && (_269 > TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w);
    float _425 = _422 ? 1.0 : fast::max(fast::clamp(exp2(-(_343 * _311)), 0.0, 1.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.w);
    float4 _432 = float4((_385 * (1.0 - _425)) + select(_413, float3(0.0), bool3(_422)), _425);
    float4 _509;
    if (View.View_SkyAtmosphereApplyCameraAerialPerspectiveVolume > 0.0)
    {
        float3 _446 = (_244 * 9.9999997473787516355514526367188e-06) - (View.View_TranslatedWorldCameraOrigin * 9.9999997473787516355514526367188e-06);
        float _452 = sqrt((fast::max(0.0, length(_446) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
        float _453 = _452 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
        float _460;
        if (_453 < 0.707106769084930419921875)
        {
            _460 = fast::clamp((_453 * _453) * 2.0, 0.0, 1.0);
        }
        else
        {
            _460 = 1.0;
        }
        float2 _488;
        if (View.View_RealTimeReflectionCapture != 0.0)
        {
            float3 _463 = normalize(_446);
            float _464 = _463.z;
            float _467 = sqrt(1.0 - (_464 * _464));
            float2 _470 = _92;
            _470.y = (_464 * 0.5) + 0.5;
            float _475 = acos(_463.x / _467);
            float2 _480 = _470;
            _480.x = (((_463.y / _467) < 0.0) ? (6.283185482025146484375 - _475) : _475) * 0.15915493667125701904296875;
            _488 = (_480 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
        }
        else
        {
            _488 = ((_159.xy / _159.ww) * float2(0.5, -0.5)) + float2(0.5);
        }
        float4 _493 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_488, _452), level(0.0));
        float3 _505 = _432.xyz + (((_493.xyz * _460).xyz * View.View_OneOverPreExposure).xyz * _425);
        float4 _508 = float4(_505.x, _505.y, _505.z, _91.w);
        _508.w = _425 * (1.0 - (_460 * (1.0 - _493.w)));
        _509 = _508;
    }
    else
    {
        _509 = _432;
    }
    out.out_var_TEXCOORD10_centroid = _234;
    out.out_var_TEXCOORD11_centroid = float4(_231[2], float(int(sign(determinant(_222)))));
    out.out_var_TEXCOORD2 = in.in_var_ATTRIBUTE3;
    out.out_var_TEXCOORD3 = in.in_var_ATTRIBUTE4;
    out.out_var_TEXCOORD7 = _509;
    out.gl_Position = _159;
    return out;
}

