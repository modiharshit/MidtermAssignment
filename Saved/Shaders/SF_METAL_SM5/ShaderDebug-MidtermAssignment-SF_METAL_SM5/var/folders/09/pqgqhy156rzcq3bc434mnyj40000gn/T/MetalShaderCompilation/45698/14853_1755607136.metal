

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

struct type_Primitive
{
    char _m0_pad[80];
    float4 Primitive_ObjectWorldPositionAndRadius;
    char _m1_pad[208];
    float3 Primitive_ObjectBounds;
    float Primitive_DecalReceiverMask;
    float Primitive_PerObjectGBufferData;
    float Primitive_UseVolumetricLightmapShadowFromStationaryLights;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _148 = {};
constant float _150 = {};
constant float4 _151 = {};

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
};

fragment MainPS_out Main_00003a05_68a47060(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(11)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    float4 _204 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _150, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _209 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _214 = (_209.xyz / float3(_209.w)) - View.View_PreViewTranslation;
    float3 _222 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float _233 = (0.100000001490116119384765625 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _281;
    float _282;
    float _283;
    float3 _284;
    float3 _285;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _250 = ((_204.xy / float2(_204.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _254 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _250, level(0.0));
        float4 _257 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _250, level(0.0));
        float4 _260 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _250, level(0.0));
        float _270 = _260.w;
        _281 = (_233 * _270) + _260.z;
        _282 = (0.5 * _270) + _260.y;
        _283 = _270 + _260.x;
        _284 = (float3(1.0) * _254.w) + _254.xyz;
        _285 = normalize((_222 * _257.w) + ((_257.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _281 = _233;
        _282 = 0.5;
        _283 = 1.0;
        _284 = float3(1.0);
        _285 = _222;
    }
    float3 _295 = fast::clamp((_214 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _306 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_295.x), int(_295.y), int(_295.z), 0).xyz), 0));
    float3 _321 = (((_306.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_295 / float3(_306.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _334;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        _334 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _321, level(0.0)).x;
    }
    else
    {
        _334 = 1.0;
    }
    float3 _348 = ((_284 - (_284 * _283)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _355 = (mix(float3(0.07999999821186065673828125 * _282), _284, float3(_283)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _358 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _363;
    if (_358)
    {
        _363 = _348 + (_355 * 0.449999988079071044921875);
    }
    else
    {
        _363 = _348;
    }
    float3 _365 = select(_355, float3(0.0), bool3(_358));
    float3 _367 = float3(dot(_365, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _384 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _321, level(0.0));
    float _400 = _384.x;
    float4 _402 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _321, level(0.0)) * 2.0) - float4(1.0)) * _400) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _403 = _384.y;
    float4 _405 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _321, level(0.0)) * 2.0) - float4(1.0)) * _403) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _406 = _384.z;
    float4 _408 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _321, level(0.0)) * 2.0) - float4(1.0)) * _406) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _425 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _321, level(0.0)) * 2.0) - float4(1.0)) * _400) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _427 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _321, level(0.0)) * 2.0) - float4(1.0)) * _403) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _429 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _321, level(0.0)) * 2.0) - float4(1.0)) * _406) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _462 = _151;
    _462.y = (-0.48860299587249755859375) * _285.y;
    float4 _465 = _462;
    _465.z = 0.48860299587249755859375 * _285.z;
    float4 _468 = _465;
    _468.w = (-0.48860299587249755859375) * _285.x;
    float3 _469 = _285 * _285;
    float4 _472 = _148;
    _472.x = (1.09254801273345947265625 * _285.x) * _285.y;
    float4 _475 = _472;
    _475.y = ((-1.09254801273345947265625) * _285.y) * _285.z;
    float4 _480 = _475;
    _480.z = 0.3153919875621795654296875 * ((3.0 * _469.z) - 1.0);
    float4 _483 = _480;
    _483.w = ((-1.09254801273345947265625) * _285.x) * _285.z;
    float4 _487 = _468;
    _487.x = 0.886227548122406005859375;
    float3 _489 = _487.yzw * 2.094395160675048828125;
    float4 _490 = float4(_487.x, _489.x, _489.y, _489.z);
    float4 _491 = _483 * 0.785398185253143310546875;
    float _492 = (_469.x - _469.y) * 0.4290426075458526611328125;
    float3 _498 = float3(0.0);
    _498.x = (dot(float4(_400, _402.xyz), _490) + dot(float4(_402.w, _425.xyz), _491)) + (_425.w * _492);
    float3 _504 = _498;
    _504.y = (dot(float4(_403, _405.xyz), _490) + dot(float4(_405.w, _427.xyz), _491)) + (_427.w * _492);
    float3 _510 = _504;
    _510.z = (dot(float4(_406, _408.xyz), _490) + dot(float4(_408.w, _429.xyz), _491)) + (_429.w * _492);
    float3 _515 = (fast::max(float3(0.0), _510) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    float3 _537 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _563;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _562;
        if (any(abs(_214 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _562 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_214, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _562 = _537;
        }
        _563 = _562;
    }
    else
    {
        _563 = _537;
    }
    float4 _570 = float4(((mix(float3(0.0), _363 + (_365 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_515 * _363) * fast::max(float3(1.0), ((((((_284 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_284 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_284 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _563) * 1.0, 0.0);
    float4 _577;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _576 = _570;
        _576.w = 0.0;
        _577 = _576;
    }
    else
    {
        _577 = _570;
    }
    float2 _581 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _589 = (_285 * 0.5) + float3(0.5);
    float4 _591 = float4(_589.x, _589.y, _589.z, float4(0.0).w);
    _591.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _592 = float4(0.0);
    _592.x = _283;
    float4 _593 = _592;
    _593.y = _282;
    float4 _594 = _593;
    _594.z = _281;
    float4 _595 = _594;
    _595.w = 0.50588238239288330078125;
    float4 _607 = float4(_284.x, _284.y, _284.z, float4(0.0).w);
    _607.w = ((log2(((dot(_515, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_367 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_367 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_367 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_581.xyx * _581.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _577 * View.View_PreExposure;
    out.out_var_SV_Target1 = _591;
    out.out_var_SV_Target2 = _595;
    out.out_var_SV_Target3 = _607;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_334, 1.0, 1.0, 1.0);
    return out;
}

