

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

constant float4 _171 = {};
constant float4 _173 = {};

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
    float4 in_var_TEXCOORD3_0 [[user(locn2)]];
};

fragment MainPS_out Main_00004433_30a7bc99(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(11)]], texture2d<float> Material_Texture2D_0 [[texture(12)]], texture2d<float> Material_Texture2D_1 [[texture(13)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD3 = {};
    in_var_TEXCOORD3[0] = in.in_var_TEXCOORD3_0;
    float4 _231 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _235 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _240 = (_235.xyz / float3(_235.w)) - View.View_PreViewTranslation;
    float4 _248 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD3[0].x, in_var_TEXCOORD3[0].y) * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _251 = (_248.xy * float2(2.0)) - float2(1.0);
    float3 _268 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize(((float4(_251, sqrt(fast::clamp(1.0 - dot(_251, _251), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _280 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD3[0].x, in_var_TEXCOORD3[0].y) * 20.0), bias(View.View_MaterialTextureMipBias));
    float _282 = mix(0.4000000059604644775390625, 1.0, _280.x);
    float4 _286 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD3[0].x, in_var_TEXCOORD3[0].y) * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _311;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _311 = _231.w;
                break;
            }
            else
            {
                float _295 = _231.z;
                _311 = ((_295 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_295 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _315 = fast::min(fast::max((_311 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _316 = _286.y;
    float4 _320 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD3[0].x, in_var_TEXCOORD3[0].y) * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _322 = _320.y;
    float3 _335 = fast::clamp(float3(mix(_282, 1.0 - _282, mix(_316, 1.0, _315)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_322 + mix(_316, 0.0, _315), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _340 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _322) + mix(mix(0.699999988079071044921875, 1.0, _316), 1.0, _315), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _387;
    float _388;
    float _389;
    float3 _390;
    float3 _391;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _357 = ((_231.xy / float2(_231.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _361 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _357, level(0.0));
        float4 _364 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _357, level(0.0));
        float4 _367 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _357, level(0.0));
        float _377 = _367.w;
        _387 = (_340 * _377) + _367.z;
        _388 = (0.5 * _377) + _367.y;
        _389 = _367.x;
        _390 = (_335 * _361.w) + _361.xyz;
        _391 = normalize((_268 * _364.w) + ((_364.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _387 = _340;
        _388 = 0.5;
        _389 = 0.0;
        _390 = _335;
        _391 = _268;
    }
    float3 _401 = fast::clamp((_240 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _412 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_401.x), int(_401.y), int(_401.z), 0).xyz), 0));
    float3 _427 = (((_412.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_401 / float3(_412.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _440;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        _440 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _427, level(0.0)).x;
    }
    else
    {
        _440 = 1.0;
    }
    float3 _454 = ((_390 - (_390 * _389)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _461 = (mix(float3(0.07999999821186065673828125 * _388), _390, float3(_389)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _464 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _469;
    if (_464)
    {
        _469 = _454 + (_461 * 0.449999988079071044921875);
    }
    else
    {
        _469 = _454;
    }
    float3 _471 = select(_461, float3(0.0), bool3(_464));
    float3 _473 = float3(dot(_471, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _490 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _427, level(0.0));
    float _506 = _490.x;
    float4 _508 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _427, level(0.0)) * 2.0) - float4(1.0)) * _506) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _509 = _490.y;
    float4 _511 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _427, level(0.0)) * 2.0) - float4(1.0)) * _509) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _512 = _490.z;
    float4 _514 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _427, level(0.0)) * 2.0) - float4(1.0)) * _512) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _531 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _427, level(0.0)) * 2.0) - float4(1.0)) * _506) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _533 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _427, level(0.0)) * 2.0) - float4(1.0)) * _509) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _535 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _427, level(0.0)) * 2.0) - float4(1.0)) * _512) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _568 = _173;
    _568.y = (-0.48860299587249755859375) * _391.y;
    float4 _571 = _568;
    _571.z = 0.48860299587249755859375 * _391.z;
    float4 _574 = _571;
    _574.w = (-0.48860299587249755859375) * _391.x;
    float3 _575 = _391 * _391;
    float4 _578 = _171;
    _578.x = (1.09254801273345947265625 * _391.x) * _391.y;
    float4 _581 = _578;
    _581.y = ((-1.09254801273345947265625) * _391.y) * _391.z;
    float4 _586 = _581;
    _586.z = 0.3153919875621795654296875 * ((3.0 * _575.z) - 1.0);
    float4 _589 = _586;
    _589.w = ((-1.09254801273345947265625) * _391.x) * _391.z;
    float4 _593 = _574;
    _593.x = 0.886227548122406005859375;
    float3 _595 = _593.yzw * 2.094395160675048828125;
    float4 _596 = float4(_593.x, _595.x, _595.y, _595.z);
    float4 _597 = _589 * 0.785398185253143310546875;
    float _598 = (_575.x - _575.y) * 0.4290426075458526611328125;
    float3 _604 = float3(0.0);
    _604.x = (dot(float4(_506, _508.xyz), _596) + dot(float4(_508.w, _531.xyz), _597)) + (_531.w * _598);
    float3 _610 = _604;
    _610.y = (dot(float4(_509, _511.xyz), _596) + dot(float4(_511.w, _533.xyz), _597)) + (_533.w * _598);
    float3 _616 = _610;
    _616.z = (dot(float4(_512, _514.xyz), _596) + dot(float4(_514.w, _535.xyz), _597)) + (_535.w * _598);
    float3 _621 = (fast::max(float3(0.0), _616) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    float3 _643 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _669;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _668;
        if (any(abs(_240 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _668 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_240, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _668 = _643;
        }
        _669 = _668;
    }
    else
    {
        _669 = _643;
    }
    float4 _676 = float4(((mix(float3(0.0), _469 + (_471 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_621 * _469) * fast::max(float3(1.0), ((((((_390 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_390 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_390 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _669) * 1.0, 0.0);
    float4 _683;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _682 = _676;
        _682.w = 0.0;
        _683 = _682;
    }
    else
    {
        _683 = _676;
    }
    float2 _687 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _695 = (_391 * 0.5) + float3(0.5);
    float4 _697 = float4(_695.x, _695.y, _695.z, float4(0.0).w);
    _697.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _698 = float4(0.0);
    _698.x = _389;
    float4 _699 = _698;
    _699.y = _388;
    float4 _700 = _699;
    _700.z = _387;
    float4 _701 = _700;
    _701.w = 0.50588238239288330078125;
    float4 _713 = float4(_390.x, _390.y, _390.z, float4(0.0).w);
    _713.w = ((log2(((dot(_621, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_473 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_473 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_473 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_687.xyx * _687.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _683 * View.View_PreExposure;
    out.out_var_SV_Target1 = _697;
    out.out_var_SV_Target2 = _701;
    out.out_var_SV_Target3 = _713;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_440, 1.0, 1.0, 1.0);
    return out;
}

