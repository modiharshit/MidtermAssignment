

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

constant float4 _162 = {};
constant float3 _163 = {};

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

fragment MainPS_out Main_000044ff_0f754ac8(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(2)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(4)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(5)]], texture2d<float> TranslucentBasePass_SceneTextures_SceneDepthTexture [[texture(6)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(7)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(8)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(9)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(10)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(11)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(12)]], texture2d<float> Material_Texture2D_0 [[texture(13)]], texture2d<float> Material_Texture2D_1 [[texture(14)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_SceneTextures_PointClampSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    float4 _231 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _235 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _240 = (_235.xyz / float3(_235.w)) - View.View_PreViewTranslation;
    float3 _248 = normalize(float3x3(in.in_var_TANGENTX.xyz, cross(in.in_var_TANGENTZ.xyz, in.in_var_TANGENTX.xyz) * in.in_var_TANGENTZ.w, in.in_var_TANGENTZ.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _262 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 8.0), bias(View.View_MaterialTextureMipBias));
    float4 _266 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, in.in_var_PARTICLE_SUBUVS.xy);
    float4 _268 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, in.in_var_PARTICLE_SUBUVS.zw);
    float4 _270 = mix(_266, _268, float4(in.in_var_TEXCOORD4.x));
    float _282 = _231.w;
    float4 _292 = TranslucentBasePass_SceneTextures_SceneDepthTexture.sample(TranslucentBasePass_SceneTextures_PointClampSampler, (((_231.xy / float2(_282)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz), level(0.0));
    float _293 = _292.x;
    float _323;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _323 = _282;
                break;
            }
            else
            {
                float _316 = _231.z;
                _323 = ((_316 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_316 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _329 = fast::clamp((_262.xyz + _270.xyz) * in.in_var_TEXCOORD5.xyz, float3(0.0), float3(1.0));
    float _330 = fast::clamp(fast::min(fast::max(in.in_var_TEXCOORD5.w * _270.w, 0.0), 1.0) * fast::min(fast::max(((((_293 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_293 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w))) - _323) * 0.006666666828095912933349609375, 0.0), 1.0), 0.0, 1.0);
    float3 _340 = fast::clamp((_240 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _351 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_340.x), int(_340.y), int(_340.z), 0).xyz), 0));
    float3 _366 = (((_351.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_340 / float3(_351.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float3 _373 = (_329 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _380 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _383 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _388;
    if (_383)
    {
        _388 = _373 + (_380 * 0.449999988079071044921875);
    }
    else
    {
        _388 = _373;
    }
    float4 _394 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _366, level(0.0));
    float _410 = _394.x;
    float _413 = _394.y;
    float _416 = _394.z;
    float4 _433 = _162;
    _433.y = (-0.48860299587249755859375) * _248.y;
    float4 _436 = _433;
    _436.z = 0.48860299587249755859375 * _248.z;
    float4 _439 = _436;
    _439.w = (-0.48860299587249755859375) * _248.x;
    float4 _440 = _439;
    _440.x = 0.886227548122406005859375;
    float3 _442 = _440.yzw * 2.094395160675048828125;
    float4 _443 = float4(_440.x, _442.x, _442.y, _442.z);
    float3 _445 = _163;
    _445.x = dot(float4(_410, ((((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _366, level(0.0)) * 2.0) - float4(1.0)) * _410) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625)).xyz), _443);
    float3 _447 = _445;
    _447.y = dot(float4(_413, ((((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _366, level(0.0)) * 2.0) - float4(1.0)) * _413) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625)).xyz), _443);
    float3 _449 = _447;
    _449.z = dot(float4(_416, ((((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _366, level(0.0)) * 2.0) - float4(1.0)) * _416) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625)).xyz), _443);
    bool _471 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _519;
    if (_471)
    {
        float4 _478 = View.View_WorldToClip * float4(_240, 1.0);
        float _479 = _478.w;
        float4 _507;
        if (_471)
        {
            _507 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_478.xy / float2(_479)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_479 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _507 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _519 = float4(_507.xyz + (in.in_var_TEXCOORD7.xyz * _507.w), _507.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _519 = in.in_var_TEXCOORD7;
    }
    float3 _520 = _240 + in.in_var_PARTICLE_LIGHTING_OFFSET;
    float3 _528 = (_520 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _536 = (_520 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _541 = fast::clamp((float3(0.5) - abs(_528 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _546 = (_541.x * _541.y) * _541.z;
    float4 _554 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _536, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _528, level(0.0)), float4(_546));
    float3 _565 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _536, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _528, level(0.0)).xyz, float3(_546)) * 1.0;
    float4 _567 = _162;
    _567.x = _554.x;
    float4 _569 = _162;
    _569.x = _554.y;
    float4 _571 = _162;
    _571.x = _554.z;
    float3 _572 = _554.xyz;
    float3 _576 = _572 / float3(dot(_572, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _578 = _565 * _576.x;
    float3 _581 = _565 * _576.y;
    float3 _584 = _565 * _576.z;
    float3 _587 = _163;
    _587.x = dot(float4(_567.x, _578.x, _578.y, _578.z), _443);
    float3 _589 = _587;
    _589.y = dot(float4(_569.x, _581.x, _581.y, _581.z), _443);
    float3 _591 = _589;
    _591.z = dot(float4(_571.x, _584.x, _584.y, _584.z), _443);
    float _593 = _554.w;
    float3 _598 = float4(fast::max(float3(0.0), _591), _593).xyz;
    float3 _664;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _612 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_520, 1.0);
        float2 _616 = _612.xy / float2(_612.w);
        float _617 = _612.z;
        float4 _620 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _616, level(0.0));
        float3 _624 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _617;
        bool2 _649 = _616 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _651 = _616 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _664 = _388 * fast::max(_598 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _593) * (float3(1.0) - select(fast::clamp(exp((float3((((_620.x * _617) * 0.5) + dot((sin(_624) * _620.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_624)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _616, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_649.x || _651.x, _649.y || _651.y)))))), float3(0.0));
    }
    else
    {
        _664 = _388 * _598;
    }
    float3 _671 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _698;
    float3 _699;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        bool _686 = any(abs(_240 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0)));
        float3 _696;
        if (_686)
        {
            _696 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_240, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _696 = _671;
        }
        _698 = _686 ? 1.0 : _330;
        _699 = _696;
    }
    else
    {
        _698 = _330;
        _699 = _671;
    }
    float4 _709 = float4((((mix(_664, _388 + (select(_380, float3(0.0), bool3(_383)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((((fast::max(float3(0.0), _449) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) * _388) * fast::max(float3(1.0), ((((((_329 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_329 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_329 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _699) * _519.w) + _519.xyz, _698);
    float3 _713 = _709.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_713.x, _713.y, _713.z, _709.w);
    return out;
}

