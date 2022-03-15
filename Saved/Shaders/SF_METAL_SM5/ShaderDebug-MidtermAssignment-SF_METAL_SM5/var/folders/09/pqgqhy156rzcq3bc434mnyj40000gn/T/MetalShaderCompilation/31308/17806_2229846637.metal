

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

constant float4 _171 = {};
constant float4 _173 = {};

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

fragment MainPS_out Main_0000458e_84e8c26d(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _230 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _234 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _239 = (_234.xyz / float3(_234.w)) - View.View_PreViewTranslation;
    float2 _240 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.300000011920928955078125;
    float4 _246 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _240, bias(View.View_MaterialTextureMipBias));
    float2 _249 = (_246.xy * float2(2.0)) - float2(1.0);
    float2 _257 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.20000000298023223876953125;
    float4 _259 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _257, bias(View.View_MaterialTextureMipBias));
    float2 _262 = (_259.xy * float2(2.0)) - float2(1.0);
    float4 _274 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.008000000379979610443115234375), bias(View.View_MaterialTextureMipBias));
    float4 _279 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.004999999888241291046142578125), bias(View.View_MaterialTextureMipBias));
    float _281 = (_274.x + 0.5) * _279.x;
    float _283 = fast::min(fast::max(_281, 0.0), 1.0);
    float3 _286 = float3(_283);
    float4 _292 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _319;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _319 = _230.w;
                break;
            }
            else
            {
                float _303 = _230.z;
                _319 = ((_303 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_303 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _334 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(mix(float4(_249, sqrt(fast::clamp(1.0 - dot(_249, _249), 0.0, 1.0)), 1.0).xyz, float4(_262, sqrt(fast::clamp(1.0 - dot(_262, _262), 0.0, 1.0)), 1.0).xyz, _286), float3(0.0, 0.0, 1.0), float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _292.x) + _319) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _346 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _240, bias(View.View_MaterialTextureMipBias));
    float4 _348 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _257, bias(View.View_MaterialTextureMipBias));
    float3 _358 = fast::clamp(mix(_346.xyz, _348.xyz, _286) * mix(0.60000002384185791015625, 1.0, _281), float3(0.0), float3(1.0));
    float _363 = (fast::clamp(mix(0.949999988079071044921875, 0.699999988079071044921875, _281 * mix(_346.w, _348.w, _283)), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _364 = in.in_var_PRIMITIVE_ID * 36u;
    uint _365 = _364 + 20u;
    float _413;
    float _414;
    float _415;
    float3 _416;
    float3 _417;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _365)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _383 = ((_230.xy / float2(_230.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _387 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _383, level(0.0));
        float4 _390 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _383, level(0.0));
        float4 _393 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _383, level(0.0));
        float _403 = _393.w;
        _413 = (_363 * _403) + _393.z;
        _414 = (0.5 * _403) + _393.y;
        _415 = _393.x;
        _416 = (_358 * _387.w) + _387.xyz;
        _417 = normalize((_334 * _390.w) + ((_390.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _413 = _363;
        _414 = 0.5;
        _415 = 0.0;
        _416 = _358;
        _417 = _334;
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
        float3 _448 = fast::clamp((_239 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
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
        float4 _549 = _173;
        _549.y = (-0.48860299587249755859375) * _417.y;
        float4 _552 = _549;
        _552.z = 0.48860299587249755859375 * _417.z;
        float4 _555 = _552;
        _555.w = (-0.48860299587249755859375) * _417.x;
        float3 _556 = _417 * _417;
        float4 _559 = _171;
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
    float3 _602 = _599 * View.View_IndirectLightingColorScale;
    float3 _624 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _653;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _652;
        if (any(abs(_239 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _364 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _364 + 19u)].xyz + float3(1.0))))
        {
            _652 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_239, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _652 = _624;
        }
        _653 = _652;
    }
    else
    {
        _653 = _624;
    }
    float4 _660 = float4(((mix(float3(0.0), _509 + (_511 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_602 * _509) * fast::max(float3(1.0), ((((((_416 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_416 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_416 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _653) * 1.0, 0.0);
    float4 _667;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _666 = _660;
        _666.w = 0.0;
        _667 = _666;
    }
    else
    {
        _667 = _660;
    }
    float2 _671 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _679 = (_417 * 0.5) + float3(0.5);
    float4 _681 = float4(_679.x, _679.y, _679.z, float4(0.0).w);
    _681.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _365)].y;
    float4 _682 = float4(0.0);
    _682.x = _415;
    float4 _683 = _682;
    _683.y = _414;
    float4 _684 = _683;
    _684.z = _413;
    float4 _685 = _684;
    _685.w = 0.50588238239288330078125;
    float4 _697 = float4(_416.x, _416.y, _416.z, float4(0.0).w);
    _697.w = ((log2(((dot(_602, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_513 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_513 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_513 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_671.xyx * _671.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _667 * View.View_PreExposure;
    out.out_var_SV_Target1 = _681;
    out.out_var_SV_Target2 = _685;
    out.out_var_SV_Target3 = _697;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_480, 1.0, 1.0, 1.0);
    return out;
}

