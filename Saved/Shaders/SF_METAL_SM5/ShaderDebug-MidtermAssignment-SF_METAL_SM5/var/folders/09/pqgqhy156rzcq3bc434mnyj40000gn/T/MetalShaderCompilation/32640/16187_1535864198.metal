

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
    char _m13_pad[36];
    float View_GameTime;
    char _m14_pad[8];
    float View_MaterialTextureMipBias;
    char _m15_pad[28];
    float View_UnlitViewmodeMask;
    char _m16_pad[612];
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

struct type_Material
{
    spvUnsafeArray<float4, 6> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float3 _161 = {};

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

fragment MainPS_out Main_00003f3b_5b8b6d86(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _220 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _224 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _229 = (_224.xyz / float3(_224.w)) - View.View_PreViewTranslation;
    float2 _236 = float2(View.View_GameTime * (-0.02999999932944774627685546875), View.View_GameTime * (-0.0199999995529651641845703125)) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(0.0500000007450580596923828125, 0.07999999821186065673828125));
    float4 _242 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _236, bias(View.View_MaterialTextureMipBias));
    float2 _245 = (_242.xy * float2(2.0)) - float2(1.0);
    float _252 = sqrt(fast::clamp(1.0 - dot(_245, _245), 0.0, 1.0)) + 1.0;
    float _260 = sin(((_229.x * 0.006666666828095912933349609375) + (View.View_GameTime * Material.Material_ScalarExpressions[0].x)) * 1.256637096405029296875);
    float4 _267 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(_260 * (-0.0599999986588954925537109375), _260 * (-0.039999999105930328369140625)) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(0.180000007152557373046875, 0.1500000059604644775390625))), bias(View.View_MaterialTextureMipBias));
    float2 _270 = (_267.xy * float2(2.0)) - float2(1.0);
    float3 _279 = float4(_270, sqrt(fast::clamp(1.0 - dot(_270, _270), 0.0, 1.0)), 1.0).xyz * float3(-1.0, -1.0, 1.0);
    float3 _282 = float3(_245, _252);
    float3 _286 = float3(_279.xy * (-1.0), _279.z);
    float3 _290 = (_282 * dot(_282, _286)) - (_286 * _252);
    float _292 = _290.z + 1.0;
    float2 _296 = float2(View.View_GameTime * (-0.070000000298023223876953125)) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.75);
    float4 _298 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _296, bias(View.View_MaterialTextureMipBias));
    float2 _301 = (_298.xy * float2(2.0)) - float2(1.0);
    float4 _313 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _340;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _340 = _220.w;
                break;
            }
            else
            {
                float _324 = _220.z;
                _340 = ((_324 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_324 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _347 = float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _313.x) + _340) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0));
    float3 _348 = mix(float4(_301, sqrt(fast::clamp(1.0 - dot(_301, _301), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), _347);
    float3 _353 = float3(_290.xy, _292);
    float3 _357 = float3(_348.xy * (-1.0), _348.z);
    float3 _369 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((((_353 * dot(_353, _357)) - (_357 * _292)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _380 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _296, bias(View.View_MaterialTextureMipBias));
    float4 _382 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _236, bias(View.View_MaterialTextureMipBias));
    float3 _397 = fast::clamp(mix(mix(Material.Material_VectorExpressions[4].xyz, Material.Material_VectorExpressions[5].xyz, float3(fast::min(fast::max(_380.x * _382.x, 0.0), 1.0))), Material.Material_VectorExpressions[4].xyz, _347), float3(0.0), float3(1.0));
    float _401 = (0.100000001490116119384765625 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _402 = in.in_var_PRIMITIVE_ID * 36u;
    uint _403 = _402 + 20u;
    float _451;
    float _452;
    float _453;
    float3 _454;
    float3 _455;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _403)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _421 = ((_220.xy / float2(_220.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _425 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _421, level(0.0));
        float4 _428 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _421, level(0.0));
        float4 _431 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _421, level(0.0));
        float _441 = _431.w;
        _451 = (_401 * _441) + _431.z;
        _452 = (0.5 * _441) + _431.y;
        _453 = _431.x;
        _454 = (_397 * _425.w) + _425.xyz;
        _455 = normalize((_369 * _428.w) + ((_428.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _451 = _401;
        _452 = 0.5;
        _453 = 0.0;
        _454 = _397;
        _455 = _369;
    }
    float _504;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _403)].z > 0.0)
    {
        float3 _472 = fast::clamp((_229 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _483 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_472.x), int(_472.y), int(_472.z), 0).xyz), 0));
        _504 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_483.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_472 / float3(_483.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _504 = 1.0;
    }
    float3 _518 = ((_454 - (_454 * _453)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _525 = (mix(float3(0.07999999821186065673828125 * _452), _454, float3(_453)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _528 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _533;
    if (_528)
    {
        _533 = _518 + (_525 * 0.449999988079071044921875);
    }
    else
    {
        _533 = _518;
    }
    float4 _539 = float4(_455, 1.0);
    float3 _543 = _161;
    _543.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _539);
    float3 _547 = _543;
    _547.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _539);
    float3 _551 = _547;
    _551.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _539);
    float4 _554 = _539.xyzz * _539.yzzx;
    float3 _558 = _161;
    _558.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _554);
    float3 _562 = _558;
    _562.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _554);
    float3 _566 = _562;
    _566.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _554);
    float3 _600 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].y)), float3(0.0));
    float3 _629;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _628;
        if (any(abs(_229 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _402 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _402 + 19u)].xyz + float3(1.0))))
        {
            _628 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_229, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _628 = _600;
        }
        _629 = _628;
    }
    else
    {
        _629 = _600;
    }
    float4 _636 = float4(((mix(float3(0.0), _533 + (select(_525, float3(0.0), bool3(_528)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((((fast::max(float3(0.0), (_551 + _566) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_455.x * _455.x) - (_455.y * _455.y)))) * View.View_SkyLightColor.xyz) * 1.0) * _533) * fast::max(float3(1.0), ((((((_454 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_454 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_454 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _629) * 1.0, 0.0);
    float4 _643;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _642 = _636;
        _642.w = 0.0;
        _643 = _642;
    }
    else
    {
        _643 = _636;
    }
    float2 _647 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _655 = (_455 * 0.5) + float3(0.5);
    float4 _657 = float4(_655.x, _655.y, _655.z, float4(0.0).w);
    _657.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _403)].y;
    float4 _658 = float4(0.0);
    _658.x = _453;
    float4 _659 = _658;
    _659.y = _452;
    float4 _660 = _659;
    _660.z = _451;
    float4 _661 = _660;
    _661.w = 0.50588238239288330078125;
    float4 _664 = float4(_454.x, _454.y, _454.z, float4(0.0).w);
    _664.w = (fract(dot(_647.xyx * _647.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _643 * View.View_PreExposure;
    out.out_var_SV_Target1 = _657;
    out.out_var_SV_Target2 = _661;
    out.out_var_SV_Target3 = _664;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_504, 1.0, 1.0, 1.0);
    return out;
}

