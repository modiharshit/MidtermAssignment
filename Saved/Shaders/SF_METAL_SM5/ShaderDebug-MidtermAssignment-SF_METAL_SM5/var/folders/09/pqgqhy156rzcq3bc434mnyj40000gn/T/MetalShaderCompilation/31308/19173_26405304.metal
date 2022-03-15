

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
    char _m0_pad[704];
    float4x4 View_SVPositionToTranslatedWorld;
    char _m1_pad[288];
    float4 View_ScreenPositionScaleBias;
    char _m2_pad[48];
    float3 View_PreViewTranslation;
    char _m3_pad[928];
    float4 View_ViewRectMin;
    float4 View_ViewSizeAndInvSize;
    char _m5_pad[68];
    float View_PreExposure;
    float4 View_DiffuseOverrideParameter;
    float4 View_SpecularOverrideParameter;
    float4 View_NormalOverrideParameter;
    float2 View_RoughnessOverrideParameter;
    char _m10_pad[8];
    float View_OutOfBoundsMask;
    char _m11_pad[48];
    float View_MaterialTextureMipBias;
    char _m12_pad[28];
    float View_UnlitViewmodeMask;
    char _m13_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m14_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m15_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m17_pad[124];
    float View_ShowDecalsMask;
    char _m18_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m19_pad[48];
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
    spvUnsafeArray<float4, 2> Material_ScalarExpressions;
};

constant float4 _171 = {};
constant float3 _172 = {};
constant float _174 = {};
constant float4 _175 = {};

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

