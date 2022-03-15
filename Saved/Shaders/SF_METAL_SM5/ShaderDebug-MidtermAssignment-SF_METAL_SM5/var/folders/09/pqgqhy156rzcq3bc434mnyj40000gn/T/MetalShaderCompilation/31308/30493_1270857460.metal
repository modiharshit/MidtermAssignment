

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
    char _m0_pad[64];
    float4x4 View_WorldToClip;
    char _m1_pad[64];
    float4x4 View_TranslatedWorldToView;
    char _m2_pad[448];
    float4x4 View_SVPositionToTranslatedWorld;
    char _m3_pad[304];
    float3 View_WorldCameraOrigin;
    char _m4_pad[32];
    float3 View_PreViewTranslation;
    char _m5_pad[928];
    float4 View_ViewRectMin;
    char _m6_pad[16];
    float4 View_LightProbeSizeRatioAndInvSizeRatio;
    char _m7_pad[52];
    float View_PreExposure;
    float4 View_DiffuseOverrideParameter;
    float4 View_SpecularOverrideParameter;
    float4 View_NormalOverrideParameter;
    float2 View_RoughnessOverrideParameter;
    char _m12_pad[8];
    float View_OutOfBoundsMask;
    char _m13_pad[80];
    float View_UnlitViewmodeMask;
    char _m14_pad[32];
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeMin;
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeInvSize;
    char _m16_pad[80];
    float3 View_IndirectLightingColorScale;
    char _m17_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m18_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m20_pad[120];
    float View_ReflectionCubemapMaxMip;
    char _m21_pad[20];
    packed_float3 View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight;
    int View_StereoPassIndex;
    char _m23_pad[160];
    float3 View_VolumetricFogInvGridSize;
    float3 View_VolumetricFogGridZParams;
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_TranslucentBasePass
{
    char _m0_pad[4];
    uint TranslucentBasePass_Shared_Forward_NumReflectionCaptures;
    char _m1_pad[4];
    uint TranslucentBasePass_Shared_Forward_NumGridCells;
    int3 TranslucentBasePass_Shared_Forward_CulledGridSize;
    uint TranslucentBasePass_Shared_Forward_LightGridPixelSizeShift;
    float3 TranslucentBasePass_Shared_Forward_LightGridZParams;
    char _m5_pad[1216];
    float4 TranslucentBasePass_Shared_Reflection_SkyLightParameters;
    float TranslucentBasePass_Shared_Reflection_SkyLightCubemapBrightness;
    char _m7_pad[64];
    float4 TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane;
    float4 TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionOrigin;
    float4 TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis;
    float4 TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis;
    float3x4 TranslucentBasePass_Shared_PlanarReflection_InverseTransposeMirrorMatrix;
    float3 TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters;
    float2 TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2;
    spvUnsafeArray<float4x4, 2> TranslucentBasePass_Shared_PlanarReflection_ProjectionWithExtraFOV;
    spvUnsafeArray<float4, 2> TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias;
    float2 TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound;
    uint TranslucentBasePass_Shared_PlanarReflection_bIsStereo;
    char _m18_pad[144];
    float TranslucentBasePass_Shared_Fog_ApplyVolumetricFog;
};

struct type_ReflectionCapture
{
    spvUnsafeArray<float4, 341> ReflectionCapture_PositionAndRadius;
    spvUnsafeArray<float4, 341> ReflectionCapture_CaptureProperties;
    spvUnsafeArray<float4, 341> ReflectionCapture_CaptureOffsetAndAverageBrightness;
    spvUnsafeArray<float4x4, 341> ReflectionCapture_BoxTransform;
    spvUnsafeArray<float4, 341> ReflectionCapture_BoxScales;
};

struct type_Material
{
    spvUnsafeArray<float4, 4> Material_VectorExpressions;
    spvUnsafeArray<float4, 2> Material_ScalarExpressions;
};

