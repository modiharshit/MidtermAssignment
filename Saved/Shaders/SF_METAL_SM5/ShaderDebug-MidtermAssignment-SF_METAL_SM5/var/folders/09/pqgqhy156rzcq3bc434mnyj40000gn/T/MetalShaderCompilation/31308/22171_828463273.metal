

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
    spvUnsafeArray<float4, 5> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _183 = {};
constant float3 _184 = {};
constant float4 _186 = {};

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

fragment MainPS_out Main_0000569b_316158a9(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(11)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(12)]], texture2d<float> Material_Texture2D_0 [[texture(13)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    bool _338;
    float4 _247 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _251 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _256 = (_251.xyz / float3(_251.w)) - View.View_PreViewTranslation;
    float4 _268 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(View.View_GameTime * (-0.100000001490116119384765625), View.View_GameTime * (-0.0500000007450580596923828125)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y)), bias(View.View_MaterialTextureMipBias));
    float2 _271 = (_268.xy * float2(2.0)) - float2(1.0);
    float _280 = View.View_GameTime * 0.0500000007450580596923828125;
    float4 _285 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(View.View_GameTime * 0.039999999105930328369140625, _280) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5)), bias(View.View_MaterialTextureMipBias));
    float2 _288 = (_285.xy * float2(2.0)) - float2(1.0);
    float _300 = View.View_GameTime * (-0.02999999932944774627685546875);
    float4 _305 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(_300, _280) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.300000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float2 _308 = (_305.xy * float2(2.0)) - float2(1.0);
    float4 _320 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(_280, 0.0) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.25)), bias(View.View_MaterialTextureMipBias));
    float2 _323 = (_320.xy * float2(2.0)) - float2(1.0);
    float _358;
    switch (0u)
    {
        default:
        {
            _338 = View.View_ViewToClip[3u].w < 1.0;
            if (_338)
            {
                _358 = _247.w;
                break;
            }
            else
            {
                float _342 = _247.z;
                _358 = ((_342 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_342 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float4 _370 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(_300, View.View_GameTime * (-0.0089999996125698089599609375)) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float2 _373 = (_370.xy * float2(2.0)) - float2(1.0);
    float4 _386 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(View.View_GameTime * 0.02999999932944774627685546875, 0.0) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(0.07999999821186065673828125, 0.039999999105930328369140625))), bias(View.View_MaterialTextureMipBias));
    float2 _389 = (_386.xy * float2(2.0)) - float2(1.0);
    float _422;
    switch (0u)
    {
        default:
        {
            if (_338)
            {
                _422 = _247.w;
                break;
            }
            else
            {
                float _406 = _247.z;
                _422 = ((_406 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_406 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _436 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(mix(float4(_271, sqrt(fast::clamp(1.0 - dot(_271, _271), 0.0, 1.0)), 1.0).xyz + (float4(_288, sqrt(fast::clamp(1.0 - dot(_288, _288), 0.0, 1.0)), 1.0).xyz * float3(-1.0, -1.0, 1.0)), float4(_308, sqrt(fast::clamp(1.0 - dot(_308, _308), 0.0, 1.0)), 1.0).xyz + float4(_323, sqrt(fast::clamp(1.0 - dot(_323, _323), 0.0, 1.0)), 1.0).xyz, float3(fast::min(fast::max((_358 - 300.0) * 0.0011111111380159854888916015625, 0.0), 1.0))), float4(_373, sqrt(fast::clamp(1.0 - dot(_373, _373), 0.0, 1.0)), 1.0).xyz + (float4(_389, sqrt(fast::clamp(1.0 - dot(_389, _389), 0.0, 1.0)), 1.0).xyz * float3(-1.0, -1.0, 1.0)), float3(fast::min(fast::max((_422 - 500.0) * 0.0005000000237487256526947021484375, 0.0), 1.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _447 = fast::clamp(Material.Material_VectorExpressions[4].xyz, float3(0.0), float3(1.0));
    float _451 = (0.300000011920928955078125 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _452 = in.in_var_PRIMITIVE_ID * 36u;
    uint _453 = _452 + 20u;
    float _502;
    float _503;
    float _504;
    float3 _505;
    float3 _506;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _453)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _471 = ((_247.xy / float2(_247.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _475 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _471, level(0.0));
        float4 _478 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _471, level(0.0));
        float4 _481 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _471, level(0.0));
        float _491 = _481.w;
        _502 = (_451 * _491) + _481.z;
        _503 = (0.5 * _491) + _481.y;
        _504 = _491 + _481.x;
        _505 = (_447 * _475.w) + _475.xyz;
        _506 = normalize((_436 * _478.w) + ((_478.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _502 = _451;
        _503 = 0.5;
        _504 = 1.0;
        _505 = _447;
        _506 = _436;
    }
    float3 _516 = fast::clamp((_256 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _527 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_516.x), int(_516.y), int(_516.z), 0).xyz), 0));
    float3 _542 = (((_527.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_516 / float3(_527.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _555;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _453)].z > 0.0)
    {
        _555 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _542, level(0.0)).x;
    }
    else
    {
        _555 = 1.0;
    }
    float3 _569 = ((_505 - (_505 * _504)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _576 = (mix(float3(0.07999999821186065673828125 * _503), _505, float3(_504)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _579 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _584;
    if (_579)
    {
        _584 = _569 + (_576 * 0.449999988079071044921875);
    }
    else
    {
        _584 = _569;
    }
    float3 _586 = select(_576, float3(0.0), bool3(_579));
    float3 _588 = float3(dot(_586, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _605 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _542, level(0.0));
    float _621 = _605.x;
    float4 _623 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _542, level(0.0)) * 2.0) - float4(1.0)) * _621) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _624 = _605.y;
    float4 _626 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _542, level(0.0)) * 2.0) - float4(1.0)) * _624) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _627 = _605.z;
    float4 _629 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _542, level(0.0)) * 2.0) - float4(1.0)) * _627) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _646 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _542, level(0.0)) * 2.0) - float4(1.0)) * _621) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _648 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _542, level(0.0)) * 2.0) - float4(1.0)) * _624) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _650 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _542, level(0.0)) * 2.0) - float4(1.0)) * _627) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _683 = _186;
    _683.y = (-0.48860299587249755859375) * _506.y;
    float4 _686 = _683;
    _686.z = 0.48860299587249755859375 * _506.z;
    float4 _689 = _686;
    _689.w = (-0.48860299587249755859375) * _506.x;
    float3 _690 = _506 * _506;
    float4 _693 = _183;
    _693.x = (1.09254801273345947265625 * _506.x) * _506.y;
    float4 _696 = _693;
    _696.y = ((-1.09254801273345947265625) * _506.y) * _506.z;
    float4 _701 = _696;
    _701.z = 0.3153919875621795654296875 * ((3.0 * _690.z) - 1.0);
    float4 _704 = _701;
    _704.w = ((-1.09254801273345947265625) * _506.x) * _506.z;
    float4 _708 = _689;
    _708.x = 0.886227548122406005859375;
    float3 _710 = _708.yzw * 2.094395160675048828125;
    float4 _711 = float4(_708.x, _710.x, _710.y, _710.z);
    float4 _712 = _704 * 0.785398185253143310546875;
    float _713 = (_690.x - _690.y) * 0.4290426075458526611328125;
    float3 _719 = float3(0.0);
    _719.x = (dot(float4(_621, _623.xyz), _711) + dot(float4(_623.w, _646.xyz), _712)) + (_646.w * _713);
    float3 _725 = _719;
    _725.y = (dot(float4(_624, _626.xyz), _711) + dot(float4(_626.w, _648.xyz), _712)) + (_648.w * _713);
    float3 _731 = _725;
    _731.z = (dot(float4(_627, _629.xyz), _711) + dot(float4(_629.w, _650.xyz), _712)) + (_650.w * _713);
    float _760;
    float _761;
    float3 _762;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _747 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _542, level(0.0)).xyz * 2.0) - float3(1.0);
        float _748 = length(_747);
        float3 _751 = _747 / float3(fast::max(_748, 9.9999997473787516355514526367188e-05));
        float _752 = 1.0 - _748;
        float _754 = 1.0 - (_752 * _752);
        _760 = mix(fast::clamp(dot(_751, _506), 0.0, 1.0), 1.0, _754);
        _761 = _748;
        _762 = mix(_751, _506, float3(_754));
    }
    else
    {
        _760 = 1.0;
        _761 = 1.0;
        _762 = _506;
    }
    float4 _766 = float4(_762, 1.0);
    float3 _770 = _184;
    _770.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _766);
    float3 _774 = _770;
    _774.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _766);
    float3 _778 = _774;
    _778.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _766);
    float4 _781 = _766.xyzz * _766.yzzx;
    float3 _785 = _184;
    _785.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _781);
    float3 _789 = _785;
    _789.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _781);
    float3 _793 = _789;
    _793.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _781);
    float3 _808 = ((fast::max(float3(0.0), _731) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_778 + _793) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_762.x * _762.x) - (_762.y * _762.y)))) * View.View_SkyLightColor.xyz) * (_761 * _760));
    float3 _830 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _859;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _858;
        if (any(abs(_256 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _452 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _452 + 19u)].xyz + float3(1.0))))
        {
            _858 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_256, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _858 = _830;
        }
        _859 = _858;
    }
    else
    {
        _859 = _830;
    }
    float4 _866 = float4(((mix(float3(0.0), _584 + (_586 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_808 * _584) * fast::max(float3(1.0), ((((((_505 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_505 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_505 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _859) * 1.0, 0.0);
    float4 _873;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _872 = _866;
        _872.w = 0.0;
        _873 = _872;
    }
    else
    {
        _873 = _866;
    }
    float2 _877 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _885 = (_506 * 0.5) + float3(0.5);
    float4 _887 = float4(_885.x, _885.y, _885.z, float4(0.0).w);
    _887.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _453)].y;
    float4 _888 = float4(0.0);
    _888.x = _504;
    float4 _889 = _888;
    _889.y = _503;
    float4 _890 = _889;
    _890.z = _502;
    float4 _891 = _890;
    _891.w = 0.50588238239288330078125;
    float4 _903 = float4(_505.x, _505.y, _505.z, float4(0.0).w);
    _903.w = ((log2(((dot(_808, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_588 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_588 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_588 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_877.xyx * _877.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _873 * View.View_PreExposure;
    out.out_var_SV_Target1 = _887;
    out.out_var_SV_Target2 = _891;
    out.out_var_SV_Target3 = _903;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_555, 1.0, 1.0, 1.0);
    return out;
}

