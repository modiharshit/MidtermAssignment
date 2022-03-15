

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
    spvUnsafeArray<float4, 4> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _146 = {};
constant float _148 = {};
constant float4 _149 = {};

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

fragment MainPS_out Main_00003899_79ab69db(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _199 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _148, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _204 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _209 = (_204.xyz / float3(_204.w)) - View.View_PreViewTranslation;
    float3 _217 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _232 = fast::clamp(Material.Material_VectorExpressions[3].xyz, float3(0.0), float3(1.0));
    float _233 = fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0);
    float _238 = (fast::clamp(Material.Material_ScalarExpressions[0].z, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _239 = in.in_var_PRIMITIVE_ID * 36u;
    uint _240 = _239 + 20u;
    float _290;
    float _291;
    float _292;
    float3 _293;
    float3 _294;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _240)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _258 = ((_199.xy / float2(_199.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _262 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _258, level(0.0));
        float4 _265 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _258, level(0.0));
        float4 _268 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _258, level(0.0));
        float _278 = _268.w;
        _290 = (_238 * _278) + _268.z;
        _291 = (0.5 * _278) + _268.y;
        _292 = (_233 * _278) + _268.x;
        _293 = (_232 * _262.w) + _262.xyz;
        _294 = normalize((_217 * _265.w) + ((_265.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _290 = _238;
        _291 = 0.5;
        _292 = _233;
        _293 = _232;
        _294 = _217;
    }
    bool _304 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _310;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _239 + 18u)].w > 0.0) && _304)
    {
        _310 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _310 = 1.0;
    }
    float _357;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _240)].z > 0.0)
    {
        float3 _325 = fast::clamp((_209 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _336 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_325.x), int(_325.y), int(_325.z), 0).xyz), 0));
        _357 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_336.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_325 / float3(_336.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _357 = _310;
    }
    float3 _371 = ((_293 - (_293 * _292)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _378 = (mix(float3(0.07999999821186065673828125 * _291), _293, float3(_292)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _381 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _386;
    if (_381)
    {
        _386 = _371 + (_378 * 0.449999988079071044921875);
    }
    else
    {
        _386 = _371;
    }
    float3 _388 = select(_378, float3(0.0), bool3(_381));
    float3 _390 = float3(dot(_388, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _476;
    if (_304)
    {
        float4 _426 = _149;
        _426.y = (-0.48860299587249755859375) * _294.y;
        float4 _429 = _426;
        _429.z = 0.48860299587249755859375 * _294.z;
        float4 _432 = _429;
        _432.w = (-0.48860299587249755859375) * _294.x;
        float3 _433 = _294 * _294;
        float4 _436 = _146;
        _436.x = (1.09254801273345947265625 * _294.x) * _294.y;
        float4 _439 = _436;
        _439.y = ((-1.09254801273345947265625) * _294.y) * _294.z;
        float4 _444 = _439;
        _444.z = 0.3153919875621795654296875 * ((3.0 * _433.z) - 1.0);
        float4 _447 = _444;
        _447.w = ((-1.09254801273345947265625) * _294.x) * _294.z;
        float4 _451 = _432;
        _451.x = 0.886227548122406005859375;
        float3 _453 = _451.yzw * 2.094395160675048828125;
        float4 _454 = float4(_451.x, _453.x, _453.y, _453.z);
        float4 _455 = _447 * 0.785398185253143310546875;
        float _456 = (_433.x - _433.y) * 0.4290426075458526611328125;
        float3 _462 = float3(0.0);
        _462.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _454) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _455)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _456);
        float3 _468 = _462;
        _468.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _454) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _455)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _456);
        float3 _474 = _468;
        _474.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _454) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _455)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _456);
        _476 = fast::max(float3(0.0), _474);
    }
    else
    {
        _476 = float3(0.0);
    }
    float3 _479 = _476 * View.View_IndirectLightingColorScale;
    float3 _501 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _530;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _529;
        if (any(abs(_209 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _239 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _239 + 19u)].xyz + float3(1.0))))
        {
            _529 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_209, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _529 = _501;
        }
        _530 = _529;
    }
    else
    {
        _530 = _501;
    }
    float4 _537 = float4(((mix(float3(0.0), _386 + (_388 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_479 * _386) * fast::max(float3(1.0), ((((((_293 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_293 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_293 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _530) * 1.0, 0.0);
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
    float3 _556 = (_294 * 0.5) + float3(0.5);
    float4 _558 = float4(_556.x, _556.y, _556.z, float4(0.0).w);
    _558.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _240)].y;
    float4 _559 = float4(0.0);
    _559.x = _292;
    float4 _560 = _559;
    _560.y = _291;
    float4 _561 = _560;
    _561.z = _290;
    float4 _562 = _561;
    _562.w = 0.50588238239288330078125;
    float4 _574 = float4(_293.x, _293.y, _293.z, float4(0.0).w);
    _574.w = ((log2(((dot(_479, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_390 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_390 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_390 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_548.xyx * _548.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _544 * View.View_PreExposure;
    out.out_var_SV_Target1 = _558;
    out.out_var_SV_Target2 = _562;
    out.out_var_SV_Target3 = _574;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_357, 1.0, 1.0, 1.0);
    return out;
}

