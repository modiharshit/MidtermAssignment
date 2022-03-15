

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
    char _m24_pad[80];
    float View_IndirectLightingCacheShowFlag;
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

struct type_IndirectLightingCache
{
    char _m0_pad[96];
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients0;
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients1;
    float4 IndirectLightingCache_IndirectLightingSHCoefficients2;
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

fragment MainPS_out Main_000076d6_b3ec19b6(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(9)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(4)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(5)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(6)]], constant type_ReflectionCapture& ReflectionCapture [[buffer(7)]], constant type_Material& Material [[buffer(8)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_NumCulledLightsGrid [[texture(0)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_CulledLightDataGrid [[texture(1)]], texturecube_array<float> TranslucentBasePass_Shared_Reflection_ReflectionCubemap [[texture(2)]], texture2d<float> TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture [[texture(3)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(4)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(5)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(6)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(7)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(8)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(9)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(10)]], texture2d<float> Material_Texture2D_0 [[texture(11)]], texture2d<float> Material_Texture2D_1 [[texture(12)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    float4 _265 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _269 = _265.xyz / float3(_265.w);
    float3 _270 = _269 - View.View_PreViewTranslation;
    float3 _272 = normalize(-_269);
    float4 _278 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _281 = (_278.xy * float2(2.0)) - float2(1.0);
    float3 _297 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_281, sqrt(fast::clamp(1.0 - dot(_281, _281), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _308 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _314 = dot(_297, _272);
    float _318 = fast::max(abs(1.0 - fast::max(0.0, _314)), 9.9999997473787516355514526367188e-05);
    float3 _333 = fast::clamp(Material.Material_VectorExpressions[3].xyz * _308.x, float3(0.0), float3(1.0));
    float _339 = (fast::clamp(Material.Material_ScalarExpressions[0].z, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _340 = fast::clamp(mix(Material.Material_ScalarExpressions[0].w, Material.Material_ScalarExpressions[1].x, (((_318 <= 0.0) ? 0.0 : pow(_318, 4.0)) * 0.959999978542327880859375) + 0.039999999105930328369140625), 0.0, 1.0);
    float3 _352 = ((_333 - (_333 * 0.89999997615814208984375)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _359 = (mix(float3(0.07999999821186065673828125 * fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0)), _333, float3(0.89999997615814208984375)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _362 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _367;
    if (_362)
    {
        _367 = _352 + (_359 * 0.449999988079071044921875);
    }
    else
    {
        _367 = _352;
    }
    float3 _369 = select(_359, float3(0.0), bool3(_362));
    float3 _445;
    if (View.View_IndirectLightingCacheShowFlag > 0.0)
    {
        float _393 = _297.y;
        float4 _395 = _206;
        _395.y = (-0.48860299587249755859375) * _393;
        float _396 = _297.z;
        float4 _398 = _395;
        _398.z = 0.48860299587249755859375 * _396;
        float _399 = _297.x;
        float4 _401 = _398;
        _401.w = (-0.48860299587249755859375) * _399;
        float3 _402 = _297 * _297;
        float4 _405 = _204;
        _405.x = (1.09254801273345947265625 * _399) * _393;
        float4 _408 = _405;
        _408.y = ((-1.09254801273345947265625) * _393) * _396;
        float4 _413 = _408;
        _413.z = 0.3153919875621795654296875 * ((3.0 * _402.z) - 1.0);
        float4 _416 = _413;
        _416.w = ((-1.09254801273345947265625) * _399) * _396;
        float4 _420 = _401;
        _420.x = 0.886227548122406005859375;
        float3 _422 = _420.yzw * 2.094395160675048828125;
        float4 _423 = float4(_420.x, _422.x, _422.y, _422.z);
        float4 _424 = _416 * 0.785398185253143310546875;
        float _425 = (_402.x - _402.y) * 0.4290426075458526611328125;
        float3 _431 = float3(0.0);
        _431.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _423) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _424)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _425);
        float3 _437 = _431;
        _437.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _423) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _424)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _425);
        float3 _443 = _437;
        _443.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _423) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _424)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _425);
        _445 = fast::max(float3(0.0), _443);
    }
    else
    {
        _445 = float3(0.0);
    }
    float3 _448 = _445 * View.View_IndirectLightingColorScale;
    uint2 _493 = uint2((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_LightProbeSizeRatioAndInvSizeRatio.zw) >> (uint2(TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridPixelSizeShift) & uint2(31u));
    float3 _507 = (_297 * (2.0 * dot(_272, _297))) - _272;
    uint _512 = (TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumGridCells + ((((min(uint(fast::max(0.0, log2(((1.0 / gl_FragCoord.w) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.x) + TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.y) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.z)), uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.z - 1)) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.y)) + _493.y) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.x)) + _493.x)) * 2u;
    float2 _531;
    float4 _534;
    _531 = float2(0.0, 1.0);
    _534 = float4(0.0, 0.0, 0.0, 1.0);
    float2 _532;
    float4 _535;
    for (uint _536 = 0u; _536 < min(TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint(_512)).x, TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumReflectionCaptures); _531 = _532, _534 = _535, _536++)
    {
        if (_534.w < 0.001000000047497451305389404296875)
        {
            break;
        }
        uint4 _547 = TranslucentBasePass_Shared_Forward_CulledLightDataGrid.read(uint((TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint((_512 + 1u))).x + _536)));
        uint _548 = _547.x;
        float3 _554 = _270 - ReflectionCapture.ReflectionCapture_PositionAndRadius[_548].xyz;
        float _555 = dot(_554, _554);
        float _556 = sqrt(_555);
        if (_556 < ReflectionCapture.ReflectionCapture_PositionAndRadius[_548].w)
        {
            float _647;
            float3 _648;
            if (ReflectionCapture.ReflectionCapture_CaptureProperties[_548].z > 0.0)
            {
                float3 _604 = (ReflectionCapture.ReflectionCapture_BoxTransform[_548] * float4(_270, 1.0)).xyz;
                float3 _610 = (ReflectionCapture.ReflectionCapture_BoxTransform[_548] * float4(_507, 0.0)).xyz;
                float3 _611 = float3(1.0) / _610;
                float3 _613 = _604 * _611;
                float3 _616 = fast::max((float3(-1.0) / _610) - _613, _611 - _613);
                float3 _630 = ReflectionCapture.ReflectionCapture_BoxScales[_548].xyz - float3(0.5 * ReflectionCapture.ReflectionCapture_BoxScales[_548].w);
                float3 _631 = -_630;
                float3 _632 = _604 * ReflectionCapture.ReflectionCapture_BoxScales[_548].xyz;
                _647 = 1.0 - smoothstep(0.0, 0.699999988079071044921875 * ReflectionCapture.ReflectionCapture_BoxScales[_548].w, dot(select(float3(0.0), abs(_632 - _631), _632 < _631), float3(1.0)) + dot(select(float3(0.0), abs(_632 - _630), _632 > _630), float3(1.0)));
                _648 = (_270 + (_507 * fast::min(_616.x, fast::min(_616.y, _616.z)))) - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_548].xyz + ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_548].xyz);
            }
            else
            {
                float _572 = dot(_507, _554);
                float _575 = (_572 * _572) - (_555 - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_548].w * ReflectionCapture.ReflectionCapture_PositionAndRadius[_548].w));
                float _592;
                float3 _593;
                if (_575 >= 0.0)
                {
                    float _586 = fast::clamp((2.5 * fast::clamp(_556 / ReflectionCapture.ReflectionCapture_PositionAndRadius[_548].w, 0.0, 1.0)) - 1.5, 0.0, 1.0);
                    _592 = 1.0 - ((_586 * _586) * (3.0 - (2.0 * _586)));
                    _593 = (_554 + (_507 * (sqrt(_575) - _572))) - ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_548].xyz;
                }
                else
                {
                    _592 = 0.0;
                    _593 = _507;
                }
                _647 = _592;
                _648 = _593;
            }
            float4 _655 = float4(_648, ReflectionCapture.ReflectionCapture_CaptureProperties[_548].y);
            float4 _657 = TranslucentBasePass_Shared_Reflection_ReflectionCubemap.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, _655.xyz, uint(round(_655.w)), level((View.View_ReflectionCubemapMaxMip - 1.0) - (1.0 - (1.2000000476837158203125 * log2(fast::max(_339, 0.001000000047497451305389404296875))))));
            float3 _660 = _657.xyz * ReflectionCapture.ReflectionCapture_CaptureProperties[_548].x;
            float4 _662 = float4(_660.x, _660.y, _660.z, _657.w) * _647;
            float3 _667 = _534.xyz + ((_662.xyz * _534.w) * 1.0);
            float4 _672 = float4(_667.x, _667.y, _667.z, _534.w);
            _672.w = _534.w * (1.0 - _662.w);
            float2 _679 = _207;
            _679.x = _531.x + ((ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_548].w * _647) * _531.y);
            float2 _682 = _679;
            _682.y = _531.y * (1.0 - _647);
            _532 = _682;
            _535 = _672;
        }
        else
        {
            _532 = _531;
            _535 = _534;
        }
    }
    float3 _704 = ((_534.xyz * View.View_IndirectLightingColorScale).xyz * mix(1.0, fast::min(dot(_448, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) / fast::max(_531.x * dot(View.View_IndirectLightingColorScale, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), 9.9999997473787516355514526367188e-05), View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[2]), smoothstep(0.0, 1.0, fast::clamp((_339 * View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[0]) + View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[1], 0.0, 1.0)))).xyz;
    float4 _706 = (float4(-1.0, -0.0274999998509883880615234375, -0.572000026702880859375, 0.02199999988079071044921875) * _339) + float4(1.0, 0.0425000004470348358154296875, 1.03999996185302734375, -0.039999999105930328369140625);
    float _707 = _706.x;
    float2 _717 = (float2(-1.03999996185302734375, 1.03999996185302734375) * ((fast::min(_707 * _707, exp2((-9.27999973297119140625) * fast::clamp(_314, 0.0, 1.0))) * _707) + _706.y)) + _706.zw;
    float3 _853;
    if (abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, float3(1.0))) > 9.9999997473787516355514526367188e-05)
    {
        float3 _753 = _270 - TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionOrigin.xyz;
        float _789 = (((1.0 - fast::clamp((abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane, float4(_270, -1.0))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.y, 0.0, 1.0)) * (fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.w - abs(dot(_753, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0) * fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.w - abs(dot(_753, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0))) * fast::clamp((dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, _297) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.y, 0.0, 1.0)) * (1.0 - fast::clamp((_339 - 0.20000000298023223876953125) * 10.0, 0.0, 1.0));
        float4 _847;
        if (_789 > 0.0)
        {
            float4 _818 = TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ProjectionWithExtraFOV[View.View_StereoPassIndex] * float4((View.View_TranslatedWorldToView * float4((_270 + (reflect(reflect(normalize(_270 - View.View_WorldCameraOrigin), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz), (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_InverseTransposeMirrorMatrix * _297).xyz) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.z)) + View.View_PreViewTranslation, 1.0)).xyz, 1.0);
            uint _825;
            if (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_bIsStereo != 0u)
            {
                _825 = uint(View.View_StereoPassIndex);
            }
            else
            {
                _825 = 0u;
            }
            float4 _842 = TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, ((fast::clamp(_818.xy / float2(_818.w), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_825].xy) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_825].zw), level(0.0));
            float4 _846 = float4(_842.x, _842.y, _842.z, float4(0.0).w);
            _846.w = _789 * _842.w;
            _847 = _846;
        }
        else
        {
            _847 = float4(0.0);
        }
        _853 = _847.xyz + (_704 * (1.0 - _847.w));
    }
    else
    {
        _853 = _704;
    }
    bool _871 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _920;
    if (_871)
    {
        float4 _878 = View.View_WorldToClip * float4(_270, 1.0);
        float _879 = _878.w;
        float4 _908;
        if (_871)
        {
            _908 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_878.xy / float2(_879)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_879 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _908 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _920 = float4(_908.xyz + (in.in_var_TEXCOORD7.xyz * _908.w), _908.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _920 = in.in_var_TEXCOORD7;
    }
    float3 _928 = (_270 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _936 = (_270 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _941 = fast::clamp((float3(0.5) - abs(_928 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _946 = (_941.x * _941.y) * _941.z;
    float4 _955 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _936, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _928, level(0.0)), float4(_946));
    float3 _966 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _936, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _928, level(0.0)).xyz, float3(_946)) * 1.0;
    float4 _968 = _206;
    _968.x = _955.x;
    float4 _970 = _206;
    _970.x = _955.y;
    float4 _972 = _206;
    _972.x = _955.z;
    float3 _973 = _955.xyz;
    float3 _977 = _973 / float3(dot(_973, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _979 = _966 * _977.x;
    float3 _982 = _966 * _977.y;
    float3 _985 = _966 * _977.z;
    float4 _989 = _206;
    _989.y = (-0.48860299587249755859375) * _297.y;
    float4 _992 = _989;
    _992.z = 0.48860299587249755859375 * _297.z;
    float4 _995 = _992;
    _995.w = (-0.48860299587249755859375) * _297.x;
    float4 _996 = _995;
    _996.x = 0.886227548122406005859375;
    float3 _998 = _996.yzw * 2.094395160675048828125;
    float4 _999 = float4(_996.x, _998.x, _998.y, _998.z);
    float3 _1001 = _208;
    _1001.x = dot(float4(_968.x, _979.x, _979.y, _979.z), _999);
    float3 _1003 = _1001;
    _1003.y = dot(float4(_970.x, _982.x, _982.y, _982.z), _999);
    float3 _1005 = _1003;
    _1005.z = dot(float4(_972.x, _985.x, _985.y, _985.z), _999);
    float _1007 = _955.w;
    float3 _1012 = float4(fast::max(float3(0.0), _1005), _1007).xyz;
    float3 _1078;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _1026 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_270, 1.0);
        float2 _1030 = _1026.xy / float2(_1026.w);
        float _1031 = _1026.z;
        float4 _1034 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _1030, level(0.0));
        float3 _1038 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _1031;
        bool2 _1063 = _1030 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _1065 = _1030 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _1078 = _367 * fast::max(_1012 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _1007) * (float3(1.0) - select(fast::clamp(exp((float3((((_1034.x * _1031) * 0.5) + dot((sin(_1038) * _1034.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_1038)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _1030, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_1063.x || _1065.x, _1063.y || _1065.y)))))), float3(0.0));
    }
    else
    {
        _1078 = _367 * _1012;
    }
    float3 _1086 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _1117;
    float3 _1118;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _1092 = in.in_var_PRIMITIVE_ID * 36u;
        bool _1105 = any(abs(_270 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _1092 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _1092 + 19u)].xyz + float3(1.0)));
        float3 _1115;
        if (_1105)
        {
            _1115 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_270, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _1115 = _1086;
        }
        _1117 = _1105 ? 1.0 : _340;
        _1118 = _1115;
    }
    else
    {
        _1117 = _340;
        _1118 = _1086;
    }
    float4 _1128 = float4((((mix((((_853 * ((_369 * _717.x) + float3(fast::clamp(50.0 * _369.y, 0.0, 1.0) * _717.y))) * 1.0) * fast::max(float3(1.0), ((((((_369 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_369 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_369 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0)) + _1078, _367 + (_369 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_448 * _367) * fast::max(float3(1.0), ((((((_333 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_333 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_333 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _1118) * _920.w) + _920.xyz, _1117);
    float3 _1132 = _1128.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_1132.x, _1132.y, _1132.z, _1128.w);
    return out;
}

