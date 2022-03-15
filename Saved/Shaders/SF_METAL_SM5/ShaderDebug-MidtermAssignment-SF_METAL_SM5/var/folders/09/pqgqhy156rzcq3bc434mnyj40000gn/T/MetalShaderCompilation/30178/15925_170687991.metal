

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

struct type_Primitive
{
    char _m0_pad[80];
    float4 Primitive_ObjectWorldPositionAndRadius;
    char _m1_pad[204];
    float Primitive_UseSingleSampleShadowFromStationaryLights;
    float3 Primitive_ObjectBounds;
    float Primitive_DecalReceiverMask;
    float Primitive_PerObjectGBufferData;
    float Primitive_UseVolumetricLightmapShadowFromStationaryLights;
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

constant float4 _160 = {};
constant float4 _162 = {};

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
    float2 in_var_TEXCOORD0 [[user(locn0)]];
};

fragment MainPS_out Main_00003e35_0a2c7df7(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    float4 _211 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _215 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _220 = (_215.xyz / float3(_215.w)) - View.View_PreViewTranslation;
    float4 _228 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (in.in_var_TEXCOORD0 * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _231 = (_228.xy * float2(2.0)) - float2(1.0);
    float3 _248 = normalize(float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0)) * normalize(((float4(_231, sqrt(fast::clamp(1.0 - dot(_231, _231), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _260 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in.in_var_TEXCOORD0 * 20.0), bias(View.View_MaterialTextureMipBias));
    float _262 = mix(0.4000000059604644775390625, 1.0, _260.x);
    float4 _266 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in.in_var_TEXCOORD0 * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _291;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _291 = _211.w;
                break;
            }
            else
            {
                float _275 = _211.z;
                _291 = ((_275 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_275 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _295 = fast::min(fast::max((_291 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _296 = _266.y;
    float4 _300 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in.in_var_TEXCOORD0 * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _302 = _300.y;
    float3 _315 = fast::clamp(float3(mix(_262, 1.0 - _262, mix(_296, 1.0, _295)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_302 + mix(_296, 0.0, _295), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _320 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _302) + mix(mix(0.699999988079071044921875, 1.0, _296), 1.0, _295), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _367;
    float _368;
    float _369;
    float3 _370;
    float3 _371;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _337 = ((_211.xy / float2(_211.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _341 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _337, level(0.0));
        float4 _344 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _337, level(0.0));
        float4 _347 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _337, level(0.0));
        float _357 = _347.w;
        _367 = (_320 * _357) + _347.z;
        _368 = (0.5 * _357) + _347.y;
        _369 = _347.x;
        _370 = (_315 * _341.w) + _341.xyz;
        _371 = normalize((_248 * _344.w) + ((_344.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _367 = _320;
        _368 = 0.5;
        _369 = 0.0;
        _370 = _315;
        _371 = _248;
    }
    bool _379 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _385;
    if ((Primitive.Primitive_UseSingleSampleShadowFromStationaryLights > 0.0) && _379)
    {
        _385 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _385 = 1.0;
    }
    float _432;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _400 = fast::clamp((_220 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _411 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_400.x), int(_400.y), int(_400.z), 0).xyz), 0));
        _432 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_411.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_400 / float3(_411.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _432 = _385;
    }
    float3 _446 = ((_370 - (_370 * _369)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _453 = (mix(float3(0.07999999821186065673828125 * _368), _370, float3(_369)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _456 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _461;
    if (_456)
    {
        _461 = _446 + (_453 * 0.449999988079071044921875);
    }
    else
    {
        _461 = _446;
    }
    float3 _463 = select(_453, float3(0.0), bool3(_456));
    float3 _465 = float3(dot(_463, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _551;
    if (_379)
    {
        float4 _501 = _162;
        _501.y = (-0.48860299587249755859375) * _371.y;
        float4 _504 = _501;
        _504.z = 0.48860299587249755859375 * _371.z;
        float4 _507 = _504;
        _507.w = (-0.48860299587249755859375) * _371.x;
        float3 _508 = _371 * _371;
        float4 _511 = _160;
        _511.x = (1.09254801273345947265625 * _371.x) * _371.y;
        float4 _514 = _511;
        _514.y = ((-1.09254801273345947265625) * _371.y) * _371.z;
        float4 _519 = _514;
        _519.z = 0.3153919875621795654296875 * ((3.0 * _508.z) - 1.0);
        float4 _522 = _519;
        _522.w = ((-1.09254801273345947265625) * _371.x) * _371.z;
        float4 _526 = _507;
        _526.x = 0.886227548122406005859375;
        float3 _528 = _526.yzw * 2.094395160675048828125;
        float4 _529 = float4(_526.x, _528.x, _528.y, _528.z);
        float4 _530 = _522 * 0.785398185253143310546875;
        float _531 = (_508.x - _508.y) * 0.4290426075458526611328125;
        float3 _537 = float3(0.0);
        _537.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _529) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _530)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _531);
        float3 _543 = _537;
        _543.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _529) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _530)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _531);
        float3 _549 = _543;
        _549.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _529) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _530)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _531);
        _551 = fast::max(float3(0.0), _549);
    }
    else
    {
        _551 = float3(0.0);
    }
    float3 _554 = _551 * View.View_IndirectLightingColorScale;
    float3 _576 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _602;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _601;
        if (any(abs(_220 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _601 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_220, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _601 = _576;
        }
        _602 = _601;
    }
    else
    {
        _602 = _576;
    }
    float4 _609 = float4(((mix(float3(0.0), _461 + (_463 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_554 * _461) * fast::max(float3(1.0), ((((((_370 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_370 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_370 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _602) * 1.0, 0.0);
    float4 _616;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _615 = _609;
        _615.w = 0.0;
        _616 = _615;
    }
    else
    {
        _616 = _609;
    }
    float2 _620 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _628 = (_371 * 0.5) + float3(0.5);
    float4 _630 = float4(_628.x, _628.y, _628.z, float4(0.0).w);
    _630.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _631 = float4(0.0);
    _631.x = _369;
    float4 _632 = _631;
    _632.y = _368;
    float4 _633 = _632;
    _633.z = _367;
    float4 _634 = _633;
    _634.w = 0.50588238239288330078125;
    float4 _646 = float4(_370.x, _370.y, _370.z, float4(0.0).w);
    _646.w = ((log2(((dot(_554, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_465 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_465 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_465 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_620.xyx * _620.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _616 * View.View_PreExposure;
    out.out_var_SV_Target1 = _630;
    out.out_var_SV_Target2 = _634;
    out.out_var_SV_Target3 = _646;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_432, 1.0, 1.0, 1.0);
    return out;
}

