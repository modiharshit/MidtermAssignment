

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
    char _m11_pad[24];
    float View_CullingSign;
    char _m12_pad[20];
    float View_MaterialTextureMipBias;
    char _m13_pad[28];
    float View_UnlitViewmodeMask;
    char _m14_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m15_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m16_pad[188];
    float View_ShowDecalsMask;
    char _m17_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m18_pad[48];
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

struct type_PrimitiveDither
{
    float PrimitiveDither_LODFactor;
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
    spvUnsafeArray<float4, 7> Material_VectorExpressions;
    spvUnsafeArray<float4, 6> Material_ScalarExpressions;
};

constant float _168 = {};
constant float _170 = {};
constant float4 _171 = {};
constant float3 _172 = {};

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
    float4 in_var_COLOR0 [[user(locn2)]];
    float4 in_var_TEXCOORD0_0 [[user(locn3)]];
    uint in_var_PRIMITIVE_ID [[user(locn4)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_0000473c_2974f70f(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_PrimitiveDither& PrimitiveDither [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], texture2d<float> Material_Texture2D_3 [[texture(10)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]], bool gl_FrontFacing [[front_facing]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _231 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _170, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _236 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _241 = (_236.xyz / float3(_236.w)) - View.View_PreViewTranslation;
    uint _242 = in.in_var_PRIMITIVE_ID * 36u;
    float4 _256 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _267 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((((float3(-0.5) + _256.xyz) * 2.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * ((View.View_CullingSign * View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _242 + 4u)].w) * float(gl_FrontFacing ? 1 : (-1)));
    float4 _278 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _285 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    if (PrimitiveDither.PrimitiveDither_LODFactor != 0.0)
    {
        if (abs(PrimitiveDither.PrimitiveDither_LODFactor) > 0.001000000047497451305389404296875)
        {
            float _305 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
            if ((float((PrimitiveDither.PrimitiveDither_LODFactor < 0.0) ? ((PrimitiveDither.PrimitiveDither_LODFactor + 1.0) > _305) : (PrimitiveDither.PrimitiveDither_LODFactor < _305)) - 0.001000000047497451305389404296875) < 0.0)
            {
                discard_fragment();
            }
        }
    }
    if (((in.in_var_COLOR0.w * _278.w) - 0.100000001490116119384765625) < 0.0)
    {
        discard_fragment();
    }
    float3 _320 = fast::clamp(_278.xyz, float3(0.0), float3(1.0));
    float _325 = (fast::clamp(_256.w, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float3 _335 = (fast::clamp(float4(_285.xyz, _168).xyz, float3(0.0), float3(1.0)).xyz * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    uint _336 = _242 + 20u;
    float3 _385;
    float _386;
    float _387;
    float _388;
    float3 _389;
    float3 _390;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _336)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _354 = ((_231.xy / float2(_231.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _358 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _354, level(0.0));
        float4 _361 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _354, level(0.0));
        float4 _364 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _354, level(0.0));
        float _366 = _358.w;
        float _374 = _364.w;
        _385 = _335 * _366;
        _386 = (_325 * _374) + _364.z;
        _387 = (0.5 * _374) + _364.y;
        _388 = _364.x;
        _389 = (_320 * _366) + _358.xyz;
        _390 = normalize((_267 * _361.w) + ((_361.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _385 = _335;
        _386 = _325;
        _387 = 0.5;
        _388 = 0.0;
        _389 = _320;
        _390 = _267;
    }
    bool _400 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _406;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _242 + 18u)].w > 0.0) && _400)
    {
        _406 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _406 = 1.0;
    }
    float _453;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _336)].z > 0.0)
    {
        float3 _421 = fast::clamp((_241 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _432 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_421.x), int(_421.y), int(_421.z), 0).xyz), 0));
        _453 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_432.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_421 / float3(_432.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _453 = _406;
    }
    float3 _456 = sqrt(fast::clamp(_385, float3(0.0), float3(1.0)));
    float4 _458 = float4(_456.x, _456.y, _456.z, float4(0.0).w);
    _458.w = 1.0;
    float3 _466 = ((_389 - (_389 * _388)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _473 = (mix(float3(0.07999999821186065673828125 * _387), _389, float3(_388)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _476 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _481;
    if (_476)
    {
        _481 = _466 + (_473 * 0.449999988079071044921875);
    }
    else
    {
        _481 = _466;
    }
    float3 _483 = select(_473, float3(0.0), bool3(_476));
    float3 _485 = float3(dot(_483, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _581;
    float3 _582;
    if (_400)
    {
        float3 _511 = fast::clamp((_241 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _515 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _511);
        float4 _519 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _511);
        float4 _522 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _511);
        float4 _527 = float4(_515.x, _519.x, _522.x, _515.w);
        float4 _532 = float4(_515.y, _519.y, _522.y, _519.w);
        float4 _537 = float4(_515.z, _519.z, _522.zw);
        float4 _540 = _171;
        _540.y = (-0.48860299587249755859375) * _390.y;
        float4 _543 = _540;
        _543.z = 0.48860299587249755859375 * _390.z;
        float4 _546 = _543;
        _546.w = (-0.48860299587249755859375) * _390.x;
        float4 _547 = _546;
        _547.x = 0.886227548122406005859375;
        float3 _549 = _547.yzw * 2.094395160675048828125;
        float4 _550 = float4(_547.x, _549.x, _549.y, _549.z);
        float3 _552 = float3(0.0);
        _552.x = dot(_527, _550);
        float3 _554 = _552;
        _554.y = dot(_532, _550);
        float3 _556 = _554;
        _556.z = dot(_537, _550);
        float3 _559 = -_390;
        float4 _562 = _171;
        _562.y = (-0.48860299587249755859375) * _559.y;
        float4 _565 = _562;
        _565.z = 0.48860299587249755859375 * _559.z;
        float4 _568 = _565;
        _568.w = (-0.48860299587249755859375) * _559.x;
        float4 _569 = _568;
        _569.x = 0.886227548122406005859375;
        float3 _571 = _569.yzw * 2.094395160675048828125;
        float4 _572 = float4(_569.x, _571.x, _571.y, _571.z);
        float3 _574 = _172;
        _574.x = dot(_527, _572);
        float3 _576 = _574;
        _576.y = dot(_532, _572);
        float3 _578 = _576;
        _578.z = dot(_537, _572);
        _581 = fast::max(float3(0.0), _578) * float3(0.3183098733425140380859375);
        _582 = fast::max(float3(0.0), _556) * float3(0.3183098733425140380859375);
    }
    else
    {
        _581 = float3(0.0);
        _582 = float3(0.0);
    }
    float3 _585 = _582 * View.View_IndirectLightingColorScale;
    float3 _610 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _639;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _638;
        if (any(abs(_241 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _242 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _242 + 19u)].xyz + float3(1.0))))
        {
            _638 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_241, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _638 = _610;
        }
        _639 = _638;
    }
    else
    {
        _639 = _610;
    }
    float4 _646 = float4(((mix(float3(0.0), _481 + (_483 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + (((_585 * _481) + ((_581 * View.View_IndirectLightingColorScale) * _385)) * fast::max(float3(1.0), ((((((_389 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_389 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_389 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _639) * 1.0, 0.0);
    float4 _653;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _652 = _646;
        _652.w = 0.0;
        _653 = _652;
    }
    else
    {
        _653 = _646;
    }
    float2 _657 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _665 = (_390 * 0.5) + float3(0.5);
    float4 _667 = float4(_665.x, _665.y, _665.z, float4(0.0).w);
    _667.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _336)].y;
    float4 _668 = float4(0.0);
    _668.x = _388;
    float4 _669 = _668;
    _669.y = _387;
    float4 _670 = _669;
    _670.z = _386;
    float4 _671 = _670;
    _671.w = 0.525490224361419677734375;
    float4 _683 = float4(_389.x, _389.y, _389.z, float4(0.0).w);
    _683.w = ((log2(((dot(_585, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_485 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_485 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_485 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_657.xyx * _657.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _653 * View.View_PreExposure;
    out.out_var_SV_Target1 = _667;
    out.out_var_SV_Target2 = _671;
    out.out_var_SV_Target3 = _683;
    out.out_var_SV_Target4 = _458;
    out.out_var_SV_Target5 = float4(_453, 1.0, 1.0, 1.0);
    return out;
}

