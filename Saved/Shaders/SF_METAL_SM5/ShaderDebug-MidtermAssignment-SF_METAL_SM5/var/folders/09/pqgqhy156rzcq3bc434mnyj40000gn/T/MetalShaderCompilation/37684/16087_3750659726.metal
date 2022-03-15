

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
    char _m11_pad[48];
    float View_MaterialTextureMipBias;
    char _m12_pad[28];
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
    float View_IndirectLightingCacheShowFlag;
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_IndirectLightingCache
{
    float3 IndirectLightingCache_IndirectLightingCachePrimitiveAdd;
    float3 IndirectLightingCache_IndirectLightingCachePrimitiveScale;
    float3 IndirectLightingCache_IndirectLightingCacheMinUV;
    float3 IndirectLightingCache_IndirectLightingCacheMaxUV;
    char _m4_pad[16];
    float IndirectLightingCache_DirectionalLightShadowing;
};

struct type_Material
{
    spvUnsafeArray<float4, 8> Material_VectorExpressions;
    spvUnsafeArray<float4, 2> Material_ScalarExpressions;
};

constant float _158 = {};
constant float4 _159 = {};

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

fragment MainPS_out Main_00003ed7_df8e868e(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _213 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _158, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _218 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _223 = (_218.xyz / float3(_218.w)) - View.View_PreViewTranslation;
    float4 _229 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _232 = (_229.xy * float2(2.0)) - float2(1.0);
    float3 _248 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_232, sqrt(fast::clamp(1.0 - dot(_232, _232), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _259 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _266 = _259.y;
    float _272 = _259.z;
    float _275 = _259.x;
    float3 _293 = fast::clamp(mix(mix(Material.Material_VectorExpressions[4].xyz, Material.Material_VectorExpressions[5].xyz, float3(_266)), Material.Material_VectorExpressions[7].xyz, float3(_272)) * _275, float3(0.0), float3(1.0));
    float _294 = fast::clamp(mix(mix(Material.Material_ScalarExpressions[0].y, Material.Material_ScalarExpressions[0].z, _266), Material.Material_ScalarExpressions[0].w, _272), 0.0, 1.0);
    float _295 = fast::clamp(_275, 0.0, 1.0);
    float _300 = (fast::clamp(mix(mix(Material.Material_ScalarExpressions[1].x, Material.Material_ScalarExpressions[1].y, _266), Material.Material_ScalarExpressions[1].z, _272), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _301 = in.in_var_PRIMITIVE_ID * 36u;
    uint _302 = _301 + 20u;
    float _352;
    float _353;
    float _354;
    float3 _355;
    float3 _356;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _302)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _320 = ((_213.xy / float2(_213.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _324 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _320, level(0.0));
        float4 _327 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _320, level(0.0));
        float4 _330 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _320, level(0.0));
        float _340 = _330.w;
        _352 = (_300 * _340) + _330.z;
        _353 = (0.5 * _340) + _330.y;
        _354 = (_294 * _340) + _330.x;
        _355 = (_293 * _324.w) + _324.xyz;
        _356 = normalize((_248 * _327.w) + ((_327.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _352 = _300;
        _353 = 0.5;
        _354 = _294;
        _355 = _293;
        _356 = _248;
    }
    bool _366 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _372;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _301 + 18u)].w > 0.0) && _366)
    {
        _372 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _372 = 1.0;
    }
    float _419;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _302)].z > 0.0)
    {
        float3 _387 = fast::clamp((_223 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _398 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_387.x), int(_387.y), int(_387.z), 0).xyz), 0));
        _419 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_398.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_387 / float3(_398.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _419 = _372;
    }
    float3 _433 = ((_355 - (_355 * _354)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _440 = (mix(float3(0.07999999821186065673828125 * _353), _355, float3(_354)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _443 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _448;
    if (_443)
    {
        _448 = _433 + (_440 * 0.449999988079071044921875);
    }
    else
    {
        _448 = _433;
    }
    float3 _450 = select(_440, float3(0.0), bool3(_443));
    float3 _452 = float3(dot(_450, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _459 = float3(_295);
    float3 _527;
    if (_366)
    {
        float3 _479 = fast::clamp((_223 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _483 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _479);
        float4 _487 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _479);
        float4 _490 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _479);
        float4 _508 = _159;
        _508.y = (-0.48860299587249755859375) * _356.y;
        float4 _511 = _508;
        _511.z = 0.48860299587249755859375 * _356.z;
        float4 _514 = _511;
        _514.w = (-0.48860299587249755859375) * _356.x;
        float4 _515 = _514;
        _515.x = 0.886227548122406005859375;
        float3 _517 = _515.yzw * 2.094395160675048828125;
        float4 _518 = float4(_515.x, _517.x, _517.y, _517.z);
        float3 _520 = float3(0.0);
        _520.x = dot(float4(_483.x, _487.x, _490.x, _483.w), _518);
        float3 _522 = _520;
        _522.y = dot(float4(_483.y, _487.y, _490.y, _487.w), _518);
        float3 _524 = _522;
        _524.z = dot(float4(_483.z, _487.z, _490.zw), _518);
        _527 = fast::max(float3(0.0), _524) * float3(0.3183098733425140380859375);
    }
    else
    {
        _527 = float3(0.0);
    }
    float3 _530 = _527 * View.View_IndirectLightingColorScale;
    float3 _552 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _581;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _580;
        if (any(abs(_223 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _301 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _301 + 19u)].xyz + float3(1.0))))
        {
            _580 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_223, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _580 = _552;
        }
        _581 = _580;
    }
    else
    {
        _581 = _552;
    }
    float4 _588 = float4(((mix(float3(0.0), _448 + (_450 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_530 * _448) * fast::max(_459, ((((((_355 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _295) + ((_355 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _295) + ((_355 * 2.755199909210205078125) + float3(0.69029998779296875))) * _295))) + _581) * 1.0, 0.0);
    float4 _595;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _594 = _588;
        _594.w = 0.0;
        _595 = _594;
    }
    else
    {
        _595 = _588;
    }
    float2 _599 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _607 = (_356 * 0.5) + float3(0.5);
    float4 _609 = float4(_607.x, _607.y, _607.z, float4(0.0).w);
    _609.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _302)].y;
    float4 _610 = float4(0.0);
    _610.x = _354;
    float4 _611 = _610;
    _611.y = _353;
    float4 _612 = _611;
    _612.z = _352;
    float4 _613 = _612;
    _613.w = 0.50588238239288330078125;
    float4 _625 = float4(_355.x, _355.y, _355.z, float4(0.0).w);
    _625.w = ((log2(((dot(_530, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_459, ((((((_452 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _295) + ((_452 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _295) + ((_452 * 2.755199909210205078125) + float3(0.69029998779296875))) * _295).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_599.xyx * _599.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _595 * View.View_PreExposure;
    out.out_var_SV_Target1 = _609;
    out.out_var_SV_Target2 = _613;
    out.out_var_SV_Target3 = _625;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_419, 1.0, 1.0, 1.0);
    return out;
}

