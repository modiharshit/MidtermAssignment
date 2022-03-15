

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
    char _m23_pad[16];
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

constant float _189 = {};
constant float4 _190 = {};
constant float4 _192 = {};
constant float2 _193 = {};
constant float3 _194 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPS_in
{
    float4 in_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 in_var_TEXCOORD11_centroid [[user(locn1)]];
    uint in_var_PRIMITIVE_ID [[user(locn2)]];
    float4 in_var_TEXCOORD7 [[user(locn3)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00007133_0783639e(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(7)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(4)]], constant type_ReflectionCapture& ReflectionCapture [[buffer(5)]], constant type_Material& Material [[buffer(6)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_NumCulledLightsGrid [[texture(0)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_CulledLightDataGrid [[texture(1)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(7)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(8)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(9)]], texturecube_array<float> TranslucentBasePass_Shared_Reflection_ReflectionCubemap [[texture(10)]], texture2d<float> TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture [[texture(11)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(12)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(13)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(14)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(15)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(16)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    float4 _252 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _256 = _252.xyz / float3(_252.w);
    float3 _257 = _256 - View.View_PreViewTranslation;
    float3 _259 = normalize(-_256);
    float3 _267 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _284 = fast::clamp(Material.Material_VectorExpressions[3].xyz, float3(0.0), float3(1.0));
    float _290 = (fast::clamp(Material.Material_ScalarExpressions[0].z, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _291 = fast::clamp(Material.Material_ScalarExpressions[0].w, 0.0, 1.0);
    float3 _301 = fast::clamp((_257 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _312 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_301.x), int(_301.y), int(_301.z), 0).xyz), 0));
    float3 _327 = (((_312.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_301 / float3(_312.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float3 _336 = (_284 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _343 = (float3(0.07999999821186065673828125 * fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _346 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _351;
    if (_346)
    {
        _351 = _336 + (_343 * 0.449999988079071044921875);
    }
    else
    {
        _351 = _336;
    }
    float3 _353 = select(_343, float3(0.0), bool3(_346));
    float4 _357 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _327, level(0.0));
    float _373 = _357.x;
    float4 _375 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _327, level(0.0)) * 2.0) - float4(1.0)) * _373) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _376 = _357.y;
    float4 _378 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _327, level(0.0)) * 2.0) - float4(1.0)) * _376) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _379 = _357.z;
    float4 _381 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _327, level(0.0)) * 2.0) - float4(1.0)) * _379) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _398 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _327, level(0.0)) * 2.0) - float4(1.0)) * _373) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _400 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _327, level(0.0)) * 2.0) - float4(1.0)) * _376) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _402 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _327, level(0.0)) * 2.0) - float4(1.0)) * _379) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float _433 = _267.y;
    float4 _435 = _192;
    _435.y = (-0.48860299587249755859375) * _433;
    float _436 = _267.z;
    float4 _438 = _435;
    _438.z = 0.48860299587249755859375 * _436;
    float _439 = _267.x;
    float4 _441 = _438;
    _441.w = (-0.48860299587249755859375) * _439;
    float3 _442 = _267 * _267;
    float4 _445 = _190;
    _445.x = (1.09254801273345947265625 * _439) * _433;
    float4 _448 = _445;
    _448.y = ((-1.09254801273345947265625) * _433) * _436;
    float4 _453 = _448;
    _453.z = 0.3153919875621795654296875 * ((3.0 * _442.z) - 1.0);
    float4 _456 = _453;
    _456.w = ((-1.09254801273345947265625) * _439) * _436;
    float4 _460 = _441;
    _460.x = 0.886227548122406005859375;
    float3 _462 = _460.yzw * 2.094395160675048828125;
    float4 _463 = float4(_460.x, _462.x, _462.y, _462.z);
    float4 _464 = _456 * 0.785398185253143310546875;
    float _465 = (_442.x - _442.y) * 0.4290426075458526611328125;
    float3 _471 = float3(0.0);
    _471.x = (dot(float4(_373, _375.xyz), _463) + dot(float4(_375.w, _398.xyz), _464)) + (_398.w * _465);
    float3 _477 = _471;
    _477.y = (dot(float4(_376, _378.xyz), _463) + dot(float4(_378.w, _400.xyz), _464)) + (_400.w * _465);
    float3 _483 = _477;
    _483.z = (dot(float4(_379, _381.xyz), _463) + dot(float4(_381.w, _402.xyz), _464)) + (_402.w * _465);
    float3 _488 = (fast::max(float3(0.0), _483) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    uint2 _533 = uint2((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_LightProbeSizeRatioAndInvSizeRatio.zw) >> (uint2(TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridPixelSizeShift) & uint2(31u));
    float3 _547 = (_267 * (2.0 * dot(_259, _267))) - _259;
    uint _553 = (TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumGridCells + ((((min(uint(fast::max(0.0, log2(((1.0 / gl_FragCoord.w) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.x) + TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.y) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.z)), uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.z - 1)) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.y)) + _533.y) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.x)) + _533.x)) * 2u;
    float2 _572;
    float4 _575;
    _572 = float2(0.0, 1.0);
    _575 = float4(0.0, 0.0, 0.0, 1.0);
    float2 _573;
    float4 _576;
    for (uint _577 = 0u; _577 < min(TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint(_553)).x, TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumReflectionCaptures); _572 = _573, _575 = _576, _577++)
    {
        if (_575.w < 0.001000000047497451305389404296875)
        {
            break;
        }
        uint4 _588 = TranslucentBasePass_Shared_Forward_CulledLightDataGrid.read(uint((TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint((_553 + 1u))).x + _577)));
        uint _589 = _588.x;
        float3 _595 = _257 - ReflectionCapture.ReflectionCapture_PositionAndRadius[_589].xyz;
        float _596 = dot(_595, _595);
        float _597 = sqrt(_596);
        if (_597 < ReflectionCapture.ReflectionCapture_PositionAndRadius[_589].w)
        {
            float _688;
            float3 _689;
            if (ReflectionCapture.ReflectionCapture_CaptureProperties[_589].z > 0.0)
            {
                float3 _645 = (ReflectionCapture.ReflectionCapture_BoxTransform[_589] * float4(_257, 1.0)).xyz;
                float3 _651 = (ReflectionCapture.ReflectionCapture_BoxTransform[_589] * float4(_547, 0.0)).xyz;
                float3 _652 = float3(1.0) / _651;
                float3 _654 = _645 * _652;
                float3 _657 = fast::max((float3(-1.0) / _651) - _654, _652 - _654);
                float3 _671 = ReflectionCapture.ReflectionCapture_BoxScales[_589].xyz - float3(0.5 * ReflectionCapture.ReflectionCapture_BoxScales[_589].w);
                float3 _672 = -_671;
                float3 _673 = _645 * ReflectionCapture.ReflectionCapture_BoxScales[_589].xyz;
                _688 = 1.0 - smoothstep(0.0, 0.699999988079071044921875 * ReflectionCapture.ReflectionCapture_BoxScales[_589].w, dot(select(float3(0.0), abs(_673 - _672), _673 < _672), float3(1.0)) + dot(select(float3(0.0), abs(_673 - _671), _673 > _671), float3(1.0)));
                _689 = (_257 + (_547 * fast::min(_657.x, fast::min(_657.y, _657.z)))) - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_589].xyz + ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_589].xyz);
            }
            else
            {
                float _613 = dot(_547, _595);
                float _616 = (_613 * _613) - (_596 - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_589].w * ReflectionCapture.ReflectionCapture_PositionAndRadius[_589].w));
                float _633;
                float3 _634;
                if (_616 >= 0.0)
                {
                    float _627 = fast::clamp((2.5 * fast::clamp(_597 / ReflectionCapture.ReflectionCapture_PositionAndRadius[_589].w, 0.0, 1.0)) - 1.5, 0.0, 1.0);
                    _633 = 1.0 - ((_627 * _627) * (3.0 - (2.0 * _627)));
                    _634 = (_595 + (_547 * (sqrt(_616) - _613))) - ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_589].xyz;
                }
                else
                {
                    _633 = 0.0;
                    _634 = _547;
                }
                _688 = _633;
                _689 = _634;
            }
            float4 _696 = float4(_689, ReflectionCapture.ReflectionCapture_CaptureProperties[_589].y);
            float4 _698 = TranslucentBasePass_Shared_Reflection_ReflectionCubemap.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, _696.xyz, uint(round(_696.w)), level((View.View_ReflectionCubemapMaxMip - 1.0) - (1.0 - (1.2000000476837158203125 * log2(fast::max(_290, 0.001000000047497451305389404296875))))));
            float3 _701 = _698.xyz * ReflectionCapture.ReflectionCapture_CaptureProperties[_589].x;
            float4 _703 = float4(_701.x, _701.y, _701.z, _698.w) * _688;
            float3 _708 = _575.xyz + ((_703.xyz * _575.w) * 1.0);
            float4 _713 = float4(_708.x, _708.y, _708.z, _575.w);
            _713.w = _575.w * (1.0 - _703.w);
            float2 _720 = _193;
            _720.x = _572.x + ((ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_589].w * _688) * _572.y);
            float2 _723 = _720;
            _723.y = _572.y * (1.0 - _688);
            _573 = _723;
            _576 = _713;
        }
        else
        {
            _573 = _572;
            _576 = _575;
        }
    }
    float3 _745 = ((_575.xyz * View.View_IndirectLightingColorScale).xyz * mix(1.0, fast::min(dot(_488, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) / fast::max(_572.x * dot(View.View_IndirectLightingColorScale, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), 9.9999997473787516355514526367188e-05), View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[2]), smoothstep(0.0, 1.0, fast::clamp((_290 * View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[0]) + View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[1], 0.0, 1.0)))).xyz;
    float4 _747 = (float4(-1.0, -0.0274999998509883880615234375, -0.572000026702880859375, 0.02199999988079071044921875) * _290) + float4(1.0, 0.0425000004470348358154296875, 1.03999996185302734375, -0.039999999105930328369140625);
    float _748 = _747.x;
    float2 _758 = (float2(-1.03999996185302734375, 1.03999996185302734375) * ((fast::min(_748 * _748, exp2((-9.27999973297119140625) * fast::clamp(dot(_267, _259), 0.0, 1.0))) * _748) + _747.y)) + _747.zw;
    float3 _894;
    if (abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, float3(1.0))) > 9.9999997473787516355514526367188e-05)
    {
        float3 _794 = _257 - TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionOrigin.xyz;
        float _830 = (((1.0 - fast::clamp((abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane, float4(_257, -1.0))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.y, 0.0, 1.0)) * (fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.w - abs(dot(_794, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0) * fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.w - abs(dot(_794, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0))) * fast::clamp((dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, _267) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.y, 0.0, 1.0)) * (1.0 - fast::clamp((_290 - 0.20000000298023223876953125) * 10.0, 0.0, 1.0));
        float4 _888;
        if (_830 > 0.0)
        {
            float4 _859 = TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ProjectionWithExtraFOV[View.View_StereoPassIndex] * float4((View.View_TranslatedWorldToView * float4((_257 + (reflect(reflect(normalize(_257 - View.View_WorldCameraOrigin), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz), (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_InverseTransposeMirrorMatrix * _267).xyz) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.z)) + View.View_PreViewTranslation, 1.0)).xyz, 1.0);
            uint _866;
            if (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_bIsStereo != 0u)
            {
                _866 = uint(View.View_StereoPassIndex);
            }
            else
            {
                _866 = 0u;
            }
            float4 _883 = TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, ((fast::clamp(_859.xy / float2(_859.w), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_866].xy) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_866].zw), level(0.0));
            float4 _887 = float4(_883.x, _883.y, _883.z, float4(0.0).w);
            _887.w = _830 * _883.w;
            _888 = _887;
        }
        else
        {
            _888 = float4(0.0);
        }
        _894 = _888.xyz + (_745 * (1.0 - _888.w));
    }
    else
    {
        _894 = _745;
    }
    bool _912 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _960;
    if (_912)
    {
        float4 _919 = View.View_WorldToClip * float4(_257, 1.0);
        float _920 = _919.w;
        float4 _948;
        if (_912)
        {
            _948 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_919.xy / float2(_920)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_920 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
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
    float3 _968 = (_257 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _976 = (_257 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _981 = fast::clamp((float3(0.5) - abs(_968 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _986 = (_981.x * _981.y) * _981.z;
    float4 _994 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _976, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _968, level(0.0)), float4(_986));
    float3 _1005 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _976, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _968, level(0.0)).xyz, float3(_986)) * 1.0;
    float4 _1007 = _192;
    _1007.x = _994.x;
    float4 _1009 = _192;
    _1009.x = _994.y;
    float4 _1011 = _192;
    _1011.x = _994.z;
    float3 _1012 = _994.xyz;
    float3 _1016 = _1012 / float3(dot(_1012, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _1018 = _1005 * _1016.x;
    float3 _1021 = _1005 * _1016.y;
    float3 _1024 = _1005 * _1016.z;
    float3 _1027 = _194;
    _1027.x = dot(float4(_1007.x, _1018.x, _1018.y, _1018.z), _463);
    float3 _1029 = _1027;
    _1029.y = dot(float4(_1009.x, _1021.x, _1021.y, _1021.z), _463);
    float3 _1031 = _1029;
    _1031.z = dot(float4(_1011.x, _1024.x, _1024.y, _1024.z), _463);
    float3 _1046 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _1077;
    float3 _1078;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _1052 = in.in_var_PRIMITIVE_ID * 36u;
        bool _1065 = any(abs(_257 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _1052 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _1052 + 19u)].xyz + float3(1.0)));
        float3 _1075;
        if (_1065)
        {
            _1075 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_257, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _1075 = _1046;
        }
        _1077 = _1065 ? 1.0 : _291;
        _1078 = _1075;
    }
    else
    {
        _1077 = _291;
        _1078 = _1046;
    }
    float4 _1088 = float4((((mix((((_894 * ((_353 * _758.x) + float3(fast::clamp(50.0 * _353.y, 0.0, 1.0) * _758.y))) * 1.0) * fast::max(float3(1.0), ((((((_353 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_353 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_353 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0)) + (_351 * float4(fast::max(float3(0.0), _1031), _189).xyz), _351 + (_353 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_488 * _351) * fast::max(float3(1.0), ((((((_284 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_284 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_284 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _1078) * _960.w) + _960.xyz, _1077);
    float3 _1092 = _1088.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_1092.x, _1092.y, _1092.z, _1088.w);
    return out;
}

