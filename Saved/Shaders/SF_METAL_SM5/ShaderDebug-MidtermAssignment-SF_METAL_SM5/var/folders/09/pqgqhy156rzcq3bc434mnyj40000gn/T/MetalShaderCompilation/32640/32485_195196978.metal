

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

struct type_TranslucentSelfShadow
{
    float4x4 TranslucentSelfShadow_WorldToShadowMatrix;
    float4 TranslucentSelfShadow_ShadowUVMinMax;
    char _m2_pad[16];
    float4 TranslucentSelfShadow_DirectionalLightColor;
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

constant float4 _220 = {};
constant float4 _222 = {};
constant float2 _223 = {};
constant float3 _224 = {};

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

fragment MainPS_out Main_00007ee5_0ba27832(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(8)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(4)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(5)]], constant type_ReflectionCapture& ReflectionCapture [[buffer(6)]], constant type_Material& Material [[buffer(7)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_NumCulledLightsGrid [[texture(0)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_CulledLightDataGrid [[texture(1)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(7)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(8)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(9)]], texturecube_array<float> TranslucentBasePass_Shared_Reflection_ReflectionCubemap [[texture(10)]], texture2d<float> TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture [[texture(11)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(12)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(13)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(14)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(15)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(16)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(17)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(18)]], texture2d<float> Material_Texture2D_0 [[texture(19)]], texture2d<float> Material_Texture2D_1 [[texture(20)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    float4 _286 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _290 = _286.xyz / float3(_286.w);
    float3 _291 = _290 - View.View_PreViewTranslation;
    float3 _293 = normalize(-_290);
    float4 _299 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _302 = (_299.xy * float2(2.0)) - float2(1.0);
    float3 _318 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_302, sqrt(fast::clamp(1.0 - dot(_302, _302), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _329 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _335 = dot(_318, _293);
    float _339 = fast::max(abs(1.0 - fast::max(0.0, _335)), 9.9999997473787516355514526367188e-05);
    float3 _354 = fast::clamp(Material.Material_VectorExpressions[3].xyz * _329.x, float3(0.0), float3(1.0));
    float _360 = (fast::clamp(Material.Material_ScalarExpressions[0].z, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _361 = fast::clamp(mix(Material.Material_ScalarExpressions[0].w, Material.Material_ScalarExpressions[1].x, (((_339 <= 0.0) ? 0.0 : pow(_339, 4.0)) * 0.959999978542327880859375) + 0.039999999105930328369140625), 0.0, 1.0);
    float3 _371 = fast::clamp((_291 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _382 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_371.x), int(_371.y), int(_371.z), 0).xyz), 0));
    float3 _397 = (((_382.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_371 / float3(_382.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float3 _409 = ((_354 - (_354 * 0.89999997615814208984375)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _416 = (mix(float3(0.07999999821186065673828125 * fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0)), _354, float3(0.89999997615814208984375)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _419 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _424;
    if (_419)
    {
        _424 = _409 + (_416 * 0.449999988079071044921875);
    }
    else
    {
        _424 = _409;
    }
    float3 _426 = select(_416, float3(0.0), bool3(_419));
    float4 _430 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _397, level(0.0));
    float _446 = _430.x;
    float4 _448 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _397, level(0.0)) * 2.0) - float4(1.0)) * _446) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _449 = _430.y;
    float4 _451 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _397, level(0.0)) * 2.0) - float4(1.0)) * _449) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _452 = _430.z;
    float4 _454 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _397, level(0.0)) * 2.0) - float4(1.0)) * _452) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _471 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _397, level(0.0)) * 2.0) - float4(1.0)) * _446) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _473 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _397, level(0.0)) * 2.0) - float4(1.0)) * _449) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _475 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _397, level(0.0)) * 2.0) - float4(1.0)) * _452) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float _506 = _318.y;
    float4 _508 = _222;
    _508.y = (-0.48860299587249755859375) * _506;
    float _509 = _318.z;
    float4 _511 = _508;
    _511.z = 0.48860299587249755859375 * _509;
    float _512 = _318.x;
    float4 _514 = _511;
    _514.w = (-0.48860299587249755859375) * _512;
    float3 _515 = _318 * _318;
    float4 _518 = _220;
    _518.x = (1.09254801273345947265625 * _512) * _506;
    float4 _521 = _518;
    _521.y = ((-1.09254801273345947265625) * _506) * _509;
    float4 _526 = _521;
    _526.z = 0.3153919875621795654296875 * ((3.0 * _515.z) - 1.0);
    float4 _529 = _526;
    _529.w = ((-1.09254801273345947265625) * _512) * _509;
    float4 _533 = _514;
    _533.x = 0.886227548122406005859375;
    float3 _535 = _533.yzw * 2.094395160675048828125;
    float4 _536 = float4(_533.x, _535.x, _535.y, _535.z);
    float4 _537 = _529 * 0.785398185253143310546875;
    float _538 = (_515.x - _515.y) * 0.4290426075458526611328125;
    float3 _544 = float3(0.0);
    _544.x = (dot(float4(_446, _448.xyz), _536) + dot(float4(_448.w, _471.xyz), _537)) + (_471.w * _538);
    float3 _550 = _544;
    _550.y = (dot(float4(_449, _451.xyz), _536) + dot(float4(_451.w, _473.xyz), _537)) + (_473.w * _538);
    float3 _556 = _550;
    _556.z = (dot(float4(_452, _454.xyz), _536) + dot(float4(_454.w, _475.xyz), _537)) + (_475.w * _538);
    float3 _561 = (fast::max(float3(0.0), _556) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    uint2 _606 = uint2((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_LightProbeSizeRatioAndInvSizeRatio.zw) >> (uint2(TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridPixelSizeShift) & uint2(31u));
    float3 _620 = (_318 * (2.0 * dot(_293, _318))) - _293;
    uint _625 = (TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumGridCells + ((((min(uint(fast::max(0.0, log2(((1.0 / gl_FragCoord.w) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.x) + TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.y) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.z)), uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.z - 1)) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.y)) + _606.y) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.x)) + _606.x)) * 2u;
    float2 _644;
    float4 _647;
    _644 = float2(0.0, 1.0);
    _647 = float4(0.0, 0.0, 0.0, 1.0);
    float2 _645;
    float4 _648;
    for (uint _649 = 0u; _649 < min(TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint(_625)).x, TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumReflectionCaptures); _644 = _645, _647 = _648, _649++)
    {
        if (_647.w < 0.001000000047497451305389404296875)
        {
            break;
        }
        uint4 _660 = TranslucentBasePass_Shared_Forward_CulledLightDataGrid.read(uint((TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint((_625 + 1u))).x + _649)));
        uint _661 = _660.x;
        float3 _667 = _291 - ReflectionCapture.ReflectionCapture_PositionAndRadius[_661].xyz;
        float _668 = dot(_667, _667);
        float _669 = sqrt(_668);
        if (_669 < ReflectionCapture.ReflectionCapture_PositionAndRadius[_661].w)
        {
            float _760;
            float3 _761;
            if (ReflectionCapture.ReflectionCapture_CaptureProperties[_661].z > 0.0)
            {
                float3 _717 = (ReflectionCapture.ReflectionCapture_BoxTransform[_661] * float4(_291, 1.0)).xyz;
                float3 _723 = (ReflectionCapture.ReflectionCapture_BoxTransform[_661] * float4(_620, 0.0)).xyz;
                float3 _724 = float3(1.0) / _723;
                float3 _726 = _717 * _724;
                float3 _729 = fast::max((float3(-1.0) / _723) - _726, _724 - _726);
                float3 _743 = ReflectionCapture.ReflectionCapture_BoxScales[_661].xyz - float3(0.5 * ReflectionCapture.ReflectionCapture_BoxScales[_661].w);
                float3 _744 = -_743;
                float3 _745 = _717 * ReflectionCapture.ReflectionCapture_BoxScales[_661].xyz;
                _760 = 1.0 - smoothstep(0.0, 0.699999988079071044921875 * ReflectionCapture.ReflectionCapture_BoxScales[_661].w, dot(select(float3(0.0), abs(_745 - _744), _745 < _744), float3(1.0)) + dot(select(float3(0.0), abs(_745 - _743), _745 > _743), float3(1.0)));
                _761 = (_291 + (_620 * fast::min(_729.x, fast::min(_729.y, _729.z)))) - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_661].xyz + ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_661].xyz);
            }
            else
            {
                float _685 = dot(_620, _667);
                float _688 = (_685 * _685) - (_668 - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_661].w * ReflectionCapture.ReflectionCapture_PositionAndRadius[_661].w));
                float _705;
                float3 _706;
                if (_688 >= 0.0)
                {
                    float _699 = fast::clamp((2.5 * fast::clamp(_669 / ReflectionCapture.ReflectionCapture_PositionAndRadius[_661].w, 0.0, 1.0)) - 1.5, 0.0, 1.0);
                    _705 = 1.0 - ((_699 * _699) * (3.0 - (2.0 * _699)));
                    _706 = (_667 + (_620 * (sqrt(_688) - _685))) - ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_661].xyz;
                }
                else
                {
                    _705 = 0.0;
                    _706 = _620;
                }
                _760 = _705;
                _761 = _706;
            }
            float4 _768 = float4(_761, ReflectionCapture.ReflectionCapture_CaptureProperties[_661].y);
            float4 _770 = TranslucentBasePass_Shared_Reflection_ReflectionCubemap.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, _768.xyz, uint(round(_768.w)), level((View.View_ReflectionCubemapMaxMip - 1.0) - (1.0 - (1.2000000476837158203125 * log2(fast::max(_360, 0.001000000047497451305389404296875))))));
            float3 _773 = _770.xyz * ReflectionCapture.ReflectionCapture_CaptureProperties[_661].x;
            float4 _775 = float4(_773.x, _773.y, _773.z, _770.w) * _760;
            float3 _780 = _647.xyz + ((_775.xyz * _647.w) * 1.0);
            float4 _785 = float4(_780.x, _780.y, _780.z, _647.w);
            _785.w = _647.w * (1.0 - _775.w);
            float2 _792 = _223;
            _792.x = _644.x + ((ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_661].w * _760) * _644.y);
            float2 _795 = _792;
            _795.y = _644.y * (1.0 - _760);
            _645 = _795;
            _648 = _785;
        }
        else
        {
            _645 = _644;
            _648 = _647;
        }
    }
    float3 _817 = ((_647.xyz * View.View_IndirectLightingColorScale).xyz * mix(1.0, fast::min(dot(_561, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) / fast::max(_644.x * dot(View.View_IndirectLightingColorScale, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), 9.9999997473787516355514526367188e-05), View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[2]), smoothstep(0.0, 1.0, fast::clamp((_360 * View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[0]) + View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[1], 0.0, 1.0)))).xyz;
    float4 _819 = (float4(-1.0, -0.0274999998509883880615234375, -0.572000026702880859375, 0.02199999988079071044921875) * _360) + float4(1.0, 0.0425000004470348358154296875, 1.03999996185302734375, -0.039999999105930328369140625);
    float _820 = _819.x;
    float2 _830 = (float2(-1.03999996185302734375, 1.03999996185302734375) * ((fast::min(_820 * _820, exp2((-9.27999973297119140625) * fast::clamp(_335, 0.0, 1.0))) * _820) + _819.y)) + _819.zw;
    float3 _966;
    if (abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, float3(1.0))) > 9.9999997473787516355514526367188e-05)
    {
        float3 _866 = _291 - TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionOrigin.xyz;
        float _902 = (((1.0 - fast::clamp((abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane, float4(_291, -1.0))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.y, 0.0, 1.0)) * (fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.w - abs(dot(_866, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0) * fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.w - abs(dot(_866, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0))) * fast::clamp((dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, _318) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.y, 0.0, 1.0)) * (1.0 - fast::clamp((_360 - 0.20000000298023223876953125) * 10.0, 0.0, 1.0));
        float4 _960;
        if (_902 > 0.0)
        {
            float4 _931 = TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ProjectionWithExtraFOV[View.View_StereoPassIndex] * float4((View.View_TranslatedWorldToView * float4((_291 + (reflect(reflect(normalize(_291 - View.View_WorldCameraOrigin), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz), (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_InverseTransposeMirrorMatrix * _318).xyz) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.z)) + View.View_PreViewTranslation, 1.0)).xyz, 1.0);
            uint _938;
            if (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_bIsStereo != 0u)
            {
                _938 = uint(View.View_StereoPassIndex);
            }
            else
            {
                _938 = 0u;
            }
            float4 _955 = TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, ((fast::clamp(_931.xy / float2(_931.w), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_938].xy) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_938].zw), level(0.0));
            float4 _959 = float4(_955.x, _955.y, _955.z, float4(0.0).w);
            _959.w = _902 * _955.w;
            _960 = _959;
        }
        else
        {
            _960 = float4(0.0);
        }
        _966 = _960.xyz + (_817 * (1.0 - _960.w));
    }
    else
    {
        _966 = _817;
    }
    bool _984 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _1032;
    if (_984)
    {
        float4 _991 = View.View_WorldToClip * float4(_291, 1.0);
        float _992 = _991.w;
        float4 _1020;
        if (_984)
        {
            _1020 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_991.xy / float2(_992)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_992 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _1020 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _1032 = float4(_1020.xyz + (in.in_var_TEXCOORD7.xyz * _1020.w), _1020.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _1032 = in.in_var_TEXCOORD7;
    }
    float3 _1040 = (_291 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _1048 = (_291 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _1053 = fast::clamp((float3(0.5) - abs(_1040 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _1058 = (_1053.x * _1053.y) * _1053.z;
    float4 _1066 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _1048, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _1040, level(0.0)), float4(_1058));
    float3 _1077 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _1048, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _1040, level(0.0)).xyz, float3(_1058)) * 1.0;
    float4 _1079 = _222;
    _1079.x = _1066.x;
    float4 _1081 = _222;
    _1081.x = _1066.y;
    float4 _1083 = _222;
    _1083.x = _1066.z;
    float3 _1084 = _1066.xyz;
    float3 _1088 = _1084 / float3(dot(_1084, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _1090 = _1077 * _1088.x;
    float3 _1093 = _1077 * _1088.y;
    float3 _1096 = _1077 * _1088.z;
    float3 _1099 = _224;
    _1099.x = dot(float4(_1079.x, _1090.x, _1090.y, _1090.z), _536);
    float3 _1101 = _1099;
    _1101.y = dot(float4(_1081.x, _1093.x, _1093.y, _1093.z), _536);
    float3 _1103 = _1101;
    _1103.z = dot(float4(_1083.x, _1096.x, _1096.y, _1096.z), _536);
    float _1105 = _1066.w;
    float3 _1110 = float4(fast::max(float3(0.0), _1103), _1105).xyz;
    float3 _1176;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _1124 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_291, 1.0);
        float2 _1128 = _1124.xy / float2(_1124.w);
        float _1129 = _1124.z;
        float4 _1132 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _1128, level(0.0));
        float3 _1136 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _1129;
        bool2 _1161 = _1128 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _1163 = _1128 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _1176 = _424 * fast::max(_1110 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _1105) * (float3(1.0) - select(fast::clamp(exp((float3((((_1132.x * _1129) * 0.5) + dot((sin(_1136) * _1132.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_1136)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _1128, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_1161.x || _1163.x, _1161.y || _1163.y)))))), float3(0.0));
    }
    else
    {
        _1176 = _424 * _1110;
    }
    float3 _1184 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _1215;
    float3 _1216;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _1190 = in.in_var_PRIMITIVE_ID * 36u;
        bool _1203 = any(abs(_291 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _1190 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _1190 + 19u)].xyz + float3(1.0)));
        float3 _1213;
        if (_1203)
        {
            _1213 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_291, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _1213 = _1184;
        }
        _1215 = _1203 ? 1.0 : _361;
        _1216 = _1213;
    }
    else
    {
        _1215 = _361;
        _1216 = _1184;
    }
    float4 _1226 = float4((((mix((((_966 * ((_426 * _830.x) + float3(fast::clamp(50.0 * _426.y, 0.0, 1.0) * _830.y))) * 1.0) * fast::max(float3(1.0), ((((((_426 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_426 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_426 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0)) + _1176, _424 + (_426 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_561 * _424) * fast::max(float3(1.0), ((((((_354 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_354 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_354 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _1216) * _1032.w) + _1032.xyz, _1215);
    float3 _1230 = _1226.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_1230.x, _1230.y, _1230.z, _1226.w);
    return out;
}

