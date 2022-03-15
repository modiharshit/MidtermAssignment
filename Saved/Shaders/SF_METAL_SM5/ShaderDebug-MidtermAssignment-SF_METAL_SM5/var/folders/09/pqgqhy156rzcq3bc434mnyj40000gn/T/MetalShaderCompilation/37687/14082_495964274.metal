

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

constant float _141 = {};
constant float3 _142 = {};

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

fragment MainPS_out Main_00003702_1d8fd072(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _197 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _141, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _202 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _207 = (_202.xyz / float3(_202.w)) - View.View_PreViewTranslation;
    float4 _213 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _216 = (_213.xy * float2(2.0)) - float2(1.0);
    float _223 = sqrt(fast::clamp(1.0 - dot(_216, _216), 0.0, 1.0)) + 1.0;
    float2 _224 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 2.0;
    float4 _228 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _224, bias(View.View_MaterialTextureMipBias));
    float2 _231 = (_228.xy * float2(2.0)) - float2(1.0);
    float _235 = sqrt(fast::clamp(1.0 - dot(_231, _231), 0.0, 1.0));
    float3 _241 = float3(_216, _223);
    float3 _244 = float3(float4(_231, _235, 1.0).xy * (-1.0), _235);
    float3 _256 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((((_241 * dot(_241, _244)) - (_244 * _223)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _267 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _224, bias(View.View_MaterialTextureMipBias));
    float4 _271 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _276 = fast::clamp(_267.xyz, float3(0.0), float3(1.0));
    float _277 = fast::clamp(_271.x, 0.0, 1.0);
    float _282 = (fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _283 = in.in_var_PRIMITIVE_ID * 36u;
    uint _284 = _283 + 20u;
    float _332;
    float _333;
    float _334;
    float3 _335;
    float3 _336;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _284)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _302 = ((_197.xy / float2(_197.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _306 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _302, level(0.0));
        float4 _309 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _302, level(0.0));
        float4 _312 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _302, level(0.0));
        float _322 = _312.w;
        _332 = (_282 * _322) + _312.z;
        _333 = (0.5 * _322) + _312.y;
        _334 = _312.x;
        _335 = (_276 * _306.w) + _306.xyz;
        _336 = normalize((_256 * _309.w) + ((_309.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _332 = _282;
        _333 = 0.5;
        _334 = 0.0;
        _335 = _276;
        _336 = _256;
    }
    float _385;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _284)].z > 0.0)
    {
        float3 _353 = fast::clamp((_207 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _364 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_353.x), int(_353.y), int(_353.z), 0).xyz), 0));
        _385 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_364.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_353 / float3(_364.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _385 = 1.0;
    }
    float3 _399 = ((_335 - (_335 * _334)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _406 = (mix(float3(0.07999999821186065673828125 * _333), _335, float3(_334)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _409 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _414;
    if (_409)
    {
        _414 = _399 + (_406 * 0.449999988079071044921875);
    }
    else
    {
        _414 = _399;
    }
    float4 _420 = float4(_336, 1.0);
    float3 _424 = _142;
    _424.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _420);
    float3 _428 = _424;
    _428.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _420);
    float3 _432 = _428;
    _432.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _420);
    float4 _435 = _420.xyzz * _420.yzzx;
    float3 _439 = _142;
    _439.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _435);
    float3 _443 = _439;
    _443.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _435);
    float3 _447 = _443;
    _447.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _435);
    float3 _482 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _511;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _510;
        if (any(abs(_207 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _283 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _283 + 19u)].xyz + float3(1.0))))
        {
            _510 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_207, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _510 = _482;
        }
        _511 = _510;
    }
    else
    {
        _511 = _482;
    }
    float4 _518 = float4(((mix(float3(0.0), _414 + (select(_406, float3(0.0), bool3(_409)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((((fast::max(float3(0.0), (_432 + _447) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_336.x * _336.x) - (_336.y * _336.y)))) * View.View_SkyLightColor.xyz) * 1.0) * _414) * fast::max(float3(_277), ((((((_335 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _277) + ((_335 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _277) + ((_335 * 2.755199909210205078125) + float3(0.69029998779296875))) * _277))) + _511) * 1.0, 0.0);
    float4 _525;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _524 = _518;
        _524.w = 0.0;
        _525 = _524;
    }
    else
    {
        _525 = _518;
    }
    float2 _529 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _537 = (_336 * 0.5) + float3(0.5);
    float4 _539 = float4(_537.x, _537.y, _537.z, float4(0.0).w);
    _539.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _284)].y;
    float4 _540 = float4(0.0);
    _540.x = _334;
    float4 _541 = _540;
    _541.y = _333;
    float4 _542 = _541;
    _542.z = _332;
    float4 _543 = _542;
    _543.w = 0.50588238239288330078125;
    float4 _546 = float4(_335.x, _335.y, _335.z, float4(0.0).w);
    _546.w = (fract(dot(_529.xyx * _529.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _525 * View.View_PreExposure;
    out.out_var_SV_Target1 = _539;
    out.out_var_SV_Target2 = _543;
    out.out_var_SV_Target3 = _546;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_385, 1.0, 1.0, 1.0);
    return out;
}

