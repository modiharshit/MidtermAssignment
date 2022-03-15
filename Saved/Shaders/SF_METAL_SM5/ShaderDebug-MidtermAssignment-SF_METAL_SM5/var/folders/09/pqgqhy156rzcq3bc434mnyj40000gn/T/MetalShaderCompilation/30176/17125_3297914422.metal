

#pragma clang diagnostic ignored "-Wmissing-prototypes"
#pragma clang diagnostic ignored "-Wmissing-braces"

#include <metal_stdlib>
#include <simd/simd.h>


template<typename T>
static inline __attribute__((always_inline))
T ue4_cross(T x, T y)
{
    metal::float3 fx = metal::float3(x);
    metal::float3 fy = metal::float3(y);
    return T(metal::fma(fx[1], fy[2], -metal::fma(fy[1], fx[2], 0.0)), metal::fma(fx[2], fy[0], -metal::fma(fy[2], fx[0], 0.0)), metal::fma(fx[0], fy[1], -metal::fma(fy[0], fx[1], 0.0)));
}
#define cross ue4_cross

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

constant float3x3 _92 = {};
constant float4 _93 = {};
constant float2 _94 = {};

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

template<typename T>
T spvFMul(T l, T r)
{
    return fma(l, r, T(0));
}

template<typename T, int Cols, int Rows>
vec<T, Cols> spvFMulVectorMatrix(vec<T, Rows> v, matrix<T, Cols, Rows> m)
{
    vec<T, Cols> res = vec<T, Cols>(0);
    for (uint i = Rows; i > 0; --i)
    {
        vec<T, Cols> tmp(0);
        for (uint j = 0; j < Cols; ++j)
        {
            tmp[j] = m[j][i - 1];
        }
        res = fma(tmp, vec<T, Cols>(v[i - 1]), res);
    }
    return res;
}

template<typename T, int Cols, int Rows>
vec<T, Rows> spvFMulMatrixVector(matrix<T, Cols, Rows> m, vec<T, Cols> v)
{
    vec<T, Rows> res = vec<T, Rows>(0);
    for (uint i = Cols; i > 0; --i)
    {
        res = fma(m[i - 1], vec<T, Rows>(v[i - 1]), res);
    }
    return res;
}

template<typename T, int LCols, int LRows, int RCols, int RRows>
matrix<T, RCols, LRows> spvFMulMatrixMatrix(matrix<T, LCols, LRows> l, matrix<T, RCols, RRows> r)
{
    matrix<T, RCols, LRows> res;
    for (uint i = 0; i < RCols; i++)
    {
        vec<T, RCols> tmp(0);
        for (uint j = 0; j < LCols; j++)
        {
            tmp = fma(vec<T, RCols>(r[i][j]), l[j], tmp);
        }
        res[i] = tmp;
    }
    return res;
}

template<typename T>
T spvFAdd(T l, T r)
{
    return fma(T(1), l, r);
}

