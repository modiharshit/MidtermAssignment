

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
    char _m21_pad[16];
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

constant float4 _161 = {};
constant float3 _162 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPS_in
{
    float4 in_var_TEXCOORD10 [[user(locn0)]];
    float4 in_var_TEXCOORD11 [[user(locn1)]];
    float4 in_var_TEXCOORD2 [[user(locn2)]];
    float4 in_var_TEXCOORD3_0 [[user(locn3)]];
    float4 in_var_PARTICLE_SUBUVS [[user(locn4)]];
    float3 in_var_PARTICLE_LIGHTING_OFFSET [[user(locn5)]];
    float4 in_var_TEXCOORD7 [[user(locn6)]];
};

fragment MainPS_out Main_000044e6_1b995ccd(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(2)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(4)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(5)]], texture2d<float> TranslucentBasePass_SceneTextures_SceneDepthTexture [[texture(6)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(7)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(8)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(9)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(10)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(11)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(12)]], texture2d<float> Material_Texture2D_0 [[texture(13)]], texture2d<float> Material_Texture2D_1 [[texture(14)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_SceneTextures_PointClampSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD3 = {};
    in_var_TEXCOORD3[0] = in.in_var_TEXCOORD3_0;
    float4 _229 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _233 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _238 = (_233.xyz / float3(_233.w)) - View.View_PreViewTranslation;
    float3 _246 = normalize(float3x3(in.in_var_TEXCOORD10.xyz, cross(in.in_var_TEXCOORD11.xyz, in.in_var_TEXCOORD10.xyz) * in.in_var_TEXCOORD11.w, in.in_var_TEXCOORD11.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _260 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD3[0].x, in_var_TEXCOORD3[0].y) * 8.0), bias(View.View_MaterialTextureMipBias));
    float4 _264 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, in.in_var_PARTICLE_SUBUVS.xy);
    float4 _266 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, in.in_var_PARTICLE_SUBUVS.zw);
    float4 _268 = mix(_264, _266, float4(in.in_var_TEXCOORD10.w));
    float _280 = _229.w;
    float4 _290 = TranslucentBasePass_SceneTextures_SceneDepthTexture.sample(TranslucentBasePass_SceneTextures_PointClampSampler, (((_229.xy / float2(_280)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz), level(0.0));
    float _291 = _290.x;
    float _321;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _321 = _280;
                break;
            }
            else
            {
                float _314 = _229.z;
                _321 = ((_314 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_314 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _327 = fast::clamp((_260.xyz + _268.xyz) * in.in_var_TEXCOORD2.xyz, float3(0.0), float3(1.0));
    float _328 = fast::clamp(fast::min(fast::max(in.in_var_TEXCOORD2.w * _268.w, 0.0), 1.0) * fast::min(fast::max(((((_291 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_291 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w))) - _321) * 0.006666666828095912933349609375, 0.0), 1.0), 0.0, 1.0);
    float3 _338 = fast::clamp((_238 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _349 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_338.x), int(_338.y), int(_338.z), 0).xyz), 0));
    float3 _364 = (((_349.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_338 / float3(_349.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float3 _371 = (_327 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _378 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _381 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _386;
    if (_381)
    {
        _386 = _371 + (_378 * 0.449999988079071044921875);
    }
    else
    {
        _386 = _371;
    }
    float4 _392 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _364, level(0.0));
    float _408 = _392.x;
    float _411 = _392.y;
    float _414 = _392.z;
    float4 _431 = _161;
    _431.y = (-0.48860299587249755859375) * _246.y;
    float4 _434 = _431;
    _434.z = 0.48860299587249755859375 * _246.z;
    float4 _437 = _434;
    _437.w = (-0.48860299587249755859375) * _246.x;
    float4 _438 = _437;
    _438.x = 0.886227548122406005859375;
    float3 _440 = _438.yzw * 2.094395160675048828125;
    float4 _441 = float4(_438.x, _440.x, _440.y, _440.z);
    float3 _443 = _162;
    _443.x = dot(float4(_408, ((((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _364, level(0.0)) * 2.0) - float4(1.0)) * _408) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625)).xyz), _441);
    float3 _445 = _443;
    _445.y = dot(float4(_411, ((((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _364, level(0.0)) * 2.0) - float4(1.0)) * _411) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625)).xyz), _441);
    float3 _447 = _445;
    _447.z = dot(float4(_414, ((((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _364, level(0.0)) * 2.0) - float4(1.0)) * _414) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625)).xyz), _441);
    bool _469 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _517;
    if (_469)
    {
        float4 _476 = View.View_WorldToClip * float4(_238, 1.0);
        float _477 = _476.w;
        float4 _505;
        if (_469)
        {
            _505 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_476.xy / float2(_477)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_477 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _505 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _517 = float4(_505.xyz + (in.in_var_TEXCOORD7.xyz * _505.w), _505.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _517 = in.in_var_TEXCOORD7;
    }
    float3 _518 = _238 + in.in_var_PARTICLE_LIGHTING_OFFSET;
    float3 _526 = (_518 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _534 = (_518 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _539 = fast::clamp((float3(0.5) - abs(_526 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _544 = (_539.x * _539.y) * _539.z;
    float4 _552 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _534, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _526, level(0.0)), float4(_544));
    float3 _563 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _534, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _526, level(0.0)).xyz, float3(_544)) * 1.0;
    float4 _565 = _161;
    _565.x = _552.x;
    float4 _567 = _161;
    _567.x = _552.y;
    float4 _569 = _161;
    _569.x = _552.z;
    float3 _570 = _552.xyz;
    float3 _574 = _570 / float3(dot(_570, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _576 = _563 * _574.x;
    float3 _579 = _563 * _574.y;
    float3 _582 = _563 * _574.z;
    float3 _585 = _162;
    _585.x = dot(float4(_565.x, _576.x, _576.y, _576.z), _441);
    float3 _587 = _585;
    _587.y = dot(float4(_567.x, _579.x, _579.y, _579.z), _441);
    float3 _589 = _587;
    _589.z = dot(float4(_569.x, _582.x, _582.y, _582.z), _441);
    float _591 = _552.w;
    float3 _596 = float4(fast::max(float3(0.0), _589), _591).xyz;
    float3 _662;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _610 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_518, 1.0);
        float2 _614 = _610.xy / float2(_610.w);
        float _615 = _610.z;
        float4 _618 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _614, level(0.0));
        float3 _622 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _615;
        bool2 _647 = _614 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _649 = _614 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _662 = _386 * fast::max(_596 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _591) * (float3(1.0) - select(fast::clamp(exp((float3((((_618.x * _615) * 0.5) + dot((sin(_622) * _618.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_622)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _614, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_647.x || _649.x, _647.y || _649.y)))))), float3(0.0));
    }
    else
    {
        _662 = _386 * _596;
    }
    float3 _669 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _696;
    float3 _697;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        bool _684 = any(abs(_238 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0)));
        float3 _694;
        if (_684)
        {
            _694 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_238, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _694 = _669;
        }
        _696 = _684 ? 1.0 : _328;
        _697 = _694;
    }
    else
    {
        _696 = _328;
        _697 = _669;
    }
    float4 _707 = float4((((mix(_662, _386 + (select(_378, float3(0.0), bool3(_381)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((((fast::max(float3(0.0), _447) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) * _386) * fast::max(float3(1.0), ((((((_327 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_327 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_327 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _697) * _517.w) + _517.xyz, _696);
    float3 _711 = _707.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_711.x, _711.y, _711.z, _707.w);
    return out;
}

