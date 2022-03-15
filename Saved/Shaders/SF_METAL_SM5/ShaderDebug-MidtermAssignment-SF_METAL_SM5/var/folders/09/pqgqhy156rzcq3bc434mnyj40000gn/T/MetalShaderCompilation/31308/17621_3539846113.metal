

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

constant float3 _159 = {};
constant float _160 = {};

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

fragment MainPS_out Main_000044d5_d2fdc3e1(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], texture2d<float> LightmapResourceCluster_StaticShadowTexture [[texture(5)]], texture2d<float> Material_Texture2D_0 [[texture(6)]], texture2d<float> Material_Texture2D_1 [[texture(7)]], texture2d<float> Material_Texture2D_2 [[texture(8)]], texture2d<float> Material_Texture2D_3 [[texture(9)]], texture2d<float> Material_Texture2D_4 [[texture(10)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], sampler Material_Texture2D_4Sampler [[sampler(6)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float3x3 _204 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _215 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _160, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _220 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _224 = _220.xyz / float3(_220.w);
    float3 _225 = _224 - View.View_PreViewTranslation;
    float2 _229 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5;
    float4 _235 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _229, bias(View.View_MaterialTextureMipBias));
    float2 _241 = ((normalize(-_224) * _204).xy * ((0.004999999888241291046142578125 * _235.w) + (-0.00449999980628490447998046875))) + _229;
    float4 _245 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _241, bias(View.View_MaterialTextureMipBias));
    float2 _248 = (_245.xy * float2(2.0)) - float2(1.0);
    float4 _261 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.100000001490116119384765625), bias(2.0 + View.View_MaterialTextureMipBias));
    float2 _264 = (_261.xy * float2(2.0)) - float2(1.0);
    float3 _283 = normalize(_204 * normalize(((float4(_248, sqrt(fast::clamp(1.0 - dot(_248, _248), 0.0, 1.0)), 1.0).xyz + (float4(_264, sqrt(fast::clamp(1.0 - dot(_264, _264), 0.0, 1.0)), 1.0).xyz * float3(0.20000000298023223876953125, 0.20000000298023223876953125, 0.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _295 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _300 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _303 = (_295.x + 0.5) * (_300.x + 0.5);
    float4 _306 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _241, bias(View.View_MaterialTextureMipBias));
    float4 _312 = Material_Texture2D_4.sample(Material_Texture2D_4Sampler, _241, bias(View.View_MaterialTextureMipBias));
    float3 _318 = fast::clamp(_306.xyz * mix(0.5, 1.0, _303), float3(0.0), float3(1.0));
    float _319 = fast::clamp(_312.y, 0.0, 1.0);
    float _324 = (fast::clamp(mix(-0.300000011920928955078125, 0.800000011920928955078125, _312.x + (_303 * 0.20000000298023223876953125)), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _325 = in.in_var_PRIMITIVE_ID * 36u;
    uint _326 = _325 + 20u;
    float _374;
    float _375;
    float _376;
    float3 _377;
    float3 _378;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _326)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _344 = ((_215.xy / float2(_215.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _348 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _344, level(0.0));
        float4 _351 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _344, level(0.0));
        float4 _354 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _344, level(0.0));
        float _364 = _354.w;
        _374 = (_324 * _364) + _354.z;
        _375 = (0.5 * _364) + _354.y;
        _376 = _354.x;
        _377 = (_318 * _348.w) + _348.xyz;
        _378 = normalize((_283 * _351.w) + ((_351.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _374 = _324;
        _375 = 0.5;
        _376 = 0.0;
        _377 = _318;
        _378 = _283;
    }
    float4 _385 = LightmapResourceCluster_StaticShadowTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.zw);
    uint _386 = in.in_var_LIGHTMAP_ID * 15u;
    uint _387 = _386 + 1u;
    float4 _394 = fast::clamp((_385 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _387)]) + ((View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _387)] * (-0.5)) + float4(0.5)), float4(0.0), float4(1.0));
    float3 _411 = ((_377 - (_377 * _376)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _418 = (mix(float3(0.07999999821186065673828125 * _375), _377, float3(_376)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _421 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _426;
    if (_421)
    {
        _426 = _411 + (_418 * 0.449999988079071044921875);
    }
    else
    {
        _426 = _411;
    }
    float3 _428 = select(_418, float3(0.0), bool3(_421));
    float3 _430 = float3(dot(_428, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _437 = float3(_319);
    float2 _446 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _450 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _446);
    float4 _452 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_446 + float2(0.0, 0.5)));
    uint _458 = _386 + 4u;
    uint _463 = _386 + 6u;
    float3 _468 = _450.xyz;
    float _520;
    float _521;
    float3 _522;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _504 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _508 = _504.w;
        float _509 = _508 * _508;
        float3 _511 = normalize(((_504.xyz * 2.0) - float3(1.0)).xyz);
        float _512 = 1.0 - _509;
        float _514 = 1.0 - (_512 * _512);
        _520 = mix(fast::clamp(dot(_511, _378), 0.0, 1.0), 1.0, _514);
        _521 = _509;
        _522 = mix(_511, _378, float3(_514));
    }
    else
    {
        _520 = 1.0;
        _521 = 1.0;
        _522 = _378;
    }
    float4 _526 = float4(_522, 1.0);
    float3 _530 = _159;
    _530.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _526);
    float3 _534 = _530;
    _534.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _526);
    float3 _538 = _534;
    _538.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _526);
    float4 _541 = _526.xyzz * _526.yzzx;
    float3 _545 = _159;
    _545.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _541);
    float3 _549 = _545;
    _549.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _541);
    float3 _553 = _549;
    _553.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _541);
    float3 _568 = (((((_468 * _468) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _458)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _463)].xyz) * ((exp2(((_450.w + ((_452.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _458)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _463)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_452 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _386 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _386 + 7u)], float4(_378.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_538 + _553) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_522.x * _522.x) - (_522.y * _522.y)))) * View.View_SkyLightColor.xyz) * (_521 * _520));
    float3 _590 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _619;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _618;
        if (any(abs(_225 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _325 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _325 + 19u)].xyz + float3(1.0))))
        {
            _618 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_225, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _618 = _590;
        }
        _619 = _618;
    }
    else
    {
        _619 = _590;
    }
    float4 _626 = float4(((mix(float3(0.0), _426 + (_428 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_568 * _426) * fast::max(_437, ((((((_377 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _319) + ((_377 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _319) + ((_377 * 2.755199909210205078125) + float3(0.69029998779296875))) * _319))) + _619) * 1.0, 0.0);
    float4 _633;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _632 = _626;
        _632.w = 0.0;
        _633 = _632;
    }
    else
    {
        _633 = _626;
    }
    float2 _637 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _645 = (_378 * 0.5) + float3(0.5);
    float4 _647 = float4(_645.x, _645.y, _645.z, float4(0.0).w);
    _647.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _326)].y;
    float4 _648 = float4(0.0);
    _648.x = _376;
    float4 _649 = _648;
    _649.y = _375;
    float4 _650 = _649;
    _650.z = _374;
    float4 _651 = _650;
    _651.w = 0.50588238239288330078125;
    float4 _663 = float4(_377.x, _377.y, _377.z, float4(0.0).w);
    _663.w = ((log2(((dot(_568, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_437, ((((((_430 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _319) + ((_430 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _319) + ((_430 * 2.755199909210205078125) + float3(0.69029998779296875))) * _319).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_637.xyx * _637.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _633 * View.View_PreExposure;
    out.out_var_SV_Target1 = _647;
    out.out_var_SV_Target2 = _651;
    out.out_var_SV_Target3 = _663;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = (View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _386)] * _394) * _394;
    return out;
}

