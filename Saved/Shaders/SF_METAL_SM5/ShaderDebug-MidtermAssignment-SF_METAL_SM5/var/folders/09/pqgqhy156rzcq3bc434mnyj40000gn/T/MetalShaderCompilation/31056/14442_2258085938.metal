

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

constant float _147 = {};
constant float4 _148 = {};

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
    uint in_var_PRIMITIVE_ID [[user(locn2)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_0000386a_8697a832(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _199 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _147, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _204 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _209 = (_204.xyz / float3(_204.w)) - View.View_PreViewTranslation;
    float3 _217 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float _228 = (0.699999988079071044921875 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _229 = in.in_var_PRIMITIVE_ID * 36u;
    uint _230 = _229 + 20u;
    float _278;
    float _279;
    float _280;
    float3 _281;
    float3 _282;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _230)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _248 = ((_199.xy / float2(_199.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _252 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _248, level(0.0));
        float4 _255 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _248, level(0.0));
        float4 _258 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _248, level(0.0));
        float _268 = _258.w;
        _278 = (_228 * _268) + _258.z;
        _279 = (0.5 * _268) + _258.y;
        _280 = _258.x;
        _281 = (float3(0.180000007152557373046875) * _252.w) + _252.xyz;
        _282 = normalize((_217 * _255.w) + ((_255.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _278 = _228;
        _279 = 0.5;
        _280 = 0.0;
        _281 = float3(0.180000007152557373046875);
        _282 = _217;
    }
    bool _292 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _298;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _229 + 18u)].w > 0.0) && _292)
    {
        _298 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _298 = 1.0;
    }
    float _345;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _230)].z > 0.0)
    {
        float3 _313 = fast::clamp((_209 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _324 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_313.x), int(_313.y), int(_313.z), 0).xyz), 0));
        _345 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_324.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_313 / float3(_324.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _345 = _298;
    }
    float3 _359 = ((_281 - (_281 * _280)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _366 = (mix(float3(0.07999999821186065673828125 * _279), _281, float3(_280)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _369 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _374;
    if (_369)
    {
        _374 = _359 + (_366 * 0.449999988079071044921875);
    }
    else
    {
        _374 = _359;
    }
    float3 _376 = select(_366, float3(0.0), bool3(_369));
    float3 _378 = float3(dot(_376, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _452;
    if (_292)
    {
        float3 _404 = fast::clamp((_209 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _408 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _404);
        float4 _412 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _404);
        float4 _415 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _404);
        float4 _433 = _148;
        _433.y = (-0.48860299587249755859375) * _282.y;
        float4 _436 = _433;
        _436.z = 0.48860299587249755859375 * _282.z;
        float4 _439 = _436;
        _439.w = (-0.48860299587249755859375) * _282.x;
        float4 _440 = _439;
        _440.x = 0.886227548122406005859375;
        float3 _442 = _440.yzw * 2.094395160675048828125;
        float4 _443 = float4(_440.x, _442.x, _442.y, _442.z);
        float3 _445 = float3(0.0);
        _445.x = dot(float4(_408.x, _412.x, _415.x, _408.w), _443);
        float3 _447 = _445;
        _447.y = dot(float4(_408.y, _412.y, _415.y, _412.w), _443);
        float3 _449 = _447;
        _449.z = dot(float4(_408.z, _412.z, _415.zw), _443);
        _452 = fast::max(float3(0.0), _449) * float3(0.3183098733425140380859375);
    }
    else
    {
        _452 = float3(0.0);
    }
    float3 _455 = _452 * View.View_IndirectLightingColorScale;
    float3 _477 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _506;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _505;
        if (any(abs(_209 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _229 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _229 + 19u)].xyz + float3(1.0))))
        {
            _505 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_209, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _505 = _477;
        }
        _506 = _505;
    }
    else
    {
        _506 = _477;
    }
    float4 _513 = float4(((mix(float3(0.0), _374 + (_376 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_455 * _374) * fast::max(float3(1.0), ((((((_281 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_281 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_281 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _506) * 1.0, 0.0);
    float4 _520;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _519 = _513;
        _519.w = 0.0;
        _520 = _519;
    }
    else
    {
        _520 = _513;
    }
    float2 _524 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _532 = (_282 * 0.5) + float3(0.5);
    float4 _534 = float4(_532.x, _532.y, _532.z, float4(0.0).w);
    _534.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _230)].y;
    float4 _535 = float4(0.0);
    _535.x = _280;
    float4 _536 = _535;
    _536.y = _279;
    float4 _537 = _536;
    _537.z = _278;
    float4 _538 = _537;
    _538.w = 0.50588238239288330078125;
    float4 _550 = float4(_281.x, _281.y, _281.z, float4(0.0).w);
    _550.w = ((log2(((dot(_455, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_378 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_378 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_378 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_524.xyx * _524.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _520 * View.View_PreExposure;
    out.out_var_SV_Target1 = _534;
    out.out_var_SV_Target2 = _538;
    out.out_var_SV_Target3 = _550;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_345, 1.0, 1.0, 1.0);
    return out;
}

