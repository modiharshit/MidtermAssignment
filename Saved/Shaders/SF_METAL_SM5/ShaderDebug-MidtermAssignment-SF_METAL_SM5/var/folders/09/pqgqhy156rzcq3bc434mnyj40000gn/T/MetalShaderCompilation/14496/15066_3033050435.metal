

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
    char _m0_pad[704];
    float4x4 View_SVPositionToTranslatedWorld;
    char _m1_pad[288];
    float4 View_ScreenPositionScaleBias;
    char _m2_pad[48];
    float3 View_PreViewTranslation;
    char _m3_pad[928];
    float4 View_ViewRectMin;
    float4 View_ViewSizeAndInvSize;
    char _m5_pad[68];
    float View_PreExposure;
    float4 View_DiffuseOverrideParameter;
    float4 View_SpecularOverrideParameter;
    float4 View_NormalOverrideParameter;
    float2 View_RoughnessOverrideParameter;
    char _m10_pad[8];
    float View_OutOfBoundsMask;
    char _m11_pad[80];
    float View_UnlitViewmodeMask;
    char _m12_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m13_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m14_pad[188];
    float View_ShowDecalsMask;
    char _m15_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m16_pad[48];
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
    spvUnsafeArray<float4, 4> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _148 = {};
constant float _150 = {};
constant float4 _151 = {};

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
};

fragment MainPS_out Main_00003ada_b4c8ad43(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(11)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    float4 _204 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _150, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _209 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _214 = (_209.xyz / float3(_209.w)) - View.View_PreViewTranslation;
    float3 _222 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _237 = fast::clamp(Material.Material_VectorExpressions[3].xyz, float3(0.0), float3(1.0));
    float _238 = fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0);
    float _243 = (fast::clamp(Material.Material_ScalarExpressions[0].z, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _292;
    float _293;
    float _294;
    float3 _295;
    float3 _296;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _260 = ((_204.xy / float2(_204.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _264 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _260, level(0.0));
        float4 _267 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _260, level(0.0));
        float4 _270 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _260, level(0.0));
        float _280 = _270.w;
        _292 = (_243 * _280) + _270.z;
        _293 = (0.5 * _280) + _270.y;
        _294 = (_238 * _280) + _270.x;
        _295 = (_237 * _264.w) + _264.xyz;
        _296 = normalize((_222 * _267.w) + ((_267.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _292 = _243;
        _293 = 0.5;
        _294 = _238;
        _295 = _237;
        _296 = _222;
    }
    float3 _306 = fast::clamp((_214 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _317 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_306.x), int(_306.y), int(_306.z), 0).xyz), 0));
    float3 _332 = (((_317.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_306 / float3(_317.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _345;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        _345 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _332, level(0.0)).x;
    }
    else
    {
        _345 = 1.0;
    }
    float3 _359 = ((_295 - (_295 * _294)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _366 = (mix(float3(0.07999999821186065673828125 * _293), _295, float3(_294)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _369 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _374;
    if (_369)
    {
        _374 = _359 + (_366 * 0.449999988079071044921875);
    }
    else
    {
        _374 = _359;
    }
    float3 _376 = select(_366, float3(0.0), bool3(_369));
    float3 _378 = float3(dot(_376, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _395 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _332, level(0.0));
    float _411 = _395.x;
    float4 _413 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _332, level(0.0)) * 2.0) - float4(1.0)) * _411) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _414 = _395.y;
    float4 _416 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _332, level(0.0)) * 2.0) - float4(1.0)) * _414) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _417 = _395.z;
    float4 _419 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _332, level(0.0)) * 2.0) - float4(1.0)) * _417) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _436 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _332, level(0.0)) * 2.0) - float4(1.0)) * _411) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _438 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _332, level(0.0)) * 2.0) - float4(1.0)) * _414) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _440 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _332, level(0.0)) * 2.0) - float4(1.0)) * _417) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _473 = _151;
    _473.y = (-0.48860299587249755859375) * _296.y;
    float4 _476 = _473;
    _476.z = 0.48860299587249755859375 * _296.z;
    float4 _479 = _476;
    _479.w = (-0.48860299587249755859375) * _296.x;
    float3 _480 = _296 * _296;
    float4 _483 = _148;
    _483.x = (1.09254801273345947265625 * _296.x) * _296.y;
    float4 _486 = _483;
    _486.y = ((-1.09254801273345947265625) * _296.y) * _296.z;
    float4 _491 = _486;
    _491.z = 0.3153919875621795654296875 * ((3.0 * _480.z) - 1.0);
    float4 _494 = _491;
    _494.w = ((-1.09254801273345947265625) * _296.x) * _296.z;
    float4 _498 = _479;
    _498.x = 0.886227548122406005859375;
    float3 _500 = _498.yzw * 2.094395160675048828125;
    float4 _501 = float4(_498.x, _500.x, _500.y, _500.z);
    float4 _502 = _494 * 0.785398185253143310546875;
    float _503 = (_480.x - _480.y) * 0.4290426075458526611328125;
    float3 _509 = float3(0.0);
    _509.x = (dot(float4(_411, _413.xyz), _501) + dot(float4(_413.w, _436.xyz), _502)) + (_436.w * _503);
    float3 _515 = _509;
    _515.y = (dot(float4(_414, _416.xyz), _501) + dot(float4(_416.w, _438.xyz), _502)) + (_438.w * _503);
    float3 _521 = _515;
    _521.z = (dot(float4(_417, _419.xyz), _501) + dot(float4(_419.w, _440.xyz), _502)) + (_440.w * _503);
    float3 _526 = (fast::max(float3(0.0), _521) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    float3 _548 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _574;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _573;
        if (any(abs(_214 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _573 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_214, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _573 = _548;
        }
        _574 = _573;
    }
    else
    {
        _574 = _548;
    }
    float4 _581 = float4(((mix(float3(0.0), _374 + (_376 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_526 * _374) * fast::max(float3(1.0), ((((((_295 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_295 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_295 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _574) * 1.0, 0.0);
    float4 _588;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _587 = _581;
        _587.w = 0.0;
        _588 = _587;
    }
    else
    {
        _588 = _581;
    }
    float2 _592 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _600 = (_296 * 0.5) + float3(0.5);
    float4 _602 = float4(_600.x, _600.y, _600.z, float4(0.0).w);
    _602.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _603 = float4(0.0);
    _603.x = _294;
    float4 _604 = _603;
    _604.y = _293;
    float4 _605 = _604;
    _605.z = _292;
    float4 _606 = _605;
    _606.w = 0.50588238239288330078125;
    float4 _618 = float4(_295.x, _295.y, _295.z, float4(0.0).w);
    _618.w = ((log2(((dot(_526, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_378 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_378 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_378 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_592.xyx * _592.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _588 * View.View_PreExposure;
    out.out_var_SV_Target1 = _602;
    out.out_var_SV_Target2 = _606;
    out.out_var_SV_Target3 = _618;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_345, 1.0, 1.0, 1.0);
    return out;
}

