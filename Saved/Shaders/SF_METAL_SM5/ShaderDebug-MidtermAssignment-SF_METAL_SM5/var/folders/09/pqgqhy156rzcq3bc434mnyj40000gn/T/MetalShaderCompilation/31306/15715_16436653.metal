

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
    char _m17_pad[188];
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

fragment MainPS_out Main_00003d63_00facdad(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_StaticShadowTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    float4 _212 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _216 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _221 = (_216.xyz / float3(_216.w)) - View.View_PreViewTranslation;
    float2 _222 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.300000011920928955078125;
    float4 _228 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _222, bias(View.View_MaterialTextureMipBias));
    float2 _231 = (_228.xy * float2(2.0)) - float2(1.0);
    float2 _239 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.20000000298023223876953125;
    float4 _241 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _239, bias(View.View_MaterialTextureMipBias));
    float2 _244 = (_241.xy * float2(2.0)) - float2(1.0);
    float4 _256 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.008000000379979610443115234375), bias(View.View_MaterialTextureMipBias));
    float4 _261 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.004999999888241291046142578125), bias(View.View_MaterialTextureMipBias));
    float _263 = (_256.x + 0.5) * _261.x;
    float _265 = fast::min(fast::max(_263, 0.0), 1.0);
    float3 _268 = float3(_265);
    float4 _274 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _301;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _301 = _212.w;
                break;
            }
            else
            {
                float _285 = _212.z;
                _301 = ((_285 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_285 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _316 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(mix(float4(_231, sqrt(fast::clamp(1.0 - dot(_231, _231), 0.0, 1.0)), 1.0).xyz, float4(_244, sqrt(fast::clamp(1.0 - dot(_244, _244), 0.0, 1.0)), 1.0).xyz, _268), float3(0.0, 0.0, 1.0), float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _274.x) + _301) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _328 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _222, bias(View.View_MaterialTextureMipBias));
    float4 _330 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _239, bias(View.View_MaterialTextureMipBias));
    float3 _340 = fast::clamp(mix(_328.xyz, _330.xyz, _268) * mix(0.60000002384185791015625, 1.0, _263), float3(0.0), float3(1.0));
    float _345 = (fast::clamp(mix(0.949999988079071044921875, 0.699999988079071044921875, _263 * mix(_328.w, _330.w, _265)), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _346 = in.in_var_PRIMITIVE_ID * 36u;
    uint _347 = _346 + 20u;
    float _395;
    float _396;
    float _397;
    float3 _398;
    float3 _399;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _347)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _365 = ((_212.xy / float2(_212.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _369 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _365, level(0.0));
        float4 _372 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _365, level(0.0));
        float4 _375 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _365, level(0.0));
        float _385 = _375.w;
        _395 = (_345 * _385) + _375.z;
        _396 = (0.5 * _385) + _375.y;
        _397 = _375.x;
        _398 = (_340 * _369.w) + _369.xyz;
        _399 = normalize((_316 * _372.w) + ((_372.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _395 = _345;
        _396 = 0.5;
        _397 = 0.0;
        _398 = _340;
        _399 = _316;
    }
    float4 _406 = LightmapResourceCluster_StaticShadowTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.zw);
    uint _407 = in.in_var_LIGHTMAP_ID * 15u;
    uint _408 = _407 + 1u;
    float4 _415 = fast::clamp((_406 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _408)]) + ((View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _408)] * (-0.5)) + float4(0.5)), float4(0.0), float4(1.0));
    float3 _432 = ((_398 - (_398 * _397)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _439 = (mix(float3(0.07999999821186065673828125 * _396), _398, float3(_397)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _442 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _447;
    if (_442)
    {
        _447 = _432 + (_439 * 0.449999988079071044921875);
    }
    else
    {
        _447 = _432;
    }
    float3 _449 = select(_439, float3(0.0), bool3(_442));
    float3 _451 = float3(dot(_449, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _466 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _470 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _466);
    float4 _472 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_466 + float2(0.0, 0.5)));
    uint _478 = _407 + 4u;
    uint _483 = _407 + 6u;
    float3 _488 = _470.xyz;
    float3 _516 = ((((_488 * _488) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _478)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _483)].xyz) * ((exp2(((_470.w + ((_472.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _478)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _483)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_472 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _407 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _407 + 7u)], float4(_399.yzx, 1.0))))) * View.View_IndirectLightingColorScale;
    float3 _538 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _567;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _566;
        if (any(abs(_221 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _346 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _346 + 19u)].xyz + float3(1.0))))
        {
            _566 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_221, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _566 = _538;
        }
        _567 = _566;
    }
    else
    {
        _567 = _538;
    }
    float4 _574 = float4(((mix(float3(0.0), _447 + (_449 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_516 * _447) * fast::max(float3(1.0), ((((((_398 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_398 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_398 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _567) * 1.0, 0.0);
    float4 _581;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _580 = _574;
        _580.w = 0.0;
        _581 = _580;
    }
    else
    {
        _581 = _574;
    }
    float2 _585 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _593 = (_399 * 0.5) + float3(0.5);
    float4 _595 = float4(_593.x, _593.y, _593.z, float4(0.0).w);
    _595.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _347)].y;
    float4 _596 = float4(0.0);
    _596.x = _397;
    float4 _597 = _596;
    _597.y = _396;
    float4 _598 = _597;
    _598.z = _395;
    float4 _599 = _598;
    _599.w = 0.50588238239288330078125;
    float4 _611 = float4(_398.x, _398.y, _398.z, float4(0.0).w);
    _611.w = ((log2(((dot(_516, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_451 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_451 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_451 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_585.xyx * _585.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _581 * View.View_PreExposure;
    out.out_var_SV_Target1 = _595;
    out.out_var_SV_Target2 = _599;
    out.out_var_SV_Target3 = _611;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = (View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _407)] * _415) * _415;
    return out;
}

