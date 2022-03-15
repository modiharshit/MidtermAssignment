

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
    char _m17_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m19_pad[124];
    float View_ShowDecalsMask;
    char _m20_pad[184];
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

constant float3 _157 = {};

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

fragment MainPS_out Main_00004426_9cd7fa3f(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _213 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _217 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _222 = (_217.xyz / float3(_217.w)) - View.View_PreViewTranslation;
    float2 _223 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.300000011920928955078125;
    float4 _229 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _223, bias(View.View_MaterialTextureMipBias));
    float2 _232 = (_229.xy * float2(2.0)) - float2(1.0);
    float2 _240 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.20000000298023223876953125;
    float4 _242 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _240, bias(View.View_MaterialTextureMipBias));
    float2 _245 = (_242.xy * float2(2.0)) - float2(1.0);
    float4 _257 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.008000000379979610443115234375), bias(View.View_MaterialTextureMipBias));
    float4 _262 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.004999999888241291046142578125), bias(View.View_MaterialTextureMipBias));
    float _264 = (_257.x + 0.5) * _262.x;
    float _266 = fast::min(fast::max(_264, 0.0), 1.0);
    float3 _269 = float3(_266);
    float4 _275 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _302;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _302 = _213.w;
                break;
            }
            else
            {
                float _286 = _213.z;
                _302 = ((_286 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_286 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _317 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(mix(float4(_232, sqrt(fast::clamp(1.0 - dot(_232, _232), 0.0, 1.0)), 1.0).xyz, float4(_245, sqrt(fast::clamp(1.0 - dot(_245, _245), 0.0, 1.0)), 1.0).xyz, _269), float3(0.0, 0.0, 1.0), float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _275.x) + _302) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _329 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _223, bias(View.View_MaterialTextureMipBias));
    float4 _331 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _240, bias(View.View_MaterialTextureMipBias));
    float3 _341 = fast::clamp(mix(_329.xyz, _331.xyz, _269) * mix(0.60000002384185791015625, 1.0, _264), float3(0.0), float3(1.0));
    float _346 = (fast::clamp(mix(0.949999988079071044921875, 0.699999988079071044921875, _264 * mix(_329.w, _331.w, _266)), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _347 = in.in_var_PRIMITIVE_ID * 36u;
    uint _348 = _347 + 20u;
    float _396;
    float _397;
    float _398;
    float3 _399;
    float3 _400;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _348)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _366 = ((_213.xy / float2(_213.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _370 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _366, level(0.0));
        float4 _373 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _366, level(0.0));
        float4 _376 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _366, level(0.0));
        float _386 = _376.w;
        _396 = (_346 * _386) + _376.z;
        _397 = (0.5 * _386) + _376.y;
        _398 = _376.x;
        _399 = (_341 * _370.w) + _370.xyz;
        _400 = normalize((_317 * _373.w) + ((_373.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _396 = _346;
        _397 = 0.5;
        _398 = 0.0;
        _399 = _341;
        _400 = _317;
    }
    float3 _415 = ((_399 - (_399 * _398)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _422 = (mix(float3(0.07999999821186065673828125 * _397), _399, float3(_398)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _425 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _430;
    if (_425)
    {
        _430 = _415 + (_422 * 0.449999988079071044921875);
    }
    else
    {
        _430 = _415;
    }
    float3 _432 = select(_422, float3(0.0), bool3(_425));
    float3 _434 = float3(dot(_432, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _449 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _454 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _449);
    float4 _456 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_449 + float2(0.0, 0.5)));
    uint _462 = in.in_var_LIGHTMAP_ID * 15u;
    uint _463 = _462 + 4u;
    uint _468 = _462 + 6u;
    float3 _473 = _454.xyz;
    float _525;
    float _526;
    float3 _527;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _509 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _513 = _509.w;
        float _514 = _513 * _513;
        float3 _516 = normalize(((_509.xyz * 2.0) - float3(1.0)).xyz);
        float _517 = 1.0 - _514;
        float _519 = 1.0 - (_517 * _517);
        _525 = mix(fast::clamp(dot(_516, _400), 0.0, 1.0), 1.0, _519);
        _526 = _514;
        _527 = mix(_516, _400, float3(_519));
    }
    else
    {
        _525 = 1.0;
        _526 = 1.0;
        _527 = _400;
    }
    float4 _531 = float4(_527, 1.0);
    float3 _535 = _157;
    _535.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _531);
    float3 _539 = _535;
    _539.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _531);
    float3 _543 = _539;
    _543.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _531);
    float4 _546 = _531.xyzz * _531.yzzx;
    float3 _550 = _157;
    _550.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _546);
    float3 _554 = _550;
    _554.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _546);
    float3 _558 = _554;
    _558.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _546);
    float3 _573 = (((((_473 * _473) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _463)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _468)].xyz) * ((exp2(((_454.w + ((_456.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _463)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _468)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_456 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _462 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _462 + 7u)], float4(_400.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_543 + _558) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_527.x * _527.x) - (_527.y * _527.y)))) * View.View_SkyLightColor.xyz) * (_526 * _525));
    float3 _595 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _624;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _623;
        if (any(abs(_222 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _347 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _347 + 19u)].xyz + float3(1.0))))
        {
            _623 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_222, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _623 = _595;
        }
        _624 = _623;
    }
    else
    {
        _624 = _595;
    }
    float4 _631 = float4(((mix(float3(0.0), _430 + (_432 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_573 * _430) * fast::max(float3(1.0), ((((((_399 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_399 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_399 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _624) * 1.0, 0.0);
    float4 _638;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _637 = _631;
        _637.w = 0.0;
        _638 = _637;
    }
    else
    {
        _638 = _631;
    }
    float2 _642 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _650 = (_400 * 0.5) + float3(0.5);
    float4 _652 = float4(_650.x, _650.y, _650.z, float4(0.0).w);
    _652.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _348)].y;
    float4 _653 = float4(0.0);
    _653.x = _398;
    float4 _654 = _653;
    _654.y = _397;
    float4 _655 = _654;
    _655.z = _396;
    float4 _656 = _655;
    _656.w = 0.75686275959014892578125;
    float4 _668 = float4(_399.x, _399.y, _399.z, float4(0.0).w);
    _668.w = ((log2(((dot(_573, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_434 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_434 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_434 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_642.xyx * _642.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _638 * View.View_PreExposure;
    out.out_var_SV_Target1 = _652;
    out.out_var_SV_Target2 = _656;
    out.out_var_SV_Target3 = _668;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

