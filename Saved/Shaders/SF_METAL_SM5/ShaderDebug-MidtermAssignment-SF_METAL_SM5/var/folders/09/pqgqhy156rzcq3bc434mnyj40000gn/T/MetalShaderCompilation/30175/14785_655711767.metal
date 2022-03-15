

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

constant float _146 = {};
constant float4 _147 = {};

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
    float4 in_var_COLOR1 [[user(locn2)]];
};

fragment MainPS_out Main_000039c1_27155e17(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    float2 _196 = (gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw;
    float4 _202 = float4((_196 - float2(0.5)) * float2(2.0, -2.0), _146, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _207 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _212 = (_207.xyz / float3(_207.w)) - View.View_PreViewTranslation;
    float3 _220 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _227 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (_196 * 4.0), bias(View.View_MaterialTextureMipBias));
    float3 _228 = _227.xyz;
    if (abs(in.in_var_COLOR1.w) > 0.001000000047497451305389404296875)
    {
        float _245 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
        if ((float((in.in_var_COLOR1.w < 0.0) ? ((in.in_var_COLOR1.w + 1.0) > _245) : (in.in_var_COLOR1.w < _245)) - 0.001000000047497451305389404296875) < 0.0)
        {
            discard_fragment();
        }
    }
    float3 _256 = fast::clamp(_228, float3(0.0), float3(1.0));
    float _260 = (0.5 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _307;
    float _308;
    float _309;
    float3 _310;
    float3 _311;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _277 = ((_202.xy / float2(_202.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _281 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _277, level(0.0));
        float4 _284 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _277, level(0.0));
        float4 _287 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _277, level(0.0));
        float _297 = _287.w;
        _307 = (_260 * _297) + _287.z;
        _308 = (0.5 * _297) + _287.y;
        _309 = _287.x;
        _310 = (_256 * _281.w) + _281.xyz;
        _311 = normalize((_220 * _284.w) + ((_284.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _307 = _260;
        _308 = 0.5;
        _309 = 0.0;
        _310 = _256;
        _311 = _220;
    }
    bool _319 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _325;
    if ((Primitive.Primitive_UseSingleSampleShadowFromStationaryLights > 0.0) && _319)
    {
        _325 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _325 = 1.0;
    }
    float _372;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _340 = fast::clamp((_212 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _351 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_340.x), int(_340.y), int(_340.z), 0).xyz), 0));
        _372 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_351.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_340 / float3(_351.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _372 = _325;
    }
    float3 _386 = ((_310 - (_310 * _309)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _393 = (mix(float3(0.07999999821186065673828125 * _308), _310, float3(_309)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _396 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _401;
    if (_396)
    {
        _401 = _386 + (_393 * 0.449999988079071044921875);
    }
    else
    {
        _401 = _386;
    }
    float3 _403 = select(_393, float3(0.0), bool3(_396));
    float3 _405 = float3(dot(_403, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _479;
    if (_319)
    {
        float3 _431 = fast::clamp((_212 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _435 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _431);
        float4 _439 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _431);
        float4 _442 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _431);
        float4 _460 = _147;
        _460.y = (-0.48860299587249755859375) * _311.y;
        float4 _463 = _460;
        _463.z = 0.48860299587249755859375 * _311.z;
        float4 _466 = _463;
        _466.w = (-0.48860299587249755859375) * _311.x;
        float4 _467 = _466;
        _467.x = 0.886227548122406005859375;
        float3 _469 = _467.yzw * 2.094395160675048828125;
        float4 _470 = float4(_467.x, _469.x, _469.y, _469.z);
        float3 _472 = float3(0.0);
        _472.x = dot(float4(_435.x, _439.x, _442.x, _435.w), _470);
        float3 _474 = _472;
        _474.y = dot(float4(_435.y, _439.y, _442.y, _439.w), _470);
        float3 _476 = _474;
        _476.z = dot(float4(_435.z, _439.z, _442.zw), _470);
        _479 = fast::max(float3(0.0), _476) * float3(0.3183098733425140380859375);
    }
    else
    {
        _479 = float3(0.0);
    }
    float3 _482 = _479 * View.View_IndirectLightingColorScale;
    float3 _504 = fast::max(mix(_228, Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _530;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _529;
        if (any(abs(_212 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _529 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_212, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _529 = _504;
        }
        _530 = _529;
    }
    else
    {
        _530 = _504;
    }
    float4 _537 = float4(((mix(float3(0.0), _401 + (_403 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_482 * _401) * fast::max(float3(1.0), ((((((_310 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_310 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_310 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _530) * 1.0, 0.0);
    float4 _544;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _543 = _537;
        _543.w = 0.0;
        _544 = _543;
    }
    else
    {
        _544 = _537;
    }
    float2 _548 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _556 = (_311 * 0.5) + float3(0.5);
    float4 _558 = float4(_556.x, _556.y, _556.z, float4(0.0).w);
    _558.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _559 = float4(0.0);
    _559.x = _309;
    float4 _560 = _559;
    _560.y = _308;
    float4 _561 = _560;
    _561.z = _307;
    float4 _562 = _561;
    _562.w = 0.50588238239288330078125;
    float4 _574 = float4(_310.x, _310.y, _310.z, float4(0.0).w);
    _574.w = ((log2(((dot(_482, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_405 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_405 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_405 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_548.xyx * _548.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _544 * View.View_PreExposure;
    out.out_var_SV_Target1 = _558;
    out.out_var_SV_Target2 = _562;
    out.out_var_SV_Target3 = _574;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_372, 1.0, 1.0, 1.0);
    return out;
}

