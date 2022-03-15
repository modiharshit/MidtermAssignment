

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
    spvUnsafeArray<float4, 6> Material_VectorExpressions;
    spvUnsafeArray<float4, 2> Material_ScalarExpressions;
};

constant float4 _166 = {};
constant float _168 = {};
constant float4 _169 = {};

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

fragment MainPS_out Main_00004191_3abea8d7(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(11)]], texture2d<float> Material_Texture2D_0 [[texture(12)]], texture2d<float> Material_Texture2D_1 [[texture(13)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _224 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _168, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _229 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _234 = (_229.xyz / float3(_229.w)) - View.View_PreViewTranslation;
    float4 _240 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _243 = (_240.xy * float2(2.0)) - float2(1.0);
    float3 _259 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_243, sqrt(fast::clamp(1.0 - dot(_243, _243), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _270 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _277 = _270.y;
    float3 _292 = fast::clamp(mix(Material.Material_VectorExpressions[4].xyz, Material.Material_VectorExpressions[5].xyz, float3(_277)) * _270.x, float3(0.0), float3(1.0));
    float _293 = fast::clamp(mix(Material.Material_ScalarExpressions[0].y, Material.Material_ScalarExpressions[0].z, _277), 0.0, 1.0);
    float _298 = (fast::clamp(mix(Material.Material_ScalarExpressions[0].w, Material.Material_ScalarExpressions[1].x, _277), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _299 = in.in_var_PRIMITIVE_ID * 36u;
    uint _300 = _299 + 20u;
    float _350;
    float _351;
    float _352;
    float3 _353;
    float3 _354;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _300)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _318 = ((_224.xy / float2(_224.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _322 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _318, level(0.0));
        float4 _325 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _318, level(0.0));
        float4 _328 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _318, level(0.0));
        float _338 = _328.w;
        _350 = (_298 * _338) + _328.z;
        _351 = (0.5 * _338) + _328.y;
        _352 = (_293 * _338) + _328.x;
        _353 = (_292 * _322.w) + _322.xyz;
        _354 = normalize((_259 * _325.w) + ((_325.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _350 = _298;
        _351 = 0.5;
        _352 = _293;
        _353 = _292;
        _354 = _259;
    }
    float3 _364 = fast::clamp((_234 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _375 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_364.x), int(_364.y), int(_364.z), 0).xyz), 0));
    float3 _390 = (((_375.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_364 / float3(_375.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _403;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _300)].z > 0.0)
    {
        _403 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _390, level(0.0)).x;
    }
    else
    {
        _403 = 1.0;
    }
    float3 _417 = ((_353 - (_353 * _352)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _424 = (mix(float3(0.07999999821186065673828125 * _351), _353, float3(_352)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _427 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _432;
    if (_427)
    {
        _432 = _417 + (_424 * 0.449999988079071044921875);
    }
    else
    {
        _432 = _417;
    }
    float3 _434 = select(_424, float3(0.0), bool3(_427));
    float3 _436 = float3(dot(_434, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _453 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _390, level(0.0));
    float _469 = _453.x;
    float4 _471 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _390, level(0.0)) * 2.0) - float4(1.0)) * _469) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _472 = _453.y;
    float4 _474 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _390, level(0.0)) * 2.0) - float4(1.0)) * _472) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _475 = _453.z;
    float4 _477 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _390, level(0.0)) * 2.0) - float4(1.0)) * _475) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _494 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _390, level(0.0)) * 2.0) - float4(1.0)) * _469) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _496 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _390, level(0.0)) * 2.0) - float4(1.0)) * _472) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _498 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _390, level(0.0)) * 2.0) - float4(1.0)) * _475) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _531 = _169;
    _531.y = (-0.48860299587249755859375) * _354.y;
    float4 _534 = _531;
    _534.z = 0.48860299587249755859375 * _354.z;
    float4 _537 = _534;
    _537.w = (-0.48860299587249755859375) * _354.x;
    float3 _538 = _354 * _354;
    float4 _541 = _166;
    _541.x = (1.09254801273345947265625 * _354.x) * _354.y;
    float4 _544 = _541;
    _544.y = ((-1.09254801273345947265625) * _354.y) * _354.z;
    float4 _549 = _544;
    _549.z = 0.3153919875621795654296875 * ((3.0 * _538.z) - 1.0);
    float4 _552 = _549;
    _552.w = ((-1.09254801273345947265625) * _354.x) * _354.z;
    float4 _556 = _537;
    _556.x = 0.886227548122406005859375;
    float3 _558 = _556.yzw * 2.094395160675048828125;
    float4 _559 = float4(_556.x, _558.x, _558.y, _558.z);
    float4 _560 = _552 * 0.785398185253143310546875;
    float _561 = (_538.x - _538.y) * 0.4290426075458526611328125;
    float3 _567 = float3(0.0);
    _567.x = (dot(float4(_469, _471.xyz), _559) + dot(float4(_471.w, _494.xyz), _560)) + (_494.w * _561);
    float3 _573 = _567;
    _573.y = (dot(float4(_472, _474.xyz), _559) + dot(float4(_474.w, _496.xyz), _560)) + (_496.w * _561);
    float3 _579 = _573;
    _579.z = (dot(float4(_475, _477.xyz), _559) + dot(float4(_477.w, _498.xyz), _560)) + (_498.w * _561);
    float3 _584 = (fast::max(float3(0.0), _579) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    float3 _606 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _635;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _634;
        if (any(abs(_234 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _299 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _299 + 19u)].xyz + float3(1.0))))
        {
            _634 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_234, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _634 = _606;
        }
        _635 = _634;
    }
    else
    {
        _635 = _606;
    }
    float4 _642 = float4(((mix(float3(0.0), _432 + (_434 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_584 * _432) * fast::max(float3(1.0), ((((((_353 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_353 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_353 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _635) * 1.0, 0.0);
    float4 _649;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _648 = _642;
        _648.w = 0.0;
        _649 = _648;
    }
    else
    {
        _649 = _642;
    }
    float2 _653 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _661 = (_354 * 0.5) + float3(0.5);
    float4 _663 = float4(_661.x, _661.y, _661.z, float4(0.0).w);
    _663.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _300)].y;
    float4 _664 = float4(0.0);
    _664.x = _352;
    float4 _665 = _664;
    _665.y = _351;
    float4 _666 = _665;
    _666.z = _350;
    float4 _667 = _666;
    _667.w = 0.50588238239288330078125;
    float4 _679 = float4(_353.x, _353.y, _353.z, float4(0.0).w);
    _679.w = ((log2(((dot(_584, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_436 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_436 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_436 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_653.xyx * _653.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _649 * View.View_PreExposure;
    out.out_var_SV_Target1 = _663;
    out.out_var_SV_Target2 = _667;
    out.out_var_SV_Target3 = _679;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_403, 1.0, 1.0, 1.0);
    return out;
}

