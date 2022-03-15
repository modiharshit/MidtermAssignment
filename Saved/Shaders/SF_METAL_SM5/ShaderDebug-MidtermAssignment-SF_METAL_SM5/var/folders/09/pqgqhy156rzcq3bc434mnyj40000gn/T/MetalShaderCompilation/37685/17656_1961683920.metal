

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
    char _m1_pad[320];
    float4x4 View_ViewToClip;
    char _m2_pad[192];
    float4x4 View_SVPositionToTranslatedWorld;
    char _m3_pad[272];
    float4 View_InvDeviceZToWorldZTransform;
    float4 View_ScreenPositionScaleBias;
    char _m5_pad[48];
    float3 View_PreViewTranslation;
    char _m6_pad[928];
    float4 View_ViewRectMin;
    float4 View_ViewSizeAndInvSize;
    char _m8_pad[68];
    float View_PreExposure;
    float4 View_DiffuseOverrideParameter;
    float4 View_SpecularOverrideParameter;
    float4 View_NormalOverrideParameter;
    char _m12_pad[16];
    float View_OutOfBoundsMask;
    char _m13_pad[48];
    float View_MaterialTextureMipBias;
    char _m14_pad[28];
    float View_UnlitViewmodeMask;
    char _m15_pad[32];
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeMin;
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeInvSize;
    char _m17_pad[80];
    float3 View_IndirectLightingColorScale;
    char _m18_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m19_pad[384];
    float3 View_VolumetricFogInvGridSize;
    float3 View_VolumetricFogGridZParams;
    char _m21_pad[80];
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
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients1;
    float4 IndirectLightingCache_IndirectLightingSHCoefficients2;
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

constant float4 _153 = {};
constant float4 _155 = {};
constant float3 _156 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPS_in
{
    float4 in_var_TEXCOORD0_0 [[user(locn0)]];
    float4 in_var_PARTICLE_SUBUVS [[user(locn1)]];
    float3 in_var_TEXCOORD4 [[user(locn2)]];
    float4 in_var_TEXCOORD5 [[user(locn3)]];
    float3 in_var_PARTICLE_LIGHTING_OFFSET [[user(locn4)]];
    float4 in_var_TANGENTX [[user(locn5)]];
    float4 in_var_TANGENTZ [[user(locn6)]];
    float4 in_var_TEXCOORD7 [[user(locn7)]];
};

