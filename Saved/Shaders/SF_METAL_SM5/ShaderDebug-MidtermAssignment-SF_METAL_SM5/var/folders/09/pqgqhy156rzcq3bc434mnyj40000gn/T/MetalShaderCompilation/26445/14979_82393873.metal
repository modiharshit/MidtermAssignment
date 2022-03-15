

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
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float _150 = {};
constant float4 _151 = {};

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

fragment MainPS_out Main_00003a83_04e93b11(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _206 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _150, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _211 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _216 = (_211.xyz / float3(_211.w)) - View.View_PreViewTranslation;
    float3 _224 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _237 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _239 = fast::clamp(_237.xyz, float3(0.0), float3(1.0));
    float _243 = (0.5 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _244 = in.in_var_PRIMITIVE_ID * 36u;
    uint _245 = _244 + 20u;
    float _293;
    float _294;
    float _295;
    float3 _296;
    float3 _297;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _245)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _263 = ((_206.xy / float2(_206.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _267 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _263, level(0.0));
        float4 _270 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _263, level(0.0));
        float4 _273 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _263, level(0.0));
        float _283 = _273.w;
        _293 = (_243 * _283) + _273.z;
        _294 = (0.5 * _283) + _273.y;
        _295 = _273.x;
        _296 = (_239 * _267.w) + _267.xyz;
        _297 = normalize((_224 * _270.w) + ((_270.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _293 = _243;
        _294 = 0.5;
        _295 = 0.0;
        _296 = _239;
        _297 = _224;
    }
    bool _307 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _313;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _244 + 18u)].w > 0.0) && _307)
    {
        _313 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _313 = 1.0;
    }
    float _360;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _245)].z > 0.0)
    {
        float3 _328 = fast::clamp((_216 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _339 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_328.x), int(_328.y), int(_328.z), 0).xyz), 0));
        _360 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_339.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_328 / float3(_339.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _360 = _313;
    }
    float3 _374 = ((_296 - (_296 * _295)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _381 = (mix(float3(0.07999999821186065673828125 * _294), _296, float3(_295)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _384 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _389;
    if (_384)
    {
        _389 = _374 + (_381 * 0.449999988079071044921875);
    }
    else
    {
        _389 = _374;
    }
    float3 _391 = select(_381, float3(0.0), bool3(_384));
    float3 _393 = float3(dot(_391, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _467;
    if (_307)
    {
        float3 _419 = fast::clamp((_216 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _423 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _419);
        float4 _427 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _419);
        float4 _430 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _419);
        float4 _448 = _151;
        _448.y = (-0.48860299587249755859375) * _297.y;
        float4 _451 = _448;
        _451.z = 0.48860299587249755859375 * _297.z;
        float4 _454 = _451;
        _454.w = (-0.48860299587249755859375) * _297.x;
        float4 _455 = _454;
        _455.x = 0.886227548122406005859375;
        float3 _457 = _455.yzw * 2.094395160675048828125;
        float4 _458 = float4(_455.x, _457.x, _457.y, _457.z);
        float3 _460 = float3(0.0);
        _460.x = dot(float4(_423.x, _427.x, _430.x, _423.w), _458);
        float3 _462 = _460;
        _462.y = dot(float4(_423.y, _427.y, _430.y, _427.w), _458);
        float3 _464 = _462;
        _464.z = dot(float4(_423.z, _427.z, _430.zw), _458);
        _467 = fast::max(float3(0.0), _464) * float3(0.3183098733425140380859375);
    }
    else
    {
        _467 = float3(0.0);
    }
    float3 _470 = _467 * View.View_IndirectLightingColorScale;
    float3 _492 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _521;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _520;
        if (any(abs(_216 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _244 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _244 + 19u)].xyz + float3(1.0))))
        {
            _520 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_216, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _520 = _492;
        }
        _521 = _520;
    }
    else
    {
        _521 = _492;
    }
    float4 _528 = float4(((mix(float3(0.0), _389 + (_391 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_470 * _389) * fast::max(float3(1.0), ((((((_296 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_296 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_296 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _521) * 1.0, 0.0);
    float4 _535;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _534 = _528;
        _534.w = 0.0;
        _535 = _534;
    }
    else
    {
        _535 = _528;
    }
    float2 _539 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _547 = (_297 * 0.5) + float3(0.5);
    float4 _549 = float4(_547.x, _547.y, _547.z, float4(0.0).w);
    _549.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _245)].y;
    float4 _550 = float4(0.0);
    _550.x = _295;
    float4 _551 = _550;
    _551.y = _294;
    float4 _552 = _551;
    _552.z = _293;
    float4 _553 = _552;
    _553.w = 0.50588238239288330078125;
    float4 _565 = float4(_296.x, _296.y, _296.z, float4(0.0).w);
    _565.w = ((log2(((dot(_470, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_393 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_393 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_393 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_539.xyx * _539.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _535 * View.View_PreExposure;
    out.out_var_SV_Target1 = _549;
    out.out_var_SV_Target2 = _553;
    out.out_var_SV_Target3 = _565;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_360, 1.0, 1.0, 1.0);
    return out;
}

