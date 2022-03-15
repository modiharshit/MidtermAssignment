

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

fragment MainPS_out Main_00003ac2_792d0ffd(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(11)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    float4 _204 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _150, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _209 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _214 = (_209.xyz / float3(_209.w)) - View.View_PreViewTranslation;
    float3 _222 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _237 = fast::clamp(Material.Material_VectorExpressions[3].xyz, float3(0.0), float3(1.0));
    float _238 = fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0);
    float _243 = (fast::clamp(Material.Material_ScalarExpressions[0].z, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _290;
    float _291;
    float _292;
    float3 _293;
    float3 _294;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _260 = ((_204.xy / float2(_204.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _264 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _260, level(0.0));
        float4 _267 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _260, level(0.0));
        float4 _270 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _260, level(0.0));
        float _280 = _270.w;
        _290 = (_243 * _280) + _270.z;
        _291 = (_238 * _280) + _270.y;
        _292 = _270.x;
        _293 = (_237 * _264.w) + _264.xyz;
        _294 = normalize((_222 * _267.w) + ((_267.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _290 = _243;
        _291 = _238;
        _292 = 0.0;
        _293 = _237;
        _294 = _222;
    }
    float3 _304 = fast::clamp((_214 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _315 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_304.x), int(_304.y), int(_304.z), 0).xyz), 0));
    float3 _330 = (((_315.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_304 / float3(_315.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _343;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        _343 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _330, level(0.0)).x;
    }
    else
    {
        _343 = 1.0;
    }
    float3 _357 = ((_293 - (_293 * _292)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _364 = (mix(float3(0.07999999821186065673828125 * _291), _293, float3(_292)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _367 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _372;
    if (_367)
    {
        _372 = _357 + (_364 * 0.449999988079071044921875);
    }
    else
    {
        _372 = _357;
    }
    float3 _374 = select(_364, float3(0.0), bool3(_367));
    float3 _376 = float3(dot(_374, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _393 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _330, level(0.0));
    float _409 = _393.x;
    float4 _411 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _330, level(0.0)) * 2.0) - float4(1.0)) * _409) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _412 = _393.y;
    float4 _414 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _330, level(0.0)) * 2.0) - float4(1.0)) * _412) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _415 = _393.z;
    float4 _417 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _330, level(0.0)) * 2.0) - float4(1.0)) * _415) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _434 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _330, level(0.0)) * 2.0) - float4(1.0)) * _409) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _436 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _330, level(0.0)) * 2.0) - float4(1.0)) * _412) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _438 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _330, level(0.0)) * 2.0) - float4(1.0)) * _415) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _471 = _151;
    _471.y = (-0.48860299587249755859375) * _294.y;
    float4 _474 = _471;
    _474.z = 0.48860299587249755859375 * _294.z;
    float4 _477 = _474;
    _477.w = (-0.48860299587249755859375) * _294.x;
    float3 _478 = _294 * _294;
    float4 _481 = _148;
    _481.x = (1.09254801273345947265625 * _294.x) * _294.y;
    float4 _484 = _481;
    _484.y = ((-1.09254801273345947265625) * _294.y) * _294.z;
    float4 _489 = _484;
    _489.z = 0.3153919875621795654296875 * ((3.0 * _478.z) - 1.0);
    float4 _492 = _489;
    _492.w = ((-1.09254801273345947265625) * _294.x) * _294.z;
    float4 _496 = _477;
    _496.x = 0.886227548122406005859375;
    float3 _498 = _496.yzw * 2.094395160675048828125;
    float4 _499 = float4(_496.x, _498.x, _498.y, _498.z);
    float4 _500 = _492 * 0.785398185253143310546875;
    float _501 = (_478.x - _478.y) * 0.4290426075458526611328125;
    float3 _507 = float3(0.0);
    _507.x = (dot(float4(_409, _411.xyz), _499) + dot(float4(_411.w, _434.xyz), _500)) + (_434.w * _501);
    float3 _513 = _507;
    _513.y = (dot(float4(_412, _414.xyz), _499) + dot(float4(_414.w, _436.xyz), _500)) + (_436.w * _501);
    float3 _519 = _513;
    _519.z = (dot(float4(_415, _417.xyz), _499) + dot(float4(_417.w, _438.xyz), _500)) + (_438.w * _501);
    float3 _524 = (fast::max(float3(0.0), _519) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    float3 _546 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _572;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _571;
        if (any(abs(_214 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _571 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_214, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _571 = _546;
        }
        _572 = _571;
    }
    else
    {
        _572 = _546;
    }
    float4 _579 = float4(((mix(float3(0.0), _372 + (_374 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_524 * _372) * fast::max(float3(1.0), ((((((_293 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_293 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_293 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _572) * 1.0, 0.0);
    float4 _586;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _585 = _579;
        _585.w = 0.0;
        _586 = _585;
    }
    else
    {
        _586 = _579;
    }
    float2 _590 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _598 = (_294 * 0.5) + float3(0.5);
    float4 _600 = float4(_598.x, _598.y, _598.z, float4(0.0).w);
    _600.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _601 = float4(0.0);
    _601.x = _292;
    float4 _602 = _601;
    _602.y = _291;
    float4 _603 = _602;
    _603.z = _290;
    float4 _604 = _603;
    _604.w = 0.50588238239288330078125;
    float4 _616 = float4(_293.x, _293.y, _293.z, float4(0.0).w);
    _616.w = ((log2(((dot(_524, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_376 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_376 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_376 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_590.xyx * _590.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _586 * View.View_PreExposure;
    out.out_var_SV_Target1 = _600;
    out.out_var_SV_Target2 = _604;
    out.out_var_SV_Target3 = _616;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_343, 1.0, 1.0, 1.0);
    return out;
}

