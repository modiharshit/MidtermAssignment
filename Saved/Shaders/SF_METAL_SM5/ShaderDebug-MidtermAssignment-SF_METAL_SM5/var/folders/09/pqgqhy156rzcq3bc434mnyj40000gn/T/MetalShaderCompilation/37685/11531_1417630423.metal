

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

constant float3 _129 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPS_in
{
    float4 in_var_PARTICLE_SUBUVS [[user(locn0)]];
    float3 in_var_TEXCOORD4 [[user(locn1)]];
    float4 in_var_TEXCOORD5 [[user(locn2)]];
    float3 in_var_PARTICLE_LIGHTING_OFFSET [[user(locn3)]];
    float4 in_var_TEXCOORD7 [[user(locn6)]];
};

fragment MainPS_out Main_00002d0b_547f52d7(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(2)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(2)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(3)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(4)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(5)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(6)]], texture2d<float> Material_Texture2D_0 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler Material_Texture2D_0Sampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    float4 _163 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _168 = (_163.xyz / float3(_163.w)) - View.View_PreViewTranslation;
    float4 _179 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, in.in_var_PARTICLE_SUBUVS.xy);
    float4 _181 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, in.in_var_PARTICLE_SUBUVS.zw);
    float3 _188 = fast::clamp(in.in_var_TEXCOORD5.xyz, float3(0.0), float3(1.0));
    float _189 = fast::clamp(in.in_var_TEXCOORD5.w * mix(_179, _181, float4(in.in_var_TEXCOORD4.x)).x, 0.0, 1.0);
    float3 _199 = fast::clamp((_168 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _210 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_199.x), int(_199.y), int(_199.z), 0).xyz), 0));
    float3 _241 = ((_188 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz) + (((float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz) * 0.449999988079071044921875);
    float4 _245 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, ((((_210.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_199 / float3(_210.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0));
    float3 _250 = _129;
    _250.x = _245.x * 0.886227548122406005859375;
    float3 _252 = _250;
    _252.y = _245.y * 0.886227548122406005859375;
    float3 _254 = _252;
    _254.z = _245.z * 0.886227548122406005859375;
    bool _276 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _324;
    if (_276)
    {
        float4 _283 = View.View_WorldToClip * float4(_168, 1.0);
        float _284 = _283.w;
        float4 _312;
        if (_276)
        {
            _312 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_283.xy / float2(_284)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_284 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _312 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _324 = float4(_312.xyz + (in.in_var_TEXCOORD7.xyz * _312.w), _312.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _324 = in.in_var_TEXCOORD7;
    }
    float3 _325 = _168 + in.in_var_PARTICLE_LIGHTING_OFFSET;
    float3 _333 = (_325 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _346 = fast::clamp((float3(0.5) - abs(_333 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float4 _359 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, ((_325 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz), level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _333, level(0.0)), float4((_346.x * _346.y) * _346.z));
    float _366 = _359.w;
    float3 _368 = float4(_359.x * 0.886227548122406005859375, _359.y * 0.886227548122406005859375, _359.z * 0.886227548122406005859375, _366).xyz;
    float3 _434;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _382 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_325, 1.0);
        float2 _386 = _382.xy / float2(_382.w);
        float _387 = _382.z;
        float4 _390 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _386, level(0.0));
        float3 _394 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _387;
        bool2 _419 = _386 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _421 = _386 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _434 = _241 * fast::max(_368 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _366) * (float3(1.0) - select(fast::clamp(exp((float3((((_390.x * _387) * 0.5) + dot((sin(_394) * _390.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_394)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _386, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_419.x || _421.x, _419.y || _421.y)))))), float3(0.0));
    }
    else
    {
        _434 = _241 * _368;
    }
    float3 _439 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _466;
    float3 _467;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        bool _454 = any(abs(_168 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0)));
        float3 _464;
        if (_454)
        {
            _464 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_168, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _464 = _439;
        }
        _466 = _454 ? 1.0 : _189;
        _467 = _464;
    }
    else
    {
        _466 = _189;
        _467 = _439;
    }
    float4 _477 = float4((((mix(_434, _241, float3(View.View_UnlitViewmodeMask)) + ((((fast::max(float3(0.0), _254) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) * _241) * fast::max(float3(1.0), ((((((_188 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_188 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_188 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _467) * _324.w) + _324.xyz, _466);
    float3 _481 = _477.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_481.x, _481.y, _481.z, _477.w);
    return out;
}

