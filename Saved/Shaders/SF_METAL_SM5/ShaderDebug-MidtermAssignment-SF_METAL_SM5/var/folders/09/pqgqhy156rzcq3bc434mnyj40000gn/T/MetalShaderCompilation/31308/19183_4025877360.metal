

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
    char _m17_pad[188];
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
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _183 = {};
constant float4 _185 = {};

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

fragment MainPS_out Main_00004aef_eff60370(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(11)]], texture2d<float> Material_Texture2D_0 [[texture(12)]], texture2d<float> Material_Texture2D_1 [[texture(13)]], texture2d<float> Material_Texture2D_2 [[texture(14)]], texture2d<float> Material_Texture2D_3 [[texture(15)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _242 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _246 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _251 = (_246.xyz / float3(_246.w)) - View.View_PreViewTranslation;
    float2 _252 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.25;
    float4 _258 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _252, bias(View.View_MaterialTextureMipBias));
    float2 _261 = (_258.xy * float2(2.0)) - float2(1.0);
    float2 _269 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.3499999940395355224609375;
    float4 _271 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _269, bias(View.View_MaterialTextureMipBias));
    float2 _274 = (_271.xy * float2(2.0)) - float2(1.0);
    float4 _286 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _291 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _296 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _300 = (_286.x + 0.5) * ((_291.x + 0.5) * (_296.x + 0.5));
    float _303 = fast::min(fast::max(mix(-2.0, 0.699999988079071044921875, _300), 0.0), 1.0);
    float3 _306 = float3(_303);
    float4 _312 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _339;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _339 = _242.w;
                break;
            }
            else
            {
                float _323 = _242.z;
                _339 = ((_323 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_323 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _354 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(mix(float4(_261, sqrt(fast::clamp(1.0 - dot(_261, _261), 0.0, 1.0)), 1.0).xyz, float4(_274, sqrt(fast::clamp(1.0 - dot(_274, _274), 0.0, 1.0)), 1.0).xyz, _306), float3(0.0, 0.0, 1.0), float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _312.x) + _339) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _367 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _252, bias(View.View_MaterialTextureMipBias));
    float4 _369 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _269, bias(View.View_MaterialTextureMipBias));
    float3 _378 = fast::clamp(mix(float3(0.6349999904632568359375), float3(1.0), float3(_300)) * mix(_367.xyz, _369.xyz, _306), float3(0.0), float3(1.0));
    float _383 = (fast::clamp(mix(0.800000011920928955078125, 0.20000000298023223876953125, mix(_367.w, _369.w, _303)), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _384 = in.in_var_PRIMITIVE_ID * 36u;
    uint _385 = _384 + 20u;
    float _433;
    float _434;
    float _435;
    float3 _436;
    float3 _437;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _385)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _403 = ((_242.xy / float2(_242.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _407 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _403, level(0.0));
        float4 _410 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _403, level(0.0));
        float4 _413 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _403, level(0.0));
        float _423 = _413.w;
        _433 = (_383 * _423) + _413.z;
        _434 = (0.5 * _423) + _413.y;
        _435 = _413.x;
        _436 = (_378 * _407.w) + _407.xyz;
        _437 = normalize((_354 * _410.w) + ((_410.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _433 = _383;
        _434 = 0.5;
        _435 = 0.0;
        _436 = _378;
        _437 = _354;
    }
    float3 _447 = fast::clamp((_251 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _458 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_447.x), int(_447.y), int(_447.z), 0).xyz), 0));
    float3 _473 = (((_458.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_447 / float3(_458.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _486;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _385)].z > 0.0)
    {
        _486 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _473, level(0.0)).x;
    }
    else
    {
        _486 = 1.0;
    }
    float3 _500 = ((_436 - (_436 * _435)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _507 = (mix(float3(0.07999999821186065673828125 * _434), _436, float3(_435)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _510 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _515;
    if (_510)
    {
        _515 = _500 + (_507 * 0.449999988079071044921875);
    }
    else
    {
        _515 = _500;
    }
    float3 _517 = select(_507, float3(0.0), bool3(_510));
    float3 _519 = float3(dot(_517, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _536 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _473, level(0.0));
    float _552 = _536.x;
    float4 _554 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _473, level(0.0)) * 2.0) - float4(1.0)) * _552) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _555 = _536.y;
    float4 _557 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _473, level(0.0)) * 2.0) - float4(1.0)) * _555) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _558 = _536.z;
    float4 _560 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _473, level(0.0)) * 2.0) - float4(1.0)) * _558) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _577 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _473, level(0.0)) * 2.0) - float4(1.0)) * _552) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _579 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _473, level(0.0)) * 2.0) - float4(1.0)) * _555) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _581 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _473, level(0.0)) * 2.0) - float4(1.0)) * _558) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _614 = _185;
    _614.y = (-0.48860299587249755859375) * _437.y;
    float4 _617 = _614;
    _617.z = 0.48860299587249755859375 * _437.z;
    float4 _620 = _617;
    _620.w = (-0.48860299587249755859375) * _437.x;
    float3 _621 = _437 * _437;
    float4 _624 = _183;
    _624.x = (1.09254801273345947265625 * _437.x) * _437.y;
    float4 _627 = _624;
    _627.y = ((-1.09254801273345947265625) * _437.y) * _437.z;
    float4 _632 = _627;
    _632.z = 0.3153919875621795654296875 * ((3.0 * _621.z) - 1.0);
    float4 _635 = _632;
    _635.w = ((-1.09254801273345947265625) * _437.x) * _437.z;
    float4 _639 = _620;
    _639.x = 0.886227548122406005859375;
    float3 _641 = _639.yzw * 2.094395160675048828125;
    float4 _642 = float4(_639.x, _641.x, _641.y, _641.z);
    float4 _643 = _635 * 0.785398185253143310546875;
    float _644 = (_621.x - _621.y) * 0.4290426075458526611328125;
    float3 _650 = float3(0.0);
    _650.x = (dot(float4(_552, _554.xyz), _642) + dot(float4(_554.w, _577.xyz), _643)) + (_577.w * _644);
    float3 _656 = _650;
    _656.y = (dot(float4(_555, _557.xyz), _642) + dot(float4(_557.w, _579.xyz), _643)) + (_579.w * _644);
    float3 _662 = _656;
    _662.z = (dot(float4(_558, _560.xyz), _642) + dot(float4(_560.w, _581.xyz), _643)) + (_581.w * _644);
    float3 _667 = (fast::max(float3(0.0), _662) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    float3 _689 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _718;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _717;
        if (any(abs(_251 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _384 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _384 + 19u)].xyz + float3(1.0))))
        {
            _717 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_251, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _717 = _689;
        }
        _718 = _717;
    }
    else
    {
        _718 = _689;
    }
    float4 _725 = float4(((mix(float3(0.0), _515 + (_517 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_667 * _515) * fast::max(float3(1.0), ((((((_436 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_436 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_436 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _718) * 1.0, 0.0);
    float4 _732;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _731 = _725;
        _731.w = 0.0;
        _732 = _731;
    }
    else
    {
        _732 = _725;
    }
    float2 _736 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _744 = (_437 * 0.5) + float3(0.5);
    float4 _746 = float4(_744.x, _744.y, _744.z, float4(0.0).w);
    _746.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _385)].y;
    float4 _747 = float4(0.0);
    _747.x = _435;
    float4 _748 = _747;
    _748.y = _434;
    float4 _749 = _748;
    _749.z = _433;
    float4 _750 = _749;
    _750.w = 0.50588238239288330078125;
    float4 _762 = float4(_436.x, _436.y, _436.z, float4(0.0).w);
    _762.w = ((log2(((dot(_667, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_519 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_519 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_519 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_736.xyx * _736.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _732 * View.View_PreExposure;
    out.out_var_SV_Target1 = _746;
    out.out_var_SV_Target2 = _750;
    out.out_var_SV_Target3 = _762;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_486, 1.0, 1.0, 1.0);
    return out;
}

