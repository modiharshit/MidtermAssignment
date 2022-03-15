

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

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_LocalVF
{
    int4 LocalVF_VertexFetch_Parameters;
};

constant float3x3 _99 = {};
constant float4 _100 = {};
constant float2 _101 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_COLOR0 [[user(locn2)]];
    float4 out_var_TEXCOORD0_0 [[user(locn3)]];
    uint out_var_PRIMITIVE_ID [[user(locn4)]];
    float4 out_var_TEXCOORD7 [[user(locn5)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    uint in_var_ATTRIBUTE13 [[attribute(13)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

vertex Main_out Main_00003d70_43a5b2bd(Main_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(7)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(3)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(4)]], constant type_View& View [[buffer(5)]], constant type_LocalVF& LocalVF [[buffer(6)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(0)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(1)]], texture_buffer<float> LocalVF_VertexFetch_ColorComponentsBuffer [[texture(2)]], texturecube<float> TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap [[texture(3)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(4)]], sampler TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler [[sampler(0)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(1)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[3];
    uint _140 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _148 = 2u * _140;
    float4 _153 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_148 + 1u)));
    float _154 = _153.w;
    float3 _155 = _153.xyz;
    float3 _157 = cross(_155, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_148)).xyz) * _154;
    float3x3 _160 = _99;
    _160[0] = cross(_157, _155) * _154;
    float3x3 _161 = _160;
    _161[1] = _157;
    float3x3 _162 = _161;
    _162[2] = _155;
    uint _163 = in.in_var_ATTRIBUTE13 * 36u;
    uint _166 = _163 + 1u;
    uint _169 = _163 + 2u;
    uint _172 = _163 + 3u;
    uint _178 = _163 + 4u;
    float3x3 _183 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _163)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _166)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _169)].xyz);
    _183[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _163)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _178)].x;
    float3x3 _186 = _183;
    _186[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _166)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _178)].y;
    float3x3 _189 = _186;
    _189[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _169)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _178)].z;
    float3x3 _190 = _189 * _162;
    float3 _200 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _163)].xyz * in.in_var_ATTRIBUTE0.xxx;
    float3 _203 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _166)].xyz * in.in_var_ATTRIBUTE0.yyy;
    float3 _204 = _200 + _203;
    float3 _207 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _169)].xyz * in.in_var_ATTRIBUTE0.zzz;
    float3 _208 = _204 + _207;
    float3 _210 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _172)].xyz + View.View_PreViewTranslation;
    float3 _211 = _208 + _210;
    float _212 = _211.x;
    float _213 = _211.y;
    float _214 = _211.z;
    float4 _215 = float4(_212, _213, _214, 1.0);
    uint _218 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    float4 _224 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(((_218 * _140) + min(0u, (_218 - 1u)))));
    float4 _225 = float4(_215.x, _215.y, _215.z, _215.w);
    float4 _226 = View.View_TranslatedWorldToClip * _225;
    spvUnsafeArray<float4, 1> _238 = { float4(_224.x, _224.y, float4(0.0).z, float4(0.0).w) };
    float3 _239 = _215.xyz;
    float3 _240 = _239 - View.View_TranslatedWorldCameraOrigin;
    float _257 = fast::min(View.View_WorldCameraOrigin.z, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.z);
    float _260 = _240.z + (View.View_WorldCameraOrigin.z - _257);
    float3 _261 = _240;
    _261.z = _260;
    float _262 = dot(_261, _261);
    float _263 = rsqrt(_262);
    float _264 = _262 * _263;
    float _272 = fast::max(fast::max(View.View_VolumetricFogMaxDistance * (length(_240) / dot(_240, View.View_ViewForward)), 0.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.w);
    float _306;
    float _307;
    float _308;
    float _309;
    if (_272 > 0.0)
    {
        float _276 = _272 * _263;
        float _277 = _276 * _260;
        float _278 = _257 + _277;
        _306 = (1.0 - _276) * _264;
        _307 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.z * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * (_278 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.w)));
        _308 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.x * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * (_278 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.y)));
        _309 = _260 - _277;
    }
    else
    {
        _306 = _264;
        _307 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.x;
        _308 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.x;
        _309 = _260;
    }
    float _313 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * _309);
    float _327 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * _309);
    float _338 = (_308 * ((abs(_313) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_313)) / _313) : (0.693147182464599609375 - (0.2402265071868896484375 * _313)))) + (_307 * ((abs(_327) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_327)) / _327) : (0.693147182464599609375 - (0.2402265071868896484375 * _327))));
    float3 _380;
    if (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.z > 0.0)
    {
        float2 _365 = float2(dot(_261.xy, float2(TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation.y, -TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation.x)), dot(_261.xy, TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation));
        float3 _366 = float3(_365.x, _365.y, _261.z);
        _380 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.xyz * mix(TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap.sample(TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler, _366, level(TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.z)).xyz, TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap.sample(TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler, _366, level(0.0)).xyz, float3(fast::clamp((_264 * TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.x) + TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.y, 0.0, 1.0)));
    }
    else
    {
        _380 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.xyz;
    }
    float3 _408;
    if ((TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.w >= 0.0) && (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.z == 0.0))
    {
        _408 = (TranslucentBasePass.TranslucentBasePass_Shared_Fog_DirectionalInscatteringColor.xyz * pow(fast::clamp(dot(_261 * _263, TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.xyz), 0.0, 1.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_DirectionalInscatteringColor.w)) * (1.0 - fast::clamp(exp2(-(_338 * fast::max(_306 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.w, 0.0))), 0.0, 1.0));
    }
    else
    {
        _408 = float3(0.0);
    }
    bool _417 = (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w > 0.0) && (_264 > TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w);
    float _420 = _417 ? 1.0 : fast::max(fast::clamp(exp2(-(_338 * _306)), 0.0, 1.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.w);
    float4 _427 = float4((_380 * (1.0 - _420)) + select(_408, float3(0.0), bool3(_417)), _420);
    float4 _504;
    if (View.View_SkyAtmosphereApplyCameraAerialPerspectiveVolume > 0.0)
    {
        float3 _441 = (_239 * 9.9999997473787516355514526367188e-06) - (View.View_TranslatedWorldCameraOrigin * 9.9999997473787516355514526367188e-06);
        float _447 = sqrt((fast::max(0.0, length(_441) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
        float _448 = _447 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
        float _455;
        if (_448 < 0.707106769084930419921875)
        {
            _455 = fast::clamp((_448 * _448) * 2.0, 0.0, 1.0);
        }
        else
        {
            _455 = 1.0;
        }
        float2 _483;
        if (View.View_RealTimeReflectionCapture != 0.0)
        {
            float3 _458 = normalize(_441);
            float _459 = _458.z;
            float _462 = sqrt(1.0 - (_459 * _459));
            float2 _465 = _101;
            _465.y = (_459 * 0.5) + 0.5;
            float _470 = acos(_458.x / _462);
            float2 _475 = _465;
            _475.x = (((_458.y / _462) < 0.0) ? (6.283185482025146484375 - _470) : _470) * 0.15915493667125701904296875;
            _483 = (_475 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
        }
        else
        {
            _483 = ((_226.xy / _226.ww) * float2(0.5, -0.5)) + float2(0.5);
        }
        float4 _488 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_483, _447), level(0.0));
        float3 _500 = _427.xyz + (((_488.xyz * _455).xyz * View.View_OneOverPreExposure).xyz * _420);
        float4 _503 = float4(_500.x, _500.y, _500.z, _100.w);
        _503.w = _420 * (1.0 - (_455 * (1.0 - _488.w)));
        _504 = _503;
    }
    else
    {
        _504 = _427;
    }
    out.out_var_TEXCOORD10_centroid = float4(_190[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_190[2], _154 * View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _178)].w);
    out.out_var_COLOR0 = LocalVF_VertexFetch_ColorComponentsBuffer.read(uint((_140 & uint(LocalVF.LocalVF_VertexFetch_Parameters.x)))).zyxw;
    out_var_TEXCOORD0 = _238;
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    out.out_var_TEXCOORD7 = _504;
    out.gl_Position = _226;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

