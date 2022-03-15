

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
    char _m11_pad[16];
    float View_OutOfBoundsMask;
    char _m12_pad[48];
    float View_MaterialTextureMipBias;
    char _m13_pad[28];
    float View_UnlitViewmodeMask;
    char _m14_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m15_pad[604];
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
    spvUnsafeArray<float4, 8> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _172 = {};
constant float4 _174 = {};

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

fragment MainPS_out Main_000040b7_9b6ce4a4(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _226 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _230 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _235 = (_230.xyz / float3(_230.w)) - View.View_PreViewTranslation;
    float2 _236 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5;
    float4 _242 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _236, bias(View.View_MaterialTextureMipBias));
    float2 _245 = (_242.xy * float2(2.0)) - float2(1.0);
    float2 _253 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125;
    float4 _257 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _253, bias(View.View_MaterialTextureMipBias));
    float _284;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _284 = _226.w;
                break;
            }
            else
            {
                float _268 = _226.z;
                _284 = ((_268 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_268 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _291 = float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _257.x) + _284) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0));
    float3 _300 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(float4(_245, sqrt(fast::clamp(1.0 - dot(_245, _245), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), _291) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _311 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _236, bias(View.View_MaterialTextureMipBias));
    float4 _327 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.75) * 0.00999999977648258209228515625), bias(View.View_MaterialTextureMipBias));
    float3 _333 = mix(Material.Material_VectorExpressions[3].xyz * _311.y, _311.xyz * Material.Material_VectorExpressions[5].xyz, float3(fast::min(fast::max(mix(-0.25, 2.0, _327.x), 0.0), 1.0)));
    float4 _335 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _253, bias(View.View_MaterialTextureMipBias));
    float4 _343 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.004999999888241291046142578125), bias(View.View_MaterialTextureMipBias));
    float3 _348 = fast::clamp(mix(_333, mix(_333, mix(_335.xyz, Material.Material_VectorExpressions[7].xyz, float3(0.300000011920928955078125)), float3(_343.x)), _291), float3(0.0), float3(1.0));
    uint _349 = in.in_var_PRIMITIVE_ID * 36u;
    uint _350 = _349 + 20u;
    float _397;
    float _398;
    float _399;
    float3 _400;
    float3 _401;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _350)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _368 = ((_226.xy / float2(_226.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _372 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _368, level(0.0));
        float4 _375 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _368, level(0.0));
        float4 _378 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _368, level(0.0));
        float _388 = _378.w;
        _397 = _388 + _378.z;
        _398 = (0.5 * _388) + _378.y;
        _399 = _378.x;
        _400 = (_348 * _372.w) + _372.xyz;
        _401 = normalize((_300 * _375.w) + ((_375.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _397 = 1.0;
        _398 = 0.5;
        _399 = 0.0;
        _400 = _348;
        _401 = _300;
    }
    bool _411 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _417;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _349 + 18u)].w > 0.0) && _411)
    {
        _417 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _417 = 1.0;
    }
    float _464;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _350)].z > 0.0)
    {
        float3 _432 = fast::clamp((_235 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _443 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_432.x), int(_432.y), int(_432.z), 0).xyz), 0));
        _464 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_443.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_432 / float3(_443.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _464 = _417;
    }
    float3 _487 = (((_400 - (_400 * _399)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz) + (((mix(float3(0.07999999821186065673828125 * _398), _400, float3(_399)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz) * 0.449999988079071044921875);
    float3 _560;
    if (_411)
    {
        float4 _510 = _174;
        _510.y = (-0.48860299587249755859375) * _401.y;
        float4 _513 = _510;
        _513.z = 0.48860299587249755859375 * _401.z;
        float4 _516 = _513;
        _516.w = (-0.48860299587249755859375) * _401.x;
        float3 _517 = _401 * _401;
        float4 _520 = _172;
        _520.x = (1.09254801273345947265625 * _401.x) * _401.y;
        float4 _523 = _520;
        _523.y = ((-1.09254801273345947265625) * _401.y) * _401.z;
        float4 _528 = _523;
        _528.z = 0.3153919875621795654296875 * ((3.0 * _517.z) - 1.0);
        float4 _531 = _528;
        _531.w = ((-1.09254801273345947265625) * _401.x) * _401.z;
        float4 _535 = _516;
        _535.x = 0.886227548122406005859375;
        float3 _537 = _535.yzw * 2.094395160675048828125;
        float4 _538 = float4(_535.x, _537.x, _537.y, _537.z);
        float4 _539 = _531 * 0.785398185253143310546875;
        float _540 = (_517.x - _517.y) * 0.4290426075458526611328125;
        float3 _546 = float3(0.0);
        _546.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _538) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _539)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _540);
        float3 _552 = _546;
        _552.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _538) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _539)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _540);
        float3 _558 = _552;
        _558.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _538) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _539)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _540);
        _560 = fast::max(float3(0.0), _558);
    }
    else
    {
        _560 = float3(0.0);
    }
    float3 _563 = _560 * View.View_IndirectLightingColorScale;
    float3 _583 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _612;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _611;
        if (any(abs(_235 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _349 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _349 + 19u)].xyz + float3(1.0))))
        {
            _611 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_235, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _611 = _583;
        }
        _612 = _611;
    }
    else
    {
        _612 = _583;
    }
    float4 _619 = float4(((mix(float3(0.0), _487, float3(View.View_UnlitViewmodeMask)) + ((_563 * _487) * fast::max(float3(1.0), ((((((_400 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_400 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_400 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _612) * 1.0, 0.0);
    float4 _626;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _625 = _619;
        _625.w = 0.0;
        _626 = _625;
    }
    else
    {
        _626 = _619;
    }
    float2 _630 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _638 = (_401 * 0.5) + float3(0.5);
    float4 _640 = float4(_638.x, _638.y, _638.z, float4(0.0).w);
    _640.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _350)].y;
    float4 _641 = float4(0.0);
    _641.x = _399;
    float4 _642 = _641;
    _642.y = _398;
    float4 _643 = _642;
    _643.z = _397;
    float4 _644 = _643;
    _644.w = 0.50588238239288330078125;
    float4 _655 = float4(_400.x, _400.y, _400.z, float4(0.0).w);
    _655.w = ((log2((dot(_563, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_630.xyx * _630.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _626 * View.View_PreExposure;
    out.out_var_SV_Target1 = _640;
    out.out_var_SV_Target2 = _644;
    out.out_var_SV_Target3 = _655;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_464, 1.0, 1.0, 1.0);
    return out;
}

