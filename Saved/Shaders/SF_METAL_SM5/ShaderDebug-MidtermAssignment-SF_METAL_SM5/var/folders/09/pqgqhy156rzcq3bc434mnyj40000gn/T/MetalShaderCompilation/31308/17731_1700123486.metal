

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

fragment MainPS_out Main_00004543_6555d35e(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
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
    float2 _256 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125;
    float4 _260 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _256, bias(View.View_MaterialTextureMipBias));
    float _287;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _287 = _228.w;
                break;
            }
            else
            {
                float _271 = _228.z;
                _287 = ((_271 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_271 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _293 = float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _260.x) + _287) - 150.0) * 0.0005000000237487256526947021484375, 0.0), 1.0));
    float3 _302 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(float3(0.5, 0.5, 1.0) * float4(_246, sqrt(fast::clamp(1.0 - dot(_246, _246), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), _293) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _314 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _317 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _326 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.449999988079071044921875), bias(View.View_MaterialTextureMipBias));
    float _327 = _326.x;
    float _331 = _326.y;
    float _335 = _326.z;
    float4 _341 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _256, bias(View.View_MaterialTextureMipBias));
    float _342 = _341.x;
    float _346 = _341.y;
    float _350 = _341.z;
    float3 _358 = fast::min(fast::max(mix(float3((_327 <= 0.0) ? 0.0 : pow(_327, 2.0), (_331 <= 0.0) ? 0.0 : pow(_331, 2.0), (_335 <= 0.0) ? 0.0 : pow(_335, 2.0)), float3((_342 <= 0.0) ? 0.0 : pow(_342, 2.0), (_346 <= 0.0) ? 0.0 : pow(_346, 2.0), (_350 <= 0.0) ? 0.0 : pow(_350, 2.0)), _293) * fast::min(fast::max(1.0 - (_314.x * _317.x), 0.0), 1.0), float3(0.0)), float3(1.0));
    float3 _363 = fast::clamp(mix(_358, float3(dot(_358, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375))), float3(0.4000000059604644775390625)) * 0.699999988079071044921875, float3(0.0), float3(1.0));
    uint _365 = in.in_var_PRIMITIVE_ID * 36u;
    uint _366 = _365 + 20u;
    float _414;
    float _415;
    float _416;
    float3 _417;
    float3 _418;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _366)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _384 = ((_228.xy / float2(_228.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _388 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _384, level(0.0));
        float4 _391 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _384, level(0.0));
        float4 _394 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _384, level(0.0));
        float _404 = _394.w;
        _414 = (View.View_RoughnessOverrideParameter.x * _404) + _394.z;
        _415 = (0.5 * _404) + _394.y;
        _416 = _394.x;
        _417 = (_363 * _388.w) + _388.xyz;
        _418 = normalize((_302 * _391.w) + ((_391.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _414 = View.View_RoughnessOverrideParameter.x;
        _415 = 0.5;
        _416 = 0.0;
        _417 = _363;
        _418 = _302;
    }
    bool _428 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _434;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _365 + 18u)].w > 0.0) && _428)
    {
        _434 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _434 = 1.0;
    }
    float _481;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _366)].z > 0.0)
    {
        float3 _449 = fast::clamp((_237 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _460 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_449.x), int(_449.y), int(_449.z), 0).xyz), 0));
        _481 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_460.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_449 / float3(_460.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _481 = _434;
    }
    float3 _495 = ((_417 - (_417 * _416)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _502 = (mix(float3(0.07999999821186065673828125 * _415), _417, float3(_416)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _505 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _510;
    if (_505)
    {
        _510 = _495 + (_502 * 0.449999988079071044921875);
    }
    else
    {
        _510 = _495;
    }
    float3 _512 = select(_502, float3(0.0), bool3(_505));
    float3 _514 = float3(dot(_512, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _600;
    if (_428)
    {
        float4 _550 = _171;
        _550.y = (-0.48860299587249755859375) * _418.y;
        float4 _553 = _550;
        _553.z = 0.48860299587249755859375 * _418.z;
        float4 _556 = _553;
        _556.w = (-0.48860299587249755859375) * _418.x;
        float3 _557 = _418 * _418;
        float4 _560 = _169;
        _560.x = (1.09254801273345947265625 * _418.x) * _418.y;
        float4 _563 = _560;
        _563.y = ((-1.09254801273345947265625) * _418.y) * _418.z;
        float4 _568 = _563;
        _568.z = 0.3153919875621795654296875 * ((3.0 * _557.z) - 1.0);
        float4 _571 = _568;
        _571.w = ((-1.09254801273345947265625) * _418.x) * _418.z;
        float4 _575 = _556;
        _575.x = 0.886227548122406005859375;
        float3 _577 = _575.yzw * 2.094395160675048828125;
        float4 _578 = float4(_575.x, _577.x, _577.y, _577.z);
        float4 _579 = _571 * 0.785398185253143310546875;
        float _580 = (_557.x - _557.y) * 0.4290426075458526611328125;
        float3 _586 = float3(0.0);
        _586.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _578) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _579)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _580);
        float3 _592 = _586;
        _592.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _578) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _579)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _580);
        float3 _598 = _592;
        _598.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _578) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _579)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _580);
        _600 = fast::max(float3(0.0), _598);
    }
    else
    {
        _600 = float3(0.0);
    }
    float3 _603 = _600 * View.View_IndirectLightingColorScale;
    float3 _625 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _654;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _653;
        if (any(abs(_237 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _365 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _365 + 19u)].xyz + float3(1.0))))
        {
            _653 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_237, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _653 = _625;
        }
        _654 = _653;
    }
    else
    {
        _654 = _625;
    }
    float4 _661 = float4(((mix(float3(0.0), _510 + (_512 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_603 * _510) * fast::max(float3(1.0), ((((((_417 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_417 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_417 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _654) * 1.0, 0.0);
    float4 _668;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _667 = _661;
        _667.w = 0.0;
        _668 = _667;
    }
    else
    {
        _668 = _661;
    }
    float2 _672 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _680 = (_418 * 0.5) + float3(0.5);
    float4 _682 = float4(_680.x, _680.y, _680.z, float4(0.0).w);
    _682.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _366)].y;
    float4 _683 = float4(0.0);
    _683.x = _416;
    float4 _684 = _683;
    _684.y = _415;
    float4 _685 = _684;
    _685.z = _414;
    float4 _686 = _685;
    _686.w = 0.50588238239288330078125;
    float4 _698 = float4(_417.x, _417.y, _417.z, float4(0.0).w);
    _698.w = ((log2(((dot(_603, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_514 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_514 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_514 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_672.xyx * _672.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _668 * View.View_PreExposure;
    out.out_var_SV_Target1 = _682;
    out.out_var_SV_Target2 = _686;
    out.out_var_SV_Target3 = _698;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_481, 1.0, 1.0, 1.0);
    return out;
}

