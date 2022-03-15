

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

fragment MainPS_out Main_00003be9_724b8c01(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> Material_Texture2D_0 [[texture(9)]], texture2d<float> Material_Texture2D_1 [[texture(10)]], texture2d<float> Material_Texture2D_2 [[texture(11)]], texture2d<float> Material_Texture2D_3 [[texture(12)]], sampler View_MaterialTextureBilinearWrapedSampler [[sampler(0)]], sampler View_SharedBilinearClampedSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
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
    float4 _269 = Material_Texture2D_2.sample(View_MaterialTextureBilinearWrapedSampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 8.0));
    float3 _273 = float3(_251.x);
    float4 _278 = Material_Texture2D_3.sample(View_MaterialTextureBilinearWrapedSampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 50.0));
    float3 _282 = float3(_251.z);
    float3 _296 = fast::clamp(mix(mix(mix(Material.Material_VectorExpressions[3].xyz, Material.Material_VectorExpressions[3].xyz, float3(_251.y)), _269.xyz * float3(0.25), _273), _278.xyz * float3(0.2249999940395355224609375), _282), float3(0.0), float3(1.0));
    float _297 = fast::clamp(mix(mix(float3(0.0), float3(1.0), _273), float3(0.0), _282).x, 0.0, 1.0);
    float3 _312 = fast::clamp((_210 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _323 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_312.x), int(_312.y), int(_312.z), 0).xyz), 0));
    float3 _338 = (((_323.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_312 / float3(_323.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _351;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        _351 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _338, level(0.0)).x;
    }
    else
    {
        _351 = 1.0;
    }
    float3 _363 = ((_296 - (_296 * _297)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _370 = (mix(float3(0.039999999105930328369140625), _296, float3(_297)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _373 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _378;
    if (_373)
    {
        _378 = _363 + (_370 * 0.449999988079071044921875);
    }
    else
    {
        _378 = _363;
    }
    float3 _380 = select(_370, float3(0.0), bool3(_373));
    float3 _382 = float3(dot(_380, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _399 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _338, level(0.0));
    float _415 = _399.x;
    float4 _417 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _338, level(0.0)) * 2.0) - float4(1.0)) * _415) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _418 = _399.y;
    float4 _420 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _338, level(0.0)) * 2.0) - float4(1.0)) * _418) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _421 = _399.z;
    float4 _423 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _338, level(0.0)) * 2.0) - float4(1.0)) * _421) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _440 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _338, level(0.0)) * 2.0) - float4(1.0)) * _415) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _442 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _338, level(0.0)) * 2.0) - float4(1.0)) * _418) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _444 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _338, level(0.0)) * 2.0) - float4(1.0)) * _421) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float _475 = _247.y;
    float4 _477 = _166;
    _477.y = (-0.48860299587249755859375) * _475;
    float _478 = _247.z;
    float4 _480 = _477;
    _480.z = 0.48860299587249755859375 * _478;
    float _481 = _247.x;
    float4 _483 = _480;
    _483.w = (-0.48860299587249755859375) * _481;
    float3 _484 = _247 * _247;
    float4 _487 = _164;
    _487.x = (1.09254801273345947265625 * _481) * _475;
    float4 _490 = _487;
    _490.y = ((-1.09254801273345947265625) * _475) * _478;
    float4 _495 = _490;
    _495.z = 0.3153919875621795654296875 * ((3.0 * _484.z) - 1.0);
    float4 _498 = _495;
    _498.w = ((-1.09254801273345947265625) * _481) * _478;
    float4 _502 = _483;
    _502.x = 0.886227548122406005859375;
    float3 _504 = _502.yzw * 2.094395160675048828125;
    float4 _505 = float4(_502.x, _504.x, _504.y, _504.z);
    float4 _506 = _498 * 0.785398185253143310546875;
    float _507 = (_484.x - _484.y) * 0.4290426075458526611328125;
    float3 _513 = float3(0.0);
    _513.x = (dot(float4(_415, _417.xyz), _505) + dot(float4(_417.w, _440.xyz), _506)) + (_440.w * _507);
    float3 _519 = _513;
    _519.y = (dot(float4(_418, _420.xyz), _505) + dot(float4(_420.w, _442.xyz), _506)) + (_442.w * _507);
    float3 _525 = _519;
    _525.z = (dot(float4(_421, _423.xyz), _505) + dot(float4(_423.w, _444.xyz), _506)) + (_444.w * _507);
    float3 _530 = (fast::max(float3(0.0), _525) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    float3 _552 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _578;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _577;
        if (any(abs(_210 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _577 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_210, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _577 = _552;
        }
        _578 = _577;
    }
    else
    {
        _578 = _552;
    }
    float4 _585 = float4(((mix(float3(0.0), _378 + (_380 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_530 * _378) * fast::max(float3(1.0), ((((((_296 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_296 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_296 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _578) * 1.0, 0.0);
    float4 _592;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _591 = _585;
        _591.w = 0.0;
        _592 = _591;
    }
    else
    {
        _592 = _585;
    }
    float2 _597 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _605 = (_247 * 0.5) + float3(0.5);
    float4 _607 = float4(_605.x, _605.y, _605.z, float4(0.0).w);
    _607.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _608 = float4(0.0);
    _608.x = _297;
    float4 _609 = _608;
    _609.y = 0.5;
    float4 _610 = _609;
    _610.z = (fast::clamp(mix(mix(float3(0.100000001490116119384765625), float3(mix(0.37999999523162841796875, 0.550000011920928955078125, _269.x)), _273), float3(mix(0.550000011920928955078125, 0.75, _278.x)), _282).x, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float4 _611 = _610;
    _611.w = 0.50588238239288330078125;
    float4 _623 = float4(_296.x, _296.y, _296.z, float4(0.0).w);
    _623.w = ((log2(((dot(_530, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_382 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_382 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_382 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_597.xyx * _597.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _592 * View.View_PreExposure;
    out.out_var_SV_Target1 = _607;
    out.out_var_SV_Target2 = _611;
    out.out_var_SV_Target3 = _623;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_351, 1.0, 1.0, 1.0);
    return out;
}

