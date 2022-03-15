

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
    spvUnsafeArray<float4, 6> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _181 = {};
constant float4 _183 = {};

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

fragment MainPS_out Main_000047ee_751f67bb(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _240 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _244 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _249 = (_244.xyz / float3(_244.w)) - View.View_PreViewTranslation;
    float2 _256 = float2(View.View_GameTime * (-0.02999999932944774627685546875), View.View_GameTime * (-0.0199999995529651641845703125)) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(0.0500000007450580596923828125, 0.07999999821186065673828125));
    float4 _262 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _256, bias(View.View_MaterialTextureMipBias));
    float2 _265 = (_262.xy * float2(2.0)) - float2(1.0);
    float _272 = sqrt(fast::clamp(1.0 - dot(_265, _265), 0.0, 1.0)) + 1.0;
    float _280 = sin(((_249.x * 0.006666666828095912933349609375) + (View.View_GameTime * Material.Material_ScalarExpressions[0].x)) * 1.256637096405029296875);
    float4 _287 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(_280 * (-0.0599999986588954925537109375), _280 * (-0.039999999105930328369140625)) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(0.180000007152557373046875, 0.1500000059604644775390625))), bias(View.View_MaterialTextureMipBias));
    float2 _290 = (_287.xy * float2(2.0)) - float2(1.0);
    float3 _299 = float4(_290, sqrt(fast::clamp(1.0 - dot(_290, _290), 0.0, 1.0)), 1.0).xyz * float3(-1.0, -1.0, 1.0);
    float3 _302 = float3(_265, _272);
    float3 _306 = float3(_299.xy * (-1.0), _299.z);
    float3 _310 = (_302 * dot(_302, _306)) - (_306 * _272);
    float _312 = _310.z + 1.0;
    float2 _316 = float2(View.View_GameTime * (-0.070000000298023223876953125)) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.75);
    float4 _318 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _316, bias(View.View_MaterialTextureMipBias));
    float2 _321 = (_318.xy * float2(2.0)) - float2(1.0);
    float4 _333 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _360;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _360 = _240.w;
                break;
            }
            else
            {
                float _344 = _240.z;
                _360 = ((_344 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_344 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _367 = float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _333.x) + _360) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0));
    float3 _368 = mix(float4(_321, sqrt(fast::clamp(1.0 - dot(_321, _321), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), _367);
    float3 _373 = float3(_310.xy, _312);
    float3 _377 = float3(_368.xy * (-1.0), _368.z);
    float3 _389 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((((_373 * dot(_373, _377)) - (_377 * _312)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _400 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _316, bias(View.View_MaterialTextureMipBias));
    float4 _402 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _256, bias(View.View_MaterialTextureMipBias));
    float3 _417 = fast::clamp(mix(mix(Material.Material_VectorExpressions[4].xyz, Material.Material_VectorExpressions[5].xyz, float3(fast::min(fast::max(_400.x * _402.x, 0.0), 1.0))), Material.Material_VectorExpressions[4].xyz, _367), float3(0.0), float3(1.0));
    float _421 = (0.100000001490116119384765625 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _422 = in.in_var_PRIMITIVE_ID * 36u;
    uint _423 = _422 + 20u;
    float _471;
    float _472;
    float _473;
    float3 _474;
    float3 _475;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _423)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _441 = ((_240.xy / float2(_240.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _445 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _441, level(0.0));
        float4 _448 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _441, level(0.0));
        float4 _451 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _441, level(0.0));
        float _461 = _451.w;
        _471 = (_421 * _461) + _451.z;
        _472 = (0.5 * _461) + _451.y;
        _473 = _451.x;
        _474 = (_417 * _445.w) + _445.xyz;
        _475 = normalize((_389 * _448.w) + ((_448.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _471 = _421;
        _472 = 0.5;
        _473 = 0.0;
        _474 = _417;
        _475 = _389;
    }
    bool _485 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _491;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _422 + 18u)].w > 0.0) && _485)
    {
        _491 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _491 = 1.0;
    }
    float _538;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _423)].z > 0.0)
    {
        float3 _506 = fast::clamp((_249 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _517 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_506.x), int(_506.y), int(_506.z), 0).xyz), 0));
        _538 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_517.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_506 / float3(_517.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _538 = _491;
    }
    float3 _552 = ((_474 - (_474 * _473)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _559 = (mix(float3(0.07999999821186065673828125 * _472), _474, float3(_473)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _562 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _567;
    if (_562)
    {
        _567 = _552 + (_559 * 0.449999988079071044921875);
    }
    else
    {
        _567 = _552;
    }
    float3 _569 = select(_559, float3(0.0), bool3(_562));
    float3 _571 = float3(dot(_569, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _657;
    if (_485)
    {
        float4 _607 = _183;
        _607.y = (-0.48860299587249755859375) * _475.y;
        float4 _610 = _607;
        _610.z = 0.48860299587249755859375 * _475.z;
        float4 _613 = _610;
        _613.w = (-0.48860299587249755859375) * _475.x;
        float3 _614 = _475 * _475;
        float4 _617 = _181;
        _617.x = (1.09254801273345947265625 * _475.x) * _475.y;
        float4 _620 = _617;
        _620.y = ((-1.09254801273345947265625) * _475.y) * _475.z;
        float4 _625 = _620;
        _625.z = 0.3153919875621795654296875 * ((3.0 * _614.z) - 1.0);
        float4 _628 = _625;
        _628.w = ((-1.09254801273345947265625) * _475.x) * _475.z;
        float4 _632 = _613;
        _632.x = 0.886227548122406005859375;
        float3 _634 = _632.yzw * 2.094395160675048828125;
        float4 _635 = float4(_632.x, _634.x, _634.y, _634.z);
        float4 _636 = _628 * 0.785398185253143310546875;
        float _637 = (_614.x - _614.y) * 0.4290426075458526611328125;
        float3 _643 = float3(0.0);
        _643.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _635) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _636)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _637);
        float3 _649 = _643;
        _649.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _635) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _636)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _637);
        float3 _655 = _649;
        _655.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _635) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _636)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _637);
        _657 = fast::max(float3(0.0), _655);
    }
    else
    {
        _657 = float3(0.0);
    }
    float3 _660 = _657 * View.View_IndirectLightingColorScale;
    float3 _682 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].y)), float3(0.0));
    float3 _711;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _710;
        if (any(abs(_249 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _422 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _422 + 19u)].xyz + float3(1.0))))
        {
            _710 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_249, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _710 = _682;
        }
        _711 = _710;
    }
    else
    {
        _711 = _682;
    }
    float4 _718 = float4(((mix(float3(0.0), _567 + (_569 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_660 * _567) * fast::max(float3(1.0), ((((((_474 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_474 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_474 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _711) * 1.0, 0.0);
    float4 _725;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _724 = _718;
        _724.w = 0.0;
        _725 = _724;
    }
    else
    {
        _725 = _718;
    }
    float2 _729 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _737 = (_475 * 0.5) + float3(0.5);
    float4 _739 = float4(_737.x, _737.y, _737.z, float4(0.0).w);
    _739.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _423)].y;
    float4 _740 = float4(0.0);
    _740.x = _473;
    float4 _741 = _740;
    _741.y = _472;
    float4 _742 = _741;
    _742.z = _471;
    float4 _743 = _742;
    _743.w = 0.50588238239288330078125;
    float4 _755 = float4(_474.x, _474.y, _474.z, float4(0.0).w);
    _755.w = ((log2(((dot(_660, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_571 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_571 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_571 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_729.xyx * _729.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _725 * View.View_PreExposure;
    out.out_var_SV_Target1 = _739;
    out.out_var_SV_Target2 = _743;
    out.out_var_SV_Target3 = _755;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_538, 1.0, 1.0, 1.0);
    return out;
}

