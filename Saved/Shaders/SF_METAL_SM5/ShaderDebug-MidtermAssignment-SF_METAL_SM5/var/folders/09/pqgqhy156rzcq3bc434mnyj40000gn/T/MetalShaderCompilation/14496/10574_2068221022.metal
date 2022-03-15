

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
    char _m6_pad[32];
    float View_OutOfBoundsMask;
    char _m7_pad[80];
    float View_UnlitViewmodeMask;
    char _m8_pad[32];
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeMin;
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeInvSize;
    char _m10_pad[80];
    float3 View_IndirectLightingColorScale;
    char _m11_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m12_pad[384];
    float3 View_VolumetricFogInvGridSize;
    float3 View_VolumetricFogGridZParams;
    char _m14_pad[16];
    float3 View_VolumetricLightmapWorldToUVScale;
    float3 View_VolumetricLightmapWorldToUVAdd;
    packed_float3 View_VolumetricLightmapIndirectionTextureSize;
    float View_VolumetricLightmapBrickSize;
    float3 View_VolumetricLightmapBrickTexelSize;
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

constant float _118 = {};
constant float3 _119 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPS_in
{
    float4 in_var_COLOR0 [[user(locn2)]];
    float4 in_var_TEXCOORD0_0 [[user(locn3)]];
    uint in_var_PRIMITIVE_ID [[user(locn4)]];
    float4 in_var_TEXCOORD7 [[user(locn5)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_0000294e_7b468c5e(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(2)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(3)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler Material_Texture2D_0Sampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _152 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _157 = (_152.xyz / float3(_152.w)) - View.View_PreViewTranslation;
    float4 _168 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y));
    float3 _173 = float3(in_var_TEXCOORD0[0].xy, 0.0);
    float3 _174 = dfdx(_173);
    float _175 = dot(_174, _174);
    float3 _176 = dfdy(_173);
    float _177 = dot(_176, _176);
    float _185 = 1.0 / sqrt((abs(_175 - _177) > 9.9999997473787516355514526367188e-06) ? ((_175 >= _177) ? _175 : _177) : _177);
    float3 _194 = fast::clamp(in.in_var_COLOR0.xyz, float3(0.0), float3(1.0));
    float _195 = fast::clamp((((_168.x + (-0.5)) * mix(0.0, 0.0500000007450580596923828125, _185)) + 0.5) * fast::min(fast::max(mix(0.0, 0.004999999888241291046142578125, _185), 0.0), 1.0), 0.0, 1.0);
    float3 _205 = fast::clamp((_157 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _216 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_205.x), int(_205.y), int(_205.z), 0).xyz), 0));
    float3 _238 = (_194 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _245 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _248 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _253;
    if (_248)
    {
        _253 = _238 + (_245 * 0.449999988079071044921875);
    }
    else
    {
        _253 = _238;
    }
    float4 _259 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, ((((_216.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_205 / float3(_216.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0));
    float3 _264 = _119;
    _264.x = _259.x * 0.886227548122406005859375;
    float3 _266 = _264;
    _266.y = _259.y * 0.886227548122406005859375;
    float3 _268 = _266;
    _268.z = _259.z * 0.886227548122406005859375;
    bool _290 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _338;
    if (_290)
    {
        float4 _297 = View.View_WorldToClip * float4(_157, 1.0);
        float _298 = _297.w;
        float4 _326;
        if (_290)
        {
            _326 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_297.xy / float2(_298)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_298 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _326 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _338 = float4(_326.xyz + (in.in_var_TEXCOORD7.xyz * _326.w), _326.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _338 = in.in_var_TEXCOORD7;
    }
    float3 _346 = (_157 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _359 = fast::clamp((float3(0.5) - abs(_346 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float4 _372 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, ((_157 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz), level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _346, level(0.0)), float4((_359.x * _359.y) * _359.z));
    float3 _388 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _419;
    float3 _420;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _394 = in.in_var_PRIMITIVE_ID * 36u;
        bool _407 = any(abs(_157 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _394 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _394 + 19u)].xyz + float3(1.0)));
        float3 _417;
        if (_407)
        {
            _417 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_157, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _417 = _388;
        }
        _419 = _407 ? 1.0 : _195;
        _420 = _417;
    }
    else
    {
        _419 = _195;
        _420 = _388;
    }
    float4 _430 = float4((((mix(_253 * float4(_372.x * 0.886227548122406005859375, _372.y * 0.886227548122406005859375, _372.z * 0.886227548122406005859375, _118).xyz, _253 + (select(_245, float3(0.0), bool3(_248)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((((fast::max(float3(0.0), _268) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) * _253) * fast::max(float3(1.0), ((((((_194 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_194 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_194 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _420) * _338.w) + _338.xyz, _419);
    float3 _434 = _430.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_434.x, _434.y, _434.z, _430.w);
    return out;
}

