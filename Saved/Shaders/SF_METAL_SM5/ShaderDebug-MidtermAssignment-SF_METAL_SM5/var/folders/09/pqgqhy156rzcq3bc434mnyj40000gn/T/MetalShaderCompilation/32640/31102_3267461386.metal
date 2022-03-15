

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

constant float4 _206 = {};
constant float4 _208 = {};
constant float2 _209 = {};
constant float3 _210 = {};

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

fragment MainPS_out Main_0000797e_c2c1810a(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(8)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(4)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(5)]], constant type_ReflectionCapture& ReflectionCapture [[buffer(6)]], constant type_Material& Material [[buffer(7)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_NumCulledLightsGrid [[texture(0)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_CulledLightDataGrid [[texture(1)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(7)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(8)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(9)]], texturecube_array<float> TranslucentBasePass_Shared_Reflection_ReflectionCubemap [[texture(10)]], texture2d<float> TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture [[texture(11)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(12)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(13)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(14)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(15)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(16)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(17)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(18)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    float4 _268 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _272 = _268.xyz / float3(_268.w);
    float3 _273 = _272 - View.View_PreViewTranslation;
    float3 _275 = normalize(-_272);
    float3 _283 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _300 = fast::clamp(Material.Material_VectorExpressions[3].xyz, float3(0.0), float3(1.0));
    float _306 = (fast::clamp(Material.Material_ScalarExpressions[0].z, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _307 = fast::clamp(Material.Material_ScalarExpressions[0].w, 0.0, 1.0);
    float3 _317 = fast::clamp((_273 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _328 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_317.x), int(_317.y), int(_317.z), 0).xyz), 0));
    float3 _343 = (((_328.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_317 / float3(_328.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float3 _352 = (_300 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _359 = (float3(0.07999999821186065673828125 * fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
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
    float4 _373 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _343, level(0.0));
    float _389 = _373.x;
    float4 _391 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _343, level(0.0)) * 2.0) - float4(1.0)) * _389) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _392 = _373.y;
    float4 _394 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _343, level(0.0)) * 2.0) - float4(1.0)) * _392) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _395 = _373.z;
    float4 _397 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _343, level(0.0)) * 2.0) - float4(1.0)) * _395) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _414 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _343, level(0.0)) * 2.0) - float4(1.0)) * _389) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _416 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _343, level(0.0)) * 2.0) - float4(1.0)) * _392) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _418 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _343, level(0.0)) * 2.0) - float4(1.0)) * _395) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float _449 = _283.y;
    float4 _451 = _208;
    _451.y = (-0.48860299587249755859375) * _449;
    float _452 = _283.z;
    float4 _454 = _451;
    _454.z = 0.48860299587249755859375 * _452;
    float _455 = _283.x;
    float4 _457 = _454;
    _457.w = (-0.48860299587249755859375) * _455;
    float3 _458 = _283 * _283;
    float4 _461 = _206;
    _461.x = (1.09254801273345947265625 * _455) * _449;
    float4 _464 = _461;
    _464.y = ((-1.09254801273345947265625) * _449) * _452;
    float4 _469 = _464;
    _469.z = 0.3153919875621795654296875 * ((3.0 * _458.z) - 1.0);
    float4 _472 = _469;
    _472.w = ((-1.09254801273345947265625) * _455) * _452;
    float4 _476 = _457;
    _476.x = 0.886227548122406005859375;
    float3 _478 = _476.yzw * 2.094395160675048828125;
    float4 _479 = float4(_476.x, _478.x, _478.y, _478.z);
    float4 _480 = _472 * 0.785398185253143310546875;
    float _481 = (_458.x - _458.y) * 0.4290426075458526611328125;
    float3 _487 = float3(0.0);
    _487.x = (dot(float4(_389, _391.xyz), _479) + dot(float4(_391.w, _414.xyz), _480)) + (_414.w * _481);
    float3 _493 = _487;
    _493.y = (dot(float4(_392, _394.xyz), _479) + dot(float4(_394.w, _416.xyz), _480)) + (_416.w * _481);
    float3 _499 = _493;
    _499.z = (dot(float4(_395, _397.xyz), _479) + dot(float4(_397.w, _418.xyz), _480)) + (_418.w * _481);
    float3 _504 = (fast::max(float3(0.0), _499) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    uint2 _549 = uint2((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_LightProbeSizeRatioAndInvSizeRatio.zw) >> (uint2(TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridPixelSizeShift) & uint2(31u));
    float3 _563 = (_283 * (2.0 * dot(_275, _283))) - _275;
    uint _569 = (TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumGridCells + ((((min(uint(fast::max(0.0, log2(((1.0 / gl_FragCoord.w) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.x) + TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.y) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.z)), uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.z - 1)) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.y)) + _549.y) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.x)) + _549.x)) * 2u;
    float2 _588;
    float4 _591;
    _588 = float2(0.0, 1.0);
    _591 = float4(0.0, 0.0, 0.0, 1.0);
    float2 _589;
    float4 _592;
    for (uint _593 = 0u; _593 < min(TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint(_569)).x, TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumReflectionCaptures); _588 = _589, _591 = _592, _593++)
    {
        if (_591.w < 0.001000000047497451305389404296875)
        {
            break;
        }
        uint4 _604 = TranslucentBasePass_Shared_Forward_CulledLightDataGrid.read(uint((TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint((_569 + 1u))).x + _593)));
        uint _605 = _604.x;
        float3 _611 = _273 - ReflectionCapture.ReflectionCapture_PositionAndRadius[_605].xyz;
        float _612 = dot(_611, _611);
        float _613 = sqrt(_612);
        if (_613 < ReflectionCapture.ReflectionCapture_PositionAndRadius[_605].w)
        {
            float _704;
            float3 _705;
            if (ReflectionCapture.ReflectionCapture_CaptureProperties[_605].z > 0.0)
            {
                float3 _661 = (ReflectionCapture.ReflectionCapture_BoxTransform[_605] * float4(_273, 1.0)).xyz;
                float3 _667 = (ReflectionCapture.ReflectionCapture_BoxTransform[_605] * float4(_563, 0.0)).xyz;
                float3 _668 = float3(1.0) / _667;
                float3 _670 = _661 * _668;
                float3 _673 = fast::max((float3(-1.0) / _667) - _670, _668 - _670);
                float3 _687 = ReflectionCapture.ReflectionCapture_BoxScales[_605].xyz - float3(0.5 * ReflectionCapture.ReflectionCapture_BoxScales[_605].w);
                float3 _688 = -_687;
                float3 _689 = _661 * ReflectionCapture.ReflectionCapture_BoxScales[_605].xyz;
                _704 = 1.0 - smoothstep(0.0, 0.699999988079071044921875 * ReflectionCapture.ReflectionCapture_BoxScales[_605].w, dot(select(float3(0.0), abs(_689 - _688), _689 < _688), float3(1.0)) + dot(select(float3(0.0), abs(_689 - _687), _689 > _687), float3(1.0)));
                _705 = (_273 + (_563 * fast::min(_673.x, fast::min(_673.y, _673.z)))) - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_605].xyz + ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_605].xyz);
            }
            else
            {
                float _629 = dot(_563, _611);
                float _632 = (_629 * _629) - (_612 - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_605].w * ReflectionCapture.ReflectionCapture_PositionAndRadius[_605].w));
                float _649;
                float3 _650;
                if (_632 >= 0.0)
                {
                    float _643 = fast::clamp((2.5 * fast::clamp(_613 / ReflectionCapture.ReflectionCapture_PositionAndRadius[_605].w, 0.0, 1.0)) - 1.5, 0.0, 1.0);
                    _649 = 1.0 - ((_643 * _643) * (3.0 - (2.0 * _643)));
                    _650 = (_611 + (_563 * (sqrt(_632) - _629))) - ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_605].xyz;
                }
                else
                {
                    _649 = 0.0;
                    _650 = _563;
                }
                _704 = _649;
                _705 = _650;
            }
            float4 _712 = float4(_705, ReflectionCapture.ReflectionCapture_CaptureProperties[_605].y);
            float4 _714 = TranslucentBasePass_Shared_Reflection_ReflectionCubemap.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, _712.xyz, uint(round(_712.w)), level((View.View_ReflectionCubemapMaxMip - 1.0) - (1.0 - (1.2000000476837158203125 * log2(fast::max(_306, 0.001000000047497451305389404296875))))));
            float3 _717 = _714.xyz * ReflectionCapture.ReflectionCapture_CaptureProperties[_605].x;
            float4 _719 = float4(_717.x, _717.y, _717.z, _714.w) * _704;
            float3 _724 = _591.xyz + ((_719.xyz * _591.w) * 1.0);
            float4 _729 = float4(_724.x, _724.y, _724.z, _591.w);
            _729.w = _591.w * (1.0 - _719.w);
            float2 _736 = _209;
            _736.x = _588.x + ((ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_605].w * _704) * _588.y);
            float2 _739 = _736;
            _739.y = _588.y * (1.0 - _704);
            _589 = _739;
            _592 = _729;
        }
        else
        {
            _589 = _588;
            _592 = _591;
        }
    }
    float3 _761 = ((_591.xyz * View.View_IndirectLightingColorScale).xyz * mix(1.0, fast::min(dot(_504, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) / fast::max(_588.x * dot(View.View_IndirectLightingColorScale, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), 9.9999997473787516355514526367188e-05), View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[2]), smoothstep(0.0, 1.0, fast::clamp((_306 * View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[0]) + View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[1], 0.0, 1.0)))).xyz;
    float4 _763 = (float4(-1.0, -0.0274999998509883880615234375, -0.572000026702880859375, 0.02199999988079071044921875) * _306) + float4(1.0, 0.0425000004470348358154296875, 1.03999996185302734375, -0.039999999105930328369140625);
    float _764 = _763.x;
    float2 _774 = (float2(-1.03999996185302734375, 1.03999996185302734375) * ((fast::min(_764 * _764, exp2((-9.27999973297119140625) * fast::clamp(dot(_283, _275), 0.0, 1.0))) * _764) + _763.y)) + _763.zw;
    float3 _910;
    if (abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, float3(1.0))) > 9.9999997473787516355514526367188e-05)
    {
        float3 _810 = _273 - TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionOrigin.xyz;
        float _846 = (((1.0 - fast::clamp((abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane, float4(_273, -1.0))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.y, 0.0, 1.0)) * (fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.w - abs(dot(_810, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0) * fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.w - abs(dot(_810, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0))) * fast::clamp((dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, _283) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.y, 0.0, 1.0)) * (1.0 - fast::clamp((_306 - 0.20000000298023223876953125) * 10.0, 0.0, 1.0));
        float4 _904;
        if (_846 > 0.0)
        {
            float4 _875 = TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ProjectionWithExtraFOV[View.View_StereoPassIndex] * float4((View.View_TranslatedWorldToView * float4((_273 + (reflect(reflect(normalize(_273 - View.View_WorldCameraOrigin), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz), (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_InverseTransposeMirrorMatrix * _283).xyz) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.z)) + View.View_PreViewTranslation, 1.0)).xyz, 1.0);
            uint _882;
            if (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_bIsStereo != 0u)
            {
                _882 = uint(View.View_StereoPassIndex);
            }
            else
            {
                _882 = 0u;
            }
            float4 _899 = TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, ((fast::clamp(_875.xy / float2(_875.w), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_882].xy) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_882].zw), level(0.0));
            float4 _903 = float4(_899.x, _899.y, _899.z, float4(0.0).w);
            _903.w = _846 * _899.w;
            _904 = _903;
        }
        else
        {
            _904 = float4(0.0);
        }
        _910 = _904.xyz + (_761 * (1.0 - _904.w));
    }
    else
    {
        _910 = _761;
    }
    bool _928 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _976;
    if (_928)
    {
        float4 _935 = View.View_WorldToClip * float4(_273, 1.0);
        float _936 = _935.w;
        float4 _964;
        if (_928)
        {
            _964 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_935.xy / float2(_936)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_936 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _964 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _976 = float4(_964.xyz + (in.in_var_TEXCOORD7.xyz * _964.w), _964.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _976 = in.in_var_TEXCOORD7;
    }
    float3 _984 = (_273 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _992 = (_273 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _997 = fast::clamp((float3(0.5) - abs(_984 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _1002 = (_997.x * _997.y) * _997.z;
    float4 _1010 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _992, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _984, level(0.0)), float4(_1002));
    float3 _1021 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _992, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _984, level(0.0)).xyz, float3(_1002)) * 1.0;
    float4 _1023 = _208;
    _1023.x = _1010.x;
    float4 _1025 = _208;
    _1025.x = _1010.y;
    float4 _1027 = _208;
    _1027.x = _1010.z;
    float3 _1028 = _1010.xyz;
    float3 _1032 = _1028 / float3(dot(_1028, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _1034 = _1021 * _1032.x;
    float3 _1037 = _1021 * _1032.y;
    float3 _1040 = _1021 * _1032.z;
    float3 _1043 = _210;
    _1043.x = dot(float4(_1023.x, _1034.x, _1034.y, _1034.z), _479);
    float3 _1045 = _1043;
    _1045.y = dot(float4(_1025.x, _1037.x, _1037.y, _1037.z), _479);
    float3 _1047 = _1045;
    _1047.z = dot(float4(_1027.x, _1040.x, _1040.y, _1040.z), _479);
    float _1049 = _1010.w;
    float3 _1054 = float4(fast::max(float3(0.0), _1047), _1049).xyz;
    float3 _1120;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _1068 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_273, 1.0);
        float2 _1072 = _1068.xy / float2(_1068.w);
        float _1073 = _1068.z;
        float4 _1076 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _1072, level(0.0));
        float3 _1080 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _1073;
        bool2 _1105 = _1072 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _1107 = _1072 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _1120 = _367 * fast::max(_1054 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _1049) * (float3(1.0) - select(fast::clamp(exp((float3((((_1076.x * _1073) * 0.5) + dot((sin(_1080) * _1076.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_1080)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _1072, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_1105.x || _1107.x, _1105.y || _1107.y)))))), float3(0.0));
    }
    else
    {
        _1120 = _367 * _1054;
    }
    float3 _1128 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _1159;
    float3 _1160;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _1134 = in.in_var_PRIMITIVE_ID * 36u;
        bool _1147 = any(abs(_273 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _1134 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _1134 + 19u)].xyz + float3(1.0)));
        float3 _1157;
        if (_1147)
        {
            _1157 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_273, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _1157 = _1128;
        }
        _1159 = _1147 ? 1.0 : _307;
        _1160 = _1157;
    }
    else
    {
        _1159 = _307;
        _1160 = _1128;
    }
    float4 _1170 = float4((((mix((((_910 * ((_369 * _774.x) + float3(fast::clamp(50.0 * _369.y, 0.0, 1.0) * _774.y))) * 1.0) * fast::max(float3(1.0), ((((((_369 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_369 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_369 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0)) + _1120, _367 + (_369 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_504 * _367) * fast::max(float3(1.0), ((((((_300 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_300 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_300 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _1160) * _976.w) + _976.xyz, _1159);
    float3 _1174 = _1170.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_1174.x, _1174.y, _1174.z, _1170.w);
    return out;
}

