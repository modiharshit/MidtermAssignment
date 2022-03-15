

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
    char _m17_pad[48];
    float4 View_SkyLightColor;
    char _m18_pad[124];
    float View_ShowDecalsMask;
    char _m19_pad[184];
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

constant float3 _154 = {};

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

fragment MainPS_out Main_00003fa7_9ca99bc7(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> Material_Texture2D_0 [[texture(4)]], texture2d<float> Material_Texture2D_1 [[texture(5)]], texture2d<float> Material_Texture2D_2 [[texture(6)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _210 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _214 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _219 = (_214.xyz / float3(_214.w)) - View.View_PreViewTranslation;
    float4 _225 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _228 = (_225.xy * float2(2.0)) - float2(1.0);
    float2 _238 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125;
    float4 _242 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _238, bias(View.View_MaterialTextureMipBias));
    float _269;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _269 = _210.w;
                break;
            }
            else
            {
                float _253 = _210.z;
                _269 = ((_253 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_253 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _275 = float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _242.x) + _269) - 150.0) * 0.0005000000237487256526947021484375, 0.0), 1.0));
    float3 _284 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(float3(0.5, 0.5, 1.0) * float4(_228, sqrt(fast::clamp(1.0 - dot(_228, _228), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), _275) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _296 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _299 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _308 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.449999988079071044921875), bias(View.View_MaterialTextureMipBias));
    float _309 = _308.x;
    float _313 = _308.y;
    float _317 = _308.z;
    float4 _323 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _238, bias(View.View_MaterialTextureMipBias));
    float _324 = _323.x;
    float _328 = _323.y;
    float _332 = _323.z;
    float3 _340 = fast::min(fast::max(mix(float3((_309 <= 0.0) ? 0.0 : pow(_309, 2.0), (_313 <= 0.0) ? 0.0 : pow(_313, 2.0), (_317 <= 0.0) ? 0.0 : pow(_317, 2.0)), float3((_324 <= 0.0) ? 0.0 : pow(_324, 2.0), (_328 <= 0.0) ? 0.0 : pow(_328, 2.0), (_332 <= 0.0) ? 0.0 : pow(_332, 2.0)), _275) * fast::min(fast::max(1.0 - (_296.x * _299.x), 0.0), 1.0), float3(0.0)), float3(1.0));
    float3 _345 = fast::clamp(mix(_340, float3(dot(_340, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375))), float3(0.4000000059604644775390625)) * 0.699999988079071044921875, float3(0.0), float3(1.0));
    uint _347 = in.in_var_PRIMITIVE_ID * 36u;
    uint _348 = _347 + 20u;
    float _396;
    float _397;
    float _398;
    float3 _399;
    float3 _400;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _348)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _366 = ((_210.xy / float2(_210.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _370 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _366, level(0.0));
        float4 _373 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _366, level(0.0));
        float4 _376 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _366, level(0.0));
        float _386 = _376.w;
        _396 = (View.View_RoughnessOverrideParameter.x * _386) + _376.z;
        _397 = (0.5 * _386) + _376.y;
        _398 = _376.x;
        _399 = (_345 * _370.w) + _370.xyz;
        _400 = normalize((_284 * _373.w) + ((_373.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _396 = View.View_RoughnessOverrideParameter.x;
        _397 = 0.5;
        _398 = 0.0;
        _399 = _345;
        _400 = _284;
    }
    float3 _415 = ((_399 - (_399 * _398)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _422 = (mix(float3(0.07999999821186065673828125 * _397), _399, float3(_398)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _425 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _430;
    if (_425)
    {
        _430 = _415 + (_422 * 0.449999988079071044921875);
    }
    else
    {
        _430 = _415;
    }
    float3 _432 = select(_422, float3(0.0), bool3(_425));
    float3 _434 = float3(dot(_432, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _449 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _454 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _449);
    float4 _456 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_449 + float2(0.0, 0.5)));
    uint _458 = in.in_var_LIGHTMAP_ID * 15u;
    float3 _468 = (_454.xyz * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _458 + 4u)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _458 + 6u)].xyz;
    float _469 = dot(_468, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float _488 = (exp2((_469 * 16.0) - 8.0) - 0.00390625) * fast::max(0.0, dot((_456 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _458 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _458 + 7u)], float4(_400.yzx, 1.0)));
    float4 _499 = float4(_400, 1.0);
    float3 _503 = _154;
    _503.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _499);
    float3 _507 = _503;
    _507.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _499);
    float3 _511 = _507;
    _511.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _499);
    float4 _514 = _499.xyzz * _499.yzzx;
    float3 _518 = _154;
    _518.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _514);
    float3 _522 = _518;
    _522.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _514);
    float3 _526 = _522;
    _526.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _514);
    float3 _540 = (float4(_468 * (_488 / _469), _488).xyz * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_511 + _526) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_400.x * _400.x) - (_400.y * _400.y)))) * View.View_SkyLightColor.xyz) * 1.0);
    float3 _562 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _591;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _590;
        if (any(abs(_219 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _347 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _347 + 19u)].xyz + float3(1.0))))
        {
            _590 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_219, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _590 = _562;
        }
        _591 = _590;
    }
    else
    {
        _591 = _562;
    }
    float4 _598 = float4(((mix(float3(0.0), _430 + (_432 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_540 * _430) * fast::max(float3(1.0), ((((((_399 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_399 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_399 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _591) * 1.0, 0.0);
    float4 _605;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _604 = _598;
        _604.w = 0.0;
        _605 = _604;
    }
    else
    {
        _605 = _598;
    }
    float2 _609 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _617 = (_400 * 0.5) + float3(0.5);
    float4 _619 = float4(_617.x, _617.y, _617.z, float4(0.0).w);
    _619.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _348)].y;
    float4 _620 = float4(0.0);
    _620.x = _398;
    float4 _621 = _620;
    _621.y = _397;
    float4 _622 = _621;
    _622.z = _396;
    float4 _623 = _622;
    _623.w = 0.75686275959014892578125;
    float4 _635 = float4(_399.x, _399.y, _399.z, float4(0.0).w);
    _635.w = ((log2(((dot(_540, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_434 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_434 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_434 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_609.xyx * _609.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _605 * View.View_PreExposure;
    out.out_var_SV_Target1 = _619;
    out.out_var_SV_Target2 = _623;
    out.out_var_SV_Target3 = _635;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

