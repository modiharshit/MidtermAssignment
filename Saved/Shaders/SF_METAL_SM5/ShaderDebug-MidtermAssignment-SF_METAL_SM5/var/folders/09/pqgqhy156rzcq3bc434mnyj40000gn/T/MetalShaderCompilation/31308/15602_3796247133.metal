

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
    spvUnsafeArray<float4, 6> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _158 = {};
constant float _160 = {};
constant float4 _161 = {};

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

fragment MainPS_out Main_00003cf2_e246225d(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _214 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _160, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _219 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _224 = (_219.xyz / float3(_219.w)) - View.View_PreViewTranslation;
    float4 _230 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _233 = (_230.xy * float2(2.0)) - float2(1.0);
    float3 _249 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_233, sqrt(fast::clamp(1.0 - dot(_233, _233), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _260 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _267 = _260.y;
    float3 _278 = fast::clamp(mix(Material.Material_VectorExpressions[4].xyz, Material.Material_VectorExpressions[5].xyz, float3(_267)) * _260.x, float3(0.0), float3(1.0));
    float _279 = fast::clamp(mix(0.0, 1.0, _267), 0.0, 1.0);
    float _284 = (fast::clamp(mix(Material.Material_ScalarExpressions[0].y, Material.Material_ScalarExpressions[0].z, _267), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _285 = in.in_var_PRIMITIVE_ID * 36u;
    uint _286 = _285 + 20u;
    float _336;
    float _337;
    float _338;
    float3 _339;
    float3 _340;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _286)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _304 = ((_214.xy / float2(_214.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _308 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _304, level(0.0));
        float4 _311 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _304, level(0.0));
        float4 _314 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _304, level(0.0));
        float _324 = _314.w;
        _336 = (_284 * _324) + _314.z;
        _337 = (0.5 * _324) + _314.y;
        _338 = (_279 * _324) + _314.x;
        _339 = (_278 * _308.w) + _308.xyz;
        _340 = normalize((_249 * _311.w) + ((_311.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _336 = _284;
        _337 = 0.5;
        _338 = _279;
        _339 = _278;
        _340 = _249;
    }
    bool _350 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _356;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _285 + 18u)].w > 0.0) && _350)
    {
        _356 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _356 = 1.0;
    }
    float _403;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _286)].z > 0.0)
    {
        float3 _371 = fast::clamp((_224 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _382 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_371.x), int(_371.y), int(_371.z), 0).xyz), 0));
        _403 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_382.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_371 / float3(_382.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _403 = _356;
    }
    float3 _417 = ((_339 - (_339 * _338)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _424 = (mix(float3(0.07999999821186065673828125 * _337), _339, float3(_338)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _427 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _432;
    if (_427)
    {
        _432 = _417 + (_424 * 0.449999988079071044921875);
    }
    else
    {
        _432 = _417;
    }
    float3 _434 = select(_424, float3(0.0), bool3(_427));
    float3 _436 = float3(dot(_434, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _522;
    if (_350)
    {
        float4 _472 = _161;
        _472.y = (-0.48860299587249755859375) * _340.y;
        float4 _475 = _472;
        _475.z = 0.48860299587249755859375 * _340.z;
        float4 _478 = _475;
        _478.w = (-0.48860299587249755859375) * _340.x;
        float3 _479 = _340 * _340;
        float4 _482 = _158;
        _482.x = (1.09254801273345947265625 * _340.x) * _340.y;
        float4 _485 = _482;
        _485.y = ((-1.09254801273345947265625) * _340.y) * _340.z;
        float4 _490 = _485;
        _490.z = 0.3153919875621795654296875 * ((3.0 * _479.z) - 1.0);
        float4 _493 = _490;
        _493.w = ((-1.09254801273345947265625) * _340.x) * _340.z;
        float4 _497 = _478;
        _497.x = 0.886227548122406005859375;
        float3 _499 = _497.yzw * 2.094395160675048828125;
        float4 _500 = float4(_497.x, _499.x, _499.y, _499.z);
        float4 _501 = _493 * 0.785398185253143310546875;
        float _502 = (_479.x - _479.y) * 0.4290426075458526611328125;
        float3 _508 = float3(0.0);
        _508.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _500) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _501)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _502);
        float3 _514 = _508;
        _514.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _500) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _501)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _502);
        float3 _520 = _514;
        _520.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _500) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _501)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _502);
        _522 = fast::max(float3(0.0), _520);
    }
    else
    {
        _522 = float3(0.0);
    }
    float3 _525 = _522 * View.View_IndirectLightingColorScale;
    float3 _547 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _576;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _575;
        if (any(abs(_224 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _285 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _285 + 19u)].xyz + float3(1.0))))
        {
            _575 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_224, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _575 = _547;
        }
        _576 = _575;
    }
    else
    {
        _576 = _547;
    }
    float4 _583 = float4(((mix(float3(0.0), _432 + (_434 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_525 * _432) * fast::max(float3(1.0), ((((((_339 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_339 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_339 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _576) * 1.0, 0.0);
    float4 _590;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _589 = _583;
        _589.w = 0.0;
        _590 = _589;
    }
    else
    {
        _590 = _583;
    }
    float2 _594 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _602 = (_340 * 0.5) + float3(0.5);
    float4 _604 = float4(_602.x, _602.y, _602.z, float4(0.0).w);
    _604.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _286)].y;
    float4 _605 = float4(0.0);
    _605.x = _338;
    float4 _606 = _605;
    _606.y = _337;
    float4 _607 = _606;
    _607.z = _336;
    float4 _608 = _607;
    _608.w = 0.50588238239288330078125;
    float4 _620 = float4(_339.x, _339.y, _339.z, float4(0.0).w);
    _620.w = ((log2(((dot(_525, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_436 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_436 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_436 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_594.xyx * _594.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _590 * View.View_PreExposure;
    out.out_var_SV_Target1 = _604;
    out.out_var_SV_Target2 = _608;
    out.out_var_SV_Target3 = _620;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_403, 1.0, 1.0, 1.0);
    return out;
}

