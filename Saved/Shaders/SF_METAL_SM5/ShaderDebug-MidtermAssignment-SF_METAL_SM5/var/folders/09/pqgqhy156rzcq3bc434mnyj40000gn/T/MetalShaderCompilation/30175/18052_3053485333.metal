

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
    char _m15_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m16_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m17_pad[188];
    float View_ShowDecalsMask;
    char _m18_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m19_pad[48];
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

constant float4 _173 = {};
constant float4 _175 = {};

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

fragment MainPS_out Main_00004684_b6007d15(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_LandscapeParameters& LandscapeParameters [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(11)]], texture2d<float> LandscapeParameters_NormalmapTexture [[texture(12)]], texture2d<float> Material_Texture2D_0 [[texture(13)]], texture2d<float> Material_Texture2D_1 [[texture(14)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler LandscapeParameters_NormalmapTextureSampler [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    float4 _217 = LandscapeParameters_NormalmapTexture.sample(LandscapeParameters_NormalmapTextureSampler, in.in_var_TEXCOORD1.zw);
    float2 _222 = (float2(_217.zw) * float2(2.0)) - float2(1.0);
    float _226 = sqrt(fast::max(1.0 - dot(_222, _222), 0.0));
    float _227 = _222.x;
    float3 _229 = float3(_227, _222.y, _226);
    float3 _232 = normalize(float3(_226, 0.0, -_227));
    float4 _256 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _260 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _265 = (_260.xyz / float3(_260.w)) - View.View_PreViewTranslation;
    float4 _273 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (in.in_var_TEXCOORD0 * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _276 = (_273.xy * float2(2.0)) - float2(1.0);
    float3 _293 = normalize((float3x3(LandscapeParameters.LandscapeParameters_LocalToWorldNoScaling[0].xyz, LandscapeParameters.LandscapeParameters_LocalToWorldNoScaling[1].xyz, LandscapeParameters.LandscapeParameters_LocalToWorldNoScaling[2].xyz) * float3x3(_232, cross(_229, _232), _229)) * normalize(((float4(_276, sqrt(fast::clamp(1.0 - dot(_276, _276), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _305 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in.in_var_TEXCOORD0 * 20.0), bias(View.View_MaterialTextureMipBias));
    float _307 = mix(0.4000000059604644775390625, 1.0, _305.x);
    float4 _311 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in.in_var_TEXCOORD0 * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _336;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _336 = _256.w;
                break;
            }
            else
            {
                float _320 = _256.z;
                _336 = ((_320 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_320 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _340 = fast::min(fast::max((_336 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _341 = _311.y;
    float4 _345 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in.in_var_TEXCOORD0 * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _347 = _345.y;
    float3 _360 = fast::clamp(float3(mix(_307, 1.0 - _307, mix(_341, 1.0, _340)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_347 + mix(_341, 0.0, _340), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _365 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _347) + mix(mix(0.699999988079071044921875, 1.0, _341), 1.0, _340), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _412;
    float _413;
    float _414;
    float3 _415;
    float3 _416;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _382 = ((_256.xy / float2(_256.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _386 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _382, level(0.0));
        float4 _389 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _382, level(0.0));
        float4 _392 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _382, level(0.0));
        float _402 = _392.w;
        _412 = (_365 * _402) + _392.z;
        _413 = (0.5 * _402) + _392.y;
        _414 = _392.x;
        _415 = (_360 * _386.w) + _386.xyz;
        _416 = normalize((_293 * _389.w) + ((_389.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _412 = _365;
        _413 = 0.5;
        _414 = 0.0;
        _415 = _360;
        _416 = _293;
    }
    float3 _426 = fast::clamp((_265 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _437 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_426.x), int(_426.y), int(_426.z), 0).xyz), 0));
    float3 _452 = (((_437.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_426 / float3(_437.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _465;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        _465 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _452, level(0.0)).x;
    }
    else
    {
        _465 = 1.0;
    }
    float3 _479 = ((_415 - (_415 * _414)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _486 = (mix(float3(0.07999999821186065673828125 * _413), _415, float3(_414)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _489 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _494;
    if (_489)
    {
        _494 = _479 + (_486 * 0.449999988079071044921875);
    }
    else
    {
        _494 = _479;
    }
    float3 _496 = select(_486, float3(0.0), bool3(_489));
    float3 _498 = float3(dot(_496, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _515 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _452, level(0.0));
    float _531 = _515.x;
    float4 _533 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _452, level(0.0)) * 2.0) - float4(1.0)) * _531) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _534 = _515.y;
    float4 _536 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _452, level(0.0)) * 2.0) - float4(1.0)) * _534) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _537 = _515.z;
    float4 _539 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _452, level(0.0)) * 2.0) - float4(1.0)) * _537) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _556 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _452, level(0.0)) * 2.0) - float4(1.0)) * _531) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _558 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _452, level(0.0)) * 2.0) - float4(1.0)) * _534) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _560 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _452, level(0.0)) * 2.0) - float4(1.0)) * _537) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _593 = _175;
    _593.y = (-0.48860299587249755859375) * _416.y;
    float4 _596 = _593;
    _596.z = 0.48860299587249755859375 * _416.z;
    float4 _599 = _596;
    _599.w = (-0.48860299587249755859375) * _416.x;
    float3 _600 = _416 * _416;
    float4 _603 = _173;
    _603.x = (1.09254801273345947265625 * _416.x) * _416.y;
    float4 _606 = _603;
    _606.y = ((-1.09254801273345947265625) * _416.y) * _416.z;
    float4 _611 = _606;
    _611.z = 0.3153919875621795654296875 * ((3.0 * _600.z) - 1.0);
    float4 _614 = _611;
    _614.w = ((-1.09254801273345947265625) * _416.x) * _416.z;
    float4 _618 = _599;
    _618.x = 0.886227548122406005859375;
    float3 _620 = _618.yzw * 2.094395160675048828125;
    float4 _621 = float4(_618.x, _620.x, _620.y, _620.z);
    float4 _622 = _614 * 0.785398185253143310546875;
    float _623 = (_600.x - _600.y) * 0.4290426075458526611328125;
    float3 _629 = float3(0.0);
    _629.x = (dot(float4(_531, _533.xyz), _621) + dot(float4(_533.w, _556.xyz), _622)) + (_556.w * _623);
    float3 _635 = _629;
    _635.y = (dot(float4(_534, _536.xyz), _621) + dot(float4(_536.w, _558.xyz), _622)) + (_558.w * _623);
    float3 _641 = _635;
    _641.z = (dot(float4(_537, _539.xyz), _621) + dot(float4(_539.w, _560.xyz), _622)) + (_560.w * _623);
    float3 _646 = (fast::max(float3(0.0), _641) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    float3 _668 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _694;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _693;
        if (any(abs(_265 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _693 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_265, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _693 = _668;
        }
        _694 = _693;
    }
    else
    {
        _694 = _668;
    }
    float4 _701 = float4(((mix(float3(0.0), _494 + (_496 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_646 * _494) * fast::max(float3(1.0), ((((((_415 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_415 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_415 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _694) * 1.0, 0.0);
    float4 _708;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _707 = _701;
        _707.w = 0.0;
        _708 = _707;
    }
    else
    {
        _708 = _701;
    }
    float2 _712 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _720 = (_416 * 0.5) + float3(0.5);
    float4 _722 = float4(_720.x, _720.y, _720.z, float4(0.0).w);
    _722.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _723 = float4(0.0);
    _723.x = _414;
    float4 _724 = _723;
    _724.y = _413;
    float4 _725 = _724;
    _725.z = _412;
    float4 _726 = _725;
    _726.w = 0.50588238239288330078125;
    float4 _738 = float4(_415.x, _415.y, _415.z, float4(0.0).w);
    _738.w = ((log2(((dot(_646, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_498 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_498 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_498 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_712.xyx * _712.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _708 * View.View_PreExposure;
    out.out_var_SV_Target1 = _722;
    out.out_var_SV_Target2 = _726;
    out.out_var_SV_Target3 = _738;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_465, 1.0, 1.0, 1.0);
    return out;
}

