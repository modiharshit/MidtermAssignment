

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
    spvUnsafeArray<float4, 4> Material_VectorExpressions;
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

fragment MainPS_out Main_000039cd_01fafcff(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> Material_Texture2D_0 [[texture(4)]], texture2d<float> Material_Texture2D_1 [[texture(5)]], texture2d<float> Material_Texture2D_2 [[texture(6)]], texture2d<float> Material_Texture2D_3 [[texture(7)]], texture2d<float> Material_Texture2D_4 [[texture(8)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], sampler Material_Texture2D_4Sampler [[sampler(6)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    float4 _209 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _213 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _218 = (_213.xyz / float3(_213.w)) - View.View_PreViewTranslation;
    float2 _219 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5;
    float4 _225 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _219, bias(View.View_MaterialTextureMipBias));
    float2 _228 = (_225.xy * float2(2.0)) - float2(1.0);
    float3 _244 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_228, sqrt(fast::clamp(1.0 - dot(_228, _228), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _256 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (_219 * float2(0.25)), bias(View.View_MaterialTextureMipBias));
    float2 _259 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 2.0;
    float4 _264 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (_259 * 0.2134999930858612060546875), bias(View.View_MaterialTextureMipBias));
    float4 _269 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (_259 * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float _296;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _296 = _209.w;
                break;
            }
            else
            {
                float _280 = _209.z;
                _296 = ((_280 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_280 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float4 _304 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _307 = mix(_264.x + 0.5, _269.x + 0.5, fast::min(fast::max((_296 - 24.0) * 0.0009765625, 0.0), 1.0)) * (_304.x + 0.5);
    float4 _312 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _219, bias(View.View_MaterialTextureMipBias));
    float4 _325 = Material_Texture2D_4.sample(Material_Texture2D_4Sampler, _219, bias(View.View_MaterialTextureMipBias));
    float3 _331 = fast::clamp(fast::min(fast::max(((_312.xyz * mix(0.60000002384185791015625, 1.0, _307)) * mix(0.1500000059604644775390625, 0.699999988079071044921875, _256.x)) * Material.Material_VectorExpressions[3].xyz, float3(0.0)), float3(1.0)), float3(0.0), float3(1.0));
    float _332 = fast::clamp(_325.y, 0.0, 1.0);
    float _337 = (fast::clamp(mix(-0.300000011920928955078125, 1.0, _325.x + (_307 * 0.20000000298023223876953125)), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _338 = in.in_var_PRIMITIVE_ID * 36u;
    uint _339 = _338 + 20u;
    float _387;
    float _388;
    float _389;
    float3 _390;
    float3 _391;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _339)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _357 = ((_209.xy / float2(_209.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _361 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _357, level(0.0));
        float4 _364 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _357, level(0.0));
        float4 _367 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _357, level(0.0));
        float _377 = _367.w;
        _387 = (_337 * _377) + _367.z;
        _388 = (0.5 * _377) + _367.y;
        _389 = _367.x;
        _390 = (_331 * _361.w) + _361.xyz;
        _391 = normalize((_244 * _364.w) + ((_364.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _387 = _337;
        _388 = 0.5;
        _389 = 0.0;
        _390 = _331;
        _391 = _244;
    }
    float3 _406 = ((_390 - (_390 * _389)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _413 = (mix(float3(0.07999999821186065673828125 * _388), _390, float3(_389)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _416 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _421;
    if (_416)
    {
        _421 = _406 + (_413 * 0.449999988079071044921875);
    }
    else
    {
        _421 = _406;
    }
    float3 _423 = select(_413, float3(0.0), bool3(_416));
    float3 _425 = float3(dot(_423, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _432 = float3(_332);
    float2 _441 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _446 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _441);
    float4 _448 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_441 + float2(0.0, 0.5)));
    uint _450 = in.in_var_LIGHTMAP_ID * 15u;
    float3 _460 = (_446.xyz * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _450 + 4u)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _450 + 6u)].xyz;
    float _461 = dot(_460, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float _480 = (exp2((_461 * 16.0) - 8.0) - 0.00390625) * fast::max(0.0, dot((_448 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _450 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _450 + 7u)], float4(_391.yzx, 1.0)));
    float3 _490 = float4(_460 * (_480 / _461), _480).xyz * View.View_IndirectLightingColorScale;
    float3 _512 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _541;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _540;
        if (any(abs(_218 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _338 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _338 + 19u)].xyz + float3(1.0))))
        {
            _540 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_218, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _540 = _512;
        }
        _541 = _540;
    }
    else
    {
        _541 = _512;
    }
    float4 _548 = float4(((mix(float3(0.0), _421 + (_423 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_490 * _421) * fast::max(_432, ((((((_390 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _332) + ((_390 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _332) + ((_390 * 2.755199909210205078125) + float3(0.69029998779296875))) * _332))) + _541) * 1.0, 0.0);
    float4 _555;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _554 = _548;
        _554.w = 0.0;
        _555 = _554;
    }
    else
    {
        _555 = _548;
    }
    float2 _559 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _567 = (_391 * 0.5) + float3(0.5);
    float4 _569 = float4(_567.x, _567.y, _567.z, float4(0.0).w);
    _569.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _339)].y;
    float4 _570 = float4(0.0);
    _570.x = _389;
    float4 _571 = _570;
    _571.y = _388;
    float4 _572 = _571;
    _572.z = _387;
    float4 _573 = _572;
    _573.w = 0.75686275959014892578125;
    float4 _585 = float4(_390.x, _390.y, _390.z, float4(0.0).w);
    _585.w = ((log2(((dot(_490, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_432, ((((((_425 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _332) + ((_425 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _332) + ((_425 * 2.755199909210205078125) + float3(0.69029998779296875))) * _332).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_559.xyx * _559.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _555 * View.View_PreExposure;
    out.out_var_SV_Target1 = _569;
    out.out_var_SV_Target2 = _573;
    out.out_var_SV_Target3 = _585;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