fragment MainPS_out Main_000044f8_74ecebd0(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(4)]], constant type_Material& Material [[buffer(5)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], texture2d<float> TranslucentBasePass_SceneTextures_SceneDepthTexture [[texture(1)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(2)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(3)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(4)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(5)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(6)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_SceneTextures_PointClampSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    float4 _220 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _224 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _229 = (_224.xyz / float3(_224.w)) - View.View_PreViewTranslation;
    float3 _237 = normalize(float3x3(in.in_var_TANGENTX.xyz, cross(in.in_var_TANGENTZ.xyz, in.in_var_TANGENTX.xyz) * in.in_var_TANGENTZ.w, in.in_var_TANGENTZ.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _251 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 8.0), bias(View.View_MaterialTextureMipBias));
    float4 _255 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, in.in_var_PARTICLE_SUBUVS.xy);
    float4 _257 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, in.in_var_PARTICLE_SUBUVS.zw);
    float4 _259 = mix(_255, _257, float4(in.in_var_TEXCOORD4.x));
    float _271 = _220.w;
    float4 _281 = TranslucentBasePass_SceneTextures_SceneDepthTexture.sample(TranslucentBasePass_SceneTextures_PointClampSampler, (((_220.xy / float2(_271)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz), level(0.0));
    float _282 = _281.x;
    float _312;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _312 = _271;
                break;
            }
            else
            {
                float _305 = _220.z;
                _312 = ((_305 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_305 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _318 = fast::clamp((_251.xyz + _259.xyz) * in.in_var_TEXCOORD5.xyz, float3(0.0), float3(1.0));
    float _319 = fast::clamp(fast::min(fast::max(in.in_var_TEXCOORD5.w * _259.w, 0.0), 1.0) * fast::min(fast::max(((((_282 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_282 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w))) - _312) * 0.006666666828095912933349609375, 0.0), 1.0), 0.0, 1.0);
    float3 _326 = (_318 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _333 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _336 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _341;
    if (_336)
    {
        _341 = _326 + (_333 * 0.449999988079071044921875);
    }
    else
    {
        _341 = _326;
    }
    float3 _419;
    if (View.View_IndirectLightingCacheShowFlag > 0.0)
    {
        float _367 = _237.y;
        float4 _369 = _155;
        _369.y = (-0.48860299587249755859375) * _367;
        float _370 = _237.z;
        float4 _372 = _369;
        _372.z = 0.48860299587249755859375 * _370;
        float _373 = _237.x;
        float4 _375 = _372;
        _375.w = (-0.48860299587249755859375) * _373;
        float3 _376 = _237 * _237;
        float4 _379 = _153;
        _379.x = (1.09254801273345947265625 * _373) * _367;
        float4 _382 = _379;
        _382.y = ((-1.09254801273345947265625) * _367) * _370;
        float4 _387 = _382;
        _387.z = 0.3153919875621795654296875 * ((3.0 * _376.z) - 1.0);
        float4 _390 = _387;
        _390.w = ((-1.09254801273345947265625) * _373) * _370;
        float4 _394 = _375;
        _394.x = 0.886227548122406005859375;
        float3 _396 = _394.yzw * 2.094395160675048828125;
        float4 _397 = float4(_394.x, _396.x, _396.y, _396.z);
        float4 _398 = _390 * 0.785398185253143310546875;
        float _399 = (_376.x - _376.y) * 0.4290426075458526611328125;
        float3 _405 = _156;
        _405.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _397) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _398)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _399);
        float3 _411 = _405;
        _411.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _397) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _398)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _399);
        float3 _417 = _411;
        _417.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _397) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _398)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _399);
        _419 = fast::max(float3(0.0), _417);
    }
    else
    {
        _419 = float3(0.0);
    }
    bool _439 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _488;
    if (_439)
    {
        float4 _446 = View.View_WorldToClip * float4(_229, 1.0);
        float _447 = _446.w;
        float4 _476;
        if (_439)
        {
            _476 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_446.xy / float2(_447)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_447 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _476 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _488 = float4(_476.xyz + (in.in_var_TEXCOORD7.xyz * _476.w), _476.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _488 = in.in_var_TEXCOORD7;
    }
    float3 _489 = _229 + in.in_var_PARTICLE_LIGHTING_OFFSET;
    float3 _497 = (_489 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _505 = (_489 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _510 = fast::clamp((float3(0.5) - abs(_497 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _515 = (_510.x * _510.y) * _510.z;
    float4 _524 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _505, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _497, level(0.0)), float4(_515));
    float3 _535 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _505, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _497, level(0.0)).xyz, float3(_515)) * 1.0;
    float4 _537 = _155;
    _537.x = _524.x;
    float4 _539 = _155;
    _539.x = _524.y;
    float4 _541 = _155;
    _541.x = _524.z;
    float3 _542 = _524.xyz;
    float3 _546 = _542 / float3(dot(_542, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _548 = _535 * _546.x;
    float3 _551 = _535 * _546.y;
    float3 _554 = _535 * _546.z;
    float4 _558 = _155;
    _558.y = (-0.48860299587249755859375) * _237.y;
    float4 _561 = _558;
    _561.z = 0.48860299587249755859375 * _237.z;
    float4 _564 = _561;
    _564.w = (-0.48860299587249755859375) * _237.x;
    float4 _565 = _564;
    _565.x = 0.886227548122406005859375;
    float3 _567 = _565.yzw * 2.094395160675048828125;
    float4 _568 = float4(_565.x, _567.x, _567.y, _567.z);
    float3 _570 = _156;
    _570.x = dot(float4(_537.x, _548.x, _548.y, _548.z), _568);
    float3 _572 = _570;
    _572.y = dot(float4(_539.x, _551.x, _551.y, _551.z), _568);
    float3 _574 = _572;
    _574.z = dot(float4(_541.x, _554.x, _554.y, _554.z), _568);
    float _576 = _524.w;
    float3 _581 = float4(fast::max(float3(0.0), _574), _576).xyz;
    float3 _647;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _595 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_489, 1.0);
        float2 _599 = _595.xy / float2(_595.w);
        float _600 = _595.z;
        float4 _603 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _599, level(0.0));
        float3 _607 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _600;
        bool2 _632 = _599 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _634 = _599 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _647 = _341 * fast::max(_581 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _576) * (float3(1.0) - select(fast::clamp(exp((float3((((_603.x * _600) * 0.5) + dot((sin(_607) * _603.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_607)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _599, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_632.x || _634.x, _632.y || _634.y)))))), float3(0.0));
    }
    else
    {
        _647 = _341 * _581;
    }
    float3 _654 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _681;
    float3 _682;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        bool _669 = any(abs(_229 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0)));
        float3 _679;
        if (_669)
        {
            _679 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_229, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _679 = _654;
        }
        _681 = _669 ? 1.0 : _319;
        _682 = _679;
    }
    else
    {
        _681 = _319;
        _682 = _654;
    }
    float4 _692 = float4((((mix(_647, _341 + (select(_333, float3(0.0), bool3(_336)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + (((_419 * View.View_IndirectLightingColorScale) * _341) * fast::max(float3(1.0), ((((((_318 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_318 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_318 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _682) * _488.w) + _488.xyz, _681);
    float3 _696 = _692.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_696.x, _696.y, _696.z, _692.w);
    return out;
}

