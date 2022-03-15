

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

constant float3 _152 = {};
constant float _153 = {};

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

fragment MainPS_out Main_00003fff_b2babbc9(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float3x3 _197 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _208 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _153, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _213 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _217 = _213.xyz / float3(_213.w);
    float3 _218 = _217 - View.View_PreViewTranslation;
    float4 _227 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _233 = ((normalize(-_217) * _197).xy * ((0.0599999986588954925537109375 * _227.x) + (-0.021600000560283660888671875))) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _237 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _233, bias(View.View_MaterialTextureMipBias));
    float2 _240 = (_237.xy * float2(2.0)) - float2(1.0);
    float3 _256 = normalize(_197 * normalize((float4(_240, sqrt(fast::clamp(1.0 - dot(_240, _240), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _268 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.20000000298023223876953125), bias(View.View_MaterialTextureMipBias));
    float4 _273 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float4 _278 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0030000000260770320892333984375), bias(View.View_MaterialTextureMipBias));
    float4 _286 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _233, bias(View.View_MaterialTextureMipBias));
    float _289 = _286.w;
    float3 _294 = fast::clamp(_286.xyz * ((_268.x + 0.5) * ((_273.x + 0.5) * (_278.x + 0.5))), float3(0.0), float3(1.0));
    float _295 = fast::clamp(_289 * 4.0, 0.0, 1.0);
    float _300 = (fast::clamp(fast::min(fast::max(mix(1.0, -1.75, _289), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _301 = in.in_var_PRIMITIVE_ID * 36u;
    uint _302 = _301 + 20u;
    float _350;
    float _351;
    float _352;
    float3 _353;
    float3 _354;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _302)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _320 = ((_208.xy / float2(_208.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _324 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _320, level(0.0));
        float4 _327 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _320, level(0.0));
        float4 _330 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _320, level(0.0));
        float _340 = _330.w;
        _350 = (_300 * _340) + _330.z;
        _351 = (_295 * _340) + _330.y;
        _352 = _330.x;
        _353 = (_294 * _324.w) + _324.xyz;
        _354 = normalize((_256 * _327.w) + ((_327.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _350 = _300;
        _351 = _295;
        _352 = 0.0;
        _353 = _294;
        _354 = _256;
    }
    float3 _369 = ((_353 - (_353 * _352)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _376 = (mix(float3(0.07999999821186065673828125 * _351), _353, float3(_352)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _379 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _384;
    if (_379)
    {
        _384 = _369 + (_376 * 0.449999988079071044921875);
    }
    else
    {
        _384 = _369;
    }
    float3 _386 = select(_376, float3(0.0), bool3(_379));
    float3 _388 = float3(dot(_386, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _403 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _408 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _403);
    float4 _410 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_403 + float2(0.0, 0.5)));
    uint _416 = in.in_var_LIGHTMAP_ID * 15u;
    uint _417 = _416 + 4u;
    uint _422 = _416 + 6u;
    float3 _427 = _408.xyz;
    float _479;
    float _480;
    float3 _481;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _463 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _467 = _463.w;
        float _468 = _467 * _467;
        float3 _470 = normalize(((_463.xyz * 2.0) - float3(1.0)).xyz);
        float _471 = 1.0 - _468;
        float _473 = 1.0 - (_471 * _471);
        _479 = mix(fast::clamp(dot(_470, _354), 0.0, 1.0), 1.0, _473);
        _480 = _468;
        _481 = mix(_470, _354, float3(_473));
    }
    else
    {
        _479 = 1.0;
        _480 = 1.0;
        _481 = _354;
    }
    float4 _485 = float4(_481, 1.0);
    float3 _489 = _152;
    _489.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _485);
    float3 _493 = _489;
    _493.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _485);
    float3 _497 = _493;
    _497.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _485);
    float4 _500 = _485.xyzz * _485.yzzx;
    float3 _504 = _152;
    _504.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _500);
    float3 _508 = _504;
    _508.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _500);
    float3 _512 = _508;
    _512.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _500);
    float3 _527 = (((((_427 * _427) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _417)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _422)].xyz) * ((exp2(((_408.w + ((_410.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _417)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _422)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_410 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _416 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _416 + 7u)], float4(_354.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_497 + _512) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_481.x * _481.x) - (_481.y * _481.y)))) * View.View_SkyLightColor.xyz) * (_480 * _479));
    float3 _549 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _578;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _577;
        if (any(abs(_218 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _301 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _301 + 19u)].xyz + float3(1.0))))
        {
            _577 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_218, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _577 = _549;
        }
        _578 = _577;
    }
    else
    {
        _578 = _549;
    }
    float4 _585 = float4(((mix(float3(0.0), _384 + (_386 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_527 * _384) * fast::max(float3(1.0), ((((((_353 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_353 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_353 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _578) * 1.0, 0.0);
    float4 _592;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _591 = _585;
        _591.w = 0.0;
        _592 = _591;
    }
    else
    {
        _592 = _585;
    }
    float2 _596 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _604 = (_354 * 0.5) + float3(0.5);
    float4 _606 = float4(_604.x, _604.y, _604.z, float4(0.0).w);
    _606.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _302)].y;
    float4 _607 = float4(0.0);
    _607.x = _352;
    float4 _608 = _607;
    _608.y = _351;
    float4 _609 = _608;
    _609.z = _350;
    float4 _610 = _609;
    _610.w = 0.75686275959014892578125;
    float4 _622 = float4(_353.x, _353.y, _353.z, float4(0.0).w);
    _622.w = ((log2(((dot(_527, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_388 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_388 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_388 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_596.xyx * _596.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _592 * View.View_PreExposure;
    out.out_var_SV_Target1 = _606;
    out.out_var_SV_Target2 = _610;
    out.out_var_SV_Target3 = _622;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

