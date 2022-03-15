

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
    char _m13_pad[48];
    float View_MaterialTextureMipBias;
    char _m14_pad[28];
    float View_UnlitViewmodeMask;
    char _m15_pad[32];
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeMin;
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeInvSize;
    char _m17_pad[80];
    float3 View_IndirectLightingColorScale;
    char _m18_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m19_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m21_pad[120];
    float View_ReflectionCubemapMaxMip;
    char _m22_pad[20];
    packed_float3 View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight;
    int View_StereoPassIndex;
    char _m24_pad[160];
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

constant float _198 = {};
constant float3 _199 = {};
constant float2 _201 = {};
constant float4 _202 = {};
constant float3 _203 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPS_in
{
    float4 in_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 in_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 in_var_TEXCOORD0_0 [[user(locn2)]];
    float4 in_var_TEXCOORD4 [[user(locn3)]];
    uint in_var_PRIMITIVE_ID [[user(locn4)]];
    uint in_var_LIGHTMAP_ID [[user(locn5)]];
    float4 in_var_TEXCOORD7 [[user(locn6)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00007ca3_027214af(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(9)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(3)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(4)]], constant type_View& View [[buffer(5)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(6)]], constant type_ReflectionCapture& ReflectionCapture [[buffer(7)]], constant type_Material& Material [[buffer(8)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_NumCulledLightsGrid [[texture(0)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_CulledLightDataGrid [[texture(1)]], texturecube<float> TranslucentBasePass_Shared_Reflection_SkyLightCubemap [[texture(2)]], texturecube_array<float> TranslucentBasePass_Shared_Reflection_ReflectionCubemap [[texture(3)]], texture2d<float> TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture [[texture(4)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(5)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(6)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(7)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(8)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(9)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(10)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(11)]], texture2d<float> Material_Texture2D_0 [[texture(12)]], texture2d<float> Material_Texture2D_1 [[texture(13)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_Shared_Reflection_SkyLightCubemapSampler [[sampler(1)]], sampler TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler [[sampler(2)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(3)]], sampler Material_Texture2D_0Sampler [[sampler(4)]], sampler Material_Texture2D_1Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[3];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[4];
    float4 _263 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _267 = _263.xyz / float3(_263.w);
    float3 _268 = _267 - View.View_PreViewTranslation;
    float3 _270 = normalize(-_267);
    float4 _276 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _279 = (_276.xy * float2(2.0)) - float2(1.0);
    float3 _295 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_279, sqrt(fast::clamp(1.0 - dot(_279, _279), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _306 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _312 = dot(_295, _270);
    float _316 = fast::max(abs(1.0 - fast::max(0.0, _312)), 9.9999997473787516355514526367188e-05);
    float3 _331 = fast::clamp(Material.Material_VectorExpressions[3].xyz * _306.x, float3(0.0), float3(1.0));
    float _337 = (fast::clamp(Material.Material_ScalarExpressions[0].z, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _338 = fast::clamp(mix(Material.Material_ScalarExpressions[0].w, Material.Material_ScalarExpressions[1].x, (((_316 <= 0.0) ? 0.0 : pow(_316, 4.0)) * 0.959999978542327880859375) + 0.039999999105930328369140625), 0.0, 1.0);
    float3 _350 = ((_331 - (_331 * 0.89999997615814208984375)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _357 = (mix(float3(0.07999999821186065673828125 * fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0)), _331, float3(0.89999997615814208984375)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _360 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _365;
    if (_360)
    {
        _365 = _350 + (_357 * 0.449999988079071044921875);
    }
    else
    {
        _365 = _350;
    }
    float3 _367 = select(_357, float3(0.0), bool3(_360));
    float2 _369 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _374 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _369);
    float4 _376 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_369 + float2(0.0, 0.5)));
    uint _382 = in.in_var_LIGHTMAP_ID * 15u;
    uint _383 = _382 + 4u;
    uint _388 = _382 + 6u;
    float3 _393 = _374.xyz;
    float _411 = _295.y;
    float _445;
    float _446;
    float3 _447;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _429 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _433 = _429.w;
        float _434 = _433 * _433;
        float3 _436 = normalize(((_429.xyz * 2.0) - float3(1.0)).xyz);
        float _437 = 1.0 - _434;
        float _439 = 1.0 - (_437 * _437);
        _445 = mix(fast::clamp(dot(_436, _295), 0.0, 1.0), 1.0, _439);
        _446 = _434;
        _447 = mix(_436, _295, float3(_439));
    }
    else
    {
        _445 = 1.0;
        _446 = 1.0;
        _447 = _295;
    }
    float4 _451 = float4(_447, 1.0);
    float3 _455 = _199;
    _455.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(4, spvBufferSizeConstants, float4, 0u)], _451);
    float3 _459 = _455;
    _459.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(4, spvBufferSizeConstants, float4, 1u)], _451);
    float3 _463 = _459;
    _463.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(4, spvBufferSizeConstants, float4, 2u)], _451);
    float4 _466 = _451.xyzz * _451.yzzx;
    float3 _470 = _199;
    _470.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(4, spvBufferSizeConstants, float4, 3u)], _466);
    float3 _474 = _470;
    _474.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(4, spvBufferSizeConstants, float4, 4u)], _466);
    float3 _478 = _474;
    _478.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(4, spvBufferSizeConstants, float4, 5u)], _466);
    float3 _493 = (((((_393 * _393) * View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _383)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _388)].xyz) * ((exp2(((_374.w + ((_376.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _383)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _388)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_376 * View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _382 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _382 + 7u)], float4(_411, _295.zx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_463 + _478) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(4, spvBufferSizeConstants, float4, 6u)].xyz * ((_447.x * _447.x) - (_447.y * _447.y)))) * View.View_SkyLightColor.xyz) * (_446 * _445));
    uint2 _538 = uint2((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_LightProbeSizeRatioAndInvSizeRatio.zw) >> (uint2(TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridPixelSizeShift) & uint2(31u));
    float3 _552 = (_295 * (2.0 * dot(_270, _295))) - _270;
    uint _557 = (TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumGridCells + ((((min(uint(fast::max(0.0, log2(((1.0 / gl_FragCoord.w) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.x) + TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.y) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.z)), uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.z - 1)) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.y)) + _538.y) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.x)) + _538.x)) * 2u;
    float _572 = 1.0 - (1.2000000476837158203125 * log2(fast::max(_337, 0.001000000047497451305389404296875)));
    float2 _576;
    float4 _579;
    _576 = float2(0.0, 1.0);
    _579 = float4(0.0, 0.0, 0.0, 1.0);
    float2 _577;
    float4 _580;
    for (uint _581 = 0u; _581 < min(TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint(_557)).x, TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumReflectionCaptures); _576 = _577, _579 = _580, _581++)
    {
        if (_579.w < 0.001000000047497451305389404296875)
        {
            break;
        }
        uint4 _592 = TranslucentBasePass_Shared_Forward_CulledLightDataGrid.read(uint((TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint((_557 + 1u))).x + _581)));
        uint _593 = _592.x;
        float3 _599 = _268 - ReflectionCapture.ReflectionCapture_PositionAndRadius[_593].xyz;
        float _600 = dot(_599, _599);
        float _601 = sqrt(_600);
        if (_601 < ReflectionCapture.ReflectionCapture_PositionAndRadius[_593].w)
        {
            float _692;
            float3 _693;
            if (ReflectionCapture.ReflectionCapture_CaptureProperties[_593].z > 0.0)
            {
                float3 _649 = (ReflectionCapture.ReflectionCapture_BoxTransform[_593] * float4(_268, 1.0)).xyz;
                float3 _655 = (ReflectionCapture.ReflectionCapture_BoxTransform[_593] * float4(_552, 0.0)).xyz;
                float3 _656 = float3(1.0) / _655;
                float3 _658 = _649 * _656;
                float3 _661 = fast::max((float3(-1.0) / _655) - _658, _656 - _658);
                float3 _675 = ReflectionCapture.ReflectionCapture_BoxScales[_593].xyz - float3(0.5 * ReflectionCapture.ReflectionCapture_BoxScales[_593].w);
                float3 _676 = -_675;
                float3 _677 = _649 * ReflectionCapture.ReflectionCapture_BoxScales[_593].xyz;
                _692 = 1.0 - smoothstep(0.0, 0.699999988079071044921875 * ReflectionCapture.ReflectionCapture_BoxScales[_593].w, dot(select(float3(0.0), abs(_677 - _676), _677 < _676), float3(1.0)) + dot(select(float3(0.0), abs(_677 - _675), _677 > _675), float3(1.0)));
                _693 = (_268 + (_552 * fast::min(_661.x, fast::min(_661.y, _661.z)))) - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_593].xyz + ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_593].xyz);
            }
            else
            {
                float _617 = dot(_552, _599);
                float _620 = (_617 * _617) - (_600 - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_593].w * ReflectionCapture.ReflectionCapture_PositionAndRadius[_593].w));
                float _637;
                float3 _638;
                if (_620 >= 0.0)
                {
                    float _631 = fast::clamp((2.5 * fast::clamp(_601 / ReflectionCapture.ReflectionCapture_PositionAndRadius[_593].w, 0.0, 1.0)) - 1.5, 0.0, 1.0);
                    _637 = 1.0 - ((_631 * _631) * (3.0 - (2.0 * _631)));
                    _638 = (_599 + (_552 * (sqrt(_620) - _617))) - ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_593].xyz;
                }
                else
                {
                    _637 = 0.0;
                    _638 = _552;
                }
                _692 = _637;
                _693 = _638;
            }
            float4 _700 = float4(_693, ReflectionCapture.ReflectionCapture_CaptureProperties[_593].y);
            float4 _702 = TranslucentBasePass_Shared_Reflection_ReflectionCubemap.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, _700.xyz, uint(round(_700.w)), level((View.View_ReflectionCubemapMaxMip - 1.0) - _572));
            float3 _705 = _702.xyz * ReflectionCapture.ReflectionCapture_CaptureProperties[_593].x;
            float4 _707 = float4(_705.x, _705.y, _705.z, _702.w) * _692;
            float3 _712 = _579.xyz + ((_707.xyz * _579.w) * 1.0);
            float4 _717 = float4(_712.x, _712.y, _712.z, _579.w);
            _717.w = _579.w * (1.0 - _707.w);
            float2 _724 = _201;
            _724.x = _576.x + ((ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_593].w * _692) * _576.y);
            float2 _727 = _724;
            _727.y = _576.y * (1.0 - _692);
            _577 = _727;
            _580 = _717;
        }
        else
        {
            _577 = _576;
            _580 = _579;
        }
    }
    float3 _729 = _579.xyz * View.View_IndirectLightingColorScale;
    float4 _730 = float4(_729.x, _729.y, _729.z, _579.w);
    float _733 = _576.x * dot(View.View_IndirectLightingColorScale, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float2 _734 = _201;
    _734.x = _733;
    float4 _776;
    float2 _777;
    float3 _778;
    if ((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightParameters.y > 0.0) && true)
    {
        float3 _754 = TranslucentBasePass_Shared_Reflection_SkyLightCubemap.sample(TranslucentBasePass_Shared_Reflection_SkyLightCubemapSampler, _552, level((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightParameters.x - 1.0) - _572)).xyz * View.View_SkyLightColor.xyz;
        float4 _773;
        float2 _774;
        float3 _775;
        if ((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightParameters.z < 1.0) && true)
        {
            float3 _767 = _729.xyz + ((_754 * _579.w) * 1.0);
            float2 _772 = _201;
            _772.x = _733 + ((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightCubemapBrightness * dot(View.View_SkyLightColor.xyz, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375))) * _576.y);
            _773 = float4(_767.x, _767.y, _767.z, _579.w);
            _774 = _772;
            _775 = float3(0.0);
        }
        else
        {
            _773 = _730;
            _774 = _734;
            _775 = _754 * 1.0;
        }
        _776 = _773;
        _777 = _774;
        _778 = _775;
    }
    else
    {
        _776 = _730;
        _777 = _734;
        _778 = float3(0.0);
    }
    float3 _800 = ((_776.xyz * mix(1.0, fast::min(dot(_493, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) / fast::max(_777.x, 9.9999997473787516355514526367188e-05), View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[2]), smoothstep(0.0, 1.0, fast::clamp((_337 * View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[0]) + View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[1], 0.0, 1.0)))).xyz + (_778 * _776.w)).xyz;
    float4 _802 = (float4(-1.0, -0.0274999998509883880615234375, -0.572000026702880859375, 0.02199999988079071044921875) * _337) + float4(1.0, 0.0425000004470348358154296875, 1.03999996185302734375, -0.039999999105930328369140625);
    float _803 = _802.x;
    float2 _813 = (float2(-1.03999996185302734375, 1.03999996185302734375) * ((fast::min(_803 * _803, exp2((-9.27999973297119140625) * fast::clamp(_312, 0.0, 1.0))) * _803) + _802.y)) + _802.zw;
    float3 _949;
    if (abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, float3(1.0))) > 9.9999997473787516355514526367188e-05)
    {
        float3 _849 = _268 - TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionOrigin.xyz;
        float _885 = (((1.0 - fast::clamp((abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane, float4(_268, -1.0))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.y, 0.0, 1.0)) * (fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.w - abs(dot(_849, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0) * fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.w - abs(dot(_849, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0))) * fast::clamp((dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, _295) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.y, 0.0, 1.0)) * (1.0 - fast::clamp((_337 - 0.20000000298023223876953125) * 10.0, 0.0, 1.0));
        float4 _943;
        if (_885 > 0.0)
        {
            float4 _914 = TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ProjectionWithExtraFOV[View.View_StereoPassIndex] * float4((View.View_TranslatedWorldToView * float4((_268 + (reflect(reflect(normalize(_268 - View.View_WorldCameraOrigin), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz), (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_InverseTransposeMirrorMatrix * _295).xyz) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.z)) + View.View_PreViewTranslation, 1.0)).xyz, 1.0);
            uint _921;
            if (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_bIsStereo != 0u)
            {
                _921 = uint(View.View_StereoPassIndex);
            }
            else
            {
                _921 = 0u;
            }
            float4 _938 = TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, ((fast::clamp(_914.xy / float2(_914.w), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_921].xy) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_921].zw), level(0.0));
            float4 _942 = float4(_938.x, _938.y, _938.z, float4(0.0).w);
            _942.w = _885 * _938.w;
            _943 = _942;
        }
        else
        {
            _943 = float4(0.0);
        }
        _949 = _943.xyz + (_800 * (1.0 - _943.w));
    }
    else
    {
        _949 = _800;
    }
    bool _967 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _1016;
    if (_967)
    {
        float4 _974 = View.View_WorldToClip * float4(_268, 1.0);
        float _975 = _974.w;
        float4 _1004;
        if (_967)
        {
            _1004 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_974.xy / float2(_975)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_975 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _1004 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _1016 = float4(_1004.xyz + (in.in_var_TEXCOORD7.xyz * _1004.w), _1004.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _1016 = in.in_var_TEXCOORD7;
    }
    float3 _1024 = (_268 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _1032 = (_268 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _1037 = fast::clamp((float3(0.5) - abs(_1024 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _1042 = (_1037.x * _1037.y) * _1037.z;
    float4 _1051 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _1032, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _1024, level(0.0)), float4(_1042));
    float3 _1062 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _1032, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _1024, level(0.0)).xyz, float3(_1042)) * 1.0;
    float4 _1064 = _202;
    _1064.x = _1051.x;
    float4 _1066 = _202;
    _1066.x = _1051.y;
    float4 _1068 = _202;
    _1068.x = _1051.z;
    float3 _1069 = _1051.xyz;
    float3 _1073 = _1069 / float3(dot(_1069, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _1075 = _1062 * _1073.x;
    float3 _1078 = _1062 * _1073.y;
    float3 _1081 = _1062 * _1073.z;
    float4 _1084 = _202;
    _1084.y = (-0.48860299587249755859375) * _411;
    float4 _1086 = _1084;
    _1086.z = 0.48860299587249755859375 * _295.z;
    float4 _1088 = _1086;
    _1088.w = (-0.48860299587249755859375) * _295.x;
    float4 _1089 = _1088;
    _1089.x = 0.886227548122406005859375;
    float3 _1091 = _1089.yzw * 2.094395160675048828125;
    float4 _1092 = float4(_1089.x, _1091.x, _1091.y, _1091.z);
    float3 _1094 = _203;
    _1094.x = dot(float4(_1064.x, _1075.x, _1075.y, _1075.z), _1092);
    float3 _1096 = _1094;
    _1096.y = dot(float4(_1066.x, _1078.x, _1078.y, _1078.z), _1092);
    float3 _1098 = _1096;
    _1098.z = dot(float4(_1068.x, _1081.x, _1081.y, _1081.z), _1092);
    float3 _1113 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _1144;
    float3 _1145;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _1119 = in.in_var_PRIMITIVE_ID * 36u;
        bool _1132 = any(abs(_268 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _1119 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _1119 + 19u)].xyz + float3(1.0)));
        float3 _1142;
        if (_1132)
        {
            _1142 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_268, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _1142 = _1113;
        }
        _1144 = _1132 ? 1.0 : _338;
        _1145 = _1142;
    }
    else
    {
        _1144 = _338;
        _1145 = _1113;
    }
    float4 _1155 = float4((((mix((((_949 * ((_367 * _813.x) + float3(fast::clamp(50.0 * _367.y, 0.0, 1.0) * _813.y))) * 1.0) * fast::max(float3(1.0), ((((((_367 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_367 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_367 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0)) + (_365 * float4(fast::max(float3(0.0), _1098), _198).xyz), _365 + (_367 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_493 * _365) * fast::max(float3(1.0), ((((((_331 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_331 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_331 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _1145) * _1016.w) + _1016.xyz, _1144);
    float3 _1159 = _1155.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_1159.x, _1159.y, _1159.z, _1155.w);
    return out;
}

