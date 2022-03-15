

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
    float3 IndirectLightingCache_IndirectLightingCachePrimitiveAdd;
    float3 IndirectLightingCache_IndirectLightingCachePrimitiveScale;
    float3 IndirectLightingCache_IndirectLightingCacheMinUV;
    float3 IndirectLightingCache_IndirectLightingCacheMaxUV;
    char _m4_pad[16];
    float IndirectLightingCache_DirectionalLightShadowing;
};

struct type_Material
{
    spvUnsafeArray<float4, 5> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _169 = {};

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

fragment MainPS_out Main_00004972_0a4c2bc5(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    bool _318;
    float4 _227 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _231 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _236 = (_231.xyz / float3(_231.w)) - View.View_PreViewTranslation;
    float4 _248 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(View.View_GameTime * (-0.100000001490116119384765625), View.View_GameTime * (-0.0500000007450580596923828125)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y)), bias(View.View_MaterialTextureMipBias));
    float2 _251 = (_248.xy * float2(2.0)) - float2(1.0);
    float _260 = View.View_GameTime * 0.0500000007450580596923828125;
    float4 _265 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(View.View_GameTime * 0.039999999105930328369140625, _260) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5)), bias(View.View_MaterialTextureMipBias));
    float2 _268 = (_265.xy * float2(2.0)) - float2(1.0);
    float _280 = View.View_GameTime * (-0.02999999932944774627685546875);
    float4 _285 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(_280, _260) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.300000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float2 _288 = (_285.xy * float2(2.0)) - float2(1.0);
    float4 _300 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(_260, 0.0) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.25)), bias(View.View_MaterialTextureMipBias));
    float2 _303 = (_300.xy * float2(2.0)) - float2(1.0);
    float _338;
    switch (0u)
    {
        default:
        {
            _318 = View.View_ViewToClip[3u].w < 1.0;
            if (_318)
            {
                _338 = _227.w;
                break;
            }
            else
            {
                float _322 = _227.z;
                _338 = ((_322 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_322 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float4 _350 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(_280, View.View_GameTime * (-0.0089999996125698089599609375)) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float2 _353 = (_350.xy * float2(2.0)) - float2(1.0);
    float4 _366 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(View.View_GameTime * 0.02999999932944774627685546875, 0.0) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(0.07999999821186065673828125, 0.039999999105930328369140625))), bias(View.View_MaterialTextureMipBias));
    float2 _369 = (_366.xy * float2(2.0)) - float2(1.0);
    float _402;
    switch (0u)
    {
        default:
        {
            if (_318)
            {
                _402 = _227.w;
                break;
            }
            else
            {
                float _386 = _227.z;
                _402 = ((_386 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_386 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _416 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(mix(float4(_251, sqrt(fast::clamp(1.0 - dot(_251, _251), 0.0, 1.0)), 1.0).xyz + (float4(_268, sqrt(fast::clamp(1.0 - dot(_268, _268), 0.0, 1.0)), 1.0).xyz * float3(-1.0, -1.0, 1.0)), float4(_288, sqrt(fast::clamp(1.0 - dot(_288, _288), 0.0, 1.0)), 1.0).xyz + float4(_303, sqrt(fast::clamp(1.0 - dot(_303, _303), 0.0, 1.0)), 1.0).xyz, float3(fast::min(fast::max((_338 - 300.0) * 0.0011111111380159854888916015625, 0.0), 1.0))), float4(_353, sqrt(fast::clamp(1.0 - dot(_353, _353), 0.0, 1.0)), 1.0).xyz + (float4(_369, sqrt(fast::clamp(1.0 - dot(_369, _369), 0.0, 1.0)), 1.0).xyz * float3(-1.0, -1.0, 1.0)), float3(fast::min(fast::max((_402 - 500.0) * 0.0005000000237487256526947021484375, 0.0), 1.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _427 = fast::clamp(Material.Material_VectorExpressions[4].xyz, float3(0.0), float3(1.0));
    float _431 = (0.300000011920928955078125 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _432 = in.in_var_PRIMITIVE_ID * 36u;
    uint _433 = _432 + 20u;
    float _482;
    float _483;
    float _484;
    float3 _485;
    float3 _486;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _433)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _451 = ((_227.xy / float2(_227.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _455 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _451, level(0.0));
        float4 _458 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _451, level(0.0));
        float4 _461 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _451, level(0.0));
        float _471 = _461.w;
        _482 = (_431 * _471) + _461.z;
        _483 = (0.5 * _471) + _461.y;
        _484 = _471 + _461.x;
        _485 = (_427 * _455.w) + _455.xyz;
        _486 = normalize((_416 * _458.w) + ((_458.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _482 = _431;
        _483 = 0.5;
        _484 = 1.0;
        _485 = _427;
        _486 = _416;
    }
    bool _496 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _502;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _432 + 18u)].w > 0.0) && _496)
    {
        _502 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _502 = 1.0;
    }
    float _549;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _433)].z > 0.0)
    {
        float3 _517 = fast::clamp((_236 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _528 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_517.x), int(_517.y), int(_517.z), 0).xyz), 0));
        _549 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_528.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_517 / float3(_528.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _549 = _502;
    }
    float3 _563 = ((_485 - (_485 * _484)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _570 = (mix(float3(0.07999999821186065673828125 * _483), _485, float3(_484)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _573 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _578;
    if (_573)
    {
        _578 = _563 + (_570 * 0.449999988079071044921875);
    }
    else
    {
        _578 = _563;
    }
    float3 _580 = select(_570, float3(0.0), bool3(_573));
    float3 _582 = float3(dot(_580, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _656;
    if (_496)
    {
        float3 _608 = fast::clamp((_236 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _612 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _608);
        float4 _616 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _608);
        float4 _619 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _608);
        float4 _637 = _169;
        _637.y = (-0.48860299587249755859375) * _486.y;
        float4 _640 = _637;
        _640.z = 0.48860299587249755859375 * _486.z;
        float4 _643 = _640;
        _643.w = (-0.48860299587249755859375) * _486.x;
        float4 _644 = _643;
        _644.x = 0.886227548122406005859375;
        float3 _646 = _644.yzw * 2.094395160675048828125;
        float4 _647 = float4(_644.x, _646.x, _646.y, _646.z);
        float3 _649 = float3(0.0);
        _649.x = dot(float4(_612.x, _616.x, _619.x, _612.w), _647);
        float3 _651 = _649;
        _651.y = dot(float4(_612.y, _616.y, _619.y, _616.w), _647);
        float3 _653 = _651;
        _653.z = dot(float4(_612.z, _616.z, _619.zw), _647);
        _656 = fast::max(float3(0.0), _653) * float3(0.3183098733425140380859375);
    }
    else
    {
        _656 = float3(0.0);
    }
    float3 _659 = _656 * View.View_IndirectLightingColorScale;
    float3 _681 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _710;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _709;
        if (any(abs(_236 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _432 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _432 + 19u)].xyz + float3(1.0))))
        {
            _709 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_236, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _709 = _681;
        }
        _710 = _709;
    }
    else
    {
        _710 = _681;
    }
    float4 _717 = float4(((mix(float3(0.0), _578 + (_580 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_659 * _578) * fast::max(float3(1.0), ((((((_485 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_485 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_485 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _710) * 1.0, 0.0);
    float4 _724;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _723 = _717;
        _723.w = 0.0;
        _724 = _723;
    }
    else
    {
        _724 = _717;
    }
    float2 _728 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _736 = (_486 * 0.5) + float3(0.5);
    float4 _738 = float4(_736.x, _736.y, _736.z, float4(0.0).w);
    _738.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _433)].y;
    float4 _739 = float4(0.0);
    _739.x = _484;
    float4 _740 = _739;
    _740.y = _483;
    float4 _741 = _740;
    _741.z = _482;
    float4 _742 = _741;
    _742.w = 0.50588238239288330078125;
    float4 _754 = float4(_485.x, _485.y, _485.z, float4(0.0).w);
    _754.w = ((log2(((dot(_659, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_582 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_582 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_582 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_728.xyx * _728.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _724 * View.View_PreExposure;
    out.out_var_SV_Target1 = _738;
    out.out_var_SV_Target2 = _742;
    out.out_var_SV_Target3 = _754;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_549, 1.0, 1.0, 1.0);
    return out;
}

