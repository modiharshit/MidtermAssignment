

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

constant float4 _169 = {};
constant float _171 = {};
constant float4 _172 = {};

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

fragment MainPS_out Main_0000438e_15886993(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], texture2d<float> Material_Texture2D_4 [[texture(9)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], sampler Material_Texture2D_4Sampler [[sampler(6)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float3x3 _215 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _226 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _171, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _231 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _235 = _231.xyz / float3(_231.w);
    float3 _236 = _235 - View.View_PreViewTranslation;
    float2 _240 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5;
    float4 _246 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _240, bias(View.View_MaterialTextureMipBias));
    float2 _252 = ((normalize(-_235) * _215).xy * ((0.00999999977648258209228515625 * _246.w) + (-0.004999999888241291046142578125))) + _240;
    float4 _256 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _252, bias(View.View_MaterialTextureMipBias));
    float2 _259 = (_256.xy * float2(2.0)) - float2(1.0);
    float4 _272 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.100000001490116119384765625), bias(2.0 + View.View_MaterialTextureMipBias));
    float2 _275 = (_272.xy * float2(2.0)) - float2(1.0);
    float3 _294 = normalize(_215 * normalize(((float4(_259, sqrt(fast::clamp(1.0 - dot(_259, _259), 0.0, 1.0)), 1.0).xyz + (float4(_275, sqrt(fast::clamp(1.0 - dot(_275, _275), 0.0, 1.0)), 1.0).xyz * float3(0.20000000298023223876953125, 0.20000000298023223876953125, 0.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _306 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _311 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _314 = (_306.x + 0.5) * (_311.x + 0.5);
    float4 _317 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _252, bias(View.View_MaterialTextureMipBias));
    float4 _323 = Material_Texture2D_4.sample(Material_Texture2D_4Sampler, _252, bias(View.View_MaterialTextureMipBias));
    float3 _329 = fast::clamp(_317.xyz * mix(0.5, 1.0, _314), float3(0.0), float3(1.0));
    float _330 = fast::clamp(_323.y, 0.0, 1.0);
    float _335 = (fast::clamp(mix(-0.300000011920928955078125, 0.800000011920928955078125, _323.x + (_314 * 0.20000000298023223876953125)), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _336 = in.in_var_PRIMITIVE_ID * 36u;
    uint _337 = _336 + 20u;
    float _385;
    float _386;
    float _387;
    float3 _388;
    float3 _389;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _337)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _355 = ((_226.xy / float2(_226.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _359 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _355, level(0.0));
        float4 _362 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _355, level(0.0));
        float4 _365 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _355, level(0.0));
        float _375 = _365.w;
        _385 = (_335 * _375) + _365.z;
        _386 = (0.5 * _375) + _365.y;
        _387 = _365.x;
        _388 = (_329 * _359.w) + _359.xyz;
        _389 = normalize((_294 * _362.w) + ((_362.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _385 = _335;
        _386 = 0.5;
        _387 = 0.0;
        _388 = _329;
        _389 = _294;
    }
    bool _399 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _405;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _336 + 18u)].w > 0.0) && _399)
    {
        _405 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _405 = 1.0;
    }
    float _452;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _337)].z > 0.0)
    {
        float3 _420 = fast::clamp((_236 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _431 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_420.x), int(_420.y), int(_420.z), 0).xyz), 0));
        _452 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_431.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_420 / float3(_431.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _452 = _405;
    }
    float3 _466 = ((_388 - (_388 * _387)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _473 = (mix(float3(0.07999999821186065673828125 * _386), _388, float3(_387)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _476 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _481;
    if (_476)
    {
        _481 = _466 + (_473 * 0.449999988079071044921875);
    }
    else
    {
        _481 = _466;
    }
    float3 _483 = select(_473, float3(0.0), bool3(_476));
    float3 _485 = float3(dot(_483, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _492 = float3(_330);
    float3 _572;
    if (_399)
    {
        float4 _522 = _172;
        _522.y = (-0.48860299587249755859375) * _389.y;
        float4 _525 = _522;
        _525.z = 0.48860299587249755859375 * _389.z;
        float4 _528 = _525;
        _528.w = (-0.48860299587249755859375) * _389.x;
        float3 _529 = _389 * _389;
        float4 _532 = _169;
        _532.x = (1.09254801273345947265625 * _389.x) * _389.y;
        float4 _535 = _532;
        _535.y = ((-1.09254801273345947265625) * _389.y) * _389.z;
        float4 _540 = _535;
        _540.z = 0.3153919875621795654296875 * ((3.0 * _529.z) - 1.0);
        float4 _543 = _540;
        _543.w = ((-1.09254801273345947265625) * _389.x) * _389.z;
        float4 _547 = _528;
        _547.x = 0.886227548122406005859375;
        float3 _549 = _547.yzw * 2.094395160675048828125;
        float4 _550 = float4(_547.x, _549.x, _549.y, _549.z);
        float4 _551 = _543 * 0.785398185253143310546875;
        float _552 = (_529.x - _529.y) * 0.4290426075458526611328125;
        float3 _558 = float3(0.0);
        _558.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _550) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _551)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _552);
        float3 _564 = _558;
        _564.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _550) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _551)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _552);
        float3 _570 = _564;
        _570.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _550) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _551)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _552);
        _572 = fast::max(float3(0.0), _570);
    }
    else
    {
        _572 = float3(0.0);
    }
    float3 _575 = _572 * View.View_IndirectLightingColorScale;
    float3 _597 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _626;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _625;
        if (any(abs(_236 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _336 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _336 + 19u)].xyz + float3(1.0))))
        {
            _625 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_236, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _625 = _597;
        }
        _626 = _625;
    }
    else
    {
        _626 = _597;
    }
    float4 _633 = float4(((mix(float3(0.0), _481 + (_483 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_575 * _481) * fast::max(_492, ((((((_388 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _330) + ((_388 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _330) + ((_388 * 2.755199909210205078125) + float3(0.69029998779296875))) * _330))) + _626) * 1.0, 0.0);
    float4 _640;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _639 = _633;
        _639.w = 0.0;
        _640 = _639;
    }
    else
    {
        _640 = _633;
    }
    float2 _644 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _652 = (_389 * 0.5) + float3(0.5);
    float4 _654 = float4(_652.x, _652.y, _652.z, float4(0.0).w);
    _654.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _337)].y;
    float4 _655 = float4(0.0);
    _655.x = _387;
    float4 _656 = _655;
    _656.y = _386;
    float4 _657 = _656;
    _657.z = _385;
    float4 _658 = _657;
    _658.w = 0.50588238239288330078125;
    float4 _670 = float4(_388.x, _388.y, _388.z, float4(0.0).w);
    _670.w = ((log2(((dot(_575, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_492, ((((((_485 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _330) + ((_485 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _330) + ((_485 * 2.755199909210205078125) + float3(0.69029998779296875))) * _330).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_644.xyx * _644.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _640 * View.View_PreExposure;
    out.out_var_SV_Target1 = _654;
    out.out_var_SV_Target2 = _658;
    out.out_var_SV_Target3 = _670;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_452, 1.0, 1.0, 1.0);
    return out;
}

