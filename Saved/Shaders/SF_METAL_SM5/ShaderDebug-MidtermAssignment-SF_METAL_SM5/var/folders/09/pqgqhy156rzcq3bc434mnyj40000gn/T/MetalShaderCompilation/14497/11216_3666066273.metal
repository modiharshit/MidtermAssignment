

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

struct type_View
{
    char _m0_pad[64];
    float4x4 View_WorldToClip;
    char _m1_pad[576];
    float4x4 View_SVPositionToTranslatedWorld;
    char _m2_pad[352];
    float3 View_PreViewTranslation;
    char _m3_pad[1028];
    float View_PreExposure;
    float4 View_DiffuseOverrideParameter;
    float4 View_SpecularOverrideParameter;
    float4 View_NormalOverrideParameter;
    char _m7_pad[16];
    float View_OutOfBoundsMask;
    char _m8_pad[24];
    float View_CullingSign;
    char _m9_pad[52];
    float View_UnlitViewmodeMask;
    char _m10_pad[32];
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeMin;
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeInvSize;
    char _m12_pad[508];
    float View_RenderingReflectionCaptureMask;
    char _m13_pad[48];
    float4 View_SkyLightColor;
    char _m14_pad[320];
    float3 View_VolumetricFogInvGridSize;
    float3 View_VolumetricFogGridZParams;
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_TranslucentBasePass
{
    char _m0_pad[1836];
    float TranslucentBasePass_Shared_Fog_ApplyVolumetricFog;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float _114 = {};
constant float3 _115 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPS_in
{
    float4 in_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 in_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 in_var_COLOR0 [[user(locn2)]];
    float4 in_var_TEXCOORD0_0 [[user(locn3)]];
    uint in_var_PRIMITIVE_ID [[user(locn4)]];
    float4 in_var_TEXCOORD7 [[user(locn5)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00002bd0_da83bb61(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(1)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(2)]], texture2d<float> Material_Texture2D_0 [[texture(3)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler Material_Texture2D_0Sampler [[sampler(1)]], float4 gl_FragCoord [[position]], bool gl_FrontFacing [[front_facing]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _157 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _162 = (_157.xyz / float3(_157.w)) - View.View_PreViewTranslation;
    uint _163 = in.in_var_PRIMITIVE_ID * 36u;
    float3 _179 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * ((View.View_CullingSign * View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _163 + 4u)].w) * float(gl_FrontFacing ? 1 : (-1)));
    float4 _190 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y));
    float3 _195 = float3(in_var_TEXCOORD0[0].xy, 0.0);
    float3 _196 = dfdx(_195);
    float _197 = dot(_196, _196);
    float3 _198 = dfdy(_195);
    float _199 = dot(_198, _198);
    float _207 = 1.0 / sqrt((abs(_197 - _199) > 9.9999997473787516355514526367188e-06) ? ((_197 >= _199) ? _197 : _199) : _199);
    float3 _216 = fast::clamp(in.in_var_COLOR0.xyz, float3(0.0), float3(1.0));
    float _217 = fast::clamp((((_190.x + (-0.5)) * mix(0.0, 0.0500000007450580596923828125, _207)) + 0.5) * fast::min(fast::max(mix(0.0, 0.004999999888241291046142578125, _207), 0.0), 1.0), 0.0, 1.0);
    float3 _224 = (_216 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _231 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _234 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _239;
    if (_234)
    {
        _239 = _224 + (_231 * 0.449999988079071044921875);
    }
    else
    {
        _239 = _224;
    }
    float _242 = _179.x;
    float _243 = _179.y;
    float4 _245 = float4(_242, _243, _179.z, 1.0);
    float3 _249 = _115;
    _249.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _245);
    float3 _253 = _249;
    _253.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _245);
    float3 _257 = _253;
    _257.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _245);
    float4 _260 = _245.xyzz * _245.yzzx;
    float3 _264 = _115;
    _264.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _260);
    float3 _268 = _264;
    _268.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _260);
    float3 _272 = _268;
    _272.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _260);
    bool _302 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _351;
    if (_302)
    {
        float4 _309 = View.View_WorldToClip * float4(_162, 1.0);
        float _310 = _309.w;
        float4 _339;
        if (_302)
        {
            _339 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_309.xy / float2(_310)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_310 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _339 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _351 = float4(_339.xyz + (in.in_var_TEXCOORD7.xyz * _339.w), _339.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _351 = in.in_var_TEXCOORD7;
    }
    float3 _359 = (_162 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _372 = fast::clamp((float3(0.5) - abs(_359 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float4 _386 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, ((_162 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz), level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _359, level(0.0)), float4((_372.x * _372.y) * _372.z));
    float3 _402 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _432;
    float3 _433;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        bool _420 = any(abs(_162 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _163 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _163 + 19u)].xyz + float3(1.0)));
        float3 _430;
        if (_420)
        {
            _430 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_162, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _430 = _402;
        }
        _432 = _420 ? 1.0 : _217;
        _433 = _430;
    }
    else
    {
        _432 = _217;
        _433 = _402;
    }
    float4 _443 = float4((((mix(_239 * float4(_386.x * 0.886227548122406005859375, _386.y * 0.886227548122406005859375, _386.z * 0.886227548122406005859375, _114).xyz, _239 + (select(_231, float3(0.0), bool3(_234)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((((fast::max(float3(0.0), (_257 + _272) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_242 * _242) - (_243 * _243)))) * View.View_SkyLightColor.xyz) * 1.0) * _239) * fast::max(float3(1.0), ((((((_216 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_216 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_216 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _433) * _351.w) + _351.xyz, _432);
    float3 _447 = _443.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_447.x, _447.y, _447.z, _443.w);
    return out;
}

