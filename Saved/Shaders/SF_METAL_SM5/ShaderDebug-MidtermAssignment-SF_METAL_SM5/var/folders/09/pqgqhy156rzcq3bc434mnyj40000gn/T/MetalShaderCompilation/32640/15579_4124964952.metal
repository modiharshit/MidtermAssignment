

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

constant float3 _153 = {};

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

fragment MainPS_out Main_00003cdb_f5ddf858(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _211 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _215 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _220 = (_215.xyz / float3(_215.w)) - View.View_PreViewTranslation;
    float2 _221 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.300000011920928955078125;
    float4 _227 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _221, bias(View.View_MaterialTextureMipBias));
    float2 _230 = (_227.xy * float2(2.0)) - float2(1.0);
    float2 _238 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.20000000298023223876953125;
    float4 _240 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _238, bias(View.View_MaterialTextureMipBias));
    float2 _243 = (_240.xy * float2(2.0)) - float2(1.0);
    float4 _255 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.008000000379979610443115234375), bias(View.View_MaterialTextureMipBias));
    float4 _260 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.004999999888241291046142578125), bias(View.View_MaterialTextureMipBias));
    float _262 = (_255.x + 0.5) * _260.x;
    float _264 = fast::min(fast::max(_262, 0.0), 1.0);
    float3 _267 = float3(_264);
    float4 _273 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _300;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _300 = _211.w;
                break;
            }
            else
            {
                float _284 = _211.z;
                _300 = ((_284 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_284 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _315 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(mix(float4(_230, sqrt(fast::clamp(1.0 - dot(_230, _230), 0.0, 1.0)), 1.0).xyz, float4(_243, sqrt(fast::clamp(1.0 - dot(_243, _243), 0.0, 1.0)), 1.0).xyz, _267), float3(0.0, 0.0, 1.0), float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _273.x) + _300) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _327 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _221, bias(View.View_MaterialTextureMipBias));
    float4 _329 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _238, bias(View.View_MaterialTextureMipBias));
    float3 _339 = fast::clamp(mix(_327.xyz, _329.xyz, _267) * mix(0.60000002384185791015625, 1.0, _262), float3(0.0), float3(1.0));
    float _344 = (fast::clamp(mix(0.949999988079071044921875, 0.699999988079071044921875, _262 * mix(_327.w, _329.w, _264)), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _345 = in.in_var_PRIMITIVE_ID * 36u;
    uint _346 = _345 + 20u;
    float _394;
    float _395;
    float _396;
    float3 _397;
    float3 _398;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _346)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _364 = ((_211.xy / float2(_211.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _368 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _364, level(0.0));
        float4 _371 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _364, level(0.0));
        float4 _374 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _364, level(0.0));
        float _384 = _374.w;
        _394 = (_344 * _384) + _374.z;
        _395 = (0.5 * _384) + _374.y;
        _396 = _374.x;
        _397 = (_339 * _368.w) + _368.xyz;
        _398 = normalize((_315 * _371.w) + ((_371.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _394 = _344;
        _395 = 0.5;
        _396 = 0.0;
        _397 = _339;
        _398 = _315;
    }
    float _447;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _346)].z > 0.0)
    {
        float3 _415 = fast::clamp((_220 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _426 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_415.x), int(_415.y), int(_415.z), 0).xyz), 0));
        _447 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_426.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_415 / float3(_426.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _447 = 1.0;
    }
    float3 _461 = ((_397 - (_397 * _396)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _468 = (mix(float3(0.07999999821186065673828125 * _395), _397, float3(_396)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _471 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _476;
    if (_471)
    {
        _476 = _461 + (_468 * 0.449999988079071044921875);
    }
    else
    {
        _476 = _461;
    }
    float4 _482 = float4(_398, 1.0);
    float3 _486 = _153;
    _486.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _482);
    float3 _490 = _486;
    _490.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _482);
    float3 _494 = _490;
    _494.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _482);
    float4 _497 = _482.xyzz * _482.yzzx;
    float3 _501 = _153;
    _501.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _497);
    float3 _505 = _501;
    _505.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _497);
    float3 _509 = _505;
    _509.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _497);
    float3 _543 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _572;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _571;
        if (any(abs(_220 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _345 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _345 + 19u)].xyz + float3(1.0))))
        {
            _571 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_220, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _571 = _543;
        }
        _572 = _571;
    }
    else
    {
        _572 = _543;
    }
    float4 _579 = float4(((mix(float3(0.0), _476 + (select(_468, float3(0.0), bool3(_471)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((((fast::max(float3(0.0), (_494 + _509) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_398.x * _398.x) - (_398.y * _398.y)))) * View.View_SkyLightColor.xyz) * 1.0) * _476) * fast::max(float3(1.0), ((((((_397 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_397 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_397 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _572) * 1.0, 0.0);
    float4 _586;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _585 = _579;
        _585.w = 0.0;
        _586 = _585;
    }
    else
    {
        _586 = _579;
    }
    float2 _590 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _598 = (_398 * 0.5) + float3(0.5);
    float4 _600 = float4(_598.x, _598.y, _598.z, float4(0.0).w);
    _600.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _346)].y;
    float4 _601 = float4(0.0);
    _601.x = _396;
    float4 _602 = _601;
    _602.y = _395;
    float4 _603 = _602;
    _603.z = _394;
    float4 _604 = _603;
    _604.w = 0.50588238239288330078125;
    float4 _607 = float4(_397.x, _397.y, _397.z, float4(0.0).w);
    _607.w = (fract(dot(_590.xyx * _590.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _586 * View.View_PreExposure;
    out.out_var_SV_Target1 = _600;
    out.out_var_SV_Target2 = _604;
    out.out_var_SV_Target3 = _607;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_447, 1.0, 1.0, 1.0);
    return out;
}

