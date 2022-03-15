

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
    char _m11_pad[800];
    float3 View_VolumetricFogInvGridSize;
    float3 View_VolumetricFogGridZParams;
    char _m13_pad[16];
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

struct type_TranslucentSelfShadow
{
    float4x4 TranslucentSelfShadow_WorldToShadowMatrix;
    float4 TranslucentSelfShadow_ShadowUVMinMax;
    char _m2_pad[16];
    float4 TranslucentSelfShadow_DirectionalLightColor;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float3 _126 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPS_in
{
    float4 in_var_TEXCOORD0_0 [[user(locn2)]];
    uint in_var_PRIMITIVE_ID [[user(locn3)]];
    float4 in_var_TEXCOORD7 [[user(locn4)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00002ce0_2fa1afc4(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(2)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(2)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(3)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(4)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(5)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(6)]], texture2d<float> Material_Texture2D_0 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler Material_Texture2D_0Sampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _157 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _162 = (_157.xyz / float3(_157.w)) - View.View_PreViewTranslation;
    float4 _173 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y));
    float _175 = fast::clamp(_173.x, 0.0, 1.0);
    float3 _185 = fast::clamp((_162 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _196 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_185.x), int(_185.y), int(_185.z), 0).xyz), 0));
    float3 _227 = ((float3(1.0) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz) + (((float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz) * 0.449999988079071044921875);
    float4 _231 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, ((((_196.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_185 / float3(_196.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0));
    float3 _236 = _126;
    _236.x = _231.x * 0.886227548122406005859375;
    float3 _238 = _236;
    _238.y = _231.y * 0.886227548122406005859375;
    float3 _240 = _238;
    _240.z = _231.z * 0.886227548122406005859375;
    bool _250 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _298;
    if (_250)
    {
        float4 _257 = View.View_WorldToClip * float4(_162, 1.0);
        float _258 = _257.w;
        float4 _286;
        if (_250)
        {
            _286 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_257.xy / float2(_258)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_258 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _286 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _298 = float4(_286.xyz + (in.in_var_TEXCOORD7.xyz * _286.w), _286.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _298 = in.in_var_TEXCOORD7;
    }
    float3 _306 = (_162 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _319 = fast::clamp((float3(0.5) - abs(_306 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float4 _332 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, ((_162 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz), level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _306, level(0.0)), float4((_319.x * _319.y) * _319.z));
    float _339 = _332.w;
    float3 _341 = float4(_332.x * 0.886227548122406005859375, _332.y * 0.886227548122406005859375, _332.z * 0.886227548122406005859375, _339).xyz;
    float3 _407;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _355 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_162, 1.0);
        float2 _359 = _355.xy / float2(_355.w);
        float _360 = _355.z;
        float4 _363 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _359, level(0.0));
        float3 _367 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _360;
        bool2 _392 = _359 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _394 = _359 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _407 = _227 * fast::max(_341 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _339) * (float3(1.0) - select(fast::clamp(exp((float3((((_363.x * _360) * 0.5) + dot((sin(_367) * _363.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_367)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _359, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_392.x || _394.x, _392.y || _394.y)))))), float3(0.0));
    }
    else
    {
        _407 = _227 * _341;
    }
    float3 _412 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _443;
    float3 _444;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _418 = in.in_var_PRIMITIVE_ID * 36u;
        bool _431 = any(abs(_162 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _418 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _418 + 19u)].xyz + float3(1.0)));
        float3 _441;
        if (_431)
        {
            _441 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_162, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _441 = _412;
        }
        _443 = _431 ? 1.0 : _175;
        _444 = _441;
    }
    else
    {
        _443 = _175;
        _444 = _412;
    }
    float4 _454 = float4((((mix(_407, _227, float3(View.View_UnlitViewmodeMask)) + ((((fast::max(float3(0.0), _240) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) * _227) * float3(1.000099658966064453125))) + _444) * _298.w) + _298.xyz, _443);
    float3 _458 = _454.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_458.x, _458.y, _458.z, _454.w);
    return out;
}

