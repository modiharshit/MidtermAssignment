

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
    char _m14_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m16_pad[124];
    float View_ShowDecalsMask;
    char _m17_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_PrimitiveDither
{
    float PrimitiveDither_LODFactor;
};

struct type_Material
{
    spvUnsafeArray<float4, 7> Material_VectorExpressions;
    spvUnsafeArray<float4, 2> Material_ScalarExpressions;
};

constant float3 _154 = {};
constant float _155 = {};

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

fragment MainPS_out Main_0000400f_d8d7944c(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(6)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_PrimitiveDither& PrimitiveDither [[buffer(4)]], constant type_Material& Material [[buffer(5)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], texture2d<float> LightmapResourceCluster_StaticShadowTexture [[texture(5)]], texture2d<float> Material_Texture2D_0 [[texture(6)]], sampler View_MaterialTextureBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _209 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _155, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _214 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _219 = (_214.xyz / float3(_214.w)) - View.View_PreViewTranslation;
    float4 _223 = Material_Texture2D_0.sample(View_MaterialTextureBilinearClampedSampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y));
    float2 _226 = (_223.xy * float2(2.0)) - float2(1.0);
    float3 _242 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_226, sqrt(fast::clamp(1.0 - dot(_226, _226), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    if (PrimitiveDither.PrimitiveDither_LODFactor != 0.0)
    {
        if (abs(PrimitiveDither.PrimitiveDither_LODFactor) > 0.001000000047497451305389404296875)
        {
            float _277 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
            if ((float((PrimitiveDither.PrimitiveDither_LODFactor < 0.0) ? ((PrimitiveDither.PrimitiveDither_LODFactor + 1.0) > _277) : (PrimitiveDither.PrimitiveDither_LODFactor < _277)) - 0.001000000047497451305389404296875) < 0.0)
            {
                discard_fragment();
            }
        }
    }
    float3 _288 = fast::clamp(Material.Material_VectorExpressions[6].xyz, float3(0.0), float3(1.0));
    float _289 = fast::clamp(Material.Material_ScalarExpressions[0].z, 0.0, 1.0);
    float _290 = fast::clamp(Material.Material_ScalarExpressions[0].w, 0.0, 1.0);
    float _291 = fast::clamp(Material.Material_ScalarExpressions[1].y, 0.0, 1.0);
    float _296 = (fast::clamp(Material.Material_ScalarExpressions[1].x, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _297 = in.in_var_PRIMITIVE_ID * 36u;
    uint _298 = _297 + 20u;
    float _348;
    float _349;
    float _350;
    float3 _351;
    float3 _352;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _298)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _316 = ((_209.xy / float2(_209.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _320 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _316, level(0.0));
        float4 _323 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _316, level(0.0));
        float4 _326 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _316, level(0.0));
        float _336 = _326.w;
        _348 = (_296 * _336) + _326.z;
        _349 = (_290 * _336) + _326.y;
        _350 = (_289 * _336) + _326.x;
        _351 = (_288 * _320.w) + _320.xyz;
        _352 = normalize((_242 * _323.w) + ((_323.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _348 = _296;
        _349 = _290;
        _350 = _289;
        _351 = _288;
        _352 = _242;
    }
    float4 _359 = LightmapResourceCluster_StaticShadowTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.zw);
    uint _360 = in.in_var_LIGHTMAP_ID * 15u;
    uint _361 = _360 + 1u;
    float4 _368 = fast::clamp((_359 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _361)]) + ((View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _361)] * (-0.5)) + float4(0.5)), float4(0.0), float4(1.0));
    float3 _385 = ((_351 - (_351 * _350)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _392 = (mix(float3(0.07999999821186065673828125 * _349), _351, float3(_350)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _395 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _400;
    if (_395)
    {
        _400 = _385 + (_392 * 0.449999988079071044921875);
    }
    else
    {
        _400 = _385;
    }
    float3 _402 = select(_392, float3(0.0), bool3(_395));
    float3 _404 = float3(dot(_402, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _411 = float3(_291);
    float2 _420 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _424 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _420);
    float4 _426 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_420 + float2(0.0, 0.5)));
    uint _432 = _360 + 4u;
    uint _437 = _360 + 6u;
    float3 _442 = _424.xyz;
    float _494;
    float _495;
    float3 _496;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _478 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _482 = _478.w;
        float _483 = _482 * _482;
        float3 _485 = normalize(((_478.xyz * 2.0) - float3(1.0)).xyz);
        float _486 = 1.0 - _483;
        float _488 = 1.0 - (_486 * _486);
        _494 = mix(fast::clamp(dot(_485, _352), 0.0, 1.0), 1.0, _488);
        _495 = _483;
        _496 = mix(_485, _352, float3(_488));
    }
    else
    {
        _494 = 1.0;
        _495 = 1.0;
        _496 = _352;
    }
    float4 _500 = float4(_496, 1.0);
    float3 _504 = _154;
    _504.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _500);
    float3 _508 = _504;
    _508.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _500);
    float3 _512 = _508;
    _512.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _500);
    float4 _515 = _500.xyzz * _500.yzzx;
    float3 _519 = _154;
    _519.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _515);
    float3 _523 = _519;
    _523.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _515);
    float3 _527 = _523;
    _527.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _515);
    float3 _542 = (((((_442 * _442) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _432)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _437)].xyz) * ((exp2(((_424.w + ((_426.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _432)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _437)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_426 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _360 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _360 + 7u)], float4(_352.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_512 + _527) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_496.x * _496.x) - (_496.y * _496.y)))) * View.View_SkyLightColor.xyz) * (_495 * _494));
    float3 _564 = fast::max(mix(Material.Material_VectorExpressions[3].xyz, Material.Material_VectorExpressions[4].xyz, float3(Material.Material_ScalarExpressions[0].y)), float3(0.0));
    float3 _593;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _592;
        if (any(abs(_219 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _297 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _297 + 19u)].xyz + float3(1.0))))
        {
            _592 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_219, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _592 = _564;
        }
        _593 = _592;
    }
    else
    {
        _593 = _564;
    }
    float4 _600 = float4(((mix(float3(0.0), _400 + (_402 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_542 * _400) * fast::max(_411, ((((((_351 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _291) + ((_351 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _291) + ((_351 * 2.755199909210205078125) + float3(0.69029998779296875))) * _291))) + _593) * 1.0, 0.0);
    float4 _607;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _606 = _600;
        _606.w = 0.0;
        _607 = _606;
    }
    else
    {
        _607 = _600;
    }
    float2 _611 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _619 = (_352 * 0.5) + float3(0.5);
    float4 _621 = float4(_619.x, _619.y, _619.z, float4(0.0).w);
    _621.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _298)].y;
    float4 _622 = float4(0.0);
    _622.x = _350;
    float4 _623 = _622;
    _623.y = _349;
    float4 _624 = _623;
    _624.z = _348;
    float4 _625 = _624;
    _625.w = 0.50588238239288330078125;
    float4 _637 = float4(_351.x, _351.y, _351.z, float4(0.0).w);
    _637.w = ((log2(((dot(_542, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_411, ((((((_404 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _291) + ((_404 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _291) + ((_404 * 2.755199909210205078125) + float3(0.69029998779296875))) * _291).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_611.xyx * _611.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _607 * View.View_PreExposure;
    out.out_var_SV_Target1 = _621;
    out.out_var_SV_Target2 = _625;
    out.out_var_SV_Target3 = _637;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = (View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _360)] * _368) * _368;
    return out;
}

