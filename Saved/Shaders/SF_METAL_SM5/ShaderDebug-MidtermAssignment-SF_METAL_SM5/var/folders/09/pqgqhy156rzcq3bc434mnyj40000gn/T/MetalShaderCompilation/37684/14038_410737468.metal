

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
    char _m0_pad[64];
    float4 Primitive_InvNonUniformScaleAndDeterminantSign;
};

struct type_MeshParticleVF
{
    float4 MeshParticleVF_SubImageSize;
};

constant float4 _102 = {};
constant float4 _103 = {};
constant float2 _104 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD1 [[user(locn2)]];
    float4 out_var_TEXCOORD2 [[user(locn3)]];
    float4 out_var_COLOR1 [[user(locn4)]];
    float4 out_var_TEXCOORD7 [[user(locn5)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    float2 in_var_ATTRIBUTE4_0 [[attribute(4)]];
    float4 in_var_ATTRIBUTE8 [[attribute(8)]];
    float4 in_var_ATTRIBUTE9 [[attribute(9)]];
    float4 in_var_ATTRIBUTE10 [[attribute(10)]];
    int4 in_var_ATTRIBUTE11 [[attribute(11)]];
    float2 in_var_ATTRIBUTE12 [[attribute(12)]];
    float4 in_var_ATTRIBUTE14 [[attribute(14)]];
};

vertex Main_out Main_000036d6_187b5b3c(Main_in in [[stage_in]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_MeshParticleVF& MeshParticleVF [[buffer(3)]], texturecube<float> TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap [[texture(0)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(1)]], sampler TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler [[sampler(0)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(1)]])
{
    Main_out out = {};
    spvUnsafeArray<float2, 1> in_var_ATTRIBUTE4 = {};
    in_var_ATTRIBUTE4[0] = in.in_var_ATTRIBUTE4_0;
    float2 _158 = (float2(float(in.in_var_ATTRIBUTE11.x), float(in.in_var_ATTRIBUTE11.y)) + in_var_ATTRIBUTE4[0]) * MeshParticleVF.MeshParticleVF_SubImageSize.xy;
    float2 _165 = (float2(float(in.in_var_ATTRIBUTE11.z), float(in.in_var_ATTRIBUTE11.w)) + in_var_ATTRIBUTE4[0]) * MeshParticleVF.MeshParticleVF_SubImageSize.xy;
    float4x4 _167 = float4x4(in.in_var_ATTRIBUTE8, in.in_var_ATTRIBUTE9, in.in_var_ATTRIBUTE10, float4(0.0, 0.0, 0.0, 1.0));
    float4x4 _168 = transpose(_167);
    float4 _169 = _168 * in.in_var_ATTRIBUTE0;
    float3 _170 = _169.xyz;
    float3 _171 = _170 + View.View_PreViewTranslation;
    float _173 = _171.x;
    float _174 = _171.y;
    float _175 = _171.z;
    float4 _176 = float4(_173, _174, _175, in.in_var_ATTRIBUTE0.w);
    float4 _177 = float4(_176.x, _176.y, _176.z, _176.w);
    float4 _178 = View.View_TranslatedWorldToClip * _177;
    float2 _179 = float2(in.in_var_ATTRIBUTE12.x);
    float4 _182 = _103;
    _182.w = 0.0;
    float3x3 _184 = float3x3(float3(0.0), float3(0.0), float3(0.0));
    _184[2] = in.in_var_ATTRIBUTE2.xyz;
    float3 _187 = cross(in.in_var_ATTRIBUTE2.xyz, in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _188 = _184;
    _188[1] = _187;
    float3x3 _191 = _188;
    _191[0] = cross(_187, in.in_var_ATTRIBUTE2.xyz) * in.in_var_ATTRIBUTE2.w;
    float3x3 _199 = float3x3(_168[0].xyz, _168[1].xyz, _168[2].xyz) * _191;
    float3 _201 = normalize(_199[0]);
    float3 _212 = _176.xyz;
    float3 _213 = _212 - View.View_TranslatedWorldCameraOrigin;
    float _230 = fast::min(View.View_WorldCameraOrigin.z, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.z);
    float _233 = _213.z + (View.View_WorldCameraOrigin.z - _230);
    float3 _234 = _213;
    _234.z = _233;
    float _235 = dot(_234, _234);
    float _236 = rsqrt(_235);
    float _237 = _235 * _236;
    float _245 = fast::max(fast::max(View.View_VolumetricFogMaxDistance * (length(_213) / dot(_213, View.View_ViewForward)), 0.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.w);
    float _279;
    float _280;
    float _281;
    float _282;
    if (_245 > 0.0)
    {
        float _249 = _245 * _236;
        float _250 = _249 * _233;
        float _251 = _230 + _250;
        _279 = (1.0 - _249) * _237;
        _280 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.z * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * (_251 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.w)));
        _281 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.x * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * (_251 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.y)));
        _282 = _233 - _250;
    }
    else
    {
        _279 = _237;
        _280 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.x;
        _281 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.x;
        _282 = _233;
    }
    float _286 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * _282);
    float _300 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * _282);
    float _311 = (_281 * ((abs(_286) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_286)) / _286) : (0.693147182464599609375 - (0.2402265071868896484375 * _286)))) + (_280 * ((abs(_300) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_300)) / _300) : (0.693147182464599609375 - (0.2402265071868896484375 * _300))));
    float3 _353;
    if (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.z > 0.0)
    {
        float2 _338 = float2(dot(_234.xy, float2(TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation.y, -TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation.x)), dot(_234.xy, TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation));
        float3 _339 = float3(_338.x, _338.y, _234.z);
        _353 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.xyz * mix(TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap.sample(TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler, _339, level(TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.z)).xyz, TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap.sample(TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler, _339, level(0.0)).xyz, float3(fast::clamp((_237 * TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.x) + TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.y, 0.0, 1.0)));
    }
    else
    {
        _353 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.xyz;
    }
    float3 _381;
    if ((TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.w >= 0.0) && (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.z == 0.0))
    {
        _381 = (TranslucentBasePass.TranslucentBasePass_Shared_Fog_DirectionalInscatteringColor.xyz * pow(fast::clamp(dot(_234 * _236, TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.xyz), 0.0, 1.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_DirectionalInscatteringColor.w)) * (1.0 - fast::clamp(exp2(-(_311 * fast::max(_279 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.w, 0.0))), 0.0, 1.0));
    }
    else
    {
        _381 = float3(0.0);
    }
    bool _390 = (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w > 0.0) && (_237 > TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w);
    float _393 = _390 ? 1.0 : fast::max(fast::clamp(exp2(-(_311 * _279)), 0.0, 1.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.w);
    float4 _400 = float4((_353 * (1.0 - _393)) + select(_381, float3(0.0), bool3(_390)), _393);
    float4 _477;
    if (View.View_SkyAtmosphereApplyCameraAerialPerspectiveVolume > 0.0)
    {
        float3 _414 = (_212 * 9.9999997473787516355514526367188e-06) - (View.View_TranslatedWorldCameraOrigin * 9.9999997473787516355514526367188e-06);
        float _420 = sqrt((fast::max(0.0, length(_414) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
        float _421 = _420 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
        float _428;
        if (_421 < 0.707106769084930419921875)
        {
            _428 = fast::clamp((_421 * _421) * 2.0, 0.0, 1.0);
        }
        else
        {
            _428 = 1.0;
        }
        float2 _456;
        if (View.View_RealTimeReflectionCapture != 0.0)
        {
            float3 _431 = normalize(_414);
            float _432 = _431.z;
            float _435 = sqrt(1.0 - (_432 * _432));
            float2 _438 = _104;
            _438.y = (_432 * 0.5) + 0.5;
            float _443 = acos(_431.x / _435);
            float2 _448 = _438;
            _448.x = (((_431.y / _435) < 0.0) ? (6.283185482025146484375 - _443) : _443) * 0.15915493667125701904296875;
            _456 = (_448 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
        }
        else
        {
            _456 = ((_178.xy / _178.ww) * float2(0.5, -0.5)) + float2(0.5);
        }
        float4 _461 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_456, _420), level(0.0));
        float3 _473 = _400.xyz + (((_461.xyz * _428).xyz * View.View_OneOverPreExposure).xyz * _393);
        float4 _476 = float4(_473.x, _473.y, _473.z, _102.w);
        _476.w = _393 * (1.0 - (_428 * (1.0 - _461.w)));
        _477 = _476;
    }
    else
    {
        _477 = _400;
    }
    out.out_var_TEXCOORD10_centroid = float4(_201.x, _201.y, _201.z, _182.w);
    out.out_var_TEXCOORD11_centroid = float4(normalize(_199[2]), in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_TEXCOORD1 = float4(_158.x, _158.y, float2(0.0).x, float2(0.0).y);
    out.out_var_TEXCOORD2 = float4(_165.x, _165.y, _179.x, _179.y);
    out.out_var_COLOR1 = in.in_var_ATTRIBUTE14;
    out.out_var_TEXCOORD7 = _477;
    out.gl_Position = _178;
    return out;
}

