

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

constant float4 _169 = {};
constant float4 _171 = {};

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

fragment MainPS_out Main_00004407_e209a33d(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _228 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _232 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _237 = (_232.xyz / float3(_232.w)) - View.View_PreViewTranslation;
    float4 _243 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _246 = (_243.xy * float2(2.0)) - float2(1.0);
    float4 _258 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _285;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _285 = _228.w;
                break;
            }
            else
            {
                float _269 = _228.z;
                _285 = ((_269 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_269 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _301 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(float4(_246, sqrt(fast::clamp(1.0 - dot(_246, _246), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _258.x) + _285) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _313 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _318 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _323 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _327 = (_313.x + 0.5) * ((_318.x + 0.5) * (_323.x + 0.5));
    float4 _333 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _339 = fast::clamp(mix(float3(0.300000011920928955078125), float3(1.0), float3(_327)) * _333.xyz, float3(0.0), float3(1.0));
    float _344 = (fast::clamp(mix(0.5, 0.20000000298023223876953125, _327 * _333.w), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _345 = in.in_var_PRIMITIVE_ID * 36u;
    uint _346 = _345 + 20u;
    float _394;
    float _395;
    float _396;
    float3 _397;
    float3 _398;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _346)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _364 = ((_228.xy / float2(_228.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _368 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _364, level(0.0));
        float4 _371 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _364, level(0.0));
        float4 _374 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _364, level(0.0));
        float _384 = _374.w;
        _394 = (_344 * _384) + _374.z;
        _395 = (0.5 * _384) + _374.y;
        _396 = _374.x;
        _397 = (_339 * _368.w) + _368.xyz;
        _398 = normalize((_301 * _371.w) + ((_371.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _394 = _344;
        _395 = 0.5;
        _396 = 0.0;
        _397 = _339;
        _398 = _301;
    }
    bool _408 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _414;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _345 + 18u)].w > 0.0) && _408)
    {
        _414 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _414 = 1.0;
    }
    float _461;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _346)].z > 0.0)
    {
        float3 _429 = fast::clamp((_237 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _440 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_429.x), int(_429.y), int(_429.z), 0).xyz), 0));
        _461 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_440.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_429 / float3(_440.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _461 = _414;
    }
    float3 _475 = ((_397 - (_397 * _396)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _482 = (mix(float3(0.07999999821186065673828125 * _395), _397, float3(_396)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _485 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _490;
    if (_485)
    {
        _490 = _475 + (_482 * 0.449999988079071044921875);
    }
    else
    {
        _490 = _475;
    }
    float3 _492 = select(_482, float3(0.0), bool3(_485));
    float3 _494 = float3(dot(_492, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _580;
    if (_408)
    {
        float4 _530 = _171;
        _530.y = (-0.48860299587249755859375) * _398.y;
        float4 _533 = _530;
        _533.z = 0.48860299587249755859375 * _398.z;
        float4 _536 = _533;
        _536.w = (-0.48860299587249755859375) * _398.x;
        float3 _537 = _398 * _398;
        float4 _540 = _169;
        _540.x = (1.09254801273345947265625 * _398.x) * _398.y;
        float4 _543 = _540;
        _543.y = ((-1.09254801273345947265625) * _398.y) * _398.z;
        float4 _548 = _543;
        _548.z = 0.3153919875621795654296875 * ((3.0 * _537.z) - 1.0);
        float4 _551 = _548;
        _551.w = ((-1.09254801273345947265625) * _398.x) * _398.z;
        float4 _555 = _536;
        _555.x = 0.886227548122406005859375;
        float3 _557 = _555.yzw * 2.094395160675048828125;
        float4 _558 = float4(_555.x, _557.x, _557.y, _557.z);
        float4 _559 = _551 * 0.785398185253143310546875;
        float _560 = (_537.x - _537.y) * 0.4290426075458526611328125;
        float3 _566 = float3(0.0);
        _566.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _558) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _559)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _560);
        float3 _572 = _566;
        _572.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _558) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _559)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _560);
        float3 _578 = _572;
        _578.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _558) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _559)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _560);
        _580 = fast::max(float3(0.0), _578);
    }
    else
    {
        _580 = float3(0.0);
    }
    float3 _583 = _580 * View.View_IndirectLightingColorScale;
    float3 _605 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _634;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _633;
        if (any(abs(_237 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _345 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _345 + 19u)].xyz + float3(1.0))))
        {
            _633 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_237, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _633 = _605;
        }
        _634 = _633;
    }
    else
    {
        _634 = _605;
    }
    float4 _641 = float4(((mix(float3(0.0), _490 + (_492 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_583 * _490) * fast::max(float3(1.0), ((((((_397 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_397 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_397 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _634) * 1.0, 0.0);
    float4 _648;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _647 = _641;
        _647.w = 0.0;
        _648 = _647;
    }
    else
    {
        _648 = _641;
    }
    float2 _652 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _660 = (_398 * 0.5) + float3(0.5);
    float4 _662 = float4(_660.x, _660.y, _660.z, float4(0.0).w);
    _662.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _346)].y;
    float4 _663 = float4(0.0);
    _663.x = _396;
    float4 _664 = _663;
    _664.y = _395;
    float4 _665 = _664;
    _665.z = _394;
    float4 _666 = _665;
    _666.w = 0.50588238239288330078125;
    float4 _678 = float4(_397.x, _397.y, _397.z, float4(0.0).w);
    _678.w = ((log2(((dot(_583, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_494 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_494 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_494 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_652.xyx * _652.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _648 * View.View_PreExposure;
    out.out_var_SV_Target1 = _662;
    out.out_var_SV_Target2 = _666;
    out.out_var_SV_Target3 = _678;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_461, 1.0, 1.0, 1.0);
    return out;
}

