

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
    char _m17_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m19_pad[124];
    float View_ShowDecalsMask;
    char _m20_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m21_pad[48];
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
    char _m0_pad[64];
    float4 IndirectLightingCache_PointSkyBentNormal;
    float IndirectLightingCache_DirectionalLightShadowing;
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients0;
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients1;
    float4 IndirectLightingCache_IndirectLightingSHCoefficients2;
};

struct type_Material
{
    spvUnsafeArray<float4, 6> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _174 = {};
constant float3 _175 = {};
constant float4 _177 = {};

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

fragment MainPS_out Main_00004cd8_c6b85435(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _237 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _241 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _246 = (_241.xyz / float3(_241.w)) - View.View_PreViewTranslation;
    float4 _253 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 10.0), bias(View.View_MaterialTextureMipBias));
    float2 _256 = (_253.xy * float2(2.0)) - float2(1.0);
    float4 _269 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _272 = (_269.xy * float2(2.0)) - float2(1.0);
    float _306;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _306 = _237.w;
                break;
            }
            else
            {
                float _290 = _237.z;
                _306 = ((_290 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_290 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _310 = fast::min(fast::max((_306 - 24.0) * 0.00022222222469281405210494995117188, 0.0), 1.0);
    float3 _321 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((((float4(_256, sqrt(fast::clamp(1.0 - dot(_256, _256), 0.0, 1.0)), 1.0).xyz * float3(0.5, 0.5, 1.0)) + mix(float4(_272, sqrt(fast::clamp(1.0 - dot(_272, _272), 0.0, 1.0)), 1.0).xyz * float3(0.25, 0.25, 1.0), float3(0.0, 0.0, 1.0), float3(_310))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _333 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 5.0), bias(View.View_MaterialTextureMipBias));
    float _335 = mix(0.4000000059604644775390625, 1.0, _333.x);
    float _338 = mix(0.699999988079071044921875, 0.89999997615814208984375, _333.y);
    float4 _343 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _358 = fast::clamp(mix(Material.Material_VectorExpressions[4].xyz, Material.Material_VectorExpressions[5].xyz, float3(fast::min(fast::max(_343.y + _310, 0.0), 1.0))) * mix(_335, 1.0 - _335, _338), float3(0.0), float3(1.0));
    float _363 = (fast::clamp(_335 * _338, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _364 = in.in_var_PRIMITIVE_ID * 36u;
    uint _365 = _364 + 20u;
    float _413;
    float _414;
    float _415;
    float3 _416;
    float3 _417;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _365)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _383 = ((_237.xy / float2(_237.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _387 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _383, level(0.0));
        float4 _390 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _383, level(0.0));
        float4 _393 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _383, level(0.0));
        float _403 = _393.w;
        _413 = (_363 * _403) + _393.z;
        _414 = (0.5 * _403) + _393.y;
        _415 = _393.x;
        _416 = (_358 * _387.w) + _387.xyz;
        _417 = normalize((_321 * _390.w) + ((_390.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _413 = _363;
        _414 = 0.5;
        _415 = 0.0;
        _416 = _358;
        _417 = _321;
    }
    bool _427 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _433;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _364 + 18u)].w > 0.0) && _427)
    {
        _433 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _433 = 1.0;
    }
    float _480;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _365)].z > 0.0)
    {
        float3 _448 = fast::clamp((_246 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _459 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_448.x), int(_448.y), int(_448.z), 0).xyz), 0));
        _480 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_459.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_448 / float3(_459.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _480 = _433;
    }
    float3 _494 = ((_416 - (_416 * _415)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _501 = (mix(float3(0.07999999821186065673828125 * _414), _416, float3(_415)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _504 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _509;
    if (_504)
    {
        _509 = _494 + (_501 * 0.449999988079071044921875);
    }
    else
    {
        _509 = _494;
    }
    float3 _511 = select(_501, float3(0.0), bool3(_504));
    float3 _513 = float3(dot(_511, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _599;
    if (_427)
    {
        float4 _549 = _177;
        _549.y = (-0.48860299587249755859375) * _417.y;
        float4 _552 = _549;
        _552.z = 0.48860299587249755859375 * _417.z;
        float4 _555 = _552;
        _555.w = (-0.48860299587249755859375) * _417.x;
        float3 _556 = _417 * _417;
        float4 _559 = _174;
        _559.x = (1.09254801273345947265625 * _417.x) * _417.y;
        float4 _562 = _559;
        _562.y = ((-1.09254801273345947265625) * _417.y) * _417.z;
        float4 _567 = _562;
        _567.z = 0.3153919875621795654296875 * ((3.0 * _556.z) - 1.0);
        float4 _570 = _567;
        _570.w = ((-1.09254801273345947265625) * _417.x) * _417.z;
        float4 _574 = _555;
        _574.x = 0.886227548122406005859375;
        float3 _576 = _574.yzw * 2.094395160675048828125;
        float4 _577 = float4(_574.x, _576.x, _576.y, _576.z);
        float4 _578 = _570 * 0.785398185253143310546875;
        float _579 = (_556.x - _556.y) * 0.4290426075458526611328125;
        float3 _585 = float3(0.0);
        _585.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _577) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _578)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _579);
        float3 _591 = _585;
        _591.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _577) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _578)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _579);
        float3 _597 = _591;
        _597.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _577) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _578)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _579);
        _599 = fast::max(float3(0.0), _597);
    }
    else
    {
        _599 = float3(0.0);
    }
    float _625;
    float _626;
    float3 _627;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _615;
        float _616;
        if (_427)
        {
            _615 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _616 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _615 = _417;
            _616 = 1.0;
        }
        float _617 = 1.0 - _616;
        float _619 = 1.0 - (_617 * _617);
        _625 = mix(fast::clamp(dot(_615, _417), 0.0, 1.0), 1.0, _619);
        _626 = _616;
        _627 = mix(_615, _417, float3(_619));
    }
    else
    {
        _625 = 1.0;
        _626 = 1.0;
        _627 = _417;
    }
    float4 _631 = float4(_627, 1.0);
    float3 _635 = _175;
    _635.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _631);
    float3 _639 = _635;
    _639.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _631);
    float3 _643 = _639;
    _643.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _631);
    float4 _646 = _631.xyzz * _631.yzzx;
    float3 _650 = _175;
    _650.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _646);
    float3 _654 = _650;
    _654.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _646);
    float3 _658 = _654;
    _658.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _646);
    float3 _673 = (_599 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_643 + _658) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_627.x * _627.x) - (_627.y * _627.y)))) * View.View_SkyLightColor.xyz) * (_626 * _625));
    float3 _695 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _724;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _723;
        if (any(abs(_246 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _364 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _364 + 19u)].xyz + float3(1.0))))
        {
            _723 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_246, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _723 = _695;
        }
        _724 = _723;
    }
    else
    {
        _724 = _695;
    }
    float4 _731 = float4(((mix(float3(0.0), _509 + (_511 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_673 * _509) * fast::max(float3(1.0), ((((((_416 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_416 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_416 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _724) * 1.0, 0.0);
    float4 _738;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _737 = _731;
        _737.w = 0.0;
        _738 = _737;
    }
    else
    {
        _738 = _731;
    }
    float2 _742 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _750 = (_417 * 0.5) + float3(0.5);
    float4 _752 = float4(_750.x, _750.y, _750.z, float4(0.0).w);
    _752.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _365)].y;
    float4 _753 = float4(0.0);
    _753.x = _415;
    float4 _754 = _753;
    _754.y = _414;
    float4 _755 = _754;
    _755.z = _413;
    float4 _756 = _755;
    _756.w = 0.50588238239288330078125;
    float4 _768 = float4(_416.x, _416.y, _416.z, float4(0.0).w);
    _768.w = ((log2(((dot(_673, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_513 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_513 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_513 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_742.xyx * _742.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _738 * View.View_PreExposure;
    out.out_var_SV_Target1 = _752;
    out.out_var_SV_Target2 = _756;
    out.out_var_SV_Target3 = _768;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_480, 1.0, 1.0, 1.0);
    return out;
}

