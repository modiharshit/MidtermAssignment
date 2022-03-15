

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
    float View_IndirectLightingCacheShowFlag;
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_IndirectLightingCache
{
    char _m0_pad[80];
    float IndirectLightingCache_DirectionalLightShadowing;
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients0;
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients1;
    float4 IndirectLightingCache_IndirectLightingSHCoefficients2;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _174 = {};
constant float4 _176 = {};

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

fragment MainPS_out Main_00004692_ff2f55ee(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _233 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _237 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _242 = (_237.xyz / float3(_237.w)) - View.View_PreViewTranslation;
    float2 _243 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.25;
    float4 _249 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _243, bias(View.View_MaterialTextureMipBias));
    float2 _252 = (_249.xy * float2(2.0)) - float2(1.0);
    float2 _260 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.3499999940395355224609375;
    float4 _262 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _260, bias(View.View_MaterialTextureMipBias));
    float2 _265 = (_262.xy * float2(2.0)) - float2(1.0);
    float4 _277 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _282 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _287 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _291 = (_277.x + 0.5) * ((_282.x + 0.5) * (_287.x + 0.5));
    float _294 = fast::min(fast::max(mix(-2.0, 0.699999988079071044921875, _291), 0.0), 1.0);
    float3 _297 = float3(_294);
    float4 _303 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _330;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _330 = _233.w;
                break;
            }
            else
            {
                float _314 = _233.z;
                _330 = ((_314 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_314 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _345 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(mix(float4(_252, sqrt(fast::clamp(1.0 - dot(_252, _252), 0.0, 1.0)), 1.0).xyz, float4(_265, sqrt(fast::clamp(1.0 - dot(_265, _265), 0.0, 1.0)), 1.0).xyz, _297), float3(0.0, 0.0, 1.0), float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _303.x) + _330) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _358 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _243, bias(View.View_MaterialTextureMipBias));
    float4 _360 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _260, bias(View.View_MaterialTextureMipBias));
    float3 _369 = fast::clamp(mix(float3(0.6349999904632568359375), float3(1.0), float3(_291)) * mix(_358.xyz, _360.xyz, _297), float3(0.0), float3(1.0));
    float _374 = (fast::clamp(mix(0.800000011920928955078125, 0.20000000298023223876953125, mix(_358.w, _360.w, _294)), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _375 = in.in_var_PRIMITIVE_ID * 36u;
    uint _376 = _375 + 20u;
    float _424;
    float _425;
    float _426;
    float3 _427;
    float3 _428;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _376)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _394 = ((_233.xy / float2(_233.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _398 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _394, level(0.0));
        float4 _401 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _394, level(0.0));
        float4 _404 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _394, level(0.0));
        float _414 = _404.w;
        _424 = (_374 * _414) + _404.z;
        _425 = (0.5 * _414) + _404.y;
        _426 = _404.x;
        _427 = (_369 * _398.w) + _398.xyz;
        _428 = normalize((_345 * _401.w) + ((_401.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _424 = _374;
        _425 = 0.5;
        _426 = 0.0;
        _427 = _369;
        _428 = _345;
    }
    bool _438 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _444;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _375 + 18u)].w > 0.0) && _438)
    {
        _444 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _444 = 1.0;
    }
    float _491;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _376)].z > 0.0)
    {
        float3 _459 = fast::clamp((_242 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _470 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_459.x), int(_459.y), int(_459.z), 0).xyz), 0));
        _491 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_470.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_459 / float3(_470.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _491 = _444;
    }
    float3 _505 = ((_427 - (_427 * _426)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _512 = (mix(float3(0.07999999821186065673828125 * _425), _427, float3(_426)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _515 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _520;
    if (_515)
    {
        _520 = _505 + (_512 * 0.449999988079071044921875);
    }
    else
    {
        _520 = _505;
    }
    float3 _522 = select(_512, float3(0.0), bool3(_515));
    float3 _524 = float3(dot(_522, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _610;
    if (_438)
    {
        float4 _560 = _176;
        _560.y = (-0.48860299587249755859375) * _428.y;
        float4 _563 = _560;
        _563.z = 0.48860299587249755859375 * _428.z;
        float4 _566 = _563;
        _566.w = (-0.48860299587249755859375) * _428.x;
        float3 _567 = _428 * _428;
        float4 _570 = _174;
        _570.x = (1.09254801273345947265625 * _428.x) * _428.y;
        float4 _573 = _570;
        _573.y = ((-1.09254801273345947265625) * _428.y) * _428.z;
        float4 _578 = _573;
        _578.z = 0.3153919875621795654296875 * ((3.0 * _567.z) - 1.0);
        float4 _581 = _578;
        _581.w = ((-1.09254801273345947265625) * _428.x) * _428.z;
        float4 _585 = _566;
        _585.x = 0.886227548122406005859375;
        float3 _587 = _585.yzw * 2.094395160675048828125;
        float4 _588 = float4(_585.x, _587.x, _587.y, _587.z);
        float4 _589 = _581 * 0.785398185253143310546875;
        float _590 = (_567.x - _567.y) * 0.4290426075458526611328125;
        float3 _596 = float3(0.0);
        _596.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _588) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _589)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _590);
        float3 _602 = _596;
        _602.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _588) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _589)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _590);
        float3 _608 = _602;
        _608.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _588) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _589)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _590);
        _610 = fast::max(float3(0.0), _608);
    }
    else
    {
        _610 = float3(0.0);
    }
    float3 _613 = _610 * View.View_IndirectLightingColorScale;
    float3 _635 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _664;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _663;
        if (any(abs(_242 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _375 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _375 + 19u)].xyz + float3(1.0))))
        {
            _663 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_242, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _663 = _635;
        }
        _664 = _663;
    }
    else
    {
        _664 = _635;
    }
    float4 _671 = float4(((mix(float3(0.0), _520 + (_522 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_613 * _520) * fast::max(float3(1.0), ((((((_427 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_427 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_427 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _664) * 1.0, 0.0);
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
    float3 _690 = (_428 * 0.5) + float3(0.5);
    float4 _692 = float4(_690.x, _690.y, _690.z, float4(0.0).w);
    _692.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _376)].y;
    float4 _693 = float4(0.0);
    _693.x = _426;
    float4 _694 = _693;
    _694.y = _425;
    float4 _695 = _694;
    _695.z = _424;
    float4 _696 = _695;
    _696.w = 0.50588238239288330078125;
    float4 _708 = float4(_427.x, _427.y, _427.z, float4(0.0).w);
    _708.w = ((log2(((dot(_613, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_524 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_524 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_524 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_682.xyx * _682.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _678 * View.View_PreExposure;
    out.out_var_SV_Target1 = _692;
    out.out_var_SV_Target2 = _696;
    out.out_var_SV_Target3 = _708;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_491, 1.0, 1.0, 1.0);
    return out;
}

