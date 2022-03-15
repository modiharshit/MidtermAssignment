

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

constant float4 _84 = {};
constant float2 _85 = {};

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

vertex Main_out Main_0000280a_1c8f012d(Main_in in [[stage_in]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_BeamTrailVF& BeamTrailVF [[buffer(3)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(0)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(0)]])
{
    Main_out out = {};
    float3 _128 = Primitive.Primitive_LocalToWorld[0u].xyz * in.in_var_ATTRIBUTE0.xxx;
    float3 _133 = Primitive.Primitive_LocalToWorld[1u].xyz * in.in_var_ATTRIBUTE0.yyy;
    float3 _134 = _128 + _133;
    float3 _139 = Primitive.Primitive_LocalToWorld[2u].xyz * in.in_var_ATTRIBUTE0.zzz;
    float3 _140 = _134 + _139;
    float3 _144 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _145 = _140 + _144;
    float _146 = _145.x;
    float _147 = _145.y;
    float _148 = _145.z;
    float4 _149 = float4(_146, _147, _148, 1.0);
    float4 _150 = float4(_149.x, _149.y, _149.z, _149.w);
    float4 _151 = View.View_TranslatedWorldToClip * _150;
    float3 _165 = _149.xyz;
    float3 _166 = View.View_WorldCameraOrigin - _165;
    float3 _173 = _165 - float4((((Primitive.Primitive_LocalToWorld[0u].xyz * in.in_var_ATTRIBUTE1.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * in.in_var_ATTRIBUTE1.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * in.in_var_ATTRIBUTE1.zzz)) + _144, 1.0).xyz;
    float _184 = cos(in.in_var_ATTRIBUTE2.z);
    float _187 = sin(in.in_var_ATTRIBUTE2.z);
    float3 _193 = cross(_166 / float3(sqrt(fast::max(dot(_166, _166), 0.00999999977648258209228515625))), _173 / float3(sqrt(fast::max(dot(_173, _173), 0.00999999977648258209228515625))));
    bool4 _206 = bool4(BeamTrailVF.BeamTrailVF_ScreenAlignment.x > 1.5);
    float3 _209 = select((BeamTrailVF.BeamTrailVF_CameraUp * ((-1.0) * _184)) + (BeamTrailVF.BeamTrailVF_CameraRight * _187), float4(_193 / float3(sqrt(fast::max(dot(_193, _193), 0.00999999977648258209228515625))), 0.0), _206).xyz;
    float3 _210 = select((BeamTrailVF.BeamTrailVF_CameraUp * _187) + (BeamTrailVF.BeamTrailVF_CameraRight * _184), float4(0.0), _206).xyz;
    float3x3 _214 = float3x3(_209, _210, -normalize(cross(_209, _210)));
    float3x3 _223 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz) * _214;
    float3 _224 = _223[0];
    float4 _226 = float4(_224.x, _224.y, _224.z, _84.w);
    _226.w = 0.0;
    float3 _236 = _149.xyz;
    float3 _237 = _236 - View.View_TranslatedWorldCameraOrigin;
    float _253 = fast::min(View.View_WorldCameraOrigin.z, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.z);
    float _256 = _237.z + (View.View_WorldCameraOrigin.z - _253);
    float3 _257 = _237;
    _257.z = _256;
    float _258 = dot(_257, _257);
    float _259 = rsqrt(_258);
    float _260 = _258 * _259;
    float _267 = fast::max(fast::max(View.View_VolumetricFogMaxDistance * (length(_237) / dot(_237, View.View_ViewForward)), 0.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.w);
    float _301;
    float _302;
    float _303;
    float _304;
    if (_267 > 0.0)
    {
        float _271 = _267 * _259;
        float _272 = _271 * _256;
        float _273 = _253 + _272;
        _301 = (1.0 - _271) * _260;
        _302 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.z * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * (_273 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.w)));
        _303 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.x * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * (_273 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.y)));
        _304 = _256 - _272;
    }
    else
    {
        _301 = _260;
        _302 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.x;
        _303 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.x;
        _304 = _256;
    }
    float _308 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * _304);
    float _322 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * _304);
    float _344 = ((TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w > 0.0) && (_260 > TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w)) ? 1.0 : fast::max(fast::clamp(exp2(-(((_303 * ((abs(_308) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_308)) / _308) : (0.693147182464599609375 - (0.2402265071868896484375 * _308)))) + (_302 * ((abs(_322) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_322)) / _322) : (0.693147182464599609375 - (0.2402265071868896484375 * _322))))) * _301)), 0.0, 1.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.w);
    float4 _345 = float4(0.0, 0.0, 0.0, _344);
    float4 _422;
    if (View.View_SkyAtmosphereApplyCameraAerialPerspectiveVolume > 0.0)
    {
        float3 _359 = (_236 * 9.9999997473787516355514526367188e-06) - (View.View_TranslatedWorldCameraOrigin * 9.9999997473787516355514526367188e-06);
        float _365 = sqrt((fast::max(0.0, length(_359) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
        float _366 = _365 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
        float _373;
        if (_366 < 0.707106769084930419921875)
        {
            _373 = fast::clamp((_366 * _366) * 2.0, 0.0, 1.0);
        }
        else
        {
            _373 = 1.0;
        }
        float2 _401;
        if (View.View_RealTimeReflectionCapture != 0.0)
        {
            float3 _376 = normalize(_359);
            float _377 = _376.z;
            float _380 = sqrt(1.0 - (_377 * _377));
            float2 _383 = _85;
            _383.y = (_377 * 0.5) + 0.5;
            float _388 = acos(_376.x / _380);
            float2 _393 = _383;
            _393.x = (((_376.y / _380) < 0.0) ? (6.283185482025146484375 - _388) : _388) * 0.15915493667125701904296875;
            _401 = (_393 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
        }
        else
        {
            _401 = ((_151.xy / _151.ww) * float2(0.5, -0.5)) + float2(0.5);
        }
        float4 _406 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_401, _365), level(0.0));
        float3 _418 = _345.xyz + (((_406.xyz * _373).xyz * View.View_OneOverPreExposure).xyz * _344);
        float4 _421 = float4(_418.x, _418.y, _418.z, _84.w);
        _421.w = _344 * (1.0 - (_373 * (1.0 - _406.w)));
        _422 = _421;
    }
    else
    {
        _422 = _345;
    }
    out.out_var_TEXCOORD10_centroid = _226;
    out.out_var_TEXCOORD11_centroid = float4(_223[2], float(int(sign(determinant(_214)))));
    out.out_var_TEXCOORD2 = in.in_var_ATTRIBUTE3;
    out.out_var_TEXCOORD3 = in.in_var_ATTRIBUTE4;
    out.out_var_TEXCOORD7 = _422;
    out.gl_Position = _151;
    return out;
}

