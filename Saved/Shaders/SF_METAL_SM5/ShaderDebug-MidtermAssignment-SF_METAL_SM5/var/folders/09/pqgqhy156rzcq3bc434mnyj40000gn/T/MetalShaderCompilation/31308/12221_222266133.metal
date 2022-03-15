

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
    char _m12_pad[612];
    float View_RenderingReflectionCaptureMask;
    char _m13_pad[48];
    float4 View_SkyLightColor;
    char _m14_pad[124];
    float View_ShowDecalsMask;
    char _m15_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m16_pad[48];
    float3 View_VolumetricLightmapWorldToUVScale;
    float3 View_VolumetricLightmapWorldToUVAdd;
    packed_float3 View_VolumetricLightmapIndirectionTextureSize;
    float View_VolumetricLightmapBrickSize;
    float3 View_VolumetricLightmapBrickTexelSize;
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

constant float _131 = {};
constant float3 _132 = {};

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
    uint in_var_PRIMITIVE_ID [[user(locn2)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00002fbd_0d3f8315(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _183 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _131, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _188 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _193 = (_188.xyz / float3(_188.w)) - View.View_PreViewTranslation;
    float3 _201 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float _212 = (0.64999997615814208984375 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _213 = in.in_var_PRIMITIVE_ID * 36u;
    uint _214 = _213 + 20u;
    float _263;
    float _264;
    float _265;
    float3 _266;
    float3 _267;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _214)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _232 = ((_183.xy / float2(_183.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _236 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _232, level(0.0));
        float4 _239 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _232, level(0.0));
        float4 _242 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _232, level(0.0));
        float _252 = _242.w;
        _263 = (_212 * _252) + _242.z;
        _264 = (0.5 * _252) + _242.y;
        _265 = _252 + _242.x;
        _266 = (float3(0.180000007152557373046875) * _236.w) + _236.xyz;
        _267 = normalize((_201 * _239.w) + ((_239.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _263 = _212;
        _264 = 0.5;
        _265 = 1.0;
        _266 = float3(0.180000007152557373046875);
        _267 = _201;
    }
    float _316;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _214)].z > 0.0)
    {
        float3 _284 = fast::clamp((_193 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _295 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_284.x), int(_284.y), int(_284.z), 0).xyz), 0));
        _316 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_295.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_284 / float3(_295.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _316 = 1.0;
    }
    float4 _318 = float4(0.0);
    _318.x = 1.0;
    float4 _319 = _318;
    _319.y = 0.0;
    float3 _333 = ((_266 - (_266 * _265)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _340 = (mix(float3(0.07999999821186065673828125 * _264), _266, float3(_265)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _343 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _348;
    if (_343)
    {
        _348 = _333 + (_340 * 0.449999988079071044921875);
    }
    else
    {
        _348 = _333;
    }
    float4 _354 = float4(_267, 1.0);
    float3 _358 = _132;
    _358.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _354);
    float3 _362 = _358;
    _362.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _354);
    float3 _366 = _362;
    _366.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _354);
    float4 _369 = _354.xyzz * _354.yzzx;
    float3 _373 = _132;
    _373.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _369);
    float3 _377 = _373;
    _377.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _369);
    float3 _381 = _377;
    _381.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _369);
    float3 _415 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _444;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _443;
        if (any(abs(_193 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _213 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _213 + 19u)].xyz + float3(1.0))))
        {
            _443 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_193, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _443 = _415;
        }
        _444 = _443;
    }
    else
    {
        _444 = _415;
    }
    float4 _451 = float4(((mix(float3(0.0), _348 + (select(_340, float3(0.0), bool3(_343)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((((fast::max(float3(0.0), (_366 + _381) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_267.x * _267.x) - (_267.y * _267.y)))) * View.View_SkyLightColor.xyz) * 1.0) * _348) * fast::max(float3(1.0), ((((((_266 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_266 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_266 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _444) * 1.0, 0.0);
    float4 _458;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _457 = _451;
        _457.w = 0.0;
        _458 = _457;
    }
    else
    {
        _458 = _451;
    }
    float2 _462 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _470 = (_267 * 0.5) + float3(0.5);
    float4 _472 = float4(_470.x, _470.y, _470.z, float4(0.0).w);
    _472.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _214)].y;
    float4 _473 = float4(0.0);
    _473.x = _265;
    float4 _474 = _473;
    _474.y = _264;
    float4 _475 = _474;
    _475.z = fast::clamp(_263, 0.0, 0.996078431606292724609375);
    float4 _476 = _475;
    _476.w = 0.517647087574005126953125;
    float4 _479 = float4(_266.x, _266.y, _266.z, float4(0.0).w);
    _479.w = (fract(dot(_462.xyx * _462.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _458 * View.View_PreExposure;
    out.out_var_SV_Target1 = _472;
    out.out_var_SV_Target2 = _476;
    out.out_var_SV_Target3 = _479;
    out.out_var_SV_Target4 = _319;
    out.out_var_SV_Target5 = float4(_316, 1.0, 1.0, 1.0);
    return out;
}

