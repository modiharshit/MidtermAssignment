

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
    char _m19_pad[184];
    float View_ReflectionCubemapMaxMip;
    char _m20_pad[20];
    packed_float3 View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight;
    int View_StereoPassIndex;
    char _m22_pad[160];
    float3 View_VolumetricFogInvGridSize;
    float3 View_VolumetricFogGridZParams;
    char _m24_pad[16];
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

constant float _203 = {};
constant float4 _204 = {};
constant float4 _206 = {};
constant float2 _207 = {};
constant float3 _208 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPS_in
{
    float4 in_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 in_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 in_var_TEXCOORD0_0 [[user(locn2)]];
    uint in_var_PRIMITIVE_ID [[user(locn3)]];
    float4 in_var_TEXCOORD7 [[user(locn4)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_000076a2_d482154f(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(7)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(4)]], constant type_ReflectionCapture& ReflectionCapture [[buffer(5)]], constant type_Material& Material [[buffer(6)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_NumCulledLightsGrid [[texture(0)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_CulledLightDataGrid [[texture(1)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(7)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(8)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(9)]], texturecube_array<float> TranslucentBasePass_Shared_Reflection_ReflectionCubemap [[texture(10)]], texture2d<float> TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture [[texture(11)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(12)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(13)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(14)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(15)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(16)]], texture2d<float> Material_Texture2D_0 [[texture(17)]], texture2d<float> Material_Texture2D_1 [[texture(18)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    float4 _270 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _274 = _270.xyz / float3(_270.w);
    float3 _275 = _274 - View.View_PreViewTranslation;
    float3 _277 = normalize(-_274);
    float4 _283 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _286 = (_283.xy * float2(2.0)) - float2(1.0);
    float3 _302 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_286, sqrt(fast::clamp(1.0 - dot(_286, _286), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _313 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _319 = dot(_302, _277);
    float _323 = fast::max(abs(1.0 - fast::max(0.0, _319)), 9.9999997473787516355514526367188e-05);
    float3 _338 = fast::clamp(Material.Material_VectorExpressions[3].xyz * _313.x, float3(0.0), float3(1.0));
    float _344 = (fast::clamp(Material.Material_ScalarExpressions[0].z, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _345 = fast::clamp(mix(Material.Material_ScalarExpressions[0].w, Material.Material_ScalarExpressions[1].x, (((_323 <= 0.0) ? 0.0 : pow(_323, 4.0)) * 0.959999978542327880859375) + 0.039999999105930328369140625), 0.0, 1.0);
    float3 _355 = fast::clamp((_275 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _366 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_355.x), int(_355.y), int(_355.z), 0).xyz), 0));
    float3 _381 = (((_366.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_355 / float3(_366.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float3 _393 = ((_338 - (_338 * 0.89999997615814208984375)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _400 = (mix(float3(0.07999999821186065673828125 * fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0)), _338, float3(0.89999997615814208984375)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _403 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _408;
    if (_403)
    {
        _408 = _393 + (_400 * 0.449999988079071044921875);
    }
    else
    {
        _408 = _393;
    }
    float3 _410 = select(_400, float3(0.0), bool3(_403));
    float4 _414 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _381, level(0.0));
    float _430 = _414.x;
    float4 _432 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _381, level(0.0)) * 2.0) - float4(1.0)) * _430) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _433 = _414.y;
    float4 _435 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _381, level(0.0)) * 2.0) - float4(1.0)) * _433) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _436 = _414.z;
    float4 _438 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _381, level(0.0)) * 2.0) - float4(1.0)) * _436) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _455 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _381, level(0.0)) * 2.0) - float4(1.0)) * _430) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _457 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _381, level(0.0)) * 2.0) - float4(1.0)) * _433) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _459 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _381, level(0.0)) * 2.0) - float4(1.0)) * _436) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float _490 = _302.y;
    float4 _492 = _206;
    _492.y = (-0.48860299587249755859375) * _490;
    float _493 = _302.z;
    float4 _495 = _492;
    _495.z = 0.48860299587249755859375 * _493;
    float _496 = _302.x;
    float4 _498 = _495;
    _498.w = (-0.48860299587249755859375) * _496;
    float3 _499 = _302 * _302;
    float4 _502 = _204;
    _502.x = (1.09254801273345947265625 * _496) * _490;
    float4 _505 = _502;
    _505.y = ((-1.09254801273345947265625) * _490) * _493;
    float4 _510 = _505;
    _510.z = 0.3153919875621795654296875 * ((3.0 * _499.z) - 1.0);
    float4 _513 = _510;
    _513.w = ((-1.09254801273345947265625) * _496) * _493;
    float4 _517 = _498;
    _517.x = 0.886227548122406005859375;
    float3 _519 = _517.yzw * 2.094395160675048828125;
    float4 _520 = float4(_517.x, _519.x, _519.y, _519.z);
    float4 _521 = _513 * 0.785398185253143310546875;
    float _522 = (_499.x - _499.y) * 0.4290426075458526611328125;
    float3 _528 = float3(0.0);
    _528.x = (dot(float4(_430, _432.xyz), _520) + dot(float4(_432.w, _455.xyz), _521)) + (_455.w * _522);
    float3 _534 = _528;
    _534.y = (dot(float4(_433, _435.xyz), _520) + dot(float4(_435.w, _457.xyz), _521)) + (_457.w * _522);
    float3 _540 = _534;
    _540.z = (dot(float4(_436, _438.xyz), _520) + dot(float4(_438.w, _459.xyz), _521)) + (_459.w * _522);
    float3 _545 = (fast::max(float3(0.0), _540) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    uint2 _590 = uint2((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_LightProbeSizeRatioAndInvSizeRatio.zw) >> (uint2(TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridPixelSizeShift) & uint2(31u));
    float3 _604 = (_302 * (2.0 * dot(_277, _302))) - _277;
    uint _609 = (TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumGridCells + ((((min(uint(fast::max(0.0, log2(((1.0 / gl_FragCoord.w) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.x) + TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.y) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.z)), uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.z - 1)) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.y)) + _590.y) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.x)) + _590.x)) * 2u;
    float2 _628;
    float4 _631;
    _628 = float2(0.0, 1.0);
    _631 = float4(0.0, 0.0, 0.0, 1.0);
    float2 _629;
    float4 _632;
    for (uint _633 = 0u; _633 < min(TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint(_609)).x, TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumReflectionCaptures); _628 = _629, _631 = _632, _633++)
    {
        if (_631.w < 0.001000000047497451305389404296875)
        {
            break;
        }
        uint4 _644 = TranslucentBasePass_Shared_Forward_CulledLightDataGrid.read(uint((TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint((_609 + 1u))).x + _633)));
        uint _645 = _644.x;
        float3 _651 = _275 - ReflectionCapture.ReflectionCapture_PositionAndRadius[_645].xyz;
        float _652 = dot(_651, _651);
        float _653 = sqrt(_652);
        if (_653 < ReflectionCapture.ReflectionCapture_PositionAndRadius[_645].w)
        {
            float _744;
            float3 _745;
            if (ReflectionCapture.ReflectionCapture_CaptureProperties[_645].z > 0.0)
            {
                float3 _701 = (ReflectionCapture.ReflectionCapture_BoxTransform[_645] * float4(_275, 1.0)).xyz;
                float3 _707 = (ReflectionCapture.ReflectionCapture_BoxTransform[_645] * float4(_604, 0.0)).xyz;
                float3 _708 = float3(1.0) / _707;
                float3 _710 = _701 * _708;
                float3 _713 = fast::max((float3(-1.0) / _707) - _710, _708 - _710);
                float3 _727 = ReflectionCapture.ReflectionCapture_BoxScales[_645].xyz - float3(0.5 * ReflectionCapture.ReflectionCapture_BoxScales[_645].w);
                float3 _728 = -_727;
                float3 _729 = _701 * ReflectionCapture.ReflectionCapture_BoxScales[_645].xyz;
                _744 = 1.0 - smoothstep(0.0, 0.699999988079071044921875 * ReflectionCapture.ReflectionCapture_BoxScales[_645].w, dot(select(float3(0.0), abs(_729 - _728), _729 < _728), float3(1.0)) + dot(select(float3(0.0), abs(_729 - _727), _729 > _727), float3(1.0)));
                _745 = (_275 + (_604 * fast::min(_713.x, fast::min(_713.y, _713.z)))) - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_645].xyz + ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_645].xyz);
            }
            else
            {
                float _669 = dot(_604, _651);
                float _672 = (_669 * _669) - (_652 - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_645].w * ReflectionCapture.ReflectionCapture_PositionAndRadius[_645].w));
                float _689;
                float3 _690;
                if (_672 >= 0.0)
                {
                    float _683 = fast::clamp((2.5 * fast::clamp(_653 / ReflectionCapture.ReflectionCapture_PositionAndRadius[_645].w, 0.0, 1.0)) - 1.5, 0.0, 1.0);
                    _689 = 1.0 - ((_683 * _683) * (3.0 - (2.0 * _683)));
                    _690 = (_651 + (_604 * (sqrt(_672) - _669))) - ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_645].xyz;
                }
                else
                {
                    _689 = 0.0;
                    _690 = _604;
                }
                _744 = _689;
                _745 = _690;
            }
            float4 _752 = float4(_745, ReflectionCapture.ReflectionCapture_CaptureProperties[_645].y);
            float4 _754 = TranslucentBasePass_Shared_Reflection_ReflectionCubemap.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, _752.xyz, uint(round(_752.w)), level((View.View_ReflectionCubemapMaxMip - 1.0) - (1.0 - (1.2000000476837158203125 * log2(fast::max(_344, 0.001000000047497451305389404296875))))));
            float3 _757 = _754.xyz * ReflectionCapture.ReflectionCapture_CaptureProperties[_645].x;
            float4 _759 = float4(_757.x, _757.y, _757.z, _754.w) * _744;
            float3 _764 = _631.xyz + ((_759.xyz * _631.w) * 1.0);
            float4 _769 = float4(_764.x, _764.y, _764.z, _631.w);
            _769.w = _631.w * (1.0 - _759.w);
            float2 _776 = _207;
            _776.x = _628.x + ((ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_645].w * _744) * _628.y);
            float2 _779 = _776;
            _779.y = _628.y * (1.0 - _744);
            _629 = _779;
            _632 = _769;
        }
        else
        {
            _629 = _628;
            _632 = _631;
        }
    }
    float3 _801 = ((_631.xyz * View.View_IndirectLightingColorScale).xyz * mix(1.0, fast::min(dot(_545, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) / fast::max(_628.x * dot(View.View_IndirectLightingColorScale, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), 9.9999997473787516355514526367188e-05), View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[2]), smoothstep(0.0, 1.0, fast::clamp((_344 * View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[0]) + View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[1], 0.0, 1.0)))).xyz;
    float4 _803 = (float4(-1.0, -0.0274999998509883880615234375, -0.572000026702880859375, 0.02199999988079071044921875) * _344) + float4(1.0, 0.0425000004470348358154296875, 1.03999996185302734375, -0.039999999105930328369140625);
    float _804 = _803.x;
    float2 _814 = (float2(-1.03999996185302734375, 1.03999996185302734375) * ((fast::min(_804 * _804, exp2((-9.27999973297119140625) * fast::clamp(_319, 0.0, 1.0))) * _804) + _803.y)) + _803.zw;
    float3 _950;
    if (abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, float3(1.0))) > 9.9999997473787516355514526367188e-05)
    {
        float3 _850 = _275 - TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionOrigin.xyz;
        float _886 = (((1.0 - fast::clamp((abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane, float4(_275, -1.0))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.y, 0.0, 1.0)) * (fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.w - abs(dot(_850, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0) * fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.w - abs(dot(_850, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0))) * fast::clamp((dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, _302) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.y, 0.0, 1.0)) * (1.0 - fast::clamp((_344 - 0.20000000298023223876953125) * 10.0, 0.0, 1.0));
        float4 _944;
        if (_886 > 0.0)
        {
            float4 _915 = TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ProjectionWithExtraFOV[View.View_StereoPassIndex] * float4((View.View_TranslatedWorldToView * float4((_275 + (reflect(reflect(normalize(_275 - View.View_WorldCameraOrigin), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz), (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_InverseTransposeMirrorMatrix * _302).xyz) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.z)) + View.View_PreViewTranslation, 1.0)).xyz, 1.0);
            uint _922;
            if (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_bIsStereo != 0u)
            {
                _922 = uint(View.View_StereoPassIndex);
            }
            else
            {
                _922 = 0u;
            }
            float4 _939 = TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, ((fast::clamp(_915.xy / float2(_915.w), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_922].xy) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_922].zw), level(0.0));
            float4 _943 = float4(_939.x, _939.y, _939.z, float4(0.0).w);
            _943.w = _886 * _939.w;
            _944 = _943;
        }
        else
        {
            _944 = float4(0.0);
        }
        _950 = _944.xyz + (_801 * (1.0 - _944.w));
    }
    else
    {
        _950 = _801;
    }
    bool _968 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _1016;
    if (_968)
    {
        float4 _975 = View.View_WorldToClip * float4(_275, 1.0);
        float _976 = _975.w;
        float4 _1004;
        if (_968)
        {
            _1004 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_975.xy / float2(_976)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_976 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
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
    float3 _1024 = (_275 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _1032 = (_275 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _1037 = fast::clamp((float3(0.5) - abs(_1024 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _1042 = (_1037.x * _1037.y) * _1037.z;
    float4 _1050 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _1032, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _1024, level(0.0)), float4(_1042));
    float3 _1061 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _1032, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _1024, level(0.0)).xyz, float3(_1042)) * 1.0;
    float4 _1063 = _206;
    _1063.x = _1050.x;
    float4 _1065 = _206;
    _1065.x = _1050.y;
    float4 _1067 = _206;
    _1067.x = _1050.z;
    float3 _1068 = _1050.xyz;
    float3 _1072 = _1068 / float3(dot(_1068, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _1074 = _1061 * _1072.x;
    float3 _1077 = _1061 * _1072.y;
    float3 _1080 = _1061 * _1072.z;
    float3 _1083 = _208;
    _1083.x = dot(float4(_1063.x, _1074.x, _1074.y, _1074.z), _520);
    float3 _1085 = _1083;
    _1085.y = dot(float4(_1065.x, _1077.x, _1077.y, _1077.z), _520);
    float3 _1087 = _1085;
    _1087.z = dot(float4(_1067.x, _1080.x, _1080.y, _1080.z), _520);
    float3 _1102 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _1133;
    float3 _1134;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _1108 = in.in_var_PRIMITIVE_ID * 36u;
        bool _1121 = any(abs(_275 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _1108 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _1108 + 19u)].xyz + float3(1.0)));
        float3 _1131;
        if (_1121)
        {
            _1131 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_275, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _1131 = _1102;
        }
        _1133 = _1121 ? 1.0 : _345;
        _1134 = _1131;
    }
    else
    {
        _1133 = _345;
        _1134 = _1102;
    }
    float4 _1144 = float4((((mix((((_950 * ((_410 * _814.x) + float3(fast::clamp(50.0 * _410.y, 0.0, 1.0) * _814.y))) * 1.0) * fast::max(float3(1.0), ((((((_410 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_410 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_410 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0)) + (_408 * float4(fast::max(float3(0.0), _1087), _203).xyz), _408 + (_410 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_545 * _408) * fast::max(float3(1.0), ((((((_338 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_338 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_338 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _1134) * _1016.w) + _1016.xyz, _1133);
    float3 _1148 = _1144.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_1148.x, _1148.y, _1148.z, _1144.w);
    return out;
}

