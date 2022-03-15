

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
    char _m11_pad[80];
    float View_UnlitViewmodeMask;
    char _m12_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m13_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m14_pad[188];
    float View_ShowDecalsMask;
    char _m15_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m16_pad[48];
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

constant float _138 = {};
constant float4 _139 = {};

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
};

fragment MainPS_out Main_0000364a_76ae9a8f(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    float4 _192 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _138, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _197 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _202 = (_197.xyz / float3(_197.w)) - View.View_PreViewTranslation;
    float3 _210 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float _221 = (0.100000001490116119384765625 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _269;
    float _270;
    float _271;
    float3 _272;
    float3 _273;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _238 = ((_192.xy / float2(_192.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _242 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _238, level(0.0));
        float4 _245 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _238, level(0.0));
        float4 _248 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _238, level(0.0));
        float _258 = _248.w;
        _269 = (_221 * _258) + _248.z;
        _270 = (0.5 * _258) + _248.y;
        _271 = _258 + _248.x;
        _272 = (float3(1.0) * _242.w) + _242.xyz;
        _273 = normalize((_210 * _245.w) + ((_245.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _269 = _221;
        _270 = 0.5;
        _271 = 1.0;
        _272 = float3(1.0);
        _273 = _210;
    }
    bool _281 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _287;
    if ((Primitive.Primitive_UseSingleSampleShadowFromStationaryLights > 0.0) && _281)
    {
        _287 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _287 = 1.0;
    }
    float _334;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _302 = fast::clamp((_202 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _313 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_302.x), int(_302.y), int(_302.z), 0).xyz), 0));
        _334 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_313.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_302 / float3(_313.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _334 = _287;
    }
    float3 _348 = ((_272 - (_272 * _271)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _355 = (mix(float3(0.07999999821186065673828125 * _270), _272, float3(_271)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _358 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _363;
    if (_358)
    {
        _363 = _348 + (_355 * 0.449999988079071044921875);
    }
    else
    {
        _363 = _348;
    }
    float3 _365 = select(_355, float3(0.0), bool3(_358));
    float3 _367 = float3(dot(_365, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _441;
    if (_281)
    {
        float3 _393 = fast::clamp((_202 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _397 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _393);
        float4 _401 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _393);
        float4 _404 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _393);
        float4 _422 = _139;
        _422.y = (-0.48860299587249755859375) * _273.y;
        float4 _425 = _422;
        _425.z = 0.48860299587249755859375 * _273.z;
        float4 _428 = _425;
        _428.w = (-0.48860299587249755859375) * _273.x;
        float4 _429 = _428;
        _429.x = 0.886227548122406005859375;
        float3 _431 = _429.yzw * 2.094395160675048828125;
        float4 _432 = float4(_429.x, _431.x, _431.y, _431.z);
        float3 _434 = float3(0.0);
        _434.x = dot(float4(_397.x, _401.x, _404.x, _397.w), _432);
        float3 _436 = _434;
        _436.y = dot(float4(_397.y, _401.y, _404.y, _401.w), _432);
        float3 _438 = _436;
        _438.z = dot(float4(_397.z, _401.z, _404.zw), _432);
        _441 = fast::max(float3(0.0), _438) * float3(0.3183098733425140380859375);
    }
    else
    {
        _441 = float3(0.0);
    }
    float3 _444 = _441 * View.View_IndirectLightingColorScale;
    float3 _466 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _492;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _491;
        if (any(abs(_202 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _491 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_202, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _491 = _466;
        }
        _492 = _491;
    }
    else
    {
        _492 = _466;
    }
    float4 _499 = float4(((mix(float3(0.0), _363 + (_365 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_444 * _363) * fast::max(float3(1.0), ((((((_272 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_272 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_272 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _492) * 1.0, 0.0);
    float4 _506;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _505 = _499;
        _505.w = 0.0;
        _506 = _505;
    }
    else
    {
        _506 = _499;
    }
    float2 _510 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _518 = (_273 * 0.5) + float3(0.5);
    float4 _520 = float4(_518.x, _518.y, _518.z, float4(0.0).w);
    _520.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _521 = float4(0.0);
    _521.x = _271;
    float4 _522 = _521;
    _522.y = _270;
    float4 _523 = _522;
    _523.z = _269;
    float4 _524 = _523;
    _524.w = 0.50588238239288330078125;
    float4 _536 = float4(_272.x, _272.y, _272.z, float4(0.0).w);
    _536.w = ((log2(((dot(_444, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_367 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_367 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_367 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_510.xyx * _510.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _506 * View.View_PreExposure;
    out.out_var_SV_Target1 = _520;
    out.out_var_SV_Target2 = _524;
    out.out_var_SV_Target3 = _536;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_334, 1.0, 1.0, 1.0);
    return out;
}

