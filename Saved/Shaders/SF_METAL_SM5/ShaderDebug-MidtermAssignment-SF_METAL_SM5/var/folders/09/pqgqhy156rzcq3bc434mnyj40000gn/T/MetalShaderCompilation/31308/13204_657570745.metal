

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
    char _m13_pad[612];
    float View_RenderingReflectionCaptureMask;
    char _m14_pad[188];
    float View_ShowDecalsMask;
    char _m15_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m16_pad[48];
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

constant float _137 = {};

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

fragment MainPS_out Main_00003394_2731bbb9(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], texture2d<float> Material_Texture2D_4 [[texture(9)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], sampler Material_Texture2D_4Sampler [[sampler(6)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float3x3 _181 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _192 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _137, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _197 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _201 = _197.xyz / float3(_197.w);
    float3 _202 = _201 - View.View_PreViewTranslation;
    float2 _206 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5;
    float4 _212 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _206, bias(View.View_MaterialTextureMipBias));
    float2 _218 = ((normalize(-_201) * _181).xy * ((0.00999999977648258209228515625 * _212.w) + (-0.004999999888241291046142578125))) + _206;
    float4 _222 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _218, bias(View.View_MaterialTextureMipBias));
    float2 _225 = (_222.xy * float2(2.0)) - float2(1.0);
    float4 _238 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.100000001490116119384765625), bias(2.0 + View.View_MaterialTextureMipBias));
    float2 _241 = (_238.xy * float2(2.0)) - float2(1.0);
    float3 _260 = normalize(_181 * normalize(((float4(_225, sqrt(fast::clamp(1.0 - dot(_225, _225), 0.0, 1.0)), 1.0).xyz + (float4(_241, sqrt(fast::clamp(1.0 - dot(_241, _241), 0.0, 1.0)), 1.0).xyz * float3(0.20000000298023223876953125, 0.20000000298023223876953125, 0.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _272 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _277 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _280 = (_272.x + 0.5) * (_277.x + 0.5);
    float4 _283 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _218, bias(View.View_MaterialTextureMipBias));
    float4 _289 = Material_Texture2D_4.sample(Material_Texture2D_4Sampler, _218, bias(View.View_MaterialTextureMipBias));
    float3 _294 = fast::clamp(_283.xyz * mix(0.5, 1.0, _280), float3(0.0), float3(1.0));
    float _299 = (fast::clamp(mix(-0.300000011920928955078125, 0.800000011920928955078125, _289.x + (_280 * 0.20000000298023223876953125)), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _300 = in.in_var_PRIMITIVE_ID * 36u;
    uint _301 = _300 + 20u;
    float _349;
    float _350;
    float _351;
    float3 _352;
    float3 _353;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _301)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _319 = ((_192.xy / float2(_192.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _323 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _319, level(0.0));
        float4 _326 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _319, level(0.0));
        float4 _329 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _319, level(0.0));
        float _339 = _329.w;
        _349 = (_299 * _339) + _329.z;
        _350 = (0.5 * _339) + _329.y;
        _351 = _329.x;
        _352 = (_294 * _323.w) + _323.xyz;
        _353 = normalize((_260 * _326.w) + ((_326.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _349 = _299;
        _350 = 0.5;
        _351 = 0.0;
        _352 = _294;
        _353 = _260;
    }
    float _402;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _301)].z > 0.0)
    {
        float3 _370 = fast::clamp((_202 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _381 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_370.x), int(_370.y), int(_370.z), 0).xyz), 0));
        _402 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_381.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_370 / float3(_381.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _402 = 1.0;
    }
    float3 _416 = ((_352 - (_352 * _351)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _423 = (mix(float3(0.07999999821186065673828125 * _350), _352, float3(_351)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _426 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _431;
    if (_426)
    {
        _431 = _416 + (_423 * 0.449999988079071044921875);
    }
    else
    {
        _431 = _416;
    }
    float3 _440 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _469;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _468;
        if (any(abs(_202 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _300 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _300 + 19u)].xyz + float3(1.0))))
        {
            _468 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_202, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _468 = _440;
        }
        _469 = _468;
    }
    else
    {
        _469 = _440;
    }
    float4 _475 = float4((mix(float3(0.0), _431 + (select(_423, float3(0.0), bool3(_426)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + _469) * 1.0, 0.0);
    float4 _482;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _481 = _475;
        _481.w = 0.0;
        _482 = _481;
    }
    else
    {
        _482 = _475;
    }
    float2 _486 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _494 = (_353 * 0.5) + float3(0.5);
    float4 _496 = float4(_494.x, _494.y, _494.z, float4(0.0).w);
    _496.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _301)].y;
    float4 _497 = float4(0.0);
    _497.x = _351;
    float4 _498 = _497;
    _498.y = _350;
    float4 _499 = _498;
    _499.z = _349;
    float4 _500 = _499;
    _500.w = 0.50588238239288330078125;
    float4 _503 = float4(_352.x, _352.y, _352.z, float4(0.0).w);
    _503.w = (fract(dot(_486.xyx * _486.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _482 * View.View_PreExposure;
    out.out_var_SV_Target1 = _496;
    out.out_var_SV_Target2 = _500;
    out.out_var_SV_Target3 = _503;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_402, 1.0, 1.0, 1.0);
    return out;
}

