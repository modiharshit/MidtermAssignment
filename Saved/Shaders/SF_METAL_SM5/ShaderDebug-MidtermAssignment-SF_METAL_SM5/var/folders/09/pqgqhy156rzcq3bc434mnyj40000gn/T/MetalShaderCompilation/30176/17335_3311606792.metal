

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

constant float4 _169 = {};
constant float4 _171 = {};

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
    float2 in_var_TEXCOORD0_0 [[user(locn0)]];
    float4 in_var_TEXCOORD10_centroid [[user(locn1)]];
    float4 in_var_TEXCOORD11_centroid [[user(locn2)]];
};

fragment MainPS_out Main_000043b7_c5631c08(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(11)]], texture2d<float> Material_Texture2D_0 [[texture(12)]], texture2d<float> Material_Texture2D_1 [[texture(13)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float2, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    float4 _228 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _232 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _237 = (_232.xyz / float3(_232.w)) - View.View_PreViewTranslation;
    float4 _245 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (in_var_TEXCOORD0[0] * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _248 = (_245.xy * float2(2.0)) - float2(1.0);
    float3 _265 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize(((float4(_248, sqrt(fast::clamp(1.0 - dot(_248, _248), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _277 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in_var_TEXCOORD0[0] * 20.0), bias(View.View_MaterialTextureMipBias));
    float _279 = mix(0.4000000059604644775390625, 1.0, _277.x);
    float4 _283 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in_var_TEXCOORD0[0] * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _308;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _308 = _228.w;
                break;
            }
            else
            {
                float _292 = _228.z;
                _308 = ((_292 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_292 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _312 = fast::min(fast::max((_308 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _313 = _283.y;
    float4 _317 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in_var_TEXCOORD0[0] * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _319 = _317.y;
    float3 _332 = fast::clamp(float3(mix(_279, 1.0 - _279, mix(_313, 1.0, _312)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_319 + mix(_313, 0.0, _312), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _337 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _319) + mix(mix(0.699999988079071044921875, 1.0, _313), 1.0, _312), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _384;
    float _385;
    float _386;
    float3 _387;
    float3 _388;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _354 = ((_228.xy / float2(_228.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _358 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _354, level(0.0));
        float4 _361 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _354, level(0.0));
        float4 _364 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _354, level(0.0));
        float _374 = _364.w;
        _384 = (_337 * _374) + _364.z;
        _385 = (0.5 * _374) + _364.y;
        _386 = _364.x;
        _387 = (_332 * _358.w) + _358.xyz;
        _388 = normalize((_265 * _361.w) + ((_361.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _384 = _337;
        _385 = 0.5;
        _386 = 0.0;
        _387 = _332;
        _388 = _265;
    }
    float3 _398 = fast::clamp((_237 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _409 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_398.x), int(_398.y), int(_398.z), 0).xyz), 0));
    float3 _424 = (((_409.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_398 / float3(_409.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _437;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        _437 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _424, level(0.0)).x;
    }
    else
    {
        _437 = 1.0;
    }
    float3 _451 = ((_387 - (_387 * _386)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _458 = (mix(float3(0.07999999821186065673828125 * _385), _387, float3(_386)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _461 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _466;
    if (_461)
    {
        _466 = _451 + (_458 * 0.449999988079071044921875);
    }
    else
    {
        _466 = _451;
    }
    float3 _468 = select(_458, float3(0.0), bool3(_461));
    float3 _470 = float3(dot(_468, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _487 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _424, level(0.0));
    float _503 = _487.x;
    float4 _505 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _424, level(0.0)) * 2.0) - float4(1.0)) * _503) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _506 = _487.y;
    float4 _508 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _424, level(0.0)) * 2.0) - float4(1.0)) * _506) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _509 = _487.z;
    float4 _511 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _424, level(0.0)) * 2.0) - float4(1.0)) * _509) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _528 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _424, level(0.0)) * 2.0) - float4(1.0)) * _503) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _530 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _424, level(0.0)) * 2.0) - float4(1.0)) * _506) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _532 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _424, level(0.0)) * 2.0) - float4(1.0)) * _509) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _565 = _171;
    _565.y = (-0.48860299587249755859375) * _388.y;
    float4 _568 = _565;
    _568.z = 0.48860299587249755859375 * _388.z;
    float4 _571 = _568;
    _571.w = (-0.48860299587249755859375) * _388.x;
    float3 _572 = _388 * _388;
    float4 _575 = _169;
    _575.x = (1.09254801273345947265625 * _388.x) * _388.y;
    float4 _578 = _575;
    _578.y = ((-1.09254801273345947265625) * _388.y) * _388.z;
    float4 _583 = _578;
    _583.z = 0.3153919875621795654296875 * ((3.0 * _572.z) - 1.0);
    float4 _586 = _583;
    _586.w = ((-1.09254801273345947265625) * _388.x) * _388.z;
    float4 _590 = _571;
    _590.x = 0.886227548122406005859375;
    float3 _592 = _590.yzw * 2.094395160675048828125;
    float4 _593 = float4(_590.x, _592.x, _592.y, _592.z);
    float4 _594 = _586 * 0.785398185253143310546875;
    float _595 = (_572.x - _572.y) * 0.4290426075458526611328125;
    float3 _601 = float3(0.0);
    _601.x = (dot(float4(_503, _505.xyz), _593) + dot(float4(_505.w, _528.xyz), _594)) + (_528.w * _595);
    float3 _607 = _601;
    _607.y = (dot(float4(_506, _508.xyz), _593) + dot(float4(_508.w, _530.xyz), _594)) + (_530.w * _595);
    float3 _613 = _607;
    _613.z = (dot(float4(_509, _511.xyz), _593) + dot(float4(_511.w, _532.xyz), _594)) + (_532.w * _595);
    float3 _618 = (fast::max(float3(0.0), _613) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    float3 _640 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _666;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _665;
        if (any(abs(_237 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _665 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_237, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _665 = _640;
        }
        _666 = _665;
    }
    else
    {
        _666 = _640;
    }
    float4 _673 = float4(((mix(float3(0.0), _466 + (_468 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_618 * _466) * fast::max(float3(1.0), ((((((_387 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_387 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_387 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _666) * 1.0, 0.0);
    float4 _680;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _679 = _673;
        _679.w = 0.0;
        _680 = _679;
    }
    else
    {
        _680 = _673;
    }
    float2 _684 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _692 = (_388 * 0.5) + float3(0.5);
    float4 _694 = float4(_692.x, _692.y, _692.z, float4(0.0).w);
    _694.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _695 = float4(0.0);
    _695.x = _386;
    float4 _696 = _695;
    _696.y = _385;
    float4 _697 = _696;
    _697.z = _384;
    float4 _698 = _697;
    _698.w = 0.50588238239288330078125;
    float4 _710 = float4(_387.x, _387.y, _387.z, float4(0.0).w);
    _710.w = ((log2(((dot(_618, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_470 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_470 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_470 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_684.xyx * _684.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _680 * View.View_PreExposure;
    out.out_var_SV_Target1 = _694;
    out.out_var_SV_Target2 = _698;
    out.out_var_SV_Target3 = _710;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_437, 1.0, 1.0, 1.0);
    return out;
}

