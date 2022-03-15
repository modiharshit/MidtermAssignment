

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
    char _m0_pad[448];
    float4x4 View_ViewToClip;
    char _m1_pad[192];
    float4x4 View_SVPositionToTranslatedWorld;
    char _m2_pad[272];
    float4 View_InvDeviceZToWorldZTransform;
    float4 View_ScreenPositionScaleBias;
    char _m4_pad[48];
    float3 View_PreViewTranslation;
    char _m5_pad[928];
    float4 View_ViewRectMin;
    float4 View_ViewSizeAndInvSize;
    char _m7_pad[68];
    float View_PreExposure;
    float4 View_DiffuseOverrideParameter;
    float4 View_SpecularOverrideParameter;
    float4 View_NormalOverrideParameter;
    float2 View_RoughnessOverrideParameter;
    char _m12_pad[8];
    float View_OutOfBoundsMask;
    char _m13_pad[48];
    float View_MaterialTextureMipBias;
    char _m14_pad[28];
    float View_UnlitViewmodeMask;
    char _m15_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m16_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m17_pad[188];
    float View_ShowDecalsMask;
    char _m18_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m19_pad[48];
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

constant float4 _171 = {};
constant float4 _173 = {};

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

fragment MainPS_out Main_0000441e_85dc3ff5(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _230 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _234 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _239 = (_234.xyz / float3(_234.w)) - View.View_PreViewTranslation;
    float4 _245 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _248 = (_245.xy * float2(2.0)) - float2(1.0);
    float4 _260 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _287;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _287 = _230.w;
                break;
            }
            else
            {
                float _271 = _230.z;
                _287 = ((_271 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_271 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _303 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(float4(_248, sqrt(fast::clamp(1.0 - dot(_248, _248), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _260.x) + _287) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _315 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _320 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _325 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _329 = (_315.x + 0.5) * ((_320.x + 0.5) * (_325.x + 0.5));
    float4 _335 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _341 = fast::clamp(mix(float3(0.20000000298023223876953125), float3(1.0), float3(_329)) * _335.xyz, float3(0.0), float3(1.0));
    float _346 = (fast::clamp(mix(0.4000000059604644775390625, 0.800000011920928955078125, _329 * _335.w), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _347 = in.in_var_PRIMITIVE_ID * 36u;
    uint _348 = _347 + 20u;
    float _396;
    float _397;
    float _398;
    float3 _399;
    float3 _400;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _348)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _366 = ((_230.xy / float2(_230.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _370 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _366, level(0.0));
        float4 _373 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _366, level(0.0));
        float4 _376 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _366, level(0.0));
        float _386 = _376.w;
        _396 = (_346 * _386) + _376.z;
        _397 = (0.5 * _386) + _376.y;
        _398 = _376.x;
        _399 = (_341 * _370.w) + _370.xyz;
        _400 = normalize((_303 * _373.w) + ((_373.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _396 = _346;
        _397 = 0.5;
        _398 = 0.0;
        _399 = _341;
        _400 = _303;
    }
    bool _410 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _416;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _347 + 18u)].w > 0.0) && _410)
    {
        _416 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _416 = 1.0;
    }
    float _463;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _348)].z > 0.0)
    {
        float3 _431 = fast::clamp((_239 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _442 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_431.x), int(_431.y), int(_431.z), 0).xyz), 0));
        _463 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_442.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_431 / float3(_442.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _463 = _416;
    }
    float3 _477 = ((_399 - (_399 * _398)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _484 = (mix(float3(0.07999999821186065673828125 * _397), _399, float3(_398)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _487 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _492;
    if (_487)
    {
        _492 = _477 + (_484 * 0.449999988079071044921875);
    }
    else
    {
        _492 = _477;
    }
    float3 _494 = select(_484, float3(0.0), bool3(_487));
    float3 _496 = float3(dot(_494, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _582;
    if (_410)
    {
        float4 _532 = _173;
        _532.y = (-0.48860299587249755859375) * _400.y;
        float4 _535 = _532;
        _535.z = 0.48860299587249755859375 * _400.z;
        float4 _538 = _535;
        _538.w = (-0.48860299587249755859375) * _400.x;
        float3 _539 = _400 * _400;
        float4 _542 = _171;
        _542.x = (1.09254801273345947265625 * _400.x) * _400.y;
        float4 _545 = _542;
        _545.y = ((-1.09254801273345947265625) * _400.y) * _400.z;
        float4 _550 = _545;
        _550.z = 0.3153919875621795654296875 * ((3.0 * _539.z) - 1.0);
        float4 _553 = _550;
        _553.w = ((-1.09254801273345947265625) * _400.x) * _400.z;
        float4 _557 = _538;
        _557.x = 0.886227548122406005859375;
        float3 _559 = _557.yzw * 2.094395160675048828125;
        float4 _560 = float4(_557.x, _559.x, _559.y, _559.z);
        float4 _561 = _553 * 0.785398185253143310546875;
        float _562 = (_539.x - _539.y) * 0.4290426075458526611328125;
        float3 _568 = float3(0.0);
        _568.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _560) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _561)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _562);
        float3 _574 = _568;
        _574.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _560) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _561)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _562);
        float3 _580 = _574;
        _580.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _560) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _561)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _562);
        _582 = fast::max(float3(0.0), _580);
    }
    else
    {
        _582 = float3(0.0);
    }
    float3 _585 = _582 * View.View_IndirectLightingColorScale;
    float3 _607 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _636;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _635;
        if (any(abs(_239 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _347 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _347 + 19u)].xyz + float3(1.0))))
        {
            _635 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_239, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _635 = _607;
        }
        _636 = _635;
    }
    else
    {
        _636 = _607;
    }
    float4 _643 = float4(((mix(float3(0.0), _492 + (_494 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_585 * _492) * fast::max(float3(1.0), ((((((_399 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_399 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_399 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _636) * 1.0, 0.0);
    float4 _650;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _649 = _643;
        _649.w = 0.0;
        _650 = _649;
    }
    else
    {
        _650 = _643;
    }
    float2 _654 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _662 = (_400 * 0.5) + float3(0.5);
    float4 _664 = float4(_662.x, _662.y, _662.z, float4(0.0).w);
    _664.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _348)].y;
    float4 _665 = float4(0.0);
    _665.x = _398;
    float4 _666 = _665;
    _666.y = _397;
    float4 _667 = _666;
    _667.z = _396;
    float4 _668 = _667;
    _668.w = 0.50588238239288330078125;
    float4 _680 = float4(_399.x, _399.y, _399.z, float4(0.0).w);
    _680.w = ((log2(((dot(_585, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_496 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_496 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_496 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_654.xyx * _654.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _650 * View.View_PreExposure;
    out.out_var_SV_Target1 = _664;
    out.out_var_SV_Target2 = _668;
    out.out_var_SV_Target3 = _680;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_463, 1.0, 1.0, 1.0);
    return out;
}

