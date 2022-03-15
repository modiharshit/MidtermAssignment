

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

constant float4 _170 = {};
constant float4 _172 = {};

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
    float4 in_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 in_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 in_var_TEXCOORD0_0 [[user(locn2)]];
};

fragment MainPS_out Main_00004432_1316db80(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(11)]], texture2d<float> Material_Texture2D_0 [[texture(12)]], texture2d<float> Material_Texture2D_1 [[texture(13)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    float4 _230 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _234 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _239 = (_234.xyz / float3(_234.w)) - View.View_PreViewTranslation;
    float4 _247 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _250 = (_247.xy * float2(2.0)) - float2(1.0);
    float3 _267 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize(((float4(_250, sqrt(fast::clamp(1.0 - dot(_250, _250), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _279 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 20.0), bias(View.View_MaterialTextureMipBias));
    float _281 = mix(0.4000000059604644775390625, 1.0, _279.x);
    float4 _285 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _310;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _310 = _230.w;
                break;
            }
            else
            {
                float _294 = _230.z;
                _310 = ((_294 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_294 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _314 = fast::min(fast::max((_310 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _315 = _285.y;
    float4 _319 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _321 = _319.y;
    float3 _334 = fast::clamp(float3(mix(_281, 1.0 - _281, mix(_315, 1.0, _314)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_321 + mix(_315, 0.0, _314), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _339 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _321) + mix(mix(0.699999988079071044921875, 1.0, _315), 1.0, _314), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _386;
    float _387;
    float _388;
    float3 _389;
    float3 _390;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _356 = ((_230.xy / float2(_230.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _360 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _356, level(0.0));
        float4 _363 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _356, level(0.0));
        float4 _366 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _356, level(0.0));
        float _376 = _366.w;
        _386 = (_339 * _376) + _366.z;
        _387 = (0.5 * _376) + _366.y;
        _388 = _366.x;
        _389 = (_334 * _360.w) + _360.xyz;
        _390 = normalize((_267 * _363.w) + ((_363.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _386 = _339;
        _387 = 0.5;
        _388 = 0.0;
        _389 = _334;
        _390 = _267;
    }
    float3 _400 = fast::clamp((_239 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _411 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_400.x), int(_400.y), int(_400.z), 0).xyz), 0));
    float3 _426 = (((_411.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_400 / float3(_411.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _439;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        _439 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _426, level(0.0)).x;
    }
    else
    {
        _439 = 1.0;
    }
    float3 _453 = ((_389 - (_389 * _388)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _460 = (mix(float3(0.07999999821186065673828125 * _387), _389, float3(_388)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _463 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _468;
    if (_463)
    {
        _468 = _453 + (_460 * 0.449999988079071044921875);
    }
    else
    {
        _468 = _453;
    }
    float3 _470 = select(_460, float3(0.0), bool3(_463));
    float3 _472 = float3(dot(_470, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _489 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _426, level(0.0));
    float _505 = _489.x;
    float4 _507 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _426, level(0.0)) * 2.0) - float4(1.0)) * _505) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _508 = _489.y;
    float4 _510 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _426, level(0.0)) * 2.0) - float4(1.0)) * _508) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _511 = _489.z;
    float4 _513 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _426, level(0.0)) * 2.0) - float4(1.0)) * _511) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _530 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _426, level(0.0)) * 2.0) - float4(1.0)) * _505) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _532 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _426, level(0.0)) * 2.0) - float4(1.0)) * _508) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _534 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _426, level(0.0)) * 2.0) - float4(1.0)) * _511) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _567 = _172;
    _567.y = (-0.48860299587249755859375) * _390.y;
    float4 _570 = _567;
    _570.z = 0.48860299587249755859375 * _390.z;
    float4 _573 = _570;
    _573.w = (-0.48860299587249755859375) * _390.x;
    float3 _574 = _390 * _390;
    float4 _577 = _170;
    _577.x = (1.09254801273345947265625 * _390.x) * _390.y;
    float4 _580 = _577;
    _580.y = ((-1.09254801273345947265625) * _390.y) * _390.z;
    float4 _585 = _580;
    _585.z = 0.3153919875621795654296875 * ((3.0 * _574.z) - 1.0);
    float4 _588 = _585;
    _588.w = ((-1.09254801273345947265625) * _390.x) * _390.z;
    float4 _592 = _573;
    _592.x = 0.886227548122406005859375;
    float3 _594 = _592.yzw * 2.094395160675048828125;
    float4 _595 = float4(_592.x, _594.x, _594.y, _594.z);
    float4 _596 = _588 * 0.785398185253143310546875;
    float _597 = (_574.x - _574.y) * 0.4290426075458526611328125;
    float3 _603 = float3(0.0);
    _603.x = (dot(float4(_505, _507.xyz), _595) + dot(float4(_507.w, _530.xyz), _596)) + (_530.w * _597);
    float3 _609 = _603;
    _609.y = (dot(float4(_508, _510.xyz), _595) + dot(float4(_510.w, _532.xyz), _596)) + (_532.w * _597);
    float3 _615 = _609;
    _615.z = (dot(float4(_511, _513.xyz), _595) + dot(float4(_513.w, _534.xyz), _596)) + (_534.w * _597);
    float3 _620 = (fast::max(float3(0.0), _615) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    float3 _642 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _668;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _667;
        if (any(abs(_239 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _667 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_239, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _667 = _642;
        }
        _668 = _667;
    }
    else
    {
        _668 = _642;
    }
    float4 _675 = float4(((mix(float3(0.0), _468 + (_470 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_620 * _468) * fast::max(float3(1.0), ((((((_389 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_389 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_389 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _668) * 1.0, 0.0);
    float4 _682;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _681 = _675;
        _681.w = 0.0;
        _682 = _681;
    }
    else
    {
        _682 = _675;
    }
    float2 _686 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _694 = (_390 * 0.5) + float3(0.5);
    float4 _696 = float4(_694.x, _694.y, _694.z, float4(0.0).w);
    _696.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _697 = float4(0.0);
    _697.x = _388;
    float4 _698 = _697;
    _698.y = _387;
    float4 _699 = _698;
    _699.z = _386;
    float4 _700 = _699;
    _700.w = 0.50588238239288330078125;
    float4 _712 = float4(_389.x, _389.y, _389.z, float4(0.0).w);
    _712.w = ((log2(((dot(_620, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_472 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_472 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_472 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_686.xyx * _686.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _682 * View.View_PreExposure;
    out.out_var_SV_Target1 = _696;
    out.out_var_SV_Target2 = _700;
    out.out_var_SV_Target3 = _712;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_439, 1.0, 1.0, 1.0);
    return out;
}

