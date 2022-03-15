

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
    char _m11_pad[24];
    float View_CullingSign;
    char _m12_pad[52];
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

struct type_Primitive
{
    char _m0_pad[64];
    float4 Primitive_InvNonUniformScaleAndDeterminantSign;
    float4 Primitive_ObjectWorldPositionAndRadius;
    char _m2_pad[208];
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

constant float4 _155 = {};
constant float _157 = {};
constant float4 _158 = {};

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
    float4 in_var_COLOR0 [[user(locn2)]];
    float4 in_var_COLOR1 [[user(locn3)]];
};

fragment MainPS_out Main_00003d0c_1feb42fb(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(11)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]], bool gl_FrontFacing [[front_facing]])
{
    MainPS_out out = {};
    float4 _217 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _157, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _222 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _227 = (_222.xyz / float3(_222.w)) - View.View_PreViewTranslation;
    float3 _241 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * ((View.View_CullingSign * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w) * float(gl_FrontFacing ? 1 : (-1)));
    if (abs(in.in_var_COLOR1.w) > 0.001000000047497451305389404296875)
    {
        float _259 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
        if ((float((in.in_var_COLOR1.w < 0.0) ? ((in.in_var_COLOR1.w + 1.0) > _259) : (in.in_var_COLOR1.w < _259)) - 0.001000000047497451305389404296875) < 0.0)
        {
            discard_fragment();
        }
    }
    float3 _270 = fast::clamp(in.in_var_COLOR0.xyz, float3(0.0), float3(1.0));
    float _274 = (0.5 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _319;
    float _320;
    float _321;
    float3 _322;
    float3 _323;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _291 = ((_217.xy / float2(_217.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _295 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _291, level(0.0));
        float4 _298 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _291, level(0.0));
        float4 _301 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _291, level(0.0));
        _319 = (_274 * _301.w) + _301.z;
        _320 = _301.y;
        _321 = _301.x;
        _322 = (_270 * _295.w) + _295.xyz;
        _323 = normalize((_241 * _298.w) + ((_298.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _319 = _274;
        _320 = 0.0;
        _321 = 0.0;
        _322 = _270;
        _323 = _241;
    }
    float3 _333 = fast::clamp((_227 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _344 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_333.x), int(_333.y), int(_333.z), 0).xyz), 0));
    float3 _359 = (((_344.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_333 / float3(_344.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _372;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        _372 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _359, level(0.0)).x;
    }
    else
    {
        _372 = 1.0;
    }
    float3 _386 = ((_322 - (_322 * _321)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _393 = (mix(float3(0.07999999821186065673828125 * _320), _322, float3(_321)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _396 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _401;
    if (_396)
    {
        _401 = _386 + (_393 * 0.449999988079071044921875);
    }
    else
    {
        _401 = _386;
    }
    float3 _403 = select(_393, float3(0.0), bool3(_396));
    float3 _405 = float3(dot(_403, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _422 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _359, level(0.0));
    float _438 = _422.x;
    float4 _440 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _359, level(0.0)) * 2.0) - float4(1.0)) * _438) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _441 = _422.y;
    float4 _443 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _359, level(0.0)) * 2.0) - float4(1.0)) * _441) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _444 = _422.z;
    float4 _446 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _359, level(0.0)) * 2.0) - float4(1.0)) * _444) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _463 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _359, level(0.0)) * 2.0) - float4(1.0)) * _438) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _465 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _359, level(0.0)) * 2.0) - float4(1.0)) * _441) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _467 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _359, level(0.0)) * 2.0) - float4(1.0)) * _444) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _500 = _158;
    _500.y = (-0.48860299587249755859375) * _323.y;
    float4 _503 = _500;
    _503.z = 0.48860299587249755859375 * _323.z;
    float4 _506 = _503;
    _506.w = (-0.48860299587249755859375) * _323.x;
    float3 _507 = _323 * _323;
    float4 _510 = _155;
    _510.x = (1.09254801273345947265625 * _323.x) * _323.y;
    float4 _513 = _510;
    _513.y = ((-1.09254801273345947265625) * _323.y) * _323.z;
    float4 _518 = _513;
    _518.z = 0.3153919875621795654296875 * ((3.0 * _507.z) - 1.0);
    float4 _521 = _518;
    _521.w = ((-1.09254801273345947265625) * _323.x) * _323.z;
    float4 _525 = _506;
    _525.x = 0.886227548122406005859375;
    float3 _527 = _525.yzw * 2.094395160675048828125;
    float4 _528 = float4(_525.x, _527.x, _527.y, _527.z);
    float4 _529 = _521 * 0.785398185253143310546875;
    float _530 = (_507.x - _507.y) * 0.4290426075458526611328125;
    float3 _536 = float3(0.0);
    _536.x = (dot(float4(_438, _440.xyz), _528) + dot(float4(_440.w, _463.xyz), _529)) + (_463.w * _530);
    float3 _542 = _536;
    _542.y = (dot(float4(_441, _443.xyz), _528) + dot(float4(_443.w, _465.xyz), _529)) + (_465.w * _530);
    float3 _548 = _542;
    _548.z = (dot(float4(_444, _446.xyz), _528) + dot(float4(_446.w, _467.xyz), _529)) + (_467.w * _530);
    float3 _553 = (fast::max(float3(0.0), _548) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    float3 _575 = fast::max(mix(in.in_var_COLOR0.xyz, Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _601;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _600;
        if (any(abs(_227 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _600 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_227, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _600 = _575;
        }
        _601 = _600;
    }
    else
    {
        _601 = _575;
    }
    float4 _608 = float4(((mix(float3(0.0), _401 + (_403 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_553 * _401) * fast::max(float3(1.0), ((((((_322 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_322 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_322 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _601) * 1.0, 0.0);
    float4 _615;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _614 = _608;
        _614.w = 0.0;
        _615 = _614;
    }
    else
    {
        _615 = _608;
    }
    float2 _619 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _627 = (_323 * 0.5) + float3(0.5);
    float4 _629 = float4(_627.x, _627.y, _627.z, float4(0.0).w);
    _629.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _630 = float4(0.0);
    _630.x = _321;
    float4 _631 = _630;
    _631.y = _320;
    float4 _632 = _631;
    _632.z = _319;
    float4 _633 = _632;
    _633.w = 0.50588238239288330078125;
    float4 _645 = float4(_322.x, _322.y, _322.z, float4(0.0).w);
    _645.w = ((log2(((dot(_553, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_405 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_405 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_405 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_619.xyx * _619.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _615 * View.View_PreExposure;
    out.out_var_SV_Target1 = _629;
    out.out_var_SV_Target2 = _633;
    out.out_var_SV_Target3 = _645;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_372, 1.0, 1.0, 1.0);
    return out;
}