constant float _184 = {};
constant float3 _185 = {};
constant float2 _187 = {};
constant float4 _188 = {};
constant float3 _189 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPS_in
{
    float4 in_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 in_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 in_var_TEXCOORD4 [[user(locn2)]];
    uint in_var_PRIMITIVE_ID [[user(locn3)]];
    uint in_var_LIGHTMAP_ID [[user(locn4)]];
    float4 in_var_TEXCOORD7 [[user(locn5)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_0000771d_4bbfbef4(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(9)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(3)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(4)]], constant type_View& View [[buffer(5)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(6)]], constant type_ReflectionCapture& ReflectionCapture [[buffer(7)]], constant type_Material& Material [[buffer(8)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_NumCulledLightsGrid [[texture(0)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_CulledLightDataGrid [[texture(1)]], texturecube<float> TranslucentBasePass_Shared_Reflection_SkyLightCubemap [[texture(2)]], texturecube_array<float> TranslucentBasePass_Shared_Reflection_ReflectionCubemap [[texture(3)]], texture2d<float> TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture [[texture(4)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(5)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(6)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(7)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(8)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(9)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(10)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(11)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_Shared_Reflection_SkyLightCubemapSampler [[sampler(1)]], sampler TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler [[sampler(2)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[3];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[4];
    float4 _245 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _249 = _245.xyz / float3(_245.w);
    float3 _250 = _249 - View.View_PreViewTranslation;
    float3 _252 = normalize(-_249);
    float3 _260 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _277 = fast::clamp(Material.Material_VectorExpressions[3].xyz, float3(0.0), float3(1.0));
    float _283 = (fast::clamp(Material.Material_ScalarExpressions[0].z, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _284 = fast::clamp(Material.Material_ScalarExpressions[0].w, 0.0, 1.0);
    float3 _293 = (_277 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _300 = (float3(0.07999999821186065673828125 * fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _303 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _308;
    if (_303)
    {
        _308 = _293 + (_300 * 0.449999988079071044921875);
    }
    else
    {
        _308 = _293;
    }
    float3 _310 = select(_300, float3(0.0), bool3(_303));
    float2 _312 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _317 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _312);
    float4 _319 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_312 + float2(0.0, 0.5)));
    uint _325 = in.in_var_LIGHTMAP_ID * 15u;
    uint _326 = _325 + 4u;
    uint _331 = _325 + 6u;
    float3 _336 = _317.xyz;
    float _354 = _260.y;
    float _388;
    float _389;
    float3 _390;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _372 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _376 = _372.w;
        float _377 = _376 * _376;
        float3 _379 = normalize(((_372.xyz * 2.0) - float3(1.0)).xyz);
        float _380 = 1.0 - _377;
        float _382 = 1.0 - (_380 * _380);
        _388 = mix(fast::clamp(dot(_379, _260), 0.0, 1.0), 1.0, _382);
        _389 = _377;
        _390 = mix(_379, _260, float3(_382));
    }
    else
    {
        _388 = 1.0;
        _389 = 1.0;
        _390 = _260;
    }
    float4 _394 = float4(_390, 1.0);
    float3 _398 = _185;
    _398.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(4, spvBufferSizeConstants, float4, 0u)], _394);
    float3 _402 = _398;
    _402.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(4, spvBufferSizeConstants, float4, 1u)], _394);
    float3 _406 = _402;
    _406.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(4, spvBufferSizeConstants, float4, 2u)], _394);
    float4 _409 = _394.xyzz * _394.yzzx;
    float3 _413 = _185;
    _413.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(4, spvBufferSizeConstants, float4, 3u)], _409);
    float3 _417 = _413;
    _417.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(4, spvBufferSizeConstants, float4, 4u)], _409);
    float3 _421 = _417;
    _421.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(4, spvBufferSizeConstants, float4, 5u)], _409);
    float3 _436 = (((((_336 * _336) * View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _326)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _331)].xyz) * ((exp2(((_317.w + ((_319.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _326)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _331)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_319 * View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _325 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _325 + 7u)], float4(_354, _260.zx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_406 + _421) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(4, spvBufferSizeConstants, float4, 6u)].xyz * ((_390.x * _390.x) - (_390.y * _390.y)))) * View.View_SkyLightColor.xyz) * (_389 * _388));
    uint2 _481 = uint2((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_LightProbeSizeRatioAndInvSizeRatio.zw) >> (uint2(TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridPixelSizeShift) & uint2(31u));
    float3 _495 = (_260 * (2.0 * dot(_252, _260))) - _252;
    uint _501 = (TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumGridCells + ((((min(uint(fast::max(0.0, log2(((1.0 / gl_FragCoord.w) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.x) + TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.y) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.z)), uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.z - 1)) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.y)) + _481.y) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.x)) + _481.x)) * 2u;
    float _516 = 1.0 - (1.2000000476837158203125 * log2(fast::max(_283, 0.001000000047497451305389404296875)));
    float2 _520;
    float4 _523;
    _520 = float2(0.0, 1.0);
    _523 = float4(0.0, 0.0, 0.0, 1.0);
    float2 _521;
    float4 _524;
    for (uint _525 = 0u; _525 < min(TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint(_501)).x, TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumReflectionCaptures); _520 = _521, _523 = _524, _525++)
    {
        if (_523.w < 0.001000000047497451305389404296875)
        {
            break;
        }
        uint4 _536 = TranslucentBasePass_Shared_Forward_CulledLightDataGrid.read(uint((TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint((_501 + 1u))).x + _525)));
        uint _537 = _536.x;
        float3 _543 = _250 - ReflectionCapture.ReflectionCapture_PositionAndRadius[_537].xyz;
        float _544 = dot(_543, _543);
        float _545 = sqrt(_544);
        if (_545 < ReflectionCapture.ReflectionCapture_PositionAndRadius[_537].w)
        {
            float _636;
            float3 _637;
            if (ReflectionCapture.ReflectionCapture_CaptureProperties[_537].z > 0.0)
            {
                float3 _593 = (ReflectionCapture.ReflectionCapture_BoxTransform[_537] * float4(_250, 1.0)).xyz;
                float3 _599 = (ReflectionCapture.ReflectionCapture_BoxTransform[_537] * float4(_495, 0.0)).xyz;
                float3 _600 = float3(1.0) / _599;
                float3 _602 = _593 * _600;
                float3 _605 = fast::max((float3(-1.0) / _599) - _602, _600 - _602);
                float3 _619 = ReflectionCapture.ReflectionCapture_BoxScales[_537].xyz - float3(0.5 * ReflectionCapture.ReflectionCapture_BoxScales[_537].w);
                float3 _620 = -_619;
                float3 _621 = _593 * ReflectionCapture.ReflectionCapture_BoxScales[_537].xyz;
                _636 = 1.0 - smoothstep(0.0, 0.699999988079071044921875 * ReflectionCapture.ReflectionCapture_BoxScales[_537].w, dot(select(float3(0.0), abs(_621 - _620), _621 < _620), float3(1.0)) + dot(select(float3(0.0), abs(_621 - _619), _621 > _619), float3(1.0)));
                _637 = (_250 + (_495 * fast::min(_605.x, fast::min(_605.y, _605.z)))) - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_537].xyz + ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_537].xyz);
            }
            else
            {
                float _561 = dot(_495, _543);
                float _564 = (_561 * _561) - (_544 - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_537].w * ReflectionCapture.ReflectionCapture_PositionAndRadius[_537].w));
                float _581;
                float3 _582;
                if (_564 >= 0.0)
                {
                    float _575 = fast::clamp((2.5 * fast::clamp(_545 / ReflectionCapture.ReflectionCapture_PositionAndRadius[_537].w, 0.0, 1.0)) - 1.5, 0.0, 1.0);
                    _581 = 1.0 - ((_575 * _575) * (3.0 - (2.0 * _575)));
                    _582 = (_543 + (_495 * (sqrt(_564) - _561))) - ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_537].xyz;
                }
                else
                {
                    _581 = 0.0;
                    _582 = _495;
                }
                _636 = _581;
                _637 = _582;
            }
            float4 _644 = float4(_637, ReflectionCapture.ReflectionCapture_CaptureProperties[_537].y);
            float4 _646 = TranslucentBasePass_Shared_Reflection_ReflectionCubemap.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, _644.xyz, uint(round(_644.w)), level((View.View_ReflectionCubemapMaxMip - 1.0) - _516));
            float3 _649 = _646.xyz * ReflectionCapture.ReflectionCapture_CaptureProperties[_537].x;
            float4 _651 = float4(_649.x, _649.y, _649.z, _646.w) * _636;
            float3 _656 = _523.xyz + ((_651.xyz * _523.w) * 1.0);
            float4 _661 = float4(_656.x, _656.y, _656.z, _523.w);
            _661.w = _523.w * (1.0 - _651.w);
            float2 _668 = _187;
            _668.x = _520.x + ((ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_537].w * _636) * _520.y);
            float2 _671 = _668;
            _671.y = _520.y * (1.0 - _636);
            _521 = _671;
            _524 = _661;
        }
        else
        {
            _521 = _520;
            _524 = _523;
        }
    }
    float3 _673 = _523.xyz * View.View_IndirectLightingColorScale;
    float4 _674 = float4(_673.x, _673.y, _673.z, _523.w);
    float _677 = _520.x * dot(View.View_IndirectLightingColorScale, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float2 _678 = _187;
    _678.x = _677;
    float4 _720;
    float2 _721;
    float3 _722;
    if ((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightParameters.y > 0.0) && true)
    {
        float3 _698 = TranslucentBasePass_Shared_Reflection_SkyLightCubemap.sample(TranslucentBasePass_Shared_Reflection_SkyLightCubemapSampler, _495, level((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightParameters.x - 1.0) - _516)).xyz * View.View_SkyLightColor.xyz;
        float4 _717;
        float2 _718;
        float3 _719;
        if ((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightParameters.z < 1.0) && true)
        {
            float3 _711 = _673.xyz + ((_698 * _523.w) * 1.0);
            float2 _716 = _187;
            _716.x = _677 + ((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightCubemapBrightness * dot(View.View_SkyLightColor.xyz, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375))) * _520.y);
            _717 = float4(_711.x, _711.y, _711.z, _523.w);
            _718 = _716;
            _719 = float3(0.0);
        }
        else
        {
            _717 = _674;
            _718 = _678;
            _719 = _698 * 1.0;
        }
        _720 = _717;
        _721 = _718;
        _722 = _719;
    }
    else
    {
        _720 = _674;
        _721 = _678;
        _722 = float3(0.0);
    }
    float3 _744 = ((_720.xyz * mix(1.0, fast::min(dot(_436, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) / fast::max(_721.x, 9.9999997473787516355514526367188e-05), View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[2]), smoothstep(0.0, 1.0, fast::clamp((_283 * View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[0]) + View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[1], 0.0, 1.0)))).xyz + (_722 * _720.w)).xyz;
    float4 _746 = (float4(-1.0, -0.0274999998509883880615234375, -0.572000026702880859375, 0.02199999988079071044921875) * _283) + float4(1.0, 0.0425000004470348358154296875, 1.03999996185302734375, -0.039999999105930328369140625);
    float _747 = _746.x;
    float2 _757 = (float2(-1.03999996185302734375, 1.03999996185302734375) * ((fast::min(_747 * _747, exp2((-9.27999973297119140625) * fast::clamp(dot(_260, _252), 0.0, 1.0))) * _747) + _746.y)) + _746.zw;
    float3 _893;
    if (abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, float3(1.0))) > 9.9999997473787516355514526367188e-05)
    {
        float3 _793 = _250 - TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionOrigin.xyz;
        float _829 = (((1.0 - fast::clamp((abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane, float4(_250, -1.0))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.y, 0.0, 1.0)) * (fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.w - abs(dot(_793, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0) * fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.w - abs(dot(_793, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0))) * fast::clamp((dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, _260) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.y, 0.0, 1.0)) * (1.0 - fast::clamp((_283 - 0.20000000298023223876953125) * 10.0, 0.0, 1.0));
        float4 _887;
        if (_829 > 0.0)
        {
            float4 _858 = TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ProjectionWithExtraFOV[View.View_StereoPassIndex] * float4((View.View_TranslatedWorldToView * float4((_250 + (reflect(reflect(normalize(_250 - View.View_WorldCameraOrigin), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz), (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_InverseTransposeMirrorMatrix * _260).xyz) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.z)) + View.View_PreViewTranslation, 1.0)).xyz, 1.0);
            uint _865;
            if (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_bIsStereo != 0u)
            {
                _865 = uint(View.View_StereoPassIndex);
            }
            else
            {
                _865 = 0u;
            }
            float4 _882 = TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, ((fast::clamp(_858.xy / float2(_858.w), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_865].xy) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_865].zw), level(0.0));
            float4 _886 = float4(_882.x, _882.y, _882.z, float4(0.0).w);
            _886.w = _829 * _882.w;
            _887 = _886;
        }
        else
        {
            _887 = float4(0.0);
        }
        _893 = _887.xyz + (_744 * (1.0 - _887.w));
    }
    else
    {
        _893 = _744;
    }
    bool _911 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _960;
    if (_911)
    {
        float4 _918 = View.View_WorldToClip * float4(_250, 1.0);
        float _919 = _918.w;
        float4 _948;
        if (_911)
        {
            _948 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_918.xy / float2(_919)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_919 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _948 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _960 = float4(_948.xyz + (in.in_var_TEXCOORD7.xyz * _948.w), _948.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _960 = in.in_var_TEXCOORD7;
    }
    float3 _968 = (_250 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _976 = (_250 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _981 = fast::clamp((float3(0.5) - abs(_968 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _986 = (_981.x * _981.y) * _981.z;
    float4 _995 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _976, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _968, level(0.0)), float4(_986));
    float3 _1006 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _976, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _968, level(0.0)).xyz, float3(_986)) * 1.0;
    float4 _1008 = _188;
    _1008.x = _995.x;
    float4 _1010 = _188;
    _1010.x = _995.y;
    float4 _1012 = _188;
    _1012.x = _995.z;
    float3 _1013 = _995.xyz;
    float3 _1017 = _1013 / float3(dot(_1013, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _1019 = _1006 * _1017.x;
    float3 _1022 = _1006 * _1017.y;
    float3 _1025 = _1006 * _1017.z;
    float4 _1028 = _188;
    _1028.y = (-0.48860299587249755859375) * _354;
    float4 _1030 = _1028;
    _1030.z = 0.48860299587249755859375 * _260.z;
    float4 _1032 = _1030;
    _1032.w = (-0.48860299587249755859375) * _260.x;
    float4 _1033 = _1032;
    _1033.x = 0.886227548122406005859375;
    float3 _1035 = _1033.yzw * 2.094395160675048828125;
    float4 _1036 = float4(_1033.x, _1035.x, _1035.y, _1035.z);
    float3 _1038 = _189;
    _1038.x = dot(float4(_1008.x, _1019.x, _1019.y, _1019.z), _1036);
    float3 _1040 = _1038;
    _1040.y = dot(float4(_1010.x, _1022.x, _1022.y, _1022.z), _1036);
    float3 _1042 = _1040;
    _1042.z = dot(float4(_1012.x, _1025.x, _1025.y, _1025.z), _1036);
    float3 _1057 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _1088;
    float3 _1089;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _1063 = in.in_var_PRIMITIVE_ID * 36u;
        bool _1076 = any(abs(_250 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _1063 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _1063 + 19u)].xyz + float3(1.0)));
        float3 _1086;
        if (_1076)
        {
            _1086 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_250, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _1086 = _1057;
        }
        _1088 = _1076 ? 1.0 : _284;
        _1089 = _1086;
    }
    else
    {
        _1088 = _284;
        _1089 = _1057;
    }
    float4 _1099 = float4((((mix((((_893 * ((_310 * _757.x) + float3(fast::clamp(50.0 * _310.y, 0.0, 1.0) * _757.y))) * 1.0) * fast::max(float3(1.0), ((((((_310 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_310 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_310 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0)) + (_308 * float4(fast::max(float3(0.0), _1042), _184).xyz), _308 + (_310 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_436 * _308) * fast::max(float3(1.0), ((((((_277 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_277 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_277 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _1089) * _960.w) + _960.xyz, _1088);
    float3 _1103 = _1099.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_1103.x, _1103.y, _1103.z, _1099.w);
    return out;
}

