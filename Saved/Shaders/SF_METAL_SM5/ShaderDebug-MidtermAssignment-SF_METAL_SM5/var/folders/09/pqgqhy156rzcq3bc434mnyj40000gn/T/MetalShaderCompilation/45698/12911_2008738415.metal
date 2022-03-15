

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
    char _m11_pad[24];
    float View_CullingSign;
    char _m12_pad[52];
    float View_UnlitViewmodeMask;
    char _m13_pad[612];
    float View_RenderingReflectionCaptureMask;
    char _m14_pad[48];
    float4 View_SkyLightColor;
    char _m15_pad[124];
    float View_ShowDecalsMask;
    char _m16_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m17_pad[48];
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

constant float _138 = {};
constant float3 _139 = {};

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
    float4 in_var_COLOR0 [[user(locn2)]];
    float4 in_var_TEXCOORD0_0 [[user(locn3)]];
    uint in_var_PRIMITIVE_ID [[user(locn4)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_0000326f_77baea6f(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], float4 gl_FragCoord [[position]], bool gl_FrontFacing [[front_facing]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _198 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _138, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _203 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _208 = (_203.xyz / float3(_203.w)) - View.View_PreViewTranslation;
    uint _209 = in.in_var_PRIMITIVE_ID * 36u;
    float3 _225 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * ((View.View_CullingSign * View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _209 + 4u)].w) * float(gl_FrontFacing ? 1 : (-1)));
    if ((mix(-90.0, 90.0, Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y)).x) - 0.33329999446868896484375) < 0.0)
    {
        discard_fragment();
    }
    float3 _244 = fast::clamp(in.in_var_COLOR0.xyz, float3(0.0), float3(1.0));
    float _248 = (0.5 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _249 = _209 + 20u;
    float _297;
    float _298;
    float _299;
    float3 _300;
    float3 _301;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _249)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _267 = ((_198.xy / float2(_198.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _271 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _267, level(0.0));
        float4 _274 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _267, level(0.0));
        float4 _277 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _267, level(0.0));
        float _287 = _277.w;
        _297 = (_248 * _287) + _277.z;
        _298 = (0.5 * _287) + _277.y;
        _299 = _277.x;
        _300 = (_244 * _271.w) + _271.xyz;
        _301 = normalize((_225 * _274.w) + ((_274.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _297 = _248;
        _298 = 0.5;
        _299 = 0.0;
        _300 = _244;
        _301 = _225;
    }
    float _350;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _249)].z > 0.0)
    {
        float3 _318 = fast::clamp((_208 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _329 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_318.x), int(_318.y), int(_318.z), 0).xyz), 0));
        _350 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_329.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_318 / float3(_329.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _350 = 1.0;
    }
    float3 _364 = ((_300 - (_300 * _299)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _371 = (mix(float3(0.07999999821186065673828125 * _298), _300, float3(_299)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _374 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _379;
    if (_374)
    {
        _379 = _364 + (_371 * 0.449999988079071044921875);
    }
    else
    {
        _379 = _364;
    }
    float4 _385 = float4(_301, 1.0);
    float3 _389 = _139;
    _389.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _385);
    float3 _393 = _389;
    _393.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _385);
    float3 _397 = _393;
    _397.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _385);
    float4 _400 = _385.xyzz * _385.yzzx;
    float3 _404 = _139;
    _404.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _400);
    float3 _408 = _404;
    _408.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _400);
    float3 _412 = _408;
    _412.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _400);
    float3 _446 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _475;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _474;
        if (any(abs(_208 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _209 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _209 + 19u)].xyz + float3(1.0))))
        {
            _474 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_208, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _474 = _446;
        }
        _475 = _474;
    }
    else
    {
        _475 = _446;
    }
    float4 _482 = float4(((mix(float3(0.0), _379 + (select(_371, float3(0.0), bool3(_374)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((((fast::max(float3(0.0), (_397 + _412) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_301.x * _301.x) - (_301.y * _301.y)))) * View.View_SkyLightColor.xyz) * 1.0) * _379) * fast::max(float3(1.0), ((((((_300 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_300 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_300 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _475) * 1.0, 0.0);
    float4 _489;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _488 = _482;
        _488.w = 0.0;
        _489 = _488;
    }
    else
    {
        _489 = _482;
    }
    float2 _493 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _501 = (_301 * 0.5) + float3(0.5);
    float4 _503 = float4(_501.x, _501.y, _501.z, float4(0.0).w);
    _503.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _249)].y;
    float4 _504 = float4(0.0);
    _504.x = _299;
    float4 _505 = _504;
    _505.y = _298;
    float4 _506 = _505;
    _506.z = _297;
    float4 _507 = _506;
    _507.w = 0.50588238239288330078125;
    float4 _510 = float4(_300.x, _300.y, _300.z, float4(0.0).w);
    _510.w = (fract(dot(_493.xyx * _493.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _489 * View.View_PreExposure;
    out.out_var_SV_Target1 = _503;
    out.out_var_SV_Target2 = _507;
    out.out_var_SV_Target3 = _510;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_350, 1.0, 1.0, 1.0);
    return out;
}

