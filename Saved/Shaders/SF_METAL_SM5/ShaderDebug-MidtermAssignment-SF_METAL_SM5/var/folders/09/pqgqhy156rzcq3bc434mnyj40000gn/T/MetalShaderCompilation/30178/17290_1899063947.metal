

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
    uint NumBoneInfluencesParam;
};

constant spvUnsafeArray<float2, 1> _99 = spvUnsafeArray<float2, 1>({ float2(0.0) });

constant float3x3 _105 = {};
constant float4 _106 = {};
constant float4 _107 = {};
constant float2 _108 = {};

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
    uint4 in_var_ATTRIBUTE3 [[attribute(3)]];
    float4 in_var_ATTRIBUTE4 [[attribute(4)]];
    float2 in_var_ATTRIBUTE5_0 [[attribute(5)]];
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
    uint4 in_var_ATTRIBUTE14 [[attribute(14)]];
    float4 in_var_ATTRIBUTE15 [[attribute(15)]];
};

vertex Main_out Main_0000438a_71316a8b(Main_in in [[stage_in]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]], texture_buffer<float> BoneMatrices [[texture(0)]], texturecube<float> TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap [[texture(1)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(2)]], sampler TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler [[sampler(0)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(1)]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    spvUnsafeArray<float2, 1> in_var_ATTRIBUTE5 = {};
    in_var_ATTRIBUTE5[0] = in.in_var_ATTRIBUTE5_0;
    float4 _154 = float4(in.in_var_ATTRIBUTE4.x);
    int _157 = int(in.in_var_ATTRIBUTE3.x) * 3;
    float4 _171 = float4(in.in_var_ATTRIBUTE4.y);
    int _174 = int(in.in_var_ATTRIBUTE3.y) * 3;
    float4 _190 = float4(in.in_var_ATTRIBUTE4.z);
    int _193 = int(in.in_var_ATTRIBUTE3.z) * 3;
    float4 _209 = float4(in.in_var_ATTRIBUTE4.w);
    int _212 = int(in.in_var_ATTRIBUTE3.w) * 3;
    float4 _224 = (((_154 * BoneMatrices.read(uint(uint(_157)))) + (_171 * BoneMatrices.read(uint(uint(_174))))) + (_190 * BoneMatrices.read(uint(uint(_193))))) + (_209 * BoneMatrices.read(uint(uint(_212))));
    float4 _225 = (((_154 * BoneMatrices.read(uint(uint(_157 + 1)))) + (_171 * BoneMatrices.read(uint(uint(_174 + 1))))) + (_190 * BoneMatrices.read(uint(uint(_193 + 1))))) + (_209 * BoneMatrices.read(uint(uint(_212 + 1))));
    float4 _226 = (((_154 * BoneMatrices.read(uint(uint(_157 + 2)))) + (_171 * BoneMatrices.read(uint(uint(_174 + 2))))) + (_190 * BoneMatrices.read(uint(uint(_193 + 2))))) + (_209 * BoneMatrices.read(uint(uint(_212 + 2))));
    float3x4 _310;
    if (_Globals.NumBoneInfluencesParam > 4u)
    {
        float4 _234 = float4(in.in_var_ATTRIBUTE15.x);
        int _237 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _253 = float4(in.in_var_ATTRIBUTE15.y);
        int _256 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _272 = float4(in.in_var_ATTRIBUTE15.z);
        int _275 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _291 = float4(in.in_var_ATTRIBUTE15.w);
        int _294 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _310 = float3x4((((_224 + (_234 * BoneMatrices.read(uint(uint(_237))))) + (_253 * BoneMatrices.read(uint(uint(_256))))) + (_272 * BoneMatrices.read(uint(uint(_275))))) + (_291 * BoneMatrices.read(uint(uint(_294)))), (((_225 + (_234 * BoneMatrices.read(uint(uint(_237 + 1))))) + (_253 * BoneMatrices.read(uint(uint(_256 + 1))))) + (_272 * BoneMatrices.read(uint(uint(_275 + 1))))) + (_291 * BoneMatrices.read(uint(uint(_294 + 1)))), (((_226 + (_234 * BoneMatrices.read(uint(uint(_237 + 2))))) + (_253 * BoneMatrices.read(uint(uint(_256 + 2))))) + (_272 * BoneMatrices.read(uint(uint(_275 + 2))))) + (_291 * BoneMatrices.read(uint(uint(_294 + 2)))));
    }
    else
    {
        _310 = float3x4(_224, _225, _226);
    }
    float3 _316 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _310);
    float3x3 _317 = _105;
    _317[0] = _316;
    float3 _323 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _310);
    float3x3 _324 = _317;
    _324[2] = _323;
    float3x3 _329 = _324;
    _329[1] = normalize(cross(_323, _316) * in.in_var_ATTRIBUTE2.w);
    float3 _330 = in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11;
    float _331 = _330.x;
    float _332 = _330.y;
    float _333 = _330.z;
    float4 _334 = float4(_331, _332, _333, 1.0);
    float3 _335 = _334 * _310;
    float3 _336 = _335 + in.in_var_ATTRIBUTE12;
    float3 _341 = _336.xxx;
    float3 _342 = Primitive.Primitive_LocalToWorld[0u].xyz * _341;
    float3 _346 = _336.yyy;
    float3 _347 = Primitive.Primitive_LocalToWorld[1u].xyz * _346;
    float3 _348 = _342 + _347;
    float3 _352 = _336.zzz;
    float3 _353 = Primitive.Primitive_LocalToWorld[2u].xyz * _352;
    float3 _354 = _348 + _353;
    float3 _358 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _359 = _354 + _358;
    float _360 = _359.x;
    float _361 = _359.y;
    float _362 = _359.z;
    float4 _363 = float4(_360, _361, _362, 1.0);
    spvUnsafeArray<float2, 1> _118;
    _118 = in_var_ATTRIBUTE5;
    spvUnsafeArray<float2, 1> _119 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _365 = 0; _365 < 1; )
    {
        _119[_365] = _118[_365];
        _365++;
        continue;
    }
    float4 _374 = float4(_363.x, _363.y, _363.z, _363.w);
    float4 _375 = View.View_TranslatedWorldToClip * _374;
    float4 _378 = _107;
    _378.w = 0.0;
    float3x3 _391 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _391[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _394 = _391;
    _394[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _397 = _394;
    _397[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _398 = _397 * _329;
    float3 _399 = _398[0];
    spvUnsafeArray<float4, 1> _409 = { float4(_119[0].x, _119[0].y, float4(0.0).z, float4(0.0).w) };
    float3 _410 = _363.xyz;
    float3 _411 = _410 - View.View_TranslatedWorldCameraOrigin;
    float _428 = fast::min(View.View_WorldCameraOrigin.z, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.z);
    float _431 = _411.z + (View.View_WorldCameraOrigin.z - _428);
    float3 _432 = _411;
    _432.z = _431;
    float _433 = dot(_432, _432);
    float _434 = rsqrt(_433);
    float _435 = _433 * _434;
    float _443 = fast::max(fast::max(View.View_VolumetricFogMaxDistance * (length(_411) / dot(_411, View.View_ViewForward)), 0.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.w);
    float _477;
    float _478;
    float _479;
    float _480;
    if (_443 > 0.0)
    {
        float _447 = _443 * _434;
        float _448 = _447 * _431;
        float _449 = _428 + _448;
        _477 = (1.0 - _447) * _435;
        _478 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.z * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * (_449 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.w)));
        _479 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.x * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * (_449 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.y)));
        _480 = _431 - _448;
    }
    else
    {
        _477 = _435;
        _478 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.x;
        _479 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.x;
        _480 = _431;
    }
    float _484 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * _480);
    float _498 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * _480);
    float _509 = (_479 * ((abs(_484) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_484)) / _484) : (0.693147182464599609375 - (0.2402265071868896484375 * _484)))) + (_478 * ((abs(_498) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_498)) / _498) : (0.693147182464599609375 - (0.2402265071868896484375 * _498))));
    float3 _551;
    if (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.z > 0.0)
    {
        float2 _536 = float2(dot(_432.xy, float2(TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation.y, -TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation.x)), dot(_432.xy, TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation));
        float3 _537 = float3(_536.x, _536.y, _432.z);
        _551 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.xyz * mix(TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap.sample(TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler, _537, level(TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.z)).xyz, TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap.sample(TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler, _537, level(0.0)).xyz, float3(fast::clamp((_435 * TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.x) + TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.y, 0.0, 1.0)));
    }
    else
    {
        _551 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.xyz;
    }
    float3 _579;
    if ((TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.w >= 0.0) && (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.z == 0.0))
    {
        _579 = (TranslucentBasePass.TranslucentBasePass_Shared_Fog_DirectionalInscatteringColor.xyz * pow(fast::clamp(dot(_432 * _434, TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.xyz), 0.0, 1.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_DirectionalInscatteringColor.w)) * (1.0 - fast::clamp(exp2(-(_509 * fast::max(_477 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.w, 0.0))), 0.0, 1.0));
    }
    else
    {
        _579 = float3(0.0);
    }
    bool _588 = (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w > 0.0) && (_435 > TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w);
    float _591 = _588 ? 1.0 : fast::max(fast::clamp(exp2(-(_509 * _477)), 0.0, 1.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.w);
    float4 _598 = float4((_551 * (1.0 - _591)) + select(_579, float3(0.0), bool3(_588)), _591);
    float4 _675;
    if (View.View_SkyAtmosphereApplyCameraAerialPerspectiveVolume > 0.0)
    {
        float3 _612 = (_410 * 9.9999997473787516355514526367188e-06) - (View.View_TranslatedWorldCameraOrigin * 9.9999997473787516355514526367188e-06);
        float _618 = sqrt((fast::max(0.0, length(_612) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
        float _619 = _618 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
        float _626;
        if (_619 < 0.707106769084930419921875)
        {
            _626 = fast::clamp((_619 * _619) * 2.0, 0.0, 1.0);
        }
        else
        {
            _626 = 1.0;
        }
        float2 _654;
        if (View.View_RealTimeReflectionCapture != 0.0)
        {
            float3 _629 = normalize(_612);
            float _630 = _629.z;
            float _633 = sqrt(1.0 - (_630 * _630));
            float2 _636 = _108;
            _636.y = (_630 * 0.5) + 0.5;
            float _641 = acos(_629.x / _633);
            float2 _646 = _636;
            _646.x = (((_629.y / _633) < 0.0) ? (6.283185482025146484375 - _641) : _641) * 0.15915493667125701904296875;
            _654 = (_646 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
        }
        else
        {
            _654 = ((_375.xy / _375.ww) * float2(0.5, -0.5)) + float2(0.5);
        }
        float4 _659 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_654, _618), level(0.0));
        float3 _671 = _598.xyz + (((_659.xyz * _626).xyz * View.View_OneOverPreExposure).xyz * _591);
        float4 _674 = float4(_671.x, _671.y, _671.z, _106.w);
        _674.w = _591 * (1.0 - (_626 * (1.0 - _659.w)));
        _675 = _674;
    }
    else
    {
        _675 = _598;
    }
    out.out_var_TEXCOORD10_centroid = float4(_399.x, _399.y, _399.z, _378.w);
    out.out_var_TEXCOORD11_centroid = float4(_398[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _409;
    out.out_var_TEXCOORD7 = _675;
    out.gl_Position = _375;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

