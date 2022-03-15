

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
    char _m0_pad[448];
    float4x4 View_ViewToClip;
    char _m1_pad[192];
    float4x4 View_SVPositionToTranslatedWorld;
    char _m2_pad[272];
    float4 View_InvDeviceZToWorldZTransform;
    float4 View_ScreenPositionScaleBias;
    char _m4_pad[48];
    float3 View_PreViewTranslation;
    char _m5_pad[928];
    float4 View_ViewRectMin;
    float4 View_ViewSizeAndInvSize;
    char _m7_pad[68];
    float View_PreExposure;
    float4 View_DiffuseOverrideParameter;
    float4 View_SpecularOverrideParameter;
    float4 View_NormalOverrideParameter;
    float2 View_RoughnessOverrideParameter;
    char _m12_pad[8];
    float View_OutOfBoundsMask;
    char _m13_pad[48];
    float View_MaterialTextureMipBias;
    char _m14_pad[28];
    float View_UnlitViewmodeMask;
    char _m15_pad[612];
    float View_RenderingReflectionCaptureMask;
    char _m16_pad[188];
    float View_ShowDecalsMask;
    char _m17_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m18_pad[48];
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
    float Primitive_DecalReceiverMask;
    float Primitive_PerObjectGBufferData;
    float Primitive_UseVolumetricLightmapShadowFromStationaryLights;
};

struct type_LandscapeParameters
{
    char _m0_pad[144];
    float4x4 LandscapeParameters_LocalToWorldNoScaling;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
    float4 out_var_SV_Target1 [[color(1)]];
    float4 out_var_SV_Target2 [[color(2)]];
    float4 out_var_SV_Target3 [[color(3)]];
    float4 out_var_SV_Target4 [[color(4)]];
    float4 out_var_SV_Target5 [[color(5)]];
};

struct MainPS_in
{
    float2 in_var_TEXCOORD0 [[user(locn0)]];
    float4 in_var_TEXCOORD1 [[user(locn1)]];
};

fragment MainPS_out Main_00003276_b24f62be(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_LandscapeParameters& LandscapeParameters [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> LandscapeParameters_NormalmapTexture [[texture(5)]], texture2d<float> Material_Texture2D_0 [[texture(6)]], texture2d<float> Material_Texture2D_1 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler LandscapeParameters_NormalmapTextureSampler [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    float4 _175 = LandscapeParameters_NormalmapTexture.sample(LandscapeParameters_NormalmapTextureSampler, in.in_var_TEXCOORD1.zw);
    float2 _180 = (float2(_175.zw) * float2(2.0)) - float2(1.0);
    float _184 = sqrt(fast::max(1.0 - dot(_180, _180), 0.0));
    float _185 = _180.x;
    float3 _187 = float3(_185, _180.y, _184);
    float3 _190 = normalize(float3(_184, 0.0, -_185));
    float4 _214 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _218 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _223 = (_218.xyz / float3(_218.w)) - View.View_PreViewTranslation;
    float4 _231 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (in.in_var_TEXCOORD0 * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _234 = (_231.xy * float2(2.0)) - float2(1.0);
    float3 _251 = normalize((float3x3(LandscapeParameters.LandscapeParameters_LocalToWorldNoScaling[0].xyz, LandscapeParameters.LandscapeParameters_LocalToWorldNoScaling[1].xyz, LandscapeParameters.LandscapeParameters_LocalToWorldNoScaling[2].xyz) * float3x3(_190, cross(_187, _190), _187)) * normalize(((float4(_234, sqrt(fast::clamp(1.0 - dot(_234, _234), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _263 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in.in_var_TEXCOORD0 * 20.0), bias(View.View_MaterialTextureMipBias));
    float _265 = mix(0.4000000059604644775390625, 1.0, _263.x);
    float4 _269 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in.in_var_TEXCOORD0 * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _294;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _294 = _214.w;
                break;
            }
            else
            {
                float _278 = _214.z;
                _294 = ((_278 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_278 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _298 = fast::min(fast::max((_294 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _299 = _269.y;
    float4 _303 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in.in_var_TEXCOORD0 * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _305 = _303.y;
    float3 _318 = fast::clamp(float3(mix(_265, 1.0 - _265, mix(_299, 1.0, _298)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_305 + mix(_299, 0.0, _298), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _323 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _305) + mix(mix(0.699999988079071044921875, 1.0, _299), 1.0, _298), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _370;
    float _371;
    float _372;
    float3 _373;
    float3 _374;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _340 = ((_214.xy / float2(_214.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _344 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _340, level(0.0));
        float4 _347 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _340, level(0.0));
        float4 _350 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _340, level(0.0));
        float _360 = _350.w;
        _370 = (_323 * _360) + _350.z;
        _371 = (0.5 * _360) + _350.y;
        _372 = _350.x;
        _373 = (_318 * _344.w) + _344.xyz;
        _374 = normalize((_251 * _347.w) + ((_347.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _370 = _323;
        _371 = 0.5;
        _372 = 0.0;
        _373 = _318;
        _374 = _251;
    }
    float _423;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _391 = fast::clamp((_223 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _402 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_391.x), int(_391.y), int(_391.z), 0).xyz), 0));
        _423 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_402.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_391 / float3(_402.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _423 = 1.0;
    }
    float3 _437 = ((_373 - (_373 * _372)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _444 = (mix(float3(0.07999999821186065673828125 * _371), _373, float3(_372)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _447 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _452;
    if (_447)
    {
        _452 = _437 + (_444 * 0.449999988079071044921875);
    }
    else
    {
        _452 = _437;
    }
    float3 _461 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _487;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _486;
        if (any(abs(_223 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _486 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_223, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _486 = _461;
        }
        _487 = _486;
    }
    else
    {
        _487 = _461;
    }
    float4 _493 = float4((mix(float3(0.0), _452 + (select(_444, float3(0.0), bool3(_447)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + _487) * 1.0, 0.0);
    float4 _500;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _499 = _493;
        _499.w = 0.0;
        _500 = _499;
    }
    else
    {
        _500 = _493;
    }
    float2 _504 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _512 = (_374 * 0.5) + float3(0.5);
    float4 _514 = float4(_512.x, _512.y, _512.z, float4(0.0).w);
    _514.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _515 = float4(0.0);
    _515.x = _372;
    float4 _516 = _515;
    _516.y = _371;
    float4 _517 = _516;
    _517.z = _370;
    float4 _518 = _517;
    _518.w = 0.50588238239288330078125;
    float4 _521 = float4(_373.x, _373.y, _373.z, float4(0.0).w);
    _521.w = (fract(dot(_504.xyx * _504.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _500 * View.View_PreExposure;
    out.out_var_SV_Target1 = _514;
    out.out_var_SV_Target2 = _518;
    out.out_var_SV_Target3 = _521;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_423, 1.0, 1.0, 1.0);
    return out;
}

