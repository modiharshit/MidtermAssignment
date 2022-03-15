

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
    spvUnsafeArray<float4, 8> Material_VectorExpressions;
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

fragment MainPS_out Main_000034c7_a53c4bc5(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _196 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _141, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _201 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _206 = (_201.xyz / float3(_201.w)) - View.View_PreViewTranslation;
    float4 _212 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _215 = (_212.xy * float2(2.0)) - float2(1.0);
    float3 _231 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_215, sqrt(fast::clamp(1.0 - dot(_215, _215), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _242 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _249 = _242.z;
    float _255 = _242.y;
    float3 _269 = fast::clamp(mix(mix(Material.Material_VectorExpressions[4].xyz, Material.Material_VectorExpressions[5].xyz, float3(_249)), Material.Material_VectorExpressions[7].xyz, float3(_255)) * _242.x, float3(0.0), float3(1.0));
    float _270 = fast::clamp(mix(0.0, 1.0, _255), 0.0, 1.0);
    float _275 = (fast::clamp(mix(mix(Material.Material_ScalarExpressions[0].y, Material.Material_ScalarExpressions[0].z, _249), Material.Material_ScalarExpressions[0].w, _255), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _276 = in.in_var_PRIMITIVE_ID * 36u;
    uint _277 = _276 + 20u;
    float _327;
    float _328;
    float _329;
    float3 _330;
    float3 _331;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _277)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _295 = ((_196.xy / float2(_196.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _299 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _295, level(0.0));
        float4 _302 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _295, level(0.0));
        float4 _305 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _295, level(0.0));
        float _315 = _305.w;
        _327 = (_275 * _315) + _305.z;
        _328 = (0.5 * _315) + _305.y;
        _329 = (_270 * _315) + _305.x;
        _330 = (_269 * _299.w) + _299.xyz;
        _331 = normalize((_231 * _302.w) + ((_302.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _327 = _275;
        _328 = 0.5;
        _329 = _270;
        _330 = _269;
        _331 = _231;
    }
    float _380;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _277)].z > 0.0)
    {
        float3 _348 = fast::clamp((_206 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _359 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_348.x), int(_348.y), int(_348.z), 0).xyz), 0));
        _380 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_359.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_348 / float3(_359.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _380 = 1.0;
    }
    float3 _394 = ((_330 - (_330 * _329)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _401 = (mix(float3(0.07999999821186065673828125 * _328), _330, float3(_329)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _404 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _409;
    if (_404)
    {
        _409 = _394 + (_401 * 0.449999988079071044921875);
    }
    else
    {
        _409 = _394;
    }
    float4 _415 = float4(_331, 1.0);
    float3 _419 = _142;
    _419.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _415);
    float3 _423 = _419;
    _423.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _415);
    float3 _427 = _423;
    _427.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _415);
    float4 _430 = _415.xyzz * _415.yzzx;
    float3 _434 = _142;
    _434.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _430);
    float3 _438 = _434;
    _438.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _430);
    float3 _442 = _438;
    _442.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _430);
    float3 _476 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _505;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _504;
        if (any(abs(_206 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _276 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _276 + 19u)].xyz + float3(1.0))))
        {
            _504 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_206, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _504 = _476;
        }
        _505 = _504;
    }
    else
    {
        _505 = _476;
    }
    float4 _512 = float4(((mix(float3(0.0), _409 + (select(_401, float3(0.0), bool3(_404)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((((fast::max(float3(0.0), (_427 + _442) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_331.x * _331.x) - (_331.y * _331.y)))) * View.View_SkyLightColor.xyz) * 1.0) * _409) * fast::max(float3(1.0), ((((((_330 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_330 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_330 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _505) * 1.0, 0.0);
    float4 _519;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _518 = _512;
        _518.w = 0.0;
        _519 = _518;
    }
    else
    {
        _519 = _512;
    }
    float2 _523 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _531 = (_331 * 0.5) + float3(0.5);
    float4 _533 = float4(_531.x, _531.y, _531.z, float4(0.0).w);
    _533.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _277)].y;
    float4 _534 = float4(0.0);
    _534.x = _329;
    float4 _535 = _534;
    _535.y = _328;
    float4 _536 = _535;
    _536.z = _327;
    float4 _537 = _536;
    _537.w = 0.50588238239288330078125;
    float4 _540 = float4(_330.x, _330.y, _330.z, float4(0.0).w);
    _540.w = (fract(dot(_523.xyx * _523.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _519 * View.View_PreExposure;
    out.out_var_SV_Target1 = _533;
    out.out_var_SV_Target2 = _537;
    out.out_var_SV_Target3 = _540;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_380, 1.0, 1.0, 1.0);
    return out;
}

