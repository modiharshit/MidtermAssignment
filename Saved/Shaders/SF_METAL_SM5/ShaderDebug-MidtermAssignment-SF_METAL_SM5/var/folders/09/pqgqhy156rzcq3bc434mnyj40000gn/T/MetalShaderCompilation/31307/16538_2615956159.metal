

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
    char _m15_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m17_pad[124];
    float View_ShowDecalsMask;
    char _m18_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float3 _150 = {};
constant float _151 = {};

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
    float4 in_var_TEXCOORD4 [[user(locn3)]];
    uint in_var_PRIMITIVE_ID [[user(locn4)]];
    uint in_var_LIGHTMAP_ID [[user(locn5)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_0000409a_9bec52bf(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float3x3 _195 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _206 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _151, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _211 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _215 = _211.xyz / float3(_211.w);
    float3 _216 = _215 - View.View_PreViewTranslation;
    float2 _220 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5;
    float4 _226 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _220, bias(View.View_MaterialTextureMipBias));
    float2 _232 = ((normalize(-_215) * _195).xy * ((0.00999999977648258209228515625 * _226.w) + (-0.008000000379979610443115234375))) + _220;
    float4 _236 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _232, bias(View.View_MaterialTextureMipBias));
    float2 _239 = (_236.xy * float2(2.0)) - float2(1.0);
    float3 _255 = normalize(_195 * normalize((float4(_239, sqrt(fast::clamp(1.0 - dot(_239, _239), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _267 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _272 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _277 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _281 = (_267.x + 0.5) * ((_272.x + 0.5) * (_277.x + 0.5));
    float4 _284 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _232, bias(View.View_MaterialTextureMipBias));
    float4 _290 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _232, bias(View.View_MaterialTextureMipBias));
    float3 _295 = fast::clamp(_284.xyz * mix(0.5, 1.0, _281), float3(0.0), float3(1.0));
    float _296 = fast::clamp(_290.y, 0.0, 1.0);
    float _301 = (fast::clamp(mix(0.300000011920928955078125, 0.800000011920928955078125, _281 * _290.x), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _302 = in.in_var_PRIMITIVE_ID * 36u;
    uint _303 = _302 + 20u;
    float _351;
    float _352;
    float _353;
    float3 _354;
    float3 _355;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _303)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _321 = ((_206.xy / float2(_206.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _325 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _321, level(0.0));
        float4 _328 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _321, level(0.0));
        float4 _331 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _321, level(0.0));
        float _341 = _331.w;
        _351 = (_301 * _341) + _331.z;
        _352 = (0.5 * _341) + _331.y;
        _353 = _331.x;
        _354 = (_295 * _325.w) + _325.xyz;
        _355 = normalize((_255 * _328.w) + ((_328.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _351 = _301;
        _352 = 0.5;
        _353 = 0.0;
        _354 = _295;
        _355 = _255;
    }
    float3 _370 = ((_354 - (_354 * _353)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _377 = (mix(float3(0.07999999821186065673828125 * _352), _354, float3(_353)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _380 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _385;
    if (_380)
    {
        _385 = _370 + (_377 * 0.449999988079071044921875);
    }
    else
    {
        _385 = _370;
    }
    float3 _387 = select(_377, float3(0.0), bool3(_380));
    float3 _389 = float3(dot(_387, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _396 = float3(_296);
    float2 _405 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _410 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _405);
    float4 _412 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_405 + float2(0.0, 0.5)));
    uint _418 = in.in_var_LIGHTMAP_ID * 15u;
    uint _419 = _418 + 4u;
    uint _424 = _418 + 6u;
    float3 _429 = _410.xyz;
    float _481;
    float _482;
    float3 _483;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _465 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _469 = _465.w;
        float _470 = _469 * _469;
        float3 _472 = normalize(((_465.xyz * 2.0) - float3(1.0)).xyz);
        float _473 = 1.0 - _470;
        float _475 = 1.0 - (_473 * _473);
        _481 = mix(fast::clamp(dot(_472, _355), 0.0, 1.0), 1.0, _475);
        _482 = _470;
        _483 = mix(_472, _355, float3(_475));
    }
    else
    {
        _481 = 1.0;
        _482 = 1.0;
        _483 = _355;
    }
    float4 _487 = float4(_483, 1.0);
    float3 _491 = _150;
    _491.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _487);
    float3 _495 = _491;
    _495.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _487);
    float3 _499 = _495;
    _499.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _487);
    float4 _502 = _487.xyzz * _487.yzzx;
    float3 _506 = _150;
    _506.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _502);
    float3 _510 = _506;
    _510.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _502);
    float3 _514 = _510;
    _514.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _502);
    float3 _529 = (((((_429 * _429) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _419)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _424)].xyz) * ((exp2(((_410.w + ((_412.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _419)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _424)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_412 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _418 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _418 + 7u)], float4(_355.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_499 + _514) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_483.x * _483.x) - (_483.y * _483.y)))) * View.View_SkyLightColor.xyz) * (_482 * _481));
    float3 _551 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _580;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _579;
        if (any(abs(_216 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _302 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _302 + 19u)].xyz + float3(1.0))))
        {
            _579 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_216, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _579 = _551;
        }
        _580 = _579;
    }
    else
    {
        _580 = _551;
    }
    float4 _587 = float4(((mix(float3(0.0), _385 + (_387 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_529 * _385) * fast::max(_396, ((((((_354 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _296) + ((_354 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _296) + ((_354 * 2.755199909210205078125) + float3(0.69029998779296875))) * _296))) + _580) * 1.0, 0.0);
    float4 _594;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _593 = _587;
        _593.w = 0.0;
        _594 = _593;
    }
    else
    {
        _594 = _587;
    }
    float2 _598 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _606 = (_355 * 0.5) + float3(0.5);
    float4 _608 = float4(_606.x, _606.y, _606.z, float4(0.0).w);
    _608.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _303)].y;
    float4 _609 = float4(0.0);
    _609.x = _353;
    float4 _610 = _609;
    _610.y = _352;
    float4 _611 = _610;
    _611.z = _351;
    float4 _612 = _611;
    _612.w = 0.75686275959014892578125;
    float4 _624 = float4(_354.x, _354.y, _354.z, float4(0.0).w);
    _624.w = ((log2(((dot(_529, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_396, ((((((_389 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _296) + ((_389 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _296) + ((_389 * 2.755199909210205078125) + float3(0.69029998779296875))) * _296).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_598.xyx * _598.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _594 * View.View_PreExposure;
    out.out_var_SV_Target1 = _608;
    out.out_var_SV_Target2 = _612;
    out.out_var_SV_Target3 = _624;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

