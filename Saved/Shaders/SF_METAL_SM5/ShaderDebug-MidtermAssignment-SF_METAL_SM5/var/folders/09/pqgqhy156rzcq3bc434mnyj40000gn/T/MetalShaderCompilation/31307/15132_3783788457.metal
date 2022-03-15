

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
    char _m11_pad[16];
    float View_OutOfBoundsMask;
    char _m12_pad[48];
    float View_MaterialTextureMipBias;
    char _m13_pad[28];
    float View_UnlitViewmodeMask;
    char _m14_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m15_pad[464];
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
    spvUnsafeArray<float4, 8> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float3 _157 = {};

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

fragment MainPS_out Main_00003b1c_e18807a9(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> Material_Texture2D_0 [[texture(4)]], texture2d<float> Material_Texture2D_1 [[texture(5)]], texture2d<float> Material_Texture2D_2 [[texture(6)]], texture2d<float> Material_Texture2D_3 [[texture(7)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _209 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _213 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _218 = (_213.xyz / float3(_213.w)) - View.View_PreViewTranslation;
    float2 _219 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5;
    float4 _225 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _219, bias(View.View_MaterialTextureMipBias));
    float2 _228 = (_225.xy * float2(2.0)) - float2(1.0);
    float2 _236 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125;
    float4 _240 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _236, bias(View.View_MaterialTextureMipBias));
    float _267;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _267 = _209.w;
                break;
            }
            else
            {
                float _251 = _209.z;
                _267 = ((_251 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_251 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _274 = float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _240.x) + _267) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0));
    float3 _283 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(float4(_228, sqrt(fast::clamp(1.0 - dot(_228, _228), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), _274) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _294 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _219, bias(View.View_MaterialTextureMipBias));
    float4 _310 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.75) * 0.00999999977648258209228515625), bias(View.View_MaterialTextureMipBias));
    float3 _316 = mix(Material.Material_VectorExpressions[3].xyz * _294.y, _294.xyz * Material.Material_VectorExpressions[5].xyz, float3(fast::min(fast::max(mix(-0.25, 2.0, _310.x), 0.0), 1.0)));
    float4 _318 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _236, bias(View.View_MaterialTextureMipBias));
    float4 _326 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.004999999888241291046142578125), bias(View.View_MaterialTextureMipBias));
    float3 _331 = fast::clamp(mix(_316, mix(_316, mix(_318.xyz, Material.Material_VectorExpressions[7].xyz, float3(0.300000011920928955078125)), float3(_326.x)), _274), float3(0.0), float3(1.0));
    uint _332 = in.in_var_PRIMITIVE_ID * 36u;
    uint _333 = _332 + 20u;
    float _380;
    float _381;
    float _382;
    float3 _383;
    float3 _384;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _333)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _351 = ((_209.xy / float2(_209.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _355 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _351, level(0.0));
        float4 _358 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _351, level(0.0));
        float4 _361 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _351, level(0.0));
        float _371 = _361.w;
        _380 = _371 + _361.z;
        _381 = (0.5 * _371) + _361.y;
        _382 = _361.x;
        _383 = (_331 * _355.w) + _355.xyz;
        _384 = normalize((_283 * _358.w) + ((_358.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _380 = 1.0;
        _381 = 0.5;
        _382 = 0.0;
        _383 = _331;
        _384 = _283;
    }
    float3 _408 = (((_383 - (_383 * _382)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz) + (((mix(float3(0.07999999821186065673828125 * _381), _383, float3(_382)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz) * 0.449999988079071044921875);
    float2 _410 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _415 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _410);
    float4 _417 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_410 + float2(0.0, 0.5)));
    uint _419 = in.in_var_LIGHTMAP_ID * 15u;
    float3 _429 = (_415.xyz * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _419 + 4u)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _419 + 6u)].xyz;
    float _430 = dot(_429, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float _449 = (exp2((_430 * 16.0) - 8.0) - 0.00390625) * fast::max(0.0, dot((_417 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _419 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _419 + 7u)], float4(_384.yzx, 1.0)));
    float4 _460 = float4(_384, 1.0);
    float3 _464 = _157;
    _464.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _460);
    float3 _468 = _464;
    _468.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _460);
    float3 _472 = _468;
    _472.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _460);
    float4 _475 = _460.xyzz * _460.yzzx;
    float3 _479 = _157;
    _479.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _475);
    float3 _483 = _479;
    _483.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _475);
    float3 _487 = _483;
    _487.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _475);
    float3 _501 = (float4(_429 * (_449 / _430), _449).xyz * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_472 + _487) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_384.x * _384.x) - (_384.y * _384.y)))) * View.View_SkyLightColor.xyz) * 1.0);
    float3 _521 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _550;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _549;
        if (any(abs(_218 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _332 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _332 + 19u)].xyz + float3(1.0))))
        {
            _549 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_218, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _549 = _521;
        }
        _550 = _549;
    }
    else
    {
        _550 = _521;
    }
    float4 _557 = float4(((mix(float3(0.0), _408, float3(View.View_UnlitViewmodeMask)) + ((_501 * _408) * fast::max(float3(1.0), ((((((_383 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_383 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_383 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _550) * 1.0, 0.0);
    float4 _564;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _563 = _557;
        _563.w = 0.0;
        _564 = _563;
    }
    else
    {
        _564 = _557;
    }
    float2 _568 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _576 = (_384 * 0.5) + float3(0.5);
    float4 _578 = float4(_576.x, _576.y, _576.z, float4(0.0).w);
    _578.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _333)].y;
    float4 _579 = float4(0.0);
    _579.x = _382;
    float4 _580 = _579;
    _580.y = _381;
    float4 _581 = _580;
    _581.z = _380;
    float4 _582 = _581;
    _582.w = 0.75686275959014892578125;
    float4 _593 = float4(_383.x, _383.y, _383.z, float4(0.0).w);
    _593.w = ((log2((dot(_501, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_568.xyx * _568.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _564 * View.View_PreExposure;
    out.out_var_SV_Target1 = _578;
    out.out_var_SV_Target2 = _582;
    out.out_var_SV_Target3 = _593;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

