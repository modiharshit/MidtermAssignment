

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
    char _m1_pad[352];
    float3 View_PreViewTranslation;
    char _m2_pad[1028];
    float View_PreExposure;
    float4 View_DiffuseOverrideParameter;
    float4 View_SpecularOverrideParameter;
    float4 View_NormalOverrideParameter;
    float2 View_RoughnessOverrideParameter;
    char _m7_pad[8];
    float View_OutOfBoundsMask;
    char _m8_pad[48];
    float View_MaterialTextureMipBias;
    char _m9_pad[28];
    float View_UnlitViewmodeMask;
    char _m10_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m11_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m12_pad[376];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m13_pad[48];
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
    char _m2_pad[4];
    float Primitive_PerObjectGBufferData;
    float Primitive_UseVolumetricLightmapShadowFromStationaryLights;
};

struct type_Material
{
    spvUnsafeArray<float4, 4> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _164 = {};
constant float4 _166 = {};

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
};

fragment MainPS_out Main_00003c4f_3406432f(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> Material_Texture2D_0 [[texture(9)]], texture2d<float> Material_Texture2D_1 [[texture(10)]], texture2d<float> Material_Texture2D_2 [[texture(11)]], texture2d<float> Material_Texture2D_3 [[texture(12)]], sampler View_MaterialTextureBilinearWrapedSampler [[sampler(0)]], sampler View_SharedBilinearClampedSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    float4 _205 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _210 = (_205.xyz / float3(_205.w)) - View.View_PreViewTranslation;
    float4 _216 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _219 = (_216.xy * float2(2.0)) - float2(1.0);
    float _223 = sqrt(fast::clamp(1.0 - dot(_219, _219), 0.0, 1.0));
    float3 _231 = float3(float4(_219, _223, 1.0).xy * (-1.0), _223);
    float3 _235 = (float3(0.0, 0.0, 2.0) * dot(float3(0.0, 0.0, 2.0), _231)) - (_231 * 2.0);
    float3 _247 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize(((_235 / float3(sqrt(dot(_235, _235)))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _251 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _269 = Material_Texture2D_2.sample(View_MaterialTextureBilinearWrapedSampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 50.0));
    float3 _273 = float3(_251.x);
    float4 _278 = Material_Texture2D_3.sample(View_MaterialTextureBilinearWrapedSampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 8.0));
    float3 _282 = float3(_251.z);
    float3 _285 = float3(_251.w);
    float3 _300 = fast::clamp(mix(mix(mix(mix(Material.Material_VectorExpressions[3].xyz, Material.Material_VectorExpressions[3].xyz, float3(_251.y)), _269.xyz * float3(0.2249999940395355224609375), _273), _278.xyz * float3(0.25), _282), float3(0.0), _285), float3(0.0), float3(1.0));
    float _301 = fast::clamp(mix(mix(float3(0.0), float3(1.0), _282), float3(0.0), _285).x, 0.0, 1.0);
    float3 _316 = fast::clamp((_210 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _327 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_316.x), int(_316.y), int(_316.z), 0).xyz), 0));
    float3 _342 = (((_327.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_316 / float3(_327.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _355;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        _355 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _342, level(0.0)).x;
    }
    else
    {
        _355 = 1.0;
    }
    float3 _367 = ((_300 - (_300 * _301)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _374 = (mix(float3(0.039999999105930328369140625), _300, float3(_301)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _377 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _382;
    if (_377)
    {
        _382 = _367 + (_374 * 0.449999988079071044921875);
    }
    else
    {
        _382 = _367;
    }
    float3 _384 = select(_374, float3(0.0), bool3(_377));
    float3 _386 = float3(dot(_384, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _403 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _342, level(0.0));
    float _419 = _403.x;
    float4 _421 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _342, level(0.0)) * 2.0) - float4(1.0)) * _419) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _422 = _403.y;
    float4 _424 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _342, level(0.0)) * 2.0) - float4(1.0)) * _422) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _425 = _403.z;
    float4 _427 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _342, level(0.0)) * 2.0) - float4(1.0)) * _425) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _444 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _342, level(0.0)) * 2.0) - float4(1.0)) * _419) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _446 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _342, level(0.0)) * 2.0) - float4(1.0)) * _422) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _448 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _342, level(0.0)) * 2.0) - float4(1.0)) * _425) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float _479 = _247.y;
    float4 _481 = _166;
    _481.y = (-0.48860299587249755859375) * _479;
    float _482 = _247.z;
    float4 _484 = _481;
    _484.z = 0.48860299587249755859375 * _482;
    float _485 = _247.x;
    float4 _487 = _484;
    _487.w = (-0.48860299587249755859375) * _485;
    float3 _488 = _247 * _247;
    float4 _491 = _164;
    _491.x = (1.09254801273345947265625 * _485) * _479;
    float4 _494 = _491;
    _494.y = ((-1.09254801273345947265625) * _479) * _482;
    float4 _499 = _494;
    _499.z = 0.3153919875621795654296875 * ((3.0 * _488.z) - 1.0);
    float4 _502 = _499;
    _502.w = ((-1.09254801273345947265625) * _485) * _482;
    float4 _506 = _487;
    _506.x = 0.886227548122406005859375;
    float3 _508 = _506.yzw * 2.094395160675048828125;
    float4 _509 = float4(_506.x, _508.x, _508.y, _508.z);
    float4 _510 = _502 * 0.785398185253143310546875;
    float _511 = (_488.x - _488.y) * 0.4290426075458526611328125;
    float3 _517 = float3(0.0);
    _517.x = (dot(float4(_419, _421.xyz), _509) + dot(float4(_421.w, _444.xyz), _510)) + (_444.w * _511);
    float3 _523 = _517;
    _523.y = (dot(float4(_422, _424.xyz), _509) + dot(float4(_424.w, _446.xyz), _510)) + (_446.w * _511);
    float3 _529 = _523;
    _529.z = (dot(float4(_425, _427.xyz), _509) + dot(float4(_427.w, _448.xyz), _510)) + (_448.w * _511);
    float3 _534 = (fast::max(float3(0.0), _529) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    float3 _556 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _582;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _581;
        if (any(abs(_210 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _581 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_210, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _581 = _556;
        }
        _582 = _581;
    }
    else
    {
        _582 = _556;
    }
    float4 _589 = float4(((mix(float3(0.0), _382 + (_384 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_534 * _382) * fast::max(float3(1.0), ((((((_300 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_300 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_300 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _582) * 1.0, 0.0);
    float4 _596;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _595 = _589;
        _595.w = 0.0;
        _596 = _595;
    }
    else
    {
        _596 = _589;
    }
    float2 _601 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _609 = (_247 * 0.5) + float3(0.5);
    float4 _611 = float4(_609.x, _609.y, _609.z, float4(0.0).w);
    _611.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _612 = float4(0.0);
    _612.x = _301;
    float4 _613 = _612;
    _613.y = 0.5;
    float4 _614 = _613;
    _614.z = (fast::clamp(mix(mix(mix(float3(0.100000001490116119384765625), float3(mix(0.550000011920928955078125, 0.75, _269.x)), _273), float3(mix(0.37999999523162841796875, 0.550000011920928955078125, _278.x)), _282), float3(0.100000001490116119384765625), _285).x, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float4 _615 = _614;
    _615.w = 0.50588238239288330078125;
    float4 _627 = float4(_300.x, _300.y, _300.z, float4(0.0).w);
    _627.w = ((log2(((dot(_534, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_386 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_386 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_386 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_601.xyx * _601.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _596 * View.View_PreExposure;
    out.out_var_SV_Target1 = _611;
    out.out_var_SV_Target2 = _615;
    out.out_var_SV_Target3 = _627;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_355, 1.0, 1.0, 1.0);
    return out;
}

