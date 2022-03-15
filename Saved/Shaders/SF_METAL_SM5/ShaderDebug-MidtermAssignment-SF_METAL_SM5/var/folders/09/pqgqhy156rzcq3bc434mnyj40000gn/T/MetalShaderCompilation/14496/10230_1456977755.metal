

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
    char _m10_pad[612];
    float View_RenderingReflectionCaptureMask;
    char _m11_pad[376];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m12_pad[48];
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

fragment MainPS_out Main_000027f6_56d7b75b(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> Material_Texture2D_0 [[texture(2)]], texture2d<float> Material_Texture2D_1 [[texture(3)]], texture2d<float> Material_Texture2D_2 [[texture(4)]], texture2d<float> Material_Texture2D_3 [[texture(5)]], sampler View_MaterialTextureBilinearWrapedSampler [[sampler(0)]], sampler View_SharedBilinearClampedSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    float4 _162 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _167 = (_162.xyz / float3(_162.w)) - View.View_PreViewTranslation;
    float4 _173 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _176 = (_173.xy * float2(2.0)) - float2(1.0);
    float _180 = sqrt(fast::clamp(1.0 - dot(_176, _176), 0.0, 1.0));
    float3 _188 = float3(float4(_176, _180, 1.0).xy * (-1.0), _180);
    float3 _192 = (float3(0.0, 0.0, 2.0) * dot(float3(0.0, 0.0, 2.0), _188)) - (_188 * 2.0);
    float4 _208 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _226 = Material_Texture2D_2.sample(View_MaterialTextureBilinearWrapedSampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 50.0));
    float3 _230 = float3(_208.x);
    float4 _235 = Material_Texture2D_3.sample(View_MaterialTextureBilinearWrapedSampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 8.0));
    float3 _239 = float3(_208.z);
    float3 _242 = float3(_208.w);
    float3 _257 = fast::clamp(mix(mix(mix(mix(Material.Material_VectorExpressions[3].xyz, Material.Material_VectorExpressions[3].xyz, float3(_208.y)), _226.xyz * float3(0.2249999940395355224609375), _230), _235.xyz * float3(0.25), _239), float3(0.0), _242), float3(0.0), float3(1.0));
    float _258 = fast::clamp(mix(mix(float3(0.0), float3(1.0), _239), float3(0.0), _242).x, 0.0, 1.0);
    float _312;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _280 = fast::clamp((_167 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _291 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_280.x), int(_280.y), int(_280.z), 0).xyz), 0));
        _312 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_291.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_280 / float3(_291.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _312 = 1.0;
    }
    float3 _324 = ((_257 - (_257 * _258)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _331 = (mix(float3(0.039999999105930328369140625), _257, float3(_258)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _334 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _339;
    if (_334)
    {
        _339 = _324 + (_331 * 0.449999988079071044921875);
    }
    else
    {
        _339 = _324;
    }
    float3 _348 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _374;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _373;
        if (any(abs(_167 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _373 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_167, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _373 = _348;
        }
        _374 = _373;
    }
    else
    {
        _374 = _348;
    }
    float4 _380 = float4((mix(float3(0.0), _339 + (select(_331, float3(0.0), bool3(_334)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + _374) * 1.0, 0.0);
    float4 _387;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _386 = _380;
        _386.w = 0.0;
        _387 = _386;
    }
    else
    {
        _387 = _380;
    }
    float2 _392 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _400 = ((normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize(((_192 / float3(sqrt(dot(_192, _192)))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0) * 0.5) + float3(0.5);
    float4 _402 = float4(_400.x, _400.y, _400.z, float4(0.0).w);
    _402.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _403 = float4(0.0);
    _403.x = _258;
    float4 _404 = _403;
    _404.y = 0.5;
    float4 _405 = _404;
    _405.z = (fast::clamp(mix(mix(mix(float3(0.100000001490116119384765625), float3(mix(0.550000011920928955078125, 0.75, _226.x)), _230), float3(mix(0.37999999523162841796875, 0.550000011920928955078125, _235.x)), _239), float3(0.100000001490116119384765625), _242).x, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float4 _406 = _405;
    _406.w = 0.50588238239288330078125;
    float4 _409 = float4(_257.x, _257.y, _257.z, float4(0.0).w);
    _409.w = (fract(dot(_392.xyx * _392.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _387 * View.View_PreExposure;
    out.out_var_SV_Target1 = _402;
    out.out_var_SV_Target2 = _406;
    out.out_var_SV_Target3 = _409;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_312, 1.0, 1.0, 1.0);
    return out;
}

