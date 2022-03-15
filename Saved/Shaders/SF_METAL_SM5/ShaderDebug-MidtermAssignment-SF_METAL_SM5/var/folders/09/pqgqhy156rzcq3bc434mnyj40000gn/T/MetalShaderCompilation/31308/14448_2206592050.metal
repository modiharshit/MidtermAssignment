

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

constant float4 _150 = {};
constant float _152 = {};
constant float4 _153 = {};

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

fragment MainPS_out Main_00003870_8385ec32(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _203 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _152, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _208 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _213 = (_208.xyz / float3(_208.w)) - View.View_PreViewTranslation;
    float3 _221 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float _232 = (0.64999997615814208984375 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _233 = in.in_var_PRIMITIVE_ID * 36u;
    uint _234 = _233 + 20u;
    float _283;
    float _284;
    float _285;
    float3 _286;
    float3 _287;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _234)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _252 = ((_203.xy / float2(_203.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _256 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _252, level(0.0));
        float4 _259 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _252, level(0.0));
        float4 _262 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _252, level(0.0));
        float _272 = _262.w;
        _283 = (_232 * _272) + _262.z;
        _284 = (0.5 * _272) + _262.y;
        _285 = _272 + _262.x;
        _286 = (float3(0.180000007152557373046875) * _256.w) + _256.xyz;
        _287 = normalize((_221 * _259.w) + ((_259.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _283 = _232;
        _284 = 0.5;
        _285 = 1.0;
        _286 = float3(0.180000007152557373046875);
        _287 = _221;
    }
    bool _297 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _303;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _233 + 18u)].w > 0.0) && _297)
    {
        _303 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _303 = 1.0;
    }
    float _350;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _234)].z > 0.0)
    {
        float3 _318 = fast::clamp((_213 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _329 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_318.x), int(_318.y), int(_318.z), 0).xyz), 0));
        _350 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_329.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_318 / float3(_329.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _350 = _303;
    }
    float4 _352 = float4(0.0);
    _352.x = 1.0;
    float4 _353 = _352;
    _353.y = 0.0;
    float3 _367 = ((_286 - (_286 * _285)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _374 = (mix(float3(0.07999999821186065673828125 * _284), _286, float3(_285)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _377 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _382;
    if (_377)
    {
        _382 = _367 + (_374 * 0.449999988079071044921875);
    }
    else
    {
        _382 = _367;
    }
    float3 _384 = select(_374, float3(0.0), bool3(_377));
    float3 _386 = float3(dot(_384, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _472;
    if (_297)
    {
        float4 _422 = _153;
        _422.y = (-0.48860299587249755859375) * _287.y;
        float4 _425 = _422;
        _425.z = 0.48860299587249755859375 * _287.z;
        float4 _428 = _425;
        _428.w = (-0.48860299587249755859375) * _287.x;
        float3 _429 = _287 * _287;
        float4 _432 = _150;
        _432.x = (1.09254801273345947265625 * _287.x) * _287.y;
        float4 _435 = _432;
        _435.y = ((-1.09254801273345947265625) * _287.y) * _287.z;
        float4 _440 = _435;
        _440.z = 0.3153919875621795654296875 * ((3.0 * _429.z) - 1.0);
        float4 _443 = _440;
        _443.w = ((-1.09254801273345947265625) * _287.x) * _287.z;
        float4 _447 = _428;
        _447.x = 0.886227548122406005859375;
        float3 _449 = _447.yzw * 2.094395160675048828125;
        float4 _450 = float4(_447.x, _449.x, _449.y, _449.z);
        float4 _451 = _443 * 0.785398185253143310546875;
        float _452 = (_429.x - _429.y) * 0.4290426075458526611328125;
        float3 _458 = float3(0.0);
        _458.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _450) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _451)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _452);
        float3 _464 = _458;
        _464.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _450) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _451)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _452);
        float3 _470 = _464;
        _470.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _450) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _451)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _452);
        _472 = fast::max(float3(0.0), _470);
    }
    else
    {
        _472 = float3(0.0);
    }
    float3 _475 = _472 * View.View_IndirectLightingColorScale;
    float3 _497 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _526;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _525;
        if (any(abs(_213 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _233 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _233 + 19u)].xyz + float3(1.0))))
        {
            _525 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_213, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _525 = _497;
        }
        _526 = _525;
    }
    else
    {
        _526 = _497;
    }
    float4 _533 = float4(((mix(float3(0.0), _382 + (_384 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_475 * _382) * fast::max(float3(1.0), ((((((_286 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_286 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_286 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _526) * 1.0, 0.0);
    float4 _540;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _539 = _533;
        _539.w = 0.0;
        _540 = _539;
    }
    else
    {
        _540 = _533;
    }
    float2 _544 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _552 = (_287 * 0.5) + float3(0.5);
    float4 _554 = float4(_552.x, _552.y, _552.z, float4(0.0).w);
    _554.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _234)].y;
    float4 _555 = float4(0.0);
    _555.x = _285;
    float4 _556 = _555;
    _556.y = _284;
    float4 _557 = _556;
    _557.z = fast::clamp(_283, 0.0, 0.996078431606292724609375);
    float4 _558 = _557;
    _558.w = 0.517647087574005126953125;
    float4 _570 = float4(_286.x, _286.y, _286.z, float4(0.0).w);
    _570.w = ((log2(((dot(_475, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_386 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_386 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_386 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_544.xyx * _544.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _540 * View.View_PreExposure;
    out.out_var_SV_Target1 = _554;
    out.out_var_SV_Target2 = _558;
    out.out_var_SV_Target3 = _570;
    out.out_var_SV_Target4 = _353;
    out.out_var_SV_Target5 = float4(_350, 1.0, 1.0, 1.0);
    return out;
}

