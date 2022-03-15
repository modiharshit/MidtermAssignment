

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

constant float3x3 _89 = {};
constant float4 _90 = {};
constant float2 _91 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD0_0 [[user(locn2)]];
    uint out_var_PRIMITIVE_ID [[user(locn3)]];
    float4 out_var_TEXCOORD7 [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    uint in_var_ATTRIBUTE13 [[attribute(13)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

vertex Main_out Main_00003124_a00ab336(Main_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(6)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(3)]], constant type_View& View [[buffer(4)]], constant type_LocalVF& LocalVF [[buffer(5)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(0)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(1)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(2)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    uint _130 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _131 = 2u * _130;
    float4 _136 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_131 + 1u)));
    float _137 = _136.w;
    float3 _138 = _136.xyz;
    float3 _140 = cross(_138, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_131)).xyz) * _137;
    float3x3 _143 = _89;
    _143[0] = cross(_140, _138) * _137;
    float3x3 _144 = _143;
    _144[1] = _140;
    float3x3 _145 = _144;
    _145[2] = _138;
    uint _146 = in.in_var_ATTRIBUTE13 * 36u;
    uint _149 = _146 + 1u;
    uint _152 = _146 + 2u;
    uint _155 = _146 + 3u;
    uint _161 = _146 + 4u;
    float3x3 _166 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _146)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _149)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _152)].xyz);
    _166[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _146)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _161)].x;
    float3x3 _169 = _166;
    _169[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _149)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _161)].y;
    float3x3 _172 = _169;
    _172[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _152)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _161)].z;
    float3x3 _173 = _172 * _145;
    float3 _183 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _146)].xyz * in.in_var_ATTRIBUTE0.xxx;
    float3 _186 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _149)].xyz * in.in_var_ATTRIBUTE0.yyy;
    float3 _187 = _183 + _186;
    float3 _190 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _152)].xyz * in.in_var_ATTRIBUTE0.zzz;
    float3 _191 = _187 + _190;
    float3 _193 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _155)].xyz + View.View_PreViewTranslation;
    float3 _194 = _191 + _193;
    float _195 = _194.x;
    float _196 = _194.y;
    float _197 = _194.z;
    float4 _198 = float4(_195, _196, _197, 1.0);
    float4 _199 = float4(_198.x, _198.y, _198.z, _198.w);
    float4 _200 = View.View_TranslatedWorldToClip * _199;
    float4 _206 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((uint(LocalVF.LocalVF_VertexFetch_Parameters.y) * _130)));
    spvUnsafeArray<float4, 1> _218 = { float4(_206.x, _206.y, float4(0.0).z, float4(0.0).w) };
    float3 _219 = _198.xyz;
    float3 _220 = _219 - View.View_TranslatedWorldCameraOrigin;
    float _236 = fast::min(View.View_WorldCameraOrigin.z, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.z);
    float _239 = _220.z + (View.View_WorldCameraOrigin.z - _236);
    float3 _240 = _220;
    _240.z = _239;
    float _241 = dot(_240, _240);
    float _242 = rsqrt(_241);
    float _243 = _241 * _242;
    float _250 = fast::max(fast::max(View.View_VolumetricFogMaxDistance * (length(_220) / dot(_220, View.View_ViewForward)), 0.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.w);
    float _284;
    float _285;
    float _286;
    float _287;
    if (_250 > 0.0)
    {
        float _254 = _250 * _242;
        float _255 = _254 * _239;
        float _256 = _236 + _255;
        _284 = (1.0 - _254) * _243;
        _285 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.z * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * (_256 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.w)));
        _286 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.x * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * (_256 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.y)));
        _287 = _239 - _255;
    }
    else
    {
        _284 = _243;
        _285 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.x;
        _286 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.x;
        _287 = _239;
    }
    float _291 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * _287);
    float _305 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * _287);
    float _327 = ((TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w > 0.0) && (_243 > TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w)) ? 1.0 : fast::max(fast::clamp(exp2(-(((_286 * ((abs(_291) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_291)) / _291) : (0.693147182464599609375 - (0.2402265071868896484375 * _291)))) + (_285 * ((abs(_305) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_305)) / _305) : (0.693147182464599609375 - (0.2402265071868896484375 * _305))))) * _284)), 0.0, 1.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.w);
    float4 _328 = float4(0.0, 0.0, 0.0, _327);
    float4 _405;
    if (View.View_SkyAtmosphereApplyCameraAerialPerspectiveVolume > 0.0)
    {
        float3 _342 = (_219 * 9.9999997473787516355514526367188e-06) - (View.View_TranslatedWorldCameraOrigin * 9.9999997473787516355514526367188e-06);
        float _348 = sqrt((fast::max(0.0, length(_342) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
        float _349 = _348 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
        float _356;
        if (_349 < 0.707106769084930419921875)
        {
            _356 = fast::clamp((_349 * _349) * 2.0, 0.0, 1.0);
        }
        else
        {
            _356 = 1.0;
        }
        float2 _384;
        if (View.View_RealTimeReflectionCapture != 0.0)
        {
            float3 _359 = normalize(_342);
            float _360 = _359.z;
            float _363 = sqrt(1.0 - (_360 * _360));
            float2 _366 = _91;
            _366.y = (_360 * 0.5) + 0.5;
            float _371 = acos(_359.x / _363);
            float2 _376 = _366;
            _376.x = (((_359.y / _363) < 0.0) ? (6.283185482025146484375 - _371) : _371) * 0.15915493667125701904296875;
            _384 = (_376 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
        }
        else
        {
            _384 = ((_200.xy / _200.ww) * float2(0.5, -0.5)) + float2(0.5);
        }
        float4 _389 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_384, _348), level(0.0));
        float3 _401 = _328.xyz + (((_389.xyz * _356).xyz * View.View_OneOverPreExposure).xyz * _327);
        float4 _404 = float4(_401.x, _401.y, _401.z, _90.w);
        _404.w = _327 * (1.0 - (_356 * (1.0 - _389.w)));
        _405 = _404;
    }
    else
    {
        _405 = _328;
    }
    out.out_var_TEXCOORD10_centroid = float4(_173[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_173[2], _137 * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _161)].w);
    out_var_TEXCOORD0 = _218;
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    out.out_var_TEXCOORD7 = _405;
    out.gl_Position = _200;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

