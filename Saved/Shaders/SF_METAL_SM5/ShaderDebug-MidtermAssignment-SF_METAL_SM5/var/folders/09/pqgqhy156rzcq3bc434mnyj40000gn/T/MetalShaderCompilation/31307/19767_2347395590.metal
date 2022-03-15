

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
    spvUnsafeArray<float4, 4> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _173 = {};
constant float3 _174 = {};
constant float _176 = {};
constant float4 _177 = {};

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

fragment MainPS_out Main_00004d37_8bea6a06(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(11)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(12)]], texture2d<float> Material_Texture2D_0 [[texture(13)]], texture2d<float> Material_Texture2D_1 [[texture(14)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float3x3 _223 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _234 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _176, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _239 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _243 = _239.xyz / float3(_239.w);
    float3 _244 = _243 - View.View_PreViewTranslation;
    float4 _253 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _259 = ((normalize(-_243) * _223).xy * ((0.0500000007450580596923828125 * _253.z) + (-0.02500000037252902984619140625))) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _263 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _259, bias(View.View_MaterialTextureMipBias));
    float2 _266 = (_263.xy * float2(2.0)) - float2(1.0);
    float _273 = sqrt(fast::clamp(1.0 - dot(_266, _266), 0.0, 1.0)) + 1.0;
    float4 _276 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 8.0), bias(View.View_MaterialTextureMipBias));
    float2 _279 = (_276.xy * float2(2.0)) - float2(1.0);
    float4 _288 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _259, bias(View.View_MaterialTextureMipBias));
    float _290 = _288.y;
    float3 _292 = mix(float4(_279, sqrt(fast::clamp(1.0 - dot(_279, _279), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), float3(_290));
    float3 _295 = float3(_266, _273);
    float3 _299 = float3(_292.xy * (-1.0), _292.z);
    float3 _311 = normalize(_223 * normalize((((_295 * dot(_295, _299)) - (_299 * _273)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _325 = fast::clamp(Material.Material_VectorExpressions[3].xyz * _288.x, float3(0.0), float3(1.0));
    float _326 = fast::clamp(mix(1.0, 0.0, _290), 0.0, 1.0);
    float _330 = (0.300000011920928955078125 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _331 = in.in_var_PRIMITIVE_ID * 36u;
    uint _332 = _331 + 20u;
    float _382;
    float _383;
    float _384;
    float3 _385;
    float3 _386;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _332)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _350 = ((_234.xy / float2(_234.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _354 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _350, level(0.0));
        float4 _357 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _350, level(0.0));
        float4 _360 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _350, level(0.0));
        float _370 = _360.w;
        _382 = (_330 * _370) + _360.z;
        _383 = (0.5 * _370) + _360.y;
        _384 = (_326 * _370) + _360.x;
        _385 = (_325 * _354.w) + _354.xyz;
        _386 = normalize((_311 * _357.w) + ((_357.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _382 = _330;
        _383 = 0.5;
        _384 = _326;
        _385 = _325;
        _386 = _311;
    }
    float3 _396 = fast::clamp((_244 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _407 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_396.x), int(_396.y), int(_396.z), 0).xyz), 0));
    float3 _422 = (((_407.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_396 / float3(_407.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _435;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _332)].z > 0.0)
    {
        _435 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _422, level(0.0)).x;
    }
    else
    {
        _435 = 1.0;
    }
    float3 _449 = ((_385 - (_385 * _384)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _456 = (mix(float3(0.07999999821186065673828125 * _383), _385, float3(_384)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _459 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _464;
    if (_459)
    {
        _464 = _449 + (_456 * 0.449999988079071044921875);
    }
    else
    {
        _464 = _449;
    }
    float3 _466 = select(_456, float3(0.0), bool3(_459));
    float3 _468 = float3(dot(_466, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _485 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _422, level(0.0));
    float _501 = _485.x;
    float4 _503 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _422, level(0.0)) * 2.0) - float4(1.0)) * _501) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _504 = _485.y;
    float4 _506 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _422, level(0.0)) * 2.0) - float4(1.0)) * _504) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _507 = _485.z;
    float4 _509 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _422, level(0.0)) * 2.0) - float4(1.0)) * _507) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _526 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _422, level(0.0)) * 2.0) - float4(1.0)) * _501) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _528 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _422, level(0.0)) * 2.0) - float4(1.0)) * _504) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _530 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _422, level(0.0)) * 2.0) - float4(1.0)) * _507) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _563 = _177;
    _563.y = (-0.48860299587249755859375) * _386.y;
    float4 _566 = _563;
    _566.z = 0.48860299587249755859375 * _386.z;
    float4 _569 = _566;
    _569.w = (-0.48860299587249755859375) * _386.x;
    float3 _570 = _386 * _386;
    float4 _573 = _173;
    _573.x = (1.09254801273345947265625 * _386.x) * _386.y;
    float4 _576 = _573;
    _576.y = ((-1.09254801273345947265625) * _386.y) * _386.z;
    float4 _581 = _576;
    _581.z = 0.3153919875621795654296875 * ((3.0 * _570.z) - 1.0);
    float4 _584 = _581;
    _584.w = ((-1.09254801273345947265625) * _386.x) * _386.z;
    float4 _588 = _569;
    _588.x = 0.886227548122406005859375;
    float3 _590 = _588.yzw * 2.094395160675048828125;
    float4 _591 = float4(_588.x, _590.x, _590.y, _590.z);
    float4 _592 = _584 * 0.785398185253143310546875;
    float _593 = (_570.x - _570.y) * 0.4290426075458526611328125;
    float3 _599 = float3(0.0);
    _599.x = (dot(float4(_501, _503.xyz), _591) + dot(float4(_503.w, _526.xyz), _592)) + (_526.w * _593);
    float3 _605 = _599;
    _605.y = (dot(float4(_504, _506.xyz), _591) + dot(float4(_506.w, _528.xyz), _592)) + (_528.w * _593);
    float3 _611 = _605;
    _611.z = (dot(float4(_507, _509.xyz), _591) + dot(float4(_509.w, _530.xyz), _592)) + (_530.w * _593);
    float _640;
    float _641;
    float3 _642;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _627 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _422, level(0.0)).xyz * 2.0) - float3(1.0);
        float _628 = length(_627);
        float3 _631 = _627 / float3(fast::max(_628, 9.9999997473787516355514526367188e-05));
        float _632 = 1.0 - _628;
        float _634 = 1.0 - (_632 * _632);
        _640 = mix(fast::clamp(dot(_631, _386), 0.0, 1.0), 1.0, _634);
        _641 = _628;
        _642 = mix(_631, _386, float3(_634));
    }
    else
    {
        _640 = 1.0;
        _641 = 1.0;
        _642 = _386;
    }
    float4 _646 = float4(_642, 1.0);
    float3 _650 = _174;
    _650.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _646);
    float3 _654 = _650;
    _654.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _646);
    float3 _658 = _654;
    _658.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _646);
    float4 _661 = _646.xyzz * _646.yzzx;
    float3 _665 = _174;
    _665.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _661);
    float3 _669 = _665;
    _669.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _661);
    float3 _673 = _669;
    _673.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _661);
    float3 _688 = ((fast::max(float3(0.0), _611) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_658 + _673) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_642.x * _642.x) - (_642.y * _642.y)))) * View.View_SkyLightColor.xyz) * (_641 * _640));
    float3 _710 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _739;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _738;
        if (any(abs(_244 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _331 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _331 + 19u)].xyz + float3(1.0))))
        {
            _738 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_244, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _738 = _710;
        }
        _739 = _738;
    }
    else
    {
        _739 = _710;
    }
    float4 _746 = float4(((mix(float3(0.0), _464 + (_466 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_688 * _464) * fast::max(float3(1.0), ((((((_385 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_385 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_385 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _739) * 1.0, 0.0);
    float4 _753;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _752 = _746;
        _752.w = 0.0;
        _753 = _752;
    }
    else
    {
        _753 = _746;
    }
    float2 _757 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _765 = (_386 * 0.5) + float3(0.5);
    float4 _767 = float4(_765.x, _765.y, _765.z, float4(0.0).w);
    _767.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _332)].y;
    float4 _768 = float4(0.0);
    _768.x = _384;
    float4 _769 = _768;
    _769.y = _383;
    float4 _770 = _769;
    _770.z = _382;
    float4 _771 = _770;
    _771.w = 0.50588238239288330078125;
    float4 _783 = float4(_385.x, _385.y, _385.z, float4(0.0).w);
    _783.w = ((log2(((dot(_688, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_468 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_468 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_468 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_757.xyx * _757.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _753 * View.View_PreExposure;
    out.out_var_SV_Target1 = _767;
    out.out_var_SV_Target2 = _771;
    out.out_var_SV_Target3 = _783;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_435, 1.0, 1.0, 1.0);
    return out;
}

