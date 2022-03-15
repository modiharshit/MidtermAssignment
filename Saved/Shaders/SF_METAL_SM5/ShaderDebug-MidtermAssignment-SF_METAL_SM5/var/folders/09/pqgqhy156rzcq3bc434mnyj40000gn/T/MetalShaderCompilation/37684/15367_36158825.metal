

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

constant float3x3 _96 = {};
constant float4 _97 = {};
constant float2 _98 = {};

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

vertex Main_out Main_00003c07_0227bd69(Main_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(6)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(3)]], constant type_View& View [[buffer(4)]], constant type_LocalVF& LocalVF [[buffer(5)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(0)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(1)]], texturecube<float> TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap [[texture(2)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(3)]], sampler TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler [[sampler(0)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(1)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    uint _138 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _139 = 2u * _138;
    float4 _144 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_139 + 1u)));
    float _145 = _144.w;
    float3 _146 = _144.xyz;
    float3 _148 = cross(_146, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_139)).xyz) * _145;
    float3x3 _151 = _96;
    _151[0] = cross(_148, _146) * _145;
    float3x3 _152 = _151;
    _152[1] = _148;
    float3x3 _153 = _152;
    _153[2] = _146;
    uint _154 = in.in_var_ATTRIBUTE13 * 36u;
    uint _157 = _154 + 1u;
    uint _160 = _154 + 2u;
    uint _163 = _154 + 3u;
    uint _169 = _154 + 4u;
    float3x3 _174 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _154)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _157)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _160)].xyz);
    _174[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _154)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _169)].x;
    float3x3 _177 = _174;
    _177[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _157)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _169)].y;
    float3x3 _180 = _177;
    _180[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _160)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _169)].z;
    float3x3 _181 = _180 * _153;
    float3 _191 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _154)].xyz * in.in_var_ATTRIBUTE0.xxx;
    float3 _194 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _157)].xyz * in.in_var_ATTRIBUTE0.yyy;
    float3 _195 = _191 + _194;
    float3 _198 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _160)].xyz * in.in_var_ATTRIBUTE0.zzz;
    float3 _199 = _195 + _198;
    float3 _201 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _163)].xyz + View.View_PreViewTranslation;
    float3 _202 = _199 + _201;
    float _203 = _202.x;
    float _204 = _202.y;
    float _205 = _202.z;
    float4 _206 = float4(_203, _204, _205, 1.0);
    float4 _207 = float4(_206.x, _206.y, _206.z, _206.w);
    float4 _208 = View.View_TranslatedWorldToClip * _207;
    float4 _214 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((uint(LocalVF.LocalVF_VertexFetch_Parameters.y) * _138)));
    spvUnsafeArray<float4, 1> _226 = { float4(_214.x, _214.y, float4(0.0).z, float4(0.0).w) };
    float3 _227 = _206.xyz;
    float3 _228 = _227 - View.View_TranslatedWorldCameraOrigin;
    float _245 = fast::min(View.View_WorldCameraOrigin.z, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.z);
    float _248 = _228.z + (View.View_WorldCameraOrigin.z - _245);
    float3 _249 = _228;
    _249.z = _248;
    float _250 = dot(_249, _249);
    float _251 = rsqrt(_250);
    float _252 = _250 * _251;
    float _260 = fast::max(fast::max(View.View_VolumetricFogMaxDistance * (length(_228) / dot(_228, View.View_ViewForward)), 0.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.w);
    float _294;
    float _295;
    float _296;
    float _297;
    if (_260 > 0.0)
    {
        float _264 = _260 * _251;
        float _265 = _264 * _248;
        float _266 = _245 + _265;
        _294 = (1.0 - _264) * _252;
        _295 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.z * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * (_266 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.w)));
        _296 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.x * exp2(-fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * (_266 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.y)));
        _297 = _248 - _265;
    }
    else
    {
        _294 = _252;
        _295 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.x;
        _296 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.x;
        _297 = _248;
    }
    float _301 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y * _297);
    float _315 = fast::max(-127.0, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y * _297);
    float _326 = (_296 * ((abs(_301) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_301)) / _301) : (0.693147182464599609375 - (0.2402265071868896484375 * _301)))) + (_295 * ((abs(_315) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_315)) / _315) : (0.693147182464599609375 - (0.2402265071868896484375 * _315))));
    float3 _368;
    if (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.z > 0.0)
    {
        float2 _353 = float2(dot(_249.xy, float2(TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation.y, -TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation.x)), dot(_249.xy, TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation));
        float3 _354 = float3(_353.x, _353.y, _249.z);
        _368 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.xyz * mix(TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap.sample(TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler, _354, level(TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.z)).xyz, TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap.sample(TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler, _354, level(0.0)).xyz, float3(fast::clamp((_252 * TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.x) + TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.y, 0.0, 1.0)));
    }
    else
    {
        _368 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.xyz;
    }
    float3 _396;
    if ((TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.w >= 0.0) && (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.z == 0.0))
    {
        _396 = (TranslucentBasePass.TranslucentBasePass_Shared_Fog_DirectionalInscatteringColor.xyz * pow(fast::clamp(dot(_249 * _251, TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.xyz), 0.0, 1.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_DirectionalInscatteringColor.w)) * (1.0 - fast::clamp(exp2(-(_326 * fast::max(_294 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.w, 0.0))), 0.0, 1.0));
    }
    else
    {
        _396 = float3(0.0);
    }
    bool _405 = (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w > 0.0) && (_252 > TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w);
    float _408 = _405 ? 1.0 : fast::max(fast::clamp(exp2(-(_326 * _294)), 0.0, 1.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.w);
    float4 _415 = float4((_368 * (1.0 - _408)) + select(_396, float3(0.0), bool3(_405)), _408);
    float4 _492;
    if (View.View_SkyAtmosphereApplyCameraAerialPerspectiveVolume > 0.0)
    {
        float3 _429 = (_227 * 9.9999997473787516355514526367188e-06) - (View.View_TranslatedWorldCameraOrigin * 9.9999997473787516355514526367188e-06);
        float _435 = sqrt((fast::max(0.0, length(_429) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
        float _436 = _435 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
        float _443;
        if (_436 < 0.707106769084930419921875)
        {
            _443 = fast::clamp((_436 * _436) * 2.0, 0.0, 1.0);
        }
        else
        {
            _443 = 1.0;
        }
        float2 _471;
        if (View.View_RealTimeReflectionCapture != 0.0)
        {
            float3 _446 = normalize(_429);
            float _447 = _446.z;
            float _450 = sqrt(1.0 - (_447 * _447));
            float2 _453 = _98;
            _453.y = (_447 * 0.5) + 0.5;
            float _458 = acos(_446.x / _450);
            float2 _463 = _453;
            _463.x = (((_446.y / _450) < 0.0) ? (6.283185482025146484375 - _458) : _458) * 0.15915493667125701904296875;
            _471 = (_463 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
        }
        else
        {
            _471 = ((_208.xy / _208.ww) * float2(0.5, -0.5)) + float2(0.5);
        }
        float4 _476 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_471, _435), level(0.0));
        float3 _488 = _415.xyz + (((_476.xyz * _443).xyz * View.View_OneOverPreExposure).xyz * _408);
        float4 _491 = float4(_488.x, _488.y, _488.z, _97.w);
        _491.w = _408 * (1.0 - (_443 * (1.0 - _476.w)));
        _492 = _491;
    }
    else
    {
        _492 = _415;
    }
    out.out_var_TEXCOORD10_centroid = float4(_181[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_181[2], _145 * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _169)].w);
    out_var_TEXCOORD0 = _226;
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    out.out_var_TEXCOORD7 = _492;
    out.gl_Position = _208;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

