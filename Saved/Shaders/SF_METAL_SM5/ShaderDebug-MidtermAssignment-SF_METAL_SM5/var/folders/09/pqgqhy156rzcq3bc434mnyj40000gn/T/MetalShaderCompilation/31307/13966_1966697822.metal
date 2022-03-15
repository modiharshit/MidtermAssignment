

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
    char _m15_pad[188];
    float View_ShowDecalsMask;
    char _m16_pad[184];
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

constant float _148 = {};

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

fragment MainPS_out Main_0000368e_75396d5e(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> Material_Texture2D_0 [[texture(4)]], texture2d<float> Material_Texture2D_1 [[texture(5)]], texture2d<float> Material_Texture2D_2 [[texture(6)]], texture2d<float> Material_Texture2D_3 [[texture(7)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    float3x3 _190 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _201 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _148, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _206 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _210 = _206.xyz / float3(_206.w);
    float3 _211 = _210 - View.View_PreViewTranslation;
    float4 _220 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _226 = ((normalize(-_210) * _190).xy * ((0.0599999986588954925537109375 * _220.x) + (-0.021600000560283660888671875))) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _230 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _226, bias(View.View_MaterialTextureMipBias));
    float2 _233 = (_230.xy * float2(2.0)) - float2(1.0);
    float3 _249 = normalize(_190 * normalize((float4(_233, sqrt(fast::clamp(1.0 - dot(_233, _233), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _261 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.20000000298023223876953125), bias(View.View_MaterialTextureMipBias));
    float4 _266 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float4 _271 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0030000000260770320892333984375), bias(View.View_MaterialTextureMipBias));
    float4 _279 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _226, bias(View.View_MaterialTextureMipBias));
    float _282 = _279.w;
    float3 _287 = fast::clamp(_279.xyz * ((_261.x + 0.5) * ((_266.x + 0.5) * (_271.x + 0.5))), float3(0.0), float3(1.0));
    float _288 = fast::clamp(_282 * 4.0, 0.0, 1.0);
    float _293 = (fast::clamp(fast::min(fast::max(mix(1.0, -1.75, _282), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _294 = in.in_var_PRIMITIVE_ID * 36u;
    uint _295 = _294 + 20u;
    float _343;
    float _344;
    float _345;
    float3 _346;
    float3 _347;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _295)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _313 = ((_201.xy / float2(_201.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _317 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _313, level(0.0));
        float4 _320 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _313, level(0.0));
        float4 _323 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _313, level(0.0));
        float _333 = _323.w;
        _343 = (_293 * _333) + _323.z;
        _344 = (_288 * _333) + _323.y;
        _345 = _323.x;
        _346 = (_287 * _317.w) + _317.xyz;
        _347 = normalize((_249 * _320.w) + ((_320.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _343 = _293;
        _344 = _288;
        _345 = 0.0;
        _346 = _287;
        _347 = _249;
    }
    float3 _362 = ((_346 - (_346 * _345)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _369 = (mix(float3(0.07999999821186065673828125 * _344), _346, float3(_345)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _372 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _377;
    if (_372)
    {
        _377 = _362 + (_369 * 0.449999988079071044921875);
    }
    else
    {
        _377 = _362;
    }
    float3 _379 = select(_369, float3(0.0), bool3(_372));
    float3 _381 = float3(dot(_379, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _396 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _401 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _396);
    float4 _403 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_396 + float2(0.0, 0.5)));
    uint _409 = in.in_var_LIGHTMAP_ID * 15u;
    uint _410 = _409 + 4u;
    uint _415 = _409 + 6u;
    float3 _420 = _401.xyz;
    float3 _448 = ((((_420 * _420) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _410)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _415)].xyz) * ((exp2(((_401.w + ((_403.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _410)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _415)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_403 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _409 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _409 + 7u)], float4(_347.yzx, 1.0))))) * View.View_IndirectLightingColorScale;
    float3 _470 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _499;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _498;
        if (any(abs(_211 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _294 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _294 + 19u)].xyz + float3(1.0))))
        {
            _498 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_211, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _498 = _470;
        }
        _499 = _498;
    }
    else
    {
        _499 = _470;
    }
    float4 _506 = float4(((mix(float3(0.0), _377 + (_379 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_448 * _377) * fast::max(float3(1.0), ((((((_346 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_346 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_346 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _499) * 1.0, 0.0);
    float4 _513;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _512 = _506;
        _512.w = 0.0;
        _513 = _512;
    }
    else
    {
        _513 = _506;
    }
    float2 _517 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _525 = (_347 * 0.5) + float3(0.5);
    float4 _527 = float4(_525.x, _525.y, _525.z, float4(0.0).w);
    _527.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _295)].y;
    float4 _528 = float4(0.0);
    _528.x = _345;
    float4 _529 = _528;
    _529.y = _344;
    float4 _530 = _529;
    _530.z = _343;
    float4 _531 = _530;
    _531.w = 0.75686275959014892578125;
    float4 _543 = float4(_346.x, _346.y, _346.z, float4(0.0).w);
    _543.w = ((log2(((dot(_448, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_381 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_381 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_381 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_517.xyx * _517.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _513 * View.View_PreExposure;
    out.out_var_SV_Target1 = _527;
    out.out_var_SV_Target2 = _531;
    out.out_var_SV_Target3 = _543;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

