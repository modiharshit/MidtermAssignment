

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
    char _m0_pad[256];
    float4x4 View_ViewToTranslatedWorld;
    char _m1_pad[384];
    float4x4 View_SVPositionToTranslatedWorld;
    char _m2_pad[288];
    float4 View_ScreenPositionScaleBias;
    float3 View_WorldCameraOrigin;
    char _m4_pad[32];
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
    char _m15_pad[600];
    packed_float3 View_NormalCurvatureToRoughnessScaleBias;
    float View_RenderingReflectionCaptureMask;
    char _m17_pad[48];
    float4 View_SkyLightColor;
    char _m18_pad[124];
    float View_ShowDecalsMask;
    char _m19_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m20_pad[48];
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

struct type_PrimitiveDither
{
    float PrimitiveDither_LODFactor;
};

struct type_Material
{
    spvUnsafeArray<float4, 6> Material_VectorExpressions;
    spvUnsafeArray<float4, 4> Material_ScalarExpressions;
};

constant float _153 = {};
constant float4x4 _154 = {};
constant float _155 = {};
constant float3 _156 = {};

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
    float4 in_var_TEXCOORD15 [[user(locn2)]];
    float4 in_var_TEXCOORD0_0 [[user(locn3)]];
    uint in_var_PRIMITIVE_ID [[user(locn4)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00004468_f5830d5d(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_PrimitiveDither& PrimitiveDither [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_3 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_3Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float3x3 _208 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _220 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _155, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _225 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _230 = (_225.xyz / float3(_225.w)) - View.View_PreViewTranslation;
    uint _231 = in.in_var_PRIMITIVE_ID * 36u;
    float4x4 _234 = _154;
    _234[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _231)];
    float4x4 _238 = _234;
    _238[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _231 + 1u)];
    float4x4 _242 = _238;
    _242[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _231 + 2u)];
    float4x4 _246 = _242;
    _246[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _231 + 3u)];
    float3 _249 = (_246 * float4(0.0, 0.0, 0.0, 1.0)).xyz - View.View_WorldCameraOrigin;
    float4 _261 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _264 = (float3(-0.5) + _261.xyz) * 2.0;
    float3 _280 = ((((_249 / float3(sqrt(dot(_249, _249)))) * _208) * (-1.0)) * _264.z) + (float3(_264.xy, 0.0) * ((float3x3(View.View_ViewToTranslatedWorld[0].xyz, View.View_ViewToTranslatedWorld[1].xyz, View.View_ViewToTranslatedWorld[2].xyz) * float3(1.0, 1.0, 0.0)) * _208));
    float3 _292 = normalize(_208 * normalize(((_280 / float3(sqrt(dot(_280, _280)))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _303 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _310 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    if (PrimitiveDither.PrimitiveDither_LODFactor != 0.0)
    {
        if (abs(PrimitiveDither.PrimitiveDither_LODFactor) > 0.001000000047497451305389404296875)
        {
            float _330 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
            if ((float((PrimitiveDither.PrimitiveDither_LODFactor < 0.0) ? ((PrimitiveDither.PrimitiveDither_LODFactor + 1.0) > _330) : (PrimitiveDither.PrimitiveDither_LODFactor < _330)) - 0.001000000047497451305389404296875) < 0.0)
            {
                discard_fragment();
            }
        }
    }
    if (((_303.w * in_var_TEXCOORD0[0].z) - 0.100000001490116119384765625) < 0.0)
    {
        discard_fragment();
    }
    float3 _345 = fast::clamp(_303.xyz, float3(0.0), float3(1.0));
    float _350 = (fast::clamp(_261.w, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float3 _360 = (fast::clamp(float4(_310.xyz, _153).xyz, float3(0.0), float3(1.0)).xyz * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    uint _361 = _231 + 20u;
    float3 _410;
    float _411;
    float _412;
    float _413;
    float3 _414;
    float3 _415;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _361)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _379 = ((_220.xy / float2(_220.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _383 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _379, level(0.0));
        float4 _386 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _379, level(0.0));
        float4 _389 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _379, level(0.0));
        float _391 = _383.w;
        float _399 = _389.w;
        _410 = _360 * _391;
        _411 = (_350 * _399) + _389.z;
        _412 = (0.5 * _399) + _389.y;
        _413 = _389.x;
        _414 = (_345 * _391) + _383.xyz;
        _415 = normalize((_292 * _386.w) + ((_386.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _410 = _360;
        _411 = _350;
        _412 = 0.5;
        _413 = 0.0;
        _414 = _345;
        _415 = _292;
    }
    float _464;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _361)].z > 0.0)
    {
        float3 _432 = fast::clamp((_230 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _443 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_432.x), int(_432.y), int(_432.z), 0).xyz), 0));
        _464 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_443.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_432 / float3(_443.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _464 = 1.0;
    }
    float3 _467 = sqrt(fast::clamp(_410, float3(0.0), float3(1.0)));
    float4 _469 = float4(_467.x, _467.y, _467.z, float4(0.0).w);
    _469.w = 1.0;
    float3 _474 = dfdx(in.in_var_TEXCOORD15.xyz);
    float3 _475 = dfdy(in.in_var_TEXCOORD15.xyz);
    float3 _493 = ((_414 - (_414 * _413)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _500 = (mix(float3(0.07999999821186065673828125 * _412), _414, float3(_413)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _503 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _508;
    if (_503)
    {
        _508 = _493 + (_500 * 0.449999988079071044921875);
    }
    else
    {
        _508 = _493;
    }
    float4 _514 = float4(_415, 1.0);
    float3 _518 = _156;
    _518.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _514);
    float3 _522 = _518;
    _522.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _514);
    float3 _526 = _522;
    _526.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _514);
    float4 _529 = _514.xyzz * _514.yzzx;
    float3 _533 = _156;
    _533.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _529);
    float3 _537 = _533;
    _537.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _529);
    float3 _541 = _537;
    _541.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _529);
    float3 _555 = -_415;
    float _556 = _555.x;
    float _557 = _555.y;
    float4 _559 = float4(_556, _557, _555.z, 1.0);
    float3 _562 = _156;
    _562.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _559);
    float3 _565 = _562;
    _565.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _559);
    float3 _568 = _565;
    _568.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _559);
    float4 _571 = _559.xyzz * _559.yzzx;
    float3 _574 = _156;
    _574.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _571);
    float3 _577 = _574;
    _577.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _571);
    float3 _580 = _577;
    _580.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _571);
    float3 _614 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _643;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _642;
        if (any(abs(_230 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _231 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _231 + 19u)].xyz + float3(1.0))))
        {
            _642 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_230, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _642 = _614;
        }
        _643 = _642;
    }
    else
    {
        _643 = _614;
    }
    float4 _650 = float4(((mix(float3(0.0), _508 + (select(_500, float3(0.0), bool3(_503)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + (((((fast::max(float3(0.0), (_526 + _541) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_415.x * _415.x) - (_415.y * _415.y)))) * View.View_SkyLightColor.xyz) * 1.0) * _508) + (((fast::max(float3(0.0), (_568 + _580) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_556 * _556) - (_557 * _557)))) * View.View_SkyLightColor.xyz) * 1.0) * _410)) * fast::max(float3(1.0), ((((((_414 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_414 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_414 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _643) * 1.0, 0.0);
    float4 _657;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _656 = _650;
        _656.w = 0.0;
        _657 = _656;
    }
    else
    {
        _657 = _650;
    }
    float2 _661 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _669 = (_415 * 0.5) + float3(0.5);
    float4 _671 = float4(_669.x, _669.y, _669.z, float4(0.0).w);
    _671.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _361)].y;
    float4 _672 = float4(0.0);
    _672.x = _413;
    float4 _673 = _672;
    _673.y = _412;
    float4 _674 = _673;
    _674.z = fast::max(_411, fast::clamp((pow(fast::max(dot(_474, _474), dot(_475, _475)), View.View_NormalCurvatureToRoughnessScaleBias[2]) * View.View_NormalCurvatureToRoughnessScaleBias[0]) + View.View_NormalCurvatureToRoughnessScaleBias[1], 0.0, 1.0));
    float4 _675 = _674;
    _675.w = 0.525490224361419677734375;
    float4 _678 = float4(_414.x, _414.y, _414.z, float4(0.0).w);
    _678.w = (fract(dot(_661.xyx * _661.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _657 * View.View_PreExposure;
    out.out_var_SV_Target1 = _671;
    out.out_var_SV_Target2 = _675;
    out.out_var_SV_Target3 = _678;
    out.out_var_SV_Target4 = _469;
    out.out_var_SV_Target5 = float4(_464, 1.0, 1.0, 1.0);
    return out;
}

