

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
    char _m11_pad[36];
    float View_GameTime;
    char _m12_pad[8];
    float View_MaterialTextureMipBias;
    char _m13_pad[28];
    float View_UnlitViewmodeMask;
    char _m14_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m15_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m16_pad[188];
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
    spvUnsafeArray<float4, 6> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float _146 = {};

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

fragment MainPS_out Main_00003405_cf14657d(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> Material_Texture2D_0 [[texture(4)]], texture2d<float> Material_Texture2D_1 [[texture(5)]], texture2d<float> Material_Texture2D_2 [[texture(6)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    float3x3 _189 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _200 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _146, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _205 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _209 = _205.xyz / float3(_205.w);
    float3 _210 = _209 - View.View_PreViewTranslation;
    float4 _219 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _225 = ((normalize(-_209) * _189).xy * ((0.0500000007450580596923828125 * _219.z) + (-0.02500000037252902984619140625))) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _229 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _225, bias(View.View_MaterialTextureMipBias));
    float2 _232 = (_229.xy * float2(2.0)) - float2(1.0);
    float3 _248 = normalize(_189 * normalize((float4(_232, sqrt(fast::clamp(1.0 - dot(_232, _232), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _250 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _225, bias(View.View_MaterialTextureMipBias));
    float _263 = _250.y;
    float4 _275 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _283 = fast::clamp(float3(mix(0.25, 0.4000000059604644775390625, _275.x) * 0.25), float3(0.0), float3(1.0));
    float _288 = (fast::clamp(fast::min(fast::max(0.25 + _263, 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _289 = in.in_var_PRIMITIVE_ID * 36u;
    uint _290 = _289 + 20u;
    float _338;
    float _339;
    float _340;
    float3 _341;
    float3 _342;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _290)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _308 = ((_200.xy / float2(_200.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _312 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _308, level(0.0));
        float4 _315 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _308, level(0.0));
        float4 _318 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _308, level(0.0));
        float _328 = _318.w;
        _338 = (_288 * _328) + _318.z;
        _339 = (0.5 * _328) + _318.y;
        _340 = _318.x;
        _341 = (_283 * _312.w) + _312.xyz;
        _342 = normalize((_248 * _315.w) + ((_315.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _338 = _288;
        _339 = 0.5;
        _340 = 0.0;
        _341 = _283;
        _342 = _248;
    }
    float3 _357 = ((_341 - (_341 * _340)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _364 = (mix(float3(0.07999999821186065673828125 * _339), _341, float3(_340)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _367 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _372;
    if (_367)
    {
        _372 = _357 + (_364 * 0.449999988079071044921875);
    }
    else
    {
        _372 = _357;
    }
    float3 _374 = select(_364, float3(0.0), bool3(_367));
    float3 _376 = float3(dot(_374, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _391 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _396 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _391);
    float4 _398 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_391 + float2(0.0, 0.5)));
    uint _400 = in.in_var_LIGHTMAP_ID * 15u;
    float3 _410 = (_396.xyz * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _400 + 4u)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _400 + 6u)].xyz;
    float _411 = dot(_410, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float _430 = (exp2((_411 * 16.0) - 8.0) - 0.00390625) * fast::max(0.0, dot((_398 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _400 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _400 + 7u)], float4(_342.yzx, 1.0)));
    float3 _440 = float4(_410 * (_430 / _411), _430).xyz * View.View_IndirectLightingColorScale;
    float3 _462 = fast::max(mix(mix(Material.Material_VectorExpressions[3].xyz, Material.Material_VectorExpressions[4].xyz, float3(sin(View.View_GameTime * 1.57079637050628662109375))) * _263, Material.Material_VectorExpressions[5].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _491;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _490;
        if (any(abs(_210 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _289 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _289 + 19u)].xyz + float3(1.0))))
        {
            _490 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_210, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _490 = _462;
        }
        _491 = _490;
    }
    else
    {
        _491 = _462;
    }
    float4 _498 = float4(((mix(float3(0.0), _372 + (_374 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_440 * _372) * fast::max(float3(1.0), ((((((_341 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_341 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_341 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _491) * 1.0, 0.0);
    float4 _505;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _504 = _498;
        _504.w = 0.0;
        _505 = _504;
    }
    else
    {
        _505 = _498;
    }
    float2 _509 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _517 = (_342 * 0.5) + float3(0.5);
    float4 _519 = float4(_517.x, _517.y, _517.z, float4(0.0).w);
    _519.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _290)].y;
    float4 _520 = float4(0.0);
    _520.x = _340;
    float4 _521 = _520;
    _521.y = _339;
    float4 _522 = _521;
    _522.z = _338;
    float4 _523 = _522;
    _523.w = 0.75686275959014892578125;
    float4 _535 = float4(_341.x, _341.y, _341.z, float4(0.0).w);
    _535.w = ((log2(((dot(_440, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_376 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_376 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_376 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_509.xyx * _509.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _505 * View.View_PreExposure;
    out.out_var_SV_Target1 = _519;
    out.out_var_SV_Target2 = _523;
    out.out_var_SV_Target3 = _535;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

