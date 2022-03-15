

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
    char _m13_pad[36];
    float View_GameTime;
    char _m14_pad[8];
    float View_MaterialTextureMipBias;
    char _m15_pad[28];
    float View_UnlitViewmodeMask;
    char _m16_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m17_pad[412];
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

struct type_Material
{
    spvUnsafeArray<float4, 6> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _193 = {};
constant float3 _194 = {};
constant float4 _196 = {};

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

fragment MainPS_out Main_0000559d_e5bfd241(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(11)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(12)]], texture2d<float> Material_Texture2D_0 [[texture(13)]], texture2d<float> Material_Texture2D_1 [[texture(14)]], texture2d<float> Material_Texture2D_2 [[texture(15)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _257 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _261 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _266 = (_261.xyz / float3(_261.w)) - View.View_PreViewTranslation;
    float2 _273 = float2(View.View_GameTime * (-0.02999999932944774627685546875), View.View_GameTime * (-0.0199999995529651641845703125)) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(0.0500000007450580596923828125, 0.07999999821186065673828125));
    float4 _279 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _273, bias(View.View_MaterialTextureMipBias));
    float2 _282 = (_279.xy * float2(2.0)) - float2(1.0);
    float _289 = sqrt(fast::clamp(1.0 - dot(_282, _282), 0.0, 1.0)) + 1.0;
    float _297 = sin(((_266.x * 0.006666666828095912933349609375) + (View.View_GameTime * Material.Material_ScalarExpressions[0].x)) * 1.256637096405029296875);
    float4 _304 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(_297 * (-0.0599999986588954925537109375), _297 * (-0.039999999105930328369140625)) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(0.180000007152557373046875, 0.1500000059604644775390625))), bias(View.View_MaterialTextureMipBias));
    float2 _307 = (_304.xy * float2(2.0)) - float2(1.0);
    float3 _316 = float4(_307, sqrt(fast::clamp(1.0 - dot(_307, _307), 0.0, 1.0)), 1.0).xyz * float3(-1.0, -1.0, 1.0);
    float3 _319 = float3(_282, _289);
    float3 _323 = float3(_316.xy * (-1.0), _316.z);
    float3 _327 = (_319 * dot(_319, _323)) - (_323 * _289);
    float _329 = _327.z + 1.0;
    float2 _333 = float2(View.View_GameTime * (-0.070000000298023223876953125)) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.75);
    float4 _335 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _333, bias(View.View_MaterialTextureMipBias));
    float2 _338 = (_335.xy * float2(2.0)) - float2(1.0);
    float4 _350 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _377;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _377 = _257.w;
                break;
            }
            else
            {
                float _361 = _257.z;
                _377 = ((_361 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_361 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _384 = float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _350.x) + _377) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0));
    float3 _385 = mix(float4(_338, sqrt(fast::clamp(1.0 - dot(_338, _338), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), _384);
    float3 _390 = float3(_327.xy, _329);
    float3 _394 = float3(_385.xy * (-1.0), _385.z);
    float3 _406 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((((_390 * dot(_390, _394)) - (_394 * _329)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _417 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _333, bias(View.View_MaterialTextureMipBias));
    float4 _419 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _273, bias(View.View_MaterialTextureMipBias));
    float3 _434 = fast::clamp(mix(mix(Material.Material_VectorExpressions[4].xyz, Material.Material_VectorExpressions[5].xyz, float3(fast::min(fast::max(_417.x * _419.x, 0.0), 1.0))), Material.Material_VectorExpressions[4].xyz, _384), float3(0.0), float3(1.0));
    float _438 = (0.100000001490116119384765625 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _439 = in.in_var_PRIMITIVE_ID * 36u;
    uint _440 = _439 + 20u;
    float _488;
    float _489;
    float _490;
    float3 _491;
    float3 _492;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _440)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _458 = ((_257.xy / float2(_257.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _462 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _458, level(0.0));
        float4 _465 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _458, level(0.0));
        float4 _468 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _458, level(0.0));
        float _478 = _468.w;
        _488 = (_438 * _478) + _468.z;
        _489 = (0.5 * _478) + _468.y;
        _490 = _468.x;
        _491 = (_434 * _462.w) + _462.xyz;
        _492 = normalize((_406 * _465.w) + ((_465.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _488 = _438;
        _489 = 0.5;
        _490 = 0.0;
        _491 = _434;
        _492 = _406;
    }
    float3 _502 = fast::clamp((_266 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _513 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_502.x), int(_502.y), int(_502.z), 0).xyz), 0));
    float3 _528 = (((_513.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_502 / float3(_513.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _541;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _440)].z > 0.0)
    {
        _541 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _528, level(0.0)).x;
    }
    else
    {
        _541 = 1.0;
    }
    float3 _555 = ((_491 - (_491 * _490)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _562 = (mix(float3(0.07999999821186065673828125 * _489), _491, float3(_490)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _565 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _570;
    if (_565)
    {
        _570 = _555 + (_562 * 0.449999988079071044921875);
    }
    else
    {
        _570 = _555;
    }
    float3 _572 = select(_562, float3(0.0), bool3(_565));
    float3 _574 = float3(dot(_572, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _591 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _528, level(0.0));
    float _607 = _591.x;
    float4 _609 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _528, level(0.0)) * 2.0) - float4(1.0)) * _607) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _610 = _591.y;
    float4 _612 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _528, level(0.0)) * 2.0) - float4(1.0)) * _610) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _613 = _591.z;
    float4 _615 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _528, level(0.0)) * 2.0) - float4(1.0)) * _613) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _632 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _528, level(0.0)) * 2.0) - float4(1.0)) * _607) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _634 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _528, level(0.0)) * 2.0) - float4(1.0)) * _610) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _636 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _528, level(0.0)) * 2.0) - float4(1.0)) * _613) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _669 = _196;
    _669.y = (-0.48860299587249755859375) * _492.y;
    float4 _672 = _669;
    _672.z = 0.48860299587249755859375 * _492.z;
    float4 _675 = _672;
    _675.w = (-0.48860299587249755859375) * _492.x;
    float3 _676 = _492 * _492;
    float4 _679 = _193;
    _679.x = (1.09254801273345947265625 * _492.x) * _492.y;
    float4 _682 = _679;
    _682.y = ((-1.09254801273345947265625) * _492.y) * _492.z;
    float4 _687 = _682;
    _687.z = 0.3153919875621795654296875 * ((3.0 * _676.z) - 1.0);
    float4 _690 = _687;
    _690.w = ((-1.09254801273345947265625) * _492.x) * _492.z;
    float4 _694 = _675;
    _694.x = 0.886227548122406005859375;
    float3 _696 = _694.yzw * 2.094395160675048828125;
    float4 _697 = float4(_694.x, _696.x, _696.y, _696.z);
    float4 _698 = _690 * 0.785398185253143310546875;
    float _699 = (_676.x - _676.y) * 0.4290426075458526611328125;
    float3 _705 = float3(0.0);
    _705.x = (dot(float4(_607, _609.xyz), _697) + dot(float4(_609.w, _632.xyz), _698)) + (_632.w * _699);
    float3 _711 = _705;
    _711.y = (dot(float4(_610, _612.xyz), _697) + dot(float4(_612.w, _634.xyz), _698)) + (_634.w * _699);
    float3 _717 = _711;
    _717.z = (dot(float4(_613, _615.xyz), _697) + dot(float4(_615.w, _636.xyz), _698)) + (_636.w * _699);
    float _746;
    float _747;
    float3 _748;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _733 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _528, level(0.0)).xyz * 2.0) - float3(1.0);
        float _734 = length(_733);
        float3 _737 = _733 / float3(fast::max(_734, 9.9999997473787516355514526367188e-05));
        float _738 = 1.0 - _734;
        float _740 = 1.0 - (_738 * _738);
        _746 = mix(fast::clamp(dot(_737, _492), 0.0, 1.0), 1.0, _740);
        _747 = _734;
        _748 = mix(_737, _492, float3(_740));
    }
    else
    {
        _746 = 1.0;
        _747 = 1.0;
        _748 = _492;
    }
    float4 _752 = float4(_748, 1.0);
    float3 _756 = _194;
    _756.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _752);
    float3 _760 = _756;
    _760.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _752);
    float3 _764 = _760;
    _764.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _752);
    float4 _767 = _752.xyzz * _752.yzzx;
    float3 _771 = _194;
    _771.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _767);
    float3 _775 = _771;
    _775.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _767);
    float3 _779 = _775;
    _779.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _767);
    float3 _794 = ((fast::max(float3(0.0), _717) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_764 + _779) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_748.x * _748.x) - (_748.y * _748.y)))) * View.View_SkyLightColor.xyz) * (_747 * _746));
    float3 _816 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].y)), float3(0.0));
    float3 _845;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _844;
        if (any(abs(_266 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _439 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _439 + 19u)].xyz + float3(1.0))))
        {
            _844 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_266, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _844 = _816;
        }
        _845 = _844;
    }
    else
    {
        _845 = _816;
    }
    float4 _852 = float4(((mix(float3(0.0), _570 + (_572 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_794 * _570) * fast::max(float3(1.0), ((((((_491 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_491 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_491 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _845) * 1.0, 0.0);
    float4 _859;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _858 = _852;
        _858.w = 0.0;
        _859 = _858;
    }
    else
    {
        _859 = _852;
    }
    float2 _863 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _871 = (_492 * 0.5) + float3(0.5);
    float4 _873 = float4(_871.x, _871.y, _871.z, float4(0.0).w);
    _873.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _440)].y;
    float4 _874 = float4(0.0);
    _874.x = _490;
    float4 _875 = _874;
    _875.y = _489;
    float4 _876 = _875;
    _876.z = _488;
    float4 _877 = _876;
    _877.w = 0.50588238239288330078125;
    float4 _889 = float4(_491.x, _491.y, _491.z, float4(0.0).w);
    _889.w = ((log2(((dot(_794, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_574 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_574 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_574 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_863.xyx * _863.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _859 * View.View_PreExposure;
    out.out_var_SV_Target1 = _873;
    out.out_var_SV_Target2 = _877;
    out.out_var_SV_Target3 = _889;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_541, 1.0, 1.0, 1.0);
    return out;
}

