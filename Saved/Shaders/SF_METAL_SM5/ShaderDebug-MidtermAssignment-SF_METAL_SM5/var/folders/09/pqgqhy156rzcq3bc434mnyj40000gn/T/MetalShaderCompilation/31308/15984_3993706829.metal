

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
    char _m1_pad[4];
    uint LocalVF_LODLightmapDataIndex;
};

constant float3x3 _100 = {};
constant float4 _101 = {};
constant float2 _102 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD4 [[user(locn2)]];
    uint out_var_PRIMITIVE_ID [[user(locn3)]];
    uint out_var_LIGHTMAP_ID [[user(locn4)]];
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

vertex Main_out Main_00003e70_ee0b214d(Main_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(7)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(3)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(4)]], constant type_View& View [[buffer(5)]], constant type_LocalVF& LocalVF [[buffer(6)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(0)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(1)]], texturecube<float> TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap [[texture(2)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(3)]], sampler TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler [[sampler(0)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(1)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[3];
    uint _142 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _143 = 2u * _142;
    float4 _148 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_143 + 1u)));
    float _149 = _148.w;
    float3 _150 = _148.xyz;
    float3 _152 = cross(_150, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_143)).xyz) * _149;
    float3x3 _155 = _100;
    _155[0] = cross(_152, _150) * _149;
    float3x3 _156 = _155;
    _156[1] = _152;
    float3x3 _157 = _156;
    _157[2] = _150;
    uint _158 = in.in_var_ATTRIBUTE13 * 36u;
    uint _161 = _158 + 1u;
    uint _164 = _158 + 2u;
    uint _167 = _158 + 3u;
    uint _173 = _158 + 4u;
    float3x3 _178 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _158)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _161)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _164)].xyz);
    _178[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _158)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _173)].x;
    float3x3 _181 = _178;
    _181[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _161)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _173)].y;
    float3x3 _184 = _181;
    _184[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _164)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _173)].z;
    float3x3 _185 = _184 * _157;
    float3 _195 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _158)].xyz * in.in_var_ATTRIBUTE0.xxx;
    float3 _198 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _161)].xyz * in.in_var_ATTRIBUTE0.yyy;
    float3 _199 = _195 + _198;
    float3 _202 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _164)].xyz * in.in_var_ATTRIBUTE0.zzz;
    float3 _203 = _199 + _202;
    float3 _205 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _167)].xyz + View.View_PreViewTranslation;
    float3 _206 = _203 + _205;
    float _207 = _206.x;
    float _208 = _206.y;
    float _209 = _206.z;
    float4 _210 = float4(_207, _208, _209, 1.0);
    float4 _211 = float4(_210.x, _210.y, _210.z, _210.w);
    float4 _212 = View.View_TranslatedWorldToClip * _211;
    uint _231 = as_type<uint>(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _158 + 24u)].w) + LocalVF.LocalVF_LODLightmapDataIndex;
    uint _233 = (_231 * 15u) + 2u;
    float2 _239 = (LocalVF_VertexFetch_TexCoordBuffer.read(uint(((uint(LocalVF.LocalVF_VertexFetch_Parameters.y) * _142) + uint(LocalVF.LocalVF_VertexFetch_Parameters.z)))).xy * View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _233)].xy) + View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _233)].zw;
    float3 _251 = _210.xyz;
    float3 _252 = _251 - View.View_TranslatedWorldCameraOrigin;
    float _269 = fast::min(View.View_WorldCameraOrigin.z, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.z);
    float _272 = _252.z + (View.View_WorldCameraOrigin.z - _269);
    float3 _273 = _252;
    _273.z = _272;
    float _274 = dot(_273, _273);
    float _275 = rsqrt(_274);
    float _276 = _274 * _275;
    float _284 = fast::max(fast::max(View.View_VolumetricFogMaxDistance * (length(_252) / dot(_252, View.View_ViewForward)), 0.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.w);
    float _318;
    float _319;
    float _320;
    float _321;
    if (_284 > 0.0)
    {
        float _288 = _284 * _275;
        float _289 = _288 * _272;
        float _290 = _269 + _289;
        _318 = (1.0 - _288) * _276;
        _319 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.z * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * (_290 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.w)));
        _320 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.x * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * (_290 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.y)));
        _321 = _272 - _289;
    }
    else
    {
        _318 = _276;
        _319 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.x;
        _320 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.x;
        _321 = _272;
    }
    float _325 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * _321);
    float _339 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * _321);
    float _350 = (_320 * ((abs(_325) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_325)) / _325) : (0.693147182464599609375 - (0.2402265071868896484375 * _325)))) + (_319 * ((abs(_339) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_339)) / _339) : (0.693147182464599609375 - (0.2402265071868896484375 * _339))));
    float3 _392;
    if (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.z > 0.0)
    {
        float2 _377 = float2(dot(_273.xy, float2(TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation.y, -TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation.x)), dot(_273.xy, TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation));
        float3 _378 = float3(_377.x, _377.y, _273.z);
        _392 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.xyz * mix(TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap.sample(TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler, _378, level(TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.z)).xyz, TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap.sample(TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler, _378, level(0.0)).xyz, float3(fast::clamp((_276 * TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.x) + TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.y, 0.0, 1.0)));
    }
    else
    {
        _392 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.xyz;
    }
    float3 _420;
    if ((TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.w >= 0.0) && (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.z == 0.0))
    {
        _420 = (TranslucentBasePass.TranslucentBasePass_Shared_Fog_DirectionalInscatteringColor.xyz * pow(fast::clamp(dot(_273 * _275, TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.xyz), 0.0, 1.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_DirectionalInscatteringColor.w)) * (1.0 - fast::clamp(exp2(-(_350 * fast::max(_318 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.w, 0.0))), 0.0, 1.0));
    }
    else
    {
        _420 = float3(0.0);
    }
    bool _429 = (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w > 0.0) && (_276 > TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w);
    float _432 = _429 ? 1.0 : fast::max(fast::clamp(exp2(-(_350 * _318)), 0.0, 1.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.w);
    float4 _439 = float4((_392 * (1.0 - _432)) + select(_420, float3(0.0), bool3(_429)), _432);
    float4 _516;
    if (View.View_SkyAtmosphereApplyCameraAerialPerspectiveVolume > 0.0)
    {
        float3 _453 = (_251 * 9.9999997473787516355514526367188e-06) - (View.View_TranslatedWorldCameraOrigin * 9.9999997473787516355514526367188e-06);
        float _459 = sqrt((fast::max(0.0, length(_453) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
        float _460 = _459 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
        float _467;
        if (_460 < 0.707106769084930419921875)
        {
            _467 = fast::clamp((_460 * _460) * 2.0, 0.0, 1.0);
        }
        else
        {
            _467 = 1.0;
        }
        float2 _495;
        if (View.View_RealTimeReflectionCapture != 0.0)
        {
            float3 _470 = normalize(_453);
            float _471 = _470.z;
            float _474 = sqrt(1.0 - (_471 * _471));
            float2 _477 = _102;
            _477.y = (_471 * 0.5) + 0.5;
            float _482 = acos(_470.x / _474);
            float2 _487 = _477;
            _487.x = (((_470.y / _474) < 0.0) ? (6.283185482025146484375 - _482) : _482) * 0.15915493667125701904296875;
            _495 = (_487 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
        }
        else
        {
            _495 = ((_212.xy / _212.ww) * float2(0.5, -0.5)) + float2(0.5);
        }
        float4 _500 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_495, _459), level(0.0));
        float3 _512 = _439.xyz + (((_500.xyz * _467).xyz * View.View_OneOverPreExposure).xyz * _432);
        float4 _515 = float4(_512.x, _512.y, _512.z, _101.w);
        _515.w = _432 * (1.0 - (_467 * (1.0 - _500.w)));
        _516 = _515;
    }
    else
    {
        _516 = _439;
    }
    out.out_var_TEXCOORD10_centroid = float4(_185[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_185[2], _149 * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _173)].w);
    out.out_var_TEXCOORD4 = float4(_239.x, _239.y, float2(0.0).x, float2(0.0).y);
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    out.out_var_LIGHTMAP_ID = _231;
    out.out_var_TEXCOORD7 = _516;
    out.gl_Position = _212;
    return out;
}

