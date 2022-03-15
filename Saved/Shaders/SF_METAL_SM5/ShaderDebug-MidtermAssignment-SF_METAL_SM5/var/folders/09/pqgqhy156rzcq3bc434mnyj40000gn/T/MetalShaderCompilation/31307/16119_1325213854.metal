

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

constant float3 _148 = {};
constant float _149 = {};

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

fragment MainPS_out Main_00003ef7_4efd289e(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _204 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _149, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _209 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _214 = (_209.xyz / float3(_209.w)) - View.View_PreViewTranslation;
    float4 _220 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _223 = (_220.xy * float2(2.0)) - float2(1.0);
    float _230 = sqrt(fast::clamp(1.0 - dot(_223, _223), 0.0, 1.0)) + 1.0;
    float4 _233 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 2.0), bias(View.View_MaterialTextureMipBias));
    float2 _236 = (_233.xy * float2(2.0)) - float2(1.0);
    float3 _245 = float4(_236, sqrt(fast::clamp(1.0 - dot(_236, _236), 0.0, 1.0)), 1.0).xyz * float3(-1.0, -1.0, 1.0);
    float3 _248 = float3(_223, _230);
    float3 _252 = float3(_245.xy * (-1.0), _245.z);
    float3 _264 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((((_248 * dot(_248, _252)) - (_252 * _230)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _276 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _281 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.02999999932944774627685546875), bias(View.View_MaterialTextureMipBias));
    float4 _290 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _294 = fast::clamp(mix(float3(0.5), float3(1.0), float3((_276.x + 0.5) * (_281.x + 0.5))) * _290.xyz, float3(0.0), float3(1.0));
    float _295 = fast::clamp(_290.w, 0.0, 1.0);
    float _299 = (0.980000019073486328125 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _300 = in.in_var_PRIMITIVE_ID * 36u;
    uint _301 = _300 + 20u;
    float _349;
    float _350;
    float _351;
    float3 _352;
    float3 _353;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _301)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _319 = ((_204.xy / float2(_204.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _323 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _319, level(0.0));
        float4 _326 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _319, level(0.0));
        float4 _329 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _319, level(0.0));
        float _339 = _329.w;
        _349 = (_299 * _339) + _329.z;
        _350 = (_295 * _339) + _329.y;
        _351 = _329.x;
        _352 = (_294 * _323.w) + _323.xyz;
        _353 = normalize((_264 * _326.w) + ((_326.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _349 = _299;
        _350 = _295;
        _351 = 0.0;
        _352 = _294;
        _353 = _264;
    }
    float3 _368 = ((_352 - (_352 * _351)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _375 = (mix(float3(0.07999999821186065673828125 * _350), _352, float3(_351)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _378 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _383;
    if (_378)
    {
        _383 = _368 + (_375 * 0.449999988079071044921875);
    }
    else
    {
        _383 = _368;
    }
    float3 _385 = select(_375, float3(0.0), bool3(_378));
    float3 _387 = float3(dot(_385, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _402 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _407 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _402);
    float4 _409 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_402 + float2(0.0, 0.5)));
    uint _415 = in.in_var_LIGHTMAP_ID * 15u;
    uint _416 = _415 + 4u;
    uint _421 = _415 + 6u;
    float3 _426 = _407.xyz;
    float _478;
    float _479;
    float3 _480;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _462 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _466 = _462.w;
        float _467 = _466 * _466;
        float3 _469 = normalize(((_462.xyz * 2.0) - float3(1.0)).xyz);
        float _470 = 1.0 - _467;
        float _472 = 1.0 - (_470 * _470);
        _478 = mix(fast::clamp(dot(_469, _353), 0.0, 1.0), 1.0, _472);
        _479 = _467;
        _480 = mix(_469, _353, float3(_472));
    }
    else
    {
        _478 = 1.0;
        _479 = 1.0;
        _480 = _353;
    }
    float4 _484 = float4(_480, 1.0);
    float3 _488 = _148;
    _488.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _484);
    float3 _492 = _488;
    _492.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _484);
    float3 _496 = _492;
    _496.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _484);
    float4 _499 = _484.xyzz * _484.yzzx;
    float3 _503 = _148;
    _503.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _499);
    float3 _507 = _503;
    _507.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _499);
    float3 _511 = _507;
    _511.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _499);
    float3 _526 = (((((_426 * _426) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _416)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _421)].xyz) * ((exp2(((_407.w + ((_409.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _416)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _421)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_409 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _415 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _415 + 7u)], float4(_353.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_496 + _511) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_480.x * _480.x) - (_480.y * _480.y)))) * View.View_SkyLightColor.xyz) * (_479 * _478));
    float3 _548 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _577;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _576;
        if (any(abs(_214 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _300 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _300 + 19u)].xyz + float3(1.0))))
        {
            _576 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_214, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _576 = _548;
        }
        _577 = _576;
    }
    else
    {
        _577 = _548;
    }
    float4 _584 = float4(((mix(float3(0.0), _383 + (_385 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_526 * _383) * fast::max(float3(1.0), ((((((_352 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_352 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_352 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _577) * 1.0, 0.0);
    float4 _591;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _590 = _584;
        _590.w = 0.0;
        _591 = _590;
    }
    else
    {
        _591 = _584;
    }
    float2 _595 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _603 = (_353 * 0.5) + float3(0.5);
    float4 _605 = float4(_603.x, _603.y, _603.z, float4(0.0).w);
    _605.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _301)].y;
    float4 _606 = float4(0.0);
    _606.x = _351;
    float4 _607 = _606;
    _607.y = _350;
    float4 _608 = _607;
    _608.z = _349;
    float4 _609 = _608;
    _609.w = 0.75686275959014892578125;
    float4 _621 = float4(_352.x, _352.y, _352.z, float4(0.0).w);
    _621.w = ((log2(((dot(_526, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_387 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_387 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_387 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_595.xyx * _595.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _591 * View.View_PreExposure;
    out.out_var_SV_Target1 = _605;
    out.out_var_SV_Target2 = _609;
    out.out_var_SV_Target3 = _621;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

