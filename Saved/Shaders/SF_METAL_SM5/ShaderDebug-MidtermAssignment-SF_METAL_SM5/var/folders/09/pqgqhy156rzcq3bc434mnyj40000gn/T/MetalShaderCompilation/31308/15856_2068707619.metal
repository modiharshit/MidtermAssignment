

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
    char _m15_pad[48];
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

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
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

fragment MainPS_out Main_00003df0_7b4df923(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> Material_Texture2D_0 [[texture(4)]], texture2d<float> Material_Texture2D_1 [[texture(5)]], texture2d<float> Material_Texture2D_2 [[texture(6)]], texture2d<float> Material_Texture2D_3 [[texture(7)]], texture2d<float> Material_Texture2D_4 [[texture(8)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], sampler Material_Texture2D_4Sampler [[sampler(6)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float3x3 _198 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _209 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _155, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _214 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _218 = _214.xyz / float3(_214.w);
    float3 _219 = _218 - View.View_PreViewTranslation;
    float2 _223 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5;
    float4 _229 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _223, bias(View.View_MaterialTextureMipBias));
    float2 _235 = ((normalize(-_218) * _198).xy * ((0.004999999888241291046142578125 * _229.w) + (-0.00449999980628490447998046875))) + _223;
    float4 _239 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _235, bias(View.View_MaterialTextureMipBias));
    float2 _242 = (_239.xy * float2(2.0)) - float2(1.0);
    float4 _255 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.100000001490116119384765625), bias(2.0 + View.View_MaterialTextureMipBias));
    float2 _258 = (_255.xy * float2(2.0)) - float2(1.0);
    float3 _277 = normalize(_198 * normalize(((float4(_242, sqrt(fast::clamp(1.0 - dot(_242, _242), 0.0, 1.0)), 1.0).xyz + (float4(_258, sqrt(fast::clamp(1.0 - dot(_258, _258), 0.0, 1.0)), 1.0).xyz * float3(0.20000000298023223876953125, 0.20000000298023223876953125, 0.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _289 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _294 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _297 = (_289.x + 0.5) * (_294.x + 0.5);
    float4 _300 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _235, bias(View.View_MaterialTextureMipBias));
    float4 _306 = Material_Texture2D_4.sample(Material_Texture2D_4Sampler, _235, bias(View.View_MaterialTextureMipBias));
    float3 _312 = fast::clamp(_300.xyz * mix(0.5, 1.0, _297), float3(0.0), float3(1.0));
    float _313 = fast::clamp(_306.y, 0.0, 1.0);
    float _318 = (fast::clamp(mix(-0.300000011920928955078125, 0.800000011920928955078125, _306.x + (_297 * 0.20000000298023223876953125)), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _319 = in.in_var_PRIMITIVE_ID * 36u;
    uint _320 = _319 + 20u;
    float _368;
    float _369;
    float _370;
    float3 _371;
    float3 _372;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _320)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _338 = ((_209.xy / float2(_209.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _342 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _338, level(0.0));
        float4 _345 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _338, level(0.0));
        float4 _348 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _338, level(0.0));
        float _358 = _348.w;
        _368 = (_318 * _358) + _348.z;
        _369 = (0.5 * _358) + _348.y;
        _370 = _348.x;
        _371 = (_312 * _342.w) + _342.xyz;
        _372 = normalize((_277 * _345.w) + ((_345.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _368 = _318;
        _369 = 0.5;
        _370 = 0.0;
        _371 = _312;
        _372 = _277;
    }
    float3 _387 = ((_371 - (_371 * _370)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _394 = (mix(float3(0.07999999821186065673828125 * _369), _371, float3(_370)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _397 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _402;
    if (_397)
    {
        _402 = _387 + (_394 * 0.449999988079071044921875);
    }
    else
    {
        _402 = _387;
    }
    float3 _404 = select(_394, float3(0.0), bool3(_397));
    float3 _406 = float3(dot(_404, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _413 = float3(_313);
    float2 _422 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _427 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _422);
    float4 _429 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_422 + float2(0.0, 0.5)));
    uint _431 = in.in_var_LIGHTMAP_ID * 15u;
    float3 _441 = (_427.xyz * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _431 + 4u)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _431 + 6u)].xyz;
    float _442 = dot(_441, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float _461 = (exp2((_442 * 16.0) - 8.0) - 0.00390625) * fast::max(0.0, dot((_429 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _431 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _431 + 7u)], float4(_372.yzx, 1.0)));
    float4 _472 = float4(_372, 1.0);
    float3 _476 = _154;
    _476.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _472);
    float3 _480 = _476;
    _480.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _472);
    float3 _484 = _480;
    _484.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _472);
    float4 _487 = _472.xyzz * _472.yzzx;
    float3 _491 = _154;
    _491.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _487);
    float3 _495 = _491;
    _495.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _487);
    float3 _499 = _495;
    _499.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _487);
    float3 _513 = (float4(_441 * (_461 / _442), _461).xyz * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_484 + _499) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_372.x * _372.x) - (_372.y * _372.y)))) * View.View_SkyLightColor.xyz) * 1.0);
    float3 _535 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _564;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _563;
        if (any(abs(_219 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _319 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _319 + 19u)].xyz + float3(1.0))))
        {
            _563 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_219, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _563 = _535;
        }
        _564 = _563;
    }
    else
    {
        _564 = _535;
    }
    float4 _571 = float4(((mix(float3(0.0), _402 + (_404 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_513 * _402) * fast::max(_413, ((((((_371 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _313) + ((_371 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _313) + ((_371 * 2.755199909210205078125) + float3(0.69029998779296875))) * _313))) + _564) * 1.0, 0.0);
    float4 _578;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _577 = _571;
        _577.w = 0.0;
        _578 = _577;
    }
    else
    {
        _578 = _571;
    }
    float2 _582 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _590 = (_372 * 0.5) + float3(0.5);
    float4 _592 = float4(_590.x, _590.y, _590.z, float4(0.0).w);
    _592.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _320)].y;
    float4 _593 = float4(0.0);
    _593.x = _370;
    float4 _594 = _593;
    _594.y = _369;
    float4 _595 = _594;
    _595.z = _368;
    float4 _596 = _595;
    _596.w = 0.75686275959014892578125;
    float4 _608 = float4(_371.x, _371.y, _371.z, float4(0.0).w);
    _608.w = ((log2(((dot(_513, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_413, ((((((_406 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _313) + ((_406 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _313) + ((_406 * 2.755199909210205078125) + float3(0.69029998779296875))) * _313).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_582.xyx * _582.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _578 * View.View_PreExposure;
    out.out_var_SV_Target1 = _592;
    out.out_var_SV_Target2 = _596;
    out.out_var_SV_Target3 = _608;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

