

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
    char _m25_pad[80];
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

struct type_IndirectLightingCache
{
    char _m0_pad[64];
    float4 IndirectLightingCache_PointSkyBentNormal;
    char _m1_pad[16];
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients0;
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients1;
    float4 IndirectLightingCache_IndirectLightingSHCoefficients2;
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

constant float _181 = {};
constant float4 _182 = {};
constant float3 _183 = {};
constant float4 _185 = {};
constant float2 _186 = {};
constant float3 _187 = {};

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

fragment MainPS_out Main_00007af5_2a425740(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(9)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(3)]], constant type_View& View [[buffer(4)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(5)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(6)]], constant type_ReflectionCapture& ReflectionCapture [[buffer(7)]], constant type_Material& Material [[buffer(8)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_NumCulledLightsGrid [[texture(0)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_CulledLightDataGrid [[texture(1)]], texturecube<float> TranslucentBasePass_Shared_Reflection_SkyLightCubemap [[texture(2)]], texturecube_array<float> TranslucentBasePass_Shared_Reflection_ReflectionCubemap [[texture(3)]], texture2d<float> TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture [[texture(4)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(5)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(6)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(7)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(8)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(9)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_Shared_Reflection_SkyLightCubemapSampler [[sampler(1)]], sampler TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[3];
    float4 _243 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _247 = _243.xyz / float3(_243.w);
    float3 _248 = _247 - View.View_PreViewTranslation;
    float3 _250 = normalize(-_247);
    float3 _258 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _275 = fast::clamp(Material.Material_VectorExpressions[3].xyz, float3(0.0), float3(1.0));
    float _281 = (fast::clamp(Material.Material_ScalarExpressions[0].z, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _282 = fast::clamp(Material.Material_ScalarExpressions[0].w, 0.0, 1.0);
    float3 _291 = (_275 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _298 = (float3(0.07999999821186065673828125 * fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _301 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _306;
    if (_301)
    {
        _306 = _291 + (_298 * 0.449999988079071044921875);
    }
    else
    {
        _306 = _291;
    }
    float3 _308 = select(_298, float3(0.0), bool3(_301));
    bool _311 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float3 _384;
    if (_311)
    {
        float _332 = _258.y;
        float4 _334 = _185;
        _334.y = (-0.48860299587249755859375) * _332;
        float _335 = _258.z;
        float4 _337 = _334;
        _337.z = 0.48860299587249755859375 * _335;
        float _338 = _258.x;
        float4 _340 = _337;
        _340.w = (-0.48860299587249755859375) * _338;
        float3 _341 = _258 * _258;
        float4 _344 = _182;
        _344.x = (1.09254801273345947265625 * _338) * _332;
        float4 _347 = _344;
        _347.y = ((-1.09254801273345947265625) * _332) * _335;
        float4 _352 = _347;
        _352.z = 0.3153919875621795654296875 * ((3.0 * _341.z) - 1.0);
        float4 _355 = _352;
        _355.w = ((-1.09254801273345947265625) * _338) * _335;
        float4 _359 = _340;
        _359.x = 0.886227548122406005859375;
        float3 _361 = _359.yzw * 2.094395160675048828125;
        float4 _362 = float4(_359.x, _361.x, _361.y, _361.z);
        float4 _363 = _355 * 0.785398185253143310546875;
        float _364 = (_341.x - _341.y) * 0.4290426075458526611328125;
        float3 _370 = float3(0.0);
        _370.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _362) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _363)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _364);
        float3 _376 = _370;
        _376.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _362) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _363)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _364);
        float3 _382 = _376;
        _382.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _362) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _363)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _364);
        _384 = fast::max(float3(0.0), _382);
    }
    else
    {
        _384 = float3(0.0);
    }
    float _410;
    float _411;
    float3 _412;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _400;
        float _401;
        if (_311)
        {
            _400 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _401 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _400 = _258;
            _401 = 1.0;
        }
        float _402 = 1.0 - _401;
        float _404 = 1.0 - (_402 * _402);
        _410 = mix(fast::clamp(dot(_400, _258), 0.0, 1.0), 1.0, _404);
        _411 = _401;
        _412 = mix(_400, _258, float3(_404));
    }
    else
    {
        _410 = 1.0;
        _411 = 1.0;
        _412 = _258;
    }
    float4 _416 = float4(_412, 1.0);
    float3 _420 = _183;
    _420.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 0u)], _416);
    float3 _424 = _420;
    _424.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 1u)], _416);
    float3 _428 = _424;
    _428.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 2u)], _416);
    float4 _431 = _416.xyzz * _416.yzzx;
    float3 _435 = _183;
    _435.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 3u)], _431);
    float3 _439 = _435;
    _439.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 4u)], _431);
    float3 _443 = _439;
    _443.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 5u)], _431);
    float3 _458 = (_384 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_428 + _443) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 6u)].xyz * ((_412.x * _412.x) - (_412.y * _412.y)))) * View.View_SkyLightColor.xyz) * (_411 * _410));
    uint2 _503 = uint2((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_LightProbeSizeRatioAndInvSizeRatio.zw) >> (uint2(TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridPixelSizeShift) & uint2(31u));
    float3 _517 = (_258 * (2.0 * dot(_250, _258))) - _250;
    uint _523 = (TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumGridCells + ((((min(uint(fast::max(0.0, log2(((1.0 / gl_FragCoord.w) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.x) + TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.y) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.z)), uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.z - 1)) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.y)) + _503.y) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.x)) + _503.x)) * 2u;
    float _538 = 1.0 - (1.2000000476837158203125 * log2(fast::max(_281, 0.001000000047497451305389404296875)));
    float2 _542;
    float4 _545;
    _542 = float2(0.0, 1.0);
    _545 = float4(0.0, 0.0, 0.0, 1.0);
    float2 _543;
    float4 _546;
    for (uint _547 = 0u; _547 < min(TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint(_523)).x, TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumReflectionCaptures); _542 = _543, _545 = _546, _547++)
    {
        if (_545.w < 0.001000000047497451305389404296875)
        {
            break;
        }
        uint4 _558 = TranslucentBasePass_Shared_Forward_CulledLightDataGrid.read(uint((TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint((_523 + 1u))).x + _547)));
        uint _559 = _558.x;
        float3 _565 = _248 - ReflectionCapture.ReflectionCapture_PositionAndRadius[_559].xyz;
        float _566 = dot(_565, _565);
        float _567 = sqrt(_566);
        if (_567 < ReflectionCapture.ReflectionCapture_PositionAndRadius[_559].w)
        {
            float _658;
            float3 _659;
            if (ReflectionCapture.ReflectionCapture_CaptureProperties[_559].z > 0.0)
            {
                float3 _615 = (ReflectionCapture.ReflectionCapture_BoxTransform[_559] * float4(_248, 1.0)).xyz;
                float3 _621 = (ReflectionCapture.ReflectionCapture_BoxTransform[_559] * float4(_517, 0.0)).xyz;
                float3 _622 = float3(1.0) / _621;
                float3 _624 = _615 * _622;
                float3 _627 = fast::max((float3(-1.0) / _621) - _624, _622 - _624);
                float3 _641 = ReflectionCapture.ReflectionCapture_BoxScales[_559].xyz - float3(0.5 * ReflectionCapture.ReflectionCapture_BoxScales[_559].w);
                float3 _642 = -_641;
                float3 _643 = _615 * ReflectionCapture.ReflectionCapture_BoxScales[_559].xyz;
                _658 = 1.0 - smoothstep(0.0, 0.699999988079071044921875 * ReflectionCapture.ReflectionCapture_BoxScales[_559].w, dot(select(float3(0.0), abs(_643 - _642), _643 < _642), float3(1.0)) + dot(select(float3(0.0), abs(_643 - _641), _643 > _641), float3(1.0)));
                _659 = (_248 + (_517 * fast::min(_627.x, fast::min(_627.y, _627.z)))) - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_559].xyz + ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_559].xyz);
            }
            else
            {
                float _583 = dot(_517, _565);
                float _586 = (_583 * _583) - (_566 - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_559].w * ReflectionCapture.ReflectionCapture_PositionAndRadius[_559].w));
                float _603;
                float3 _604;
                if (_586 >= 0.0)
                {
                    float _597 = fast::clamp((2.5 * fast::clamp(_567 / ReflectionCapture.ReflectionCapture_PositionAndRadius[_559].w, 0.0, 1.0)) - 1.5, 0.0, 1.0);
                    _603 = 1.0 - ((_597 * _597) * (3.0 - (2.0 * _597)));
                    _604 = (_565 + (_517 * (sqrt(_586) - _583))) - ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_559].xyz;
                }
                else
                {
                    _603 = 0.0;
                    _604 = _517;
                }
                _658 = _603;
                _659 = _604;
            }
            float4 _666 = float4(_659, ReflectionCapture.ReflectionCapture_CaptureProperties[_559].y);
            float4 _668 = TranslucentBasePass_Shared_Reflection_ReflectionCubemap.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, _666.xyz, uint(round(_666.w)), level((View.View_ReflectionCubemapMaxMip - 1.0) - _538));
            float3 _671 = _668.xyz * ReflectionCapture.ReflectionCapture_CaptureProperties[_559].x;
            float4 _673 = float4(_671.x, _671.y, _671.z, _668.w) * _658;
            float3 _678 = _545.xyz + ((_673.xyz * _545.w) * 1.0);
            float4 _683 = float4(_678.x, _678.y, _678.z, _545.w);
            _683.w = _545.w * (1.0 - _673.w);
            float2 _690 = _186;
            _690.x = _542.x + ((ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_559].w * _658) * _542.y);
            float2 _693 = _690;
            _693.y = _542.y * (1.0 - _658);
            _543 = _693;
            _546 = _683;
        }
        else
        {
            _543 = _542;
            _546 = _545;
        }
    }
    float3 _695 = _545.xyz * View.View_IndirectLightingColorScale;
    float4 _696 = float4(_695.x, _695.y, _695.z, _545.w);
    float _699 = _542.x * dot(View.View_IndirectLightingColorScale, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float2 _700 = _186;
    _700.x = _699;
    float4 _742;
    float2 _743;
    float3 _744;
    if ((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightParameters.y > 0.0) && true)
    {
        float3 _720 = TranslucentBasePass_Shared_Reflection_SkyLightCubemap.sample(TranslucentBasePass_Shared_Reflection_SkyLightCubemapSampler, _517, level((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightParameters.x - 1.0) - _538)).xyz * View.View_SkyLightColor.xyz;
        float4 _739;
        float2 _740;
        float3 _741;
        if ((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightParameters.z < 1.0) && true)
        {
            float3 _733 = _695.xyz + ((_720 * _545.w) * 1.0);
            float2 _738 = _186;
            _738.x = _699 + ((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightCubemapBrightness * dot(View.View_SkyLightColor.xyz, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375))) * _542.y);
            _739 = float4(_733.x, _733.y, _733.z, _545.w);
            _740 = _738;
            _741 = float3(0.0);
        }
        else
        {
            _739 = _696;
            _740 = _700;
            _741 = _720 * 1.0;
        }
        _742 = _739;
        _743 = _740;
        _744 = _741;
    }
    else
    {
        _742 = _696;
        _743 = _700;
        _744 = float3(0.0);
    }
    float3 _766 = ((_742.xyz * mix(1.0, fast::min(dot(_458, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) / fast::max(_743.x, 9.9999997473787516355514526367188e-05), View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[2]), smoothstep(0.0, 1.0, fast::clamp((_281 * View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[0]) + View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[1], 0.0, 1.0)))).xyz + (_744 * _742.w)).xyz;
    float4 _768 = (float4(-1.0, -0.0274999998509883880615234375, -0.572000026702880859375, 0.02199999988079071044921875) * _281) + float4(1.0, 0.0425000004470348358154296875, 1.03999996185302734375, -0.039999999105930328369140625);
    float _769 = _768.x;
    float2 _779 = (float2(-1.03999996185302734375, 1.03999996185302734375) * ((fast::min(_769 * _769, exp2((-9.27999973297119140625) * fast::clamp(dot(_258, _250), 0.0, 1.0))) * _769) + _768.y)) + _768.zw;
    float3 _915;
    if (abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, float3(1.0))) > 9.9999997473787516355514526367188e-05)
    {
        float3 _815 = _248 - TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionOrigin.xyz;
        float _851 = (((1.0 - fast::clamp((abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane, float4(_248, -1.0))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.y, 0.0, 1.0)) * (fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.w - abs(dot(_815, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0) * fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.w - abs(dot(_815, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0))) * fast::clamp((dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, _258) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.y, 0.0, 1.0)) * (1.0 - fast::clamp((_281 - 0.20000000298023223876953125) * 10.0, 0.0, 1.0));
        float4 _909;
        if (_851 > 0.0)
        {
            float4 _880 = TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ProjectionWithExtraFOV[View.View_StereoPassIndex] * float4((View.View_TranslatedWorldToView * float4((_248 + (reflect(reflect(normalize(_248 - View.View_WorldCameraOrigin), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz), (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_InverseTransposeMirrorMatrix * _258).xyz) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.z)) + View.View_PreViewTranslation, 1.0)).xyz, 1.0);
            uint _887;
            if (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_bIsStereo != 0u)
            {
                _887 = uint(View.View_StereoPassIndex);
            }
            else
            {
                _887 = 0u;
            }
            float4 _904 = TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, ((fast::clamp(_880.xy / float2(_880.w), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_887].xy) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_887].zw), level(0.0));
            float4 _908 = float4(_904.x, _904.y, _904.z, float4(0.0).w);
            _908.w = _851 * _904.w;
            _909 = _908;
        }
        else
        {
            _909 = float4(0.0);
        }
        _915 = _909.xyz + (_766 * (1.0 - _909.w));
    }
    else
    {
        _915 = _766;
    }
    bool _933 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _982;
    if (_933)
    {
        float4 _940 = View.View_WorldToClip * float4(_248, 1.0);
        float _941 = _940.w;
        float4 _970;
        if (_933)
        {
            _970 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_940.xy / float2(_941)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_941 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _970 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _982 = float4(_970.xyz + (in.in_var_TEXCOORD7.xyz * _970.w), _970.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _982 = in.in_var_TEXCOORD7;
    }
    float3 _990 = (_248 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _998 = (_248 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _1003 = fast::clamp((float3(0.5) - abs(_990 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _1008 = (_1003.x * _1003.y) * _1003.z;
    float4 _1017 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _998, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _990, level(0.0)), float4(_1008));
    float3 _1028 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _998, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _990, level(0.0)).xyz, float3(_1008)) * 1.0;
    float4 _1030 = _185;
    _1030.x = _1017.x;
    float4 _1032 = _185;
    _1032.x = _1017.y;
    float4 _1034 = _185;
    _1034.x = _1017.z;
    float3 _1035 = _1017.xyz;
    float3 _1039 = _1035 / float3(dot(_1035, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _1041 = _1028 * _1039.x;
    float3 _1044 = _1028 * _1039.y;
    float3 _1047 = _1028 * _1039.z;
    float4 _1051 = _185;
    _1051.y = (-0.48860299587249755859375) * _258.y;
    float4 _1054 = _1051;
    _1054.z = 0.48860299587249755859375 * _258.z;
    float4 _1057 = _1054;
    _1057.w = (-0.48860299587249755859375) * _258.x;
    float4 _1058 = _1057;
    _1058.x = 0.886227548122406005859375;
    float3 _1060 = _1058.yzw * 2.094395160675048828125;
    float4 _1061 = float4(_1058.x, _1060.x, _1060.y, _1060.z);
    float3 _1063 = _187;
    _1063.x = dot(float4(_1030.x, _1041.x, _1041.y, _1041.z), _1061);
    float3 _1065 = _1063;
    _1065.y = dot(float4(_1032.x, _1044.x, _1044.y, _1044.z), _1061);
    float3 _1067 = _1065;
    _1067.z = dot(float4(_1034.x, _1047.x, _1047.y, _1047.z), _1061);
    float3 _1082 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _1113;
    float3 _1114;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _1088 = in.in_var_PRIMITIVE_ID * 36u;
        bool _1101 = any(abs(_248 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _1088 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _1088 + 19u)].xyz + float3(1.0)));
        float3 _1111;
        if (_1101)
        {
            _1111 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_248, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _1111 = _1082;
        }
        _1113 = _1101 ? 1.0 : _282;
        _1114 = _1111;
    }
    else
    {
        _1113 = _282;
        _1114 = _1082;
    }
    float4 _1124 = float4((((mix((((_915 * ((_308 * _779.x) + float3(fast::clamp(50.0 * _308.y, 0.0, 1.0) * _779.y))) * 1.0) * fast::max(float3(1.0), ((((((_308 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_308 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_308 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0)) + (_306 * float4(fast::max(float3(0.0), _1067), _181).xyz), _306 + (_308 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_458 * _306) * fast::max(float3(1.0), ((((((_275 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_275 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_275 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _1114) * _982.w) + _982.xyz, _1113);
    float3 _1128 = _1124.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_1128.x, _1128.y, _1128.z, _1124.w);
    return out;
}

