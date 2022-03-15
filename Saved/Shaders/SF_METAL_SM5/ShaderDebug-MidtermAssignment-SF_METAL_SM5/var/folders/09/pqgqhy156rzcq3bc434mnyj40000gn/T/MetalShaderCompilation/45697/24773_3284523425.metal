

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
    char _m0_pad[256];
    float4x4 View_ViewToTranslatedWorld;
    char _m1_pad[384];
    float4x4 View_SVPositionToTranslatedWorld;
    char _m2_pad[288];
    float4 View_ScreenPositionScaleBias;
    float3 View_WorldCameraOrigin;
    char _m4_pad[32];
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
    char _m13_pad[48];
    float View_MaterialTextureMipBias;
    char _m14_pad[28];
    float View_UnlitViewmodeMask;
    char _m15_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m16_pad[400];
    packed_float3 View_NormalCurvatureToRoughnessScaleBias;
    float View_RenderingReflectionCaptureMask;
    char _m18_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m20_pad[124];
    float View_ShowDecalsMask;
    char _m21_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m22_pad[48];
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

struct type_PrimitiveDither
{
    float PrimitiveDither_LODFactor;
};

struct type_Material
{
    spvUnsafeArray<float4, 6> Material_VectorExpressions;
    spvUnsafeArray<float4, 4> Material_ScalarExpressions;
};

