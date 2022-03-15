

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

fragment MainPS_out Main_0000383c_50cd91fe(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _199 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _148, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _204 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _209 = (_204.xyz / float3(_204.w)) - View.View_PreViewTranslation;
    float3 _217 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _230 = fast::clamp(Material.Material_VectorExpressions[3].xyz, float3(0.0), float3(1.0));
    float _235 = (fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _236 = in.in_var_PRIMITIVE_ID * 36u;
    uint _237 = _236 + 20u;
    float _285;
    float _286;
    float _287;
    float3 _288;
    float3 _289;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _237)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _255 = ((_199.xy / float2(_199.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _259 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _255, level(0.0));
        float4 _262 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _255, level(0.0));
        float4 _265 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _255, level(0.0));
        float _275 = _265.w;
        _285 = (_235 * _275) + _265.z;
        _286 = (0.5 * _275) + _265.y;
        _287 = _265.x;
        _288 = (_230 * _259.w) + _259.xyz;
        _289 = normalize((_217 * _262.w) + ((_262.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _285 = _235;
        _286 = 0.5;
        _287 = 0.0;
        _288 = _230;
        _289 = _217;
    }
    bool _299 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _305;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _236 + 18u)].w > 0.0) && _299)
    {
        _305 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _305 = 1.0;
    }
    float _352;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _237)].z > 0.0)
    {
        float3 _320 = fast::clamp((_209 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _331 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_320.x), int(_320.y), int(_320.z), 0).xyz), 0));
        _352 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_331.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_320 / float3(_331.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _352 = _305;
    }
    float3 _366 = ((_288 - (_288 * _287)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _373 = (mix(float3(0.07999999821186065673828125 * _286), _288, float3(_287)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _376 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _381;
    if (_376)
    {
        _381 = _366 + (_373 * 0.449999988079071044921875);
    }
    else
    {
        _381 = _366;
    }
    float3 _383 = select(_373, float3(0.0), bool3(_376));
    float3 _385 = float3(dot(_383, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _471;
    if (_299)
    {
        float4 _421 = _149;
        _421.y = (-0.48860299587249755859375) * _289.y;
        float4 _424 = _421;
        _424.z = 0.48860299587249755859375 * _289.z;
        float4 _427 = _424;
        _427.w = (-0.48860299587249755859375) * _289.x;
        float3 _428 = _289 * _289;
        float4 _431 = _146;
        _431.x = (1.09254801273345947265625 * _289.x) * _289.y;
        float4 _434 = _431;
        _434.y = ((-1.09254801273345947265625) * _289.y) * _289.z;
        float4 _439 = _434;
        _439.z = 0.3153919875621795654296875 * ((3.0 * _428.z) - 1.0);
        float4 _442 = _439;
        _442.w = ((-1.09254801273345947265625) * _289.x) * _289.z;
        float4 _446 = _427;
        _446.x = 0.886227548122406005859375;
        float3 _448 = _446.yzw * 2.094395160675048828125;
        float4 _449 = float4(_446.x, _448.x, _448.y, _448.z);
        float4 _450 = _442 * 0.785398185253143310546875;
        float _451 = (_428.x - _428.y) * 0.4290426075458526611328125;
        float3 _457 = float3(0.0);
        _457.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _449) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _450)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _451);
        float3 _463 = _457;
        _463.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _449) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _450)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _451);
        float3 _469 = _463;
        _469.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _449) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _450)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _451);
        _471 = fast::max(float3(0.0), _469);
    }
    else
    {
        _471 = float3(0.0);
    }
    float3 _474 = _471 * View.View_IndirectLightingColorScale;
    float3 _496 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _525;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _524;
        if (any(abs(_209 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _236 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _236 + 19u)].xyz + float3(1.0))))
        {
            _524 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_209, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _524 = _496;
        }
        _525 = _524;
    }
    else
    {
        _525 = _496;
    }
    float4 _532 = float4(((mix(float3(0.0), _381 + (_383 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_474 * _381) * fast::max(float3(1.0), ((((((_288 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_288 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_288 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _525) * 1.0, 0.0);
    float4 _539;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _538 = _532;
        _538.w = 0.0;
        _539 = _538;
    }
    else
    {
        _539 = _532;
    }
    float2 _543 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _551 = (_289 * 0.5) + float3(0.5);
    float4 _553 = float4(_551.x, _551.y, _551.z, float4(0.0).w);
    _553.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _237)].y;
    float4 _554 = float4(0.0);
    _554.x = _287;
    float4 _555 = _554;
    _555.y = _286;
    float4 _556 = _555;
    _556.z = _285;
    float4 _557 = _556;
    _557.w = 0.50588238239288330078125;
    float4 _569 = float4(_288.x, _288.y, _288.z, float4(0.0).w);
    _569.w = ((log2(((dot(_474, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_385 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_385 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_385 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_543.xyx * _543.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _539 * View.View_PreExposure;
    out.out_var_SV_Target1 = _553;
    out.out_var_SV_Target2 = _557;
    out.out_var_SV_Target3 = _569;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_352, 1.0, 1.0, 1.0);
    return out;
}

