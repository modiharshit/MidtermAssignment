

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
    char _m0_pad[448];
    float4x4 View_ViewToClip;
    char _m1_pad[192];
    float4x4 View_SVPositionToTranslatedWorld;
    char _m2_pad[272];
    float4 View_InvDeviceZToWorldZTransform;
    float4 View_ScreenPositionScaleBias;
    char _m4_pad[48];
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
    char _m16_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m17_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m19_pad[124];
    float View_ShowDecalsMask;
    char _m20_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m21_pad[48];
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

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _184 = {};
constant float3 _185 = {};
constant float4 _187 = {};

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
    float4 in_var_TEXCOORD0_0 [[user(locn2)]];
    uint in_var_PRIMITIVE_ID [[user(locn3)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_000051cf_1e82ead3(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(11)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(12)]], texture2d<float> Material_Texture2D_0 [[texture(13)]], texture2d<float> Material_Texture2D_1 [[texture(14)]], texture2d<float> Material_Texture2D_2 [[texture(15)]], texture2d<float> Material_Texture2D_3 [[texture(16)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _247 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _251 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _256 = (_251.xyz / float3(_251.w)) - View.View_PreViewTranslation;
    float4 _262 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _265 = (_262.xy * float2(2.0)) - float2(1.0);
    float4 _277 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _304;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _304 = _247.w;
                break;
            }
            else
            {
                float _288 = _247.z;
                _304 = ((_288 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_288 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _320 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(float4(_265, sqrt(fast::clamp(1.0 - dot(_265, _265), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _277.x) + _304) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _332 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _337 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _342 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _346 = (_332.x + 0.5) * ((_337.x + 0.5) * (_342.x + 0.5));
    float4 _352 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _358 = fast::clamp(mix(float3(0.20000000298023223876953125), float3(1.0), float3(_346)) * _352.xyz, float3(0.0), float3(1.0));
    float _363 = (fast::clamp(mix(0.4000000059604644775390625, 0.800000011920928955078125, _346 * _352.w), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _364 = in.in_var_PRIMITIVE_ID * 36u;
    uint _365 = _364 + 20u;
    float _413;
    float _414;
    float _415;
    float3 _416;
    float3 _417;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _365)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _383 = ((_247.xy / float2(_247.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _387 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _383, level(0.0));
        float4 _390 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _383, level(0.0));
        float4 _393 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _383, level(0.0));
        float _403 = _393.w;
        _413 = (_363 * _403) + _393.z;
        _414 = (0.5 * _403) + _393.y;
        _415 = _393.x;
        _416 = (_358 * _387.w) + _387.xyz;
        _417 = normalize((_320 * _390.w) + ((_390.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _413 = _363;
        _414 = 0.5;
        _415 = 0.0;
        _416 = _358;
        _417 = _320;
    }
    float3 _427 = fast::clamp((_256 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _438 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_427.x), int(_427.y), int(_427.z), 0).xyz), 0));
    float3 _453 = (((_438.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_427 / float3(_438.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _466;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _365)].z > 0.0)
    {
        _466 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _453, level(0.0)).x;
    }
    else
    {
        _466 = 1.0;
    }
    float3 _480 = ((_416 - (_416 * _415)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _487 = (mix(float3(0.07999999821186065673828125 * _414), _416, float3(_415)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _490 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _495;
    if (_490)
    {
        _495 = _480 + (_487 * 0.449999988079071044921875);
    }
    else
    {
        _495 = _480;
    }
    float3 _497 = select(_487, float3(0.0), bool3(_490));
    float3 _499 = float3(dot(_497, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _516 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _453, level(0.0));
    float _532 = _516.x;
    float4 _534 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _453, level(0.0)) * 2.0) - float4(1.0)) * _532) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _535 = _516.y;
    float4 _537 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _453, level(0.0)) * 2.0) - float4(1.0)) * _535) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _538 = _516.z;
    float4 _540 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _453, level(0.0)) * 2.0) - float4(1.0)) * _538) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _557 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _453, level(0.0)) * 2.0) - float4(1.0)) * _532) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _559 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _453, level(0.0)) * 2.0) - float4(1.0)) * _535) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _561 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _453, level(0.0)) * 2.0) - float4(1.0)) * _538) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _594 = _187;
    _594.y = (-0.48860299587249755859375) * _417.y;
    float4 _597 = _594;
    _597.z = 0.48860299587249755859375 * _417.z;
    float4 _600 = _597;
    _600.w = (-0.48860299587249755859375) * _417.x;
    float3 _601 = _417 * _417;
    float4 _604 = _184;
    _604.x = (1.09254801273345947265625 * _417.x) * _417.y;
    float4 _607 = _604;
    _607.y = ((-1.09254801273345947265625) * _417.y) * _417.z;
    float4 _612 = _607;
    _612.z = 0.3153919875621795654296875 * ((3.0 * _601.z) - 1.0);
    float4 _615 = _612;
    _615.w = ((-1.09254801273345947265625) * _417.x) * _417.z;
    float4 _619 = _600;
    _619.x = 0.886227548122406005859375;
    float3 _621 = _619.yzw * 2.094395160675048828125;
    float4 _622 = float4(_619.x, _621.x, _621.y, _621.z);
    float4 _623 = _615 * 0.785398185253143310546875;
    float _624 = (_601.x - _601.y) * 0.4290426075458526611328125;
    float3 _630 = float3(0.0);
    _630.x = (dot(float4(_532, _534.xyz), _622) + dot(float4(_534.w, _557.xyz), _623)) + (_557.w * _624);
    float3 _636 = _630;
    _636.y = (dot(float4(_535, _537.xyz), _622) + dot(float4(_537.w, _559.xyz), _623)) + (_559.w * _624);
    float3 _642 = _636;
    _642.z = (dot(float4(_538, _540.xyz), _622) + dot(float4(_540.w, _561.xyz), _623)) + (_561.w * _624);
    float _671;
    float _672;
    float3 _673;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _658 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _453, level(0.0)).xyz * 2.0) - float3(1.0);
        float _659 = length(_658);
        float3 _662 = _658 / float3(fast::max(_659, 9.9999997473787516355514526367188e-05));
        float _663 = 1.0 - _659;
        float _665 = 1.0 - (_663 * _663);
        _671 = mix(fast::clamp(dot(_662, _417), 0.0, 1.0), 1.0, _665);
        _672 = _659;
        _673 = mix(_662, _417, float3(_665));
    }
    else
    {
        _671 = 1.0;
        _672 = 1.0;
        _673 = _417;
    }
    float4 _677 = float4(_673, 1.0);
    float3 _681 = _185;
    _681.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _677);
    float3 _685 = _681;
    _685.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _677);
    float3 _689 = _685;
    _689.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _677);
    float4 _692 = _677.xyzz * _677.yzzx;
    float3 _696 = _185;
    _696.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _692);
    float3 _700 = _696;
    _700.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _692);
    float3 _704 = _700;
    _704.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _692);
    float3 _719 = ((fast::max(float3(0.0), _642) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_689 + _704) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_673.x * _673.x) - (_673.y * _673.y)))) * View.View_SkyLightColor.xyz) * (_672 * _671));
    float3 _741 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _770;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _769;
        if (any(abs(_256 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _364 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _364 + 19u)].xyz + float3(1.0))))
        {
            _769 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_256, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _769 = _741;
        }
        _770 = _769;
    }
    else
    {
        _770 = _741;
    }
    float4 _777 = float4(((mix(float3(0.0), _495 + (_497 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_719 * _495) * fast::max(float3(1.0), ((((((_416 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_416 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_416 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _770) * 1.0, 0.0);
    float4 _784;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _783 = _777;
        _783.w = 0.0;
        _784 = _783;
    }
    else
    {
        _784 = _777;
    }
    float2 _788 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _796 = (_417 * 0.5) + float3(0.5);
    float4 _798 = float4(_796.x, _796.y, _796.z, float4(0.0).w);
    _798.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _365)].y;
    float4 _799 = float4(0.0);
    _799.x = _415;
    float4 _800 = _799;
    _800.y = _414;
    float4 _801 = _800;
    _801.z = _413;
    float4 _802 = _801;
    _802.w = 0.50588238239288330078125;
    float4 _814 = float4(_416.x, _416.y, _416.z, float4(0.0).w);
    _814.w = ((log2(((dot(_719, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_499 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_499 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_499 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_788.xyx * _788.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _784 * View.View_PreExposure;
    out.out_var_SV_Target1 = _798;
    out.out_var_SV_Target2 = _802;
    out.out_var_SV_Target3 = _814;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_466, 1.0, 1.0, 1.0);
    return out;
}

