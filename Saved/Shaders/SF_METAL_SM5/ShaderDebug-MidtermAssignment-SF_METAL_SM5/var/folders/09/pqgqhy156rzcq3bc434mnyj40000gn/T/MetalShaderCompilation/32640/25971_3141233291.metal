

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
    char _m18_pad[184];
    float View_ReflectionCubemapMaxMip;
    char _m19_pad[20];
    packed_float3 View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight;
    int View_StereoPassIndex;
    char _m21_pad[160];
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
    char _m5_pad[1312];
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
    char _m16_pad[144];
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

constant float _175 = {};
constant float2 _177 = {};
constant float4 _178 = {};
constant float3 _179 = {};

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

fragment MainPS_out Main_00006573_bb3b6a8b(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(8)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(3)]], constant type_View& View [[buffer(4)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(5)]], constant type_ReflectionCapture& ReflectionCapture [[buffer(6)]], constant type_Material& Material [[buffer(7)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_NumCulledLightsGrid [[texture(0)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_CulledLightDataGrid [[texture(1)]], texturecube_array<float> TranslucentBasePass_Shared_Reflection_ReflectionCubemap [[texture(2)]], texture2d<float> TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture [[texture(3)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(4)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(5)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(6)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(7)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(8)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(9)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler [[sampler(1)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[3];
    float4 _232 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _236 = _232.xyz / float3(_232.w);
    float3 _237 = _236 - View.View_PreViewTranslation;
    float3 _239 = normalize(-_236);
    float3 _247 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _264 = fast::clamp(Material.Material_VectorExpressions[3].xyz, float3(0.0), float3(1.0));
    float _270 = (fast::clamp(Material.Material_ScalarExpressions[0].z, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _271 = fast::clamp(Material.Material_ScalarExpressions[0].w, 0.0, 1.0);
    float3 _280 = (_264 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _287 = (float3(0.07999999821186065673828125 * fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _290 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _295;
    if (_290)
    {
        _295 = _280 + (_287 * 0.449999988079071044921875);
    }
    else
    {
        _295 = _280;
    }
    float3 _297 = select(_287, float3(0.0), bool3(_290));
    float2 _299 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _304 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _299);
    float4 _306 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_299 + float2(0.0, 0.5)));
    uint _312 = in.in_var_LIGHTMAP_ID * 15u;
    uint _313 = _312 + 4u;
    uint _318 = _312 + 6u;
    float3 _323 = _304.xyz;
    float _341 = _247.y;
    float3 _351 = ((((_323 * _323) * View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _313)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _318)].xyz) * ((exp2(((_304.w + ((_306.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _313)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _318)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_306 * View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _312 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _312 + 7u)], float4(_341, _247.zx, 1.0))))) * View.View_IndirectLightingColorScale;
    uint2 _396 = uint2((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_LightProbeSizeRatioAndInvSizeRatio.zw) >> (uint2(TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridPixelSizeShift) & uint2(31u));
    float3 _410 = (_247 * (2.0 * dot(_239, _247))) - _239;
    uint _416 = (TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumGridCells + ((((min(uint(fast::max(0.0, log2(((1.0 / gl_FragCoord.w) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.x) + TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.y) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.z)), uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.z - 1)) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.y)) + _396.y) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.x)) + _396.x)) * 2u;
    float2 _435;
    float4 _438;
    _435 = float2(0.0, 1.0);
    _438 = float4(0.0, 0.0, 0.0, 1.0);
    float2 _436;
    float4 _439;
    for (uint _440 = 0u; _440 < min(TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint(_416)).x, TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumReflectionCaptures); _435 = _436, _438 = _439, _440++)
    {
        if (_438.w < 0.001000000047497451305389404296875)
        {
            break;
        }
        uint4 _451 = TranslucentBasePass_Shared_Forward_CulledLightDataGrid.read(uint((TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint((_416 + 1u))).x + _440)));
        uint _452 = _451.x;
        float3 _458 = _237 - ReflectionCapture.ReflectionCapture_PositionAndRadius[_452].xyz;
        float _459 = dot(_458, _458);
        float _460 = sqrt(_459);
        if (_460 < ReflectionCapture.ReflectionCapture_PositionAndRadius[_452].w)
        {
            float _551;
            float3 _552;
            if (ReflectionCapture.ReflectionCapture_CaptureProperties[_452].z > 0.0)
            {
                float3 _508 = (ReflectionCapture.ReflectionCapture_BoxTransform[_452] * float4(_237, 1.0)).xyz;
                float3 _514 = (ReflectionCapture.ReflectionCapture_BoxTransform[_452] * float4(_410, 0.0)).xyz;
                float3 _515 = float3(1.0) / _514;
                float3 _517 = _508 * _515;
                float3 _520 = fast::max((float3(-1.0) / _514) - _517, _515 - _517);
                float3 _534 = ReflectionCapture.ReflectionCapture_BoxScales[_452].xyz - float3(0.5 * ReflectionCapture.ReflectionCapture_BoxScales[_452].w);
                float3 _535 = -_534;
                float3 _536 = _508 * ReflectionCapture.ReflectionCapture_BoxScales[_452].xyz;
                _551 = 1.0 - smoothstep(0.0, 0.699999988079071044921875 * ReflectionCapture.ReflectionCapture_BoxScales[_452].w, dot(select(float3(0.0), abs(_536 - _535), _536 < _535), float3(1.0)) + dot(select(float3(0.0), abs(_536 - _534), _536 > _534), float3(1.0)));
                _552 = (_237 + (_410 * fast::min(_520.x, fast::min(_520.y, _520.z)))) - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_452].xyz + ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_452].xyz);
            }
            else
            {
                float _476 = dot(_410, _458);
                float _479 = (_476 * _476) - (_459 - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_452].w * ReflectionCapture.ReflectionCapture_PositionAndRadius[_452].w));
                float _496;
                float3 _497;
                if (_479 >= 0.0)
                {
                    float _490 = fast::clamp((2.5 * fast::clamp(_460 / ReflectionCapture.ReflectionCapture_PositionAndRadius[_452].w, 0.0, 1.0)) - 1.5, 0.0, 1.0);
                    _496 = 1.0 - ((_490 * _490) * (3.0 - (2.0 * _490)));
                    _497 = (_458 + (_410 * (sqrt(_479) - _476))) - ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_452].xyz;
                }
                else
                {
                    _496 = 0.0;
                    _497 = _410;
                }
                _551 = _496;
                _552 = _497;
            }
            float4 _559 = float4(_552, ReflectionCapture.ReflectionCapture_CaptureProperties[_452].y);
            float4 _561 = TranslucentBasePass_Shared_Reflection_ReflectionCubemap.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, _559.xyz, uint(round(_559.w)), level((View.View_ReflectionCubemapMaxMip - 1.0) - (1.0 - (1.2000000476837158203125 * log2(fast::max(_270, 0.001000000047497451305389404296875))))));
            float3 _564 = _561.xyz * ReflectionCapture.ReflectionCapture_CaptureProperties[_452].x;
            float4 _566 = float4(_564.x, _564.y, _564.z, _561.w) * _551;
            float3 _571 = _438.xyz + ((_566.xyz * _438.w) * 1.0);
            float4 _576 = float4(_571.x, _571.y, _571.z, _438.w);
            _576.w = _438.w * (1.0 - _566.w);
            float2 _583 = _177;
            _583.x = _435.x + ((ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_452].w * _551) * _435.y);
            float2 _586 = _583;
            _586.y = _435.y * (1.0 - _551);
            _436 = _586;
            _439 = _576;
        }
        else
        {
            _436 = _435;
            _439 = _438;
        }
    }
    float3 _608 = ((_438.xyz * View.View_IndirectLightingColorScale).xyz * mix(1.0, fast::min(dot(_351, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) / fast::max(_435.x * dot(View.View_IndirectLightingColorScale, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), 9.9999997473787516355514526367188e-05), View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[2]), smoothstep(0.0, 1.0, fast::clamp((_270 * View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[0]) + View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[1], 0.0, 1.0)))).xyz;
    float4 _610 = (float4(-1.0, -0.0274999998509883880615234375, -0.572000026702880859375, 0.02199999988079071044921875) * _270) + float4(1.0, 0.0425000004470348358154296875, 1.03999996185302734375, -0.039999999105930328369140625);
    float _611 = _610.x;
    float2 _621 = (float2(-1.03999996185302734375, 1.03999996185302734375) * ((fast::min(_611 * _611, exp2((-9.27999973297119140625) * fast::clamp(dot(_247, _239), 0.0, 1.0))) * _611) + _610.y)) + _610.zw;
    float3 _757;
    if (abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, float3(1.0))) > 9.9999997473787516355514526367188e-05)
    {
        float3 _657 = _237 - TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionOrigin.xyz;
        float _693 = (((1.0 - fast::clamp((abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane, float4(_237, -1.0))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.y, 0.0, 1.0)) * (fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.w - abs(dot(_657, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0) * fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.w - abs(dot(_657, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0))) * fast::clamp((dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, _247) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.y, 0.0, 1.0)) * (1.0 - fast::clamp((_270 - 0.20000000298023223876953125) * 10.0, 0.0, 1.0));
        float4 _751;
        if (_693 > 0.0)
        {
            float4 _722 = TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ProjectionWithExtraFOV[View.View_StereoPassIndex] * float4((View.View_TranslatedWorldToView * float4((_237 + (reflect(reflect(normalize(_237 - View.View_WorldCameraOrigin), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz), (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_InverseTransposeMirrorMatrix * _247).xyz) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.z)) + View.View_PreViewTranslation, 1.0)).xyz, 1.0);
            uint _729;
            if (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_bIsStereo != 0u)
            {
                _729 = uint(View.View_StereoPassIndex);
            }
            else
            {
                _729 = 0u;
            }
            float4 _746 = TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, ((fast::clamp(_722.xy / float2(_722.w), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_729].xy) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_729].zw), level(0.0));
            float4 _750 = float4(_746.x, _746.y, _746.z, float4(0.0).w);
            _750.w = _693 * _746.w;
            _751 = _750;
        }
        else
        {
            _751 = float4(0.0);
        }
        _757 = _751.xyz + (_608 * (1.0 - _751.w));
    }
    else
    {
        _757 = _608;
    }
    bool _775 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _824;
    if (_775)
    {
        float4 _782 = View.View_WorldToClip * float4(_237, 1.0);
        float _783 = _782.w;
        float4 _812;
        if (_775)
        {
            _812 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_782.xy / float2(_783)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_783 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _812 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _824 = float4(_812.xyz + (in.in_var_TEXCOORD7.xyz * _812.w), _812.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _824 = in.in_var_TEXCOORD7;
    }
    float3 _832 = (_237 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _840 = (_237 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _845 = fast::clamp((float3(0.5) - abs(_832 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _850 = (_845.x * _845.y) * _845.z;
    float4 _859 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _840, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _832, level(0.0)), float4(_850));
    float3 _870 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _840, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _832, level(0.0)).xyz, float3(_850)) * 1.0;
    float4 _872 = _178;
    _872.x = _859.x;
    float4 _874 = _178;
    _874.x = _859.y;
    float4 _876 = _178;
    _876.x = _859.z;
    float3 _877 = _859.xyz;
    float3 _881 = _877 / float3(dot(_877, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _883 = _870 * _881.x;
    float3 _886 = _870 * _881.y;
    float3 _889 = _870 * _881.z;
    float4 _892 = _178;
    _892.y = (-0.48860299587249755859375) * _341;
    float4 _894 = _892;
    _894.z = 0.48860299587249755859375 * _247.z;
    float4 _896 = _894;
    _896.w = (-0.48860299587249755859375) * _247.x;
    float4 _897 = _896;
    _897.x = 0.886227548122406005859375;
    float3 _899 = _897.yzw * 2.094395160675048828125;
    float4 _900 = float4(_897.x, _899.x, _899.y, _899.z);
    float3 _902 = _179;
    _902.x = dot(float4(_872.x, _883.x, _883.y, _883.z), _900);
    float3 _904 = _902;
    _904.y = dot(float4(_874.x, _886.x, _886.y, _886.z), _900);
    float3 _906 = _904;
    _906.z = dot(float4(_876.x, _889.x, _889.y, _889.z), _900);
    float3 _921 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _952;
    float3 _953;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _927 = in.in_var_PRIMITIVE_ID * 36u;
        bool _940 = any(abs(_237 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _927 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _927 + 19u)].xyz + float3(1.0)));
        float3 _950;
        if (_940)
        {
            _950 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_237, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _950 = _921;
        }
        _952 = _940 ? 1.0 : _271;
        _953 = _950;
    }
    else
    {
        _952 = _271;
        _953 = _921;
    }
    float4 _963 = float4((((mix((((_757 * ((_297 * _621.x) + float3(fast::clamp(50.0 * _297.y, 0.0, 1.0) * _621.y))) * 1.0) * fast::max(float3(1.0), ((((((_297 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_297 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_297 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0)) + (_295 * float4(fast::max(float3(0.0), _906), _175).xyz), _295 + (_297 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_351 * _295) * fast::max(float3(1.0), ((((((_264 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_264 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_264 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _953) * _824.w) + _824.xyz, _952);
    float3 _967 = _963.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_967.x, _967.y, _967.z, _963.w);
    return out;
}

