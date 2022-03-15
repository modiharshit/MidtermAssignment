

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
    char _m13_pad[80];
    float View_IndirectLightingCacheShowFlag;
};

struct type_Primitive
{
    char _m0_pad[80];
    float4 Primitive_ObjectWorldPositionAndRadius;
    char _m1_pad[208];
    float3 Primitive_ObjectBounds;
};

struct type_TranslucentBasePass
{
    char _m0_pad[1836];
    float TranslucentBasePass_Shared_Fog_ApplyVolumetricFog;
};

struct type_IndirectLightingCache
{
    char _m0_pad[96];
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients0;
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

constant float3 _121 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPS_in
{
    float4 in_var_TEXCOORD1 [[user(locn2)]];
    float4 in_var_TEXCOORD2 [[user(locn3)]];
    float4 in_var_COLOR1 [[user(locn4)]];
    float4 in_var_TEXCOORD7 [[user(locn5)]];
};

fragment MainPS_out Main_00002a57_18536b99(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(4)]], constant type_Material& Material [[buffer(5)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(1)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(2)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(3)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler Material_Texture2D_0Sampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    float4 _149 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _154 = (_149.xyz / float3(_149.w)) - View.View_PreViewTranslation;
    float4 _165 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, in.in_var_TEXCOORD1.xy);
    float4 _167 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, in.in_var_TEXCOORD2.xy);
    float3 _174 = fast::clamp(in.in_var_COLOR1.xyz, float3(0.0), float3(1.0));
    float _175 = fast::clamp(in.in_var_COLOR1.w * mix(_165, _167, float4(in.in_var_TEXCOORD2.z)).x, 0.0, 1.0);
    float3 _191 = ((_174 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz) + (((float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz) * 0.449999988079071044921875);
    float3 _209;
    if (View.View_IndirectLightingCacheShowFlag > 0.0)
    {
        float3 _204 = _121;
        _204.x = IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0].x * 0.886227548122406005859375;
        float3 _206 = _204;
        _206.y = IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1].x * 0.886227548122406005859375;
        float3 _208 = _206;
        _208.z = IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2].x * 0.886227548122406005859375;
        _209 = _208;
    }
    else
    {
        _209 = float3(0.0);
    }
    bool _229 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _278;
    if (_229)
    {
        float4 _236 = View.View_WorldToClip * float4(_154, 1.0);
        float _237 = _236.w;
        float4 _266;
        if (_229)
        {
            _266 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_236.xy / float2(_237)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_237 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _266 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _278 = float4(_266.xyz + (in.in_var_TEXCOORD7.xyz * _266.w), _266.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _278 = in.in_var_TEXCOORD7;
    }
    float3 _286 = (_154 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _299 = fast::clamp((float3(0.5) - abs(_286 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float4 _313 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, ((_154 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz), level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _286, level(0.0)), float4((_299.x * _299.y) * _299.z));
    float _320 = _313.w;
    float3 _322 = float4(_313.x * 0.886227548122406005859375, _313.y * 0.886227548122406005859375, _313.z * 0.886227548122406005859375, _320).xyz;
    float3 _388;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _336 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_154, 1.0);
        float2 _340 = _336.xy / float2(_336.w);
        float _341 = _336.z;
        float4 _344 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _340, level(0.0));
        float3 _348 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _341;
        bool2 _373 = _340 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _375 = _340 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _388 = _191 * fast::max(_322 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _320) * (float3(1.0) - select(fast::clamp(exp((float3((((_344.x * _341) * 0.5) + dot((sin(_348) * _344.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_348)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _340, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_373.x || _375.x, _373.y || _375.y)))))), float3(0.0));
    }
    else
    {
        _388 = _191 * _322;
    }
    float3 _393 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _420;
    float3 _421;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        bool _408 = any(abs(_154 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0)));
        float3 _418;
        if (_408)
        {
            _418 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_154, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _418 = _393;
        }
        _420 = _408 ? 1.0 : _175;
        _421 = _418;
    }
    else
    {
        _420 = _175;
        _421 = _393;
    }
    float4 _431 = float4((((mix(_388, _191, float3(View.View_UnlitViewmodeMask)) + (((_209 * View.View_IndirectLightingColorScale) * _191) * fast::max(float3(1.0), ((((((_174 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_174 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_174 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _421) * _278.w) + _278.xyz, _420);
    float3 _435 = _431.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_435.x, _435.y, _435.z, _431.w);
    return out;
}

