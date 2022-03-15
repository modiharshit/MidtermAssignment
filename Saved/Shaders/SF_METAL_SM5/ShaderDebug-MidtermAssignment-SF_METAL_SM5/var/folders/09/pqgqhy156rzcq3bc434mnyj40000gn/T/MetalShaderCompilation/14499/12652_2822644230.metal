

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

constant float3 _137 = {};

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

fragment MainPS_out Main_0000316c_a83e2206(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(2)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(2)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(3)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(4)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(5)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(6)]], texture2d<float> Material_Texture2D_0 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler Material_Texture2D_0Sampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _170 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _175 = (_170.xyz / float3(_170.w)) - View.View_PreViewTranslation;
    float4 _186 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y));
    float3 _191 = float3(in_var_TEXCOORD0[0].xy, 0.0);
    float3 _192 = dfdx(_191);
    float _193 = dot(_192, _192);
    float3 _194 = dfdy(_191);
    float _195 = dot(_194, _194);
    float _203 = 1.0 / sqrt((abs(_193 - _195) > 9.9999997473787516355514526367188e-06) ? ((_193 >= _195) ? _193 : _195) : _195);
    float3 _212 = fast::clamp(in.in_var_COLOR0.xyz, float3(0.0), float3(1.0));
    float _213 = fast::clamp((((_186.x + (-0.5)) * mix(0.0, 0.0500000007450580596923828125, _203)) + 0.5) * fast::min(fast::max(mix(0.0, 0.004999999888241291046142578125, _203), 0.0), 1.0), 0.0, 1.0);
    float3 _223 = fast::clamp((_175 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _234 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_223.x), int(_223.y), int(_223.z), 0).xyz), 0));
    float3 _256 = (_212 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _263 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _266 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _271;
    if (_266)
    {
        _271 = _256 + (_263 * 0.449999988079071044921875);
    }
    else
    {
        _271 = _256;
    }
    float4 _277 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, ((((_234.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_223 / float3(_234.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0));
    float3 _282 = _137;
    _282.x = _277.x * 0.886227548122406005859375;
    float3 _284 = _282;
    _284.y = _277.y * 0.886227548122406005859375;
    float3 _286 = _284;
    _286.z = _277.z * 0.886227548122406005859375;
    bool _308 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _356;
    if (_308)
    {
        float4 _315 = View.View_WorldToClip * float4(_175, 1.0);
        float _316 = _315.w;
        float4 _344;
        if (_308)
        {
            _344 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_315.xy / float2(_316)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_316 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _344 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _356 = float4(_344.xyz + (in.in_var_TEXCOORD7.xyz * _344.w), _344.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _356 = in.in_var_TEXCOORD7;
    }
    float3 _364 = (_175 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _377 = fast::clamp((float3(0.5) - abs(_364 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float4 _390 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, ((_175 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz), level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _364, level(0.0)), float4((_377.x * _377.y) * _377.z));
    float _397 = _390.w;
    float3 _399 = float4(_390.x * 0.886227548122406005859375, _390.y * 0.886227548122406005859375, _390.z * 0.886227548122406005859375, _397).xyz;
    float3 _465;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _413 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_175, 1.0);
        float2 _417 = _413.xy / float2(_413.w);
        float _418 = _413.z;
        float4 _421 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _417, level(0.0));
        float3 _425 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _418;
        bool2 _450 = _417 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _452 = _417 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _465 = _271 * fast::max(_399 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _397) * (float3(1.0) - select(fast::clamp(exp((float3((((_421.x * _418) * 0.5) + dot((sin(_425) * _421.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_425)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _417, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_450.x || _452.x, _450.y || _452.y)))))), float3(0.0));
    }
    else
    {
        _465 = _271 * _399;
    }
    float3 _472 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _503;
    float3 _504;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _478 = in.in_var_PRIMITIVE_ID * 36u;
        bool _491 = any(abs(_175 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _478 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _478 + 19u)].xyz + float3(1.0)));
        float3 _501;
        if (_491)
        {
            _501 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_175, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _501 = _472;
        }
        _503 = _491 ? 1.0 : _213;
        _504 = _501;
    }
    else
    {
        _503 = _213;
        _504 = _472;
    }
    float4 _514 = float4((((mix(_465, _271 + (select(_263, float3(0.0), bool3(_266)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((((fast::max(float3(0.0), _286) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) * _271) * fast::max(float3(1.0), ((((((_212 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_212 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_212 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _504) * _356.w) + _356.xyz, _503);
    float3 _518 = _514.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_518.x, _518.y, _518.z, _514.w);
    return out;
}

