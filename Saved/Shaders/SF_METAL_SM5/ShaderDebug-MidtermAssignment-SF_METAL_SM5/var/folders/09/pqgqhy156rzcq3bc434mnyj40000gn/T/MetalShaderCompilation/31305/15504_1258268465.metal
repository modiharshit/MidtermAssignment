

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
    char _m15_pad[612];
    float View_RenderingReflectionCaptureMask;
    char _m16_pad[48];
    float4 View_SkyLightColor;
    char _m17_pad[124];
    float View_ShowDecalsMask;
    char _m18_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m19_pad[48];
    float3 View_VolumetricLightmapWorldToUVScale;
    float3 View_VolumetricLightmapWorldToUVAdd;
    packed_float3 View_VolumetricLightmapIndirectionTextureSize;
    float View_VolumetricLightmapBrickSize;
    float3 View_VolumetricLightmapBrickTexelSize;
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
    uint in_var_PRIMITIVE_ID [[user(locn3)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00003c90_4affa731(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _212 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _216 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _221 = (_216.xyz / float3(_216.w)) - View.View_PreViewTranslation;
    float4 _227 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _230 = (_227.xy * float2(2.0)) - float2(1.0);
    float2 _240 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125;
    float4 _244 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _240, bias(View.View_MaterialTextureMipBias));
    float _271;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _271 = _212.w;
                break;
            }
            else
            {
                float _255 = _212.z;
                _271 = ((_255 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_255 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _277 = float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _244.x) + _271) - 150.0) * 0.0005000000237487256526947021484375, 0.0), 1.0));
    float3 _286 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(float3(0.5, 0.5, 1.0) * float4(_230, sqrt(fast::clamp(1.0 - dot(_230, _230), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), _277) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _298 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _301 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _310 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.449999988079071044921875), bias(View.View_MaterialTextureMipBias));
    float _311 = _310.x;
    float _315 = _310.y;
    float _319 = _310.z;
    float4 _325 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _240, bias(View.View_MaterialTextureMipBias));
    float _326 = _325.x;
    float _330 = _325.y;
    float _334 = _325.z;
    float3 _342 = fast::min(fast::max(mix(float3((_311 <= 0.0) ? 0.0 : pow(_311, 2.0), (_315 <= 0.0) ? 0.0 : pow(_315, 2.0), (_319 <= 0.0) ? 0.0 : pow(_319, 2.0)), float3((_326 <= 0.0) ? 0.0 : pow(_326, 2.0), (_330 <= 0.0) ? 0.0 : pow(_330, 2.0), (_334 <= 0.0) ? 0.0 : pow(_334, 2.0)), _277) * fast::min(fast::max(1.0 - (_298.x * _301.x), 0.0), 1.0), float3(0.0)), float3(1.0));
    float3 _347 = fast::clamp(mix(_342, float3(dot(_342, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375))), float3(0.4000000059604644775390625)) * 0.699999988079071044921875, float3(0.0), float3(1.0));
    uint _349 = in.in_var_PRIMITIVE_ID * 36u;
    uint _350 = _349 + 20u;
    float _398;
    float _399;
    float _400;
    float3 _401;
    float3 _402;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _350)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _368 = ((_212.xy / float2(_212.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _372 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _368, level(0.0));
        float4 _375 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _368, level(0.0));
        float4 _378 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _368, level(0.0));
        float _388 = _378.w;
        _398 = (View.View_RoughnessOverrideParameter.x * _388) + _378.z;
        _399 = (0.5 * _388) + _378.y;
        _400 = _378.x;
        _401 = (_347 * _372.w) + _372.xyz;
        _402 = normalize((_286 * _375.w) + ((_375.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _398 = View.View_RoughnessOverrideParameter.x;
        _399 = 0.5;
        _400 = 0.0;
        _401 = _347;
        _402 = _286;
    }
    float _451;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _350)].z > 0.0)
    {
        float3 _419 = fast::clamp((_221 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _430 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_419.x), int(_419.y), int(_419.z), 0).xyz), 0));
        _451 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_430.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_419 / float3(_430.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _451 = 1.0;
    }
    float3 _465 = ((_401 - (_401 * _400)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _472 = (mix(float3(0.07999999821186065673828125 * _399), _401, float3(_400)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _475 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _480;
    if (_475)
    {
        _480 = _465 + (_472 * 0.449999988079071044921875);
    }
    else
    {
        _480 = _465;
    }
    float4 _486 = float4(_402, 1.0);
    float3 _490 = _154;
    _490.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _486);
    float3 _494 = _490;
    _494.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _486);
    float3 _498 = _494;
    _498.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _486);
    float4 _501 = _486.xyzz * _486.yzzx;
    float3 _505 = _154;
    _505.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _501);
    float3 _509 = _505;
    _509.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _501);
    float3 _513 = _509;
    _513.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _501);
    float3 _547 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _576;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _575;
        if (any(abs(_221 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _349 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _349 + 19u)].xyz + float3(1.0))))
        {
            _575 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_221, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _575 = _547;
        }
        _576 = _575;
    }
    else
    {
        _576 = _547;
    }
    float4 _583 = float4(((mix(float3(0.0), _480 + (select(_472, float3(0.0), bool3(_475)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((((fast::max(float3(0.0), (_498 + _513) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_402.x * _402.x) - (_402.y * _402.y)))) * View.View_SkyLightColor.xyz) * 1.0) * _480) * fast::max(float3(1.0), ((((((_401 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_401 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_401 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _576) * 1.0, 0.0);
    float4 _590;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _589 = _583;
        _589.w = 0.0;
        _590 = _589;
    }
    else
    {
        _590 = _583;
    }
    float2 _594 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _602 = (_402 * 0.5) + float3(0.5);
    float4 _604 = float4(_602.x, _602.y, _602.z, float4(0.0).w);
    _604.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _350)].y;
    float4 _605 = float4(0.0);
    _605.x = _400;
    float4 _606 = _605;
    _606.y = _399;
    float4 _607 = _606;
    _607.z = _398;
    float4 _608 = _607;
    _608.w = 0.50588238239288330078125;
    float4 _611 = float4(_401.x, _401.y, _401.z, float4(0.0).w);
    _611.w = (fract(dot(_594.xyx * _594.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _590 * View.View_PreExposure;
    out.out_var_SV_Target1 = _604;
    out.out_var_SV_Target2 = _608;
    out.out_var_SV_Target3 = _611;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_451, 1.0, 1.0, 1.0);
    return out;
}

