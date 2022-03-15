

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
    float View_IndirectLightingCacheShowFlag;
};

struct type_Primitive
{
    char _m0_pad[80];
    float4 Primitive_ObjectWorldPositionAndRadius;
    char _m1_pad[204];
    float Primitive_UseSingleSampleShadowFromStationaryLights;
    float3 Primitive_ObjectBounds;
    char _m3_pad[4];
    float Primitive_PerObjectGBufferData;
    float Primitive_UseVolumetricLightmapShadowFromStationaryLights;
};

struct type_IndirectLightingCache
{
    char _m0_pad[80];
    float IndirectLightingCache_DirectionalLightShadowing;
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients0;
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients1;
    float4 IndirectLightingCache_IndirectLightingSHCoefficients2;
};

struct type_Material
{
    spvUnsafeArray<float4, 4> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _156 = {};
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
    float4 in_var_TEXCOORD0_0 [[user(locn2)]];
};

fragment MainPS_out Main_000037b6_8cd95330(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> Material_Texture2D_0 [[texture(2)]], texture2d<float> Material_Texture2D_1 [[texture(3)]], texture2d<float> Material_Texture2D_2 [[texture(4)]], texture2d<float> Material_Texture2D_3 [[texture(5)]], sampler View_MaterialTextureBilinearWrapedSampler [[sampler(0)]], sampler View_SharedBilinearClampedSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    float4 _196 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _201 = (_196.xyz / float3(_196.w)) - View.View_PreViewTranslation;
    float4 _207 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _210 = (_207.xy * float2(2.0)) - float2(1.0);
    float _214 = sqrt(fast::clamp(1.0 - dot(_210, _210), 0.0, 1.0));
    float3 _222 = float3(float4(_210, _214, 1.0).xy * (-1.0), _214);
    float3 _226 = (float3(0.0, 0.0, 2.0) * dot(float3(0.0, 0.0, 2.0), _222)) - (_222 * 2.0);
    float3 _238 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize(((_226 / float3(sqrt(dot(_226, _226)))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _242 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _260 = Material_Texture2D_2.sample(View_MaterialTextureBilinearWrapedSampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 8.0));
    float3 _264 = float3(_242.x);
    float4 _269 = Material_Texture2D_3.sample(View_MaterialTextureBilinearWrapedSampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 50.0));
    float3 _273 = float3(_242.z);
    float3 _287 = fast::clamp(mix(mix(mix(Material.Material_VectorExpressions[3].xyz, Material.Material_VectorExpressions[3].xyz, float3(_242.y)), _260.xyz * float3(0.25), _264), _269.xyz * float3(0.2249999940395355224609375), _273), float3(0.0), float3(1.0));
    float _288 = fast::clamp(mix(mix(float3(0.0), float3(1.0), _264), float3(0.0), _273).x, 0.0, 1.0);
    bool _301 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _307;
    if ((Primitive.Primitive_UseSingleSampleShadowFromStationaryLights > 0.0) && _301)
    {
        _307 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _307 = 1.0;
    }
    float _354;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _322 = fast::clamp((_201 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _333 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_322.x), int(_322.y), int(_322.z), 0).xyz), 0));
        _354 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_333.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_322 / float3(_333.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _354 = _307;
    }
    float3 _366 = ((_287 - (_287 * _288)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _373 = (mix(float3(0.039999999105930328369140625), _287, float3(_288)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _376 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _381;
    if (_376)
    {
        _381 = _366 + (_373 * 0.449999988079071044921875);
    }
    else
    {
        _381 = _366;
    }
    float3 _383 = select(_373, float3(0.0), bool3(_376));
    float3 _385 = float3(dot(_383, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _471;
    if (_301)
    {
        float _419 = _238.y;
        float4 _421 = _158;
        _421.y = (-0.48860299587249755859375) * _419;
        float _422 = _238.z;
        float4 _424 = _421;
        _424.z = 0.48860299587249755859375 * _422;
        float _425 = _238.x;
        float4 _427 = _424;
        _427.w = (-0.48860299587249755859375) * _425;
        float3 _428 = _238 * _238;
        float4 _431 = _156;
        _431.x = (1.09254801273345947265625 * _425) * _419;
        float4 _434 = _431;
        _434.y = ((-1.09254801273345947265625) * _419) * _422;
        float4 _439 = _434;
        _439.z = 0.3153919875621795654296875 * ((3.0 * _428.z) - 1.0);
        float4 _442 = _439;
        _442.w = ((-1.09254801273345947265625) * _425) * _422;
        float4 _446 = _427;
        _446.x = 0.886227548122406005859375;
        float3 _448 = _446.yzw * 2.094395160675048828125;
        float4 _449 = float4(_446.x, _448.x, _448.y, _448.z);
        float4 _450 = _442 * 0.785398185253143310546875;
        float _451 = (_428.x - _428.y) * 0.4290426075458526611328125;
        float3 _457 = float3(0.0);
        _457.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _449) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _450)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _451);
        float3 _463 = _457;
        _463.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _449) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _450)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _451);
        float3 _469 = _463;
        _469.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _449) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _450)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _451);
        _471 = fast::max(float3(0.0), _469);
    }
    else
    {
        _471 = float3(0.0);
    }
    float3 _474 = _471 * View.View_IndirectLightingColorScale;
    float3 _496 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _522;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _521;
        if (any(abs(_201 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _521 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_201, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _521 = _496;
        }
        _522 = _521;
    }
    else
    {
        _522 = _496;
    }
    float4 _529 = float4(((mix(float3(0.0), _381 + (_383 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_474 * _381) * fast::max(float3(1.0), ((((((_287 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_287 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_287 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _522) * 1.0, 0.0);
    float4 _536;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _535 = _529;
        _535.w = 0.0;
        _536 = _535;
    }
    else
    {
        _536 = _529;
    }
    float2 _541 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _549 = (_238 * 0.5) + float3(0.5);
    float4 _551 = float4(_549.x, _549.y, _549.z, float4(0.0).w);
    _551.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _552 = float4(0.0);
    _552.x = _288;
    float4 _553 = _552;
    _553.y = 0.5;
    float4 _554 = _553;
    _554.z = (fast::clamp(mix(mix(float3(0.100000001490116119384765625), float3(mix(0.37999999523162841796875, 0.550000011920928955078125, _260.x)), _264), float3(mix(0.550000011920928955078125, 0.75, _269.x)), _273).x, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float4 _555 = _554;
    _555.w = 0.50588238239288330078125;
    float4 _567 = float4(_287.x, _287.y, _287.z, float4(0.0).w);
    _567.w = ((log2(((dot(_474, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_385 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_385 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_385 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_541.xyx * _541.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _536 * View.View_PreExposure;
    out.out_var_SV_Target1 = _551;
    out.out_var_SV_Target2 = _555;
    out.out_var_SV_Target3 = _567;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_354, 1.0, 1.0, 1.0);
    return out;
}

