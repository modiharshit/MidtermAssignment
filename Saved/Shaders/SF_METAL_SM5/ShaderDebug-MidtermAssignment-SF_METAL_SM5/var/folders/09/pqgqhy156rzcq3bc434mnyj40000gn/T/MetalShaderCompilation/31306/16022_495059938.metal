

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
    char _m15_pad[188];
    float View_ShowDecalsMask;
    char _m16_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m17_pad[48];
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

constant float4 _161 = {};
constant float _163 = {};
constant float4 _164 = {};

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

fragment MainPS_out Main_00003e96_1d8203e2(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(11)]], texture2d<float> Material_Texture2D_0 [[texture(12)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _220 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _163, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _225 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _230 = (_225.xyz / float3(_225.w)) - View.View_PreViewTranslation;
    float3 _238 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _251 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _253 = fast::clamp(_251.xyz, float3(0.0), float3(1.0));
    float _257 = (0.949999988079071044921875 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _258 = in.in_var_PRIMITIVE_ID * 36u;
    uint _259 = _258 + 20u;
    float _307;
    float _308;
    float _309;
    float3 _310;
    float3 _311;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _259)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _277 = ((_220.xy / float2(_220.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _281 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _277, level(0.0));
        float4 _284 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _277, level(0.0));
        float4 _287 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _277, level(0.0));
        float _297 = _287.w;
        _307 = (_257 * _297) + _287.z;
        _308 = (0.20000000298023223876953125 * _297) + _287.y;
        _309 = _287.x;
        _310 = (_253 * _281.w) + _281.xyz;
        _311 = normalize((_238 * _284.w) + ((_284.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _307 = _257;
        _308 = 0.20000000298023223876953125;
        _309 = 0.0;
        _310 = _253;
        _311 = _238;
    }
    float3 _321 = fast::clamp((_230 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _332 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_321.x), int(_321.y), int(_321.z), 0).xyz), 0));
    float3 _347 = (((_332.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_321 / float3(_332.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _360;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _259)].z > 0.0)
    {
        _360 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _347, level(0.0)).x;
    }
    else
    {
        _360 = 1.0;
    }
    float3 _374 = ((_310 - (_310 * _309)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _381 = (mix(float3(0.07999999821186065673828125 * _308), _310, float3(_309)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _384 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _389;
    if (_384)
    {
        _389 = _374 + (_381 * 0.449999988079071044921875);
    }
    else
    {
        _389 = _374;
    }
    float3 _391 = select(_381, float3(0.0), bool3(_384));
    float3 _393 = float3(dot(_391, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _410 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _347, level(0.0));
    float _426 = _410.x;
    float4 _428 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _347, level(0.0)) * 2.0) - float4(1.0)) * _426) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _429 = _410.y;
    float4 _431 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _347, level(0.0)) * 2.0) - float4(1.0)) * _429) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _432 = _410.z;
    float4 _434 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _347, level(0.0)) * 2.0) - float4(1.0)) * _432) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _451 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _347, level(0.0)) * 2.0) - float4(1.0)) * _426) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _453 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _347, level(0.0)) * 2.0) - float4(1.0)) * _429) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _455 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _347, level(0.0)) * 2.0) - float4(1.0)) * _432) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _488 = _164;
    _488.y = (-0.48860299587249755859375) * _311.y;
    float4 _491 = _488;
    _491.z = 0.48860299587249755859375 * _311.z;
    float4 _494 = _491;
    _494.w = (-0.48860299587249755859375) * _311.x;
    float3 _495 = _311 * _311;
    float4 _498 = _161;
    _498.x = (1.09254801273345947265625 * _311.x) * _311.y;
    float4 _501 = _498;
    _501.y = ((-1.09254801273345947265625) * _311.y) * _311.z;
    float4 _506 = _501;
    _506.z = 0.3153919875621795654296875 * ((3.0 * _495.z) - 1.0);
    float4 _509 = _506;
    _509.w = ((-1.09254801273345947265625) * _311.x) * _311.z;
    float4 _513 = _494;
    _513.x = 0.886227548122406005859375;
    float3 _515 = _513.yzw * 2.094395160675048828125;
    float4 _516 = float4(_513.x, _515.x, _515.y, _515.z);
    float4 _517 = _509 * 0.785398185253143310546875;
    float _518 = (_495.x - _495.y) * 0.4290426075458526611328125;
    float3 _524 = float3(0.0);
    _524.x = (dot(float4(_426, _428.xyz), _516) + dot(float4(_428.w, _451.xyz), _517)) + (_451.w * _518);
    float3 _530 = _524;
    _530.y = (dot(float4(_429, _431.xyz), _516) + dot(float4(_431.w, _453.xyz), _517)) + (_453.w * _518);
    float3 _536 = _530;
    _536.z = (dot(float4(_432, _434.xyz), _516) + dot(float4(_434.w, _455.xyz), _517)) + (_455.w * _518);
    float3 _541 = (fast::max(float3(0.0), _536) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    float3 _563 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _592;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _591;
        if (any(abs(_230 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _258 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _258 + 19u)].xyz + float3(1.0))))
        {
            _591 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_230, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _591 = _563;
        }
        _592 = _591;
    }
    else
    {
        _592 = _563;
    }
    float4 _599 = float4(((mix(float3(0.0), _389 + (_391 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_541 * _389) * fast::max(float3(1.0), ((((((_310 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_310 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_310 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _592) * 1.0, 0.0);
    float4 _606;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _605 = _599;
        _605.w = 0.0;
        _606 = _605;
    }
    else
    {
        _606 = _599;
    }
    float2 _610 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _618 = (_311 * 0.5) + float3(0.5);
    float4 _620 = float4(_618.x, _618.y, _618.z, float4(0.0).w);
    _620.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _259)].y;
    float4 _621 = float4(0.0);
    _621.x = _309;
    float4 _622 = _621;
    _622.y = _308;
    float4 _623 = _622;
    _623.z = _307;
    float4 _624 = _623;
    _624.w = 0.50588238239288330078125;
    float4 _636 = float4(_310.x, _310.y, _310.z, float4(0.0).w);
    _636.w = ((log2(((dot(_541, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_393 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_393 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_393 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_610.xyx * _610.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _606 * View.View_PreExposure;
    out.out_var_SV_Target1 = _620;
    out.out_var_SV_Target2 = _624;
    out.out_var_SV_Target3 = _636;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_360, 1.0, 1.0, 1.0);
    return out;
}

