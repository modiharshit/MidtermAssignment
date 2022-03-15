

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
    float4 in_var_TEXCOORD10 [[user(locn0)]];
    float4 in_var_TEXCOORD11 [[user(locn1)]];
    float4 in_var_TEXCOORD1_0 [[user(locn2)]];
};

fragment MainPS_out Main_000043f4_f7a10fa9(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(11)]], texture2d<float> Material_Texture2D_0 [[texture(12)]], texture2d<float> Material_Texture2D_1 [[texture(13)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD1 = {};
    in_var_TEXCOORD1[0] = in.in_var_TEXCOORD1_0;
    float4 _233 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _237 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _242 = (_237.xyz / float3(_237.w)) - View.View_PreViewTranslation;
    float4 _250 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD1[0].x, in_var_TEXCOORD1[0].y) * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _253 = (_250.xy * float2(2.0)) - float2(1.0);
    float3 _270 = normalize(float3x3(in.in_var_TEXCOORD10.xyz, cross(in.in_var_TEXCOORD11.xyz, in.in_var_TEXCOORD10.xyz) * in.in_var_TEXCOORD11.w, in.in_var_TEXCOORD11.xyz) * normalize(((float4(_253, sqrt(fast::clamp(1.0 - dot(_253, _253), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _282 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD1[0].x, in_var_TEXCOORD1[0].y) * 20.0), bias(View.View_MaterialTextureMipBias));
    float _284 = mix(0.4000000059604644775390625, 1.0, _282.x);
    float4 _288 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD1[0].x, in_var_TEXCOORD1[0].y) * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _313;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _313 = _233.w;
                break;
            }
            else
            {
                float _297 = _233.z;
                _313 = ((_297 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_297 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _317 = fast::min(fast::max((_313 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _318 = _288.y;
    float4 _322 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD1[0].x, in_var_TEXCOORD1[0].y) * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _324 = _322.y;
    float3 _337 = fast::clamp(float3(mix(_284, 1.0 - _284, mix(_318, 1.0, _317)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_324 + mix(_318, 0.0, _317), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _342 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _324) + mix(mix(0.699999988079071044921875, 1.0, _318), 1.0, _317), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _389;
    float _390;
    float _391;
    float3 _392;
    float3 _393;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _359 = ((_233.xy / float2(_233.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _363 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _359, level(0.0));
        float4 _366 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _359, level(0.0));
        float4 _369 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _359, level(0.0));
        float _379 = _369.w;
        _389 = (_342 * _379) + _369.z;
        _390 = (0.5 * _379) + _369.y;
        _391 = _369.x;
        _392 = (_337 * _363.w) + _363.xyz;
        _393 = normalize((_270 * _366.w) + ((_366.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _389 = _342;
        _390 = 0.5;
        _391 = 0.0;
        _392 = _337;
        _393 = _270;
    }
    float3 _403 = fast::clamp((_242 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _414 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_403.x), int(_403.y), int(_403.z), 0).xyz), 0));
    float3 _429 = (((_414.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_403 / float3(_414.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _442;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        _442 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _429, level(0.0)).x;
    }
    else
    {
        _442 = 1.0;
    }
    float3 _456 = ((_392 - (_392 * _391)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _463 = (mix(float3(0.07999999821186065673828125 * _390), _392, float3(_391)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _466 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _471;
    if (_466)
    {
        _471 = _456 + (_463 * 0.449999988079071044921875);
    }
    else
    {
        _471 = _456;
    }
    float3 _473 = select(_463, float3(0.0), bool3(_466));
    float3 _475 = float3(dot(_473, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _492 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _429, level(0.0));
    float _508 = _492.x;
    float4 _510 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _429, level(0.0)) * 2.0) - float4(1.0)) * _508) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _511 = _492.y;
    float4 _513 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _429, level(0.0)) * 2.0) - float4(1.0)) * _511) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _514 = _492.z;
    float4 _516 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _429, level(0.0)) * 2.0) - float4(1.0)) * _514) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _533 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _429, level(0.0)) * 2.0) - float4(1.0)) * _508) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _535 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _429, level(0.0)) * 2.0) - float4(1.0)) * _511) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _537 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _429, level(0.0)) * 2.0) - float4(1.0)) * _514) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _570 = _175;
    _570.y = (-0.48860299587249755859375) * _393.y;
    float4 _573 = _570;
    _573.z = 0.48860299587249755859375 * _393.z;
    float4 _576 = _573;
    _576.w = (-0.48860299587249755859375) * _393.x;
    float3 _577 = _393 * _393;
    float4 _580 = _173;
    _580.x = (1.09254801273345947265625 * _393.x) * _393.y;
    float4 _583 = _580;
    _583.y = ((-1.09254801273345947265625) * _393.y) * _393.z;
    float4 _588 = _583;
    _588.z = 0.3153919875621795654296875 * ((3.0 * _577.z) - 1.0);
    float4 _591 = _588;
    _591.w = ((-1.09254801273345947265625) * _393.x) * _393.z;
    float4 _595 = _576;
    _595.x = 0.886227548122406005859375;
    float3 _597 = _595.yzw * 2.094395160675048828125;
    float4 _598 = float4(_595.x, _597.x, _597.y, _597.z);
    float4 _599 = _591 * 0.785398185253143310546875;
    float _600 = (_577.x - _577.y) * 0.4290426075458526611328125;
    float3 _606 = float3(0.0);
    _606.x = (dot(float4(_508, _510.xyz), _598) + dot(float4(_510.w, _533.xyz), _599)) + (_533.w * _600);
    float3 _612 = _606;
    _612.y = (dot(float4(_511, _513.xyz), _598) + dot(float4(_513.w, _535.xyz), _599)) + (_535.w * _600);
    float3 _618 = _612;
    _618.z = (dot(float4(_514, _516.xyz), _598) + dot(float4(_516.w, _537.xyz), _599)) + (_537.w * _600);
    float3 _623 = (fast::max(float3(0.0), _618) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    float3 _645 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _671;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _670;
        if (any(abs(_242 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _670 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_242, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _670 = _645;
        }
        _671 = _670;
    }
    else
    {
        _671 = _645;
    }
    float4 _678 = float4(((mix(float3(0.0), _471 + (_473 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_623 * _471) * fast::max(float3(1.0), ((((((_392 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_392 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_392 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _671) * 1.0, 0.0);
    float4 _685;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _684 = _678;
        _684.w = 0.0;
        _685 = _684;
    }
    else
    {
        _685 = _678;
    }
    float2 _689 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _697 = (_393 * 0.5) + float3(0.5);
    float4 _699 = float4(_697.x, _697.y, _697.z, float4(0.0).w);
    _699.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _700 = float4(0.0);
    _700.x = _391;
    float4 _701 = _700;
    _701.y = _390;
    float4 _702 = _701;
    _702.z = _389;
    float4 _703 = _702;
    _703.w = 0.50588238239288330078125;
    float4 _715 = float4(_392.x, _392.y, _392.z, float4(0.0).w);
    _715.w = ((log2(((dot(_623, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_475 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_475 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_475 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_689.xyx * _689.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _685 * View.View_PreExposure;
    out.out_var_SV_Target1 = _699;
    out.out_var_SV_Target2 = _703;
    out.out_var_SV_Target3 = _715;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_442, 1.0, 1.0, 1.0);
    return out;
}

