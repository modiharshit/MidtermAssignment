

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

fragment MainPS_out Main_00003a47_289bc349(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> Material_Texture2D_0 [[texture(4)]], texture2d<float> Material_Texture2D_1 [[texture(5)]], texture2d<float> Material_Texture2D_2 [[texture(6)]], texture2d<float> Material_Texture2D_3 [[texture(7)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    float4 _208 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _212 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _216 = _212.xyz / float3(_212.w);
    float3 _217 = _216 - View.View_PreViewTranslation;
    float4 _225 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _228 = (_225.xy * float2(2.0)) - float2(1.0);
    float4 _240 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _267;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _267 = _208.w;
                break;
            }
            else
            {
                float _251 = _208.z;
                _267 = ((_251 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_251 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _283 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(float4(_228, sqrt(fast::clamp(1.0 - dot(_228, _228), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _240.x) + _267) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _295 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _300 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _305 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _309 = (_295.x + 0.5) * ((_300.x + 0.5) * (_305.x + 0.5));
    float4 _313 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _315 = _313.xyz * _309;
    float _317 = _315.x;
    float _321 = _315.y;
    float _325 = _315.z;
    float _334 = fast::max(abs(1.0 - fast::max(0.0, dot(in.in_var_TEXCOORD11_centroid.xyz, normalize(-_216)))), 9.9999997473787516355514526367188e-05);
    float3 _343 = fast::clamp(mix(_315 * 0.5, float3((_317 <= 0.0) ? 0.0 : pow(_317, 0.4000000059604644775390625), (_321 <= 0.0) ? 0.0 : pow(_321, 0.4000000059604644775390625), (_325 <= 0.0) ? 0.0 : pow(_325, 0.4000000059604644775390625)), float3((_334 <= 0.0) ? 0.0 : pow(_334, 3.0))), float3(0.0), float3(1.0));
    float _348 = (fast::clamp(mix(0.89999997615814208984375, 0.5, _309 * _313.w), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _349 = in.in_var_PRIMITIVE_ID * 36u;
    uint _350 = _349 + 20u;
    float _398;
    float _399;
    float _400;
    float3 _401;
    float3 _402;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _350)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _368 = ((_208.xy / float2(_208.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _372 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _368, level(0.0));
        float4 _375 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _368, level(0.0));
        float4 _378 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _368, level(0.0));
        float _388 = _378.w;
        _398 = (_348 * _388) + _378.z;
        _399 = (0.5 * _388) + _378.y;
        _400 = _378.x;
        _401 = (_343 * _372.w) + _372.xyz;
        _402 = normalize((_283 * _375.w) + ((_375.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _398 = _348;
        _399 = 0.5;
        _400 = 0.0;
        _401 = _343;
        _402 = _283;
    }
    float3 _417 = ((_401 - (_401 * _400)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _424 = (mix(float3(0.07999999821186065673828125 * _399), _401, float3(_400)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _427 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _432;
    if (_427)
    {
        _432 = _417 + (_424 * 0.449999988079071044921875);
    }
    else
    {
        _432 = _417;
    }
    float3 _434 = select(_424, float3(0.0), bool3(_427));
    float3 _436 = float3(dot(_434, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _451 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _456 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _451);
    float4 _458 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_451 + float2(0.0, 0.5)));
    uint _460 = in.in_var_LIGHTMAP_ID * 15u;
    float3 _470 = (_456.xyz * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _460 + 4u)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _460 + 6u)].xyz;
    float _471 = dot(_470, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float _490 = (exp2((_471 * 16.0) - 8.0) - 0.00390625) * fast::max(0.0, dot((_458 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _460 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _460 + 7u)], float4(_402.yzx, 1.0)));
    float3 _500 = float4(_470 * (_490 / _471), _490).xyz * View.View_IndirectLightingColorScale;
    float3 _522 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _551;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _550;
        if (any(abs(_217 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _349 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _349 + 19u)].xyz + float3(1.0))))
        {
            _550 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_217, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _550 = _522;
        }
        _551 = _550;
    }
    else
    {
        _551 = _522;
    }
    float4 _558 = float4(((mix(float3(0.0), _432 + (_434 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_500 * _432) * fast::max(float3(1.0), ((((((_401 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_401 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_401 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _551) * 1.0, 0.0);
    float4 _565;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _564 = _558;
        _564.w = 0.0;
        _565 = _564;
    }
    else
    {
        _565 = _558;
    }
    float2 _569 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _577 = (_402 * 0.5) + float3(0.5);
    float4 _579 = float4(_577.x, _577.y, _577.z, float4(0.0).w);
    _579.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _350)].y;
    float4 _580 = float4(0.0);
    _580.x = _400;
    float4 _581 = _580;
    _581.y = _399;
    float4 _582 = _581;
    _582.z = _398;
    float4 _583 = _582;
    _583.w = 0.75686275959014892578125;
    float4 _595 = float4(_401.x, _401.y, _401.z, float4(0.0).w);
    _595.w = ((log2(((dot(_500, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_436 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_436 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_436 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_569.xyx * _569.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _565 * View.View_PreExposure;
    out.out_var_SV_Target1 = _579;
    out.out_var_SV_Target2 = _583;
    out.out_var_SV_Target3 = _595;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

