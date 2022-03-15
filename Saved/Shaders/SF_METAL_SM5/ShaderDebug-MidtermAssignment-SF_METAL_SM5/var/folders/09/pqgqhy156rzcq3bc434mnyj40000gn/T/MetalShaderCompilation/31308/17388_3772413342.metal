

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
    char _m17_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m19_pad[124];
    float View_ShowDecalsMask;
    char _m20_pad[184];
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

constant float3 _158 = {};

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

fragment MainPS_out Main_000043ec_e0da759e(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], texture2d<float> Material_Texture2D_4 [[texture(9)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], sampler Material_Texture2D_4Sampler [[sampler(6)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _214 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _218 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _223 = (_218.xyz / float3(_218.w)) - View.View_PreViewTranslation;
    float2 _224 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5;
    float4 _230 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _224, bias(View.View_MaterialTextureMipBias));
    float2 _233 = (_230.xy * float2(2.0)) - float2(1.0);
    float3 _249 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_233, sqrt(fast::clamp(1.0 - dot(_233, _233), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _261 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (_224 * float2(0.25)), bias(View.View_MaterialTextureMipBias));
    float2 _264 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 2.0;
    float4 _269 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (_264 * 0.2134999930858612060546875), bias(View.View_MaterialTextureMipBias));
    float4 _274 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (_264 * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float _301;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _301 = _214.w;
                break;
            }
            else
            {
                float _285 = _214.z;
                _301 = ((_285 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_285 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float4 _309 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _312 = mix(_269.x + 0.5, _274.x + 0.5, fast::min(fast::max((_301 - 24.0) * 0.0009765625, 0.0), 1.0)) * (_309.x + 0.5);
    float4 _317 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _224, bias(View.View_MaterialTextureMipBias));
    float4 _330 = Material_Texture2D_4.sample(Material_Texture2D_4Sampler, _224, bias(View.View_MaterialTextureMipBias));
    float3 _336 = fast::clamp(fast::min(fast::max(((_317.xyz * mix(0.60000002384185791015625, 1.0, _312)) * mix(0.1500000059604644775390625, 0.699999988079071044921875, _261.x)) * Material.Material_VectorExpressions[3].xyz, float3(0.0)), float3(1.0)), float3(0.0), float3(1.0));
    float _337 = fast::clamp(_330.y, 0.0, 1.0);
    float _342 = (fast::clamp(mix(-0.300000011920928955078125, 1.0, _330.x + (_312 * 0.20000000298023223876953125)), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _343 = in.in_var_PRIMITIVE_ID * 36u;
    uint _344 = _343 + 20u;
    float _392;
    float _393;
    float _394;
    float3 _395;
    float3 _396;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _344)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _362 = ((_214.xy / float2(_214.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _366 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _362, level(0.0));
        float4 _369 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _362, level(0.0));
        float4 _372 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _362, level(0.0));
        float _382 = _372.w;
        _392 = (_342 * _382) + _372.z;
        _393 = (0.5 * _382) + _372.y;
        _394 = _372.x;
        _395 = (_336 * _366.w) + _366.xyz;
        _396 = normalize((_249 * _369.w) + ((_369.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _392 = _342;
        _393 = 0.5;
        _394 = 0.0;
        _395 = _336;
        _396 = _249;
    }
    float3 _411 = ((_395 - (_395 * _394)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _418 = (mix(float3(0.07999999821186065673828125 * _393), _395, float3(_394)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _421 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _426;
    if (_421)
    {
        _426 = _411 + (_418 * 0.449999988079071044921875);
    }
    else
    {
        _426 = _411;
    }
    float3 _428 = select(_418, float3(0.0), bool3(_421));
    float3 _430 = float3(dot(_428, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _437 = float3(_337);
    float2 _446 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _451 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _446);
    float4 _453 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_446 + float2(0.0, 0.5)));
    uint _459 = in.in_var_LIGHTMAP_ID * 15u;
    uint _460 = _459 + 4u;
    uint _465 = _459 + 6u;
    float3 _470 = _451.xyz;
    float _522;
    float _523;
    float3 _524;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _506 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _510 = _506.w;
        float _511 = _510 * _510;
        float3 _513 = normalize(((_506.xyz * 2.0) - float3(1.0)).xyz);
        float _514 = 1.0 - _511;
        float _516 = 1.0 - (_514 * _514);
        _522 = mix(fast::clamp(dot(_513, _396), 0.0, 1.0), 1.0, _516);
        _523 = _511;
        _524 = mix(_513, _396, float3(_516));
    }
    else
    {
        _522 = 1.0;
        _523 = 1.0;
        _524 = _396;
    }
    float4 _528 = float4(_524, 1.0);
    float3 _532 = _158;
    _532.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _528);
    float3 _536 = _532;
    _536.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _528);
    float3 _540 = _536;
    _540.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _528);
    float4 _543 = _528.xyzz * _528.yzzx;
    float3 _547 = _158;
    _547.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _543);
    float3 _551 = _547;
    _551.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _543);
    float3 _555 = _551;
    _555.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _543);
    float3 _570 = (((((_470 * _470) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _460)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _465)].xyz) * ((exp2(((_451.w + ((_453.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _460)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _465)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_453 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _459 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _459 + 7u)], float4(_396.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_540 + _555) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_524.x * _524.x) - (_524.y * _524.y)))) * View.View_SkyLightColor.xyz) * (_523 * _522));
    float3 _592 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _621;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _620;
        if (any(abs(_223 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _343 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _343 + 19u)].xyz + float3(1.0))))
        {
            _620 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_223, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _620 = _592;
        }
        _621 = _620;
    }
    else
    {
        _621 = _592;
    }
    float4 _628 = float4(((mix(float3(0.0), _426 + (_428 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_570 * _426) * fast::max(_437, ((((((_395 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _337) + ((_395 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _337) + ((_395 * 2.755199909210205078125) + float3(0.69029998779296875))) * _337))) + _621) * 1.0, 0.0);
    float4 _635;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _634 = _628;
        _634.w = 0.0;
        _635 = _634;
    }
    else
    {
        _635 = _628;
    }
    float2 _639 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _647 = (_396 * 0.5) + float3(0.5);
    float4 _649 = float4(_647.x, _647.y, _647.z, float4(0.0).w);
    _649.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _344)].y;
    float4 _650 = float4(0.0);
    _650.x = _394;
    float4 _651 = _650;
    _651.y = _393;
    float4 _652 = _651;
    _652.z = _392;
    float4 _653 = _652;
    _653.w = 0.75686275959014892578125;
    float4 _665 = float4(_395.x, _395.y, _395.z, float4(0.0).w);
    _665.w = ((log2(((dot(_570, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_437, ((((((_430 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _337) + ((_430 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _337) + ((_430 * 2.755199909210205078125) + float3(0.69029998779296875))) * _337).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_639.xyx * _639.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _635 * View.View_PreExposure;
    out.out_var_SV_Target1 = _649;
    out.out_var_SV_Target2 = _653;
    out.out_var_SV_Target3 = _665;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

