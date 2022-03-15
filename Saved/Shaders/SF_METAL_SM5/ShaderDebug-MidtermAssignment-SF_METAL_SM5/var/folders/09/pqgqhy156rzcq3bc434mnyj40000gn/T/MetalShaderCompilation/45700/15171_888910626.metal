

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
    char _m11_pad[24];
    float View_CullingSign;
    char _m12_pad[52];
    float View_UnlitViewmodeMask;
    char _m13_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m14_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m15_pad[188];
    float View_ShowDecalsMask;
    char _m16_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m17_pad[48];
    float3 View_VolumetricLightmapWorldToUVScale;
    float3 View_VolumetricLightmapWorldToUVAdd;
    packed_float3 View_VolumetricLightmapIndirectionTextureSize;
    float View_VolumetricLightmapBrickSize;
    float3 View_VolumetricLightmapBrickTexelSize;
};

struct type_Primitive
{
    char _m0_pad[64];
    float4 Primitive_InvNonUniformScaleAndDeterminantSign;
    float4 Primitive_ObjectWorldPositionAndRadius;
    char _m2_pad[208];
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

constant float4 _150 = {};
constant float _152 = {};
constant float4 _153 = {};

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
    float4 in_var_COLOR0 [[user(locn2)]];
};

fragment MainPS_out Main_00003b43_34fbb322(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(11)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]], bool gl_FrontFacing [[front_facing]])
{
    MainPS_out out = {};
    float4 _211 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _152, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _216 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _221 = (_216.xyz / float3(_216.w)) - View.View_PreViewTranslation;
    float3 _235 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * ((View.View_CullingSign * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w) * float(gl_FrontFacing ? 1 : (-1)));
    float3 _244 = fast::clamp(in.in_var_COLOR0.xyz, float3(0.0), float3(1.0));
    float _248 = (0.5 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _293;
    float _294;
    float _295;
    float3 _296;
    float3 _297;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _265 = ((_211.xy / float2(_211.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _269 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _265, level(0.0));
        float4 _272 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _265, level(0.0));
        float4 _275 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _265, level(0.0));
        _293 = (_248 * _275.w) + _275.z;
        _294 = _275.y;
        _295 = _275.x;
        _296 = (_244 * _269.w) + _269.xyz;
        _297 = normalize((_235 * _272.w) + ((_272.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _293 = _248;
        _294 = 0.0;
        _295 = 0.0;
        _296 = _244;
        _297 = _235;
    }
    float3 _307 = fast::clamp((_221 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _318 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_307.x), int(_307.y), int(_307.z), 0).xyz), 0));
    float3 _333 = (((_318.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_307 / float3(_318.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _346;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        _346 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _333, level(0.0)).x;
    }
    else
    {
        _346 = 1.0;
    }
    float3 _360 = ((_296 - (_296 * _295)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _367 = (mix(float3(0.07999999821186065673828125 * _294), _296, float3(_295)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _370 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _375;
    if (_370)
    {
        _375 = _360 + (_367 * 0.449999988079071044921875);
    }
    else
    {
        _375 = _360;
    }
    float3 _377 = select(_367, float3(0.0), bool3(_370));
    float3 _379 = float3(dot(_377, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _396 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _333, level(0.0));
    float _412 = _396.x;
    float4 _414 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _333, level(0.0)) * 2.0) - float4(1.0)) * _412) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _415 = _396.y;
    float4 _417 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _333, level(0.0)) * 2.0) - float4(1.0)) * _415) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _418 = _396.z;
    float4 _420 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _333, level(0.0)) * 2.0) - float4(1.0)) * _418) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _437 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _333, level(0.0)) * 2.0) - float4(1.0)) * _412) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _439 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _333, level(0.0)) * 2.0) - float4(1.0)) * _415) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _441 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _333, level(0.0)) * 2.0) - float4(1.0)) * _418) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _474 = _153;
    _474.y = (-0.48860299587249755859375) * _297.y;
    float4 _477 = _474;
    _477.z = 0.48860299587249755859375 * _297.z;
    float4 _480 = _477;
    _480.w = (-0.48860299587249755859375) * _297.x;
    float3 _481 = _297 * _297;
    float4 _484 = _150;
    _484.x = (1.09254801273345947265625 * _297.x) * _297.y;
    float4 _487 = _484;
    _487.y = ((-1.09254801273345947265625) * _297.y) * _297.z;
    float4 _492 = _487;
    _492.z = 0.3153919875621795654296875 * ((3.0 * _481.z) - 1.0);
    float4 _495 = _492;
    _495.w = ((-1.09254801273345947265625) * _297.x) * _297.z;
    float4 _499 = _480;
    _499.x = 0.886227548122406005859375;
    float3 _501 = _499.yzw * 2.094395160675048828125;
    float4 _502 = float4(_499.x, _501.x, _501.y, _501.z);
    float4 _503 = _495 * 0.785398185253143310546875;
    float _504 = (_481.x - _481.y) * 0.4290426075458526611328125;
    float3 _510 = float3(0.0);
    _510.x = (dot(float4(_412, _414.xyz), _502) + dot(float4(_414.w, _437.xyz), _503)) + (_437.w * _504);
    float3 _516 = _510;
    _516.y = (dot(float4(_415, _417.xyz), _502) + dot(float4(_417.w, _439.xyz), _503)) + (_439.w * _504);
    float3 _522 = _516;
    _522.z = (dot(float4(_418, _420.xyz), _502) + dot(float4(_420.w, _441.xyz), _503)) + (_441.w * _504);
    float3 _527 = (fast::max(float3(0.0), _522) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    float3 _549 = fast::max(mix(in.in_var_COLOR0.xyz, Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _575;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _574;
        if (any(abs(_221 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _574 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_221, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _574 = _549;
        }
        _575 = _574;
    }
    else
    {
        _575 = _549;
    }
    float4 _582 = float4(((mix(float3(0.0), _375 + (_377 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_527 * _375) * fast::max(float3(1.0), ((((((_296 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_296 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_296 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _575) * 1.0, 0.0);
    float4 _589;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _588 = _582;
        _588.w = 0.0;
        _589 = _588;
    }
    else
    {
        _589 = _582;
    }
    float2 _593 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _601 = (_297 * 0.5) + float3(0.5);
    float4 _603 = float4(_601.x, _601.y, _601.z, float4(0.0).w);
    _603.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _604 = float4(0.0);
    _604.x = _295;
    float4 _605 = _604;
    _605.y = _294;
    float4 _606 = _605;
    _606.z = _293;
    float4 _607 = _606;
    _607.w = 0.50588238239288330078125;
    float4 _619 = float4(_296.x, _296.y, _296.z, float4(0.0).w);
    _619.w = ((log2(((dot(_527, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_379 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_379 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_379 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_593.xyx * _593.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _589 * View.View_PreExposure;
    out.out_var_SV_Target1 = _603;
    out.out_var_SV_Target2 = _607;
    out.out_var_SV_Target3 = _619;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_346, 1.0, 1.0, 1.0);
    return out;
}

