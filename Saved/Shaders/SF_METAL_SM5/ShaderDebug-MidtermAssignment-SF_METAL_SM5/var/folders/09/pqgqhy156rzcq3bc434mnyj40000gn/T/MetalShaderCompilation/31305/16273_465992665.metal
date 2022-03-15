

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
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _161 = {};
constant float _163 = {};
constant float4 _164 = {};

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

fragment MainPS_out Main_00003f91_1bc67bd9(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _218 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _163, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _223 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _228 = (_223.xyz / float3(_223.w)) - View.View_PreViewTranslation;
    float4 _234 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _237 = (_234.xy * float2(2.0)) - float2(1.0);
    float3 _253 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_237, sqrt(fast::clamp(1.0 - dot(_237, _237), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _265 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _270 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _275 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _279 = (_265.x + 0.5) * ((_270.x + 0.5) * (_275.x + 0.5));
    float4 _285 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _291 = fast::clamp(mix(float3(0.5), float3(1.0), float3(_279)) * _285.xyz, float3(0.0), float3(1.0));
    float _296 = (fast::clamp(mix(0.60000002384185791015625, 0.4000000059604644775390625, _279 * _285.w), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _297 = in.in_var_PRIMITIVE_ID * 36u;
    uint _298 = _297 + 20u;
    float _347;
    float _348;
    float _349;
    float3 _350;
    float3 _351;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _298)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _316 = ((_218.xy / float2(_218.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _320 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _316, level(0.0));
        float4 _323 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _316, level(0.0));
        float4 _326 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _316, level(0.0));
        float _336 = _326.w;
        _347 = (_296 * _336) + _326.z;
        _348 = (0.5 * _336) + _326.y;
        _349 = _336 + _326.x;
        _350 = (_291 * _320.w) + _320.xyz;
        _351 = normalize((_253 * _323.w) + ((_323.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _347 = _296;
        _348 = 0.5;
        _349 = 1.0;
        _350 = _291;
        _351 = _253;
    }
    bool _361 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _367;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _297 + 18u)].w > 0.0) && _361)
    {
        _367 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _367 = 1.0;
    }
    float _414;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _298)].z > 0.0)
    {
        float3 _382 = fast::clamp((_228 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _393 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_382.x), int(_382.y), int(_382.z), 0).xyz), 0));
        _414 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_393.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_382 / float3(_393.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _414 = _367;
    }
    float3 _428 = ((_350 - (_350 * _349)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _435 = (mix(float3(0.07999999821186065673828125 * _348), _350, float3(_349)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _438 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _443;
    if (_438)
    {
        _443 = _428 + (_435 * 0.449999988079071044921875);
    }
    else
    {
        _443 = _428;
    }
    float3 _445 = select(_435, float3(0.0), bool3(_438));
    float3 _447 = float3(dot(_445, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _533;
    if (_361)
    {
        float4 _483 = _164;
        _483.y = (-0.48860299587249755859375) * _351.y;
        float4 _486 = _483;
        _486.z = 0.48860299587249755859375 * _351.z;
        float4 _489 = _486;
        _489.w = (-0.48860299587249755859375) * _351.x;
        float3 _490 = _351 * _351;
        float4 _493 = _161;
        _493.x = (1.09254801273345947265625 * _351.x) * _351.y;
        float4 _496 = _493;
        _496.y = ((-1.09254801273345947265625) * _351.y) * _351.z;
        float4 _501 = _496;
        _501.z = 0.3153919875621795654296875 * ((3.0 * _490.z) - 1.0);
        float4 _504 = _501;
        _504.w = ((-1.09254801273345947265625) * _351.x) * _351.z;
        float4 _508 = _489;
        _508.x = 0.886227548122406005859375;
        float3 _510 = _508.yzw * 2.094395160675048828125;
        float4 _511 = float4(_508.x, _510.x, _510.y, _510.z);
        float4 _512 = _504 * 0.785398185253143310546875;
        float _513 = (_490.x - _490.y) * 0.4290426075458526611328125;
        float3 _519 = float3(0.0);
        _519.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _511) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _512)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _513);
        float3 _525 = _519;
        _525.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _511) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _512)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _513);
        float3 _531 = _525;
        _531.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _511) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _512)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _513);
        _533 = fast::max(float3(0.0), _531);
    }
    else
    {
        _533 = float3(0.0);
    }
    float3 _536 = _533 * View.View_IndirectLightingColorScale;
    float3 _558 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _587;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _586;
        if (any(abs(_228 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _297 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _297 + 19u)].xyz + float3(1.0))))
        {
            _586 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_228, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _586 = _558;
        }
        _587 = _586;
    }
    else
    {
        _587 = _558;
    }
    float4 _594 = float4(((mix(float3(0.0), _443 + (_445 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_536 * _443) * fast::max(float3(1.0), ((((((_350 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_350 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_350 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _587) * 1.0, 0.0);
    float4 _601;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _600 = _594;
        _600.w = 0.0;
        _601 = _600;
    }
    else
    {
        _601 = _594;
    }
    float2 _605 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _613 = (_351 * 0.5) + float3(0.5);
    float4 _615 = float4(_613.x, _613.y, _613.z, float4(0.0).w);
    _615.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _298)].y;
    float4 _616 = float4(0.0);
    _616.x = _349;
    float4 _617 = _616;
    _617.y = _348;
    float4 _618 = _617;
    _618.z = _347;
    float4 _619 = _618;
    _619.w = 0.50588238239288330078125;
    float4 _631 = float4(_350.x, _350.y, _350.z, float4(0.0).w);
    _631.w = ((log2(((dot(_536, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_447 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_447 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_447 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_605.xyx * _605.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _601 * View.View_PreExposure;
    out.out_var_SV_Target1 = _615;
    out.out_var_SV_Target2 = _619;
    out.out_var_SV_Target3 = _631;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_414, 1.0, 1.0, 1.0);
    return out;
}

