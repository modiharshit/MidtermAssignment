

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
    char _m9_pad[16];
    float View_OutOfBoundsMask;
    char _m10_pad[80];
    float View_UnlitViewmodeMask;
    char _m11_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m12_pad[604];
    float View_ShowDecalsMask;
    char _m13_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m14_pad[48];
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

constant float4 _147 = {};
constant float _149 = {};
constant float4 _150 = {};

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

fragment MainPS_out Main_00003438_ae9f11ac(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _197 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _149, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _202 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _207 = (_202.xyz / float3(_202.w)) - View.View_PreViewTranslation;
    float3 _215 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    uint _223 = in.in_var_PRIMITIVE_ID * 36u;
    uint _224 = _223 + 20u;
    float _271;
    float _272;
    float _273;
    float3 _274;
    float3 _275;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _224)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _242 = ((_197.xy / float2(_197.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _246 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _242, level(0.0));
        float4 _249 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _242, level(0.0));
        float4 _252 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _242, level(0.0));
        float _262 = _252.w;
        _271 = _262 + _252.z;
        _272 = (0.5 * _262) + _252.y;
        _273 = _252.x;
        _274 = (float3(0.180000007152557373046875) * _246.w) + _246.xyz;
        _275 = normalize((_215 * _249.w) + ((_249.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _271 = 1.0;
        _272 = 0.5;
        _273 = 0.0;
        _274 = float3(0.180000007152557373046875);
        _275 = _215;
    }
    bool _285 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _291;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _223 + 18u)].w > 0.0) && _285)
    {
        _291 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _291 = 1.0;
    }
    float _338;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _224)].z > 0.0)
    {
        float3 _306 = fast::clamp((_207 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _317 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_306.x), int(_306.y), int(_306.z), 0).xyz), 0));
        _338 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_317.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_306 / float3(_317.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _338 = _291;
    }
    float3 _361 = (((_274 - (_274 * _273)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz) + (((mix(float3(0.07999999821186065673828125 * _272), _274, float3(_273)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz) * 0.449999988079071044921875);
    float3 _434;
    if (_285)
    {
        float4 _384 = _150;
        _384.y = (-0.48860299587249755859375) * _275.y;
        float4 _387 = _384;
        _387.z = 0.48860299587249755859375 * _275.z;
        float4 _390 = _387;
        _390.w = (-0.48860299587249755859375) * _275.x;
        float3 _391 = _275 * _275;
        float4 _394 = _147;
        _394.x = (1.09254801273345947265625 * _275.x) * _275.y;
        float4 _397 = _394;
        _397.y = ((-1.09254801273345947265625) * _275.y) * _275.z;
        float4 _402 = _397;
        _402.z = 0.3153919875621795654296875 * ((3.0 * _391.z) - 1.0);
        float4 _405 = _402;
        _405.w = ((-1.09254801273345947265625) * _275.x) * _275.z;
        float4 _409 = _390;
        _409.x = 0.886227548122406005859375;
        float3 _411 = _409.yzw * 2.094395160675048828125;
        float4 _412 = float4(_409.x, _411.x, _411.y, _411.z);
        float4 _413 = _405 * 0.785398185253143310546875;
        float _414 = (_391.x - _391.y) * 0.4290426075458526611328125;
        float3 _420 = float3(0.0);
        _420.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _412) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _413)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _414);
        float3 _426 = _420;
        _426.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _412) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _413)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _414);
        float3 _432 = _426;
        _432.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _412) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _413)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _414);
        _434 = fast::max(float3(0.0), _432);
    }
    else
    {
        _434 = float3(0.0);
    }
    float3 _437 = _434 * View.View_IndirectLightingColorScale;
    float3 _457 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _486;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _485;
        if (any(abs(_207 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _223 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _223 + 19u)].xyz + float3(1.0))))
        {
            _485 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_207, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _485 = _457;
        }
        _486 = _485;
    }
    else
    {
        _486 = _457;
    }
    float4 _493 = float4(((mix(float3(0.0), _361, float3(View.View_UnlitViewmodeMask)) + ((_437 * _361) * fast::max(float3(1.0), ((((((_274 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_274 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_274 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _486) * 1.0, 0.0);
    float4 _500;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _499 = _493;
        _499.w = 0.0;
        _500 = _499;
    }
    else
    {
        _500 = _493;
    }
    float2 _504 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _512 = (_275 * 0.5) + float3(0.5);
    float4 _514 = float4(_512.x, _512.y, _512.z, float4(0.0).w);
    _514.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _224)].y;
    float4 _515 = float4(0.0);
    _515.x = _273;
    float4 _516 = _515;
    _516.y = _272;
    float4 _517 = _516;
    _517.z = _271;
    float4 _518 = _517;
    _518.w = 0.50588238239288330078125;
    float4 _529 = float4(_274.x, _274.y, _274.z, float4(0.0).w);
    _529.w = ((log2((dot(_437, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_504.xyx * _504.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _500 * View.View_PreExposure;
    out.out_var_SV_Target1 = _514;
    out.out_var_SV_Target2 = _518;
    out.out_var_SV_Target3 = _529;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_338, 1.0, 1.0, 1.0);
    return out;
}

