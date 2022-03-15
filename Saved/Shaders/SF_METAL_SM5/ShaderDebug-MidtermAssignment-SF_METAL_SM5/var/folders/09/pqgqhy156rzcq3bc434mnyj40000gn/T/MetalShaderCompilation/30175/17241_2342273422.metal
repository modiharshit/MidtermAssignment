

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

constant float4 _167 = {};
constant float4 _169 = {};

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
    float4 in_var_TEXCOORD2 [[user(locn2)]];
};

fragment MainPS_out Main_00004359_8b9c418e(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(11)]], texture2d<float> Material_Texture2D_0 [[texture(12)]], texture2d<float> Material_Texture2D_1 [[texture(13)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    float4 _226 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _230 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _235 = (_230.xyz / float3(_230.w)) - View.View_PreViewTranslation;
    float4 _243 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (in.in_var_TEXCOORD2.xy * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _246 = (_243.xy * float2(2.0)) - float2(1.0);
    float3 _263 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize(((float4(_246, sqrt(fast::clamp(1.0 - dot(_246, _246), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _275 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in.in_var_TEXCOORD2.xy * 20.0), bias(View.View_MaterialTextureMipBias));
    float _277 = mix(0.4000000059604644775390625, 1.0, _275.x);
    float4 _281 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in.in_var_TEXCOORD2.xy * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _306;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _306 = _226.w;
                break;
            }
            else
            {
                float _290 = _226.z;
                _306 = ((_290 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_290 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _310 = fast::min(fast::max((_306 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _311 = _281.y;
    float4 _315 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in.in_var_TEXCOORD2.xy * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _317 = _315.y;
    float3 _330 = fast::clamp(float3(mix(_277, 1.0 - _277, mix(_311, 1.0, _310)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_317 + mix(_311, 0.0, _310), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _335 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _317) + mix(mix(0.699999988079071044921875, 1.0, _311), 1.0, _310), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _382;
    float _383;
    float _384;
    float3 _385;
    float3 _386;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _352 = ((_226.xy / float2(_226.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _356 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _352, level(0.0));
        float4 _359 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _352, level(0.0));
        float4 _362 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _352, level(0.0));
        float _372 = _362.w;
        _382 = (_335 * _372) + _362.z;
        _383 = (0.5 * _372) + _362.y;
        _384 = _362.x;
        _385 = (_330 * _356.w) + _356.xyz;
        _386 = normalize((_263 * _359.w) + ((_359.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _382 = _335;
        _383 = 0.5;
        _384 = 0.0;
        _385 = _330;
        _386 = _263;
    }
    float3 _396 = fast::clamp((_235 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _407 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_396.x), int(_396.y), int(_396.z), 0).xyz), 0));
    float3 _422 = (((_407.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_396 / float3(_407.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _435;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        _435 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _422, level(0.0)).x;
    }
    else
    {
        _435 = 1.0;
    }
    float3 _449 = ((_385 - (_385 * _384)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _456 = (mix(float3(0.07999999821186065673828125 * _383), _385, float3(_384)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _459 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _464;
    if (_459)
    {
        _464 = _449 + (_456 * 0.449999988079071044921875);
    }
    else
    {
        _464 = _449;
    }
    float3 _466 = select(_456, float3(0.0), bool3(_459));
    float3 _468 = float3(dot(_466, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _485 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _422, level(0.0));
    float _501 = _485.x;
    float4 _503 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _422, level(0.0)) * 2.0) - float4(1.0)) * _501) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _504 = _485.y;
    float4 _506 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _422, level(0.0)) * 2.0) - float4(1.0)) * _504) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _507 = _485.z;
    float4 _509 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _422, level(0.0)) * 2.0) - float4(1.0)) * _507) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _526 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _422, level(0.0)) * 2.0) - float4(1.0)) * _501) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _528 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _422, level(0.0)) * 2.0) - float4(1.0)) * _504) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _530 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _422, level(0.0)) * 2.0) - float4(1.0)) * _507) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _563 = _169;
    _563.y = (-0.48860299587249755859375) * _386.y;
    float4 _566 = _563;
    _566.z = 0.48860299587249755859375 * _386.z;
    float4 _569 = _566;
    _569.w = (-0.48860299587249755859375) * _386.x;
    float3 _570 = _386 * _386;
    float4 _573 = _167;
    _573.x = (1.09254801273345947265625 * _386.x) * _386.y;
    float4 _576 = _573;
    _576.y = ((-1.09254801273345947265625) * _386.y) * _386.z;
    float4 _581 = _576;
    _581.z = 0.3153919875621795654296875 * ((3.0 * _570.z) - 1.0);
    float4 _584 = _581;
    _584.w = ((-1.09254801273345947265625) * _386.x) * _386.z;
    float4 _588 = _569;
    _588.x = 0.886227548122406005859375;
    float3 _590 = _588.yzw * 2.094395160675048828125;
    float4 _591 = float4(_588.x, _590.x, _590.y, _590.z);
    float4 _592 = _584 * 0.785398185253143310546875;
    float _593 = (_570.x - _570.y) * 0.4290426075458526611328125;
    float3 _599 = float3(0.0);
    _599.x = (dot(float4(_501, _503.xyz), _591) + dot(float4(_503.w, _526.xyz), _592)) + (_526.w * _593);
    float3 _605 = _599;
    _605.y = (dot(float4(_504, _506.xyz), _591) + dot(float4(_506.w, _528.xyz), _592)) + (_528.w * _593);
    float3 _611 = _605;
    _611.z = (dot(float4(_507, _509.xyz), _591) + dot(float4(_509.w, _530.xyz), _592)) + (_530.w * _593);
    float3 _616 = (fast::max(float3(0.0), _611) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    float3 _638 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _664;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _663;
        if (any(abs(_235 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _663 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_235, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _663 = _638;
        }
        _664 = _663;
    }
    else
    {
        _664 = _638;
    }
    float4 _671 = float4(((mix(float3(0.0), _464 + (_466 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_616 * _464) * fast::max(float3(1.0), ((((((_385 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_385 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_385 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _664) * 1.0, 0.0);
    float4 _678;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _677 = _671;
        _677.w = 0.0;
        _678 = _677;
    }
    else
    {
        _678 = _671;
    }
    float2 _682 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _690 = (_386 * 0.5) + float3(0.5);
    float4 _692 = float4(_690.x, _690.y, _690.z, float4(0.0).w);
    _692.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _693 = float4(0.0);
    _693.x = _384;
    float4 _694 = _693;
    _694.y = _383;
    float4 _695 = _694;
    _695.z = _382;
    float4 _696 = _695;
    _696.w = 0.50588238239288330078125;
    float4 _708 = float4(_385.x, _385.y, _385.z, float4(0.0).w);
    _708.w = ((log2(((dot(_616, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_468 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_468 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_468 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_682.xyx * _682.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _678 * View.View_PreExposure;
    out.out_var_SV_Target1 = _692;
    out.out_var_SV_Target2 = _696;
    out.out_var_SV_Target3 = _708;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_435, 1.0, 1.0, 1.0);
    return out;
}

