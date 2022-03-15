

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

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float _143 = {};
constant float4 _145 = {};
constant float3 _146 = {};

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

fragment MainPS_out Main_00003cdd_37506962(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(4)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(5)]], texture2d<float> TranslucentBasePass_SceneTextures_SceneDepthTexture [[texture(6)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(7)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(8)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(9)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(10)]], texture2d<float> Material_Texture2D_0 [[texture(11)]], texture2d<float> Material_Texture2D_1 [[texture(12)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_SceneTextures_PointClampSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    float4 _214 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _218 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _223 = (_218.xyz / float3(_218.w)) - View.View_PreViewTranslation;
    float3 _231 = normalize(float3x3(in.in_var_TANGENTX.xyz, cross(in.in_var_TANGENTZ.xyz, in.in_var_TANGENTX.xyz) * in.in_var_TANGENTZ.w, in.in_var_TANGENTZ.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _245 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 8.0), bias(View.View_MaterialTextureMipBias));
    float4 _249 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, in.in_var_PARTICLE_SUBUVS.xy);
    float4 _251 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, in.in_var_PARTICLE_SUBUVS.zw);
    float4 _253 = mix(_249, _251, float4(in.in_var_TEXCOORD4.x));
    float _265 = _214.w;
    float4 _275 = TranslucentBasePass_SceneTextures_SceneDepthTexture.sample(TranslucentBasePass_SceneTextures_PointClampSampler, (((_214.xy / float2(_265)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz), level(0.0));
    float _276 = _275.x;
    float _306;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _306 = _265;
                break;
            }
            else
            {
                float _299 = _214.z;
                _306 = ((_299 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_299 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _312 = fast::clamp((_245.xyz + _253.xyz) * in.in_var_TEXCOORD5.xyz, float3(0.0), float3(1.0));
    float _313 = fast::clamp(fast::min(fast::max(in.in_var_TEXCOORD5.w * _253.w, 0.0), 1.0) * fast::min(fast::max(((((_276 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_276 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w))) - _306) * 0.006666666828095912933349609375, 0.0), 1.0), 0.0, 1.0);
    float3 _323 = fast::clamp((_223 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _334 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_323.x), int(_323.y), int(_323.z), 0).xyz), 0));
    float3 _349 = (((_334.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_323 / float3(_334.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float3 _356 = (_312 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _363 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _366 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _371;
    if (_366)
    {
        _371 = _356 + (_363 * 0.449999988079071044921875);
    }
    else
    {
        _371 = _356;
    }
    float4 _377 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _349, level(0.0));
    float _393 = _377.x;
    float _396 = _377.y;
    float _399 = _377.z;
    float4 _416 = _145;
    _416.y = (-0.48860299587249755859375) * _231.y;
    float4 _419 = _416;
    _419.z = 0.48860299587249755859375 * _231.z;
    float4 _422 = _419;
    _422.w = (-0.48860299587249755859375) * _231.x;
    float4 _423 = _422;
    _423.x = 0.886227548122406005859375;
    float3 _425 = _423.yzw * 2.094395160675048828125;
    float4 _426 = float4(_423.x, _425.x, _425.y, _425.z);
    float3 _428 = _146;
    _428.x = dot(float4(_393, ((((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _349, level(0.0)) * 2.0) - float4(1.0)) * _393) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625)).xyz), _426);
    float3 _430 = _428;
    _430.y = dot(float4(_396, ((((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _349, level(0.0)) * 2.0) - float4(1.0)) * _396) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625)).xyz), _426);
    float3 _432 = _430;
    _432.z = dot(float4(_399, ((((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _349, level(0.0)) * 2.0) - float4(1.0)) * _399) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625)).xyz), _426);
    bool _454 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _502;
    if (_454)
    {
        float4 _461 = View.View_WorldToClip * float4(_223, 1.0);
        float _462 = _461.w;
        float4 _490;
        if (_454)
        {
            _490 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_461.xy / float2(_462)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_462 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _490 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _502 = float4(_490.xyz + (in.in_var_TEXCOORD7.xyz * _490.w), _490.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _502 = in.in_var_TEXCOORD7;
    }
    float3 _503 = _223 + in.in_var_PARTICLE_LIGHTING_OFFSET;
    float3 _511 = (_503 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _519 = (_503 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _524 = fast::clamp((float3(0.5) - abs(_511 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _529 = (_524.x * _524.y) * _524.z;
    float4 _537 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _519, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _511, level(0.0)), float4(_529));
    float3 _548 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _519, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _511, level(0.0)).xyz, float3(_529)) * 1.0;
    float4 _550 = _145;
    _550.x = _537.x;
    float4 _552 = _145;
    _552.x = _537.y;
    float4 _554 = _145;
    _554.x = _537.z;
    float3 _555 = _537.xyz;
    float3 _559 = _555 / float3(dot(_555, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _561 = _548 * _559.x;
    float3 _564 = _548 * _559.y;
    float3 _567 = _548 * _559.z;
    float3 _570 = _146;
    _570.x = dot(float4(_550.x, _561.x, _561.y, _561.z), _426);
    float3 _572 = _570;
    _572.y = dot(float4(_552.x, _564.x, _564.y, _564.z), _426);
    float3 _574 = _572;
    _574.z = dot(float4(_554.x, _567.x, _567.y, _567.z), _426);
    float3 _588 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _615;
    float3 _616;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        bool _603 = any(abs(_223 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0)));
        float3 _613;
        if (_603)
        {
            _613 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_223, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _613 = _588;
        }
        _615 = _603 ? 1.0 : _313;
        _616 = _613;
    }
    else
    {
        _615 = _313;
        _616 = _588;
    }
    float4 _626 = float4((((mix(_371 * float4(fast::max(float3(0.0), _574), _143).xyz, _371 + (select(_363, float3(0.0), bool3(_366)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((((fast::max(float3(0.0), _432) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) * _371) * fast::max(float3(1.0), ((((((_312 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_312 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_312 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _616) * _502.w) + _502.xyz, _615);
    float3 _630 = _626.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_630.x, _630.y, _630.z, _626.w);
    return out;
}

