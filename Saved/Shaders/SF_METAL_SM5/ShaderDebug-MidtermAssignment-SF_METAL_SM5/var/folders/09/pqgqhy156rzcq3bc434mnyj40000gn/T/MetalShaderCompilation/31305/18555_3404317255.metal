

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

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _179 = {};
constant float4 _181 = {};

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
    uint in_var_PRIMITIVE_ID [[user(locn3)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_0000487b_cae9c247(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(11)]], texture2d<float> Material_Texture2D_0 [[texture(12)]], texture2d<float> Material_Texture2D_1 [[texture(13)]], texture2d<float> Material_Texture2D_2 [[texture(14)]], texture2d<float> Material_Texture2D_3 [[texture(15)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _238 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _242 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _247 = (_242.xyz / float3(_242.w)) - View.View_PreViewTranslation;
    float4 _253 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _256 = (_253.xy * float2(2.0)) - float2(1.0);
    float4 _268 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _295;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _295 = _238.w;
                break;
            }
            else
            {
                float _279 = _238.z;
                _295 = ((_279 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_279 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _311 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(float4(_256, sqrt(fast::clamp(1.0 - dot(_256, _256), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _268.x) + _295) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _323 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _328 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _333 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _337 = (_323.x + 0.5) * ((_328.x + 0.5) * (_333.x + 0.5));
    float4 _343 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _349 = fast::clamp(mix(float3(0.20000000298023223876953125), float3(1.0), float3(_337)) * _343.xyz, float3(0.0), float3(1.0));
    float _354 = (fast::clamp(mix(0.800000011920928955078125, 0.300000011920928955078125, _337 * _343.w), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _355 = in.in_var_PRIMITIVE_ID * 36u;
    uint _356 = _355 + 20u;
    float _404;
    float _405;
    float _406;
    float3 _407;
    float3 _408;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _356)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _374 = ((_238.xy / float2(_238.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _378 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _374, level(0.0));
        float4 _381 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _374, level(0.0));
        float4 _384 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _374, level(0.0));
        float _394 = _384.w;
        _404 = (_354 * _394) + _384.z;
        _405 = (0.5 * _394) + _384.y;
        _406 = _384.x;
        _407 = (_349 * _378.w) + _378.xyz;
        _408 = normalize((_311 * _381.w) + ((_381.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _404 = _354;
        _405 = 0.5;
        _406 = 0.0;
        _407 = _349;
        _408 = _311;
    }
    float3 _418 = fast::clamp((_247 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _429 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_418.x), int(_418.y), int(_418.z), 0).xyz), 0));
    float3 _444 = (((_429.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_418 / float3(_429.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _457;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _356)].z > 0.0)
    {
        _457 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _444, level(0.0)).x;
    }
    else
    {
        _457 = 1.0;
    }
    float3 _471 = ((_407 - (_407 * _406)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _478 = (mix(float3(0.07999999821186065673828125 * _405), _407, float3(_406)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _481 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _486;
    if (_481)
    {
        _486 = _471 + (_478 * 0.449999988079071044921875);
    }
    else
    {
        _486 = _471;
    }
    float3 _488 = select(_478, float3(0.0), bool3(_481));
    float3 _490 = float3(dot(_488, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _507 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _444, level(0.0));
    float _523 = _507.x;
    float4 _525 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _444, level(0.0)) * 2.0) - float4(1.0)) * _523) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _526 = _507.y;
    float4 _528 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _444, level(0.0)) * 2.0) - float4(1.0)) * _526) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _529 = _507.z;
    float4 _531 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _444, level(0.0)) * 2.0) - float4(1.0)) * _529) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _548 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _444, level(0.0)) * 2.0) - float4(1.0)) * _523) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _550 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _444, level(0.0)) * 2.0) - float4(1.0)) * _526) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _552 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _444, level(0.0)) * 2.0) - float4(1.0)) * _529) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _585 = _181;
    _585.y = (-0.48860299587249755859375) * _408.y;
    float4 _588 = _585;
    _588.z = 0.48860299587249755859375 * _408.z;
    float4 _591 = _588;
    _591.w = (-0.48860299587249755859375) * _408.x;
    float3 _592 = _408 * _408;
    float4 _595 = _179;
    _595.x = (1.09254801273345947265625 * _408.x) * _408.y;
    float4 _598 = _595;
    _598.y = ((-1.09254801273345947265625) * _408.y) * _408.z;
    float4 _603 = _598;
    _603.z = 0.3153919875621795654296875 * ((3.0 * _592.z) - 1.0);
    float4 _606 = _603;
    _606.w = ((-1.09254801273345947265625) * _408.x) * _408.z;
    float4 _610 = _591;
    _610.x = 0.886227548122406005859375;
    float3 _612 = _610.yzw * 2.094395160675048828125;
    float4 _613 = float4(_610.x, _612.x, _612.y, _612.z);
    float4 _614 = _606 * 0.785398185253143310546875;
    float _615 = (_592.x - _592.y) * 0.4290426075458526611328125;
    float3 _621 = float3(0.0);
    _621.x = (dot(float4(_523, _525.xyz), _613) + dot(float4(_525.w, _548.xyz), _614)) + (_548.w * _615);
    float3 _627 = _621;
    _627.y = (dot(float4(_526, _528.xyz), _613) + dot(float4(_528.w, _550.xyz), _614)) + (_550.w * _615);
    float3 _633 = _627;
    _633.z = (dot(float4(_529, _531.xyz), _613) + dot(float4(_531.w, _552.xyz), _614)) + (_552.w * _615);
    float3 _638 = (fast::max(float3(0.0), _633) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    float3 _660 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _689;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _688;
        if (any(abs(_247 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _355 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _355 + 19u)].xyz + float3(1.0))))
        {
            _688 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_247, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _688 = _660;
        }
        _689 = _688;
    }
    else
    {
        _689 = _660;
    }
    float4 _696 = float4(((mix(float3(0.0), _486 + (_488 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_638 * _486) * fast::max(float3(1.0), ((((((_407 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_407 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_407 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _689) * 1.0, 0.0);
    float4 _703;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _702 = _696;
        _702.w = 0.0;
        _703 = _702;
    }
    else
    {
        _703 = _696;
    }
    float2 _707 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _715 = (_408 * 0.5) + float3(0.5);
    float4 _717 = float4(_715.x, _715.y, _715.z, float4(0.0).w);
    _717.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _356)].y;
    float4 _718 = float4(0.0);
    _718.x = _406;
    float4 _719 = _718;
    _719.y = _405;
    float4 _720 = _719;
    _720.z = _404;
    float4 _721 = _720;
    _721.w = 0.50588238239288330078125;
    float4 _733 = float4(_407.x, _407.y, _407.z, float4(0.0).w);
    _733.w = ((log2(((dot(_638, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_490 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_490 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_490 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_707.xyx * _707.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _703 * View.View_PreExposure;
    out.out_var_SV_Target1 = _717;
    out.out_var_SV_Target2 = _721;
    out.out_var_SV_Target3 = _733;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_457, 1.0, 1.0, 1.0);
    return out;
}

