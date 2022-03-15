

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

constant float4 _186 = {};
constant float3 _187 = {};
constant float4 _189 = {};

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

fragment MainPS_out Main_00005444_54747a13(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(11)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(12)]], texture2d<float> Material_Texture2D_0 [[texture(13)]], texture2d<float> Material_Texture2D_1 [[texture(14)]], texture2d<float> Material_Texture2D_2 [[texture(15)]], texture2d<float> Material_Texture2D_3 [[texture(16)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _249 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _253 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _258 = (_253.xyz / float3(_253.w)) - View.View_PreViewTranslation;
    float2 _259 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.25;
    float4 _265 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _259, bias(View.View_MaterialTextureMipBias));
    float2 _268 = (_265.xy * float2(2.0)) - float2(1.0);
    float2 _276 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.3499999940395355224609375;
    float4 _278 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _276, bias(View.View_MaterialTextureMipBias));
    float2 _281 = (_278.xy * float2(2.0)) - float2(1.0);
    float4 _293 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _298 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _303 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _307 = (_293.x + 0.5) * ((_298.x + 0.5) * (_303.x + 0.5));
    float _310 = fast::min(fast::max(mix(-2.0, 0.699999988079071044921875, _307), 0.0), 1.0);
    float3 _313 = float3(_310);
    float4 _319 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _346;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _346 = _249.w;
                break;
            }
            else
            {
                float _330 = _249.z;
                _346 = ((_330 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_330 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _361 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(mix(float4(_268, sqrt(fast::clamp(1.0 - dot(_268, _268), 0.0, 1.0)), 1.0).xyz, float4(_281, sqrt(fast::clamp(1.0 - dot(_281, _281), 0.0, 1.0)), 1.0).xyz, _313), float3(0.0, 0.0, 1.0), float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _319.x) + _346) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _374 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _259, bias(View.View_MaterialTextureMipBias));
    float4 _376 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _276, bias(View.View_MaterialTextureMipBias));
    float3 _386 = fast::clamp(mix(float3(0.6349999904632568359375), float3(1.0), float3(_307)) * mix(_374.xyz, _376.xyz, _313), float3(0.0), float3(1.0));
    float _391 = (fast::clamp(mix(0.800000011920928955078125, 0.300000011920928955078125, _307 * mix(_374.w, _376.w, _310)), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _392 = in.in_var_PRIMITIVE_ID * 36u;
    uint _393 = _392 + 20u;
    float _441;
    float _442;
    float _443;
    float3 _444;
    float3 _445;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _393)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _411 = ((_249.xy / float2(_249.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _415 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _411, level(0.0));
        float4 _418 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _411, level(0.0));
        float4 _421 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _411, level(0.0));
        float _431 = _421.w;
        _441 = (_391 * _431) + _421.z;
        _442 = (0.5 * _431) + _421.y;
        _443 = _421.x;
        _444 = (_386 * _415.w) + _415.xyz;
        _445 = normalize((_361 * _418.w) + ((_418.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _441 = _391;
        _442 = 0.5;
        _443 = 0.0;
        _444 = _386;
        _445 = _361;
    }
    float3 _455 = fast::clamp((_258 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _466 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_455.x), int(_455.y), int(_455.z), 0).xyz), 0));
    float3 _481 = (((_466.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_455 / float3(_466.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _494;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _393)].z > 0.0)
    {
        _494 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _481, level(0.0)).x;
    }
    else
    {
        _494 = 1.0;
    }
    float3 _508 = ((_444 - (_444 * _443)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _515 = (mix(float3(0.07999999821186065673828125 * _442), _444, float3(_443)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _518 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _523;
    if (_518)
    {
        _523 = _508 + (_515 * 0.449999988079071044921875);
    }
    else
    {
        _523 = _508;
    }
    float3 _525 = select(_515, float3(0.0), bool3(_518));
    float3 _527 = float3(dot(_525, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _544 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _481, level(0.0));
    float _560 = _544.x;
    float4 _562 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _481, level(0.0)) * 2.0) - float4(1.0)) * _560) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _563 = _544.y;
    float4 _565 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _481, level(0.0)) * 2.0) - float4(1.0)) * _563) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _566 = _544.z;
    float4 _568 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _481, level(0.0)) * 2.0) - float4(1.0)) * _566) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _585 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _481, level(0.0)) * 2.0) - float4(1.0)) * _560) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _587 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _481, level(0.0)) * 2.0) - float4(1.0)) * _563) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _589 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _481, level(0.0)) * 2.0) - float4(1.0)) * _566) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _622 = _189;
    _622.y = (-0.48860299587249755859375) * _445.y;
    float4 _625 = _622;
    _625.z = 0.48860299587249755859375 * _445.z;
    float4 _628 = _625;
    _628.w = (-0.48860299587249755859375) * _445.x;
    float3 _629 = _445 * _445;
    float4 _632 = _186;
    _632.x = (1.09254801273345947265625 * _445.x) * _445.y;
    float4 _635 = _632;
    _635.y = ((-1.09254801273345947265625) * _445.y) * _445.z;
    float4 _640 = _635;
    _640.z = 0.3153919875621795654296875 * ((3.0 * _629.z) - 1.0);
    float4 _643 = _640;
    _643.w = ((-1.09254801273345947265625) * _445.x) * _445.z;
    float4 _647 = _628;
    _647.x = 0.886227548122406005859375;
    float3 _649 = _647.yzw * 2.094395160675048828125;
    float4 _650 = float4(_647.x, _649.x, _649.y, _649.z);
    float4 _651 = _643 * 0.785398185253143310546875;
    float _652 = (_629.x - _629.y) * 0.4290426075458526611328125;
    float3 _658 = float3(0.0);
    _658.x = (dot(float4(_560, _562.xyz), _650) + dot(float4(_562.w, _585.xyz), _651)) + (_585.w * _652);
    float3 _664 = _658;
    _664.y = (dot(float4(_563, _565.xyz), _650) + dot(float4(_565.w, _587.xyz), _651)) + (_587.w * _652);
    float3 _670 = _664;
    _670.z = (dot(float4(_566, _568.xyz), _650) + dot(float4(_568.w, _589.xyz), _651)) + (_589.w * _652);
    float _699;
    float _700;
    float3 _701;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _686 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _481, level(0.0)).xyz * 2.0) - float3(1.0);
        float _687 = length(_686);
        float3 _690 = _686 / float3(fast::max(_687, 9.9999997473787516355514526367188e-05));
        float _691 = 1.0 - _687;
        float _693 = 1.0 - (_691 * _691);
        _699 = mix(fast::clamp(dot(_690, _445), 0.0, 1.0), 1.0, _693);
        _700 = _687;
        _701 = mix(_690, _445, float3(_693));
    }
    else
    {
        _699 = 1.0;
        _700 = 1.0;
        _701 = _445;
    }
    float4 _705 = float4(_701, 1.0);
    float3 _709 = _187;
    _709.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _705);
    float3 _713 = _709;
    _713.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _705);
    float3 _717 = _713;
    _717.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _705);
    float4 _720 = _705.xyzz * _705.yzzx;
    float3 _724 = _187;
    _724.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _720);
    float3 _728 = _724;
    _728.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _720);
    float3 _732 = _728;
    _732.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _720);
    float3 _747 = ((fast::max(float3(0.0), _670) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_717 + _732) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_701.x * _701.x) - (_701.y * _701.y)))) * View.View_SkyLightColor.xyz) * (_700 * _699));
    float3 _769 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _798;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _797;
        if (any(abs(_258 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _392 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _392 + 19u)].xyz + float3(1.0))))
        {
            _797 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_258, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _797 = _769;
        }
        _798 = _797;
    }
    else
    {
        _798 = _769;
    }
    float4 _805 = float4(((mix(float3(0.0), _523 + (_525 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_747 * _523) * fast::max(float3(1.0), ((((((_444 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_444 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_444 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _798) * 1.0, 0.0);
    float4 _812;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _811 = _805;
        _811.w = 0.0;
        _812 = _811;
    }
    else
    {
        _812 = _805;
    }
    float2 _816 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _824 = (_445 * 0.5) + float3(0.5);
    float4 _826 = float4(_824.x, _824.y, _824.z, float4(0.0).w);
    _826.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _393)].y;
    float4 _827 = float4(0.0);
    _827.x = _443;
    float4 _828 = _827;
    _828.y = _442;
    float4 _829 = _828;
    _829.z = _441;
    float4 _830 = _829;
    _830.w = 0.50588238239288330078125;
    float4 _842 = float4(_444.x, _444.y, _444.z, float4(0.0).w);
    _842.w = ((log2(((dot(_747, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_527 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_527 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_527 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_816.xyx * _816.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _812 * View.View_PreExposure;
    out.out_var_SV_Target1 = _826;
    out.out_var_SV_Target2 = _830;
    out.out_var_SV_Target3 = _842;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_494, 1.0, 1.0, 1.0);
    return out;
}

