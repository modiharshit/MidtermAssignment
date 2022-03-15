

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
    char _m11_pad[80];
    float View_UnlitViewmodeMask;
    char _m12_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m13_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m14_pad[188];
    float View_ShowDecalsMask;
    char _m15_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m16_pad[48];
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

constant float4 _165 = {};
constant float _167 = {};
constant float4 _168 = {};

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

fragment MainPS_out Main_00003d9a_f05f87e9(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(11)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _222 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _167, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _227 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _232 = (_227.xyz / float3(_227.w)) - View.View_PreViewTranslation;
    float3 _240 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _254 = fast::clamp(mix(float3(0.25), float3(0.569999992847442626953125, 0.3332314789295196533203125, 0.0342000015079975128173828125), float3(fast::min(fast::max(mix(-20.0, 20.0, in_var_TEXCOORD0[0].y), 0.0), 1.0))), float3(0.0), float3(1.0));
    float _258 = (0.20000000298023223876953125 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _259 = in.in_var_PRIMITIVE_ID * 36u;
    uint _260 = _259 + 20u;
    float _308;
    float _309;
    float _310;
    float3 _311;
    float3 _312;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _260)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _278 = ((_222.xy / float2(_222.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _282 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _278, level(0.0));
        float4 _285 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _278, level(0.0));
        float4 _288 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _278, level(0.0));
        float _298 = _288.w;
        _308 = (_258 * _298) + _288.z;
        _309 = (0.5 * _298) + _288.y;
        _310 = _288.x;
        _311 = (_254 * _282.w) + _282.xyz;
        _312 = normalize((_240 * _285.w) + ((_285.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _308 = _258;
        _309 = 0.5;
        _310 = 0.0;
        _311 = _254;
        _312 = _240;
    }
    float3 _322 = fast::clamp((_232 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _333 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_322.x), int(_322.y), int(_322.z), 0).xyz), 0));
    float3 _348 = (((_333.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_322 / float3(_333.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _361;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _260)].z > 0.0)
    {
        _361 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _348, level(0.0)).x;
    }
    else
    {
        _361 = 1.0;
    }
    float3 _375 = ((_311 - (_311 * _310)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _382 = (mix(float3(0.07999999821186065673828125 * _309), _311, float3(_310)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _385 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _390;
    if (_385)
    {
        _390 = _375 + (_382 * 0.449999988079071044921875);
    }
    else
    {
        _390 = _375;
    }
    float3 _392 = select(_382, float3(0.0), bool3(_385));
    float3 _394 = float3(dot(_392, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _411 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _348, level(0.0));
    float _427 = _411.x;
    float4 _429 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _348, level(0.0)) * 2.0) - float4(1.0)) * _427) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _430 = _411.y;
    float4 _432 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _348, level(0.0)) * 2.0) - float4(1.0)) * _430) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _433 = _411.z;
    float4 _435 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _348, level(0.0)) * 2.0) - float4(1.0)) * _433) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _452 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _348, level(0.0)) * 2.0) - float4(1.0)) * _427) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _454 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _348, level(0.0)) * 2.0) - float4(1.0)) * _430) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _456 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _348, level(0.0)) * 2.0) - float4(1.0)) * _433) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _489 = _168;
    _489.y = (-0.48860299587249755859375) * _312.y;
    float4 _492 = _489;
    _492.z = 0.48860299587249755859375 * _312.z;
    float4 _495 = _492;
    _495.w = (-0.48860299587249755859375) * _312.x;
    float3 _496 = _312 * _312;
    float4 _499 = _165;
    _499.x = (1.09254801273345947265625 * _312.x) * _312.y;
    float4 _502 = _499;
    _502.y = ((-1.09254801273345947265625) * _312.y) * _312.z;
    float4 _507 = _502;
    _507.z = 0.3153919875621795654296875 * ((3.0 * _496.z) - 1.0);
    float4 _510 = _507;
    _510.w = ((-1.09254801273345947265625) * _312.x) * _312.z;
    float4 _514 = _495;
    _514.x = 0.886227548122406005859375;
    float3 _516 = _514.yzw * 2.094395160675048828125;
    float4 _517 = float4(_514.x, _516.x, _516.y, _516.z);
    float4 _518 = _510 * 0.785398185253143310546875;
    float _519 = (_496.x - _496.y) * 0.4290426075458526611328125;
    float3 _525 = float3(0.0);
    _525.x = (dot(float4(_427, _429.xyz), _517) + dot(float4(_429.w, _452.xyz), _518)) + (_452.w * _519);
    float3 _531 = _525;
    _531.y = (dot(float4(_430, _432.xyz), _517) + dot(float4(_432.w, _454.xyz), _518)) + (_454.w * _519);
    float3 _537 = _531;
    _537.z = (dot(float4(_433, _435.xyz), _517) + dot(float4(_435.w, _456.xyz), _518)) + (_456.w * _519);
    float3 _542 = (fast::max(float3(0.0), _537) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    float3 _564 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _593;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _592;
        if (any(abs(_232 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _259 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _259 + 19u)].xyz + float3(1.0))))
        {
            _592 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_232, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _592 = _564;
        }
        _593 = _592;
    }
    else
    {
        _593 = _564;
    }
    float4 _600 = float4(((mix(float3(0.0), _390 + (_392 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_542 * _390) * fast::max(float3(1.0), ((((((_311 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_311 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_311 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _593) * 1.0, 0.0);
    float4 _607;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _606 = _600;
        _606.w = 0.0;
        _607 = _606;
    }
    else
    {
        _607 = _600;
    }
    float2 _611 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _619 = (_312 * 0.5) + float3(0.5);
    float4 _621 = float4(_619.x, _619.y, _619.z, float4(0.0).w);
    _621.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _260)].y;
    float4 _622 = float4(0.0);
    _622.x = _310;
    float4 _623 = _622;
    _623.y = _309;
    float4 _624 = _623;
    _624.z = _308;
    float4 _625 = _624;
    _625.w = 0.50588238239288330078125;
    float4 _637 = float4(_311.x, _311.y, _311.z, float4(0.0).w);
    _637.w = ((log2(((dot(_542, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_394 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_394 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_394 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_611.xyx * _611.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _607 * View.View_PreExposure;
    out.out_var_SV_Target1 = _621;
    out.out_var_SV_Target2 = _625;
    out.out_var_SV_Target3 = _637;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_361, 1.0, 1.0, 1.0);
    return out;
}

