

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

constant float4 _149 = {};
constant float _151 = {};
constant float4 _152 = {};

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

fragment MainPS_out Main_000037e8_107084da(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _202 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _151, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _207 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _212 = (_207.xyz / float3(_207.w)) - View.View_PreViewTranslation;
    float3 _220 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float _231 = (0.699999988079071044921875 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _232 = in.in_var_PRIMITIVE_ID * 36u;
    uint _233 = _232 + 20u;
    float _281;
    float _282;
    float _283;
    float3 _284;
    float3 _285;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _233)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _251 = ((_202.xy / float2(_202.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _255 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _251, level(0.0));
        float4 _258 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _251, level(0.0));
        float4 _261 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _251, level(0.0));
        float _271 = _261.w;
        _281 = (_231 * _271) + _261.z;
        _282 = (0.5 * _271) + _261.y;
        _283 = _261.x;
        _284 = (float3(0.180000007152557373046875) * _255.w) + _255.xyz;
        _285 = normalize((_220 * _258.w) + ((_258.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _281 = _231;
        _282 = 0.5;
        _283 = 0.0;
        _284 = float3(0.180000007152557373046875);
        _285 = _220;
    }
    bool _295 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _301;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _232 + 18u)].w > 0.0) && _295)
    {
        _301 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _301 = 1.0;
    }
    float _348;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _233)].z > 0.0)
    {
        float3 _316 = fast::clamp((_212 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _327 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_316.x), int(_316.y), int(_316.z), 0).xyz), 0));
        _348 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_327.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_316 / float3(_327.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _348 = _301;
    }
    float3 _362 = ((_284 - (_284 * _283)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _369 = (mix(float3(0.07999999821186065673828125 * _282), _284, float3(_283)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _372 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _377;
    if (_372)
    {
        _377 = _362 + (_369 * 0.449999988079071044921875);
    }
    else
    {
        _377 = _362;
    }
    float3 _379 = select(_369, float3(0.0), bool3(_372));
    float3 _381 = float3(dot(_379, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _467;
    if (_295)
    {
        float4 _417 = _152;
        _417.y = (-0.48860299587249755859375) * _285.y;
        float4 _420 = _417;
        _420.z = 0.48860299587249755859375 * _285.z;
        float4 _423 = _420;
        _423.w = (-0.48860299587249755859375) * _285.x;
        float3 _424 = _285 * _285;
        float4 _427 = _149;
        _427.x = (1.09254801273345947265625 * _285.x) * _285.y;
        float4 _430 = _427;
        _430.y = ((-1.09254801273345947265625) * _285.y) * _285.z;
        float4 _435 = _430;
        _435.z = 0.3153919875621795654296875 * ((3.0 * _424.z) - 1.0);
        float4 _438 = _435;
        _438.w = ((-1.09254801273345947265625) * _285.x) * _285.z;
        float4 _442 = _423;
        _442.x = 0.886227548122406005859375;
        float3 _444 = _442.yzw * 2.094395160675048828125;
        float4 _445 = float4(_442.x, _444.x, _444.y, _444.z);
        float4 _446 = _438 * 0.785398185253143310546875;
        float _447 = (_424.x - _424.y) * 0.4290426075458526611328125;
        float3 _453 = float3(0.0);
        _453.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _445) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _446)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _447);
        float3 _459 = _453;
        _459.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _445) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _446)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _447);
        float3 _465 = _459;
        _465.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _445) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _446)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _447);
        _467 = fast::max(float3(0.0), _465);
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
        if (any(abs(_212 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _232 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _232 + 19u)].xyz + float3(1.0))))
        {
            _520 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_212, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
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
    float4 _528 = float4(((mix(float3(0.0), _377 + (_379 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_470 * _377) * fast::max(float3(1.0), ((((((_284 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_284 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_284 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _521) * 1.0, 0.0);
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
    float3 _547 = (_285 * 0.5) + float3(0.5);
    float4 _549 = float4(_547.x, _547.y, _547.z, float4(0.0).w);
    _549.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _233)].y;
    float4 _550 = float4(0.0);
    _550.x = _283;
    float4 _551 = _550;
    _551.y = _282;
    float4 _552 = _551;
    _552.z = _281;
    float4 _553 = _552;
    _553.w = 0.50588238239288330078125;
    float4 _565 = float4(_284.x, _284.y, _284.z, float4(0.0).w);
    _565.w = ((log2(((dot(_470, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_381 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_381 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_381 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_539.xyx * _539.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _535 * View.View_PreExposure;
    out.out_var_SV_Target1 = _549;
    out.out_var_SV_Target2 = _553;
    out.out_var_SV_Target3 = _565;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_348, 1.0, 1.0, 1.0);
    return out;
}

