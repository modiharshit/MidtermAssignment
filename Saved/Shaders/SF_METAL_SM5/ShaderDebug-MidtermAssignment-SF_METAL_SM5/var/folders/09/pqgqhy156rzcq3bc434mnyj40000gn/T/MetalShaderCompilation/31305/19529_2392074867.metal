

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
    char _m18_pad[188];
    float View_ShowDecalsMask;
    char _m19_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m20_pad[48];
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

constant float4 _190 = {};
constant float4 _192 = {};

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

fragment MainPS_out Main_00004c49_8e942a73(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(11)]], texture2d<float> Material_Texture2D_0 [[texture(12)]], texture2d<float> Material_Texture2D_1 [[texture(13)]], texture2d<float> Material_Texture2D_2 [[texture(14)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _249 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _253 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _258 = (_253.xyz / float3(_253.w)) - View.View_PreViewTranslation;
    float2 _265 = float2(View.View_GameTime * (-0.02999999932944774627685546875), View.View_GameTime * (-0.0199999995529651641845703125)) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(0.0500000007450580596923828125, 0.07999999821186065673828125));
    float4 _271 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _265, bias(View.View_MaterialTextureMipBias));
    float2 _274 = (_271.xy * float2(2.0)) - float2(1.0);
    float _281 = sqrt(fast::clamp(1.0 - dot(_274, _274), 0.0, 1.0)) + 1.0;
    float _289 = sin(((_258.x * 0.006666666828095912933349609375) + (View.View_GameTime * Material.Material_ScalarExpressions[0].x)) * 1.256637096405029296875);
    float4 _296 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(_289 * (-0.0599999986588954925537109375), _289 * (-0.039999999105930328369140625)) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(0.180000007152557373046875, 0.1500000059604644775390625))), bias(View.View_MaterialTextureMipBias));
    float2 _299 = (_296.xy * float2(2.0)) - float2(1.0);
    float3 _308 = float4(_299, sqrt(fast::clamp(1.0 - dot(_299, _299), 0.0, 1.0)), 1.0).xyz * float3(-1.0, -1.0, 1.0);
    float3 _311 = float3(_274, _281);
    float3 _315 = float3(_308.xy * (-1.0), _308.z);
    float3 _319 = (_311 * dot(_311, _315)) - (_315 * _281);
    float _321 = _319.z + 1.0;
    float2 _325 = float2(View.View_GameTime * (-0.070000000298023223876953125)) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.75);
    float4 _327 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _325, bias(View.View_MaterialTextureMipBias));
    float2 _330 = (_327.xy * float2(2.0)) - float2(1.0);
    float4 _342 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _369;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _369 = _249.w;
                break;
            }
            else
            {
                float _353 = _249.z;
                _369 = ((_353 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_353 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _376 = float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _342.x) + _369) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0));
    float3 _377 = mix(float4(_330, sqrt(fast::clamp(1.0 - dot(_330, _330), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), _376);
    float3 _382 = float3(_319.xy, _321);
    float3 _386 = float3(_377.xy * (-1.0), _377.z);
    float3 _398 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((((_382 * dot(_382, _386)) - (_386 * _321)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _409 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _325, bias(View.View_MaterialTextureMipBias));
    float4 _411 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _265, bias(View.View_MaterialTextureMipBias));
    float3 _426 = fast::clamp(mix(mix(Material.Material_VectorExpressions[4].xyz, Material.Material_VectorExpressions[5].xyz, float3(fast::min(fast::max(_409.x * _411.x, 0.0), 1.0))), Material.Material_VectorExpressions[4].xyz, _376), float3(0.0), float3(1.0));
    float _430 = (0.100000001490116119384765625 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _431 = in.in_var_PRIMITIVE_ID * 36u;
    uint _432 = _431 + 20u;
    float _480;
    float _481;
    float _482;
    float3 _483;
    float3 _484;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _432)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _450 = ((_249.xy / float2(_249.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _454 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _450, level(0.0));
        float4 _457 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _450, level(0.0));
        float4 _460 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _450, level(0.0));
        float _470 = _460.w;
        _480 = (_430 * _470) + _460.z;
        _481 = (0.5 * _470) + _460.y;
        _482 = _460.x;
        _483 = (_426 * _454.w) + _454.xyz;
        _484 = normalize((_398 * _457.w) + ((_457.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _480 = _430;
        _481 = 0.5;
        _482 = 0.0;
        _483 = _426;
        _484 = _398;
    }
    float3 _494 = fast::clamp((_258 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _505 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_494.x), int(_494.y), int(_494.z), 0).xyz), 0));
    float3 _520 = (((_505.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_494 / float3(_505.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _533;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _432)].z > 0.0)
    {
        _533 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _520, level(0.0)).x;
    }
    else
    {
        _533 = 1.0;
    }
    float3 _547 = ((_483 - (_483 * _482)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _554 = (mix(float3(0.07999999821186065673828125 * _481), _483, float3(_482)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _557 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _562;
    if (_557)
    {
        _562 = _547 + (_554 * 0.449999988079071044921875);
    }
    else
    {
        _562 = _547;
    }
    float3 _564 = select(_554, float3(0.0), bool3(_557));
    float3 _566 = float3(dot(_564, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _583 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _520, level(0.0));
    float _599 = _583.x;
    float4 _601 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _520, level(0.0)) * 2.0) - float4(1.0)) * _599) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _602 = _583.y;
    float4 _604 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _520, level(0.0)) * 2.0) - float4(1.0)) * _602) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _605 = _583.z;
    float4 _607 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _520, level(0.0)) * 2.0) - float4(1.0)) * _605) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _624 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _520, level(0.0)) * 2.0) - float4(1.0)) * _599) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _626 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _520, level(0.0)) * 2.0) - float4(1.0)) * _602) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _628 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _520, level(0.0)) * 2.0) - float4(1.0)) * _605) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _661 = _192;
    _661.y = (-0.48860299587249755859375) * _484.y;
    float4 _664 = _661;
    _664.z = 0.48860299587249755859375 * _484.z;
    float4 _667 = _664;
    _667.w = (-0.48860299587249755859375) * _484.x;
    float3 _668 = _484 * _484;
    float4 _671 = _190;
    _671.x = (1.09254801273345947265625 * _484.x) * _484.y;
    float4 _674 = _671;
    _674.y = ((-1.09254801273345947265625) * _484.y) * _484.z;
    float4 _679 = _674;
    _679.z = 0.3153919875621795654296875 * ((3.0 * _668.z) - 1.0);
    float4 _682 = _679;
    _682.w = ((-1.09254801273345947265625) * _484.x) * _484.z;
    float4 _686 = _667;
    _686.x = 0.886227548122406005859375;
    float3 _688 = _686.yzw * 2.094395160675048828125;
    float4 _689 = float4(_686.x, _688.x, _688.y, _688.z);
    float4 _690 = _682 * 0.785398185253143310546875;
    float _691 = (_668.x - _668.y) * 0.4290426075458526611328125;
    float3 _697 = float3(0.0);
    _697.x = (dot(float4(_599, _601.xyz), _689) + dot(float4(_601.w, _624.xyz), _690)) + (_624.w * _691);
    float3 _703 = _697;
    _703.y = (dot(float4(_602, _604.xyz), _689) + dot(float4(_604.w, _626.xyz), _690)) + (_626.w * _691);
    float3 _709 = _703;
    _709.z = (dot(float4(_605, _607.xyz), _689) + dot(float4(_607.w, _628.xyz), _690)) + (_628.w * _691);
    float3 _714 = (fast::max(float3(0.0), _709) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    float3 _736 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].y)), float3(0.0));
    float3 _765;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _764;
        if (any(abs(_258 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _431 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _431 + 19u)].xyz + float3(1.0))))
        {
            _764 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_258, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _764 = _736;
        }
        _765 = _764;
    }
    else
    {
        _765 = _736;
    }
    float4 _772 = float4(((mix(float3(0.0), _562 + (_564 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_714 * _562) * fast::max(float3(1.0), ((((((_483 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_483 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_483 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _765) * 1.0, 0.0);
    float4 _779;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _778 = _772;
        _778.w = 0.0;
        _779 = _778;
    }
    else
    {
        _779 = _772;
    }
    float2 _783 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _791 = (_484 * 0.5) + float3(0.5);
    float4 _793 = float4(_791.x, _791.y, _791.z, float4(0.0).w);
    _793.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _432)].y;
    float4 _794 = float4(0.0);
    _794.x = _482;
    float4 _795 = _794;
    _795.y = _481;
    float4 _796 = _795;
    _796.z = _480;
    float4 _797 = _796;
    _797.w = 0.50588238239288330078125;
    float4 _809 = float4(_483.x, _483.y, _483.z, float4(0.0).w);
    _809.w = ((log2(((dot(_714, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_566 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_566 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_566 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_783.xyx * _783.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _779 * View.View_PreExposure;
    out.out_var_SV_Target1 = _793;
    out.out_var_SV_Target2 = _797;
    out.out_var_SV_Target3 = _809;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_533, 1.0, 1.0, 1.0);
    return out;
}

