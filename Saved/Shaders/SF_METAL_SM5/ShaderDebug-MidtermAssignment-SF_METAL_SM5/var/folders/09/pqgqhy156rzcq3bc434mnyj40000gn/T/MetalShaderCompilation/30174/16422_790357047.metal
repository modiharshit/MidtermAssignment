

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

constant float3x3 _104 = {};
constant float4 _105 = {};
constant float2 _106 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD0_0 [[user(locn2)]];
    float4 out_var_TEXCOORD4 [[user(locn3)]];
    uint out_var_PRIMITIVE_ID [[user(locn4)]];
    uint out_var_LIGHTMAP_ID [[user(locn5)]];
    float4 out_var_TEXCOORD7 [[user(locn6)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    uint in_var_ATTRIBUTE13 [[attribute(13)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

vertex Main_out Main_00004026_2f1be437(Main_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(7)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(3)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(4)]], constant type_View& View [[buffer(5)]], constant type_LocalVF& LocalVF [[buffer(6)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(0)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(1)]], texturecube<float> TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap [[texture(2)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(3)]], sampler TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler [[sampler(0)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(1)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[3];
    uint _145 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _146 = 2u * _145;
    float4 _151 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_146 + 1u)));
    float _152 = _151.w;
    float3 _153 = _151.xyz;
    float3 _155 = cross(_153, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_146)).xyz) * _152;
    float3x3 _158 = _104;
    _158[0] = cross(_155, _153) * _152;
    float3x3 _159 = _158;
    _159[1] = _155;
    float3x3 _160 = _159;
    _160[2] = _153;
    uint _161 = in.in_var_ATTRIBUTE13 * 36u;
    uint _164 = _161 + 1u;
    uint _167 = _161 + 2u;
    uint _170 = _161 + 3u;
    uint _176 = _161 + 4u;
    float3x3 _181 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _161)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _164)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _167)].xyz);
    _181[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _161)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _176)].x;
    float3x3 _184 = _181;
    _184[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _164)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _176)].y;
    float3x3 _187 = _184;
    _187[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _167)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _176)].z;
    float3x3 _188 = _187 * _160;
    float3 _198 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _161)].xyz * in.in_var_ATTRIBUTE0.xxx;
    float3 _201 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _164)].xyz * in.in_var_ATTRIBUTE0.yyy;
    float3 _202 = _198 + _201;
    float3 _205 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _167)].xyz * in.in_var_ATTRIBUTE0.zzz;
    float3 _206 = _202 + _205;
    float3 _208 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _170)].xyz + View.View_PreViewTranslation;
    float3 _209 = _206 + _208;
    float _210 = _209.x;
    float _211 = _209.y;
    float _212 = _209.z;
    float4 _213 = float4(_210, _211, _212, 1.0);
    uint _216 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    uint _219 = _216 * _145;
    float4 _222 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_219 + min(0u, (_216 - 1u)))));
    float4 _223 = float4(_213.x, _213.y, _213.z, _213.w);
    float4 _224 = View.View_TranslatedWorldToClip * _223;
    uint _239 = as_type<uint>(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _161 + 24u)].w) + LocalVF.LocalVF_LODLightmapDataIndex;
    uint _241 = (_239 * 15u) + 2u;
    float2 _247 = (LocalVF_VertexFetch_TexCoordBuffer.read(uint((_219 + uint(LocalVF.LocalVF_VertexFetch_Parameters.z)))).xy * View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _241)].xy) + View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _241)].zw;
    spvUnsafeArray<float4, 1> _259 = { float4(_222.x, _222.y, float4(0.0).z, float4(0.0).w) };
    float3 _260 = _213.xyz;
    float3 _261 = _260 - View.View_TranslatedWorldCameraOrigin;
    float _278 = fast::min(View.View_WorldCameraOrigin.z, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.z);
    float _281 = _261.z + (View.View_WorldCameraOrigin.z - _278);
    float3 _282 = _261;
    _282.z = _281;
    float _283 = dot(_282, _282);
    float _284 = rsqrt(_283);
    float _285 = _283 * _284;
    float _293 = fast::max(fast::max(View.View_VolumetricFogMaxDistance * (length(_261) / dot(_261, View.View_ViewForward)), 0.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.w);
    float _327;
    float _328;
    float _329;
    float _330;
    if (_293 > 0.0)
    {
        float _297 = _293 * _284;
        float _298 = _297 * _281;
        float _299 = _278 + _298;
        _327 = (1.0 - _297) * _285;
        _328 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.z * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * (_299 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.w)));
        _329 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.x * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * (_299 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.y)));
        _330 = _281 - _298;
    }
    else
    {
        _327 = _285;
        _328 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.x;
        _329 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.x;
        _330 = _281;
    }
    float _334 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * _330);
    float _348 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * _330);
    float _359 = (_329 * ((abs(_334) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_334)) / _334) : (0.693147182464599609375 - (0.2402265071868896484375 * _334)))) + (_328 * ((abs(_348) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_348)) / _348) : (0.693147182464599609375 - (0.2402265071868896484375 * _348))));
    float3 _401;
    if (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.z > 0.0)
    {
        float2 _386 = float2(dot(_282.xy, float2(TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation.y, -TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation.x)), dot(_282.xy, TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation));
        float3 _387 = float3(_386.x, _386.y, _282.z);
        _401 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.xyz * mix(TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap.sample(TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler, _387, level(TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.z)).xyz, TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap.sample(TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler, _387, level(0.0)).xyz, float3(fast::clamp((_285 * TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.x) + TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.y, 0.0, 1.0)));
    }
    else
    {
        _401 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.xyz;
    }
    float3 _429;
    if ((TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.w >= 0.0) && (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.z == 0.0))
    {
        _429 = (TranslucentBasePass.TranslucentBasePass_Shared_Fog_DirectionalInscatteringColor.xyz * pow(fast::clamp(dot(_282 * _284, TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.xyz), 0.0, 1.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_DirectionalInscatteringColor.w)) * (1.0 - fast::clamp(exp2(-(_359 * fast::max(_327 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.w, 0.0))), 0.0, 1.0));
    }
    else
    {
        _429 = float3(0.0);
    }
    bool _438 = (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w > 0.0) && (_285 > TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w);
    float _441 = _438 ? 1.0 : fast::max(fast::clamp(exp2(-(_359 * _327)), 0.0, 1.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.w);
    float4 _448 = float4((_401 * (1.0 - _441)) + select(_429, float3(0.0), bool3(_438)), _441);
    float4 _525;
    if (View.View_SkyAtmosphereApplyCameraAerialPerspectiveVolume > 0.0)
    {
        float3 _462 = (_260 * 9.9999997473787516355514526367188e-06) - (View.View_TranslatedWorldCameraOrigin * 9.9999997473787516355514526367188e-06);
        float _468 = sqrt((fast::max(0.0, length(_462) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
        float _469 = _468 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
        float _476;
        if (_469 < 0.707106769084930419921875)
        {
            _476 = fast::clamp((_469 * _469) * 2.0, 0.0, 1.0);
        }
        else
        {
            _476 = 1.0;
        }
        float2 _504;
        if (View.View_RealTimeReflectionCapture != 0.0)
        {
            float3 _479 = normalize(_462);
            float _480 = _479.z;
            float _483 = sqrt(1.0 - (_480 * _480));
            float2 _486 = _106;
            _486.y = (_480 * 0.5) + 0.5;
            float _491 = acos(_479.x / _483);
            float2 _496 = _486;
            _496.x = (((_479.y / _483) < 0.0) ? (6.283185482025146484375 - _491) : _491) * 0.15915493667125701904296875;
            _504 = (_496 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
        }
        else
        {
            _504 = ((_224.xy / _224.ww) * float2(0.5, -0.5)) + float2(0.5);
        }
        float4 _509 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_504, _468), level(0.0));
        float3 _521 = _448.xyz + (((_509.xyz * _476).xyz * View.View_OneOverPreExposure).xyz * _441);
        float4 _524 = float4(_521.x, _521.y, _521.z, _105.w);
        _524.w = _441 * (1.0 - (_476 * (1.0 - _509.w)));
        _525 = _524;
    }
    else
    {
        _525 = _448;
    }
    out.out_var_TEXCOORD10_centroid = float4(_188[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_188[2], _152 * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _176)].w);
    out_var_TEXCOORD0 = _259;
    out.out_var_TEXCOORD4 = float4(_247.x, _247.y, float2(0.0).x, float2(0.0).y);
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    out.out_var_LIGHTMAP_ID = _239;
    out.out_var_TEXCOORD7 = _525;
    out.gl_Position = _224;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

