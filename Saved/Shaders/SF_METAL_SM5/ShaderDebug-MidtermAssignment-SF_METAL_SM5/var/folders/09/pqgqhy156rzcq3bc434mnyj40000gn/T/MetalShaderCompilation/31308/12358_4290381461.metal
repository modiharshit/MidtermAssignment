

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
    char _m14_pad[188];
    float View_ShowDecalsMask;
    char _m15_pad[184];
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

constant float _136 = {};

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

fragment MainPS_out Main_00003046_ffba0695(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_StaticShadowTexture [[texture(4)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    float4 _185 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _136, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _190 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _195 = (_190.xyz / float3(_190.w)) - View.View_PreViewTranslation;
    float3 _203 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float _214 = (0.64999997615814208984375 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _215 = in.in_var_PRIMITIVE_ID * 36u;
    uint _216 = _215 + 20u;
    float _265;
    float _266;
    float _267;
    float3 _268;
    float3 _269;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _216)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _234 = ((_185.xy / float2(_185.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _238 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _234, level(0.0));
        float4 _241 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _234, level(0.0));
        float4 _244 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _234, level(0.0));
        float _254 = _244.w;
        _265 = (_214 * _254) + _244.z;
        _266 = (0.5 * _254) + _244.y;
        _267 = _254 + _244.x;
        _268 = (float3(0.180000007152557373046875) * _238.w) + _238.xyz;
        _269 = normalize((_203 * _241.w) + ((_241.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _265 = _214;
        _266 = 0.5;
        _267 = 1.0;
        _268 = float3(0.180000007152557373046875);
        _269 = _203;
    }
    float4 _276 = LightmapResourceCluster_StaticShadowTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.zw);
    uint _277 = in.in_var_LIGHTMAP_ID * 15u;
    uint _278 = _277 + 1u;
    float4 _285 = fast::clamp((_276 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _278)]) + ((View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _278)] * (-0.5)) + float4(0.5)), float4(0.0), float4(1.0));
    float4 _290 = float4(0.0);
    _290.x = 1.0;
    float4 _291 = _290;
    _291.y = 0.0;
    float3 _305 = ((_268 - (_268 * _267)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _312 = (mix(float3(0.07999999821186065673828125 * _266), _268, float3(_267)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _315 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _320;
    if (_315)
    {
        _320 = _305 + (_312 * 0.449999988079071044921875);
    }
    else
    {
        _320 = _305;
    }
    float3 _322 = select(_312, float3(0.0), bool3(_315));
    float3 _324 = float3(dot(_322, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _339 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _343 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _339);
    float4 _345 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_339 + float2(0.0, 0.5)));
    uint _351 = _277 + 4u;
    uint _356 = _277 + 6u;
    float3 _361 = _343.xyz;
    float3 _389 = ((((_361 * _361) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _351)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _356)].xyz) * ((exp2(((_343.w + ((_345.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _351)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _356)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_345 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _277 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _277 + 7u)], float4(_269.yzx, 1.0))))) * View.View_IndirectLightingColorScale;
    float3 _411 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _440;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _439;
        if (any(abs(_195 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _215 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _215 + 19u)].xyz + float3(1.0))))
        {
            _439 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_195, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _439 = _411;
        }
        _440 = _439;
    }
    else
    {
        _440 = _411;
    }
    float4 _447 = float4(((mix(float3(0.0), _320 + (_322 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_389 * _320) * fast::max(float3(1.0), ((((((_268 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_268 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_268 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _440) * 1.0, 0.0);
    float4 _454;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _453 = _447;
        _453.w = 0.0;
        _454 = _453;
    }
    else
    {
        _454 = _447;
    }
    float2 _458 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _466 = (_269 * 0.5) + float3(0.5);
    float4 _468 = float4(_466.x, _466.y, _466.z, float4(0.0).w);
    _468.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _216)].y;
    float4 _469 = float4(0.0);
    _469.x = _267;
    float4 _470 = _469;
    _470.y = _266;
    float4 _471 = _470;
    _471.z = fast::clamp(_265, 0.0, 0.996078431606292724609375);
    float4 _472 = _471;
    _472.w = 0.517647087574005126953125;
    float4 _484 = float4(_268.x, _268.y, _268.z, float4(0.0).w);
    _484.w = ((log2(((dot(_389, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_324 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_324 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_324 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_458.xyx * _458.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _454 * View.View_PreExposure;
    out.out_var_SV_Target1 = _468;
    out.out_var_SV_Target2 = _472;
    out.out_var_SV_Target3 = _484;
    out.out_var_SV_Target4 = _291;
    out.out_var_SV_Target5 = (View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _277)] * _285) * _285;
    return out;
}

