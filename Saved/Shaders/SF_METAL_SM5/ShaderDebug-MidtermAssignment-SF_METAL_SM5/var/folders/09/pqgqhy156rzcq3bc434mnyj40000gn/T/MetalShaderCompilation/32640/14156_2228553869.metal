

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

fragment MainPS_out Main_0000374c_84d5088d(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _199 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _148, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _204 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _209 = (_204.xyz / float3(_204.w)) - View.View_PreViewTranslation;
    float3 _217 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    uint _226 = in.in_var_PRIMITIVE_ID * 36u;
    uint _227 = _226 + 20u;
    float _272;
    float _273;
    float _274;
    float3 _275;
    float3 _276;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _227)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _245 = ((_199.xy / float2(_199.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _252 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _245, level(0.0));
        float4 _255 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _245, level(0.0));
        float _264 = _255.w;
        _272 = (View.View_RoughnessOverrideParameter.x * _264) + _255.z;
        _273 = (0.5 * _264) + _255.y;
        _274 = _255.x;
        _275 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _245, level(0.0)).xyz;
        _276 = normalize((_217 * _252.w) + ((_252.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _272 = View.View_RoughnessOverrideParameter.x;
        _273 = 0.5;
        _274 = 0.0;
        _275 = float3(0.0);
        _276 = _217;
    }
    bool _286 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _292;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _226 + 18u)].w > 0.0) && _286)
    {
        _292 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _292 = 1.0;
    }
    float _339;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _227)].z > 0.0)
    {
        float3 _307 = fast::clamp((_209 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _318 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_307.x), int(_307.y), int(_307.z), 0).xyz), 0));
        _339 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_318.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_307 / float3(_318.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _339 = _292;
    }
    float3 _353 = ((_275 - (_275 * _274)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _360 = (mix(float3(0.07999999821186065673828125 * _273), _275, float3(_274)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _363 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _368;
    if (_363)
    {
        _368 = _353 + (_360 * 0.449999988079071044921875);
    }
    else
    {
        _368 = _353;
    }
    float3 _370 = select(_360, float3(0.0), bool3(_363));
    float3 _372 = float3(dot(_370, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _458;
    if (_286)
    {
        float4 _408 = _149;
        _408.y = (-0.48860299587249755859375) * _276.y;
        float4 _411 = _408;
        _411.z = 0.48860299587249755859375 * _276.z;
        float4 _414 = _411;
        _414.w = (-0.48860299587249755859375) * _276.x;
        float3 _415 = _276 * _276;
        float4 _418 = _146;
        _418.x = (1.09254801273345947265625 * _276.x) * _276.y;
        float4 _421 = _418;
        _421.y = ((-1.09254801273345947265625) * _276.y) * _276.z;
        float4 _426 = _421;
        _426.z = 0.3153919875621795654296875 * ((3.0 * _415.z) - 1.0);
        float4 _429 = _426;
        _429.w = ((-1.09254801273345947265625) * _276.x) * _276.z;
        float4 _433 = _414;
        _433.x = 0.886227548122406005859375;
        float3 _435 = _433.yzw * 2.094395160675048828125;
        float4 _436 = float4(_433.x, _435.x, _435.y, _435.z);
        float4 _437 = _429 * 0.785398185253143310546875;
        float _438 = (_415.x - _415.y) * 0.4290426075458526611328125;
        float3 _444 = float3(0.0);
        _444.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _436) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _437)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _438);
        float3 _450 = _444;
        _450.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _436) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _437)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _438);
        float3 _456 = _450;
        _456.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _436) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _437)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _438);
        _458 = fast::max(float3(0.0), _456);
    }
    else
    {
        _458 = float3(0.0);
    }
    float3 _461 = _458 * View.View_IndirectLightingColorScale;
    float3 _483 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _512;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _511;
        if (any(abs(_209 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _226 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _226 + 19u)].xyz + float3(1.0))))
        {
            _511 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_209, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _511 = _483;
        }
        _512 = _511;
    }
    else
    {
        _512 = _483;
    }
    float4 _519 = float4(((mix(float3(0.0), _368 + (_370 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_461 * _368) * fast::max(float3(1.0), ((((((_275 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_275 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_275 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _512) * 1.0, 0.0);
    float4 _526;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _525 = _519;
        _525.w = 0.0;
        _526 = _525;
    }
    else
    {
        _526 = _519;
    }
    float2 _530 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _538 = (_276 * 0.5) + float3(0.5);
    float4 _540 = float4(_538.x, _538.y, _538.z, float4(0.0).w);
    _540.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _227)].y;
    float4 _541 = float4(0.0);
    _541.x = _274;
    float4 _542 = _541;
    _542.y = _273;
    float4 _543 = _542;
    _543.z = _272;
    float4 _544 = _543;
    _544.w = 0.50588238239288330078125;
    float4 _556 = float4(_275.x, _275.y, _275.z, float4(0.0).w);
    _556.w = ((log2(((dot(_461, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_372 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_372 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_372 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_530.xyx * _530.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _526 * View.View_PreExposure;
    out.out_var_SV_Target1 = _540;
    out.out_var_SV_Target2 = _544;
    out.out_var_SV_Target3 = _556;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_339, 1.0, 1.0, 1.0);
    return out;
}

