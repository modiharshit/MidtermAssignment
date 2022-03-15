

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

constant float3x3 _103 = {};
constant float4 _104 = {};
constant float2 _105 = {};

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

vertex Main_out Main_00004152_91edba9d(Main_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(7)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(3)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(4)]], constant type_View& View [[buffer(5)]], constant type_LocalVF& LocalVF [[buffer(6)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(0)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(1)]], texturecube<float> TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap [[texture(2)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(3)]], sampler TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler [[sampler(0)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(1)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[3];
    uint _144 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _145 = 2u * _144;
    float4 _150 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_145 + 1u)));
    float _151 = _150.w;
    float3 _152 = _150.xyz;
    float3 _154 = cross(_152, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_145)).xyz) * _151;
    float3x3 _157 = _103;
    _157[0] = cross(_154, _152) * _151;
    float3x3 _158 = _157;
    _158[1] = _154;
    float3x3 _159 = _158;
    _159[2] = _152;
    uint _160 = in.in_var_ATTRIBUTE13 * 36u;
    uint _163 = _160 + 1u;
    uint _166 = _160 + 2u;
    uint _169 = _160 + 3u;
    uint _175 = _160 + 4u;
    float3x3 _180 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _160)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _163)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _166)].xyz);
    _180[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _160)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _175)].x;
    float3x3 _183 = _180;
    _183[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _163)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _175)].y;
    float3x3 _186 = _183;
    _186[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _166)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _175)].z;
    float3x3 _187 = _186 * _159;
    float3 _197 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _160)].xyz * in.in_var_ATTRIBUTE0.xxx;
    float3 _200 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _163)].xyz * in.in_var_ATTRIBUTE0.yyy;
    float3 _201 = _197 + _200;
    float3 _204 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _166)].xyz * in.in_var_ATTRIBUTE0.zzz;
    float3 _205 = _201 + _204;
    float3 _207 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _169)].xyz + View.View_PreViewTranslation;
    float3 _208 = _205 + _207;
    float _209 = _208.x;
    float _210 = _208.y;
    float _211 = _208.z;
    float4 _212 = float4(_209, _210, _211, 1.0);
    uint _215 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    uint _218 = _215 * _144;
    float4 _221 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_218 + min(0u, (_215 - 1u)))));
    float4 _222 = float4(_212.x, _212.y, _212.z, _212.w);
    float4 _223 = View.View_TranslatedWorldToClip * _222;
    float2 _230 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_218 + uint(LocalVF.LocalVF_VertexFetch_Parameters.z)))).xy;
    uint _238 = as_type<uint>(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _160 + 24u)].w) + LocalVF.LocalVF_LODLightmapDataIndex;
    uint _239 = _238 * 15u;
    uint _240 = _239 + 2u;
    float2 _246 = (_230 * View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _240)].xy) + View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _240)].zw;
    uint _247 = _239 + 3u;
    float2 _253 = (_230 * View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _247)].xy) + View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _247)].zw;
    spvUnsafeArray<float4, 1> _265 = { float4(_221.x, _221.y, float4(0.0).z, float4(0.0).w) };
    float3 _266 = _212.xyz;
    float3 _267 = _266 - View.View_TranslatedWorldCameraOrigin;
    float _284 = fast::min(View.View_WorldCameraOrigin.z, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.z);
    float _287 = _267.z + (View.View_WorldCameraOrigin.z - _284);
    float3 _288 = _267;
    _288.z = _287;
    float _289 = dot(_288, _288);
    float _290 = rsqrt(_289);
    float _291 = _289 * _290;
    float _299 = fast::max(fast::max(View.View_VolumetricFogMaxDistance * (length(_267) / dot(_267, View.View_ViewForward)), 0.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.w);
    float _333;
    float _334;
    float _335;
    float _336;
    if (_299 > 0.0)
    {
        float _303 = _299 * _290;
        float _304 = _303 * _287;
        float _305 = _284 + _304;
        _333 = (1.0 - _303) * _291;
        _334 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.z * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * (_305 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.w)));
        _335 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.x * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * (_305 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.y)));
        _336 = _287 - _304;
    }
    else
    {
        _333 = _291;
        _334 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.x;
        _335 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.x;
        _336 = _287;
    }
    float _340 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * _336);
    float _354 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * _336);
    float _365 = (_335 * ((abs(_340) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_340)) / _340) : (0.693147182464599609375 - (0.2402265071868896484375 * _340)))) + (_334 * ((abs(_354) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_354)) / _354) : (0.693147182464599609375 - (0.2402265071868896484375 * _354))));
    float3 _407;
    if (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.z > 0.0)
    {
        float2 _392 = float2(dot(_288.xy, float2(TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation.y, -TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation.x)), dot(_288.xy, TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation));
        float3 _393 = float3(_392.x, _392.y, _288.z);
        _407 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.xyz * mix(TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap.sample(TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler, _393, level(TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.z)).xyz, TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap.sample(TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler, _393, level(0.0)).xyz, float3(fast::clamp((_291 * TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.x) + TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.y, 0.0, 1.0)));
    }
    else
    {
        _407 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.xyz;
    }
    float3 _435;
    if ((TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.w >= 0.0) && (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.z == 0.0))
    {
        _435 = (TranslucentBasePass.TranslucentBasePass_Shared_Fog_DirectionalInscatteringColor.xyz * pow(fast::clamp(dot(_288 * _290, TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.xyz), 0.0, 1.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_DirectionalInscatteringColor.w)) * (1.0 - fast::clamp(exp2(-(_365 * fast::max(_333 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.w, 0.0))), 0.0, 1.0));
    }
    else
    {
        _435 = float3(0.0);
    }
    bool _444 = (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w > 0.0) && (_291 > TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w);
    float _447 = _444 ? 1.0 : fast::max(fast::clamp(exp2(-(_365 * _333)), 0.0, 1.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.w);
    float4 _454 = float4((_407 * (1.0 - _447)) + select(_435, float3(0.0), bool3(_444)), _447);
    float4 _531;
    if (View.View_SkyAtmosphereApplyCameraAerialPerspectiveVolume > 0.0)
    {
        float3 _468 = (_266 * 9.9999997473787516355514526367188e-06) - (View.View_TranslatedWorldCameraOrigin * 9.9999997473787516355514526367188e-06);
        float _474 = sqrt((fast::max(0.0, length(_468) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
        float _475 = _474 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
        float _482;
        if (_475 < 0.707106769084930419921875)
        {
            _482 = fast::clamp((_475 * _475) * 2.0, 0.0, 1.0);
        }
        else
        {
            _482 = 1.0;
        }
        float2 _510;
        if (View.View_RealTimeReflectionCapture != 0.0)
        {
            float3 _485 = normalize(_468);
            float _486 = _485.z;
            float _489 = sqrt(1.0 - (_486 * _486));
            float2 _492 = _105;
            _492.y = (_486 * 0.5) + 0.5;
            float _497 = acos(_485.x / _489);
            float2 _502 = _492;
            _502.x = (((_485.y / _489) < 0.0) ? (6.283185482025146484375 - _497) : _497) * 0.15915493667125701904296875;
            _510 = (_502 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
        }
        else
        {
            _510 = ((_223.xy / _223.ww) * float2(0.5, -0.5)) + float2(0.5);
        }
        float4 _515 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_510, _474), level(0.0));
        float3 _527 = _454.xyz + (((_515.xyz * _482).xyz * View.View_OneOverPreExposure).xyz * _447);
        float4 _530 = float4(_527.x, _527.y, _527.z, _104.w);
        _530.w = _447 * (1.0 - (_482 * (1.0 - _515.w)));
        _531 = _530;
    }
    else
    {
        _531 = _454;
    }
    out.out_var_TEXCOORD10_centroid = float4(_187[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_187[2], _151 * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _175)].w);
    out_var_TEXCOORD0 = _265;
    out.out_var_TEXCOORD4 = float4(_246.x, _246.y, _253.x, _253.y);
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    out.out_var_LIGHTMAP_ID = _238;
    out.out_var_TEXCOORD7 = _531;
    out.gl_Position = _223;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

