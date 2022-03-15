

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
    char _m13_pad[36];
    float View_GameTime;
    char _m14_pad[8];
    float View_MaterialTextureMipBias;
    char _m15_pad[28];
    float View_UnlitViewmodeMask;
    char _m16_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m17_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m18_pad[188];
    float View_ShowDecalsMask;
    char _m19_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m20_pad[48];
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
    spvUnsafeArray<float4, 5> Material_VectorExpressions;
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

fragment MainPS_out Main_00004d47_2b200763(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(11)]], texture2d<float> Material_Texture2D_0 [[texture(12)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    bool _330;
    float4 _239 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _243 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _248 = (_243.xyz / float3(_243.w)) - View.View_PreViewTranslation;
    float4 _260 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(View.View_GameTime * (-0.100000001490116119384765625), View.View_GameTime * (-0.0500000007450580596923828125)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y)), bias(View.View_MaterialTextureMipBias));
    float2 _263 = (_260.xy * float2(2.0)) - float2(1.0);
    float _272 = View.View_GameTime * 0.0500000007450580596923828125;
    float4 _277 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(View.View_GameTime * 0.039999999105930328369140625, _272) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5)), bias(View.View_MaterialTextureMipBias));
    float2 _280 = (_277.xy * float2(2.0)) - float2(1.0);
    float _292 = View.View_GameTime * (-0.02999999932944774627685546875);
    float4 _297 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(_292, _272) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.300000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float2 _300 = (_297.xy * float2(2.0)) - float2(1.0);
    float4 _312 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(_272, 0.0) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.25)), bias(View.View_MaterialTextureMipBias));
    float2 _315 = (_312.xy * float2(2.0)) - float2(1.0);
    float _350;
    switch (0u)
    {
        default:
        {
            _330 = View.View_ViewToClip[3u].w < 1.0;
            if (_330)
            {
                _350 = _239.w;
                break;
            }
            else
            {
                float _334 = _239.z;
                _350 = ((_334 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_334 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float4 _362 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(_292, View.View_GameTime * (-0.0089999996125698089599609375)) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float2 _365 = (_362.xy * float2(2.0)) - float2(1.0);
    float4 _378 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(View.View_GameTime * 0.02999999932944774627685546875, 0.0) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(0.07999999821186065673828125, 0.039999999105930328369140625))), bias(View.View_MaterialTextureMipBias));
    float2 _381 = (_378.xy * float2(2.0)) - float2(1.0);
    float _414;
    switch (0u)
    {
        default:
        {
            if (_330)
            {
                _414 = _239.w;
                break;
            }
            else
            {
                float _398 = _239.z;
                _414 = ((_398 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_398 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _428 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(mix(float4(_263, sqrt(fast::clamp(1.0 - dot(_263, _263), 0.0, 1.0)), 1.0).xyz + (float4(_280, sqrt(fast::clamp(1.0 - dot(_280, _280), 0.0, 1.0)), 1.0).xyz * float3(-1.0, -1.0, 1.0)), float4(_300, sqrt(fast::clamp(1.0 - dot(_300, _300), 0.0, 1.0)), 1.0).xyz + float4(_315, sqrt(fast::clamp(1.0 - dot(_315, _315), 0.0, 1.0)), 1.0).xyz, float3(fast::min(fast::max((_350 - 300.0) * 0.0011111111380159854888916015625, 0.0), 1.0))), float4(_365, sqrt(fast::clamp(1.0 - dot(_365, _365), 0.0, 1.0)), 1.0).xyz + (float4(_381, sqrt(fast::clamp(1.0 - dot(_381, _381), 0.0, 1.0)), 1.0).xyz * float3(-1.0, -1.0, 1.0)), float3(fast::min(fast::max((_414 - 500.0) * 0.0005000000237487256526947021484375, 0.0), 1.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _439 = fast::clamp(Material.Material_VectorExpressions[4].xyz, float3(0.0), float3(1.0));
    float _443 = (0.300000011920928955078125 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _444 = in.in_var_PRIMITIVE_ID * 36u;
    uint _445 = _444 + 20u;
    float _494;
    float _495;
    float _496;
    float3 _497;
    float3 _498;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _445)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _463 = ((_239.xy / float2(_239.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _467 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _463, level(0.0));
        float4 _470 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _463, level(0.0));
        float4 _473 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _463, level(0.0));
        float _483 = _473.w;
        _494 = (_443 * _483) + _473.z;
        _495 = (0.5 * _483) + _473.y;
        _496 = _483 + _473.x;
        _497 = (_439 * _467.w) + _467.xyz;
        _498 = normalize((_428 * _470.w) + ((_470.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _494 = _443;
        _495 = 0.5;
        _496 = 1.0;
        _497 = _439;
        _498 = _428;
    }
    float3 _508 = fast::clamp((_248 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _519 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_508.x), int(_508.y), int(_508.z), 0).xyz), 0));
    float3 _534 = (((_519.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_508 / float3(_519.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _547;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _445)].z > 0.0)
    {
        _547 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _534, level(0.0)).x;
    }
    else
    {
        _547 = 1.0;
    }
    float3 _561 = ((_497 - (_497 * _496)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _568 = (mix(float3(0.07999999821186065673828125 * _495), _497, float3(_496)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _571 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _576;
    if (_571)
    {
        _576 = _561 + (_568 * 0.449999988079071044921875);
    }
    else
    {
        _576 = _561;
    }
    float3 _578 = select(_568, float3(0.0), bool3(_571));
    float3 _580 = float3(dot(_578, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _597 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _534, level(0.0));
    float _613 = _597.x;
    float4 _615 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _534, level(0.0)) * 2.0) - float4(1.0)) * _613) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _616 = _597.y;
    float4 _618 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _534, level(0.0)) * 2.0) - float4(1.0)) * _616) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _619 = _597.z;
    float4 _621 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _534, level(0.0)) * 2.0) - float4(1.0)) * _619) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _638 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _534, level(0.0)) * 2.0) - float4(1.0)) * _613) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _640 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _534, level(0.0)) * 2.0) - float4(1.0)) * _616) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _642 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _534, level(0.0)) * 2.0) - float4(1.0)) * _619) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _675 = _181;
    _675.y = (-0.48860299587249755859375) * _498.y;
    float4 _678 = _675;
    _678.z = 0.48860299587249755859375 * _498.z;
    float4 _681 = _678;
    _681.w = (-0.48860299587249755859375) * _498.x;
    float3 _682 = _498 * _498;
    float4 _685 = _179;
    _685.x = (1.09254801273345947265625 * _498.x) * _498.y;
    float4 _688 = _685;
    _688.y = ((-1.09254801273345947265625) * _498.y) * _498.z;
    float4 _693 = _688;
    _693.z = 0.3153919875621795654296875 * ((3.0 * _682.z) - 1.0);
    float4 _696 = _693;
    _696.w = ((-1.09254801273345947265625) * _498.x) * _498.z;
    float4 _700 = _681;
    _700.x = 0.886227548122406005859375;
    float3 _702 = _700.yzw * 2.094395160675048828125;
    float4 _703 = float4(_700.x, _702.x, _702.y, _702.z);
    float4 _704 = _696 * 0.785398185253143310546875;
    float _705 = (_682.x - _682.y) * 0.4290426075458526611328125;
    float3 _711 = float3(0.0);
    _711.x = (dot(float4(_613, _615.xyz), _703) + dot(float4(_615.w, _638.xyz), _704)) + (_638.w * _705);
    float3 _717 = _711;
    _717.y = (dot(float4(_616, _618.xyz), _703) + dot(float4(_618.w, _640.xyz), _704)) + (_640.w * _705);
    float3 _723 = _717;
    _723.z = (dot(float4(_619, _621.xyz), _703) + dot(float4(_621.w, _642.xyz), _704)) + (_642.w * _705);
    float3 _728 = (fast::max(float3(0.0), _723) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    float3 _750 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _779;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _778;
        if (any(abs(_248 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _444 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _444 + 19u)].xyz + float3(1.0))))
        {
            _778 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_248, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _778 = _750;
        }
        _779 = _778;
    }
    else
    {
        _779 = _750;
    }
    float4 _786 = float4(((mix(float3(0.0), _576 + (_578 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_728 * _576) * fast::max(float3(1.0), ((((((_497 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_497 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_497 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _779) * 1.0, 0.0);
    float4 _793;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _792 = _786;
        _792.w = 0.0;
        _793 = _792;
    }
    else
    {
        _793 = _786;
    }
    float2 _797 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _805 = (_498 * 0.5) + float3(0.5);
    float4 _807 = float4(_805.x, _805.y, _805.z, float4(0.0).w);
    _807.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _445)].y;
    float4 _808 = float4(0.0);
    _808.x = _496;
    float4 _809 = _808;
    _809.y = _495;
    float4 _810 = _809;
    _810.z = _494;
    float4 _811 = _810;
    _811.w = 0.50588238239288330078125;
    float4 _823 = float4(_497.x, _497.y, _497.z, float4(0.0).w);
    _823.w = ((log2(((dot(_728, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_580 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_580 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_580 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_797.xyx * _797.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _793 * View.View_PreExposure;
    out.out_var_SV_Target1 = _807;
    out.out_var_SV_Target2 = _811;
    out.out_var_SV_Target3 = _823;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_547, 1.0, 1.0, 1.0);
    return out;
}