constant float _185 = {};
constant float4x4 _186 = {};
constant float4 _187 = {};
constant float3 _188 = {};
constant float _190 = {};
constant float4 _191 = {};
constant float3 _192 = {};

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
    float4 in_var_TEXCOORD15 [[user(locn2)]];
    float4 in_var_TEXCOORD0_0 [[user(locn3)]];
    uint in_var_PRIMITIVE_ID [[user(locn4)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_000060c5_c3c5d9a1(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_PrimitiveDither& PrimitiveDither [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(11)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(12)]], texture2d<float> Material_Texture2D_0 [[texture(13)]], texture2d<float> Material_Texture2D_1 [[texture(14)]], texture2d<float> Material_Texture2D_3 [[texture(15)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_3Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float3x3 _246 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _258 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _190, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _263 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _268 = (_263.xyz / float3(_263.w)) - View.View_PreViewTranslation;
    uint _269 = in.in_var_PRIMITIVE_ID * 36u;
    float4x4 _272 = _186;
    _272[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _269)];
    float4x4 _276 = _272;
    _276[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _269 + 1u)];
    float4x4 _280 = _276;
    _280[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _269 + 2u)];
    float4x4 _284 = _280;
    _284[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _269 + 3u)];
    float3 _287 = (_284 * float4(0.0, 0.0, 0.0, 1.0)).xyz - View.View_WorldCameraOrigin;
    float4 _299 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _302 = (float3(-0.5) + _299.xyz) * 2.0;
    float3 _318 = ((((_287 / float3(sqrt(dot(_287, _287)))) * _246) * (-1.0)) * _302.z) + (float3(_302.xy, 0.0) * ((float3x3(View.View_ViewToTranslatedWorld[0].xyz, View.View_ViewToTranslatedWorld[1].xyz, View.View_ViewToTranslatedWorld[2].xyz) * float3(1.0, 1.0, 0.0)) * _246));
    float3 _330 = normalize(_246 * normalize(((_318 / float3(sqrt(dot(_318, _318)))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _341 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _348 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    if (PrimitiveDither.PrimitiveDither_LODFactor != 0.0)
    {
        if (abs(PrimitiveDither.PrimitiveDither_LODFactor) > 0.001000000047497451305389404296875)
        {
            float _368 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
            if ((float((PrimitiveDither.PrimitiveDither_LODFactor < 0.0) ? ((PrimitiveDither.PrimitiveDither_LODFactor + 1.0) > _368) : (PrimitiveDither.PrimitiveDither_LODFactor < _368)) - 0.001000000047497451305389404296875) < 0.0)
            {
                discard_fragment();
            }
        }
    }
    if (((_341.w * in_var_TEXCOORD0[0].z) - 0.100000001490116119384765625) < 0.0)
    {
        discard_fragment();
    }
    float3 _383 = fast::clamp(_341.xyz, float3(0.0), float3(1.0));
    float _388 = (fast::clamp(_299.w, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float3 _398 = (fast::clamp(float4(_348.xyz, _185).xyz, float3(0.0), float3(1.0)).xyz * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    uint _399 = _269 + 20u;
    float3 _448;
    float _449;
    float _450;
    float _451;
    float3 _452;
    float3 _453;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _399)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _417 = ((_258.xy / float2(_258.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _421 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _417, level(0.0));
        float4 _424 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _417, level(0.0));
        float4 _427 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _417, level(0.0));
        float _429 = _421.w;
        float _437 = _427.w;
        _448 = _398 * _429;
        _449 = (_388 * _437) + _427.z;
        _450 = (0.5 * _437) + _427.y;
        _451 = _427.x;
        _452 = (_383 * _429) + _421.xyz;
        _453 = normalize((_330 * _424.w) + ((_424.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _448 = _398;
        _449 = _388;
        _450 = 0.5;
        _451 = 0.0;
        _452 = _383;
        _453 = _330;
    }
    float3 _463 = fast::clamp((_268 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _474 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_463.x), int(_463.y), int(_463.z), 0).xyz), 0));
    float3 _489 = (((_474.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_463 / float3(_474.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _502;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _399)].z > 0.0)
    {
        _502 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _489, level(0.0)).x;
    }
    else
    {
        _502 = 1.0;
    }
    float3 _505 = sqrt(fast::clamp(_448, float3(0.0), float3(1.0)));
    float4 _507 = float4(_505.x, _505.y, _505.z, float4(0.0).w);
    _507.w = 1.0;
    float3 _512 = dfdx(in.in_var_TEXCOORD15.xyz);
    float3 _513 = dfdy(in.in_var_TEXCOORD15.xyz);
    float3 _531 = ((_452 - (_452 * _451)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _538 = (mix(float3(0.07999999821186065673828125 * _450), _452, float3(_451)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _541 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _546;
    if (_541)
    {
        _546 = _531 + (_538 * 0.449999988079071044921875);
    }
    else
    {
        _546 = _531;
    }
    float3 _548 = select(_538, float3(0.0), bool3(_541));
    float3 _550 = float3(dot(_548, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _567 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _489, level(0.0));
    float _583 = _567.x;
    float4 _585 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _489, level(0.0)) * 2.0) - float4(1.0)) * _583) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _586 = _567.y;
    float4 _588 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _489, level(0.0)) * 2.0) - float4(1.0)) * _586) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _589 = _567.z;
    float4 _591 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _489, level(0.0)) * 2.0) - float4(1.0)) * _589) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _608 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _489, level(0.0)) * 2.0) - float4(1.0)) * _583) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _610 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _489, level(0.0)) * 2.0) - float4(1.0)) * _586) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _612 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _489, level(0.0)) * 2.0) - float4(1.0)) * _589) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _616 = float4(_583, _585.xyz);
    float4 _621 = float4(_585.w, _608.xyz);
    float _622 = _608.w;
    float4 _626 = float4(_586, _588.xyz);
    float4 _631 = float4(_588.w, _610.xyz);
    float _632 = _610.w;
    float4 _636 = float4(_589, _591.xyz);
    float4 _641 = float4(_591.w, _612.xyz);
    float _642 = _612.w;
    float4 _645 = _191;
    _645.y = (-0.48860299587249755859375) * _453.y;
    float4 _648 = _645;
    _648.z = 0.48860299587249755859375 * _453.z;
    float4 _651 = _648;
    _651.w = (-0.48860299587249755859375) * _453.x;
    float3 _652 = _453 * _453;
    float4 _655 = _187;
    _655.x = (1.09254801273345947265625 * _453.x) * _453.y;
    float4 _658 = _655;
    _658.y = ((-1.09254801273345947265625) * _453.y) * _453.z;
    float4 _663 = _658;
    _663.z = 0.3153919875621795654296875 * ((3.0 * _652.z) - 1.0);
    float4 _666 = _663;
    _666.w = ((-1.09254801273345947265625) * _453.x) * _453.z;
    float4 _670 = _651;
    _670.x = 0.886227548122406005859375;
    float3 _672 = _670.yzw * 2.094395160675048828125;
    float4 _673 = float4(_670.x, _672.x, _672.y, _672.z);
    float4 _674 = _666 * 0.785398185253143310546875;
    float _675 = (_652.x - _652.y) * 0.4290426075458526611328125;
    float3 _681 = float3(0.0);
    _681.x = (dot(_616, _673) + dot(_621, _674)) + (_622 * _675);
    float3 _687 = _681;
    _687.y = (dot(_626, _673) + dot(_631, _674)) + (_632 * _675);
    float3 _693 = _687;
    _693.z = (dot(_636, _673) + dot(_641, _674)) + (_642 * _675);
    float3 _696 = -_453;
    float _697 = _696.y;
    float4 _699 = _191;
    _699.y = (-0.48860299587249755859375) * _697;
    float _700 = _696.z;
    float4 _702 = _699;
    _702.z = 0.48860299587249755859375 * _700;
    float _703 = _696.x;
    float4 _705 = _702;
    _705.w = (-0.48860299587249755859375) * _703;
    float3 _706 = _696 * _696;
    float4 _709 = _187;
    _709.x = (1.09254801273345947265625 * _703) * _697;
    float4 _712 = _709;
    _712.y = ((-1.09254801273345947265625) * _697) * _700;
    float4 _717 = _712;
    _717.z = 0.3153919875621795654296875 * ((3.0 * _706.z) - 1.0);
    float4 _720 = _717;
    _720.w = ((-1.09254801273345947265625) * _703) * _700;
    float4 _724 = _705;
    _724.x = 0.886227548122406005859375;
    float3 _726 = _724.yzw * 2.094395160675048828125;
    float4 _727 = float4(_724.x, _726.x, _726.y, _726.z);
    float4 _728 = _720 * 0.785398185253143310546875;
    float _729 = (_706.x - _706.y) * 0.4290426075458526611328125;
    float3 _735 = _192;
    _735.x = (dot(_616, _727) + dot(_621, _728)) + (_622 * _729);
    float3 _741 = _735;
    _741.y = (dot(_626, _727) + dot(_631, _728)) + (_632 * _729);
    float3 _747 = _741;
    _747.z = (dot(_636, _727) + dot(_641, _728)) + (_642 * _729);
    float _777;
    float _778;
    float3 _779;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _764 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _489, level(0.0)).xyz * 2.0) - float3(1.0);
        float _765 = length(_764);
        float3 _768 = _764 / float3(fast::max(_765, 9.9999997473787516355514526367188e-05));
        float _769 = 1.0 - _765;
        float _771 = 1.0 - (_769 * _769);
        _777 = mix(fast::clamp(dot(_768, _453), 0.0, 1.0), 1.0, _771);
        _778 = _765;
        _779 = mix(_768, _453, float3(_771));
    }
    else
    {
        _777 = 1.0;
        _778 = 1.0;
        _779 = _453;
    }
    float4 _783 = float4(_779, 1.0);
    float3 _787 = _188;
    _787.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _783);
    float3 _791 = _787;
    _791.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _783);
    float3 _795 = _791;
    _795.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _783);
    float4 _798 = _783.xyzz * _783.yzzx;
    float3 _802 = _188;
    _802.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _798);
    float3 _806 = _802;
    _806.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _798);
    float3 _810 = _806;
    _810.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _798);
    float4 _825 = float4(_703, _697, _700, 1.0);
    float3 _828 = _192;
    _828.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _825);
    float3 _831 = _828;
    _831.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _825);
    float3 _834 = _831;
    _834.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _825);
    float4 _837 = _825.xyzz * _825.yzzx;
    float3 _840 = _192;
    _840.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _837);
    float3 _843 = _840;
    _843.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _837);
    float3 _846 = _843;
    _846.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _837);
    float3 _859 = ((fast::max(float3(0.0), _693) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_795 + _810) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_779.x * _779.x) - (_779.y * _779.y)))) * View.View_SkyLightColor.xyz) * (_778 * _777));
    float3 _883 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _912;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _911;
        if (any(abs(_268 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _269 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _269 + 19u)].xyz + float3(1.0))))
        {
            _911 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_268, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _911 = _883;
        }
        _912 = _911;
    }
    else
    {
        _912 = _883;
    }
    float4 _919 = float4(((mix(float3(0.0), _546 + (_548 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + (((_859 * _546) + ((((fast::max(float3(0.0), _747) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_834 + _846) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_703 * _703) - (_697 * _697)))) * View.View_SkyLightColor.xyz) * _778)) * _448)) * fast::max(float3(1.0), ((((((_452 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_452 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_452 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _912) * 1.0, 0.0);
    float4 _926;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _925 = _919;
        _925.w = 0.0;
        _926 = _925;
    }
    else
    {
        _926 = _919;
    }
    float2 _930 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _938 = (_453 * 0.5) + float3(0.5);
    float4 _940 = float4(_938.x, _938.y, _938.z, float4(0.0).w);
    _940.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _399)].y;
    float4 _941 = float4(0.0);
    _941.x = _451;
    float4 _942 = _941;
    _942.y = _450;
    float4 _943 = _942;
    _943.z = fast::max(_449, fast::clamp((pow(fast::max(dot(_512, _512), dot(_513, _513)), View.View_NormalCurvatureToRoughnessScaleBias[2]) * View.View_NormalCurvatureToRoughnessScaleBias[0]) + View.View_NormalCurvatureToRoughnessScaleBias[1], 0.0, 1.0));
    float4 _944 = _943;
    _944.w = 0.525490224361419677734375;
    float4 _956 = float4(_452.x, _452.y, _452.z, float4(0.0).w);
    _956.w = ((log2(((dot(_859, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_550 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_550 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_550 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_930.xyx * _930.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _926 * View.View_PreExposure;
    out.out_var_SV_Target1 = _940;
    out.out_var_SV_Target2 = _944;
    out.out_var_SV_Target3 = _956;
    out.out_var_SV_Target4 = _507;
    out.out_var_SV_Target5 = float4(_502, 1.0, 1.0, 1.0);
    return out;
}

