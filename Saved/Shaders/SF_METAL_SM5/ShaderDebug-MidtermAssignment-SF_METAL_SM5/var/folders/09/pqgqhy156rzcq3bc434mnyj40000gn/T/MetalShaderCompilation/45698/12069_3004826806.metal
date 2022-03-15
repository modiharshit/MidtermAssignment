

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

constant float3x3 _83 = {};
constant float4 _84 = {};
constant float2 _85 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    uint out_var_PRIMITIVE_ID [[user(locn2)]];
    float4 out_var_TEXCOORD7 [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    uint in_var_ATTRIBUTE13 [[attribute(13)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

vertex Main_out Main_00002f25_b31a04b6(Main_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(1)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_LocalVF& LocalVF [[buffer(4)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(0)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(1)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[1];
    uint _125 = 2u * (uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex));
    float4 _130 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_125 + 1u)));
    float _131 = _130.w;
    float3 _132 = _130.xyz;
    float3 _134 = cross(_132, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_125)).xyz) * _131;
    float3x3 _137 = _83;
    _137[0] = cross(_134, _132) * _131;
    float3x3 _138 = _137;
    _138[1] = _134;
    float3x3 _139 = _138;
    _139[2] = _132;
    uint _140 = in.in_var_ATTRIBUTE13 * 36u;
    uint _143 = _140 + 1u;
    uint _146 = _140 + 2u;
    uint _149 = _140 + 3u;
    uint _155 = _140 + 4u;
    float3x3 _160 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _140)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _143)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _146)].xyz);
    _160[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _140)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _155)].x;
    float3x3 _163 = _160;
    _163[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _143)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _155)].y;
    float3x3 _166 = _163;
    _166[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _146)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _155)].z;
    float3x3 _167 = _166 * _139;
    float3 _177 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _140)].xyz * in.in_var_ATTRIBUTE0.xxx;
    float3 _180 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _143)].xyz * in.in_var_ATTRIBUTE0.yyy;
    float3 _181 = _177 + _180;
    float3 _184 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _146)].xyz * in.in_var_ATTRIBUTE0.zzz;
    float3 _185 = _181 + _184;
    float3 _187 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _149)].xyz + View.View_PreViewTranslation;
    float3 _188 = _185 + _187;
    float _189 = _188.x;
    float _190 = _188.y;
    float _191 = _188.z;
    float4 _192 = float4(_189, _190, _191, 1.0);
    float4 _193 = float4(_192.x, _192.y, _192.z, _192.w);
    float4 _194 = View.View_TranslatedWorldToClip * _193;
    float3 _205 = _192.xyz;
    float3 _206 = _205 - View.View_TranslatedWorldCameraOrigin;
    float _222 = fast::min(View.View_WorldCameraOrigin.z, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.z);
    float _225 = _206.z + (View.View_WorldCameraOrigin.z - _222);
    float3 _226 = _206;
    _226.z = _225;
    float _227 = dot(_226, _226);
    float _228 = rsqrt(_227);
    float _229 = _227 * _228;
    float _236 = fast::max(fast::max(View.View_VolumetricFogMaxDistance * (length(_206) / dot(_206, View.View_ViewForward)), 0.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.w);
    float _270;
    float _271;
    float _272;
    float _273;
    if (_236 > 0.0)
    {
        float _240 = _236 * _228;
        float _241 = _240 * _225;
        float _242 = _222 + _241;
        _270 = (1.0 - _240) * _229;
        _271 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.z * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * (_242 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.w)));
        _272 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.x * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * (_242 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.y)));
        _273 = _225 - _241;
    }
    else
    {
        _270 = _229;
        _271 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.x;
        _272 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.x;
        _273 = _225;
    }
    float _277 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * _273);
    float _291 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * _273);
    float _313 = ((TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w > 0.0) && (_229 > TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w)) ? 1.0 : fast::max(fast::clamp(exp2(-(((_272 * ((abs(_277) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_277)) / _277) : (0.693147182464599609375 - (0.2402265071868896484375 * _277)))) + (_271 * ((abs(_291) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_291)) / _291) : (0.693147182464599609375 - (0.2402265071868896484375 * _291))))) * _270)), 0.0, 1.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.w);
    float4 _314 = float4(0.0, 0.0, 0.0, _313);
    float4 _391;
    if (View.View_SkyAtmosphereApplyCameraAerialPerspectiveVolume > 0.0)
    {
        float3 _328 = (_205 * 9.9999997473787516355514526367188e-06) - (View.View_TranslatedWorldCameraOrigin * 9.9999997473787516355514526367188e-06);
        float _334 = sqrt((fast::max(0.0, length(_328) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
        float _335 = _334 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
        float _342;
        if (_335 < 0.707106769084930419921875)
        {
            _342 = fast::clamp((_335 * _335) * 2.0, 0.0, 1.0);
        }
        else
        {
            _342 = 1.0;
        }
        float2 _370;
        if (View.View_RealTimeReflectionCapture != 0.0)
        {
            float3 _345 = normalize(_328);
            float _346 = _345.z;
            float _349 = sqrt(1.0 - (_346 * _346));
            float2 _352 = _85;
            _352.y = (_346 * 0.5) + 0.5;
            float _357 = acos(_345.x / _349);
            float2 _362 = _352;
            _362.x = (((_345.y / _349) < 0.0) ? (6.283185482025146484375 - _357) : _357) * 0.15915493667125701904296875;
            _370 = (_362 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
        }
        else
        {
            _370 = ((_194.xy / _194.ww) * float2(0.5, -0.5)) + float2(0.5);
        }
        float4 _375 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_370, _334), level(0.0));
        float3 _387 = _314.xyz + (((_375.xyz * _342).xyz * View.View_OneOverPreExposure).xyz * _313);
        float4 _390 = float4(_387.x, _387.y, _387.z, _84.w);
        _390.w = _313 * (1.0 - (_342 * (1.0 - _375.w)));
        _391 = _390;
    }
    else
    {
        _391 = _314;
    }
    out.out_var_TEXCOORD10_centroid = float4(_167[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_167[2], _131 * View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _155)].w);
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    out.out_var_TEXCOORD7 = _391;
    out.gl_Position = _194;
    return out;
}

