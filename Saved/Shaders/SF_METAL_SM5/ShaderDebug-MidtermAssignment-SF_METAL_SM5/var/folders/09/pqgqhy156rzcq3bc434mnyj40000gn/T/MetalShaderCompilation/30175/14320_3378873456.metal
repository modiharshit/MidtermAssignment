

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
    char _m8_pad[48];
    float View_MaterialTextureMipBias;
    char _m9_pad[28];
    float View_UnlitViewmodeMask;
    char _m10_pad[32];
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeMin;
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeInvSize;
    char _m12_pad[80];
    float3 View_IndirectLightingColorScale;
    char _m13_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m14_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m16_pad[320];
    float3 View_VolumetricFogInvGridSize;
    float3 View_VolumetricFogGridZParams;
    char _m18_pad[16];
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

constant float3 _132 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPS_in
{
    float4 in_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 in_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 in_var_TEXCOORD0_0 [[user(locn2)]];
    uint in_var_PRIMITIVE_ID [[user(locn3)]];
    float4 in_var_TEXCOORD7 [[user(locn4)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_000037f0_c9658470(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(6)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(3)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(4)]], constant type_Material& Material [[buffer(5)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(2)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(3)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(4)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(5)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(6)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler Material_Texture2D_0Sampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _176 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _181 = (_176.xyz / float3(_176.w)) - View.View_PreViewTranslation;
    float4 _195 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _216 = fast::clamp((_181 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _227 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_216.x), int(_216.y), int(_216.z), 0).xyz), 0));
    float3 _242 = (((_227.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_216 / float3(_227.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float3 _252 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _255 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _260;
    if (_255)
    {
        _260 = View.View_DiffuseOverrideParameter.xyz + (_252 * 0.449999988079071044921875);
    }
    else
    {
        _260 = View.View_DiffuseOverrideParameter.xyz;
    }
    float4 _266 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _242, level(0.0));
    float3 _271 = _132;
    _271.x = _266.x * 0.886227548122406005859375;
    float3 _273 = _271;
    _273.y = _266.y * 0.886227548122406005859375;
    float3 _275 = _273;
    _275.z = _266.z * 0.886227548122406005859375;
    float _296;
    float3 _297;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _291 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _242, level(0.0)).xyz * 2.0) - float3(1.0);
        float _292 = length(_291);
        _296 = _292;
        _297 = _291 / float3(fast::max(_292, 9.9999997473787516355514526367188e-05));
    }
    else
    {
        _296 = 1.0;
        _297 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    }
    float4 _301 = float4(_297, 1.0);
    float3 _305 = _132;
    _305.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _301);
    float3 _309 = _305;
    _309.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _301);
    float3 _313 = _309;
    _313.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _301);
    float4 _316 = _301.xyzz * _301.yzzx;
    float3 _320 = _132;
    _320.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _316);
    float3 _324 = _320;
    _324.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _316);
    float3 _328 = _324;
    _328.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _316);
    bool _346 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _394;
    if (_346)
    {
        float4 _353 = View.View_WorldToClip * float4(_181, 1.0);
        float _354 = _353.w;
        float4 _382;
        if (_346)
        {
            _382 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_353.xy / float2(_354)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_354 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _382 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _394 = float4(_382.xyz + (in.in_var_TEXCOORD7.xyz * _382.w), _382.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _394 = in.in_var_TEXCOORD7;
    }
    float3 _402 = (_181 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _415 = fast::clamp((float3(0.5) - abs(_402 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float4 _428 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, ((_181 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz), level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _402, level(0.0)), float4((_415.x * _415.y) * _415.z));
    float _435 = _428.w;
    float3 _437 = float4(_428.x * 0.886227548122406005859375, _428.y * 0.886227548122406005859375, _428.z * 0.886227548122406005859375, _435).xyz;
    float3 _503;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _451 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_181, 1.0);
        float2 _455 = _451.xy / float2(_451.w);
        float _456 = _451.z;
        float4 _459 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _455, level(0.0));
        float3 _463 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _456;
        bool2 _488 = _455 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _490 = _455 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _503 = _260 * fast::max(_437 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _435) * (float3(1.0) - select(fast::clamp(exp((float3((((_459.x * _456) * 0.5) + dot((sin(_463) * _459.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_463)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _455, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_488.x || _490.x, _488.y || _490.y)))))), float3(0.0));
    }
    else
    {
        _503 = _260 * _437;
    }
    float3 _510 = fast::max(mix(float3(_195.yxz), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _540;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _516 = in.in_var_PRIMITIVE_ID * 36u;
        float3 _539;
        if (any(abs(_181 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _516 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _516 + 19u)].xyz + float3(1.0))))
        {
            _539 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_181, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _539 = _510;
        }
        _540 = _539;
    }
    else
    {
        _540 = _510;
    }
    float4 _550 = float4((((mix(_503, _260 + (select(_252, float3(0.0), bool3(_255)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((((fast::max(float3(0.0), _275) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_313 + _328) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_297.x * _297.x) - (_297.y * _297.y)))) * View.View_SkyLightColor.xyz) * _296)) * _260)) + _540) * _394.w) + _394.xyz, 1.0);
    float3 _554 = _550.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_554.x, _554.y, _554.z, _550.w);
    return out;
}

