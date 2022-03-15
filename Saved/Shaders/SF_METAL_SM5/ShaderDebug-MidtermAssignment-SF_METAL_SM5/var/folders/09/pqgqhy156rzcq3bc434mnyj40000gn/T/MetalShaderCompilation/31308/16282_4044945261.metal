

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

constant float3x3 _99 = {};
constant float4 _100 = {};
constant float2 _101 = {};

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

vertex Main_out Main_00003f9a_f118f76d(Main_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(7)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(3)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(4)]], constant type_View& View [[buffer(5)]], constant type_LocalVF& LocalVF [[buffer(6)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(0)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(1)]], texturecube<float> TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap [[texture(2)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(3)]], sampler TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler [[sampler(0)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(1)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[3];
    uint _141 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _142 = 2u * _141;
    float4 _147 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_142 + 1u)));
    float _148 = _147.w;
    float3 _149 = _147.xyz;
    float3 _151 = cross(_149, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_142)).xyz) * _148;
    float3x3 _154 = _99;
    _154[0] = cross(_151, _149) * _148;
    float3x3 _155 = _154;
    _155[1] = _151;
    float3x3 _156 = _155;
    _156[2] = _149;
    uint _157 = in.in_var_ATTRIBUTE13 * 36u;
    uint _160 = _157 + 1u;
    uint _163 = _157 + 2u;
    uint _166 = _157 + 3u;
    uint _172 = _157 + 4u;
    float3x3 _177 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _157)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _160)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _163)].xyz);
    _177[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _157)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _172)].x;
    float3x3 _180 = _177;
    _180[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _160)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _172)].y;
    float3x3 _183 = _180;
    _183[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _163)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _172)].z;
    float3x3 _184 = _183 * _156;
    float3 _194 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _157)].xyz * in.in_var_ATTRIBUTE0.xxx;
    float3 _197 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _160)].xyz * in.in_var_ATTRIBUTE0.yyy;
    float3 _198 = _194 + _197;
    float3 _201 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _163)].xyz * in.in_var_ATTRIBUTE0.zzz;
    float3 _202 = _198 + _201;
    float3 _204 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _166)].xyz + View.View_PreViewTranslation;
    float3 _205 = _202 + _204;
    float _206 = _205.x;
    float _207 = _205.y;
    float _208 = _205.z;
    float4 _209 = float4(_206, _207, _208, 1.0);
    float4 _210 = float4(_209.x, _209.y, _209.z, _209.w);
    float4 _211 = View.View_TranslatedWorldToClip * _210;
    float2 _222 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(((uint(LocalVF.LocalVF_VertexFetch_Parameters.y) * _141) + uint(LocalVF.LocalVF_VertexFetch_Parameters.z)))).xy;
    uint _230 = as_type<uint>(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _157 + 24u)].w) + LocalVF.LocalVF_LODLightmapDataIndex;
    uint _231 = _230 * 15u;
    uint _232 = _231 + 2u;
    float2 _238 = (_222 * View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _232)].xy) + View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _232)].zw;
    uint _239 = _231 + 3u;
    float2 _245 = (_222 * View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _239)].xy) + View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _239)].zw;
    float3 _257 = _209.xyz;
    float3 _258 = _257 - View.View_TranslatedWorldCameraOrigin;
    float _275 = fast::min(View.View_WorldCameraOrigin.z, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.z);
    float _278 = _258.z + (View.View_WorldCameraOrigin.z - _275);
    float3 _279 = _258;
    _279.z = _278;
    float _280 = dot(_279, _279);
    float _281 = rsqrt(_280);
    float _282 = _280 * _281;
    float _290 = fast::max(fast::max(View.View_VolumetricFogMaxDistance * (length(_258) / dot(_258, View.View_ViewForward)), 0.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.w);
    float _324;
    float _325;
    float _326;
    float _327;
    if (_290 > 0.0)
    {
        float _294 = _290 * _281;
        float _295 = _294 * _278;
        float _296 = _275 + _295;
        _324 = (1.0 - _294) * _282;
        _325 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.z * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * (_296 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.w)));
        _326 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.x * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * (_296 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.y)));
        _327 = _278 - _295;
    }
    else
    {
        _324 = _282;
        _325 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.x;
        _326 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.x;
        _327 = _278;
    }
    float _331 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * _327);
    float _345 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * _327);
    float _356 = (_326 * ((abs(_331) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_331)) / _331) : (0.693147182464599609375 - (0.2402265071868896484375 * _331)))) + (_325 * ((abs(_345) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_345)) / _345) : (0.693147182464599609375 - (0.2402265071868896484375 * _345))));
    float3 _398;
    if (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.z > 0.0)
    {
        float2 _383 = float2(dot(_279.xy, float2(TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation.y, -TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation.x)), dot(_279.xy, TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation));
        float3 _384 = float3(_383.x, _383.y, _279.z);
        _398 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.xyz * mix(TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap.sample(TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler, _384, level(TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.z)).xyz, TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap.sample(TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler, _384, level(0.0)).xyz, float3(fast::clamp((_282 * TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.x) + TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.y, 0.0, 1.0)));
    }
    else
    {
        _398 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.xyz;
    }
    float3 _426;
    if ((TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.w >= 0.0) && (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.z == 0.0))
    {
        _426 = (TranslucentBasePass.TranslucentBasePass_Shared_Fog_DirectionalInscatteringColor.xyz * pow(fast::clamp(dot(_279 * _281, TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.xyz), 0.0, 1.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_DirectionalInscatteringColor.w)) * (1.0 - fast::clamp(exp2(-(_356 * fast::max(_324 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.w, 0.0))), 0.0, 1.0));
    }
    else
    {
        _426 = float3(0.0);
    }
    bool _435 = (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w > 0.0) && (_282 > TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w);
    float _438 = _435 ? 1.0 : fast::max(fast::clamp(exp2(-(_356 * _324)), 0.0, 1.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.w);
    float4 _445 = float4((_398 * (1.0 - _438)) + select(_426, float3(0.0), bool3(_435)), _438);
    float4 _522;
    if (View.View_SkyAtmosphereApplyCameraAerialPerspectiveVolume > 0.0)
    {
        float3 _459 = (_257 * 9.9999997473787516355514526367188e-06) - (View.View_TranslatedWorldCameraOrigin * 9.9999997473787516355514526367188e-06);
        float _465 = sqrt((fast::max(0.0, length(_459) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
        float _466 = _465 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
        float _473;
        if (_466 < 0.707106769084930419921875)
        {
            _473 = fast::clamp((_466 * _466) * 2.0, 0.0, 1.0);
        }
        else
        {
            _473 = 1.0;
        }
        float2 _501;
        if (View.View_RealTimeReflectionCapture != 0.0)
        {
            float3 _476 = normalize(_459);
            float _477 = _476.z;
            float _480 = sqrt(1.0 - (_477 * _477));
            float2 _483 = _101;
            _483.y = (_477 * 0.5) + 0.5;
            float _488 = acos(_476.x / _480);
            float2 _493 = _483;
            _493.x = (((_476.y / _480) < 0.0) ? (6.283185482025146484375 - _488) : _488) * 0.15915493667125701904296875;
            _501 = (_493 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
        }
        else
        {
            _501 = ((_211.xy / _211.ww) * float2(0.5, -0.5)) + float2(0.5);
        }
        float4 _506 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_501, _465), level(0.0));
        float3 _518 = _445.xyz + (((_506.xyz * _473).xyz * View.View_OneOverPreExposure).xyz * _438);
        float4 _521 = float4(_518.x, _518.y, _518.z, _100.w);
        _521.w = _438 * (1.0 - (_473 * (1.0 - _506.w)));
        _522 = _521;
    }
    else
    {
        _522 = _445;
    }
    out.out_var_TEXCOORD10_centroid = float4(_184[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_184[2], _148 * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _172)].w);
    out.out_var_TEXCOORD4 = float4(_238.x, _238.y, _245.x, _245.y);
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    out.out_var_LIGHTMAP_ID = _230;
    out.out_var_TEXCOORD7 = _522;
    out.gl_Position = _211;
    return out;
}

