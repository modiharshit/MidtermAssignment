

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

constant float3 _127 = {};

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

fragment MainPS_out Main_00002c7a_deb7cd0f(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(2)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(2)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(3)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(4)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(5)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(6)]], texture2d<float> Material_Texture2D_0 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler Material_Texture2D_0Sampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    float4 _160 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _165 = (_160.xyz / float3(_160.w)) - View.View_PreViewTranslation;
    float4 _176 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, in.in_var_TEXCOORD1.xy);
    float4 _178 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, in.in_var_TEXCOORD2.xy);
    float3 _185 = fast::clamp(in.in_var_COLOR1.xyz, float3(0.0), float3(1.0));
    float _186 = fast::clamp(in.in_var_COLOR1.w * mix(_176, _178, float4(in.in_var_TEXCOORD2.z)).x, 0.0, 1.0);
    float3 _196 = fast::clamp((_165 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _207 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_196.x), int(_196.y), int(_196.z), 0).xyz), 0));
    float3 _238 = ((_185 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz) + (((float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz) * 0.449999988079071044921875);
    float4 _242 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, ((((_207.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_196 / float3(_207.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0));
    float3 _247 = _127;
    _247.x = _242.x * 0.886227548122406005859375;
    float3 _249 = _247;
    _249.y = _242.y * 0.886227548122406005859375;
    float3 _251 = _249;
    _251.z = _242.z * 0.886227548122406005859375;
    bool _273 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _321;
    if (_273)
    {
        float4 _280 = View.View_WorldToClip * float4(_165, 1.0);
        float _281 = _280.w;
        float4 _309;
        if (_273)
        {
            _309 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_280.xy / float2(_281)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_281 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _309 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _321 = float4(_309.xyz + (in.in_var_TEXCOORD7.xyz * _309.w), _309.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _321 = in.in_var_TEXCOORD7;
    }
    float3 _329 = (_165 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _342 = fast::clamp((float3(0.5) - abs(_329 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float4 _355 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, ((_165 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz), level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _329, level(0.0)), float4((_342.x * _342.y) * _342.z));
    float _362 = _355.w;
    float3 _364 = float4(_355.x * 0.886227548122406005859375, _355.y * 0.886227548122406005859375, _355.z * 0.886227548122406005859375, _362).xyz;
    float3 _430;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _378 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_165, 1.0);
        float2 _382 = _378.xy / float2(_378.w);
        float _383 = _378.z;
        float4 _386 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _382, level(0.0));
        float3 _390 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _383;
        bool2 _415 = _382 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _417 = _382 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _430 = _238 * fast::max(_364 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _362) * (float3(1.0) - select(fast::clamp(exp((float3((((_386.x * _383) * 0.5) + dot((sin(_390) * _386.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_390)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _382, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_415.x || _417.x, _415.y || _417.y)))))), float3(0.0));
    }
    else
    {
        _430 = _238 * _364;
    }
    float3 _435 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _462;
    float3 _463;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        bool _450 = any(abs(_165 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0)));
        float3 _460;
        if (_450)
        {
            _460 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_165, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _460 = _435;
        }
        _462 = _450 ? 1.0 : _186;
        _463 = _460;
    }
    else
    {
        _462 = _186;
        _463 = _435;
    }
    float4 _473 = float4((((mix(_430, _238, float3(View.View_UnlitViewmodeMask)) + ((((fast::max(float3(0.0), _251) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) * _238) * fast::max(float3(1.0), ((((((_185 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_185 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_185 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _463) * _321.w) + _321.xyz, _462);
    float3 _477 = _473.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_477.x, _477.y, _477.z, _473.w);
    return out;
}

