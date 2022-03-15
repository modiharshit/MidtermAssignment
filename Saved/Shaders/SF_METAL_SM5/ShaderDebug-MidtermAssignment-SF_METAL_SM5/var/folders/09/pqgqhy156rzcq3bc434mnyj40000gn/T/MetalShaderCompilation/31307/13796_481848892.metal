

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
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
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

fragment MainPS_out Main_000035e4_1cb86e3c(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _184 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _133, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _189 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _194 = (_189.xyz / float3(_189.w)) - View.View_PreViewTranslation;
    float3 _202 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    uint _211 = in.in_var_PRIMITIVE_ID * 36u;
    uint _212 = _211 + 20u;
    float _257;
    float _258;
    float _259;
    float3 _260;
    float3 _261;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _212)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _230 = ((_184.xy / float2(_184.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _237 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _230, level(0.0));
        float4 _240 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _230, level(0.0));
        float _249 = _240.w;
        _257 = (View.View_RoughnessOverrideParameter.x * _249) + _240.z;
        _258 = (0.5 * _249) + _240.y;
        _259 = _240.x;
        _260 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _230, level(0.0)).xyz;
        _261 = normalize((_202 * _237.w) + ((_237.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _257 = View.View_RoughnessOverrideParameter.x;
        _258 = 0.5;
        _259 = 0.0;
        _260 = float3(0.0);
        _261 = _202;
    }
    float3 _276 = ((_260 - (_260 * _259)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _283 = (mix(float3(0.07999999821186065673828125 * _258), _260, float3(_259)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _286 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _291;
    if (_286)
    {
        _291 = _276 + (_283 * 0.449999988079071044921875);
    }
    else
    {
        _291 = _276;
    }
    float3 _293 = select(_283, float3(0.0), bool3(_286));
    float3 _295 = float3(dot(_293, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _310 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _315 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _310);
    float4 _317 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_310 + float2(0.0, 0.5)));
    uint _323 = in.in_var_LIGHTMAP_ID * 15u;
    uint _324 = _323 + 4u;
    uint _329 = _323 + 6u;
    float3 _334 = _315.xyz;
    float _386;
    float _387;
    float3 _388;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _370 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _374 = _370.w;
        float _375 = _374 * _374;
        float3 _377 = normalize(((_370.xyz * 2.0) - float3(1.0)).xyz);
        float _378 = 1.0 - _375;
        float _380 = 1.0 - (_378 * _378);
        _386 = mix(fast::clamp(dot(_377, _261), 0.0, 1.0), 1.0, _380);
        _387 = _375;
        _388 = mix(_377, _261, float3(_380));
    }
    else
    {
        _386 = 1.0;
        _387 = 1.0;
        _388 = _261;
    }
    float4 _392 = float4(_388, 1.0);
    float3 _396 = _132;
    _396.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _392);
    float3 _400 = _396;
    _400.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _392);
    float3 _404 = _400;
    _404.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _392);
    float4 _407 = _392.xyzz * _392.yzzx;
    float3 _411 = _132;
    _411.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _407);
    float3 _415 = _411;
    _415.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _407);
    float3 _419 = _415;
    _419.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _407);
    float3 _434 = (((((_334 * _334) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _324)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _329)].xyz) * ((exp2(((_315.w + ((_317.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _324)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _329)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_317 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _323 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _323 + 7u)], float4(_261.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_404 + _419) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_388.x * _388.x) - (_388.y * _388.y)))) * View.View_SkyLightColor.xyz) * (_387 * _386));
    float3 _456 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _485;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _484;
        if (any(abs(_194 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _211 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _211 + 19u)].xyz + float3(1.0))))
        {
            _484 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_194, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _484 = _456;
        }
        _485 = _484;
    }
    else
    {
        _485 = _456;
    }
    float4 _492 = float4(((mix(float3(0.0), _291 + (_293 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_434 * _291) * fast::max(float3(1.0), ((((((_260 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_260 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_260 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _485) * 1.0, 0.0);
    float4 _499;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _498 = _492;
        _498.w = 0.0;
        _499 = _498;
    }
    else
    {
        _499 = _492;
    }
    float2 _503 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _511 = (_261 * 0.5) + float3(0.5);
    float4 _513 = float4(_511.x, _511.y, _511.z, float4(0.0).w);
    _513.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _212)].y;
    float4 _514 = float4(0.0);
    _514.x = _259;
    float4 _515 = _514;
    _515.y = _258;
    float4 _516 = _515;
    _516.z = _257;
    float4 _517 = _516;
    _517.w = 0.75686275959014892578125;
    float4 _529 = float4(_260.x, _260.y, _260.z, float4(0.0).w);
    _529.w = ((log2(((dot(_434, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_295 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_295 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_295 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_503.xyx * _503.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _499 * View.View_PreExposure;
    out.out_var_SV_Target1 = _513;
    out.out_var_SV_Target2 = _517;
    out.out_var_SV_Target3 = _529;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