fragment MainPS_out Main_00004ae5_0192e9b8(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(11)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(12)]], texture2d<float> Material_Texture2D_0 [[texture(13)]], texture2d<float> Material_Texture2D_1 [[texture(14)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _232 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _174, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _237 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _242 = (_237.xyz / float3(_237.w)) - View.View_PreViewTranslation;
    float4 _248 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _251 = (_248.xy * float2(2.0)) - float2(1.0);
    float3 _267 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_251, sqrt(fast::clamp(1.0 - dot(_251, _251), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _278 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _285 = _278.y;
    float3 _300 = fast::clamp(mix(Material.Material_VectorExpressions[4].xyz, Material.Material_VectorExpressions[5].xyz, float3(_285)) * _278.x, float3(0.0), float3(1.0));
    float _301 = fast::clamp(mix(Material.Material_ScalarExpressions[0].y, Material.Material_ScalarExpressions[0].z, _285), 0.0, 1.0);
    float _306 = (fast::clamp(mix(Material.Material_ScalarExpressions[0].w, Material.Material_ScalarExpressions[1].x, _285), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _307 = in.in_var_PRIMITIVE_ID * 36u;
    uint _308 = _307 + 20u;
    float _358;
    float _359;
    float _360;
    float3 _361;
    float3 _362;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _308)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _326 = ((_232.xy / float2(_232.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _330 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _326, level(0.0));
        float4 _333 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _326, level(0.0));
        float4 _336 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _326, level(0.0));
        float _346 = _336.w;
        _358 = (_306 * _346) + _336.z;
        _359 = (0.5 * _346) + _336.y;
        _360 = (_301 * _346) + _336.x;
        _361 = (_300 * _330.w) + _330.xyz;
        _362 = normalize((_267 * _333.w) + ((_333.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _358 = _306;
        _359 = 0.5;
        _360 = _301;
        _361 = _300;
        _362 = _267;
    }
    float3 _372 = fast::clamp((_242 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _383 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_372.x), int(_372.y), int(_372.z), 0).xyz), 0));
    float3 _398 = (((_383.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_372 / float3(_383.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _411;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _308)].z > 0.0)
    {
        _411 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _398, level(0.0)).x;
    }
    else
    {
        _411 = 1.0;
    }
    float3 _425 = ((_361 - (_361 * _360)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _432 = (mix(float3(0.07999999821186065673828125 * _359), _361, float3(_360)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _435 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _440;
    if (_435)
    {
        _440 = _425 + (_432 * 0.449999988079071044921875);
    }
    else
    {
        _440 = _425;
    }
    float3 _442 = select(_432, float3(0.0), bool3(_435));
    float3 _444 = float3(dot(_442, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _461 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _398, level(0.0));
    float _477 = _461.x;
    float4 _479 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _398, level(0.0)) * 2.0) - float4(1.0)) * _477) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _480 = _461.y;
    float4 _482 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _398, level(0.0)) * 2.0) - float4(1.0)) * _480) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _483 = _461.z;
    float4 _485 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _398, level(0.0)) * 2.0) - float4(1.0)) * _483) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _502 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _398, level(0.0)) * 2.0) - float4(1.0)) * _477) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _504 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _398, level(0.0)) * 2.0) - float4(1.0)) * _480) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _506 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _398, level(0.0)) * 2.0) - float4(1.0)) * _483) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _539 = _175;
    _539.y = (-0.48860299587249755859375) * _362.y;
    float4 _542 = _539;
    _542.z = 0.48860299587249755859375 * _362.z;
    float4 _545 = _542;
    _545.w = (-0.48860299587249755859375) * _362.x;
    float3 _546 = _362 * _362;
    float4 _549 = _171;
    _549.x = (1.09254801273345947265625 * _362.x) * _362.y;
    float4 _552 = _549;
    _552.y = ((-1.09254801273345947265625) * _362.y) * _362.z;
    float4 _557 = _552;
    _557.z = 0.3153919875621795654296875 * ((3.0 * _546.z) - 1.0);
    float4 _560 = _557;
    _560.w = ((-1.09254801273345947265625) * _362.x) * _362.z;
    float4 _564 = _545;
    _564.x = 0.886227548122406005859375;
    float3 _566 = _564.yzw * 2.094395160675048828125;
    float4 _567 = float4(_564.x, _566.x, _566.y, _566.z);
    float4 _568 = _560 * 0.785398185253143310546875;
    float _569 = (_546.x - _546.y) * 0.4290426075458526611328125;
    float3 _575 = float3(0.0);
    _575.x = (dot(float4(_477, _479.xyz), _567) + dot(float4(_479.w, _502.xyz), _568)) + (_502.w * _569);
    float3 _581 = _575;
    _581.y = (dot(float4(_480, _482.xyz), _567) + dot(float4(_482.w, _504.xyz), _568)) + (_504.w * _569);
    float3 _587 = _581;
    _587.z = (dot(float4(_483, _485.xyz), _567) + dot(float4(_485.w, _506.xyz), _568)) + (_506.w * _569);
    float _616;
    float _617;
    float3 _618;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _603 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _398, level(0.0)).xyz * 2.0) - float3(1.0);
        float _604 = length(_603);
        float3 _607 = _603 / float3(fast::max(_604, 9.9999997473787516355514526367188e-05));
        float _608 = 1.0 - _604;
        float _610 = 1.0 - (_608 * _608);
        _616 = mix(fast::clamp(dot(_607, _362), 0.0, 1.0), 1.0, _610);
        _617 = _604;
        _618 = mix(_607, _362, float3(_610));
    }
    else
    {
        _616 = 1.0;
        _617 = 1.0;
        _618 = _362;
    }
    float4 _622 = float4(_618, 1.0);
    float3 _626 = _172;
    _626.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _622);
    float3 _630 = _626;
    _630.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _622);
    float3 _634 = _630;
    _634.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _622);
    float4 _637 = _622.xyzz * _622.yzzx;
    float3 _641 = _172;
    _641.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _637);
    float3 _645 = _641;
    _645.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _637);
    float3 _649 = _645;
    _649.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _637);
    float3 _664 = ((fast::max(float3(0.0), _587) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_634 + _649) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_618.x * _618.x) - (_618.y * _618.y)))) * View.View_SkyLightColor.xyz) * (_617 * _616));
    float3 _686 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _715;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _714;
        if (any(abs(_242 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _307 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _307 + 19u)].xyz + float3(1.0))))
        {
            _714 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_242, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _714 = _686;
        }
        _715 = _714;
    }
    else
    {
        _715 = _686;
    }
    float4 _722 = float4(((mix(float3(0.0), _440 + (_442 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_664 * _440) * fast::max(float3(1.0), ((((((_361 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_361 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_361 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _715) * 1.0, 0.0);
    float4 _729;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _728 = _722;
        _728.w = 0.0;
        _729 = _728;
    }
    else
    {
        _729 = _722;
    }
    float2 _733 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _741 = (_362 * 0.5) + float3(0.5);
    float4 _743 = float4(_741.x, _741.y, _741.z, float4(0.0).w);
    _743.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _308)].y;
    float4 _744 = float4(0.0);
    _744.x = _360;
    float4 _745 = _744;
    _745.y = _359;
    float4 _746 = _745;
    _746.z = _358;
    float4 _747 = _746;
    _747.w = 0.50588238239288330078125;
    float4 _759 = float4(_361.x, _361.y, _361.z, float4(0.0).w);
    _759.w = ((log2(((dot(_664, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_444 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_444 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_444 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_733.xyx * _733.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _729 * View.View_PreExposure;
    out.out_var_SV_Target1 = _743;
    out.out_var_SV_Target2 = _747;
    out.out_var_SV_Target3 = _759;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_411, 1.0, 1.0, 1.0);
    return out;
}