vertex Main_out Main_000042e5_c4922e36(Main_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(1)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_LocalVF& LocalVF [[buffer(4)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(0)]], texturecube<float> TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap [[texture(1)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(2)]], sampler TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler [[sampler(0)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(1)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[1];
    uint _137 = 2u * (uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex));
    float4 _142 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_137 + 1u)));
    float _143 = _142.w;
    float3 _144 = _142.xyz;
    float3 _146 = cross(_144, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_137)).xyz) * _143;
    float3x3 _149 = _92;
    _149[0] = cross(_146, _144) * _143;
    float3x3 _150 = _149;
    _150[1] = _146;
    float3x3 _151 = _150;
    _151[2] = _144;
    uint _152 = in.in_var_ATTRIBUTE13 * 36u;
    uint _155 = _152 + 1u;
    uint _158 = _152 + 2u;
    uint _161 = _152 + 3u;
    uint _167 = _152 + 4u;
    float3x3 _172 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _152)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _155)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _158)].xyz);
    _172[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _152)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _167)].x;
    float3x3 _175 = _172;
    _175[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _155)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _167)].y;
    float3x3 _178 = _175;
    _178[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _158)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _167)].z;
    float3x3 _179 = spvFMulMatrixMatrix(_178, _151);
    float3 _191 = spvFMul(View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _155)].xyz, in.in_var_ATTRIBUTE0.yyy);
    float3 _192 = fma(View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _152)].xyz, in.in_var_ATTRIBUTE0.xxx, _191);
    float3 _195 = fma(View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _158)].xyz, in.in_var_ATTRIBUTE0.zzz, _192);
    float3 _197 = spvFAdd(View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _161)].xyz, View.View_PreViewTranslation);
    float3 _198 = spvFAdd(_195, _197);
    float _199 = _198.x;
    float _200 = _198.y;
    float _201 = _198.z;
    float4 _202 = float4(_199, _200, _201, 1.0);
    float3 _203 = _202.xyz;
    float3 _204 = _203 - View.View_PreViewTranslation;
    float3 _205 = View.View_WorldCameraOrigin - _204;
    float _206 = dot(_205, _205);
    float _207 = sqrt(_206);
    float3 _208 = float3(_207);
    float3 _209 = _205 / _208;
    float _210 = _207 - 20.0;
    float _211 = fast::min(999999988484154753734934528.0, _210);
    float3 _212 = _209 * _211;
    float3 _213 = spvFAdd(_203, _212);
    float4 _214 = float4(_213.x, _213.y, _213.z, _202.w);
    float4 _215 = spvFMulMatrixVector(View.View_TranslatedWorldToClip, _214);
    float3 _226 = _213.xyz;
    float3 _227 = _226 - View.View_TranslatedWorldCameraOrigin;
    float _244 = fast::min(View.View_WorldCameraOrigin.z, TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.z);
    float _247 = spvFAdd(_227.z, View.View_WorldCameraOrigin.z - _244);
    float3 _248 = _227;
    _248.z = _247;
    float _249 = dot(_248, _248);
    float _250 = rsqrt(_249);
    float _251 = spvFMul(_249, _250);
    float _259 = fast::max(fast::max(spvFMul(View.View_VolumetricFogMaxDistance, length(_227) / dot(_227, View.View_ViewForward)), 0.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.w);
    float _293;
    float _294;
    float _295;
    float _296;
    if (_259 > 0.0)
    {
        float _263 = spvFMul(_259, _250);
        float _265 = fma(_263, _247, _244);
        _293 = spvFMul(1.0 - _263, _251);
        _294 = spvFMul(TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.z, exp2(-fast::max(-127.0, spvFMul(TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y, _265 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.w))));
        _295 = spvFMul(TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.x, exp2(-fast::max(-127.0, spvFMul(TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y, _265 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.y))));
        _296 = _247 - spvFMul(_263, _247);
    }
    else
    {
        _293 = _251;
        _294 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.x;
        _295 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.x;
        _296 = _247;
    }
    float _300 = fast::max(-127.0, spvFMul(TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters.y, _296));
    float _313 = fast::max(-127.0, spvFMul(TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters2.y, _296));
    float _324 = fma(_295, (abs(_300) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_300)) / _300) : (0.693147182464599609375 - spvFMul(0.2402265071868896484375, _300)), spvFMul(_294, (abs(_313) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_313)) / _313) : (0.693147182464599609375 - spvFMul(0.2402265071868896484375, _313))));
    float3 _365;
    if (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.z > 0.0)
    {
        float2 _350 = float2(dot(_248.xy, float2(TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation.y, -TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation.x)), dot(_248.xy, TranslucentBasePass.TranslucentBasePass_Shared_Fog_SinCosInscatteringColorCubemapRotation));
        float3 _351 = float3(_350.x, _350.y, _248.z);
        _365 = spvFMul(TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.xyz, mix(TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap.sample(TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler, _351, level(TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.z)).xyz, TranslucentBasePass_Shared_Fog_FogInscatteringColorCubemap.sample(TranslucentBasePass_Shared_Fog_FogInscatteringColorSampler, _351, level(0.0)).xyz, float3(fast::clamp(fma(_251, TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.x, TranslucentBasePass.TranslucentBasePass_Shared_Fog_FogInscatteringTextureParameters.y), 0.0, 1.0))));
    }
    else
    {
        _365 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.xyz;
    }
    float3 _393;
    if ((TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.w >= 0.0) && (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.z == 0.0))
    {
        _393 = (TranslucentBasePass.TranslucentBasePass_Shared_Fog_DirectionalInscatteringColor.xyz * pow(fast::clamp(dot(_248 * _250, TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.xyz), 0.0, 1.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_DirectionalInscatteringColor.w)) * (1.0 - fast::clamp(exp2(-spvFMul(_324, fast::max(_293 - TranslucentBasePass.TranslucentBasePass_Shared_Fog_InscatteringLightDirection.w, 0.0))), 0.0, 1.0));
    }
    else
    {
        _393 = float3(0.0);
    }
    bool _402 = (TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w > 0.0) && (_251 > TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogParameters3.w);
    float _405 = _402 ? 1.0 : fast::max(fast::clamp(exp2(-spvFMul(_324, _293)), 0.0, 1.0), TranslucentBasePass.TranslucentBasePass_Shared_Fog_ExponentialFogColorParameter.w);
    float4 _412 = float4(spvFAdd(_365 * (1.0 - _405), select(_393, float3(0.0), bool3(_402))), _405);
    float4 _487;
    if (View.View_SkyAtmosphereApplyCameraAerialPerspectiveVolume > 0.0)
    {
        float3 _425 = (_226 * 9.9999997473787516355514526367188e-06) - (View.View_TranslatedWorldCameraOrigin * 9.9999997473787516355514526367188e-06);
        float _431 = sqrt(spvFMul(spvFMul(fast::max(0.0, length(_425) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm), View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv), View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv));
        float _432 = spvFMul(_431, View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution);
        float _439;
        if (_432 < 0.707106769084930419921875)
        {
            _439 = fast::clamp(spvFMul(spvFMul(_432, _432), 2.0), 0.0, 1.0);
        }
        else
        {
            _439 = 1.0;
        }
        float2 _466;
        if (View.View_RealTimeReflectionCapture != 0.0)
        {
            float3 _442 = normalize(_425);
            float _443 = _442.z;
            float _446 = sqrt(1.0 - spvFMul(_443, _443));
            float2 _448 = _94;
            _448.y = fma(_443, 0.5, 0.5);
            float _453 = acos(_442.x / _446);
            float2 _458 = _448;
            _458.x = spvFMul(((_442.y / _446) < 0.0) ? (6.283185482025146484375 - _453) : _453, 0.15915493667125701904296875);
            _466 = spvFMul(spvFAdd(_458, View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5), View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / spvFAdd(View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy, float2(1.0)));
        }
        else
        {
            _466 = fma(_215.xy / _215.ww, float2(0.5, -0.5), float2(0.5));
        }
        float4 _471 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_466, _431), level(0.0));
        float3 _483 = spvFAdd(_412.xyz, ((_471.xyz * _439).xyz * View.View_OneOverPreExposure).xyz * _405);
        float4 _486 = float4(_483.x, _483.y, _483.z, _93.w);
        _486.w = spvFMul(_405, 1.0 - spvFMul(_439, 1.0 - _471.w));
        _487 = _486;
    }
    else
    {
        _487 = _412;
    }
    out.out_var_TEXCOORD10_centroid = float4(_179[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_179[2], spvFMul(_143, View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _167)].w));
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    out.out_var_TEXCOORD7 = _487;
    out.gl_Position = _215;
    return out;
}

