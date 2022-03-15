

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

struct type_Material
{
    spvUnsafeArray<float4, 4> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float3 _132 = {};
constant float _133 = {};

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
    float4 in_var_TEXCOORD4 [[user(locn2)]];
    uint in_var_PRIMITIVE_ID [[user(locn3)]];
    uint in_var_LIGHTMAP_ID [[user(locn4)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_000036d4_647de4a3(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _184 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _133, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _189 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _194 = (_189.xyz / float3(_189.w)) - View.View_PreViewTranslation;
    float3 _202 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _215 = fast::clamp(Material.Material_VectorExpressions[3].xyz, float3(0.0), float3(1.0));
    float _220 = (fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _221 = in.in_var_PRIMITIVE_ID * 36u;
    uint _222 = _221 + 20u;
    float _270;
    float _271;
    float _272;
    float3 _273;
    float3 _274;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _222)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _240 = ((_184.xy / float2(_184.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _244 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _240, level(0.0));
        float4 _247 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _240, level(0.0));
        float4 _250 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _240, level(0.0));
        float _260 = _250.w;
        _270 = (_220 * _260) + _250.z;
        _271 = (0.5 * _260) + _250.y;
        _272 = _250.x;
        _273 = (_215 * _244.w) + _244.xyz;
        _274 = normalize((_202 * _247.w) + ((_247.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _270 = _220;
        _271 = 0.5;
        _272 = 0.0;
        _273 = _215;
        _274 = _202;
    }
    float3 _289 = ((_273 - (_273 * _272)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _296 = (mix(float3(0.07999999821186065673828125 * _271), _273, float3(_272)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _299 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _304;
    if (_299)
    {
        _304 = _289 + (_296 * 0.449999988079071044921875);
    }
    else
    {
        _304 = _289;
    }
    float3 _306 = select(_296, float3(0.0), bool3(_299));
    float3 _308 = float3(dot(_306, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _323 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _328 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _323);
    float4 _330 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_323 + float2(0.0, 0.5)));
    uint _336 = in.in_var_LIGHTMAP_ID * 15u;
    uint _337 = _336 + 4u;
    uint _342 = _336 + 6u;
    float3 _347 = _328.xyz;
    float _399;
    float _400;
    float3 _401;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _383 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _387 = _383.w;
        float _388 = _387 * _387;
        float3 _390 = normalize(((_383.xyz * 2.0) - float3(1.0)).xyz);
        float _391 = 1.0 - _388;
        float _393 = 1.0 - (_391 * _391);
        _399 = mix(fast::clamp(dot(_390, _274), 0.0, 1.0), 1.0, _393);
        _400 = _388;
        _401 = mix(_390, _274, float3(_393));
    }
    else
    {
        _399 = 1.0;
        _400 = 1.0;
        _401 = _274;
    }
    float4 _405 = float4(_401, 1.0);
    float3 _409 = _132;
    _409.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _405);
    float3 _413 = _409;
    _413.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _405);
    float3 _417 = _413;
    _417.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _405);
    float4 _420 = _405.xyzz * _405.yzzx;
    float3 _424 = _132;
    _424.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _420);
    float3 _428 = _424;
    _428.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _420);
    float3 _432 = _428;
    _432.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _420);
    float3 _447 = (((((_347 * _347) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _337)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _342)].xyz) * ((exp2(((_328.w + ((_330.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _337)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _342)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_330 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _336 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _336 + 7u)], float4(_274.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_417 + _432) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_401.x * _401.x) - (_401.y * _401.y)))) * View.View_SkyLightColor.xyz) * (_400 * _399));
    float3 _469 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _498;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _497;
        if (any(abs(_194 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _221 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _221 + 19u)].xyz + float3(1.0))))
        {
            _497 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_194, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _497 = _469;
        }
        _498 = _497;
    }
    else
    {
        _498 = _469;
    }
    float4 _505 = float4(((mix(float3(0.0), _304 + (_306 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_447 * _304) * fast::max(float3(1.0), ((((((_273 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_273 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_273 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _498) * 1.0, 0.0);
    float4 _512;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _511 = _505;
        _511.w = 0.0;
        _512 = _511;
    }
    else
    {
        _512 = _505;
    }
    float2 _516 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _524 = (_274 * 0.5) + float3(0.5);
    float4 _526 = float4(_524.x, _524.y, _524.z, float4(0.0).w);
    _526.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _222)].y;
    float4 _527 = float4(0.0);
    _527.x = _272;
    float4 _528 = _527;
    _528.y = _271;
    float4 _529 = _528;
    _529.z = _270;
    float4 _530 = _529;
    _530.w = 0.75686275959014892578125;
    float4 _542 = float4(_273.x, _273.y, _273.z, float4(0.0).w);
    _542.w = ((log2(((dot(_447, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_308 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_308 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_308 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_516.xyx * _516.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _512 * View.View_PreExposure;
    out.out_var_SV_Target1 = _526;
    out.out_var_SV_Target2 = _530;
    out.out_var_SV_Target3 = _542;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

