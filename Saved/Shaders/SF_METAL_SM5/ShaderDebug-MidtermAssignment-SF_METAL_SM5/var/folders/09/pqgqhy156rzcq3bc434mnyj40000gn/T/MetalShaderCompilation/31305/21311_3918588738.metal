

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

fragment MainPS_out Main_0000533f_e990eb42(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(11)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(12)]], texture2d<float> Material_Texture2D_0 [[texture(13)]], texture2d<float> Material_Texture2D_1 [[texture(14)]], texture2d<float> Material_Texture2D_2 [[texture(15)]], texture2d<float> Material_Texture2D_3 [[texture(16)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _247 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _251 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _256 = (_251.xyz / float3(_251.w)) - View.View_PreViewTranslation;
    float2 _257 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.300000011920928955078125;
    float4 _263 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _257, bias(View.View_MaterialTextureMipBias));
    float2 _266 = (_263.xy * float2(2.0)) - float2(1.0);
    float2 _274 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.20000000298023223876953125;
    float4 _276 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _274, bias(View.View_MaterialTextureMipBias));
    float2 _279 = (_276.xy * float2(2.0)) - float2(1.0);
    float4 _291 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.008000000379979610443115234375), bias(View.View_MaterialTextureMipBias));
    float4 _296 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.004999999888241291046142578125), bias(View.View_MaterialTextureMipBias));
    float _298 = (_291.x + 0.5) * _296.x;
    float _300 = fast::min(fast::max(_298, 0.0), 1.0);
    float3 _303 = float3(_300);
    float4 _309 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _336;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _336 = _247.w;
                break;
            }
            else
            {
                float _320 = _247.z;
                _336 = ((_320 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_320 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _351 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(mix(float4(_266, sqrt(fast::clamp(1.0 - dot(_266, _266), 0.0, 1.0)), 1.0).xyz, float4(_279, sqrt(fast::clamp(1.0 - dot(_279, _279), 0.0, 1.0)), 1.0).xyz, _303), float3(0.0, 0.0, 1.0), float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _309.x) + _336) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _363 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _257, bias(View.View_MaterialTextureMipBias));
    float4 _365 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _274, bias(View.View_MaterialTextureMipBias));
    float3 _375 = fast::clamp(mix(_363.xyz, _365.xyz, _303) * mix(0.60000002384185791015625, 1.0, _298), float3(0.0), float3(1.0));
    float _380 = (fast::clamp(mix(0.949999988079071044921875, 0.699999988079071044921875, _298 * mix(_363.w, _365.w, _300)), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _381 = in.in_var_PRIMITIVE_ID * 36u;
    uint _382 = _381 + 20u;
    float _430;
    float _431;
    float _432;
    float3 _433;
    float3 _434;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _382)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _400 = ((_247.xy / float2(_247.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _404 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _400, level(0.0));
        float4 _407 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _400, level(0.0));
        float4 _410 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _400, level(0.0));
        float _420 = _410.w;
        _430 = (_380 * _420) + _410.z;
        _431 = (0.5 * _420) + _410.y;
        _432 = _410.x;
        _433 = (_375 * _404.w) + _404.xyz;
        _434 = normalize((_351 * _407.w) + ((_407.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _430 = _380;
        _431 = 0.5;
        _432 = 0.0;
        _433 = _375;
        _434 = _351;
    }
    float3 _444 = fast::clamp((_256 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _455 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_444.x), int(_444.y), int(_444.z), 0).xyz), 0));
    float3 _470 = (((_455.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_444 / float3(_455.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _483;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _382)].z > 0.0)
    {
        _483 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _470, level(0.0)).x;
    }
    else
    {
        _483 = 1.0;
    }
    float3 _497 = ((_433 - (_433 * _432)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _504 = (mix(float3(0.07999999821186065673828125 * _431), _433, float3(_432)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _507 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _512;
    if (_507)
    {
        _512 = _497 + (_504 * 0.449999988079071044921875);
    }
    else
    {
        _512 = _497;
    }
    float3 _514 = select(_504, float3(0.0), bool3(_507));
    float3 _516 = float3(dot(_514, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _533 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _470, level(0.0));
    float _549 = _533.x;
    float4 _551 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _470, level(0.0)) * 2.0) - float4(1.0)) * _549) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _552 = _533.y;
    float4 _554 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _470, level(0.0)) * 2.0) - float4(1.0)) * _552) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _555 = _533.z;
    float4 _557 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _470, level(0.0)) * 2.0) - float4(1.0)) * _555) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _574 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _470, level(0.0)) * 2.0) - float4(1.0)) * _549) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _576 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _470, level(0.0)) * 2.0) - float4(1.0)) * _552) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _578 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _470, level(0.0)) * 2.0) - float4(1.0)) * _555) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _611 = _187;
    _611.y = (-0.48860299587249755859375) * _434.y;
    float4 _614 = _611;
    _614.z = 0.48860299587249755859375 * _434.z;
    float4 _617 = _614;
    _617.w = (-0.48860299587249755859375) * _434.x;
    float3 _618 = _434 * _434;
    float4 _621 = _184;
    _621.x = (1.09254801273345947265625 * _434.x) * _434.y;
    float4 _624 = _621;
    _624.y = ((-1.09254801273345947265625) * _434.y) * _434.z;
    float4 _629 = _624;
    _629.z = 0.3153919875621795654296875 * ((3.0 * _618.z) - 1.0);
    float4 _632 = _629;
    _632.w = ((-1.09254801273345947265625) * _434.x) * _434.z;
    float4 _636 = _617;
    _636.x = 0.886227548122406005859375;
    float3 _638 = _636.yzw * 2.094395160675048828125;
    float4 _639 = float4(_636.x, _638.x, _638.y, _638.z);
    float4 _640 = _632 * 0.785398185253143310546875;
    float _641 = (_618.x - _618.y) * 0.4290426075458526611328125;
    float3 _647 = float3(0.0);
    _647.x = (dot(float4(_549, _551.xyz), _639) + dot(float4(_551.w, _574.xyz), _640)) + (_574.w * _641);
    float3 _653 = _647;
    _653.y = (dot(float4(_552, _554.xyz), _639) + dot(float4(_554.w, _576.xyz), _640)) + (_576.w * _641);
    float3 _659 = _653;
    _659.z = (dot(float4(_555, _557.xyz), _639) + dot(float4(_557.w, _578.xyz), _640)) + (_578.w * _641);
    float _688;
    float _689;
    float3 _690;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _675 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _470, level(0.0)).xyz * 2.0) - float3(1.0);
        float _676 = length(_675);
        float3 _679 = _675 / float3(fast::max(_676, 9.9999997473787516355514526367188e-05));
        float _680 = 1.0 - _676;
        float _682 = 1.0 - (_680 * _680);
        _688 = mix(fast::clamp(dot(_679, _434), 0.0, 1.0), 1.0, _682);
        _689 = _676;
        _690 = mix(_679, _434, float3(_682));
    }
    else
    {
        _688 = 1.0;
        _689 = 1.0;
        _690 = _434;
    }
    float4 _694 = float4(_690, 1.0);
    float3 _698 = _185;
    _698.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _694);
    float3 _702 = _698;
    _702.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _694);
    float3 _706 = _702;
    _706.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _694);
    float4 _709 = _694.xyzz * _694.yzzx;
    float3 _713 = _185;
    _713.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _709);
    float3 _717 = _713;
    _717.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _709);
    float3 _721 = _717;
    _721.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _709);
    float3 _736 = ((fast::max(float3(0.0), _659) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_706 + _721) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_690.x * _690.x) - (_690.y * _690.y)))) * View.View_SkyLightColor.xyz) * (_689 * _688));
    float3 _758 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _787;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _786;
        if (any(abs(_256 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _381 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _381 + 19u)].xyz + float3(1.0))))
        {
            _786 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_256, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _786 = _758;
        }
        _787 = _786;
    }
    else
    {
        _787 = _758;
    }
    float4 _794 = float4(((mix(float3(0.0), _512 + (_514 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_736 * _512) * fast::max(float3(1.0), ((((((_433 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_433 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_433 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _787) * 1.0, 0.0);
    float4 _801;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _800 = _794;
        _800.w = 0.0;
        _801 = _800;
    }
    else
    {
        _801 = _794;
    }
    float2 _805 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _813 = (_434 * 0.5) + float3(0.5);
    float4 _815 = float4(_813.x, _813.y, _813.z, float4(0.0).w);
    _815.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _382)].y;
    float4 _816 = float4(0.0);
    _816.x = _432;
    float4 _817 = _816;
    _817.y = _431;
    float4 _818 = _817;
    _818.z = _430;
    float4 _819 = _818;
    _819.w = 0.50588238239288330078125;
    float4 _831 = float4(_433.x, _433.y, _433.z, float4(0.0).w);
    _831.w = ((log2(((dot(_736, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_516 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_516 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_516 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_805.xyx * _805.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _801 * View.View_PreExposure;
    out.out_var_SV_Target1 = _815;
    out.out_var_SV_Target2 = _819;
    out.out_var_SV_Target3 = _831;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_483, 1.0, 1.0, 1.0);
    return out;
}

